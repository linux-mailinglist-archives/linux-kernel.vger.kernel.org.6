Return-Path: <linux-kernel+bounces-350781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB119909A7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520981F21EAC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFEE1CACEB;
	Fri,  4 Oct 2024 16:46:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6B28DD1
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060391; cv=none; b=WIYrCgS0wAAeOvBXo3+YHBuVlptaul3xWgyAazmIqD4EgaABdZleIteQ0Cq1EAgFx6lVJ8N6Sgz9iuL1igzPVpdGDn3ZZXJVyngsYPzm632wc3cLPr/s+4aPLma8m5w0yMej3Dq0GDgrojgwnFLnwEodArYd/cWzYeyJIJOYEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060391; c=relaxed/simple;
	bh=ylnnfKvetf93g2DUN//euZqD3scWcX/30/I9+Vkfp5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXUD3wIEDkkrYIfKJ14z7Cey/0R6vBSnOGuQPmyS/Ix5sbUAY/aDhI4j0SI4QsXoluQH8ACV2OhpdgNhUZXQigK5yMkTHvlsas5kS6+L782SUy7/qE9TI0vHTSt8XKqOwiBd0iDVWwkMai1kB1bU/8eEexGB0YO8kinZLBmnDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1swlRf-0000as-FV; Fri, 04 Oct 2024 18:46:23 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1swlRc-003daH-BK; Fri, 04 Oct 2024 18:46:20 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1swlRc-00AkA7-0n;
	Fri, 04 Oct 2024 18:46:20 +0200
Date: Fri, 4 Oct 2024 18:46:20 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next v2 3/9] net: phy: Allow PHY drivers to report
 isolation support
Message-ID: <ZwAb3DNWYl0ykRBl@pengutronix.de>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
 <20241004161601.2932901-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004161601.2932901-4-maxime.chevallier@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2024 at 06:15:53PM +0200, Maxime Chevallier wrote:
> Some PHYs have malfunctionning isolation modes, where the MII lines
> aren't correctly set in high-impedance, potentially interfering with the
> MII bus in unexpected ways. Some other PHYs simply don't support it.

Do we have in this case multiple isolation variants like high-impedance
and "the other one"? :)  Do the "the other one" is still usable for some
cases like Wake on LAN without shared xMII?

I'm just curios.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

