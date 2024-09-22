Return-Path: <linux-kernel+bounces-335139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1689297E19E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C601F212DE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899DA4A15;
	Sun, 22 Sep 2024 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNDHxiVn"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074433E1
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727009204; cv=none; b=lLmyrG640TgckePR3xcRh1M+5G4Vji66QqoAxrd6yAGS9Ht0XHbNamH12Bccxp6zJfJDfhIxeGkkvok3Lux71BaixFPerygV7wydFfoJ6SC7uAxz6wy5s6a8BjNCZzvEjTXG4yJuT1sbJo/Jn8nLPPiZIQfTu3azrG3NoL9/GUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727009204; c=relaxed/simple;
	bh=8ePD+2m1CM3zdKo4/0z1aKBWmtRs1LNpXPlC45ftoYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i92Vr2hxwvlgm9AZCGqkgXuU0Le5uz1+K4Xw2+Lig87QHgS9fTILLS1RCsh5Tfd1PNs/Uocw9rbpqK8D/SID+92GjnCrv/A8axZxf3frS6dKcXLyRguAdSw2Hi2gYEenprRNPY8lwNVxLEyj05iGKXd9fZeBbtf/VIlxihSi1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNDHxiVn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2054e22ce3fso34061265ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727009203; x=1727614003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FTwL6+9o13ypVh56/VhhZXYdy2Ls+PjrT2/i5xc+EE=;
        b=TNDHxiVn6W57QbWCniTLcYHvkJUa4zZ+HQdzlTpcKiQbb6kskijt23PFWriuFhYc5I
         yQbzBHT0SU3HTi0uGBP5xBSfq2ScnsFBJ9oeuo85vkOfu5pQxkdRaiggc88k4JGBRL1d
         +dC+wFuRFQ+4Ik34iszV/oBwlOoWtOOLmsvrcc0WEFM+2ktCzajKfJyaLI71SRtntL/S
         H4L1p8HAJyODrsGVV9M2r+1zFqsxBCaPdIwxtOiNPQio98zEYfIw+KODGKigkIxFjX9s
         jdiWkt/xKILzDVt9VunfOoq5YZBx9ZywDO9Ld6AObOdysFMcbtlsVKbqUVPchfsFMZD1
         kaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727009203; x=1727614003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FTwL6+9o13ypVh56/VhhZXYdy2Ls+PjrT2/i5xc+EE=;
        b=DkqP7WbAM7Lh/y44xNJNID+89CBEQ9oplwXkWQpeSeRsgNSPsJR9M9mAd+4diw2j0z
         Mu7ok2ODfD1nC3Tpa9BKeQW3HlHolxCug0/x1hatk2wJ/oOjq9R6hMMR6M0zYTzfobA7
         qkUwWch/Vklt+ALoDQTVdwmCYV4Py0LvtA9Gzig83n+1vutOx7cgzNKAs6G5VWyEY2/L
         U5ftpt60j9XeRbpGeVV7PqHhuo1kpXW4Ng00w+kdgpM7EEF2FdJwOn1kimQMlpFB45mv
         XkmJNP8juyi57H3iTNebfIRqqTGPi0bRRXypCFroKVdUcI2cLJ7Ytx7YlkbvyBfLlZa2
         I2Eg==
X-Forwarded-Encrypted: i=1; AJvYcCW3xZJmNBF7KkbV5SFHoqEzI6N9LBrlNTaSaGUr4k1xSWvXzFwFUCli9HsWmmMIAZV1g9mD+zr71Wrfp0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIP1eRWmkUcjCsgufa1dAYhHUTSJpfX8hBXIDwLfwK3vbD23G
	98L0jSjC9wE9H6Sx3XnUlnLQEoZpNGiHfQAcClDHGQQMgu9AwqLHO28Y/A==
