Return-Path: <linux-kernel+bounces-431046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658B99E3874
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7806F161564
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408961B21AB;
	Wed,  4 Dec 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AZfrw58S"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ADB1B4130
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310633; cv=none; b=NkR4vpH+eazqvshL+Fn5whed8fxhbrmq6ZxKh9eEmEHw9fIIc4fSHaWT8HTDXAUiw7wNiEUwLCAWo+vCMar+4SzylFUoDGAagSr5Pw0UITOxJdQ8N+7OjEs4FoiM9szUZlARMyt7NwvLBkzgXSz/6lbISlzmN1G58CX4yfJqHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310633; c=relaxed/simple;
	bh=hP7hUc+z7BZxPdYj1/2wMZfEErGlV5j6jXq2U6tDsOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WuGPn0ofV4X4Ks0V7P5Xi7bYOrkNnNDPO/WeoP9KEZvue4fIc0QXliW64JM4jAen1OgSfmNhUp2Ii2nka7V5R4MOyDq/51gUBLKsglRwd+ajhJNvnFZ9YN3xmnfLgbJCwDbuoX4+RQvincmUQuWqyvoBUjcUqb1OK+8+mlw1G4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AZfrw58S; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215cc7b0c56so14453425ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733310631; x=1733915431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5NhkFR9u/ZCBqXODjRxrXNpbWksUAj27FTFaGEH9DI=;
        b=AZfrw58SvUb7o187X3TZRx0kYECmA3r3shludNJCjMNzWQDLcb80l2KM9TcmLUAY1e
         oWgBg8AKQ8ccHoc0CII7DD79WyOPWh11zupKpMTerTAwz7hXHTxjTuShjc+28jwQ2doJ
         MJBV2QOlDcdDduy0PiOiO4vDRYQ+F9zHdYeAgO5OKFQiyqu54AvXu+YslJPSRNSwGlKf
         1mfgTMMUtK47t3VRdMCs7U9UhwhL6OHNNiVARCS2wp8n88yiOl6/d1WWZLRn2C73i9/c
         Esz94QI1OVzAN3DczQeM8GaSVf8DA8wK03jXz+xYyCbJ5UPJX5/QT9HGlm/cxR6ZrVRB
         urXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310631; x=1733915431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5NhkFR9u/ZCBqXODjRxrXNpbWksUAj27FTFaGEH9DI=;
        b=eKg36Szw5EOqV9lN7YUpkXcHyx/v630ID1M/gEru0RaOAsPDEScasn/MCtbvT7FGfS
         zofm/t6AltyKJSfR3F1Aegj4dRsO8Vs9Znu6JQ6mZ139MS60xhfmSVmoc1Blqw1vTW+n
         DJIYrI2urN+yejlsV+cun6e9RdiuJ1bEPU2uxY7yWH9Eo9FfM5GBiqWf9ZwQbK/Rwg+x
         t9ppTD0vLjwytxnHOK1h76W1zQ2Gl8hNphDBXPEeLjRUYCYSUo4KZNC7eivCTKtA6GqG
         HgWXuQyaU2JJ3BpKbyG2q2VSi7c7x440MK0SQQUosH9I5A0KqxXA8+tjjYA25HvcBbdy
         O6CA==
X-Forwarded-Encrypted: i=1; AJvYcCWigxkKkWvsi/PJm1ewBEB+cU7UOiisjJkJ9xgJMdu7v7CGe2O7iOuyO9yNMQ1y0TSPThydD138+vDWaWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyaZLsDsnFdLo7WdvP6V8NZ2d5VbgrUg/ecgi82u0yC7LmtKk
	btxfE/e3t97fs8LWJ+ld2LCgTvixPJgDIC9FBmYWpydAYch8wtDSyFl9883JQMU=
X-Gm-Gg: ASbGnctYIWRA9X6PkBZj7T5qg0A/nOcjeHhE7h3IbW6XILzGkGu69qzRK10g0BxyWuK
	OpmQIZl/2T9lrDUmgFgApDlOCWcD0y9atTg7rYWvxHIs1GgRBFHZSQXnvjZbDxWiX1cXfF/TBxw
	OR/DFClxb6Qinm2NbBAD0FKZcfHRQNjqtU+b8ggcrG5+tMFlZvtFe011mpiz/kvkRsPx1F3vVsl
	RIs5acz8kjKiJOro4HCKN+P8mGOxmcQK087sTQdyOqKYhDY4VkPaX19AODi3v1r/VWgc2mBx7a0
	oFm2VVpzMTSlojs=
