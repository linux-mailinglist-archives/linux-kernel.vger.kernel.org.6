Return-Path: <linux-kernel+bounces-373619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E809A5975
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8181F223C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B749A1CFEDE;
	Mon, 21 Oct 2024 04:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPeG/E48"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE061CF7B6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729484550; cv=none; b=ZQPMTQJ0QJx/qZNsERV04zyu60RK6g5dMFZZ/raurjjsbfjEduAsurFh3I7SDsVgb6SsvFrpgk8W7ExQAPJKMmz7dN66RNqmtmt10EJYlpfscG14EREDphEtB5mDqxptsCHAAqzH7GsUD5rbKrzgyK3ZD6PaAmJAsBDyWHIb/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729484550; c=relaxed/simple;
	bh=q1CirfEE+g7TLW2THus/ysy93zvYFU3FA3njHvBj4WM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e0vFCQWPFpd1kWkq+Uibbm1UzDbTJDgM834igwOhmGz4K4O65dckF30D8Bmftk7h+qrE5MDiCct3T+5PNnkKXkpOvCS4oDCzv78WR6fFDvFiZGbyvnnAtWkBgbgNq5y82pHHQfH/GNVd8p3yqkejHtBp3lzgW04PxSmdHNeRyMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPeG/E48; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e36cfed818so57449237b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 21:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729484548; x=1730089348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQVfzlUfyOXzQNiM6rrgf1IxWXC/TuVQ/9/mg1gNSUk=;
        b=iPeG/E48pt9aXKx/m25EdLFsGMhBJL50WiJDxePUKZuXdKE3sYhwRHxZ3wlA9nBhx3
         RRavlR6cn3mJfsQ/G8V4HNdSN+QBUOhAy2UAmyW7w6gpI42hpm2+7grvo4pMxaBOJwAF
         qOJ8AMHMsheSDyzvBWnhP1oiZBD4wQktMPPkkzzLy+lDAMOYSZ6Q4nVTCJtIgHvxTDtR
         UHN/CYIRFTg2kWZn3/bAGboRNFLAxjCKjoSycJvsNQILMKyXY0wRPzW9iZG3gZvf8T6J
         V2oy/Hq18K4H7GBG5x+86v9vDvUi45FcNallzZQ76VcdubTauTixxK4gYnuhyx7AoPOr
         cvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729484548; x=1730089348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQVfzlUfyOXzQNiM6rrgf1IxWXC/TuVQ/9/mg1gNSUk=;
        b=gwliLN6Ql2M3dU3WP/za2O3VK4VIyYzscUpymbp0Ue1DNnJIUdxeNi5Cpytjj1Boik
         FKN+LEk+CeBmASBj2ZrOTp+9wpD6EkqJN5loIRpv+d1iIlmS2pv4Hh4BTVGiSEkT/YR8
         vpc6zS+1MTXPP5KegDX1JhWeqzt9kev6aKpRL6DmxtYdg2GFmwEpiXMn4btIvFqHo1zl
         +CXhQ9hWOo3oqUo0sZll9a0Bi2oSzab3oDg1QyU90jUcRzaRKNSM30iZInrB8v1NOLbh
         9O8esgCW3GEKtOIykZB2qFra66IPu5nz4tvlvjpEhDNMBaAJg/lmDgXjScUZF5zkzY4E
         gNtw==
X-Forwarded-Encrypted: i=1; AJvYcCUea0p1icJtifmsXkXvbMbxeO3kPksTACpf9QFBhhARdb6CdmfzwGQEE3z1lNjS3L0h7jl1V2R6BBAw2jA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6X77t8f980kZEy6St/Yg61hUqA7zeKQlIxhIQSj0ZiYpgy9v
	ALbyimgOKBesWbSf3uKGfIPGHdRYslJbgWPmE9UWb5tX04TjOlm99TUGeQfuABMaqEWaV13B5Gs
	Yww==
X-Google-Smtp-Source: AGHT+IFa+RAhMnCTBGawKhIBMzr1i4wNva1osbWPtOgVISCaAsioJIQoe2S7YEzQTgFhpJ04zIjZfcK8uDQ=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:1569:9ef4:20ab:abf9])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:6383:b0:663:ddc1:eab8 with SMTP id
 00721157ae682-6e5bfbeb2e0mr2568607b3.4.1729484547736; Sun, 20 Oct 2024
 21:22:27 -0700 (PDT)
