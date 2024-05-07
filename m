Return-Path: <linux-kernel+bounces-170565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F658BD928
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD251F2371A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8555F4F208;
	Tue,  7 May 2024 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Jyh4IHac"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488B3BB3D
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046172; cv=none; b=Qkt4b79CNn7etCH+8BOkudckFf4apYbJKIM1oNXe3VbhwWz+mozj/dbmhm5Usnqs+tx1W8d4F+LHC3xkfcCVA/9r1Cmik8Kh3Ux/rKYjkSvtkbdcHcAD9lPRP1rbXPGPlYnfMYpjm3hfQI06Ln4Xm7Kkex4cUCpTx5988Chs25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046172; c=relaxed/simple;
	bh=yS+zKcRdHLA3uaeN6uPi5O7/8wOCzM0M3jPlowSQyzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFHvK7AL/YZHgxZlVTWjHeyyB/SVcnNw/h1EkpcIfIiMYVywr/y0MoFZZ2lwwzpEmNeV+QCYOlswXPqNK2PvlhF4Q6Ztb5YaQKzH0UXQx8X9O9MG8+jXYYq6FuMi74amczziZHcKjZjfbRTgyQD0b3hZ0QaSejx6cmFoifpg31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Jyh4IHac; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1eab16c8d83so19205555ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715046171; x=1715650971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCTzqIps+ZkkY2OB8nLwr+KIJ7vqS249dCWRcdyLtRQ=;
        b=Jyh4IHacpORsEiEyP/vP9vRQ8aByMewS89MNu7qKn5dJF9qY3nmvJk2N6VMG/7YZAz
         qToUQrHaPJPBcn2Fq1wsPGJielYhVo5tG/0khP/SOcho6afQGpdtLHIJObFFTXAlbXPl
         w/4scfSMTVuB5QKGJW1SL3gHsQ3jcvqQ0x1GtpJBjAmXBNccxGRMHWse+uQYLvtVWcOb
         z0OH+2KB59uDWo6CroQeMB9cvKbaS1ytQfZlpymxNTJfRHJNU+mawXz1PrCL2iE45Tez
         /LOy9KjvXoRf3Ae5xHW950Si45bSHqQ0lpGMJmjt0YpN0wlyPuDgITQjOVR0/Hge3luY
         wMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715046171; x=1715650971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCTzqIps+ZkkY2OB8nLwr+KIJ7vqS249dCWRcdyLtRQ=;
        b=nEu8XPXzPfTdQFZ3+/ncPNQAYu4ZzzbDvEh7Cb8Dj6qJMRcqBLa6pkVwFr3d7Qmtvr
         3K3KwMH457HCibkRRnK5LAvpGpK1ZoGZXiNfM3eX6bgwWeGjm/3nIzSuF+23pv9sbUyS
         riNbmYYpTKZhh36kzzlf76tgE7qcfx3c9+Bjx4bx2AlcoHSG49ZJ/hDAqJcCCNmFSAVR
         Ey8gcLkyY3OeMIPnDwmq6Zx3PWrI5SBDNCxqWrk+0rUvhsBH0r3Q+unaCfc3hXN1Z+Wm
         3yKuNhKWBIDRiGiW3jyoYmDEDaTHbTOVbiolSCUtYFMltMf5QGh79ghw6rbzDk1UT+dR
         /qGg==
X-Forwarded-Encrypted: i=1; AJvYcCW0h/Rc72eJFq5N/tvmOaAIVSJHd1NNzeoYjXjrVXkK8c4lsgXN5JaYt9l7rRlGpvQv3Wr3/Rd1dpiTFEx2y62fEVmIslKLWrjGYpvC
X-Gm-Message-State: AOJu0YzGfXd4lhSjTQo+2gSW64nrSCR9moAw1fM8uv2PoR4KRHO3miJD
	hqfVSZukxsEJO5CujRcM8DohxhLw9DmGQdmhHncqCxUxB4WQPVgpOubIh3BjXrA=
