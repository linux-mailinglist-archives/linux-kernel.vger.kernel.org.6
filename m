Return-Path: <linux-kernel+bounces-414199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055419D24A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F291F230D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B961D1C4A0C;
	Tue, 19 Nov 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7aTxOUT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C9014AD1A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014863; cv=none; b=nDzasgqh81WYKRbZwFXMWXPQ9d+MPzkBAkSJ/H9wuhQ4dUc/SzD/DRLHsLLUZJNORIjp/CRCo7XdvawXsxvXXVbPBGapPiAowVNZZaDt/Hm7xuYCJA9GXPYpaZ10R2WHe3e2K7Bfa8OegtWKlycr+g8XT4EuKREg5x3B8iKTdso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014863; c=relaxed/simple;
	bh=9MNw4PDaI+BxTepANziN7narYyulyqe7VV7uYHk8/sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX/2WTj0O+8LEwvgM+K0ou+I0pdSVMxitx2yra2768Q3mU40NagAKPS0NkNeGDjOdFFLKJuxXxqZE9JPTTi+P/MMSVP8d6xNALJuq3jiiihfRXDSvZVEPE8Dzl63347G7GShrJHDGdfeK7jkkjfzoiHHy8asieg0XcOPw6c7bW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7aTxOUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3C6C4CECF;
	Tue, 19 Nov 2024 11:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732014862;
	bh=9MNw4PDaI+BxTepANziN7narYyulyqe7VV7uYHk8/sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7aTxOUTBJPMO/TRKOFTG31+/sWlQxLbWmo5jz4sgaZ+hJX9bRhUvVYpQwa/knL5v
	 vrVQ/4hpnsUQNokpWjrupw8j4Wd+DP4s4oG0MpxF0VYY86f8nIweZL1bIL0ryHhOPv
	 y2SiGwfMaO/5+AtD7Fv0e2snw5jAZB+ScWwUKWn6pDK4k9SZuzrntuWChCXKvUbAfk
	 RyC6NGIuU3DPuHYDGyH829bu4lyyOCR1sVYXpMi7nQ9He8E7KYu1u9XuPRRaRDX+E9
	 RYMvDvVrtsrmZp799L+1o7nuoUvzy9jqjHr+T8WHS9qGgPVsPriliIegiSCda7p46c
	 /NKezZqBBCLCg==
Date: Tue, 19 Nov 2024 12:14:18 +0100
From: Ingo Molnar <mingo@kernel.org>
To: gldrk <me@rarity.fan>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Check return value from
 memblock_phys_alloc_range()
Message-ID: <ZzxzCk9LIPkFqcqK@gmail.com>
References: <94b3e98f-96a7-3560-1f76-349eb95ccf7f@rarity.fan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94b3e98f-96a7-3560-1f76-349eb95ccf7f@rarity.fan>


* gldrk <me@rarity.fan> wrote:

> At least with CONFIG_PHYSICAL_START=0x100000, if there is < 4 MiB of contiguous
> free memory available at this point, the kernel will crash and burn because
> memblock_phys_alloc_range returns 0 on failure, which leads memblock_phys_free
> to throw the first 4 MiB of physical memory to the wolves.  At a minimum it
> should fail gracefully with a meaningful diagnostic, but in fact everything
> seems to work fine without the weird reserve allocation.
> 
> ---
>  arch/x86/mm/init.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index eb503f5..3696770 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -640,8 +640,13 @@ static void __init memory_map_top_down(unsigned long
> map_start,
>  	 */
>  	addr = memblock_phys_alloc_range(PMD_SIZE, PMD_SIZE, map_start,
>  					 map_end);
> -	memblock_phys_free(addr, PMD_SIZE);
> -	real_end = addr + PMD_SIZE;
> +	if (unlikely(addr < map_start)) {
> +		pr_warn("Failed to release memory for alloc_low_pages()");
> +		real_end = ALIGN_DOWN(map_end, PMD_SIZE);
> +	} else {
> +		memblock_phys_free(addr, PMD_SIZE);
> +		real_end = addr + PMD_SIZE;
> +	}

Makes sense to fix this bug I suppose, but the usual error check 
pattern for memblock_phys_alloc_range() failure would not be 'addr < 
map_start' but !addr.

( If memblock_phys_alloc_range() succeeds but returns an address below 
  'map_start', that would be a different failure I guess. )

Also, no need to add the 'unlikely()' I suspect - this is early boot 
code, micro-performance of branching is immaterial.

Just curious: what type of system has < 4 MiB of contiguous free memory 
available in early boot? Or was it something intentionally constrained 
via qemu?

Thanks,

	Ingo