X-Google-Smtp-Source: AGHT+IHr/3WEXhcUbT+3scjK3eDqtKNFZN/P/43E0ViNGyViHEQX/poSMnV5EjBiq3NGqRPWRhcOyA==
X-Received: by 2002:a17:902:f64d:b0:215:9894:5679 with SMTP id d9443c01a7336-215bc42229emr92525605ad.0.1733310630948;
        Wed, 04 Dec 2024 03:10:30 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21527515731sm107447495ad.192.2024.12.04.03.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:10:30 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	zokeefe@google.com,
	rientjes@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 02/11] mm: userfaultfd: recheck dst_pmd entry in move_pages_pte()
Date: Wed,  4 Dec 2024 19:09:42 +0800
Message-Id: <8108c262757fc492626f3a2ffc44b775f2710e16.1733305182.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1733305182.git.zhengqi.arch@bytedance.com>
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In move_pages_pte(), since dst_pte needs to be none, the subsequent
pte_same() check cannot prevent the dst_pte page from being freed
concurrently, so we also need to abtain dst_pmdval and recheck pmd_same().
Otherwise, once we support empty PTE page reclaimation for anonymous
pages, it may result in moving the src_pte page into the dts_pte page that
is about to be freed by RCU.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/userfaultfd.c | 51 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 60a0be33766ff..8e16dc290ddf1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1020,6 +1020,14 @@ void double_pt_unlock(spinlock_t *ptl1,
 		__release(ptl2);
 }
 
