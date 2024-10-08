Return-Path: <linux-kernel+bounces-355480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A500D9952DB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB1B2852A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668061E0490;
	Tue,  8 Oct 2024 15:01:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520651E008E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399687; cv=none; b=VTjcxd7IhTOIjPr7yxJTXbT8QQvDCswSqsIcQgZMaE3lbRhtIWq4WOHPNl21qBbmun3PHmTDYGaAN3l9PuWvIXoOoBSRMGZHX8o6gjoEHxT5qNHJTm/5W5UI9ft725d57wrd1EHBE+vmrQAP83h7G5dDXpWWoip0eUppun+30w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399687; c=relaxed/simple;
	bh=+W5OZ6dooplYBQPBLHswZ9NRnDap1swU6HEYSLanpko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zj2eiihNAla+5mUDIiY9yAURU5H6CF3l7U31+pvlrwVq7g24HuD1XJxBNTsgHq0mQ0tDKgceR97LZ042Zv9E4bjLMZT8Ia30svrkHtwggKDDRWNKiNn8YbrWfhiBWENdBWIog6TD4we9ywQ6nAwlmIdDdsHVYD9RAq7aiPNI8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1syBi6-0002sj-4i; Tue, 08 Oct 2024 17:01:14 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1syBi2-000OEm-JT; Tue, 08 Oct 2024 17:01:10 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1syBi2-000Qkx-1a;
	Tue, 08 Oct 2024 17:01:10 +0200
Date: Tue, 8 Oct 2024 17:01:10 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 06/12] net: ethtool: Add PSE new port priority
 support feature
Message-ID: <ZwVJNomEzQJOr8jx@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-6-787054f74ed5@bootlin.com>
 <ZwDcHCr1aXeGWXIh@pengutronix.de>
 <20241007113026.39c4a8c2@kmaincent-XPS-13-7390>
 <ZwPr2chTq4sX_I_b@pengutronix.de>
 <20241008122300.37c77493@kmaincent-XPS-13-7390>
 <20241008145617.23254843@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008145617.23254843@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2024 at 02:56:17PM +0200, Kory Maincent wrote:
> On Tue, 8 Oct 2024 12:23:00 +0200
> Kory Maincent <kory.maincent@bootlin.com> wrote:
> 
> > On Mon, 7 Oct 2024 16:10:33 +0200
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > 
> > > User will not understand why devices fail to provide enough power by
> > > attaching two device to one domain and not failing by attaching to
> > > different domains. Except we provide this information to the user space.
> > 
> > What you are explaining seems neat on the paper but I don't know the best way
> > to implement it. It needs more brainstorming.
> 
> Is it ok for you if we go further with this patch series and continue talking
> about PSE power domain alongside?
> It should not be necessary to be supported with port priority as the two PSE
> supported controller can behave autonomously on a power domain.
> I hope I will have time in the project to add its support when we will have a
> more precise idea of how.

Ok.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

