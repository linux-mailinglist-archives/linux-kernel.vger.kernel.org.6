Return-Path: <linux-kernel+bounces-288707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8524E953DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EB81F26BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28746155739;
	Thu, 15 Aug 2024 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPAXRVvN"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6290512B94
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723763195; cv=none; b=EqkBcdB2QzT1J+fRjac3AzMn2Jj61M06wNX0bbhb4xlEFCN0YJwvDX0RiLf1a82sdxTsaLHInG/GwIMCo4te14hp6hiDt8F7IXezlLR06PIEXNGyn+5mMiYYILvATZlrG2QLfVouL183+55Fht/0oe8JliXeQ4l7BdmFNDhJPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723763195; c=relaxed/simple;
	bh=xcqovtWc5+QAsBBFOX7v4heS2/NfrG03Eh2JIED6YJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfeCAMo2xK9r6+Esw+pZH4WgBY4Uxg5qTIFRKTonQBxNAyga4NTm2iF1OFHibE95Vxd0SfSlYEUWSIJ6sFDxdSbgyGEGUISj8t9lq0DXggvT3G6251zxcH1sUU1mgmlh9OG2skpcI/WRXZIM7DKE/2VoOXGLTFmdsJYeuuXcPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPAXRVvN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20208830de8so777425ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723763193; x=1724367993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/zpViDnXt7FpAGHxaqgS4YyUNzii93kYurBFVfMwqE=;
        b=PPAXRVvNBdUUhwwTUx90mhHltYHl21wyT7a+Ccano/+Z4cF9KLIRH9LuqasR7DNDAQ
         ONWEUQItaQ5KUNAb2TbSrDO5onRFKrRZA/6EaCEAGTUiJPuoQscv58AZvE8pmHrBu6IV
         xwaukOEKmrDnxWz6lmj34PZV/KP/g0O6Q08NN5eZQUTksIAqeZbw5Vuo+/6kay4VNAGl
         +9ncu0BtHqkbV/oh+1JMyeYfEz3yWqKyR4NDTiq8GQoJUEULxWir5eIkdx4DoI2WPw3j
         SHSy3lVacPtHe76RhKDEqQHLwIrUVR9/wWRhlx6N/ox84qqplLTVylFjiCO2iIsUPDeN
         yIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723763193; x=1724367993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/zpViDnXt7FpAGHxaqgS4YyUNzii93kYurBFVfMwqE=;
        b=P2KP4CInhBkVL5d5WrnKSy6qJo2HLSWydSKTdsDv8SFrj/rW26FfYK+vcdtLkfqaF3
         h+8OgFqhaw01pUc5d5DYURVtlxdTyW+rxHCDj82oejUh3f1ka5O0X48K21pJovsujowG
         rYRzOgILAAhuoqAZvd7OwyTfRJ3VFfMwL9WhDG9DJR+dQjt2R8r9gEXzY5X/s0fC20gl
         z24lUW9cHTf1vfzKru1HXRQZWAGgASTpYPxVgedHdnA5MGM2Vpg+ndZZdSL/GbeMV/se
         bhULGBU8pRD63yPzp+6zUJG6lJkyZ2GfzFi9Ay0DA1xM7Ttq+gH20jEkQ3sx7L7l5YIL
         GPng==
X-Forwarded-Encrypted: i=1; AJvYcCXIxH+B9cHmDBRnUcysYVEjEFyTASxGQGcWBqxRMMzLB92LOHyVCnSEtqKGdDHcshDCkNusgNrtj+yqNPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSgBupEkn6bF6IsFoaqnw2YzaiF7nHIRGkYe9F7Q4KFRxg7Lh+
	H4CgJB9FVcoS1nxaVFMMN/ypwbKtRntqElOt/yRS96W+0U9bLbYg
X-Google-Smtp-Source: AGHT+IGlJ4CKM5TdeWOEh9vmgZNrpyxETSOztRbXUr0JVMqCNlRfxztjXl2nRsrCNZD/PIMUTKpFjw==
X-Received: by 2002:a17:902:ecc3:b0:1fb:54d9:ebbb with SMTP id d9443c01a7336-20203ea1da0mr15808655ad.22.1723763192564;
        Thu, 15 Aug 2024 16:06:32 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7ca35fsm4202664a91.9.2024.08.15.16.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 16:06:32 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: wangkefeng.wang@huawei.com
