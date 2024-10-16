Return-Path: <linux-kernel+bounces-368205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E069A0C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E241C21D61
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82BE208D95;
	Wed, 16 Oct 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P+4fGtVz"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572B2502BE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088792; cv=none; b=B06u8zhvRJmCRjoIJkFbzS2qfFNFWmqzyBpZHTHrCROxiob4pyQQlujuZ0bLkckwt0dL81QdpF6wBKSKwZO5OBuHbxELj9BUt+4MdGOrgx+dquXcwiczvPo1GPGpcNBkOPNxJHSXhj1GtkV3EpLAI5Et/zaDQQwoESN2DjkiXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088792; c=relaxed/simple;
	bh=AVIojWVgVPgacv9ZbneEhN8rUVSFbdBdgSb2arX1QKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EAP+SaDtl9hrA3/p3peu5er7m5JW5hT7qUwtq3y4k+LlL2bPTv5httIix7ciICADAvUoUaSt8pMRO2I8PypFWSPLd9jMiSGKjgm42R8mY8p8j8U04Db6o6yzNDVkjwgIrI/23Fyiu9cDISsv1t+ZtWAN1UhAJFaa1DyfG3YgMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P+4fGtVz; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49GEQIff053122;
	Wed, 16 Oct 2024 09:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729088778;
	bh=7uD86GHH73wAIfXRyQS8Bz3q+Ng3nHf4VH1iDLFs+LQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=P+4fGtVznXW+wmHDiADj6Lo97gXLn0iUAft9wq48rNX+tXGU/hNekNGBP/2Mh0pkW
	 7U0H1tOLIYX5yhVGcDfES0lFjG2t/tNIzIzXAyIa7Q4+eY8NUdb6lUDCTfdIfgzWVE
	 eJOeY5fLpEoKJwsUqZYPz0di59y2WprfR6+IBJPo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49GEQIbM026790
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Oct 2024 09:26:18 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Oct 2024 09:26:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Oct 2024 09:26:17 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49GEQH66083088;
	Wed, 16 Oct 2024 09:26:17 -0500
Message-ID: <9cec1380-37f5-48e1-ad89-2bcede5d5f3c@ti.com>
Date: Wed, 16 Oct 2024 09:26:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] irqchip: Kconfig: module build support for the TI
 interrupt router driver
To: Guillaume LA ROQUE <glaroque@baylibre.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>,
        Nishanth Menon <nm@ti.com>, Tero Kristo
	<kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <vishalm@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Kevin
 Hilman <khilman@baylibre.com>,
        Nicolas Frayer <nfrayer@baylibre.com>
References: <20241016-timodules-v3-0-fa71091ade98@baylibre.com>
 <20241016-timodules-v3-1-fa71091ade98@baylibre.com>
 <95b85e47-8554-430b-b878-e6045d8f6871@ti.com>
 <c97847c6-7e40-4b36-97bd-663aaa431aa7@baylibre.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <c97847c6-7e40-4b36-97bd-663aaa431aa7@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/16/24 9:18 AM, Guillaume LA ROQUE wrote:
> Hi Andrew,
> 
> Le 16/10/2024 à 15:37, Andrew Davis a écrit :
>> On 10/16/24 4:41 AM, Guillaume La Roque wrote:
>>> From: Nicolas Frayer <nfrayer@baylibre.com>
>>>
>>> Added module build support in Kconfig for the TI SCI interrupt router
>>> driver
>>>
>>> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
>>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>>> ---
>>>   arch/arm64/Kconfig.platforms      | 1 -
>>>   drivers/irqchip/Kconfig           | 3 ++-
>>>   drivers/irqchip/irq-ti-sci-intr.c | 1 +
>>>   3 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>> index 6c6d11536b42..393845a3ae5c 100644
>>> --- a/arch/arm64/Kconfig.platforms
>>> +++ b/arch/arm64/Kconfig.platforms
>>> @@ -135,7 +135,6 @@ config ARCH_K3
>>>       select SOC_TI
>>>       select TI_MESSAGE_MANAGER
>>>       select TI_SCI_PROTOCOL
>>> -    select TI_SCI_INTR_IRQCHIP
>>>       select TI_SCI_INTA_IRQCHIP
>>>       select TI_K3_SOCINFO
>>>       help
>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>> index 341cd9ca5a05..a958731404e9 100644
>>> --- a/drivers/irqchip/Kconfig
>>> +++ b/drivers/irqchip/Kconfig
>>> @@ -533,9 +533,10 @@ config LS1X_IRQ
>>>         Support for the Loongson-1 platform Interrupt Controller.
>>>     config TI_SCI_INTR_IRQCHIP
>>> -    bool
>>> +    tristate "TI SCI INTR Interrupt Controller"
>>
>> Although not needed, might be good to gate this on ARCH_K3
>> as it only makes sense to add when K3 is an enabled platform.
> 
> Actually if ARCH_K3 is not selected it's not possible to enable TI IRQCHIP driver from menuconfig so depends look good or do you want to have when i select irqchip driver ARCH_K3 is enabled ?
> 

Just adding the below "depends on" is fine, no need to select
or change anything else.

Andrew

>> Then add on compile test support:
>>
>> depends on ARCH_K3 || COMPILE_TEST
>>
> i will add in v4.
> 
> thanks for review
> 
> Guillaume
>> Andrew
>>
>>>       depends on TI_SCI_PROTOCOL
>>>       select IRQ_DOMAIN_HIERARCHY
>>> +    default ARCH_K3
>>>       help
>>>         This enables the irqchip driver support for K3 Interrupt router
>>>         over TI System Control Interface available on some new TI's SoCs.
>>> diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
>>> index c027cd9e4a69..b49a73106c69 100644
>>> --- a/drivers/irqchip/irq-ti-sci-intr.c
>>> +++ b/drivers/irqchip/irq-ti-sci-intr.c
>>> @@ -303,3 +303,4 @@ module_platform_driver(ti_sci_intr_irq_domain_driver);
>>>     MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
>>>   MODULE_DESCRIPTION("K3 Interrupt Router driver over TI SCI protocol");
>>> +MODULE_LICENSE("GPL");
>>>
> 

