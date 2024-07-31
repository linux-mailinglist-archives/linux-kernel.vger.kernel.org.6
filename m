Return-Path: <linux-kernel+bounces-269853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A78C943787
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3BC1C2034D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107016C68D;
	Wed, 31 Jul 2024 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="wr6UoDNT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uL5aslpe"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94BD1BC40;
	Wed, 31 Jul 2024 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460019; cv=none; b=O9TR86cuJZ/rIOGY6gp7RMjdNcSdZoFC+1tGG7gS1eW+C+lzBPVh6AxvuDbyaude4H3QM3X9wFPyIp+f6yrUbzqlCLodhuLcEwsIsYkxAqjwz15Hs7zpyIhLahVjc+Gf734h+BM0ZN0r3UbLLE7rc/P8j0Qx8qghw/SHE41HY6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460019; c=relaxed/simple;
	bh=0dYOac+DnhFj3MTvnTQZVP1+tgBmy5r1FRt+D41P1ws=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oH5fdt+I3cTxx1l4mr74j1HxS8Pa7Zjiqps+1+3vVCgXD4r/5pGS496q3CCH7xSBSJlj4/I0SMo7fX1ESiT18UJcxC49M7K6YfAhE38Oj+j062IoYQh89Na0q1UVZfUkdItp7Yqpk2TdkVWpxnIGvEkJemh2oUgYgtzH32e5Urk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=wr6UoDNT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uL5aslpe; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B56911147097;
	Wed, 31 Jul 2024 17:06:54 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute3.internal (MEProxy); Wed, 31 Jul 2024 17:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1722460014;
	 x=1722546414; bh=i3o9mBDFO7h83tAUcQt7Otg8PTtqrGmNLEMBhONVpbA=; b=
	wr6UoDNTpVfLtPto7ksRJ50dKbLHJNy6wl1tk/n8UIYPGkm4RsKmIbw4G1wgsjH8
	tmqnsRrvdu0HzTZc0tGv66lt0B2yynwtdS51s/gNZqcdbnYtT/OQ5XjUMs3pGKcI
	PMcRUVdDdrHh4WEA1afinh8J4H21pPsVR+NZc1p5/hXKw5hgkii6oDnvaTWz3RTq
	SCLucTMWQpeoHDvt1rQkMuVPWBFscDbDdWhM5ZVdG3CiFiNZ3tSk2p0FqNLEX8jA
	H8ILtPyQ/DNWoXNAF6pL1lcdjgkgX4s7a9nQxHueRd1v2R+tQvFeWLbnZTI2mFDs
	9QRGWA44B6uKECYm+yLOWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722460014; x=
	1722546414; bh=i3o9mBDFO7h83tAUcQt7Otg8PTtqrGmNLEMBhONVpbA=; b=u
	L5aslpemmpAlma4D1KoByFfelHP+Gs5LCzt5kvy+8MOz49Sp51ZOAn9a+s02G6gH
	6huiE5u2sAJrrmdfbe0OuFR7Qtyeg6JGFx88VywrX8d8xHqzb48JxK6mbEC86U1F
	5LauaCv2Hopj3IGQiwNd1P3vmUUVhFB/hO/3r9VmxSeEFWa+OfcUIEkDzyHlXBBV
	offirVcptTX9Tx7rucecQfeMfcD0Zo49CkioUCODzOGtq69Ty+7mMCz6zRDw0fRd
	wi0bYVGwc6bayia06hpLSUvmfi2+XD9dKupEgH11JlosOYterr/XXgUlP9l1tosC
	2wK7YB3O7DSn8pclO/ULg==
X-ME-Sender: <xms:bqeqZuBW0VIaSd0_hW7ReOlD1dAHYEEmP6NQRn4c25tnvUxiz3R9hQ>
    <xme:bqeqZohZpfU8cr2ao24TkefFZpdY5iaO9DBZix3nWYaHI0GwUdcj9I2VNSxMBkqCg
    ZRsB6PTi0hEwXKQi2c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpeehtedugfelgeeltdevvedtleffhfetgfdtjefhkefgudejfeeuueefvdejuddu
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:bqeqZhmnl5YJSOve-yqAtbuIeSFcxZpOzQIy8ke6_3P0yhi4S-SAPw>
    <xmx:bqeqZswHolxGFCTCU9DzAIsLlfYY6o-TK7BZRXjWNaZRMJEdqqWNFQ>
    <xmx:bqeqZjReUlg9Hn9kEng1uTDZPb8G5vPEVymkU_fIr93DLp_PHaMnxw>
    <xmx:bqeqZnZwiwwnfTRK4Qz1m-aX0XGuWqCEoZNO_U2QC2-5TdwlCMPmtA>
    <xmx:bqeqZhO7RejRhd6q9cUBC3AfH_bqXrs8DPUos13re-z25YxN14l9d6ui>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E9E262340080; Wed, 31 Jul 2024 17:06:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Aug 2024 09:06:33 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Mohamed Ghanmi" <mohamed.ghanmi@supcom.tn>
