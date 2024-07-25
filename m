Return-Path: <linux-kernel+bounces-261831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD40093BCB6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52F01C215E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC316D9B7;
	Thu, 25 Jul 2024 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiCzSknb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E263C7;
	Thu, 25 Jul 2024 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721889836; cv=none; b=EnJzCPwHKB/MSrRplYIyfG8yPLwdt83OmsuScQsRhpFFNnV4KB1IGF90ulqVW4a8quFPxexs08p5ojpIfK3636KH6I5r0WZex+D/mohhtT5ix0us4UWuh6ZDZt91UcFRhvWSKjxczmtpHAziF+e28D71mLd0jIUUbGG7B/W2WgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721889836; c=relaxed/simple;
	bh=j5u2RpXt7FLWK3p3uA35Pa2GPE4jCj0dwoVonDkPdqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqn7HqyPBW9TteHI8VLYkCWySMlHRWBFLmTQ30pQB+URHpnKEe4Emoydrude+wK2UvQHO4yT+uWD7heEOMoL2wVn3/qv9QgKYpT9xB7gZf0583TlfgDpn7OX5/IPum0rhik+t/Cq4w5Ti56UpwHXe6ZssZPRrTmXK5CF9BUR6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiCzSknb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A107C116B1;
	Thu, 25 Jul 2024 06:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721889836;
	bh=j5u2RpXt7FLWK3p3uA35Pa2GPE4jCj0dwoVonDkPdqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiCzSknbY+OksEDov3gvjl3Jf5xG355EhKITaXvqrA9kRiJPRUJ4Lio/j4risjF5w
	 qKzetqLt619vnvQUctynXWqPDdMPXu9MRG0r3L3VfzuCrr5Uqsn2jwWpkdqgsxdzLh
	 g8C5n4gYcf4YIk1RuoCqYwBS7q06RUjo3CY8ArrO4GbwWzJmwTwoAf7bVetTylRd4u
	 ccNxoReArFA921fSVLMQNlbznN1BNgSb0o83574kpKvt33yXP7S/Zey+fnAyzTdKit
	 HJfhmqXsbyoMI9VFuNSw8OaMIvKoKzHxa3khZh2osODFUulB33cHi2+dPZAb8jRNtG
	 r4rCtQxoViCdQ==
Date: Thu, 25 Jul 2024 12:13:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Konstantin Porotchkin <kostap@marvell.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC v3 5/6] phy: mvebu-cp110-utmi: add support for
 armada-380 utmi phys
Message-ID: <ZqH0KDVjCILr3A6r@matsya>
References: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
 <20240720-a38x-utmi-phy-v3-5-4c16f9abdbdc@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720-a38x-utmi-phy-v3-5-4c16f9abdbdc@solid-run.com>

On 20-07-24, 16:19, Josua Mayer wrote:
> Armada 380 has similar USB-2.0 PHYs as CP-110. The differences are:
> - register base addresses
> - gap between port registers
> - number of ports: 388 has three, cp110 two
> - device-mode mux bit refers to different ports
> - syscon register's base address (offsets identical)
> - armada-8k uses syscon for various drivers, a38x not
> 
> Differentiation uses of_match_data with distinct compatible strings.
> 
> Add support for Armada 380 PHYs by partially restructuting the driver:
> - Port register pointers are moved to the per-port private data.
> - Add armada-38x-specific compatible string and store enum value in
>   of_match_data for differentiation.
> - Add support for optional regs usb-cfg and utmi-cfg, to be used instead
>   of syscon.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  drivers/phy/marvell/phy-mvebu-cp110-utmi.c | 209 +++++++++++++++++++++++------
>  1 file changed, 166 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
> index 4922a5f3327d..4341923e85bc 100644
> --- a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
> +++ b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
> @@ -19,7 +19,7 @@
>  #include <linux/usb/of.h>
>  #include <linux/usb/otg.h>
>  
> -#define UTMI_PHY_PORTS				2
> +#define UTMI_PHY_PORTS				3
>  
>  /* CP110 UTMI register macro definetions */
>  #define SYSCON_USB_CFG_REG			0x420
> @@ -76,32 +76,44 @@
>  #define PLL_LOCK_DELAY_US			10000
>  #define PLL_LOCK_TIMEOUT_US			1000000
>  
> -#define PORT_REGS(p)				((p)->priv->regs + (p)->id * 0x1000)
> +enum mvebu_cp110_utmi_type {
> +	/* 0 is reserved to avoid clashing with NULL */
> +	A380_UTMI = 1,
> +	CP110_UTMI = 2,
> +};
> +
> +struct mvebu_cp110_utmi_port;

