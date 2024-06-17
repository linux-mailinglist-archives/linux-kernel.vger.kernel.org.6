Return-Path: <linux-kernel+bounces-216575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CA590A1A7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D62B1F2164A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199774C6F;
	Mon, 17 Jun 2024 01:14:45 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9641C23A9;
	Mon, 17 Jun 2024 01:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718586884; cv=none; b=UIoyHbZ6jKN/zCvZfML6dubOgFOxVljdYdNYw2+rwsEx9qVTql6RcAvim2YfTFEmrRMeb0rj/x8LTbpq3d3IH6GWQIkji8h7wGRzyhNiFB1qOiHwo1b75aONUsHBCjdrWDTTkI5vkWTXP0O6PlDdEyiLYUEgf2d+iOBN9j5lTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718586884; c=relaxed/simple;
	bh=qIu5rQTukuOoWbQVvyIFGv0UMiz5h00XdlWs48l3Bvw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aftXVV09r+LaorX5bqyKryqWCFjDbbbHCezD/SEK6zBwLGQn6ug6PyV2xAikkS60atUeE6l6iEXWyY2gVhBPHacM2vXg6kPoSm3w3sPdU5q0tqOlJaIxAzAlS4QR0PXeXFaaffBETSmo2rOhxrpT2WPJiz1GBVas65IgHHiubtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8DxDev4jW9mwm8HAA--.29658S3;
	Mon, 17 Jun 2024 09:14:32 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxnsf3jW9mMK0kAA--.23879S3;
	Mon, 17 Jun 2024 09:14:31 +0800 (CST)
Subject: Re: [PATCH V1 1/2] docs: Add advanced extended IRQ model description
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, corbet@lwn.net, alexs@kernel.org,
 siyanteng@loongson.cn, loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240604125015.18678-1-zhangtianyang@loongson.cn>
 <CAAhV-H704OFWf87v4TaEzNDRPOXZYPMTgZnuWtvbE4CzPjYH3g@mail.gmail.com>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <89d8cfbb-59ca-520a-b7f8-36bf4bffed09@loongson.cn>
Date: Mon, 17 Jun 2024 09:14:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H704OFWf87v4TaEzNDRPOXZYPMTgZnuWtvbE4CzPjYH3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8Bxnsf3jW9mMK0kAA--.23879S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFWUZw4DKF13JrykAr1UJwc_yoW7GrWrpr
	9xGF9avF48Wry5Wr17Jr48Wr17Jw1fK3WDtF1xKry8Xr1qyr1Dtr1Utr1kXFW7G348AF12
	qFy5Kw1DA3WUA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==

Hi, Huacai

