Return-Path: <linux-kernel+bounces-422215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D729D95F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18E6166D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42CD1CD214;
	Tue, 26 Nov 2024 11:04:44 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6780F7DA68
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732619084; cv=none; b=OykoOzNw+qbAuzIcobMsvTCaDf87ITZqJHGEB00JL7feOj4nk8VV6OSYSR5PgjtjCdZfiqJI0XLqDs1MbOEcpuTrnyW5JOB+8bfzygK9D0PNtnjb6ZbMa6LbJqHtdEB/U9LRDylDzbPsHMvlL7O6p+PEWRPA/CZB8ho9ZwNe1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732619084; c=relaxed/simple;
	bh=Qjj4TlnexTrYfYx0Fb86z88nPbDi3KHCHpXW+CWZSMo=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ah+sqxMEQQfO7BwyQLyRoOrGaFSn5eeM5s6I1J2sVc1CFOu894r1zCrCX07muphwKohxobpCj+jM32zk7N9Nzp094xk59g6g5FttWGeBxp1NNwRlQC5MbvxUTSHgOV/C5ma9AuT4Km0rcW02yXs4amerMcFAc3VwiQay6fAOZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxG+JIq0VnsRFJAA--.11302S3;
	Tue, 26 Nov 2024 19:04:40 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxyOJHq0VnunJoAA--.23008S3;
	Tue, 26 Nov 2024 19:04:39 +0800 (CST)
Subject: Re: [PATCH v4 05/10] objtool: Handle unreachable entry of rodata
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-6-yangtiezhu@loongson.cn>
 <20241126072557.b6qt7jaiikvkcswn@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <20537f77-e105-317b-7f95-8a72533c8e43@loongson.cn>
Date: Tue, 26 Nov 2024 19:04:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241126072557.b6qt7jaiikvkcswn@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCxyOJHq0VnunJoAA--.23008S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArykKr43KFW8Kw48tr1kJFc_yoW8uFyDpF
	15Way2kF4jqryIk3ZrK3Wjgry5Gws7Gry8Gryvyr4UG347Zrn5tFWSka12va47Ww15u3WI
	vFWYgryUWF4jyagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU

On 11/26/2024 03:25 PM, Josh Poimboeuf wrote:
> On Fri, Nov 22, 2024 at 12:50:00PM +0800, Tiezhu Yang wrote:
>> When compling with Clang on LoongArch, there exists unreachable entry of
>> rodata which points to a position after the function return instruction,
>> this is generated by compiler to fill the non-existent switch case, just
>> skip the entry when parsing the relocation section of rodata.
>>
>> This is preparation for later patch on LoongArch, there is no effect for
>> the other archs with this patch.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  tools/objtool/check.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index 8733ca620cca..b21e47d8d3d1 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
>> @@ -2144,6 +2144,13 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>>  		if (!dest_insn)
>>  			break;
>>
>> +		/* Handle the special cases compiled with Clang on LoongArch */
>> +		if (file->elf->ehdr.e_machine == EM_LOONGARCH && reloc->sym->type == STT_SECTION &&
>> +		    (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc != pfunc)) {
>> +			prev_offset = reloc_offset(reloc);
>> +			continue;
>
> Are you sure this is specific to loongarch?

I am not sure, I only found this issue on LoongArch compiled with Clang,
but I think there is no effect if make it generic, like this:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f7586f82b967..87302e6fc07f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2103,9 +2103,10 @@ static int add_jump_table(struct objtool_file 
*file, struct instruction *insn,
                 if (!dest_insn)
                         break;

-               /* Make sure the destination is in the same function: */
-               if (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc 
!= pfunc)
-                       break;
+               if (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc 
!= pfunc) {
+                       prev_offset = reloc_offset(reloc);
+                       continue;
+               }

                 alt = malloc(sizeof(*alt));
                 if (!alt) {

If you are OK, I will modify it.

Thanks,
Tiezhu


