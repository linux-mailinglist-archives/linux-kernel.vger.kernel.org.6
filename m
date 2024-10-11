Return-Path: <linux-kernel+bounces-361954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC7699AF4F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFAC283C92
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01341E4120;
	Fri, 11 Oct 2024 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Q67KLpj"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9678D1E0B6D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688978; cv=none; b=Z/nafZFwxjIww+lHiaMoYp97T7zB+ZHCionsOre2Cf4NC/QCEM3hDJ/Ti6nOcif/y0DoS/tx08kFzge7EH4AzFqPHpaxRp1QkRlEFbcG96lsrIjf353z7bGE08xSNBxwZC9HC7hs3w/bhbPtypRbDNWb6wHqcc3s00bTNn8hY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688978; c=relaxed/simple;
	bh=Gau1ydTYGuCvwtKgP2KlmKQaOwOGpCa5RoKlrazqx2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OffLzh2r02ckXXsPAdHAcGJSBpHQqP6uI16RoIQgOcl38OmookLcL8YmjkeW0d+RjGuJMKQ3H6lGBmgfrMYF06/TXZCaWadPVC4gqYHKcorpMBnH3kA1wWg65oucb8vGrh6TurnCArUsnHcC4jj+GQN4Kks7he/40edS9U1Yrus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Q67KLpj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e49ae1172so531285b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728688976; x=1729293776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5z/uTVdP5L9L1RuFDdlTqhHJV3lmY38mQBJGe8OEp3E=;
        b=3Q67KLpj+aNbjUX5LCuovoNjmxYYBTIzxWyuyMWFeaPs1Xt5OSCRz3x/DKxcTG4Imq
         1I+PIwBCx2GL+0YX11IlYTFpJh/yQeChGWFw53B4XuHWVooLZjk1XBypUSeyWRLoWjmu
         jmRQQhyPKnFB48XKHY+4kleR3Zku5XkH9d23IIiocffqnXeBR5hVcX3o8ubbzD1z80uo
         hdkKqAvWfRYUY68pcVKMXdyg2ioJfH+9Uw61xMzLhOZEHqOMZbEwybQW4kkB7YM51ITz
         tXUEQDGTin9tVr33YXX7ZDL7esmcA/Xp5pBMZ1fpTBMaAGm+aF7QA5q0k/vy+O+VB0eH
         lpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728688976; x=1729293776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5z/uTVdP5L9L1RuFDdlTqhHJV3lmY38mQBJGe8OEp3E=;
        b=WNemm+wtmSZqFpeQ4Tyi5LnnQ8a+jMyc7pqO51rieQBAy0rlG+9LYRrvX3PlaeqvF3
         9DE6pHNvSL8yipYZISO+hIDnZe3Wv2EzWomIv+M89A2V+Ll3cpvzJdnVIAiBLz7zm/PV
         KxVXypf35FSAkr9ZVPoKgX4lXSnL8HVtf/tEIjyP9kaKVQ6SBpLPvzogPhDPwn5vC+xZ
         HGiDB+ivR5rTeYU4UfYdgj4qz25fRIoW5c6O684iurjRqkfzgchKmgPmdmWpteGUhGQj
         8qNBSFX6CVccLAXvvpMY5DDC25nevkAmfFFAwgC8OoeqVIXJsyfPYWo6a58AwVFyGKkO
         6CwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTSP8lJ7sCsr8YJRIwOS6ONc8mLWslkyDL3acbFDJcZgvDoUzIFC4jZ5EF82GGy9xij9A08+RJtO9duew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCvQKF+f9FwRj9jO4jph4KwPlqHLFIg0akZfWk4mumA5To6ge
	Y/9Q5m6qeJh2wDHu++tmIyQ9cxFVk27GmUvBfLv+drs359NvBfgRQdPK20t8rxURnajCEC7PL17
	U+2iggSVF+DRCzlW/X5S1Og==
X-Google-Smtp-Source: AGHT+IFfT7z16+ucRzSRkvBaeFJLnd4Fcce7MUMDnNMVo0kKP75g66nPfjELWNwdxuLQm7HYU5qKFyPa9P3bxM35iw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:146:b875:ac13:a9fc])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:6f60:b0:70d:fba:c51c with
 SMTP id d2e1a72fcca58-71e380c6404mr6646b3a.3.1728688975598; Fri, 11 Oct 2024
 16:22:55 -0700 (PDT)
Date: Fri, 11 Oct 2024 23:22:36 +0000
In-Reply-To: <cover.1728684491.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1728684491.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <b2b7be300469aa59933f08257c794675895d49f8.1728684491.git.ackerleytng@google.com>
Subject: [RFC PATCH 1/3] mm: hugetlb: Simplify logic in dequeue_hugetlb_folio_vma()
From: Ackerley Tng <ackerleytng@google.com>
To: muchun.song@linux.dev, peterx@redhat.com, akpm@linux-foundation.org, 
	rientjes@google.com, fvdl@google.com, jthoughton@google.com, david@redhat.com
Cc: isaku.yamahata@intel.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, tabba@google.com, quic_eberman@quicinc.com, 
	roypat@amazon.co.uk, jgg@nvidia.com, jhubbard@nvidia.com, seanjc@google.com, 
	pbonzini@redhat.com, erdemaktas@google.com, vannapurve@google.com, 
	ackerleytng@google.com, pgonda@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
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
index 190fa05635f4..73165c670739 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1281,8 +1281,9 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
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
@@ -1394,8 +1395,7 @@ static unsigned long available_huge_pages(struct hstate *h)

 static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 				struct vm_area_struct *vma,
-				unsigned long address, int avoid_reserve,
-				long chg)
+				unsigned long address, bool use_hstate_resv)
 {
 	struct folio *folio = NULL;
 	struct mempolicy *mpol;
@@ -1403,16 +1403,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
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
@@ -1430,7 +1421,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
 							nid, nodemask);

-	if (folio && !avoid_reserve && vma_has_reserves(vma, chg)) {
+	if (folio && use_hstate_resv) {
 		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
 	}
@@ -2973,6 +2964,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	struct mem_cgroup *memcg;
 	bool deferred_reserve;
 	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
+	bool use_hstate_resv;

 	memcg = get_mem_cgroup_from_current();
 	memcg_charge_ret = mem_cgroup_hugetlb_try_charge(memcg, gfp, nr_pages);
@@ -3033,20 +3025,17 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
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
2.47.0.rc1.288.g06298d1525-goog

