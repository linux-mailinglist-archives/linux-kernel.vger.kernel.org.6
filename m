Return-Path: <linux-kernel+bounces-368146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 325C79A0BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2CE283D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA7F20A5C0;
	Wed, 16 Oct 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SZ+KDOEY"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C215B13C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086512; cv=none; b=NTjs+Ev7hEKtmZNhhYvQBPPQjLfpQaoxelQwPvMtxWyZd+7KzLuDKscmtaF//kBUVxly7yXO6dANsrMj5jYNwo1LeA7L6xW3SmfC2i2M1+dlC3++McMhwSBTOTdAVQMArldNON6CoH0iILyOTV4yJguDDOITLh3lAf0QsA3mpG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086512; c=relaxed/simple;
	bh=IGF9igFMGiABgo8acMe0UhXDl5fL6jJr7Dk+tDalB1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GFeivAImMyeT6p4lcEqgXkk+qEwqrQdeKJeq6JAHymCalkZCuY3KmHTgPjvcHgTc27GLmIY+DY3LMhJLCPQCzYlQUFA7unCpuG0xEr/uIsYqiT1TPhkGtFU6ZjQ222URBVPHtgZ86szNWRtWvqyjRybU8fb55ulmHDoBQfV0gaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SZ+KDOEY; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49GDm4S2075985;
	Wed, 16 Oct 2024 08:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729086484;
	bh=ZaxyANJDQa6m8eaPm4fCn2VbOVR+pL6P58PiLp2TIUU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SZ+KDOEYczXaIw1Cqz+BMbbYH0jl/tly/kcR/ywbS7n+mXiQ6VLvoPbfAZss5lPk8
	 leUMs73H1o/ih+ONOIjges2FQRNxaZ9iEtOssFFbHuEFCVqurJIflUOLIqT5k/PzJJ
	 oKFOpOHxVWpbHqgee0DvDcUoLxTrJKQgYMTn7TBQ=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49GDm3EU058042
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Oct 2024 08:48:04 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Oct 2024 08:48:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Oct 2024 08:48:03 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49GDm2WM038218;
	Wed, 16 Oct 2024 08:48:02 -0500
Message-ID: <0c2ae869-d04f-481d-b770-ec54f4d2e658@ti.com>
Date: Wed, 16 Oct 2024 08:48:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] irqchip: Kconfig: Added module build support for
 the TI interrupt aggregator
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
 <20241016-timodules-v3-2-fa71091ade98@baylibre.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20241016-timodules-v3-2-fa71091ade98@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/16/24 4:41 AM, Guillaume La Roque wrote:
> From: Nicolas Frayer <nfrayer@baylibre.com>
> 
> Added module build support in Kconfig for the TI SCI interrupt aggregator
> driver. The driver's default build is built-in and it also depends on
> ARCH_K3 as the driver uses some 64 bit ops and should only be built
> for 64 bit platforms.
> 
> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>   arch/arm64/Kconfig.platforms      | 1 -
>   drivers/irqchip/Kconfig           | 5 +++--
>   drivers/irqchip/irq-ti-sci-inta.c | 1 +
>   3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 393845a3ae5c..9dea47decfbd 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -135,7 +135,6 @@ config ARCH_K3
>   	select SOC_TI
>   	select TI_MESSAGE_MANAGER
>   	select TI_SCI_PROTOCOL
> -	select TI_SCI_INTA_IRQCHIP
>   	select TI_K3_SOCINFO
>   	help
>   	  This enables support for Texas Instruments' K3 multicore SoC
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index a958731404e9..9646322345e4 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -544,10 +544,11 @@ config TI_SCI_INTR_IRQCHIP
>   	  TI System Controller, say Y here. Otherwise, say N.
>   
>   config TI_SCI_INTA_IRQCHIP
> -	bool
> -	depends on TI_SCI_PROTOCOL
> +	tristate "TI SCI INTA Interrupt Controller"
> +	depends on ARCH_K3 && TI_SCI_PROTOCOL

You can still compile test, just gate it on 64BIT (or ARM64 if those
64bit ops are only available on ARM64).

depends on ARCH_K3 || (COMPILE_TEST && ARM64)

BTW, the last time this was posted the feedback was that if this
was compiled as a module we might have issues with dependent drivers
not having this IRQ ready as it may be loaded later. I think this
would only cause probe defers if the drivers are well behaving, but
something to double check.

Andrew

>   	select IRQ_DOMAIN_HIERARCHY
>   	select TI_SCI_INTA_MSI_DOMAIN
> +	default ARCH_K3
>   	help
>   	  This enables the irqchip driver support for K3 Interrupt aggregator
>   	  over TI System Control Interface available on some new TI's SoCs.
> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
> index b83f5cbab123..a887efba262c 100644
> --- a/drivers/irqchip/irq-ti-sci-inta.c
> +++ b/drivers/irqchip/irq-ti-sci-inta.c
> @@ -743,3 +743,4 @@ module_platform_driver(ti_sci_inta_irq_domain_driver);
>   
>   MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ti.com>");
>   MODULE_DESCRIPTION("K3 Interrupt Aggregator driver over TI SCI protocol");
> +MODULE_LICENSE("GPL");
> 

