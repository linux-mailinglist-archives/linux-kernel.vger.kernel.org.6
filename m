Return-Path: <linux-kernel+bounces-235856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA8E91DA77
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0269D1F22C40
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A4414A09D;
	Mon,  1 Jul 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bdGhfYAk"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EFA12C814
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823708; cv=none; b=sWeDExI4xyj4RKzzyMjfDeMzJG2fskMKR0RvfMaRHhv4tpDyzYUpg/mLwZEA5Bk+c4Igkw9D84YYKL+gwwxecH9kTIlFrcA5NqI5RQZb5dSqhUe6CyJTKHuIgXF+Gt8rBUcat45FoORy0wN+2pVztwtEoq2xpbluqqY+Szxqs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823708; c=relaxed/simple;
	bh=UR+gqYf3Ay+0HsLufDqQaYW+u+QXys5JZWosHZe79ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hkn3krky8Zm3yj1EribYKj7lMEAfClqHLRIsxZPQZ8/0muG5PPPkMolRNcXk1Rvjn0o7f7bN8+yDTbpykUBZ8hGszwIZEXBZ96051dDqZqkvp776ZxrDgket5yyH7M39xFcWtoQewoMxh4rxZZjUmjleHePVmBvLKGSOAW4/OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bdGhfYAk; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25cd49906aeso382622fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719823706; x=1720428506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McQK/YxjiDTA99Z+xjg1GpN+1HDVMfpYwsApecFoTmw=;
        b=bdGhfYAk4I27qLqeWqJiB2TMq3MPbJMkfqC9igkU1nBeVH/96tyadSyFIKQwHRKgZb
         owjLFh8OkObdL9IZv35UHgDzYayZhe4Sweh5q+tM3dMIpEe1Av2KXhnjNnaDRZ7gkvz4
         4DaCl1ir2IV68e3oZYHrtQd2VcNjFGKVDFyFtVFDWzsE3FPRwhpUTjiZ2qRykPxjEnu3
         Ogw9i/kT8P33ORL7a4LRTpm4YRr1/WNzQ5Y3Vws9YJDna3ioWI0Pbh1KpNgIfCK70BuI
         3TLF/XX58HDqm0wkAaKc9Dey8BKwmzGrgRj8O+Cu7ER4BTQdX16xzwGiliiJ6Ne95CTL
         ogaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823706; x=1720428506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McQK/YxjiDTA99Z+xjg1GpN+1HDVMfpYwsApecFoTmw=;
        b=GeKOsmBRfah66Plkylas7wT7UNl6LBXiIaRchKv2J1jnOhNIAQdrNCaOtQ69GebPPO
         QvgYcX29NMjDq4iyVxFJpRRzm0X4byYpIuG54MvuqDoTtH3R/eIA08q80UbsZ1ojGCOs
         e4Xeq7L4ey0h1u4+AOrV0k0cCgOD/Xs109xVY1wtkB81rk8cnj2Sq+3w9C1vONzmSezM
         iCR6sb+NQhZQ5BA9I/wXZvymg3Wu9EsJQvhsuBMcTXmMU3W3mqV76agI7ExLdOO41uyV
         cMLBeRgwR6048egYHURkphSQvfspe2TraSLKPKOcsY8eJy81P6VuA6IoZPyxlgl04uZz
         oBlA==
X-Forwarded-Encrypted: i=1; AJvYcCVdpZ9re49Oq6hVIRTTjVHGINvJeXZF+kzvmW335ER6xUR5u7GHbDsmCug6XDaLJTWBC2+YV/cZH+paZg0kZKWvJxKa9U1MjQnfyRXq
X-Gm-Message-State: AOJu0YxEHXNwAsiT0tpflT5yl2HvZ6/aXlJ2zBOhrqOkr9QfkWemd01y
	0JtKVrhmu2Al6lyQsMq2iJfMabxS0kApkf4NjWkG36bNkjs4L7TGzBsImPSNBn8=
