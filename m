Return-Path: <linux-kernel+bounces-245452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B58792B2AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4BC280F24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ACB15382F;
	Tue,  9 Jul 2024 08:55:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F415358A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515312; cv=none; b=JAQ948i0q0lEMQegDoSEuvWtQAKj5J5utDXQMA3E+gUjjVYhID6Lz1lZDOAkviyEGRTR3NNLO9MhnSfpjB+uNkgtzWhN10O0e8GOXMk5zUZlTwvVNgba8MFqRqEeshfyBxLYiAZQz8n86XrV40H6HttM4a0AOUCocaFRgLgvYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515312; c=relaxed/simple;
	bh=2FYVMtmDzIZUKIJ+dabrFKImBJRSm71ljP7ZDyoecE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGOx9e3AYyKHc65Oa8k6gVKcDql1tMXEIXG6uGrSzfol5zpFcy7dcTrm2y/7E3addwy+yDYZW1HGpZp7am7d5og6WrEFtmtx/abY+z2y2Bxf75y0OcDvVhGdiMgrdjPtjex6x4HqASdjyJWdL8xxCE7/X96pIqvt0Ls8ZkHGSck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1sR6cj-0001sa-Fu; Tue, 09 Jul 2024 10:54:57 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1sR6cg-008F2O-FK; Tue, 09 Jul 2024 10:54:54 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1sR6cg-006TZB-1F;
	Tue, 09 Jul 2024 10:54:54 +0200
Date: Tue, 9 Jul 2024 10:54:54 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Horia Geanta <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: caam - enable hash api only on ARM platforms per
 default
Message-ID: <20240709085454.you3b3ueb3xbtrv6@pengutronix.de>
References: <20240626155724.4045056-1-m.felsch@pengutronix.de>
 <258feb43-382d-4ea0-9164-357924350dec@nxp.com>
 <ZofSbH2Fu/xLnzif@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZofSbH2Fu/xLnzif@gondor.apana.org.au>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-07-05, Herbert Xu wrote:
> On Fri, Jul 05, 2024 at 09:39:19AM +0000, Horia Geanta wrote:
> >
> > I disagree with compiling out the hash support.

We don't compile it out, we just don't set the default=y since on ARMv8
it's not required.

> > If needed, algorithm priority could be changed - even at runtime,
> > using NETLINK_CRYPTO messages (needs CONFIG_CRYPTO_USER=y/m).
> 
> We should change the default priority.

We had an patch exactly doing this but depending on the SoC the default
prio may valid since the CAAM is used on ARMv7 and ARMv8 NXP SoCs. To
not cause any regression we went this way.

Regards,
  Marco

> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 

