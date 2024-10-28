Return-Path: <linux-kernel+bounces-384887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883029B2FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EA71F22CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC01D9A59;
	Mon, 28 Oct 2024 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KztElKoT"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B251D6DDA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117258; cv=none; b=TSZlMTjU6hPPGljaWdNUhgeUhd55xIMHR5DV8CWUyDM+RdcNdr7wSqFMe581kbc2mnvvoHGjcW6kgooVdcCpwPdodw/45rDs+T8oLA0ve1AV0aN6aDvOdFKX3fwyvhPIrtY94qOIy0wY6jbmSrfAdRBtVJb03tp8K7JpKk8bj3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117258; c=relaxed/simple;
	bh=zqX+xcXJ40uXj03LfxA4Q5/N7DguvuSPxQR9DEjvzRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qwx9UCI6wVw1RasCioUDVP6uRrfBw4hJUj0yvW8z/qQnTO5i3bpNCQVX5Ap+ea0ax9C1u+PEpMAOfzFyI/G7F78tfGiklhaUyIWOV/jp9v7vQARnB/nWhwrrAPXu/FvtQVrgihiEP9TSL7X64MhM3PR/g+hV7NEoUuMqg2/8BgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KztElKoT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f2b95775so4821925e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730117253; x=1730722053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqVme9SSl1kiGR7ZZ2bymn3ufBDZ/0AEa0OkOgqzSis=;
        b=KztElKoTgdfDgToJw1vJW+MFmHgUxKynH38Z6jgRuRHE44yIR6unhDn+bogqgZqlI2
         CMK5LrKQeW+8ptm7GYCmsY8K9+HNUfZHOi/v9VFQ2FgxhdbilfYvkYJHrkzhCxmvPhqE
         qGDMVkVaKoWwJx46iU3tGwvwH/TsQ+1zNjy2g08L0YDyGa4nlGldTxaa11pDTuG2W1NC
         e/HngaREqS3HThRsDnQ2ABHETNmDc9R4agQLnPnqhVak7cxY1i19UciToPH/CfR4JcmJ
         Rg17UAV6Bl0fQVq6hpowRO4uMqwccrX0Bog54CvZdVvrhcXBtoiW0RleiUNkOWFXpa9g
         gkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730117253; x=1730722053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqVme9SSl1kiGR7ZZ2bymn3ufBDZ/0AEa0OkOgqzSis=;
        b=ilQ004eA58+0FEzVlsN3YUkV0ROjmuSONL2SMJaubg9C0NVv4ktubN1VIkGJQfOQA2
         Y+DwKwgFZqmTFt4fvkw1+rZapC/wozrUUe/nl0slY/GEiEfkqZXywBI/26uEShHrJuUI
         Siev9zmun75CvM2mqIuzWQ7fjfqSzaPd0BfkoQat28nFpxQaGZyIwLwj7hCJ8Nw3tlyp
         z/Pm9lYkCDPXyX9LOdTe++bD/+hozmrQTktS8FYNp8pf4bQpNcrsr+quoxe6aqnTLi0z
         /g053+rs1OqLC13Tj+3VH3fMoHZhJkiAIiqUDeCRuv7zaubjlcL/UA0QDRWxqs+CW/yI
         su4w==
X-Gm-Message-State: AOJu0Yyjr71yWutnkCUk9QtbBTACjGxkoif7BQS+M1X5GdeYVocnTz+N
	tsENjojLDBHI0/URYoR/eaEJFdsO1m91dIvCNLyFiG6z6b3b4/q+
X-Google-Smtp-Source: AGHT+IGl8Jl/qbsVoFO54+KqUiZXPR1Km9KlondPbyPeYyG4ao2kTuffWzqD+VDP9MZrHcbTum5y6Q==
X-Received: by 2002:a05:6512:3053:b0:539:a4ef:6765 with SMTP id 2adb3069b0e04-53b348ba142mr5197135e87.7.1730117252716;
        Mon, 28 Oct 2024 05:07:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:1494])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1e0b232dsm369353466b.26.2024.10.28.05.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 05:07:32 -0700 (PDT)
Message-ID: <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
Date: Mon, 28 Oct 2024 12:07:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>, "Huang, Ying" <ying.huang@intel.com>,
 Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
