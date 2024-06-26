Return-Path: <linux-kernel+bounces-231261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECBA9189F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DBD284124
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55C618FDB5;
	Wed, 26 Jun 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nj4KPykJ"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9917FAAE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422252; cv=none; b=dLKe7KMh2FPrJz6E+VJABianYMXc/H6wsv7TuuteNRNQFiWMZLCkR3TypHiOcJ2mM28Bj+EqwBLkktk7D8QQVGmrj/PmeNDhYoDlHpBN9UHsexnhyNrHfFfJAH8KT7o5AJFYqywivwM82af4BIYjhkKL86v78OYAStpRWWRnSQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422252; c=relaxed/simple;
	bh=VLnzLgcwZrkCQcRXtezgubXIh27MSUOk4NTAqfW155o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gr/ulfimJZbNIGuz2DZmLyLDusexf889mPne+ibMEHM5QhfeTNMdb+prQOPECPjwFPZj7EJ/3WXlXbmfAlvmhUctPgCqL4LFxXaMndDx3qKlKoJWxov/6P/AO6fJRiGEAcIN2Sx3S0MtB+avv/Ex4F1DhzyqbCDhbEgHhtORxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nj4KPykJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c8911c84daso2447979a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719422250; x=1720027050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=of2FbNumXWiiWPSU2khL/cXCQvlYVxK+wsi6dw//9/8=;
        b=nj4KPykJmK2Grzm1RGkYQwCGabQrh0peqpxGE9XdNu13X/nTdi5YmU2OJLrvh7l5jj
         N5+lzgaoC+tv2SUD5ljI7P8UmtAQa+rdzdORVdQhViA/pBNHLM9QhFP7H48Yb13GZGez
         RpmZjGPZJnTlIXiUxGsCybSIpBrxJz3iKmBfoRt86dtjR5Sb8EaiJGV5okSEYMUbtdUu
         TiW/akDJg9TFgh7loAwIySvqQm0sQR/j6rU4rlPQ6u5It5ENHA3WP9ROUHdshaVt+506
         IO+lwd9eUj3cD1oWYq8XTgaDE+vPBcKz1poVpwtDlunPw8wOQEjj+Uj3Fnf47lzsqWrI
         Z0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719422250; x=1720027050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=of2FbNumXWiiWPSU2khL/cXCQvlYVxK+wsi6dw//9/8=;
        b=VHR1VH0gvMCwzxa0vZUk8dfLDu6zflwwCujPUxkUxk4KkTcqMVPCfmPUneYZX4D/o1
         0UfVJyt+Y7JhnBYQn2XFeLOYF249ZctjycIY6YXqRpndmC0aNsYHdKxa9a5QnR6NylxD
         hBtPreXw6oXsvqfB8Xc/Syg+dIRwetezPfDx5yUp+gHU0gQcw1jxhuu1wHGoi8enWKdl
         30y2QHP2yBk0jCsZvgHhc/jWpyMx9Uc7qbut7Zmhu7MsrwpxCK/cjxJur0nNClJJ9ukT
         fl9lZAeoIi70qL8SzHhL9BWwbIGM3k7WGSxOg/euFoAZ2gGuJbqJDgfP56ch3IidXrQZ
         5Arw==
X-Forwarded-Encrypted: i=1; AJvYcCWcojZ6m5hVaj1wC3M3WOhnyzkStvdgb3L3EkINz0jJtaq8m661v437LU1CyD9d0KUPdAlUYlfGKSiKToMwDE2E2UvCkmXr4CE9Qw+V
X-Gm-Message-State: AOJu0YzkbEM6JZhCHPXiI+Jb4zawHrGlwsMMvzWrLcjESB0m9sVWL2B4
	0b/gUTS58VhzGC306XUQX8p2r6DXhUWF8iG9Vmy1SDvCrCMwXAXQOlx74fKAXAY=
