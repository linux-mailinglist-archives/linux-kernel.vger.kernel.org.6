Return-Path: <linux-kernel+bounces-417781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2869F9D58F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24D72868D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E4216FF5F;
	Fri, 22 Nov 2024 04:51:45 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8D11632E8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732251104; cv=none; b=TLuIAAI7YDg8htpkJHn0TNSilxCd55YcInzgIRrpLM8WqNeuYRdW4aPDjRxfYl6O6oU/JLbARBd2FmBOF9avh9iPRY0I9pky3PJTPNeppVutL8PdwxlSlEt0eCmQ3fOO743FQCJ+l9Gj6pfEwqp9suFj25iFZC05hK8oP4/JTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732251104; c=relaxed/simple;
	bh=sXJC7+BIzrkdr2c8xg26yJGufdpB5vL4s7bxiuKEKkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiRYQDzcOsqlfSlqNFUZ42y5/plzyL6fn8xd7JQU0VnC1fsy+t2Id0WR7HQil+se30JkLPnoXc/XR/tLt24yDhR5LeaSKyuZG9dTZWy2usDGmEBnRAgfcdw9bjsGqqJy1t+ZImBD1UDFU6O/0KFv1EjeaNjp2nMHRZXCbM/Fmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxPOKMDUBn_7xFAA--.5104S3;
	Fri, 22 Nov 2024 12:50:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxdcCIDUBnIJJiAA--.33733S6;
	Fri, 22 Nov 2024 12:50:19 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/10] objtool: Handle PC relative relocation type
Date: Fri, 22 Nov 2024 12:49:59 +0800
Message-ID: <20241122045005.14617-5-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowMCxdcCIDUBnIJJiAA--.33733S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFW7tr1fWw4DuF1kWFW7Awc_yoW8Jw4xpF
	9xuw45KrsI9r17WwsrKa1kWrW5Cws7WryxJrW0kryrAF9xZF1rKay2ka15Ca1UXw1Fva1I
	vFyYkFy7Aa1DA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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

When compling with Clang on LoongArch, there exists 32 bit PC relative
relocation type, it needs to get the offset with "S + A - PC" according
to the spec of "ELF for the LoongArch Architecture".

This is preparation for later patch on LoongArch, there is no effect for
the other archs with this patch.

Link: https://github.com/loongson/la-abi-specs/blob/release/laelf.adoc
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 19d1263e64e4..8733ca620cca 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2126,6 +2126,11 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (reloc->sym->type == STT_SECTION) {
 			/* Addend field in the relocation entry associated with the symbol */
 			offset = reloc_addend(reloc);
+			/* Handle the special cases compiled with Clang on LoongArch */
+			if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
+			    reloc_type(reloc) == R_LARCH_32_PCREL)
+				offset = reloc->sym->offset + reloc_addend(reloc) -
+					 (reloc_offset(reloc) - reloc_offset(table));
 		} else {
 			/* The address of the symbol in the relocation entry */
 			offset = reloc->sym->offset;
-- 
2.42.0