X-Google-Smtp-Source: AGHT+IFN2WppGgIQE1/8To548LzmJeYPiitqZmZGxr2Jxr97Tojwrcl4bY6VD5q2UaSwNJF/59bDBA==
X-Received: by 2002:a05:6870:2892:b0:255:1fea:340d with SMTP id 586e51a60fabf-25db3049d93mr5100637fac.0.1719823705877;
        Mon, 01 Jul 2024 01:48:25 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a7e7e0sm5932374b3a.204.2024.07.01.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:48:25 -0700 (PDT)
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
Subject: [RFC PATCH 5/7] x86: mm: free page table pages by RCU instead of semi RCU
Date: Mon,  1 Jul 2024 16:46:46 +0800
Message-Id: <1a27215790293face83242cfd703e910aa0c5ce8.1719570849.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1719570849.git.zhengqi.arch@bytedance.com>
References: <cover.1719570849.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, if CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, the page table pages
will be freed by semi RCU, that is:

 - batch table freeing: asynchronous free by RCU
 - single table freeing: IPI + synchronous free

In this way, the page table can be lockless traversed by disabling IRQ in
paths such as fast GUP. But this is not enough to free the empty PTE page
table pages in paths other that munmap and exit_mmap path, because IPI
cannot be synchronized with rcu_read_lock() in pte_offset_map{_lock}().

In preparation for supporting empty PTE page table pages reclaimation,
let single table also be freed by RCU like batch table freeing. Then we
can also use pte_offset_map() etc to prevent PTE page from being freed.

Like pte_free_defer(), we can also safely use ptdesc->pt_rcu_head to free
the page table pages:

 - The pt_rcu_head is unioned with pt_list and pmd_huge_pte.

 - For pt_list, it is used to manage the PGD page in x86. Fortunately
   tlb_remove_table() will not be used for free PGD pages, so it is safe
   to use pt_rcu_head.

 - For pmd_huge_pte, we will do zap_deposited_table() before freeing the
   PMD page, so it is also safe.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/include/asm/tlb.h | 23 +++++++++++++++++++++++
 arch/x86/kernel/paravirt.c |  7 +++++++
 arch/x86/mm/pgtable.c      |  2 +-
 mm/mmu_gather.c            |  2 +-
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 580636cdc257..9182db1e0264 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -34,4 +34,27 @@ static inline void __tlb_remove_table(void *table)
 	free_page_and_swap_cache(table);
 }
 
+#ifndef CONFIG_PT_RECLAIM
+static inline void __tlb_remove_table_one(void *table)
+{
+	free_page_and_swap_cache(table);
+}
+#else
+static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
+{
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	free_page_and_swap_cache(page);
+}
+
+static inline void __tlb_remove_table_one(void *table)
+{
+	struct page *page;
+
+	page = table;
+	call_rcu(&page->rcu_head, __tlb_remove_table_one_rcu);
+}
+#endif /* CONFIG_PT_RECLAIM */
+
 #endif /* _ASM_X86_TLB_H */
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5358d43886ad..199b9a3813b4 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -60,10 +60,17 @@ void __init native_pv_lock_init(void)
 		static_branch_disable(&virt_spin_lock_key);
 }
 
+#ifndef CONFIG_PT_RECLAIM
 static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
 	tlb_remove_page(tlb, table);
 }
+#else
+static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
+{
+	tlb_remove_table(tlb, table);
+}
+#endif
 
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 93e54ba91fbf..cd5bf2157611 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -18,7 +18,7 @@ EXPORT_SYMBOL(physical_mask);
 #define PGTABLE_HIGHMEM 0
 #endif
 
-#ifndef CONFIG_PARAVIRT
+#if !defined(CONFIG_PARAVIRT) && !defined(CONFIG_PT_RECLAIM)
 static inline
 void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 99b3e9408aa0..1a8f7b8781a2 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -314,7 +314,7 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 static void tlb_remove_table_one(void *table)
 {
 	tlb_remove_table_sync_one();
-	__tlb_remove_table(table);
+	__tlb_remove_table_one(table);
 }
 
 static void tlb_table_flush(struct mmu_gather *tlb)
-- 
2.20.1


