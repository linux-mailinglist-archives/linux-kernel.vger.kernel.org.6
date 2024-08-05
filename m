Return-Path: <linux-kernel+bounces-274224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64555947559
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4E61C20D8D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF871442F7;
	Mon,  5 Aug 2024 06:38:09 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE721E4B2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839888; cv=none; b=udRTcZngRBJq3/cjFkuUQDwgUWdBQpUJMCs7dFk4asWZtLil+AUZKV9Xb7dkzY2c/i5IDWQiXS6l0+YMWaWjt++vZGp3Qgpc35ivw9AP67YH2DCfMNpzXrym8lgmYyro/ac5gTTba2YBNhLx5I/s6gAj90C9L1WEddzZJBIvszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839888; c=relaxed/simple;
	bh=W2qjOM8zoMp8N6DTqnb2Rxdtdzr7Yge8cX0J/+C1Gbk=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PSJ+DZ2JapvFSTb6z8zoZYc5YoWrqS5FZVzSqyYBKMF/2T4WUuzJLZM2bcBLwvn0IOFvYzqnpOa+eaPZgpma+lRLrtX2Qql4nhKtt0m0wMJRRspcnWYrvJBUnyLuIt9vlFfHlDY6IC14AQ4jQ63VsmtvCLena7D7Z7f9mhshMdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxuOlGc7Bmyt8HAA--.27273S3;
	Mon, 05 Aug 2024 14:37:58 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxA+JFc7BmJhQEAA--.21528S3;
	Mon, 05 Aug 2024 14:37:58 +0800 (CST)
Subject: Re: [PATCH v2 2/3] objtool: Handle secondary stack related
 instructions
To: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>
References: <20240805032700.16038-1-yangtiezhu@loongson.cn>
 <20240805032700.16038-3-yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <3bea8b7f-b783-ba85-1ed0-c6bd3f6af92b@loongson.cn>
Date: Mon, 5 Aug 2024 14:37:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240805032700.16038-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCxA+JFc7BmJhQEAA--.21528S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr13XrW8uw4xAFWDWFyfuFX_yoW5CFyxpF
	4xW3W5ZF98Krn8uwnFqFyDWFyDAw4kKr15WF15Gw18Gr9xKFn8uanIvFsxAF1xXwn5ua48
	tFWYqry7Aw42k3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFE__UUUUU=

On 08/05/2024 11:26 AM, Tiezhu Yang wrote:
> After commit a0f7085f6a63 ("LoongArch: Add RANDOMIZE_KSTACK_OFFSET
> support"), there is a new instruction "sub.d $sp, $sp, $t0" for the
> secondary stack in do_syscall(), then there exists a objtool warning
> "do_syscall+0x11c: return with modified stack frame" and there is no
> handle_syscall() which is the previous frame of do_syscall() in the
> call trace when executing the command "echo l > /proc/sysrq-trigger".

...

> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 01237d167223..c7b9942fee29 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2993,6 +2993,28 @@ static int update_cfi_state(struct instruction *insn,
>  				break;
>  			}
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

Here should be CFI_BP instead of CFI_FP which is only defined
for LoongArch.

> +					if (insn->sym->secondary_stack) {
> +						cfa->base = CFI_SP;
> +						cfa->offset = -op->src.offset;
> +					}
> +				}
> +				break;
> +			}
> +
>  			if (op->dest.reg == CFI_SP && op->src.reg == CFI_BP) {
>
>  				/* lea disp(%rbp), %rsp */

Oh, sorry, I forgot to test this change on x86.

Here is the test info on x86: the cfa->base is CFI_BP
or CFI_BP_INDIRECT and the cfa->offset is not 0
if (op->dest.reg == CFI_SP && op->src.reg == CFI_BP),
thus it can check the following condition
if(cfa->base == CFI_BP && cfa->offset == 0)
to distinguish x86 and LoongArch.

So the correct change should be something like this
to make sure it works well for both x86 and LoongArch:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 01237d167223..0832d20c95d2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2993,10 +2993,28 @@ static int update_cfi_state(struct instruction 
*insn,
                                 break;
                         }

-                       if (op->dest.reg == CFI_SP && op->src.reg == 
CFI_BP) {
+                       if (op->dest.reg == CFI_BP && op->src.reg == 
CFI_SP) {
+                               /* addi.d fp,sp,imm for the secondary 
stack on LoongArch */
+                               if (cfa->base == CFI_SP && cfa->offset 
== op->src.offset) {
+                                       if (insn->sym->secondary_stack) {
+                                               cfa->base = CFI_BP;
+                                               cfa->offset = 0;
+                                       }
+                               }
+                               break;
+                       }

-                               /* lea disp(%rbp), %rsp */
-                               cfi->stack_size = -(op->src.offset + 
regs[CFI_BP].offset);
+                       if (op->dest.reg == CFI_SP && op->src.reg == 
CFI_BP) {
+                               /* addi.d sp,fp,imm for the secondary 
stack on LoongArch */
+                               if (cfa->base == CFI_BP && cfa->offset 
== 0) {
+                                       if (insn->sym->secondary_stack) {
+                                               cfa->base = CFI_SP;
+                                               cfa->offset = 
-op->src.offset;
+                                       }
+                               } else {
+                                       /* lea disp(%rbp), %rsp */
+                                       cfi->stack_size = 
-(op->src.offset + regs[CFI_BP].offset);
+                               }
                                 break;
                         }

I will wait for some days to get more review comments
and then send v3 later.

Thanks,
Tiezhu


