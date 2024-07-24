Return-Path: <linux-kernel+bounces-261157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C23C93B35D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8F91C22AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E2C15B0EE;
	Wed, 24 Jul 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJa5KS6z"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0CA158DA3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721833806; cv=none; b=SV1mplGgBsNNlX4EgM4rBpa3kVURLyUlBiY/lFKDxRjGDXaQBFK6AvaXIvqPHQUJGjcEUumh4+MtIS2wj8krik2IEkv2deeqksUSyCE1jElAqgrpSt1Pk3wsFCedO24QIDWq/ogrwAGpmQLenpYMw+xuV2rfvp8vhR1fEBTH5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721833806; c=relaxed/simple;
	bh=QY6KBs5sCXbAurZdEDfy2yTv3p4j/EuLQieJ8axoEEw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QE4Mfj0W7ib+1Q6Y2a2VSRELPCi7byKvVz4zgzK05llupANDGVrQlLmHApyMVGmCj3/55y7fT75Nb9RCXC9vniLQP26aHU33Jv3cwekcB3PfMyVXogtA1iOtW6I6vXXphaX2qHOYLgi6t4p99HpG3+9DmZo/J0fuHYdg90EKht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJa5KS6z; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f0277daa5so5911575e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721833803; x=1722438603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrn+2L2J3l+O5LKB4lMvA6eRmgJO2t1OuP7DCfHiNX0=;
        b=TJa5KS6zBHEc1RXTIuRJ5HLRmodpmYcIu6FLbcikZaRZ0GOC0j/x+lsY3Qsu66wpy2
         9d7HfAv5aDuQkxBFvevof5D0QlbvM5LeZVSKVrMMfOwW9JGUItWI0HD0SfMAmTtcOPOs
         mtovHYduIx/tzkqm2i6PizfhAJQ/5qNZ9ZtHuj6it8HiSYaMSzwLKQkzMy66UP2nBdEm
         +Rn+ZWW/SEDC4PwkV70hfE6jP9I1sy3yRDCSl1h2t+fwR1GOPaA/EdXTmgRrL1G+TvVW
         5HnR1t67ZzGpr2MPUwLsH7LrtFuAcaiqubfn3sRqLFdem9mLRy0cBH6/9FZd7cdmWmRK
         LBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721833803; x=1722438603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrn+2L2J3l+O5LKB4lMvA6eRmgJO2t1OuP7DCfHiNX0=;
        b=j7ZJKU7FiUDHmvxwl6OA2lRmjZvLrEq0wKHg+/ro9kKeocwzm5+n+v9wMdJh5Mbqiz
         9IjnyQ42UyH+Wi9VvSDdbFHZQJy55ik+nAPJtVEq1/INyflCwsaKHlTGMA04kyooN8xd
         4fzqfG0datb8OfC/Qvwzu6XA/w3vDMsZeoXByhQShc7mDgtoeYbslICpcH+ExHa045KM
         x44DO1VVKQLN6+YXZMVNG+iRuADccbv90y0l7+LqRWL/QCat1HQAav+5mc8hkLuWJpbB
         4YWLq+4NccNCx4CcREWdej494vfq574ZBsXntxZzV67lL2Ruy3KShnX44wEOE4RViRg4
         ir3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFiDYtMj9wrVEr47aTpD+hEu7Mg5AupLP3zMbAmwQZTH09iGvWyG3RtkXhLJ2mVOwvuc585JZg0/exq7awBH6b5HtFiNFyVg3xarzb
X-Gm-Message-State: AOJu0YyOzfTB66E436lazsNZROv0cWGfchhcaaT3bNKRw2jAN0ATjGvm
	X82ZREx10wDtFwW5jm1aij2OHtzvtAQrjYqkSGj5DUSoPJhea0yM
X-Google-Smtp-Source: AGHT+IHDPBxN5xxAPAbJb/lsNABWyt8VCCzYmydonGh2j7ufP5sX07N9OjQ8QuGnBhkMCvodEU94WQ==
X-Received: by 2002:a05:6512:ea1:b0:52c:d9b3:2b06 with SMTP id 2adb3069b0e04-52efb859ef2mr9666902e87.58.1721833802485;
        Wed, 24 Jul 2024 08:10:02 -0700 (PDT)
