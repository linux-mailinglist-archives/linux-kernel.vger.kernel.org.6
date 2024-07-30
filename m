Return-Path: <linux-kernel+bounces-267317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800ED941012
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFC628371A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB69197555;
	Tue, 30 Jul 2024 10:57:55 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF60E1DA32
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337075; cv=none; b=Cq7VKsBa3MiIyM7AffNa1Qcm7hIDDJXB0qnR15SmldAMVBgQ3IumtTNkEH4QWB+HyGwWmzHY+nFSDvSOoHQswmr7y84oDZT2MoL16G4X61MwhpDx8GSriNcxpEAvH3t5ETpxqxy6+azwt5gfP+wZ70tyP/YVe49nr73jROf9zdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337075; c=relaxed/simple;
	bh=fDp1d/mg0Zzqb9iZx2iJYS7OWCBh7c2Kr/tOqv+/pqE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S2xBYEQYif/Nwr4FoR3eCGfGEsbHVsGKo+E+cBqyR/dXjRCtOtL5maN16T1igi9g7f+KebHRAakUmZytXkn0n9pCUl/wkCC9cT9aLlWXw/vkX1bdP+5JMuOhClMm2Pnu3rWp0S2nZAW8FpZJVZGjfKLyUc+Gw6IbxPElJzyChzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8Cxe+oux6hmmGwEAA--.15664S3;
	Tue, 30 Jul 2024 18:57:50 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowMAxX8csx6hm5XMGAA--.32005S3;
	Tue, 30 Jul 2024 18:57:50 +0800 (CST)
Subject: Re: [PATCH 1/2] objtool/LoongArch: Restrict stack operation
 instruction
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240730061901.21485-1-yangtiezhu@loongson.cn>
 <20240730061901.21485-2-yangtiezhu@loongson.cn>
 <4ac60afc-de6b-acf6-c9e6-1f45c0680dbe@loongson.cn>
 <6ee45e77-eb22-c4ac-ee47-6a329236eeb7@loongson.cn>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <ca433beb-e3cd-8036-cc05-5f4cc1a735fa@loongson.cn>
Date: Tue, 30 Jul 2024 18:57:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6ee45e77-eb22-c4ac-ee47-6a329236eeb7@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxX8csx6hm5XMGAA--.32005S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF17Cr45Jr13uw17GF45Jwc_yoW8Kw18pF
	97J3Z8JFWkG34IkrnFqF1DWa4qyrW7Xw1UGr15ta4Fyrs8AF12gr4rXFW29FnxXrs3Jw1j
	krWfZrWxuFyqqFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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


On 2024-07-30 17:49, Tiezhu Yang wrote:
> On 07/30/2024 05:28 PM, Jinyang He wrote:
>> On 2024-07-30 14:19, Tiezhu Yang wrote:
>>
>>> After commit a0f7085f6a63 ("LoongArch: Add RANDOMIZE_KSTACK_OFFSET
>>> support"), the code flow of do_syscall() was changed when compiled
>>> with GCC due to the secondary stack of add_random_kstack_offset(),
>>> something like this:
>>>
>>>    addi.d          $sp, $sp, -32
>>>    st.d            $fp, $sp, 16
>>>    st.d            $ra, $sp, 24
>>>    addi.d          $fp, $sp, 32
>>>    ...
>>>    sub.d           $sp, $sp, $t1
>> Have you checked the ORC info whether is right or tried backtrace which
>> passed do_syscall? The "sub.d $sp, $sp, $t1" has modified the $sp so the
>> $sp cannot express CFA here. This patch just clear the warning but 
>> ignore
>> the validity of ORC info. The wrong ORC info may cause illegally access
>> memory when backtrace.
>
> I did testing many times before submitting, the call trace is
> expected when testing "echo l > /proc/sysrq-trigger".
Make sure the RANDOMIZE_KSTACK_OFFSET is enable. I tested it by
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y on qemu and it did
not show the frame about handle_syscall.

On the other hand,
$ ./tools/objtool/objtool --dump arch/loongarch/kernel/syscall.o
.noinstr.text+0:type:call sp:sp +   0 fp: (und)  ra: (und)  signal:0
.noinstr.text+4:type:call sp:sp +  32 fp: (und)  ra: (und)  signal:0
.noinstr.text+8:type:call sp:sp +  32 fp:prevsp + -16 ra: (und) signal:0
.noinstr.text+c:type:call sp:sp +  32 fp:prevsp + -16 ra:prevsp + -8 
signal:0
.noinstr.text+e4:type:call sp:sp +  32 fp:prevsp + -16 ra: (und) signal:0
.noinstr.text+e8:type:call sp:sp +  32 fp: (und)  ra: (und) signal:0
.noinstr.text+ec:type:call sp:sp +   0 fp: (und)  ra: (und) signal:0
.noinstr.text+f0:type:? sp: (und)  fp: (und)  ra: (und)  signal:0
.noinstr.text+100:type:call sp:sp +  32 fp:prevsp + -16 ra:prevsp + -8 
signal:0
.noinstr.text+118:type:? sp: (und)  fp: (und)  ra: (und)  signal:0
$ objdump -d arch/loongarch/kernel/syscall.o | grep "sub.*sp.*sp"
   70:    0011b463     sub.d           $sp, $sp, $t1
Obviously the ORC info is wrong.
(Assume the backtrace PC is 0x74, how to find the previous frame?)


