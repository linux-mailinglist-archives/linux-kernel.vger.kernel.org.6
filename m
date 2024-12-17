Return-Path: <linux-kernel+bounces-448410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2205A9F3FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56292165E20
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0958C13B7A1;
	Tue, 17 Dec 2024 01:09:17 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FAE224D6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397756; cv=none; b=pmug4rSL0Von9tUwL62yircIXxBOgXwMwqmFzpJcM14H+YtQFRZxdKONjrd5xeIDo/az4KF5aNcoxkHRpzSPrqpZ54ByqhZAHMHYWLBiG521OEWRU+rpYL0K04L9SXFGKVXOLT0n96lIR5JbokoeAZoYjM+XS3VfBIIHuxNdz40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397756; c=relaxed/simple;
	bh=5IPJJWeAlO39eq8FDSJb7baUxMjFQGsbCAUC8y4lQws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk7/+JAw+cmKmyCu273mLhTLtpC49DXnbOoSyUBBKgboTdaWpOyABJi0PvbRZRxobpUtQ2JwIpzzG57Gf4XuYtmwvpxWaTzvmS2biAfzUI79NuMsTzF2FLdKP2i814InShL8OsdJPTLZqDSikruErHZORlMo015+JqeLVmVQHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx_644z2BnJJdXAA--.1144S3;
	Tue, 17 Dec 2024 09:09:12 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxPEcyz2BnXNeFAA--.16436S5;
	Tue, 17 Dec 2024 09:09:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/9] objtool: Handle PC relative relocation type
Date: Tue, 17 Dec 2024 09:08:59 +0800
Message-ID: <20241217010905.13054-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241217010905.13054-1-yangtiezhu@loongson.cn>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxPEcyz2BnXNeFAA--.16436S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr48Ww13Xw15uryfGFyrKrX_yoW7Jw45pF
	srC398Kr4Yqr1xWw42ya1kWrW5Gan7Wry2qryDtryrZrZFqw15tFWxAFZ8Ka1UXwsYgFWx
	ZFnYgw17AF4qv3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EoGPUUUUU==

For the most part, an absolute relocation type is used for rodata.
In the case of STT_SECTION, reloc->sym->offset is always zero, for
the other symbol types, reloc_addend(reloc) is always zero, thus it
can use a simple statement "reloc->sym->offset + reloc_addend(reloc)"
to obtain the symbol offset for various symbol types.

When compiling on LoongArch, there exist PC relative relocation types
for rodata, it needs to calculate the symbol offset with "S + A - PC"
according to the spec of "ELF for the LoongArch Architecture".

If there is only one jump table in the rodata, the "PC" is the entry
address which is equal with the value of reloc_offset(reloc), at this
time, reloc_offset(table) is 0.

If there are many jump tables in the rodata, the "PC" is the offset
of the jump table's base address which is equal with the value of
reloc_offset(reloc) - reloc_offset(table).

So for LoongArch, if the relocation type is PC relative, it can use a
statement "reloc_offset(reloc) - reloc_offset(table)" to get the "PC"
value when calculating the symbol offset with "S + A - PC" for one or
many jump tables in the rodata.

Add an arch-specific function arch_jump_table_sym_offset() to assign
the symbol offset, for the most part that is an absolute relocation,
the default value is "reloc->sym->offset + reloc_addend(reloc)" in
the weak definition, it can be overridden by each architecture that
has different requirements.

Link: https://github.com/loongson/la-abi-specs/blob/release/laelf.adoc
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/loongarch/decode.c           | 17 +++++++++++++----
 tools/objtool/arch/loongarch/include/arch/elf.h |  7 +++++++
 tools/objtool/check.c                           |  7 ++++++-
 tools/objtool/include/objtool/arch.h            |  1 +
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index b64205b89f6b..02e490555966 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -5,10 +5,7 @@
 #include <asm/inst.h>
 #include <asm/orc_types.h>
 #include <linux/objtool_types.h>
-
-#ifndef EM_LOONGARCH
-#define EM_LOONGARCH	258
-#endif
+#include <arch/elf.h>
 
 int arch_ftrace_match(char *name)
 {
@@ -374,3 +371,15 @@ unsigned int arch_reloc_size(struct reloc *reloc)
 		return 8;
 	}
 }
+
+unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table)
+{
+	switch (reloc_type(reloc)) {
+	case R_LARCH_32_PCREL:
+	case R_LARCH_64_PCREL:
+		return reloc->sym->offset + reloc_addend(reloc) -
+		       (reloc_offset(reloc) - reloc_offset(table));
+	default:
+		return reloc->sym->offset + reloc_addend(reloc);
+	}
+}
diff --git a/tools/objtool/arch/loongarch/include/arch/elf.h b/tools/objtool/arch/loongarch/include/arch/elf.h
index 9623d663220e..ec79062c9554 100644
--- a/tools/objtool/arch/loongarch/include/arch/elf.h
+++ b/tools/objtool/arch/loongarch/include/arch/elf.h
@@ -18,6 +18,13 @@
 #ifndef R_LARCH_32_PCREL
 #define R_LARCH_32_PCREL	99
 #endif
+#ifndef R_LARCH_64_PCREL
+#define R_LARCH_64_PCREL	109
+#endif
+
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH		258
+#endif
 
 #define R_NONE			R_LARCH_NONE
 #define R_ABS32			R_LARCH_32
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d8668ae0f599..cff7416b207e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1943,6 +1943,11 @@ static int add_special_section_alts(struct objtool_file *file)
 	return ret;
 }
 
+__weak unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table)
+{
+	return reloc->sym->offset + reloc_addend(reloc);
+}
+
 static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			  struct reloc *next_table)
 {
@@ -1971,7 +1976,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (prev_offset && reloc_offset(reloc) != prev_offset + arch_reloc_size(reloc))
 			break;
 
-		sym_offset = reloc->sym->offset + reloc_addend(reloc);
+		sym_offset = arch_jump_table_sym_offset(reloc, table);
 
 		/* Detect function pointers from contiguous objects: */
 		if (reloc->sym->sec == pfunc->sec && sym_offset == pfunc->offset)
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 396f7c6c81c0..089a1acc48a8 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -98,5 +98,6 @@ int arch_rewrite_retpolines(struct objtool_file *file);
 bool arch_pc_relative_reloc(struct reloc *reloc);
 
 unsigned int arch_reloc_size(struct reloc *reloc);
+unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table);
 
 #endif /* _ARCH_H */
-- 
2.42.0


