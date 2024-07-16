Return-Path: <linux-kernel+bounces-253669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D7A932497
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA123B2360D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22760198E78;
	Tue, 16 Jul 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJUOu5/R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B41CFBE;
	Tue, 16 Jul 2024 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127971; cv=none; b=rrNvMSJ4Nf38CAvBlR5+VQiicqLuYrao58HXNxMz1wfbLsg24xPsio5MAnJP7dkXzPEs/rZYlUlEJJqkc+2UQdgyJQysBLhTeeLDNTbFuYqFrNeeDKuwhZvAf6Mz7D6SO1mewanOkSG5F14eoeLD0NrIOdlBVHc6amqMpk0eXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127971; c=relaxed/simple;
	bh=iVjizggjH/Quf+RBaM03/SUpOL20rM3KHOb614Ik3dM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WIr/ZlxX9WCKuhyc9Vg1LKPSfJVGGbFogecir2N4aDW43bvJ9jo8CtlIjCHqR+yT/LZfrDZFgLQfsmaqHDyJKnoEXtGf1SJ4WWdj/Nvi8TBHGu3m0DtNcbpVGXw/+WaWkakjjgevwQ/DzTx6add3YQ/sC/lvBC9AGkRSQcQypDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJUOu5/R; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721127969; x=1752663969;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iVjizggjH/Quf+RBaM03/SUpOL20rM3KHOb614Ik3dM=;
  b=BJUOu5/RZqfubRQkBgEUIOvCfb9Rq0W5i0QxJW/0vhupZ2280MqU2IDy
   tTXbT/SPG3z69YpJn28RXZqIGJwmBka+PRLQb7M9obf+lTDNt0NRPb0/Q
   DO4iQFxXLzNVTCtwMrSR5tUT2+gPLHS6P76E5sfj8YQFbr3e6dhA09nnw
   jvS+sncxj6mSlo9QUO1Lylh9fx0pOJq7RQueV62w8/8b4yD5MQ3ko4Qry
   kzOnyinpg8nwzC+0wHw1j0ztm9Bqu16dd05uFYDujmoRlGQr44m0X2la4
   pR//ky0kiM9EYauBYdNU4ekTt1GNtHZBPf1KwuMU3RlJxJio8RZj3PFn4
   Q==;
X-CSE-ConnectionGUID: 1FtqyydpTomrzXZuL/CO/w==
X-CSE-MsgGUID: 66iCwi7RTg6clud7By0/NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18428099"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18428099"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 04:06:09 -0700
X-CSE-ConnectionGUID: ARKHl+VtTzu1aZHQMgqL6A==
X-CSE-MsgGUID: LuAFIGJzRdyCekdmWVEK1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="50053780"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.133])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 04:06:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Jul 2024 14:06:02 +0300 (EEST)
To: Luke Jones <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] platform/x86 asus-bioscfg: move existing tunings to
 asus-bioscfg module
In-Reply-To: <65069b59-a5c8-42c5-b0e3-8a097ab14b3e@app.fastmail.com>
Message-ID: <5c639541-0fba-276f-7b57-3f5a379c5bac@linux.intel.com>
References: <20240716051612.64842-1-luke@ljones.dev> <20240716051612.64842-2-luke@ljones.dev> <951d3dc4-5330-2bbb-0372-8ab2761bf8f3@linux.intel.com> <65069b59-a5c8-42c5-b0e3-8a097ab14b3e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-740309722-1721127962=:1037"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-740309722-1721127962=:1037
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 16 Jul 2024, Luke Jones wrote:

> On Tue, 16 Jul 2024, at 9:45 PM, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 16 Jul 2024, Luke D. Jones wrote:
> >=20
> > > The fw_attributes_class provides a much cleaner interface to all of t=
he
> > > attributes introduced to asus-wmi. This patch moves all of these extr=
a
> > > attributes over to fw_attributes_class, and shifts the bulk of these
> > > definitions to a new kernel module to reduce the clutter of asus-wmi
> > > with the intention of deprecating the asus-wmi attributes in future.
> > >=20
> > > The work applies only to WMI methods which don't have a clearly defin=
ed
> > > place within the sysfs and as a result ended up lumped together in
> > > /sys/devices/platform/asus-nb-wmi/ with no standard API.
> > >=20
> > > Where possible the fw attrs now implement defaults, min, max, scalar,
> > > choices, etc. As en example dgpu_disable becomes:
> > >=20
> > > /sys/class/firmware-attributes/asus-bioscfg/attributes/dgpu_disable/
> > > =E2=94=9C=E2=94=80=E2=94=80 current_value
> > > =E2=94=9C=E2=94=80=E2=94=80 display_name
> > > =E2=94=9C=E2=94=80=E2=94=80 possible_values
> > > =E2=94=94=E2=94=80=E2=94=80 type
> > >=20
> > > as do other attributes.
> > >=20
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > ---
> > >  drivers/platform/x86/Kconfig               |  14 +
> > >  drivers/platform/x86/Makefile              |   1 +
> > >  drivers/platform/x86/asus-bioscfg.c        | 666 +++++++++++++++++++=
++
> > >  drivers/platform/x86/asus-bioscfg.h        | 243 ++++++++
> > >  drivers/platform/x86/asus-wmi.c            |  18 +-
> > >  include/linux/platform_data/x86/asus-wmi.h |  11 +
> > >  6 files changed, 952 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/platform/x86/asus-bioscfg.c
> > >  create mode 100644 drivers/platform/x86/asus-bioscfg.h
> > >=20
> > > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kcon=
fig
> > > index 665fa9524986..b4a5a5bec7f3 100644
> > > --- a/drivers/platform/x86/Kconfig
> > > +++ b/drivers/platform/x86/Kconfig
> > > @@ -265,6 +265,18 @@ config ASUS_WIRELESS
> > >    If you choose to compile this driver as a module the module will b=
e
> > >    called asus-wireless.
> > > =20
> > > +config ASUS_BIOS
> > > + tristate "ASUS BIOS Driver"
> > > + depends on ACPI_WMI
> > > + depends on ASUS_WMI
> > > + select FW_ATTR_CLASS
> > > + help
> > > +   Say Y here if you have a WMI aware Asus laptop and would like to =
use the
> > > +   firmware_attributes API.
> > > +
> > > +   To compile this driver as a module, choose M here: the module wil=
l
> > > +   be called asus-bios.
> > > +
> > >  config ASUS_WMI
> > >  tristate "ASUS WMI Driver"
> > >  depends on ACPI_WMI
> > > @@ -276,6 +288,8 @@ config ASUS_WMI
> > >  depends on HOTPLUG_PCI
> > >  depends on ACPI_VIDEO || ACPI_VIDEO =3D n
> > >  depends on SERIO_I8042 || SERIO_I8042 =3D n
> > > + select ASUS_BIOS
> >=20
> > Selecting user visible configs is not a good idea. Also, there=20
> > seems to be circular dependency now between ASUS_BIOS & ASUS_WMI ?
>=20
> Is "selects" the same as "depends"?

It's not the same. Selects ask to enabled another symbol (with caveats)=20
and depends only shows this symbol if the other symbol is already enabled.

Select comes with many many caveats and should only be used for the=20
config symbols which are truly library type (and not presented to user in=
=20
the first place).

> I did just remove:
> =09select ASUS_WMI_BIOS
> which should not be there at all.
>=20
> ASUS_BIOS does need ASUS_WMI. And I'd like ASUS_BIOS to be selected by=20
> defualt, is this not the right way to do that?=20

Default should not be handled with either depends on / select I think,=20
but I'm not Kconfig expert.

There's also default clause but it should be used sparingly as each and=20
every developer naturally thinks their thing is so important it must be on=
=20
by default so we know where that thinking ends to. :-)

Distros tend enable about everything anyway so it might not be so=20
important in the end what the default is.

> > > + select ASUS_WMI_BIOS
> > >  select INPUT_SPARSEKMAP
> > >  select LEDS_CLASS
> > >  select NEW_LEDS

> > > + struct mutex mutex;
> > > +} asus_bioscfg =3D {
> > > + .mutex =3D __MUTEX_INITIALIZER(asus_bioscfg.mutex),
> >=20
> > Don't try to initialize it on the same go like this.
> >=20
> > You might want static too.
>=20
> Ack both
>=20
> >=20
> > > +};
> > > +
> > > +static struct fw_attrs_group {
> > > + u32 pending_reboot;
> > > +} fw_attrs =3D {
> > > + .pending_reboot =3D 0,
> > > +};
> >=20
> > Same here.
>=20
> It was probably done like this in code I read as a reference. I'll shift=
=20
> to the module init function.=20

???

I just meant this split:

struct fw_attrs_group {
=09u32 pending_reboot;
};

static struct fw_attrs_group fw_attrs =3D {
=09.pending_reboot =3D 0,
};

