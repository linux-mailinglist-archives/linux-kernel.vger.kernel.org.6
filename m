Return-Path: <linux-kernel+bounces-278948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BADA94B6F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E03B21D78
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7925187878;
	Thu,  8 Aug 2024 06:52:17 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D07A5228;
	Thu,  8 Aug 2024 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099937; cv=none; b=p9n4Wx89q3pDSxaekwejhPL2YIQb83zCJuAqERlhmsCTRemVWqaFrQYL9iioAq0d0gzVIR2TYcNJlHjDk/64hLJIMzR5+4ERvvMeBsvQZaww77WIA9o3HULuBWxIkaYvdsXdv7VbxiG8U19YB4rIxkqGy6sr37vkpZze9c8M744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099937; c=relaxed/simple;
	bh=tyzblumlpNxy/lgpFjj9twjGD98ubq+OFuL+jONNIco=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YWRlALZHxDp5yAK8fG5S0k4udiYQ+nItVuhC4GBPpW6rGh48rhQ0lxgmJkxnPU345+GPPOMRlOZsZllbajF6Hu48tbbGjh59F2vKSc+cpuXCpK2zcvgVVpP3qBdEjD+t8TXONyVVwUEwyOYFCjdM3Fa1ErQxwR0gTLlxHfj8LNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8Bx35sca7Rm4H0LAA--.8264S3;
	Thu, 08 Aug 2024 14:52:12 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowMDxnWcYa7RmilIJAA--.17111S3;
	Thu, 08 Aug 2024 14:52:10 +0800 (CST)
Subject: Re: [PATCH V8 2/2] irqchip/loongarch-avec: Add AVEC irqchip support
To: Thomas Gleixner <tglx@linutronix.de>, corbet@lwn.net, alexs@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
 gaoliang@loongson.cn, wangliupu@loongson.cn, lvjianmin@loongson.cn,
 yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org,
 dianders@chromium.org, maobibo@loongson.cn, xry111@xry111.site,
 zhaotianrui@loongson.cn, nathan@kernel.org, yangtiezhu@loongson.cn,
 zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20240806115557.4750-1-zhangtianyang@loongson.cn>
 <87le180z8b.ffs@tglx>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <bc5d4e7a-ba81-f8f7-3629-2c80897d8ffc@loongson.cn>
Date: Thu, 8 Aug 2024 14:52:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87le180z8b.ffs@tglx>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMDxnWcYa7RmilIJAA--.17111S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF4rCr1xur1DZF4ftFWfCrX_yoW5Ww1UpF
	WUJw4Dur48tFyFqrWkX3yDZryavryIg3WDK34fCa4xAa4Y9ryI9Fy0kF47uFyUCr48Aw4j
	vr40vrykCan8JagCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2pVbDU
	UUU

Hi, Thomas

Thank you for your feedback.

ÔÚ 2024/8/8 ÉÏÎç6:01, Thomas Gleixner Ð´µÀ:

>> +	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
>> +
>> +	for (i = 0; i < nr_irqs; i++) {
>> +		d = irq_domain_get_irq_data(domain, virq + i);
>> +		if (d) {
>> +			clear_free_vector(d);
>> +			irq_domain_reset_irq_data(d);
>> +
> Stray newline, but the more important question is what kfree()'s 'd'?
>
> AFAICT, nothing. So that's a memory leak, no?
With my understand , 'd' as 'struct irq_data' can be free at public 
irqdomain process, and really miss a kfree targeting 'struct chip_data'
>
>> +static int __init avecintc_init(struct irq_domain *parent)
>> +{
>> +	parent_irq = irq_create_mapping(parent, INT_AVEC);
>> +	if (!parent_irq) {
>> +		pr_err("Failed to mapping hwirq\n");
>> +		ret = -EINVAL;
>> +		goto out_remove_domain;
>> +	}
>> +	irq_set_chained_handler_and_data(parent_irq, avecintc_irq_dispatch, NULL);
>> +
>> +	ret = irq_matrix_init();
>> +	if (ret < 0) {
>> +		pr_err("Failed to init irq matrix\n");
>> +		goto out_remove_domain;
> Which still leaves the disfunct chained handler installed and the
> mapping intact.

There is indeed a problem here, but we have not found a similar approach 
for reference.

Is it reasonable to replace here with handle_bad_irq in case of failure? 
or is there any other more suitable way. We hope you can give us some 
suggestions, thank you very much

>> +#endif
>> +	value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
>> +	value |= IOCSR_MISC_FUNC_AVEC_EN;
>> +	iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
>> +
>> +	return ret;
>> +
>> +out_remove_domain:
>> +	irq_domain_remove(loongarch_avec.domain);
>> +out_free_handle:
>> +	irq_domain_free_fwnode(loongarch_avec.fwnode);
>> +out:
>> +	return ret;
>> +}
>> +
>> +static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
>> +				     const unsigned long end)
>> +{
>> +	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
>> +
>> +	msi_base_addr = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
> What validates that msi_base_addr has none of the lower 16 bits set, as
> they are required to be zero to make MSI message composing work, right?

This operation originates from some hardware designs.

In 3C6000, either eiointc or avecintc can be the parent controller for 
MSI interrupts and these two controllers have different MSI msg address.

In our platform design scheme, we fix avec-msg-address to the address of 
(eiointc-msg-address - 0x100000). Therefore, here we need to subtract 
AVEC_MSG_OFFSET from the msg_address obtained by MCFG

The main purpose of the design that users of 3C6000 can freely choose 
the version of the Linux kernel that supports loongarch (regardless of 
whether AVEC is supported or not) without having to change the firmware


Thanks again

Tianyang


