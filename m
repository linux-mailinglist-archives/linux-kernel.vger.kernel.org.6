Return-Path: <linux-kernel+bounces-408788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10769C8391
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C5BB2269A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00601F26DB;
	Thu, 14 Nov 2024 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eVl/ee1Y"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476811F26E7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567643; cv=none; b=BwzEwynVbzDFgcnyd0nwtELf5/ZRCNP3uiwW1LTI40Ak9R77ASQ2bR4VAHyrG/gWuLLntwNDf9NtobGYAHe567SP5ghym2sM4rZxtR4WwSdQtBmn6r+uNyGIZ8d6ZFqFneN3QAX3ucThqdV2BOhJ0XEycJRB3fepDFbHMADO4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567643; c=relaxed/simple;
	bh=hP7hUc+z7BZxPdYj1/2wMZfEErGlV5j6jXq2U6tDsOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YkoutVsQgyppqq1M71CfD4xliWGVnqvklBoyVEb9ytw3w8d152BPzmEpK7JdKSCwIHSDcmGFDL0DuSemqRulBiZh+TgOJfy1deWrrib8j0rVMIxUuuHAvcpf6AkQJUaBjgYgBxrfYbsFWrsqrelhmIszLpMxxeI64Ejtn11g1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eVl/ee1Y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ce5e3b116so2153715ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731567641; x=1732172441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5NhkFR9u/ZCBqXODjRxrXNpbWksUAj27FTFaGEH9DI=;
        b=eVl/ee1YJE8l8AJ26PFZ7FqJKHC6yrXpS6iPgeo03I7HlFVqWtQILFNg8UfrG5aY+i
         eyQ50trL9fovU0czvZS80BFuURfWNKL+0oty+Pa3x7yKcoZSr7JPjZjid2P10CZIjqF5
         1/yoMrQhRBeIUDzprvgA6KkRaRXu3Ng+rOb5pgD8D3HvIqZn1UaLHZtxdmUQX50z483A
         B7Ox9JrGUkSy4fRpXwGz4f+4OjxBJbtxFAAdmnl9KD4ijWtqOlzx3/6GyS0FDiN8hOdj
         3o1R/JSV0aAtupgtRp4wWtKlk35uucRgtf0KnHEwoh719fYPlK0NjjaC4r74/srnE063
         Datw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567641; x=1732172441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5NhkFR9u/ZCBqXODjRxrXNpbWksUAj27FTFaGEH9DI=;
        b=ipDy7qvJgzvMdHYPD24HWjp/hwYGDztFho6HdJYeyQVGv/5BgceurF56iylLNK2pBF
         Tz/ZqNNgWWy9hG+rYsn7UkhSezPhYn+bwVWGcg/ra+s0SVqhu5t9ul5dj+3mqzkT5fhm
         /srtDROtGrRlgcG+hGpjT/oI/dO8aguuh43BSpa4HJNIv8E0G24AzubfmXUe8AIPx/nY
         KrYEcjZoqRpA3ztHzuHW6Mhe0qawHL3bRD8GkQPD6spRyxXw5FBwDkO6g4jq10bFU+WV
         UePpgxkVoZCDUkRN/c0duYWfm2iUpoRlLRUc1CQ+TKemNy9ZpjNeBPkPvoGSsnzG0GKb
         vMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlA682MJh1tt7VBLN1pP9rn5L4LjKPaTXiBU9obGONtTRblW6ZPZNKmQrSbJKxMPUX0nq1GAUXZdbjN+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhpYuM7hVWOr3eQVzgPF+uARIPhWoXqC1s5Ttc+zicIYoQ6Eg
	u/X9JN9G+UrHoa39BPyOBSpAvfH8VHKYBRXvFz54hsPFiYQ09CnZ/f4Mn45w6hY=
X-Google-Smtp-Source: AGHT+IHBiLojldOiy5h7kyJqW1/SyLghLkJxoovGFCwaxMGieVNX0Uk7Et6paaJVqXGLWQ0ZBmUDAg==
X-Received: by 2002:a17:902:d489:b0:20b:b75d:e8c1 with SMTP id d9443c01a7336-211c4f9cf52mr14080785ad.4.1731567641481;
        Wed, 13 Nov 2024 23:00:41 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d389c2sm4119065ad.268.2024.11.13.23.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:00:40 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	peterx@redhat.com
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zokeefe@google.com,
	rientjes@google.com,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 2/9] mm: userfaultfd: recheck dst_pmd entry in move_pages_pte()
Date: Thu, 14 Nov 2024 14:59:53 +0800
Message-Id: <ce9830b7725bf2b85d55a57c6317ed1141e96acb.1731566457.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1731566457.git.zhengqi.arch@bytedance.com>
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
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


