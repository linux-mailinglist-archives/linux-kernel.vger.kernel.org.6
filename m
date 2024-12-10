Return-Path: <linux-kernel+bounces-438680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C89EA44B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E92188773E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2DB7080C;
	Tue, 10 Dec 2024 01:28:24 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D68614E;
	Tue, 10 Dec 2024 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794104; cv=none; b=LUB6/MugVG57w7SnIBtrHE8cPXyDQHnYt9S/35k0U2ILfEp9BcE1j8bK9vwo4T4Bth02JATS1kSWZbxlOT1YyfuJJ3K/wFRAMbdRpr/l04f8AHlUwLTScPTkGCS+J0jO30JjzQnV6ER0CLi2fz08FDkMR73eH+blFe2IlOYzZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794104; c=relaxed/simple;
	bh=OPKnQ4yQl6LR6oOeamgI087F9tEA7PLQBdB9WGOpfSE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cgsu7s+jE5LsZJ/n0S+Ol5Hh38Yg31aQmtCe6g08l9FTzMXNXDsmd2yCAQnn+vF7KyN0lZseTKMC5Hm+Yb/oNDu+QMTiKTl6LR62uEeIMhpd7pN9xTSnsLCnPAR3wBYGpOQ6WaWkyHeu1YXiEem6iI/ncY43fB9fJ4+vXnvEOAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8BxeeEzmVdntZtUAA--.35568S3;
	Tue, 10 Dec 2024 09:28:19 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowMAxDEcymVdnvY59AA--.6452S3;
	Tue, 10 Dec 2024 09:28:18 +0800 (CST)
Subject: Re: [PATCH] irqchip/loongarch-avec:Add multi-nodes topology support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, tglx@linutronix.de, loongarch@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241207033146.20938-1-zhangtianyang@loongson.cn>
 <CAAhV-H4VAyD+=Btt9S6HrN6-sVQJqe1_jeLPS13UR1kxXJ8S5w@mail.gmail.com>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <697baf2d-3381-3511-c7f5-971532788eb8@loongson.cn>
Date: Tue, 10 Dec 2024 09:28:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4VAyD+=Btt9S6HrN6-sVQJqe1_jeLPS13UR1kxXJ8S5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxDEcymVdnvY59AA--.6452S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGrW7uw15Kw43Jr4xAFyrAFc_yoW5ZrW5pa
	98Jay5Ar4Uta4fWr9xt3yDZFyaqr4fKrZrta4xC3WxWrZ8CF1DWFy0gry5ZF18uws7u3W0
	vF48JFy7u3W5AFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc-eODUUUU

Hi, Huacai

在 2024/12/7 下午5:11, Huacai Chen 写道:
> Hi, Tianyang,
>
> On Sat, Dec 7, 2024 at 11:31 AM Tianyang Zhang
> <zhangtianyang@loongson.cn> wrote:
>> This patch enables the advanced interrupt controller function under
>> multiple-node of 3C600. The topology of the advanced interrupt controller
>> is consistent with NUMA node. We check the enable status of the node where
>> each CPU is located once when it goes online, which may cause some
>> additional operations, but it can ensure that the advanced interrupt
>> controller can still be used in situations where some CPUs cannot start
> The whole can be reworded:
>
> Currently we only enable one chip's advanced interrupt controller
> (AVEC) in hardware, so multi-chip machines with Loongson-3C6000 don't
> work. This patch enables it for every chip (In theory every chip needs
> to be enabled only once, but for simplicity we enable it on every core
> in the CPU online hooks).
Ok, I got it, thanks
>
>> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
>> ---
>>   drivers/irqchip/irq-loongarch-avec.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loongarch-avec.c
>> index 0f6e465dd309..9e30198fa7e4 100644
>> --- a/drivers/irqchip/irq-loongarch-avec.c
>> +++ b/drivers/irqchip/irq-loongarch-avec.c
>> @@ -56,6 +56,18 @@ struct avecintc_data {
>>          unsigned int            moving;
>>   };
>>
>> +static inline void avecintc_enable(void)
>> +{
>> +       u64 value;
>> +
>> +       if (!loongarch_avec.domain)
>> +               return;
> Is there any reason to check this? If domain is NULL, avecintc_init()
> fails, there is no chance to execute this function.
>
> Huacai
Yes, you are right , it's redundancy, thanks
>
>> +
>> +       value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
>> +       value |= IOCSR_MISC_FUNC_AVEC_EN;
>> +       iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
>> +}
>> +
>>   static inline void avecintc_ack_irq(struct irq_data *d)
>>   {
>>   }
>> @@ -127,6 +139,8 @@ static int avecintc_cpu_online(unsigned int cpu)
>>
>>          guard(raw_spinlock)(&loongarch_avec.lock);
>>
>> +       avecintc_enable();
>> +
>>          irq_matrix_online(loongarch_avec.vector_matrix);
>>
>>          pending_list_init(cpu);
>> @@ -339,7 +353,6 @@ static int __init irq_matrix_init(void)
>>   static int __init avecintc_init(struct irq_domain *parent)
>>   {
>>          int ret, parent_irq;
>> -       unsigned long value;
>>
>>          raw_spin_lock_init(&loongarch_avec.lock);
>>
>> @@ -378,14 +391,13 @@ static int __init avecintc_init(struct irq_domain *parent)
>>                                    "irqchip/loongarch/avecintc:starting",
>>                                    avecintc_cpu_online, avecintc_cpu_offline);
>>   #endif
>> -       value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
>> -       value |= IOCSR_MISC_FUNC_AVEC_EN;
>> -       iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
>> +       avecintc_enable();
>>
>>          return ret;
>>
>>   out_remove_domain:
>>          irq_domain_remove(loongarch_avec.domain);
>> +       loongarch_avec.domain = NULL;
>>   out_free_handle:
>>          irq_domain_free_fwnode(loongarch_avec.fwnode);
>>   out:
>> --
>> 2.20.1
>>