Cc: "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <d21a1be5-7589-49e4-a96b-cddf9b6c15eb@app.fastmail.com>
In-Reply-To: <ZqopEfPCuU7-7mUR@meddabeast>
References: <20240609144849.2532-1-mohamed.ghanmi@supcom.tn>
 <20240609144849.2532-2-mohamed.ghanmi@supcom.tn>
 <9daef2c6-6df4-4f61-966c-239450de7b4e@app.fastmail.com>
 <ZnlEuiP4Dgqpf51C@laptop>
 <ebad3eec-576b-46ef-887b-6d3ce31bd5f8@app.fastmail.com>
 <ZqopEfPCuU7-7mUR@meddabeast>
Subject: Re: [PATCH v4 1/1] platform/x86: asus-wmi: add support for vivobook fan
 profiles
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> Hi,
>=20
> On Tue, Jun 25, 2024 at 09:46:36AM +1200, Luke Jones wrote:
> > On Mon, 24 Jun 2024, at 10:04 PM, Mohamed Ghanmi wrote:
> > > On Tue, Jun 11, 2024 at 05:31:46PM +1200, Luke Jones wrote:
> > > >=20
> > > >=20
> > > > On Mon, 10 Jun 2024, at 2:48 AM, Mohamed Ghanmi wrote:
> > > > > Add support for vivobook fan profiles wmi call on the ASUS VIV=
OBOOK
> > > > > to adjust power limits.
> > > > >=20
> > > > > These fan profiles have a different device id than the ROG ser=
ies
> > > > > and different order. This reorders the existing modes.
> > > > >=20
> > > > > As part of keeping the patch clean the throttle_thermal_policy=
_available
> > > > > boolean stored in the driver struct is removed and
> > > > > throttle_thermal_policy_dev is used in place (as on init it is=
 zeroed).