References: <20241027001444.3233-1-21cnbao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241027001444.3233-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/10/2024 01:14, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> In a memcg where mTHP is always utilized, even at full capacity, it
> might not be the best option. Consider a system that uses only small
> folios: after each reclamation, a process has at least SWAP_CLUSTER_MAX
> of buffer space before it can initiate the next reclamation. However,
> large folios can quickly fill this space, rapidly bringing the memcg
> back to full capacity, even though some portions of the large folios
> may not be immediately needed and used by the process.
> 
> Usama and Kanchana identified a regression when building the kernel in
> a memcg with memory.max set to a small value while enabling large
> folio swap-in support on zswap[1].
> 
> The issue arises from an edge case where the memory cgroup remains
> nearly full most of the time. Consequently, bringing in mTHP can
> quickly cause a memcg overflow, triggering a swap-out. The subsequent
> swap-in then recreates the overflow, resulting in a repetitive cycle.
> 
> We need a mechanism to stop the cup from overflowing continuously.
> One potential solution is to slow the filling process when we identify
> that the cup is nearly full.
> 
> Usama reported an improvement when we mitigate mTHP swap-in as the
> memcg approaches full capacity[2]:
> 
> int mem_cgroup_swapin_charge_folio(...)
> {
> 	...
> 	if (folio_test_large(folio) &&
> 	    mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio)))
> 		ret = -ENOMEM;
> 	else
> 		ret = charge_memcg(folio, memcg, gfp);
> 	...
> }
> 
> AMD 16K+32K THP=always
> metric         mm-unstable      mm-unstable + large folio zswapin series    mm-unstable + large folio zswapin + no swap thrashing fix
> real           1m23.038s        1m23.050s                                   1m22.704s
> user           53m57.210s       53m53.437s                                  53m52.577s
> sys            7m24.592s        7m48.843s                                   7m22.519s
> zswpin         612070           999244                                      815934
> zswpout        2226403          2347979                                     2054980
> pgfault        20667366         20481728                                    20478690
> pgmajfault     385887           269117                                      309702
> 
> AMD 16K+32K+64K THP=always
> metric         mm-unstable      mm-unstable + large folio zswapin series   mm-unstable + large folio zswapin + no swap thrashing fix
> real           1m22.975s        1m23.266s                                  1m22.549s
> user           53m51.302s       53m51.069s                                 53m46.471s
> sys            7m40.168s        7m57.104s                                  7m25.012s
> zswpin         676492           1258573                                    1225703
> zswpout        2449839          2714767                                    2899178
> pgfault        17540746         17296555                                   17234663
> pgmajfault     429629           307495                                     287859
> 
> I wonder if we can extend the mitigation to do_anonymous_page() as
> well. Without hardware like AMD and ARM with hardware TLB coalescing
> or CONT-PTE, I conducted a quick test on my Intel i9 workstation with
> 10 cores and 2 threads. I enabled one 12 GiB zRAM while running kernel
> builds in a memcg with memory.max set to 1 GiB.
> 
> $ echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
> $ echo always > /sys/kernel/mm/transparent_hugepage/hugepages-32kB/enabled
> $ echo always > /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enabled
> $ echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> 
> $ time systemd-run --scope -p MemoryMax=1G make ARCH=arm64 \
> CROSS_COMPILE=aarch64-linux-gnu- Image -10 1>/dev/null 2>/dev/null
> 
>             disable-mTHP-swapin  mm-unstable  with-this-patch
> Real:            6m54.595s      7m4.832s       6m45.811s
> User:            66m42.795s     66m59.984s     67m21.150s
> Sys:             12m7.092s      15m18.153s     12m52.644s
> pswpin:          4262327        11723248       5918690
> pswpout:         14883774       19574347       14026942
> 64k-swpout:      624447         889384         480039
> 32k-swpout:      115473         242288         73874
> 16k-swpout:      158203         294672         109142
> 64k-swpin:       0              495869         159061
> 32k-swpin:       0              219977         56158
> 16k-swpin:       0              223501         81445
> 

hmm, both the user and sys time are worse with the patch compared to
disable-mTHP-swapin. I wonder if the real time is an anomaly and if you
repeat the experiment the real time might be worse as well? 

