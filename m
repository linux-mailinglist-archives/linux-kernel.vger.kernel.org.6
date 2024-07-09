Return-Path: <linux-kernel+bounces-246496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDA692C2A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DCAAB23BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E86C17B040;
	Tue,  9 Jul 2024 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cmWOcTlM"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D7180033
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546787; cv=none; b=JokC8KGWEaDJrwL5T4HFkDVqPQWFT6ilP/Iw+pPu0gg7ttGPxJ1u0mmVaeEaEZzlv92BpF8Lfiv99kgB0x7Fl6wkUjfzFVWzYf2kqeBqqTNTMlx5YbKkMmmI5wbf5F2gIZ3KfU/8W2xpSAz4Vcw4w3lGzx0+Rwx3Jl6mGQ5zeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546787; c=relaxed/simple;
	bh=IGoFOuz+Zi5Uhxx4emsE7F5oHebVKUziK0at7L29O1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEmfITb82ae4FWpLQqvhW3vGi676PY+0j16UgaJxF2QKtGzjvpENE63t0NldsXgOFZwRRLk2WhmpHNHSxCT8XSR3DOARXs15Xs3Cdee2qKWY0gHVEFgiqH/ydvrY9RJ7fHABQHOB5OynVXkrW7CJFCyliWdIJYceU54pWzYJaQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cmWOcTlM; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d9231a8dd6so1607367b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720546783; x=1721151583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ys1Aw6VvBUculkzPHvM/HV7hPckJqLLorHwgfnWzAjs=;
        b=cmWOcTlMhSlh3QNDd4eEIhRgAB87DkJaYjUq4GPwFgYUCtxhsAow5P+bITfOyZsToY
         fcwSH0Ewd7lvXsK8bWBLFvkfaW8RSI7+UkmrWMzhjp0q2FPGzBxEOKIDTs5QdniT29Wu
         igRKApedXLqaFznbnXcG0GipP/i9TCl1tdjQcMeFoKk9HmSU1APFfi6bM1QD6RBJiMcU
         4eEaSqxJoB3X6BS1+Dq9jRwKqSwAEc4a2f7DOmQNhZ0gGPfxMzVg5BnbmNWqmOllrpAX
         KCQuVMyo9hpjmYaYfzMtVeTJBAr3FtlgbQhvPuhPWV0Fr6DZRlRwz6bVj00PSaAjIb0i
         4d/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546783; x=1721151583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ys1Aw6VvBUculkzPHvM/HV7hPckJqLLorHwgfnWzAjs=;
        b=I9JcAFKlTIiTNCUNQ9GHR5pQry3Z0z0dfp6mhuwTeaQA9F8jE1g9zKEohgPVldH7yc
         XJP0crd5srfzJOgM4RKNwMpve4ogw22CLKvpuRk3eotFNcilKyD5aEbloI0qawf+wrji
         5MFuf26vFb06QYA7WcQef9MgAsCZlB+HhynMC6vJ7RHI5X+wmwi2NS/nVKT5MK8ujNh9
         hb8Tpz/HHJtKAagpW51Ykl1nB2YhXtbsOY+ClPHIX2ciorwSQVXHEjhe4S75TubdhFoj
         LWaaqYNz7pA5hiunWnV0XUYbVWeYZqqmsqOhDlKu2/YwB27rqzTr/1EXoLR5loKDM6kY
         b86g==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZBBRqV6PqF3+Z0EieSP+MCV6ir2OsNzGXMLI6An+Ms8YS0xAakKNiNv1Z9z8J4A6GkeW0px/6079Ry+s6RGQxyTV+djrZ9wLgnoM
X-Gm-Message-State: AOJu0YyoqwDNOmvOnc2k0dqcweT/GZ3wQjVi2hZwMfJA9l/SzRELzIsr
	QqbjBIqPEVlLfhuUpQgMnwtYEjKqxeIK6BVTcxGQubtbodTk3pNQZSeKfQoUnbc=
