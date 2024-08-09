Return-Path: <linux-kernel+bounces-280293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9AB94C848
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD4E1F21FFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12710A3E;
	Fri,  9 Aug 2024 01:50:48 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA9D2FF;
	Fri,  9 Aug 2024 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168248; cv=none; b=p22KJY/aNs9lxjoUlhdZq9XMY25NcLmjkdl81jfBFgUVZS31IJbOT4cDRi9eE15KqQdwCInaP3usNqIJFwurH/ADV06bsYDxKLtk5SrTjjmG0Y3LN6OZc0A3+6cqzGfT22rJBpe6QLrnjGf9fMXAMMFA5Evxwsnf78bkF05y18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168248; c=relaxed/simple;
	bh=Y4j8tEMDeUnrJUVE4V/9NiwhCmjh/Ep/R9WciWZpdzA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gG0SlspG4/SpsqeTT/QssCuuBF5556arf++O/171WEuJvbrXJG92TaAU7E8B9C9yUnY1/283nbAjEdIRhr/aVuWs0QH1+hHu6fG11V7GBuud9f25XsO0qp187FwVYy2Y3IfNADlvpPeQeI3R16vbSUxdFsTCmvPeKKbdhCG0ybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8DxyOnzdbVmrMsMAA--.36937S3;
	Fri, 09 Aug 2024 09:50:43 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowMDxkeHwdbVmz8IKAA--.52880S3;
	Fri, 09 Aug 2024 09:50:42 +0800 (CST)
Subject: Re: [PATCH V8 2/2] irqchip/loongarch-avec: Add AVEC irqchip support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, corbet@lwn.net, alexs@kernel.org,
 kernel@xen0n.name, jiaxun.yang@flygoat.com, gaoliang@loongson.cn,
 wangliupu@loongson.cn, lvjianmin@loongson.cn, yijun@loongson.cn,
 mhocko@suse.com, akpm@linux-foundation.org, dianders@chromium.org,
 maobibo@loongson.cn, xry111@xry111.site, zhaotianrui@loongson.cn,
 nathan@kernel.org, yangtiezhu@loongson.cn, zhoubinbin@loongson.cn,
 loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20240806115557.4750-1-zhangtianyang@loongson.cn>
 <87le180z8b.ffs@tglx> <bc5d4e7a-ba81-f8f7-3629-2c80897d8ffc@loongson.cn>
 <CAAhV-H7EHRSFsJCY3F2NdwjGcEO-TnSF4S3iQnYXh-N8c2-b4g@mail.gmail.com>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <ae561e06-1312-2568-c36f-3a845050a596@loongson.cn>
Date: Fri, 9 Aug 2024 09:50:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7EHRSFsJCY3F2NdwjGcEO-TnSF4S3iQnYXh-N8c2-b4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMDxkeHwdbVmz8IKAA--.52880S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGrW5Xw1DArW3Gr1rJw4kKrX_yoW5tryDpF
	WUGa1DAr4UJF10qrWvvw1DXrnIyr1xGr1Utw1fGa4xA3s0gFyIvF10yF42kFy8Cr4rJa1j
	vr48trWxCF98JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUUUUU

Hi, Huacai

在 2024/8/8 下午4:03, Huacai Chen 写道:
> Hi, Tianyang,
>
> On Thu, Aug 8, 2024 at 2:52 PM Tianyang Zhang <zhangtianyang@loongson.cn> wrote:
>> Hi, Thomas
>>
>> Thank you for your feedback.
>>
>> 在 2024/8/8 上午6:01, Thomas Gleixner 写道:
>>
>>>> +    guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
>>>> +
>>>> +    for (i = 0; i < nr_irqs; i++) {
>>>> +            d = irq_domain_get_irq_data(domain, virq + i);
>>>> +            if (d) {
>>>> +                    clear_free_vector(d);
>>>> +                    irq_domain_reset_irq_data(d);
>>>> +
>>> Stray newline, but the more important question is what kfree()'s 'd'?
>>>
>>> AFAICT, nothing. So that's a memory leak, no?
>> With my understand , 'd' as 'struct irq_data' can be free at public
>> irqdomain process, and really miss a kfree targeting 'struct chip_data'
>>>> +static int __init avecintc_init(struct irq_domain *parent)
>>>> +{
>>>> +    parent_irq = irq_create_mapping(parent, INT_AVEC);
>>>> +    if (!parent_irq) {
>>>> +            pr_err("Failed to mapping hwirq\n");
>>>> +            ret = -EINVAL;
>>>> +            goto out_remove_domain;
>>>> +    }
>>>> +    irq_set_chained_handler_and_data(parent_irq, avecintc_irq_dispatch, NULL);
>>>> +
>>>> +    ret = irq_matrix_init();
>>>> +    if (ret < 0) {
>>>> +            pr_err("Failed to init irq matrix\n");
>>>> +            goto out_remove_domain;
>>> Which still leaves the disfunct chained handler installed and the
>>> mapping intact.
>> There is indeed a problem here, but we have not found a similar approach
>> for reference.
>>
>> Is it reasonable to replace here with handle_bad_irq in case of failure?
>> or is there any other more suitable way. We hope you can give us some
>> suggestions, thank you very much
> Maybe we can move irq_set_chained_handler_and_data(parent_irq,
> avecintc_irq_dispatch, NULL) after the checking of irq_matrix_init().
>
> Huacai
I think is a good idea~~
>>>> +#endif
>>>> +    value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
>>>> +    value |= IOCSR_MISC_FUNC_AVEC_EN;
>>>> +    iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
>>>> +
>>>> +    return ret;
>>>> +
>>>> +out_remove_domain:
>>>> +    irq_domain_remove(loongarch_avec.domain);
>>>> +out_free_handle:
>>>> +    irq_domain_free_fwnode(loongarch_avec.fwnode);
>>>> +out:
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
>>>> +                                 const unsigned long end)
>>>> +{
>>>> +    struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
>>>> +
>>>> +    msi_base_addr = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
>>> What validates that msi_base_addr has none of the lower 16 bits set, as
>>> they are required to be zero to make MSI message composing work, right?
>> This operation originates from some hardware designs.
>>
>> In 3C6000, either eiointc or avecintc can be the parent controller for
>> MSI interrupts and these two controllers have different MSI msg address.
>>
>> In our platform design scheme, we fix avec-msg-address to the address of
>> (eiointc-msg-address - 0x100000). Therefore, here we need to subtract
>> AVEC_MSG_OFFSET from the msg_address obtained by MCFG
>>
>> The main purpose of the design that users of 3C6000 can freely choose
>> the version of the Linux kernel that supports loongarch (regardless of
>> whether AVEC is supported or not) without having to change the firmware
>>
>>
>> Thanks again
>>
>> Tianyang
>>