X-Google-Smtp-Source: AGHT+IFcNj1lxhLTwHPlCK4GlMUj4Rw8hbj32zTfxKPPgwKugeGp2LOBvsLjEjT1lRXdW+vSCTVKLw==
X-Received: by 2002:a17:903:2b07:b0:1e4:c8b3:dbaf with SMTP id mc7-20020a1709032b0700b001e4c8b3dbafmr13911614plb.33.1715046170305;
        Mon, 06 May 2024 18:42:50 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b001eb3f705ddasm8915311plx.255.2024.05.06.18.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 18:42:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 06 May 2024 18:40:48 -0700
Subject: [PATCH 7/8] riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBC Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-compile_kernel_with_extensions-v1-7-5c25c134c097@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715046158; l=3081;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=yS+zKcRdHLA3uaeN6uPi5O7/8wOCzM0M3jPlowSQyzw=;
 b=xjEaBxuq9R3saXEJW38LF+s1vw2phgumpvArnblkck0B5vgdDCTA1Fh0JjuHtzXSFyGm8yXBo
 S623mMD7ghMCkD+Oo1IlBznEsB7pihM0BXEqJS/GNaia3IW3xpzsUVf
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Zbc can optimize kernel instruction sequences. Add a config option
PLATFORM_SUPPORTS_RISCV_ISA_ZBC that allows arbitrary Zbc instruction
sequences to be emitted by the compiler.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig.isa | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/riscv/Makefile    |  1 +
 2 files changed, 52 insertions(+)

diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
index e7f28dc44137..b7399f236bba 100644
--- a/arch/riscv/Kconfig.isa
+++ b/arch/riscv/Kconfig.isa
@@ -289,3 +289,54 @@ config PLATFORM_SUPPORTS_RISCV_ISA_ZBB
 	  systems that do not support the Zbb extension.
 
 endchoice
+
+config TOOLCHAIN_HAS_ZBC
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbc)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbc)
+	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZBC
+	bool
+
+choice
+	prompt "Zbc extension for bit manipulation instructions support"
+	default PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBC
+	help
+	  This selects the level of support for Zbc instructions to be
+	  built into the Linux Kernel. This does not impact whether Zbc
+	  instructions are allowed to be emitted by user-space code.
+
+	  The Zbc extension provides instructions to accelerate carry-less
+	  multiplication.
+
+config PROHIBIT_RISCV_ISA_ZBC
+	bool "Prohibit Zbc instruction sequences"
+	depends on NONPORTABLE
+	help
+	  Regardless of if the platform supports Zbc instructions,
+	  prohibit the kernel from emitting Zbc instructions.
+
+config PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBC
+	bool "Allow Zbc instruction sequences if supported"
+	depends on TOOLCHAIN_HAS_ZBC
+	depends on RISCV_ALTERNATIVE
+	select RISCV_ISA_ZBC
+	help
+	  Add support for enabling optimisations in the kernel when the
+	  Zbc extension is detected at boot.
+
+config PLATFORM_SUPPORTS_RISCV_ISA_ZBC
+	bool "Emit Zbc instructions when building Linux"
+	depends on TOOLCHAIN_HAS_ZBC
+	depends on NONPORTABLE
+	select RISCV_ISA_ZBC
+	help
+	  Adds "zbc" to the ISA subsets that the toolchain is allowed to emit
+	  when building Linux, which results in Zbc instructions in the
+	  Linux binary. This option produces a kernel that will not run on
+	  systems that do not support the Zbc extension.
+
+endchoice
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 0ab4cc5dfffb..30be0fec976a 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -69,6 +69,7 @@ riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_C)	:= $(riscv-march-y)c
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_V)	:= $(riscv-march-y)v
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBA)	:= $(riscv-march-y)_zba
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB)	:= $(riscv-march-y)_zbb
+riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBC)	:= $(riscv-march-y)_zbc
 
 ifdef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 KBUILD_CFLAGS += -Wa,-misa-spec=2.2

-- 
2.44.0


