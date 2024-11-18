Return-Path: <linux-kernel+bounces-413318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE889D173B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6909E1F2335B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADA71B21A0;
	Mon, 18 Nov 2024 17:37:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40320EC2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951440; cv=none; b=mDr6YlfM4cTs8ldKmBJyYKxRWS9tyf8Sz2O1Cueciexn/iJ4XsoO9UkMk+E+T6g1s6J9JSm5jMmyEsFD9zTFOt5iS3TpTQkp17x1C8NuXdoNYItu0Ir90+eJs2B1U2B1QFAeHJbAXFs5xaemiaBkS+vIxBj0SElQN3ODSek9Ptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951440; c=relaxed/simple;
	bh=Yo0gB4ek0uFbneWNFNJ+hEqTULdzuIhAy5RBWMXlMKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC7G63kj8SzjxSNBaDBova3iB7LEhHON2zN7sQGw+8RwMuIRtR/GNKtD6/jqMHZgD30vZUPVgP8i9AiFbWvt5KLqcN1BOFafb9RpE8RWRJKRLma0cbpo5awYcrOTNFFw0bqzv+yjUU+kFMTIqmG+vx6ydLP/2EPptdOTH4cGFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tD5gQ-0004GK-48; Mon, 18 Nov 2024 18:37:06 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tD5gO-001Qvh-0F;
	Mon, 18 Nov 2024 18:37:04 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tD5gN-001V9N-36;
	Mon, 18 Nov 2024 18:37:03 +0100
Date: Mon, 18 Nov 2024 18:37:03 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yuiko Oshino <yuiko.oshino@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net v1 1/1] net: phy: microchip: Reset LAN88xx PHY to
 ensure clean link state on LAN7800/7850
Message-ID: <Zzt7P6KklGzgrtob@pengutronix.de>
References: <20241117102147.1688991-1-o.rempel@pengutronix.de>
 <20241118174849.5625064f@fedora.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118174849.5625064f@fedora.home>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2024 at 05:48:49PM +0100, Maxime Chevallier wrote:
> Hi Oleksij,
> 
> On Sun, 17 Nov 2024 11:21:47 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Fix outdated MII_LPA data in the LAN88xx PHY, which is used in LAN7800
> > and LAN7850 USB Ethernet controllers. Due to a hardware limitation, the
> > PHY cannot reliably update link status after parallel detection when the
> > link partner does not support auto-negotiation. To mitigate this, add a
> > PHY reset in `lan88xx_link_change_notify()` when `phydev->state` is
> > `PHY_NOLINK`, ensuring the PHY starts in a clean state and reports
> > accurate fixed link parallel detection results.
> > 
> > Fixes: 792aec47d59d9 ("add microchip LAN88xx phy driver")
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> This looks like the issue in the Asix AX88772A, but your patch has
> better error handling :)

It was my code in Asix. Need to add proper error handling too. It is not
nice if device is detached but kernel is continuing executing things and
printing a lot of errors.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

