Return-Path: <linux-kernel+bounces-349423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D913A98F5C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BA0CB23134
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E343C1AB6ED;
	Thu,  3 Oct 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Of1J8Hvy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872011AAE1D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978576; cv=none; b=SYy4Z6DpjzxIzRuIKul1iv7iUHTdLh/xqIQ/i6Yak6HAklcbnbbyHiqd3JEp/3Zm4p6pa0TZVjJoIAka1le+nSiCUYOOHRVWFDq8rPSIumiMe/Ao7D/8WuoQ3qR7LpvNiLWvqjvjXta9FIuuk8kJDSvh2I1PlIX8Npnki7K44BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978576; c=relaxed/simple;
	bh=LNXHnZ3MJTRGkhaxV719B4uyyapg1cSteIU3lrzILyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4iGOvnq2InKeT+logUjXpaJd1dz5RFVBKGv3eXAVqngKzvOBsR5zjlXPjY/znmGsjI19yGmKA+pdhXBdZW5vE0Gzt9lOFQK5D28E3pEHb0/s2JJ6Tr30m5T8+NUe+Rhq9Fvmse7sOA88Y+uImbuRL007/Zo0PjxEX4AXb4IFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Of1J8Hvy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727978573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoB0gVV5ljS71U6qY/mcjDVPFZ4CZEqwYkfhM8ibUYo=;
	b=Of1J8HvywBb1k8ZGAJx/JNinSXFgbhWuqAa3J6zscqKcumtqlJ7uAZXHB8yRTCYYMOJfFj
	GsjkyQCISJZ8IBleouFFRsQ4Eai/dLf91KmxByQQvw4qcMC9f6C4hqTi7yQIeja6twO50l
	x6rxd+PpGzbeheo9yKAXM3L2RK43o44=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-RUwWaVmgMRi1vNQoSNRnSg-1; Thu, 03 Oct 2024 14:02:52 -0400
X-MC-Unique: RUwWaVmgMRi1vNQoSNRnSg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8a877c1d22so87368266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 11:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727978571; x=1728583371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoB0gVV5ljS71U6qY/mcjDVPFZ4CZEqwYkfhM8ibUYo=;
        b=VtlJT1b15Fs8hgBYFDe1c3Irk4V7uY470Sq4/WyikoMXsab0/qcysA3uF1X3glCTUi
         SAJGYTo5eIXyeBSm3Dwdas/ChK/w60Q3g//XJFDpGlt46/b3yebdwJABt1dBHpOLFE26
         4Wi3uJJwtBlG22aDY58psqvg9a3sXn/oTWFcs5f1FgGYFe3Lmhvrwl7yTEJbqNDYFdCt
         jz5Sd2GepCkXwCXX6xCRZzZ63CmMHJVfg/lVeDvdRQ0fFnqPNvu+x6zOuEghvGgiOaBa
         dIG0sqGihvZPEOGL1vd8MY/mlOQAhlaL8LcvpoKgZDjwv4dTt1dC4hfZJMY/t5NZLpyt
         u2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpbDhJMBLigxOkrnbbHt7OAFWJaqIiuCxlSSZivScSlsHo/Mam7st8U4FcB+Pa0oCImGHdX59YlJELHBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy875/LhVSSvPfmTt65JuY0MZYx/Zr8LqZWHMDI/jUuMJ9y+hWb
	ZO1VfJvA4sWqCslUgmyE/e1ZGYP8DgFZK1ZHmeOwoFO9+ASZyF+aZBCuuyiaWfTFYrDQepuXaoJ
	0FPjpmoFydrH6293WbsoGDngNBdB840FEIUBsrBmZa/8C4PRxZxva6nkeVQa13g==
X-Received: by 2002:a17:907:e89:b0:a8d:44a5:1c2f with SMTP id a640c23a62f3a-a991bce3ac7mr20421866b.6.1727978571018;
        Thu, 03 Oct 2024 11:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6n7NcOHAAmMOq2VOS/f3DZ6xSz0sT97JwLchZBMGQYGRM+Fp8/kX9HVDKXUACimFwhcWCQg==
X-Received: by 2002:a17:907:e89:b0:a8d:44a5:1c2f with SMTP id a640c23a62f3a-a991bce3ac7mr20418966b.6.1727978570560;
        Thu, 03 Oct 2024 11:02:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910472f96sm116305766b.146.2024.10.03.11.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 11:02:50 -0700 (PDT)
Message-ID: <b230f7a0-618c-4ebb-913c-93602fb64cd2@redhat.com>
Date: Thu, 3 Oct 2024 20:02:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU
 device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-usb@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Zhang Ning <zhangn1985@outlook.com>
References: <20241003174252.1190628-2-andriy.shevchenko@linux.intel.com>
 <20241003174252.1190628-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241003174252.1190628-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Oct-24 7:32 PM, Andy Shevchenko wrote:
> While design wise the idea of converting the driver to use
> the hierarchy of the IRQ chips is correct, the implementation
> has (inherited) flaws. This was unvelead when platform_get_irq()
> had started WARN() on IRQ 0 that is supposed to be a Linux
> IRQ number (also known as vIRQ).
> 
> Rework the driver to respect IRQ domain when creating each MFD
> device separately, as the domain is not the same for all of them.
> 
> Fixes: 957ae5098185 ("platform/x86: Add Whiskey Cove PMIC TMU support")
> Fixes: 57129044f504 ("mfd: intel_soc_pmic_bxtwc: Use chained IRQs for second level IRQ chips")
> Reported-by: Zhang Ning <zhangn1985@outlook.com>
> Closes: https://lore.kernel.org/r/TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, patch looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Please feel free to merge this through the MFD tree as suggested in
the cover-letter.

