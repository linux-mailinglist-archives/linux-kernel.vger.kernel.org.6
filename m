Return-Path: <linux-kernel+bounces-336602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2BB983CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C37CB220B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF2173451;
	Tue, 24 Sep 2024 06:18:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ECE81742
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158694; cv=none; b=QdmTN5vhoF3NnDNeK6zRmavN01MGp94HjV/eO5zG/i3tPdoiYjs0f1gX1Eetqc8dWid8zshSWf2ijwXJayM7n5Syo3ZZK02dsSV8g0n6tKWCvnN0gx/Arnmz+PhjZJb40KPZpDjZa4nfcrhWabuDcdnKG0MRUUyudDH8sJ6yHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158694; c=relaxed/simple;
	bh=BYZ01WAhfG8PTdgaq/+vHJ+RA/m6/q8HB6ZoPYc7sh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jeq771KA02kYzWMeotfDXodkAX24OiqTd6fyIqmlgiKmow+hfZnwQXJB6SJU3CKhwnobYBP1osmjpdYssB4kdShWhitTVhfWDvMvGt0GYaea1i2771+Yb40e49anY7bi+vFe7Czgpz/KHc2MnfsxJ9X6T3Ag8DwrG5IGDGp57pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ssys3-0006SU-OQ; Tue, 24 Sep 2024 08:17:59 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1ssys1-001892-NB; Tue, 24 Sep 2024 08:17:57 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ssys1-009LjW-21;
	Tue, 24 Sep 2024 08:17:57 +0200
Date: Tue, 24 Sep 2024 08:17:57 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: tps23881: Fix boolean evaluation for
 bitmask checks
Message-ID: <ZvJZlbeMM0TM3f9f@pengutronix.de>
References: <20240923153427.2135263-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240923153427.2135263-1-kory.maincent@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2024 at 05:34:26PM +0200, Kory Maincent wrote:
> Fixed potential incorrect boolean evaluation when checking bitmask values.
> The existing code assigned the result of bitwise operations directly to
> boolean variables, which could lead to unexpected values.
> This has been corrected by explicitly converting the results to booleans
> using the !! operator.
> 
> Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
 
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