why forward declare and not move the structs instead?

>  
>  /**
>   * struct mvebu_cp110_utmi - PHY driver data
>   *
> - * @regs: PHY registers
> + * @regs_usb: USB configuration register
>   * @syscon: Regmap with system controller registers
>   * @dev: device driver handle
>   * @ops: phy ops
> + * @ports: phy object for each port
>   */
>  struct mvebu_cp110_utmi {
> -	void __iomem *regs;
> +	void __iomem *regs_usb;
>  	struct regmap *syscon;
>  	struct device *dev;
>  	const struct phy_ops *ops;
> +	struct mvebu_cp110_utmi_port *ports[UTMI_PHY_PORTS];
>  };
>  
>  /**
>   * struct mvebu_cp110_utmi_port - PHY port data
>   *
> + * @regs: PHY registers
> + * @regs_cfg: PHY config register
>   * @priv: PHY driver data
>   * @id: PHY port ID
>   * @dr_mode: PHY connection: USB_DR_MODE_HOST or USB_DR_MODE_PERIPHERAL
>   */
>  struct mvebu_cp110_utmi_port {
>  	struct mvebu_cp110_utmi *priv;
> +	void __iomem *regs;
> +	void __iomem *regs_cfg;
>  	u32 id;
>  	enum usb_dr_mode dr_mode;
>  };
> @@ -118,47 +130,47 @@ static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port *port)
>  	 * The crystal used for all platform boards is now 25MHz.
>  	 * See the functional specification for details.
>  	 */
> -	reg = readl(PORT_REGS(port) + UTMI_PLL_CTRL_REG);
> +	reg = readl(port->regs + UTMI_PLL_CTRL_REG);

why not handle this as a preparatory patch for this? Helps in review

>  	reg &= ~(PLL_REFDIV_MASK | PLL_FBDIV_MASK | PLL_SEL_LPFR_MASK);
>  	reg |= (PLL_REFDIV_VAL << PLL_REFDIV_OFFSET) |
>  	       (PLL_FBDIV_VAL << PLL_FBDIV_OFFSET);
> -	writel(reg, PORT_REGS(port) + UTMI_PLL_CTRL_REG);
> +	writel(reg, port->regs + UTMI_PLL_CTRL_REG);
>  
>  	/* Impedance Calibration Threshold Setting */
> -	reg = readl(PORT_REGS(port) + UTMI_CAL_CTRL_REG);
> +	reg = readl(port->regs + UTMI_CAL_CTRL_REG);
>  	reg &= ~IMPCAL_VTH_MASK;
>  	reg |= IMPCAL_VTH_VAL << IMPCAL_VTH_OFFSET;
> -	writel(reg, PORT_REGS(port) + UTMI_CAL_CTRL_REG);
> +	writel(reg, port->regs + UTMI_CAL_CTRL_REG);
>  
>  	/* Set LS TX driver strength coarse control */
> -	reg = readl(PORT_REGS(port) + UTMI_TX_CH_CTRL_REG);
> +	reg = readl(port->regs + UTMI_TX_CH_CTRL_REG);
>  	reg &= ~TX_AMP_MASK;
>  	reg |= TX_AMP_VAL << TX_AMP_OFFSET;
> -	writel(reg, PORT_REGS(port) + UTMI_TX_CH_CTRL_REG);
> +	writel(reg, port->regs + UTMI_TX_CH_CTRL_REG);
>  
>  	/* Disable SQ and enable analog squelch detect */
> -	reg = readl(PORT_REGS(port) + UTMI_RX_CH_CTRL0_REG);
> +	reg = readl(port->regs + UTMI_RX_CH_CTRL0_REG);
>  	reg &= ~SQ_DET_EN;
>  	reg |= SQ_ANA_DTC_SEL;
> -	writel(reg, PORT_REGS(port) + UTMI_RX_CH_CTRL0_REG);
> +	writel(reg, port->regs + UTMI_RX_CH_CTRL0_REG);
>  
>  	/*
>  	 * Set External squelch calibration number and
>  	 * enable the External squelch calibration
>  	 */
> -	reg = readl(PORT_REGS(port) + UTMI_RX_CH_CTRL1_REG);
> +	reg = readl(port->regs + UTMI_RX_CH_CTRL1_REG);
>  	reg &= ~SQ_AMP_CAL_MASK;
>  	reg |= (SQ_AMP_CAL_VAL << SQ_AMP_CAL_OFFSET) | SQ_AMP_CAL_EN;
> -	writel(reg, PORT_REGS(port) + UTMI_RX_CH_CTRL1_REG);
> +	writel(reg, port->regs + UTMI_RX_CH_CTRL1_REG);
>  
>  	/*
>  	 * Set Control VDAT Reference Voltage - 0.325V and
>  	 * Control VSRC Reference Voltage - 0.6V
>  	 */
> -	reg = readl(PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
> +	reg = readl(port->regs + UTMI_CHGDTC_CTRL_REG);
>  	reg &= ~(VDAT_MASK | VSRC_MASK);
>  	reg |= (VDAT_VAL << VDAT_OFFSET) | (VSRC_VAL << VSRC_OFFSET);
> -	writel(reg, PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
> +	writel(reg, port->regs + UTMI_CHGDTC_CTRL_REG);
>  }
>  
>  static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
> @@ -166,22 +178,38 @@ static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
>  	struct mvebu_cp110_utmi_port *port = phy_get_drvdata(phy);
>  	struct mvebu_cp110_utmi *utmi = port->priv;
>  	int i;
> +	int reg;
>  
>  	/* Power down UTMI PHY port */
> -	regmap_clear_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
> -			  UTMI_PHY_CFG_PU_MASK);
> +	if (!IS_ERR(port->regs_cfg)) {
> +		reg = readl(port->regs_cfg);
> +		reg &= ~(UTMI_PHY_CFG_PU_MASK);
> +		writel(reg, port->regs_cfg);
> +	} else
> +		regmap_clear_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
> +				  UTMI_PHY_CFG_PU_MASK);

