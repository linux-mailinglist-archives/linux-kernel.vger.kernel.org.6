Return-Path: <linux-kernel+bounces-261512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DCF93B819
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78141F21C40
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDBF139D1A;
	Wed, 24 Jul 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFzCsKpA"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51A8120C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853298; cv=none; b=HOoMkoTfqA99XfXTTuzhSw/WyUs5ZNwaHIj+ffPojUj3fyswy3X0sjhJ150l4BwDo0ckoRDW3Ay7lgH5oTFwg8LjDvSRJfJU/6onIR2edJqILMrIouAHukwNJXDuPrTtfgbW5Fm5TMRnxBT4GMMM6sDf1mRdB2cVusfzx0zzOwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853298; c=relaxed/simple;
	bh=vFH7327q+5rH3J9UsScnR7oqlDXuPEFOwEiM+oIb0DU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH9T0SRg2MgToQr17KDfjTi/v4K+Jf7t1btNz4LJsBWKuAmxs4MbgB1Os3qucgClEH7hRicQkWpQ1Pz/aFEUo310mnIIYFZ8u45jv1A3akPpt9KmnWfmP62/K+igD1DYxL9GdPgCG6xiEIB/pkM99eYH4ycveNOfvTlWIvd8Up8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFzCsKpA; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f025b94e07so2569931fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721853294; x=1722458094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aL/MHX8ocQL08cfxr5CF34T2UZUbJ//sYdQZ9GO2OEw=;
        b=bFzCsKpAZhYzTRE7V0ZaTe1gO024aDtvby6BRLrpvsmKMYpM3nsym3gtSh4xO1q799
         U4D1YgWGUmdDNJ3kvl44FcS6d4ZHX8vafzv24ryiYnKvZhPhM44YVHGdkl4ZFwkik8gE
         jCcYo9PA3K3FbKvEyHVQtE9OO85gqNJmZO0EuQ64GovysYQyAWYR7GnaLv7kNhL+FEBi
         ypi9kEVQ9O8QJhyBSlBV4xkzoK06xktZaxuTsYwkqchs0aeb/niQ+V8hd6g+CpzH1k7i
         N7aj2v/UiLwSc0t9g09rfVYruPhGxlE16akpKaTL2LPfMGXqHvHBxtid3oZ0s7aG31Rp
         iTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721853294; x=1722458094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL/MHX8ocQL08cfxr5CF34T2UZUbJ//sYdQZ9GO2OEw=;
        b=L2t1JJSoCs2FVogosA8055L3c0rwXeYJDBqP+RFot0Q4ISA8LHxPSIUvDGX8BtCmms
         5EXKMmdDyMVAeDUnftd1XrL3fu2NgZbv/fpG/isR/cv/3FbupuPdEWcTAmuDDC3KvIqA
         yYoWiEC2A/PfPOHSVgcf+Bc6q4HrMCNGe3ROEF9ZYpwmvHWtZlNVwjnB0xMReQ3bPbSv
         5yqnpZ6GSLzHUnLW2CWvqW5+KVfstWr+4s9s0bB+L/Pj8EJd8BGXpsna9oLjDK0Azw3n
         7e1FOmvATzqMXk463DnaQJbyW6Zu0jJleZbg1/HMPks15vr7c+4vsP4+f94wjq1kBAyV
         rI9g==
X-Forwarded-Encrypted: i=1; AJvYcCVpX5NnHPrRhXeQokLfEZvb71IfLz2hmKUldl+KennssVURGt0B3d/qF5Ata6aij7iQRTouLA0NAWEmHVuFjXBHXXXLbP1LN6vgZjWw
X-Gm-Message-State: AOJu0Yykb1uEX7oTsMRJgCkaA0QRE3qF+Jm+iywoiXjkmUeR+VZ6fJVW
	WdnfbuA8mPaOebUuAzoiHm87RfXjnx0wyiijH47Er//g85QGvYrF
X-Google-Smtp-Source: AGHT+IFG5lRYCwoSvnRY6wNKxXZH0lbrp+Tjw6qO7pTZqDNUY+OTWeybDV7POpqFx4DMPDMXL672yQ==
X-Received: by 2002:a2e:95d7:0:b0:2ef:17f7:6e1d with SMTP id 38308e7fff4ca-2f039edeaddmr6439291fa.4.1721853293083;
        Wed, 24 Jul 2024 13:34:53 -0700 (PDT)
