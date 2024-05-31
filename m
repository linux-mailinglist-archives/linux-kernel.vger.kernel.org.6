Return-Path: <linux-kernel+bounces-197142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F78D66B9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0CB1F23470
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A512158D78;
	Fri, 31 May 2024 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="m0mKu5CV"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E615623B
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172622; cv=none; b=U9mFEIedmvrR4hYwPh72t6pojaoFV72U3fTLXJ5by7B8hDrscAFaQBoq1YubYNxtOlFGsImV3kkM7mgY5NESGXcauQAG2x3MVKzCWRbtUpyuQDNM8iAWdNZzBY9qDZP3cLjzgib+R/YslYjJNmIa5HNJ3zXVd5yK+OVv8ElRRYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172622; c=relaxed/simple;
	bh=bIfxEfz4EBdKnjco6iVqwTUBBvuXdTOs9eUQkf5mKfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfzPpGA7uvvn3PvN9DSCgAJCop2psFte8yVUcudO9q3hpehdH8h213XUj0s4tz4n8Z0jkopM1FII9isaDCS3yzHvjybHCxdOFQpYSYQ+VLWZlNVwszFjvRPSL6c13I3b5Zg3dCao6gZycfYYsNOQeKvb6ADBrIARz9pZ24/NmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=m0mKu5CV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7024d560b32so438007b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717172619; x=1717777419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rsKkVgyABm2zSwFdUDJOXq7adWq0Ho5JZ/Z2NJ4mJiU=;
        b=m0mKu5CVn+pLzVMcwdpFvKkTQ6WrMVuUpfbhqh4KWOF6uV10ceMpG6B4AGWH5AgwFM
         ua2279BSwFHUeI/FK2ngex6MBuhEK+RpZa4XZ6+kZZuqj8f5wntudyAFwyXTAN8jKlTm
         L98Hcg7lsqTbz3DqW7o4owIkKw89qY9u4fMYl7jlphdBupl5T6IAxaZDoKktM4U6P+57
         yjST7Oarp5tVf0KnBq9gUYo8eHxowCjlSvoLQkeGTkpXSFwwfA6BCSGRMdGB+6WcfXbM
         M40Zang0vzVqsTI2I9rGmJZac0+XpcUM93XgIWe1S2m1f398R/iX8e+8kNCQ+093YgTT
         FGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717172619; x=1717777419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsKkVgyABm2zSwFdUDJOXq7adWq0Ho5JZ/Z2NJ4mJiU=;
        b=H0YDnCtp0yT0XfYK0bvnxL3j8vUqfRp8ZgAK0sBMPZyHC8RR6avrsygVNk0picGS9y
         sdvf+nPBFRoIVG/Oe+J6vpDuJKiRtmegf8Cy7uMM9ZOVh8wTw99Qq2wvMOvPb/Lh9n08
         zBqOqtoX7uwnNSR50dZrDaTPBQgeNyl8rvRPnJblNxdZGAH5h3YgBCBl1abPyeY8OrIL
         /yMURHJcdZh2TrIfXD88Vqa02NL7kKxm6wjzLBDrH8M0GI+Mb8PWmLZiaTwLWFU3OPnI
         7HWQvLNf6nPBP6oqxUVOnQGvj0wzC7ArnEGMSyLpAuGyau7EGFbMBFdgcN03hqhd7nKO
         wtCQ==
X-Gm-Message-State: AOJu0YyVAwmq+vyRpSVKPf7YYq7wN48WEP0cGYCVpYnqm+SROVOUa5UN
	YobYKsQiv94I0TfXTJ0BQkQvyTBS+rBT1HOLj5KN4v1NymakOmwNo2Kw8t077Pw=
X-Google-Smtp-Source: AGHT+IHpgxDFAp5J7T641RR+0mVW8V2Nn0gbrQcP9lUx8oojqxJVe9W67kxVGgNI9Mv6tX6A5vxQdg==
X-Received: by 2002:a05:6a21:3a4a:b0:1af:86e4:bc99 with SMTP id adf61e73a8af0-1b26f12ce72mr3535729637.10.1717172618783;
        Fri, 31 May 2024 09:23:38 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423cb6eesm1572398b3a.6.2024.05.31.09.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 09:23:38 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Jesse Taube <jesse@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Date: Fri, 31 May 2024 12:23:27 -0400
