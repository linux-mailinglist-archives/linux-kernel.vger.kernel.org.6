Return-Path: <linux-kernel+bounces-321378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737D39719D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A131F22706
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE291B81A4;
	Mon,  9 Sep 2024 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2y2wVsf"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8551B86CF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886053; cv=none; b=LS3awr/31U+f2bN70vVCKnc6/EF43GH2PxVKt88DKPUPsMQnNRYj9R63kUvfT+KhHNZeG1VCVTC0C5mF99aBEaYSV/RtHWV+5CPWMM6JE7+ABKC8idZU4uGEhBPbprMVkfmEwfAOS0ZDltDbGzrFScKJpuefV3Qc31lssTsFnn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886053; c=relaxed/simple;
	bh=VgYapO8i1qKDRRRsUo0MTuUblS7PQzfXlK6ZkBqLlsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kfT0urQdqpnH7z8vavQKQ3rtxnZLF5ZmhUaBhNwahkI0UaAlVf5nrtOptkIBQiDV4kpx4aiJRAhME/GlxLl2ZpwJE1oNv9tLcj5egwE+VZXdVh7NUFIkiNnw2FC4sM26cCp1+HCaj/9Xo3AVbxaHyiGAKNBvfWIBGM7ecKkhCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2y2wVsf; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-374b981dd62so2108221f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725886049; x=1726490849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOyTNrjRYeC5V1YoJMilLcLgHHeqHqjXzH9wfdwY9sw=;
        b=e2y2wVsfXgUG62smecUmPZQOn1wigwpwCaBC5qjGE9V/EHSraUY+7Ijr87OIpLsxv4
         XltXV2axxngwuQMAfq5CfKF7q8t02rvDlU59whIgQN9Kra/YHfpuDs0D6VJ0rudEnULC
         43GSzWgRBx75BFyEJqJnt+8zDfZVuOrPwbuA1rqy2yvyVlvG0XJ6d8tHex+E+ozWs+Gz
         gb/nRmgXevm/2cSibQEBjidwGJdgTVIxgQZMGLfSBguflhVwax47EKcbkAj4rHc6u/72
         /quWEGiA8BERRYqhXSM8lJPuptIDH0aHkoMOtxVkizvtkAgrgCafkNDcZao7WI7K6xgw
         ZUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886049; x=1726490849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOyTNrjRYeC5V1YoJMilLcLgHHeqHqjXzH9wfdwY9sw=;
        b=Uwkt4HoP0QngNTzhemqyh6fbdVb5t+aAxKlWgM2/VcPWI91BH3qGcAUmcUr9u+i4Q2
         2b6Ik9vDTNwJlyJh1RVmU5r5aOVB4eADwfWsBq1gn9w59Gw1gf05t8Q1g0xWQdMCHo+v
         fCkvCRPHHohtvv4/o6iTnnCoOpW0FK8Tn1Yc4+9Bdh02MS20ORm7ZSpUVm1fPH4LVnvc
         2BdJ5yl55aY5ZoOz+k+NYEEmZuvfHqWcH80JFaEmBbsLCOBM4m/gtJuM4WVMEmCDOg6Y
         2hfp9oe9SSwbkXx3kDj8V5939WzGvKghwFISdVIS6fV8fhYHD8MfgpMwLrX8ZhbufdZx
         IO3g==
X-Forwarded-Encrypted: i=1; AJvYcCWQv063k6y8Z8ocHDFtxksyKf4sLckAxEu/VrCgrS5wOqfQDL/Ia7UeUr2E3oOL9Sb7Vn1XMBascujGsWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmLgdqZ0l8wUxZ32Rqnc64tencO/q1sOmxQQ/H9l+FesR3lLgm
	sqV9B+DYcI0ic4Xo/IroLqG8slv0gnspqRrFgcZ6ow5eY/g9rJYFssKJJ/4BmqQpZNMHfqMTdrN
	zURTtwGlmHuS6mf5/mYkD7Vj6Hw==
X-Google-Smtp-Source: AGHT+IG+ip5lnTk9ayqB7jP8eGKNbUqkVkAL495AT+0kgCNA1tzshuDCmFE76GVP0BcqGg2a70PypynTTnHwd3R29A0=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f1b7])
 (user=sebastianene job=sendgmr) by 2002:a05:6000:1281:b0:374:cad2:a75e with
 SMTP id ffacd0b85a97d-378895c2527mr13872f8f.1.1725886049120; Mon, 09 Sep 2024
 05:47:29 -0700 (PDT)
Date: Mon,  9 Sep 2024 12:47:18 +0000
In-Reply-To: <20240909124721.1672199-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240909124721.1672199-1-sebastianene@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240909124721.1672199-3-sebastianene@google.com>
Subject: [PATCH v10 2/5] arm64: ptdump: Expose the attribute parsing functionality
From: Sebastian Ene <sebastianene@google.com>
To: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com, 
	ardb@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, 
	james.morse@arm.com, vdonnefort@google.com, mark.rutland@arm.com, 
	maz@kernel.org, oliver.upton@linux.dev, rananta@google.com, 
	ryan.roberts@arm.com, sebastianene@google.com, shahuang@redhat.com, 
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Reuse the descriptor parsing functionality to keep the same output format
as the original ptdump code. In order for this to happen, move the state
tracking objects into a common header.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h | 41 +++++++++++++++++++++++-
 arch/arm64/mm/ptdump.c          | 55 +++++++--------------------------
 2 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 5b1701c76d1c..bd5d3ee3e8dc 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -9,6 +9,7 @@
 
 #include <linux/mm_types.h>
 #include <linux/seq_file.h>
