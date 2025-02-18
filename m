Return-Path: <linux-kernel+bounces-518754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A3DA39415
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6FC3B79CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453A81C07C2;
	Tue, 18 Feb 2025 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjbheyhY"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE461D31B8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864689; cv=none; b=YueXRwOoIgl8L6rL4QtJZRmnBR60XtZ6Z/9yEgclSm2CYl/mVYPezWymC4AlNUZbWBdrAFw3sBPwuP/BoTMBVPOKpFM+4/T68zEzTJCuR//YJzTcJJQv9Dwe0lc9U4ViOPd8gvPt324I/XEX+K+8ExxKtcZxusMbyRk9/8a+4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864689; c=relaxed/simple;
	bh=L9q/Bz4rEJrHe9INhIW+7OhrqRSDlC8plBjzP02+RkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ctTHz9WAoFPYZ8rTpcu9QmHJHfHMZt3fDIySiui+4AP/PLjXp+CJTCcUjxN8f+mL7ddB8nFyOUTiVAk0CCObnO9SlrM5VgVUlVr4h/v9q71brEqv78Xq1KOcC1SDoGN010LrLbV5s5VEZX6BJsua+blASrgMHbbTDgB1+ieUEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjbheyhY; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d9f21e17cfso5610238a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739864685; x=1740469485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JITLiJitMapwSBE70GMQNrVDMhYLdei0zpFE4LKFc7g=;
        b=qjbheyhYx/zp46T3uysjtXzBEkZLQ+Gai+DCOqqrB+kFXzST4iWuBfyVtkfL2SYG9R
         wvQONbRuw/6naGzBqlFqs6vTxy3/bgxjH690B722jG9bOH2QzK4xVSJLCgigjw3UeLKx
         UXN1l67OMt54/cy/ygOk1EaVhqHRD4V+5MExGbaJL5RtfDGtN+EuwPxkmZ/yMUNmdKhP
         +30iDk/OsakHPmaOUHq1sjy59sNUQCPAy8enSARvwgYz4+AuYiUmjOuxEky1N3a5WvZD
         BuHydESV8bJMuhzeMvqYJHII52TBgcdn+6XmMho+H34xdek2IZ+wb4Fcw38H7514dzYY
         vv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739864685; x=1740469485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JITLiJitMapwSBE70GMQNrVDMhYLdei0zpFE4LKFc7g=;
        b=dL4/m2tXAQqMUv9NLiZBw/WLGzDLg+o0Ku2xntQ3OW/6emeoQ1LU47eYHx6EF17sXT
         oag8dzaDb/wAKoZi7fFjJ9jVQ9q5/A/TYb1BYb11DNlGOveIXE5B0vVEkxmz8UJ0LO69
         JNfjUB5IOnprQJZrSSd3Bcq6KVPJs+es4KYqa9RTilLOO7mQmC5Vxp3vg1/2E/IUktX6
         4sVxXBj1ZeX9qv4MTgxoYsyiK7k4cSJKY3nUfTpNW7Co8NA2iya8yoaMQsZmSivEm8T/
         REvIDerg6leN+P4GaMs/om7fD1/5FumJmlCxefFaM1yEXeTCMIp6t7Vt0hRaso6c/mAD
         BLTA==
X-Forwarded-Encrypted: i=1; AJvYcCU92H8UPr68Vji9z3bnYlx3MvEr9svZ0XKOgbxhV/Mtkrm+CITx7932oFhBwi++pXXqZCOxN9gHLxr5obc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBThJlZdBRN2nSr2Ug9sg8wHzt33r6Gst6QjlgcYzsSWSKsICQ
	K+dbisidvtg98NonqLNXwKkDBr7BkN+OFv3+zVgMJoEmTQHkwSf3xA/2tL0uILn05qNRGcXbH+i
	P4WTqSA==
X-Google-Smtp-Source: AGHT+IGFOhnYv4JMBUKLB0Ci2QcvG2V+iEPaNM/BoKlrGzw5Uz5IR1FyRuCfNfH8YrktIbvHuQM/DFUJknqH
X-Received: from edbev18.prod.google.com ([2002:a05:6402:5412:b0:5de:b66e:8791])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3511:b0:5e0:7199:5497
 with SMTP id 4fb4d7f45d1cf-5e071995c8cmr3544427a12.11.1739864685601; Mon, 17
 Feb 2025 23:44:45 -0800 (PST)
Date: Tue, 18 Feb 2025 08:43:45 +0100
In-Reply-To: <cover.1739864467.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739864467.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <9f33eaaea6fed2948502eff27c4627921d1e1e78.1739864467.git.dvyukov@google.com>
Subject: [PATCH v2 1/4] pkeys: add API to switch to permissive pkey register
From: Dmitry Vyukov <dvyukov@google.com>
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The API allows to switch to permissive pkey register that allows accesses
to all PKEYs. This functionality is already used in x86 signal delivery,
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
Changes in v2:
 - Fixed typo in commit description
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