> I need Usama's assistance to identify a suitable patch, as I lack
> access to hardware such as AMD machines and ARM servers with TLB
> optimization.
> 
> [1] https://lore.kernel.org/all/b1c17b5e-acd9-4bef-820e-699768f1426d@gmail.com/
> [2] https://lore.kernel.org/all/7a14c332-3001-4b9a-ada3-f4d6799be555@gmail.com/
> 
> Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/memcontrol.h |  9 ++++++++
>  mm/memcontrol.c            | 45 ++++++++++++++++++++++++++++++++++++++
>  mm/memory.c                | 17 ++++++++++++++
>  3 files changed, 71 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 524006313b0d..8bcc8f4af39f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -697,6 +697,9 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
>  int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
>  		long nr_pages);
>  
> +int mem_cgroup_precharge_large_folio(struct mm_struct *mm,
> +				swp_entry_t *entry);
> +
>  int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
>  				  gfp_t gfp, swp_entry_t entry);
>  
> @@ -1201,6 +1204,12 @@ static inline int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg,
>  	return 0;
>  }
>  
> +static inline int mem_cgroup_precharge_large_folio(struct mm_struct *mm,
> +		swp_entry_t *entry)
> +{
> +	return 0;
> +}
> +
>  static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
>  			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 17af08367c68..f3d92b93ea6d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4530,6 +4530,51 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
>  	return 0;
>  }
>  
> +static inline bool mem_cgroup_has_margin(struct mem_cgroup *memcg)
> +{
> +	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
> +		if (mem_cgroup_margin(memcg) < HPAGE_PMD_NR)

There might be 3 issues with the approach:

Its a very big margin, lets say you have ARM64_64K_PAGES, and you have
256K THP set to always. As HPAGE_PMD is 512M for 64K page, you are
basically saying you need 512M free memory to swapin just 256K?

Its an uneven margin for different folio sizes.
For 16K folio swapin, you are checking if there is margin for 128 folios,
but for 1M folio swapin, you are checking there is margin for just 2 folios.

Maybe it might be better to make this dependent on some factor of folio_nr_pages?

As Johannes pointed out, the charging code already does the margin check.
So for 4K, the check just checks if there is 4K available, but for 16K it checks
if a lot more than 16K is available. Maybe there should be a similar policy for
all? I guess this is similar to my 2nd point, but just considers 4K folios as
well.

Thanks,
Usama


> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +/**
> + * mem_cgroup_swapin_precharge_large_folio: Precharge large folios.
> + *
> + * @mm: mm context of the victim
> + * @entry: swap entry for which the folio will be allocated
> + *
> + * If we are arriving the edge of an almost full memcg, return error so that
> + * swap-in and anon faults can quickly fall back to small folios to avoid swap
> + * thrashing.
> + *
> + * Returns 0 on success, an error code on failure.
> + */
> +int mem_cgroup_precharge_large_folio(struct mm_struct *mm, swp_entry_t *entry)
> +{
> +	struct mem_cgroup *memcg = NULL;
> +	unsigned short id;
> +	bool has_margin;
> +
> +	if (mem_cgroup_disabled())
> +		return 0;
> +
> +	rcu_read_lock();
> +	if (entry) {
> +		id = lookup_swap_cgroup_id(*entry);
> +		memcg = mem_cgroup_from_id(id);
> +	}
> +	if (!memcg || !css_tryget_online(&memcg->css))
> +		memcg = get_mem_cgroup_from_mm(mm);
> +	has_margin = mem_cgroup_has_margin(memcg);
> +	rcu_read_unlock();
> +
> +	css_put(&memcg->css);
> +	return has_margin ? 0 : -ENOMEM;
> +}
> +
>  /**
>   * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for swapin.
>   * @folio: folio to charge.
> diff --git a/mm/memory.c b/mm/memory.c
> index 0f614523b9f4..96368ba0e8a6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4168,6 +4168,16 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  
>  	pte_unmap_unlock(pte, ptl);
>  
> +	if (!orders)
> +		goto fallback;
> +
> +	/*
> +	 * Avoid swapping in large folios when memcg is nearly full, as it
> +	 * may quickly trigger additional swap-out and swap-in cycles.
> +	 */
> +	if (mem_cgroup_precharge_large_folio(vma->vm_mm, &entry))
> +		goto fallback;
> +
>  	/* Try allocating the highest of the remaining orders. */
>  	gfp = vma_thp_gfp_mask(vma);
>  	while (orders) {
> @@ -4707,6 +4717,13 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  	if (!orders)
>  		goto fallback;
>  
> +	/*
> +	 * When memcg is nearly full, large folios can rapidly fill
> +	 * the margin and trigger new reclamation
> +	 */
> +	if (mem_cgroup_precharge_large_folio(vma->vm_mm, NULL))
> +		goto fallback;
> +
>  	/* Try allocating the highest of the remaining orders. */
>  	gfp = vma_thp_gfp_mask(vma);
>  	while (orders) {


