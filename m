Return-Path: <linux-kernel+bounces-256949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433B3937304
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F7D282166
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C477D2C182;
	Fri, 19 Jul 2024 04:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMBuZbPc"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D4E1B86FC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721363110; cv=none; b=oNzugHipY1oWCz8N5EQ4qjB+mdAggXejn/Oji+eF0H9ZbRdh+WBN3GZPLUMFpsczZ/dsFeA1KwVOGhMAx2LRaZl6DKbMxZlNqpO00w5NguL3PsYs2mC41lrl4OllzGtlYMbpzXyLkY5iza/62uEeR8NQoeRhm23lup1ASo1aDKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721363110; c=relaxed/simple;
	bh=JfDQi8IHe+Y/uHGn7NOeok9pvCy1UhqkSbJ7urQArRo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cMXxZAtgAiK0YWhX2ocO/W7bVX1+RKkIqPn8pymnAsDr2sIn+XO4ulFA0fFXcOSwMQbAtnvclT7UPrmIDmpFE7oQkMPJ+rM8CHoZ/MFtcus/HLrDQbX2WHbsirR2zVZcxQmIVf7t50b3sO9X+Llvjmok054ATSwTgwY5KBEOrfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hMBuZbPc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05f08adcacso3780846276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721363107; x=1721967907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+NNarvcCPGmC6xaUjCG54gZuwTNt3t3JLl9nhr1UDkw=;
        b=hMBuZbPc4/HV50U5TUMq+Mr2+2V26WD1LqFszTBVpyQdEumhY96Bvb3YIps1z8H7h7
         fzXjBkAjeDKpL28nTYDwwVgrKVVeNR0AJXcN496J7EY2OZkB97t9V3XiEGxtyj7qXhPh
         pqB0X/xygjoggynUi58TLSU2soGn5J6kZDw+hRpakMOZuHW0I7Sl6pdcTvAAzfRXS0+J
         nNdSvu/4H7G0HpNWVrSpMNkEZjylsaciEfL8NX4IfM2fqditR0toXf3WbSITTftu7+HR
         v6VWsw/0P71TrX8yZXalH0l2C9x47f7JCXLcDNsaIp36hm9mki3nx9AysEYRGeQibzey
         NAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721363107; x=1721967907;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+NNarvcCPGmC6xaUjCG54gZuwTNt3t3JLl9nhr1UDkw=;
        b=RH/LEqlozBSKGXqCzyX+m1Vmj8xDCie73CBUK+OfUGnFHdzrBtxnqGiL5oOVKcul3s
         AwOQPIT5JfTW8sHsR3qC0o3XklGzmJHlidGGtq+WrqsgT13Vx1rqTTygD/QsR+WWYz0L
         da2b+sIplq6w7s8p34TYfBSPUdpB7lZf57cr4UXRSxpPglqir/YdUjhmLGWNowTYmsZT
         PYdXp9gDdQjMrNgIeNOXFa6X1tWNRMVBaJgPSP6G8RFGfPLN3E69UQIWW681057gnVKY
         CjFFBlnlLiSvwc8+0JYD+8Rz+WeHLw/m/ficsuEnYI3TUEtlMXp1IGULFMg/bKVYYk3m
         7i0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0kj+pP/LUkLXJnWfSSvC436JIvq7OYByI8EkOMeBIXnAjX1gctzoNvOk9k43PLwwgjB/x6oUUeFpVwMIEp6P/FVUyGGB+hFiaDWoC
X-Gm-Message-State: AOJu0YwjC8MXhGm2SxMkmSxUM09BaxQCH2YWaiWMnp8d57X1KMniYsI5
	Bbqm0fccCWf9Sc9fccnuhI48diHm9CVrFg7VYIg0ocxODnv+srL61RdwqL49u8hA6fQk4nz0XCp
	XYQ==
X-Google-Smtp-Source: AGHT+IE0YSx9HNsiQ/WXGG3ku7Od6DV4r5MXGVHv4m+T1aFzqES6PloIb+AJgOXSlV8hWcPpO1Vu5jk9/MA=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:9f7f:3650:b9e0:5d4b])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:c03:b0:e05:fc91:8935 with SMTP id
 3f1490d57ef6-e05feb62eebmr84080276.3.1721363107223; Thu, 18 Jul 2024 21:25:07
 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:25:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719042503.2752316-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1] mm/hugetlb_vmemmap: don't synchronize_rcu()
 without HVO
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, kernel test robot <oliver.sang@intel.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

