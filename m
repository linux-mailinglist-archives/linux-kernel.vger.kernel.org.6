Return-Path: <linux-kernel+bounces-448406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C09F3FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406817A4373
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E47C2E630;
	Tue, 17 Dec 2024 01:09:15 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89161C687
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397754; cv=none; b=Dh9oa0CXId5LI0/zmvMwKI1qxi8ejEZU+0FZm8bDJ+AwvMQyfgFTZ/vHWiDxo6MuUf4cV4e66VICuesO7HgfvcA5wPiv9bPwef+fsJDgmgdYiMwuZ/kyIHLhBiCzsWOK7NcHXTi0zjbNajflV/VjnJmZugvQB+tkPhuHKZ96Zpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397754; c=relaxed/simple;
	bh=Ne6/TC/nupmtNSrpc7iFsVbWm9wIs+HkhWkyxpKiwbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0MwnPwu0QG99Lqnp2QOePAdKr3iUNMh8OUV/0Bfr64Bv9LSNufXSPWV4Qg5idoeZCaBs0DNwRvBwKFD5fJ2i12QNgwouk8fcGhBIvvVltZSeKFK/XmM9xSIB3Jedxc5woiwGJgWJVS6Qvm99jhQUa/md8XEYfHT3WIlMM4awuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxCeE1z2BnEZdXAA--.39950S3;
	Tue, 17 Dec 2024 09:09:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxPEcyz2BnXNeFAA--.16436S3;
	Tue, 17 Dec 2024 09:09:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/9] objtool: Handle various symbol types of rodata
Date: Tue, 17 Dec 2024 09:08:57 +0800
Message-ID: <20241217010905.13054-2-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowMDxPEcyz2BnXNeFAA--.16436S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFWDKF47Ww48JF18Gw1Dtwc_yoW5WrWDpF
	sxG3y5Kr4YvryxWwn7ta9YgFy3Gw4kWF17Jr4DKr1rZ3sFvr1rKFW2kr1ak3WDGrn2va17
	XryY9ry3CF4DA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EoGPUUUUU==

In the relocation section ".rela.rodata" of each .o file compiled with
LoongArch toolchain, there are various symbol types such as STT_NOTYPE,
STT_OBJECT, STT_FUNC in addition to the usual STT_SECTION, it needs to
use reloc symbol offset instead of reloc addend to find the destination
instruction in find_jump_table() and add_jump_table().

For the most part, an absolute relocation type is used for rodata. In the
case of STT_SECTION, reloc->sym->offset is always zero, and for the other
symbol types, reloc_addend(reloc) is always zero, thus it can use a simple
statement "reloc->sym->offset + reloc_addend(reloc)" to obtain the symbol
offset for various symbol types.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e92c5564d9ca..f64435ad3514 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1953,6 +1953,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	unsigned int prev_offset = 0;
 	struct reloc *reloc = table;
 	struct alternative *alt;
+	unsigned long sym_offset;
 
 	/*
 	 * Each @reloc is a switch table relocation which points to the target
@@ -1970,12 +1971,13 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
 			break;
 
+		sym_offset = reloc->sym->offset + reloc_addend(reloc);
+
 		/* Detect function pointers from contiguous objects: */
-		if (reloc->sym->sec == pfunc->sec &&
-		    reloc_addend(reloc) == pfunc->offset)
+		if (reloc->sym->sec == pfunc->sec && sym_offset == pfunc->offset)
 			break;
 
-		dest_insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
+		dest_insn = find_insn(file, reloc->sym->sec, sym_offset);
 		if (!dest_insn)
 			break;
 
@@ -2013,6 +2015,7 @@ static void find_jump_table(struct objtool_file *file, struct symbol *func,
 	struct reloc *table_reloc;
 	struct instruction *dest_insn, *orig_insn = insn;
 	unsigned long table_size;
+	unsigned long sym_offset;
 
 	/*
 	 * Backward search using the @first_jump_src links, these help avoid
@@ -2036,7 +2039,10 @@ static void find_jump_table(struct objtool_file *file, struct symbol *func,
 		table_reloc = arch_find_switch_table(file, insn, &table_size);
 		if (!table_reloc)
 			continue;
-		dest_insn = find_insn(file, table_reloc->sym->sec, reloc_addend(table_reloc));
+
+		sym_offset = table_reloc->sym->offset + reloc_addend(table_reloc);
+
+		dest_insn = find_insn(file, table_reloc->sym->sec, sym_offset);
 		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
 			continue;
 
-- 
2.42.0