Message-ID: <20240531162327.2436962-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dectect the Zkr extension and use it to seed the kernel base address.

Detection of the extension can not be done in the typical fashion, as
this is very early in the boot process. Instead, add a trap handler
and run it to see if the extension is present.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 arch/riscv/kernel/pi/Makefile           |  2 +-
 arch/riscv/kernel/pi/archrandom_early.c | 71 +++++++++++++++++++++++++
 arch/riscv/mm/init.c                    |  3 ++
 3 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/pi/archrandom_early.c

diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
index 50bc5ef7dd2f..9025eb52945a 100644
--- a/arch/riscv/kernel/pi/Makefile
+++ b/arch/riscv/kernel/pi/Makefile
@@ -32,5 +32,5 @@ $(obj)/string.o: $(srctree)/lib/string.c FORCE
 $(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-obj-y		:= cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
+obj-y		:= cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o archrandom_early.pi.o
 extra-y		:= $(patsubst %.pi.o,%.o,$(obj-y))
diff --git a/arch/riscv/kernel/pi/archrandom_early.c b/arch/riscv/kernel/pi/archrandom_early.c
new file mode 100644
index 000000000000..311be9388b5c
--- /dev/null
+++ b/arch/riscv/kernel/pi/archrandom_early.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * To avoid rewriteing code include asm/archrandom.h and create macros
+ * for the functions that won't be included.
+ */
+
+#define riscv_has_extension_likely(...) false
+#define pr_err_once(...)
+
+#include <linux/types.h>
+#include <asm/hwcap.h>
+#include <asm/archrandom.h>
+
+/*
+ * Asm goto is needed so that the compiler does not remove the label.
+ */
+
+#define csr_goto_swap(csr, val)						\
+({									\
+	unsigned long __v;						\
+	__asm__ __volatile__ goto("csrrw %0, " __ASM_STR(csr) ", %1"	\
+				  : "=r" (__v) : "rK" (&&val)		\
+				  : "memory" : val);			\
+	__v;								\
+})
+
+/*
+ * Declare the functions that are exported (but prefixed) here so that LLVM
+ * does not complain it lacks the 'static' keyword (which, if added, makes
+ * LLVM complain because the function is actually unused in this file).
+ */
+
+u64 get_kaslr_seed_zkr(void);
+
+/*
+ * This function is called by setup_vm to check if the kernel has the ZKR.
+ * Traps haven't been set up yet, but save and restore the TVEC to avoid
+ * any side effects.
+ */
+
+static inline bool __must_check riscv_has_zkr(void)
+{
+	unsigned long tvec;
+
+	tvec = csr_goto_swap(CSR_TVEC, not_zkr);
+	csr_swap(CSR_SEED, 0);
+	csr_write(CSR_TVEC, tvec);
+	return true;
+not_zkr:
+	csr_write(CSR_TVEC, tvec);
+	return false;
+}
+
+u64 get_kaslr_seed_zkr(void)
+{
+	const int needed_seeds = sizeof(u64) / sizeof(long);
+	int i = 0;
+	u64 seed = 0;
+	long *entropy = (long *)(&seed);
+
+	if (!riscv_has_zkr())
+		return 0;
+
+	for (i = 0; i < needed_seeds; i++) {
+		if (!csr_seed_long(&entropy[i]))
+			return 0;
+	}
+
+	return seed;
+}
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9940171c79f0..8ef1edd2cddd 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1025,6 +1025,7 @@ static void __init pt_ops_set_late(void)
 #ifdef CONFIG_RANDOMIZE_BASE
 extern bool __init __pi_set_nokaslr_from_cmdline(uintptr_t dtb_pa);
 extern u64 __init __pi_get_kaslr_seed(uintptr_t dtb_pa);
+extern u64 __init __pi_get_kaslr_seed_zkr(void);
 
 static int __init print_nokaslr(char *p)
 {
@@ -1049,6 +1050,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 		u32 kernel_size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
 		u32 nr_pos;
 
+		if (kaslr_seed == 0)
+			kaslr_seed = __pi_get_kaslr_seed_zkr();
 		/*
 		 * Compute the number of positions available: we are limited
 		 * by the early page table that only has one PUD and we must
-- 
2.43.0


