Return-Path: <linux-kernel+bounces-177208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C57D8C3B73
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2CC1C20CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87D5145FEB;
	Mon, 13 May 2024 06:38:45 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D6F2E827;
	Mon, 13 May 2024 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582325; cv=none; b=LzFi7yqlZdugj2tF5igRydODu6se3fAvECWdOTpM8kjPup+OJqGzU/M8ZvUUpLIE7BSpWyMWPnOujaf562xS9vAd4Lw3KUVsbcEHsggR5+vmWcZb6ZV0TkRR4eL0TFmzQaRpu8lcHejlznb+FDFQKPPI8NWkoYP10Lahc3atDfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582325; c=relaxed/simple;
	bh=TOKtOi8SMh5KrsAoqKzTKP4dRMSjSWxiBPerZzBEDYQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lq5ahyMB6/gDOWVN5rFJut6YbqRCxMr1NLrzcCCEDC3Hw890Y0H/UTdCvPbNSw99FnHPDN699tE5y3bBjvRQNdnad4I3N0cdenTZzmDsd7P09HDyoYb0r6l35pFbenStlYm4XEkpFUmnPZvK8truaFPyXBaC1kK0lIyoSSeGaV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8CxyelvtUFmlRIMAA--.17498S3;
	Mon, 13 May 2024 14:38:39 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx4VVstUFmqqIcAA--.34663S3;
	Mon, 13 May 2024 14:38:39 +0800 (CST)
Subject: Re: [PATCH 1/2] docs: Add advanced extended IRQ model description
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, corbet@lwn.net,
 alexs@kernel.org, siyanteng@loongson.cn, loongarch@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240507122228.5288-1-zhangtianyang@loongson.cn>
 <CAD-N9QV82w1_7ksGAWJDNVcRDyKHLgiEbx13b3sr4cTazobW5g@mail.gmail.com>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <5648b40a-51fa-612d-d102-e2948866174f@loongson.cn>
Date: Mon, 13 May 2024 14:38:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAD-N9QV82w1_7ksGAWJDNVcRDyKHLgiEbx13b3sr4cTazobW5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8Cx4VVstUFmqqIcAA--.34663S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw15Aw4UAr1UXryrAr1fGrX_yoW7JFy7pr
	9xGF9avF48G345Wr17Jr48Wr13Jw1fK3WDtF1xKry8Xr1qyr1DJr1Utr1kXFW7G348Ar1j
	qFW5Kw1DAw1UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTm
	DUUUU


在 2024/5/9 上午10:24, Dongliang Mu 写道:
> On Tue, May 7, 2024 at 8:24 PM Tianyang Zhang <zhangtianyang@loongson.cn> wrote:
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
>> index 7988f4192363..79228741d1b9 100644
>> --- a/Documentation/arch/loongarch/irq-chip-model.rst
>> +++ b/Documentation/arch/loongarch/irq-chip-model.rst
>> @@ -85,6 +85,39 @@ to CPUINTC directly::
>>       | Devices |
>>       +---------+
>>
>> +Advanced Extended IRQ model
>> +=======================
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
>> index f1e9ab18206c..7ccde82dd666 100644
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
>> +CPU串口（UARTs）中断发送到LIOINTC，MSI中断发送到AVEC,而后通过AVEC送达CPUINTC，而
> AVEC is followed by an English comma (Translation: AVEC 后面一个英文逗号)
> Dongliang Mu
Ok, I will follow the advice
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
>>


