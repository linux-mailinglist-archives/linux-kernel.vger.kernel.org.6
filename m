Return-Path: <linux-kernel+bounces-517474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EDFA38152
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACE63A3DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA242135C7;
	Mon, 17 Feb 2025 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9srBKPo"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB399192B71
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790495; cv=none; b=eew1l/vpvrGqsSleDXV44B11XxAl9jqLIRR234W8/lww2oPGuhooQcybv/fabO9/CZpkOzttTVPFWNWttRWfcsdec0S4t4H3DVYJQ3YSJLIaDBrwf3NkHAJFSpWcNP38meqwRdwZQh78OyMaypiiXfZQwrQYXR3AxP+sekekgjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790495; c=relaxed/simple;
	bh=S4gKZe3I4EYKf5E7q96ZBisfogHzg2odYiy/EqZYfU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uTF+CRK+E+elcRBwb6C2kVAJ/V+kKD7P4EHCtDqRD5c6o/Zv4XlYwLpBm3x4Hvp/KzNC6JJu8BNs/ParKKwJwYqF1RmmebW/dgxcAi6Gpl1tpU0rlhGZUFu6KvGKxYEq9zpjNtuUkFnVZPhNkrT3C1okiuZGnOnFEKRfnvlhgJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9srBKPo; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-abb9962ebe5so82390466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739790492; x=1740395292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jqXqpqizOnDlMWwzZuVF9a2CR14R+qK8RMrkhnNZbmM=;
        b=P9srBKPoA5kpPVzTgi5vbtldTY9nVWLfmX59kOp0PWs5y1B+FAvPmj6qQ6qi11FewT
         wQaOZDRP/APWCVZax9WEwGkRAVqd9rcIgM6pfFjo7sKnSbTcCoyJndhIgcnjruTlmuF2
         YjVuEAIZoVUtcqZ/33z1ACIAHzTDfkB4kffK3NnMPzrQSMk/5lFU/9olRnVsAViTiZri
         TFG6gSO8CTrTNm/qxHbSPWOHFilYOVDgRz9fd3ead4AiOR1zp6b106xqrbj5BOfP7Zhf
         8Hyg5NHU44wMiEiO450ifRMyBblMmSzwnVaQR+S4gtGBQbNPhrUkRkFNPRswqAE/CyYw
         lAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739790492; x=1740395292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqXqpqizOnDlMWwzZuVF9a2CR14R+qK8RMrkhnNZbmM=;
        b=FXtTolQCiP/rJZ13ZWT+AiQ12WEWbl4AR6whBPVj7d5ZfoSUtTeMtnIUzFlVMh8BN3
         lxTbaWkRNWOQdcZuk79/ID0LZIZ1ARdgDx5InrHYkKMnbwo/XIk5mHEf6R1b/xY2xcJA
         UpbNY7lbA2VTmVSiyhiHR827DOcZ/+j1XwcX96gMn0Ds3A7U+NS5MbdtcAXV+g5Ng/U5
         iM0CHm3Mkdqo1vRt0CqNfmOhToibViJdsWmq+gQ2egtitzmJMcuZqqR5doMrSK1lA2nG
         bACqwFw2rta4qXkSGM5ZKf7nd7Ol9mRfRkIifDLoynuhnL0+NTqHKjr5fO9gXXMcbU6f
         95nw==
X-Forwarded-Encrypted: i=1; AJvYcCW2OkRyTb2+zY0TLHsReoi3DW+iR51k1lS+EcV9UE6if2u24CfULddz8h6xYJROwNVutSvhcyf/wdx41ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YywuvBC1Y0qtMBlyji085uFCqhko9VtfpX6sWBX7z9aQeZmlAqx
	FYIlm4xds8L7+vsEhuKZ5rrlI7feAFrn6o7+dT/W7muyc3+ndZo70/PcuZdDK/3fb8k4YRIsc3t
	Yj1qo/w==
X-Google-Smtp-Source: AGHT+IFC8xLiAD97i45QddBe0Hg/Sc+qBWjG9lRAlS4snl4BSDRt6sJI8o3b9u2f6re5RbXrXeuXtGDOTUDg
X-Received: from edbb21.prod.google.com ([2002:a05:6402:1f15:b0:5e0:4a93:3dc6])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:27d2:b0:5de:5865:69ae
 with SMTP id 4fb4d7f45d1cf-5e036173c4dmr21313063a12.29.1739790492277; Mon, 17
 Feb 2025 03:08:12 -0800 (PST)
Date: Mon, 17 Feb 2025 12:07:30 +0100
In-Reply-To: <cover.1739790300.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <ffd123bb0c73df5cdd3a5807b360bd390983150b.1739790300.git.dvyukov@google.com>
Subject: [PATCH 1/4] pkeys: add API to switch to permissive pkey register
From: Dmitry Vyukov <dvyukov@google.com>
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The API allows to switch to permissive pkey register that allows accesses
to all PKEYs. This is functionality is already used in x86 signal delivery,
and will be needed for rseq.

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
---
 arch/x86/Kconfig             |  1 +
 arch/x86/include/asm/pkeys.h | 14 ++++++++++++++
 arch/x86/include/asm/pkru.h  | 10 +++++++---
 include/linux/pkeys.h        | 22 ++++++++++++++++++++++
 mm/Kconfig                   |  2 ++
 5 files changed, 46 insertions(+), 3 deletions(-)

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
index 2e6c04d8a45b4..1cacfe184b9d4 100644
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
@@ -123,4 +125,16 @@ static inline int vma_pkey(struct vm_area_struct *vma)
 	return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
 }
 
+typedef u32 pkey_reg_t;
+
+static inline pkey_reg_t switch_to_permissive_pkey_reg(void)
+{
+	return write_pkru(0);
+}
+
+static inline void write_pkey_reg(pkey_reg_t val)
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
index 86be8bf27b41b..d94a0ae7a784b 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -48,4 +48,26 @@ static inline bool arch_pkeys_enabled(void)
 
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
+#ifndef CONFIG_ARCH_HAS_PERMISSIVE_PKEY
+
+/*
+ * Common name for value of the register that controls access to PKEYs
+ * (called differently on different arches: PKRU, POR, AMR).
+ */
+typedef int pkey_reg_t;
+
+/*
+ * Sets PKEY access register to the most permissive value that allows
+ * accesses to all PKEYs. Returns the current value of PKEY register.
+ * Code should generally arrange switching back to the old value
+ * using write_pkey_reg(old_value).
+ */
+static inline pkey_reg_t switch_to_permissive_pkey_reg(void)
+{
+	return 0;
+}
+
+static inline void write_pkey_reg(pkey_reg_t val) {}
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
2.48.1.601.g30ceb7b040-goog


