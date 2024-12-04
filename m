Return-Path: <linux-kernel+bounces-431305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667669E3CAB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEFFBB2A906
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1781F707D;
	Wed,  4 Dec 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oXJBhl4+"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349F15E97
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320419; cv=none; b=BFA43iawYThJJkPo1AcWv+wrJ8jj6py6dPM8jXfD/pY9uWsnPpAUELmDCba+ItqGWVOKIn+DACKNnBdpajsQ+lG4dMbMPjnEuVLdVmGKi6YHzfTWRnFrtaFkXSlHPFoHr9Yy5S1y3C9b/ufmloxtFj5TGs4BQ16A2fOFKEL5VqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320419; c=relaxed/simple;
	bh=pGfE1RzcB2ZxZeBdmX+clCPr+9jcwKF8lC4v55m0G5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UWlHO0CEluzFX8jjPPLNNN+ZzvRfOkiAp2FfbUtAeVVGm5SAeoDIT2Al62wx2PyrB0mL13j86VbSiQ4essSH4WAfPzd3tU/ycMSlZRKcNdcG6oqnxh1NLw0+exZrJN3Nh74rt5JD8YVz1ePf6rqzChOFDtMycr2q5/GN4TnP8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oXJBhl4+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B4DrURK117889;
	Wed, 4 Dec 2024 07:53:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733320410;
	bh=S93UvHgh8XYLvPpL89G3ksgsz6hVMnSyaavZSi2WEIk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oXJBhl4+IFQyh0BIhJgtBiKftd725f6hUifdl4g49xbVXIY3vaMyJwFkrpTeh5b1F
	 RdlQBQbdyN8uCvJQn91T2EQNFG225ZV8gFiQY5JJucHzg6X59CszGnDLm+jMoxdP3h
	 m1vJHADrBoge7UE5f1A/COVB1/I4h5DdP986T2gY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B4DrUXs024720;
	Wed, 4 Dec 2024 07:53:30 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Dec 2024 07:53:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Dec 2024 07:53:30 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B4DrUWl001321;
	Wed, 4 Dec 2024 07:53:30 -0600
Message-ID: <d7e9d9f8-ac81-4cbb-897c-585741ca00c9@ti.com>
Date: Wed, 4 Dec 2024 07:53:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mux: mmio: Add suspend and resume support
To: Thomas Richard <thomas.richard@bootlin.com>, Peter Rosin <peda@axentia.se>
CC: <linux-kernel@vger.kernel.org>, <gregory.clement@bootlin.com>,
        <theo.lebrun@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <u-kumar1@ti.com>
References: <20240613-mux-mmio-resume-support-v2-1-e8496099b034@bootlin.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240613-mux-mmio-resume-support-v2-1-e8496099b034@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/11/24 3:53 AM, Thomas Richard wrote:
> The status of each mux is read during suspend and stored in the private
> memory of the mux_chip.
> Then the state is restored during the resume.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
> In this second version, as discussed with Peter, everything is done in the
> mmio-mux driver.
> A mux_mmio_set() function was added, and used during suspend stage to get
> the status of the of the muxes.
> This status is stored in the private memory of the mux_chip.
> ---
> Changes in v2:
> - Remove all modifications done in the mux subsystem
> - Add a mux_mmio_set()
> - Read the status of muxes during suspend and store in the private memory
>    of the mux_chip.

Do you need this private memory? Since this is already using regmap, why
not use the regmap cache, then you can restore all the values on resume
with a simple call to regcache_sync().

Andrew