hugetlb_vmemmap_optimize_folio() and hugetlb_vmemmap_restore_folio()
are wrappers meant to be called regardless of whether HVO is enabled.
Therefore, they should not call synchronize_rcu(). Otherwise, it
regresses use cases not enabling HVO.

So move synchronize_rcu() to __hugetlb_vmemmap_optimize_folio() and
__hugetlb_vmemmap_restore_folio(), and call it once for each batch of
folios when HVO is enabled.

Fixes: bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407091001.1250ad4a-oliver.sang@intel.com
Reported-by: Janosch Frank <frankja@linux.ibm.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/hugetlb_vmemmap.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 829112b0a914..809ce74bbdfd 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -43,6 +43,8 @@ struct vmemmap_remap_walk {
 #define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
 /* Skip the TLB flush when we remap the PTE */
 #define VMEMMAP_REMAP_NO_TLB_FLUSH	BIT(1)
+/* synchronize_rcu() to avoid writes from page_ref_add_unless() */
+#define VMEMMAP_SYNCHRONIZE_RCU		BIT(2)
 	unsigned long		flags;
 };
 
@@ -460,6 +462,9 @@ static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
 	if (!folio_test_hugetlb_vmemmap_optimized(folio))
 		return 0;
 
+	if (flags & VMEMMAP_SYNCHRONIZE_RCU)
+		synchronize_rcu();
+
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
 	vmemmap_reuse	= vmemmap_start;
 	vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
@@ -492,10 +497,7 @@ static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
  */
 int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio)
 {
-	/* avoid writes from page_ref_add_unless() while unfolding vmemmap */
-	synchronize_rcu();
-
-	return __hugetlb_vmemmap_restore_folio(h, folio, 0);
+	return __hugetlb_vmemmap_restore_folio(h, folio, VMEMMAP_SYNCHRONIZE_RCU);
 }
 
 /**
@@ -518,14 +520,14 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	struct folio *folio, *t_folio;
 	long restored = 0;
 	long ret = 0;
-
-	/* avoid writes from page_ref_add_unless() while unfolding vmemmap */
-	synchronize_rcu();
+	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH | VMEMMAP_SYNCHRONIZE_RCU;
 
 	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			ret = __hugetlb_vmemmap_restore_folio(h, folio,
-							      VMEMMAP_REMAP_NO_TLB_FLUSH);
+			ret = __hugetlb_vmemmap_restore_folio(h, folio, flags);
+			/* only need to synchronize_rcu() once for each batch */
+			flags &= ~VMEMMAP_SYNCHRONIZE_RCU;
+
 			if (ret)
 				break;
 			restored++;
@@ -573,6 +575,9 @@ static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 		return ret;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+
+	if (flags & VMEMMAP_SYNCHRONIZE_RCU)
+		synchronize_rcu();
 	/*
 	 * Very Subtle
 	 * If VMEMMAP_REMAP_NO_TLB_FLUSH is set, TLB flushing is not performed
@@ -620,10 +625,7 @@ void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	/* avoid writes from page_ref_add_unless() while folding vmemmap */
-	synchronize_rcu();
-
-	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, 0);
+	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, VMEMMAP_SYNCHRONIZE_RCU);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -650,6 +652,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 {
 	struct folio *folio;
 	LIST_HEAD(vmemmap_pages);
+	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH | VMEMMAP_SYNCHRONIZE_RCU;
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = hugetlb_vmemmap_split_folio(h, folio);
@@ -666,14 +669,12 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 
 	flush_tlb_all();
 
-	/* avoid writes from page_ref_add_unless() while folding vmemmap */
-	synchronize_rcu();
-
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
 
-		ret = __hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages,
-						       VMEMMAP_REMAP_NO_TLB_FLUSH);
+		ret = __hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, flags);
+		/* only need to synchronize_rcu() once for each batch */
+		flags &= ~VMEMMAP_SYNCHRONIZE_RCU;
 
 		/*
 		 * Pages to be freed may have been accumulated.  If we
@@ -687,8 +688,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
-			__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages,
-							 VMEMMAP_REMAP_NO_TLB_FLUSH);
+			__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, flags);
 		}
 	}
 
-- 
2.45.2.1089.g2a221341d9-goog


