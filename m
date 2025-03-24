Return-Path: <linux-kernel+bounces-573083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E540A6D2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA501889DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C3A2110E;
	Mon, 24 Mar 2025 01:44:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D294B667
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742780661; cv=none; b=DKZ85dFHH7wYdXLSY8wGGdO0A3kjPM6b6IBSiM0rV/1/RDFGOApZhwm7ErcYwFLTuGTJTSreU2CGIt1hbgPy/EU9HYcCHQCwY3p0iEOvWfLyuisZQAWF9nRXpdellfIP2opfD2CtsfhTRTLi1Q/lbH7AbiHSOlulieweAsF1rSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742780661; c=relaxed/simple;
	bh=xRbrfHOuddHYdxNvjKjVq6wM8tNLSTWFvbiXOpOeo8w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VxNs2sYgvXTZnh+BSaQYq+HfED5r5qp36JYocKByt3tl4Jp4g1J8YzRd22sZ/10s+SrGeLHqBsS4TUK7yncpTAXRpaH++mGkIBYXSVuatL+xGqepQUWwIxEPctdAKmgcmsjSshx25y7wjR6iix8YB4cM9GvtKC7Sq6MH/qv2A80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8DxjXKVuOBnJJmjAA--.12635S3;
	Mon, 24 Mar 2025 09:42:45 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowMDxu8SPuOBnTflcAA--.9800S3;
	Mon, 24 Mar 2025 09:42:41 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: KGDB: Rework arch_kgdb_breakpoint()
 implementation
To: Huacai Chen <chenhuacai@kernel.org>, WangYuli <wangyuli@uniontech.com>
Cc: kernel@xen0n.name, guanwentao@uniontech.com, wentao@uniontech.com,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhoubinbin@loongson.cn, lihui@loongson.cn, rdunlap@infradead.org,
 chenhuacai@loongson.cn, zhanjun@uniontech.com, niecheng1@uniontech.com,
 Tiezhu Yang <yangtiezhu@loongson.cn>
References: <943E06D656E4E707+20250321141001.109916-1-wangyuli@uniontech.com>
 <CAAhV-H71aEKj2V8mAqbUuAe1JiHngWHW3rSaJ_Dx_CzoQC7TgQ@mail.gmail.com>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <545ed081-bec3-395c-e0dd-a45146e00cd1@loongson.cn>
Date: Mon, 24 Mar 2025 09:42:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H71aEKj2V8mAqbUuAe1JiHngWHW3rSaJ_Dx_CzoQC7TgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMDxu8SPuOBnTflcAA--.9800S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF4UGFyxtr1fKF13WF43XFc_yoW5WFW3pF
	48Ca4qkF48Jry8C39xK3y3Zr15Aws7Ww4xZ3Z8Ka4fCayDX3W5tr1IkFn7Wa4jgw1xK3W0
	vF90gF92q3W5J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOa93UUU
	UU=

On 2025-03-22 20:51, Huacai Chen wrote:

> Hi, Tiezhu & Jinyang,
>
> On Fri, Mar 21, 2025 at 10:11 PM WangYuli <wangyuli@uniontech.com> wrote:
>> The arch_kgdb_breakpoint() function defines the kgdb_breakinst
>> symbol using inline assembly.
>>
>> There's a potential issue where the compiler might inline
>> arch_kgdb_breakpoint(), which would then define the kgdb_breakinst
>> symbol multiple times, leading to a linker error.
>>
>> To prevent this, declare arch_kgdb_breakpoint() as noline.
>>
>> Fix follow error with LLVM-19 *only* when LTO_CLANG_FULL:
>>      LD      vmlinux.o
>>    ld.lld-19: error: ld-temp.o <inline asm>:3:1: symbol 'kgdb_breakinst' is already defined
>>    kgdb_breakinst: break 2
>>    ^
>>
>> Additionally, remove "nop" here because it's meaningless for LoongArch
>> here.
>>
>> Fixes: e14dd076964e ("LoongArch: Add basic KGDB & KDB support")
>> Co-developed-by: Winston Wen <wentao@uniontech.com>
>> Signed-off-by: Winston Wen <wentao@uniontech.com>
>> Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
>> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
>> Co-developed-by: Huacai Chen <chenhuacai@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> Tested-by: Yuli Wang <wangyuli@uniontech.com>
>> Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
>> Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
>> ---
>> Changelog:
>>   *v1->v2:
>>      1. Drop the nop which is no effect for LoongArch here.
>>      2. Add "STACK_FRAME_NON_STANDARD" for arch_kgdb_breakpoint() to
>> avoid the objtool warning.
>> ---
>>   arch/loongarch/kernel/kgdb.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kgdb.c
>> index 445c452d72a7..38bd0561d7d5 100644
>> --- a/arch/loongarch/kernel/kgdb.c
>> +++ b/arch/loongarch/kernel/kgdb.c
>> @@ -224,13 +224,13 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
>>          regs->csr_era = pc;
>>   }
>>
>> -void arch_kgdb_breakpoint(void)
>> +noinline void arch_kgdb_breakpoint(void)
>>   {
>>          __asm__ __volatile__ (                  \
>>                  ".globl kgdb_breakinst\n\t"     \
>> -               "nop\n"                         \
>>                  "kgdb_breakinst:\tbreak 2\n\t"); /* BRK_KDB = 2 */
>>   }
>> +STACK_FRAME_NON_STANDARD(arch_kgdb_breakpoint);
> Is there a better solution than STACK_FRAME_NON_STANDARD()? In the
> past we can use annotate_reachable() in arch_kgdb_breakpoint(), but
> annotate_reachable() is no longer exist.

Maybe we can parse the imm-code of `break` and set diffrent insn_type in 
objtool.
The BRK_KDB imply the PC will go head, while the BRK_BUG imply PC stop.
(arch/loongarch/include/uapi/asm/break.h)

Tiezhu, how do you think?


>
> Huacai
>
>>   /*
>>    * Calls linux_debug_hook before the kernel dies. If KGDB is enabled,
>> --
>> 2.49.0
>>


