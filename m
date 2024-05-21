Return-Path: <linux-kernel+bounces-185204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9432B8CB1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02351C21FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CA51CD11;
	Tue, 21 May 2024 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFFpTFpK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727A182DB
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307916; cv=none; b=Ua3FPhNPT4P+e1Mc1s1Wo9yCX2QLtrd213VJYgaEiEYwT85yQ9VvqWEMZjTCT140kiFFqQZa2929I0R1xMrhqoENC/1RsdrLDxqrivnyFZ8im+jjjou8XFlDG1bGvc+JxoMvEPHJR1p03PGZtHuTD5JGGdhfDNB38YmuY+mbkKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307916; c=relaxed/simple;
	bh=PVda4OgjthlCL7ySbYlgXdAxVK5l0MruHqLonyOdoT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLbtsptiCM3Wr+a1TO2mCvL9YbP40H0iQlMKzdG5i9UcnXnSFFAJINszFGRLLWltpuEMheF0ncGNe0wW+RIXbDULbwZ7rn6AigiFEsdmdYmrfIUH2V9nEbCV6Ir2nuMJ+OH96IK4Na5iyWthw+Cetx3126O8ZOX/SmGpNClc3tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFFpTFpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FCAC2BD11;
	Tue, 21 May 2024 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716307916;
	bh=PVda4OgjthlCL7ySbYlgXdAxVK5l0MruHqLonyOdoT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFFpTFpKbes/L275L+fKRvqYwGC7FJVCHI2Dgjpaedk9stHFAJ52yzIQ7p7/s/kmn
	 cxcfQm9uI5ATr4MJ/8GT0v++mwx9wqKxFm4PWs4eU/czQsHJfujZmbzX8NKvFzsQpM
	 IvRiGqILJw4mafA3347JsBec0mSjyGgMXmMFnbrcO4KpgMrjmhV8/VdN0wHJ3qwFEa
	 8eqikN/rqxMZgCAYU5Lei7QES0ZB0nBHzHWHzvdif+QJk5FyZWICWHC0th73Q49Wn7
	 JKHeSFC1wfQeDJIDW5+Qoh5M0Tdp6L9qBBR2Kjhe4XouylIuOqdiOb7TeFWr2XZ9KJ
	 g//UCA5wx8+Aw==
Date: Tue, 21 May 2024 19:10:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Eric Chanudet <echanude@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Zhang Jianhua <chris.zjh@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Nick Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] arm64: init: override deferred_page_init_max_threads
Message-ID: <ZkzHX-4yYybEJdEQ@kernel.org>
References: <20240520231555.395979-5-echanude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520231555.395979-5-echanude@redhat.com>

(added powerpc folks)

On Mon, May 20, 2024 at 07:15:59PM -0400, Eric Chanudet wrote:
> This was the behavior prior to making the function arch-specific with
> commit ecd096506922 ("mm: make deferred init's max threads
> arch-specific")
> 
> Architectures can override the generic implementation that uses only one
> CPU. Setting DEFERRED_STRUCT_PAGE_INIT and testing on a few arm64
> platforms shows faster deferred_init_memmap completions:
> 
> |         | x13s        | SA8775p-ride | Ampere R137-P31 | Ampere HR330 |
> |         | Metal, 32GB | VM, 36GB     | VM, 58GB        | Metal, 128GB |
> |         | 8cpus       | 8cpus        | 8cpus           | 32cpus       |
> |---------|-------------|--------------|-----------------|--------------|
> | threads |  ms     (%) | ms       (%) |  ms         (%) |  ms      (%) |
> |---------|-------------|--------------|-----------------|--------------|
> | 1       | 108    (0%) | 72      (0%) | 224        (0%) | 324     (0%) |
> | cpus    |  24  (-77%) | 36    (-50%) |  40      (-82%) |  56   (-82%) |
> 
> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> ---
>  arch/arm64/mm/init.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9b5ab6818f7f..71f5188fe63d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -158,6 +158,13 @@ static void __init zone_sizes_init(void)
>  	free_area_init(max_zone_pfns);
>  }
>  
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask)
> +{
> +	return max_t(int, cpumask_weight(node_cpumask), 1);
> +}
> +#endif
> +

Maybe we should make this default and let architectures that want a single
thread override deferred_page_init_max_threads() to return 1?

>  int pfn_is_map_memory(unsigned long pfn)
>  {
>  	phys_addr_t addr = PFN_PHYS(pfn);
> -- 
> 2.44.0
> 

-- 
Sincerely yours,
Mike.

