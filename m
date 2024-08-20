Return-Path: <linux-kernel+bounces-293975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC55D958720
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7934B281CED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE75190049;
	Tue, 20 Aug 2024 12:37:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDAF18F2F9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157460; cv=none; b=pNy28GKSIIYPKmIuKMbQbfpZe3T/z4X9t3LfdbcJqrJ1u1GHE1iINGs+k53uQuRvfY6uXvUmOlF6WN4LesG2wwHgTeqQ3iel9O88V9UYQYiOQIlIz9n8h4jpZ+/zjMM2mAw5yAWzKT94nIRjvLfNZmUP3Wel3H+FpKnn5bD07fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157460; c=relaxed/simple;
	bh=sRePvfj/oJ6v8RUicxjMB9eW5qwEBHExj2tE1CepU8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHqmAkvbSSEWFV4m62hI0Z5ukT2sUTqh0qDTt3eDeNj3xuLRTjOq6DNH08RB+W3n2jJaOSa3nVc3gkah/32bG9bjXgbRvfLoJ/QCmRgncJ0wkNXN03VolkoGQrFDJbIYAwlrQDhMaAmtgs6Dt4sVG4ulIYe7mvsAT1/UrU2ZIWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx65oQjsRmxSYaAA--.20476S3;
	Tue, 20 Aug 2024 20:37:36 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxkeEMjsRmL5MbAA--.56855S3;
	Tue, 20 Aug 2024 20:37:33 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] LoongArch: Define barrier_before_unreachable() as empty
Date: Tue, 20 Aug 2024 20:37:30 +0800
Message-ID: <20240820123731.31568-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240820123731.31568-1-yangtiezhu@loongson.cn>
References: <20240820123731.31568-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxkeEMjsRmL5MbAA--.56855S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr43Gr1rWw43tw45Kr43XFc_yoW5KF43pF
	nFvryDGr4kWrs7Cw17t345ur45Aw4kCF4agry8Xa4UZFy5Xw1ktwn7KrW7JFyjgws2grW0
	gF1fG34YgF48JabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUc0eHDUUUU

When building kernel with -Os (CONFIG_CC_OPTIMIZE_FOR_SIZE=y) rather
than the default -O2 (CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set),
there exist many objtool warnings "unreachable instruction", this is
because objtool couldn't find a code path to reach the instruction,
objdump shows that the unreachable instruction is related with BUG()
or unreachable().

In include/linux/compiler-gcc.h, there is an empty inline assembly

  #define barrier_before_unreachable() asm volatile("")

in the definition of unreachable() to work around GCC 7.0 after the
commit 173a3efd3edb ("bug.h: work around GCC PR82365 in BUG()") in
the year of 2018, the unreachable instruction is generated by it.

As far as I can see, this workaround is to fix warnings of frame sizes,
the default CONFIG_FRAME_WARN is 2048 on 64 bit system now, it seems
that there are no -Wframe-larger-than warnings in the current kernel
without this workaround.

I am not sure whether the GCC bug has been fixed, I can not find the
fixup in the link https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365
and in the GCC repo. So I am not sure whether it is time and proper
to remove this workaround in the common header totally, just remove
it in the arch specified header when compiling kernel with a newer
GCC version (for example GCC 12.1 or higher on LoongArch) at least.

For example:
arch/loongarch/kernel/cpu-probe.o: warning: objtool: cpu_probe+0x664: unreachable instruction

objdump -M no-aliases -D arch/loongarch/kernel/cpu-probe.o

Without this patch:

0000000000000000 <cpu_probe>:
 ...
 65c:   44000d80        bnez            $t0, 12 # 668 <.L345^B1+0x4>

0000000000000660 <.L10001^B2>:
 660:   002a0001        break           0x1

0000000000000664 <.L345^B1>:
 664:   53ff63ff        b               -160    # 5c4 <.L344^B1>
 668:   0280040c        addi.w          $t0, $zero, 1
 66c:   00006d8d        cpucfg          $t1, $t0

With this patch:

0000000000000000 <cpu_probe>:
 ...
 65c:   44000980        bnez            $t0, 8  # 664 <.L345^B1>

0000000000000660 <.L10001^B2>:
 660:   002a0001        break           0x1

0000000000000664 <.L345^B1>:
 664:   0280040c        addi.w          $t0, $zero, 1
 668:   00006d8d        cpucfg          $t1, $t0

Cc: stable@vger.kernel.org # 6.9+
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407221208.6SSBeN9H-lkp@intel.com/
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig                |  1 +
 arch/loongarch/include/asm/compiler.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 arch/loongarch/include/asm/compiler.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 70f169210b52..3af0da76d103 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -102,6 +102,7 @@ config LOONGARCH
 	select GPIOLIB
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN
diff --git a/arch/loongarch/include/asm/compiler.h b/arch/loongarch/include/asm/compiler.h
new file mode 100644
index 000000000000..4f6adb8d533e
--- /dev/null
+++ b/arch/loongarch/include/asm/compiler.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_COMPILER_H
+#define _ASM_COMPILER_H
+
+#ifdef barrier_before_unreachable
+#undef barrier_before_unreachable
+#define barrier_before_unreachable() do { } while (0)
+#endif
+
+#endif /* _ASM_COMPILER_H */
-- 
2.42.0