Regards,

Hans


> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c     | 31 ++++++++++++++------------
>  drivers/platform/x86/intel/bxtwc_tmu.c | 22 +++++-------------
>  2 files changed, 23 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index d72995a9e820..628108dcf545 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -245,12 +245,6 @@ static struct mfd_cell bxt_wc_dev[] = {
>  		.num_resources = ARRAY_SIZE(bcu_resources),
>  		.resources = bcu_resources,
>  	},
> -	{
> -		.name = "bxt_wcove_tmu",
> -		.num_resources = ARRAY_SIZE(tmu_resources),
> -		.resources = tmu_resources,
> -	},
> -
>  	{
>  		.name = "bxt_wcove_gpio",
>  		.num_resources = ARRAY_SIZE(gpio_resources),
> @@ -261,6 +255,14 @@ static struct mfd_cell bxt_wc_dev[] = {
>  	},
>  };
>  
> +static const struct mfd_cell bxt_wc_tmu_dev[] = {
> +	{
> +		.name = "bxt_wcove_tmu",
> +		.num_resources = ARRAY_SIZE(tmu_resources),
> +		.resources = tmu_resources,
> +	},
> +};
> +
>  static struct mfd_cell bxt_wc_chgr_dev[] = {
>  	{
>  		.name = "bxt_wcove_usbc",
> @@ -489,6 +491,15 @@ static int bxtwc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to add IRQ chip\n");
>  
> +	ret = bxtwc_add_chained_devices(pmic, bxt_wc_tmu_dev, ARRAY_SIZE(bxt_wc_tmu_dev),
> +					pmic->irq_chip_data,
> +					BXTWC_TMU_LVL1_IRQ,
> +					IRQF_ONESHOT,
> +					&bxtwc_regmap_irq_chip_tmu,
> +					&pmic->irq_chip_data_tmu);
> +	if (ret)
> +		return ret;
> +
>  	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
>  					 BXTWC_PWRBTN_LVL1_IRQ,
>  					 IRQF_ONESHOT,
> @@ -497,14 +508,6 @@ static int bxtwc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to add PWRBTN IRQ chip\n");
>  
> -	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
> -					 BXTWC_TMU_LVL1_IRQ,
> -					 IRQF_ONESHOT,
> -					 &bxtwc_regmap_irq_chip_tmu,
> -					 &pmic->irq_chip_data_tmu);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to add TMU IRQ chip\n");
> -
>  	/* Add chained IRQ handler for BCU IRQs */
>  	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
>  					 BXTWC_BCU_LVL1_IRQ,
> diff --git a/drivers/platform/x86/intel/bxtwc_tmu.c b/drivers/platform/x86/intel/bxtwc_tmu.c
> index d0e2a3c293b0..9ac801b929b9 100644
> --- a/drivers/platform/x86/intel/bxtwc_tmu.c
> +++ b/drivers/platform/x86/intel/bxtwc_tmu.c
> @@ -48,9 +48,8 @@ static irqreturn_t bxt_wcove_tmu_irq_handler(int irq, void *data)
>  static int bxt_wcove_tmu_probe(struct platform_device *pdev)
>  {
>  	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
> -	struct regmap_irq_chip_data *regmap_irq_chip;
>  	struct wcove_tmu *wctmu;
> -	int ret, virq, irq;
> +	int ret;
>  
>  	wctmu = devm_kzalloc(&pdev->dev, sizeof(*wctmu), GFP_KERNEL);
>  	if (!wctmu)
> @@ -59,27 +58,18 @@ static int bxt_wcove_tmu_probe(struct platform_device *pdev)
>  	wctmu->dev = &pdev->dev;
>  	wctmu->regmap = pmic->regmap;
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return irq;
> +	wctmu->irq = platform_get_irq(pdev, 0);
> +	if (wctmu->irq < 0)
> +		return wctmu->irq;
>  
> -	regmap_irq_chip = pmic->irq_chip_data_tmu;
> -	virq = regmap_irq_get_virq(regmap_irq_chip, irq);
> -	if (virq < 0) {
> -		dev_err(&pdev->dev,
> -			"failed to get virtual interrupt=%d\n", irq);
> -		return virq;
> -	}
> -
> -	ret = devm_request_threaded_irq(&pdev->dev, virq,
> +	ret = devm_request_threaded_irq(&pdev->dev, wctmu->irq,
>  					NULL, bxt_wcove_tmu_irq_handler,
>  					IRQF_ONESHOT, "bxt_wcove_tmu", wctmu);
>  	if (ret) {
>  		dev_err(&pdev->dev, "request irq failed: %d,virq: %d\n",
> -							ret, virq);
> +			ret, wctmu->irq);
>  		return ret;
>  	}
> -	wctmu->irq = virq;
>  
>  	/* Unmask TMU second level Wake & System alarm */
>  	regmap_update_bits(wctmu->regmap, BXTWC_MTMUIRQ_REG,


