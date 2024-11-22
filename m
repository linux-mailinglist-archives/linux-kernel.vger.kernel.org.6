Return-Path: <linux-kernel+bounces-417780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DFB9D58F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEA71F232CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED4F16E895;
	Fri, 22 Nov 2024 04:51:44 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129771527A7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732251103; cv=none; b=L3VixPwhYbzc0nuodbfV039oIr/2Gv8OUq/J2oDfxeY3yCo/dxyynAhW9T0GxezLWD2ZlP7dLiGGWuJp1T3HQpEa8qUsSrOWH14eNAcsZzii8ZDSaT+07XyDfsFZn/XBuj6DeeGIkk9px0DrU/Tp2vrnh8PXliSgzEzSbSJpffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732251103; c=relaxed/simple;
	bh=sUA2iDpfr8XXjasNoatf2r79oIC71AizCNh+S9ZSSqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLMAuaOEw00Z+tFz7d80/olsZ2swlcAaLR+B8OumzuLdonSmyDrm1IHJpoWKPgWwojrPfhIfj4AkEJr1jijlRL1KSTjFsLhOohMvAcp6ckNNxY5DtK005tJfcD+XRzwbKvQvMhhqWJzt32MpE2ET4iDubhGlrt0vppHvp6nBpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxIK+LDUBn+7xFAA--.47117S3;
	Fri, 22 Nov 2024 12:50:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxdcCIDUBnIJJiAA--.33733S5;
	Fri, 22 Nov 2024 12:50:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/10] objtool: Handle different entry size of rodata
Date: Fri, 22 Nov 2024 12:49:58 +0800
Message-ID: <20241122045005.14617-4-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowMCxdcCIDUBnIJJiAA--.33733S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur1fCr4kWw48AFW5ur1xJFc_yoW8Aw48pF
	43C3yrtr4Fqr17W3ZrKan5urZxCw4Igry8JFZ7try8twsFqr1rtFZak3s0kFWUXr9Yg3Wf
	Zr90yry8uF4DA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4AhLUUUUU

In the most cases, the entry size of rodata is 8 bytes because the
relocation type is 64 bit, but when compling with Clang on LoongArch,
there exists 32 bit relocation type, the entry size of rodata should
be 4 bytes in this case.

This is preparation for later patch on LoongArch, there is no effect
for the other archs with this patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 191950551352..19d1263e64e4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -26,6 +26,10 @@
 #define EM_LOONGARCH		258
 #endif
 
+#ifndef R_LARCH_32_PCREL
+#define R_LARCH_32_PCREL	99
+#endif
+
 struct alternative {
 	struct alternative *next;
 	struct instruction *insn;
@@ -2096,6 +2100,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	struct reloc *reloc = table;
 	struct alternative *alt;
 	unsigned long offset;
+	unsigned long rodata_entry_size;
 
 	/*
 	 * Each @reloc is a switch table relocation which points to the target
@@ -2107,8 +2112,15 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (reloc != table && reloc == next_table)
 			break;
 
+		/* Handle the special cases compiled with Clang on LoongArch */
+		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
+		    reloc_type(reloc) == R_LARCH_32_PCREL)
+			rodata_entry_size = 4;
+		else
+			rodata_entry_size = 8;
+
 		/* Make sure the table entries are consecutive: */
-		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
+		if (prev_offset && reloc_offset(reloc) != prev_offset + rodata_entry_size)
 			break;
 
 		if (reloc->sym->type == STT_SECTION) {
-- 
2.42.0


