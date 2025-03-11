Return-Path: <linux-kernel+bounces-555995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D96A5BF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC143B309A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE3F253B46;
	Tue, 11 Mar 2025 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy0iq12A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142B24EF8E;
	Tue, 11 Mar 2025 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693245; cv=none; b=cIhNh3YdOsogWNnqLJA+87NtS4ajNTp9+QOZu9cE4N0QfALf93SbCjnJ7NILuZPTZw4QWfM5zDDePBGgTmq28Pg21q1h1IurEi66jaKACmYmCk8lrwdjNjAaj63BUbaATkbxmlzzypovzTNzv2KkH9NsO7uTCR0JakWnYz35b5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693245; c=relaxed/simple;
	bh=+uJX8/966KEhOX1GBFyKHP+XMrltWM13u4aR/id8BsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NokI98PtvB5uCux3SZqiOaJ+j8UtyimQG2AAelxxmnGQrU2NVz/hAcViVQBa0CE8pq7lVzIwC0HksCbDMQrV2JWATbC/3YGKICqwbOr1od7nAKEdzLD/EFxEImR4JIYH4lwcRA2Xh7mXU40/t0I4FXky9gjIPCf/+w5oq6mf3Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy0iq12A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A75AC4CEED;
	Tue, 11 Mar 2025 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741693244;
	bh=+uJX8/966KEhOX1GBFyKHP+XMrltWM13u4aR/id8BsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jy0iq12AnsMIgVe3uUuG2Vb0J1re8F3/OPHbboZBhVadT+d8LLPyVgPu3+OPvq8Cs
	 JLxIDkLqdb9IaWCLu+m70qK2fUSL2bq4/txnb06XLgcDdPGPV+O7BOLA0x79LM0fYl
	 AzHVzTCeyZIqvaaVIAkJunkvu6dDI/mfdTDdNKex/rmoCViOgLp6srdnigbmG7THZt
	 lw4NJHxo8tUIJcaUWDryzc6uxC5pVF4idsCDkLi1cDn3metAYhcDT7hh4ZBSpV0c7n
	 fHLlfkNymGAQ9RbRujaTRa3EVVxmdL3aZE3s3hQx2W5zNELFvGGujbXEOLm4NeoWM4
	 tON/JZFSkpOfA==
Date: Tue, 11 Mar 2025 12:40:39 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>, Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH 10/13] phy: airoha: Add support for Airoha AN7581 USB PHY
Message-ID: <Z9AhN9T8s1oogCUn@vaman>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-11-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309132959.19045-11-ansuelsmth@gmail.com>

On 09-03-25, 14:29, Christian Marangi wrote:
> Add support for Airoha AN7581 USB PHY driver. AN7581 supports up to 2
> USB port with USB 2.0 mode always supported and USB 3.0 mode available
> only if the Serdes port is correctly configured for USB 3.0.
> 
> On xLate probe, the Serdes mode is validated and the driver return error
> if the Serdes mode doesn't reflect the expected mode. This is required
> as Serdes mode are controlled by the SCU SSR bits and can be either USB
> 3.0 mode or HSGMII or PCIe 2. In such case USB 3.0 won't work.
> 
> If the USB 3.0 mode is not supported, the modes needs to be also
> disabled in the xHCI node or the driver will report unsable clock and
> fail probe.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/phy/Kconfig                 |   1 +
>  drivers/phy/Makefile                |   3 +-
>  drivers/phy/airoha/Kconfig          |  13 +
>  drivers/phy/airoha/Makefile         |   3 +
>  drivers/phy/airoha/phy-airoha-usb.c | 554 ++++++++++++++++++++++++++++
>  6 files changed, 574 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/phy/airoha/Kconfig
>  create mode 100644 drivers/phy/airoha/Makefile
>  create mode 100644 drivers/phy/airoha/phy-airoha-usb.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2dd385e9165..1835e488ccaa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -758,6 +758,7 @@ M:	Christian Marangi <ansuelsmth@gmail.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yam
> +F:	drivers/phy/airoha/phy-airoha-usb.c
>  
>  AIRSPY MEDIA DRIVER
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 8d58efe998ec..19c9c518fc3d 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -93,6 +93,7 @@ config PHY_NXP_PTN3222
>  	  schemes. It supports all three USB 2.0 data rates: Low Speed, Full
>  	  Speed and High Speed.
>  
> +source "drivers/phy/airoha/Kconfig"
>  source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index e281442acc75..71708c6865b8 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -12,7 +12,8 @@ obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
>  obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
>  obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
>  obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
> -obj-y					+= allwinner/	\
> +obj-y					+= airoha/	\

Directory for a single driver? Also move the PCIe driver in, if you
really want to do this