> > > > >=20
> > > > > Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> > > > > Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > > > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > > > ---
> > > > > drivers/platform/x86/asus-wmi.c            | 125 ++++++++++++-=
--------
> > > > > include/linux/platform_data/x86/asus-wmi.h |   1 +
> > > > > 2 files changed, 76 insertions(+), 50 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platfor=
m/x86/asus-wmi.c
> > > > > index 3c61d75a3..2e3d8d8fb 100644
> > > > > --- a/drivers/platform/x86/asus-wmi.c
> > > > > +++ b/drivers/platform/x86/asus-wmi.c
> > > > > @@ -97,6 +97,12 @@ module_param(fnlock_default, bool, 0444);
> > > > > #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST 1
> > > > > #define ASUS_THROTTLE_THERMAL_POLICY_SILENT 2
> > > > > =20
> > > > > +#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO 0
> > > > > +#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO 1
> > > > > +#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO 2
> > > > > +
> > > > > +#define PLATFORM_PROFILE_MAX 2
> > > > > +
> > > > > #define USB_INTEL_XUSB2PR 0xD0
> > > > > #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI 0x9c31
> > > > > =20
> > > > > @@ -293,8 +299,8 @@ struct asus_wmi {
> > > > > u32 kbd_rgb_dev;
> > > > > bool kbd_rgb_state_available;
> > > > > =20
> > > > > - bool throttle_thermal_policy_available;
> > > > > u8 throttle_thermal_policy_mode;
> > > > > + u32 throttle_thermal_policy_dev;
> > > > > =20
> > > > > bool cpu_fan_curve_available;
> > > > > bool gpu_fan_curve_available;
> > > > > @@ -3152,7 +3158,7 @@ static int fan_curve_get_factory_default=
(struct asus_wmi *asus, u32 fan_dev)
> > > > > int err, fan_idx;
> > > > > u8 mode =3D 0;
> > > > > =20
> > > > > - if (asus->throttle_thermal_policy_available)
> > > > > + if (asus->throttle_thermal_policy_dev)
> > > > > mode =3D asus->throttle_thermal_policy_mode;
> > > > > /* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT=
 */
> > > > > if (mode =3D=3D 2)
> > > > > @@ -3359,7 +3365,7 @@ static ssize_t fan_curve_enable_store(st=
ruct device *dev,
> > > > > * For machines with throttle this is the only way to reset fans
> > > > > * to default mode of operation (does not erase curve data).
> > > > > */
> > > > > - if (asus->throttle_thermal_policy_available) {
> > > > > + if (asus->throttle_thermal_policy_dev) {
> > > > > err =3D throttle_thermal_policy_write(asus);
> > > > > if (err)
> > > > > return err;
> > > > > @@ -3576,8 +3582,8 @@ static const struct attribute_group asus=
_fan_curve_attr_group =3D {
> > > > > __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
> > > > > =20
> > > > > /*
> > > > > - * Must be initialised after throttle_thermal_policy_check_pr=
esent() as
> > > > > - * we check the status of throttle_thermal_policy_available d=
uring init.
> > > > > + * Must be initialised after throttle_thermal_policy_dev is s=
et as
> > > > > + * we check the status of throttle_thermal_policy_dev during =
init.
> > > > >   */
> > > > > static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asu=
s)
> > > > > {
> > > > > @@ -3618,38 +3624,13 @@ static int asus_wmi_custom_fan_curve_i=
nit(struct asus_wmi *asus)
> > > > > }
> > > > > =20
> > > > > /* Throttle thermal policy ***********************************=
*****************/
> > > > > -
> > > > > -static int throttle_thermal_policy_check_present(struct asus_=
wmi *asus)
> > > > > -{
> > > > > - u32 result;
> > > > > - int err;
> > > > > -
> > > > > - asus->throttle_thermal_policy_available =3D false;
> > > > > -
> > > > > - err =3D asus_wmi_get_devstate(asus,
> > > > > -     ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> > > > > -     &result);
> > > > > - if (err) {
> > > > > - if (err =3D=3D -ENODEV)
> > > > > - return 0;
> > > > > - return err;
> > > > > - }
> > > > > -
> > > > > - if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> > > > > - asus->throttle_thermal_policy_available =3D true;
> > > > > -
> > > > > - return 0;
> > > > > -}
> > > > > -
> > > > > static int throttle_thermal_policy_write(struct asus_wmi *asus)
> > > > > {
> > > > > - int err;
> > > > > - u8 value;
> > > > > + u8 value =3D asus->throttle_thermal_policy_mode;
> > > > > u32 retval;
> > > > > + int err;
> > > > > =20
> > > > > - value =3D asus->throttle_thermal_policy_mode;
> > > > > -
> > > > > - err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMA=
L_POLICY,
> > > > > + err =3D asus_wmi_set_devstate(asus->throttle_thermal_policy_=
dev,
> > > > >     value, &retval);
> > > > > =20
> > > > > sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> > > > > @@ -3679,7 +3660,7 @@ static int throttle_thermal_policy_write=
(struct asus_wmi *asus)
> > > > > =20
> > > > > static int throttle_thermal_policy_set_default(struct asus_wmi=
 *asus)
> > > > > {
> > > > > - if (!asus->throttle_thermal_policy_available)
> > > > > + if (!asus->throttle_thermal_policy_dev)
> > > > > return 0;
> > > > > =20
> > > > > asus->throttle_thermal_policy_mode =3D ASUS_THROTTLE_THERMAL_P=
OLICY_DEFAULT;
> > > > > @@ -3691,7 +3672,7 @@ static int throttle_thermal_policy_switc=
h_next(struct asus_wmi *asus)
> > > > > u8 new_mode =3D asus->throttle_thermal_policy_mode + 1;
> > > > > int err;
> > > > > =20
> > > > > - if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > > > > + if (new_mode > PLATFORM_PROFILE_MAX)
> > > > > new_mode =3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > > > > =20
> > > > > asus->throttle_thermal_policy_mode =3D new_mode;
> > > > > @@ -3730,7 +3711,7 @@ static ssize_t throttle_thermal_policy_s=
tore(struct device *dev,
> > > > > if (result < 0)
> > > > > return result;
> > > > > =20
> > > > > - if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > > > > + if (new_mode > PLATFORM_PROFILE_MAX)
> > > > > return -EINVAL;
> > > > > =20
> > > > > asus->throttle_thermal_policy_mode =3D new_mode;
> > > > > @@ -3747,10 +3728,56 @@ static ssize_t throttle_thermal_policy=
_store(struct device *dev,
> > > > > return count;
> > > > > }
> > > > > =20
> > > > > -// Throttle thermal policy: 0 - default, 1 - overboost, 2 - s=
ilent
> > > > > +/*
> > > > > + * Throttle thermal policy: 0 - default, 1 - overboost, 2 - s=
ilent
> > > > > + */
> > > > > static DEVICE_ATTR_RW(throttle_thermal_policy);
> > > > > =20
> > > > > /* Platform profile ******************************************=
*****************/
> > > > > +static int asus_wmi_platform_profile_to_vivo(struct asus_wmi =
*asus,
> > > > > +   int mode)
> > > >=20
> > > > Given the internals of this function I'm still not sure if this =
naming makes sense. Perhaps "maybe_platform_profile_to_vivo()"
> > > >
> > > you're right. this function doesn't only remap to vivo but if the =
laptop
> > > is a not a vivo (in our case a ROG) it doesn't change the mapping.
> > >=20
> > > The way I see it is that there is a logical mapping (the ROG mode
> > > mapping) which is stored in the asus_wmi struct and a physical map=
ping
> > > that is used when writing to the acpi device (the vivo in this cas=
e).=20
> > > so maybe naming them asus_wmi_platform_profile_from_logical_mappin=
g()=20
> > > and asus_wmi_platform_profile_to_logical_mapping() is a better nam=
ing.
> > > in the future there will be other device ids for different laptops.
> >=20
> > If we go ahead with a function name change it should be shorter, and=
 add a oneline comment to describe what you just did here.
> >=20
> > Perhaps "asus_wmi_map_<to/from>_platform_profile()".
>=20
> I would like to know the status on this patch ?=20
> should we go ahead with a name change ?
> I=E2=80=99d like to hear your thoughts on this=20
>=20
> >=20
> > > sorry for the late reply
> > > > > +{
> > > > > + bool vivo;
> > > > > +
> > > > > + vivo =3D asus->throttle_thermal_policy_dev =3D=3D ASUS_WMI_D=
EVID_THROTTLE_THERMAL_POLICY_VIVO;
> > > > > +
> > > > > + if (vivo) {
> > > > > + switch (mode) {
> > > > > + case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> > > > > + return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
> > > > > + case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
> > > > > + return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
> > > > > + case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> > > > > + return ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
> > > > > + }
> > > > > + }
> > > > > +
> > > > > + return mode;
> > > > > +
> > > > > +}
> > > > > +
> > > > > +static int asus_wmi_platform_profile_mode_from_vivo(struct as=
us_wmi *asus,
> > > > > +   int mode)
> > > >=20
> > > > Same as the last function.
> > > >=20
> > > same as the above
> > > > > +{
> > > > > + bool vivo;
> > > > > +
> > > > > + vivo =3D asus->throttle_thermal_policy_dev =3D=3D ASUS_WMI_D=
EVID_THROTTLE_THERMAL_POLICY_VIVO;
> > > > > +
> > > > > + if (vivo) {
> > > > > + switch (mode) {
> > > > > + case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO:
> > > > > + return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > > > > + case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO:
> > > > > + return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> > > > > + case ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO:
> > > > > + return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> > > > > + }
> > > > > + }
> > > > > +
> > > > > + return mode;
> > > > > +
> > > > > +}
> > > > > +
> > > > > static int asus_wmi_platform_profile_get(struct platform_profi=
le_handler *pprof,
> > > > > enum platform_profile_option *profile)
> > > > > {
> > > > > @@ -3758,10 +3785,9 @@ static int asus_wmi_platform_profile_ge=
t(struct platform_profile_handler *pprof,
> > > > > int tp;
> > > > > =20
> > > > > asus =3D container_of(pprof, struct asus_wmi, platform_profile=
_handler);
> > > > > -
> > > > > tp =3D asus->throttle_thermal_policy_mode;
> > > > > =20
> > > > > - switch (tp) {
> > > > > + switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
> > > > > case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> > > > > *profile =3D PLATFORM_PROFILE_BALANCED;
> > > > > break;
> > > > > @@ -3775,6 +3801,7 @@ static int asus_wmi_platform_profile_get=
(struct platform_profile_handler *pprof,
> > > > > return -EINVAL;
> > > > > }
> > > > > =20
> > > > > +
> > > > > return 0;
> > > > > }
> > > > > =20
> > > > > @@ -3800,7 +3827,7 @@ static int asus_wmi_platform_profile_set=
(struct platform_profile_handler *pprof,
> > > > > return -EOPNOTSUPP;
> > > > > }
> > > > > =20
> > > > > - asus->throttle_thermal_policy_mode =3D tp;
> > > > > + asus->throttle_thermal_policy_mode =3D asus_wmi_platform_pro=
file_to_vivo(asus, tp);
> > > > > return throttle_thermal_policy_write(asus);
> > > > > }
> > > > > =20
> > > > > @@ -3813,7 +3840,7 @@ static int platform_profile_setup(struct=
 asus_wmi *asus)
> > > > > * Not an error if a component platform_profile relies on is un=
available
> > > > > * so early return, skipping the setup of platform_profile.
> > > > > */
> > > > > - if (!asus->throttle_thermal_policy_available)
> > > > > + if (!asus->throttle_thermal_policy_dev)
> > > > > return 0;
> > > > > =20
> > > > > dev_info(dev, "Using throttle_thermal_policy for platform_prof=
ile support\n");
> > > > > @@ -4228,7 +4255,7 @@ static void asus_wmi_handle_event_code(i=
nt code, struct asus_wmi *asus)
> > > > > if (code =3D=3D NOTIFY_KBD_FBM || code =3D=3D NOTIFY_KBD_TTP) {
> > > > > if (asus->fan_boost_mode_available)
> > > > > fan_boost_mode_switch_next(asus);
> > > > > - if (asus->throttle_thermal_policy_available)
> > > > > + if (asus->throttle_thermal_policy_dev)
> > > > > throttle_thermal_policy_switch_next(asus);
> > > > > return;
> > > > > =20
> > > > > @@ -4436,7 +4463,7 @@ static umode_t asus_sysfs_is_visible(str=
uct kobject *kobj,
> > > > > else if (attr =3D=3D &dev_attr_fan_boost_mode.attr)
> > > > > ok =3D asus->fan_boost_mode_available;
> > > > > else if (attr =3D=3D &dev_attr_throttle_thermal_policy.attr)
> > > > > - ok =3D asus->throttle_thermal_policy_available;
> > > > > + ok =3D asus->throttle_thermal_policy_dev !=3D 0;
> > > > > else if (attr =3D=3D &dev_attr_ppt_pl2_sppt.attr)
> > > > > devid =3D ASUS_WMI_DEVID_PPT_PL2_SPPT;
> > > > > else if (attr =3D=3D &dev_attr_ppt_pl1_spl.attr)
> > > > > @@ -4745,16 +4772,15 @@ static int asus_wmi_add(struct platfor=
m_device *pdev)
> > > > > else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_=
MODE2))
> > > > > asus->kbd_rgb_dev =3D ASUS_WMI_DEVID_TUF_RGB_MODE2;
> > > > > =20
> > > > > + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_TH=
ERMAL_POLICY))
> > > > > + asus->throttle_thermal_policy_dev =3D ASUS_WMI_DEVID_THROTTL=
E_THERMAL_POLICY;
> > > > > + else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTT=
LE_THERMAL_POLICY_VIVO))
> > > > > + asus->throttle_thermal_policy_dev =3D ASUS_WMI_DEVID_THROTTL=
E_THERMAL_POLICY_VIVO;
> > > > > +
> > > > > err =3D fan_boost_mode_check_present(asus);
> > > > > if (err)
> > > > > goto fail_fan_boost_mode;
> > > > > =20
> > > > > - err =3D throttle_thermal_policy_check_present(asus);
> > > > > - if (err)
> > > > > - goto fail_throttle_thermal_policy;
> > > > > - else
> > > > > - throttle_thermal_policy_set_default(asus);
> > > > > -
> > > > > err =3D platform_profile_setup(asus);
> > > > > if (err)
> > > > > goto fail_platform_profile_setup;
> > > > > @@ -4849,7 +4875,6 @@ static int asus_wmi_add(struct platform_=
device *pdev)
> > > > > fail_input:
> > > > > asus_wmi_sysfs_exit(asus->platform_device);
> > > > > fail_sysfs:
> > > > > -fail_throttle_thermal_policy:
> > > > > fail_custom_fan_curve:
> > > > > fail_platform_profile_setup:
> > > > > if (asus->platform_profile_support)
> > > > > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/incl=
ude/linux/platform_data/x86/asus-wmi.h
> > > > > index 3eb5cd677..982a63774 100644
> > > > > --- a/include/linux/platform_data/x86/asus-wmi.h
> > > > > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > > > > @@ -64,6 +64,7 @@
> > > > > #define ASUS_WMI_DEVID_SCREENPAD_LIGHT 0x00050032
> > > > > #define ASUS_WMI_DEVID_FAN_BOOST_MODE 0x00110018
> > > > > #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
> > > > > +#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
> > > > > =20
> > > > > /* Misc */
> > > > > #define ASUS_WMI_DEVID_PANEL_OD 0x00050019
> > > > > --=20
> > > > > 2.44.0
> > > > >=20
> > > > =20
> > > > If Hans and Ilpo don't have any requirements then:
> > > >=20
> > > > Signed-off-by: Luke D. Jones <luke@ljones.dev>

I have no issues with this patch and it needs to be merged before I subm=
it a stream of work. My signed-off tag is above.

> > > >=20
> > >=20
>=20

