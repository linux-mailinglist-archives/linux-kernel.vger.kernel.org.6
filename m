Return-Path: <linux-kernel+bounces-511819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246FBA33022
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978D6162172
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A281FFC6F;
	Wed, 12 Feb 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QPDeYVXM"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514E1FCF62
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389892; cv=none; b=q318O2/AtSRbQo3R06udVfwYu3Cjq/+mLUzfne1Jw+cONrUFFjUvmxyN7/oS2dIf5LwS2hPrAzh1HCzFZuIZsXR55Q5PW+mKtHBNOp/IAIxFdQ4YI+f7Bo/TzFmx7q84iR00HeTvmwDhY90Rh9rwo9UkYRwQZmzlluHixAN4tkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389892; c=relaxed/simple;
	bh=v5gi1ISZVSBvQPGrj1374pYnd52LCsULqEAMuTZuSsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YPCQ2MPXNvPI0QsAxbUSwJ2tLiE7OIPVHsoK74d4MwT2jMggU/MgOI8cL2Zlt8+Kz+2nTQVtHv6hskad5reBSxlpWc++JvvlH6mBhJKU0LvCCrM2e92Ht9WVWyFcyqTNoaXeInXYE508Ija54PUd+U8AoqakJYlU49Rmdg94y+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QPDeYVXM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f818a980cso564035ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739389889; x=1739994689; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3amVsx8Ci03zXdDpEUIaq7SCAMVrHBBM+qenXfv5ZR4=;
        b=QPDeYVXMNHsyNrbZEhDMQSeuGrkuTB1zP8ayCbDoYLY73f+bj1o8yS6HMv8FnAsiGS
         bej+SnLO152sFXyiw+8IkSnGrK0xlX6//u53Ug97pSCALr2BYKLutzqO0cBVW7SR2D9R
         o+64TGLpZFrZkvVh3Z3kJmLpcDizyk4U6DPY7EYWZiqzuPH8G+s/soilDWI40rNjczqF
         8SP8LvOBtjqqGeX3zs6u6R/+eMtEUqUMVp5NTJS++L9HL2fAOpKNdYXnPWTVDJXbS+St
         kqgdM1lkvT20Jq6PssXayW6MiW4TfI4G9thRVGIiLGp1I9rDnsgcpyaTHwtDF6cr2hby
         0Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739389889; x=1739994689;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3amVsx8Ci03zXdDpEUIaq7SCAMVrHBBM+qenXfv5ZR4=;
        b=U6GpdjTBS/YOY+F6uDJKtPi2dGUqWWujvlUOSZXdBRDtsowWEy3nIpLGK7gURVJI57
         tqmMhlNi48Y49D0Bv/uAOR/5TUGMJkIasMnefeRhs9r6tD2g31rAGfUM4YUWHVfSQ5pJ
         WNEOxevPYnVAQ5ATExoabzMxBa4p5hznPqFBa2S1x9NqBhIZ240HF9SWTxXfxGvytyO8
         cKZ2VclkrDzklEOH152kF1yJUxxBR0fE9i+qPzExJMZoq2j4jN5V/WW7UpH/vkHHfRsB
         J9FzD4u0cBwxF0xO8/BZPzZ4bQX5417SgQ93vNutZfIOqPaQQcIsLmlpCw+Cmish8b2L
         tljw==
X-Forwarded-Encrypted: i=1; AJvYcCWbMZnp49sOVqEfUixQOmIhjc8cAgtHGWWo5RhdwLSVpfpSlulY2fgQbwbZpAPTPy2vy55QAbxUYOOEn8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhwxooCgh6uOAHRPXrjk48N8qqgvhgCpNrz5dvO6NnZHHdiez8
	9TXdYbG3H3TlUFQuU9MyE9SBBRGGbKw/sH50V9TOuToIXaUJCM+marYxF/wwNLo=
X-Gm-Gg: ASbGncutZZdHvXI3mNrV1iQ5B0usarJDgLc/FsdC9L5erx43RZHAf3KqqqW/b7I6jfj
	IJ9xVSegmjX6kUBxlhqQbHvfMhn+CPfTFAaSDajSVvc9kwrm/KkF7/4IyBc1aO2Iv32nOPjbMUU
	fo2aZf1qRU5ge6Yi4QqB4PsR4Qa5HsBjSoyxZlEnADnogt5A/tCrYlGvl0HUpPrkHbz2Icl51Bz
	Nuu4B/YyV37VfajvsiySYClGGj60RxSL2+BvSl1xnM+o25lgABy/6ydyGcE2kSfKpiNHffWcX1s
	poi8qOah90n1SRWsFX2JWxeq4z6t3/M=
X-Google-Smtp-Source: AGHT+IEEvEByzP+UwvSlz3Wl3sMSsMOYf2t2jQTgZm9hPz6gNFn/8KomqHQP45IN8uMvN0dOsI3hJQ==
X-Received: by 2002:a05:6a20:db0c:b0:1d9:2b51:3ccd with SMTP id adf61e73a8af0-1ee5c733420mr9638478637.7.1739389889379;
        Wed, 12 Feb 2025 11:51:29 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad555e8f22bsm4594772a12.68.2025.02.12.11.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:51:27 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 12 Feb 2025 11:51:17 -0800
