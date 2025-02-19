Return-Path: <linux-kernel+bounces-521013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA284A3B2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E3F3A9BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C71C3029;
	Wed, 19 Feb 2025 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bFlXS0yS"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2AF1C3C05
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950870; cv=none; b=QzFUCDLOUEa/yaQXO7iQqwfbdmBkvEKk7/E4vrM1bUrYTYAJfQTZfHBk3qL/R3CS1qkWkG7WbmujZPqvoEJMetypzywipAYHd07d6hWz7KqR0o3WNVENCPItxUvXnh7BS4IDpaBLRP0zgt+E3LNq+8qcHIVx/sgHxv83VnPthI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950870; c=relaxed/simple;
	bh=MYOB0khx0BDtse/zgJNeZZJiRFCMhoUVzEaJYI7/5V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YVmHXRfb4vP6f7coEvXMInHE334xttUPV93yIG0R0fcWwee2MgB1in+5EXU9LzBR0/BGXGWurgrPSRczVjwqz44yuLEUJB6pvQqfVV6Lbx4p2IABe3VVGZV0fpsxi4j2tK/z2zqbBPiup0ZViJs9v5uOaTDFCGw7/F018FTbmRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bFlXS0yS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-221057b6ac4so66658265ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739950866; x=1740555666; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4D7y6vS16TntjY0YVJnY/KjcZrZYq5GD7J9zG5joEhE=;
        b=bFlXS0ySvSBxHBpbaA4my5QAa9RLf1srurAm+t1WGkVgCpgBjVEQ7MACKeJl2RIiOj
         YGy6BccrWa6cUOW/Np+mHBGqZacfs1Toy9UYz4bB884iX/33wWNys9caUY035A58dWpz
         1ZKRCOgsdp0diQfMGwG07X69JXDIomS868R4KVB4gH6PN0sfQRRYYLbazk4B/bxySuyc
         Tx1Bv3CRZQNw6Zabh677RFOSLO8/2AtfEm6P2XooHhw83qwaT6wjl4bdwPzJ8O2oVQGJ
         tjizTpPpak3zAPtKj3x0bnIm53xfIzsLd8uvQ80/z7bdI9zOrF92gM4V5dikVD1hwzMP
         c3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739950866; x=1740555666;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4D7y6vS16TntjY0YVJnY/KjcZrZYq5GD7J9zG5joEhE=;
        b=nvZ5bXUr1qN+TsH3X/bRVWCB20GC8oLr1C5U5O1AMO3XQ6b4SeiYfGlEA4u1MrKb69
         7kXmQc1DX//xlKRCyEimHXyUk8bawiKI6gwEZFpHEK8fN4llhPZdRo0Qd6687Ib8x9yu
         mJhowWws4OoCLNR6aQ1ZfNO33Hy55YQZ+yHJdHrH+frtOMYgKbnjRdpFWrscEgEJevuL
         vM0RU/yIDbNLcnINIsePSe3DZ4xOh0gLNo6sZ+Uhqf/DWKqm3wahcwcMgmChxoJ4X04P
         ++qqhKPLQ82SXSS2SPegB5YqVEPR7LmMp2F0HmN3FXTcbezKmfzE1xkCU8XdjxVck1nY
         U0/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHesjnUdk2WRD7aH/W3WuWsNXGy/XFgrrIkmGDExVSg+r+stkAoWPoiIuOnzVklJtUuUQuVC5ud6P3LiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9okKYn7AxKKiUpfInVQFhGjDzpII0BSGWo2BGHRjm6whcJFp2
	Wcyflb7oezR9nNkSULUGKOhWDFJYVXgEdgoZuA5fC49HtVzkMflQHOSmaA/nx6s=
