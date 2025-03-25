Return-Path: <linux-kernel+bounces-574739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A230A6E950
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0585E7A3C73
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 05:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65591AB530;
	Tue, 25 Mar 2025 05:34:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361D1A9B32
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742880897; cv=none; b=j0MrvwhVxNHM4Ts0nR9eMIh6OFEYPH3HAvYBpDx41z9dJSJFGdineaq8R7K08CunzBrTBBhV+koHdTsnMQtiI2/aAtj+qxtkvpRKj4o59D2hPuAbaiDt438+jxbofnvIqQJdtkAia8+4mo1IReTo47/Hvf2mN6q4gNm57I3bpGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742880897; c=relaxed/simple;
	bh=c2Av66IXC/j5Ecmc1swHw1f2mz1THsByFbOQ2gd0qHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koqU8XFoKronh/5EoAwbGTLKoYVv3JK/LFeFfqeFAgugKGpAu/ammnnmk0EUXyMsMqkngYOFsEt9Uqw7URqnz40GIZZYdxQWkaPOUliM+B2ylbXFtHayOP6+lBBUbl0qSVhqWIgYKAAVuQ5bT5NIyB0qHYxT4n744VPj6/RFh2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1twwve-0001R5-Q1; Tue, 25 Mar 2025 06:34:22 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1twwvY-001WnQ-2d;
	Tue, 25 Mar 2025 06:34:17 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1twwvZ-00Fk6E-0G;
	Tue, 25 Mar 2025 06:34:17 +0100
Date: Tue, 25 Mar 2025 06:34:17 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
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
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Dent Project <dentproject@linuxfoundation.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <Z-JAWfL5U-hq79LZ@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
 <20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
 <Z9gYTRgH-b1fXJRQ@pengutronix.de>
 <20250320173535.75e6419e@kmaincent-XPS-13-7390>
 <20250324173907.3afa58d2@kmaincent-XPS-13-7390>
 <Z-GXROTptwg3jh4J@p620>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z-GXROTptwg3jh4J@p620>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 24, 2025 at 05:33:18PM +0000, Kyle Swenson wrote:
> Hello Kory,
> 
> On Mon, Mar 24, 2025 at 05:39:07PM +0100, Kory Maincent wrote:
> > Hello Kyle, Oleksij,
> ...
> > 
> > Small question on PSE core behavior for PoE users.
> > 
> > If we want to enable a port but we can't due to over budget.
> > Should we :
> > - Report an error (or not) and save the enable action from userspace. On that
> >   case, if enough budget is available later due to priority change or port
> >   disconnected the PSE core will try automatically to re enable the PoE port.
> >   The port will then be enabled without any action from the user.
> > - Report an error but do nothing. The user will need to rerun the enable
> >   command later to try to enable the port again.
> > 
> > How is it currently managed in PoE poprietary userspace tools?
> 
> So in our implementation, we're using the first option you've presented.
> That is, we save the enable action from the user and if we can't power
> the device due to insufficient budget remaining, we'll indicate that status to the
> user.  If enough power budget becomes available later, we'll power up
> the device automatically.

It seems to be similar to administrative UP state - "ip link set dev lan1 up".
I'm ok with this behavior.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