X-Google-Smtp-Source: AGHT+IEk1HF1yfwHvH3U4VgVuiMqv2Jw5XGtTnEzdU9HnMvAVoMYKCqf2ajoA2E7c7OpBZqgCqBz2w==
X-Received: by 2002:a17:902:c941:b0:206:93e7:5837 with SMTP id d9443c01a7336-208d83f0519mr130599345ad.39.1727009202707;
        Sun, 22 Sep 2024 05:46:42 -0700 (PDT)
Received: from dw-tp.. ([171.76.87.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d19aasm119420975ad.127.2024.09.22.05.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 05:46:42 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC / PoC v1 1/1] powerpc: Add support for batched unmap TLB flush
Date: Sun, 22 Sep 2024 18:16:24 +0530
Message-ID: <589d5262da605ae6d84a02bac477009f4655b705.1727001426.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727001426.git.ritesh.list@gmail.com>
References: <cover.1727001426.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

=== NOT FOR MERGE YET ===

This adds the support for ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH.
More details are added to the cover letter.

---
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h |  5 +++
 arch/powerpc/include/asm/tlbbatch.h           | 14 ++++++++
 arch/powerpc/mm/book3s64/radix_tlb.c          | 32 +++++++++++++++++++
 4 files changed, 52 insertions(+)
 create mode 100644 arch/powerpc/include/asm/tlbbatch.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0b8b2e3a6381..c3a23c1894dd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -171,6 +171,7 @@ config PPC
 	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS		if PPC_QUEUED_SPINLOCKS
+	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if PPC64 && PPC_BOOK3S_64
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index fd642b729775..f872537715e7 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -222,4 +222,9 @@ static inline bool cputlb_use_tlbie(void)
 	return tlbie_enabled;
 }

+bool arch_tlbbatch_should_defer(struct mm_struct *mm);
+void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+			       struct mm_struct *mm, unsigned long uaddr);
+void arch_flush_tlb_batched_pending(struct mm_struct *mm);
+void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 #endif /*  _ASM_POWERPC_BOOK3S_64_TLBFLUSH_H */
diff --git a/arch/powerpc/include/asm/tlbbatch.h b/arch/powerpc/include/asm/tlbbatch.h
new file mode 100644
index 000000000000..fa738462a242
--- /dev/null
+++ b/arch/powerpc/include/asm/tlbbatch.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 IBM Corporation.
+ */
+#ifndef _ASM_POWERPC_TLBBATCH_H
+#define _ASM_POWERPC_TLBBATCH_H
+
+#include <linux/cpumask.h>
+
+struct arch_tlbflush_unmap_batch {
+	struct cpumask cpumask;
+};
+
+#endif /* _ASM_POWERPC_TLBBATCH_H */
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 9e1f6558d026..2b1b2f7429fc 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -11,6 +11,7 @@
 #include <linux/mmu_context.h>
 #include <linux/sched/mm.h>
 #include <linux/debugfs.h>
+#include <linux/smp.h>

 #include <asm/ppc-opcode.h>
 #include <asm/tlb.h>
@@ -1585,3 +1586,34 @@ static int __init create_tlb_single_page_flush_ceiling(void)
 }
 late_initcall(create_tlb_single_page_flush_ceiling);

+#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+bool arch_tlbbatch_should_defer(struct mm_struct *mm)
+{
+	if (!radix_enabled())
+		return false;
+	return true;
+}
+
+void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+			       struct mm_struct *mm,
+			       unsigned long uaddr)
+{
+	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
+}
+
+void arch_flush_tlb_batched_pending(struct mm_struct *mm)
+{
+	flush_tlb_mm(mm);
+}
+
+static inline void tlbiel_flush_all_lpid(void *arg)
+{
+	tlbiel_all_lpid(true);
+}
+
+void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
+{
+	on_each_cpu_mask(&batch->cpumask, tlbiel_flush_all_lpid, NULL, 1);
+	cpumask_clear(&batch->cpumask);
+}
+#endif
--
2.46.0


