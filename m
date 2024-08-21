Return-Path: <linux-kernel+bounces-295047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BF595960F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE4B2899AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6067B1B81DD;
	Wed, 21 Aug 2024 07:26:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD21B81D6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225172; cv=none; b=RCS5IHMDUKEc3a5DPoeCOoYfkQhOMPDDDW4SVYtXE086UtutyC7xw/zkjLim3eLZQNWBRJDUGDPLn9rUmNcCXQ9zgnn8g4Kv0bILsvdnb9EZsyD1O4px3+FRcha2hxS3McfSwLfnrBR68jd6rTY5RmZLnMh7YM0b+6SAZQNF1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225172; c=relaxed/simple;
	bh=i4givOFpoIFYH4oJJeUES8CCDV6YYBw1Dn8HLriMbKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iuq23Nd2grDKe0xEc6mX/y1Y56yOJkqsIefTrrYSTu1r4LUGb9Rjq7qujzFfwvrqZruyrgN0+B03BsEpW8tNfe5Ns89YRhb9T9dmi9W1TLgj3MNjIxJKY03buJIaV+E1uWzJRV/vXaI0GceYK1/DWzq7iDRbts3zE+yobhxvnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1sgfjD-0007np-PK; Wed, 21 Aug 2024 09:25:59 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1sgfjD-001xSa-9d; Wed, 21 Aug 2024 09:25:59 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1sgfjD-00FPfV-0b;
	Wed, 21 Aug 2024 09:25:59 +0200
Date: Wed, 21 Aug 2024 09:25:59 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/3] serdev: ttyport: make use of tty_kopen_exclusive
Message-ID: <20240821072559.lh5lt3mnhrit5gmp@pengutronix.de>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <20240807-v6-10-topic-usb-serial-serdev-v1-1-ed2cc5da591f@pengutronix.de>
 <c7a710ec-f391-4726-910e-d7bedbfc6a6f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a710ec-f391-4726-910e-d7bedbfc6a6f@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-08-08, Jiri Slaby wrote:
> On 07. 08. 24, 16:08, Marco Felsch wrote:
> > The purpose of serdev is to provide kernel drivers for particular serial
> > device, serdev-ttyport is no exception here. Make use of the
> > tty_kopen_exclusive() funciton to mark this tty device as kernel
> > internal device.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >   drivers/tty/serdev/serdev-ttyport.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> > index 3d7ae7fa5018..94c43d25ddbe 100644
> > --- a/drivers/tty/serdev/serdev-ttyport.c
> > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > @@ -103,11 +103,14 @@ static int ttyport_write_room(struct serdev_controller *ctrl)
> >   static int ttyport_open(struct serdev_controller *ctrl)
> >   {
> >   	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> > +	struct tty_driver *tty_drv = serport->tty_drv;
> >   	struct tty_struct *tty;
> >   	struct ktermios ktermios;
> > +	dev_t dev;
> >   	int ret;
> > -	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
> > +	dev = MKDEV(tty_drv->major, tty_drv->minor_start + serport->tty_idx);
> > +	tty = tty_kopen_exclusive(dev);
> 
> I believe that the now added tty_lookup_driver() has negligible impact in
> this anyway slow path, right?

Any other comments, suggestions apart this one?

Regards,
  Marco

> 
> thanks,
> -- 
> js
> suse labs
> 
> 

