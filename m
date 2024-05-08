Return-Path: <linux-kernel+bounces-172605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB7D8BF42B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871D2B22733
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9FE168CC;
	Wed,  8 May 2024 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vQ1Ztv9e"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AE12E70
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132215; cv=none; b=bMJBVx6kOCa54Xvhnt9qteqBkYOulC3c1M1Ex68MDxUrL+hkZEh1cgLEVYK6nQTKSjoXBBDOz4up9BprU8ci89yPyG74EUl8IsBL8LvMrbztp3QapV5/z3qhARb14KyZr/JWUSM6fWqyeWN6BiJ3AODkhnMM8H6PZl+svLSw928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132215; c=relaxed/simple;
	bh=7B3II1X/5OVe4Mrr/uSiLQQPEgDk0UMK2lq4VVxpgKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JUpTFuXJMYYmeoa1gY52W5QKB+HBe+1GkaMscfaOorvkyrW+2saEFtKTKdZ2GwYaWaENZW1x97UiG+gmdrS9lxzCCImJoXBtXld3FFQaLW65qEdt0nhi8GiG7287pHwmgLMb6JkshX+EpEf4qOmINB4TStNPzzh7zTYR79ICX5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vQ1Ztv9e; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so2756322b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715132213; x=1715737013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSebZNH2K21s8abZJ+EPitFsmRQfB0232RHZtpEHlvw=;
        b=vQ1Ztv9eid0UwJLSrsbdU0A4oB1CdmH2XL6L9wz1mVyY3eELA/EnF8oZfw4qaWrwVi
         5kucwQdvN2h2LfATn4shur9HNhW0uM0l5H65ep960r3Mwik7Z/bGfReZekjIXp1zQR08
         DZm4YNzljYb0R+5IYc+IzfC9RWvjriCTMU6LEiDA96wEga7a+wdAJ65gA0MJB4tQeXlw
         z+h0QdhCUmTMzTQ03Tz7FyNJW+FNFINvhTx+rt8XWb3IS84GAH/tO2oSWihI90aaFVCN
         kDfnH88GTmWH2J3uDGgBeJW2jL3xq3ZkAtVunsgOWe6n7rT/LaZ418iZf0+70BqxHxKy
         1EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132213; x=1715737013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSebZNH2K21s8abZJ+EPitFsmRQfB0232RHZtpEHlvw=;
        b=WAmZp/VxJy8cUEpV1nnJaji6t352Y+/fmi83Awr1jnxNz1kh9zyTPgFuw6Yy2plG0L
         DBxk/T3jjzhAz+R0TlkLG9ILXXW5i6/cI75NAImbqBvIYNvDSn7KUfHwt9F65l9r1UVR
         EvWYAAtKKCobIsItUdkwV4w07HqvLoGkgzY0By+MslqrEgu2p/jJPuhHc0Wiy37lrLb8
         IJvWB6fDI7dZxjKouGwza2EbAX+1epsdMhjz9Tkvne4v17zK1dC3H5pH981h/Q9yY0/Z
         VpCgluyXyTQ1qCK3j87zQgxjlSIgRNGzl+rTzdQsLMORPi7HivbB9xrgxULDgs3UlG36
         raBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwXRShZGVQriDtkeF+freaBXhMDDhOmVjgOZktzIxHxhqNRCkKw4Z7qJBui6n+lW+ceMvN74zDYbao6kMQGoK6FU5UytynS79rW5p9
X-Gm-Message-State: AOJu0YwXtOPUwrE4fGKe9avm/pujzLFMFGjR8B9ZEIocX9QK3lcRN8SE
	ky3LaMc+yPBZ0Lq8in+uDXBXsMEnZE+++zSS39eSU14ole4aHNysuiHuN7Gy/zg=
X-Google-Smtp-Source: AGHT+IHg6ptW80TJdWpfJCJXopHCGmFJ2iuPtPmC3dzzLoosh6XalLDn4t3j0emDTqeCUhoduvuo/g==
X-Received: by 2002:a05:6a20:1001:b0:1a9:c80a:c152 with SMTP id adf61e73a8af0-1afc8d763c8mr1324536637.21.1715132213554;
        Tue, 07 May 2024 18:36:53 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a265sm171994a91.10.2024.05.07.18.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:36:52 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 May 2024 18:36:34 -0700
Subject: [PATCH v2 8/8] riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBS Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-compile_kernel_with_extensions-v2-8-722c21c328c6@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715132198; l=3277;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=7B3II1X/5OVe4Mrr/uSiLQQPEgDk0UMK2lq4VVxpgKM=;
 b=BOORKVGo69HF+7q44TCG43/RRTkpsAJGBawNHVFpF9jkZ7wAN2u8vXOHTvuJ13Qg1B+/ol51J
 6rief9SvltyDHEUzuVdcAQrC2MGCzumWPDi5HvHzyzoB8a1cNpdR4Vo
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Zbs can optimize kernel instruction sequences. Add a config option
PLATFORM_SUPPORTS_RISCV_ISA_ZBS that allows arbitrary Zbs instruction
sequences to be emitted by the compiler.

The existing "RISCV_ISA_ZBS" option is repurposed to be used to by kernel
code to determine if either PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBS or
PLATFORM_SUPPORTS_RISCV_ISA_ZBS has been set.

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
index 57457d15e9a4..80ff8503196a 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -69,6 +69,7 @@ riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_C)	:= $(riscv-march-y)c
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBA)	:= $(riscv-march-y)_zba
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB)	:= $(riscv-march-y)_zbb
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBC)	:= $(riscv-march-y)_zbc
+riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBS)	:= $(riscv-march-y)_zbs
 
 ifdef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 KBUILD_CFLAGS += -Wa,-misa-spec=2.2

-- 
2.44.0