+#include <linux/ptdump.h>
 
 struct addr_marker {
 	unsigned long start_address;
@@ -21,14 +22,52 @@ struct ptdump_info {
 	unsigned long			base_addr;
 };
 
+struct ptdump_prot_bits {
+	u64		mask;
+	u64		val;
+	const char	*set;
+	const char	*clear;
+};
+
+struct ptdump_pg_level {
+	const struct ptdump_prot_bits *bits;
+	char name[4];
+	int num;
+	u64 mask;
+};
+
+/*
+ * The page dumper groups page table entries of the same type into a single
+ * description. It uses pg_state to track the range information while
+ * iterating over the pte entries. When the continuity is broken it then
+ * dumps out a description of the range.
+ */
+struct ptdump_pg_state {
+	struct ptdump_state ptdump;
+	struct seq_file *seq;
+	const struct addr_marker *marker;
+	const struct mm_struct *mm;
+	unsigned long start_address;
+	int level;
+	u64 current_prot;
+	bool check_wx;
+	unsigned long wx_pages;
+	unsigned long uxn_pages;
+};
+
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
+void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
+	       u64 val);
 #ifdef CONFIG_PTDUMP_DEBUGFS
 #define EFI_RUNTIME_MAP_END	DEFAULT_MAP_WINDOW_64
 void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
 #else
 static inline void ptdump_debugfs_register(struct ptdump_info *info,
 					   const char *name) { }
-#endif
+#endif /* CONFIG_PTDUMP_DEBUGFS */
+#else
+static inline void note_page(void *pt_st, unsigned long addr,
+			     int level, u64 val) { }
 #endif /* CONFIG_PTDUMP_CORE */
 
 #endif /* __ASM_PTDUMP_H */
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 6986827e0d64..404751fd30fe 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -38,33 +38,7 @@
 		seq_printf(m, fmt);	\
 })
 
-/*
- * The page dumper groups page table entries of the same type into a single
- * description. It uses pg_state to track the range information while
- * iterating over the pte entries. When the continuity is broken it then
- * dumps out a description of the range.
- */
-struct pg_state {
-	struct ptdump_state ptdump;
-	struct seq_file *seq;
-	const struct addr_marker *marker;
-	const struct mm_struct *mm;
-	unsigned long start_address;
-	int level;
-	u64 current_prot;
-	bool check_wx;
-	unsigned long wx_pages;
-	unsigned long uxn_pages;
-};
-
-struct prot_bits {
-	u64		mask;
-	u64		val;
-	const char	*set;
-	const char	*clear;
-};
-
-static const struct prot_bits pte_bits[] = {
+static const struct ptdump_prot_bits pte_bits[] = {
 	{
 		.mask	= PTE_VALID,
 		.val	= PTE_VALID,
@@ -143,14 +117,7 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
-struct pg_level {
-	const struct prot_bits *bits;
-	char name[4];
-	int num;
-	u64 mask;
-};
-
-static struct pg_level pg_level[] __ro_after_init = {
+static struct ptdump_pg_level pg_level[] __ro_after_init = {
 	{ /* pgd */
 		.name	= "PGD",
 		.bits	= pte_bits,
@@ -174,7 +141,7 @@ static struct pg_level pg_level[] __ro_after_init = {
 	},
 };
 
-static void dump_prot(struct pg_state *st, const struct prot_bits *bits,
+static void dump_prot(struct ptdump_pg_state *st, const struct ptdump_prot_bits *bits,
 			size_t num)
 {
 	unsigned i;
@@ -192,7 +159,7 @@ static void dump_prot(struct pg_state *st, const struct prot_bits *bits,
 	}
 }
 
-static void note_prot_uxn(struct pg_state *st, unsigned long addr)
+static void note_prot_uxn(struct ptdump_pg_state *st, unsigned long addr)
 {
 	if (!st->check_wx)
 		return;
@@ -206,7 +173,7 @@ static void note_prot_uxn(struct pg_state *st, unsigned long addr)
 	st->uxn_pages += (addr - st->start_address) / PAGE_SIZE;
 }
 
-static void note_prot_wx(struct pg_state *st, unsigned long addr)
+static void note_prot_wx(struct ptdump_pg_state *st, unsigned long addr)
 {
 	if (!st->check_wx)
 		return;
@@ -221,10 +188,10 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
 }
 
-static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
-		      u64 val)
+void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
+	       u64 val)
 {
-	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
+	struct ptdump_pg_state *st = container_of(pt_st, struct ptdump_pg_state, ptdump);
 	static const char units[] = "KMGTPE";
 	u64 prot = 0;
 
@@ -286,12 +253,12 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 {
 	unsigned long end = ~0UL;
-	struct pg_state st;
+	struct ptdump_pg_state st;
 
 	if (info->base_addr < TASK_SIZE_64)
 		end = TASK_SIZE_64;
 
-	st = (struct pg_state){
+	st = (struct ptdump_pg_state){
 		.seq = s,
 		.marker = info->markers,
 		.mm = info->mm,
@@ -324,7 +291,7 @@ static struct ptdump_info kernel_ptdump_info __ro_after_init = {
 
 bool ptdump_check_wx(void)
 {
-	struct pg_state st = {
+	struct ptdump_pg_state st = {
 		.seq = NULL,
 		.marker = (struct addr_marker[]) {
 			{ 0, NULL},
-- 
2.46.0.469.g59c65b2a67-goog


