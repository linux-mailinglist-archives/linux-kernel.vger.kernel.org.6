Return-Path: <linux-kernel+bounces-261453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C065093B78D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A109B219F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5897A16C68E;
	Wed, 24 Jul 2024 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8n9XGeq"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987416B750
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721849272; cv=none; b=iW4YfZZOv5vmkplq3evdx1f4Cc20bgwEJX/lIvO79FNxZkV86BIBcBU9ZV0OtscsZYZ8+YsR29inq7nfyLWjKY4bv3hxKCpmgSx8pVw/8fI3y12SW/KdEYeuru1iKQ0PBT1liYw0v30KmuE5xCz/StmDFqTXcQLNKVrRyA5i13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721849272; c=relaxed/simple;
	bh=cFx6MQgns4pUkedkz5cDozAFwZ0ld9YK9hnMlZxlcvc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNioofX4dUkwK8Os7bb48wQy7EqeVS1gLr1lHtoEhqIG60lQOcBcL8Bm1309T2ao1vfxvX1GNM4amUSML4Fm+Aj7bIk2CKw3bPrNirYkRX+AWf+fecmJxRSPaeKj73P4zoCMgi8CUu2Nms/9xF0iA+EXTqOmm5Uj8r9Z3p+FYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8n9XGeq; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efd530a4eso101757e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721849268; x=1722454068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NP3aBNE3gDLvzsGTSnShCZXLleNYO+n5X1vqCqA86g4=;
        b=W8n9XGeqmJBv97up06BEd82iMHCRVVgiWTgMnECU4wnDWSJcFotleNocfLchLII0N5
         7Eq5ABT8lGLTQBO862IEdMntmaIevUyfvbeK3X20k7/SJWaYybZO0wBpWvghSOd87mCS
         Z8PJf6BoMjeaedh3prDGiQQBFGKhy0+ajOApgHNnyZX06FYyEAOAavSGyaV1QlJY+3ay
         nbR5OQ8juKBO0Bo6NwDKxRan5NX533nI9r0zZndpHAkiKMk+49hslfVF4m1GBREpysnK
         SJ5h1Vtq0jjtusyYYdNDlF82DIDUj+45rdQN7UCWlJ08u3ETAwoMegBj7MTYlOPN6Guu
         N0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721849268; x=1722454068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP3aBNE3gDLvzsGTSnShCZXLleNYO+n5X1vqCqA86g4=;
        b=n7bI3xTrJSbdOvBSvonKQtuQdJBPvF/8AJfb6D2Z9+tHe5Sk3r90I3Q+NLNPM4kPDy
         PicQh98LO5Rd+aO5vrxH+pavZUmRuKUsXWCLafm4q30xh0MSKq3LZfKIgIB+HxDRoU5w
         eTE22LPx1mk4ZbAlv5j+ISAMI19VL/Ua0Md17arXp4+rRn/jl0kEv+l6Vpm/IaFVuyxL
         5fyTfgPg2Fx3QIbo+UffbGl8ag0r73q+KvIbNM10U5GIeGXz/Jx4jCm+lQhH1Tatuqqj
         dWkM12MUC6qYNBlYGovGxrtzVs+goR9IP+zjA+ZsjVB1+oD9byRdC/tdo1L4kt/hH4wK
         WFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk6yesi+Y97J1lNwo3D8DP+/zGBufeaFTBT1jMltdud1Li+0RV3E+Thzya6a5RGEjfaGUgIMaMcxiGYmrytdXEMOWxdwYGIxF8WmnP
X-Gm-Message-State: AOJu0YwNILNBp/WRAWsEm9RkAZoDenWINMmC+A+QSqepzjHEQjNdj6gN
	+TMMu5tJKMHX/h41hqDHdZn5z3O5pzm+/AQPD5mHdFCIu02+uXE/
X-Google-Smtp-Source: AGHT+IHyVMNOsbEV8z6LmCGvu8LApsDl6R2BcQmKs9Bk8rTpk1AbLSJ6c95ODc7G7jeh1oUBF/KIkQ==
X-Received: by 2002:a05:6512:239d:b0:52f:154:661b with SMTP id 2adb3069b0e04-52fd3eefd4cmr530155e87.11.1721849267911;
        Wed, 24 Jul 2024 12:27:47 -0700 (PDT)
