Return-Path: <linux-kernel+bounces-203522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438078FDC8A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D235A28867D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A62E1759F;
	Thu,  6 Jun 2024 02:10:17 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FCD1640B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639816; cv=none; b=L+l/WwY4lMq1yuH6PvC0DbSXVMhZeW5LXZo7M9CQYS4uV91tgEwzXKCGTTAraGGj6kdxCYKhGyUz0+6+UtpOSViXkxl/NMXz6GySEwMEXgjMVDUi06MWtpJUYVKgvV0rEhZkLr0wE6rQMgjxmUwLqQezKF5AE7Gc5m6AjPyr9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639816; c=relaxed/simple;
	bh=Z0CYkHleD15nnISvbRfPMD7qgij7i9JhEyEYYx5DE2E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IDY8i4xXS7jOEuAHdalpYDGMvVlNaiabDcU1CYKFcQ7b1YJW0st/5IE6jDUoYGoiiwKILaufk4lYGxqYSq4a4w6VIc/KTk1m87zGqJPMMOWSaKV2EfPsFB0Nsra7MF2BAFNribD4G9ZrCrxSV1uUmv1CJYYgLdhxRuPVJdXoXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8DxFPCDGmFmkgwEAA--.17399S3;
	Thu, 06 Jun 2024 10:10:11 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Axw8R9GmFmaV4WAA--.45165S3;
	Thu, 06 Jun 2024 10:10:10 +0800 (CST)
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
 <82b7e6ea-c2cb-6364-ebe9-bff928028408@loongson.cn>
 <1c132209a612e2e8953f0b458fc01853120db9a9.camel@xry111.site>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <2bf11cd2-8449-acda-f5ad-659c38cb018e@loongson.cn>
Date: Thu, 6 Jun 2024 10:10:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1c132209a612e2e8953f0b458fc01853120db9a9.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8Axw8R9GmFmaV4WAA--.45165S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW3Aw17Xw4rur43XrWftFc_yoW5ur43pF
	y8Jr1UJryUJr18Jr1UJr4UXryUJr1UJw1UJr1rJF1UJr1UJr1jqF17Xr1j9r18Xr4kJr1U
	tr4UJr1Uury5JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUUUUU

On 2024-06-06 03:05, Xi Ruoyao wrote:

> On Wed, 2024-06-05 at 23:47 +0800, Jinyang He wrote:
>> In our 419 repo this func has been renamed arch_update_insn_state (, now it
>> should be arch_update_cfi_state) and give some actions to deal with the
>> frame pointer case. If we support it we may deal with some case but for
>> clang...
>>
>> .global test
>> .type test,@function
>> test:
>>
>> addi.d  $sp,$sp,-448
>> st.d    $ra,$sp,440
>> st.d    $fp,$sp,432
>> addi.d  $fp,$sp,448
>>
>> # do something  <- not change $sp
> This is simplified.  In the real code $sp is changed, something like:
>
> bstrins.d $sp, $zero, 5, 0
>
> $fp is needed to allow restoring $sp after realigning $sp for some local
> over-aligned variables, as demonstrated by this example:
>
> struct x { _Alignas(64) char buf[128]; };
>
> void f(struct x *p);
> void g()
> {
> 	struct x x = { .buf = "1145141919810" };
> 	f(&x);
> }
>
> GCC does not align $sp, it produces the aligned address for x from an
> unaligned $sp instead:
>
> addi.d $a0, $sp, 63
> srli.d $a0, $a0, 6
> slli.d $a0, $a0, 6
>
> thus there's no need to use $fp.
>
> /* snip */
>
>> <- restore regs from non-cfa ?
>>           ld.d    $ra, $sp, 8                     # 8-byte Folded Reload
> /* snip */
>
>> Maybe Clang have anything wrong?
> I don't think we must restore regs based on $fp just because CFA is
> based on $fp.

You are right.


> The .cfi directives only provides *one* possible way to
> restore the regs.
What I just confused is that there is no ".cfi_*"
in the eplogue by clang, which may cause wrong backtrace if gdb set

breakpoint there and backtrace. (But this is out of this topic.)



> This way is convenient to the unwinder, but not
> necessarily convenient to the CPU thus the real instruction sequence can
> use a different way.  They only need to be "equivalent", not necessarily
> "exactly same."
>
> Also note that .cfi_* directives are completely irrelevant for objtool.
> THe objtool synthesizes the ORC unwind info from the machine
> instructions, not the DWARF unwind info coded with .cfi_*.
> The entire point of ORC is avoiding DWARF.  It's even named ORC because
> ORC and DWARF are sworn enemies in some tales.
Yes.
The yestorday attachment has something wrong.
Enmmmm.... (It seems I'm careless.) diff is,

                 switch (op->src.type) {
                 case OP_SRC_ADD:
                         if (op->dest.reg == CFI_SP && op->src.reg == 
CFI_SP) {
-                               /* addi.d sp, sp, imm */
-                               cfi->stack_size -= op->src.offset;
-                               if (cfa->base == CFI_SP)
                                 /* addi.d sp, sp, imm */
                                 cfi->stack_size -= op->src.offset;
                                 if (cfa->base == CFI_SP)

Or you can get the tmp fix by [1].

[1]: 
https://github.com/MQ-mengqing/linux/commit/c1f7df3eb2a2bb7a1c10c2aa6e0e3d585b457352


