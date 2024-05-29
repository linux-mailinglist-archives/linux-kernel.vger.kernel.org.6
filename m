Return-Path: <linux-kernel+bounces-194437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C84928D3C32
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D301F23646
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49931836E7;
	Wed, 29 May 2024 16:24:43 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B931181B8B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999883; cv=none; b=hFVnOU7ScUPyhGfvfy19knz1PiyvlpJX+v7a/S+m/ajXBAE2yeeTjaYpNXTdHgHOcwt6QzIE/v1a+FWAQfgIyS7Pn/VjE2bkXhl7HNM5P3/D3WHebSxb7tIkWV7pSAsJwQooPeLAVovjG5pN50KbidjcphokTlO32JtF2KO8fwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999883; c=relaxed/simple;
	bh=BNLah/QDHzx6qCWDqnWrCWU9HLpUvuMNchraD+Ektj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oC5eqseqc+j3lPrSnl2Q/TTfMOBrRBw2iz4sjR6cEkldIdEQbM3ZhxtNn37dVGKgITTesSFtwH5FIr8WpG2qJCKRoaerCywYeyuxMecVqO3Mg34g1qJxWqcYkx85YwoSvSyppfQrkkUoIvsfYIk8tXAicZtFkH5JgHWYasxMD2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a0e.versanet.de ([83.135.90.14] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sCM69-0005AH-Ga; Wed, 29 May 2024 18:24:21 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>, linux-rockchip@lists.infradead.org,
 Diederik de Haas <didi.debian@cknow.org>, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org, s.hauer@pengutronix.de,
 Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH 0/1] Fix the port mux of VP2
Date: Wed, 29 May 2024 18:24:20 +0200
Message-ID: <2652218.tIAgqjz4sF@diego>
In-Reply-To: <2397969.FhQbyb98Gs@bagend>
References:
 <20240422101905.32703-1-andyshrk@163.com>
 <171405838036.2897712.4067984796758491640.b4-ty@sntech.de>
 <2397969.FhQbyb98Gs@bagend>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 29. Mai 2024, 17:55:25 CEST schrieb Diederik de Haas:
> On Thursday, 25 April 2024 17:19:58 CEST Heiko Stuebner wrote:
> > On Mon, 22 Apr 2024 18:19:04 +0800, Andy Yan wrote:
> > > From: Andy Yan <andy.yan@rock-chips.com>
> > > 
> > > The port mux bits of VP2 should be defined by
> > > RK3568_OVL_PORT_SET__PORT2_MUX, this maybe a copy and paste error when
> > > this driver first introduced.> 
> > > Hi Heiko:
> > >    Maybe thi is the problem you met when you porting the dsi2 driver.
> > > 
> > 
> > Applied, thanks!
> > 
> > [1/1] drm/rockchip: vop2: Fix the port mux of VP2
> >       commit: 2bdb481bf7a93c22b9fea8daefa2834aab23a70f
> 
> Wasn't this patch supposed to be part of 6.10-rc1?

Looking at the drm-misc tree, the last tag for the drm-misc to drm-main
merge is labeled drm-misc-next-2024-04-25, same day as I applied the
patch.

In theory I think -rc6 is the cutoff for drm-misc changes for mainline,
which would've been the 28th of april, but there might've been simple
hickups preventing that last merge, resulting in the patch missing an
early cutoff.


On the other hand, somehow Torvald's tree actually has this commit [0],
just with a "Notice: this object is not reachable from any branch."
Possibly some drm-merge-mayhem?

All very confusing.

@Thomas, @Marten: do you possible have an idea what might've happened?


Heiko




[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2bdb481bf7a93c22b9fea8daefa2834aab23a70f