Received: from pc636 (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef95c84e2sm1743525e87.10.2024.07.24.12.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 12:27:47 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 24 Jul 2024 21:27:46 +0200
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Adrian Huang <adrianhuang0701@gmail.com>, ahuang12@lenovo.com,
	akpm@linux-foundation.org, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	peterz@infradead.org, sunjw10@lenovo.com
Subject: Re: [PATCH 1/1] mm/vmalloc: Add preempt point in purge_vmap_node()
 when enabling kasan
Message-ID: <ZqFVslYh9UV0h6wR@pc636>
References: <Zp-K_A60DjlDhlRt@pc636>
 <20240724124624.27673-1-ahuang12@lenovo.com>
 <ZqEQhUWTUWWFA4ek@pc636>
 <ZqEZRyOVEAaqyCuU@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqEZRyOVEAaqyCuU@pc636>

On Wed, Jul 24, 2024 at 05:09:59PM +0200, Uladzislau Rezki wrote:
> On Wed, Jul 24, 2024 at 04:32:37PM +0200, Uladzislau Rezki wrote:
> > On Wed, Jul 24, 2024 at 08:46:24PM +0800, Adrian Huang wrote:
> > > > It works great and does not generate the soft-lock-up splat :)
> > > > See below some comments:
> > > 
> > > Great. Thanks for the confirmation.
> > > 
> > > <snip>
> > > 
> > > >> +     kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
> > > >> +
> > > >>
> > > > Do we need it here? We just did the TLB flush for en entire range in the
> > > > __purge_vmap_area_lazy(). So, it is two times invoked and looks odd to me.
> > > >
> > > > Am i missing something?
> > > 
> > > 1. The TLB flush for the entire range in __purge_vmap_area_lazy() is for
> > > the vmalloc virtual address (VMALLOC_START->VMALLOC_END).
> > > 
> > > 2. The TLB flush in purge_vmap_node() is for the KASAN shadow virtual address 
> > > (the shadow offset 'CONFIG_KASAN_SHADOW_OFFSET' is defined in .config).
> > > 
> > Correct. It deals with a shadow region!
> > 
> > >
> > > BTW, I found my first patch has the potential risk. We need to flush TLB of
> > > the KASAN shadow virtual address firstly. Please see the following patch for
> > > detail. (I put the comment in the following patch). The following patch
> > > also works well on my 256-core machine.
> > > 
> > I noticed that and it would be my second question :)
> > 
> > >
> > > If you're ok with the patch, I'll submit it for upstream review. And, may I
> > > have your tag(s): tested-by/reviewed-by? (If possible, could you please have
> > > a test for the following patch).
> > > 
> > I am OK. I will test and get back soon.
> > 
> > > Thanks.
> > > 
> > > ---
> > > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > > index 70d6a8f6e25d..ddbf42a1a7b7 100644
> > > --- a/include/linux/kasan.h
> > > +++ b/include/linux/kasan.h
> > > @@ -55,6 +55,9 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
> > >  int kasan_populate_early_shadow(const void *shadow_start,
> > >  				const void *shadow_end);
> > >  
> > > +#define KASAN_VMALLOC_PAGE_RANGE 0x1 /* Apply exsiting page range */
> > > +#define KASAN_VMALLOC_TLB_FLUSH  0x2 /* TLB flush */
> > > +
> > >  #ifndef kasan_mem_to_shadow
> > >  static inline void *kasan_mem_to_shadow(const void *addr)
> > >  {
> > > @@ -511,7 +514,8 @@ void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
> > >  int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> > >  void kasan_release_vmalloc(unsigned long start, unsigned long end,
> > >  			   unsigned long free_region_start,
> > > -			   unsigned long free_region_end);
> > > +			   unsigned long free_region_end,
> > > +			   unsigned long flags);
> > >  
> > >  #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> > >  
> > > @@ -526,7 +530,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
> > >  static inline void kasan_release_vmalloc(unsigned long start,
> > >  					 unsigned long end,
> > >  					 unsigned long free_region_start,
> > > -					 unsigned long free_region_end) { }
> > > +					 unsigned long free_region_end,
> > > +					 unsigned long flags) { }
> > >  
> > >  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> > >  
> > > @@ -561,7 +566,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
> > >  static inline void kasan_release_vmalloc(unsigned long start,
> > >  					 unsigned long end,
> > >  					 unsigned long free_region_start,
> > > -					 unsigned long free_region_end) { }
> > > +					 unsigned long free_region_end,
> > > +					 unsigned long flags) { }
> > >  
> > >  static inline void *kasan_unpoison_vmalloc(const void *start,
> > >  					   unsigned long size,
> > > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > > index d6210ca48dda..88d1c9dcb507 100644
> > > --- a/mm/kasan/shadow.c
> > > +++ b/mm/kasan/shadow.c
> > > @@ -489,7 +489,8 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
> > >   */
> > >  void kasan_release_vmalloc(unsigned long start, unsigned long end,
> > >  			   unsigned long free_region_start,
> > > -			   unsigned long free_region_end)
> > > +			   unsigned long free_region_end,
> > > +			   unsigned long flags)
> > >  {
> > >  	void *shadow_start, *shadow_end;
> > >  	unsigned long region_start, region_end;
> > > @@ -522,12 +523,17 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
> > >  			__memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
> > >  			return;
> > >  		}
> > > -		apply_to_existing_page_range(&init_mm,
> > > +
> > > +
> > > +		if (flags & KASAN_VMALLOC_PAGE_RANGE)
> > > +			apply_to_existing_page_range(&init_mm,
> > >  					     (unsigned long)shadow_start,
> > >  					     size, kasan_depopulate_vmalloc_pte,
> > >  					     NULL);
> > > -		flush_tlb_kernel_range((unsigned long)shadow_start,
> > > -				       (unsigned long)shadow_end);
> > > +
> > > +		if (flags & KASAN_VMALLOC_TLB_FLUSH)
> > > +			flush_tlb_kernel_range((unsigned long)shadow_start,
> > > +					       (unsigned long)shadow_end);
> > >  	}
> > >  }
> > >  
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index e34ea860153f..12cdc92cdb83 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2193,8 +2193,22 @@ static void purge_vmap_node(struct work_struct *work)
> > >  	struct vmap_area *va, *n_va;
> > >  	LIST_HEAD(local_list);
> remove the space.
> > >  
> > > +	unsigned long start;
> > > +	unsigned long end;
> > > +
> > >  	vn->nr_purged = 0;
> > >  
> > > +	start = list_first_entry(&vn->purge_list, struct vmap_area, list)->va_start;
> no need to have an extra space.
> > > +
> > > +	end = list_last_entry(&vn->purge_list, struct vmap_area, list)->va_end;
> > > +
> > > +	/*
> > > +	 * Since node_pool_add_va() returns vmap_area(s) to its pool, the
> > > +	 * returned vmap_area(s) might be grabbed immediately via node_alloc()
> > > +	 * by other core. We need to flush TLB firstly.
> > > +	 */
> > > +	kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
> > > +
> > >  	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
> > >  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
> > >  		unsigned long orig_start = va->va_start;
> > > @@ -2205,7 +2219,8 @@ static void purge_vmap_node(struct work_struct *work)
> > >  
> > >  		if (is_vmalloc_or_module_addr((void *)orig_start))
> > >  			kasan_release_vmalloc(orig_start, orig_end,
> > > -					      va->va_start, va->va_end);
> > > +					      va->va_start, va->va_end,
> > > +					      KASAN_VMALLOC_PAGE_RANGE);
> >
> orig_start and orig_end are unnecessary now. But it can be removed by
> an extra patch!
> 
> > >  
> > >  		atomic_long_sub(nr, &vmap_lazy_nr);
> > >  		vn->nr_purged++;
> > > @@ -4726,7 +4741,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> > >  				&free_vmap_area_list);
> > >  		if (va)
> > >  			kasan_release_vmalloc(orig_start, orig_end,
> > > -				va->va_start, va->va_end);
> > > +				va->va_start, va->va_end,
> > > +				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
> > >  		vas[area] = NULL;
> > >  	}
> > >  
> > > @@ -4776,7 +4792,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> > >  				&free_vmap_area_list);
> > >  		if (va)
> > >  			kasan_release_vmalloc(orig_start, orig_end,
> > > -				va->va_start, va->va_end);
> > > +				va->va_start, va->va_end,
> > > +				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
> > >  		vas[area] = NULL;
> > >  		kfree(vms[area]);
> > >  	}
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
I get: BUG: KASAN: vmalloc-out-of-bounds in long_busy_list_alloc_test+0x195/0x1c0 [test_vmalloc]

