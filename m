Return-Path: <linux-kernel+bounces-410953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBC09CF0CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048FE283D03
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FED1CEE91;
	Fri, 15 Nov 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Su+j5v5s"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F51E519
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686225; cv=none; b=A638tUqoxeX2fKMqNXZc/9sDzKAup9quob7W+TKJ33t2iXrN/L/EsWc4TceyMR8HXQjdAZn1x2dXevp0ddAkYFjhnALMWy4I6CEmPee7dGJ7WhvK9G3YfZLD6/TtPwVhpDIi8ZrNNmOWiwMj14XuE8YR9UFe6wP/O1/Mktsl8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686225; c=relaxed/simple;
	bh=AlDEGL9LDco9t1mKPKKHdLD+wv0TcrjOUuzzc8aGpfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukDNADwt3XILtyu8ZKulhsQctcn+TlRrPiAinuRKCKSJ+EfrdRQa9SzIpO5K0zi7doLaJdO9aUKLpIag+nhqPk0wevSVBEIyAUNBMhTwKWDEwVF0YDEd5DoyIAR6L+bgLwjthC5KXY20HkrXyeopJxLNpXZWhlkCzkSjLQzVKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Su+j5v5s; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a6ababaaa9so3227005ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1731686222; x=1732291022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+rnx6UgiqXrH5bDxfguf6xfUwDWk1F65iK1HKNBelU=;
        b=Su+j5v5sAhfXo5fp6xP1IBNEPQbmIqwns3ha0xcUjc4nXmHgJ8iymLsZqvwvfqaeG/
         j5rZjnU7KUpZ7aicmWweVDVAOUTbkVgfV5jvFYvPXNBiN5ejkJTwdPyY9r5CBUcysQ8u
         f1XRTAXuC4XkMwM8CYRlJx3N7PrKio92X9T6R6rtTYwwJLQLCGtV2TyA2KAza+IMNkM/
         06SmuncCPLQTm7fyIEz4JFskQHN/LlDLPirrQqDHIrpGdryN41UFljcgdM22axfxgGOA
         UkAF5ZwwkqpbBHUIOqBoFMjf9yXdXUpssLANX/Evqqa/h2L53xLMyUGINaJgbC+ASIGc
         QEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686222; x=1732291022;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+rnx6UgiqXrH5bDxfguf6xfUwDWk1F65iK1HKNBelU=;
        b=ql5HtCa+7mNY4v7fPcbgFP2RukboHm2Zy+cVKSOVowax0KonN9TNeKaXBgL1uV6BZh
         zyISzgI03wAzos8Bz8H15vAhGPaPU4CjWCqgC6GfltIth8EQyMfVRe/fP9KPh1aHS80m
         iw68ofejF3dLgYxF97sdSIP+pa3dBSbo1Oyq8/YEsx2TXSn1HcY4z5zaJHWX8kdXCcO6
         Ro398cWqDkVd25DVotf3c75wwL2o0qvBg0pzboyRh9HKm9mB5UOb95pybU6O+lwudgUE
         rjVF5eVNwYjj4dMvgPSuxyBVq/OxR9Y6r+iE5qoygDAeCHC7F84kRjGi8FYS31g4e9ZF
         TA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMV1VfT6fb9PJx59Si9wcDeVbsqui501L40FoPLhrl4sbhXzNTIvwmvmFANFYcPehEb2KKQPDYyONHYK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh41rg/jjO+wiq+WLRki8jDe/CD5SkWCb+6ASRV1TclfAJhhRk
	uyuX7y2CcWq5cuX35Y+qs24+Cd0yOXDimyVz/GIlFs3bocSpPU5Sf7v3sQnuvbU=
X-Google-Smtp-Source: AGHT+IHLYI16z6tZcHvVg1d1AfaTsr5FXWrQvyx1DzsBfAgKeYMUzeWqaPDyNNu463w5bz1k3LpgcA==
X-Received: by 2002:a05:6e02:1fe3:b0:3a6:c122:508c with SMTP id e9e14a558f8ab-3a748079e25mr33546605ab.19.1731686222210;
        Fri, 15 Nov 2024 07:57:02 -0800 (PST)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a749393582sm3189915ab.10.2024.11.15.07.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:57:01 -0800 (PST)