Received: from pc638.lan (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf0e356sm105591fa.27.2024.07.24.13.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 13:34:52 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Wed, 24 Jul 2024 22:34:51 +0200
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Adrian Huang <adrianhuang0701@gmail.com>, ahuang12@lenovo.com,
	akpm@linux-foundation.org, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	peterz@infradead.org, sunjw10@lenovo.com
Subject: Re: [PATCH 1/1] mm/vmalloc: Add preempt point in purge_vmap_node()
 when enabling kasan
Message-ID: <ZqFlawuVnOMY2k3E@pc638.lan>
References: <Zp-K_A60DjlDhlRt@pc636>
 <20240724124624.27673-1-ahuang12@lenovo.com>
 <ZqEQhUWTUWWFA4ek@pc636>
 <ZqEZRyOVEAaqyCuU@pc636>
 <ZqFVslYh9UV0h6wR@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqFVslYh9UV0h6wR@pc636>

On Wed, Jul 24, 2024 at 09:27:46PM +0200, Uladzislau Rezki wrote:
> On Wed, Jul 24, 2024 at 05:09:59PM +0200, Uladzislau Rezki wrote:
> > On Wed, Jul 24, 2024 at 04:32:37PM +0200, Uladzislau Rezki wrote:
> > > On Wed, Jul 24, 2024 at 08:46:24PM +0800, Adrian Huang wrote:
> > > > > It works great and does not generate the soft-lock-up splat :)
> > > > > See below some comments:
> > > > 
> > > > Great. Thanks for the confirmation.
> > > > 
> > > > <snip>
> > > > 
> > > > >> +     kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
> > > > >> +
> > > > >>
> > > > > Do we need it here? We just did the TLB flush for en entire range in the
> > > > > __purge_vmap_area_lazy(). So, it is two times invoked and looks odd to me.
> > > > >
> > > > > Am i missing something?
> > > > 
> > > > 1. The TLB flush for the entire range in __purge_vmap_area_lazy() is for
> > > > the vmalloc virtual address (VMALLOC_START->VMALLOC_END).
> > > > 
> > > > 2. The TLB flush in purge_vmap_node() is for the KASAN shadow virtual address 
> > > > (the shadow offset 'CONFIG_KASAN_SHADOW_OFFSET' is defined in .config).
> > > > 
> > > Correct. It deals with a shadow region!
> > > 
> > > >
> > > > BTW, I found my first patch has the potential risk. We need to flush TLB of
> > > > the KASAN shadow virtual address firstly. Please see the following patch for
> > > > detail. (I put the comment in the following patch). The following patch
> > > > also works well on my 256-core machine.
> > > > 
> > > I noticed that and it would be my second question :)
> > > 
> > > >
> > > > If you're ok with the patch, I'll submit it for upstream review. And, may I
> > > > have your tag(s): tested-by/reviewed-by? (If possible, could you please have
> > > > a test for the following patch).
> > > > 
> > > I am OK. I will test and get back soon.
> > > 
> > > > Thanks.
> > > > 
> > > > ---
> > > > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > > > index 70d6a8f6e25d..ddbf42a1a7b7 100644
> > > > --- a/include/linux/kasan.h
> > > > +++ b/include/linux/kasan.h
> > > > @@ -55,6 +55,9 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
> > > >  int kasan_populate_early_shadow(const void *shadow_start,
> > > >  				const void *shadow_end);
> > > >  
> > > > +#define KASAN_VMALLOC_PAGE_RANGE 0x1 /* Apply exsiting page range */
> > > > +#define KASAN_VMALLOC_TLB_FLUSH  0x2 /* TLB flush */
> > > > +
> > > >  #ifndef kasan_mem_to_shadow
> > > >  static inline void *kasan_mem_to_shadow(const void *addr)
> > > >  {
> > > > @@ -511,7 +514,8 @@ void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
> > > >  int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> > > >  void kasan_release_vmalloc(unsigned long start, unsigned long end,
> > > >  			   unsigned long free_region_start,
> > > > -			   unsigned long free_region_end);
> > > > +			   unsigned long free_region_end,
> > > > +			   unsigned long flags);
> > > >  
> > > >  #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> > > >  
> > > > @@ -526,7 +530,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
> > > >  static inline void kasan_release_vmalloc(unsigned long start,
> > > >  					 unsigned long end,
> > > >  					 unsigned long free_region_start,
> > > > -					 unsigned long free_region_end) { }
> > > > +					 unsigned long free_region_end,
> > > > +					 unsigned long flags) { }
> > > >  
> > > >  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> > > >  
> > > > @@ -561,7 +566,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
> > > >  static inline void kasan_release_vmalloc(unsigned long start,
> > > >  					 unsigned long end,
> > > >  					 unsigned long free_region_start,
> > > > -					 unsigned long free_region_end) { }
> > > > +					 unsigned long free_region_end,
> > > > +					 unsigned long flags) { }
> > > >  
> > > >  static inline void *kasan_unpoison_vmalloc(const void *start,
> > > >  					   unsigned long size,
> > > > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > > > index d6210ca48dda..88d1c9dcb507 100644
> > > > --- a/mm/kasan/shadow.c
> > > > +++ b/mm/kasan/shadow.c
> > > > @@ -489,7 +489,8 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
> > > >   */
> > > >  void kasan_release_vmalloc(unsigned long start, unsigned long end,
> > > >  			   unsigned long free_region_start,
> > > > -			   unsigned long free_region_end)
> > > > +			   unsigned long free_region_end,
> > > > +			   unsigned long flags)
> > > >  {
> > > >  	void *shadow_start, *shadow_end;
> > > >  	unsigned long region_start, region_end;
> > > > @@ -522,12 +523,17 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
> > > >  			__memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
> > > >  			return;
> > > >  		}
> > > > -		apply_to_existing_page_range(&init_mm,
> > > > +
> > > > +
> > > > +		if (flags & KASAN_VMALLOC_PAGE_RANGE)
> > > > +			apply_to_existing_page_range(&init_mm,
> > > >  					     (unsigned long)shadow_start,
> > > >  					     size, kasan_depopulate_vmalloc_pte,
> > > >  					     NULL);
> > > > -		flush_tlb_kernel_range((unsigned long)shadow_start,
> > > > -				       (unsigned long)shadow_end);
> > > > +
> > > > +		if (flags & KASAN_VMALLOC_TLB_FLUSH)
> > > > +			flush_tlb_kernel_range((unsigned long)shadow_start,
> > > > +					       (unsigned long)shadow_end);
> > > >  	}
> > > >  }
> > > >  
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index e34ea860153f..12cdc92cdb83 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -2193,8 +2193,22 @@ static void purge_vmap_node(struct work_struct *work)
> > > >  	struct vmap_area *va, *n_va;
> > > >  	LIST_HEAD(local_list);
> > remove the space.
> > > >  
> > > > +	unsigned long start;
> > > > +	unsigned long end;
> > > > +
> > > >  	vn->nr_purged = 0;
> > > >  
> > > > +	start = list_first_entry(&vn->purge_list, struct vmap_area, list)->va_start;
> > no need to have an extra space.
> > > > +
> > > > +	end = list_last_entry(&vn->purge_list, struct vmap_area, list)->va_end;
> > > > +
> > > > +	/*
> > > > +	 * Since node_pool_add_va() returns vmap_area(s) to its pool, the
> > > > +	 * returned vmap_area(s) might be grabbed immediately via node_alloc()
> > > > +	 * by other core. We need to flush TLB firstly.
> > > > +	 */
> > > > +	kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
> > > > +
> > > >  	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
> > > >  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
> > > >  		unsigned long orig_start = va->va_start;
> > > > @@ -2205,7 +2219,8 @@ static void purge_vmap_node(struct work_struct *work)
> > > >  
> > > >  		if (is_vmalloc_or_module_addr((void *)orig_start))
> > > >  			kasan_release_vmalloc(orig_start, orig_end,
> > > > -					      va->va_start, va->va_end);
> > > > +					      va->va_start, va->va_end,
> > > > +					      KASAN_VMALLOC_PAGE_RANGE);
> > >
> > orig_start and orig_end are unnecessary now. But it can be removed by
> > an extra patch!
> > 
> > > >  
> > > >  		atomic_long_sub(nr, &vmap_lazy_nr);
> > > >  		vn->nr_purged++;
> > > > @@ -4726,7 +4741,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> > > >  				&free_vmap_area_list);
> > > >  		if (va)
> > > >  			kasan_release_vmalloc(orig_start, orig_end,
> > > > -				va->va_start, va->va_end);
> > > > +				va->va_start, va->va_end,
> > > > +				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
> > > >  		vas[area] = NULL;
> > > >  	}
> > > >  
> > > > @@ -4776,7 +4792,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> > > >  				&free_vmap_area_list);
> > > >  		if (va)
> > > >  			kasan_release_vmalloc(orig_start, orig_end,
> > > > -				va->va_start, va->va_end);
> > > > +				va->va_start, va->va_end,
> > > > +				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
> > > >  		vas[area] = NULL;
> > > >  		kfree(vms[area]);
> > > >  	}
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> I get: BUG: KASAN: vmalloc-out-of-bounds in long_busy_list_alloc_test+0x195/0x1c0 [test_vmalloc]
> 
> [15579.900340] ==================================================================
> [15579.900412] BUG: KASAN: vmalloc-out-of-bounds in long_busy_list_alloc_test+0x195/0x1c0 [test_vmalloc]
> [15579.900459] Write of size 1 at addr ffffc901c0578000 by task vmalloc_test/2/49374
> 
> [15579.900506] CPU: 199 PID: 49374 Comm: vmalloc_test/2 Kdump: loaded Not tainted 6.10.0-rc5-00019-g4236f0255ea8-dirty #3450
> [15579.900554] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [15579.900595] Call Trace:
> [15579.900611]  <TASK>
> [15579.900635]  dump_stack_lvl+0x53/0x70
> [15579.900670]  print_address_description.constprop.0+0x2c/0x3a0
> [15579.900701]  ? long_busy_list_alloc_test+0x195/0x1c0 [test_vmalloc]
> [15579.900732]  print_report+0xb9/0x2b0
> [15579.900752]  ? kasan_addr_to_slab+0xd/0xb0
> [15579.900776]  ? long_busy_list_alloc_test+0x195/0x1c0 [test_vmalloc]
> [15579.900806]  kasan_report+0xd3/0x110
> [15579.900828]  ? long_busy_list_alloc_test+0x195/0x1c0 [test_vmalloc]
> [15579.900860]  long_busy_list_alloc_test+0x195/0x1c0 [test_vmalloc]
> [15579.900890]  ? ktime_get+0xa1/0x170
> [15579.900910]  ? __pfx_long_busy_list_alloc_test+0x10/0x10 [test_vmalloc]
> [15579.900943]  test_func+0x232/0x510 [test_vmalloc]
> [15579.900970]  ? __pfx_test_func+0x10/0x10 [test_vmalloc]
> [15579.900998]  ? __kthread_parkme+0x82/0x140
> [15579.901022]  ? __pfx_test_func+0x10/0x10 [test_vmalloc]
> [15579.901049]  kthread+0x2a5/0x370
> [15579.901069]  ? __pfx_kthread+0x10/0x10
> [15579.901091]  ret_from_fork+0x34/0x70
> [15579.901113]  ? __pfx_kthread+0x10/0x10
> [15579.901135]  ret_from_fork_asm+0x1a/0x30
> [15579.901161]  </TASK>
> 
> [15579.901189] The buggy address belongs to the virtual mapping at
>                 [ffffc901c0578000, ffffc901c05dd000) created by:
>                 long_busy_list_alloc_test+0x8e/0x1c0 [test_vmalloc]
> 
> [15579.901281] The buggy address belongs to the physical page:
> [15579.901309] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x50611a
> [15579.901312] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> [15579.901317] raw: 0017ffffc0000000 0000000000000000 dead000000000122 0000000000000000
> [15579.901320] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [15579.901321] page dumped because: kasan: bad access detected
> 
> [15579.901335] Memory state around the buggy address:
> [15579.901359]  ffffc901c0577f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [15579.901391]  ffffc901c0577f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [15579.901423] >ffffc901c0578000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [15579.901455]                    ^
> [15579.901474]  ffffc901c0578080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [15579.901506]  ffffc901c0578100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [15579.901538] ==================================================================
> [15579.902332] Disabling lock debugging due to kernel taint
> 
> after applying this patch. Let me check tomorrow if it is a real BUG or
> it is a side-effect of the patch.
> 
You can trigger that BUG by running a vmalloc test-squite:

sudo ./test_vmalloc.sh run_test_mask=7 nr_threads=15

Reworked a bit your patch to solve a false-positive above splat:

<snip>
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 70d6a8f6e25d..ddbf42a1a7b7 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -55,6 +55,9 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 int kasan_populate_early_shadow(const void *shadow_start,
 				const void *shadow_end);
 
+#define KASAN_VMALLOC_PAGE_RANGE 0x1 /* Apply exsiting page range */
+#define KASAN_VMALLOC_TLB_FLUSH  0x2 /* TLB flush */
+
 #ifndef kasan_mem_to_shadow
 static inline void *kasan_mem_to_shadow(const void *addr)
 {
@@ -511,7 +514,8 @@ void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
 int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
-			   unsigned long free_region_end);
+			   unsigned long free_region_end,
+			   unsigned long flags);
 
 #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
@@ -526,7 +530,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
 static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long end,
 					 unsigned long free_region_start,
-					 unsigned long free_region_end) { }
+					 unsigned long free_region_end,
+					 unsigned long flags) { }
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
@@ -561,7 +566,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
 static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long end,
 					 unsigned long free_region_start,
-					 unsigned long free_region_end) { }
+					 unsigned long free_region_end,
+					 unsigned long flags) { }
 
 static inline void *kasan_unpoison_vmalloc(const void *start,
 					   unsigned long size,
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d6210ca48dda..88d1c9dcb507 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -489,7 +489,8 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
  */
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
-			   unsigned long free_region_end)
+			   unsigned long free_region_end,
+			   unsigned long flags)
 {
 	void *shadow_start, *shadow_end;
 	unsigned long region_start, region_end;
@@ -522,12 +523,17 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			__memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
 			return;
 		}
