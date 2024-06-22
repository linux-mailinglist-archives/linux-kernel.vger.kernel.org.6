Return-Path: <linux-kernel+bounces-225550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006C791320C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 07:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FF91C21CEB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 05:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09BA1494D1;
	Sat, 22 Jun 2024 05:06:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5111494B8
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 05:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719032806; cv=none; b=TQLI0Q42NX6c8J1+YcABrsT8fy3VUZ2v6oSZy5u3qf8mVUOkSaXck83wQDEhvVRgPzpHHzgTn4YWgVuzDde6kbPjcYp7dCcRk2+NrTn0AP1v124wz5Et7/4CXhyAC5BqafJFb7xzjqOvet6XwgTYMiauRqBdJ2xDkEpy5Zx52ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719032806; c=relaxed/simple;
	bh=ElpnqGb2uAaNz3u3gs7mh9PIoZii/nf6yiSP2bvyY+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrvsUi2MP9wg8R2KM4UwIIDtCGstSct/qtLsmcEtyP4r2Fu7B4KkUV55uunuruhDyTChzHq64WQi0fch9yckltWdnseSvIjprzAFDDFBPMEolX0VI6bJG/vwVqv62kA2h+RVOnkxzuTWacoBc9x9alsyUzO5rvMFk+K3w0ygnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sKsxN-0000tW-6U; Sat, 22 Jun 2024 07:06:33 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sKsxK-0046VJ-R4; Sat, 22 Jun 2024 07:06:30 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sKsxK-008Emb-2P;
	Sat, 22 Jun 2024 07:06:30 +0200
Date: Sat, 22 Jun 2024 07:06:30 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 1/7] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Message-ID: <ZnZb1rG-ePCyoqlU@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
 <20240614-feature_poe_power_cap-v3-1-a26784e78311@bootlin.com>
 <Zm15fP1Sudot33H5@pengutronix.de>
 <20240617154712.76fa490a@kmaincent-XPS-13-7390>
 <ZnCUrUm69gmbGWQq@pengutronix.de>
 <20240621182915.3efd9ccf@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621182915.3efd9ccf@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2024 at 06:29:15PM +0200, Kory Maincent wrote:
> On Mon, 17 Jun 2024 21:55:25 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Mon, Jun 17, 2024 at 03:47:12PM +0200, Kory Maincent wrote:
> >  [...]  
> > > 
> > > Mmh not really indeed, maybe we can put it in error_condition substate?  
> > 
> > I'm not sure how this error can help user, if even we do not understand
> > what is says. May be map everything what is not clear right not to
> > unsupported error value. This give us some time to communicate with
> > vendor and prevent us from making pointless UAPi?
> 
> Is it ok for you if I use this substate for unsupported value:
> ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS
> or do you prefer another one.

Ack, sounds good.

> > > Should I put it under MPS substate then?  
> > 
> > If my understand is correct, then yes. Can you test it? Do you have PD
> > with adjustable load?
> 
> Yes I will test it.

Thx!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