Cc: akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hch@infradead.org,
	hughd@google.com,
	kaleshsingh@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com
Subject: Re: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like devices
Date: Fri, 16 Aug 2024 11:06:12 +1200
Message-Id: <20240815230612.77266-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20ed69ad-5dad-446b-9f01-86ad8b1c67fa@huawei.com>
References: <20ed69ad-5dad-446b-9f01-86ad8b1c67fa@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Aug 16, 2024 at 1:27 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>
>
> On 2024/8/15 17:47, Kairui Song wrote:
> > On Fri, Aug 2, 2024 at 8:21 PM Barry Song <21cnbao@gmail.com> wrote:
> >>
> >> From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > Hi Chuanhua,
> >
> >>
> ...
>
> >> +
> >> +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> >> +{
> >> +       struct vm_area_struct *vma = vmf->vma;
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +       unsigned long orders;
> >> +       struct folio *folio;
> >> +       unsigned long addr;
> >> +       swp_entry_t entry;
> >> +       spinlock_t *ptl;
> >> +       pte_t *pte;
> >> +       gfp_t gfp;
> >> +       int order;
> >> +
> >> +       /*
> >> +        * If uffd is active for the vma we need per-page fault fidelity to
> >> +        * maintain the uffd semantics.
> >> +        */
> >> +       if (unlikely(userfaultfd_armed(vma)))
> >> +               goto fallback;
> >> +
> >> +       /*
> >> +        * A large swapped out folio could be partially or fully in zswap. We
> >> +        * lack handling for such cases, so fallback to swapping in order-0
> >> +        * folio.
> >> +        */
> >> +       if (!zswap_never_enabled())
> >> +               goto fallback;
> >> +
> >> +       entry = pte_to_swp_entry(vmf->orig_pte);
> >> +       /*
> >> +        * Get a list of all the (large) orders below PMD_ORDER that are enabled
> >> +        * and suitable for swapping THP.
> >> +        */
> >> +       orders = thp_vma_allowable_orders(vma, vma->vm_flags,
> >> +                       TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
> >> +       orders = thp_vma_suitable_orders(vma, vmf->address, orders);
> >> +       orders = thp_swap_suitable_orders(swp_offset(entry), vmf->address, orders);
> >> +
> >> +       if (!orders)
> >> +               goto fallback;
> >> +
> >> +       pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address & PMD_MASK, &ptl);
> >> +       if (unlikely(!pte))
> >> +               goto fallback;
> >> +
> >> +       /*
> >> +        * For do_swap_page, find the highest order where the aligned range is
> >> +        * completely swap entries with contiguous swap offsets.
> >> +        */
> >> +       order = highest_order(orders);
> >> +       while (orders) {
> >> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> >> +               if (can_swapin_thp(vmf, pte + pte_index(addr), 1 << order))
> >> +                       break;
> >> +               order = next_order(&orders, order);
> >> +       }
> >> +
> >> +       pte_unmap_unlock(pte, ptl);
> >> +
> >> +       /* Try allocating the highest of the remaining orders. */
> >> +       gfp = vma_thp_gfp_mask(vma);
> >> +       while (orders) {
> >> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> >> +               folio = vma_alloc_folio(gfp, order, vma, addr, true);
> >> +               if (folio)
> >> +                       return folio;
> >> +               order = next_order(&orders, order);
> >> +       }
> >> +
> >> +fallback:
> >> +#endif
> >> +       return vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address, false);
> >> +}
> >> +
> >> +
> >>   /*
> >>    * We enter with non-exclusive mmap_lock (to exclude vma changes,
> >>    * but allow concurrent faults), and pte mapped but not yet locked.
> >> @@ -4074,35 +4220,37 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>          if (!folio) {
> >>                  if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >>                      __swap_count(entry) == 1) {
> >> -                       /*
> >> -                        * Prevent parallel swapin from proceeding with
> >> -                        * the cache flag. Otherwise, another thread may
> >> -                        * finish swapin first, free the entry, and swapout
> >> -                        * reusing the same entry. It's undetectable as
> >> -                        * pte_same() returns true due to entry reuse.
> >> -                        */
> >> -                       if (swapcache_prepare(entry, 1)) {
> >> -                               /* Relax a bit to prevent rapid repeated page faults */
> >> -                               schedule_timeout_uninterruptible(1);
> >> -                               goto out;
> >> -                       }
> >> -                       need_clear_cache = true;
> >> -
> >>                          /* skip swapcache */
> >> -                       folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> >> -                                               vma, vmf->address, false);
> >> +                       folio = alloc_swap_folio(vmf);
> >>                          page = &folio->page;
> >>                          if (folio) {
> >>                                  __folio_set_locked(folio);
> >>                                  __folio_set_swapbacked(folio);
> >>
> >> +                               nr_pages = folio_nr_pages(folio);
> >> +                               if (folio_test_large(folio))
> >> +                                       entry.val = ALIGN_DOWN(entry.val, nr_pages);
> >> +                               /*
> >> +                                * Prevent parallel swapin from proceeding with
> >> +                                * the cache flag. Otherwise, another thread may
> >> +                                * finish swapin first, free the entry, and swapout
> >> +                                * reusing the same entry. It's undetectable as
> >> +                                * pte_same() returns true due to entry reuse.
> >> +                                */
> >> +                               if (swapcache_prepare(entry, nr_pages)) {
> >> +                                       /* Relax a bit to prevent rapid repeated page faults */
> >> +                                       schedule_timeout_uninterruptible(1);
> >> +                                       goto out_page;
> >> +                               }
> >> +                               need_clear_cache = true;
> >> +
> >>                                  if (mem_cgroup_swapin_charge_folio(folio,
> >>                                                          vma->vm_mm, GFP_KERNEL,
> >>                                                          entry)) {
> >>                                          ret = VM_FAULT_OOM;
> >>                                          goto out_page;
> >>                                  }
> >
> > After your patch, with build kernel test, I'm seeing kernel log
> > spamming like this:
> > [  101.048594] pagefault_out_of_memory: 95 callbacks suppressed
> > [  101.048599] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> > [  101.059416] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> > [  101.118575] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> > [  101.125585] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> > [  101.182501] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> > [  101.215351] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> > [  101.272822] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> > [  101.403195] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> > ............
> >
> > And heavy performance loss with workloads limited by memcg, mTHP enabled.
> >
> > After some debugging, the problematic part is the
> > mem_cgroup_swapin_charge_folio call above.
> > When under pressure, cgroup charge fails easily for mTHP. One 64k
> > swapin will require a much more aggressive reclaim to success.
> >
> > If I change MAX_RECLAIM_RETRIES from 16 to 512, the spamming log is
> > gone and mTHP swapin should have a much higher swapin success rate.
> > But this might not be the right way.
> >
> > For this particular issue, maybe you can change the charge order, try
> > charging first, if successful, use mTHP. if failed, fallback to 4k?
>
> This is what we did in alloc_anon_folio(), see 085ff35e7636
> ("mm: memory: move mem_cgroup_charge() into alloc_anon_folio()"),
> 1) fallback earlier
> 2) using same GFP flags for allocation and charge
>
> but it seems that there is a little complicated for swapin charge

