Return-Path: <linux-kernel+bounces-426741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D159DF726
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3E5B21A7C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882631DA63F;
	Sun,  1 Dec 2024 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQeoHeaj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E21D8E1D
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088183; cv=none; b=jRMVdIK+LZa+6pK2TgKXYLd3VWayMiS8MmKyN6VMImbkexFbOZKg1lm4eTv6EUBJ8kk2OFExipSAQ8xLKQQi7PWYtK4EqrxFmRcee91LSlXpAi4soH57q0xZA+KihnREqLKVDzw2nHSmRfrO3jatnF5937X8iowWYhTO0g+W3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088183; c=relaxed/simple;
	bh=tNMEMm+0UKui0cbRmREuuGJGP3p7pkxPiHc+LfNvtNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYDf9R1t63EAopAlDPKdLn0x8hYJFndlRA1s+bR5d+KdmhV2I7+Y84mnGqIhYj9Paj6LLZvsw7uDIuDbitvP+IY8MlNKg+ycTml99Ro7R6gqVvitV8AOmUY2CM2sGFvd6/NJqwM7QIi5maoN2FmQOT1n7nJHGTCahbqmQESstG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQeoHeaj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733088181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4S7W+NNw/Z0asEvav/qetVxn0P5gIx5aAGF1EDJoEHQ=;
	b=IQeoHeajXidKyzuyr5HN4Q+rnYcwD4+4UDk2BLfEAvTUiK+HOHQYKtJjAvpD2YrOg6nT8A
	CXnRX6ngn2MhI7czK3KHoQq7JHfdo8oKMNm8Vxx6DPF9shEsPnEGexl1iYAIyxBLG+ViLN
	S+sWfYj8liEanAy7G/Yr7Ebg7gEyqsg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-We0czABVOGykjlAstBtiRg-1; Sun, 01 Dec 2024 16:23:00 -0500
X-MC-Unique: We0czABVOGykjlAstBtiRg-1
X-Mimecast-MFC-AGG-ID: We0czABVOGykjlAstBtiRg
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4669be6c87aso47416871cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 13:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733088179; x=1733692979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4S7W+NNw/Z0asEvav/qetVxn0P5gIx5aAGF1EDJoEHQ=;
        b=mNDgOuryYOrfztt80gKEVZ5u5IzaPZOvjUV4xzTseMpwQtCqaq1uu+3AznhKMYOXH+
         pRpihyMJXJOMpemQY0xSKQue/+NI38A1AvdS7r+RXZjIcUc8BCO5GEmtJNazboeT6nch
         GE76Fr0RroMifU/xphVnRNdk8SGi2+HvuTc4cF4QLxmhpKDAlkfMPXL5xf1TQJ7vYzFG
         U6DsUywctH0lhc9obwoxTDYpCNN0QVsMF18XcEHoNPmBWVuGogQwDTO3cD7rfPyfAiCt
         g0my8ukDhuKGsKTrFjQRnWEUVseX1fvy2h6uXU7Z7wffhQsPiZTCGqGzRqLvXWkPWOYF
         xSoA==
X-Gm-Message-State: AOJu0Yxdn6fwMKdfQlEAMGV/g6VGLq0JqNBbsDii1kIhv9uD24tshajw
	GWljXpkP0/s2TytQgTFWUXPw/XjGxKZTtUNO0LWwU0cZMZgeIpBGZZB2s5RzGxKkJOcL2czRa1F
	P3qKGHM8Fl3rwQ8Tsod5SwGhFD56mB2SQwTRZywDohyQYiapVJlp7G8tdTZCHnRlGFxXL0+GF0S
	Zq44+NfkinhuWEA2PJWXjj5JRxqrEchGRUmWngmYdwcoU=
X-Gm-Gg: ASbGnctFmvR7znee7HgzYrlxJ+52l22iqS5Tsk+4ZyblbjBZUc2bYN8mE2MQEH6zSVn
	jvLrQFAbOLFgmncRgsEkf+hSvBePhz+HuQE7NsnXDD6hHU0KDpQ6Q+bB+M46HldbuiAGp02yDCI
	b7dbXZY60Wne6ssCkPrNhOpdKhxU72Gv5rj45LdEHmIOrREEcc5uWmeZyIyA0H7Eay5XVKYNot1
	Cwi7JgkZPePyNEJcyN3V4nqAR4M6yOy0mradhibmWNpe2snaFB3uCMqxwSPydYn8u8lATu18Hfh
	EIZMCdeIp/SzoKRdNfK5Z9IjMA==
X-Received: by 2002:a05:622a:558f:b0:463:60a9:74c0 with SMTP id d75a77b69052e-466b34df5a2mr287105121cf.14.1733088179023;
        Sun, 01 Dec 2024 13:22:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU8yFbm4tc7hT2oRa608rksSZP3tFjGJoJtWKVGNQdDCFCtb+uupJvQXL6XiGSzbeqJN01Ew==
X-Received: by 2002:a05:622a:558f:b0:463:60a9:74c0 with SMTP id d75a77b69052e-466b34df5a2mr287104571cf.14.1733088178467;
        Sun, 01 Dec 2024 13:22:58 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4249f0asm41278911cf.81.2024.12.01.13.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 13:22:57 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Rik van Riel <riel@surriel.com>,
	Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Ackerley Tng <ackerleytng@google.com>
Subject: [PATCH 5/7] mm/hugetlb: Simplify vma_has_reserves()
Date: Sun,  1 Dec 2024 16:22:38 -0500
Message-ID: <20241201212240.533824-6-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241201212240.533824-1-peterx@redhat.com>
References: <20241201212240.533824-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vma_has_reserves() is a helper "trying" to know whether the vma should
consume one reservation when allocating the hugetlb folio.

