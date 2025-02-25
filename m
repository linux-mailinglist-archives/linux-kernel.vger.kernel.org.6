Return-Path: <linux-kernel+bounces-531524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF43A44186
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F81189819F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2B3270EA6;
	Tue, 25 Feb 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IhJLznCr"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6FD26FDA8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491649; cv=none; b=JCGMRqk2FNHf01nfDkPoXpG8fXpZQxwBVZDR2c/oM/xCxqhgEI7zEereSGtjfRLQBIvpuHxqXRJmzEz1+IxxpA6DK7NTuZ5m8ySASP0kgXSrhC7IO+xOh46ErTXvvQualbDlK0b5UVAW1jHRCFXKBvpptS3b+6Ddt8tYs5ghPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491649; c=relaxed/simple;
	bh=g+n3TAVbRYeopfv2thFyRpDHZ0uzmD8PYIu8wMyexJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o2uHlP6A/ybxmBL5D2YRZ35mEayeTu9GZaPlxeOqPelF8g2ptosDKiR/zRhkLOCVvXPPKvR12ApBMPq+bchZhUQUqZ5oY1Kh1vu3NfNsGc6Un95aB/K/41yscRQ2oOUX9H2lKS9sQQAKRhYD5CO6KPf6PpieN6VHIKZZxeoRG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IhJLznCr; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e08b755856so4802512a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740491645; x=1741096445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdyNR/l9tUX5mWYlAxYoBmtPUMPfXZLm9s3JeHQDuDg=;
        b=IhJLznCr3K5I5oKqePnOJVgooMNnkhE4pKCoaTnkTWMajcizpOqW3nLgULwdgO3f3g
         gjPieaN9Kfa+s108/PUzBe4gon00AA9OS7LIhar4u8vChHLvgsbpjTokpVIGrQOD4fhE
         EbKpuALPoWloKNpV5Ka5nSahZnjMhgZWKAP8sDS94V5G5RNs5DxvBgrGJbDAdYgZRg46
         uDpkqkQ9lBL34+HNWetWGDJShF1dhfqCBprOCOadCellVXUIXqrdwsWlYnNEDGc5sdVL
         jO0nbltHWqT6b2Xavm76wky6maQN6b4anG4ZdZhsblk8gGfE859wC0WaG025Y7GCHwMd
         2AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491645; x=1741096445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdyNR/l9tUX5mWYlAxYoBmtPUMPfXZLm9s3JeHQDuDg=;
        b=nOtCKXc7FSky0dTKMYrPu861+cip13JjJEKkSwhylqisC6gvBLDUS9u1ZNKi1Aicy/
         B866tKugFbdRd0tWowlSSIGMsAA/0efvPCpAYf627NM7rycq4xvaCj5TnlbduVq2uEqm
         qdEZg7bGNqt5RG9rkK1NYpLe6v8lqo96sj8TTQbxi2CHeuIwE5L4WM7FBqQ5jMIWhyoJ
         ilBsTfL8VoPqtxmlzyoxtWCmWT/e9UzqykZ+fm6iEEiikyzyXlsV2qI3m51ThgjW2ouG
         xyl7Os7wUe6crjWjSHKuCtaIblC9TP+m+eWe3+pB1K/L1ic/Sg/DgKSGv5CQqBXiXZSM
         9oDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYKFRaWBRelRmJDRlCahl7nRZppgp85nuGeNB2qrTudMItAkyIXxBtDTC7lyC7nsGn0H4XeNvyUghXwQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrqaUgCEMIboulOF2uz/hF2LZeyQru+sHILShu2IM/f5N0jIwN
	SxnoCNqMi7kqNi7gfuMZzxXDtLV0AK91+L2bqNT+tDlMh+SeyE9U91WEfxBZk4AIOUmvm5n2D4u
	efqYg7A==
X-Google-Smtp-Source: AGHT+IEGPaJGqqLzhk9TVJVTOjR4kEA4ZifYmUctOEbv4wTcMB36xiJLmFQsK5lJK7Mvd7hfDjnnd6qGjQvh
X-Received: from edc20.prod.google.com ([2002:a05:6402:4614:b0:5de:d7ab:eca2])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:50c7:b0:5dc:cc02:5d25
 with SMTP id 4fb4d7f45d1cf-5e0b70d5729mr18190417a12.11.1740491644884; Tue, 25
 Feb 2025 05:54:04 -0800 (PST)
Date: Tue, 25 Feb 2025 14:53:43 +0100
In-Reply-To: <cover.1740491413.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740491413.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <bf238e9f0d8e6960c1b36920b0fd9cbbaf705fc9.1740491413.git.dvyukov@google.com>
Subject: [PATCH v5 1/4] pkeys: add API to switch to permissive/zero pkey register
From: Dmitry Vyukov <dvyukov@google.com>
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The API allows to switch to permissive pkey register that allows accesses
to all PKEYs, and to a value that allows access to the 0 (default) PKEY.
x86 signal delivery already uses switching to permissive PKEY register
value, and rseq needs to allow access to PKEY 0 while accessing
struct rseq/rseq_cs.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")