[15579.900340] ==================================================================
[15579.900412] BUG: KASAN: vmalloc-out-of-bounds in long_busy_list_alloc_test+0x195/0x1c0 [test_vmalloc]
[15579.900459] Write of size 1 at addr ffffc901c0578000 by task vmalloc_test/2/49374

[15579.900506] CPU: 199 PID: 49374 Comm: vmalloc_test/2 Kdump: loaded Not tainted 6.10.0-rc5-00019-g4236f0255ea8-dirty #3450
[15579.900554] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[15579.900595] Call Trace:
[15579.900611]  <TASK>
[15579.900635]  dump_stack_lvl+0x53/0x70
[15579.900670]  print_address_description.constprop.0+0x2c/0x3a0
[15579.900701]  ? long_busy_list_alloc_test+0x195/0x1c0 [test_vmalloc]
[15579.900732]  print_report+0xb9/0x2b0
[15579.900752]  ? kasan_addr_to_slab+0xd/0xb0
[15579.900776]  ? long_busy_list_alloc_test+0x195/0x1c0 [test_vmalloc]
[15579.900806]  kasan_report+0xd3/0x110
[15579.900828]  ? long_busy_list_alloc_test+0x195/0x1c0 [test_vmalloc]
[15579.900860]  long_busy_list_alloc_test+0x195/0x1c0 [test_vmalloc]
[15579.900890]  ? ktime_get+0xa1/0x170
[15579.900910]  ? __pfx_long_busy_list_alloc_test+0x10/0x10 [test_vmalloc]
[15579.900943]  test_func+0x232/0x510 [test_vmalloc]
[15579.900970]  ? __pfx_test_func+0x10/0x10 [test_vmalloc]
[15579.900998]  ? __kthread_parkme+0x82/0x140
[15579.901022]  ? __pfx_test_func+0x10/0x10 [test_vmalloc]
[15579.901049]  kthread+0x2a5/0x370
[15579.901069]  ? __pfx_kthread+0x10/0x10
[15579.901091]  ret_from_fork+0x34/0x70
[15579.901113]  ? __pfx_kthread+0x10/0x10
[15579.901135]  ret_from_fork_asm+0x1a/0x30
[15579.901161]  </TASK>

[15579.901189] The buggy address belongs to the virtual mapping at
                [ffffc901c0578000, ffffc901c05dd000) created by:
                long_busy_list_alloc_test+0x8e/0x1c0 [test_vmalloc]

[15579.901281] The buggy address belongs to the physical page:
[15579.901309] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x50611a
[15579.901312] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[15579.901317] raw: 0017ffffc0000000 0000000000000000 dead000000000122 0000000000000000
[15579.901320] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[15579.901321] page dumped because: kasan: bad access detected

[15579.901335] Memory state around the buggy address:
[15579.901359]  ffffc901c0577f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[15579.901391]  ffffc901c0577f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[15579.901423] >ffffc901c0578000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[15579.901455]                    ^
[15579.901474]  ffffc901c0578080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[15579.901506]  ffffc901c0578100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[15579.901538] ==================================================================
[15579.902332] Disabling lock debugging due to kernel taint

after applying this patch. Let me check tomorrow if it is a real BUG or
it is a side-effect of the patch.

--
Uladzislau Rezki

