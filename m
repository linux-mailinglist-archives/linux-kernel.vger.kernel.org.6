Return-Path: <linux-kernel+bounces-568806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC19A69A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9234239EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0570B219A67;
	Wed, 19 Mar 2025 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="FS5rfi6e"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA62135DE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418612; cv=none; b=XtuLqJNs/NAy2li2qTFfomsXiZMZPkftB4UCjs25DLNBLWYSdkbLCPRhKvLPkG/s4UxzaJHIU/VcE3nWoY2M82RUz4NSJcBp7y7dCZDOBFAxqywVditqQ3lJkTmMf/FhVyl63E06MMDbNZ+4NlYoZDSvTXuJ42e2FfJ6DgdUs4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418612; c=relaxed/simple;
	bh=M1E3rlnRjg7zgjLtIZW+R/MLyP34kXkWb7jHt9CA/kQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZO9c29jVB7zugDJ+r50sxjfuBgERSgboU4mqWjd787XKXJn59JO6kD2Q0776jrwMJIsaLaumjjFuR3ChyEIAaaPpsZS1YoSq3OXlv6aO+bqXYk2YyI5PYXUD2C218Te9FWqmhtUi7EKYBBt6sf8Dx+q8KinL5COHAF+fa1fQwm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=FS5rfi6e; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1742418608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Z50bW4uP9y2NKyrA9FP3XB/KfgBiP1prO7EaYYpM7k=;
	b=FS5rfi6eUGa/2hpZla7vnwITZrOXs+XRdMr6mlvKgJNk6Qr44UPCas73LB4AcuXWld+pW/
	cp2JPl5Oa+q8yXmOif+e5ckr2qqvvtwhyDlEUAakiy8GhLiNu0n4aiZYZ5DLoVUH89QO++
	HJKsd3Z7Tb+GVk+ri/QsrfN4iFusXN5hEjEFiBOTS/9KsWJC5amy9mwxm0t6NTjdDCJXhV
	ByOcT9GAKgvTuKNUGscSqUapyddmwmSa7TlMw1SPSvvEdKH3LU54peCmTlON0CwjrluyEX
	pKreqAzF7js4T9HI5VSdxHyVc1idbvf+aWHGLv/sreortH8410YYlIAjHCSX+w==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Wed, 19 Mar 2025 22:09:46 +0100
Subject: [PATCH v2 2/2] riscv: introduce asm/swab.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-riscv-swab-v2-2-d53b6d6ab915@iencinas.com>
References: <20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com>
In-Reply-To: <20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 linux-arch@vger.kernel.org, Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

Implement endianness swap macros for RISC-V.

Use the rev8 instruction when Zbb is available. Otherwise, rely on the
default mask-and-shift implementation.

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
 arch/riscv/include/asm/swab.h | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/riscv/include/asm/swab.h b/arch/riscv/include/asm/swab.h
new file mode 100644
index 0000000000000000000000000000000000000000..6cb40e8108c956dd445746d59bc1dd0a53475212
--- /dev/null
+++ b/arch/riscv/include/asm/swab.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_SWAB_H
+#define _ASM_RISCV_SWAB_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <asm/alternative-macros.h>
+#include <asm/hwcap.h>
+#include <asm-generic/swab.h>
+
+#if defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE)
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

-- 
2.48.1


