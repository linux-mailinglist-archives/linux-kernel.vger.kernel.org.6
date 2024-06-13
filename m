Return-Path: <linux-kernel+bounces-212847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F60906732
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907E628275F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2871411DA;
	Thu, 13 Jun 2024 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CoduOCp8"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F27D1411E0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267957; cv=none; b=bJqcB60fzpi7zlWfcejibdrNr+RdRncVidWlgAtcQ2Y8CnB8Vr74GrSIA5nTki4GJlhZdar7Pb5MQe+ALBQYlkPkcuS7Yp7E8fBq8FlKhxpJPcAgE02SSLomtTrmQK8MKWqOg9se1akTWSvxZDgrzAiY3Wjn1uXWip35M+uwIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267957; c=relaxed/simple;
	bh=xdE94GfqCYx2aEuVmfPuT2Y5YFCBjfjEEQZ9wkLA5M4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+l/D7k6DbM/QXWLc6Sxf+CReCNqrDvVyEzygZbZol3ZmIkbFOZjxeeoP/FvhzdjCyc1OOatYfSkJQ8LCMu88gEfN9HrruFOoOGYCU5Qxo5xV/ZKKJKyXbYFsaO6bgzMcSKt79sL8Qm08X4nldTRxxzXLZZVQ9mBhRrMGbOvAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CoduOCp8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6f2eecba617so35540a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718267955; x=1718872755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5Cg5Bw8hj6kh0AKq+CP9F+WzciGspxa+25MjItj/4s=;
        b=CoduOCp8IxojeaHXANppP6BFGfP8ETKuJuaTNr/a5TQ/zS2w/umrHzNX0Of10NqP3Z
         iaBxt/H/96K9xWgUgNsbZ2mi9x66PDji2Ss1OzIwyaniVoABHrCytMKcCyMBlnPSeDqa
         MfSMlDuV/dQPjkPhpdDDYYt3x0/4pPmDr3l8umsm1hjfm20mqatMvyEyKHO/qd5tv6aA
         VjM8IotrqO5Y5ukoXkEvQvDWvfbi+4vOqHQ0TUOzQOAsxEamzYJQzYFwqjzO/TpfS1YO
         njM/+BDM4yNdnYC6FEHKW5iXCcRvK0EVZuRgOxY/YnKyLNTtFcMHtO+Sf5zWYZDJtdnv
         q03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267955; x=1718872755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5Cg5Bw8hj6kh0AKq+CP9F+WzciGspxa+25MjItj/4s=;
        b=rtpvTnc/5jQsHwAWq16H4WYL2zrb9BaLXFE8haquMFjIRPlh6rpI6Km0mpfuKDWzuV
         VCxqqH89YwnwDFyLGbxfkoY4ZlVBngRLMV3+pRrDD2AClvlpvXzEitRWL+UOzZZlPpKq
         reW9FMxYsY048e1tNm/Z0tZcKt+MjAH7iOfYogqlWkCILK6a34LDZPDjYcWnbYYyuZvY
         QNgLXQ1gyNlVmIJTKWUsE+0zieLBX64wk1epGrX+6Outikwf/ra5U+uwqU9N43tItiw9
         fB0kUnzxncTZ/YA+NRUpCOO+XjOWbETKHtfjmAsqQfiUk3eIldGiat2zLSQl4UQlJr2v
         kgzA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Z2oNyu8M0mnIz9PdpfTxQYQeBhPICy8TcW6MwsDqSfH8ADj3ypU7xk4SiArIbSmPNNIR/+g/Lz3gMLPABS9+9sZAPF8MJh6CyPZG
X-Gm-Message-State: AOJu0YwDRvq3qLSukdiNujxBY2z35U/3/CZ9XJ/LFjp0+JSKorkrl/Sm
	kFckGc/SnDpZQvu////w1TxUHRMh+z1tCiKNHrB2WOjamdf9bZRZgLNX3G/BoaI=
X-Google-Smtp-Source: AGHT+IFkPIn1Dv10c/sdgT1s4Zy3CxP/93/DlvxiYc4NUJmFcAF7R4ScSAp8hM8C7UzSnp9lmTxVHg==
X-Received: by 2002:a05:6a20:da89:b0:1b4:4ed4:91f5 with SMTP id adf61e73a8af0-1b8ab6ab543mr4962426637.6.1718267954815;
        Thu, 13 Jun 2024 01:39:14 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb980bdsm820856b3a.211.2024.06.13.01.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:39:14 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 1/3] mm: pgtable: move pte_free_defer() out of CONFIG_TRANSPARENT_HUGEPAGE
Date: Thu, 13 Jun 2024 16:38:08 +0800
Message-Id: <7864fd8186075ae12fd227f13f4191f3d1bc6764.1718267194.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1718267194.git.zhengqi.arch@bytedance.com>
References: <cover.1718267194.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to reuse the pte_free_defer() in the subsequent work of freeing
empty user PTE pages, move it out of the CONFIG_TRANSPARENT_HUGEPAGE
range.

No functional change intended.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/powerpc/mm/pgtable-frag.c | 2 --
 arch/s390/mm/pgalloc.c         | 2 --
 arch/sparc/mm/init_64.c        | 2 +-
 mm/pgtable-generic.c           | 2 +-
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index 8c31802f97e8..46d8f4bec85e 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -133,7 +133,6 @@ void pte_fragment_free(unsigned long *table, int kernel)
 	}
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 {
 	struct page *page;
@@ -142,4 +141,3 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 	SetPageActive(page);
 	pte_fragment_free((unsigned long *)pgtable, 0);
 }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index abb629d7e131..6415379bd3fd 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -204,7 +204,6 @@ void __tlb_remove_table(void *table)
 	pagetable_pte_dtor_free(ptdesc);
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void pte_free_now(struct rcu_head *head)
 {
 	struct ptdesc *ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
@@ -223,7 +222,6 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 	 */
 	WARN_ON_ONCE(mm_has_pgste(mm));
 }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /*
  * Base infrastructure required to generate basic asces, region, segment,
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 53d7cb5bbffe..20aaf123c9fc 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2939,7 +2939,6 @@ void pgtable_free(void *table, bool is_page)
 		kmem_cache_free(pgtable_cache, table);
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void pte_free_now(struct rcu_head *head)
 {
 	struct page *page;
@@ -2956,6 +2955,7 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 	call_rcu(&page->rcu_head, pte_free_now);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 			  pmd_t *pmd)
 {
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index a78a4adf711a..197937495a0a 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -233,6 +233,7 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 	return pmd;
 }
 #endif
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /* arch define pte_free_defer in asm/pgalloc.h for its own implementation */
 #ifndef pte_free_defer
@@ -252,7 +253,6 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 	call_rcu(&page->rcu_head, pte_free_now);
 }
 #endif /* pte_free_defer */
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #if defined(CONFIG_GUP_GET_PXX_LOW_HIGH) && \
 	(defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RCU))
-- 
2.20.1


