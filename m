Return-Path: <linux-kernel+bounces-413912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591439D2084
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085291F226B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51F419D06E;
	Tue, 19 Nov 2024 06:57:07 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F35614D430
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999427; cv=none; b=CGxNvhtK+Tu8b5Ypp7UvQ0Hm5jH3CY8/YPl0x3LzyaiCQZpvkgEWTPZUGrhZT9l/F9MSbN0g4GtZ7spk4Y44SydH4ZQR2ucQlcgOIuXEaBJPNHY2s1x5nH56S4021r4ledaP/ECJ+YRz58G3D4OFC928w6yEFGAwcal/suqQeUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999427; c=relaxed/simple;
	bh=nnSsZRHm+jV+Tfoq0nNKNgiSjK/fN0EvobTeEl/KG68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcLJ2tfD15q8pXIe+T9nrNWcgyJr2bqMPLnftHrC7XO9U7jr883YAIsXYOt0eh8ltfVgNFKYYqbVP3i78KqDYLhlL5lvDJHuHLEpZSbvzUJyNvSP2hJi4/LTj2X4sF0h+X4uClxMledWDkFLNrnLrzmaRnrKCW70rYzYTIDhIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx366_NjxnbTZCAA--.25167S3;
	Tue, 19 Nov 2024 14:57:03 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxDuG4NjxnB_5cAA--.5437S8;
	Tue, 19 Nov 2024 14:57:03 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/10] objtool: Handle unsorted table offset of rodata
Date: Tue, 19 Nov 2024 14:56:51 +0800
Message-ID: <20241119065655.21123-7-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241119065655.21123-1-yangtiezhu@loongson.cn>
References: <20241119065655.21123-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxDuG4NjxnB_5cAA--.5437S8
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw18uFWfGrWfWFWfJr4kKrX_yoW8uF4xpF
	15C3y8KrWYg34rKwnrt3WFgrW5Gw47Gry8Jr1xtry0v3sFvrnxtFZaka42kFyDW3y5W3WI
	vFZxKry8CFsrAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07j6sjUUUUUU=

When compling with Clang on LoongArch, there are unsorted table offset
of rodata if there exist many jump tables, it will get the wrong table
end and find the wrong jump destination instructions in add_jump_table(),
so it needs to check the table size of rodata to break the process when
parsing the relocation section of rodata.

This is preparation for later patch on LoongArch, there is no effect for
the other archs with this patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c                 | 7 +++++++
 tools/objtool/include/objtool/check.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 17df3738e087..cad9e0c21123 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2093,6 +2093,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	struct alternative *alt;
 	unsigned long offset;
 	unsigned long rodata_entry_size;
+	unsigned long rodata_table_size = insn->table_size;
 
 	/*
 	 * Each @reloc is a switch table relocation which points to the target
@@ -2104,6 +2105,12 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (reloc != table && reloc == next_table)
 			break;
 
+		/* Handle the special cases compiled with Clang on LoongArch */
+		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
+		    reloc->sym->type == STT_SECTION && reloc != table &&
+		    reloc_offset(reloc) == reloc_offset(table) + rodata_table_size)
+			break;
+
 		/* Handle the special cases compiled with Clang on LoongArch */
 		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
 		    reloc_type(reloc) == R_LARCH_32_PCREL)
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index daa46f1f0965..11aafcc7b0c7 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -46,6 +46,7 @@ struct instruction {
 	struct section *sec;
 	unsigned long offset;
 	unsigned long immediate;
+	unsigned long table_size;
 
 	u8 len;
 	u8 prev_len;
-- 
2.42.0


