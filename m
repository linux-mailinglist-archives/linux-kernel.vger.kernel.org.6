Return-Path: <linux-kernel+bounces-555192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10076A5A6B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1951893688
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4A21E520E;
	Mon, 10 Mar 2025 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="N28ATju+"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D271E2834
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644258; cv=none; b=iEKUOOkrICn3Z5+S2bB84j9ZWwT7+YvJ19OakRCKhME3gMkAe+IBNe9JcLyoUTV3RdQBU768mnXwlKk83nYlVKpzl1PuxwTEcyFM88Wqbo+sp0ALfZBLft7Ydbuan2TVS0yLkEzakcz7BZwJXW9bBn28D0b7qrgrarX/Rab5a0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644258; c=relaxed/simple;
	bh=FrKlVPINhgHm/qZYxoAI2bxJmn4MPARDw9Qn5DJ1fRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XLKvXauWnRBOTBTy+rzH//f3AfZc2oNM+L7LZ+muE3menMLDHxFYXCP8mtBJtFwM1JH0KQKrjPW/VAfaWxJpj6mPIsO9LBWSQ8VNtM5CVlnaCswrpfWq+yqPKHRHSFYM2nbJfvqy8IoMuBk6jXNsbSIzdq5ulUlkEgH92Uu1DzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=N28ATju+; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1741644253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vMEhOW9fgJPCr4InVKo09seDTKCph02bUyGs2pruQNI=;
	b=N28ATju+SsOf5mOLkX4xSXH0ni5rpddkGVzQ0AFC5fZJcs6P9VO9pz7SF8qelSzN+l2NqC
	8kfjOzO5vJk/0dupShTH1+xEiBt1YfuUS0lNDnS+CaDl5gjrC+TAduQkxHPxR2JbuBY8dT
	j2wlpSllboIUsJ5sIPqcjTn/9mOURqWUOYZ6c/TGMSauNtDAR5erQ72gz/Td0PRtI7fBEn
	BD3YkUwNcoep0OKwNa9/4u5ftcPliRRNb65AdzzivcwQbINktEq+ujn/vjK1IGQJi8uvsS
	UnVv0QwKNYfl9M/wc/mFp+6ZjOaSkFGFYRITqUfIkQrcf5YsCIKSgtLPRhqhWQ==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Mon, 10 Mar 2025 23:03:55 +0100
Subject: [PATCH RFC] riscv: introduce asm/swab.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-riscv-swab-v1-1-34652ef1ee96@iencinas.com>
X-B4-Tracking: v=1; b=H4sIAMphz2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNz3aLM4uQy3eLyxCTdJAvDJEuTRMvEZMMkJaCGgqLUtMwKsGHRSkF
 uzkqxtbUAh1/042EAAAA=
X-Change-ID: 20250307-riscv-swab-b81b94a9ac1b
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

Implement endianness swap macros for RISC-V.

Use the rev8 instruction when Zbb is available. Otherwise, rely on the
default mask-and-shift implementation.

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
Motivated by [1]. A couple of things to note:

We need a default implementation to fall back on, but there isn't any in
`asm-generic/swab.h`. Should I introduce a first patch moving 
___constant_swab<XX> into include/uapi/asm-generic/swab.h?

I don't particularly like the ARCH_SWAB macro but I can't think of
anything better that doesn't result in code duplication.

Tested with crc_kunit as pointed out here [2]. I can't provide
performance numbers as I don't have RISC-V hardware yet.

Ccing everyone involved with [1].

[1] https://lore.kernel.org/all/20250302220426.GC2079@quark.localdomain/
[2] https://lore.kernel.org/all/20250216225530.306980-1-ebiggers@kernel.org/
---
 arch/riscv/include/asm/swab.h | 81 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/riscv/include/asm/swab.h b/arch/riscv/include/asm/swab.h
new file mode 100644
index 0000000000000000000000000000000000000000..8f8a13b343f6ffbefbb3c7747ab4e14243852014
--- /dev/null
+++ b/arch/riscv/include/asm/swab.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_SWAB_H
+#define _ASM_RISCV_SWAB_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <asm/alternative-macros.h>
+#include <asm/hwcap.h>
+
+#if defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE)
+
+/*
+ * FIXME, RFC PATCH: This is copypasted from include/uapi/linux/swab.h
+ * should I move these `#defines` to include/uapi/asm-generic/swab.h
+ * and include that file here and in include/uapi/linux/swab.h ?
+ */
+#define ___constant_swab16(x) ((__u16)(				\
+	(((__u16)(x) & (__u16)0x00ffU) << 8) |			\
+	(((__u16)(x) & (__u16)0xff00U) >> 8)))
+
+#define ___constant_swab32(x) ((__u32)(				\
+	(((__u32)(x) & (__u32)0x000000ffUL) << 24) |		\
+	(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |		\
+	(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |		\
+	(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
+
+#define ___constant_swab64(x) ((__u64)(				\
+	(((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |	\
+	(((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |	\
+	(((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |	\
+	(((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |	\
+	(((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |	\
+	(((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |	\
+	(((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |	\
+	(((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
+
+#define ___constant_swahw32(x) ((__u32)(			\
+	(((__u32)(x) & (__u32)0x0000ffffUL) << 16) |		\
+	(((__u32)(x) & (__u32)0xffff0000UL) >> 16)))
+
+#define ___constant_swahb32(x) ((__u32)(			\
+	(((__u32)(x) & (__u32)0x00ff00ffUL) << 8) |		\
+	(((__u32)(x) & (__u32)0xff00ff00UL) >> 8)))
+
+
+#define ARCH_SWAB(size) \
+static __always_inline unsigned long __arch_swab##size(__u##size value) \
+{									\
+	unsigned long x = value;					\
+									\
+	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,			\
+			     RISCV_ISA_EXT_ZBB, 1)			\
+			     :::: legacy);				\
+									\
+	asm volatile (".option push\n"					\
+		      ".option arch,+zbb\n"				\
+		      "rev8 %0, %1\n"					\
+		      ".option pop\n"					\
+		      : "=r" (x) : "r" (x));				\
+									\
+	return x >> (BITS_PER_LONG - size);				\
+									\
+legacy:									\
+	return  ___constant_swab##size(value);				\
+}
+
+#ifdef CONFIG_64BIT
+ARCH_SWAB(64)
+#define __arch_swab64 __arch_swab64
+#endif
+
+ARCH_SWAB(32)
+#define __arch_swab32 __arch_swab32
+
+ARCH_SWAB(16)
+#define __arch_swab16 __arch_swab16
+
+#undef ARCH_SWAB
+
+#endif /* defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE) */
+#endif /* _ASM_RISCV_SWAB_H */

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250307-riscv-swab-b81b94a9ac1b

Best regards,
-- 
Ignacio Encinas <ignacio@iencinas.com>


