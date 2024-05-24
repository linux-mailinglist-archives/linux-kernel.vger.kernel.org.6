Return-Path: <linux-kernel+bounces-188396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22EE8CE180
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EF11C20923
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7512881C;
	Fri, 24 May 2024 07:26:15 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFAB208A1
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716535574; cv=none; b=MtUD7OMld3pMGsqxn+HHIMkJWzo65MwVV5Ha3Z7SbXerWwafeOFgch/dehps9tAB3qMeX17uJMGTkgE0NOPQRerBv/YuNI7W3x5qqvNn9BqqReKTnXnkQ4kuLJOQ1xIOEPZAN5oX9uQsdTucMQAphFZYCUw9LTbl1368UudRP1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716535574; c=relaxed/simple;
	bh=/se8mm87HQtUgcFpISYZXBUDgihIzjiMgwUGHDPrzFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgyJKZMhltJiPh0f4OKImSBc7/0UqhClo22zvxkk5KxYg/rgbxRApMajLv8leRQ1J0CDaLd+dAf3AZzfXyCqhjyj94IZ5Jtzme3HOwVx3FjfN2ja/X7jRrzkRrnw1TU6B8EPvDfRfhArSlFtJvmapOQMKSqxk1feoVtOApHY7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 886651C0007;
	Fri, 24 May 2024 07:25:59 +0000 (UTC)
Message-ID: <545a7f3e-436e-4fd7-a45f-4f800bd58b20@ghiti.fr>
Date: Fri, 24 May 2024 09:25:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-fixes] riscv: kexec: Avoid deadlock in kexec crash path
Content-Language: en-US
To: takakura@valinux.co.jp, songshuaishuai@tinylab.org,
 paul.walmsley@sifive.com
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
 xianting.tian@linux.alibaba.com, takahiro.akashi@linaro.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <0e34cd12-66d8-4432-780a-f08d03a2c95e@sifive.com>
 <20240506051058.20386-1-takakura@valinux.co.jp>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240506051058.20386-1-takakura@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Song, Ryo,

On 06/05/2024 07:10, takakura@valinux.co.jp wrote:
> Hi Song and Paul!
>
>>> To avoid the deadlock, this patch directly EOI the irq regardless of
>>> the active status of irqchip.
>> Taking a quick look at the other architectures, looks like no one else is
>> doing this.  Is this addressing a RISC-V-only problem?
>>
>>> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
>>> index f6c7135b00d7..d7ddf4d2b243 100644
>>> --- a/arch/riscv/kernel/machine_kexec.c
>>> +++ b/arch/riscv/kernel/machine_kexec.c
>>> @@ -149,20 +149,12 @@ static void machine_kexec_mask_interrupts(void)
>>>   
>>>   	for_each_irq_desc(i, desc) {
>>>   		struct irq_chip *chip;
>>> -		int ret;
>>>   
>>>   		chip = irq_desc_get_chip(desc);
>>>   		if (!chip)
>>>   			continue;
>>>   
>>> -		/*
>>> -		 * First try to remove the active state. If this
>>> -		 * fails, try to EOI the interrupt.
>>> -		 */
>>> -		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
>>> -
>>> -		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
>>> -		    chip->irq_eoi)
>>> +		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
>>>   			chip->irq_eoi(&desc->irq_data);
> I think this deadlock is relevant to riscv and arm64 as they both
> acquire irqdesc spinlock by calling irq_set_irqchip_state() during their
> machine_kexec_mask_interrupts().
>
> However, I think calling irq_set_irqchip_state() during
> machine_kexec_mask_interrupts() is arm64 specific way of handling EOI
> which is not necessary for riscv.
> For arm64, its interrupt controller(gic) seems to have two ways of EOIing
> an interrupt depending on the mode which gic is configured. One of them
> treats EOI as two step procedure, priority drop and deactivation. I think
> irq_set_irqchip_state() is there to handle the deactivation part of
> the procedure.
> For riscv, EOI only requires irq_eoi handler to complete EOI and I think
> keeping irq_set_irqchip_state() will only leave this possible deadlock
> without any use.
> So I think it's best we simply remove irq_set_irqchip_state() as Song did.


I think this ^ is relevant and should be added to the commit log. @Song 
can you respin another version with the updated commit log? @Ryo can you 
add your Reviewed-by when it's done?

This fix has been lagging behind for quite some time, it would be nice 
to merge this in 6.10 and backport to stable.

Thanks,

Alex


>
> Sincerely,
> Ryo Takakura
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

