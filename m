Return-Path: <linux-kernel+bounces-296509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2468C95ABA2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FAD28BF56
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9E528E37;
	Thu, 22 Aug 2024 02:57:20 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20E44C97
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295440; cv=none; b=E0Hsgb/Mlg6ToKrlME+guHtrmgu3LqNQL+H8gb/nClBod3Ar9Z1AaBMvEVZZNF9I6W9x8bdM+avxetqEIExnB72xOK77h5N5la0oKyZMEUObbVQxKqhwa6cfDM1cESUEsKSe4PfLjwyfaZ/e7DQKBf4/YCFYUe/69nafcVUXT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295440; c=relaxed/simple;
	bh=8CObXoMgSKoS4ZUJ0qUwPLz2SDMC/KxFvL88BD+5ztY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=M1AjOghpnS87hx1kGF9snpdS/EZ1JKUogZRY/0hZnFD/kIimo/tsj4ErcDJ4DnvL3IfeWmQGCIdaW4zmYgUufGjToSgl3a1ipd4b7lDO+wwcklpJL2Od2LavOgoK+bad15pAWWq6YeO5eU0mZFYU1NjwrPFAXV8W2CM1M5r1Sh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxKuoLqcZmnccbAA--.59909S3;
	Thu, 22 Aug 2024 10:57:15 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMCxC2cJqcZmdF4dAA--.33083S3;
	Thu, 22 Aug 2024 10:57:15 +0800 (CST)
Subject: Re: [PATCH v1 2/2] LoongArch: Add ifdefs to fix LSX and LASX related
 issues
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240820123731.31568-1-yangtiezhu@loongson.cn>
 <20240820123731.31568-3-yangtiezhu@loongson.cn>
 <1d23bbfe-dd36-b2ff-c4b3-cf69396ea53f@loongson.cn>
 <882d3aa3-24cf-9866-7e00-161e94893811@loongson.cn>
 <57818c31-c767-e8f4-2ea9-765e2dbbe1ba@loongson.cn>
 <6a8f6421-0ea8-cec9-7e6d-8473d474baa3@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <5a4d674c-579f-f644-4fbf-9ef41d4af8de@loongson.cn>
Date: Thu, 22 Aug 2024 10:57:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6a8f6421-0ea8-cec9-7e6d-8473d474baa3@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxC2cJqcZmdF4dAA--.33083S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFyUGF18Cw1UZF48Ary3WrX_yoW5Aryxpr
	ykAFWDtFWrGr1kAr1qqw1DWa4Utr1kJw1UXr1UJFy8Jws8tr4agr4UXF1j9ryDWr4rJ3WS
	yrW8X3sIvryUJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
	14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
	WIevJa73UjIFyTuYvjxU7_MaUUUUU



On 2024/8/22 上午10:51, Tiezhu Yang wrote:
> On 08/22/2024 09:09 AM, maobibo wrote:
>>
>>
>> On 2024/8/21 下午6:07, Tiezhu Yang wrote:
>>> On 08/21/2024 09:12 AM, maobibo wrote:
>>>>
>>>>
>>>> On 2024/8/20 下午8:37, Tiezhu Yang wrote:
>>>>> There exist some issues when building kernel if CONFIG_CPU_HAS_LBT
>>>>> is set
>>>>> but CONFIG_CPU_HAS_LSX and CONFIG_CPU_HAS_LASX are not set. In this
>>>>> case,
>>>>> there are no definitions of _restore_lsx and _restore_lasx and there
>>>>> are
>>>>> also no definitions of kvm_restore_lsx and kvm_restore_lasx in fpu.S
>>>>> and
>>>>> switch.S respectively, just add some ifdefs to fix the issues.
>>>
>>> ...
>>>
>>>> It is hard to understand to put CONFIG_CPU_HAS_LASX inside
>>>> CONFIG_CPU_HAS_LBT, in general option CONFIG_CPU_HAS_LBT has nothing
>>>> with CONFIG_CPU_HAS_LASX.
>>>>
>>>> Would you like to add parameter func in macro fpu_restore_csr like 
>>>> this?
>>>>
>>>> --- a/arch/loongarch/include/asm/asmmacro.h
>>>> +++ b/arch/loongarch/include/asm/asmmacro.h
>>>> @@ -55,10 +55,11 @@
>>>>  #endif
>>>>         .endm
>>>>
>>>> -       .macro fpu_restore_csr thread tmp0 tmp1
>>>> +       .macro fpu_restore_csr thread tmp0 tmp1 func
>>>>         ldptr.w         \tmp0, \thread, THREAD_FCSR
>>>>         movgr2fcsr      fcsr0, \tmp0
>>>>  #ifdef CONFIG_CPU_HAS_LBT
>>>> +       STACK_FRAME_NON_STANDARD        \func
>>>>         /* TM bit is always 0 if LBT not supported */
>>>>         andi            \tmp0, \tmp0, FPU_CSR_TM
>>>>         beqz            \tmp0, 2f
>>>> @@ -282,10 +283,10 @@
>>>>         lsx_save_data           \thread, \tmp0
>>>>         .endm
>>>
>>> For the record, I modified the related code as you suggested and
>>> tested with various configs, it works well.
>>>
>>> But as we discussed offline, these current changes are small relatively
>>> and the STACK_FRAME_NON_STANDARD related code may be removed if there
>>> is a proper possible way, so just leave it as is in my opinion.
>> Just be curious, what is the proper possible way to remove this, is it
>> solved with new gcc/binutil version?  Do we plan to drop latest
>> gcc/binutils support in near future only in order to remove these
>> STACK_FRAME_NON_STANDARD code?
> 
> These STACK_FRAME_NON_STANDARD related assembler code are irrelevant
> with compiler toolchains, the proper possible way is not yet clear
> for now but it is only related with kernel code itself.
OK, I see. Thanks for the explanation, and I am ok for this patch.

Regards
Bibo Mao
> 
> The support of compiler toolchains is to solve the issues such as
> the relocation type of label diff and jumptable info of swith case.
> 
> The above two things are independent.
> 
> Thanks,
> Tiezhu