Received: from pc636 (host-90-233-213-186.mobileonline.telia.com. [90.233.213.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd10f7ea1sm177759e87.22.2024.07.24.08.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:10:02 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 24 Jul 2024 17:09:59 +0200
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Adrian Huang <adrianhuang0701@gmail.com>, ahuang12@lenovo.com,
	akpm@linux-foundation.org, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	peterz@infradead.org, sunjw10@lenovo.com
Subject: Re: [PATCH 1/1] mm/vmalloc: Add preempt point in purge_vmap_node()
 when enabling kasan
Message-ID: <ZqEZRyOVEAaqyCuU@pc636>
References: <Zp-K_A60DjlDhlRt@pc636>
 <20240724124624.27673-1-ahuang12@lenovo.com>
 <ZqEQhUWTUWWFA4ek@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqEQhUWTUWWFA4ek@pc636>

On Wed, Jul 24, 2024 at 04:32:37PM +0200, Uladzislau Rezki wrote:
> On Wed, Jul 24, 2024 at 08:46:24PM +0800, Adrian Huang wrote:
> > > It works great and does not generate the soft-lock-up splat :)
> > > See below some comments:
> > 
> > Great. Thanks for the confirmation.
> > 
> > <snip>
> > 
> > >> +     kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
> > >> +
> > >>
> > > Do we need it here? We just did the TLB flush for en entire range in the
> > > __purge_vmap_area_lazy(). So, it is two times invoked and looks odd to me.
> > >
> > > Am i missing something?
> > 
> > 1. The TLB flush for the entire range in __purge_vmap_area_lazy() is for
> > the vmalloc virtual address (VMALLOC_START->VMALLOC_END).
> > 
> > 2. The TLB flush in purge_vmap_node() is for the KASAN shadow virtual address 
> > (the shadow offset 'CONFIG_KASAN_SHADOW_OFFSET' is defined in .config).
> > 
> Correct. It deals with a shadow region!
> 
> >
> > BTW, I found my first patch has the potential risk. We need to flush TLB of
> > the KASAN shadow virtual address firstly. Please see the following patch for
> > detail. (I put the comment in the following patch). The following patch
> > also works well on my 256-core machine.
> > 
> I noticed that and it would be my second question :)
> 
> >
> > If you're ok with the patch, I'll submit it for upstream review. And, may I
> > have your tag(s): tested-by/reviewed-by? (If possible, could you please have
> > a test for the following patch).
> > 
> I am OK. I will test and get back soon.
> 
> > Thanks.
> > 
> > ---
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 70d6a8f6e25d..ddbf42a1a7b7 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -55,6 +55,9 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
> >  int kasan_populate_early_shadow(const void *shadow_start,
> >  				const void *shadow_end);
> >  
> > +#define KASAN_VMALLOC_PAGE_RANGE 0x1 /* Apply exsiting page range */
> > +#define KASAN_VMALLOC_TLB_FLUSH  0x2 /* TLB flush */
> > +
> >  #ifndef kasan_mem_to_shadow
> >  static inline void *kasan_mem_to_shadow(const void *addr)
> >  {
> > @@ -511,7 +514,8 @@ void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
> >  int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> >  void kasan_release_vmalloc(unsigned long start, unsigned long end,
> >  			   unsigned long free_region_start,
> > -			   unsigned long free_region_end);
> > +			   unsigned long free_region_end,
> > +			   unsigned long flags);
> >  
> >  #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> >  
> > @@ -526,7 +530,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
> >  static inline void kasan_release_vmalloc(unsigned long start,
> >  					 unsigned long end,
> >  					 unsigned long free_region_start,
> > -					 unsigned long free_region_end) { }
> > +					 unsigned long free_region_end,
> > +					 unsigned long flags) { }
> >  
> >  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> >  
> > @@ -561,7 +566,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
> >  static inline void kasan_release_vmalloc(unsigned long start,
> >  					 unsigned long end,
> >  					 unsigned long free_region_start,
> > -					 unsigned long free_region_end) { }
> > +					 unsigned long free_region_end,
> > +					 unsigned long flags) { }
> >  
> >  static inline void *kasan_unpoison_vmalloc(const void *start,
> >  					   unsigned long size,
> > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > index d6210ca48dda..88d1c9dcb507 100644
> > --- a/mm/kasan/shadow.c
> > +++ b/mm/kasan/shadow.c
> > @@ -489,7 +489,8 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
> >   */
> >  void kasan_release_vmalloc(unsigned long start, unsigned long end,
> >  			   unsigned long free_region_start,
> > -			   unsigned long free_region_end)
> > +			   unsigned long free_region_end,
> > +			   unsigned long flags)
> >  {
> >  	void *shadow_start, *shadow_end;
> >  	unsigned long region_start, region_end;
> > @@ -522,12 +523,17 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
> >  			__memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
> >  			return;
> >  		}
> > -		apply_to_existing_page_range(&init_mm,
> > +
> > +
> > +		if (flags & KASAN_VMALLOC_PAGE_RANGE)
> > +			apply_to_existing_page_range(&init_mm,
> >  					     (unsigned long)shadow_start,
> >  					     size, kasan_depopulate_vmalloc_pte,
> >  					     NULL);
> > -		flush_tlb_kernel_range((unsigned long)shadow_start,
> > -				       (unsigned long)shadow_end);
> > +
> > +		if (flags & KASAN_VMALLOC_TLB_FLUSH)
> > +			flush_tlb_kernel_range((unsigned long)shadow_start,
> > +					       (unsigned long)shadow_end);
> >  	}
> >  }
> >  
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index e34ea860153f..12cdc92cdb83 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2193,8 +2193,22 @@ static void purge_vmap_node(struct work_struct *work)
> >  	struct vmap_area *va, *n_va;
> >  	LIST_HEAD(local_list);
remove the space.
> >  
> > +	unsigned long start;
> > +	unsigned long end;
> > +
> >  	vn->nr_purged = 0;
> >  
> > +	start = list_first_entry(&vn->purge_list, struct vmap_area, list)->va_start;
no need to have an extra space.
> > +
> > +	end = list_last_entry(&vn->purge_list, struct vmap_area, list)->va_end;
> > +
> > +	/*
> > +	 * Since node_pool_add_va() returns vmap_area(s) to its pool, the
> > +	 * returned vmap_area(s) might be grabbed immediately via node_alloc()
> > +	 * by other core. We need to flush TLB firstly.
> > +	 */
> > +	kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
> > +
> >  	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
> >  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
> >  		unsigned long orig_start = va->va_start;
> > @@ -2205,7 +2219,8 @@ static void purge_vmap_node(struct work_struct *work)
> >  
> >  		if (is_vmalloc_or_module_addr((void *)orig_start))
> >  			kasan_release_vmalloc(orig_start, orig_end,
> > -					      va->va_start, va->va_end);
> > +					      va->va_start, va->va_end,
> > +					      KASAN_VMALLOC_PAGE_RANGE);
>
orig_start and orig_end are unnecessary now. But it can be removed by
an extra patch!

> >  
> >  		atomic_long_sub(nr, &vmap_lazy_nr);
> >  		vn->nr_purged++;
> > @@ -4726,7 +4741,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> >  				&free_vmap_area_list);
> >  		if (va)
> >  			kasan_release_vmalloc(orig_start, orig_end,
> > -				va->va_start, va->va_end);
> > +				va->va_start, va->va_end,
> > +				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
> >  		vas[area] = NULL;
> >  	}
> >  
> > @@ -4776,7 +4792,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> >  				&free_vmap_area_list);
> >  		if (va)
> >  			kasan_release_vmalloc(orig_start, orig_end,
> > -				va->va_start, va->va_end);
> > +				va->va_start, va->va_end,
> > +				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
> >  		vas[area] = NULL;
> >  		kfree(vms[area]);
> >  	}
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you.

--
Uladzislau Rezki

