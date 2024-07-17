Return-Path: <linux-kernel+bounces-255790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC84934541
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9372828EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30911FA1;
	Thu, 18 Jul 2024 00:03:00 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420DA110A;
	Thu, 18 Jul 2024 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260980; cv=none; b=h86QYI04oIUW5GeIay9Bgd4eNMmSXqDpzrSKufitNcPTgm/NkPhakct1OqbqKMhyUIP0H06A2WkLamtW7HHE8TB5n7aZ/s1HOs5CPCl2hC6TsvMjG1+D2jQ164yH5sCats1vG5XW31VDtXUaTe98KwZtIWDHCW28g69XuJW1D1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260980; c=relaxed/simple;
	bh=VjUGKZ3qVd+2tzNkMyHtQ4ZoixFDGkxiFILn0GlzxgQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mAChWZ42siDZpge7S5tIugP9S4+Uy1cjvS5xv5yo9O6Omb9Hv3IcyXuM0PnYouqRxmeQnjw3B2Xed4AjvRXD1hQ2v3il10z70JUKzkfVVPK2bBusSv3bXPZlqvByyuLlG3cosvf3J75FD408NkZPnfvgRXoQa5ZzPlZeeWabHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b693a1.dsl.pool.telekom.hu [::ffff:81.182.147.161])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000073351.0000000066985A7C.001802A6; Thu, 18 Jul 2024 01:57:48 +0200
Message-ID: <4fc2a95afd8f852c8dff1a95ddc54f56cea5c0ed.camel@irl.hu>
Subject: Re: [PATCH 3/4] platform/x86: ideapad-laptop: move ymc_trigger_ec
 from lenovo-ymc
From: Gergo Koteles <soyer@irl.hu>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
  Ike Panhc <ike.pan@canonical.com>,
  platform-driver-x86@vger.kernel.org,
  LKML <linux-kernel@vger.kernel.org>
Date: Thu, 18 Jul 2024 01:57:47 +0200
In-Reply-To: <828057ef-b941-879e-170e-f4e769d4b77a@linux.intel.com>
References: <cover.1720515666.git.soyer@irl.hu>
	 <44f63dfa758c811ae941216874fbb1ec77f4a293.1720515666.git.soyer@irl.hu>
	 <828057ef-b941-879e-170e-f4e769d4b77a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ilpo,

Thanks for the review.

On Thu, 2024-07-11 at 11:18 +0300, Ilpo J=C3=A4rvinen wrote:
> On Tue, 9 Jul 2024, Gergo Koteles wrote:
>=20
> > Some models need to trigger the EC for the yoga mode control to work
> > properly. EC triggering consists of a VPC call that needs to be
> > synchronized. The vpc_mutex is in the ideapad-laptop module, so
> > synchronization is easier there.
> >=20
> > Move the ymc_trigger_ec function to the ideapad-laptop module.
> >=20
> > Signed-off-by: Gergo Koteles <soyer@irl.hu>
> > ---
> >  drivers/platform/x86/Kconfig          |  1 +
> >  drivers/platform/x86/ideapad-laptop.c | 18 ++++++++++++++
> >  drivers/platform/x86/ideapad-laptop.h |  2 ++
> >  drivers/platform/x86/lenovo-ymc.c     | 34 ++++-----------------------
> >  4 files changed, 26 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 665fa9524986..ddfccc226751 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -477,6 +477,7 @@ config LENOVO_YMC
> >  	tristate "Lenovo Yoga Tablet Mode Control"
> >  	depends on ACPI_WMI
> >  	depends on INPUT
> > +	depends on IDEAPAD_LAPTOP
> >  	select INPUT_SPARSEKMAP
> >  	help
> >  	  This driver maps the Tablet Mode Control switch to SW_TABLET_MODE i=
nput
> > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x=
86/ideapad-laptop.c
> > index 464cc5fd0088..4dcdbb153dda 100644
> > --- a/drivers/platform/x86/ideapad-laptop.c
> > +++ b/drivers/platform/x86/ideapad-laptop.c
> > @@ -1615,6 +1615,24 @@ static void ideapad_sync_touchpad_state(struct i=
deapad_private *priv, bool send_
> >  	priv->r_touchpad_val =3D value;
> >  }
> > =20
> > +void ideapad_ymc_trigger_ec(void)
> > +{
> > +	struct ideapad_private *priv;
> > +	int ret;
> > +
> > +	guard(mutex)(&ideapad_shared_mutex);
> > +
> > +	priv =3D ideapad_shared;
> > +	if (!priv)
> > +		return;
> > +
> > +	scoped_guard(mutex, &priv->vpc_mutex)
>=20
> It feels the ordering in this series is off because patch 2 add the=20
> mutex and here you add it into yet another function. If this patch=20
> would be before the other, the mutex changes could all go into the same=
=20
> patch.
>=20

I (wrongly) thought it would be easier to explain why a new dependency
is needed.=20
Mutex changes go into one patch in the v2.


> > +		ret =3D write_ec_cmd(priv->adev->handle, VPCCMD_W_YMC, 1);
> > +	if (ret)
> > +		dev_warn(&priv->platform_device->dev, "Could not write YMC: %d\n", r=
et);
> > +}
> > +EXPORT_SYMBOL_GPL(ideapad_ymc_trigger_ec);
>=20
> This export should be namespaced.

It will be in the v2.

>=20
> I'll have to say I can accept this approach only grudgingly... it feels=
=20
> off even if I understand why you have to do this cross driver thing.
>=20

Based on the WMI driver development guide, I will add a notification
chain in v2 soon. Looks better.

Best Regards,
Gergo Koteles


