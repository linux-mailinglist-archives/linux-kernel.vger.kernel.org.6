Return-Path: <linux-kernel+bounces-435094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8819E6FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC8D16D61D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24355206F10;
	Fri,  6 Dec 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wJquaEgZ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4F1FCCFB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493203; cv=none; b=O5u4KSGTrnPHJr4X5R/monbasYcPzhKIIPQfHbwg2r2OwjtH/wOa6IYDK8ujPnfgBDSfplawvaoZnJbqIWhu+/sG5GKdtQsmyl/k3/rQlfq3o3irNiaIB8N7jms7BSGsCPiY7mBloajZdDU2uRvm4dgUeR+EyrKEZti7eJcdCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493203; c=relaxed/simple;
	bh=1OO1fi22KQhjYpjXXc0UuiOo2wcBVoYhgC5i5pB3Jac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNoOEmhDHfen4wA1GiW/TfqalcYnCUgZpm0UqbYdRgXxFxq46sJlRibgWHqXGbZ841/aSK9spLzYf8ipugBt1MysvukANq8rJN2TJz+sMjuUdy4zRQiI8VRFrf/umrzG0h+k0KOlqP4EFSS+GKqfiwiFnGQvdxkT8PstheFHXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wJquaEgZ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZbYJrhkQc0nvUHQDz7CHZJDyBA/Z0++rFcxDzUyd6KA=; b=wJquaEgZ8eQk7upw2fXmwkzvEb
	ROAcLrOufdlHgtSYsjWmNv5XPCMzML1UhZnRf+c1MBkbFItVt1uLgoF2IxvJOvK1Kk41XASnk/8ry
	2lRgNuW2aEDsIvGQb3kwfoeiZx/e1vSWU7KCwLQrVVrgwv5QqfuvggH18yy7WnbphtpbjdgERexro
	MBUZwdAqML56vLfu/UuWHMP3Bx4cbPTWkt4EgehUj5r6JwI36ud8GcbPdyLjahkAQP4yD3CDdDrhF
	oPQS9Yoi5Me8b6tK0G6FhSPKNkfAcCkMIKNKurGgEvZnGneNBWgBbSAD+pIvyUacvoUM7Qh5rh035
	2x89O6bw==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tJYld-0000cM-0l; Fri, 06 Dec 2024 14:53:13 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 2/2] phy: phy-rockchip-samsung-hdptx: Don't use dt aliases to
 determine phy-id
Date: Fri, 06 Dec 2024 14:53:12 +0100
Message-ID: <11259672.BaYr0rKQ5T@diego>
In-Reply-To: <87273a36-07f9-4224-bfff-63e905be9b0a@collabora.com>
References:
 <20241206103401.1780416-1-heiko@sntech.de>
 <20241206103401.1780416-3-heiko@sntech.de>
 <87273a36-07f9-4224-bfff-63e905be9b0a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Cristian,

Am Freitag, 6. Dezember 2024, 12:26:35 CET schrieb Cristian Ciocaltea:
> On 12/6/24 12:34 PM, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > 
> > The phy needs to know its identity in the system (phy0 or phy1 on rk3588)
> > for some actions and the driver currently contains code abusing of_alias
> > for that.
> > 
> > Devicetree aliases are always optional and should not be used for core
> > device functionality, so instead keep a list of phys on a soc in the
> > of_device_data and find the phy-id by comparing against the mapped
> > register-base.
> > 
> > Fixes: c4b09c562086 ("phy: phy-rockchip-samsung-hdptx: Add clock provider support")
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
> >  .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 50 ++++++++++++++++---
> >  1 file changed, 44 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> > index c5c64c209e96..b137f8c4d157 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> > @@ -385,11 +385,22 @@ enum rk_hdptx_reset {
> >  	RST_MAX
> >  };
> 
> [...]
> 
> > +
> > +	/* find the phy-id from the io address */
> > +	hdptx->phy_id = -ENODEV;
> > +	for (id = 0; id < hdptx->cfgs->num_phys; id++) {
> > +		if (res->start == hdptx->cfgs->phy_ids[id]) {
> > +			hdptx->phy_id = id;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (hdptx->phy_id < 0)
> > +		return dev_err_probe(dev, -ENODEV, "no matching device found\n");
> 
> Maybe we could simply fallback to assume phy1 doesn't exist in this
> case, which avoids the need to provide a match data with a single entry.

Personally I'm a fan of consistent behaviour, not things working
accidentially ;-) . See the usbdp phy for example, also declaring just
one phy using the same mechanism.

Also I really don't trust the hdptxphy-grf being stable over time.
Rockchip engineers always move bts around in those, so there will be a
need for platform-data at some point anyway.


> Regardless,
> 
> Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

thanks :-)

Heiko