X-Google-Smtp-Source: AGHT+IGyHd+WADwyRkT1gcGbulDJF4qqkfp5LHBXeyGhlm6qCM53u/kZpVYoYyrJHx1rDz4EeAXGkg==
X-Received: by 2002:a17:90b:1884:b0:2c2:f6dc:eb12 with SMTP id 98e67ed59e1d1-2c8612c7375mr10774803a91.11.1719422249790;
        Wed, 26 Jun 2024 10:17:29 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8f3b5ad36sm83217a91.26.2024.06.26.10.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:17:29 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Wende Tan <twd2.me@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sami Tolvanen <samitolvanen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 3/3] RISC-V: Use Zkr to seed KASLR base address
Date: Wed, 26 Jun 2024 13:16:52 -0400
Message-ID: <20240626171652.366415-3-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626171652.366415-1-jesse@rivosinc.com>
References: <20240626171652.366415-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the device tree for Zkr in isa string.
If Zkr is present, use it to seed the kernel base address.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 arch/riscv/kernel/pi/Makefile           |  2 +-
 arch/riscv/kernel/pi/archrandom_early.c | 30 ++++++++
 arch/riscv/kernel/pi/fdt_early.c        | 94 +++++++++++++++++++++++++
 arch/riscv/kernel/pi/pi.h               |  3 +
 arch/riscv/mm/init.c                    |  5 +-
 5 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/archrandom_early.c

diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
index 1ef7584be0c3..dba902f2a538 100644
--- a/arch/riscv/kernel/pi/Makefile
+++ b/arch/riscv/kernel/pi/Makefile
@@ -33,5 +33,5 @@ $(obj)/string.o: $(srctree)/lib/string.c FORCE
 $(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-obj-y		:= cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
+obj-y		:= cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o archrandom_early.pi.o
 extra-y		:= $(patsubst %.pi.o,%.o,$(obj-y))
diff --git a/arch/riscv/kernel/pi/archrandom_early.c b/arch/riscv/kernel/pi/archrandom_early.c
new file mode 100644
index 000000000000..c6261165e8a6
--- /dev/null
+++ b/arch/riscv/kernel/pi/archrandom_early.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/csr.h>
+#include <linux/processor.h>
+
+#include "pi.h"
+
+/*
+ * To avoid rewriting code include asm/archrandom.h and create macros
+ * for the functions that won't be included.
+ */
+#undef riscv_has_extension_unlikely
+#define riscv_has_extension_likely(...) false
+#undef pr_err_once
+#define pr_err_once(...)
+
+#include <asm/archrandom.h>
+
+u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa)
+{
+	unsigned long seed = 0;
+
+	if (!early_isa_str((const void *)dtb_pa, "zkr"))
+		return 0;
+
+	if (!csr_seed_long(&seed))
+		return 0;
+
+	return seed;
+}
diff --git a/arch/riscv/kernel/pi/fdt_early.c b/arch/riscv/kernel/pi/fdt_early.c
index 40ee299702bf..ba76197b44d1 100644
--- a/arch/riscv/kernel/pi/fdt_early.c
+++ b/arch/riscv/kernel/pi/fdt_early.c
@@ -23,3 +23,97 @@ u64 get_kaslr_seed(uintptr_t dtb_pa)
 	*prop = 0;
 	return ret;
 }
