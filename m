Return-Path: <linux-kernel+bounces-536964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E963EA48677
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B105A163AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B81D6DA8;
	Thu, 27 Feb 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUJKMZIu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE51ABEC5;
	Thu, 27 Feb 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676633; cv=none; b=ZHyXNK6avxwyYvrJuOEG4527tQ8MsBZR4kv0N0CI7xfXpfeHK5smqx0dh3TC4vgR0xKdf7x1S4V88rk7ilpa3Zn977Jn9Aj5N0FmTRuvS+oT7NPq2kt3cumYtsueVYiIQQMZ1hMdfCGrpAH1rO8lZh3uSUSdDygpqBWxh6zgzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676633; c=relaxed/simple;
	bh=KsQcP8nvAWGmzJyCA6JwZ7xNhP2Lrxd4hs+4HIMnZYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLEjs7hBxyAO8g+fh1/nKQzWjSSSX+E54ynkga2dttxMI4z2gM21fwAJiXeS4USMM5YielXPVuRGKN++A5Bnj3zML/tttA6lHVrPxEicxAXtgCSJk/G39TTt8c33SkK8oL0xyBbfhPrbmp1kkmTlr4xKI6ChbVSSMATGZIeBAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUJKMZIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCE9C4CEDD;
	Thu, 27 Feb 2025 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740676632;
	bh=KsQcP8nvAWGmzJyCA6JwZ7xNhP2Lrxd4hs+4HIMnZYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUJKMZIuxmsG4nPgdOWJafa8UsgOnhsRVEF7jfhWn5r54BdR4PmkKglz0LgtjWYxc
	 ZzGNDpjy46UdTJ9jjaMXLvzeotFHLhvoVCoYJhX4hEVc6XuvQqrPmuGTQo5U76AZMc
	 FbG3WPK7VkxmyiTf3w+9oLrx9W85znahErMVXEMv+8dt/f0/5IVbSW6H6D0iuG6kKY
	 RmCuL4LNffqZHJcgyLAALJSdwBQ0V7TXiRehxEDYp2s3kCwFD1cxvJf3XXXJ3lI9ZR
	 1KagSeW/QTK+M/WyoVUqkawXTuD6Np/WT8hvvg7n5wM3xLoQmSQkgvLbi1LVjhnpoc
	 hvwEuycC4L60Q==
Date: Thu, 27 Feb 2025 17:17:06 +0000
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
Subject: Re: [PATCH v5 5/9] mfd: bcm590xx: Add PMU ID/revision parsing
 function
Message-ID: <20250227171706.GH824852@google.com>
References: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
 <20250221-bcm59054-v5-5-065f516a9042@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221-bcm59054-v5-5-065f516a9042@gmail.com>

On Fri, 21 Feb 2025, Artur Weber wrote:

> The BCM590xx PMUs have two I2C registers for reading the PMU ID
> and revision. The revision is useful for subdevice drivers, since
> different revisions may have slight differences in behavior.
> 
> Add a function to parse the data contained in the ID/revision
> registers. Use the ID value to verify that the correct compatible is
> used; store the revision value as two separate variables, rev_dig
> and rev_ana, for later usage.
> 
> Also add some known revision values to bcm590xx.h, for convenience
> when writing subdevice drivers.

This is a very odd commit message.  Did someone tell you to improve upon
a previous one?  This goes into too much detail about how the code
works.  Instead, you should state what you're doing and why it's
required i.e. what you're using it for.  Pitch it at a mid to high
level.

> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v5:
> - Add REG_ prefix to register offset constant names
> 
> Changes in v4:
> - Added this commit
> ---
>  drivers/mfd/bcm590xx.c       | 81 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/bcm590xx.h | 14 ++++++++
>  2 files changed, 95 insertions(+)
> 
> diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
> index 632eb57d0d9e9f20f801fac22eae21b3c46cefd5..6e53cf3dbf54636faab635634a31e9e36827cece 100644
> --- a/drivers/mfd/bcm590xx.c
> +++ b/drivers/mfd/bcm590xx.c
> @@ -17,6 +17,17 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> +/* Under primary I2C address: */
> +#define BCM590XX_REG_PMUID		0x1e
> +#define BCM590XX_PMUID_BCM59054		0x54
> +#define BCM590XX_PMUID_BCM59056		0x56
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
> @@ -37,6 +48,72 @@ static const struct regmap_config bcm590xx_regmap_config_sec = {
>  	.cache_type	= REGCACHE_MAPLE,
>  };
>  
> +/* Map device_type enum value to model name string */