> +struct airoha_usb_phy_priv {
> +	struct device *dev;
> +
> +	struct regmap *regmap;
> +
> +	unsigned int id;
> +
> +	struct airoha_usb_phy_instance *phys[AIROHA_USB_PHY_MAX_INSTANCE];

No need for empty lines here?

> +static int airoha_usb_phy_u2_slew_rate_calibration(struct airoha_usb_phy_priv *priv)
> +{
> +	u32 fm_out;
> +	u32 srctrl;
> +
> +	/* Enable HS TX SR calibration */
> +	regmap_set_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR5,
> +			AIROHA_USB_PHY_USB20_HSTX_SRCAL_EN);
> +
> +	usleep_range(1000, 1500);
> +
> +	/* Enable Free run clock */
> +	regmap_set_bits(priv->regmap, AIROHA_USB_PHY_FMMONR1,
> +			AIROHA_USB_PHY_FRCK_EN);
> +
> +	/* Select Monitor Clock */
> +	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_FMCR0,
> +			   AIROHA_USB_PHY_MONCLK_SEL,
> +			   priv->id == 0 ? AIROHA_USB_PHY_MONCLK_SEL0 :
> +					   AIROHA_USB_PHY_MONCLK_SEL1);
> +
> +	/* Set cyclecnt */
> +	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_FMCR0,
> +			   AIROHA_USB_PHY_CYCLECNT,
> +			   FIELD_PREP(AIROHA_USB_PHY_CYCLECNT,
> +				      AIROHA_USB_PHY_U2_FM_DET_CYCLE_CNT));
> +
> +	/* Enable Frequency meter */
> +	regmap_set_bits(priv->regmap, AIROHA_USB_PHY_FMCR0,
> +			AIROHA_USB_PHY_FREQDET_EN);
> +
> +	/* Timeout can happen and we will apply workaround at the end */
> +	regmap_read_poll_timeout(priv->regmap, AIROHA_USB_PHY_FMMONR0, fm_out,
> +				 fm_out, AIROHA_USB_PHY_FREQDET_SLEEP,
> +				 AIROHA_USB_PHY_FREQDET_TIMEOUT);
> +
> +	/* Disable Frequency meter */
> +	regmap_clear_bits(priv->regmap, AIROHA_USB_PHY_FMCR0,
> +			  AIROHA_USB_PHY_FREQDET_EN);
> +
> +	/* Disable Free run clock */
> +	regmap_clear_bits(priv->regmap, AIROHA_USB_PHY_FMMONR1,
> +			  AIROHA_USB_PHY_FRCK_EN);
> +
> +	/* Disable HS TX SR calibration */
> +	regmap_clear_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR5,
> +			  AIROHA_USB_PHY_USB20_HSTX_SRCAL_EN);
> +
> +	usleep_range(1000, 1500);
> +
> +	/* Frequency was not detected, use default SR calibration value */
> +	if (!fm_out) {
> +		srctrl = 0x5;

magic?

> +		dev_err(priv->dev, "Frequency not detected, using default SR calibration.\n");
> +	/* (1024 / FM_OUT) * REF_CK * U2_SR_COEF (round to the nearest digits) */
> +	} else {
> +		srctrl = AIROHA_USB_PHY_REF_CK * AIROHA_USB_PHY_U2_SR_COEF;
> +		srctrl = (srctrl * AIROHA_USB_PHY_U2_FM_DET_CYCLE_CNT) / fm_out;
> +		srctrl = DIV_ROUND_CLOSEST(srctrl, AIROHA_USB_PHY_U2_SR_COEF_DIVISOR);
> +		dev_dbg(priv->dev, "SR calibration applied: %x\n", srctrl);
> +	}
> +
> +	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR5,
> +			   AIROHA_USB_PHY_USB20_HSTX_SRCTRL,
> +			   FIELD_PREP(AIROHA_USB_PHY_USB20_HSTX_SRCTRL, srctrl));
> +
> +	return 0;

This is the only return... consider making it void return then?
Here and other places

> +static int airoha_usb_phy_exit(struct phy *phy)
> +{
> +	return 0;
> +}

you can drop this

> +static int airoha_usb_phy_power_on(struct phy *phy)
> +{
> +	struct airoha_usb_phy_instance *instance = phy_get_drvdata(phy);
> +	struct airoha_usb_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
> +
> +	if (instance->type == PHY_TYPE_USB2)
> +		return airoha_usb_phy_u2_power_on(priv);
> +
> +	return airoha_usb_phy_u3_power_on(priv);

for non USB2, you power both why?

> +static int airoha_usb_phy_u2_set_mode(struct airoha_usb_phy_priv *priv,
> +				      enum phy_mode mode)
> +{
> +	u32 val = 0;
> +
> +	/*
> +	 * For Device and Host mode, enable force IDDIG.
> +	 * For Device set IDDIG, for Host clear IDDIG.
> +	 * For OTG disable force and clear IDDIG bit while at it.
> +	 */
> +	switch (mode) {
> +	case PHY_MODE_USB_DEVICE:
> +		val |= AIROHA_USB_PHY_IDDIG;
> +		fallthrough;
> +	case PHY_MODE_USB_HOST:
> +		val |= AIROHA_USB_PHY_FORCE_IDDIG;
> +		break;
> +	case PHY_MODE_USB_OTG:
> +		break;

Not expecting to set this?
-- 
~Vinod