X-Google-Smtp-Source: AGHT+IGj1/PBL90vBofRatNEDEbdFQFf7AwNGmHOoh5MNXhXvkvRBUpAEVrV8n1KV+mCB1tFV7RvZg==
X-Received: by 2002:a05:6808:13c9:b0:3d5:633b:3d8d with SMTP id 5614622812f47-3d93c0aaa10mr2959216b6e.53.1720546783247;
        Tue, 09 Jul 2024 10:39:43 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff6762sm117547785a.10.2024.07.09.10.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:39:42 -0700 (PDT)
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
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Charlie Jenkins <charlie@rivosinc.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 4/4] RISC-V: Use Zkr to seed KASLR base address
Date: Tue,  9 Jul 2024 13:39:37 -0400
Message-ID: <20240709173937.510084-5-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709173937.510084-1-jesse@rivosinc.com>
References: <20240709173937.510084-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the device tree for Zkr in the isa string.
If Zkr is present, use it to seed the kernel base address.

On an ACPI system, as of this commit, there is no easy way to check if
Zkr is present. Blindly running the instruction isn't an option as;
we have to be able to trust the firmware.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Zong Li <zong.li@sifive.com>
---
V1 -> V2:
 - Almost entire rewrite
V2 -> V3:
 - Dont parse iscv,isa-base
 - Move fdt_early_match_extension_isa in pi.h under comment
 - Only check enabled cpus
 - Rename early_isa_str to fdt_early_match_extension_isa
 - Rename get_ext_named to early_cpu_isa_ext_available
 - Rewrite isa_string_contains
 - Update commit description
 - Use fdt_stringlist_contains for riscv,isa-extensions
V3 -> V4:
 - Add `CFLAGS_fdt_early.o += -D__NO_FORTIFY` to Makefile
 - Remove isdigit
---
 arch/riscv/kernel/pi/Makefile           |   3 +-
 arch/riscv/kernel/pi/archrandom_early.c |  30 +++++
 arch/riscv/kernel/pi/fdt_early.c        | 160 ++++++++++++++++++++++++
 arch/riscv/kernel/pi/pi.h               |   3 +
 arch/riscv/mm/init.c                    |   5 +-
 5 files changed, 199 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/archrandom_early.c

diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
index 1ef7584be0c3..d5bf1bc7de62 100644
--- a/arch/riscv/kernel/pi/Makefile
+++ b/arch/riscv/kernel/pi/Makefile
@@ -17,6 +17,7 @@ KBUILD_CFLAGS	+= -mcmodel=medany
 
 CFLAGS_cmdline_early.o += -D__NO_FORTIFY
 CFLAGS_lib-fdt_ro.o += -D__NO_FORTIFY
+CFLAGS_fdt_early.o += -D__NO_FORTIFY
 
 $(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
 			       --remove-section=.note.gnu.property \
@@ -33,5 +34,5 @@ $(obj)/string.o: $(srctree)/lib/string.c FORCE
 $(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-obj-y		:= cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
+obj-y		:= cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o archrandom_early.pi.o
 extra-y		:= $(patsubst %.pi.o,%.o,$(obj-y))
diff --git a/arch/riscv/kernel/pi/archrandom_early.c b/arch/riscv/kernel/pi/archrandom_early.c
new file mode 100644
index 000000000000..3f05d3cf3b7b
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
+	if (!fdt_early_match_extension_isa((const void *)dtb_pa, "zkr"))
+		return 0;
+
+	if (!csr_seed_long(&seed))
+		return 0;
+
+	return seed;
+}
diff --git a/arch/riscv/kernel/pi/fdt_early.c b/arch/riscv/kernel/pi/fdt_early.c
index 40ee299702bf..9bdee2fafe47 100644
--- a/arch/riscv/kernel/pi/fdt_early.c
+++ b/arch/riscv/kernel/pi/fdt_early.c
@@ -2,6 +2,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/libfdt.h>
+#include <linux/ctype.h>
 
 #include "pi.h"
 
@@ -23,3 +24,162 @@ u64 get_kaslr_seed(uintptr_t dtb_pa)
 	*prop = 0;
 	return ret;
 }