However it's not clear on why we need such complexity, as such information
is already represented in the "chg" variable.

From alloc_hugetlb_folio() context, "chg" (or in the function's context,
"gbl_chg") is defined as:

  - If gbl_chg=1, the allocation cannot reuse an existing reservation
  - If gbl_chg=0, the allocation should reuse an existing reservation

Firstly, map_chg is defined as following, to cover all cases of hugetlb
reservation scenarios (mostly, via vma_needs_reservation(), but
cow_from_owner is an outlier):

CONDITION                                             HAS RESERVATION?
=========                                             ================
- SHARED: always check against per-inode resv_map
  (ignore NONRESERVE)
  - If resv exists                                ==> YES  [1]
  - If not                                        ==> NO   [2]
- PRIVATE: complicated...
  - Request came from a CoW from owner resv map   ==> NO   [3]
    (when cow_from_owner==true)
  - If does not own a resv_map at all..           ==> NO   [4]
    (examples: VM_NORESERVE, private fork())
  - If owns a resv_map, but resv donsn't exists   ==> NO   [5]
  - If owns a resv_map, and resv exists           ==> YES  [6]

Further on, gbl_chg considered spool setup, so that is a decision based on
all the context.

If we look at vma_has_reserves(), it almost does check that has already
been processed by map_chg accounting (I marked each return value to the
case above):

  static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
  {
          if (vma->vm_flags & VM_NORESERVE) {
                  if (vma->vm_flags & VM_MAYSHARE && chg == 0)
                          return true;              ==> [1]
                  else
                          return false;             ==> [2] or [4]
          }

          if (vma->vm_flags & VM_MAYSHARE) {
                  if (chg)
                          return false;             ==> [2]
                  else
                          return true;              ==> [1]
          }

          if (is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
                  if (chg)
                          return false;             ==> [5]
                  else
                          return true;              ==> [6]
          }

          return false;                             ==> [4]
  }

It didn't check [3], but [3] case was actually already covered now by the
"chg" / "gbl_chg" / "map_chg" calculations.

In short, vma_has_reserves() doesn't provide anything more than return
"!chg".. so just simplify all the things.

There're a lot of comments describing truncation races, IIUC there should
have no race as long as map_chg is properly done.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 67 ++++++----------------------------------------------
 1 file changed, 7 insertions(+), 60 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 14cfe0bb01e4..b7e16b3c4e67 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1247,66 +1247,13 @@ void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
 }
 
 /* Returns true if the VMA has associated reserve pages */
-static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
+static bool vma_has_reserves(long chg)
 {
-	if (vma->vm_flags & VM_NORESERVE) {
-		/*
-		 * This address is already reserved by other process(chg == 0),
-		 * so, we should decrement reserved count. Without decrementing,
-		 * reserve count remains after releasing inode, because this
-		 * allocated page will go into page cache and is regarded as
-		 * coming from reserved pool in releasing step.  Currently, we
-		 * don't have any other solution to deal with this situation
-		 * properly, so add work-around here.
-		 */
-		if (vma->vm_flags & VM_MAYSHARE && chg == 0)
-			return true;
-		else
-			return false;
-	}
-
-	/* Shared mappings always use reserves */
-	if (vma->vm_flags & VM_MAYSHARE) {
-		/*
-		 * We know VM_NORESERVE is not set.  Therefore, there SHOULD
-		 * be a region map for all pages.  The only situation where
-		 * there is no region map is if a hole was punched via
-		 * fallocate.  In this case, there really are no reserves to
-		 * use.  This situation is indicated if chg != 0.
-		 */
-		if (chg)
-			return false;
-		else
-			return true;
-	}
-
 	/*
-	 * Only the process that called mmap() has reserves for
-	 * private mappings.
+	 * Now "chg" has all the conditions considered for whether we
+	 * should use an existing reservation.
 	 */
-	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
-		/*
-		 * Like the shared case above, a hole punch or truncate
-		 * could have been performed on the private mapping.
-		 * Examine the value of chg to determine if reserves
-		 * actually exist or were previously consumed.
-		 * Very Subtle - The value of chg comes from a previous
-		 * call to vma_needs_reserves().  The reserve map for
-		 * private mappings has different (opposite) semantics
-		 * than that of shared mappings.  vma_needs_reserves()
-		 * has already taken this difference in semantics into
-		 * account.  Therefore, the meaning of chg is the same
-		 * as in the shared case above.  Code could easily be
-		 * combined, but keeping it separate draws attention to
-		 * subtle differences.
-		 */
-		if (chg)
-			return false;
-		else
-			return true;
-	}
-
-	return false;
+	return chg == 0;
 }
 
 static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
@@ -1407,7 +1354,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 	 * have no page reserves. This check ensures that reservations are
 	 * not "stolen". The child may still get SIGKILLed
 	 */
-	if (!vma_has_reserves(vma, chg) && !available_huge_pages(h))
+	if (!vma_has_reserves(chg) && !available_huge_pages(h))
 		goto err;
 
 	gfp_mask = htlb_alloc_mask(h);
@@ -1425,7 +1372,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
 							nid, nodemask);
 
-	if (folio && vma_has_reserves(vma, chg)) {
+	if (folio && vma_has_reserves(chg)) {
 		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
 	}
@@ -3076,7 +3023,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
-		if (vma_has_reserves(vma, gbl_chg)) {
+		if (vma_has_reserves(gbl_chg)) {
 			folio_set_hugetlb_restore_reserve(folio);
 			h->resv_huge_pages--;
 		}
-- 
2.47.0


