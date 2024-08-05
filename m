Return-Path: <linux-kernel+bounces-274513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6971094792F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212B0281626
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8538154BE3;
	Mon,  5 Aug 2024 10:15:09 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7513A41A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852909; cv=none; b=tFs5ZReRO3Mv+Z6frYfkL3lU1Buzo2NdtXdJDvgfMOjBiny+Ne1pPU5MvBMMRUeSSC+S9m3ntq55xASJ+yDUaa3yrWtp/tiea65Wr60QaRt5rbJL8gjx7YF3lGKUpcrMn5lTulnSx/S5J5Yf07nXorY27QDT+OSiwezFpWWkvs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852909; c=relaxed/simple;
	bh=OieQ7kRgK8P7X11XTdNK+TozyuFKOmlVU3TljFIuyEA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IdthwmY/LpFGLT0b/dBEfJL8SUAvg6EPXeInVpoVJXoLPZ6srxDvt5sIkYgK3I9PIrPrZLSkVgEPTYlx44MEzy0GBu2h+/1us0EBD7nu05j/0ePt1NTvYduAqkvsiGPtvRODdqobeKTqfEb/7VDAwZgd3vivbj47EMfnpR1EZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8Bx7eonprBmYvUHAA--.27137S3;
	Mon, 05 Aug 2024 18:15:03 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowMBxZOAlprBmgWEEAA--.23108S3;
	Mon, 05 Aug 2024 18:15:02 +0800 (CST)
Subject: Re: [PATCH v2 2/3] objtool: Handle secondary stack related
 instructions
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240805032700.16038-1-yangtiezhu@loongson.cn>
 <20240805032700.16038-3-yangtiezhu@loongson.cn>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <b95bd5f5-9ddb-5053-5574-f1fb5981e7b5@loongson.cn>
Date: Mon, 5 Aug 2024 18:15:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240805032700.16038-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBxZOAlprBmgWEEAA--.23108S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxKw48tF47tr1UKw1DAr13trc_yoW7Xw43pF
	sru3W3GrWrWr1fZwnFqa1UWrZ8Aw4xWry0gFnxGw1xArZIqrn3WF1SvF1YyFnYqws5W3y0
	qFWfZry2yF4jv3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
	Z7UUUUU==

On 2024-08-05 11:26, Tiezhu Yang wrote:

> After commit a0f7085f6a63 ("LoongArch: Add RANDOMIZE_KSTACK_OFFSET
> support"), there is a new instruction "sub.d $sp, $sp, $t0" for the
> secondary stack in do_syscall(), then there exists a objtool warning
> "do_syscall+0x11c: return with modified stack frame" and there is no
> handle_syscall() which is the previous frame of do_syscall() in the
> call trace when executing the command "echo l > /proc/sysrq-trigger".
>
> objdump shows something like this:
>
> 0000000000000000 <do_syscall>:
>     0:   02ff8063        addi.d          $sp, $sp, -32
>     4:   29c04076        st.d            $fp, $sp, 16
>     8:   29c02077        st.d            $s0, $sp, 8
>     c:   29c06061        st.d            $ra, $sp, 24
>    10:   02c08076        addi.d          $fp, $sp, 32
>    ...
>    74:   0011b063        sub.d           $sp, $sp, $t0
>    ...
>    a8:   4c000181        jirl            $ra, $t0, 0
>    ...
>    dc:   02ff82c3        addi.d          $sp, $fp, -32
>    e0:   28c06061        ld.d            $ra, $sp, 24
>    e4:   28c04076        ld.d            $fp, $sp, 16
>    e8:   28c02077        ld.d            $s0, $sp, 8
>    ec:   02c08063        addi.d          $sp, $sp, 32
>    f0:   4c000020        jirl            $zero, $ra, 0
>
> The instruction "sub.d $sp, $sp, $t0" changes the stack bottom
> and the new stack size is a random value, in order to find the
> return address of do_syscall() which is stored in the original
> stack frame after executing "jirl $ra, $t0, 0", it should use
> fp which points to the original stack top.
>
> This is a rare case, add a member "secondary_stack" in the struct
> symbol as a label to avoid affecting the current normal case, then
> set it as true only if there exists the secondary stack instruction
> "sub.d $sp, $sp, $t0", at last check this label for the other special
> secondary stack instructions about fp to change the cfa base and cfa
> offset during the period of secondary stack in update_cfi_state().
>
> Tested with the following two configs:
> (1) CONFIG_RANDOMIZE_KSTACK_OFFSET=y &&
>      CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=n
> (2) CONFIG_RANDOMIZE_KSTACK_OFFSET=y &&
>      CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
>
> Cc: stable@vger.kernel.org # 6.9+
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/objtool/arch/loongarch/decode.c |  8 +++++++-
>   tools/objtool/check.c                 | 22 ++++++++++++++++++++++
>   tools/objtool/include/objtool/elf.h   |  1 +
>   3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
> index db4dd05cdb49..4085714ffd18 100644
> --- a/tools/objtool/arch/loongarch/decode.c
> +++ b/tools/objtool/arch/loongarch/decode.c
> @@ -122,7 +122,7 @@ static bool decode_insn_reg2i12_fomat(union loongarch_instruction inst,
>   	switch (inst.reg2i12_format.opcode) {
>   	case addid_op:
>   		if ((inst.reg2i12_format.rd == CFI_SP) || (inst.reg2i12_format.rj == CFI_SP)) {
> -			/* addi.d sp,sp,si12 or addi.d fp,sp,si12 */
> +			/* addi.d sp,sp,si12 or addi.d fp,sp,si12 or addi.d sp,fp,si12 */
>   			insn->immediate = sign_extend64(inst.reg2i12_format.immediate, 11);
>   			ADD_OP(op) {
>   				op->src.type = OP_SRC_ADD;
> @@ -275,6 +275,8 @@ static bool decode_insn_reg2i16_fomat(union loongarch_instruction inst,
>   static bool decode_insn_reg3_fomat(union loongarch_instruction inst,
>   				   struct instruction *insn)
>   {
> +	struct symbol *func;
> +
>   	switch (inst.reg3_format.opcode) {
>   	case subd_op:
>   		if ((inst.reg3_format.rd == CFI_SP) && (inst.reg3_format.rj == CFI_SP)) {
> @@ -282,6 +284,10 @@ static bool decode_insn_reg3_fomat(union loongarch_instruction inst,
>   			 * sub.d sp,sp,t0
>   			 * this is a rare case for the secondary stack.
>   			 */
> +			func = find_func_containing(insn->sec, insn->offset);
> +			if (!func)
> +				return false;
> +			func->secondary_stack = true;
>   		}
>   		break;
>   	default:
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 01237d167223..c7b9942fee29 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2993,6 +2993,28 @@ static int update_cfi_state(struct instruction *insn,
>   				break;
>   			}
>   
> +			if (op->dest.reg == CFI_BP && op->src.reg == CFI_SP) {
> +				/* addi.d fp,sp,imm for the secondary stack on LoongArch */
> +				if (cfa->base == CFI_SP && cfa->offset == op->src.offset) {
> +					if (insn->sym->secondary_stack) {
> +						cfa->base = CFI_BP;
> +						cfa->offset = 0;
> +					}
> +				}
> +				break;
> +			}
> +
> +			if (op->dest.reg == CFI_SP && op->src.reg == CFI_BP) {
> +				/* addi.d sp,fp,imm for the secondary stack on LoongArch */
> +				if (cfa->base == CFI_FP && cfa->offset == 0) {
> +					if (insn->sym->secondary_stack) {
> +						cfa->base = CFI_SP;
> +						cfa->offset = -op->src.offset;
> +					}
> +				}
> +				break;
> +			}
> +
>   			if (op->dest.reg == CFI_SP && op->src.reg == CFI_BP) {
>   
>   				/* lea disp(%rbp), %rsp */
> diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
> index 2b8a69de4db8..586916e0d441 100644
> --- a/tools/objtool/include/objtool/elf.h
> +++ b/tools/objtool/include/objtool/elf.h
> @@ -68,6 +68,7 @@ struct symbol {
>   	u8 warned	     : 1;
>   	u8 embedded_insn     : 1;
>   	u8 local_label       : 1;
> +	u8 secondary_stack   : 1;
>   	struct list_head pv_target;
>   	struct reloc *relocs;
>   };

LGTM although I think we should make update_cfi_state() arch-specific.
It also fix many warning when use Clang, thanks.

Jinyang