---
Changes in v5:
 - Removed leftover dead code in enable_zero_pkey_val
 - Clarified commit message

Changes in v4:
 - Added Fixes tag

Changes in v3:
 - Renamed API functions to write_permissive_pkey_val/write_pkey_val
 - Added enable_zero_pkey_val for rseq
 - Added Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Changes in v2:
 - Fixed typo in commit description
---
 arch/x86/Kconfig             |  1 +
 arch/x86/include/asm/pkeys.h | 30 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/pkru.h  | 10 +++++++---
 include/linux/pkeys.h        | 31 +++++++++++++++++++++++++++++++
 mm/Kconfig                   |  2 ++
 5 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118d..43af2840d098f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1881,6 +1881,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
+	select ARCH_HAS_PERMISSIVE_PKEY
 	help
 	  Memory Protection Keys provides a mechanism for enforcing
 	  page-based protections, but without requiring modification of the
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 2e6c04d8a45b4..614099766d5f2 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PKEYS_H
 #define _ASM_X86_PKEYS_H
 
+#include "pkru.h"
+
 /*
  * If more than 16 keys are ever supported, a thorough audit
  * will be necessary to ensure that the types that store key
@@ -123,4 +125,32 @@ static inline int vma_pkey(struct vm_area_struct *vma)
 	return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
 }
 
+typedef u32 pkey_reg_t;
+
+static inline pkey_reg_t write_permissive_pkey_val(void)
+{
+	return write_pkru(0);
+}
+
+static inline pkey_reg_t enable_zero_pkey_val(void)
+{
+	u32 pkru;
+
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return 0;
+	/*
+	 * WRPKRU is relatively expensive compared to RDPKRU,
+	 * avoid it if possible.
+	 */
+	pkru = rdpkru();
+	if ((pkru & (PKRU_AD_BIT|PKRU_WD_BIT)) != 0)
+		wrpkru(pkru & ~(PKRU_AD_BIT|PKRU_WD_BIT));
+	return pkru;
+}
+
+static inline void write_pkey_val(pkey_reg_t val)
+{
+	write_pkru(val);
+}
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
index 74f0a2d34ffdd..b9bf9b7f2753b 100644
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -39,16 +39,20 @@ static inline u32 read_pkru(void)
 	return 0;
 }
 
-static inline void write_pkru(u32 pkru)
+static inline u32 write_pkru(u32 pkru)
 {
+	u32 old_pkru;
+
 	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
-		return;
+		return 0;
 	/*
 	 * WRPKRU is relatively expensive compared to RDPKRU.
 	 * Avoid WRPKRU when it would not change the value.
 	 */
-	if (pkru != rdpkru())
+	old_pkru = rdpkru();
+	if (pkru != old_pkru)
 		wrpkru(pkru);
+	return old_pkru;
 }
 
 static inline void pkru_write_default(void)
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 86be8bf27b41b..262d60f6a15f8 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -48,4 +48,35 @@ static inline bool arch_pkeys_enabled(void)
 
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
+#ifndef CONFIG_ARCH_HAS_PERMISSIVE_PKEY
+
+/*
+ * Common name for value of the register that controls access to PKEYs
+ * (called differently on different arches: PKRU, POR, AMR).
+ */
+typedef char pkey_reg_t;
+
+/*
+ * Sets PKEY access register to the most permissive value that allows
+ * accesses to all PKEYs. Returns the current value of PKEY register.
+ * Code should generally arrange switching back to the old value
+ * using write_pkey_val(old_value).
+ */
+static inline pkey_reg_t write_permissive_pkey_val(void)
+{
+	return 0;
+}
+
+/*
+ * Sets PKEY access register to a value that allows access to the 0 (default)
+ * PKEY. Returns the current value of PKEY register.
+ */
+static inline pkey_reg_t enable_zero_pkey_val(void)
+{
+	return 0;
+}
+
+static inline void write_pkey_val(pkey_reg_t val) {}
+#endif /* ! CONFIG_ARCH_HAS_PERMISSIVE_PKEY */
+
 #endif /* _LINUX_PKEYS_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db064172..9e874f7713a2b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1147,6 +1147,8 @@ config ARCH_USES_HIGH_VMA_FLAGS
 	bool
 config ARCH_HAS_PKEYS
 	bool
+config ARCH_HAS_PERMISSIVE_PKEY
+	bool
 
 config ARCH_USES_PG_ARCH_2
 	bool
-- 
2.48.1.658.g4767266eb4-goog