-		apply_to_existing_page_range(&init_mm,
+
+
+		if (flags & KASAN_VMALLOC_PAGE_RANGE)
+			apply_to_existing_page_range(&init_mm,
 					     (unsigned long)shadow_start,
 					     size, kasan_depopulate_vmalloc_pte,
 					     NULL);
-		flush_tlb_kernel_range((unsigned long)shadow_start,
-				       (unsigned long)shadow_end);
+
+		if (flags & KASAN_VMALLOC_TLB_FLUSH)
+			flush_tlb_kernel_range((unsigned long)shadow_start,
+					       (unsigned long)shadow_end);
 	}
 }
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 03b82fb8ecd3..ed5eb02de545 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2186,6 +2186,25 @@ decay_va_pool_node(struct vmap_node *vn, bool full_decay)
 	reclaim_list_global(&decay_list);
 }
 
+static void
+kasan_release_vmalloc_node(struct vmap_node *vn)
+{
+	struct vmap_area *va;
+	unsigned long start, end;
+
+	start = list_first_entry(&vn->purge_list, struct vmap_area, list)->va_start;
+	end = list_last_entry(&vn->purge_list, struct vmap_area, list)->va_end;
+
+	list_for_each_entry(va, &vn->purge_list, list) {
+		if (is_vmalloc_or_module_addr((void *) va->va_start))
+			kasan_release_vmalloc(va->va_start, va->va_end,
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE);
+	}
+
+	kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
+}
+
 static void purge_vmap_node(struct work_struct *work)
 {
 	struct vmap_node *vn = container_of(work,
@@ -2193,20 +2212,17 @@ static void purge_vmap_node(struct work_struct *work)
 	struct vmap_area *va, *n_va;
 	LIST_HEAD(local_list);
 
+	if (kasan_enabled())
+		kasan_release_vmalloc_node(vn);
+
 	vn->nr_purged = 0;
 
 	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
 		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
-		unsigned long orig_start = va->va_start;
-		unsigned long orig_end = va->va_end;
 		unsigned int vn_id = decode_vn_id(va->flags);
 
 		list_del_init(&va->list);
 
-		if (is_vmalloc_or_module_addr((void *)orig_start))
-			kasan_release_vmalloc(orig_start, orig_end,
-					      va->va_start, va->va_end);
-
 		atomic_long_sub(nr, &vmap_lazy_nr);
 		vn->nr_purged++;
 
@@ -4717,7 +4733,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 				&free_vmap_area_list);
 		if (va)
 			kasan_release_vmalloc(orig_start, orig_end,
-				va->va_start, va->va_end);
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
 		vas[area] = NULL;
 	}
 
@@ -4767,7 +4784,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 				&free_vmap_area_list);
 		if (va)
 			kasan_release_vmalloc(orig_start, orig_end,
-				va->va_start, va->va_end);
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
 		vas[area] = NULL;
 		kfree(vms[area]);
 	}
<snip>

--
Uladzislau Rezki

