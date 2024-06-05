Return-Path: <linux-kernel+bounces-202862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E58FD206
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52011F229B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216B3D96A;
	Wed,  5 Jun 2024 15:48:03 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A714D2AE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602482; cv=none; b=X6G1JgqihyVuyQI9yQ/u8BxT2nwUPClbhnQmLnqrhD8S8XRAc03fuQaJAp0zwC7WJ/C0P4yBglYJdcKvafUQohDQ/S4R5GyTz9AkkqOhQCfbq3GCQ2S/eSipVP5jTO8Feip3w1LyKxpJZ7/uOTYcj4GXIz11ittYmUVFQijedH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602482; c=relaxed/simple;
	bh=KcjSwJ0+XA4TR7oVQPcrguemEcyiaQCaDwuAVXuNCwo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ueTvHMrvkWtTSj1etUD4MGvRCmQINiBdcSUWELJd1wErD1lA5+NsZuuvY4SIL41WPocE3K7V4tf1NYzQ/q8VEEAXU7g7a18PF76Tm+ocp3VTn1zSGpLU0ODXpQoXMnx3MLgG9WNuYOJb+iPf8u7BqApmbdrxtVR3fkXP/dPBktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [106.121.188.47])
	by gateway (Coremail) with SMTP id _____8Dxi+qliGBmVdoDAA--.16618S3;
	Wed, 05 Jun 2024 23:47:49 +0800 (CST)
Received: from [192.168.78.91] (unknown [106.121.188.47])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxhsWhiGBmz9gVAA--.44278S3;
	Wed, 05 Jun 2024 23:47:47 +0800 (CST)
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
To: Xi Ruoyao <xry111@xry111.site>, Nathan Chancellor <nathan@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Youling Tang <tangyouling@kylinos.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 mengqinggang@loongson.cn, cailulu@loongson.cn, wanglei@loongson.cn,
 luweining@loongson.cn, Yujie Liu <yujie.liu@intel.com>,
 Heng Qi <hengqi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
References: <20240604150741.30252-1-xry111@xry111.site>
 <20240605054328.GA279426@thelio-3990X>
 <b55b8cb2c52f2c3701c83353586130b8dc237ee2.camel@xry111.site>
 <20240605062548.GF279426@thelio-3990X>
 <f8ef61773b0119b8573fc0fed9ad0a8b43061efd.camel@xry111.site>
 <444ec2031ef6ca016cbfa8dfedc51bddc8529ba7.camel@xry111.site>
 <ada035690e446909c3cdbf9a43a92def96020615.camel@xry111.site>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <82b7e6ea-c2cb-6364-ebe9-bff928028408@loongson.cn>
Date: Wed, 5 Jun 2024 23:47:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ada035690e446909c3cdbf9a43a92def96020615.camel@xry111.site>
Content-Type: multipart/mixed;
 boundary="------------A0BD408AA52CCDA597402C21"
Content-Language: en-US
X-CM-TRANSID:AQAAf8AxhsWhiGBmz9gVAA--.44278S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFWxuF43tFyxKw4fCr4UGFX_yoWrtw45pF
	y8JF1UGrWUJr18Ar1Utr17WFy5tr18J34UXr98tF1UJr1qyr1jqr1UXryj9r1vqr4xXw1j
	yr1UAr17Zr1jyagCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUQvjI02j7Aq62kKe7AKxVWUAVWUtwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr
	1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21le4C267I2x7xF54xIwI1l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxV
	WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUUUU=

This is a multi-part message in MIME format.
--------------A0BD408AA52CCDA597402C21
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-06-05 23:13, Xi Ruoyao wrote:

> On Wed, 2024-06-05 at 21:18 +0800, Xi Ruoyao wrote:
>> On Wed, 2024-06-05 at 18:57 +0800, Xi Ruoyao wrote:
>>> On Tue, 2024-06-04 at 23:25 -0700, Nathan Chancellor wrote:
>>>> On Wed, Jun 05, 2024 at 01:54:24PM +0800, Xi Ruoyao wrote:
>>>>> On Tue, 2024-06-04 at 22:43 -0700, Nathan Chancellor wrote:
>>>>>> For what it's worth, I have noticed some warnings with clang that I
>>>>>> don't see with GCC but I only filed an issue on our GitHub and never
>>>>>> followed up on the mailing list, so sorry about that.
>>>>>>
>>>>>> https://github.com/ClangBuiltLinux/linux/issues/2024
>>>>>>
>>>>>> Might be tangential to this patch though but I felt it was worth
>>>>>> mentioning.
>>>>> The warnings in GCC build is definitely the issue handled by this patch.
>>>>> But the warnings in Clang build should be a different issue.  Can you
>>>>> attach the kernel/events/core.o file from the Clang build for analysis?
>>>>> I guess we need to disable more optimization...
>>>> Sure thing. Let me know if there are any issues with the attachment.
>>> Thanks!  I've simplified it and now even...
>>>
>>> .global test
>>> .type test,@function
>>> test:
>>>
>>> addi.d	$sp,$sp,-448
>>> st.d	$ra,$sp,440
>>> st.d	$fp,$sp,432
>>> addi.d	$fp,$sp,448
>>>
>>> # do something
>>>
>>> addi.d	$sp,$fp,-448
>>> ld.d	$fp,$sp,432
>>> ld.d	$ra,$sp,440
>>> addi.d	$sp,$sp,448
>>> ret
>>>
>>> .size test,.-test
>>>
>>> is enough to trigger a objtool warning:
>>>
>>> /home/xry111/t1.o: warning: objtool: test+0x20: return with modified stack frame
>>>
>>> And to me this warning is bogus?
>> Minimal C reproducer:
>>
>> struct x { _Alignas(64) char buf[128]; };
>>
>> void f(struct x *p);
>> void g()
>> {
>> 	struct x x = { .buf = "1145141919810" };
>> 	f(&x);
>> }
>>
>> Then objtool is unhappy to the object file produced with "clang -c -O2"
>> from this translation unit:
>>
>> /home/xry111/t2.o: warning: objtool: g+0x50: return with modified stack frame
>>
>> It seems CFI_BP has a very specific semantic in objtool and Clang does
>> not operates $fp in the expected way.  I'm not sure about my conclusion
>> though.  Maybe Peter can explain it better.
> Another example: some simple rust code:
>
> extern { fn f(x: &i64) -> i64; }
>
> #[no_mangle]
> fn g() -> i64 {
>      let x = 114514;
>      unsafe {f(&x)}
> }
>
> It's just lucky GCC doesn't use $fp as the frame pointer unless there's
> some stupid code (VLA etc) thus the issue was not detected.
>
>
I think this because we did not add arch special handle in 
update_cfi_state().
In our 419 repo this func has been renamed arch_update_insn_state (, now it
should be arch_update_cfi_state) and give some actions to deal with the
frame pointer case. If we support it we may deal with some case but for 
clang...

