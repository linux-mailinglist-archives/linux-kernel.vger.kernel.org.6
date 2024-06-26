Return-Path: <linux-kernel+bounces-230764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826BE91819A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94B11C23EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FF9181BB8;
	Wed, 26 Jun 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZNK+SJzL"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348017B50F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407096; cv=none; b=GhF33aMR8TCFniwzhRoWt+8austHtCsyHz0WizuG96AlfAzx329X781Ika6Hbgv46lD7D6LHYAohTAXaqw20dgmCYkiP+ieawl0VBmzT7wG9cTh8HAKhh2FCt0+dTWRwq3ojAOfjh78PF0cK7gTI+KJz5Vg2j2/HNy5a+CjKfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407096; c=relaxed/simple;
	bh=A9Uqg4vTaom0SRJ8P/Ttrrx+YujCW1mkS/Zqcd4jDx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGYpiOD2RvjGFR5nfiBPvkgoLwkjdjDpKCZfvHtvxS9jY9QgJYuUOQ7v+rfMBoVjPS8GyqFXmiIAWN9sUdK0UGcdyAI3qdOrLF2qBYjHM7RilZyEbGLWA6WrLPimes64jgOo9JG7Bor7+A/20lXJyMH9yHMUaiyvcGjQYIBxaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZNK+SJzL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cd8897c73so5585472e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719407093; x=1720011893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhXCNVmR8P99l/LeuRhjy5KBZNQ4/EvtQCsDBcea+Tc=;
        b=ZNK+SJzLKFSgzvyxUkjQxUDR7o7piP4GoB+T9N3Sguqx3K0xQsC4SxTPoMFW540BFd
         QqlNEIBkE0xV/AY2c5wCkks+d3+XMdFSWD43srTrFVrUB+dloM1QUh4J9AiptgzJNVoW
         QmljUMlDHXqpQ6e8siqWm5/78g5jav65kdFEz8bOgCjB6bPKyUtIlVxQ/bw2Dhask1jq
         +jXAoX9ZTFpcNw7rmtEPJHx4qNmEeWWmHMV7sFUEvoe90nGtUcMpPOfVP3Qj+cdMq2gN
         oyJj9lRy6M2cLKbeD9SBrFZLXro4V9A+u3CXp0XITS/TvyQqIaBXlScGy7pQDNjlN+ES
         z6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407093; x=1720011893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhXCNVmR8P99l/LeuRhjy5KBZNQ4/EvtQCsDBcea+Tc=;
        b=Y+CLC5mKpuwi0LRR7mqXq6yKOhqrS2Sm3NmFcBAzZhTyRAswS5Qx4orcxk8dqPXErX
         yRG2MfxpYj7nkk8DzDyxIqu+t6T5WWdtKEdW6f1msmh+aV+96gCxaGA1csrqu5vqptbD
         4e+YNzz/xdnaA/JvpHL1d1QQEEUX6//RwSxNiXh0B1h3kJ0Dj0S9YFlZVjLFUbb6vXw7
         cW6KSJqkdTCxbeU0MLrXPy2r3i+/wZBz4PHRQiXE5GWRpgrDH7DdEQgsqDZMUnCPVkc4
         NKEsS9YcPfznE8lbbN3eBCxDnX7PF5HRM3yISA1AAOo/HgFkMaCIjbqvTI5EE9mLrMiA
         pDyw==
X-Forwarded-Encrypted: i=1; AJvYcCUkNLVkZqGcZFo0J7La/TfFPwgLsYPFmqviYfVMJXGCtZPYQSc9FRVABBqcXC5Sw0iGF9D2i/rpOvlRJTee+or/lVsWrDhddia6RMas
X-Gm-Message-State: AOJu0YzpZC92c30T+x83SouWRXM7kbUbtZT34vG7FSwPKNgvQulTicv6
	yEWW9SkMopdaBUrDV+n4n9SdA8JTtklj7Bjh9LTj+XFQ+lUq7x24GwIWgMpE+NU=
