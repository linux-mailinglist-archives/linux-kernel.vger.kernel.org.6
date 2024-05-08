Return-Path: <linux-kernel+bounces-172603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D9F8BF429
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E851F22CC4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E17D12E7C;
	Wed,  8 May 2024 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SzIfMXP+"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFB10A11
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132213; cv=none; b=iPAlLii0PIS45wx4VaTzQ91B/FfQakn8ZirltyBSh7RVi5OAL71Dq78A3EPHs/CppDiuGALiODgmOjHJEjde76gXrOX+S6df5QlU4/G8uJ81yjFQyTWpufdj9yzL1iQu9O+LYteZx/2LihlouPm++iG5BwV8mtCI0uTE6HE+sGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132213; c=relaxed/simple;
	bh=Ue5TDLMRl4Jg133jL9t6n44Efl7WVoijxTwvOh6lOb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTDBNDAoBctsmsRb2LCo8lvwtNqvNfRsSKC21M7ZEr75+VQfuOI0GRVlb5WjurJxrxxAIBziy/r1Ejyfw4LmlU7yHHES2YOUl/1KQFdmlHVsLWQieZVs5g876j5dPwP0mYrQPxRK+YgHSdzu440C5x3c/heGfuwQyT4xlLw9g0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SzIfMXP+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so3548580b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715132210; x=1715737010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myHzOOjViF8S4NmNBR6ubwFIqcNqWX5HRrdoX2U4mxE=;
        b=SzIfMXP+Ut2Uyuq8ATXD7KKrRnjj8Jjy97yT5RSKljbxhrqL2qwfZlTSs6p8tRthUe
         Q9ZrgxpA97wG06n98KgVPWgKZ/FxxVSU/Dfu3FMlmRlq02rV09b5USPnO1aZQffK4T23
         brEEIL1L9Cf/zYV/+PUu3Zt4xJpUkBsWvVdPjzXNhVd1YBcowTX4327HTAzk0Bkjmh1+
         14pGQqlU2SC3Lwji4tPdAntZewtrZOHwnG/hI8se3pblL7g5MRRtcSz+WNxJoTSnVBWW
         gCY8RyaoujoFShki4JH6XGuNk+Sda2kWKM727varxAowybOHArdssKt1aN6G/39hQXjE
         WxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132210; x=1715737010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myHzOOjViF8S4NmNBR6ubwFIqcNqWX5HRrdoX2U4mxE=;
        b=ltp29XkuqlhUq01t8pj0xB0vDa3LQhN4P5+WhOTcAVmDMWDb0S7AI/5Mqp054+N3Wd
         /VtQtoXvYoH2Ot7t2jAO0AKmwSpEgcRlmyAcCerCbK6yqozmyOF6EzNcm5mMtJ6rdVtn
         D2jNwXu5D6s4GmfDbMEWXamU6wFzC7Kai6Apoj19UPew9YkSHai1mfEUWBmirck6sYKc
         6IHa/SgQhPqHN96Bytlt2Am8fa5Y42s93/zhCXmgmqLPdqZUeE538Zq6MBUDiD/mqebZ
         gjiNmKup3nEepRBYV4HzZyYW/bWGNnjz8wbjkpMF6y8P4rN/K7DA2kKQi8tvVlKI2xbl
         YEQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcKbpZ0IGLoEbd0703q3xvrqLX+Y8naDwYj8ZkhpJ+Ng/+kpn4iV4UcVzN9LdaoDpQzN9b4rHq2w0HIi6Evy4MYnQt2NQum2TAoT3v
X-Gm-Message-State: AOJu0Yzxxgp52GRJjY7O7MKgDnZfrLW2l8ADNp22Bj5yoaX3K4U67Pej
	Qwaozpv5rl97N9UrqtszVZzG+rTOoUHG407U//a+XiyP5pZjNTbI2xY3UTk6YIE=
