Return-Path: <linux-kernel+bounces-262078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134FF93C086
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B981C21A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877C21991C2;
	Thu, 25 Jul 2024 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQZq/HxD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCADA176233;
	Thu, 25 Jul 2024 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905413; cv=none; b=hR6vDFtjAUucmuBay6Txavyd4IVKrMMWyzDLCH/cD9OTmWd5qq6kXQzt5k2eYQ4bw5qUE6CbI8Es09UTCxQUjVW8CTFT9HjYWc+chnkrUL03OnES46ZORNfFPpEULr9mNvIF/x3BgIeaEzMgOBudkAcqE22dJsKA56VyxL5ILgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905413; c=relaxed/simple;
	bh=RCVBCoKT1vSGM8CC/3jXNwaZrAHFv8eiwDk/Yatez5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5svVHvB82pWJUED/+tKS5GlnXAA2ByiIrWR88pG6gYDDOgTBwwiRlnWRJjet/Ol+25gUkukw9pa6E2dg9r0/JutmDclWtJX7yLVMr45N8exG9YQSBn3X/lVY5M5EmiymeqSWCorQbEUHxLUILHqkBMvdbSmwtvOITHjfazN2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQZq/HxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852EEC116B1;
	Thu, 25 Jul 2024 11:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721905413;
	bh=RCVBCoKT1vSGM8CC/3jXNwaZrAHFv8eiwDk/Yatez5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQZq/HxDlxXi454xs8++s7E0GK+Or3EhCt84LW+1FAh+0XxXIyzXpdvMhUaz05Erg
	 eU/3VZZAPv7mYiJp9rp7QkovXV121b8w/u1gYV64LcuUMRDYmW8VnS6PrynN9x6Mwn
	 CupjHgtyI+1rgpnqCsAIFzwIiZ6aiW5kW0PUGS5mESDLkSb/hSsPjZVrIBNF2TZWwU
	 HyOFwiVJ4kEECUa9/nTk8KRTOEIdVXWt+aAXxtGU1tJkRfRKC6PxCI9m/HCwejrsA9
	 eSvpRIT+dFjOtf3eqLcKmurZySnkFiCIJoRkJfkplOSQNsj/uN7s9M5vNCIh7x4Ybt
	 jl9jC+hOjmu+w==
Date: Thu, 25 Jul 2024 16:33:29 +0530
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
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC v3 5/6] phy: mvebu-cp110-utmi: add support for
 armada-380 utmi phys
Message-ID: <ZqIxAf2yPL32HLaP@matsya>
References: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
 <20240720-a38x-utmi-phy-v3-5-4c16f9abdbdc@solid-run.com>
 <ZqH0KDVjCILr3A6r@matsya>
 <f4835ad8-08c1-49f0-ae85-4f870ad90a8e@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4835ad8-08c1-49f0-ae85-4f870ad90a8e@solid-run.com>

On 25-07-24, 08:38, Josua Mayer wrote:
> Am 25.07.24 um 08:43 schrieb Vinod Koul:
> > On 20-07-24, 16:19, Josua Mayer wrote:

> >> +struct mvebu_cp110_utmi_port;
> > why forward declare and not move the structs instead?
> Seemed like the smaller change / more readable as diff.
> I can move the struct instead!

Yes and that can be preparatory as well :-)
 
