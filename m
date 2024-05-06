Return-Path: <linux-kernel+bounces-169308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B8D8BC6A5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C7128165B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 05:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372FC4654B;
	Mon,  6 May 2024 05:11:11 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F11EB36
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 05:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714972270; cv=none; b=qTrKFgOpYbkKqz1M5fgDHzypt6GElEs4YUC48Vi0aRMWzdSrysb0IwGFG6B/Y4Tdfjfz1p4OQ7iBn1tgWLHfUaS1YVKAELTFtVDNKHzlMOl3HvELZarMX3FmicoVCVYLs6LE2z4cVMyCC2KkmGZUmqpyQt1P926KthY1ugUqAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714972270; c=relaxed/simple;
	bh=BB0dnxQuZNlpbqV7qVpCvA6BjpvtolgqVeWWLahaff0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHoL7Bk2rVRfeUYC2f12MWgyIbrBJJnC5QDmTlUQGJvrbGoqXdDUAxCB5mR19yLpTt+3wcfObo+7mI7FYNjjbqcMSoEmIJLAWKCAENxBV1ng1YwTTcn1k2H1rFmEwjMebptzgtbJ1fKv6+TmkzAJU81QIjSZufpDesapyf7xDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 61438A99CF;
	Mon,  6 May 2024 14:11:00 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fd3innPWGCin; Mon,  6 May 2024 14:11:00 +0900 (JST)
Received: from localhost.localdomain (p10626078-ipngn25201marunouchi.tokyo.ocn.ne.jp [153.201.134.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 25483A9977;
	Mon,  6 May 2024 14:11:00 +0900 (JST)
From: takakura@valinux.co.jp
To: songshuaishuai@tinylab.org,
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
Date: Mon,  6 May 2024 14:10:58 +0900
Message-Id: <20240506051058.20386-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0e34cd12-66d8-4432-780a-f08d03a2c95e@sifive.com>
References: <0e34cd12-66d8-4432-780a-f08d03a2c95e@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Song and Paul!

>> To avoid the deadlock, this patch directly EOI the irq regardless of
>> the active status of irqchip.
>
>Taking a quick look at the other architectures, looks like no one else is 
>doing this.  Is this addressing a RISC-V-only problem?
>
>> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
>> index f6c7135b00d7..d7ddf4d2b243 100644
>> --- a/arch/riscv/kernel/machine_kexec.c
>> +++ b/arch/riscv/kernel/machine_kexec.c
>> @@ -149,20 +149,12 @@ static void machine_kexec_mask_interrupts(void)
>>  
>>  	for_each_irq_desc(i, desc) {
>>  		struct irq_chip *chip;
>> -		int ret;
>>  
>>  		chip = irq_desc_get_chip(desc);
>>  		if (!chip)
>>  			continue;
>>  
>> -		/*
>> -		 * First try to remove the active state. If this
>> -		 * fails, try to EOI the interrupt.
>> -		 */
>> -		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
>> -
>> -		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
>> -		    chip->irq_eoi)
>> +		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
>>  			chip->irq_eoi(&desc->irq_data);
I think this deadlock is relevant to riscv and arm64 as they both
acquire irqdesc spinlock by calling irq_set_irqchip_state() during their 
machine_kexec_mask_interrupts().

However, I think calling irq_set_irqchip_state() during 
machine_kexec_mask_interrupts() is arm64 specific way of handling EOI 
which is not necessary for riscv.
For arm64, its interrupt controller(gic) seems to have two ways of EOIing 
an interrupt depending on the mode which gic is configured. One of them 
treats EOI as two step procedure, priority drop and deactivation. I think 
irq_set_irqchip_state() is there to handle the deactivation part of 
the procedure.
For riscv, EOI only requires irq_eoi handler to complete EOI and I think 
keeping irq_set_irqchip_state() will only leave this possible deadlock 
without any use. 
So I think it's best we simply remove irq_set_irqchip_state() as Song did.

Sincerely,
Ryo Takakura