X-Google-Smtp-Source: AGHT+IHmyiekyum4bwoOJjosIJw7Z4DfDemwOXxUCyVbwuXuMPDsZBlduhwLXl3Z+XO6EPfAoMsxiA==
X-Received: by 2002:a05:6a21:191:b0:1a7:2ceb:e874 with SMTP id adf61e73a8af0-1afc8d5b8fcmr1553729637.37.1715132210381;
        Tue, 07 May 2024 18:36:50 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a265sm171994a91.10.2024.05.07.18.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:36:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 May 2024 18:36:32 -0700
Subject: [PATCH v2 6/8] riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBA Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-compile_kernel_with_extensions-v2-6-722c21c328c6@rivosinc.com>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
In-Reply-To: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Song Liu <song@kernel.org>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>, Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715132198; l=3295;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=Ue5TDLMRl4Jg133jL9t6n44Efl7WVoijxTwvOh6lOb4=;
 b=VPIFtHfzr8Xor7UIxI0uyPtvmdLuA5naS2Aa3xz4lMr3TZ261O7CupIAtnVu2wEleN1W4S7jL
 MeRK4vLEM5jDcGk96yhQiSL1n+P1wTsp6mS9ZW8caczG/bll99sxiRn
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Zba can optimize kernel instruction sequences. Add a config option
PLATFORM_SUPPORTS_RISCV_ISA_ZBA that allows arbitrary Zba instruction
sequences to be emitted by the compiler.

The existing "RISCV_ISA_ZBA" option is repurposed to be used to by kernel
code to determine if either PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBA or
PLATFORM_SUPPORTS_RISCV_ISA_ZBA has been set.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig.isa | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/riscv/Makefile    |  1 +
 2 files changed, 53 insertions(+)

diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
index 49bed8c75263..e7f28dc44137 100644
--- a/arch/riscv/Kconfig.isa
+++ b/arch/riscv/Kconfig.isa
@@ -186,6 +186,58 @@ config PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT
 
 	   If you don't know what to do here, say Y.
 
+
+config TOOLCHAIN_HAS_ZBA
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zba)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zba)
+	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZBA
+	bool
+
+choice
+	prompt "Zba extension for address generation instructions support"
+	default PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBA
+	help
+	  This selects the level of support for Zba instructions to be
+	  built into the Linux Kernel. This does not impact whether Zba
+	  instructions are allowed to be emitted by user-space code.
+
+	  The Zba extension provides instructions to accelerate a number
+	  of address generation instruction sequences.
+
+config PROHIBIT_RISCV_ISA_ZBA
+	bool "Prohibit Zba instruction sequences"
+	depends on NONPORTABLE
+	help
+	  Regardless of if the platform supports Zba instructions,
+	  prohibit the kernel from emitting Zba instructions.
+
+config PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBA
+	bool "Allow Zba instruction sequences if supported"
+	depends on TOOLCHAIN_HAS_ZBB
+	depends on RISCV_ALTERNATIVE
+	select RISCV_ISA_ZBA
+	help
+	  Add support for enabling optimisations in the kernel when the
+	  Zba extension is detected at boot.
+
+config PLATFORM_SUPPORTS_RISCV_ISA_ZBA
+	bool "Emit Zba instructions when building Linux"
+	depends on TOOLCHAIN_HAS_ZBB
+	depends on NONPORTABLE
+	select RISCV_ISA_ZBA
+	help
+	  Adds "zba" to the ISA subsets that the toolchain is allowed to emit
+	  when building Linux, which results in Zba instructions in the
+	  Linux binary. This option produces a kernel that will not run on
+	  systems that do not support the Zba extension.
+
+endchoice
+
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6b0c3a782f99..c8ec38b9880a 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -66,6 +66,7 @@ riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
 riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
 riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_C)	:= $(riscv-march-y)c
+riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBA)	:= $(riscv-march-y)_zba
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB)	:= $(riscv-march-y)_zbb
 
 ifdef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC

-- 
2.44.0


