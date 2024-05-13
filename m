Return-Path: <linux-kernel+bounces-177212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F1B8C3B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148172816AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B15146A6E;
	Mon, 13 May 2024 06:40:29 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4996252F9B;
	Mon, 13 May 2024 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582429; cv=none; b=gptM4lae07rV2oVo8QRjEJNL8OyiHpR2IDAnlS3EZ2qSLGyPXfTuXV88PzFfRdXiTIbiZxE24+gKa/H/smbsKq3z+52YUx07TlC3Wxh6ewydwYcOCnH7yEbRDpmevZ/GNLqGwI7zIPgaqMx3La3v6nnPddpRMz04LM1C+aVpJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582429; c=relaxed/simple;
	bh=s3KEVO2WVfNjujMY5GX/FpbgTHgOuPOWDdwQwaLheY0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JZTOY/BmlIuA8QeruT+KCd/y8ZarWCuO2VGsfgbzKRNn9gObi/KEVfm/HRwHuGiFLZ3IJL63uvXs9pN6V5FjfgR/fdhmx9Cxe/a7p05wXzrED/Qix+oUi5eUqlwY9sKAbVRJ4bv9IPzvxMx1inHq9AZPERDT7tjfHOwDjYmQB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8Bx3+vZtUFmyRIMAA--.29783S3;
	Mon, 13 May 2024 14:40:25 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxlFbXtUFmMqMcAA--.35005S3;
	Mon, 13 May 2024 14:40:24 +0800 (CST)
Subject: Re: [PATCH 1/2] docs: Add advanced extended IRQ model description
To: Randy Dunlap <rdunlap@infradead.org>, chenhuacai@kernel.org,
 kernel@xen0n.name, corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240507122228.5288-1-zhangtianyang@loongson.cn>
 <c1f1b699-71ad-409a-a843-afe42640626a@infradead.org>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <a72f2d5b-ed6d-1b47-ac99-5c99f9cf257b@loongson.cn>
Date: Mon, 13 May 2024 14:40:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c1f1b699-71ad-409a-a843-afe42640626a@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8BxlFbXtUFmMqMcAA--.35005S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw13GrWxury7JF43tw18Zwc_yoW8try3pr
	Z3GF9avFs7t343WF13Jr1UXr13Jw1fJanrKF1xKry8Xw1qvr1Dtr1UXrykXFWUG340yr1j
	qFW5G34DCw1UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jwBMNUUUUU=


在 2024/5/9 上午6:29, Randy Dunlap 写道:
> Hi--
>
> On 5/7/24 5:22 AM, Tianyang Zhang wrote:
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
> The === underline line needs to be at least as long as the line above it.
I will repair this problem
>> +
>> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
>> +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, MSI interrupts go to AVEC,
>> +and then go to CPUINTC, Other devices interrupts go to PCH-PIC/PCH-LPC and gathered
>                    CPUINTC.
Thank you for the reminder
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
> thanks.




