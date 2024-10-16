Return-Path: <linux-kernel+bounces-368195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8439A0C72
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21DD1C20D59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C3220C030;
	Wed, 16 Oct 2024 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QFVGcNpL"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A920C00B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088326; cv=none; b=rq4I4zWAjj+JFMEj1tj0KSxGVUPpJyFAoeuByzMwrupnLOHJDTBgiNIZqIe83xQtzr2H3rLkU+v314nGc67qYc2FmmPIuPX1LMTi3nDxhwuJ/ymZWAm+/KkpU21JFsQisg+/8VbbjdKqs8jtQJ47o4FkB+m251XfrSMnZJIpmIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088326; c=relaxed/simple;
	bh=C2XA3wt8mSC7QYJ9J0OdcZEXb5kaeMtdSsTmLqq13HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmIUdIuDZ0wV0lJFac+jvag+KH0+W9B1/ZB8oXw3HwPkcwt6VOMv2pKmAJ9Rm3Ys4RFg8gGGdKkAjJo4OCg1U8Y8jL6nHmZU7GBGUxZhzW7s1UsLdH2fModEm6uKg4XcHfwCRyffZI4rmRbavJoA/6DRheiXeZ7rw3Gq33YTIh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QFVGcNpL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43140a2f7f7so17871415e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729088322; x=1729693122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3XoQGpvLTfLi0/g6YUJeL26pge1uY+/1NVcT43Kbq+4=;
        b=QFVGcNpLUU+H3eHBqIOxj6xvilWApKFR7n75kfZElARl9Dki3jJS6VOgPpSsrVGShT
         m38WS8vdxxy/G+BwtPZwoCyYWD/J6x8IjBxPMHhaC4I5RVMnZd50izaX+bL/jcetr2kT
         1RJsIR/EQD3r6TToqodlsSM2Msp8Cg7uIb9wCAlfTziP4FXfStgdqZ4k0WGd6cmYbXw2
         nEKSjOiAiPALhB8L/lUi5J86bkw/miSaux18RJQnnB1Nk7NiO742fMslm3lbQ36b5pH1
         JyuurONK2jU63vS49n/57+X25CIoVqYnqOUNlTyUPQgr4pbf1MvfXuSLyjSjui72Xz0s
         /pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088322; x=1729693122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XoQGpvLTfLi0/g6YUJeL26pge1uY+/1NVcT43Kbq+4=;
        b=Dq1XBFdyb6xHuVQr8gn/HYRwzst4MWvkNvMdukFESYY20ANle0ElbvJEdQ+nK7MU9n
         AflI+uRdDGSrNKCtm0rrzpz4vhT/BcQAaL04l6N51sYZ1uzND3gxnAIQM081fWxl7YMJ
         BXF6dVRCITFRMyxuSzGF2/yUPt2Fo3dIf5+dOTJTURm9vW7t1I44Lo8NERZFBpS5Nhvi
         uByIXtEQUjw4Z7oRx48d12ZyB4P13dH67/myPS0BB+JgqHYLobBXGLgjFafWMiyUxsRG
         e+AZF2JHOr4BdSJOZXJDe0N6ed+JeVzGWxj0ikZN7DZXY+Y8LlQQbYU+a0V2UYtWJWT7
         KDnA==
X-Forwarded-Encrypted: i=1; AJvYcCUdtCarDOXU5qVVsIeqMLTbdo1/IdY5bOzB3x7r4emok7KqAZMaP9Ex2G0rUBbh7TkGHlkevgEaj1uZGPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8i8VTnHYLYyKEo8qGPTKuM5WeevBaqW9g440uFrWMGEFwrvG
	h881WMokEe0EqHPW5HSUTkZgZp43hNYjoGUGooTgu9SmWGlVc65/PSlE2sKVqlk=