+
+/* Based off of fdt_stringlist_contains */
+static int isa_string_contains(const char *strlist, int listlen, const char *str)
+{
+	int len = strlen(str);
+	const char *p;
+
+	while (listlen >= len) {
+		if (strncasecmp(str, strlist, len) == 0)
+			return 1;
+		p = memchr(strlist, '_', listlen);
+		if (!p)
+			p = memchr(strlist, '\0', listlen);
+		if (!p)
+			return 0; /* malformed strlist.. */
+		listlen -= (p - strlist) + 1;
+		strlist = p + 1;
+	}
+
+	return 0;
+}
+
+/* Based off of fdt_nodename_eq_ */
+static int fdt_node_name_eq(const void *fdt, int offset,
+			    const char *s)
+{
+	int olen;
+	int len = strlen(s);
+	const char *p = fdt_get_name(fdt, offset, &olen);
+
+	if (!p || olen < len)
+		/* short match */
+		return 0;
+
+	if (memcmp(p, s, len) != 0)
+		return 0;
+
+	if (p[len] == '\0')
+		return 1;
+	else if (!memchr(s, '@', len) && (p[len] == '@'))
+		return 1;
+	else
+		return 0;
+}
+
+/*
+ * Returns true if the extension is in the isa string
+ * Returns false if the extension is not found
+ */
+static bool get_ext_named(const void *fdt, int node, const char *name)
+{
+	const void *prop;
+	int len;
+
+	prop = fdt_getprop(fdt, node, "riscv,isa-base", &len);
+	if (prop && isa_string_contains(prop, len, name))
+		return true;
+
+	prop = fdt_getprop(fdt, node, "riscv,isa-extensions", &len);
+	if (prop && isa_string_contains(prop, len, name))
+		return true;
+
+	prop = fdt_getprop(fdt, node, "riscv,isa", &len);
+	if (prop && isa_string_contains(prop, len, name))
+		return true;
+
+	return false;
+}
+
+/*
+ * Returns true if the extension is in the isa string on all cpus
+ * Returns false if the extension is not found
+ */
+bool early_isa_str(const void *fdt, const char *ext_name)
+{
+	int node, parent;
+	bool ret = false;
+
+	parent = fdt_path_offset(fdt, "/cpus");
+	if (parent < 0)
+		return false;
+
+	fdt_for_each_subnode(node, fdt, parent) {
+		if (!fdt_node_name_eq(fdt, node, "cpu"))
+			continue;
+
+		if (!get_ext_named(fdt, node, ext_name))
+			return false;
+
+		ret = true;
+	}
+
+	return ret;
+}
diff --git a/arch/riscv/kernel/pi/pi.h b/arch/riscv/kernel/pi/pi.h
index 65da99466baf..26e7e5f84a30 100644
--- a/arch/riscv/kernel/pi/pi.h
+++ b/arch/riscv/kernel/pi/pi.h
@@ -4,6 +4,8 @@
 
 #include <linux/types.h>
 
+bool early_isa_str(const void *fdt, const char *ext_name);
+
 /*
  * The folowing functions are exported (but prefixed) declare them here so
  * that LLVM does not complain it lacks the 'static' keyword (which, if
@@ -11,6 +13,7 @@
  */
 
 u64 get_kaslr_seed(uintptr_t dtb_pa);
+u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa);
 bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
 u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9940171c79f0..bfb068dc4a64 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1025,6 +1025,7 @@ static void __init pt_ops_set_late(void)
 #ifdef CONFIG_RANDOMIZE_BASE
 extern bool __init __pi_set_nokaslr_from_cmdline(uintptr_t dtb_pa);
 extern u64 __init __pi_get_kaslr_seed(uintptr_t dtb_pa);
+extern u64 __init __pi_get_kaslr_seed_zkr(const uintptr_t dtb_pa);
 
 static int __init print_nokaslr(char *p)
 {
@@ -1045,10 +1046,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 #ifdef CONFIG_RANDOMIZE_BASE
 	if (!__pi_set_nokaslr_from_cmdline(dtb_pa)) {
-		u64 kaslr_seed = __pi_get_kaslr_seed(dtb_pa);
+		u64 kaslr_seed = __pi_get_kaslr_seed_zkr(dtb_pa);
 		u32 kernel_size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
 		u32 nr_pos;
 
+		if (kaslr_seed == 0)
+			kaslr_seed = __pi_get_kaslr_seed(dtb_pa);
 		/*
 		 * Compute the number of positions available: we are limited
 		 * by the early page table that only has one PUD and we must
-- 
2.45.2


