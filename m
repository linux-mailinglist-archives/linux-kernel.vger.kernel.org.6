Return-Path: <linux-kernel+bounces-513544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E26CA34B72
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09693163FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ED8200120;
	Thu, 13 Feb 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyzYe8/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667361FF7DD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466549; cv=none; b=TSmymN7EcW+9o1Cbw5a8QDjfh0s+BTxFcGnIPv4BRRdAbthNCtHeHXO/AY4uOEUlBPdsDWCF5iJln/V8NSLwcwPYT/Sger1092M+cH04QKyvYgFiJ6uWwTNyivvLyrNNlWzaw/+VRQX4zbbcSrbDkeNw6Bqe1Bfq38kCUUQSn4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466549; c=relaxed/simple;
	bh=4x9jxxW0VD/X4SQSVaG2JypaS5X6rvTy8i5aJNkaqGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSz2A39w/5Q1O5RYge0/7ntjiF6HWClgJ9betuwm3ncEPXS/bs58wYCnG0f5nQjoPJavKvvTEbxtpZQ3BtA9hFIuk5KJifW0W+82P629zGjSPSHno8pwyHza8luhqD7gcJJmvOKktoPMOv/woRdlniv6uyBpGA8ROT9xNN+kkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyzYe8/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF828C4CED1;
	Thu, 13 Feb 2025 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739466548;
	bh=4x9jxxW0VD/X4SQSVaG2JypaS5X6rvTy8i5aJNkaqGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyzYe8/FSw0fl1CP4gUZZpa5MWXZthpkiUG+mI9U9lf93L2MaIccibO3nE4sWJ818
	 p+cEWlfzkMX/GuNQ9+3yultf7t7/GyBdPh5VdjwsUpkB2WbwJJQ2X0yqtkVvqQ0aDD
	 G3SYthnFz3F/udB8mazLb+24drxHpMXr9MUHi8XNYehaqHDWsf7coFGd7fqmgKdt4R
	 9Pdjd658XnbsDREowp3+HltvYyCjf7pcLt8R8plvGnNhGLaZi9yG2qGBp36JDTV5Bw
	 e3pbnWF2pohnY5SGCG7XN4xTxArGp3+e8+t8N0p9NyyIUBQ7MispuEjYLCc9Rrxb8+
	 oNjymN98zlMWw==
Date: Thu, 13 Feb 2025 22:29:45 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc64/ftrace: fix module loading without patchable
 function entries
Message-ID: <wlscshbqan2svtqkz5xc6v47tzndfnsvge7h4lbfn67zoplekl@elt2oxwhrp6f>
References: <20250204231821.39140-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204231821.39140-1-ailiop@suse.com>

On Wed, Feb 05, 2025 at 12:18:21AM +0100, Anthony Iliopoulos wrote:
> get_stubs_size assumes that there must always be at least one patchable
> function entry, which is not always the case (modules that export data
> but no code), otherwise it returns -ENOEXEC and thus the section header
> sh_size is set to that value. During module_memory_alloc() the size is
> passed to execmem_alloc() after being page-aligned and thus set to zero
> which will cause it to fail the allocation (and thus module loading) as
> __vmalloc_node_range() checks for zero-sized allocs and returns null:
> 
> [  115.466896] module_64: cast_common: doesn't contain __patchable_function_entries.
> [  115.469189] ------------[ cut here ]------------
> [  115.469496] WARNING: CPU: 0 PID: 274 at mm/vmalloc.c:3778 __vmalloc_node_range_noprof+0x8b4/0x8f0
> ...
> [  115.478574] ---[ end trace 0000000000000000 ]---
> [  115.479545] execmem: unable to allocate memory

Ugh, that's nasty.

> 
> Fix this by removing the check completely, since it is anyway not
> helpful to propagate this as an error upwards.
> 
> Fixes: eec37961a56a ("powerpc64/ftrace: Move ftrace sequence out of line")
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  arch/powerpc/kernel/module_64.c | 4 ----
>  1 file changed, 4 deletions(-)
> 

Thanks for fixing this. It might also be good to add a check in 
setup_ftrace_ool_stubs(). Something like this:

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 34a5aec4908f..c10a9c66cfe3 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -1125,6 +1125,10 @@ static int setup_ftrace_ool_stubs(const Elf64_Shdr *sechdrs, unsigned long addr,
        unsigned int i, total_stubs, num_stubs;
        struct ppc64_stub_entry *stub;
 
+       /* Bail out early if no traceable functions */
+       if (!me->arch.ool_stub_count)
+               return 0;
+
        total_stubs = sechdrs[me->arch.stubs_section].sh_size / sizeof(*stub);
        num_stubs = roundup(me->arch.ool_stub_count * sizeof(struct ftrace_ool_stub),
                            sizeof(struct ppc64_stub_entry)) / sizeof(struct ppc64_stub_entry);


Regardless of that, for this patch:
Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen


