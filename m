Return-Path: <linux-kernel+bounces-250425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E392F7B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E760E1C2302E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D2F14F104;
	Fri, 12 Jul 2024 09:15:13 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE953148841
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775712; cv=none; b=ttWUq+tKw4F8x15qzbr5gxz/n77Dl+lRBPq9NMNT7AQxv7bfZb/GtRP55NCdCHB9Q/Rg8zwI2NtYy4WcKucS8KnHrXgtGPnPAUJphJCymkSWzRPwZ0pyJ/I20oXw/N4UvCs96bhuhplBinjdOHwzELQiEZYvidplzWyGeRfkOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775712; c=relaxed/simple;
	bh=Lp5ngsEVb0UGlrqte4rNQSyKQc/dO2qWXOfgKEa02Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9AfvaixRLES8rLubPghJemOVDYZMhEhqc7BE6AtAiw9D+rFJ5cVJ4RwvM/EvBC3HlJV6a9gBuHVIj/OKJ0Jz1WMjkYJqDbLPZib2CwbsRZ9sV1yAoG1EhE9MhiTP8TjqLtywWMvDNzDLxkOOhX9lfUfZt190tJgTufcrEoDiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxK_Ad9JBmMaEDAA--.10429S3;
	Fri, 12 Jul 2024 17:15:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXcca9JBmW65FAA--.28188S5;
	Fri, 12 Jul 2024 17:15:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] objtool/LoongArch: Add support for jump table
Date: Fri, 12 Jul 2024 17:15:05 +0800
Message-ID: <20240712091506.28140-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240712091506.28140-1-yangtiezhu@loongson.cn>
References: <20240712091506.28140-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXcca9JBmW65FAA--.28188S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr4rKr1fAFy5uw1xGw13WrX_yoW8uw1UpF
	47C345Wr45WryfWw13tF4rur9Igw4IgFy7Xr9xKr93Zw47tFyrtFs7AF1qyF1rXrsYkr4x
	XayfKr4UuF4UAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8XyCJUUUUU==

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/loongarch/special.c | 54 +++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/loongarch/special.c
index 9bba1e9318e0..3e08ad3a507c 100644
--- a/tools/objtool/arch/loongarch/special.c
+++ b/tools/objtool/arch/loongarch/special.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#include <string.h>
+
 #include <objtool/special.h>
+#include <objtool/warn.h>
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
@@ -8,8 +11,57 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 	return false;
 }
 
+static struct reloc *find_reloc_by_tablejump_annotate(struct objtool_file *file,
+						      struct instruction *insn)
+{
+	struct section *rsec;
+	struct reloc *reloc;
+	unsigned long offset;
+
+	rsec = find_section_by_name(file->elf, ".rela.discard.tablejump_annotate");
+	if (!rsec)
+		return NULL;
+
+	for_each_reloc(rsec, reloc) {
+		if (reloc->sym->sec->rodata)
+			continue;
+
+		if (strcmp(insn->sec->name, reloc->sym->sec->name))
+			continue;
+
+		offset = reloc->sym->offset;
+		if (insn->offset == offset) {
+			reloc++;
+			return reloc;
+		}
+	}
+
+	return NULL;
+}
+
 struct reloc *arch_find_switch_table(struct objtool_file *file,
 				     struct instruction *insn)
 {
-	return NULL;
+	struct reloc *annotate_reloc;
+	struct reloc *rodata_reloc;
+	struct section *table_sec;
+	unsigned long table_offset;
+
+	annotate_reloc = find_reloc_by_tablejump_annotate(file, insn);
+	if (!annotate_reloc)
+		return NULL;
+
+	table_sec = annotate_reloc->sym->sec;
+	table_offset = annotate_reloc->sym->offset;
+
+	/*
+	 * Each table entry has a rela associated with it.  The rela
+	 * should reference text in the same function as the original
+	 * instruction.
+	 */
+	rodata_reloc = find_reloc_by_dest(file->elf, table_sec, table_offset);
+	if (!rodata_reloc)
+		return NULL;
+
+	return rodata_reloc;
 }
-- 
2.42.0


