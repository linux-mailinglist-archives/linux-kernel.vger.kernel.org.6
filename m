Return-Path: <linux-kernel+bounces-413913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FDE9D2085
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD739B22C79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E86F19E838;
	Tue, 19 Nov 2024 06:57:08 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D195F199FA1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999427; cv=none; b=Q2SB1Nl3bOsFoerAYxGJUud5l1h1nUhNYVfGfQ0mIdj0YJyIDwJILcTZggWDlnDg7UqufXVUg5w6er/NBAw7BZxRsEUiY5dK+YResm37IfNZaWwRzWNvqXMVoDR8QcjNTdCLBOekaYfKxe7wQf/qK+gUY16zt9o58/wdkx32O/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999427; c=relaxed/simple;
	bh=U76I/hWykKRbyzMCtFBw6tfSwAXietSBOB/FdHQh8KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGimNm9Dm47Tlw0jqJzpP773YxQyh0/OhR6gtnL7RQIbSau0kPlYlkGwuFVm3mkL8Ywww7/YbITfOKdGFvvWEMVjIXSf1ITg0nbLenhAj2C2WsJcaT8Im2AljqIlAoIIFB4Sa6rjsddYfzaWTghjsBkibBuk2IryEFn6ry42c04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxMK_ANjxncTZCAA--.40489S3;
	Tue, 19 Nov 2024 14:57:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxDuG4NjxnB_5cAA--.5437S9;
	Tue, 19 Nov 2024 14:57:03 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] objtool/LoongArch: Get each table size of rodata
Date: Tue, 19 Nov 2024 14:56:52 +0800
Message-ID: <20241119065655.21123-8-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowMCxDuG4NjxnB_5cAA--.5437S9
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZryxuFyUJFWftF4Duw47Jrc_yoW5KF48pF
	95C3s8trWYqFy5WF47AF4SyrW3Jw48WryxGr9rG3WFy343tr9Yqay2qasIk3Z5JrZ8Cr1S
	qFWrKr1xuF4kArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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
end and find the wrong jump destination instructions in add_jump_table().

Sort the rodata table offset by parsing ".rela.discard.tablejump_annotate"
and then get each table size of rodata corresponded with each table jump
instruction, it is used to check the table end and will break the process
when parsing ".rela.rodata" to avoid getting the wrong jump destination
instructions.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/loongarch/special.c | 72 ++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/loongarch/special.c
index 9bba1e9318e0..454bd01226a4 100644
--- a/tools/objtool/arch/loongarch/special.c
+++ b/tools/objtool/arch/loongarch/special.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <objtool/special.h>
+#include <objtool/warn.h>
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
@@ -8,6 +9,77 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 	return false;
 }
 
+struct table_info {
+	struct list_head jump_info;
+	unsigned long insn_offset;
+	unsigned long rodata_offset;
+};
+
+static void get_rodata_table_size_by_table_annotate(struct objtool_file *file,
+						    struct instruction *insn)
+{
+	struct section *rsec;
+	struct reloc *reloc;
+	struct list_head table_list;
+	struct table_info *orig_table;
+	struct table_info *next_table;
+	unsigned long tmp_insn_offset;
+	unsigned long tmp_rodata_offset;
+
+	rsec = find_section_by_name(file->elf, ".rela.discard.tablejump_annotate");
+	if (!rsec)
+		return;
+
+	INIT_LIST_HEAD(&table_list);
+
+	for_each_reloc(rsec, reloc) {
+		if (reloc->sym->type != STT_SECTION)
+			return;
+
+		orig_table = malloc(sizeof(struct table_info));
+		if (!orig_table) {
+			WARN("malloc failed");
+			return;
+		}
+
+		orig_table->insn_offset = reloc_addend(reloc);
+		reloc++;
+		orig_table->rodata_offset = reloc_addend(reloc);
+
+		list_add_tail(&orig_table->jump_info, &table_list);
+
+		if (reloc_idx(reloc) + 1 == sec_num_entries(rsec))
+			break;
+	}
+
+	list_for_each_entry(orig_table, &table_list, jump_info) {
+		next_table = list_next_entry(orig_table, jump_info);
+		list_for_each_entry_from(next_table, &table_list, jump_info) {
+			if (next_table->rodata_offset < orig_table->rodata_offset) {
+				tmp_insn_offset = next_table->insn_offset;
+				tmp_rodata_offset = next_table->rodata_offset;
+				next_table->insn_offset = orig_table->insn_offset;
+				next_table->rodata_offset = orig_table->rodata_offset;
+				orig_table->insn_offset = tmp_insn_offset;
+				orig_table->rodata_offset = tmp_rodata_offset;
+			}
+		}
+	}
+
+	list_for_each_entry(orig_table, &table_list, jump_info) {
+		if (insn->offset == orig_table->insn_offset) {
+			next_table = list_next_entry(orig_table, jump_info);
+			if (&next_table->jump_info == &table_list)
+				break;
+
+			while (next_table->rodata_offset == orig_table->rodata_offset)
+				next_table = list_next_entry(next_table, jump_info);
+
+			insn->table_size = next_table->rodata_offset - orig_table->rodata_offset;
+		}
+	}
+}
+
 struct reloc *arch_find_switch_table(struct objtool_file *file,
 				     struct instruction *insn)
 {
-- 
2.42.0


