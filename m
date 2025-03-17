Return-Path: <linux-kernel+bounces-565154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004D8A661E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86BF189AA88
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7EA1F63F0;
	Mon, 17 Mar 2025 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Tfs+PypC"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA5946F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251486; cv=none; b=GUs9ombaPXmdG+wdtBInEn3xzkHCJE3QtW7KMXhfqFIOR47aHa9k0SAv0kgXp+HEaXQR5p48eYMPCq6MDTkGMFy4bAKe/uoz/rU+W5W+oenk7/4pLV2xcOHkRRtEwtQkq9KRzAH+k339Mkwb+iaWI1mwHB7u0uAw5Mb3QK/puGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251486; c=relaxed/simple;
	bh=GIa4+70HaoeLJA3SQUbd+Njvuh3wwoPCbP1yH7ozI7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfYESA9xTL0nitgwdlqo83IdEzZAvSOzWTioA75Ju6tFJF8CO3SMPzM5FGErxwIlcqt7l9R1w0bAxFeemweaLv5y8HOOv+Ho69Cu1zgm9hiUPrA1SxV4246EySyM9qOsZoWjkGJ8g+IIvLpALc92s5CfZe9/vNTCxe5Sef7fuAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tfs+PypC; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 003134327A;
	Mon, 17 Mar 2025 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742251482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+DFeujrXddI7AipEE/U92hGOn892c6Z6ywxYR+W8kOo=;
	b=Tfs+PypCiW8O+ZQMtkwQpPVVdplJ32j+A9AbS/L54/ahVfEVwfQxYmrrPGChYvYycZbqI8
	zOjlT1VjUt+TP3vODZW5MLBDr6qJlSs7dNtoEMX+KCfnUT33Qtgsu7F3hMlJfnkkmrfLxs
	8GNKL22nEhs8D5cKLXWNQBPH+Dbc/rnqDFF4FKJ0u8g12Egkb/AYqamsAGElcc4GX4GMkD
	9IK0pYXFomv7ysuPvNwuPCfxm5Nb/12DjxvbRO/o5SIivMjcnO6uOeLwcaiiTaTknfdu2G
	HKvJHMeSQmQG+ee2keSyeeZbH41Cc/qbUCNskuDW0be9gNSpboZUVp1C6YgDCA==
Date: Mon, 17 Mar 2025 23:44:40 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Stanley Chu <stanley.chuys@gmail.com>, miquel.raynal@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v1 1/3] i3c: master: svc: Fix missing the IBI rules
Message-ID: <20250317224440840e4117@mail.local>
References: <20250317051951.3065011-1-yschu@nuvoton.com>
 <20250317051951.3065011-2-yschu@nuvoton.com>
 <Z9glVBnpdwXuLwD7@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9glVBnpdwXuLwD7@lizhi-Precision-Tower-5810>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiudeuteehhfekgeejveefhfeiudejuefhgfeljefgjeegkeeujeeugfehgefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemvdgumeeifeejtdemjeekvgdtmegttdgvkeemvdektdeimeekrggtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdgumeeifeejtdemjeekvgdtmegttdgvkeemvdektdeimeekrggtiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopefhrhgrnhhkrdhlihesnhigphdrtghomhdprhgtphhtthhopehsthgrnhhlvgihrdgthhhuhihssehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihn
 hgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhifegtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhgvrhdrmhgrihhmohhnsehnuhhvohhtohhnrdgtohhmpdhrtghpthhtohepkhiflhhiuhesnhhuvhhothhonhdrtghomhdprhgtphhtthhopeihshgthhhusehnuhhvohhtohhnrdgtohhm
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello Frank,

On 17/03/2025 09:36:20-0400, Frank Li wrote:
> On Mon, Mar 17, 2025 at 01:19:49PM +0800, Stanley Chu wrote:
> > From: Stanley Chu <yschu@nuvoton.com>
> >
> > The code does not add IBI rules for devices with controller capability.
> > However, some target devices, such as secondary controller, also have
>                 ^^ dual rule devices
> 
> OR
> 
> However, the second controller have the controller capablity and work at
> target devices mode when the device probe. So add IBI rules for such
> devices.
> 
> 
> > the controller capability.
> > Modify the code to add rules for devices capable of sending IBI requests.
> >
> > Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> 
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Please avoid adding you reviewed-by tag when you request changes, else
patch work will show the patch as being applicable. This is fine to do
it occasionally but not for all the patches you review. You can simply
wait for the next version to come.

> 
> 
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > index 1d1f351b9a85..a72ba5a7edd4 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -1106,7 +1106,7 @@ static int svc_i3c_update_ibirules(struct svc_i3c_master *master)
> >
> >  	/* Create the IBIRULES register for both cases */
> >  	i3c_bus_for_each_i3cdev(&master->base.bus, dev) {
> > -		if (I3C_BCR_DEVICE_ROLE(dev->info.bcr) == I3C_BCR_I3C_MASTER)
> > +		if (!(dev->info.bcr & I3C_BCR_IBI_REQ_CAP))
> >  			continue;
> >
> >  		if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD) {
> > --
> > 2.34.1
> >

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

