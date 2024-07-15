Return-Path: <linux-kernel+bounces-252927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F3C9319FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3101F2342E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F361FC5;
	Mon, 15 Jul 2024 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CKpW3p5q"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481A33987;
	Mon, 15 Jul 2024 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066729; cv=none; b=uGUl1E6RHeYUV1ADKukmdm2q47JGIBGHz3O7pBB8O9QL+Z5688gVuRvdli2nA5WmJ/s7P/6Ciet3vxZBTo6ZO5j0a0dxbI9IWlxIf2K2UQeIw8w7ieDD/uIKBDk6ue1n3YcJvsYCBjephvdzKadAPV+nDc5MRCxUUNpzPMLNpow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066729; c=relaxed/simple;
	bh=KraVWH9h2oC0iidUG8sGF//wwgQ2nyOKlC7IXhuh50Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bURwPOAo2V2625NSs/+rN78rWaRtN8tt10RoiSpr32v/SLt/MT/dTbXIriILcRPomKirvLAxx971cZxiL9KWs74y0M4mbqrBWqjFnkXQbpkmxfqpXGIxw5BxFRhOPCVZAN0ELtIFZhibuUokMF4SlnUe3+5Z0iPGJWJTS47m424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CKpW3p5q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pqHqXcd4plsh9mCkPXR2+UXnLFjsClDH5v3E0JBOoQE=; b=CKpW3p5q4tsnCI3dVKqNYaso+S
	mVRZ3Vkg+Kz7cAUwxYVtehoLS2I7YT0yFtxmiTswRrcp7iXBDzqEvxgphA19KEvgLU/gqbs8UKMtr
	gI+OlZP5Eclswf+dFVRqWFcuy8ZbTGILQ2LP9aUxQ8zpMjeeDW3ZPQEt4NLUetc9WiAU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sTQ4S-002aUF-RA; Mon, 15 Jul 2024 20:05:08 +0200
Date: Mon, 15 Jul 2024 20:05:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] phy: mvebu-cp110-utmi: add support for
 armada-380 utmi phys
Message-ID: <837de973-0a58-4a07-a126-43445bfa7721@lunn.ch>
References: <20240715-a38x-utmi-phy-v1-0-d57250f53cf2@solid-run.com>
 <20240715-a38x-utmi-phy-v1-1-d57250f53cf2@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-a38x-utmi-phy-v1-1-d57250f53cf2@solid-run.com>

> @@ -191,8 +196,15 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
>  	struct mvebu_cp110_utmi_port *port = phy_get_drvdata(phy);
>  	struct mvebu_cp110_utmi *utmi = port->priv;
>  	struct device *dev = &phy->dev;
> +	const void *match;
> +	enum mvebu_cp110_utmi_type type;
>  	int ret;
>  	u32 reg;
> +	u32 sel;
> +
> +	match = of_device_get_match_data(dev);
> +	if (match)
> +		type = (enum mvebu_cp110_utmi_type)(uintptr_t)match;
>  
>  	/* It is necessary to power off UTMI before configuration */
>  	ret = mvebu_cp110_utmi_phy_power_off(phy);
> @@ -208,16 +220,38 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
>  	 * to UTMI0 or to UTMI1 PHY port, but not to both.
>  	 */
>  	if (port->dr_mode == USB_DR_MODE_PERIPHERAL) {
> +		switch (type) {

Just looking at this, i'm surprised there is not a warning about
type possibly being uninitialled. 

> @@ -285,6 +320,8 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
>  	struct mvebu_cp110_utmi *utmi;
>  	struct phy_provider *provider;
>  	struct device_node *child;
> +	const void *match;
> +	enum mvebu_cp110_utmi_type type;
>  	u32 usb_devices = 0;
>  
>  	utmi = devm_kzalloc(dev, sizeof(*utmi), GFP_KERNEL);
> @@ -293,6 +330,10 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
>  
>  	utmi->dev = dev;
>  
> +	match = of_device_get_match_data(dev);
> +	if (match)
> +		type = (enum mvebu_cp110_utmi_type)(uintptr_t)match;
> +
>  	/* Get system controller region */
>  	utmi->syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
>  						       "marvell,system-controller");
> @@ -326,6 +367,18 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
>  			return -ENOMEM;
>  		}
>  
> +		/* Get port memory region */
> +		switch (type) {

Same here.

	Andrew

