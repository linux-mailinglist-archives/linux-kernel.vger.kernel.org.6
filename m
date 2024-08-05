Return-Path: <linux-kernel+bounces-274140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC8B9473DF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389741F215D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BB513DDBD;
	Mon,  5 Aug 2024 03:27:07 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249D613D26B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722828427; cv=none; b=VViqTm46Hyc5xsJLJNim+KGYYMIIaIJDDwxQ3D7YyaHHSfZfcFxh/gq46HjunJw3sjsJ1kUADsCmep0o1v2PG4iCe6jLZQTJMPjuiRpWu68jj2kQZksBz8tkKRpMFiKq3ZRG6VW2x2TxggCEuLSwDjTEsH2wYXZs1urZPkvyC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722828427; c=relaxed/simple;
	bh=hl0dbmk20s8D35tLoREPfCShfffkpWB3hKqyL5SB2wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIu1Q2c7Dxx5zcVu7RhT4lgKKsJdRMyk6laGnZVM3I2FHt7ILo4yWu4C3tUyrJeces07lmS+LLZjJKAn5n2yWSjJ6KJOHOpjSsWENBBnGrJIPRNkGkgeaFFXCpB23LJNfpPL+zT4K1lfXtYTq8osoIDNSKHH4g/aWaZT1oNiQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dxi+qGRrBmG9AHAA--.26907S3;
	Mon, 05 Aug 2024 11:27:02 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxkeGFRrBmgeADAA--.20473S3;
	Mon, 05 Aug 2024 11:27:02 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] objtool/LoongArch: Decode secondary stack instruction
Date: Mon,  5 Aug 2024 11:26:58 +0800
Message-ID: <20240805032700.16038-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240805032700.16038-1-yangtiezhu@loongson.cn>
References: <20240805032700.16038-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxkeGFRrBmgeADAA--.20473S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr13XF18tw1DZw4DKr4kAFc_yoW5Cr18pa
	nrZ3s5Jr4rWr1SyrnrJ3y5urW3Grs3WryIqFsxG34IkrWaqr95XF1IgFy0yF1kGw4rKFyI
	9r4fZw17WF1UAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxUc0eHDUUUU

After commit a0f7085f6a63 ("LoongArch: Add RANDOMIZE_KSTACK_OFFSET
support"), there is a new instruction "sub.d $sp, $sp, $t0" for the
secondary stack in do_syscall(), then there exists a objtool warning
"do_syscall+0x11c: return with modified stack frame" and there is no
handle_syscall() which is the previous frame of do_syscall() in the
call trace when executing the command "echo l > /proc/sysrq-trigger".

In order to solve the above issues, the first step is to decode the
secondary stack instruction "sub.d $sp, $sp, $t0".

Cc: stable@vger.kernel.org # 6.9+
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/loongarch/include/asm/inst.h | 12 ++++++++++++
 tools/objtool/arch/loongarch/decode.c   | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/arch/loongarch/include/asm/inst.h b/tools/arch/loongarch/include/asm/inst.h
index c25b5853181d..935b596642e2 100644
--- a/tools/arch/loongarch/include/asm/inst.h
+++ b/tools/arch/loongarch/include/asm/inst.h
@@ -51,6 +51,10 @@ enum reg2i16_op {
 	bgeu_op		= 0x1b,
 };
 
+enum reg3_op {
+	subd_op		= 0x23,
+};
+
 struct reg0i15_format {
 	unsigned int immediate : 15;
 	unsigned int opcode : 17;
@@ -96,6 +100,13 @@ struct reg2i16_format {
 	unsigned int opcode : 6;
 };
 
+struct reg3_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int rk : 5;
+	unsigned int opcode : 17;
+};
+
 union loongarch_instruction {
 	unsigned int word;
 	struct reg0i15_format	reg0i15_format;
@@ -105,6 +116,7 @@ union loongarch_instruction {
 	struct reg2i12_format	reg2i12_format;
 	struct reg2i14_format	reg2i14_format;
 	struct reg2i16_format	reg2i16_format;
+	struct reg3_format	reg3_format;
 };
 
 #define LOONGARCH_INSN_SIZE	sizeof(union loongarch_instruction)
diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index aee479d2191c..db4dd05cdb49 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -272,6 +272,25 @@ static bool decode_insn_reg2i16_fomat(union loongarch_instruction inst,
 	return true;
 }
 
+static bool decode_insn_reg3_fomat(union loongarch_instruction inst,
+				   struct instruction *insn)
+{
+	switch (inst.reg3_format.opcode) {
+	case subd_op:
+		if ((inst.reg3_format.rd == CFI_SP) && (inst.reg3_format.rj == CFI_SP)) {
+			/*
+			 * sub.d sp,sp,t0
+			 * this is a rare case for the secondary stack.
+			 */
+		}
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    struct instruction *insn)
@@ -303,6 +322,8 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		return 0;
 	if (decode_insn_reg2i16_fomat(inst, insn))
 		return 0;
+	if (decode_insn_reg3_fomat(inst, insn))
+		return 0;
 
 	if (inst.word == 0)
 		insn->type = INSN_NOP;
-- 
2.42.0