+
+/**
+ *  fdt_device_is_available - check if a device is available for use
+ *
+ * @fdt: pointer to the device tree blob
+ * @node: offset of the node whose property to find
+ *
+ *  Returns true if the status property is absent or set to "okay" or "ok",
+ *  false otherwise
+ */
+static bool fdt_device_is_available(const void *fdt, int node)
+{
+	const char *status;
+	int statlen;
+
+	status = fdt_getprop(fdt, node, "status", &statlen);
+	if (!status)
+		return true;
+
+	if (statlen > 0) {
+		if (!strcmp(status, "okay") || !strcmp(status, "ok"))
+			return true;
+	}
+
+	return false;
+}
+
+/* Copy of fdt_nodename_eq_ */
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
+/**
+ *  isa_string_contains - check if isa string contains an extension
+ *
+ * @isa_str: isa string to search
+ * @ext_name: the extension to search for
+ *
+ *  Returns true if the extension is in the given isa string,
+ *  false otherwise
+ */
+static bool isa_string_contains(const char *isa_str, const char *ext_name)
+{
+	size_t i, single_end, len = strlen(ext_name);
+	char ext_end;
+
+	/* Error must contain rv32/64 */
+	if (strlen(isa_str) < 4)
+		return false;
+
+	if (len == 1) {
+		single_end = strcspn(isa_str, "sSxXzZ");
+		/* Search for single chars between rv32/64 and multi-letter extensions */
+		for (i = 4; i < single_end; i++) {
+			if (tolower(isa_str[i]) == ext_name[0])
+				return true;
+		}
+		return false;
+	}
+
+	/* Skip to start of multi-letter extensions */
+	isa_str = strpbrk(isa_str, "sSxXzZ");
+	while (isa_str) {
+		if (strncasecmp(isa_str, ext_name, len) == 0) {
+			ext_end = isa_str[len];
+			/* Check if matches the whole extension. */
+			if (ext_end == '\0' || ext_end == '_')
+				return true;
+		}
+		/* Multi-letter extensions must be split from other multi-letter
+		 * extensions with an "_", the end of a multi-letter extension will
+		 * either be the null character or the "_" at the start of the next
+		 * multi-letter extension.
+		 */
+		isa_str = strchr(isa_str, '_');
+		if (isa_str)
+			isa_str++;
+	}
+
+	return false;
+}
+
+/**
+ *  early_cpu_isa_ext_available - check if cpu node has an extension
+ *
+ * @fdt: pointer to the device tree blob
+ * @node: offset of the cpu node
+ * @ext_name: the extension to search for
+ *
+ *  Returns true if the cpu node has the extension,
+ *  false otherwise
+ */
+static bool early_cpu_isa_ext_available(const void *fdt, int node, const char *ext_name)
+{
+	const void *prop;
+	int len;
+
+	prop = fdt_getprop(fdt, node, "riscv,isa-extensions", &len);
+	if (prop && fdt_stringlist_contains(prop, len, ext_name))
+		return true;
+
+	prop = fdt_getprop(fdt, node, "riscv,isa", &len);
+	if (prop && isa_string_contains(prop, ext_name))
+		return true;
+
+	return false;
+}
+
+/**
+ *  fdt_early_match_extension_isa - check if all cpu nodes have an extension
+ *
+ * @fdt: pointer to the device tree blob
+ * @ext_name: the extension to search for
+ *
+ *  Returns true if the all available the cpu nodes have the extension,
+ *  false otherwise
+ */
+bool fdt_early_match_extension_isa(const void *fdt, const char *ext_name)
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
+		if (!fdt_device_is_available(fdt, node))
+			continue;
+
+		if (!early_cpu_isa_ext_available(fdt, node, ext_name))
+			return false;
+
+		ret = true;
+	}
+
+	return ret;
+}
diff --git a/arch/riscv/kernel/pi/pi.h b/arch/riscv/kernel/pi/pi.h
index 493c8cb7c0e6..21141d84fea6 100644
--- a/arch/riscv/kernel/pi/pi.h
+++ b/arch/riscv/kernel/pi/pi.h
@@ -11,7 +11,10 @@
  */
 
 u64 get_kaslr_seed(uintptr_t dtb_pa);
+u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa);
 bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
 u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
 
+bool fdt_early_match_extension_isa(const void *fdt, const char *ext_name);
+
 #endif /* _RISCV_PI_H_ */
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


