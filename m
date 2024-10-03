Return-Path: <linux-kernel+bounces-349014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB77798EF67
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4491C212CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC8C189B8F;
	Thu,  3 Oct 2024 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bvIrtvK5"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0172186E46;
	Thu,  3 Oct 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959236; cv=none; b=nfSJzzvknGA7IZagc8dOBGg9i74sp9LF2GGg911XoXza3Enyk/0soVxRdf7VarKfAu3WApRxWeqARvaszjn4hfXeXEi45ldXwThxagmOMZvIGManykRxQFQXZQr0C+aCEsDInku9WEljJf2SDFf8huRiVXCAg1gcUQ2b8le6AvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959236; c=relaxed/simple;
	bh=jDcru5H9+Qa+PxjnhWrNRGNCTHk/VKHGXnAFQzMI0lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3+JaUPm/2JASrJkJna4v9L1/fKKqAl1nUjx4azyOyoO2hz9FclN/hqraomXpFI+FYlNahmhocFmypy3a/ezmr5vBgT//rppx4p1TYbiTCefvw2gPu1jFR9/p8xmutIYOV5/tELo69Onjbt1CAIIxv3wSYovAAODkfRt6Tqp/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bvIrtvK5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cPwDJx00YR3As1/9S202+k1eFQiQLwUHTk7faEAhr3I=; b=bv
	IrtvK5c2temyYdg2CjgwBpkZ+N1Ho56y2idbrZyiDLsdpbb+IjLcJoRsMa3O0nY3QSH1x1pZkIOU4
	YFVvLZ+DoLVNImhK9AihVvLaD7bVmRCbJQ3BYmveoKzpV8TPCtCPly3fABOgw8jzW5SY9RxlfVo/a
	hrViCZi6alUQaoU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swL80-008wgB-Pw; Thu, 03 Oct 2024 14:40:20 +0200
Date: Thu, 3 Oct 2024 14:40:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qingtao Cao <qingtao.cao.au@gmail.com>
Cc: Qingtao Cao <qingtao.cao@digi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/1] net: phy: marvell: avoid bringing down
 fibre link when autoneg is bypassed
Message-ID: <b4d889ad-2e69-44a1-a01e-e8d7e571ca4b@lunn.ch>
References: <20241003071050.376502-1-qingtao.cao@digi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241003071050.376502-1-qingtao.cao@digi.com>

On Thu, Oct 03, 2024 at 05:10:50PM +1000, Qingtao Cao wrote:
> On 88E151x the SGMII autoneg bypass mode defaults to be enabled. When it is
> activated, the device assumes a link-up status with existing configuration
> in BMCR, avoid bringing down the fibre link in this case

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please note the bullet point:

* don’t repost your patches within one 24h period

It would be good if you read all this document.

	Andrew