+static inline bool is_pte_pages_stable(pte_t *dst_pte, pte_t *src_pte,
+				       pte_t orig_dst_pte, pte_t orig_src_pte,
+				       pmd_t *dst_pmd, pmd_t dst_pmdval)
+{
+	return pte_same(ptep_get(src_pte), orig_src_pte) &&
+	       pte_same(ptep_get(dst_pte), orig_dst_pte) &&
+	       pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
+}
 
 static int move_present_pte(struct mm_struct *mm,
 			    struct vm_area_struct *dst_vma,
@@ -1027,6 +1035,7 @@ static int move_present_pte(struct mm_struct *mm,
 			    unsigned long dst_addr, unsigned long src_addr,
 			    pte_t *dst_pte, pte_t *src_pte,
 			    pte_t orig_dst_pte, pte_t orig_src_pte,
+			    pmd_t *dst_pmd, pmd_t dst_pmdval,
 			    spinlock_t *dst_ptl, spinlock_t *src_ptl,
 			    struct folio *src_folio)
 {
@@ -1034,8 +1043,8 @@ static int move_present_pte(struct mm_struct *mm,
 
 	double_pt_lock(dst_ptl, src_ptl);
 
-	if (!pte_same(ptep_get(src_pte), orig_src_pte) ||
-	    !pte_same(ptep_get(dst_pte), orig_dst_pte)) {
+	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
+				 dst_pmd, dst_pmdval)) {
 		err = -EAGAIN;
 		goto out;
 	}
@@ -1071,6 +1080,7 @@ static int move_swap_pte(struct mm_struct *mm,
 			 unsigned long dst_addr, unsigned long src_addr,
 			 pte_t *dst_pte, pte_t *src_pte,
 			 pte_t orig_dst_pte, pte_t orig_src_pte,
+			 pmd_t *dst_pmd, pmd_t dst_pmdval,
 			 spinlock_t *dst_ptl, spinlock_t *src_ptl)
 {
 	if (!pte_swp_exclusive(orig_src_pte))
@@ -1078,8 +1088,8 @@ static int move_swap_pte(struct mm_struct *mm,
 
 	double_pt_lock(dst_ptl, src_ptl);
 
-	if (!pte_same(ptep_get(src_pte), orig_src_pte) ||
-	    !pte_same(ptep_get(dst_pte), orig_dst_pte)) {
+	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
+				 dst_pmd, dst_pmdval)) {
 		double_pt_unlock(dst_ptl, src_ptl);
 		return -EAGAIN;
 	}
@@ -1097,13 +1107,14 @@ static int move_zeropage_pte(struct mm_struct *mm,
 			     unsigned long dst_addr, unsigned long src_addr,
 			     pte_t *dst_pte, pte_t *src_pte,
 			     pte_t orig_dst_pte, pte_t orig_src_pte,
+			     pmd_t *dst_pmd, pmd_t dst_pmdval,
 			     spinlock_t *dst_ptl, spinlock_t *src_ptl)
 {
 	pte_t zero_pte;
 
 	double_pt_lock(dst_ptl, src_ptl);
-	if (!pte_same(ptep_get(src_pte), orig_src_pte) ||
-	    !pte_same(ptep_get(dst_pte), orig_dst_pte)) {
+	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
+				 dst_pmd, dst_pmdval)) {
 		double_pt_unlock(dst_ptl, src_ptl);
 		return -EAGAIN;
 	}
@@ -1136,6 +1147,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	pte_t *src_pte = NULL;
 	pte_t *dst_pte = NULL;
 	pmd_t dummy_pmdval;
+	pmd_t dst_pmdval;
 	struct folio *src_folio = NULL;
 	struct anon_vma *src_anon_vma = NULL;
 	struct mmu_notifier_range range;
@@ -1148,11 +1160,11 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 retry:
 	/*
 	 * Use the maywrite version to indicate that dst_pte will be modified,
-	 * but since we will use pte_same() to detect the change of the pte
-	 * entry, there is no need to get pmdval, so just pass a dummy variable
-	 * to it.
+	 * since dst_pte needs to be none, the subsequent pte_same() check
+	 * cannot prevent the dst_pte page from being freed concurrently, so we
+	 * also need to abtain dst_pmdval and recheck pmd_same() later.
 	 */
-	dst_pte = pte_offset_map_rw_nolock(mm, dst_pmd, dst_addr, &dummy_pmdval,
+	dst_pte = pte_offset_map_rw_nolock(mm, dst_pmd, dst_addr, &dst_pmdval,
 					   &dst_ptl);
 
 	/* Retry if a huge pmd materialized from under us */
@@ -1161,7 +1173,11 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		goto out;
 	}
 
-	/* same as dst_pte */
+	/*
+	 * Unlike dst_pte, the subsequent pte_same() check can ensure the
+	 * stability of the src_pte page, so there is no need to get pmdval,
+	 * just pass a dummy variable to it.
+	 */
 	src_pte = pte_offset_map_rw_nolock(mm, src_pmd, src_addr, &dummy_pmdval,
 					   &src_ptl);
 
@@ -1213,7 +1229,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			err = move_zeropage_pte(mm, dst_vma, src_vma,
 					       dst_addr, src_addr, dst_pte, src_pte,
 					       orig_dst_pte, orig_src_pte,
-					       dst_ptl, src_ptl);
+					       dst_pmd, dst_pmdval, dst_ptl, src_ptl);
 			goto out;
 		}
 
@@ -1303,8 +1319,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 
 		err = move_present_pte(mm,  dst_vma, src_vma,
 				       dst_addr, src_addr, dst_pte, src_pte,
-				       orig_dst_pte, orig_src_pte,
-				       dst_ptl, src_ptl, src_folio);
+				       orig_dst_pte, orig_src_pte, dst_pmd,
+				       dst_pmdval, dst_ptl, src_ptl, src_folio);
 	} else {
 		entry = pte_to_swp_entry(orig_src_pte);
 		if (non_swap_entry(entry)) {
@@ -1319,10 +1335,9 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			goto out;
 		}
 
-		err = move_swap_pte(mm, dst_addr, src_addr,
-				    dst_pte, src_pte,
-				    orig_dst_pte, orig_src_pte,
-				    dst_ptl, src_ptl);
+		err = move_swap_pte(mm, dst_addr, src_addr, dst_pte, src_pte,
+				    orig_dst_pte, orig_src_pte, dst_pmd,
+				    dst_pmdval, dst_ptl, src_ptl);
 	}
 
 out:
-- 
2.20.1


