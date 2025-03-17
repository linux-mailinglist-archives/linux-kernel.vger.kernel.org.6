Return-Path: <linux-kernel+bounces-563764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F61A647DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35427A4185
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDE2248BD;
	Mon, 17 Mar 2025 09:44:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D6191499
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204685; cv=none; b=N2CdTMc41+smOlBA1PKJ3WId+P2wXoRf0YE/ZupYa7x9s0EKfZst6FEKTx9JE4BLesdAheODfNBwT8GNGHk7w3gjP4e3sHc9Le6qTGbwRFy4MeQwrDAP46P94A+Dqhpcj4vwDzgyXLjTpERveJT1D4pJYDXzGWktqfE6lZ+Yd9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204685; c=relaxed/simple;
	bh=LIWRdeVeAfVd98ngyW8UtjnpWxzx1XoS06rstlg+cN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ8+qxU5OJoZJuF0oK1tz8yGgV6zmIwKA3ts+I9Kvx29PxC1xvZ/4kKIwWUlQm6UYZpa2MLFKyyf31bGF7WU2q5GRryWZr6JDTOerk2g3OiZjTm7t4+9N67QUmXs2MU/iCbWiJJJH1qw/mI8rXHGrsPZeli1tNmU0sXVYIJAwdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tu70q-0003jl-Cx; Mon, 17 Mar 2025 10:44:00 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tu70o-000DrX-12;
	Mon, 17 Mar 2025 10:43:58 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tu70o-0018B3-1s;
	Mon, 17 Mar 2025 10:43:58 +0100
Date: Mon, 17 Mar 2025 10:43:58 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 03/12] net: pse-pd: tps23881: Add support for
 PSE events and interrupts
Message-ID: <Z9fu3u34K3-OeDis@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
 <20250304-feature_poe_port_prio-v6-3-3dc0c5ebaf32@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304-feature_poe_port_prio-v6-3-3dc0c5ebaf32@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2025 at 11:18:52AM +0100, Kory Maincent wrote:
> +static int tps23881_irq_handler(int irq, struct pse_controller_dev *pcdev,
> +				unsigned long *notifs,
> +				unsigned long *notifs_mask)
> +{
> +	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
> +	struct i2c_client *client = priv->client;
> +	int ret, it_mask;
> +
> +	/* Get interruption mask */
> +	ret = i2c_smbus_read_word_data(client, TPS23881_REG_IT_MASK);
> +	if (ret < 0)
> +		return ret;
> +	it_mask = ret;
> +
> +	/* Read interrupt register until it frees the interruption pin. */
> +	while (true) {

If the hardware has a stuck interrupt, this could result in an infinite
loop. max_retries with some sane value would be good.

> +		ret = i2c_smbus_read_word_data(client, TPS23881_REG_IT);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* No more relevant interruption */
> +		if (!(ret & it_mask))
> +			return 0;
> +
> +		ret = tps23881_irq_event_handler(priv, (u16)ret, notifs,
> +						 notifs_mask);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static int tps23881_setup_irq(struct tps23881_priv *priv, int irq)
> +{
> +	struct i2c_client *client = priv->client;
> +	struct pse_irq_desc irq_desc = {
> +		.name = "tps23881-irq",

here or in devm_pse_irq_helper() it would be good to add intex suffix to
the irq handler name.

v> +		.map_event = tps23881_irq_handler,
> +	};
> +	int ret;
> +	u16 val;
> +
> +	val = TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_SUPF;
> +	val |= val << 8;
> +	ret = i2c_smbus_write_word_data(client, TPS23881_REG_IT_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(client, TPS23881_REG_GEN_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = (u16)(ret | TPS23881_REG_INTEN | TPS23881_REG_INTEN << 8);
> +	ret = i2c_smbus_write_word_data(client, TPS23881_REG_GEN_MASK, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_pse_irq_helper(&priv->pcdev, irq, 0, &irq_desc);
> +}
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

