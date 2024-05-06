Return-Path: <linux-kernel+bounces-170330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB388BD54E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA2B3B21C40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8391591F7;
	Mon,  6 May 2024 19:19:04 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A0A158DDF
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023143; cv=none; b=CpmX5nM4oe48i1kZUmF+Je3jCwkFDFvyeaDtZ0ipQheoJjBSAHDnDtLtYsjB5EeYNvjPGJDsKG5Sxp7vWQJ4gdHMluEtg4ZUBMt3/Lfxo2qlypmGiL6309QcQXGLWj8YZtT/qO2YgMCsHrjCDRlDcdJICr6ubC121kHvWFKFQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023143; c=relaxed/simple;
	bh=iLuv/RrdkCRleNf8Bzi0oI0hYiMT/yyTAH48drrVY34=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFhaI7vDPARxPwXq3LB5Ds62iqbHHOcSS1if9cWcPoh5DvFNydHI55BjDuMIOfqQ7h+RkYfuBCXXWajUhFlwQpoQQZITolCNxaZz4HnGZ6ASExUuTHAtefuXwRLJlm7NPhFb6J2r0uu2uwc9z2VVCUgPIDSiFB40ulLN9aVR6no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 7d5a15ba-0bdd-11ef-abf4-005056bdd08f;
	Mon, 06 May 2024 22:18:59 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 6 May 2024 22:18:58 +0300
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Satya Priya <quic_c_skakit@quicinc.com>,
	Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 11/13] mfd: pm8008: rework driver
Message-ID: <ZjktIrsZS-T7cm-A@surfacebook.localdomain>
References: <20240506150830.23709-1-johan+linaro@kernel.org>
 <20240506150830.23709-12-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506150830.23709-12-johan+linaro@kernel.org>

Mon, May 06, 2024 at 05:08:28PM +0200, Johan Hovold kirjoitti:
> Rework the pm8008 driver to match the new binding which no longer
> describes internal details like interrupts and register offsets
> (including which of the two consecutive I2C addresses the registers
> belong two).
> 
> Instead make the interrupt controller implementation internal and pass
> interrupts to the subdrivers using MFD cell resources.
> 
> Note that subdrivers may either get their resources, like register block
> offsets, from the parent MFD or this can be included in the subdrivers
> directly.
> 
> In the current implementation, the temperature alarm driver is generic
> enough to just get its base address and alarm interrupt from the parent
> driver, which already uses this information to implement the interrupt
> controller.
> 
> The regulator driver, however, needs additional information like parent
> supplies and regulator characteristics so in that case it is easier to
> just augment its table with the regulator register base addresses.
> 
> Similarly, the current GPIO driver already holds the number of pins and
> that lookup table can therefore also be extended with register offsets.
> 
> Note that subdrivers can now access the two regmaps by name, even if the
> primary regmap is registered last so that it's returned by default when
> no name is provided in lookups.
> 
> Finally, note that the current QPNP GPIO and temperature alarm
> subdrivers need some minor rework before they can be used with non-SPMI
> devices like the PM8008. The MFD cell names therefore use a "qpnp"
> rather than "spmi" prefix to prevent binding until the drivers have been
> updated.

..

> +static void devm_irq_domain_fwnode_release(void *res)
> +{

> +	struct fwnode_handle *fwnode = res;

Unneeded line, can be

static void devm_irq_domain_fwnode_release(void *fwnode)

> +	irq_domain_free_fwnode(fwnode);
> +}

..

> +	dummy = devm_i2c_new_dummy_device(dev, client->adapter, client->addr + 1);
> +	if (IS_ERR(dummy)) {
> +		rc = PTR_ERR(dummy);
> +		dev_err(&client->dev, "failed to claim second address: %d\n", rc);
> +		return rc;

		return dev_err_probe(...);

> +	}

..

> +	name = devm_kasprintf(dev, GFP_KERNEL, "%pOF-internal", dev->of_node);

You are using fwnode for IRQ domain and IRQ domain core uses fwnode, why OF here?

	name = devm_kasprintf(dev, GFP_KERNEL, "%pfw-internal", dev_fwnode(dev));

> +	if (!name)
> +		return -ENOMEM;
> +
> +	name = strreplace(name, '/', ':');

> +	fwnode = irq_domain_alloc_named_fwnode(name);
> +	if (!fwnode)
> +		return -ENOMEM;

..

> +	rc = devm_regmap_add_irq_chip_fwnode(dev, fwnode, regmap, client->irq,
>  				IRQF_SHARED, 0, &pm8008_irq_chip, &irq_data);
> -		if (rc)
> -			dev_err(dev, "failed to add IRQ chip: %d\n", rc);
> +	if (rc) {
> +		dev_err(dev, "failed to add IRQ chip: %d\n", rc);
> +		return rc;

		return dev_err_probe(...);

>  	}

-- 
With Best Regards,
Andy Shevchenko



