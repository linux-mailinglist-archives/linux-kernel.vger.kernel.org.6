Return-Path: <linux-kernel+bounces-198610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C3B8D7AF4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03011F217FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7363208D4;
	Mon,  3 Jun 2024 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="P2NCXTpu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ho9Pn92R"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AA11DDF6;
	Mon,  3 Jun 2024 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717391970; cv=none; b=BqRCX6b/kAQ3VDao7HjJXS+4iDwv2ddrk5KAK6GRhPjvDKotTb9jA3hNX5fVi3r+hmFZ42FwPUGe8BkeloC6ZnuL2X32xzw/Wu7jiU1qLKQjO+x42goFth0rbiufVQvo7v4Bxt1ev+IESO8/H5I1el5lwzh6YyzUtFVri45jDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717391970; c=relaxed/simple;
	bh=eJyETce/sRtvByHjTbVNifMksIreBZmkd+8tqnlYUn4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=JiHULGnMGE5Q09H+JfMj+4X7BmVzdMre7as4wNXKniFfZmjm2AZG5r6Da2yoOPmNu6V3gtu7P8IHITUE39GUamZ6YIbV6GV3j0Q82sz8L/16jTP950vUxln4dkOtc+BAngSHWe3kR3VkoF4QK1DCzbZQL0cT09hUymG32+eYlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=P2NCXTpu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ho9Pn92R; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id AA7F7180015E;
	Mon,  3 Jun 2024 01:19:25 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 01:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1717391965;
	 x=1717478365; bh=EWgyi7PW7a2EXvu9lY274UDQksjpO45Tm83OEaSkHtU=; b=
	P2NCXTpuczRR6RdL5XHK84BjSwlnoil04vTHuxZdpIYjjgjdOJRBytaSVUBBEUUv
	JaQbcytwYSdrhO2w8rsQ68QaB3Zn6dUhhVqXvm4IyCwwH+0ZJSeIZHq4Gn6UX4Xs
	r88vFruFju68oWu/KA/GpWXNi7pnHuckz+90J9a+SbaRTKSv9DCIl9CCmO17bH3P
	vHAf2PgdGUk0gDKMEfKAhhmEwkznEKjLWWvj0ApK2hFvkucfYl2mV5wxTXI6D9ft
	4RIE82NmntxjVqtFkh7Sjm7UmaeNH51+fMN1I5gWS2pzemVB/HjeRTUmi04e+Esj
	pRiczN/zlMPlne3fp63SaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717391965; x=
	1717478365; bh=EWgyi7PW7a2EXvu9lY274UDQksjpO45Tm83OEaSkHtU=; b=h
	o9Pn92Rpnnh48MFKSxz8Fx1Aza/sxJldV6PQ8c8WTwZIcYzVe4DBfY/4baFQrX/C
	xB1bD2pRNFHLyiax0MApHQy1es0OlY0t6MInQf0y5KzMplvZzssi5m1toaDcUgK7
	bi/fyCbpk4WFgEWNL3CqIisH94to8cSH8SNSpXDOCRFXfI4PKjPIND83JqAkjF58
	jxv6rPWpJZ0U+un26Bn8SmkkhxS/mr1qlKveakaweljZVeniG5C4qN8RmtJV3SZZ
	AaJDz7holTYwq3VI0hkxs56kyHiotGWePX1S4YGpwPLkYve1FSOSa1ajZBDFumxV
	1nWdhV1Ue8MDImKrPoJZg==
X-ME-Sender: <xms:XFJdZiy_PfOlVLg8jAa7mfwB30xkC3BA9nC29VQp-BXmFxuFQ8MJNQ>
    <xme:XFJdZuQJkrdgdDKS7AdL1IGjI-pbvsUKjyL-fpav6U_2rWEbEzPHHpemwlBHO7SnF
    9JLzJRzRZD_NjH8Zpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeluddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepfeeugffhvdeufeehieelvdegfeffveegleehtddvheegkeetueegtdegueeh
    vdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:XFJdZkVmoSvczGa0rCfp6tl5EedWZdAOJu5_BGjBWRY0Sx4oyDHdcw>
    <xmx:XFJdZoj1Gfi8pRRDG42Fm4-C9MUWvOmfZK5oa5WLXy5mLn0leA7t1w>
    <xmx:XFJdZkB_SXva347jNI76N8vq01DlBuukrI1IbCXfL89syohz2qgXYA>
    <xmx:XFJdZpJKhdaloiKvJZTFhV-JMmCNYrsn_99W8fTqKYueprAZblT3QA>
    <xmx:XVJdZn8SF8xi80A0gPRyr5Tnvw4L26I_FJ8DtN4ZhMNqw5OEYnnWbUiy>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 726042340080; Mon,  3 Jun 2024 01:19:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aee09e9f-6269-43ef-b509-a9a7b5e1752f@app.fastmail.com>
