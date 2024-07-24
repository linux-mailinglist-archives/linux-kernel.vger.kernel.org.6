Return-Path: <linux-kernel+bounces-261090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ED193B2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2FC1F248C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D6158D8F;
	Wed, 24 Jul 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh8BkHPc"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22CA1586DB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831564; cv=none; b=Dq9XrUFrISZ+sumBNDA7JZ5ir9QkoukwNnGpELox/46qTU2HvP1VpN04hB16jvFicodEXiwRH6k0madY2QcvkWkhHb0tPA0A5rwbR2L6hMgf9XEp8ExTTj09C6uuHFC2J8TLcIhLOHT7rycCOLxGMg3lNB4Y8VG2DumROGFKoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831564; c=relaxed/simple;
	bh=DEsMu+jbt8I0dDZcs56bXsti6Cvpj1w57zl3whVaE9I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW4eKBB8wwXpXnHtxzuReZSQRPmjluOfkjhytfnq/ilBnDuSvD/h60gYJyOh8IXstggG0mYxcHZrHaMokaw3rxfIMzsiArmRAcQ4p/T6oWZqBsHC4iAuRbq+dYw4i5NcyQmk2dlLBDCjPJ2AEcDHefOn2otjzBfTSMojwVAi+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh8BkHPc; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f035ae1083so7085641fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721831561; x=1722436361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRIG3jZWW6+gmzeQGbVpeigOtDWbcHntB8qUrQnqXaI=;
        b=Nh8BkHPciskZCSy7H/T/bUeG/HGNSfDud4SyBHLoiqA3xVlS2SefrndCV0TFzhnrDa
         kl81+FGsUckOIAKHCLtzb4+3fc0NxvuOP4PZZy1VJvG/R4Xhv7KjkEsBK8OsQ6eS0SDS
         vC/Diftu2yYBwMkkjctAW7G5SP9UgFCAgfMSI0Y1t/XACKONk23Ark1m05o/xJByso/8
         n7SfQzTneYBHpI89Alc5mEPxVr1n7iIqKLfUlG6vzdLdosSe70bZLBW3Bdt5iaSQDQEX
         34K9Z2vDwJs/dcbInCXkk2maOEXi88QDiR2DuyYWh/uUPsFR3HnvDP8s1HFBpQBk/XNH
         oZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721831561; x=1722436361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRIG3jZWW6+gmzeQGbVpeigOtDWbcHntB8qUrQnqXaI=;
        b=lFJ3ZlfQF5KZOu/cxNICUMtgJy12emo6B7JsQdqAyplAx3jn7ld3oBUAawnTXZIYrA
         hELHxR3juc5adYMsC3mk4+SDSWXcat6kdFaRHPWyNew6aJx0alkKL5KddQ1j5d7Akp3V
         ldq+N1SfsbY1FKtXB9nhybRpGloU44a+bQCgJxLp2zvx4HsPIKYd8hriKzF9cUPzCA5K
         K+G07eL2VvbGbgxU94ZEnLeUPSDskoUhKoya/GWqI3q9q3gcIYxWQIOyFxFWZXw06GtP
         oJCfnX9zhxhf4d0O0AB8d9imuegx+vi/UKC3R8xL3ZxqnTVED8hdNsiQuXeGIiSZGWaj
         rnfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW2YSaNanz5+WW4WS1iT3waoAFyfAdeoAqgNmfXzR3LDMJt8ccaOvRYb+CeE2yEVlR9PejayqK3QoSVesc6nBm20I8nhUrTu/yzAAm
X-Gm-Message-State: AOJu0YxpLBIgxsXp7xXI8wlZiC6/q19TWG57nik2XUQTMnXDT3pt8hoJ
	syy4MjNgi+vuHHrgDhCgi3ZYvAScFz099Yju4Lh0iLy9+v3DDNuD
X-Google-Smtp-Source: AGHT+IEuV00AurgRYl47n4+9PvAZ0CapDyov0r3kOU1pGUrQcmH2BxdM7vWeV5PSoLkG/kRvIp3Lgw==
X-Received: by 2002:a2e:919a:0:b0:2ef:2543:45a2 with SMTP id 38308e7fff4ca-2f039cdf5ffmr289461fa.25.1721831560502;
        Wed, 24 Jul 2024 07:32:40 -0700 (PDT)
Received: from pc636 (host-90-233-213-186.mobileonline.telia.com. [90.233.213.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef24fbe937sm15017101fa.6.2024.07.24.07.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 07:32:40 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 24 Jul 2024 16:32:37 +0200
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: urezki@gmail.com, ahuang12@lenovo.com, akpm@linux-foundation.org,
	hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	peterz@infradead.org, sunjw10@lenovo.com
Subject: Re: [PATCH 1/1] mm/vmalloc: Add preempt point in purge_vmap_node()
 when enabling kasan
Message-ID: <ZqEQhUWTUWWFA4ek@pc636>
References: <Zp-K_A60DjlDhlRt@pc636>
 <20240724124624.27673-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724124624.27673-1-ahuang12@lenovo.com>

On Wed, Jul 24, 2024 at 08:46:24PM +0800, Adrian Huang wrote:
> > It works great and does not generate the soft-lock-up splat :)
> > See below some comments:
> 
> Great. Thanks for the confirmation.
> 
> <snip>
> 
> >> +     kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
> >> +
> >>
> > Do we need it here? We just did the TLB flush for en entire range in the
> > __purge_vmap_area_lazy(). So, it is two times invoked and looks odd to me.
> >
> > Am i missing something?
> 
> 1. The TLB flush for the entire range in __purge_vmap_area_lazy() is for
> the vmalloc virtual address (VMALLOC_START->VMALLOC_END).
> 
> 2. The TLB flush in purge_vmap_node() is for the KASAN shadow virtual address 
> (the shadow offset 'CONFIG_KASAN_SHADOW_OFFSET' is defined in .config).
> 
Correct. It deals with a shadow region!

>
> BTW, I found my first patch has the potential risk. We need to flush TLB of
> the KASAN shadow virtual address firstly. Please see the following patch for
> detail. (I put the comment in the following patch). The following patch
> also works well on my 256-core machine.
> 
I noticed that and it would be my second question :)

