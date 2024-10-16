Return-Path: <linux-kernel+bounces-368136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B949A0BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25052856AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C928C209F25;
	Wed, 16 Oct 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KZB38Awu"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF31D8E1D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085875; cv=none; b=M8J1bzE6wSfMj2semvI0AeOUJ9CINm3qRQqueDyeBTF+gxN5Ce3p5u7HU8AOo6XHe9phofNefGy94KQTBaHcgpDlx5hQB4iHalbaZrccy6dMxnXbK3AzSKLYRCfStDyPY3EKMRwYH2jzw3LXP0VHr7U8khSuGZmI1AxFyP0Zt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085875; c=relaxed/simple;
	bh=rstzZ+tYMOBPE3s6OxqHfKru1qf4RB/h5Ip+XluFWZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KbYXEXuJRPxxqx6qnvRXMD6zKcWYjDOeofS4Uexn2Wwz1Lhc37gq8fYljhIjvvWspBiBFKc9SAxLXqOxfFMaibAhSbn0FNAsa+t+GeHoe7V+4JiQ/XusLBSbQDyXR9pMyv5vR48i1abDyo5SI/xgbLSFf3fbsglSGjGX0K/H//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KZB38Awu; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49GDbUV4038068;
	Wed, 16 Oct 2024 08:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729085850;
	bh=La6IiwF9AF4sfLgfEWGzq3v+9S/L+fVlphilJ568oRM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KZB38AwuzTDKF9tNRm3BEeBiZu3zZgMEy1fsEXoliL1IUNNbT84+NKl2/HUQmRfFq
	 /CrX1ROdE0f7R31hSk16iCjOAfKJW1sAqzTi8ImHyc2xu31EWgdCau3fGk71oaqczX
	 XCq7WL4e5/JQqgyk+xUSN4gikL2TQoL3/K0gS7zk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49GDbU5J052142
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Oct 2024 08:37:30 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Oct 2024 08:37:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Oct 2024 08:37:30 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49GDbT1S075414;
	Wed, 16 Oct 2024 08:37:29 -0500
Message-ID: <95b85e47-8554-430b-b878-e6045d8f6871@ti.com>
Date: Wed, 16 Oct 2024 08:37:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] irqchip: Kconfig: module build support for the TI
 interrupt router driver
To: Guillaume La Roque <glaroque@baylibre.com>,
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
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20241016-timodules-v3-1-fa71091ade98@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/16/24 4:41 AM, Guillaume La Roque wrote:
> From: Nicolas Frayer <nfrayer@baylibre.com>
> 
> Added module build support in Kconfig for the TI SCI interrupt router
> driver
> 
> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>   arch/arm64/Kconfig.platforms      | 1 -
>   drivers/irqchip/Kconfig           | 3 ++-
>   drivers/irqchip/irq-ti-sci-intr.c | 1 +
>   3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 6c6d11536b42..393845a3ae5c 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -135,7 +135,6 @@ config ARCH_K3
>   	select SOC_TI
>   	select TI_MESSAGE_MANAGER
>   	select TI_SCI_PROTOCOL
> -	select TI_SCI_INTR_IRQCHIP
>   	select TI_SCI_INTA_IRQCHIP
>   	select TI_K3_SOCINFO
>   	help
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 341cd9ca5a05..a958731404e9 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -533,9 +533,10 @@ config LS1X_IRQ
>   	  Support for the Loongson-1 platform Interrupt Controller.
>   
>   config TI_SCI_INTR_IRQCHIP
> -	bool
> +	tristate "TI SCI INTR Interrupt Controller"

Although not needed, might be good to gate this on ARCH_K3
as it only makes sense to add when K3 is an enabled platform.
Then add on compile test support:

depends on ARCH_K3 || COMPILE_TEST

Andrew

>   	depends on TI_SCI_PROTOCOL
>   	select IRQ_DOMAIN_HIERARCHY
> +	default ARCH_K3
>   	help
>   	  This enables the irqchip driver support for K3 Interrupt router
>   	  over TI System Control Interface available on some new TI's SoCs.
> diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
> index c027cd9e4a69..b49a73106c69 100644
> --- a/drivers/irqchip/irq-ti-sci-intr.c
> +++ b/drivers/irqchip/irq-ti-sci-intr.c
> @@ -303,3 +303,4 @@ module_platform_driver(ti_sci_intr_irq_domain_driver);
>   
>   MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
>   MODULE_DESCRIPTION("K3 Interrupt Router driver over TI SCI protocol");
> +MODULE_LICENSE("GPL");
> 