> > > +static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
> > > +{
> > > + return !strcmp(attr->attr.name, "gpu_mux_mode");
> > > + !strcmp(attr->attr.name, "panel_hd_mode");
> >=20
> > ???
> >=20
> > Semicolon and && confusion here?
>=20
> Yeah i know, bad rebase I didn't catch.

For the record, || is correct here, not && but you probably know this=20
already.

> > > + if (result)
> > > + return result;
> > > +
> > > + if (value < min || value > max)
> > > + return -EINVAL;
> > > +
> > > + asus_wmi_set_devstate(wmi_dev, value, &result);
> >=20
> > Type confusion, u32 * vs int pointer being passed.
>=20
> I miss rust...



> > > + if (result) {
> > > + pr_err("Failed to set %s: %d\n", attr->attr.name, result);
> > > + return result;
> > > + }
> > > +
> > > + if (result > 1) {
> >=20
> > What's this supposed to mean given you've the type confusion to begin=
=20
> > with and return on the earlier line if result is non-zero?
> >=20
> > Did you mean to capture the return value of asus_wmi_set_devstate() and=
=20
> > test that in the first if ()?
>=20
> Yep.. this whole bit is a mess. I've fixed the type mess, and added a=20
> comment to clarify the "if (result > 1) {"=20
> (WMI methods return 0 =3D fail, 1 =3D success, anything else is error)

Don't add these comments into everywhere in the code but document=20
asus_wmi_set_devstate() instead with kerneldoc.

> > If you make a previously internal function such as asus_wmi_set_devstat=
e()=20
> > EXPORTed, you should document it with kerneldoc so the interface is cle=
ar.
>=20
> I'm not sure how to do this, I'll read up. Also didn't know about it so=
=20
> thanks for the pointer.=20

It's this format:

/**
 * funcname - func short desc
 * @param1: foo
 * ...
 *
 * Func long description (IMHO, often optional if not some major API).
 *
 * Returns: important info about return value
 */

You'll find plenty of examples with varying quality with grep but the most=
=20
imporant bits are the return value and parameters, and if there are=20
caveats the caller should know, the long desciption might be handy.


> > > + err =3D -ENODEV;
> > > + pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled: %d\=
n", err);
> > > + return err;
> > > + }
> > > + }
> > > +
> > > + if (asus_bioscfg.egpu_enable_available) {
> > > + err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU, &result);
> > > + if (err)
> > > + return err;
> > > + if (result && !optimus) {
> > > + err =3D -ENODEV;
> > > + pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled: %d\n=
", err);
> > > + return err;
> > > + }
> > > + }
> > > +
> > > + err =3D asus_wmi_set_devstate(asus_bioscfg.gpu_mux_dev_id, optimus,=
 &result);
> > > + if (err) {
> > > + pr_err("%s Failed to set GPU MUX mode: %d\nn", __func__, err);
> >=20
> > Never use __func__ for messages shown to normal user.
>=20
> Must have been a holdover from debug. Also wasn't aware of that rule, tha=
nks.

For pr_debug() I can give some leeway but for anything info/warn/error=20
should definitely be user readable and preferrably understandable too :-D.

> > > + return err;
> > > + }
> > > + /* !1 is considered a fail by ASUS */
> >=20
> > If the interface is documented with kerneldoc, this is unnecessary=20
> > comment. Is 0 also a failure (this differs from >1 checks elsewhere)?
>=20
> I've changed the other checks to match. But I'll also try and do a=20
> deeper analysis of those particular WMI functions to see if I can find=20
> the actual causes for other returns and their significance (0 and 2). 1=
=20
> is most definitely success though.=20

Understood, I don't expect you to know everything about these interfaces=20
but the difference just caught my eye so I mentioned it in case it's a=20
mistake.

> > As general feel of the readiness of this code, I suspect there were man=
y=20
> > more problems which I failed to notice :-(.
>=20
> I'd put money on it (sorry). I definitely should have cleaned up better=
=20
> than I did so you weren't pointing out silly little things, but I was=20
> never expecting to get over the line on the first try and desperately=20
> needed some insight for the overall patch series to see if what I was=20
> doing was actually going to be acceptable or not.=20

It's not problem in itself if you were just after an early review of the=20
concept but there are little things like not maintaining consistency in=20
variable naming which easily trips one here and there which I really=20
recommend you change because then many patterns can be checked with grep /=
=20
find if things are consistent (and it helps the code reader too if the=20
variable naming doesn't suddenly became opposite of what it was in the=20
previous function).

> As always, thanks so much for your time and review.

--=20
 i.

--8323328-740309722-1721127962=:1037--