.global test
.type test,@function
test:

addi.d  $sp,$sp,-448
st.d    $ra,$sp,440
st.d    $fp,$sp,432
addi.d  $fp,$sp,448

# do something  <- not change $sp

# addi.d        $sp,$fp,-448  <- not restore sp from cfa(fp)
ld.d    $fp,$sp,432
ld.d    $ra,$sp,440
addi.d  $sp,$sp,448
ret

.size test,.-test

This will cause warning, too. (Gcc should be ok, I don't test.)

source.c: (clang 19, based 0c1c0d53931, -g)
void *foo() { return __builtin_frame_address(0); }

asm.s:
         .cfi_sections .debug_frame
         .cfi_startproc
# %bb.0:
         addi.d  $sp, $sp, -16
         .cfi_def_cfa_offset 16
         st.d    $ra, $sp, 8                     # 8-byte Folded Spill
         st.d    $fp, $sp, 0                     # 8-byte Folded Spill
         .cfi_offset 1, -8
         .cfi_offset 22, -16
         addi.d  $fp, $sp, 16
         .cfi_def_cfa 22, 0                    <- define cfa is $r22
.Ltmp0:
         .loc    0 1 22 prologue_end             # hello.c:1:22
         move    $a0, $fp
         ld.d    $fp, $sp, 0                     # 8-byte Folded Reload  
<- restore regs from non-cfa ?
         ld.d    $ra, $sp, 8                     # 8-byte Folded Reload  
<- restore regs from non-cfa ?
         .loc    0 1 15 epilogue_begin is_stmt 0 # hello.c:1:15
         addi.d  $sp, $sp, 16                                            
<- restore prev-sp from non-cfa ?
         ret

Maybe Clang have anything wrong?


Attach: tmp fix by support arch_update_insn_state.


Thanks,

Jinyang


--------------A0BD408AA52CCDA597402C21
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-tmp-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-tmp-fix.patch"

From 98d31f806c018a0c5f5fe72e13bf5d107d94d93b Mon Sep 17 00:00:00 2001
From: Jinyang He <hejinyang@loongson.cn>
Date: Wed, 5 Jun 2024 21:26:36 +0800
Subject: [PATCH] tmp fix

---
 tools/objtool/arch/loongarch/decode.c | 111 ++++++
 tools/objtool/arch/x86/decode.c       | 507 ++++++++++++++++++++++++++
 tools/objtool/check.c                 | 505 +------------------------
 tools/objtool/include/objtool/arch.h  |   4 +
 4 files changed, 623 insertions(+), 504 deletions(-)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index aee479d2191c..ce4f1c140308 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -354,3 +354,114 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 	state->cfa.base = CFI_SP;
 	state->cfa.offset = 0;
 }
