Return-Path: <linux-kernel+bounces-170566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1DC8BD929
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B49DDB2308F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000B751C5E;
	Tue,  7 May 2024 01:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="go1yy0vT"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C84436
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046174; cv=none; b=ApZMtKoSl8zSwqVEF7Lcg3WYPSu76G06f5TWdl9Igd0iFTqjoohnfaumMsRWCL+KHlXX0yDsvwxvbTLpGL4c77H5mL5U5/Mto8Y+9/ELD2BzXILjvtY7Sunv86JGC8sTUjbAa0AcSLXnm8gr2rrdBa+ZI2AJJpN53CXIsDaQgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046174; c=relaxed/simple;
	bh=VSGPqebqjCkV+Jce+IU74T8AjKJ/iHF/vPW/Bia4uwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHAhgwXYiom0J6XnPwhMQMkS9x7re69S2ynoHX3usuVsF7GUgzektQObtPSIrw0fskKgcZlVNSNUEdJFg42dAtcoQ551IdmBAbx9yTga1BDnOMDx4zB6cGNHsNvP+9wub5zdm8mpkbWn9Ir7TluoSi9QtcYno7OiUkwKpy+n9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=go1yy0vT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee12baa01cso11784775ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715046172; x=1715650972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mrbuhf8lERW/x3AUUGdC3eD15JM+519sglQ52hQ7AhA=;
        b=go1yy0vThAgUZcD/bru6iM6pLf2hX1j+rb8s2D0IJ6dkJlILEwQcnlGfZhEDDGRP5N
         1FsW/RT84KrOHlnHjY4fT8nNOdkjT6YQmSIzMqC1FjHA+3034now014CU8l068auMv3P
         p3pcTP1eAdAY8UvtbHiRZ1Aw5tbSpI5tjHFCruKHpFH/gY6kxDuoiiBMZmgndHpDzmlG
         UW7lFNSwQGV2yZQ+9Gy81jJa3UB1kVe951eMZ7/WOjE57p7uYFpDGWzI9L7gd1LCiJHC
         fPvI2f8LTJdmuaPqlakFbpQhUUPX6WqK50F95naTXYxTDZtVd5G2fqNsRcXHTBQLPU7q
         ALdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715046172; x=1715650972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mrbuhf8lERW/x3AUUGdC3eD15JM+519sglQ52hQ7AhA=;
        b=YqxCWliBL3w5+UyoznsWTJp3ce1gVleX2rDeAB8UZUWAZ0qvMRuay1OkzmtkQx2YxN
         bVx6gT+WRnYlg3CCTQcvLCFY7rcmHbYVj2ILzP8WQOOpB7OY4k479rl4/puC3O8ceSn7
         2kQeVt/HSBKNepmmWLea6+LjH8e5DJ/wqcYzaCAwSXxOmc8kd7aN0ApVEbZu2gmmsOlq
         VHwVrDiWJk7hLRknk7GdEcGvne3BA/BTYEU8aYatZqSVhoYzjM9apecgkwRlIufu+r1F
         lStrN6EjKHcDvmZHwVWw+T5HSPQkH18t6MBk4g7kDlawAc0DJs4enm44qIDJBQ4R+e9D
         xsUA==
X-Forwarded-Encrypted: i=1; AJvYcCXp96XV1fqLVDcBLn4uLs/xacH4tXYIWi/Yq8twQ0QolawzzOrv7w5GBfC6W2Z1u2QpPbrfXAdMW8TLsUmRYFB/tzITd/UXMilKdrSt
X-Gm-Message-State: AOJu0YznTTwxqJhtn1Mwx1HK3Y4A2yysa6Vohwl1CgcdhoaEALQXanT0
	BV9vIFdFU/f1XWFXdkqIqgZec4ReIGQaDlsE0LhsaC1ZzIsefo+bWXEI8E5SQAY=