X-Gm-Gg: ASbGncuMimW+oybaYHjlcADV8Utm/9c/l+5rsfrKTje5MEMI3FVirlUgm9y1Bav+SRK
	GNLQskoqB/OZKg39a9LHHWOEtIEX1UWOnPt1RdDN4R65HcsdH7Uu7o0y4/JPjqebCYD1eMvfo91
	r3TMEDG+WWLrovNQtPbno6AZ9vK1/stsOLpDS8AxDwBxlXOMXLXh20E0Ct/RHyksX23DmqaWAjA
	GVby92s9Cnvb6KeFwX8qLWg8k3dPibmNAICMd/Jrhik22ZqJqVXiYiVyDi+KlSoMT0SKTI54JXT
	I3DbasGg/U6TTckr4Nt22V8w3VMhRsw=
X-Google-Smtp-Source: AGHT+IFmiJi7J7X4Vt+HFBMldT3EXMtD1dMAZlaKQ7wSwbNyKAWSa3LFDvQ+uRmfz14Ze+9kO46U5w==
X-Received: by 2002:a05:6a00:1707:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-732617999d0mr32185682b3a.8.1739950865754;
        Tue, 18 Feb 2025 23:41:05 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327fa51eb9sm4875266b3a.166.2025.02.18.23.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:41:04 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 18 Feb 2025 23:40:56 -0800
Subject: [PATCH v7] riscv: Add runtime constant support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-runtime_const_riscv-v7-1-e431763157ff@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAAeLtWcC/43QwWrDMAwG4FcpPi/DkmI73mnvMUaJHXX1ocmwM
 7NR8u5TC2OB+bDjL9An8V9V4Zy4qKfDVWWuqaRlluAeDiqex/mNuzRJVqjRaEDq8se8pgsf4zK
 X9ZhTibWzcRpMz4wDOCWb75lP6fOuvrxKPqeyLvnrfqTCbfrjuaZXoYPOeRM0Eo+ow3NOdSlpj
 o9xuagbWfEfDArjzcgunrwbyTcY2jNDmyFhADyiHzzjRA2m3zGk20wvjGzb2ENwwccGY34Z1O2
 uqxEmRAuO7EjyU4OxOwawzVhhiE8aehsI/lS8bds3oFo00BwCAAA=
X-Change-ID: 20250123-runtime_const_riscv-6cd854ee2817
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Pasha Bouzarjomehri <pasha@rivosinc.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12420; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=MYOB0khx0BDtse/zgJNeZZJiRFCMhoUVzEaJYI7/5V4=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/rWbq7zewOenGbbOXu9nN5hxluGVdmT11iWXNvMH7dHg
 fXZxI1xHaUsDGJcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEzk63aG/z7HPmvamx/d/2Bn
 ocuD44tuXheZXb/hW82nS6/uunb12ssxMnyTP8084dSz77+eyt6rn2cuY/xEROev3JorHBP4Wup
 eN/MDAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Implement the runtime constant infrastructure for riscv. Use this
infrastructure to generate constants to be used by the d_hash()
function.