Date: Sun, 20 Oct 2024 22:22:14 -0600
In-Reply-To: <20241021042218.746659-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021042218.746659-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241021042218.746659-3-yuzhao@google.com>
Subject: [PATCH v1 2/6] mm/hugetlb_vmemmap: add arch-independent helpers
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>, Mark Rutland <mark.rutland@arm.com>, 
	Nanyong Sun <sunnanyong@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Add architecture-independent helpers to allow individual architectures
to work around their own limitations when updating vmemmap.

Specifically, the current remap workflow requires break-before-make
(BBM) on arm64. By overriding the default helpers later in this
series, arm64 will be able to support the current HVO implementation.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_types.h |  7 +++
 mm/hugetlb_vmemmap.c     | 99 ++++++++++++++++++++++++++++++++++------
 2 files changed, 92 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8e38bc..0f3ae6e173f6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1499,4 +1499,11 @@ enum {
 	/* See also internal only FOLL flags in mm/internal.h */
 };
 
+/* Skip the TLB flush when we split the PMD */
+#define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+/* Skip the TLB flush when we remap the PTE */
+#define VMEMMAP_REMAP_NO_TLB_FLUSH	BIT(1)
+/* synchronize_rcu() to avoid writes from page_ref_add_unless() */
+#define VMEMMAP_SYNCHRONIZE_RCU		BIT(2)
+
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 46befab48d41..e50a196399f5 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -38,16 +38,56 @@ struct vmemmap_remap_walk {
 	struct page		*reuse_page;
 	unsigned long		reuse_addr;
 	struct list_head	*vmemmap_pages;
-
-/* Skip the TLB flush when we split the PMD */
-#define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
-/* Skip the TLB flush when we remap the PTE */
-#define VMEMMAP_REMAP_NO_TLB_FLUSH	BIT(1)
-/* synchronize_rcu() to avoid writes from page_ref_add_unless() */
-#define VMEMMAP_SYNCHRONIZE_RCU		BIT(2)
 	unsigned long		flags;
 };
 
