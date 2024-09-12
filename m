Return-Path: <linux-kernel+bounces-327076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA9C9770CA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C039B22056
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627991C2303;
	Thu, 12 Sep 2024 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F9JzsHmu"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9DD1C1736;
	Thu, 12 Sep 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165318; cv=none; b=PP43WfworN8jLnhe0aWKcx/0t5JxLY50GC0xk6xJPkbOJLdWFNaffa7jnHoJdeLZjU+lW78K5xLoor2GrwECpfI5peq1d9lPfz3qW5A+Y6lbttPF43Ghu5WxYf7JtgixAKBruF3aT4bw6amtaXPVEqmsBAT5ECNfiDxc9GpIp88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165318; c=relaxed/simple;
	bh=8a7RGRUSuUnUU/niDhs7XFXmo1pRjdtdSDy0r82+cLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdSoOVITMCNq/QFL2s+Lrrx6ba4MdLnC3bQLTNIWg/IM0udQBPgWTmLdGnkw04f7DO5WVBNERgmH9jN9Ny9mD3QEFqkzQIvW0FiKzVYiWEK73oZqER4yTfqqlq7Aw3wuKw15y7SV0iojIs6segtWGxO5XidjwraHRApgr2ukJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F9JzsHmu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=r/g+OSLkuknxMJDEB7gwrc4PShSFO6eIXehSjyZW1bs=; b=F9JzsHmuijbL/rGt5cIaH2KRlu
	XcUml650/VV8YRCCPGT4LxMdyptPd+JmCGN3L6Y8wHjvJxUXwG6q1S0c0GHcsFgOm6znPrzHxBLUQ
	MOcSSft0n/J4Fmse75//4eQbSmhPxV9XL4wHIZ5nOgKiywfeauOVrYbbkaqpXmv5hCd8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sooS0-007KZj-Mx; Thu, 12 Sep 2024 20:21:52 +0200
Date: Thu, 12 Sep 2024 20:21:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 0/7] Allow controlling PHY loopback and isolate
 modes
Message-ID: <aae18d69-fc00-47f2-85d8-2a45d738261b@lunn.ch>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>

> The loopback control from that API is added as it fits the API
> well, and having the ability to easily set the PHY in MII-loopback
> mode is a helpful tool to have when bringing-up a new device and
> troubleshooting the link setup.

We might want to take a step back and think about loopback some more.

Loopback can be done at a number of points in the device(s). Some
Marvell PHYs can do loopback in the PHY PCS layer. Some devices also
support loopback in the PHY SERDES layer. I've not seen it for Marvell
devices, but maybe some PHYs allow loopback much closer to the line?
And i expect some MAC PCS allow loopback.

So when talking about loopback, we might also want to include the
concept of where the loopback occurs, and maybe it needs to be a NIC
wide concept, not a PHY concept?

	Andrew


