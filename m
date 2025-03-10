Return-Path: <linux-kernel+bounces-554245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4064CA59527
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09F73A609E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B89227BAD;
	Mon, 10 Mar 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NCRg82Nw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16999226D1B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611151; cv=none; b=sqoQZwq7bfrM8EJbZn8Z2zoUvKsD49ql+1WECKmOQpAA0Uo89zL0V9A6Gm4sVb0NTgiPdkaieCoaMnP5KphdZ9sesUy8hS3rBqLCXBAbZZBU+qYPVOlTIbfZOnHWEnu6PdBblZVntY26KQFjih6gCHGiyK5FTM6tek01s0YXBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611151; c=relaxed/simple;
	bh=JT/XWy+b3jrVuXxpL+GJv0724MFYVVigUv9F2JafjPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsmpyqbiBCjr++SpoWFK5ZZfZgdSiJXz5bGcdDzaSb/6GdxSJDGfSkOABtX/YHiZiRT2B2TZ7VWUv0xvmap4zK+Lo20DCwwg5bUn6BxN45dj2vHQdLl3aMARQbsgpQDWiyh1HZ+TRjA5V3IjK1rpwrA6LcwS6PBXSSParg5Q9Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NCRg82Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF95C4CEE5;
	Mon, 10 Mar 2025 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741611150;
	bh=JT/XWy+b3jrVuXxpL+GJv0724MFYVVigUv9F2JafjPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCRg82Nwlb1ILfnvZ25f2anJ13DAx+zo2aSb21hukjQUbc/FeN/HLTMiJMRP1QtE0
	 n6b/svrzzso4B2eZy14OxFAyjuH+DgQ2IfWh/8iY8wo0BZl4BjQLCZANHcf1dAlkIg
	 4qStK/wvNxibZyXiBpa6eIChoP3kVaMsAarxD3DI=
Date: Mon, 10 Mar 2025 13:52:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH] driver/base/node.c: Fix softlockups during the
 initialization of large systems with interleaved memory blocks
Message-ID: <2025031051-gab-viability-e288@gregkh>
References: <20250310115305.13599-1-donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310115305.13599-1-donettom@linux.ibm.com>

On Mon, Mar 10, 2025 at 06:53:05AM -0500, Donet Tom wrote:
> On large systems with more than 64TB of DRAM, if the memory blocks
> are interleaved, node initialization (node_dev_init()) could take
> a long time since it iterates over each memory block. If the memory
> block belongs to the current iterating node, the first pfn_to_nid
> will provide the correct value. Otherwise, it will iterate over all
> PFNs and check the nid. On non-preemptive kernels, this can result
> in a watchdog softlockup warning. Even though CONFIG_PREEMPT_LAZY
> is enabled in kernels now [1], we may still need to fix older
> stable kernels to avoid encountering these kernel warnings during
> boot.
> 
> This patch adds a cond_resched() call in node_dev_init() to avoid
> this warning.
> 
> node_dev_init()
>     register_one_node
>         register_memory_blocks_under_node
>             walk_memory_blocks()
>                 register_mem_block_under_node_early
>                     get_nid_for_pfn
>                         early_pfn_to_nid
> 
> In my system node4 has a memory block ranging from memory30351
> to memory38524, and memory128433. The memory blocks between
> memory38524 and memory128433 do not belong to this node.
> 
> In  walk_memory_blocks() we iterate over all memblocks starting
> from memory38524 to memory128433.
> In register_mem_block_under_node_early(), up to memory38524, the
> first pfn correctly returns the corresponding nid and the function
> returns from there. But after memory38524 and until memory128433,
> the loop iterates through each pfn and checks the nid. Since the nid
> does not match the required nid, the loop continues. This causes
> the soft lockups.
> 
> [1]: https://lore.kernel.org/linuxppc-dev/20241116192306.88217-1-sshegde@linux.ibm.com/
> Fixes: 2848a28b0a60 ("drivers/base/node: consolidate node device subsystem initialization in node_dev_init()")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  drivers/base/node.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ea653fa3433..107eb508e28e 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -975,5 +975,6 @@ void __init node_dev_init(void)
>  		ret = register_one_node(i);
>  		if (ret)
>  			panic("%s() failed to add node: %d\n", __func__, ret);
> +		cond_resched();

That's a horrible hack, sorry, but no, we can't sprinkle this around in
random locations, especially as this is actually fixed by using a
different scheduler model as you say.

Why not just make the code faster so as to avoid the long time this
takes?

thanks,

greg k-h

