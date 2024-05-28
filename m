Return-Path: <linux-kernel+bounces-192633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2878D1FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109FA286803
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0C7171E71;
	Tue, 28 May 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BzH/12bJ"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7013171676
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909180; cv=none; b=ZnLp0QSTFGlflOen05fIYLcOymiGfTtjiMw0AQbQdyKXMroqWaOz4V9e9589yvv48HV+ONigDY1BmbyMed5cabU0hG28vGtxJVi62CFyLeG1pHbpQQ8Heepj7IoJ/Pwa5M+55xAUNiOevmDJ6Gi8kdAArWFpszcPkN6Iwyu0CiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909180; c=relaxed/simple;
	bh=dMj/ll2LOZkWgik8ojL9PklhNmgs0VfbZPpQvfJjzsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rsXXr5uogoZgoEbf2TdcFwvyasA81Awy0TTL2Bc00xPMzfhBRRE4DsKfjQ8zBbtGWh7auhgpsUvVbEmVDi6prn9eN1/KhJzZufjmvLvBiI2+URY7HQWLr1ZGzR/l6hvh/D8meJ3CF8k/OlhXDrtYw4fhbqWS6c/xrbOAc8Qd0OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BzH/12bJ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e95a883101so11551561fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716909177; x=1717513977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVgeqawgxJKFwBkPgG+fq6QiuKdnJgEdRIwxDEWsZ4Q=;
        b=BzH/12bJVmuNY1gxJhKva5FRNG0nwKZ2XYOr4Irp+G8Ou/jYfdKeiu2VjF9QeIR1pv
         timbzErGKzKD4ZUmH2WTeuLl7b4VJgfCW/iC1H/9Q0NITH1VeMA4pdwplHlXxOM+tdxj
         pTOHN7GwPpFD6LUVVT9ccEDnhHovAYlR4xBD2FJWJj32JnJ/ibdvdkBgsKUykwtyb/Df
         TSCx7ebBlqLrvAaTFsJOCqiJgX1tjBo8a+EoExAhp9S/5+VC4pjGB0su5W8OJnQ/t9t2
         oeiPZFw2H7pSMgIB4M7ry/9pow9m2fp+ZRSEAoDiO/vSUsGrf1gLCPwtb9rSaKkL6Rml
         SdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909177; x=1717513977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVgeqawgxJKFwBkPgG+fq6QiuKdnJgEdRIwxDEWsZ4Q=;
        b=prIHFdV0jOednrTQ8nrNv2bWieGqQBjonre8MuKJn+936niB6v3TNjhIJP5kiLr0i2
         sFc51QMF+ooFoowmYbQNWbUxvvONZ9n4dDZF+5hS0HSnMZF34Sf65H15v9dSngb0aliA
         bvES9pluKxMJh+kjZIfZiGvvyvgZHkplm+/bg0+rmR5XGO8GHC9QxEvTN5lOeJ39TgGG
         oboRvott30An/3D/87fmcDU5G6O2vw4xrmH+hhMsdlGqSpFhNRPN+f+0rEDUl5XcIPw9
         uumCP24NrA1MGUwBTwO5wpoXPEwd2z11K/wGXp4Rp25UPfuFOOnd+aLvIf/PazXDPkFY
         nyHg==
X-Forwarded-Encrypted: i=1; AJvYcCUGh54V+I0cqtVT5U3sv0Bp/7GBpUXLXbs/JZZwCyPABKSuuUEEGNA1YubARqPXKR+dd4vpzTScr0XSwlLI9q+rKkIBxJdnQM/ULDB1
X-Gm-Message-State: AOJu0YxKO9ICYB520Pm0nXq+P80HvBHWv2aknGUqt8o3dd+vkj/wFPUZ
	29V/Vf5N9B4GeBdz6xPF4wXQ20FCE6MlMd7N67fo7l6PekzlTiQWAOGNtuV0lGY=
X-Google-Smtp-Source: AGHT+IG/weMgFc40n3U80f7qsiGYCL5GCfV3H84Qfrnd5vO+VgM5LRY1gz81bmewik/+pxslmkrhfw==
X-Received: by 2002:a2e:9953:0:b0:2e9:843d:63e5 with SMTP id 38308e7fff4ca-2e9843d643bmr22338201fa.0.1716909176965;
        Tue, 28 May 2024 08:12:56 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210897c6bbsm146607535e9.27.2024.05.28.08.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:12:56 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
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
Subject: [PATCH 2/7] riscv: Implement cmpxchg8/16() using Zabha
Date: Tue, 28 May 2024 17:10:47 +0200
Message-Id: <20240528151052.313031-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240528151052.313031-1-alexghiti@rivosinc.com>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds runtime support for Zabha in cmpxchg8/16 operations.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig               | 16 ++++++++++++++++
 arch/riscv/Makefile              | 10 ++++++++++
 arch/riscv/include/asm/cmpxchg.h | 26 ++++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b443def70139..05597719bb1c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -579,6 +579,22 @@ config RISCV_ISA_V_PREEMPTIVE
 	  preemption. Enabling this config will result in higher memory
 	  consumption due to the allocation of per-task's kernel Vector context.
 
+config TOOLCHAIN_HAS_ZABHA
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zabha)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zabha)
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZABHA
+	bool "Zabha extension support for atomic byte/half-word operations"
+	depends on TOOLCHAIN_HAS_ZABHA
+	default y
+	help
+	  Adds support to use atomic byte/half-word operations in the kernel.
+
+	  If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_ZACAS
 	bool
 	default y
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index d5b60b87998c..f58ac921dece 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -89,6 +89,16 @@ else
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
 endif
 
+# Check if the toolchain supports Zabha
+ifdef CONFIG_AS_IS_LLVM
+# Support for experimental Zabha was merged in LLVM 19.
+KBUILD_CFLAGS += -menable-experimental-extensions
+KBUILD_AFLAGS += -menable-experimental-extensions
+riscv-march-y := $(riscv-march-y)_zabha1p0
+else
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := $(riscv-march-y)_zabha
+endif
+
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
 KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 1c50b4821ac8..65de9771078e 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -103,8 +103,14 @@
  * indicated by comparing RETURN with OLD.
  */
 
-#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)	\
+#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
 ({									\
+	__label__ zabha, end;						\
+									\
+	asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,			\
+			     RISCV_ISA_EXT_ZABHA, 1)			\
+			: : : : zabha);					\
+									\
 	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
 	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
 	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
@@ -131,6 +137,17 @@
 		: "memory");						\
 									\
 	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+	goto end;							\
+									\
+zabha:									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"	amocas" cas_sfx " %0, %z2, %1\n"		\
+		append							\
+		: "+&r" (r), "+A" (*(p))				\
+		: "rJ" (n)						\
+		: "memory");						\
+end:									\
 })
 
 #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
@@ -175,8 +192,13 @@ end:									\
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
+		__arch_cmpxchg_masked(sc_sfx, ".b" sc_sfx,		\
+					prepend, append,		\
+					__ret, __ptr, __old, __new);    \
+		break;							\
 	case 2:								\
-		__arch_cmpxchg_masked(sc_sfx, prepend, append,		\
+		__arch_cmpxchg_masked(sc_sfx, ".h" sc_sfx,		\
+					prepend, append,		\
 					__ret, __ptr, __old, __new);	\
 		break;							\
 	case 4:								\
-- 
2.39.2


