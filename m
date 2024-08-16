Return-Path: <linux-kernel+bounces-289663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EAD9548E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC12286F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A721B3F05;
	Fri, 16 Aug 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZj0Y4Kn"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752741B86C2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811962; cv=none; b=VshpxiIWqIGwZUvxIt+VmTWfJTfY8azLJ9Fqf5Zmn9ul34VuRVc54xb9Yg2t1L/w4RJsHIzaDGkO9zkDuYMKGANxvX4jOzQrA3m8cJC5Ndkr6gDBrG2tJjwFthHt8BpZm8SI83K+Yw0iaLcXOxsolZbQ+4+oNclvHFKBB2KhBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811962; c=relaxed/simple;
	bh=y70w3NBhBN5fs+GL9wdFhOe2sHLvfu6UQ316Ye80lco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FC1bMw8m1SF4BULR2IEyDwPkLdFtR0/kBkKmV1Btx7ZpkSVXzRN41jaJ7YAezINVUWvXGNC8iNVVdVvG8C5Ab5t18pOpkasgbSLPI13QBwFWLcYHFJV9FVOQvCVAFylK+yeVoLj1hAqDTI0+VBta4bg9L3MDOieTzyAwE5EmuZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZj0Y4Kn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4280cf2be19so13549675e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723811959; x=1724416759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j47oMByzJ24KyTFsD9yy6iWyScsZt9QoCMZTVk2qdfo=;
        b=lZj0Y4KnA13bu7VO/KDnThXCSwXAiCotnJ2A221uY74PvWjnVSGuClh9jBxJlTJ4+f
         D/AFv3HcX1snkVo01UxZFZ6WfvVbcX4dSYRQC7gcHg1njDLF4pjiW92rP8RkhQxSHz11
         h1HSAljEMFPBgndj8c8gyeSqUJgAn5IKY+w9R3RPF/oMGi+hEdySrsilcCZ6vt0lEYkE
         Nffsrqy+htuhcJWPOYVHKQQJwHwY5nQnivHnj9Onz/FdeNh9vRwQ+Anc8N/Vfd8vYeRx
         4XLEQbryNubEe7lK6Ws+m4JSAf4eXqkAR9VA+bE96YIQx9saK3v9lJW2XuTL0CU4KaHu
         9CvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811959; x=1724416759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j47oMByzJ24KyTFsD9yy6iWyScsZt9QoCMZTVk2qdfo=;
        b=krjGBEecX37FhwFsel9rJvhLbExkZ2/oCnaKMU/NXTGB4ss1CRj1kOab2cVl504Xgs
         vz99B/y/1Ie6UN5xwrk2+zi6h2P9gTnaHgjkLuzQ+Ba5AkkEYhSjfqp99UAvjS7m9snP
         0ntfpYpBzTH7oeeTVPwhMe1owRn18pAPONI3ZG0AWtq6VliPejK2w19uhm72xvaLZF9a
         K7PXjj4IJ6jF5jA131ZYRG/1KVy433DbecbzjkgFUKOT+aWbwELh4ZfJTJfbtQSjiCW0
         /RJDyMdCp4fTLJRjnIucPs/7/U3t8Bx1oz87ThJyA7zYQ3Og2cB1qQD9GvHZDm8cDxk6
         7VQw==
X-Forwarded-Encrypted: i=1; AJvYcCUDG6w+UBbtoH2I5NrTdY7WZBQTXsphVKqfzOy49kATjSQulNz2PvEFf65pieHHnqDoF0vtzzi6ZNf2SEW2+upWUhoSEUTJZcosgIEM
X-Gm-Message-State: AOJu0YyMiUGG1BNYTqGr0iRHL0PKX9fpnUetYdjfAKFyY/xYkTw3gLgl
	G0pRg8GEBzBH1mOvfrEHS3u8etXuQatBkcFfFHzOx8cY3GvEr0igyUxAmO+7p1cNvpXxNZ/A0Tk
	mSuRP9HKF6RKGtQN6H2HfynFAdw==
X-Google-Smtp-Source: AGHT+IHY+evZi+M0pBKraTT8P2CDheqGUjf1GzHxhiMrm6b9MgqKZzrCDiy/xU7sxesCTtcgx0h+YUSn4Xyp/2hiU3k=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:3b09:b0:429:d0bb:e3f3 with
 SMTP id 5b1f17b1804b1-429ed7e38d2mr149595e9.7.1723811958600; Fri, 16 Aug 2024
 05:39:18 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:39:02 +0000
In-Reply-To: <20240816123906.3683425-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816123906.3683425-1-sebastianene@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240816123906.3683425-3-sebastianene@google.com>
Subject: [PATCH v8 2/6] arm64: ptdump: Expose the attribute parsing functionality
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
2.46.0.184.g6999bdac58-goog


