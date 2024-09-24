Return-Path: <linux-kernel+bounces-336788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E749840D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DA61C21EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6C4152160;
	Tue, 24 Sep 2024 08:44:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F314F9E9
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167456; cv=none; b=V6SIWD2yZ3WMYUOok2KQCHZ62L7eAFreU83SLov1HChrurvG2/XpHTzmo76FLcb9fUaKN0Ui2HhPKBGhPkx4gAWu2X0Nx4zKRMm0dPH+RFFBnJSqq1JtO3wozSTy02hEgN+hXrkJ8t5gl1jMI2b137jnSG8/4gGcaFzq6FNCQsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167456; c=relaxed/simple;
	bh=+buXv4YcK1Kq+N/RYqWqCggYWDBgpSyTBGtY5DUB1Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdOPzNzqiIpZ7cELhwRmz9pMUWcNoz/JpW7Ba+WJbIMn4uxscWK8r2+HjgIBcjkBmNITav+4Svu2UrRuPc9U/e3YFB4EC+6v9lwjWzLn9m4O4cwnz1AZT3pnvhqHY9+3hfKIngjwJaBTE56FJB6rXb743l8RBUlyjeUsVWGs+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1st19U-00023s-Cu; Tue, 24 Sep 2024 10:44:08 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1st19S-001AZ7-S9; Tue, 24 Sep 2024 10:44:06 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1st19S-009Nv3-2V;
	Tue, 24 Sep 2024 10:44:06 +0200
Date: Tue, 24 Sep 2024 10:44:06 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>, thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: tps23881: Fix boolean evaluation for
 bitmask checks
Message-ID: <ZvJ71uWZygUxrmEo@pengutronix.de>
References: <20240923153427.2135263-1-kory.maincent@bootlin.com>
 <20240924071839.GD4029621@kernel.org>
 <20240924101529.0093994d@kmaincent-XPS-13-7390>
 <20240924082612.GF4029621@kernel.org>
 <20240924103357.1ca3d22f@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924103357.1ca3d22f@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2024 at 10:33:57AM +0200, Kory Maincent wrote:
> On Tue, 24 Sep 2024 09:26:12 +0100
> Simon Horman <horms@kernel.org> wrote:
> 
> > > Don't know about it but if I can remove it from my driver it would be nice.
> > > :)  
> > 
> > Right, no question from my side that this change is a good one.
> > I'm just wondering if it is best for net or net-next.
> 
> Indeed, I don't know the policy on this. Do you think it shouldn't go to net?
> I will let net maintainers decide. ;)

The net is always the right place for this kind of fixes. In any case, it
would be better to have actual symptoms of the issue addressed by
this patch in the commit message.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

