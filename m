Return-Path: <linux-kernel+bounces-417778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314599D58F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B29B23072
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A76017A922;
	Fri, 22 Nov 2024 04:50:32 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAC71632E6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732251031; cv=none; b=RjaU4c5ZxmZccdstAfMZfsVN365ff/zdFTYQSKm7SWfDlghQ5Jb+g7ct4O4HRwqBlJAsoFEgpVMGwPj5Aaj/e05yPyldF75yimYTNkl/OO8Yh7/Soi1MHNMTrOpOAyNOpE0/kETcmAVen4WT0rdgC1nqkNTllYPYwlGH5kSuYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732251031; c=relaxed/simple;
	bh=pZll4EsN3g1CnxWFPtzbSrUz+zKAT53GwKlq67qeI8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjFSkLTatqjcWt7ArQtQAOtZ3Kxv1p0zewTQHIvEWAq5ISyEpvs0Zr7UTOHv8xHFME96g4t/cG5P14cuqlUU8WFnlJ3IH05QKVYRye3LMOWfKzlJTht3kr6r3t+24Eu8bvVhYqmgvLCfdFN9+wR/myAD5B64hc8Bj3ZLNfDBlGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxYa+NDUBnB71FAA--.6023S3;
	Fri, 22 Nov 2024 12:50:21 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxdcCIDUBnIJJiAA--.33733S8;
	Fri, 22 Nov 2024 12:50:21 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/10] objtool: Handle unsorted table offset of rodata
Date: Fri, 22 Nov 2024 12:50:01 +0800
Message-ID: <20241122045005.14617-7-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241122045005.14617-1-yangtiezhu@loongson.cn>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxdcCIDUBnIJJiAA--.33733S8
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw18uFWfGrWfWFWfJr4kKrX_yoW8uF4xpF
	15C3y8KrWYg34rKwnrt3WFg3y5Gw47GryxJr1xtry0q3sFvrnxtFZaka42kFWDX3y5W3WI
	va9xKry8CFs2yFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4AhLUUUUU

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
index b21e47d8d3d1..3b2d94c90011 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2101,6 +2101,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	struct alternative *alt;
 	unsigned long offset;
 	unsigned long rodata_entry_size;
+	unsigned long rodata_table_size = insn->table_size;
 
 	/*
 	 * Each @reloc is a switch table relocation which points to the target
@@ -2112,6 +2113,12 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
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