why are we doing both raw register read/write and regmap ops... that
does not sound correct to me

>  
>  	for (i = 0; i < UTMI_PHY_PORTS; i++) {
> -		int test = regmap_test_bits(utmi->syscon,
> -					    SYSCON_UTMI_CFG_REG(i),
> -					    UTMI_PHY_CFG_PU_MASK);
> +		if (!utmi->ports[i])
> +			continue;
> +
> +		if (!IS_ERR(utmi->ports[i]->regs_cfg))
> +			reg = readl(utmi->ports[i]->regs_cfg);
> +		else
> +			regmap_read(utmi->syscon, SYSCON_UTMI_CFG_REG(i), &reg);
> +		int test = reg & UTMI_PHY_CFG_PU_MASK;
>  		/* skip PLL shutdown if there are active UTMI PHY ports */
>  		if (test != 0)
>  			return 0;
>  	}
>  
>  	/* PLL Power down if all UTMI PHYs are down */
> -	regmap_clear_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
> +	if (!IS_ERR(utmi->regs_usb)) {
> +		reg = readl(utmi->regs_usb);
> +		reg &= ~(USB_CFG_PLL_MASK);
> +		writel(reg, utmi->regs_usb);
> +	} else
> +		regmap_clear_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
>  
>  	return 0;
>  }
> @@ -191,8 +219,15 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
>  	struct mvebu_cp110_utmi_port *port = phy_get_drvdata(phy);
>  	struct mvebu_cp110_utmi *utmi = port->priv;
>  	struct device *dev = &phy->dev;
> +	const void *match;
> +	enum mvebu_cp110_utmi_type type;
>  	int ret;
>  	u32 reg;
> +	u32 sel;
> +
> +	match = device_get_match_data(utmi->dev);
> +	if (match)
> +		type = (enum mvebu_cp110_utmi_type)(uintptr_t)match;
>  
>  	/* It is necessary to power off UTMI before configuration */
>  	ret = mvebu_cp110_utmi_phy_power_off(phy);
> @@ -208,16 +243,45 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
>  	 * to UTMI0 or to UTMI1 PHY port, but not to both.
>  	 */
>  	if (port->dr_mode == USB_DR_MODE_PERIPHERAL) {
> -		regmap_update_bits(utmi->syscon, SYSCON_USB_CFG_REG,
> -				   USB_CFG_DEVICE_EN_MASK | USB_CFG_DEVICE_MUX_MASK,
> -				   USB_CFG_DEVICE_EN_MASK |
> -				   (port->id << USB_CFG_DEVICE_MUX_OFFSET));
> +		switch (type) {
> +		case A380_UTMI:
> +			/*
> +			 * A380 muxes between ports 0/2:
> +			 * - 0: Device mode on Port 2
> +			 * - 1: Device mode on Port 0
> +			 */
> +			if (port->id == 1)
> +				return -EINVAL;
> +			sel = !!(port->id == 0);
> +			break;
> +		case CP110_UTMI:
> +			/*
> +			 * CP110 muxes between ports 0/1:
> +			 * - 0: Device mode on Port 0
> +			 * - 1: Device mode on Port 1
> +			 */
> +			sel = port->id;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		if (!IS_ERR(utmi->regs_usb)) {
> +			reg = readl(utmi->regs_usb);
> +			reg &= ~(USB_CFG_DEVICE_EN_MASK | USB_CFG_DEVICE_MUX_MASK);
> +			reg |= USB_CFG_DEVICE_EN_MASK;
> +			reg |= (sel << USB_CFG_DEVICE_MUX_OFFSET);
> +			writel(reg, utmi->regs_usb);
> +		} else
> +			regmap_update_bits(utmi->syscon, SYSCON_USB_CFG_REG,
> +					   USB_CFG_DEVICE_EN_MASK | USB_CFG_DEVICE_MUX_MASK,
> +					   USB_CFG_DEVICE_EN_MASK |
> +					   (sel << USB_CFG_DEVICE_MUX_OFFSET));
>  	}
>  
>  	/* Set Test suspendm mode and enable Test UTMI select */
> -	reg = readl(PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
> +	reg = readl(port->regs + UTMI_CTRL_STATUS0_REG);
>  	reg |= SUSPENDM | TEST_SEL;
> -	writel(reg, PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
> +	writel(reg, port->regs + UTMI_CTRL_STATUS0_REG);
>  
>  	/* Wait for UTMI power down */
>  	mdelay(1);
> @@ -226,16 +290,21 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
>  	mvebu_cp110_utmi_port_setup(port);
>  
>  	/* Power UP UTMI PHY */
> -	regmap_set_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
> -			UTMI_PHY_CFG_PU_MASK);
> +	if (!IS_ERR(port->regs_cfg)) {
> +		reg = readl(port->regs_cfg);
> +		reg |= UTMI_PHY_CFG_PU_MASK;
> +		writel(reg, port->regs_cfg);
> +	} else
> +		regmap_set_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
> +				UTMI_PHY_CFG_PU_MASK);
>  
>  	/* Disable Test UTMI select */
> -	reg = readl(PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
> +	reg = readl(port->regs + UTMI_CTRL_STATUS0_REG);
>  	reg &= ~TEST_SEL;
> -	writel(reg, PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
> +	writel(reg, port->regs + UTMI_CTRL_STATUS0_REG);
>  
>  	/* Wait for impedance calibration */
> -	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_CAL_CTRL_REG, reg,
> +	ret = readl_poll_timeout(port->regs + UTMI_CAL_CTRL_REG, reg,
>  				 reg & IMPCAL_DONE,
>  				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
>  	if (ret) {
> @@ -244,7 +313,7 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
>  	}
>  
>  	/* Wait for PLL calibration */
> -	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_CAL_CTRL_REG, reg,
> +	ret = readl_poll_timeout(port->regs + UTMI_CAL_CTRL_REG, reg,
>  				 reg & PLLCAL_DONE,
>  				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
>  	if (ret) {
> @@ -253,7 +322,7 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
>  	}
>  
>  	/* Wait for PLL ready */
> -	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_PLL_CTRL_REG, reg,
> +	ret = readl_poll_timeout(port->regs + UTMI_PLL_CTRL_REG, reg,
>  				 reg & PLL_RDY,
>  				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
>  	if (ret) {
> @@ -262,7 +331,12 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
>  	}
>  
>  	/* PLL Power up */
> -	regmap_set_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
> +	if (!IS_ERR(utmi->regs_usb)) {
> +		reg = readl(utmi->regs_usb);
> +		reg |= USB_CFG_PLL_MASK;
> +		writel(reg, utmi->regs_usb);
> +	} else
> +		regmap_set_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
>  
>  	return 0;
>  }
> @@ -274,7 +348,8 @@ static const struct phy_ops mvebu_cp110_utmi_phy_ops = {
>  };
>  
>  static const struct of_device_id mvebu_cp110_utmi_of_match[] = {
> -	{ .compatible = "marvell,cp110-utmi-phy" },
> +	{ .compatible = "marvell,a38x-utmi-phy", .data = (void *)A380_UTMI },
> +	{ .compatible = "marvell,cp110-utmi-phy", .data = (void *)CP110_UTMI },

Cast to void * are not required to be done

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, mvebu_cp110_utmi_of_match);
> @@ -285,6 +360,10 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
>  	struct mvebu_cp110_utmi *utmi;
>  	struct phy_provider *provider;
>  	struct device_node *child;
> +	void __iomem *regs_utmi;
> +	void __iomem *regs_utmi_cfg;
> +	const void *match;
> +	enum mvebu_cp110_utmi_type type;
>  	u32 usb_devices = 0;
>  
>  	utmi = devm_kzalloc(dev, sizeof(*utmi), GFP_KERNEL);
> @@ -293,18 +372,44 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
>  
>  	utmi->dev = dev;
>  
> +	match = device_get_match_data(dev);
> +	if (match)
> +		type = (enum mvebu_cp110_utmi_type)(uintptr_t)match;
> +
> +	/* Get UTMI memory region */
> +	regs_utmi = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs_utmi)) {
> +		dev_err(dev, "Failed to map utmi regs\n");
> +		return PTR_ERR(regs_utmi);
> +	}
> +
> +	/* Get usb config region */
> +	utmi->regs_usb = devm_platform_ioremap_resource_byname(pdev, "usb-cfg");
> +	if (IS_ERR(utmi->regs_usb) && PTR_ERR(utmi->regs_usb) != -EINVAL) {
> +		dev_err(dev, "Failed to map usb config regs\n");
> +		return PTR_ERR(utmi->regs_usb);
> +	}
> +
> +	/* Get utmi config region */
> +	regs_utmi_cfg = devm_platform_ioremap_resource_byname(pdev, "utmi-cfg");
> +	if (IS_ERR(regs_utmi_cfg) && PTR_ERR(regs_utmi_cfg) != -EINVAL) {
> +		dev_err(dev, "Failed to map usb config regs\n");
> +		return PTR_ERR(regs_utmi_cfg);
> +	}
> +
>  	/* Get system controller region */
>  	utmi->syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
>  						       "marvell,system-controller");
> -	if (IS_ERR(utmi->syscon)) {
> -		dev_err(dev, "Missing UTMI system controller\n");
> +	if (IS_ERR(utmi->syscon) && PTR_ERR(utmi->syscon) != -ENODEV) {
> +		dev_err(dev, "Failed to get system controller\n");
>  		return PTR_ERR(utmi->syscon);
>  	}
>  
> -	/* Get UTMI memory region */
> -	utmi->regs = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(utmi->regs))
> -		return PTR_ERR(utmi->regs);
> +	if (IS_ERR(utmi->syscon) &&
> +	    (IS_ERR(utmi->regs_usb) || IS_ERR(regs_utmi_cfg))) {
> +		dev_err(dev, "Missing utmi system controller or config regs");
> +		return -EINVAL;
> +	}
>  
>  	for_each_available_child_of_node(dev->of_node, child) {
>  		struct mvebu_cp110_utmi_port *port;
> @@ -326,6 +431,24 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
>  			return -ENOMEM;
>  		}
>  
> +		utmi->ports[port_id] = port;
> +
> +		/* Get port memory region */
> +		switch (type) {
> +		case A380_UTMI:
> +			port->regs = regs_utmi + port_id * 0x1000;
> +			break;
> +		case CP110_UTMI:
> +			port->regs = regs_utmi + port_id * 0x2000;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		/* assign utmi cfg reg */
> +		if (!IS_ERR(regs_utmi_cfg))
> +			port->regs_cfg = regs_utmi_cfg + port_id * 4;
> +
>  		port->dr_mode = of_usb_get_dr_mode_by_phy(child, -1);
>  		if ((port->dr_mode != USB_DR_MODE_HOST) &&
>  		    (port->dr_mode != USB_DR_MODE_PERIPHERAL)) {
> 
> -- 
> 2.43.0

-- 
~Vinod