In-Reply-To: <de8fcb82-3e08-41e6-b099-75df27c6df23@redhat.com>
References: <20240421194320.48258-1-mohamed.ghanmi@supcom.tn>
 <20240421194320.48258-2-mohamed.ghanmi@supcom.tn>
 <de8fcb82-3e08-41e6-b099-75df27c6df23@redhat.com>
Date: Mon, 03 Jun 2024 17:19:03 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Hans de Goede" <hdegoede@redhat.com>,
 "Mohamed Ghanmi" <mohamed.ghanmi@supcom.tn>
Cc: corentin.chary@gmail.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wmi: add support for vivobook fan
 profiles
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Apr 2024, at 10:20 PM, Hans de Goede wrote:
> Hi,
>=20
> On 4/21/24 9:43 PM, Mohamed Ghanmi wrote:
> > Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
> > to adjust power limits.
> >=20
> > These fan profiles have a different device id than the ROG series
> > and different order. This reorders the existing modes and adds a new
> > full speed mode available on these laptops.
> >=20
> > As part of keeping the patch clean the throttle_thermal_policy_avail=
able
> > boolean stored in the driver struct is removed and
> > throttle_thermal_policy_dev is used in place (as on init it is zeroe=
d).
> >=20
> > Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> > Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/platform/x86/asus-wmi.c            | 93 ++++++++++++-------=
---
> >  include/linux/platform_data/x86/asus-wmi.h |  1 +
> >  2 files changed, 51 insertions(+), 43 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index 3c61d75a3..1f54596ca 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -97,6 +97,11 @@ module_param(fnlock_default, bool, 0444);
> >  #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST 1
> >  #define ASUS_THROTTLE_THERMAL_POLICY_SILENT 2
> > =20
> > +#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO 0
> > +#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO 1
> > +#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO 2
> > +#define ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED 3
> > +
> >  #define USB_INTEL_XUSB2PR 0xD0
> >  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI 0x9c31
> > =20
> > @@ -293,8 +298,8 @@ struct asus_wmi {
> >  u32 kbd_rgb_dev;
> >  bool kbd_rgb_state_available;
> > =20
> > - bool throttle_thermal_policy_available;
> >  u8 throttle_thermal_policy_mode;
> > + u32 throttle_thermal_policy_dev;
> > =20
> >  bool cpu_fan_curve_available;
> >  bool gpu_fan_curve_available;
> > @@ -3152,7 +3157,7 @@ static int fan_curve_get_factory_default(struc=
t asus_wmi *asus, u32 fan_dev)
> >  int err, fan_idx;
> >  u8 mode =3D 0;
> > =20
> > - if (asus->throttle_thermal_policy_available)
> > + if (asus->throttle_thermal_policy_dev)
> >  mode =3D asus->throttle_thermal_policy_mode;
> >  /* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
> >  if (mode =3D=3D 2)
> > @@ -3359,7 +3364,7 @@ static ssize_t fan_curve_enable_store(struct d=
evice *dev,
> >  * For machines with throttle this is the only way to reset fans
> >  * to default mode of operation (does not erase curve data).
> >  */
> > - if (asus->throttle_thermal_policy_available) {
> > + if (asus->throttle_thermal_policy_dev) {
> >  err =3D throttle_thermal_policy_write(asus);
> >  if (err)
> >  return err;
> > @@ -3576,8 +3581,8 @@ static const struct attribute_group asus_fan_c=
urve_attr_group =3D {
> >  __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
> > =20
> >  /*
> > - * Must be initialised after throttle_thermal_policy_check_present(=
) as
> > - * we check the status of throttle_thermal_policy_available during =
init.
> > + * Must be initialised after throttle_thermal_policy_dev is set as
> > + * we check the status of throttle_thermal_policy_dev during init.
> >   */
> >  static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
> >  {
> > @@ -3618,38 +3623,37 @@ static int asus_wmi_custom_fan_curve_init(st=
ruct asus_wmi *asus)
> >  }
> > =20
> >  /* Throttle thermal policy ****************************************=
************/
> > -
> > -static int throttle_thermal_policy_check_present(struct asus_wmi *a=
sus)
> > +static u8 throttle_thermal_policy_max_mode(struct asus_wmi *asus)
> >  {
> > - u32 result;
> > - int err;
> > -
> > - asus->throttle_thermal_policy_available =3D false;
> > -
> > - err =3D asus_wmi_get_devstate(asus,
> > -     ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> > -     &result);
> > - if (err) {
> > - if (err =3D=3D -ENODEV)
> > - return 0;
> > - return err;
> > - }
> > -
> > - if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> > - asus->throttle_thermal_policy_available =3D true;
> > -
> > - return 0;
> > + if (asus->throttle_thermal_policy_dev =3D=3D ASUS_WMI_DEVID_THROTT=
LE_THERMAL_POLICY_VIVO)
> > + return ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED;
> > + else
> > + return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> >  }
> > =20
> >  static int throttle_thermal_policy_write(struct asus_wmi *asus)
> >  {
> > - int err;
> > - u8 value;
> > + u8 value =3D asus->throttle_thermal_policy_mode;
> >  u32 retval;
> > + bool vivo;
> > + int err;
> > =20
> > - value =3D asus->throttle_thermal_policy_mode;
> > + vivo =3D asus->throttle_thermal_policy_dev =3D=3D ASUS_WMI_DEVID_T=
HROTTLE_THERMAL_POLICY_VIVO;
> > + if (vivo) {
> > + switch (value) {
> > + case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> > + value =3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
> > + break;
> > + case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
> > + value =3D ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
> > + break;
> > + case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> > + value =3D ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
> > + break;
> > + }
> > + }
> > =20
> > - err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLI=
CY,
> > + err =3D asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
> >      value, &retval);
> > =20
> >  sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> > @@ -3679,7 +3683,7 @@ static int throttle_thermal_policy_write(struc=
t asus_wmi *asus)
> > =20
> >  static int throttle_thermal_policy_set_default(struct asus_wmi *asu=
s)
> >  {
> > - if (!asus->throttle_thermal_policy_available)
> > + if (!asus->throttle_thermal_policy_dev)
> >  return 0;
> > =20
> >  asus->throttle_thermal_policy_mode =3D ASUS_THROTTLE_THERMAL_POLICY=
_DEFAULT;
> > @@ -3689,9 +3693,10 @@ static int throttle_thermal_policy_set_defaul=
t(struct asus_wmi *asus)
> >  static int throttle_thermal_policy_switch_next(struct asus_wmi *asu=
s)
> >  {
> >  u8 new_mode =3D asus->throttle_thermal_policy_mode + 1;
> > + u8 max_mode =3D throttle_thermal_policy_max_mode(asus);
> >  int err;
> > =20
> > - if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > + if (new_mode > max_mode)
> >  new_mode =3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > =20
> >  asus->throttle_thermal_policy_mode =3D new_mode;
> > @@ -3722,6 +3727,7 @@ static ssize_t throttle_thermal_policy_store(s=
truct device *dev,
> >      const char *buf, size_t count)
> >  {
> >  struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > + u8 max_mode =3D throttle_thermal_policy_max_mode(asus);
> >  u8 new_mode;
> >  int result;
> >  int err;
> > @@ -3730,7 +3736,7 @@ static ssize_t throttle_thermal_policy_store(s=
truct device *dev,
> >  if (result < 0)
> >  return result;
> > =20
> > - if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > + if (new_mode > max_mode)
> >  return -EINVAL;
> > =20
> >  asus->throttle_thermal_policy_mode =3D new_mode;
> > @@ -3747,7 +3753,10 @@ static ssize_t throttle_thermal_policy_store(=
struct device *dev,
> >  return count;
> >  }
> > =20
> > -// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> > +/*
> > + * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> > + * Throttle thermal policy vivobook : 0 - default, 1 - silent, 2 - =
overboost, 3 - fullspeed
> > + */
>=20
> throttle_thermal_policy_write() always expects normal (non vivobook) v=
alues and
> then translates those to vivo values, so this comment is not correct.
>=20
> The only difference is that vivobook also has fullspeed, but the way u=
serspace
> sees it 1/2 or silent/overspeed are not swapped, since the swapping is=
 taking
> care of in throttle_thermal_policy_write().
>=20
> Also the new fullspeed is not exported through the platform_profile in=
terface,
> for setting values this is somewhat ok, but fullspeed can be set throu=
gh
> sysfs, and this will then cause asus_wmi_platform_profile_get() to fail
> with -EINVAL, so this need to be fixed. Either map fullspeed to
> PLATFORM_PROFILE_PERFORMANCE in asus_wmi_platform_profile_get(), or add
> a new platform_profile value for this.
>

I would much prefer if "fullspeed" was not included at all unless it was=
 an individual setting. It very rarely contributes anything good to the =
driver, and most certainly won't be of value in the platform_profile.

Otherwise, what is the status on this?=20

>=20
> >  static DEVICE_ATTR_RW(throttle_thermal_policy);
> > =20
> >  /* Platform profile ***********************************************=
************/
> > @@ -3813,7 +3822,7 @@ static int platform_profile_setup(struct asus_=
wmi *asus)
> >  * Not an error if a component platform_profile relies on is unavail=
able
> >  * so early return, skipping the setup of platform_profile.
> >  */
> > - if (!asus->throttle_thermal_policy_available)
> > + if (!asus->throttle_thermal_policy_dev)
> >  return 0;
> > =20
> >  dev_info(dev, "Using throttle_thermal_policy for platform_profile s=
upport\n");
> > @@ -4228,7 +4237,7 @@ static void asus_wmi_handle_event_code(int cod=
e, struct asus_wmi *asus)
> >  if (code =3D=3D NOTIFY_KBD_FBM || code =3D=3D NOTIFY_KBD_TTP) {
> >  if (asus->fan_boost_mode_available)
> >  fan_boost_mode_switch_next(asus);
> > - if (asus->throttle_thermal_policy_available)
> > + if (asus->throttle_thermal_policy_dev)
> >  throttle_thermal_policy_switch_next(asus);
> >  return;
> > =20
> > @@ -4436,7 +4445,7 @@ static umode_t asus_sysfs_is_visible(struct ko=
bject *kobj,
> >  else if (attr =3D=3D &dev_attr_fan_boost_mode.attr)
> >  ok =3D asus->fan_boost_mode_available;
> >  else if (attr =3D=3D &dev_attr_throttle_thermal_policy.attr)
> > - ok =3D asus->throttle_thermal_policy_available;
> > + ok =3D asus->throttle_thermal_policy_dev !=3D 0;
> >  else if (attr =3D=3D &dev_attr_ppt_pl2_sppt.attr)
> >  devid =3D ASUS_WMI_DEVID_PPT_PL2_SPPT;
> >  else if (attr =3D=3D &dev_attr_ppt_pl1_spl.attr)
> > @@ -4745,16 +4754,15 @@ static int asus_wmi_add(struct platform_devi=
ce *pdev)
> >  else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2=
))
> >  asus->kbd_rgb_dev =3D ASUS_WMI_DEVID_TUF_RGB_MODE2;
> > =20
> > + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_=
POLICY))
> > + asus->throttle_thermal_policy_dev =3D ASUS_WMI_DEVID_THROTTLE_THER=
MAL_POLICY;
> > + else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THE=
RMAL_POLICY_VIVO))
> > + asus->throttle_thermal_policy_dev =3D ASUS_WMI_DEVID_THROTTLE_THER=
MAL_POLICY_VIVO;
> > +
> >  err =3D fan_boost_mode_check_present(asus);
> >  if (err)
> >  goto fail_fan_boost_mode;
> > =20
> > - err =3D throttle_thermal_policy_check_present(asus);
> > - if (err)
> > - goto fail_throttle_thermal_policy;
> > - else
> > - throttle_thermal_policy_set_default(asus);
> > -
> >  err =3D platform_profile_setup(asus);
> >  if (err)
> >  goto fail_platform_profile_setup;
> > @@ -4849,7 +4857,6 @@ static int asus_wmi_add(struct platform_device=
 *pdev)
> >  fail_input:
> >  asus_wmi_sysfs_exit(asus->platform_device);
> >  fail_sysfs:
> > -fail_throttle_thermal_policy:
> >  fail_custom_fan_curve:
> >  fail_platform_profile_setup:
> >  if (asus->platform_profile_support)
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/li=
nux/platform_data/x86/asus-wmi.h
> > index 3eb5cd677..982a63774 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -64,6 +64,7 @@
> >  #define ASUS_WMI_DEVID_SCREENPAD_LIGHT 0x00050032
> >  #define ASUS_WMI_DEVID_FAN_BOOST_MODE 0x00110018
> >  #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
> > +#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
> > =20
> >  /* Misc */
> >  #define ASUS_WMI_DEVID_PANEL_OD 0x00050019
>=20
>=20

