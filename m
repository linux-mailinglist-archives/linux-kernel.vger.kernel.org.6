Return-Path: <linux-kernel+bounces-433418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F569E5823
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F9B1881DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71FC218EA5;
	Thu,  5 Dec 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkPr4+ka"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF41A28D;
	Thu,  5 Dec 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407600; cv=none; b=r+7jp2OQHOYJTtsz0BvYpj9k70QrgbskO94RU9Cdl47IZZAfBTTklB3foS5iz2m9ayIFOyAkoU8Cr30u/4b3Gh/2rivyuf2HCSNVGaPfP5+kMX9r9PRJteO4FZGOVh8jx6uAM4s44uyZXeztnem3k/H1t+4kqnFQ/jdEGA+9ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407600; c=relaxed/simple;
	bh=WcnoYLiqVW6s8lhRqcE/XXO4eS3a+9cECImQbGvlOb4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZntGNpo4m67PlczNjKkyoFXNJHrO9cjrhmF/nl3vnnGB7VqP3NxIaub+wuw5zEEh8bEyGmWxEFK+STy7nUNWf4DiMrg1tqq7ffBG1vK4eB1CKD+BMOChjIgy/lzj/+OhjqO4z8kUDGtw7nRcNahSmiaSQvtFyhnID/ZrA86UAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkPr4+ka; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733407598; x=1764943598;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=WcnoYLiqVW6s8lhRqcE/XXO4eS3a+9cECImQbGvlOb4=;
  b=IkPr4+kaJDWxkVLl1Bi6NgLavaWmuxSPBoIY5zdHlvEH62QhCB811U9H
   VzCyb8qJ8M2bzAixDUzrAHrKZ/OHKLqxut0dranfQ0NaAYFd9SY5kk5WV
   U8QGD7kMNwlPVaVEujoiozRsKUYHt2AlLFF7Cdrlm1zcP6cK3QV547n3O
   QDR7rb0Vje8BdeTAp5kVdl2BbtNg0ceuzr4UiLklRilSk7SQRva5rBbpN
   V/+0G9zG4lX2E+utFoJc2mpL8O/v/Lb1kfkyeOQrOKyVm/uAWxy1Gt7Ia
   VxFBTdafwn01gMgv9QLggcBfzI9OGBON35h4wa2rD7JfOj3iXXNjh2asQ
   A==;
X-CSE-ConnectionGUID: Ka1RDkyaS5OeyZfRfeyOpw==
X-CSE-MsgGUID: PtiQ3jc4TtO+25ZZoEC1Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37656151"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="37656151"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 06:06:29 -0800
X-CSE-ConnectionGUID: ifWs9E5cS4aj8+rMaZRLbg==
X-CSE-MsgGUID: I2+xAJf9TTqvuNRhDZCwHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="117347994"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 06:06:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 16:06:23 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, 
    platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [RFC PATCH 16/21] alienware-wmi: Make running control state part
 of platdata
In-Reply-To: <foiw2np7nj2qefgdw7t43zuz5kujdgnsllutjqjdoq7i5tkrdy@zfu2pk43crzx>
Message-ID: <c0af93e4-f2a6-bf2e-787d-7a360286ac8a@linux.intel.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com> <20241205004534.2186539-2-kuurtb@gmail.com> <d0828df1-4a46-2cd3-f15a-b08e5d011bba@linux.intel.com> <foiw2np7nj2qefgdw7t43zuz5kujdgnsllutjqjdoq7i5tkrdy@zfu2pk43crzx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-824526675-1733405799=:932"
Content-ID: <046b9b25-2a2c-e6d9-bfca-cb6589f9dd06@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-824526675-1733405799=:932
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <741308fa-c092-775f-e5f1-47909671469a@linux.intel.com>

On Thu, 5 Dec 2024, Kurt Borja wrote:

> On Thu, Dec 05, 2024 at 01:32:46PM +0200, Ilpo J=E4rvinen wrote:
> > On Wed, 4 Dec 2024, Kurt Borja wrote:
> >=20
> > > Both WMI devices have a different "RUNNING" control state code. Make =
the
> > > WMI drivers decide which code to use, and refactor sysfs methods
> > > accordingly.
> > >=20
> > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > > ---
> > >  drivers/platform/x86/dell/alienware-wmi.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/plat=
form/x86/dell/alienware-wmi.c
> > > index 25e0139ed78c..fa21a50d66bd 100644
> > > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > > @@ -431,6 +431,7 @@ struct alienfx_platdata {
> > >  =09bool hdmi_mux;
> > >  =09bool amplifier;
> > >  =09bool deepslp;
> > > +=09u8 running_code;
> > >  };
> > > =20
> > >  static u8 interface;
> > > @@ -576,18 +577,18 @@ static ssize_t lighting_control_state_store(str=
uct device *dev,
> > >  =09=09=09=09=09    const char *buf, size_t count)
> > >  {
> > >  =09struct alienfx_priv *priv;
> > > +=09struct alienfx_platdata *pdata;
> > >  =09u8 val;
> > > =20
> > >  =09priv =3D dev_get_drvdata(dev);
> > > +=09pdata =3D dev_get_platdata(dev);
> > > =20
> > >  =09if (strcmp(buf, "booting\n") =3D=3D 0)
> > >  =09=09val =3D LEGACY_BOOTING;
> > >  =09else if (strcmp(buf, "suspend\n") =3D=3D 0)
> > >  =09=09val =3D LEGACY_SUSPEND;
> > > -=09else if (interface =3D=3D LEGACY)
> > > -=09=09val =3D LEGACY_RUNNING;
> > >  =09else
> > > -=09=09val =3D WMAX_RUNNING;
> > > +=09=09val =3D pdata->running_code;
> > > =20
> > >  =09priv->lighting_control_state =3D val;
> > >  =09pr_debug("alienware-wmi: updated control state to %d\n",
> > > @@ -1249,6 +1250,7 @@ static int legacy_wmi_probe(struct wmi_device *=
wdev, const void *context)
> > >  =09=09.hdmi_mux =3D quirks->hdmi_mux,
> > >  =09=09.amplifier =3D quirks->amplifier,
> > >  =09=09.deepslp =3D quirks->deepslp,
> > > +=09=09.running_code =3D LEGACY_RUNNING,
> > >  =09};
> > > =20
> > >  =09if (quirks->num_zones > 0)
> > > @@ -1333,6 +1335,7 @@ static int wmax_wmi_probe(struct wmi_device *wd=
ev, const void *context)
> > >  =09=09.hdmi_mux =3D quirks->hdmi_mux,
> > >  =09=09.amplifier =3D quirks->amplifier,
> > >  =09=09.deepslp =3D quirks->deepslp,
> > > +=09=09.running_code =3D WMAX_RUNNING,
> > >  =09};
> > > =20
> > >  =09if (quirks->thermal)
> > >=20
> >=20
> > I've not taken extensive look at interdependent changes in the series b=
ut=20
> > while reviewing patch 20/21 I noticed that alienfx_probe() changed ther=
e
> > from:
> >=20
> > -       if (interface =3D=3D WMAX)
> > -               priv->lighting_control_state =3D WMAX_RUNNING;
> > -       else if (interface =3D=3D LEGACY)
> > -               priv->lighting_control_state =3D LEGACY_RUNNING;
> >=20
> > to:
> >=20
> > +       priv->lighting_control_state =3D pdata->running_code;
>=20
> This was a workaround. I forgot to add this change in this patch. Also I'=
ll
> move this earlier in the series.
>=20
> >=20
> > Somehow, it felt odd and then looking this patch 16, it felt even odder=
=2E=20
>=20
> The reason behind this is that I don't want AlienFX related methods
> depending on global variables like `interface` so I can split the file
> cleanly.

Just to make sure we don't talk past each other, I didn't mean the code=20
itself felt odd, just the patch it was changed in. So if your plan was to=
=20
have it in this patch to begin with but you noticed the problem while=20
doing the other change and put it "temporarily" there and forgot to move=20
it into correct place, no oddity problem then. :-)

> > Perhaps there's a good reason my review that didn't go deep enough fail=
ed=20
> > to uncover but please check if this is an indication that something is =
a=20
> > miss in the series.
> >=20
>=20
> Thank you so much for commenting on the series!
>=20
> Also, what do you think about the general approach? I was a bit unsure
> about the whole "platdata" stuff, as not many drivers use it in this
> subsystem.

I'm sorry but I've not come across it much so I'm not sure if my opinion=20
is that valuable.

What I can say for sure though is that the wide-spread use of global-level=
=20
variables in pdx86 drivers is definitely not setting a good example.

--=20
 i.

--8323328-824526675-1733405799=:932--