X-Google-Smtp-Source: AGHT+IGXVzg0cT42nAZtoqYsiJZ5s31h9gkqhz8eo+Ns1Bzdpb6n1iQQeyrD5Jr8Y6qR9urf80as6w==
X-Received: by 2002:ac2:596e:0:b0:52c:db7b:b463 with SMTP id 2adb3069b0e04-52ce186459cmr6385178e87.61.1719407093047;
        Wed, 26 Jun 2024 06:04:53 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c842468dsm25643865e9.36.2024.06.26.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:04:52 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Zacas
Date: Wed, 26 Jun 2024 15:03:38 +0200
Message-Id: <20240626130347.520750-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626130347.520750-1-alexghiti@rivosinc.com>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds runtime support for Zacas in cmpxchg operations.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig               | 17 +++++++++++++++++
 arch/riscv/Makefile              |  3 +++
 arch/riscv/include/asm/cmpxchg.h | 27 ++++++++++++++++++++++++---
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 05ccba8ca33a..1caaedec88c7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -596,6 +596,23 @@ config RISCV_ISA_V_PREEMPTIVE
 	  preemption. Enabling this config will result in higher memory
 	  consumption due to the allocation of per-task's kernel Vector context.
 
+config TOOLCHAIN_HAS_ZACAS
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zacas)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zacas)
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZACAS
+	bool "Zacas extension support for atomic CAS"
+	depends on TOOLCHAIN_HAS_ZACAS
+	default y
+	help
+	  Enable the use of the Zacas ISA-extension to implement kernel atomic
+	  cmpxchg operations when it is detected at boot.
+
+	  If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 06de9d365088..9fd13d7a9cc6 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -85,6 +85,9 @@ endif
 # Check if the toolchain supports Zihintpause extension
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
 
+# Check if the toolchain supports Zacas
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
+
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
 KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 808b4c78462e..a58a2141c6d3 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -9,6 +9,7 @@
 #include <linux/bug.h>
 
 #include <asm/fence.h>
+#include <asm/alternative.h>
 
 #define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)		\
 ({									\
@@ -134,21 +135,41 @@
 	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
 })
 
-#define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n)	\
+#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
 ({									\
+	__label__ zacas, end;						\
 	register unsigned int __rc;					\
 									\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
+		asm goto(ALTERNATIVE("nop", "j %[zacas]", 0,		\
+				     RISCV_ISA_EXT_ZACAS, 1)		\
+			 : : : : zacas);				\
+	}								\
+									\
 	__asm__ __volatile__ (						\
 		prepend							\
 		"0:	lr" lr_sfx " %0, %2\n"				\
 		"	bne  %0, %z3, 1f\n"				\
-		"	sc" sc_sfx " %1, %z4, %2\n"			\
+		"	sc" sc_cas_sfx " %1, %z4, %2\n"			\
 		"	bnez %1, 0b\n"					\
 		append							\
 		"1:\n"							\
 		: "=&r" (r), "=&r" (__rc), "+A" (*(p))			\
 		: "rJ" (co o), "rJ" (n)					\
 		: "memory");						\
+	goto end;							\
+									\
+zacas:									\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
+		__asm__ __volatile__ (					\
+			prepend						\
+			"	amocas" sc_cas_sfx " %0, %z2, %1\n"	\
+			append						\
+			: "+&r" (r), "+A" (*(p))			\
+			: "rJ" (n)					\
+			: "memory");					\
+	}								\
+end:;									\
 })
 
 #define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)		\
@@ -156,7 +177,7 @@
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __old = (old);				\
 	__typeof__(*(__ptr)) __new = (new);				\
-	__typeof__(*(__ptr)) __ret;					\
+	__typeof__(*(__ptr)) __ret = (old);				\
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
-- 
2.39.2