This is the riscv variant of commit 94a2bc0f611c ("arm64: add 'runtime
constant' support") and commit e3c92e81711d ("runtime constants: add
x86 architecture support").

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Ard brought this to my attention in this patch [1].

I benchmarked this patch on the Nezha D1 (which does not contain Zba or
Zbkb so it uses the default algorithm) by navigating through a large
directory structure. I created a 1000-deep directory structure and then
cd and ls through it. With this patch there was a 0.57% performance
improvement.

[1] https://lore.kernel.org/lkml/CAMj1kXE4DJnwFejNWQu784GvyJO=aGNrzuLjSxiowX_e7nW8QA@mail.gmail.com/
---
Changes in v7:
- Added benchmarking info
- Added CONFIG_RISCV_ISA_ZBA and CONFIG_RISCV_ISA_ZBKB to check that the
  compiler supports the extensions.
- Link to v6: https://lore.kernel.org/r/20250212-runtime_const_riscv-v6-1-3ef0146b310b@rivosinc.com

Changes in v6:
- .option arch only became officially supported by clang in version 17.
  Add a config to check that and guard the alternatives uses .option
  arch.
- Link to v5: https://lore.kernel.org/r/20250203-runtime_const_riscv-v5-1-bc61736a3229@rivosinc.com

Changes in v5:
- Split instructions into 16-bit parcels to avoid alignment (Emil)
- Link to v4: https://lore.kernel.org/r/20250130-runtime_const_riscv-v4-1-2d36c41b7b9c@rivosinc.com

Changes in v4:
- Add newlines after riscv32 assembler directives
- Align instructions along 32-bit boundary (Emil)
- Link to v3: https://lore.kernel.org/r/20250128-runtime_const_riscv-v3-1-11922989e2d3@rivosinc.com

Changes in v3:
- Leverage "pack" instruction for runtime_const_ptr() to reduce hot path
  by 3 instructions if Zbkb is supported. Suggested by Pasha Bouzarjomehri (pasha@rivosinc.com)
- Link to v2: https://lore.kernel.org/r/20250127-runtime_const_riscv-v2-1-95ae7cf97a39@rivosinc.com

Changes in v2:
- Treat instructions as __le32 and do proper conversions (Ben)
- Link to v1: https://lore.kernel.org/r/20250127-runtime_const_riscv-v1-1-795b023ea20b@rivosinc.com
---
 arch/riscv/Kconfig                     |  22 +++
 arch/riscv/include/asm/runtime-const.h | 254 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/vmlinux.lds.S        |   3 +
 3 files changed, 279 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e35607f1dd4603a596416d3357a71..c123f7c0579c1aca839e3c04bdb662d6856ae765 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -783,6 +783,28 @@ config RISCV_ISA_ZBC
 
 	   If you don't know what to do here, say Y.
 
+config TOOLCHAIN_HAS_ZBKB
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbkb)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbkb)
+	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZBKB
+	bool "Zbkb extension support for bit manipulation instructions"
+	depends on TOOLCHAIN_HAS_ZBKB
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	   Adds support to dynamically detect the presence of the ZBKB
+	   extension (bit manipulation for cryptography) and enable its usage.
+
+	   The Zbkb extension provides instructions to accelerate a number
+	   of common cryptography operations (pack, zip, etc).
+
+	   If you don't know what to do here, say Y.
+
 config RISCV_ISA_ZICBOM
 	bool "Zicbom extension support for non-coherent DMA operation"
 	depends on MMU
diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
new file mode 100644
index 0000000000000000000000000000000000000000..5430cdffc4a14a6551342b48d94d37d99b8d775a
--- /dev/null
+++ b/arch/riscv/include/asm/runtime-const.h
@@ -0,0 +1,254 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_RUNTIME_CONST_H
+#define _ASM_RISCV_RUNTIME_CONST_H
+
+#include <asm/alternative.h>
+#include <asm/cacheflush.h>
+#include <asm/text-patching.h>
+#include <linux/uaccess.h>
+
+#ifdef CONFIG_32BIT
+#define runtime_const_ptr(sym)					\
+({								\
+	typeof(sym) __ret;					\
+	asm_inline(".option push\n\t"				\
+		".option norvc\n\t"				\
+		"1:\t"						\
+		"lui	%[__ret],0x89abd\n\t"			\
+		"addi	%[__ret],%[__ret],-0x211\n\t"		\
+		".option pop\n\t"				\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		: [__ret] "=r" (__ret));			\
+	__ret;							\
+})
+#else
+/*
+ * Loading 64-bit constants into a register from immediates is a non-trivial
+ * task on riscv64. To get it somewhat performant, load 32 bits into two
+ * different registers and then combine the results.
+ *
+ * If the processor supports the Zbkb extension, we can combine the final
+ * "slli,slli,srli,add" into the single "pack" instruction. If the processor
+ * doesn't support Zbkb but does support the Zbb extension, we can
+ * combine the final "slli,srli,add" into one instruction "add.uw".
+ */
+#define RISCV_RUNTIME_CONST_64_PREAMBLE				\
+	".option push\n\t"					\
+	".option norvc\n\t"					\
+	"1:\t"							\
+	"lui	%[__ret],0x89abd\n\t"				\
+	"lui	%[__tmp],0x1234\n\t"				\
+	"addiw	%[__ret],%[__ret],-0x211\n\t"			\
+	"addiw	%[__tmp],%[__tmp],0x567\n\t"			\
+
+#define RISCV_RUNTIME_CONST_64_BASE				\
+	"slli	%[__tmp],%[__tmp],32\n\t"			\
+	"slli	%[__ret],%[__ret],32\n\t"			\
+	"srli	%[__ret],%[__ret],32\n\t"			\
+	"add	%[__ret],%[__ret],%[__tmp]\n\t"			\
+
+#define RISCV_RUNTIME_CONST_64_ZBA				\
+	".option push\n\t"					\
+	".option arch,+zba\n\t"					\
+	"slli	%[__tmp],%[__tmp],32\n\t"			\
+	"add.uw %[__ret],%[__ret],%[__tmp]\n\t"			\
+	"nop\n\t"						\
+	"nop\n\t"						\
+	".option pop\n\t"					\
+
+#define RISCV_RUNTIME_CONST_64_ZBKB				\
+	".option push\n\t"					\
+	".option arch,+zbkb\n\t"				\
+	"pack	%[__ret],%[__ret],%[__tmp]\n\t"			\
+	"nop\n\t"						\
+	"nop\n\t"						\
+	"nop\n\t"						\
+	".option pop\n\t"					\
+
+#define RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+	".option pop\n\t"					\
+	".pushsection runtime_ptr_" #sym ",\"a\"\n\t"		\
+	".long 1b - .\n\t"					\
+	".popsection"						\
+
+#if defined(CONFIG_RISCV_ISA_ZBA) && defined(CONFIG_RISCV_ISA_ZBKB)
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
+		ALTERNATIVE_2(						\
+			RISCV_RUNTIME_CONST_64_BASE,			\
+			RISCV_RUNTIME_CONST_64_ZBA,			\
+			0, RISCV_ISA_EXT_ZBA, 1,			\
+			RISCV_RUNTIME_CONST_64_ZBKB,			\
+			0, RISCV_ISA_EXT_ZBKB, 1			\
+		)							\
+		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#elif defined(CONFIG_RISCV_ISA_ZBA)
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
+		ALTERNATIVE(						\
+			RISCV_RUNTIME_CONST_64_BASE,			\
+			RISCV_RUNTIME_CONST_64_ZBA,			\
+			0, RISCV_ISA_EXT_ZBA, 1				\
+		)							\
+		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#elif defined(CONFIG_RISCV_ISA_ZBKB)
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
+		ALTERNATIVE(						\
+			RISCV_RUNTIME_CONST_64_BASE,			\
+			RISCV_RUNTIME_CONST_64_ZBKB,			\
+			0, RISCV_ISA_EXT_ZBKB, 1			\
+		)							\
+		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#else
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
+		RISCV_RUNTIME_CONST_64_BASE				\
+		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#endif
+#endif
+
+#ifdef CONFIG_32BIT
+#define SRLI "srli "
+#else
+#define SRLI "srliw "
+#endif
+
+#define runtime_const_shift_right_32(val, sym)			\
+({								\
+	u32 __ret;						\
+	asm_inline(".option push\n\t"				\
+		".option norvc\n\t"				\
+		"1:\t"						\
+		SRLI "%[__ret],%[__val],12\n\t"			\
+		".option pop\n\t"				\
+		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		: [__ret] "=r" (__ret)				\
+		: [__val] "r" (val));				\
+	__ret;							\
+})
+
+#define runtime_const_init(type, sym) do {			\
+	extern s32 __start_runtime_##type##_##sym[];		\
+	extern s32 __stop_runtime_##type##_##sym[];		\
+								\
+	runtime_const_fixup(__runtime_fixup_##type,		\
+			    (unsigned long)(sym),		\
+			    __start_runtime_##type##_##sym,	\
+			    __stop_runtime_##type##_##sym);	\
+} while (0)
+
+static inline void __runtime_fixup_caches(void *where, unsigned int insns)
+{
+	/* On riscv there are currently only cache-wide flushes so va is ignored. */
+	__always_unused uintptr_t va = (uintptr_t)where;
+
+	flush_icache_range(va, va + 4*insns);
+}
+
+/*
+ * The 32-bit immediate is stored in a lui+addi pairing.
+ * lui holds the upper 20 bits of the immediate in the first 20 bits of the instruction.
+ * addi holds the lower 12 bits of the immediate in the first 12 bits of the instruction.
+ */
+static inline void __runtime_fixup_32(__le16 *lui_parcel, __le16 *addi_parcel, unsigned int val)
+{
+	unsigned int lower_immediate, upper_immediate;
+	__le32 lui_res, addi_res;
+	u32 lui_insn, addi_insn;
+
+	lui_insn = (u32)le16_to_cpu(lui_parcel[0]) | (u32)le16_to_cpu(lui_parcel[1]) << 16;
+	addi_insn = (u32)le16_to_cpu(addi_parcel[0]) | (u32)le16_to_cpu(addi_parcel[1]) << 16;
+
+	lower_immediate = sign_extend32(val, 11);
+	upper_immediate = (val - lower_immediate);
+
+	if (upper_immediate & 0xfffff000) {
+		/* replace upper 20 bits of lui with upper immediate */
+		lui_insn &= 0x00000fff;
+		lui_insn |= upper_immediate & 0xfffff000;
+	} else {
+		/* replace lui with nop if immediate is small enough to fit in addi */
+		lui_insn = 0x00000013;
+	}
+
+	if (lower_immediate & 0x00000fff) {
+		/* replace upper 12 bits of addi with lower 12 bits of val */
+		addi_insn &= 0x000fffff;
+		addi_insn |= (lower_immediate & 0x00000fff) << 20;
+	} else {
+		/* replace addi with nop if lower_immediate is empty */
+		addi_insn = 0x00000013;
+	}
+
+	addi_res = cpu_to_le32(addi_insn);
+	lui_res = cpu_to_le32(lui_insn);
+	patch_insn_write(addi_parcel, &addi_res, sizeof(addi_res));
+	patch_insn_write(lui_parcel, &lui_res, sizeof(lui_res));
+}
+
+static inline void __runtime_fixup_ptr(void *where, unsigned long val)
+{
+#ifdef CONFIG_32BIT
+		__runtime_fixup_32(where, where + 4, val);
+		__runtime_fixup_caches(where, 2);
+#else
+		__runtime_fixup_32(where, where + 8, val);
+		__runtime_fixup_32(where + 4, where + 12, val >> 32);
+		__runtime_fixup_caches(where, 4);
+#endif
+}
+
+/*
+ * Replace the least significant 5 bits of the srli/srliw immediate that is
+ * located at bits 20-24
+ */
+static inline void __runtime_fixup_shift(void *where, unsigned long val)
+{
+	__le16 *parcel = where;
+	__le32 res;
+	u32 insn;
+
+	insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
+
+	insn &= 0xfe0fffff;
+	insn |= (val & 0b11111) << 20;
+
+	res = cpu_to_le32(insn);
+	patch_text_nosync(where, &res, sizeof(insn));
+}
+
+static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
+				       unsigned long val, s32 *start, s32 *end)
+{
+	while (start < end) {
+		fn(*start + (void *)start, val);
+		start++;
+	}
+}
+
+#endif /* _ASM_RISCV_RUNTIME_CONST_H */
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 002ca58dd998cb78b662837b5ebac988fb6c77bb..61bd5ba6680a786bf1db7dc37bf1acda0639b5c7 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -97,6 +97,9 @@ SECTIONS
 	{
 		EXIT_DATA
 	}
+
+	RUNTIME_CONST_VARIABLES
+
 	PERCPU_SECTION(L1_CACHE_BYTES)
 
 	.rel.dyn : {

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250123-runtime_const_riscv-6cd854ee2817
-- 
- Charlie