+#ifndef VMEMMAP_ARCH_TLB_FLUSH_FLAGS
+#define VMEMMAP_ARCH_TLB_FLUSH_FLAGS 0
+#endif
+
+#ifndef vmemmap_update_supported
+static bool vmemmap_update_supported(void)
+{
+	return true;
+}
+#endif
+
+#ifndef vmemmap_update_lock
+static void vmemmap_update_lock(void)
+{
+}
+#endif
+
+#ifndef vmemmap_update_unlock
+static void vmemmap_update_unlock(void)
+{
+}
+#endif
+
+#ifndef vmemmap_update_pte_range_start
+static void vmemmap_update_pte_range_start(pte_t *pte, unsigned long start, unsigned long end)
+{
+}
+#endif
+
+#ifndef vmemmap_update_pte_range_end
+static void vmemmap_update_pte_range_end(void)
+{
+}
+#endif
+
+#ifndef vmemmap_update_pmd_range_start
+static void vmemmap_update_pmd_range_start(pmd_t *pmd, unsigned long start, unsigned long end)
+{
+}
+#endif
+
+#ifndef vmemmap_update_pmd_range_end
+static void vmemmap_update_pmd_range_end(void)
+{
+}
+#endif
+
 static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 			     struct vmemmap_remap_walk *walk)
 {
@@ -83,7 +123,9 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
+		vmemmap_update_pmd_range_start(pmd, start, start + PMD_SIZE);
 		pmd_populate_kernel(&init_mm, pmd, pgtable);
+		vmemmap_update_pmd_range_end();
 		if (!(walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH))
 			flush_tlb_kernel_range(start, start + PMD_SIZE);
 	} else {
@@ -164,10 +206,12 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 
 	VM_BUG_ON(!PAGE_ALIGNED(start | end));
 
+	vmemmap_update_lock();
 	mmap_read_lock(&init_mm);
 	ret = walk_page_range_novma(&init_mm, start, end, &vmemmap_remap_ops,
 				    NULL, walk);
 	mmap_read_unlock(&init_mm);
+	vmemmap_update_unlock();
 	if (ret)
 		return ret;
 
@@ -228,6 +272,8 @@ static void vmemmap_remap_pte_range(pte_t *pte, unsigned long start, unsigned lo
 		smp_wmb();
 	}
 
+	vmemmap_update_pte_range_start(pte, start, end);
+
 	for (i = 0; i < nr_pages; i++) {
 		pte_t val;
 
@@ -242,6 +288,8 @@ static void vmemmap_remap_pte_range(pte_t *pte, unsigned long start, unsigned lo
 
 		set_pte_at(&init_mm, start + PAGE_SIZE * i, pte + i, val);
 	}
+
+	vmemmap_update_pte_range_end();
 }
 
 /*
@@ -287,6 +335,8 @@ static void vmemmap_restore_pte_range(pte_t *pte, unsigned long start, unsigned
 	 */
 	smp_wmb();
 
+	vmemmap_update_pte_range_start(pte, start, end);
+
 	for (i = 0; i < nr_pages; i++) {
 		pte_t val;
 
@@ -296,6 +346,8 @@ static void vmemmap_restore_pte_range(pte_t *pte, unsigned long start, unsigned
 		val = mk_pte(page, PAGE_KERNEL);
 		set_pte_at(&init_mm, start + PAGE_SIZE * i, pte + i, val);
 	}
+
+	vmemmap_update_pte_range_end();
 }
 
 /**
@@ -513,7 +565,8 @@ static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
  */
 int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio)
 {
-	return __hugetlb_vmemmap_restore_folio(h, folio, VMEMMAP_SYNCHRONIZE_RCU);
+	return __hugetlb_vmemmap_restore_folio(h, folio,
+			VMEMMAP_SYNCHRONIZE_RCU | VMEMMAP_ARCH_TLB_FLUSH_FLAGS);
 }
 
 /**
@@ -553,7 +606,7 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 		list_move(&folio->lru, non_hvo_folios);
 	}
 
-	if (restored)
+	if (restored && !(VMEMMAP_ARCH_TLB_FLUSH_FLAGS & VMEMMAP_REMAP_NO_TLB_FLUSH))
 		flush_tlb_all();
 	if (!ret)
 		ret = restored;
@@ -641,7 +694,8 @@ void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, VMEMMAP_SYNCHRONIZE_RCU);
+	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages,
+			VMEMMAP_SYNCHRONIZE_RCU | VMEMMAP_ARCH_TLB_FLUSH_FLAGS);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -683,7 +737,8 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			break;
 	}
 
-	flush_tlb_all();
+	if (!(VMEMMAP_ARCH_TLB_FLUSH_FLAGS & VMEMMAP_SPLIT_NO_TLB_FLUSH))
+		flush_tlb_all();
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
@@ -701,24 +756,35 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 		 * allowing more vmemmap remaps to occur.
 		 */
 		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
-			flush_tlb_all();
+			if (!(VMEMMAP_ARCH_TLB_FLUSH_FLAGS & VMEMMAP_REMAP_NO_TLB_FLUSH))
+				flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
 			__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, flags);
 		}
 	}
 
-	flush_tlb_all();
+	if (!(VMEMMAP_ARCH_TLB_FLUSH_FLAGS & VMEMMAP_REMAP_NO_TLB_FLUSH))
+		flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
+static int hugetlb_vmemmap_sysctl(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (!vmemmap_update_supported())
+		return -ENODEV;
+
+	return proc_dobool(ctl, write, buffer, lenp, ppos);
+}
+
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
 		.procname	= "hugetlb_optimize_vmemmap",
 		.data		= &vmemmap_optimize_enabled,
 		.maxlen		= sizeof(vmemmap_optimize_enabled),
 		.mode		= 0644,
-		.proc_handler	= proc_dobool,
+		.proc_handler	= hugetlb_vmemmap_sysctl,
 	},
 };
 
@@ -729,6 +795,11 @@ static int __init hugetlb_vmemmap_init(void)
 	/* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct pages */
 	BUILD_BUG_ON(__NR_USED_SUBPAGE > HUGETLB_VMEMMAP_RESERVE_PAGES);
 
+	if (READ_ONCE(vmemmap_optimize_enabled) && !vmemmap_update_supported()) {
+		pr_warn("HugeTLB: disabling HVO due to missing support.\n");
+		WRITE_ONCE(vmemmap_optimize_enabled, false);
+	}
+
 	for_each_hstate(h) {
 		if (hugetlb_vmemmap_optimizable(h)) {
 			register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
-- 
2.47.0.rc1.288.g06298d1525-goog


