Return-Path: <linux-kernel+bounces-536503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B50A480B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390BF17ABC1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B490323A9AE;
	Thu, 27 Feb 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cS21NNHT"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96F23A566
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665007; cv=none; b=shDpNq3G0Cq9bV5KO/LwhcvvAFYrLqXpE80en7wSmlYHiT2MJNmarLbCGSLEu/dtj/TVPJyPHIPp3wXDfKAfNdVSdMdNWfi3lRgjPZ3uzqIaH6TQj0X9Bado155kPeDoy/SBYWcBVt/bN5O8rVTch4KJCLTD3Dp4tILiab6OmB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665007; c=relaxed/simple;
	bh=g+n3TAVbRYeopfv2thFyRpDHZ0uzmD8PYIu8wMyexJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HfWsaCNxvCwZEfdWqk+q6bHs9x//NU/y7DRbrYXsawRf+aw4SrBsDEm0FiJfhce1IhpQeUii1f3cmLbkr4bW2ufPzWMFfjeqwugrjw98Tsq0TAAKxo16cIWU8Sjyad+Og/EcwgXTJNAjE7BmWFsl33/UNro4J5zuN2hlvH3RmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cS21NNHT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4399c5baac3so7699945e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740665003; x=1741269803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdyNR/l9tUX5mWYlAxYoBmtPUMPfXZLm9s3JeHQDuDg=;
        b=cS21NNHTlT6lHaw5Wh314sITmhOcyyvtOrswP/CVG817WDfULelF0oAsOZtiuAZDkG
         Di0cRtBcvZm1l5UqTvCp6FXiEZ6lcXsRAUUu2PFMC0mHepJbSHqOGD3OHCLD0hlLpFIe
         nNUxg23qbYTCbQ7ZGlNkJUtOLgS1Ka8Yp6cIps0L7+5i13eZSEP+zkCzL9V0Zp71CFfV
         ZsVmBZDb23iY1Nsxd2sRXhPqcoQA5OBOceloHZUtQYcpvtXcRz4SVwHeZ+YyR9muVhtO
         h5s7SmjIFl6/VHTAdMjGn04wreUoXL1ja5+UhpgCO+5AoohuvLKpBVI0E77afCviBMEu
         K4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740665003; x=1741269803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdyNR/l9tUX5mWYlAxYoBmtPUMPfXZLm9s3JeHQDuDg=;
        b=slJX6IC5RMvyIL/4tdyRf5iMiUJPpwr/aWUrP7x233OIML7FFxu1nQLcLPaGjpfTP4
         0moCoyaGJu3q5l5+RcHjHzcZRbei+JemW9ohygD5Fgq9sph6LM6SrNursZjBa9LcOi48
         iQaBy2HQ92s26xlCuLT2GcsezJDklm0aKDurL5WaNZiKgsPwQ3z9nLn4ymWal1K1fVKc
         9acGgd4reCG2ryqarS4s+gL7gDFJ2n0K0+1+LarVOZwkOHJURQTcPipjeFbfMZVBY0ia
         d6xnVU8PhHvCTJ9K2cS38jtip2wmxBy0O3OdVRFsJVYwdZUW20OUTff0LuGmgsi8076n
         9bEA==
X-Forwarded-Encrypted: i=1; AJvYcCVYW52R0fTama+vf82Xi1yppiUlp07rJhdIrpC4cy0EZS63siOMc0zqhMRSPGVUBT94uOPyUbIrPuOmSiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhxzpOEBAM9QjShwG88lJHW3OC4WsgNkRfuplmZCL43Gc+FjgJ
	Kv7kNrD9FSIYLXbNWRicRSpEK5pis4X50V2OdYT0pmeuLisJcxKvg+/+Z5DY9N4Dj0VaPeUhsRi
	1QWpMjw==
X-Google-Smtp-Source: AGHT+IGzvaJpoX4KLT7TQbb8SqIGurpls2L2bzHwZkcN5jr6r8UyFgg+P+X6U8CeEmO0M1lNmukGM2gQma4s
X-Received: from wmbjb4.prod.google.com ([2002:a05:600c:54e4:b0:439:98ca:e39d])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b13:b0:439:8bc3:a697
 with SMTP id 5b1f17b1804b1-43ab8fd1f46mr68084445e9.4.1740665003383; Thu, 27
 Feb 2025 06:03:23 -0800 (PST)
Date: Thu, 27 Feb 2025 15:03:12 +0100
In-Reply-To: <cover.1740664852.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740664852.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <f4434eb97c0aa550af8ef6882c623e019a28dbe3.1740664852.git.dvyukov@google.com>
Subject: [PATCH v6 1/4] pkeys: add API to switch to permissive/zero pkey register
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


