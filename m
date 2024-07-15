Return-Path: <linux-kernel+bounces-252369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D4293124D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1D6281FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E33188CB8;
	Mon, 15 Jul 2024 10:32:31 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F38188CAE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039551; cv=none; b=IfiX4NRhAfycmAXCMm8ESolhJ3BQs7D5Q8CihEFdztZfP+qe8L1r341MOjysLYUmku2JGP1TK8LwwPS10is5XNXXJdWKvRRSeAg3kuTash6AVj3WdEmafIuIJMR5OAtG+YzcnIV9uYBroh9eJkKa0T3rZN/7I9VIEOkth0FvKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039551; c=relaxed/simple;
	bh=1f1PUYMDSynzzQQV7ZnwruoYE5ot/fboiyGqOFjiY2c=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XnJ0hit0YkEH5K4VjJwIIrJEsGbrfuZVXvCAaaJW3iDIrguBKXlse/KNXeIr2fINdn21tljXlWpzCDCS7wTTaoKbsLIFcEruz06XeQBKzZ22xd6dBo50oO8liKjJIJ9uNnT+5ghE6hrKToRgQkE1FnB/yOU3mCYGDI61PIaGhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dxduq2+pRmSJIEAA--.3053S3;
	Mon, 15 Jul 2024 18:32:22 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJMW0+pRm_K1JAA--.24741S3;
	Mon, 15 Jul 2024 18:32:21 +0800 (CST)
Subject: Re: [RFC PATCH 4/4] LoongArch: Remove -fno-jump-tables for objtool
To: Huacai Chen <chenhuacai@kernel.org>
References: <20240712091506.28140-1-yangtiezhu@loongson.cn>
 <20240712091506.28140-5-yangtiezhu@loongson.cn>
 <CAAhV-H4oi1mpP8JSG1D+8CQVojGtPOpzVybCn8y8mWuMPT=zxQ@mail.gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Xi Ruoyao <xry111@xry111.site>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <497ec1a5-fdf9-037c-0781-4f25e9c4f27b@loongson.cn>
Date: Mon, 15 Jul 2024 18:32:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4oi1mpP8JSG1D+8CQVojGtPOpzVybCn8y8mWuMPT=zxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxJMW0+pRm_K1JAA--.24741S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF1UAw15ZFy7Xry3Gr1xWFX_yoW8WrWkpr
	s7A3ZrGr48Xrs5ta9xt3yvg3y2vr97KF4xWr4xtFyrArZ093yqvr18Kr1qgFy8G395tw4S
	qF1Sga4Y9F4UWFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
	sDUUUUU==

On 07/12/2024 05:40 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> On Fri, Jul 12, 2024 at 5:15 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  arch/loongarch/Kconfig  | 8 +++++++-
>>  arch/loongarch/Makefile | 6 ++----
>>  2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index ddc042895d01..57f28450a2ed 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -143,7 +143,7 @@ config LOONGARCH
>>         select HAVE_LIVEPATCH
>>         select HAVE_MOD_ARCH_SPECIFIC
>>         select HAVE_NMI
>> -       select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB && !CC_IS_CLANG
>> +       select HAVE_OBJTOOL if TOOLCHAIN_SUPPORTS_OBJTOOL && !CC_IS_CLANG
>>         select HAVE_PCI
>>         select HAVE_PERF_EVENTS
>>         select HAVE_PERF_REGS
>> @@ -276,6 +276,12 @@ config AS_HAS_LBT_EXTENSION
>>  config AS_HAS_LVZ_EXTENSION
>>         def_bool $(as-instr,hvcl 0)
>>
>> +config CC_HAS_ANNOTATE_TABLEJUMP
>> +       def_bool $(cc-option,-mannotate-tablejump)
>> +
>> +config TOOLCHAIN_SUPPORTS_OBJTOOL
>> +       def_bool AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB && CC_HAS_ANNOTATE_TABLEJUMP
> Can AS_HAS_THIN_ADD_SUB be removed now?

If the following patch can be accepted, then objtool will not rely
on AS_HAS_THIN_ADD_SUB, I will try to send this patch again.

objtool: Add skipped member in struct reloc
https://lore.kernel.org/loongarch/1690272910-11869-6-git-send-email-yangtiezhu@loongson.cn/

Thanks,
Tiezhu


