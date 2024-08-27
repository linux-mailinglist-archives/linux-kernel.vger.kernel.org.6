Return-Path: <linux-kernel+bounces-302896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FD99604C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B78E28170E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFC419CD13;
	Tue, 27 Aug 2024 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPyixhA0"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D588199E9A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748368; cv=none; b=NZnqNbqHuKFJETBA1BjieLrhBWCRLnaJbd7Cdc0xmdlG2tWeXP9s/vVRnp3b7R7c4u1wXHPWZYDaGhm01Hrw9qAYYp1YorC4jY6mSvoeB8X56OVPlH3BL5VjsF/88CXU+ss9AmG4D3wtwnkOf8DvOBRvzAYeyZs2uVUjdm4WZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748368; c=relaxed/simple;
	bh=Qr08QM26q8tDe51syMaE8h89/HxW9A0cYqV9q7lV/20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C9Ka4RlEEMrAOw487OdYpnDXJEPGV4yXIFJCbilkmUXJZank08v8JW6MGH9yOSMgOHdVWlIx417RQUc9aj/RwDdRz6L9V2XJv4O0+pqeJfio1GR63rKR1NexLGdv2uBPkpHz0tP1QyUtrQiVoupO2dNMJLoGEFf/WeIjlZBj8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPyixhA0; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-428fc34f41bso48933455e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724748363; x=1725353163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SMXEDoUiwiu4q/DZdkFbUl9+xm4eWjv4+UrgfxPU2W4=;
        b=vPyixhA02UoSiz0QoqBn/ZX2nYCNkeHHsjCjNY1R167fHRzoDVwlrvDArEBD8X977g
         hGLDAaWMukL/a2Lww9yLuNO0mTThvwTergsQqMLRcanWQiEOS6CHduD8rq7/Ry2oqrxI
         jw/JDYCDWAiSDpwO85isOJHIFrwWPLL/Vi5pgkv1ML4hmKD+yIQRQMH0sHArRZijnhqn
         ag9FY2l0D+9P9joJHWsUgNnFUy+toGnlKdOw+EU/jiBs+QT2f/hJ5x7AGzrCLTXDCdr9
         yQIU5Kh8NlRgJpehvhTXnM6RK2/VZqiGsSrwBKyu1veZhWCQ/mBELFYFQtha6JaMksCQ
         YO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748363; x=1725353163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMXEDoUiwiu4q/DZdkFbUl9+xm4eWjv4+UrgfxPU2W4=;
        b=rD3g4Bvh4+SEXofL05FpLHucMkGN/FqyAhUZVNzyFYIoInoyQUukr2RNUMXLEDJbSD
         9qJUjunFuKZ/viBrPgAPs4hLfwH+lhOviDzPlSBrLDrAnduA9tOjnZYfmBowfe3eZUvu
         oQqtNKb7+3AscBwih9ykeOeWoyOI5UMPSvkBv4YNsnmjbslQz50afEAw/5K0NNhghKju
         OeOXDB30qNqbJcSvZ73izEA4sOXnZVfQ/Isg4nMiOxFi5ccmMAakFKnOpJ12zsSwRZtZ
         T5Z9NK8dqDNE3Mg9PnpjfnFiTzZ39DkyG058R4CZP6JDXth3thRzQJp+t5InpYw3ZozW
         8kFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxYIIehTMv4WbXnux8/ws9+L0h/aZOznV0B7wX/S8Z4NO3aiPM+Z99hqlk+oMrTQf0dtkKu9vZeEx85QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOxHnBVx9g4zMy6dalFp8nW/WP8NbTgDaP/SD02o5sfX1ARxeP
	sbAr3QayD26hhia8s7c/hrn/iviEPE8fopDQar83gGO7XNNwHFYn8IJgy91I18ffqMBqaoasGMH
	Pl7PouZ1ab4aOlUP+saePw2p/oQ==
X-Google-Smtp-Source: AGHT+IHY4rt/KDG8jBlRHZVjqb4Z3O2aMXhgahv4zi33s4tbXCpBDS46J6SJnoaHeJNB1+fTQfKkZHV28U+bNgbGPq8=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:3b0f:b0:426:6619:943 with
 SMTP id 5b1f17b1804b1-42b9ae1da4dmr63725e9.3.1724748363256; Tue, 27 Aug 2024
 01:46:03 -0700 (PDT)
Date: Tue, 27 Aug 2024 08:45:45 +0000
In-Reply-To: <20240827084549.45731-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827084549.45731-1-sebastianene@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827084549.45731-3-sebastianene@google.com>
Subject: [PATCH v9 2/5] arm64: ptdump: Expose the attribute parsing functionality
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
2.46.0.295.g3b9ea8a38a-goog