>
> If you're ok with the patch, I'll submit it for upstream review. And, may I
> have your tag(s): tested-by/reviewed-by? (If possible, could you please have
> a test for the following patch).
> 
I am OK. I will test and get back soon.

> Thanks.
> 
> ---
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 70d6a8f6e25d..ddbf42a1a7b7 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -55,6 +55,9 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>  int kasan_populate_early_shadow(const void *shadow_start,
>  				const void *shadow_end);
>  
> +#define KASAN_VMALLOC_PAGE_RANGE 0x1 /* Apply exsiting page range */
> +#define KASAN_VMALLOC_TLB_FLUSH  0x2 /* TLB flush */
> +
>  #ifndef kasan_mem_to_shadow
>  static inline void *kasan_mem_to_shadow(const void *addr)
>  {
> @@ -511,7 +514,8 @@ void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
>  int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
>  void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			   unsigned long free_region_start,
> -			   unsigned long free_region_end);
> +			   unsigned long free_region_end,
> +			   unsigned long flags);
>  
>  #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>  
> @@ -526,7 +530,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
>  static inline void kasan_release_vmalloc(unsigned long start,
>  					 unsigned long end,
>  					 unsigned long free_region_start,
> -					 unsigned long free_region_end) { }
> +					 unsigned long free_region_end,
> +					 unsigned long flags) { }
>  
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>  
> @@ -561,7 +566,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
>  static inline void kasan_release_vmalloc(unsigned long start,
>  					 unsigned long end,
>  					 unsigned long free_region_start,
> -					 unsigned long free_region_end) { }
> +					 unsigned long free_region_end,
> +					 unsigned long flags) { }
>  
>  static inline void *kasan_unpoison_vmalloc(const void *start,
>  					   unsigned long size,
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index d6210ca48dda..88d1c9dcb507 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -489,7 +489,8 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>   */
>  void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			   unsigned long free_region_start,
> -			   unsigned long free_region_end)
> +			   unsigned long free_region_end,
> +			   unsigned long flags)
>  {
>  	void *shadow_start, *shadow_end;
>  	unsigned long region_start, region_end;
> @@ -522,12 +523,17 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			__memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
>  			return;
>  		}
> -		apply_to_existing_page_range(&init_mm,
> +
> +
> +		if (flags & KASAN_VMALLOC_PAGE_RANGE)
> +			apply_to_existing_page_range(&init_mm,
>  					     (unsigned long)shadow_start,
>  					     size, kasan_depopulate_vmalloc_pte,
>  					     NULL);
> -		flush_tlb_kernel_range((unsigned long)shadow_start,
> -				       (unsigned long)shadow_end);
> +
> +		if (flags & KASAN_VMALLOC_TLB_FLUSH)
> +			flush_tlb_kernel_range((unsigned long)shadow_start,
> +					       (unsigned long)shadow_end);
>  	}
>  }
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e34ea860153f..12cdc92cdb83 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2193,8 +2193,22 @@ static void purge_vmap_node(struct work_struct *work)
>  	struct vmap_area *va, *n_va;
>  	LIST_HEAD(local_list);
>  
> +	unsigned long start;
> +	unsigned long end;
> +
>  	vn->nr_purged = 0;
>  
> +	start = list_first_entry(&vn->purge_list, struct vmap_area, list)->va_start;
> +
> +	end = list_last_entry(&vn->purge_list, struct vmap_area, list)->va_end;
> +
> +	/*
> +	 * Since node_pool_add_va() returns vmap_area(s) to its pool, the
> +	 * returned vmap_area(s) might be grabbed immediately via node_alloc()
> +	 * by other core. We need to flush TLB firstly.
> +	 */
> +	kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
> +
>  	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
>  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
>  		unsigned long orig_start = va->va_start;
> @@ -2205,7 +2219,8 @@ static void purge_vmap_node(struct work_struct *work)
>  
>  		if (is_vmalloc_or_module_addr((void *)orig_start))
>  			kasan_release_vmalloc(orig_start, orig_end,
> -					      va->va_start, va->va_end);
> +					      va->va_start, va->va_end,
> +					      KASAN_VMALLOC_PAGE_RANGE);
>  
>  		atomic_long_sub(nr, &vmap_lazy_nr);
>  		vn->nr_purged++;
> @@ -4726,7 +4741,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  				&free_vmap_area_list);
>  		if (va)
>  			kasan_release_vmalloc(orig_start, orig_end,
> -				va->va_start, va->va_end);
> +				va->va_start, va->va_end,
> +				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
>  		vas[area] = NULL;
>  	}
>  
> @@ -4776,7 +4792,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  				&free_vmap_area_list);
>  		if (va)
>  			kasan_release_vmalloc(orig_start, orig_end,
> -				va->va_start, va->va_end);
> +				va->va_start, va->va_end,
> +				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
>  		vas[area] = NULL;
>  		kfree(vms[area]);
>  	}

