Return-Path: <linux-kernel+bounces-435429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331019E7782
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE79F287A43
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83B42206A4;
	Fri,  6 Dec 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="OAsSaXPm"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D4A220683
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506619; cv=none; b=TBv8qV3bR7e/LiV4FgV0PCHd3U8SG6SivjKR8Ih5P2OAfVbgJ9cJOQ/58v/92IJCiHEc0UVaNQN2FSen3599+USPISFGI47jkEuC/RAcIQwoO5IUvufrxj26BtHUmIROV84aMW88oTOnQApSCiQF6DzZTs9v5C5nmbiXC2Kuhrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506619; c=relaxed/simple;
	bh=k0Ck9hhSE+pXdvPn6NW0n+iJgQ8WhN1qYv0YO2/srL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3WBaD3PsqiTxZL0xQwshEKuCnBKinn7ycTs+CPD2RoDBh5ofCEcRj85wg2OC03fubiqEOcDtm3IRBn87GNZa1fJLtshqivmZT/shiMyFjbQXgHsc9OwWxmhVY09+xOh3QW+S4fx+Z5Hvrd7F7l16dkxlCQCKIP9y6vOLmIgJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=OAsSaXPm; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jQPhfD23YTFu2k8PG7PzToLjH9H9SzaXg3NW46Iyzwk=; b=OAsSaXPmNKWbDvZAt2FfJrx+NN
	INUzGPq8N1RuCnmRfnPcnrecc3H2wSuYkENTEjfdewM3VyK/Ta145Y7zhhTcdaWfHXXpYcz4er1Ol
	mcWZFZtppOyfOt+L0KXOI9MLHQntSMP38xR/IOMzod27BqxmTJ3dGavZmQorAtPvY31bRmcC7eR2i
	r6WrGUjO46+7E6vTrc4oLURq4lgF7mj56R4Z4997/z2/UrS+zpBcfqAVZISIOszZRRfKMfowKEBET
	Uc3qFkGmmBCuRfF+DCzrOwDMWB+ho1+Id9Ey2E/MGzXC+x4YZV9DlSG1LhENOUcXRQkxhZ1hDSyHj
	9KxtPopQ==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tJcG1-00032U-VI; Fri, 06 Dec 2024 18:36:50 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 1/2] phy: phy-rockchip-samsung-hdptx: annotate regmap
 register-callback
Date: Fri, 06 Dec 2024 18:36:49 +0100
Message-ID: <2287157.Dhsi8hcfAM@diego>
In-Reply-To: <e6172204-2f3f-4a9c-892c-be85d19ad031@collabora.com>
References:
 <20241206103401.1780416-1-heiko@sntech.de>
 <20241206103401.1780416-2-heiko@sntech.de>
 <e6172204-2f3f-4a9c-892c-be85d19ad031@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 6. Dezember 2024, 12:18:56 CET schrieb Cristian Ciocaltea:
> On 12/6/24 12:34 PM, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > 
> > The variant of the driver in the vendor-tree contained those handy
> > comments in the regmap register callback. Having the different ranges
> > describe what they are looks helpful.
> > 
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
> >  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> > index 4ced1479e2dc..c5c64c209e96 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> > @@ -766,13 +766,13 @@ static struct tx_drv_ctrl tx_drv_ctrl_hbr2[4][4] = {
> >  static bool rk_hdptx_phy_is_rw_reg(struct device *dev, unsigned int reg)
> >  {
> >  	switch (reg) {
> > -	case 0x0000 ... 0x029c:
> > -	case 0x0400 ... 0x04a4:
> > -	case 0x0800 ... 0x08a4:
> > -	case 0x0c00 ... 0x0cb4:
> > -	case 0x1000 ... 0x10b4:
> > -	case 0x1400 ... 0x14b4:
> > -	case 0x1800 ... 0x18b4:
> > +	case 0x0000 ... 0x029c: /* CMN Register */
> > +	case 0x0400 ... 0x04a4: /* Sideband Register */
> > +	case 0x0800 ... 0x08a4: /* Lane Top Register */
> > +	case 0x0c00 ... 0x0cb4: /* Lane 0 Register */
> > +	case 0x1000 ... 0x10b4: /* Lane 1 Register */
> > +	case 0x1400 ... 0x14b4: /* Lane 2 Register */
> > +	case 0x1800 ... 0x18b4: /* Lane 3 Register */
> >  		return true;
> >  	}
> >  
> 
> Nice finding!  The HDMI variant of the driver which I used as an
> implementation reference (i.e. phy-rockchip-samsung-hdptx-hdmi.c)
> doesn't provide these comments.

yep, those comments were in the displayport variant of the phy-driver ;-) .
I don't really understand why the vendor tree contains 2 separate drivers
written by two different people, but at least it looks like we're getting
one driver in mainline, thanks to Damon's work :-)




