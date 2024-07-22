Return-Path: <linux-kernel+bounces-258746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4DA938C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AC41F21E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F3B16EC1C;
	Mon, 22 Jul 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="V9NvfVC8"
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E0C16E899
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641430; cv=none; b=DSYznywWOHi/SrRPsZCu9xSawxO6KaR3+zaGz/lFVaxZvtONa01RGeVVM7cnT3Uhdd0G8Ru83gj/T5OediRvZ+skGtSd6/nGr74XbbUkvKfO1GaNG8+I5UkKnRCXdhVQpDINgpP8meZ6/h61EiufwIjKT70TWrTn631/HHA0wPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641430; c=relaxed/simple;
	bh=7YR6j+1R9mz+vgiTv2FAgB1g9CVaQI/buI0GwB5Mols=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i22pjUaeo3L3cXhLF7zzGJawVTrH5Hz349gZHwr0cAFyilRQQUg8ORJpCLTXPEZ2cVK50H2liV0Pp2+o7nMBlJ7JjzbCZM1VHoHikiRLMxUdza1Rw3ZMgmlmltijAIxt6sO3NuQoXZpsl+VvRQHWse/kSE4cBfo4CNISyPsneSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=V9NvfVC8; arc=none smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id D263B48ECED
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641426;
	bh=7YR6j+1R9mz+vgiTv2FAgB1g9CVaQI/buI0GwB5Mols=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V9NvfVC8Gh9NdexNuysa6QNcEWw0Xx9VfDUMfGCL5Lg46w7TCOcrJpXcC+NOhg55O
	 u0K0vGPc/HyDKH19HFD5aYiqEHxyb8epmKXkO+ymxfwcvt8Ukpl3ygoUW94gpWqs7L
	 LeFBABjcrGt358/5N953KH9Q0WuBTlb/8IuG53qo=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 7B50248F114; Mon, 22 Jul 2024 11:43:46 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx403.security-mail.net (Postfix) with ESMTPS id 81A1548E6F0; Mon, 22 Jul
 2024 11:43:45 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 4C4CE4032F; Mon, 22 Jul
 2024 11:43:45 +0200 (CEST)
X-Secumail-id: <cc80.669e29d1.7e3eb.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <kees@kernel.org>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Marius Gligor <mgligor@kalrayinc.com>,
 linux-mm@kvack.org
Subject: [RFC PATCH v3 27/37] kvx: Add ELF relocations and module support
Date: Mon, 22 Jul 2024 11:41:38 +0200
Message-ID: <20240722094226.21602-28-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add ELF-related definition and module relocation code for basic
kvx support.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: no changes

V2 -> V3: define CORE_DUMP_USE_REGSET
---
 arch/kvx/include/asm/elf.h      | 156 ++++++++++++++++++++++++++++++++
 arch/kvx/include/asm/vermagic.h |  12 +++
 arch/kvx/kernel/module.c        | 148 ++++++++++++++++++++++++++++++
 3 files changed, 316 insertions(+)
 create mode 100644 arch/kvx/include/asm/elf.h
 create mode 100644 arch/kvx/include/asm/vermagic.h
 create mode 100644 arch/kvx/kernel/module.c

diff --git a/arch/kvx/include/asm/elf.h b/arch/kvx/include/asm/elf.h
new file mode 100644
index 0000000000000..7b6804a939e5e
--- /dev/null
+++ b/arch/kvx/include/asm/elf.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Yann Sionneau
+ *            Clement Leger
+ *            Marius Gligor
+ *            Guillaume Thouvenin
+ */
+
+#ifndef _ASM_KVX_ELF_H
+#define _ASM_KVX_ELF_H
+
+#include <linux/types.h>
+
+#include <asm/ptrace.h>
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_CLASS	ELFCLASS64
+#define ELF_DATA	ELFDATA2LSB
+#define ELF_ARCH	EM_KVX
+
+typedef uint64_t elf_greg_t;
+typedef uint64_t elf_fpregset_t;
+
+#define ELF_NGREG	(sizeof(struct user_regs_struct) / sizeof(elf_greg_t))
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
+#define ELF_CORE_COPY_REGS(dest, regs)			\
+	*(struct user_regs_struct *)&(dest) =		\
+		*(struct user_regs_struct *)regs;	\
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) ((x)->e_machine == EM_KVX)
+
+#define ELF_CORE_EFLAGS 0x1308
+
+#define CORE_DUMP_USE_REGSET
+#define ELF_EXEC_PAGESIZE	(PAGE_SIZE)
+
+/*
+ * This is the location that an ET_DYN program is loaded if exec'ed.  Typical
+ * use of this is to invoke "./ld.so someprog" to test out a new version of
+ * the loader.  We need to make sure that it is out of the way of the program
+ * that it will "exec", and that there is sufficient room for the brk.
+ */
+#define ELF_ET_DYN_BASE		((TASK_SIZE / 3) * 2)
+
+/*
+ * This yields a mask that user programs can use to figure out what
+ * instruction set this CPU supports.  This could be done in user space,
+ * but it's not easy, and we've already done it here.
+ */
+#define ELF_HWCAP	(elf_hwcap)
+extern unsigned long elf_hwcap;
+
+/*
+ * This yields a string that ld.so will use to load implementation
+ * specific libraries for optimization.  This is more specific in
+ * intent than poking at uname or /proc/cpuinfo.
+ */
+#define ELF_PLATFORM	(NULL)
+
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
+struct linux_binprm;
+extern int arch_setup_additional_pages(struct linux_binprm *bprm,
+				       int uses_interp);
+
+/* KVX relocs */
+#define R_KVX_NONE                                   0
+#define R_KVX_16                                     1
+#define R_KVX_32                                     2
+#define R_KVX_64                                     3
+#define R_KVX_S16_PCREL                              4
+#define R_KVX_PCREL17                                5
+#define R_KVX_PCREL27                                6
+#define R_KVX_32_PCREL                               7
+#define R_KVX_S37_PCREL_LO10                         8
+#define R_KVX_S37_PCREL_UP27                         9
+#define R_KVX_S43_PCREL_LO10                        10
+#define R_KVX_S43_PCREL_UP27                        11
+#define R_KVX_S43_PCREL_EX6                         12
+#define R_KVX_S64_PCREL_LO10                        13
+#define R_KVX_S64_PCREL_UP27                        14
+#define R_KVX_S64_PCREL_EX27                        15
+#define R_KVX_64_PCREL                              16
+#define R_KVX_S16                                   17
+#define R_KVX_S32_LO5                               18
+#define R_KVX_S32_UP27                              19
+#define R_KVX_S37_LO10                              20
+#define R_KVX_S37_UP27                              21
+#define R_KVX_S37_GOTOFF_LO10                       22
+#define R_KVX_S37_GOTOFF_UP27                       23
+#define R_KVX_S43_GOTOFF_LO10                       24
+#define R_KVX_S43_GOTOFF_UP27                       25
+#define R_KVX_S43_GOTOFF_EX6                        26
+#define R_KVX_32_GOTOFF                             27
+#define R_KVX_64_GOTOFF                             28
+#define R_KVX_32_GOT                                29
+#define R_KVX_S37_GOT_LO10                          30
+#define R_KVX_S37_GOT_UP27                          31
+#define R_KVX_S43_GOT_LO10                          32
+#define R_KVX_S43_GOT_UP27                          33
+#define R_KVX_S43_GOT_EX6                           34
+#define R_KVX_64_GOT                                35
+#define R_KVX_GLOB_DAT                              36
+#define R_KVX_COPY                                  37
+#define R_KVX_JMP_SLOT                              38
+#define R_KVX_RELATIVE                              39
+#define R_KVX_S43_LO10                              40
+#define R_KVX_S43_UP27                              41
+#define R_KVX_S43_EX6                               42
+#define R_KVX_S64_LO10                              43
+#define R_KVX_S64_UP27                              44
+#define R_KVX_S64_EX27                              45
+#define R_KVX_S37_GOTADDR_LO10                      46
+#define R_KVX_S37_GOTADDR_UP27                      47
+#define R_KVX_S43_GOTADDR_LO10                      48
+#define R_KVX_S43_GOTADDR_UP27                      49
+#define R_KVX_S43_GOTADDR_EX6                       50
+#define R_KVX_S64_GOTADDR_LO10                      51
+#define R_KVX_S64_GOTADDR_UP27                      52
+#define R_KVX_S64_GOTADDR_EX27                      53
+#define R_KVX_64_DTPMOD                             54
+#define R_KVX_64_DTPOFF                             55
+#define R_KVX_S37_TLS_DTPOFF_LO10                   56
+#define R_KVX_S37_TLS_DTPOFF_UP27                   57
+#define R_KVX_S43_TLS_DTPOFF_LO10                   58
+#define R_KVX_S43_TLS_DTPOFF_UP27                   59
+#define R_KVX_S43_TLS_DTPOFF_EX6                    60
+#define R_KVX_S37_TLS_GD_LO10                       61
+#define R_KVX_S37_TLS_GD_UP27                       62
+#define R_KVX_S43_TLS_GD_LO10                       63
+#define R_KVX_S43_TLS_GD_UP27                       64
+#define R_KVX_S43_TLS_GD_EX6                        65
+#define R_KVX_S37_TLS_LD_LO10                       66
+#define R_KVX_S37_TLS_LD_UP27                       67
+#define R_KVX_S43_TLS_LD_LO10                       68
+#define R_KVX_S43_TLS_LD_UP27                       69
+#define R_KVX_S43_TLS_LD_EX6                        70
+#define R_KVX_64_TPOFF                              71
+#define R_KVX_S37_TLS_IE_LO10                       72
+#define R_KVX_S37_TLS_IE_UP27                       73
+#define R_KVX_S43_TLS_IE_LO10                       74
+#define R_KVX_S43_TLS_IE_UP27                       75
+#define R_KVX_S43_TLS_IE_EX6                        76
+#define R_KVX_S37_TLS_LE_LO10                       77
+#define R_KVX_S37_TLS_LE_UP27                       78
+#define R_KVX_S43_TLS_LE_LO10                       79
+#define R_KVX_S43_TLS_LE_UP27                       80
+#define R_KVX_S43_TLS_LE_EX6                        81
+
+#endif	/* _ASM_KVX_ELF_H */
diff --git a/arch/kvx/include/asm/vermagic.h b/arch/kvx/include/asm/vermagic.h
new file mode 100644
index 0000000000000..fef9a33065df9
--- /dev/null
+++ b/arch/kvx/include/asm/vermagic.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_VERMAGIC_H
+#define _ASM_KVX_VERMAGIC_H
+
+#define MODULE_ARCH_VERMAGIC    "kvx"
+
+#endif /* _ASM_KVX_VERMAGIC_H */
diff --git a/arch/kvx/kernel/module.c b/arch/kvx/kernel/module.c
new file mode 100644
index 0000000000000..b9383792ae456
--- /dev/null
+++ b/arch/kvx/kernel/module.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Yann Sionneau
+ *            Clement Leger
+ */
+
+#include <linux/elf.h>
+#include <linux/moduleloader.h>
+#include <linux/overflow.h>
+
+
+static int apply_rela_bits(Elf64_Addr loc, Elf64_Addr val,
+				  int sign, int immsize, int bits, int rshift,
+				  int lshift, unsigned int relocnum,
+				  struct module *me)
+{
+	unsigned long long umax;
+	long long min, max;
+	unsigned long long mask = GENMASK_ULL(bits + lshift - 1, lshift);
+
+	if (sign) {
+		min = -(1ULL << (immsize - 1));
+		max = (1ULL << (immsize - 1)) - 1;
+		if ((long long) val < min || (long long) val > max)
+			goto too_big;
+		val = (Elf64_Addr)(((long) val) >> rshift);
+	} else {
+		if (immsize < 64)
+			umax = (1ULL << immsize) - 1;
+		else
+			umax = -1ULL;
+		if ((unsigned long long) val > umax)
+			goto too_big;
+		val >>= rshift;
+	}
+
+	val <<= lshift;
+	val &= mask;
+	if (bits <= 32)
+		*(u32 *) loc = (*(u32 *)loc & ~mask) | val;
+	else
+		*(u64 *) loc = (*(u64 *)loc & ~mask) | val;
+
+	return 0;
+too_big:
+	pr_err("%s: value %llx does not fit in %d bits for reloc %u",
+	       me->name, val, bits, relocnum);
+	return -ENOEXEC;
+}
+
+int apply_relocate_add(Elf64_Shdr *sechdrs,
+			   const char *strtab,
+			   unsigned int symindex,
+			   unsigned int relsec,
+			   struct module *me)
+{
+	unsigned int i;
+	Elf64_Addr loc;
+	u64 val;
+	s64 sval;
+	Elf64_Sym *sym;
+	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
+	int ret = 0;
+
+	pr_debug("Applying relocate section %u to %u\n",
+			relsec, sechdrs[relsec].sh_info);
+
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+		/* This is where to make the change */
+		loc = (Elf64_Addr)sechdrs[sechdrs[relsec].sh_info].sh_addr
+			+ rel[i].r_offset;
+		/* This is the symbol it is referring to.  Note that all
+		 *  undefined symbols have been resolved.
+		 */
+		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
+			+ ELF64_R_SYM(rel[i].r_info);
+
+		pr_debug("type %d st_value %llx r_addend %llx loc %llx offset %llx\n",
+			 (int)ELF64_R_TYPE(rel[i].r_info),
+			 sym->st_value, rel[i].r_addend, (uint64_t)loc,
+			 rel[i].r_offset);
+
+		val = sym->st_value + rel[i].r_addend;
+		switch (ELF64_R_TYPE(rel[i].r_info)) {
+		case R_KVX_NONE:
+			break;
+		case R_KVX_32:
+			ret = apply_rela_bits(loc, val, 0, 32, 32, 0, 0,
+					      ELF64_R_TYPE(rel[i].r_info),
+					      me);
+			break;
+		case R_KVX_64:
+			ret = apply_rela_bits(loc, val, 0, 64, 64, 0, 0,
+					      ELF64_R_TYPE(rel[i].r_info),
+					      me);
+			break;
+		case R_KVX_S43_LO10:
+			ret = apply_rela_bits(loc, val, 1, 43, 10, 0, 6,
+					      ELF64_R_TYPE(rel[i].r_info),
+					      me);
+			break;
+		case R_KVX_S64_LO10:
+			ret = apply_rela_bits(loc, val, 1, 64, 10, 0, 6,
+					      ELF64_R_TYPE(rel[i].r_info),
+					      me);
+			break;
+		case R_KVX_S43_UP27:
+			ret = apply_rela_bits(loc, val, 1, 43, 27, 10, 0,
+					      ELF64_R_TYPE(rel[i].r_info),
+					      me);
+			break;
+		case R_KVX_S64_UP27:
+			ret = apply_rela_bits(loc, val, 1, 64, 27, 10, 0,
+					      ELF64_R_TYPE(rel[i].r_info),
+					      me);
+			break;
+		case R_KVX_S43_EX6:
+			ret = apply_rela_bits(loc, val, 1, 43, 6, 37, 0,
+					      ELF64_R_TYPE(rel[i].r_info),
+					      me);
+			break;
+		case R_KVX_S64_EX27:
+			ret = apply_rela_bits(loc, val, 1, 64, 27, 37, 0,
+					      ELF64_R_TYPE(rel[i].r_info),
+					      me);
+			break;
+		case R_KVX_PCREL27:
+			if (__builtin_sub_overflow(val, loc, &sval)) {
+				pr_err("%s: Signed integer overflow, this should not happen\n",
+				       me->name);
+				return -ENOEXEC;
+			}
+			sval >>= 2;
+			ret = apply_rela_bits(loc, (Elf64_Addr)sval, 1, 27, 27,
+					      0, 0,
+					      ELF64_R_TYPE(rel[i].r_info),
+					      me);
+			break;
+		default:
+			pr_err("%s: Unknown relocation: %llu\n",
+				me->name, ELF64_R_TYPE(rel[i].r_info));
+			ret = -ENOEXEC;
+		}
+	}
+	return ret;
+}
+
-- 
2.45.2






