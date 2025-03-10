Return-Path: <linux-kernel+bounces-553933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C778A590D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D94C188EF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E008022577E;
	Mon, 10 Mar 2025 10:14:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B22E22423B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601685; cv=none; b=sUD7sKaacvW/cREvYN4GQXxxwJu2anSKJz8NGFhR8UDu8KeyMzF6heYhMJ1YQajoMl9cL8HujAQGb3VVlqVAUHzt/hZn1AQ9KoNJ5lF4lI8XUGddYRG7Gv5ibqzHimMKvK7OWzs5c7oPv233RJQ+Qf1hSYNKSoKkxVomi9Ssmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601685; c=relaxed/simple;
	bh=Bx4OgRcikifGeX9R341VeL8/KfWFyP9iy5dZEgZ67KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB80gq1poFj9AzSjd61zipTzN/qGf4zSxHTK96wZYjROU8Op+myusm7oSh/8ozvCApwFd5/2XmSWec3hyIkIZr/uzH0l8JAJLI8RfQe+EhcX5vGFvlfhbK5icUumfBizDdmDHOrIf5ZTUMKXTvlC96KhrJ86msTiR4kOucAxriQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1trZuC-0007Im-3x; Mon, 10 Mar 2025 10:58:40 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1trZuB-004yXP-00;
	Mon, 10 Mar 2025 10:58:39 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1trZuA-005qxW-2s;
	Mon, 10 Mar 2025 10:58:38 +0100
Date: Mon, 10 Mar 2025 10:58:38 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Thangaraj.S@microchip.com
Cc: andrew+netdev@lunn.ch, rmk+kernel@armlinux.org.uk, davem@davemloft.net,
	Rengarajan.S@microchip.com, Woojung.Huh@microchip.com,
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	phil@raspberrypi.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 1/7] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <Z863zsYNM8hkfB19@pengutronix.de>
References: <20250307182432.1976273-1-o.rempel@pengutronix.de>
 <20250307182432.1976273-2-o.rempel@pengutronix.de>
 <1bb51aad80be4bb5e0413089e1b1bf747db4e123.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1bb51aad80be4bb5e0413089e1b1bf747db4e123.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Thangaraj,

On Mon, Mar 10, 2025 at 09:29:45AM +0000, Thangaraj.S@microchip.com wrote:
> > -       mii_adv_to_linkmode_adv_t(fc, mii_adv);
> > -       linkmode_or(phydev->advertising, fc, phydev->advertising);
> > +       phy_suspend(phydev);
> > 
> 
> Why phy_suspend called in the init? Is there any specific reason?

In my tests with EVB-LAN7801-EDS, the attached PHY stayed UP in initial
state. phy_suspend() solved this issue. But I need to retest it with all
latest changes.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

