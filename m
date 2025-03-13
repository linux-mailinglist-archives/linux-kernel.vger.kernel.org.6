Return-Path: <linux-kernel+bounces-559585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC819A5F5DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCC71884ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFBF267721;
	Thu, 13 Mar 2025 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBtA0e4Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABF265610;
	Thu, 13 Mar 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872043; cv=none; b=C6Hp83h/ZJq6kS5smgXZ91ETzhNdSIm2DqTycDpzxUeY93GpOZ8jU+2ra+Qp+cFgNnr9+gFrZbNDpXVmH/z9ijiTYWXV5nIbhmzYHUNLVVRie6lw+iajmFO8WZhCgW4glHztFDvgWaaU5cUtPu1zfA04XdfElclUA9288Ae9ETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872043; c=relaxed/simple;
	bh=7sLRPlPMdxJhpz09Z2Z7FAiXZqSpH6scXcJJzy6jD6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt/EKdcokMf8Q0li4YThGGNJfU096YxQpdGb5eoBbn3TuRknCHctF65t/BvPWwWQMZroZVRpyHXD23BYygzatLampCzEjM2ubX/MMLRCRSrlf1ViXaLQDZybG3oa6KWqW6Vr1qgsSxcFRK2m5w/E/k27USGa3eTfZ9SRNCRIqWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBtA0e4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC62EC4CEE5;
	Thu, 13 Mar 2025 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741872041;
	bh=7sLRPlPMdxJhpz09Z2Z7FAiXZqSpH6scXcJJzy6jD6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBtA0e4YOEjcIza/D/OQhLriwtnpU6IR3sxl+1DAQ+cHYTn77DmxnxinkMlGg/TBR
	 hhbQha4y9eqMBmMseUhJrkzkbqzsvsDaEkeMLCr3Q4MvR60adtKrFyaxUrM7khRj9F
	 UnGbBm+jALy6kuskJ3iSySuxDxb3ZMrX8AxddDinr2wKFDnrE5Da2+R/YqX3VHND6A
	 splMA/3ogKPO5qR2j6ifCvSPWBTMZ2w7Ytx7njAiS+vaTzjo6dZgs1p/1UDcorCSjT
	 n7abIhzeOS3hVMURteAiU88Z2QtloTx53jyL6PYXjzfHzEC8X6acvjkBTRXV09uby/
	 SMpmUw7/RMIxw==
Date: Thu, 13 Mar 2025 13:20:36 +0000
From: Lee Jones <lee@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 06/10] mfd: bcm590xx: Add PMU ID/revision parsing
 function
Message-ID: <20250313132036.GB3616286@google.com>
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
 <20250304-bcm59054-v6-6-ae8302358443@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304-bcm59054-v6-6-ae8302358443@gmail.com>

On Tue, 04 Mar 2025, Artur Weber wrote:

> The BCM590xx PMUs have two I2C registers for reading the PMU ID
> and revision. The revision is useful for subdevice drivers, since
> different revisions may have slight differences in behavior (for
> example - BCM59054 has different regulator configurations for
> revision A0 and A1).
> 
> Check the PMU ID register and make sure it matches the DT compatible.
> Fetch the digital and analog revision from the PMUREV register
> so that it can be used in subdevice drivers.
> 
> Also add some known revision values to bcm590xx.h, for convenience
> when writing subdevice drivers.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v6:
> - Adapt to PMUID being passed as device type value
> - Rename rev_dig and rev_ana to rev_digital and rev_analog
> - Rewrite commit message
> 
> Changes in v5:
> - Add REG_ prefix to register offset constant names
> 
> Changes in v4:
> - Added this commit
> ---
>  drivers/mfd/bcm590xx.c       | 63 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/bcm590xx.h | 14 ++++++++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
> index 4620eed0066fbf1dd691a2e392e967747b4d125b..74dc4ae5ecd5db7fadc56918f63110c1265d4a76 100644
> --- a/drivers/mfd/bcm590xx.c
> +++ b/drivers/mfd/bcm590xx.c
> @@ -17,6 +17,15 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> +/* Under primary I2C address: */
> +#define BCM590XX_REG_PMUID		0x1e
> +
> +#define BCM590XX_REG_PMUREV		0x1f
> +#define BCM590XX_PMUREV_DIG_MASK	0xF
> +#define BCM590XX_PMUREV_DIG_SHIFT	0
> +#define BCM590XX_PMUREV_ANA_MASK	0xF0
> +#define BCM590XX_PMUREV_ANA_SHIFT	4
> +
>  static const struct mfd_cell bcm590xx_devs[] = {
>  	{
>  		.name = "bcm590xx-vregs",
> @@ -37,6 +46,56 @@ static const struct regmap_config bcm590xx_regmap_config_sec = {
>  	.cache_type	= REGCACHE_MAPLE,
>  };
>  
> +/* Map PMU ID value to model name string */
> +static const char * const bcm590xx_names[] = {
> +	[BCM590XX_PMUID_BCM59054] = "BCM59054",
> +	[BCM590XX_PMUID_BCM59056] = "BCM59056",
> +};
> +
> +/*
> + * Parse the version from version registers and make sure it matches
> + * the device type passed to the compatible.
> + */
> +static int bcm590xx_parse_version(struct bcm590xx *bcm590xx)
> +{
> +	unsigned int id, rev;
> +	int ret;
> +
> +	/* Get PMU ID and verify that it matches compatible */
> +	ret = regmap_read(bcm590xx->regmap_pri, BCM590XX_REG_PMUID, &id);
> +	if (ret) {
> +		dev_err(bcm590xx->dev, "failed to read PMU ID: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (id != bcm590xx->pmu_id) {
> +		dev_err(bcm590xx->dev,
> +			"Incorrect ID for %s: expected %x, got %x. Check your DT compatible.\n",

Isn't it more likely that the H/W this is being executed on is
unsupported?  If so, say that instead.

> +			bcm590xx_names[bcm590xx->pmu_id], bcm590xx->pmu_id, id);
> +		return -EINVAL;

-ENODEV

> +	}
> +
> +	/* Get PMU revision and store it in the info struct */
> +	ret = regmap_read(bcm590xx->regmap_pri, BCM590XX_REG_PMUREV, &rev);
> +	if (ret) {
> +		dev_err(bcm590xx->dev, "failed to read PMU revision: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	bcm590xx->rev_digital = (rev & BCM590XX_PMUREV_DIG_MASK)
> +				     >> BCM590XX_PMUREV_DIG_SHIFT;
> +
> +	bcm590xx->rev_analog = (rev & BCM590XX_PMUREV_ANA_MASK)
> +				    >> BCM590XX_PMUREV_ANA_SHIFT;
> +
> +	dev_info(bcm590xx->dev, "PMU ID 0x%x (%s), revision: digital %d, analog %d",
> +		 id, bcm590xx_names[id],
> +		 bcm590xx->rev_digital, bcm590xx->rev_analog);
> +
> +	return 0;
> +}
> +
>  static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
>  {
>  	struct bcm590xx *bcm590xx;
> @@ -78,6 +137,10 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
>  		goto err;
>  	}
>  
> +	ret = bcm590xx_parse_version(bcm590xx);
> +	if (ret)
> +		goto err;
> +
>  	ret = devm_mfd_add_devices(&i2c_pri->dev, -1, bcm590xx_devs,
>  				   ARRAY_SIZE(bcm590xx_devs), NULL, 0, NULL);
>  	if (ret < 0) {
> diff --git a/include/linux/mfd/bcm590xx.h b/include/linux/mfd/bcm590xx.h
> index 8d146e3b102a7dbce6f4dbab9f8ae5a9c4e68c0e..fbc458e94bef923ca1b69afe2cac944adf6fedf8 100644
> --- a/include/linux/mfd/bcm590xx.h
> +++ b/include/linux/mfd/bcm590xx.h
> @@ -17,6 +17,16 @@
>  #define BCM590XX_PMUID_BCM59054		0x54
>  #define BCM590XX_PMUID_BCM59056		0x56
>  
> +/* Known chip revision IDs */
> +#define BCM59054_REV_DIGITAL_A1		1
> +#define BCM59054_REV_ANALOG_A1		2
> +
> +#define BCM59056_REV_DIGITAL_A0		1
> +#define BCM59056_REV_ANALOG_A0		1
> +
> +#define BCM59056_REV_DIGITAL_B0		2
> +#define BCM59056_REV_ANALOG_B0		2
> +
>  /* max register address */
>  #define BCM590XX_MAX_REGISTER_PRI	0xe7
>  #define BCM590XX_MAX_REGISTER_SEC	0xf0
> @@ -30,6 +40,10 @@ struct bcm590xx {
>  
>  	/* PMU ID value; also used as device type */
>  	u8 pmu_id;
> +
> +	/* Chip revision, read from PMUREV reg */
> +	u8 rev_digital;
> +	u8 rev_analog;
>  };
>  
>  #endif /*  __LINUX_MFD_BCM590XX_H */
> 
> -- 
> 2.48.1
> 

-- 
Lee Jones [李琼斯]