X-Google-Smtp-Source: AGHT+IEAfMKrn9wpk7nbCLL6ykIc+NzLxYsdeNcKIupA23puzEsIaJX9RrEu5Oe3VrdfX6gLSI8yvw==
X-Received: by 2002:a05:600c:4f83:b0:42e:75a6:bb60 with SMTP id 5b1f17b1804b1-4314a322492mr32469155e9.19.1729088322293;
        Wed, 16 Oct 2024 07:18:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:a9c0:1c6c:5427:e89d? ([2a05:6e02:10a5:e010:a9c0:1c6c:5427:e89d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7faa4085sm4448154f8f.65.2024.10.16.07.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 07:18:41 -0700 (PDT)
Message-ID: <c97847c6-7e40-4b36-97bd-663aaa431aa7@baylibre.com>
Date: Wed, 16 Oct 2024 16:18:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] irqchip: Kconfig: module build support for the TI
 interrupt router driver
To: Andrew Davis <afd@ti.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 vishalm@ti.com, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Nicolas Frayer <nfrayer@baylibre.com>
References: <20241016-timodules-v3-0-fa71091ade98@baylibre.com>
 <20241016-timodules-v3-1-fa71091ade98@baylibre.com>
 <95b85e47-8554-430b-b878-e6045d8f6871@ti.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <95b85e47-8554-430b-b878-e6045d8f6871@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrew,

Le 16/10/2024 à 15:37, Andrew Davis a écrit :
> On 10/16/24 4:41 AM, Guillaume La Roque wrote:
>> From: Nicolas Frayer <nfrayer@baylibre.com>
>>
>> Added module build support in Kconfig for the TI SCI interrupt router
>> driver
>>
>> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>   arch/arm64/Kconfig.platforms      | 1 -
>>   drivers/irqchip/Kconfig           | 3 ++-
>>   drivers/irqchip/irq-ti-sci-intr.c | 1 +
>>   3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 6c6d11536b42..393845a3ae5c 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -135,7 +135,6 @@ config ARCH_K3
>>       select SOC_TI
>>       select TI_MESSAGE_MANAGER
>>       select TI_SCI_PROTOCOL
>> -    select TI_SCI_INTR_IRQCHIP
>>       select TI_SCI_INTA_IRQCHIP
>>       select TI_K3_SOCINFO
>>       help
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 341cd9ca5a05..a958731404e9 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -533,9 +533,10 @@ config LS1X_IRQ
>>         Support for the Loongson-1 platform Interrupt Controller.
>>     config TI_SCI_INTR_IRQCHIP
>> -    bool
>> +    tristate "TI SCI INTR Interrupt Controller"
>
> Although not needed, might be good to gate this on ARCH_K3
> as it only makes sense to add when K3 is an enabled platform.

Actually if ARCH_K3 is not selected it's not possible to enable TI 
IRQCHIP driver from menuconfig so depends look good or do you want to 
have when i select irqchip driver ARCH_K3 is enabled ?

> Then add on compile test support:
>
> depends on ARCH_K3 || COMPILE_TEST
>
i will add in v4.

thanks for review

Guillaume
> Andrew
>
>>       depends on TI_SCI_PROTOCOL
>>       select IRQ_DOMAIN_HIERARCHY
>> +    default ARCH_K3
>>       help
>>         This enables the irqchip driver support for K3 Interrupt router
>>         over TI System Control Interface available on some new TI's 
>> SoCs.
>> diff --git a/drivers/irqchip/irq-ti-sci-intr.c 
>> b/drivers/irqchip/irq-ti-sci-intr.c
>> index c027cd9e4a69..b49a73106c69 100644
>> --- a/drivers/irqchip/irq-ti-sci-intr.c
>> +++ b/drivers/irqchip/irq-ti-sci-intr.c
>> @@ -303,3 +303,4 @@ 
>> module_platform_driver(ti_sci_intr_irq_domain_driver);
>>     MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
>>   MODULE_DESCRIPTION("K3 Interrupt Router driver over TI SCI protocol");
>> +MODULE_LICENSE("GPL");
>>


