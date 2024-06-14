Return-Path: <linux-kernel+bounces-214811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3800908A60
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA8D28268B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7FF1953A1;
	Fri, 14 Jun 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LdJOG65Y"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9812E61
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361936; cv=none; b=VMv1lWzMCs8GlAlb+PyzgORYEHuy21IjkaMvjLbJ4yGxaqccqzrfWhQJlV46elapbDTa9h24vZKU4y/m/Kz7QbI0iEn65QYR84NQSUS7jtbSBSsQMA+EXLAZUPcnpycoV6Put4CeHKCPlSe9bWlj16wfvZRsJ6/wt9TQgY0RsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361936; c=relaxed/simple;
	bh=7lzRe+1E0JegteQZ9jcjULYUBZjEYPgjtxe0zFeptVU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=HMl28+7+ENEVDr+aKat8pGM6aKea2EkNiTi+EEkzLWWvJWJe9/I6L74VY1ptP2eHHlouC1ydeGactW/Sq+35jA6swIzck6BT8izLv4GNxuv5Ki5vPAAo9qQE3zWnS3hpCR0G3quib6su7NwG9/rkWYLNGBJiNZ60NQmSvNOOSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LdJOG65Y; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9BEDCB53;
	Fri, 14 Jun 2024 12:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718361918;
	bh=7lzRe+1E0JegteQZ9jcjULYUBZjEYPgjtxe0zFeptVU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=LdJOG65Y0oSetUsi2iJD9sdscWmjuaXvkvi/XZ3lrLEBF8cWLpF6xeF5fGOgLtmBy
	 xgc/EadHfc8StTjWWPcZRIjBEvYCIrWWPWC8W85IlsEaQcz5HIsVGXSiitJ0Wu4jY+
	 8Dcqiqw6sGbjrKmfUebvZNqIS+Sx7ATFT6H8+3GU=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a440cbf7-c6d5-4286-a69f-05e668522931@moroto.mountain>
References: <20240613194150.2915202-1-kieran.bingham@ideasonboard.com> <a440cbf7-c6d5-4286-a69f-05e668522931@moroto.mountain>
Subject: Re: [PATCH] staging: vc04_services: vchiq_arm: Fix initialisation check
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>, Florian Fainelli <florian.fainelli@broadcom.com>, linux-rpi-kernel@lists.infradead.org, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stefan Wahren <wahrenst@gmx.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dave Stevenson <dave.stevenson@raspberrypi.org>, detule <ogjoneski@gmail.com>, moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>, open list:STAGING SUBSYSTEM <linux-staging@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>;
To: Dan Carpenter <dan.carpenter@linaro.org>
Date: Fri, 14 Jun 2024 11:45:30 +0100
Message-ID: <171836193023.2248009.1498291832866754294@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Dan Carpenter (2024-06-13 20:58:40)
> On Thu, Jun 13, 2024 at 08:41:45PM +0100, Kieran Bingham wrote:
> > ---
> >  .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 4 ++--
> >  .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 5 +++++
> >  .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c  | 7 ++++++-
> >  3 files changed, 13 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ar=
m.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > index 54467be8c371..67d853f5f2a0 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > @@ -804,7 +804,7 @@ int vchiq_initialise(struct vchiq_state *state, str=
uct vchiq_instance **instance
> >        * block forever.
> >        */
> >       for (i =3D 0; i < VCHIQ_INIT_RETRIES; i++) {
> > -             if (state)
> > +             if (vchiq_remote_initialised(state))
> >                       break;
> >               usleep_range(500, 600);
> >       }
>=20
> :/  In the original code, this would either break on the first iteration
> or fail.  The diff looked like this:
>=20
>         for (i =3D 0; i < VCHIQ_INIT_RETRIES; i++) {
> -               state =3D vchiq_get_state();
>                 if (state)
>                         break;
>=20
> I feel bad for not spotting this.  A static checker which looked at

Definitely don't feel bad - I'm pretty sure I looked through the patch
on it's way through too and missed it then!

I only spotted this once I went deeper and was doing more rework, so it
suddenly stood out with more context.

Unfortunately - it's one of the pains of limited context in diffs in a
mail client I think.

--
Kieran


> diffs could have made this work, but all of our tools look at a momement
> in time instead of looking at the change over time.
>=20
> regards,
> dan carpenter
>

