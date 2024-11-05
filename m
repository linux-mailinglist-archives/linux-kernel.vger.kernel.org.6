Return-Path: <linux-kernel+bounces-396417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 404AA9BCCDE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733BEB21F5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AC21D5CE3;
	Tue,  5 Nov 2024 12:39:14 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE591D5AAC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730810354; cv=none; b=pJ/jbpdNF+l22K77XW6/Ag9Rvm9eogFQxzNz29Nrds4zQF3OjyuCRwi87wpaYPYXCYu7R56715hnoP8YMnOf9oYCBy/LM3Y3rIRVhw6THsxzJtNC+xEQEftHy/3dC7b/bRqsq7bHq2Afs4rjTP7vsjWvnnysuxKBt2bvommE/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730810354; c=relaxed/simple;
	bh=WQBjV7XvQFc38Q87Jv1cXvfn27Td+pGBvefYsoaVrgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHY5yMDdk+zyCxGgXMZANAQWi9GX8cI6V8hw1rIRM5xBXgYJ+HO4kBpsMeLvgHZP7N3PJsXN0r1Vv8En02MfMwjeHSISjdXiBfNmCtDWR/U2gJVI2jmJrNzGVO4SziZ6/394e1rk7nvEY69sUbUZAs9QE0Sm+OyCE0IxKVmWoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxquDuESpnhLUxAA--.34568S3;
	Tue, 05 Nov 2024 20:39:10 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMBxrsLsESpnw4lCAA--.26454S3;
	Tue, 05 Nov 2024 20:39:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] objtool: Handle various symbol types for rodata
Date: Tue,  5 Nov 2024 20:39:02 +0800
Message-ID: <20241105123906.26072-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241105123906.26072-1-yangtiezhu@loongson.cn>
References: <20241105123906.26072-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxrsLsESpnw4lCAA--.26454S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFWDKF4kAF4kGFWfGw18Xrc_yoW5Ww4xpF
	sxG3y5Kr45Xr1fWws7tFW0gF9xGws7WrnrJ39rKr1rA3sIqF1rKFWSkr1ay3WDGr1Fva17
	XF1Y9ry7uF4UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxU4miiDUUUU

In the relocation section ".rela.rodata" of each .o file compiled with
LoongArch toolchain, there are various symbol types such as STT_NOTYPE,
STT_OBJECT, STT_FUNC in addition to the usual STT_SECTION, it needs to
use reloc symbol offset instead of reloc addend to find the destination
instruction in find_jump_table() and add_jump_table().

This is preparation for later patch on LoongArch, there is no effect for
the other archs with this patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6604f5d038aa..9601235e908d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2079,6 +2079,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	unsigned int prev_offset = 0;
 	struct reloc *reloc = table;
 	struct alternative *alt;
+	unsigned long offset;
 
 	/*
 	 * Each @reloc is a switch table relocation which points to the target
@@ -2094,12 +2095,19 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
 			break;
 
+		if (reloc->sym->type == STT_SECTION) {
+			/* Addend field in the relocation entry associated with the symbol */
+			offset = reloc_addend(reloc);
+		} else {
+			/* The address of the symbol in the relocation entry */
+			offset = reloc->sym->offset;
+		}
+
 		/* Detect function pointers from contiguous objects: */
-		if (reloc->sym->sec == pfunc->sec &&
-		    reloc_addend(reloc) == pfunc->offset)
+		if (reloc->sym->sec == pfunc->sec && offset == pfunc->offset)
 			break;
 
-		dest_insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
+		dest_insn = find_insn(file, reloc->sym->sec, offset);
 		if (!dest_insn)
 			break;
 
@@ -2137,6 +2145,7 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 {
 	struct reloc *table_reloc;
 	struct instruction *dest_insn, *orig_insn = insn;
+	unsigned long offset;
 
 	/*
 	 * Backward search using the @first_jump_src links, these help avoid
@@ -2160,7 +2169,16 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 		table_reloc = arch_find_switch_table(file, insn);
 		if (!table_reloc)
 			continue;
-		dest_insn = find_insn(file, table_reloc->sym->sec, reloc_addend(table_reloc));
+
+		if (table_reloc->sym->type == STT_SECTION) {
+			/* Addend field in the relocation entry associated with the symbol */
+			offset = reloc_addend(table_reloc);
+		} else {
+			/* The address of the symbol in the relocation entry */
+			offset = table_reloc->sym->offset;
+		}
+
+		dest_insn = find_insn(file, table_reloc->sym->sec, offset);
 		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
 			continue;
 
-- 
2.42.0