Kefeng, thanks! I guess we can continue using the same approach and
it's not too complicated. 

Kairui, sorry for the trouble and thanks for the report! could you
check if the solution below resolves the issue? On phones, we don't
encounter the scenarios you’re facing.

From 2daaf91077705a8fa26a3a428117f158f05375b0 Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Fri, 16 Aug 2024 10:51:48 +1200
Subject: [PATCH] mm: fallback to next_order if charing mTHP fails

When memcg approaches its limit, charging mTHP becomes difficult.
At this point, when the charge fails, we fallback to the next order
to avoid repeatedly retrying larger orders.

Reported-by: Kairui Song <ryncsn@gmail.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0ed3603aaf31..6cba28ef91e7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4121,8 +4121,12 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
 		folio = vma_alloc_folio(gfp, order, vma, addr, true);
-		if (folio)
-			return folio;
+		if (folio) {
+			if (!mem_cgroup_swapin_charge_folio(folio,
+					vma->vm_mm, gfp, entry))
+				return folio;
+			folio_put(folio);
+		}
 		order = next_order(&orders, order);
 	}
 
@@ -4244,7 +4248,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				}
 				need_clear_cache = true;
 
-				if (mem_cgroup_swapin_charge_folio(folio,
+				if (nr_pages == 1 && mem_cgroup_swapin_charge_folio(folio,
 							vma->vm_mm, GFP_KERNEL,
 							entry)) {
 					ret = VM_FAULT_OOM;
-- 
2.34.1


Thanks
Barry


