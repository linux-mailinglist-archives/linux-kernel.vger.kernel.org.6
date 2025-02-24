Return-Path: <linux-kernel+bounces-529127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39663A42007
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DF818985E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8BA23BD07;
	Mon, 24 Feb 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8tTdTmi"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D123BCF6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402775; cv=none; b=N/6PM2eAdoMr4qBJ1dfz/uXtw6CgpKHKViZ+2/42qQODjNcTbYaZAP/x1vB3bBEIoh+E1P1R5noTAhZLmSLIeRr7g3mOZJlCFakSH77OAzLD+qa/HxqSRbKp7X48j3ttw7ebztHd8257y7e2qOzSp/AMI2DCEdnSWJ21/gzVSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402775; c=relaxed/simple;
	bh=Vpe2CVhobGhf60Jo/aiXVVjf3qK7GIqiY6HV8zD3rSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R+OKZusT87MNbYDsETPHzVoMHV6B1Mfs964+hZoBItaJThBzPPDUgZCopI88vdLQ9SfMPv2OeWH/pRIr/2e3bFGI5Xppf6RQ/P6Bu2ui+pvI5A04fka6Hgskc5RULRZNxKlWjhvNUOD5AnXc1ArsH3SXWL4oQHO0PCsMLohciRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N8tTdTmi; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-abb87e3a3c9so472444166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740402771; x=1741007571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qj77FvPKWQRJo9q3eey56916PTau/uBH34JNB+3MFq8=;
        b=N8tTdTmiA36cLIZnNmi4GC/waWRhZAAq6+ozhE3vCE/yYceScHzLDUK68sxKGopD0n
         yTlrh84jLTko4Dv6fhZtGWqPeeIoMGOOJB1UEBWk4rN6nRsyIIG3apuseW/BC2e0zXny
         lqNRdGEYJNPKfsGrM5iG0YHsisjvTtMO45jRLj9nOJ6TMz2habiHl0PaLqi1HTRen8lx
         CEu35cPCwkjXn/Yyi+LJI536HGezFN9VCyzToh/u8MXaXCV8E4jgU8VX94WeP26lwDI4
         sUfx9WevnCp4meGfLsq7ZGDPmAIvnJT98OajuLUsVNDpyjMQ5BbVrUJenRoIT/bZ1rfr
         xIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402771; x=1741007571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qj77FvPKWQRJo9q3eey56916PTau/uBH34JNB+3MFq8=;
        b=RDPz99NxKYCNjuQBbla+fureAquaCs8AhxrSMbMOV+4kIKDtE1uCTYJpWdZI5eS3ke
         oe8O3Ov7E6Betx+mcpE0Ibo3wWdrj0gOYiURyr6cVf5LpEvwLnjtJ3jlKzAkoiovclpE
         TUMvr+/n3VkHST5f0/IVaeKnUWmV/oafrm6rSAQtmTSLanvN7yozm1NUloZOh5WZ/HKW
         /8/v2vDIpEFX8nCvWYpiKKu6TSoTf1Ra8Z2E5DV/NpKs3BLvkE6Id6Il/eKEhEGyoIpx
         SSaasxPN5iU0jT0Cf6q0vKAFcPZWCY/1S0iiNJYjfhU6X5ADwcC2EUXaB+W+B+YSwrAK
         Cz7w==
X-Forwarded-Encrypted: i=1; AJvYcCU4z8Hl4H4hktilLIzbPji/CEFVKGEgdLC5UqOaUUEjNs5RGABlY5TlVWJjW33SdSxB+6bK5jsTAqDSkt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7TvzOK+5CTK8QvyrmoMsqawUr0Zt+AEWsggtndabRmWDK07c
	wrpDqAlevKqFbRkrB8cBC9i511aWzjDutErE4jm0y9lQJUeXR4oRbtbihNlejgOwHHBOfimognx
	lp1qj3A==
X-Google-Smtp-Source: AGHT+IHWA9x1C1OPAHCcNc3EGFl6cjUalW8RxsLQqWhBFuyOm0xbFYwM1NzwadyiBehz36PML28g/iQQWtHh
X-Received: from ejcmm11.prod.google.com ([2002:a17:907:7a8b:b0:abb:9213:4cda])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:c0f:b0:aab:9430:40e9
 with SMTP id a640c23a62f3a-abc09ab56bfmr1211685266b.32.1740402771474; Mon, 24
 Feb 2025 05:12:51 -0800 (PST)
Date: Mon, 24 Feb 2025 14:12:28 +0100
In-Reply-To: <cover.1740402517.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740402517.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <4aaf3d4642d59bef0623b026800c5ff066777159.1740402517.git.dvyukov@google.com>
Subject: [PATCH v3 1/4] pkeys: add API to switch to permissive/zero pkey register
From: Dmitry Vyukov <dvyukov@google.com>
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The API allows to switch to permissive pkey register that allows accesses
to all PKEYs, and to a value that allows acccess to the 0 (default) PKEY.
This functionality is already used in x86 signal delivery, and will be
needed for rseq.

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

---
Changes in v3:
 - Renamed API functions to write_permissive_pkey_val/write_pkey_val
 - Added enable_zero_pkey_val for rseq
 - Added Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Changes in v2:
 - Fixed typo in commit description
---
 arch/x86/Kconfig             |  1 +
 arch/x86/include/asm/pkeys.h | 33 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/pkru.h  | 10 +++++++---
 include/linux/pkeys.h        | 31 +++++++++++++++++++++++++++++++
 mm/Kconfig                   |  2 ++
 5 files changed, 74 insertions(+), 3 deletions(-)

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
index 2e6c04d8a45b4..d6e35ab5c3d22 100644
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
@@ -123,4 +125,35 @@ static inline int vma_pkey(struct vm_area_struct *vma)
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
+
+
+	return write_pkru(0);
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
2.48.1.601.g30ceb7b040-goog


