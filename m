Return-Path: <linux-kernel+bounces-272263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E698C94596F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82446B2096D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD241C0DF2;
	Fri,  2 Aug 2024 08:02:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DA1EB4B6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585762; cv=none; b=KlIlsvhGguW6kFNQxqluzyHmYMdDvOR2Gxh0srAemb4/UIUZJfMMWMqJGOpk7VxdxfSKcbfd2hCp5U7GGBiPKbaWZCG9N+O6bXUF7dqggWs++OhSXucNCpApZCmUNa8WdWEmxLm5X13gToZ6yH/ev9oyR7MdRuDRFZgPYmfgh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585762; c=relaxed/simple;
	bh=z9N3Dy6AarxlyC46M67moVWtSSN25BIaPNxJJFfBe1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFS/FExtdxsKN5kUmuCLN7s+qbUUtcELl8RBrhBRK/Jn6LWIX6SConMsBdwDOvN8jcoXeZlWrRj/H+551fuiHNjrnUK2/NkhTTYU+8Os+OaSREGnkA2pE6UFLL9c1WTvclcLLyHCHGEpsAW97FkeaxB8Ds342BXTld5MdKXbh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sZnFC-0007PM-BI; Fri, 02 Aug 2024 10:02:34 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sZnFA-003xQm-PS; Fri, 02 Aug 2024 10:02:32 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sZnFA-00Eqbs-25;
	Fri, 02 Aug 2024 10:02:32 +0200
Date: Fri, 2 Aug 2024 10:02:32 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, Yuiko Oshino <yuiko.oshino@microchip.com>,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Eric Dumazet <edumazet@google.com>,
	Michal Kubiak <michal.kubiak@intel.com>, kernel@pengutronix.de,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v2 1/1] net: phy: microchip: lan937x: add
 support for 100BaseTX PHY
Message-ID: <ZqySmKF_C6t_YTXy@pengutronix.de>
References: <20240705085550.86678-1-o.rempel@pengutronix.de>
 <ZqdPd/ieyLgVmX8v@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqdPd/ieyLgVmX8v@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2024 at 09:14:47AM +0100, Russell King (Oracle) wrote:
> On Fri, Jul 05, 2024 at 10:55:50AM +0200, Oleksij Rempel wrote:
> > +static int lan937x_tx_config_aneg(struct phy_device *phydev)
> > +{
> > +	int ret;
> > +
> > +	ret = genphy_config_aneg(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return lan937x_tx_config_mdix(phydev, phydev->mdix_ctrl);
> 
> Should the MDIX configuration be changed _after_ aneg has possibly
> been restarted (by genphy_config_aneg()) or should the MDIX config
> be done before?

Hm, good question. I'm sure it was working, but now i'm starting to
doubt. I'll retest it as soon I'll continue to work on this HW.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

