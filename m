Return-Path: <linux-kernel+bounces-170564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4D38BD927
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD54E1F235DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315D54087F;
	Tue,  7 May 2024 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BQb9i57x"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19221E521
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046171; cv=none; b=EP1RfdGnsqoM06ru8yKwCXskETHeHZyPIjbEyqfTrSbAxt/n2MZAtzzvILvZCk0bOcq18RNFBDXI3ThUqZLJOm27CW2+kMA1dODCnA/eKfbTuQdumnB6LPwEOrkLkHFO3qfF0jyqn9o1x6Gept3tc1/acaOdbanytZ6z6AA1I5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046171; c=relaxed/simple;
	bh=eQ/auliW0EgsQFJFA6Mf9gTsQnbW6DmSQUwyvcEerUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IpPPFcIdiLjtOqh7Avp7xatH6qb0zV7pu2x2La1DTy5fBbPnLu0nQckD2PSjb/O6fmKFk27mlCqvtnyKhgup5uUieIJQll6nEOe2Zh5jtNi9zt+heL2KHUhpe47e/OX2ep1rjni7Zc4TEclk0QJy+wXlpiHLLVRVyjqufsmhUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BQb9i57x; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ee12baa01cso11784575ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715046169; x=1715650969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXKXTMdz9nysIbdQG1zSA/joXoCHsq9b8pUEu+GCNMk=;
        b=BQb9i57xAk0NXg2YkrzfI4POLLD0LM0BxUmX3BkE5RWOSTwFl1Cj396Et99HaagfMg
         Ujp4JEt52iyUDlDnKm7Lq3BAhKF4lgl6oxwPViSVJ/tBxeIWS+gAEjkF3/JfFeLKf0RL
         DhiaIlLMcieAY0oK73vNL5ADXziMHMGH12AmfjY6oW1eY+a4u7aoJ0mEmG6pVC3YB2FB
         YzeHBK0rnuKIY5SwBbl2TipjUQaPyafBQU4Uy/yMbc05zatBjbIMnxoxzkPbws3P1ZlI
         j+RK4rPM4sxEjNGolSrXnbxw9vN35DkDc5DoBsgStPgCFCO24HEGKxcwBWLcyjC+N53Y
         qSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715046169; x=1715650969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXKXTMdz9nysIbdQG1zSA/joXoCHsq9b8pUEu+GCNMk=;
        b=FV8hAml7UOOH40Y4Y0Dbo/CUoYsBMPVtydfhQtNPxreiBHimJUxR+FfM60ser8Z+or
         9SPyaRNVxcUlruyYD9KmmWKoCC08Nih2wxk5IfZWHoVwzm9kf1mFUFxENVcUCPKbL+qp
         4zXKwVnS0VpewN1dr/++3LovMrJNP7WBPd7llMh3VlsVWHo6qLvO8e59tbVxz1plCtlD
         nD2FQ7bYGMJgcHuUp09aUn3mxdvIKLtLQwuO3nDWvnDXLe55gD+hCyqTsl4QMBIGMWcP
         kp++Nxy9+xiKugjswig0+ukRlRqJQ4lA5TtYnPV7e8Z0cZPT4JrMzNvhEYqHkRr1SnWB
         hWpA==
X-Forwarded-Encrypted: i=1; AJvYcCVKQQv1moE2YL86tOQgMI5xxl7mUVRdr7O9xJAEMm/VA72bDfq5R6Vf/CgZOwYYuTJzlJZusBzJZEVCtkOb6Wvt89IlVfEHM/SnvcJD
X-Gm-Message-State: AOJu0YwmbLi3qKGwl5tw5QhYI7mWEiGY6eyt7pXd1mqFK/VRC8uoX4E8
	z5isRRsbVsOTb4POx/7Oi8DI+blqFHwvGj7oh3MJxNRSBSygDxFZD3QzMKTKWAI=
X-Google-Smtp-Source: AGHT+IF6/gGCNdZiWcJ7b5sARR/Cl9CrTBBYDbYOTX+T8auqpQE7eGTz774kKNo5c4AGtbXQtPQoWA==
X-Received: by 2002:a17:903:2344:b0:1ec:2bca:5aa8 with SMTP id c4-20020a170903234400b001ec2bca5aa8mr15677736plh.6.1715046168896;
        Mon, 06 May 2024 18:42:48 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b001eb3f705ddasm8915311plx.255.2024.05.06.18.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 18:42:48 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 06 May 2024 18:40:47 -0700
Subject: [PATCH 6/8] riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBA Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-compile_kernel_with_extensions-v1-6-5c25c134c097@rivosinc.com>
References: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
In-Reply-To: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Song Liu <song@kernel.org>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715046158; l=3133;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=eQ/auliW0EgsQFJFA6Mf9gTsQnbW6DmSQUwyvcEerUY=;
 b=vVbDWRSZVIHXc2jHg45d5wTT9RTY8XfHDD54NysNRPTWOX9vMbhQ8oCTTttPVmWoqwt9Opkb6
 cUbZF8aoSHaB+t6aIHAZdk7a8PV5YfPobXzlJvvLJWdyZ9gtfm0r4tO
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Zba can optimize kernel instruction sequences. Add a config option
PLATFORM_SUPPORTS_RISCV_ISA_ZBA that allows arbitrary Zba instruction
sequences to be emitted by the compiler.

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
index 934e20de576b..0ab4cc5dfffb 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -67,6 +67,7 @@ riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
 riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_C)	:= $(riscv-march-y)c
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_V)	:= $(riscv-march-y)v
+riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBA)	:= $(riscv-march-y)_zba
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB)	:= $(riscv-march-y)_zbb
 
 ifdef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC

-- 
2.44.0


