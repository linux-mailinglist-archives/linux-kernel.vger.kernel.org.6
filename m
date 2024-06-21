Return-Path: <linux-kernel+bounces-224655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87799912567
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E65828141F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673A115534E;
	Fri, 21 Jun 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAVzoT2t"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A1F154BFE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973164; cv=none; b=bt17U0znEP5NE6ARJd9LTG2MdF3SN9G8PelpBu8CKgZnTKxwvklDNPpf4hI/VJeHxhHs7H13GEgNvfKgDjLfzMko5EZty5jkIxp8DZBSXUnLAA1fJL9TKoUVhNtjI1pb/fQ0EWNomyQDdvQ+dkYUZN4hpiUCgBUlkRVQogxEj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973164; c=relaxed/simple;
	bh=aaHqMZaKmKl+99lxeCDfmjo1TD3ti8HIan82O3ewXag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DgZ8a/nKnZBF7WRXzv2JfP9nFt7jg1XzDeH6qr6ObYoKfCw21DTtYKhGKVE6YRtpqO15IQ7HDeYFSsyY0rTtVn2jq5DoieOj53vJoUYaX6jPy66QUHq1t+ZwUKvpxRVtAwR4MEk8vrYK9BCwvSil/kxo96GFttdAugUuafOAnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wAVzoT2t; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfeff1ae480so3326336276.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718973162; x=1719577962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EzGBq5ThBYn0maeOuexDoW9RxvarTIzzo7wMG3lfRiU=;
        b=wAVzoT2tZWndW6xM9mkoVb4SYPY455J+rAqm4HcuYVjAsedcJyMJu8UhRyayoJi7rN
         cuQbnoS5tYZuvd7pUZY8s0NW0fFGIJ1nMyNROSdYaeJ0esHq7uC92OpYeTStHmUfnMy/
         dXPOsGzglfAQvyLbxvg4rs8cz0o8VEmOsGLBBDFunHNkaeV02vGBy+nluM2GedueZN8N
         nTF80+OnvMkpBr4Mpk01WGEV29wPWiGqyi12G3FSMkdfMmtpfqxo45Nj3NabV3j4QLG4
         TfG7om5U/cDoPT++znB3gW2zFjTwmdgH9Aj+2W4rGBero+pQ2rMmz7oBSPR1jWAZH0FW
         0iRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718973162; x=1719577962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzGBq5ThBYn0maeOuexDoW9RxvarTIzzo7wMG3lfRiU=;
        b=UCQAPn7+2s1OrddXLMi/GJSoRm7bbotvnM/Z8/mStyqzrYJMWce6EP5Tnlvp1SoHxJ
         Ggmt877Puui/bZ0BlICyKntU6s+tW9rQBgga0W4WKcyeb7cndlW+vTXgKRhkwyt1pIIK
         xrebjJpLkCcQY6+dE0h1Sd2AaCNv5GRT95h1rbjg3jYny5cZQTslA74OyotVPcARQXJ4
         PllVZqMXiwGoa/OvtjHJvVsPsairJo6sRViUk5nYbPLaJIsgpH/xT1cFXo1/cF2xRq2l
         Mm5Q7e5Gse7UKKxaxZZvjqq4V9I0KzNvgA16/MPjCIDQ0Aj82PvbtyE1A+sMIepxHMpX
         eyJA==
X-Forwarded-Encrypted: i=1; AJvYcCWf2VZ9MhWHp8YV2gyl5DQFsimRBxmo0jnSMDlEoUBYbMn/oxRYpCDCJik5lddjhhoLrUTKNdUZaR/ZYi2hem40itjNetAdlZHy3dCx
X-Gm-Message-State: AOJu0YwbRDWMej66PqUD96IPqwaPIXTKPa+faI/h2sCOEweCnzz76fv8
	BMi1KiuA4/gwQz9cXkyQL2Moo9sJChUUuDCymWi0lRGgEYSqRUaNT/Ozp4k2PAWGwd25zLJssit
	bkyNtTfCyXsSWEYXD1XysZFcEqA==
X-Google-Smtp-Source: AGHT+IEHWLyl6fNJBxDvAZcuJW3n20nBcPn6CejMK+alB517jSqTAiCeKZNxc0fP6fdgpnKzvHbq34eXpiFJ6ppcopE=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a25:943:0:b0:dff:2f78:a5d7 with SMTP
 id 3f1490d57ef6-e02be130582mr1340535276.5.1718973162032; Fri, 21 Jun 2024
 05:32:42 -0700 (PDT)
Date: Fri, 21 Jun 2024 12:32:26 +0000
In-Reply-To: <20240621123230.1085265-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621123230.1085265-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240621123230.1085265-3-sebastianene@google.com>
Subject: [PATCH v7 2/6] arm64: ptdump: Expose the attribute parsing functionality
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
 arch/arm64/include/asm/ptdump.h | 41 ++++++++++++++++++++++++++++++++-
 arch/arm64/mm/ptdump.c          | 37 ++---------------------------
 2 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 5b1701c76d1c..c550b2afcab7 100644
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
 
+struct prot_bits {
+	u64		mask;
+	u64		val;
+	const char	*set;
+	const char	*clear;
+};
+
+struct pg_level {
+	const struct prot_bits *bits;
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
+struct pg_state {
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
index 6986827e0d64..e370b7a945de 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -38,32 +38,6 @@
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
 static const struct prot_bits pte_bits[] = {
 	{
 		.mask	= PTE_VALID,
@@ -143,13 +117,6 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
-struct pg_level {
-	const struct prot_bits *bits;
-	char name[4];
-	int num;
-	u64 mask;
-};
-
 static struct pg_level pg_level[] __ro_after_init = {
 	{ /* pgd */
 		.name	= "PGD",
@@ -221,8 +188,8 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
 }
 
-static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
-		      u64 val)
+void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
+	       u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 	static const char units[] = "KMGTPE";
-- 
2.45.2.741.gdbec12cfda-goog