Subject: [PATCH v6] riscv: Add runtime constant support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-runtime_const_riscv-v6-1-3ef0146b310b@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIALT7rGcC/43QwWoDIRAG4FcJnmvRcdW1p75HKEHdSeMhWnQrK
 WHfvZNAaSgeevwH/m+GubKGNWFjL7srq9hTSyVTME87Fk8+vyNPC2UGArSQoHj9zGs64yGW3NZ
 DTS12buIy6wkRZmkZNT8qHtPlru7fKJ9SW0v9ui/p8jb98ezQ65JLbp0OAhR6EOG1pl5ayvE5l
 jO7kR3+wQAxTnu08eisV27AqEdmHjOKGCkdgJsdwqIGzPTAKDFmJmKobeIkgw0uDhj9y4AY/7p
 rYkI00irjFd30h9m27Rtj5UV71QEAAA==
X-Change-ID: 20250123-runtime_const_riscv-6cd854ee2817
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Pasha Bouzarjomehri <pasha@rivosinc.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10462; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=v5gi1ISZVSBvQPGrj1374pYnd52LCsULqEAMuTZuSsw=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/qa3zs/+Jpxrzr78cYcw/9ajYsvhAmb9FY3z3cv2L/06
 wEHxt2hHaUsDGJcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAExkqzfD/4DcS+4lWVpxrhuV
 lqfw8aQqngv1apnt9j133v37PRqC2Qx/eLkPtq/ykyrlFT35KMeIY73/vMKY8F3y2iXi6R4Vq4L
 ZAA==
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

[1] https://lore.kernel.org/lkml/CAMj1kXE4DJnwFejNWQu784GvyJO=aGNrzuLjSxiowX_e7nW8QA@mail.gmail.com/
---
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
 arch/riscv/Kconfig                     |   5 +
 arch/riscv/include/asm/runtime-const.h | 223 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/vmlinux.lds.S        |   3 +
 3 files changed, 231 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d4a7ca0388c071b536df59c0eb11d55f9080c7cd..f4722fb1f529b433e60ccf096b0b60ff328744e5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -229,6 +229,11 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE
 	def_bool CC_IS_GCC
 	depends on $(cc-option,-fpatchable-function-entry=8)
 
+config CC_SUPPORTS_ASM_ARCH
+	def_bool y
+	#https://github.com/llvm/llvm-project/commit/9e8ed3403c191ab9c4903e8eeb8f732ff8a43cb4
+	depends on !CC_IS_CLANG || CLANG_VERSION >= 170000
+
 config HAVE_SHADOW_CALL_STACK
 	def_bool $(cc-option,-fsanitize=shadow-call-stack)
 	# https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e6eeb51f0cb7b8819e50da6d2444d769
diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
new file mode 100644
index 0000000000000000000000000000000000000000..77f55201e97cd7640a902cb833ccdcaceb925005
--- /dev/null
+++ b/arch/riscv/include/asm/runtime-const.h
@@ -0,0 +1,223 @@
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
+#ifdef CONFIG_CC_SUPPORTS_ASM_ARCH
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(".option push\n\t"					\
+		".option norvc\n\t"					\
+		"1:\t"							\
+		"lui	%[__ret],0x89abd\n\t"				\
+		"lui	%[__tmp],0x1234\n\t"				\
+		"addiw	%[__ret],%[__ret],-0x211\n\t"			\
+		"addiw	%[__tmp],%[__tmp],0x567\n\t"			\
+		ALTERNATIVE_2(						\
+			"slli	%[__tmp],%[__tmp],32\n\t"		\
+			"slli	%[__ret],%[__ret],32\n\t"		\
+			"srli	%[__ret],%[__ret],32\n\t"		\
+			"add	%[__ret],%[__ret],%[__tmp]\n\t",	\
+			".option push\n\t"				\
+			".option arch,+zba\n\t"				\
+			"slli	%[__tmp],%[__tmp],32\n\t"		\
+			"add.uw %[__ret],%[__ret],%[__tmp]\n\t"		\
+			"nop\n\t"					\
+			"nop\n\t"					\
+			".option pop\n\t",				\
+			0, RISCV_ISA_EXT_ZBA, 1,			\
+			".option push\n\t"				\
+			".option arch,+zbkb\n\t"			\
+			"pack	%[__ret],%[__ret],%[__tmp]\n\t"		\
+			"nop\n\t"					\
+			"nop\n\t"					\
+			"nop\n\t"					\
+			".option pop\n\t",				\
+			0, RISCV_ISA_EXT_ZBKB, 1			\
+		)							\
+		".option pop\n\t"					\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"		\
+		".long 1b - .\n\t"					\
+		".popsection"						\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#else
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(".option push\n\t"					\
+		".option norvc\n\t"					\
+		"1:\t"							\
+		"lui	%[__ret],0x89abd\n\t"				\
+		"lui	%[__tmp],0x1234\n\t"				\
+		"addiw	%[__ret],%[__ret],-0x211\n\t"			\
+		"addiw	%[__tmp],%[__tmp],0x567\n\t"			\
+		"slli	%[__tmp],%[__tmp],32\n\t"			\
+		"slli	%[__ret],%[__ret],32\n\t"			\
+		"srli	%[__ret],%[__ret],32\n\t"			\
+		"add	%[__ret],%[__ret],%[__tmp]\n\t"			\
+		".option pop\n\t"					\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"		\
+		".long 1b - .\n\t"					\
+		".popsection"						\
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
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250123-runtime_const_riscv-6cd854ee2817
-- 
- Charlie


