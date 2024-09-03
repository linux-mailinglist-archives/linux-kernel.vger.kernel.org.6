Return-Path: <linux-kernel+bounces-312542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7284E9697E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C221F24505
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23F91C7671;
	Tue,  3 Sep 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NZYlOiHW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72111C7663
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353629; cv=none; b=pFTKMBf2E1F2hjlMYut3BSiztJf/5zg6fdbuSkQBbE7GevwOjgPBiCVAuZj2wG9iwDFysE3EQYaRBdCPEceSn1UcZICMx0xajrudWOJCoDyoFMH+QEtpC+tyiP9wy/jdIe+sfHkPjiybYyVBcEoikEP7PsQ39+NE4yMhKhsOsZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353629; c=relaxed/simple;
	bh=ikeeOYEgrJwJtmNps3HCpuCmvb9ShnQmcvur9LytR74=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CEbRaHl9DcEfHEPxIQb2ergrbsBxnfbbEG7iSwwKNk6Mj93Chx8str6zZmq/2/nqraf/mLWCnSO/XGM9A2xlmc3DlWnwkUqaSUG73XkEBReTdr3iJlpIOv+oM6KJ5rjF6TCRHjegcxR/d0X48vtM5EZCVMnvSEI+RWNonObyBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NZYlOiHW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725353627; x=1756889627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ikeeOYEgrJwJtmNps3HCpuCmvb9ShnQmcvur9LytR74=;
  b=NZYlOiHWe2tzM8u0onuGLdKCl9bZrYKuqC4xe6dkSDdcnd+/hON5sv64
   PZ9duRgUepqheWwmFRmW741AHdUEux8GeQcMzJDvzF71ZLgqorkc7kaBb
   ARsrJgGHQOnyk1D8FklogJaiuNyJIFSmaVBEFusmAK8iJwkrnoANZUOBX
   EICXCYrUJzEiqdgMjZNq/m7/OW7NXfXwiSi+uMC+wlGK+CC2bnfv2BAAe
   IPw9xE9eYVx5IKb65kV/smUmoP6+XBV31hZnsR9q1GnzJTYWBklQT6xSa
   dr1REsGPm97YCKHrJ8rQhTNkmVqK8AacX2fiICQdMYv2Hw5vmnn2a0Fyt
   A==;
X-CSE-ConnectionGUID: Io7yATkYSoC5QRoM/qiFWw==
X-CSE-MsgGUID: 5Jek5hSLSdKnORaJHvum1g==
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="31221466"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 01:53:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 01:53:27 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 3 Sep 2024 01:53:26 -0700
Message-ID: <e39fe3df-3110-4f69-af9f-39dbd52d4865@microchip.com>
Date: Tue, 3 Sep 2024 10:53:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/12] irqchip/atmel-aic5: Add support for sam9x7 aic
Content-Language: en-US, fr-FR
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
	<tglx@linutronix.de>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Hari Prasath <Hari.PrasathGE@microchip.com>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
 <20240903064252.49530-1-varshini.rajendran@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240903064252.49530-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2024 at 08:42, Varshini Rajendran wrote:
> From: Hari Prasath <Hari.PrasathGE@microchip.com>
> 
> Add support for the Advanced interrupt controller(AIC) chip in the sam9x7.
> 
> Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

After several investigations to make this "smarter" (see on previous 
versions posts), we figured out this historic way of handling NR_XXX_IRQ 
is the best/simplest one.

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> ---
> Changes in v7:
> 
> - Removed the line break in the function.
> ---
>   drivers/irqchip/irq-atmel-aic5.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
> index 145535bd7560..f9168efa4160 100644
> --- a/drivers/irqchip/irq-atmel-aic5.c
> +++ b/drivers/irqchip/irq-atmel-aic5.c
> @@ -320,6 +320,7 @@ static const struct of_device_id aic5_irq_fixups[] __initconst = {
>   	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
>   	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
>   	{ .compatible = "microchip,sam9x60", .data = sam9x60_aic_irq_fixup },
> +	{ .compatible = "microchip,sam9x7", .data = sam9x60_aic_irq_fixup },
>   	{ /* sentinel */ },
>   };
>   
> @@ -406,3 +407,11 @@ static int __init sam9x60_aic5_of_init(struct device_node *node,
>   	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
>   }
>   IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);
> +
> +#define NR_SAM9X7_IRQS		70
> +
> +static int __init sam9x7_aic5_of_init(struct device_node *node, struct device_node *parent)
> +{
> +	return aic5_of_init(node, parent, NR_SAM9X7_IRQS);
> +}
> +IRQCHIP_DECLARE(sam9x7_aic5, "microchip,sam9x7-aic", sam9x7_aic5_of_init);