+
+static int update_cfi_state_regs(struct instruction *insn,
+				 struct cfi_state *cfi,
+				 struct stack_op *op)
+{
+	struct cfi_reg *cfa = &cfi->cfa;
+
+	if (cfa->base != CFI_SP && cfa->base != CFI_SP_INDIRECT)
+		return 0;
+
+	/* addi.d sp, sp, imm */
+	if (op->dest.type == OP_DEST_REG && op->src.type == OP_SRC_ADD &&
+	    op->dest.reg == CFI_SP && op->src.reg == CFI_SP)
+		cfa->offset -= op->src.offset;
+
+	return 0;
+}
+
+static void save_reg(struct cfi_state *cfi, unsigned char reg, int base,
+		     int offset)
+{
+	if (arch_callee_saved_reg(reg) &&
+	    cfi->regs[reg].base == CFI_UNDEFINED) {
+		cfi->regs[reg].base = base;
+		cfi->regs[reg].offset = offset;
+	}
+}
+
+static void restore_reg(struct cfi_state *cfi, unsigned char reg)
+{
+	cfi->regs[reg].base = CFI_UNDEFINED;
+	cfi->regs[reg].offset = 0;
+}
+
+int arch_update_cfi_state(struct instruction *insn,
+			  struct instruction *next_insn,
+			  struct cfi_state *cfi, struct stack_op *op)
+{
+	struct cfi_reg *cfa = &cfi->cfa;
+	struct cfi_reg *regs = cfi->regs;
+
+	/* ignore UNWIND_HINT_UNDEFINED regions */
+	if (cfi->force_undefined)
+		return 0;
+
+	if (cfa->base == CFI_UNDEFINED) {
+		if (insn_func(insn)) {
+			WARN_INSN(insn, "undefined stack state");
+			return -1;
+		}
+		return 0;
+	}
+
+	if (cfi->type == UNWIND_HINT_TYPE_REGS)
+		return update_cfi_state_regs(insn, cfi, op);
+
+	switch (op->dest.type) {
+	case OP_DEST_REG:
+		switch (op->src.type) {
+		case OP_SRC_ADD:
+			if (op->dest.reg == CFI_SP && op->src.reg == CFI_SP) {
+				/* addi.d sp, sp, imm */
+				cfi->stack_size -= op->src.offset;
+				if (cfa->base == CFI_SP)
+				/* addi.d sp, sp, imm */
+				cfi->stack_size -= op->src.offset;
+				if (cfa->base == CFI_SP)
+					cfa->offset -= op->src.offset;
+			} else if (op->dest.reg == CFI_FP && op->src.reg == CFI_SP) {
+				/* addi.d fp, sp, imm */
+				if (cfa->base == CFI_SP && cfa->offset == op->src.offset) {
+					cfa->base = CFI_FP;
+					cfa->offset = 0;
+				}
+			} else if (op->dest.reg == CFI_SP && op->src.reg == CFI_FP) {
+				/* addi.d sp, fp, imm */
+				if (cfa->base == CFI_FP && cfa->offset == 0) {
+					cfa->base = CFI_SP;
+					cfa->offset = -op->src.offset;
+				}
+			}
+			break;
+		case OP_SRC_REG_INDIRECT:
+			/* ld.d _reg, sp, imm */
+			if (op->src.reg == CFI_SP &&
+				op->src.offset == (regs[op->dest.reg].offset + cfi->stack_size)) {
+				restore_reg(cfi, op->dest.reg);
+				/* Gcc may not restore sp, we adjust it directly. */
+				if (cfa->base == CFI_FP && cfa->offset == 0) {
+					cfa->base = CFI_SP;
+					cfa->offset = cfi->stack_size;
+				}
+			}
+			break;
+		default:
+			break;
+		}
+		break;
+	case OP_DEST_REG_INDIRECT:
+		if (op->src.type == OP_SRC_REG) {
+			/* st.d _reg, sp, imm */
+			save_reg(cfi, op->src.reg, CFI_CFA, op->dest.offset - cfi->stack_size);
+		}
+		break;
+	default:
+		WARN_FUNC("unknown stack-related instruction", insn->sec, insn->offset);
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 3a1d80a7878d..848d890a3cbf 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -841,3 +841,510 @@ bool arch_is_embedded_insn(struct symbol *sym)
 	return !strcmp(sym->name, "retbleed_return_thunk") ||
 	       !strcmp(sym->name, "srso_safe_ret");
 }
+
+static int update_cfi_state_regs(struct instruction *insn,
+				  struct cfi_state *cfi,
+				  struct stack_op *op)
+{
+	struct cfi_reg *cfa = &cfi->cfa;
+
+	if (cfa->base != CFI_SP && cfa->base != CFI_SP_INDIRECT)
+		return 0;
+
+	/* push */
+	if (op->dest.type == OP_DEST_PUSH || op->dest.type == OP_DEST_PUSHF)
+		cfa->offset += 8;
+
+	/* pop */
+	if (op->src.type == OP_SRC_POP || op->src.type == OP_SRC_POPF)
+		cfa->offset -= 8;
+
+	/* add immediate to sp */
+	if (op->dest.type == OP_DEST_REG && op->src.type == OP_SRC_ADD &&
+	    op->dest.reg == CFI_SP && op->src.reg == CFI_SP)
+		cfa->offset -= op->src.offset;
+
+	return 0;
+}
+
+static void save_reg(struct cfi_state *cfi, unsigned char reg, int base, int offset)
+{
+	if (arch_callee_saved_reg(reg) &&
+	    cfi->regs[reg].base == CFI_UNDEFINED) {
+		cfi->regs[reg].base = base;
+		cfi->regs[reg].offset = offset;
+	}
+}
+
+static void restore_reg(struct cfi_state *cfi, unsigned char reg)
+{
+	cfi->regs[reg].base = initial_func_cfi.regs[reg].base;
+	cfi->regs[reg].offset = initial_func_cfi.regs[reg].offset;
+}
+
+/*
+ * A note about DRAP stack alignment:
+ *
+ * GCC has the concept of a DRAP register, which is used to help keep track of
+ * the stack pointer when aligning the stack.  r10 or r13 is used as the DRAP
+ * register.  The typical DRAP pattern is:
+ *
+ *   4c 8d 54 24 08		lea    0x8(%rsp),%r10
+ *   48 83 e4 c0		and    $0xffffffffffffffc0,%rsp
+ *   41 ff 72 f8		pushq  -0x8(%r10)
+ *   55				push   %rbp
+ *   48 89 e5			mov    %rsp,%rbp
+ *				(more pushes)
+ *   41 52			push   %r10
+ *				...
+ *   41 5a			pop    %r10
+ *				(more pops)
+ *   5d				pop    %rbp
+ *   49 8d 62 f8		lea    -0x8(%r10),%rsp
+ *   c3				retq
+ *
+ * There are some variations in the epilogues, like:
+ *
+ *   5b				pop    %rbx
+ *   41 5a			pop    %r10
+ *   41 5c			pop    %r12
+ *   41 5d			pop    %r13
+ *   41 5e			pop    %r14
+ *   c9				leaveq
+ *   49 8d 62 f8		lea    -0x8(%r10),%rsp
+ *   c3				retq
+ *
+ * and:
+ *
+ *   4c 8b 55 e8		mov    -0x18(%rbp),%r10
+ *   48 8b 5d e0		mov    -0x20(%rbp),%rbx
+ *   4c 8b 65 f0		mov    -0x10(%rbp),%r12
+ *   4c 8b 6d f8		mov    -0x8(%rbp),%r13
+ *   c9				leaveq
+ *   49 8d 62 f8		lea    -0x8(%r10),%rsp
+ *   c3				retq
+ *
+ * Sometimes r13 is used as the DRAP register, in which case it's saved and
+ * restored beforehand:
+ *
+ *   41 55			push   %r13
+ *   4c 8d 6c 24 10		lea    0x10(%rsp),%r13
+ *   48 83 e4 f0		and    $0xfffffffffffffff0,%rsp
+ *				...
+ *   49 8d 65 f0		lea    -0x10(%r13),%rsp
+ *   41 5d			pop    %r13
+ *   c3				retq
+ */
+int arch_update_cfi_state(struct instruction *insn,
+                            struct instruction *next_insn,
+                            struct cfi_state *cfi, struct stack_op *op)
+{
+	struct cfi_reg *cfa = &cfi->cfa;
+	struct cfi_reg *regs = cfi->regs;
+
+	/* ignore UNWIND_HINT_UNDEFINED regions */
+	if (cfi->force_undefined)
+		return 0;
+
+	/* stack operations don't make sense with an undefined CFA */
+	if (cfa->base == CFI_UNDEFINED) {
+		if (insn_func(insn)) {
+			WARN_INSN(insn, "undefined stack state");
+			return -1;
+		}
+		return 0;
+	}
+
+	if (cfi->type == UNWIND_HINT_TYPE_REGS ||
+	    cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL)
+		return update_cfi_state_regs(insn, cfi, op);
+
+	switch (op->dest.type) {
+
+	case OP_DEST_REG:
+		switch (op->src.type) {
+
+		case OP_SRC_REG:
+			if (op->src.reg == CFI_SP && op->dest.reg == CFI_BP &&
+			    cfa->base == CFI_SP &&
+			    check_reg_frame_pos(&regs[CFI_BP], -cfa->offset)) {
+
+				/* mov %rsp, %rbp */
+				cfa->base = op->dest.reg;
+				cfi->bp_scratch = false;
+			}
+
+			else if (op->src.reg == CFI_SP &&
+				 op->dest.reg == CFI_BP && cfi->drap) {
+
+				/* drap: mov %rsp, %rbp */
+				regs[CFI_BP].base = CFI_BP;
+				regs[CFI_BP].offset = -cfi->stack_size;
+				cfi->bp_scratch = false;
+			}
+
+			else if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
+
+				/*
+				 * mov %rsp, %reg
+				 *
+				 * This is needed for the rare case where GCC
+				 * does:
+				 *
+				 *   mov    %rsp, %rax
+				 *   ...
+				 *   mov    %rax, %rsp
+				 */
+				cfi->vals[op->dest.reg].base = CFI_CFA;
+				cfi->vals[op->dest.reg].offset = -cfi->stack_size;
+			}
+
+			else if (op->src.reg == CFI_BP && op->dest.reg == CFI_SP &&
+				 (cfa->base == CFI_BP || cfa->base == cfi->drap_reg)) {
+
+				/*
+				 * mov %rbp, %rsp
+				 *
+				 * Restore the original stack pointer (Clang).
+				 */
+				cfi->stack_size = -cfi->regs[CFI_BP].offset;
+			}
+
+			else if (op->dest.reg == cfa->base) {
+
+				/* mov %reg, %rsp */
+				if (cfa->base == CFI_SP &&
+				    cfi->vals[op->src.reg].base == CFI_CFA) {
+
+					/*
+					 * This is needed for the rare case
+					 * where GCC does something dumb like:
+					 *
+					 *   lea    0x8(%rsp), %rcx
+					 *   ...
+					 *   mov    %rcx, %rsp
+					 */
+					cfa->offset = -cfi->vals[op->src.reg].offset;
+					cfi->stack_size = cfa->offset;
+
+				} else if (cfa->base == CFI_SP &&
+					   cfi->vals[op->src.reg].base == CFI_SP_INDIRECT &&
+					   cfi->vals[op->src.reg].offset == cfa->offset) {
+
+					/*
+					 * Stack swizzle:
+					 *
+					 * 1: mov %rsp, (%[tos])
+					 * 2: mov %[tos], %rsp
+					 *    ...
+					 * 3: pop %rsp
+					 *
+					 * Where:
+					 *
+					 * 1 - places a pointer to the previous
+					 *     stack at the Top-of-Stack of the
+					 *     new stack.
+					 *
+					 * 2 - switches to the new stack.
+					 *
+					 * 3 - pops the Top-of-Stack to restore
+					 *     the original stack.
+					 *
+					 * Note: we set base to SP_INDIRECT
+					 * here and preserve offset. Therefore
+					 * when the unwinder reaches ToS it
+					 * will dereference SP and then add the
+					 * offset to find the next frame, IOW:
+					 * (%rsp) + offset.
+					 */
+					cfa->base = CFI_SP_INDIRECT;
+
+				} else {
+					cfa->base = CFI_UNDEFINED;
+					cfa->offset = 0;
+				}
+			}
+
+			else if (op->dest.reg == CFI_SP &&
+				 cfi->vals[op->src.reg].base == CFI_SP_INDIRECT &&
+				 cfi->vals[op->src.reg].offset == cfa->offset) {
+
+				/*
+				 * The same stack swizzle case 2) as above. But
+				 * because we can't change cfa->base, case 3)
+				 * will become a regular POP. Pretend we're a
+				 * PUSH so things don't go unbalanced.
+				 */
+				cfi->stack_size += 8;
+			}
+
+
+			break;
+
+		case OP_SRC_ADD:
+			if (op->dest.reg == CFI_SP && op->src.reg == CFI_SP) {
+
+				/* add imm, %rsp */
+				cfi->stack_size -= op->src.offset;
+				if (cfa->base == CFI_SP)
+					cfa->offset -= op->src.offset;
+				break;
+			}
+
+			if (op->dest.reg == CFI_SP && op->src.reg == CFI_BP) {
+
+				/* lea disp(%rbp), %rsp */
+				cfi->stack_size = -(op->src.offset + regs[CFI_BP].offset);
+				break;
+			}
+
+			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
+
+				/* drap: lea disp(%rsp), %drap */
+				cfi->drap_reg = op->dest.reg;
+
+				/*
+				 * lea disp(%rsp), %reg
+				 *
+				 * This is needed for the rare case where GCC
+				 * does something dumb like:
+				 *
+				 *   lea    0x8(%rsp), %rcx
+				 *   ...
+				 *   mov    %rcx, %rsp
+				 */
+				cfi->vals[op->dest.reg].base = CFI_CFA;
+				cfi->vals[op->dest.reg].offset = \
+					-cfi->stack_size + op->src.offset;
+
+				break;
+			}
+
+			if (cfi->drap && op->dest.reg == CFI_SP &&
+			    op->src.reg == cfi->drap_reg) {
+
+				 /* drap: lea disp(%drap), %rsp */
+				cfa->base = CFI_SP;
+				cfa->offset = cfi->stack_size = -op->src.offset;
+				cfi->drap_reg = CFI_UNDEFINED;
+				cfi->drap = false;
+				break;
+			}
+
+			if (op->dest.reg == cfi->cfa.base && !(next_insn && next_insn->hint)) {
+				WARN_INSN(insn, "unsupported stack register modification");
+				return -1;
+			}
+
+			break;
+
+		case OP_SRC_AND:
+			if (op->dest.reg != CFI_SP ||
+			    (cfi->drap_reg != CFI_UNDEFINED && cfa->base != CFI_SP) ||
+			    (cfi->drap_reg == CFI_UNDEFINED && cfa->base != CFI_BP)) {
+				WARN_INSN(insn, "unsupported stack pointer realignment");
+				return -1;
+			}
+
+			if (cfi->drap_reg != CFI_UNDEFINED) {
+				/* drap: and imm, %rsp */
+				cfa->base = cfi->drap_reg;
+				cfa->offset = cfi->stack_size = 0;
+				cfi->drap = true;
+			}
+
+			/*
+			 * Older versions of GCC (4.8ish) realign the stack
+			 * without DRAP, with a frame pointer.
+			 */
+
+			break;
+
+		case OP_SRC_POP:
+		case OP_SRC_POPF:
+			if (op->dest.reg == CFI_SP && cfa->base == CFI_SP_INDIRECT) {
+
+				/* pop %rsp; # restore from a stack swizzle */
+				cfa->base = CFI_SP;
+				break;
+			}
+
+			if (!cfi->drap && op->dest.reg == cfa->base) {
+
+				/* pop %rbp */
+				cfa->base = CFI_SP;
+			}
+
+			if (cfi->drap && cfa->base == CFI_BP_INDIRECT &&
+			    op->dest.reg == cfi->drap_reg &&
+			    cfi->drap_offset == -cfi->stack_size) {
+
+				/* drap: pop %drap */
+				cfa->base = cfi->drap_reg;
+				cfa->offset = 0;
+				cfi->drap_offset = -1;
+
+			} else if (cfi->stack_size == -regs[op->dest.reg].offset) {
+
+				/* pop %reg */
+				restore_reg(cfi, op->dest.reg);
+			}
+
+			cfi->stack_size -= 8;
+			if (cfa->base == CFI_SP)
+				cfa->offset -= 8;
+
+			break;
+
+		case OP_SRC_REG_INDIRECT:
+			if (!cfi->drap && op->dest.reg == cfa->base &&
+			    op->dest.reg == CFI_BP) {
+
+				/* mov disp(%rsp), %rbp */
+				cfa->base = CFI_SP;
+				cfa->offset = cfi->stack_size;
+			}
+
+			if (cfi->drap && op->src.reg == CFI_BP &&
+			    op->src.offset == cfi->drap_offset) {
+
+				/* drap: mov disp(%rbp), %drap */
+				cfa->base = cfi->drap_reg;
+				cfa->offset = 0;
+				cfi->drap_offset = -1;
+			}
+
+			if (cfi->drap && op->src.reg == CFI_BP &&
+			    op->src.offset == regs[op->dest.reg].offset) {
+
+				/* drap: mov disp(%rbp), %reg */
+				restore_reg(cfi, op->dest.reg);
+
+			} else if (op->src.reg == cfa->base &&
+			    op->src.offset == regs[op->dest.reg].offset + cfa->offset) {
+
+				/* mov disp(%rbp), %reg */
+				/* mov disp(%rsp), %reg */
+				restore_reg(cfi, op->dest.reg);
+
+			} else if (op->src.reg == CFI_SP &&
+				   op->src.offset == regs[op->dest.reg].offset + cfi->stack_size) {
+
+				/* mov disp(%rsp), %reg */
+				restore_reg(cfi, op->dest.reg);
+			}
+
+			break;
+
+		default:
+			WARN_INSN(insn, "unknown stack-related instruction");
+			return -1;
+		}
+
+		break;
+
+	case OP_DEST_PUSH:
+	case OP_DEST_PUSHF:
+		cfi->stack_size += 8;
+		if (cfa->base == CFI_SP)
+			cfa->offset += 8;
+
+		if (op->src.type != OP_SRC_REG)
+			break;
+
+		if (cfi->drap) {
+			if (op->src.reg == cfa->base && op->src.reg == cfi->drap_reg) {
+
+				/* drap: push %drap */
+				cfa->base = CFI_BP_INDIRECT;
+				cfa->offset = -cfi->stack_size;
+
+				/* save drap so we know when to restore it */
+				cfi->drap_offset = -cfi->stack_size;
+
+			} else if (op->src.reg == CFI_BP && cfa->base == cfi->drap_reg) {
+
+				/* drap: push %rbp */
+				cfi->stack_size = 0;
+
+			} else {
+
+				/* drap: push %reg */
+				save_reg(cfi, op->src.reg, CFI_BP, -cfi->stack_size);
+			}
+
+		} else {
+
+			/* push %reg */
+			save_reg(cfi, op->src.reg, CFI_CFA, -cfi->stack_size);
+		}
+
+		/* detect when asm code uses rbp as a scratch register */
+		if (opts.stackval && insn_func(insn) && op->src.reg == CFI_BP &&
+		    cfa->base != CFI_BP)
+			cfi->bp_scratch = true;
+		break;
+
+	case OP_DEST_REG_INDIRECT:
+
+		if (cfi->drap) {
+			if (op->src.reg == cfa->base && op->src.reg == cfi->drap_reg) {
+
+				/* drap: mov %drap, disp(%rbp) */
+				cfa->base = CFI_BP_INDIRECT;
+				cfa->offset = op->dest.offset;
+
+				/* save drap offset so we know when to restore it */
+				cfi->drap_offset = op->dest.offset;
+			} else {
+
+				/* drap: mov reg, disp(%rbp) */
+				save_reg(cfi, op->src.reg, CFI_BP, op->dest.offset);
+			}
+
+		} else if (op->dest.reg == cfa->base) {
+
+			/* mov reg, disp(%rbp) */
+			/* mov reg, disp(%rsp) */
+			save_reg(cfi, op->src.reg, CFI_CFA,
+				 op->dest.offset - cfi->cfa.offset);
+
+		} else if (op->dest.reg == CFI_SP) {
+
+			/* mov reg, disp(%rsp) */
+			save_reg(cfi, op->src.reg, CFI_CFA,
+				 op->dest.offset - cfi->stack_size);
+
+		} else if (op->src.reg == CFI_SP && op->dest.offset == 0) {
+
+			/* mov %rsp, (%reg); # setup a stack swizzle. */
+			cfi->vals[op->dest.reg].base = CFI_SP_INDIRECT;
+			cfi->vals[op->dest.reg].offset = cfa->offset;
+		}
+
+		break;
+
+	case OP_DEST_MEM:
+		if (op->src.type != OP_SRC_POP && op->src.type != OP_SRC_POPF) {
+			WARN_INSN(insn, "unknown stack-related memory operation");
+			return -1;
+		}
+
+		/* pop mem */
+		cfi->stack_size -= 8;
+		if (cfa->base == CFI_SP)
+			cfa->offset -= 8;
+
+		break;
+
+	default:
+		WARN_INSN(insn, "unknown stack-related instruction");
+		return -1;
+	}
+
+	return 0;
+}
+
+
+
+
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 703f99c5a80d..1fe7e21a75be 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2753,509 +2753,6 @@ static bool has_valid_stack_frame(struct insn_state *state)
 	return false;
 }
 