X-Google-Smtp-Source: AGHT+IGF+LSyNFek/MjWREJIb2DvsG1B8cdEZTM4HWcwxV91ymmqopcN94RSVuM+E6tI2esVsff8YA==
X-Received: by 2002:a17:902:e548:b0:1e5:5ccd:30e1 with SMTP id n8-20020a170902e54800b001e55ccd30e1mr13723687plf.65.1715046171913;
        Mon, 06 May 2024 18:42:51 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b001eb3f705ddasm8915311plx.255.2024.05.06.18.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 18:42:51 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 06 May 2024 18:40:49 -0700
Subject: [PATCH 8/8] riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBS Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-compile_kernel_with_extensions-v1-8-5c25c134c097@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715046158; l=3086;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=VSGPqebqjCkV+Jce+IU74T8AjKJ/iHF/vPW/Bia4uwk=;
 b=PDnuVsyyK0HUPATpcCiqShVPqzG7qsmDrxcNZxQQptU20Eb8nLdqbPfj2AbCgNK4RPsM26oGZ
 gmZwE2MylTPC4jC6xpkZtKachs4HLLUOAvrnLkA+xKmCeSbzFLq0q8f
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Zbs can optimize kernel instruction sequences. Add a config option
PLATFORM_SUPPORTS_RISCV_ISA_ZBS that allows arbitrary Zbs instruction
sequences to be emitted by the compiler.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig.isa | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/riscv/Makefile    |  1 +
 2 files changed, 52 insertions(+)

diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
index b7399f236bba..60ae1bf71c70 100644
--- a/arch/riscv/Kconfig.isa
+++ b/arch/riscv/Kconfig.isa
@@ -340,3 +340,54 @@ config PLATFORM_SUPPORTS_RISCV_ISA_ZBC
 	  systems that do not support the Zbc extension.
 
 endchoice
+
+config TOOLCHAIN_HAS_ZBS
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbs)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbs)
+	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZBS
+	bool
+
+choice
+	prompt "Zbs extension for bit manipulation instructions support"
+	default PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBS
+	help
+	  This selects the level of support for Zbs instructions to be
+	  built into the Linux Kernel. This does not impact whether Zbs
+	  instructions are allowed to be emitted by user-space code.
+
+	  The Zbs extension provides instructions to accelerate carry-less
+	  multiplication.
+
+config PROHIBIT_RISCV_ISA_ZBS
+	bool "Prohibit Zbs instruction sequences"
+	depends on NONPORTABLE
+	help
+	  Regardless of if the platform supports Zbs instructions,
+	  prohibit the kernel from emitting Zbs instructions.
+
+config PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBS
+	bool "Allow Zbs instruction sequences if supported"
+	depends on TOOLCHAIN_HAS_ZBS
+	depends on RISCV_ALTERNATIVE
+	select RISCV_ISA_ZBS
+	help
+	  Add support for enabling optimisations in the kernel when the
+	  Zbs extension is detected at boot.
+
+config PLATFORM_SUPPORTS_RISCV_ISA_ZBS
+	bool "Emit Zbs instructions when building Linux"
+	depends on TOOLCHAIN_HAS_ZBS
+	depends on NONPORTABLE
+	select RISCV_ISA_ZBS
+	help
+	  Adds "zbs" to the ISA subsets that the toolchain is allowed to emit
+	  when building Linux, which results in Zbs instructions in the
+	  Linux binary. This option produces a kernel that will not run on
+	  systems that do not support the Zbs extension.
+
+endchoice
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 30be0fec976a..7519b68c3bd5 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -70,6 +70,7 @@ riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_V)	:= $(riscv-march-y)v
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBA)	:= $(riscv-march-y)_zba
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB)	:= $(riscv-march-y)_zbb
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBC)	:= $(riscv-march-y)_zbc
+riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBS)	:= $(riscv-march-y)_zbs
 
 ifdef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 KBUILD_CFLAGS += -Wa,-misa-spec=2.2

-- 
2.44.0


