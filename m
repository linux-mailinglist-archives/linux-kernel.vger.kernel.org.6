Return-Path: <linux-kernel+bounces-408791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4D49C8394
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F501F21873
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCC91F26CC;
	Thu, 14 Nov 2024 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a3YhmZnl"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CFB1E8855
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567668; cv=none; b=qnxS2p/xpOtm+6RuPEMeJm31/jK+dyYb0tI8hVu1X2OOt/rUVy9+4Z5R+8QKwbyYteAUA1ue7VtMzsepJD63l/byXPe3KsQMj/vdRsfNLf5+BaOh5DG0QaLdMDGkzNqI1nhz8BUalF+h3P6qxWhD4p0/Zx4NQooTD7Sj4DgFlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567668; c=relaxed/simple;
	bh=PlCDMUKY8UaG2TptvcZhZCqJzQLxeovwSEQxQ9vjo7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OvPAHeMQ9BhsLcfxVqz8QbEHSP0T10yTzJqGz7tiER7yjeOjud8z66zLPQSCWbEpGkEM2QwGKkClw0yl88SXLVRbbAsK4TNtsctrgpTNgmRL7LH0IOGA1TAyIevCxowpxh3jLVsbLkuAyajsRrSb1X1rZiUJ+RZMs4qcXV68SOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a3YhmZnl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cdda5cfb6so2310675ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731567666; x=1732172466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUqyGtITukFY0TNyC3digbboCysogNiC1m+PxqBi3vg=;
        b=a3YhmZnl9a4WtpKdgHhh4nVLq3uAjHv8GYUF4/hMfCbNaIcI6/+In4tAYfHgs23CfU
         Ccsqk7tYqgJXwevkGqt0aquL+sUNCkQOOkMP+W4zz5Aks8zkO1bCbKpVKuSmLpodhPwT
         dme9h3Q5qbrLRFbSfR0qQAYOdrkhE9NvZA6tjINR7XVkbRLkS9VVYGi79lP5WTrafrBS
         N0eYerrJBbSLjSu7AvVNHXRq7tE4iK8jCMBHsvW8HfelotoNuOS9e7xa+lp9V1zWobGj
         e409hyMRHsLTQa/XwlXuUw9/FhzWNR8bfP2kbg6SjLvIuvhqIkjWDSi9FDROFL2fE7TI
         fctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567666; x=1732172466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUqyGtITukFY0TNyC3digbboCysogNiC1m+PxqBi3vg=;
        b=iv84zeJjP2TxWHioNAq7sQ+1RMOte+ura3/T00e3AkK1Hu9ExKun6YJ9OBnP985h0c
         rcBvCEhAuhlA9VXft8Ih9PKtqlKZRDCZ+4qZec+g3m8wetIzw5XVv/LdFafJyNewrKGw
         pCD10t6H5+Y+uV2FC1SPHyEEfRDPbK9m+84AD4F9KCsbrWNdgmv4uLdt/i8Ot8e+H0LX
         yUzVy8nx6tD6PPQD/SuBEGC10vyDtZ4hlWFrJHOuZbqE0VZfQElRmjn+lKNO2a/qWz94
         6XjckKykOnKQvtms3Va0aJiXVLw+Fusk1JlpGKeEMIfKL9LrSQdgy6o7GdqCpMLCYmmP
         1NfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqhTCVaozkCk2bKRNl/KWIl61YduymyuyEXXJYzadxI/QTlIkxkivO8aBBemHH5Dzszf9ttS8Me59Hd/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4bDY8idIqQ7BqjVQ0+7aaP2rmlo7TGSeq+GN3FrnaS02ecTX
	i4rcdQeECXJn93YbofHpklAFZ8FpNhQoW0xDq03HkfepJ4IN/BY3g5BToHhLHW0=
X-Google-Smtp-Source: AGHT+IH+CIyFvL8Lk36CjibW+Kiayt53v1Ia4QUhn9aVanblqL6M7a/wyMFzo1loiDImRID/mm6uDQ==
X-Received: by 2002:a17:902:ec82:b0:20c:d469:ba95 with SMTP id d9443c01a7336-211b6609df6mr63772575ad.16.1731567666242;
        Wed, 13 Nov 2024 23:01:06 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d389c2sm4119065ad.268.2024.11.13.23.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:01:05 -0800 (PST)
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
Subject: [PATCH v3 5/9] mm: introduce do_zap_pte_range()
Date: Thu, 14 Nov 2024 14:59:56 +0800
Message-Id: <1d8467c1428573cc666ca3150ba66877f7b316cf.1731566457.git.zhengqi.arch@bytedance.com>
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

This commit introduces do_zap_pte_range() to actually zap the PTEs, which
will help improve code readability and facilitate secondary checking of
the processed PTEs in the future.

No functional change.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Jann Horn <jannh@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 24633d0e1445a..bf5ac8e0b4656 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1679,6 +1679,25 @@ static inline int skip_none_ptes(pte_t *pte, unsigned long addr,
 	return nr;
 }
 
+/* If PTE_MARKER_UFFD_WP is enabled, the uffd-wp PTEs may be re-installed. */
+static inline int do_zap_pte_range(struct mmu_gather *tlb,
+				   struct vm_area_struct *vma, pte_t *pte,
+				   unsigned long addr, unsigned long end,
+				   struct zap_details *details, int *rss,
+				   bool *force_flush, bool *force_break)
+{
+	pte_t ptent = ptep_get(pte);
+	int max_nr = (end - addr) / PAGE_SIZE;
+
+	if (pte_present(ptent))
+		return zap_present_ptes(tlb, vma, pte, ptent, max_nr,
+					addr, details, rss, force_flush,
+					force_break);
+
+	return zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr, addr,
+					 details, rss);
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -1701,9 +1720,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	do {
-		pte_t ptent = ptep_get(pte);
-		int max_nr;
-
 		if (need_resched())
 			break;
 
@@ -1715,18 +1731,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			pte += nr;
 		}
 
-		max_nr = (end - addr) / PAGE_SIZE;
-		if (pte_present(ptent)) {
-			nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,
-					      addr, details, rss, &force_flush,
-					      &force_break);
-			if (unlikely(force_break)) {
-				addr += nr * PAGE_SIZE;
-				break;
-			}
-		} else {
-			nr = zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr,
-						 addr, details, rss);
+		nr = do_zap_pte_range(tlb, vma, pte, addr, end, details,
+				      rss, &force_flush, &force_break);
+		if (unlikely(force_break)) {
+			addr += nr * PAGE_SIZE;
+			break;
 		}
 	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
-- 
2.20.1


