Return-Path: <linux-kernel+bounces-228677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D26F91654B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411F62869F2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2131314A4EC;
	Tue, 25 Jun 2024 10:34:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A02145B32
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311646; cv=none; b=T/JY/bVaduoMPHnPUTnAsmTe/liofuhrWoNk8puH+/rxnDg+YZB2TCKFBDVb1TLH2Ub+FnubVyt9t4nC+jfq/dYad/nmOghfm7OC4lV9bIhcl32gatHQelV2pX1glNip9OI8yS0Dv4KT6iCA0y56NFT0wUEVEvRGELvTU15q3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311646; c=relaxed/simple;
	bh=lf34SNsy3KanOhaYXHKd69Bn7zHfE+cWds2/CsVwHSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bb5dENZWW3ewFDQ/pfb/AdO7qVdvvawslFb1ArXqkzVsLi0vi3P3xPGDPEEDeo0rTpD7KDOJrWER8yduFSYKAIUYOUUzShrnSUQwkDcteoeAlcCTw9x6U4F+Jz33i1niMb5OWowkX8Vp251jPrsE1fq6la2TVR5NOrigUiuKLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sM3Um-0008Od-EV; Tue, 25 Jun 2024 12:33:52 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sM3Uk-004rrh-Pd; Tue, 25 Jun 2024 12:33:50 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sM3Uk-00E6G5-2B;
	Tue, 25 Jun 2024 12:33:50 +0200
Date: Tue, 25 Jun 2024 12:33:50 +0200
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
Message-ID: <ZnqdDmvy0YLqk6Ih@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
 <20240614-feature_poe_power_cap-v3-1-a26784e78311@bootlin.com>
 <Zm15fP1Sudot33H5@pengutronix.de>
 <20240617154712.76fa490a@kmaincent-XPS-13-7390>
 <ZnCUrUm69gmbGWQq@pengutronix.de>
 <20240625111835.5ed3dff2@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625111835.5ed3dff2@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Köry,

On Tue, Jun 25, 2024 at 11:18:35AM +0200, Kory Maincent wrote:
> Hello Oleksij,
> 
> On Mon, 17 Jun 2024 21:55:25 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > 
> > > > The difference between open and underload is probably:
> > > > - open: Iport = 0, detection state
> > > > - underload: Iport < Imin (or Ihold?), Iport can be 0. related to
> > > > powered/MPS state.  
> > > 
> > > Should I put it under MPS substate then?  
> > 
> > If my understand is correct, then yes. Can you test it? Do you have PD
> > with adjustable load?
> 
> In fact I can't test it, I have a splitter and an adjustable load, not a
> splitter that can adjust it's own load. So I can't decrease the load of the
> splitter itself and reach this error condition.

Hm.. how about this setup:
------>>-----x--------->>----
PSE          |-load      splitter
------>>-----x--------->>----

Attach the load directly to the ethernet line after PSE did
classification with splitter. Then remove splitter. As long as load is
high enough, PSE will not turn the port off. Then reduce load until it drops
below the threshold.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

