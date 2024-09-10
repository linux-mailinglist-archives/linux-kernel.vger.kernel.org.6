Return-Path: <linux-kernel+bounces-323991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B3C974685
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3640E1F26CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EEF1AF4F0;
	Tue, 10 Sep 2024 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZZ6lDqC"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CCC1AC8B7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011879; cv=none; b=Bwy5XxX6ypwk4c2vllMU9oNySCMcaGt9Uh1GuEjk+tf8WmgaZKchVc1t2nZNCuQi4S+HQ1QE2QksN4qMV/PB0JpySwTvdTCOl6ryO5Jpnr3Hm1XSbfCnfCJ2pl/muaOe427gHRpVD+BeRQoQEUb6r+xZI1b9SriE1m2k/NpC6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011879; c=relaxed/simple;
	bh=dFKiwdQFdeHeGDHgLUaoks2Iut/fwJ7U/8H5WQn0Ux0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qdk2a3aUzWvBBuJmGXDGJsFa3UD5jhCgu/RCKeR8+c91jIQAEWcHdTcP4JBqxm8Gq/o0F4Lw53/4N/HHpAldcpxCgn6ykOJr6hVQ79ayR9hbu4g6aKm+gKISh9j0cWq2pIX3XZe+3OqXOa+Ye9gP9Bsth836f9zV5zLMXp2k1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZZ6lDqC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3e062dbeeso7481047b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011875; x=1726616675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sKXYIyjsovK+WV8DiI7P/1dY1v3IRDe3dp7/1EItjd0=;
        b=tZZ6lDqCMDPAbXr0s5fioLQtSNw04aNvJAapoxiKcSHPHFyjnIFq/9NwYKH183unLo
         6CGMTETbwrPHRPfw4nIJjuuT2O/xIxbGtD2a4BQ75b2TudDhNuuQfcCuOGlhtc51yDot
         07gZ0/Ild7OtNqopHt3C1wFznh60/BHjAxVzs0k6xvPboz8QH1YrS8T1Q36J8qTsr6kC
         1lcDuqVGY9+1im4FFwBAOSvzQcTHXVFolL5x2CLwe/7TX9aMCZg02bL5UWl8KXum1v3I
         cUGr3UDh0Fiy2opvWWMyvjhYSMWoQrdtMt2XnCmWExAPDHuOMR3WfkmDZh/bo/yDvkQz
         rXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011875; x=1726616675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKXYIyjsovK+WV8DiI7P/1dY1v3IRDe3dp7/1EItjd0=;
        b=smuI8jzHKvUlc6P0yI8NqFLB+K5ze3P0KNHyl/+fIs8y1M7wDBj4CEtfcr1ol/5G8d
         +pfdlEyDw791ZoFeD3SfugFwELI5pzkLXd28aTAQUMv1jT9LAT4JdHVQRT6UntRlBZK6
         O3WphE/2KxytKSjYudlyy8hCgeLVvu037h4F6oeKDuMf0mQMVRHcBIs05qEMSNe4PV7z
         H6sDVSXr0DvjOtoJXMx19j58BtheFB5HeGdPsOg0cjmO/Y/b2Z9lh4gw9CZibiU2z1lD
         rxMT2kBWbeBqG4TkAQ2Y9nMtdCnftUHovaIoKVj0k13TO4hu7LPU0qYPxMK5CZa+b1tl
         biSA==
X-Forwarded-Encrypted: i=1; AJvYcCWNWZCO/EJkk2gAWdSZ/U3htaf6c1uHWfuAEDM4wvzb6BtIir2l7pT8HjeJQnHDWMoossgplnlHT/hZPXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5F55VHYdNMz3vIvTfMEIRnLeHft2gdKux6xjAgPDWITMcCng
	T9oUwC1u7FwKfWP1Q5CEZS+7gQI+hCKTaiMV0xrSbJTPEHBr5daNTVYd8xNaNiU/TAFdpL0krGN
	WmRvO5Sua9su8TAFi8j7Geg==
