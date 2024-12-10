Return-Path: <linux-kernel+bounces-438673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A89EA42D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211ED288836
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D1170824;
	Tue, 10 Dec 2024 01:19:13 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE2A70812;
	Tue, 10 Dec 2024 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793553; cv=none; b=Hub8WzZ+8Ism7nVETWsWzDRQv9T0KgJQQvmI3OXeyMmWYJo0MUeKM8aSaqeCk+6MR6//UYXjfbEqcJfRY1tXFO2Ld+0WrMTtPFnjPctLJy9lzMleVuOYb3STjLjFjjn07V1Ja59It2pOr0YUGTP8nmWK7pKKS76uREJYRRf1WhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793553; c=relaxed/simple;
	bh=09mHDPvFye9jUPSO3qJvAH+WZSUM0JdnW1UeAEQmalA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pt+lXljoCDeB/FG67MGQB1fIWQ8MGKwKRMgRbzt+cL7RGBaxwev7VClRuYB6UXyRjTzrCfrW0egVcpax9rvrobYFyNIJCij1cTFuKgbA8atmLwvGhbJ9yOy9FDd01afANEORBy355JCnqKWMCEfdiM5XsXrWHfkRw2vFQiCGA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8AxaeEEl1dnqJhUAA--.32367S3;
	Tue, 10 Dec 2024 09:19:00 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowMAxXcIDl1dnA4t9AA--.33146S3;
	Tue, 10 Dec 2024 09:18:59 +0800 (CST)
Subject: Re: [PATCH] irqchip/loongarch-avec:Add multi-nodes topology support
To: Ming Wang <wangming01@loongson.cn>, chenhuacai@kernel.org,
 kernel@xen0n.name, tglx@linutronix.de
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241207033146.20938-1-zhangtianyang@loongson.cn>
 <455c5236-c5de-4138-bb23-04abb57a9a89@loongson.cn>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <bef6edc3-8e27-4973-812d-ad046f9b2177@loongson.cn>
Date: Tue, 10 Dec 2024 09:18:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <455c5236-c5de-4138-bb23-04abb57a9a89@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxXcIDl1dnA4t9AA--.33146S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur1Utw1UWr18WrWUAryxWFX_yoW5Aw1UpF
	Z5Ja45XrWUK3Z7Wry3Kw1DZFy5Jr4xGanrt34xW3W7XrWDAFyqgry8Xryq9F18Cw4kZ3W0
	vr48JFnrZF15ZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==

Hi, Ming


在 2024/12/7 下午2:03, Ming Wang 写道:
>
>
> On 2024/12/7 11:31, Tianyang Zhang wrote:
>> This patch enables the advanced interrupt controller function under
>> multiple-node of 3C600. The topology of the advanced interrupt 
>> controller
> I think '3c600' is a typo. Shouldn't it be '3c6000'?
ok, you are right , thanks
>> is consistent with NUMA node. We check the enable status of the node 
>> where
>> each CPU is located once when it goes online, which may cause some
>> additional operations, but it can ensure that the advanced interrupt
>> controller can still be used in situations where some CPUs cannot start
>>
>> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
>> ---
>>   drivers/irqchip/irq-loongarch-avec.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-loongarch-avec.c 
>> b/drivers/irqchip/irq-loongarch-avec.c
>> index 0f6e465dd309..9e30198fa7e4 100644
>> --- a/drivers/irqchip/irq-loongarch-avec.c
>> +++ b/drivers/irqchip/irq-loongarch-avec.c
>> @@ -56,6 +56,18 @@ struct avecintc_data {
>>       unsigned int        moving;
>>   };
>>   +static inline void avecintc_enable(void)
>> +{
>> +    u64 value;
>> +
>> +    if (!loongarch_avec.domain)
>> +        return;
>> +
>> +    value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
>> +    value |= IOCSR_MISC_FUNC_AVEC_EN;
>> +    iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
>> +}
>> +
>>   static inline void avecintc_ack_irq(struct irq_data *d)
>>   {
>>   }
>> @@ -127,6 +139,8 @@ static int avecintc_cpu_online(unsigned int cpu)
>>         guard(raw_spinlock)(&loongarch_avec.lock);
>>   +    avecintc_enable();
>> +
>>       irq_matrix_online(loongarch_avec.vector_matrix);
>>         pending_list_init(cpu);
>> @@ -339,7 +353,6 @@ static int __init irq_matrix_init(void)
>>   static int __init avecintc_init(struct irq_domain *parent)
>>   {
>>       int ret, parent_irq;
>> -    unsigned long value;
>>         raw_spin_lock_init(&loongarch_avec.lock);
>>   @@ -378,14 +391,13 @@ static int __init avecintc_init(struct 
>> irq_domain *parent)
>>                     "irqchip/loongarch/avecintc:starting",
>>                     avecintc_cpu_online, avecintc_cpu_offline);
>>   #endif
>> -    value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
>> -    value |= IOCSR_MISC_FUNC_AVEC_EN;
>> -    iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
>> +    avecintc_enable();
>>         return ret;
>>     out_remove_domain:
>>       irq_domain_remove(loongarch_avec.domain);
>> +    loongarch_avec.domain = NULL;
>>   out_free_handle:
>>       irq_domain_free_fwnode(loongarch_avec.fwnode);
>>   out:


