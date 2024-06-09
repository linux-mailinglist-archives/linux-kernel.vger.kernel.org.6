Return-Path: <linux-kernel+bounces-207381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4003F901654
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2EC1C20A33
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD475433C2;
	Sun,  9 Jun 2024 14:18:15 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8B1CD3C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717942695; cv=none; b=pb969C1e0Bsvo+qzLHNjAuhEQZGepAXJnTBKUY7xlLKE2rBQJF6A5LFwdtoggfoB4HJB0vTvlw+qXCLuCbylm1TrLfN8K4WCFjjMmTa9dGUySceC0CS2A0+TlrefvVRst5/mHJDyFG4aeqc/kcDAKEKaqXRY51BT+WXa7zxMoUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717942695; c=relaxed/simple;
	bh=2o6h+jkbF3j5Xznkz/U08BjHf5jtHcabwfD/Tcq1DGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AWU9Ssod1YXT/+trlcEFfldKac0HyKMF42+cO4K9X62t/QcsFGHsbQ2PKc4RqQeEfRXax7+IxCwTY9n6FeaCiRyvoAgW2/00xARao8ihbHAdrO3s6xpfKkgGwG38+wfKQDQXr4C5JB0cQNUM1Xtzt6ONcOhwN84z6tZfhG2RCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 5112AA9C38;
	Sun,  9 Jun 2024 23:18:05 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SAkmJ4iE8ZGW; Sun,  9 Jun 2024 23:18:05 +0900 (JST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp [153.220.101.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 0047FA9BFA;
	Sun,  9 Jun 2024 23:18:04 +0900 (JST)
From: takakura@valinux.co.jp
To: alex@ghiti.fr,
	songshuaishuai@tinylab.org,
	paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	guoren@kernel.org,
	xianting.tian@linux.alibaba.com,
	takahiro.akashi@linaro.org,
	takakura@valinux.co.jp,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [-fixes] riscv: kexec: Avoid deadlock in kexec crash path
Date: Sun,  9 Jun 2024 23:18:02 +0900
Message-Id: <20240609141802.6976-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <545a7f3e-436e-4fd7-a45f-4f800bd58b20@ghiti.fr>
References: <545a7f3e-436e-4fd7-a45f-4f800bd58b20@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alex, Song,

On Fri, 24 May 2024, Alexandre Ghiti wrote:
>Hi Song, Ryo,
>
>On 06/05/2024 07:10, takakura@valinux.co.jp wrote:
>> Hi Song and Paul!
>>
>>>> To avoid the deadlock, this patch directly EOI the irq regardless of
>>>> the active status of irqchip.
>>> Taking a quick look at the other architectures, looks like no one else is
>>> doing this.  Is this addressing a RISC-V-only problem?
>>>
>>>> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
>>>> index f6c7135b00d7..d7ddf4d2b243 100644
>>>> --- a/arch/riscv/kernel/machine_kexec.c
>>>> +++ b/arch/riscv/kernel/machine_kexec.c
>>>> @@ -149,20 +149,12 @@ static void machine_kexec_mask_interrupts(void)
>>>>   
>>>>   	for_each_irq_desc(i, desc) {
>>>>   		struct irq_chip *chip;
>>>> -		int ret;
>>>>   
>>>>   		chip = irq_desc_get_chip(desc);
>>>>   		if (!chip)
>>>>   			continue;
>>>>   
>>>> -		/*
>>>> -		 * First try to remove the active state. If this
>>>> -		 * fails, try to EOI the interrupt.
>>>> -		 */
>>>> -		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
>>>> -
>>>> -		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
>>>> -		    chip->irq_eoi)
>>>> +		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
>>>>   			chip->irq_eoi(&desc->irq_data);
>> I think this deadlock is relevant to riscv and arm64 as they both
>> acquire irqdesc spinlock by calling irq_set_irqchip_state() during their
>> machine_kexec_mask_interrupts().
>>
>> However, I think calling irq_set_irqchip_state() during
>> machine_kexec_mask_interrupts() is arm64 specific way of handling EOI
>> which is not necessary for riscv.
>> For arm64, its interrupt controller(gic) seems to have two ways of EOIing
>> an interrupt depending on the mode which gic is configured. One of them
>> treats EOI as two step procedure, priority drop and deactivation. I think
>> irq_set_irqchip_state() is there to handle the deactivation part of
>> the procedure.
>> For riscv, EOI only requires irq_eoi handler to complete EOI and I think
>> keeping irq_set_irqchip_state() will only leave this possible deadlock
>> without any use.
>> So I think it's best we simply remove irq_set_irqchip_state() as Song did.
>
>
>I think this ^ is relevant and should be added to the commit log. @Song 
>can you respin another version with the updated commit log? @Ryo can you 
>add your Reviewed-by when it's done?

Sure!

>This fix has been lagging behind for quite some time, it would be nice 
>to merge this in 6.10 and backport to stable.

Sincerely,

Ryo Takakura

>Thanks,
>
>Alex