> >
> >>  	reg &= ~(PLL_REFDIV_MASK | PLL_FBDIV_MASK | PLL_SEL_LPFR_MASK);
> >>  	reg |= (PLL_REFDIV_VAL << PLL_REFDIV_OFFSET) |
> >>  	       (PLL_FBDIV_VAL << PLL_FBDIV_OFFSET);
> >> -	writel(reg, PORT_REGS(port) + UTMI_PLL_CTRL_REG);
> >> +	writel(reg, port->regs + UTMI_PLL_CTRL_REG);
> >>  
> >>  	/* Impedance Calibration Threshold Setting */
> >> -	reg = readl(PORT_REGS(port) + UTMI_CAL_CTRL_REG);
> >> +	reg = readl(port->regs + UTMI_CAL_CTRL_REG);
> >>  	reg &= ~IMPCAL_VTH_MASK;
> >>  	reg |= IMPCAL_VTH_VAL << IMPCAL_VTH_OFFSET;
> >> -	writel(reg, PORT_REGS(port) + UTMI_CAL_CTRL_REG);
> >> +	writel(reg, port->regs + UTMI_CAL_CTRL_REG);
> >>  
> >>  	/* Set LS TX driver strength coarse control */
> >> -	reg = readl(PORT_REGS(port) + UTMI_TX_CH_CTRL_REG);
> >> +	reg = readl(port->regs + UTMI_TX_CH_CTRL_REG);
> >>  	reg &= ~TX_AMP_MASK;
> >>  	reg |= TX_AMP_VAL << TX_AMP_OFFSET;
> >> -	writel(reg, PORT_REGS(port) + UTMI_TX_CH_CTRL_REG);
> >> +	writel(reg, port->regs + UTMI_TX_CH_CTRL_REG);
> >>  
> >>  	/* Disable SQ and enable analog squelch detect */
> >> -	reg = readl(PORT_REGS(port) + UTMI_RX_CH_CTRL0_REG);
> >> +	reg = readl(port->regs + UTMI_RX_CH_CTRL0_REG);
> >>  	reg &= ~SQ_DET_EN;
> >>  	reg |= SQ_ANA_DTC_SEL;
> >> -	writel(reg, PORT_REGS(port) + UTMI_RX_CH_CTRL0_REG);
> >> +	writel(reg, port->regs + UTMI_RX_CH_CTRL0_REG);
> >>  
> >>  	/*
> >>  	 * Set External squelch calibration number and
> >>  	 * enable the External squelch calibration
> >>  	 */
> >> -	reg = readl(PORT_REGS(port) + UTMI_RX_CH_CTRL1_REG);
> >> +	reg = readl(port->regs + UTMI_RX_CH_CTRL1_REG);
> >>  	reg &= ~SQ_AMP_CAL_MASK;
> >>  	reg |= (SQ_AMP_CAL_VAL << SQ_AMP_CAL_OFFSET) | SQ_AMP_CAL_EN;
> >> -	writel(reg, PORT_REGS(port) + UTMI_RX_CH_CTRL1_REG);
> >> +	writel(reg, port->regs + UTMI_RX_CH_CTRL1_REG);
> >>  
> >>  	/*
> >>  	 * Set Control VDAT Reference Voltage - 0.325V and
> >>  	 * Control VSRC Reference Voltage - 0.6V
> >>  	 */
> >> -	reg = readl(PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
> >> +	reg = readl(port->regs + UTMI_CHGDTC_CTRL_REG);
> >>  	reg &= ~(VDAT_MASK | VSRC_MASK);
> >>  	reg |= (VDAT_VAL << VDAT_OFFSET) | (VSRC_VAL << VSRC_OFFSET);
> >> -	writel(reg, PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
> >> +	writel(reg, port->regs + UTMI_CHGDTC_CTRL_REG);
> >>  }
> >>  
> >>  static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
> >> @@ -166,22 +178,38 @@ static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
> >>  	struct mvebu_cp110_utmi_port *port = phy_get_drvdata(phy);
> >>  	struct mvebu_cp110_utmi *utmi = port->priv;
> >>  	int i;
> >> +	int reg;
> >>  
> >>  	/* Power down UTMI PHY port */
> >> -	regmap_clear_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
> >> -			  UTMI_PHY_CFG_PU_MASK);
> >> +	if (!IS_ERR(port->regs_cfg)) {
> >> +		reg = readl(port->regs_cfg);
> >> +		reg &= ~(UTMI_PHY_CFG_PU_MASK);
> >> +		writel(reg, port->regs_cfg);
> >> +	} else
> >> +		regmap_clear_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
> >> +				  UTMI_PHY_CFG_PU_MASK);
> > why are we doing both raw register read/write and regmap ops... that
> > does not sound correct to me
> Indeed.
> 
> The next question would be why for Armada 8K / CP110 syscon was chosen.
> From what I could find the registers accessed by utmi driver
> are not accessed by other drivers.
> 
> I am adding raw register access as an alternative,
> 
> to keep supporting old device-tree specifying syscon handle.
> 
> I considered writing helper functions for the if-not-error-syscon-else-raw,
> but between set_bits, clear_bits, global and per-port regs
> would have ended up with too many.

Aha, please add the comment so we know why it was done like this few
years later

-- 
~Vinod