在 2024/6/12 下午3:15, Huacai Chen 写道:
> Hi, Tianyang,
>
> On Tue, Jun 4, 2024 at 8:50 PM Tianyang Zhang <zhangtianyang@loongson.cn> wrote:
>>  From 3C6000, Loongarch began to support advanced extended
>> interrupt mode, in which each CPU has an independent interrupt
>> vector number.This will enhance the architecture's ability
>> to support modern devices
>>
>> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
>> ---
>>   .../arch/loongarch/irq-chip-model.rst         | 33 +++++++++++++++++
>>   .../zh_CN/arch/loongarch/irq-chip-model.rst   | 37 +++++++++++++++++--
>>   2 files changed, 67 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documentation/arch/loongarch/irq-chip-model.rst
>> index 7988f4192363..4fb24077b23b 100644
>> --- a/Documentation/arch/loongarch/irq-chip-model.rst
>> +++ b/Documentation/arch/loongarch/irq-chip-model.rst
>> @@ -85,6 +85,39 @@ to CPUINTC directly::
>>       | Devices |
>>       +---------+
>>
>> +Advanced Extended IRQ model
>> +===========================
>> +
>> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
>> +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, MSI interrupts go to AVEC,
>> +and then go to CPUINTC, Other devices interrupts go to PCH-PIC/PCH-LPC and gathered
>> +by EIOINTC, and then go to CPUINTC directly::
>> +
>> + +-----+     +--------------------------+     +-------+
>> + | IPI | --> |           CPUINTC        | <-- | Timer |
>> + +-----+     +--------------------------+     +-------+
>> +              ^        ^             ^
>> +              |        |             |
>> +      +--------+  +---------+ +---------+     +-------+
>> +      | AVEC   |  | EIOINTC | | LIOINTC | <-- | UARTs |
>> +      +--------+  +---------+ +---------+     +-------+
>> +           ^            ^
>> +           |            |
>> +         +---------+  +---------+
>> +         |   MSI   |  | PCH-PIC |
>> +         +---------+  +---------+
> Please change MSI to PCH-MSI, because it is called pch-msi the both
> the in driver name and in other figures of this document.
>
> Huacai
OK , I will fix this as soon as possible
>
>> +            ^          ^       ^
>> +            |          |       |
>> +    +---------+ +---------+ +---------+
>> +    | Devices | | PCH-LPC | | Devices |
>> +    +---------+ +---------+ +---------+
>> +                     ^
>> +                     |
>> +                +---------+
>> +                | Devices |
>> +                +---------+
>> +
>> +
>>   ACPI-related definitions
>>   ========================
>>
>> diff --git a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
>> index f1e9ab18206c..cadf38589059 100644
>> --- a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
>> +++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
>> @@ -9,9 +9,8 @@
>>   LoongArch的IRQ芯片模型（层级关系）
>>   ==================================
>>
>> -目前，基于LoongArch的处理器（如龙芯3A5000）只能与LS7A芯片组配合工作。LoongArch计算机
>> -中的中断控制器（即IRQ芯片）包括CPUINTC（CPU Core Interrupt Controller）、LIOINTC（
>> -Legacy I/O Interrupt Controller）、EIOINTC（Extended I/O Interrupt Controller）、
>> +LoongArch计算机中的中断控制器（即IRQ芯片）包括CPUINTC（CPU Core Interrupt Controller）、
>> +LIOINTC（Legacy I/O Interrupt Controller）、EIOINTC（Extended I/O Interrupt Controller）、
>>   HTVECINTC（Hyper-Transport Vector Interrupt Controller）、PCH-PIC（LS7A芯片组的主中
>>   断控制器）、PCH-LPC（LS7A芯片组的LPC中断控制器）和PCH-MSI（MSI中断控制器）。
>>
>> @@ -87,6 +86,38 @@ PCH-LPC/PCH-MSI，然后被EIOINTC统一收集，再直接到达CPUINTC::
>>       | Devices |
>>       +---------+
>>
>> +高级扩展IRQ模型
>> +=======================
>> +
>> +在这种模型里面，IPI（Inter-Processor Interrupt）和CPU本地时钟中断直接发送到CPUINTC，
>> +CPU串口（UARTs）中断发送到LIOINTC，MSI中断发送到AVEC，而后通过AVEC送达CPUINTC，而
>> +其他所有设备的中断则分别发送到所连接的PCH-PIC/PCH-LPC，然后由EIOINTC统一收集，再直
>> +接到达CPUINTC::
>> +
>> + +-----+     +--------------------------+     +-------+
>> + | IPI | --> |           CPUINTC        | <-- | Timer |
>> + +-----+     +--------------------------+     +-------+
>> +              ^        ^             ^
>> +              |        |             |
>> +      +--------+  +---------+ +---------+     +-------+
>> +      | AVEC   |  | EIOINTC | | LIOINTC | <-- | UARTs |
>> +      +--------+  +---------+ +---------+     +-------+
>> +              ^        ^
>> +              |        |
>> +      +---------+  +-------------+
>> +      |   MSI   |  |   PCH-PIC   |
>> +      +---------+  +-------------+
>> +            ^          ^       ^
>> +            |          |       |
>> +    +---------+ +---------+ +---------+
>> +    | Devices | | PCH-LPC | | Devices |
>> +    +---------+ +---------+ +---------+
>> +                     ^
>> +                     |
>> +                +---------+
>> +                | Devices |
>> +                +---------+
>> +
>>   ACPI相关的定义
>>   ==============
>>
>> --
>> 2.20.1
>>
thanks


