Return-Path: <linux-kernel+bounces-256523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71F8934FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88E41C21746
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB37143C60;
	Thu, 18 Jul 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GrHFtX7h"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726314372D;
	Thu, 18 Jul 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315367; cv=none; b=RfgKlZ7mywjuMatWa+k9qFJ5yshB1JTh6ii2GjjCzloyIKEu1WdmQlM7nY8XumxaUi0RULOpNa2j1BilCxW5SlAH+DMs8cGiG+3lX0gudfnItGd4Bs+Wgz0YdV5j7G26sUJCZ8reb8Oaxq1Doz5qjIjXQWq6WL6mlZOTEOSqzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315367; c=relaxed/simple;
	bh=aHgvN8DcpuIMoFz4mUzr/XhbxyJQPLiT8wsxrox6SmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZfBDtStrbGZ8UzA6LuSf+3cLQKWU56EOsbeQq6HQsCXK1NcHoWFDXNetp2fL+At8V+2lb2dqSeY2WMGN2boHLRC2ycvyhObEQ0fWkK75Gy8KSgRGMBXNMX9CXRbyWkQseA25ERrZtRS/ylM2Lq+cLKN61bUR9v+Ao54ZmdsSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GrHFtX7h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eahymJIWKeg6EuH2i+xe4KUuT0MlHFjbKV/EeHLuHQE=; b=GrHFtX7htOxaLDg469rq62ASgl
	b/nWhWpwoaiaDVdPWKAvn2PTM9JgzBQ9wPxKHFmV5hw49bYA1KR7WMShKYa4S0NqflQtvoUeTisu/
	PgC596VEbs4D05V0dSA7tx4B0H96Jbeok5ciQf7osdYiPpBL+/QqRjYdZI6a7DM/gf4Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUSkt-002n1J-SE; Thu, 18 Jul 2024 17:09:15 +0200
Date: Thu, 18 Jul 2024 17:09:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	horms@kernel.org, hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, linux@armlinux.org.uk,
	bryan.whitehead@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V2 0/4] Add support to PHYLINK for
 LAN743x/PCI11x1x chips
Message-ID: <336a5726-8654-441b-b5be-ef68888406c0@lunn.ch>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
 <2d8d38c2-0781-47ff-bff8-aec57d68ef05@lunn.ch>
 <ZpijZH4pwymNbefz@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpijZH4pwymNbefz@HYD-DK-UNGSW21.microchip.com>

On Thu, Jul 18, 2024 at 10:38:52AM +0530, Raju Lakkaraju wrote:
> Hi Andrew,
> 
> Thank you for review the patches.
> 
> The 07/18/2024 05:27, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Tue, Jul 16, 2024 at 05:03:45PM +0530, Raju Lakkaraju wrote:
> > > This is the follow-up patch series of
> > > https://lkml.iu.edu/hypermail/linux/kernel/2310.2/02078.html
> > >
> > > Divide the PHYLINK adaptation and SFP modifications into two separate patch
> > > series.
> > 
> > You appear to be missing the PHYLINK maintainer in your Cc: list.
> > 
> I add all PHYLINK maintainers email id's in cc
> 
> i.e.
> $ ./scripts/get_maintainer.pl drivers/net/phy/phylink.c
> Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT)

Yes, sorry, Russell is on the list. My error.

richardcochran@gmail.com is a bit odd, is PTP involved here?

	Andrew