X-Google-Smtp-Source: AGHT+IGUU7n7hwsUDrLro4Wgjoj/bFNd+sQ+f4VxxKGmgg0FjsnP+LmFWcl01bi6YDhQwKnjz58ssMXCFPvnGLCBGA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:20a0:b0:6db:7f4d:f79f with
 SMTP id 00721157ae682-6db951c4d86mr1153687b3.0.1726011875005; Tue, 10 Sep
 2024 16:44:35 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:32 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <cc6ae391e557a3be8e72746d42968c2d23d6e8a7.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 01/39] mm: hugetlb: Simplify logic in dequeue_hugetlb_folio_vma()
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Replace arguments avoid_reserve and chg in dequeue_hugetlb_folio_vma()
so dequeue_hugetlb_folio_vma() is more understandable.

The new argument, use_hstate_resv, indicates whether the folio to be
dequeued should be taken from reservations in hstate.

If use_hstate_resv is true, the folio to be dequeued should be taken
from reservations in hstate and hence h->resv_huge_pages is
decremented, and the folio is marked so that the reservation is
restored.

If use_hstate_resv is false, then a folio needs to be taken from the
pool and hence there must exist available_huge_pages(h), failing
which, goto err.

The bool use_hstate_resv can be reused within
dequeue_hugetlb_folio_vma()'s caller, alloc_hugetlb_folio().

No functional changes are intended.

As proof, the original two if conditions

!vma_has_reserves(vma, chg) && !available_huge_pages(h)

and

avoid_reserve && !available_huge_pages(h)

can be combined into

(avoid_reserve || !vma_has_reserves(vma, chg))
&& !available_huge_pages(h).

Applying de Morgan's theorem on

avoid_reserve || !vma_has_reserves(vma, chg)

yields

!avoid_reserve && vma_has_reserves(vma, chg),

hence the simplification is correct.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index aaf508be0a2b..af5c6bbc9ff0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1280,8 +1280,9 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 	}
 
 	/*
-	 * Only the process that called mmap() has reserves for
-	 * private mappings.
+	 * Only the process that called mmap() has reserves for private
+	 * mappings. A child process with MAP_PRIVATE mappings created by their
+	 * parent have no page reserves.
 	 */
 	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
 		/*
@@ -1393,8 +1394,7 @@ static unsigned long available_huge_pages(struct hstate *h)
 
 static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 				struct vm_area_struct *vma,
-				unsigned long address, int avoid_reserve,
-				long chg)
+				unsigned long address, bool use_hstate_resv)
 {
 	struct folio *folio = NULL;
 	struct mempolicy *mpol;
@@ -1402,16 +1402,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 	nodemask_t *nodemask;
 	int nid;
 
-	/*
-	 * A child process with MAP_PRIVATE mappings created by their parent
-	 * have no page reserves. This check ensures that reservations are
-	 * not "stolen". The child may still get SIGKILLed
-	 */
-	if (!vma_has_reserves(vma, chg) && !available_huge_pages(h))
-		goto err;
-
-	/* If reserves cannot be used, ensure enough pages are in the pool */
-	if (avoid_reserve && !available_huge_pages(h))
+	if (!use_hstate_resv && !available_huge_pages(h))
 		goto err;
 
 	gfp_mask = htlb_alloc_mask(h);
@@ -1429,7 +1420,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
 							nid, nodemask);
 
-	if (folio && !avoid_reserve && vma_has_reserves(vma, chg)) {
+	if (folio && use_hstate_resv) {
 		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
 	}
@@ -3130,6 +3121,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	struct mem_cgroup *memcg;
 	bool deferred_reserve;
 	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
+	bool use_hstate_resv;
 
 	memcg = get_mem_cgroup_from_current();
 	memcg_charge_ret = mem_cgroup_hugetlb_try_charge(memcg, gfp, nr_pages);
@@ -3190,20 +3182,17 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	if (ret)
 		goto out_uncharge_cgroup_reservation;
 
+	use_hstate_resv = !avoid_reserve && vma_has_reserves(vma, gbl_chg);
+
 	spin_lock_irq(&hugetlb_lock);
-	/*
-	 * glb_chg is passed to indicate whether or not a page must be taken
-	 * from the global free pool (global change).  gbl_chg == 0 indicates
-	 * a reservation exists for the allocation.
-	 */
-	folio = dequeue_hugetlb_folio_vma(h, vma, addr, avoid_reserve, gbl_chg);
+	folio = dequeue_hugetlb_folio_vma(h, vma, addr, use_hstate_resv);
 	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
 		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
 		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
-		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
+		if (use_hstate_resv) {
 			folio_set_hugetlb_restore_reserve(folio);
 			h->resv_huge_pages--;
 		}
-- 
2.46.0.598.g6f2099f65c-goog


