Return-Path: <linux-kernel+bounces-266828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86E794083B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62736B226A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B819005A;
	Tue, 30 Jul 2024 06:19:13 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0369D15FCEB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320352; cv=none; b=XIW5VgwSeu+mrz7R3hLQZs+/bnFJvI2KKbHBJ/BRQ8RdGk6ef1PWtuELY8GeNNaxdyU1EjoG7fImkTOgCFOWIk/WqCWDTtYJCoTanEsfrdatr3TMv2Fzr8nKaAi4lf3NJ72LCE+llXZATBeEThT/A1zpgWqdqj1hL7NWx8cRCDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320352; c=relaxed/simple;
	bh=vz2hKdAFp86DZHllck2S/sUsgOdMhETXVboVbB5vGXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTs/pzDv1dUiWI0XeTDm6bOn0pOpyQs51g0aAQO9knZY+H2IBI8xn7OGKPIl5asUP7HJozQYDBY2rJuoCeYyorXWKGX2FkhJwJPl6zfIEfMvYrdr2K60pXyAOgCM9e8W00qJ5MrtrmJban00PwdVbUvQ5zEk2sKfOcoE3ulKYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxruvXhahmz0MEAA--.14804S3;
	Tue, 30 Jul 2024 14:19:03 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxX8fVhahmehYGAA--.30051S3;
	Tue, 30 Jul 2024 14:19:02 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] objtool/LoongArch: Restrict stack operation instruction
Date: Tue, 30 Jul 2024 14:19:00 +0800
Message-ID: <20240730061901.21485-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240730061901.21485-1-yangtiezhu@loongson.cn>
References: <20240730061901.21485-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxX8fVhahmehYGAA--.30051S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF17Cr4UCw1kXr4fZw4DWrX_yoW8Kryfpr
	Zru3W3GFWUurn7Zw1vqayUWrZxGFs3XrySgF4fJa4xCr13Xrn7Xr1Ig3WYkFyvqw45K3y0
	grWfAry7JF4qvagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUc0eHDUUUU

After commit a0f7085f6a63 ("LoongArch: Add RANDOMIZE_KSTACK_OFFSET
support"), the code flow of do_syscall() was changed when compiled
with GCC due to the secondary stack of add_random_kstack_offset(),
something like this:

  addi.d          $sp, $sp, -32
  st.d            $fp, $sp, 16
  st.d            $ra, $sp, 24
  addi.d          $fp, $sp, 32
  ...
  sub.d           $sp, $sp, $t1
  ...
  addi.d          $sp, $fp, -32
  ld.d            $ra, $sp, 24
  ld.d            $fp, $sp, 16
  addi.d          $sp, $sp, 32

fp points to the stack top, it is only used to save and restore the
original sp and is not used as cfa base for arch_callee_saved_reg().
In the case OP_SRC_ADD of update_cfi_state(), the above rare case is
not handled so that lead to a wrong stack size, then there exists a
objtool warning "do_syscall+0x11c: return with modified stack frame".

Because the fp related instructions do not modify the stack frame,
no need to decode them, just restrict stack operation instruction
only with the single case "addi.d sp,sp,si12".

By the way, if fp is used as cfa base for arch_callee_saved_reg()
(there is no this behavior on LoongArch at present), then it needs
to decode the related instructions and modify update_cfi_state().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407201336.mW8dj1VB-lkp@intel.com/
Fixes: b2d23158e6c8 ("objtool/LoongArch: Implement instruction decoder")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/loongarch/decode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index aee479d2191c..6a34af675cee 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -121,8 +121,8 @@ static bool decode_insn_reg2i12_fomat(union loongarch_instruction inst,
 {
 	switch (inst.reg2i12_format.opcode) {
 	case addid_op:
-		if ((inst.reg2i12_format.rd == CFI_SP) || (inst.reg2i12_format.rj == CFI_SP)) {
-			/* addi.d sp,sp,si12 or addi.d fp,sp,si12 */
+		if ((inst.reg2i12_format.rd == CFI_SP) && (inst.reg2i12_format.rj == CFI_SP)) {
+			/* addi.d sp,sp,si12 */
 			insn->immediate = sign_extend64(inst.reg2i12_format.immediate, 11);
 			ADD_OP(op) {
 				op->src.type = OP_SRC_ADD;
-- 
2.42.0