> - Use this status to restore muxes during resume.
> - Link to v1: https://lore.kernel.org/r/20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com
> ---
>   drivers/mux/mmio.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 73 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
> index 30a952c34365..30b84382637f 100644
> --- a/drivers/mux/mmio.c
> +++ b/drivers/mux/mmio.c
> @@ -15,11 +15,25 @@
>   #include <linux/property.h>
>   #include <linux/regmap.h>
>   
> +struct mux_mmio {
> +	struct regmap_field **fields;
> +	unsigned int *hardware_states;
> +};
> +
> +static int mux_mmio_get(struct mux_control *mux, int *state)
> +{
> +	struct mux_mmio *mux_mmio = mux_chip_priv(mux->chip);
> +	unsigned int index = mux_control_get_index(mux);
> +
> +	return regmap_field_read(mux_mmio->fields[index], state);
> +}
> +
>   static int mux_mmio_set(struct mux_control *mux, int state)
>   {
> -	struct regmap_field **fields = mux_chip_priv(mux->chip);
> +	struct mux_mmio *mux_mmio = mux_chip_priv(mux->chip);
> +	unsigned int index = mux_control_get_index(mux);
>   
> -	return regmap_field_write(fields[mux_control_get_index(mux)], state);
> +	return regmap_field_write(mux_mmio->fields[index], state);
>   }
>   
>   static const struct mux_control_ops mux_mmio_ops = {
> @@ -37,8 +51,8 @@ static int mux_mmio_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
> -	struct regmap_field **fields;
>   	struct mux_chip *mux_chip;
> +	struct mux_mmio *mux_mmio;
>   	struct regmap *regmap;
>   	int num_fields;
>   	int ret;
> @@ -69,12 +83,20 @@ static int mux_mmio_probe(struct platform_device *pdev)
>   	}
>   	num_fields = ret / 2;
>   
> -	mux_chip = devm_mux_chip_alloc(dev, num_fields, num_fields *
> -				       sizeof(*fields));
> +	mux_chip = devm_mux_chip_alloc(dev, num_fields, sizeof(struct mux_mmio));
>   	if (IS_ERR(mux_chip))
>   		return PTR_ERR(mux_chip);
>   
> -	fields = mux_chip_priv(mux_chip);
> +	mux_mmio = mux_chip_priv(mux_chip);
> +
> +	mux_mmio->fields = devm_kmalloc(dev, num_fields * sizeof(*mux_mmio->fields), GFP_KERNEL);
> +	if (IS_ERR(mux_mmio->fields))
> +		return PTR_ERR(mux_mmio->fields);
> +
> +	mux_mmio->hardware_states = devm_kmalloc(dev, num_fields *
> +						 sizeof(*mux_mmio->hardware_states), GFP_KERNEL);
> +	if (IS_ERR(mux_mmio->hardware_states))
> +		return PTR_ERR(mux_mmio->hardware_states);
>   
>   	for (i = 0; i < num_fields; i++) {
>   		struct mux_control *mux = &mux_chip->mux[i];
> @@ -104,9 +126,9 @@ static int mux_mmio_probe(struct platform_device *pdev)
>   			return -EINVAL;
>   		}
>   
> -		fields[i] = devm_regmap_field_alloc(dev, regmap, field);
> -		if (IS_ERR(fields[i])) {
> -			ret = PTR_ERR(fields[i]);
> +		mux_mmio->fields[i] = devm_regmap_field_alloc(dev, regmap, field);
> +		if (IS_ERR(mux_mmio->fields[i])) {
> +			ret = PTR_ERR(mux_mmio->fields[i]);
>   			dev_err(dev, "bitfield %d: failed allocate: %d\n",
>   				i, ret);
>   			return ret;
> @@ -130,13 +152,55 @@ static int mux_mmio_probe(struct platform_device *pdev)
>   
>   	mux_chip->ops = &mux_mmio_ops;
>   
> +	dev_set_drvdata(dev, mux_chip);
> +
>   	return devm_mux_chip_register(dev, mux_chip);
>   }
>   
> +static int mux_mmio_suspend_noirq(struct device *dev)
> +{
> +	struct mux_chip *mux_chip = dev_get_drvdata(dev);
> +	struct mux_mmio *mux_mmio = mux_chip_priv(mux_chip);
> +	unsigned int state;
> +	int ret, i;
> +
> +	for (i = 0; i < mux_chip->controllers; i++) {
> +		ret = mux_mmio_get(&mux_chip->mux[i], &state);
> +		if (ret) {
> +			dev_err(dev, "control %u: error saving mux: %d\n", i, ret);
> +			return ret;
> +		}
> +
> +		mux_mmio->hardware_states[i] = state;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mux_mmio_resume_noirq(struct device *dev)
> +{
> +	struct mux_chip *mux_chip = dev_get_drvdata(dev);
> +	struct mux_mmio *mux_mmio = mux_chip_priv(mux_chip);
> +	int ret, i;
> +
> +	for (i = 0; i < mux_chip->controllers; i++) {
> +		ret = mux_mmio_set(&mux_chip->mux[i], mux_mmio->hardware_states[i]);
> +		if (ret) {
> +			dev_err(dev, "control %u: error restoring mux: %d\n", i, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_NOIRQ_DEV_PM_OPS(mux_mmio_pm_ops, mux_mmio_suspend_noirq, mux_mmio_resume_noirq);
> +
>   static struct platform_driver mux_mmio_driver = {
>   	.driver = {
>   		.name = "mmio-mux",
>   		.of_match_table	= mux_mmio_dt_ids,
> +		.pm = pm_sleep_ptr(&mux_mmio_pm_ops),
>   	},
>   	.probe = mux_mmio_probe,
>   };
> 
> ---
> base-commit: caf614bf68351c7e9e38dd37e07539417c757813
> change-id: 20240613-mux-mmio-resume-support-4f3b2a34a32a
> 
> Best regards,

