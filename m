Return-Path: <linux-kernel+bounces-350268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3D99028C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C9C2816B7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810A215C121;
	Fri,  4 Oct 2024 11:52:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C115B966
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042741; cv=none; b=lYHg9Qh88aP+vyaDBGfQDR9qk5CwnpfjTcvi5IwkGOcPHO4zYmbkjKDkhw+hTeVdtWjK07bj4VlK5iyEPIwf7xRyrhXNesBTS00fWwB1uzzjLk7pPk0WQSVm84qCKxYtxsswrUgg5EjsLJooqqYZjBWhdfwvY62y0cE4WilZETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042741; c=relaxed/simple;
	bh=a/b8KhS76Lypgn0Qhi6M+ScxkMKXG55iD2Gk38iXy54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT7QVXQKTje1AEsboXGInrRh101h7zP1OdplLGuJLdYwY/ey3iPQKQbbWrjRk8ZfOy8v1oB4hoNQmDkeOdmxMUOJdD8MF7YGX5UGPLI0CTIDrh0rK1mtDz8gNsD4NHjVoAfUfq6GR3krDefqYHlKJ83tbIx83Y6RHN5ZkQSWZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1swgqt-0006vI-Ca; Fri, 04 Oct 2024 13:52:07 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1swgqr-003Yt5-Ku; Fri, 04 Oct 2024 13:52:05 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1swgqr-00AgEW-1i;
	Fri, 04 Oct 2024 13:52:05 +0200
Date: Fri, 4 Oct 2024 13:52:05 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 1/1] Documentation: networking: add Twisted
 Pair Ethernet diagnostics at OSI Layer 1
Message-ID: <Zv_W5VDlTahegOZc@pengutronix.de>
References: <20241003060602.1008593-1-o.rempel@pengutronix.de>
 <20241003095321.5a3c4e26@fedora.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003095321.5a3c4e26@fedora.home>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, Oct 03, 2024 at 09:53:21AM +0200, Maxime Chevallier wrote:
...
> > +  - **Wake-on**: Displays whether Wake-on-LAN is enabled (e.g., **Wake-on: d**
> > +    for disabled). Not used for layer 1 diagnostic.
> 
> (sorry for the long scroll down there) This whole section is more of a
> documentation on what ethtool reports rather than a troubleshooting
> guide. I'm all in for getting proper doc for this, but maybe we could
> move this in a dedicated page, that we would cross-link from that guide
> ?

Ack, I was not sure where to put it. I'll try to come up with ethtool
manual patches and drop for now everything no directly related with the
diagnostic.

> > +This list will evolve with future kernel versions, reflecting new features or
> > +refinements. Below are the current suggestions:
> 
> I'm not sure this TODO list has its place in this troubleshooting
> guide. I agree with the points you list, but this looks more like a
> roadmap for PHY stuff to improve. I don't really know where this list
> could go and if it's common to maintain this kind of "TODO list" in the
> kernel doc though. Maybe Andrew has an idea ?

Yea,  may be it will be enough to send it as separate mail for
discussion.

> Thanks for coming-up with such a detailed guide. I also have some "PHY
> bringup 101" ideas on the common errors faced by developers, and this is
> document would be the ideal place to maintain this crucial information.

Good idea. It will be good to have a list or guide on what options are expected
form from PHY driver and how to test them.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

