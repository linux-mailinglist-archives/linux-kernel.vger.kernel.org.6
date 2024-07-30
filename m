Return-Path: <linux-kernel+bounces-267732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0569414DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0C61C231C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F2C1A2C1E;
	Tue, 30 Jul 2024 14:54:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F9A1A2577
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351280; cv=none; b=BEV13D6T4X0Xox0dNCe0IN79FTP68guCB0zzVcP6tGVIGGxj7LYgN5otBwuG0ygtPBCeQDFN35gkJnndomiVucbZjxQSNpxDLXJcTJjJU55Wg/vT5xA2WM2lZViC8PgOXVPCL6DlwwfsuvOJxNld7LXogIiDCuEPE308zmMyfpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351280; c=relaxed/simple;
	bh=D+dqNVllEU8lT2cgVsxsWINdUlJF87pze3+Qcm2ehQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChfKlUURIKNfne9+jmORlx+anb2nqYMRROPRC39BZ+uOzuUzlGgqtIVNexKrFM1JgPzU1DkIp6/R4kNbA73g2YJZwM/x76Aabprq3O2CaEgT/4u5T9RFBYAYm8jn/++DGn7592rRLaaTK/GQLJTtDjMFLeairVWsci5cfcW5msk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.44.126.21])
	by gateway (Coremail) with SMTP id _____8Axz+ur_qhmmo0EAA--.16105S3;
	Tue, 30 Jul 2024 22:54:35 +0800 (CST)
Received: from [192.168.0.108] (unknown [36.44.126.21])
	by front1 (Coremail) with SMTP id qMiowMAxHsen_qhmycEGAA--.34081S3;
	Tue, 30 Jul 2024 22:54:33 +0800 (CST)
Message-ID: <05ce0eba-22f6-ed0d-5005-227251decf50@loongson.cn>
Date: Tue, 30 Jul 2024 22:54:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] objtool/LoongArch: Restrict stack operation
 instruction
Content-Language: en-US
To: Jinyang He <hejinyang@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240730061901.21485-1-yangtiezhu@loongson.cn>
 <20240730061901.21485-2-yangtiezhu@loongson.cn>
 <4ac60afc-de6b-acf6-c9e6-1f45c0680dbe@loongson.cn>
 <6ee45e77-eb22-c4ac-ee47-6a329236eeb7@loongson.cn>
 <ca433beb-e3cd-8036-cc05-5f4cc1a735fa@loongson.cn>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <ca433beb-e3cd-8036-cc05-5f4cc1a735fa@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxHsen_qhmycEGAA--.34081S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw47uFW5Kw1ruryUJF4fWFX_yoW8Cr1rpr
	yfJa1UJFZ8Gr1fCr1qqr1DWFyYyryxJ34DWr45ta15Aws0va4Sqr1UXF4j9a1DXrs3JrWY
	yrWrZry3Zr9xXabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1
	WlkUUUUU=

On 7/30/24 18:57, Jinyang He wrote:
> 
> On 2024-07-30 17:49, Tiezhu Yang wrote:
>> On 07/30/2024 05:28 PM, Jinyang He wrote:
>>> On 2024-07-30 14:19, Tiezhu Yang wrote:
>>>
>>>> After commit a0f7085f6a63 ("LoongArch: Add RANDOMIZE_KSTACK_OFFSET
>>>> support"), the code flow of do_syscall() was changed when compiled
>>>> with GCC due to the secondary stack of add_random_kstack_offset(),
>>>> something like this:
>>>>
>>>>    addi.d          $sp, $sp, -32
>>>>    st.d            $fp, $sp, 16
>>>>    st.d            $ra, $sp, 24
>>>>    addi.d          $fp, $sp, 32
>>>>    ...
>>>>    sub.d           $sp, $sp, $t1
>>> Have you checked the ORC info whether is right or tried backtrace which
>>> passed do_syscall? The "sub.d $sp, $sp, $t1" has modified the $sp so the
>>> $sp cannot express CFA here. This patch just clear the warning but 
>>> ignore
>>> the validity of ORC info. The wrong ORC info may cause illegally access
>>> memory when backtrace.
>>
>> I did testing many times before submitting, the call trace is
>> expected when testing "echo l > /proc/sysrq-trigger".
> Make sure the RANDOMIZE_KSTACK_OFFSET is enable. I tested it by
> CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y on qemu and it did
> not show the frame about handle_syscall.

I tested with the defconfig, CONFIG_RANDOMIZE_KSTACK_OFFSET is set but
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set, the call trace has
handle_syscall() which is the previous frame of do_syscall(), and the
orc dump info is correct.

Let me modify the config file and test again with the following configs:
CONFIG_RANDOMIZE_KSTACK_OFFSET=y CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y

If there exists problem, I will fix it.

Thanks,
Tiezhu


