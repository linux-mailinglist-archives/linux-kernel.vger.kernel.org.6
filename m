Return-Path: <linux-kernel+bounces-344263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F82A98A799
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26AB3B25F06
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFBE192580;
	Mon, 30 Sep 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HRMvyiHp"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604AC19048F;
	Mon, 30 Sep 2024 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707644; cv=none; b=pOb23dnZVKRyLWz6Aevusk/YLWCqMKs8e5SU/r7AwKXSXSsvmbJ8z4MFvyc0QGLKcJc5OC6UFw2bgIOCDA7OIb8zk/M1eSotgCA3XWtf2431HHAJqag089djGnFODa9Sp0LWkpEvj1eVqCFFL070Tmj0kYLKcfx0Y9s6V2zcUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707644; c=relaxed/simple;
	bh=tMnFxzL17uz4BJj8zWnYchsx5JdYn5dvGi8qgvKKX8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmhbQbVfDZpAjHlAE0MSh6Ygd+sKMm6Sat16NMEqRsDgRUwmOB7eqMeyjzB8INy83wUjbDGl1vHFz8cGInKCIwVtrTNj0gbws5AdnfXp1nP0499NSrO3rhKvfVxQZlIpCc+8W9QnD3o5KpNrTLHVWDDK2G3b/aDWeS6dk/lIJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HRMvyiHp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X504+0WqBGr9MY83w4ZgBfPIlVdr06MjbRfdTrJ7haM=; b=HRMvyiHp7PbEQirxErsVrpXpaO
	NG3yuhG8eVYyKTU7r8ORvhAijzI031ToK428BYLW8R5OEJff3pQOXM0VUGkR6hBdiLmZYNJj1VUnW
	89gxqp45/IgytBzUprneQ5asA7tT1+QhMpyM3yJTgdpnpHlQN1KzbbK2JAZnIhDHCEXg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svHg1-008dJT-IX; Mon, 30 Sep 2024 16:47:05 +0200
Date: Mon, 30 Sep 2024 16:47:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Support LED control
Message-ID: <0a1809ad-a279-48d2-a7e6-8bab1111fb7a@lunn.ch>
References: <20240930-mv88e6xxx-leds-v3-1-1ac6e0a2b3cf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-mv88e6xxx-leds-v3-1-1ac6e0a2b3cf@linaro.org>

> @@ -5396,6 +5426,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
>  	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
>  	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
>  	.port_get_cmode = mv88e6352_port_get_cmode,
> +	.port_setup_leds = mv88e6xxx_port_setup_leds,
>  	.port_setup_message_port = mv88e6xxx_setup_message_port,
>  	.stats_snapshot = mv88e6320_g1_stats_snapshot,
>  	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,

This code should work for all members of the 6352 family: 6172 6176
6240 6352. Please add this op to them all.

> +static int mv88e6xxx_led_match_selector(struct mv88e6xxx_port *p, int led, bool blink_activity,
> +					bool fiber, unsigned long rules, u16 *selector)
> +{
> +	const struct mv88e6xxx_led_hwconfig *conf;
> +	int i;
> +
> +	/* No rules means we turn the LED off */
> +	if (!rules) {
> +		if (led == 1)
> +			*selector |= MV88E6XXX_PORT_LED_CONTROL_LED1_SELE;
> +		else
> +			*selector |= MV88E6XXX_PORT_LED_CONTROL_LED0_SELE;
> +		return 0;
> +	}
> +
> +	/* TODO: these rules are for MV88E6352, when adding other families,
> +	 * think abour making sure you select the table that match the

about

> --- a/drivers/net/dsa/mv88e6xxx/port.c
> +++ b/drivers/net/dsa/mv88e6xxx/port.c
> @@ -12,6 +12,7 @@
>  #include <linux/if_bridge.h>
>  #include <linux/phy.h>
>  #include <linux/phylink.h>
> +#include <linux/property.h>
>  
>  #include "chip.h"
>  #include "global2.h"
> diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h

I suspect that additional include is not needed, since there are no
other changes to port.c

	Andrew