-static int update_cfi_state_regs(struct instruction *insn,
-				  struct cfi_state *cfi,
-				  struct stack_op *op)
-{
-	struct cfi_reg *cfa = &cfi->cfa;
-
-	if (cfa->base != CFI_SP && cfa->base != CFI_SP_INDIRECT)
-		return 0;
-
-	/* push */
-	if (op->dest.type == OP_DEST_PUSH || op->dest.type == OP_DEST_PUSHF)
-		cfa->offset += 8;
-
-	/* pop */
-	if (op->src.type == OP_SRC_POP || op->src.type == OP_SRC_POPF)
-		cfa->offset -= 8;
-
-	/* add immediate to sp */
-	if (op->dest.type == OP_DEST_REG && op->src.type == OP_SRC_ADD &&
-	    op->dest.reg == CFI_SP && op->src.reg == CFI_SP)
-		cfa->offset -= op->src.offset;
-
-	return 0;
-}
-
-static void save_reg(struct cfi_state *cfi, unsigned char reg, int base, int offset)
-{
-	if (arch_callee_saved_reg(reg) &&
-	    cfi->regs[reg].base == CFI_UNDEFINED) {
-		cfi->regs[reg].base = base;
-		cfi->regs[reg].offset = offset;
-	}
-}
-
-static void restore_reg(struct cfi_state *cfi, unsigned char reg)
-{
-	cfi->regs[reg].base = initial_func_cfi.regs[reg].base;
-	cfi->regs[reg].offset = initial_func_cfi.regs[reg].offset;
-}
-
-/*
- * A note about DRAP stack alignment:
- *
- * GCC has the concept of a DRAP register, which is used to help keep track of
- * the stack pointer when aligning the stack.  r10 or r13 is used as the DRAP
- * register.  The typical DRAP pattern is:
- *
- *   4c 8d 54 24 08		lea    0x8(%rsp),%r10
- *   48 83 e4 c0		and    $0xffffffffffffffc0,%rsp
- *   41 ff 72 f8		pushq  -0x8(%r10)
- *   55				push   %rbp
- *   48 89 e5			mov    %rsp,%rbp
- *				(more pushes)
- *   41 52			push   %r10
- *				...
- *   41 5a			pop    %r10
- *				(more pops)
- *   5d				pop    %rbp
- *   49 8d 62 f8		lea    -0x8(%r10),%rsp
- *   c3				retq
- *
- * There are some variations in the epilogues, like:
- *
- *   5b				pop    %rbx
- *   41 5a			pop    %r10
- *   41 5c			pop    %r12
- *   41 5d			pop    %r13
- *   41 5e			pop    %r14
- *   c9				leaveq
- *   49 8d 62 f8		lea    -0x8(%r10),%rsp
- *   c3				retq
- *
- * and:
- *
- *   4c 8b 55 e8		mov    -0x18(%rbp),%r10
- *   48 8b 5d e0		mov    -0x20(%rbp),%rbx
- *   4c 8b 65 f0		mov    -0x10(%rbp),%r12
- *   4c 8b 6d f8		mov    -0x8(%rbp),%r13
- *   c9				leaveq
- *   49 8d 62 f8		lea    -0x8(%r10),%rsp
- *   c3				retq
- *
- * Sometimes r13 is used as the DRAP register, in which case it's saved and
- * restored beforehand:
- *
- *   41 55			push   %r13
- *   4c 8d 6c 24 10		lea    0x10(%rsp),%r13
- *   48 83 e4 f0		and    $0xfffffffffffffff0,%rsp
- *				...
- *   49 8d 65 f0		lea    -0x10(%r13),%rsp
- *   41 5d			pop    %r13
- *   c3				retq
- */
-static int update_cfi_state(struct instruction *insn,
-			    struct instruction *next_insn,
-			    struct cfi_state *cfi, struct stack_op *op)
-{
-	struct cfi_reg *cfa = &cfi->cfa;
-	struct cfi_reg *regs = cfi->regs;
-
-	/* ignore UNWIND_HINT_UNDEFINED regions */
-	if (cfi->force_undefined)
-		return 0;
-
-	/* stack operations don't make sense with an undefined CFA */
-	if (cfa->base == CFI_UNDEFINED) {
-		if (insn_func(insn)) {
-			WARN_INSN(insn, "undefined stack state");
-			return -1;
-		}
-		return 0;
-	}
-
-	if (cfi->type == UNWIND_HINT_TYPE_REGS ||
-	    cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL)
-		return update_cfi_state_regs(insn, cfi, op);
-
-	switch (op->dest.type) {
-
-	case OP_DEST_REG:
-		switch (op->src.type) {
-
-		case OP_SRC_REG:
-			if (op->src.reg == CFI_SP && op->dest.reg == CFI_BP &&
-			    cfa->base == CFI_SP &&
-			    check_reg_frame_pos(&regs[CFI_BP], -cfa->offset)) {
-
-				/* mov %rsp, %rbp */
-				cfa->base = op->dest.reg;
-				cfi->bp_scratch = false;
-			}
-
-			else if (op->src.reg == CFI_SP &&
-				 op->dest.reg == CFI_BP && cfi->drap) {
-
-				/* drap: mov %rsp, %rbp */
-				regs[CFI_BP].base = CFI_BP;
-				regs[CFI_BP].offset = -cfi->stack_size;
-				cfi->bp_scratch = false;
-			}
-
-			else if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
-
-				/*
-				 * mov %rsp, %reg
-				 *
-				 * This is needed for the rare case where GCC
-				 * does:
-				 *
-				 *   mov    %rsp, %rax
-				 *   ...
-				 *   mov    %rax, %rsp
-				 */
-				cfi->vals[op->dest.reg].base = CFI_CFA;
-				cfi->vals[op->dest.reg].offset = -cfi->stack_size;
-			}
-
-			else if (op->src.reg == CFI_BP && op->dest.reg == CFI_SP &&
-				 (cfa->base == CFI_BP || cfa->base == cfi->drap_reg)) {
-
-				/*
-				 * mov %rbp, %rsp
-				 *
-				 * Restore the original stack pointer (Clang).
-				 */
-				cfi->stack_size = -cfi->regs[CFI_BP].offset;
-			}
-
-			else if (op->dest.reg == cfa->base) {
-
-				/* mov %reg, %rsp */
-				if (cfa->base == CFI_SP &&
-				    cfi->vals[op->src.reg].base == CFI_CFA) {
-
-					/*
-					 * This is needed for the rare case
-					 * where GCC does something dumb like:
-					 *
-					 *   lea    0x8(%rsp), %rcx
-					 *   ...
-					 *   mov    %rcx, %rsp
-					 */
-					cfa->offset = -cfi->vals[op->src.reg].offset;
-					cfi->stack_size = cfa->offset;
-
-				} else if (cfa->base == CFI_SP &&
-					   cfi->vals[op->src.reg].base == CFI_SP_INDIRECT &&
-					   cfi->vals[op->src.reg].offset == cfa->offset) {
-
-					/*
-					 * Stack swizzle:
-					 *
-					 * 1: mov %rsp, (%[tos])
-					 * 2: mov %[tos], %rsp
-					 *    ...
-					 * 3: pop %rsp
-					 *
-					 * Where:
-					 *
-					 * 1 - places a pointer to the previous
-					 *     stack at the Top-of-Stack of the
-					 *     new stack.
-					 *
-					 * 2 - switches to the new stack.
-					 *
-					 * 3 - pops the Top-of-Stack to restore
-					 *     the original stack.
-					 *
-					 * Note: we set base to SP_INDIRECT
-					 * here and preserve offset. Therefore
-					 * when the unwinder reaches ToS it
-					 * will dereference SP and then add the
-					 * offset to find the next frame, IOW:
-					 * (%rsp) + offset.
-					 */
-					cfa->base = CFI_SP_INDIRECT;
-
-				} else {
-					cfa->base = CFI_UNDEFINED;
-					cfa->offset = 0;
-				}
-			}
-
-			else if (op->dest.reg == CFI_SP &&
-				 cfi->vals[op->src.reg].base == CFI_SP_INDIRECT &&
-				 cfi->vals[op->src.reg].offset == cfa->offset) {
-
-				/*
-				 * The same stack swizzle case 2) as above. But
-				 * because we can't change cfa->base, case 3)
-				 * will become a regular POP. Pretend we're a
-				 * PUSH so things don't go unbalanced.
-				 */
-				cfi->stack_size += 8;
-			}
-
-
-			break;
-
-		case OP_SRC_ADD:
-			if (op->dest.reg == CFI_SP && op->src.reg == CFI_SP) {
-
-				/* add imm, %rsp */
-				cfi->stack_size -= op->src.offset;
-				if (cfa->base == CFI_SP)
-					cfa->offset -= op->src.offset;
-				break;
-			}
-
-			if (op->dest.reg == CFI_SP && op->src.reg == CFI_BP) {
-
-				/* lea disp(%rbp), %rsp */
-				cfi->stack_size = -(op->src.offset + regs[CFI_BP].offset);
-				break;
-			}
-
-			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
-
-				/* drap: lea disp(%rsp), %drap */
-				cfi->drap_reg = op->dest.reg;
-
-				/*
-				 * lea disp(%rsp), %reg
-				 *
-				 * This is needed for the rare case where GCC
-				 * does something dumb like:
-				 *
-				 *   lea    0x8(%rsp), %rcx
-				 *   ...
-				 *   mov    %rcx, %rsp
-				 */
-				cfi->vals[op->dest.reg].base = CFI_CFA;
-				cfi->vals[op->dest.reg].offset = \
-					-cfi->stack_size + op->src.offset;
-
-				break;
-			}
-
-			if (cfi->drap && op->dest.reg == CFI_SP &&
-			    op->src.reg == cfi->drap_reg) {
-
-				 /* drap: lea disp(%drap), %rsp */
-				cfa->base = CFI_SP;
-				cfa->offset = cfi->stack_size = -op->src.offset;
-				cfi->drap_reg = CFI_UNDEFINED;
-				cfi->drap = false;
-				break;
-			}
-
-			if (op->dest.reg == cfi->cfa.base && !(next_insn && next_insn->hint)) {
-				WARN_INSN(insn, "unsupported stack register modification");
-				return -1;
-			}
-
-			break;
-
-		case OP_SRC_AND:
-			if (op->dest.reg != CFI_SP ||
-			    (cfi->drap_reg != CFI_UNDEFINED && cfa->base != CFI_SP) ||
-			    (cfi->drap_reg == CFI_UNDEFINED && cfa->base != CFI_BP)) {
-				WARN_INSN(insn, "unsupported stack pointer realignment");
-				return -1;
-			}
-
-			if (cfi->drap_reg != CFI_UNDEFINED) {
-				/* drap: and imm, %rsp */
-				cfa->base = cfi->drap_reg;
-				cfa->offset = cfi->stack_size = 0;
-				cfi->drap = true;
-			}
-
-			/*
-			 * Older versions of GCC (4.8ish) realign the stack
-			 * without DRAP, with a frame pointer.
-			 */
-
-			break;
-
-		case OP_SRC_POP:
-		case OP_SRC_POPF:
-			if (op->dest.reg == CFI_SP && cfa->base == CFI_SP_INDIRECT) {
-
-				/* pop %rsp; # restore from a stack swizzle */
-				cfa->base = CFI_SP;
-				break;
-			}
-
-			if (!cfi->drap && op->dest.reg == cfa->base) {
-
-				/* pop %rbp */
-				cfa->base = CFI_SP;
-			}
-
-			if (cfi->drap && cfa->base == CFI_BP_INDIRECT &&
-			    op->dest.reg == cfi->drap_reg &&
-			    cfi->drap_offset == -cfi->stack_size) {
-
-				/* drap: pop %drap */
-				cfa->base = cfi->drap_reg;
-				cfa->offset = 0;
-				cfi->drap_offset = -1;
-
-			} else if (cfi->stack_size == -regs[op->dest.reg].offset) {
-
-				/* pop %reg */
-				restore_reg(cfi, op->dest.reg);
-			}
-
-			cfi->stack_size -= 8;
-			if (cfa->base == CFI_SP)
-				cfa->offset -= 8;
-
-			break;
-
-		case OP_SRC_REG_INDIRECT:
-			if (!cfi->drap && op->dest.reg == cfa->base &&
-			    op->dest.reg == CFI_BP) {
-
-				/* mov disp(%rsp), %rbp */
-				cfa->base = CFI_SP;
-				cfa->offset = cfi->stack_size;
-			}
-
-			if (cfi->drap && op->src.reg == CFI_BP &&
-			    op->src.offset == cfi->drap_offset) {
-
-				/* drap: mov disp(%rbp), %drap */
-				cfa->base = cfi->drap_reg;
-				cfa->offset = 0;
-				cfi->drap_offset = -1;
-			}
-
-			if (cfi->drap && op->src.reg == CFI_BP &&
-			    op->src.offset == regs[op->dest.reg].offset) {
-
-				/* drap: mov disp(%rbp), %reg */
-				restore_reg(cfi, op->dest.reg);
-
-			} else if (op->src.reg == cfa->base &&
-			    op->src.offset == regs[op->dest.reg].offset + cfa->offset) {
-
-				/* mov disp(%rbp), %reg */
-				/* mov disp(%rsp), %reg */
-				restore_reg(cfi, op->dest.reg);
-
-			} else if (op->src.reg == CFI_SP &&
-				   op->src.offset == regs[op->dest.reg].offset + cfi->stack_size) {
-
-				/* mov disp(%rsp), %reg */
-				restore_reg(cfi, op->dest.reg);
-			}
-
-			break;
-
-		default:
-			WARN_INSN(insn, "unknown stack-related instruction");
-			return -1;
-		}
-
-		break;
-
-	case OP_DEST_PUSH:
-	case OP_DEST_PUSHF:
-		cfi->stack_size += 8;
-		if (cfa->base == CFI_SP)
-			cfa->offset += 8;
-
-		if (op->src.type != OP_SRC_REG)
-			break;
-
-		if (cfi->drap) {
-			if (op->src.reg == cfa->base && op->src.reg == cfi->drap_reg) {
-
-				/* drap: push %drap */
-				cfa->base = CFI_BP_INDIRECT;
-				cfa->offset = -cfi->stack_size;
-
-				/* save drap so we know when to restore it */
-				cfi->drap_offset = -cfi->stack_size;
-
-			} else if (op->src.reg == CFI_BP && cfa->base == cfi->drap_reg) {
-
-				/* drap: push %rbp */
-				cfi->stack_size = 0;
-
-			} else {
-
-				/* drap: push %reg */
-				save_reg(cfi, op->src.reg, CFI_BP, -cfi->stack_size);
-			}
-
-		} else {
-
-			/* push %reg */
-			save_reg(cfi, op->src.reg, CFI_CFA, -cfi->stack_size);
-		}
-
-		/* detect when asm code uses rbp as a scratch register */
-		if (opts.stackval && insn_func(insn) && op->src.reg == CFI_BP &&
-		    cfa->base != CFI_BP)
-			cfi->bp_scratch = true;
-		break;
-
-	case OP_DEST_REG_INDIRECT:
-
-		if (cfi->drap) {
-			if (op->src.reg == cfa->base && op->src.reg == cfi->drap_reg) {
-
-				/* drap: mov %drap, disp(%rbp) */
-				cfa->base = CFI_BP_INDIRECT;
-				cfa->offset = op->dest.offset;
-
-				/* save drap offset so we know when to restore it */
-				cfi->drap_offset = op->dest.offset;
-			} else {
-
-				/* drap: mov reg, disp(%rbp) */
-				save_reg(cfi, op->src.reg, CFI_BP, op->dest.offset);
-			}
-
-		} else if (op->dest.reg == cfa->base) {
-
-			/* mov reg, disp(%rbp) */
-			/* mov reg, disp(%rsp) */
-			save_reg(cfi, op->src.reg, CFI_CFA,
-				 op->dest.offset - cfi->cfa.offset);
-
-		} else if (op->dest.reg == CFI_SP) {
-
-			/* mov reg, disp(%rsp) */
-			save_reg(cfi, op->src.reg, CFI_CFA,
-				 op->dest.offset - cfi->stack_size);
-
-		} else if (op->src.reg == CFI_SP && op->dest.offset == 0) {
-
-			/* mov %rsp, (%reg); # setup a stack swizzle. */
-			cfi->vals[op->dest.reg].base = CFI_SP_INDIRECT;
-			cfi->vals[op->dest.reg].offset = cfa->offset;
-		}
-
-		break;
-
-	case OP_DEST_MEM:
-		if (op->src.type != OP_SRC_POP && op->src.type != OP_SRC_POPF) {
-			WARN_INSN(insn, "unknown stack-related memory operation");
-			return -1;
-		}
-
-		/* pop mem */
-		cfi->stack_size -= 8;
-		if (cfa->base == CFI_SP)
-			cfa->offset -= 8;
-
-		break;
-
-	default:
-		WARN_INSN(insn, "unknown stack-related instruction");
-		return -1;
-	}
-
-	return 0;
-}
-
 /*
  * The stack layouts of alternatives instructions can sometimes diverge when
  * they have stack modifications.  That's fine as long as the potential stack
@@ -3305,7 +2802,7 @@ static int handle_insn_ops(struct instruction *insn,
 
 	for (op = insn->stack_ops; op; op = op->next) {
 
-		if (update_cfi_state(insn, next_insn, &state->cfi, op))
+		if (arch_update_cfi_state(insn, next_insn, &state->cfi, op))
 			return 1;
 
 		if (!insn->alt_group)
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 0b303eba660e..c1cf08165e44 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -96,4 +96,8 @@ int arch_rewrite_retpolines(struct objtool_file *file);
 
 bool arch_pc_relative_reloc(struct reloc *reloc);
 
+int arch_update_cfi_state(struct instruction *insn,
+			  struct instruction *next_insn,
+			  struct cfi_state *cfi, struct stack_op *op);
+
 #endif /* _ARCH_H */
-- 
2.43.0


--------------A0BD408AA52CCDA597402C21--


