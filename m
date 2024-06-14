Return-Path: <linux-kernel+bounces-214839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1CB908AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BBF21F22590
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D28195969;
	Fri, 14 Jun 2024 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R28OVEM3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BBB14D29B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364972; cv=none; b=XIFg4VYntQ2uBSMtZztHP063e5CowmRumoK8cc9R1k7QQnK7qSk/u1XsqIPXb5uh9UWYfBkv7yEH23RDTp/Oq9NDmGn/CIjqM7uiSB6dqX1V09KuXZys8d8chHaaC2AYPI5XDDeDRg/inVZGke0y2xgxrfzjnc3OUu+6AbYZE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364972; c=relaxed/simple;
	bh=D57VW2tUjXTLhv/XmrfsMmV1i/cLw0/QIlJ1ekguQ3s=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=QEh8J7HRoVlyDfmmfV39ZuPG0Mh0NlqycLfAdM0Z0EMbLV/VipKwon9Sk4C2WWsfd/bNswY6/81rzwObhFqlEnnD7jrivjgjMK6aQvgiOKzyEZlUjlR/Pdjn5SY2wlu94A6lHql6yRjiHQ+L3WXuf59yQd/IdXtC5MZyVzJCuXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=R28OVEM3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6CCFB397;
	Fri, 14 Jun 2024 13:35:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718364953;
	bh=D57VW2tUjXTLhv/XmrfsMmV1i/cLw0/QIlJ1ekguQ3s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=R28OVEM3qBRkruo0lA6efSJ2h9zoPF5nl4sscfD4VdZW2fa+hs0GuZapUSTLcRXkF
	 /xXdu9zC89vz1FYULTc2RdsSuBLryN6j9EjvVdpwuTLQpAS5p6fgs2HA2WnROTV/LW
	 RZxsfr/a0L3oHAIPMQOv2lQrHjRdeK27wKQ2V5YQ=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <082d9df0-0947-4452-a3fc-87eab2019e01@gmx.net>
References: <20240613194150.2915202-1-kieran.bingham@ideasonboard.com> <20240613194150.2915202-2-kieran.bingham@ideasonboard.com> <082d9df0-0947-4452-a3fc-87eab2019e01@gmx.net>
Subject: Re: [PATCH] staging: vc04_services: vchiq_arm: Fix initialisation check
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dave Stevenson <dave.stevenson@raspberrypi.org>, detule <ogjoneski@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>, open list:STAGING SUBSYSTEM <linux-staging@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>;
To: Florian Fainelli <florian.fainelli@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, Umang Jain <umang.jain@ideasonboard.com>, linux-rpi-kernel@lists.infradead.org
Date: Fri, 14 Jun 2024 12:36:05 +0100
Message-ID: <171836496531.2248009.11650291484570726735@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Hi Stefan,

Sorry, indeed I completely missed this mail.

Quoting Stefan Wahren (2024-06-13 21:01:42)
> Hi Kieran,
>=20
> Am 13.06.24 um 21:41 schrieb Kieran Bingham:
> > The vchiq_state used to be obtained through an accessor
> > which would validate that the VCHIQ had been initialised
> > correctly with the remote.
> >
> > In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
> > vchiq_state") the global state was moved to the vchiq_mgnt structures
> > stored as a vchiq instance specific context. This conversion removed the
> > helpers and instead replaced users of this helper with the assumption
> > that the state is always available and the remote connected.
> >
> > Fix this broken assumption by re-introducing the logic that was lost
> > during the conversion.
>=20
> thank you for sending this patch. Maybe it's worth to mention that this
> patch also drop some unnecessary NULL checks of state.

I don't understand this comment. Nothing is dropped is it?

The newly added vchiq_remote_initialised() is itself a null-check too!

> > Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to vc=
hiq_state")
> > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > ---
> >   .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 4 ++--
> >   .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 5 +++++
> >   .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c  | 7 ++++++-
> >   3 files changed, 13 insertions(+), 3 deletions(-)
> >
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
> > @@ -1299,7 +1299,7 @@ void vchiq_dump_platform_instances(struct vchiq_s=
tate *state, struct seq_file *f
> >   {
> >       int i;
> >
> > -     if (!state)
> > +     if (!vchiq_remote_initialised(state))
> >               return;
> >
> >       /*
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_co=
re.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> > index 8af209e34fb2..382ec08f6a14 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> > @@ -413,6 +413,11 @@ struct vchiq_state {
> >       struct opaque_platform_state *platform_state;
> >   };
> >
> > +static inline bool vchiq_remote_initialised(const struct vchiq_state *=
state)
> > +{
> > +     return state->remote && state->remote->initialised;
> > +}
> > +
> >   struct bulk_waiter {
> >       struct vchiq_bulk *bulk;
> >       struct completion event;
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> > index 3c63347d2d08..8c4830df1070 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> > @@ -1170,6 +1170,11 @@ static int vchiq_open(struct inode *inode, struc=
t file *file)
> >
> >       dev_dbg(state->dev, "arm: vchiq open\n");
> >
> > +     if (!vchiq_remote_initialised(state)) {
> > +             dev_err(state->dev, "arm: vchiq has no connection to Vide=
oCore\n");
> Can you please downgrade the log level to dev_dbg, because vchiq_open is
> called from userspace, so we can prevent log spamming?

Sure.

> > +             return -ENOTCONN;
> > +     }
> > +
> >       instance =3D kzalloc(sizeof(*instance), GFP_KERNEL);
> >       if (!instance)
> >               return -ENOMEM;
> > @@ -1200,7 +1205,7 @@ static int vchiq_release(struct inode *inode, str=
uct file *file)
> >
> >       dev_dbg(state->dev, "arm: instance=3D%p\n", instance);
> >
> > -     if (!state) {
> > +     if (!vchiq_remote_initialised(state)) {
> >               ret =3D -EPERM;
> >               goto out;
> >       }
>

