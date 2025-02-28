Return-Path: <linux-kernel+bounces-538659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F929A49B83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F77518996C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AFD2702AC;
	Fri, 28 Feb 2025 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6IfxzwJV"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7B26E942;
	Fri, 28 Feb 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751821; cv=none; b=Hj4/cr5t22YtgLLB60WJwt75nvhnd2+c7Td0CiGmslw0VN5m6V21LwdKL8Tqc1vENpL2JWFSUxU4vrUT/Ch//5L246kK2ACep9Gsg4m0nIzYsPu2kVUTR8lLi8x2tebveMcO9xd7GRBZSTDEs9k0RLNWkY7tt03+heJKj32H5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751821; c=relaxed/simple;
	bh=NiAk1dbtJ6c2YxtaV2wJw0KRESAdUGps1hSUUUGLrmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEqvAyi+TyyUDfjvZhsMd2vYZp7YT/2GtHg16yQYL+TP1Ii11wdsqG6jE5qUn7mf0V4AFLQgdR6VLFKccYdc+UCx1xaGCmoOlVWAYJAfr6+o5empUdVN2gIRtk3L4KimDoIXoVmsg/ugCY64TaRTOYOCR9roe5tF0YqzRuyQIp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6IfxzwJV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gP7yF7df2W/n0ExR3W/btMKEa5o1CUcX1v+LkRcx5Ek=; b=6IfxzwJVy45w8i1xUFyaXP6ycZ
	x8dVWZ1QQBf61YJaIA1eEyOnOwl42i26tZwT0fu7cnOjgJ1/+IFHSEpuzedu6raWMq2sZ5OKTK6hQ
	td9HeCuQzcenu7zSdWkQVEJPUJpTgj7ZNEGanR6jOgrnW1GhOg529OzBm7Yn4PFkz7M0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1to146-000xje-80; Fri, 28 Feb 2025 15:10:10 +0100
Date: Fri, 28 Feb 2025 15:10:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com, linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v3 06/14] motorcomm:yt6801: Implement the
 fxgmac_start function
Message-ID: <f6c63297-a246-4daa-b47b-464c844baedb@lunn.ch>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
 <20250228100020.3944-7-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228100020.3944-7-Frank.Sae@motor-comm.com>

> +static int fxgmac_phy_connect(struct fxgmac_pdata *priv)
> +{
> +	struct phy_device *phydev = priv->phydev;
> +	int ret;
> +
> +	priv->phydev->irq = PHY_POLL;
> +	ret = phy_connect_direct(priv->netdev, phydev, fxgmac_phylink_handler,
> +				 PHY_INTERFACE_MODE_INTERNAL);
> +	if (ret)
> +		return ret;
> +
> +	phy_support_asym_pause(phydev);
> +	priv->phydev->mac_managed_pm = 1;
> +	phy_attached_info(phydev);
> +
> +	return 0;
> +}

Please consider swapping to phylink, not phylib. Your current pause
implementation is broken, which is a common problem with drivers using
phylib. phylink makes it much harder to get pause wrong. The same can
be said for EEE, if you decide to implement it.

	Andrew