This needs updating now.

> +static const char * const bcm590xx_names[BCM590XX_TYPE_MAX] = {
> +	[BCM59054_TYPE] = "BCM59054",
> +	[BCM59056_TYPE] = "BCM59056",
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
> +	switch (bcm590xx->dev_type) {
> +	case BCM59054_TYPE:
> +		if (id != BCM590XX_PMUID_BCM59054) {
> +			dev_err(bcm590xx->dev,
> +				"Incorrect ID for BCM59054: expected %x, got %x. Check your DT compatible.\n",
> +				BCM590XX_PMUID_BCM59054, id);
> +			return -EINVAL;
> +		}
> +		break;
> +	case BCM59056_TYPE:
> +		if (id != BCM590XX_PMUID_BCM59056) {
> +			dev_err(bcm590xx->dev,
> +				"Incorrect ID for BCM59056: expected %x, got %x. Check your DT compatible.\n",
> +				BCM590XX_PMUID_BCM59056, id);
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		dev_err(bcm590xx->dev,
> +			"Unknown device type, this is a driver bug!\n");
> +		return -EINVAL;
> +	}

This is a highly inefficient means by which to test the device type.

Why not just use BCM590XX_PMUID_BCM59054 in bcm590xx_dev_type?  Then
this boils down to just a single if () statement.

> +	/* Get PMU revision and store it in the info struct */
> +	ret = regmap_read(bcm590xx->regmap_pri, BCM590XX_REG_PMUREV, &rev);
> +	if (ret) {
> +		dev_err(bcm590xx->dev, "failed to read PMU revision: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	bcm590xx->rev_dig = (rev & BCM590XX_PMUREV_DIG_MASK)
> +				 >> BCM590XX_PMUREV_DIG_SHIFT;
> +
> +	bcm590xx->rev_ana = (rev & BCM590XX_PMUREV_ANA_MASK)
> +				 >> BCM590XX_PMUREV_ANA_SHIFT;

What is 'dig' and 'ana'?  Digital and analogue?

Variables should have suitable nomenclature that prevents confusion and ambiguity.

> +	dev_info(bcm590xx->dev, "PMU ID 0x%x (%s), revision: dig %d ana %d",

Poor nomenclature 
> +		 id, bcm590xx_names[bcm590xx->dev_type],
> +		 bcm590xx->rev_dig, bcm590xx->rev_ana);
> +
> +	return 0;
> +}
> +
>  static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
>  {
>  	struct bcm590xx *bcm590xx;
> @@ -78,6 +155,10 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
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
> index 83e62b5a6c45805bc2acc88ccc7119d86f9ac424..ba1cb3716b383d7a2ee396e0595a3b94d3b4ca5e 100644
> --- a/include/linux/mfd/bcm590xx.h
> +++ b/include/linux/mfd/bcm590xx.h
> @@ -32,6 +32,20 @@ struct bcm590xx {
>  	struct regmap *regmap_pri;
>  	struct regmap *regmap_sec;
>  	unsigned int id;
> +
> +	/* Chip revision, read from PMUREV reg */
> +	u8 rev_dig;
> +	u8 rev_ana;
>  };
>  
> +/* Known chip revision IDs */
> +#define BCM59054_REV_DIG_A1		1
> +#define BCM59054_REV_ANA_A1		2
> +
> +#define BCM59056_REV_DIG_A0		1
> +#define BCM59056_REV_ANA_A0		1
> +
> +#define BCM59056_REV_DIG_B0		2
> +#define BCM59056_REV_ANA_B0		2

Where are these used?

>  #endif /*  __LINUX_MFD_BCM590XX_H */
> 
> -- 
> 2.48.1
> 

-- 
/Lee Jones [李琼斯]