Message-ID: <1bce34c6-c2d0-4b2b-a8f9-7bc8737702b1@sifive.com>
Date: Fri, 15 Nov 2024 09:57:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/riscv-aplic: Fix crash when MSI domain is missing
To: Anup Patel <apatel@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@linutronix.de>,
 Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20241114200133.3069460-1-samuel.holland@sifive.com>
 <CAK9=C2UyfmHqtYYK-WeSRk3=6bjs5nzDmw9ntudbCnPOYxLtXg@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAK9=C2UyfmHqtYYK-WeSRk3=6bjs5nzDmw9ntudbCnPOYxLtXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Anup,

On 2024-11-15 9:42 AM, Anup Patel wrote:
> On Fri, Nov 15, 2024 at 1:31 AM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> If the APLIC driver is probed before the IMSIC driver, the parent MSI
>> domain will be missing, which causes a NULL pointer dereference in
>> msi_create_device_irq_domain(). Avoid this by deferring probe until the
>> parent MSI domain is available. Use dev_err_probe() to avoid printing an
>> error message when returning -EPROBE_DEFER.
> 
> The -EPROBE_DEFER is not needed because we expect that platforms to
> use "msi-parent" DT property in APLIC DT node which in-turn allows Linux
> DD framework to re-order probing based on fw_devlink dependencies. The
> APLIC DT bindings mandates that any of "interrupt-extended" or "msi-parent"
> DT properties MUST be present.
> 
> Can you elaborate a bit more on how you are hitting this issue ?

I agree that fw_devlink should help avoid the situation where we need to return
-EPROBE_DEFER, but the kernel must still not crash even if fw_devlink is
disabled (which is a perfectly valid thing to do: "fw_devlink=off" on the kernel
command line) or if fw_devlink fails to come up with the ideal probe order.
fw_devlink is an optimization. It should not be relied on for correctness. In my
specific case, fw_devlink got the order wrong due to some false dependency
cycles, which I sent a patch for separately[1].

Regards,
Samuel

[1]:
https://lore.kernel.org/lkml/20241114195652.3068725-1-samuel.holland@sifive.com/

>> Fixes: ca8df97fe679 ("irqchip/riscv-aplic: Add support for MSI-mode")
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  drivers/irqchip/irq-riscv-aplic-main.c | 3 ++-
>>  drivers/irqchip/irq-riscv-aplic-msi.c  | 3 +++
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
>> index 900e72541db9..93e7c51f944a 100644
>> --- a/drivers/irqchip/irq-riscv-aplic-main.c
>> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
>> @@ -207,7 +207,8 @@ static int aplic_probe(struct platform_device *pdev)
>>         else
>>                 rc = aplic_direct_setup(dev, regs);
>>         if (rc)
>> -               dev_err(dev, "failed to setup APLIC in %s mode\n", msi_mode ? "MSI" : "direct");
>> +               dev_err_probe(dev, rc, "failed to setup APLIC in %s mode\n",
>> +                             msi_mode ? "MSI" : "direct");
>>
>>  #ifdef CONFIG_ACPI
>>         if (!acpi_disabled)
>> diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
>> index 945bff28265c..fb8d1838609f 100644
>> --- a/drivers/irqchip/irq-riscv-aplic-msi.c
>> +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
>> @@ -266,6 +266,9 @@ int aplic_msi_setup(struct device *dev, void __iomem *regs)
>>                         if (msi_domain)
>>                                 dev_set_msi_domain(dev, msi_domain);
>>                 }
>> +
>> +               if (!dev_get_msi_domain(dev))
>> +                       return -EPROBE_DEFER;
>>         }
>>
>>         if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic_msi_template,
>> --
>> 2.45.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


