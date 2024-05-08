Return-Path: <linux-kernel+bounces-172604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BB58BF42A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA92B21BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46A014A90;
	Wed,  8 May 2024 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tapD0THj"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B811CB4
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132214; cv=none; b=TGhtX4fWk8y+ab+zhB9mjU/fZIV3yFkeuYEscc2VMx/NqedkU00WYt0AlSrTV2KlciwxoxWP+xcvPogJv1R7jYz/n1cAglml//lm//bP9CsmtHCnxUl/9X8FUqFA1U6tv+yqrC4og7uWki4b/GCyY1tZpEPfImx1lADxUJtskq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132214; c=relaxed/simple;
	bh=mhWqJj1RP0LVjsRT3VtWySRs+UTs7hL4pCht9UF8zQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bmjvBWIjxaVcKZ4vzsDiDWXvUK7me6wPW7yw+BY+t73eT/SmYvNNCG9euO/02VIWzdHC+kg3mvg67l/xQGtYMzwngCiuLBJSBH3Oll8CkmmL9tqKerGa1IBE+NzCA2u4nrHHyiQrikPclaR0CVZ9njpNq5Oj4j6KLngdZzHleNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tapD0THj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ac9b225a91so2707638a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715132212; x=1715737012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G63nKFkjY3qHnS0X1QIzt6sf9vbSpbh90Xj2nxjAK3E=;
        b=tapD0THj+sAOFGVZM/hZBlylZnmyshZjORu+OQca3qCaz08VtS40b8BFFqBtFygGb1
         dUqMI3LSmXdsA9SmfyJ84V72cbwBGrCZj4LaDBFeL5iS0PBmZnTXLqUTzrIr3cb9qo8F
         7YaJi82P/lm5VgoWl5ayeGe7LA990PgNQV2X39Z8G1KNumkbnOuXUoKE4MiDiKZuZLJi
         u7gNB8F3bqZduw07dj86HZf9RN/KdGmP+laZYuKz6Az4sXfPQOpCoxssL0u+wesw4SwU
         PE/PAQ4ip+DE5E/OZO1yFu5K8Uc8malwDEilU1GC/97dLFoKmv/5OuOrllUwuLyJKqxU
         IZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132212; x=1715737012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G63nKFkjY3qHnS0X1QIzt6sf9vbSpbh90Xj2nxjAK3E=;
        b=EsgoaBgRqLkApd0alMM7FwTJWzbj3BlMilwAlXW4esVYN1SSWLnzgiDkmZCT7/gnRI
         uOxrs0vs7G/5zt5X3XCEx2Ge8qJ7LOsPa5y2q36HMTQJAv8RVOUwby1e8Jnuw0u6ssJO
         x8NbKzKKm1t1epX/2tYa8Xirf/OM4B5mb3F1/YYefzBycnjyaX1ZulviqhPzpzvBJ/rA
         TTiU9O7yczXkzVLPk9WdWKWpOHFcIuY372gmyGrAxL08qLagOwKqnvcp8c8zSNv/4T4P
         4f3pAbMzg9ief62oFJMpn6sidzdtwJFohH7NJxpOR/6UdBr/zRCzlZ7hv2ka59EXLvJG
         l6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFW84qqYumgjvSFMMCULgimbOeb+0/CGKVgDjTkhVF/wMncnVR8/tYUh4iDyBegRBgwOR12pRsF+I5e0L9jxL1sQPysUoy3BT4eaUQ
X-Gm-Message-State: AOJu0Yx3UBZGfiN1aEjLoNzohyiklOGOZkKefvcuEJ0CxuX995qGUg6F
	rupuDNzZWBvx1zsoyIWbmK2e/W5UJDlqFqbllXeyVsrICXbxqZywAGeUQkE6Rwg=
X-Google-Smtp-Source: AGHT+IFiGPyl3zNyE/SYLjw5BlcdAyzafc6IKgnN2PalwWvftlru0VCVPMVwGkF+0UEGKI78AFsrvQ==
X-Received: by 2002:a17:90a:5d06:b0:2b2:7c42:bf6e with SMTP id 98e67ed59e1d1-2b6165aa078mr1175508a91.12.1715132211950;
        Tue, 07 May 2024 18:36:51 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a265sm171994a91.10.2024.05.07.18.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:36:51 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 May 2024 18:36:33 -0700
Subject: [PATCH v2 7/8] riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBC Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-compile_kernel_with_extensions-v2-7-722c21c328c6@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715132198; l=3248;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=mhWqJj1RP0LVjsRT3VtWySRs+UTs7hL4pCht9UF8zQ0=;
 b=sOz5JQJkzaPJCxTxqkvkSdeiQG9Ioekkp/cr6I56ZbEo4JJzatL3p2LLjxH4sfk9h/40qVxWB
 OEQki4PEQ2ECjcdqQ6LE0ponkjrcIiw/2Oy+cAKFQ+URoJ4CqY/pRsA
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Zbc can optimize kernel instruction sequences. Add a config option
PLATFORM_SUPPORTS_RISCV_ISA_ZBC that allows arbitrary Zbc instruction
sequences to be emitted by the compiler.

The existing "RISCV_ISA_ZBC" option is repurposed to be used to by kernel
code to determine if either PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBC or
PLATFORM_SUPPORTS_RISCV_ISA_ZBC has been set.

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
index c8ec38b9880a..57457d15e9a4 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -68,6 +68,7 @@ riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_C)	:= $(riscv-march-y)c
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBA)	:= $(riscv-march-y)_zba
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB)	:= $(riscv-march-y)_zbb
+riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBC)	:= $(riscv-march-y)_zbc
 
 ifdef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 KBUILD_CFLAGS += -Wa,-misa-spec=2.2

-- 
2.44.0


