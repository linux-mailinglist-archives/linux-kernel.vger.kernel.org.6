Return-Path: <linux-kernel+bounces-227977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6396C915936
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D529E1F244C1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE581A0B05;
	Mon, 24 Jun 2024 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="l1qIrwKr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QrZiHe9G"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16201A0AFB;
	Mon, 24 Jun 2024 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265621; cv=none; b=REWTRF3O+qtbeTCZ2p1lRX303RTNtLpQDFYtyQB5eD0N/yBh/uqHoL1d5FgM0UEK5ABtod/qXzQ0dYzqtIxiRrMRFAGS454c/EGWoU6BA4OmA7vQlsq70fgdEuRgpw7ymRuVkMw/Y/ZRvwFvKNGgkwlUOt/5804DOS8ZKJaK8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265621; c=relaxed/simple;
	bh=7uY3iHuLf313ptSsL1znOAkGZGDIuUzTLUzoWr14QgQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=nHu2/W1QWVOBs3iLY9kqxrVce3O5+XlI37aB/ETeNohMdA1YjvTX/Y4X6XfG8gaZItKLlTr/L8gumhPu+l03zRY9g/OuliGKObFFG7qD05alRg4mmAhU59+Z77ZTGXeonoGtNH7LX1fHLTAdRjnULfHaSxuYAb1PGzYpM8h5kBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=l1qIrwKr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QrZiHe9G; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B18AF114010D;
	Mon, 24 Jun 2024 17:46:57 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Mon, 24 Jun 2024 17:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1719265617; x=1719352017; bh=/+IxcAwOgj
	kW/14O+aZjRIBG51uVIigaxcmvca/dldA=; b=l1qIrwKrm2zWnfOq1vXNfMdnSV
	Cia/t4zC+Vv+POFAWFTvh7X3v3zOauZM+ZrseoIaj/ib4Xjc92TVzApW6O4NtyU8
	u7ZSYgyzDLI00Zx1Ft1PHgcpOdOD6AzdFgOqvZUJRh9LoGcIvKlEo29kx5VVF+eM
	6Eon70osiH0VbvjmnQznwXgtw1AavmnjuhhHGNcL338JMhjp59ProKtm8CAtMedl
	bwmbFQl72Z31Ivw1CMimFQTUyoUTNTnkAy7wu6qmZena1W4zZax6uaEVaFIUaxHa
	tkcabYi0buvzew7iXAvsnmOydta1c+ENENZqxz4UwbrTcLWYsRNk0IdvHGMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719265617; x=1719352017; bh=/+IxcAwOgjkW/14O+aZjRIBG51uV
	Iigaxcmvca/dldA=; b=QrZiHe9GQVeFRsBHZDpov2zsWqwT01THmpkxjpeyBpSC
	//Va2hsmf+kTCvyom4KLa/9ytvqwT42mbfFi7zqegDWwRzsSttl6iKHd8YviRmKq
	b6MNZEOIqbVbmenFvUhB8pv0zYXTT+og3019iFgJdKVBWbXBtBdHqGfMyZm+wJcL
	SIvdT2aKh5AsQ/MNgHutE6X/c3/ORiVP3WTq8KOO7pI+Kt8GI50n0qu9xkTNjK21
	Hrr1uvPvsHlX6VWee09Ik5cIku/grL+feKt6zepF9G2hC7CLh0h6uEmYhBtwRs39
	VMgc3fayjOmtlrilCt+/kiDVwukwsrYBe1AVmRnjew==
X-ME-Sender: <xms:UOl5Zu4A-5XjK7ovTx9XG8GF2EoggUsCU_6eycQWVAOAWc9FWdXs9w>
    <xme:UOl5Zn5VE-YUtjGPtwoXlENvKHTYb3g4xBM8Y3vMb3JsBnfs1ZWZ7FioABsyqzr7w
    uX-iM0uX2ssS2lO5jk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpedutdelgfdvgeekueeuteevffelfedukeeitedugfdvtdeutdetjeduudeuvdeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:UOl5ZtfykmCzcuLRiLljYRDUufdfAgzmBIBUCWKNAl3FCfm3ksPx5g>
    <xmx:UOl5ZrL71bnLFMaWDCwYBtOP2sFAZFK_-2OWs1LPTDnJ6yJxNSeLRg>
    <xmx:UOl5ZiLbmQC3snrnQVKTkJqzx0hzaO7OfMVJ-0L_yLSEuvr41dgm2w>
    <xmx:UOl5Zsx1oXzJ7jbUvUA8YI6V-6Z3b-kEKHVcsqoZDEkSoy9-JTQ3Ug>
    <xmx:Uel5ZnGaeeAeBkviRPUGQAacB4oiSp7ZWu2bMy6A4bEZJe9BkxjcZ0vV>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CBD322340080; Mon, 24 Jun 2024 17:46:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ebad3eec-576b-46ef-887b-6d3ce31bd5f8@app.fastmail.com>
In-Reply-To: <ZnlEuiP4Dgqpf51C@laptop>
References: <20240609144849.2532-1-mohamed.ghanmi@supcom.tn>
 <20240609144849.2532-2-mohamed.ghanmi@supcom.tn>
 <9daef2c6-6df4-4f61-966c-239450de7b4e@app.fastmail.com>
 <ZnlEuiP4Dgqpf51C@laptop>
Date: Tue, 25 Jun 2024 09:46:36 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Mohamed Ghanmi" <mohamed.ghanmi@supcom.tn>
Cc: "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] platform/x86: asus-wmi: add support for vivobook fan
 profiles
Content-Type: text/plain

On Mon, 24 Jun 2024, at 10:04 PM, Mohamed Ghanmi wrote:
> On Tue, Jun 11, 2024 at 05:31:46PM +1200, Luke Jones wrote:
> > 
> > 
> > On Mon, 10 Jun 2024, at 2:48 AM, Mohamed Ghanmi wrote:
> > > Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
> > > to adjust power limits.
> > > 
> > > These fan profiles have a different device id than the ROG series
> > > and different order. This reorders the existing modes.
> > > 
> > > As part of keeping the patch clean the throttle_thermal_policy_available
> > > boolean stored in the driver struct is removed and
> > > throttle_thermal_policy_dev is used in place (as on init it is zeroed).
> > > 
> > > Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> > > Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > ---
> > > drivers/platform/x86/asus-wmi.c            | 125 ++++++++++++---------
> > > include/linux/platform_data/x86/asus-wmi.h |   1 +
> > > 2 files changed, 76 insertions(+), 50 deletions(-)
> > > 
> > > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > > index 3c61d75a3..2e3d8d8fb 100644
> > > --- a/drivers/platform/x86/asus-wmi.c
> > > +++ b/drivers/platform/x86/asus-wmi.c
> > > @@ -97,6 +97,12 @@ module_param(fnlock_default, bool, 0444);
> > > #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST 1
> > > #define ASUS_THROTTLE_THERMAL_POLICY_SILENT 2
> > >  
> > > +#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO 0
> > > +#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO 1
> > > +#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO 2
> > > +
> > > +#define PLATFORM_PROFILE_MAX 2
> > > +
> > > #define USB_INTEL_XUSB2PR 0xD0
> > > #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI 0x9c31
> > >  
> > > @@ -293,8 +299,8 @@ struct asus_wmi {
> > > u32 kbd_rgb_dev;
> > > bool kbd_rgb_state_available;
> > >  
> > > - bool throttle_thermal_policy_available;
> > > u8 throttle_thermal_policy_mode;
> > > + u32 throttle_thermal_policy_dev;
> > >  
> > > bool cpu_fan_curve_available;
> > > bool gpu_fan_curve_available;
> > > @@ -3152,7 +3158,7 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
> > > int err, fan_idx;
> > > u8 mode = 0;
> > >  
> > > - if (asus->throttle_thermal_policy_available)
> > > + if (asus->throttle_thermal_policy_dev)
> > > mode = asus->throttle_thermal_policy_mode;
> > > /* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
> > > if (mode == 2)
> > > @@ -3359,7 +3365,7 @@ static ssize_t fan_curve_enable_store(struct device *dev,
> > > * For machines with throttle this is the only way to reset fans
> > > * to default mode of operation (does not erase curve data).
> > > */
> > > - if (asus->throttle_thermal_policy_available) {
> > > + if (asus->throttle_thermal_policy_dev) {
> > > err = throttle_thermal_policy_write(asus);
> > > if (err)
> > > return err;
> > > @@ -3576,8 +3582,8 @@ static const struct attribute_group asus_fan_curve_attr_group = {
> > > __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
> > >  
> > > /*
> > > - * Must be initialised after throttle_thermal_policy_check_present() as
> > > - * we check the status of throttle_thermal_policy_available during init.
> > > + * Must be initialised after throttle_thermal_policy_dev is set as
> > > + * we check the status of throttle_thermal_policy_dev during init.
> > >   */
> > > static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
> > > {
> > > @@ -3618,38 +3624,13 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
> > > }
> > >  
> > > /* Throttle thermal policy ****************************************************/
> > > -
> > > -static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
> > > -{
> > > - u32 result;
> > > - int err;
> > > -
> > > - asus->throttle_thermal_policy_available = false;
> > > -
> > > - err = asus_wmi_get_devstate(asus,
> > > -     ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> > > -     &result);
> > > - if (err) {
> > > - if (err == -ENODEV)
> > > - return 0;
> > > - return err;
> > > - }
> > > -
> > > - if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> > > - asus->throttle_thermal_policy_available = true;
> > > -
> > > - return 0;
> > > -}
> > > -
> > > static int throttle_thermal_policy_write(struct asus_wmi *asus)
> > > {
> > > - int err;
> > > - u8 value;
> > > + u8 value = asus->throttle_thermal_policy_mode;
> > > u32 retval;
> > > + int err;
> > >  
> > > - value = asus->throttle_thermal_policy_mode;
> > > -
> > > - err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> > > + err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
> > >     value, &retval);
> > >  
> > > sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> > > @@ -3679,7 +3660,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
> > >  
> > > static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
> > > {
> > > - if (!asus->throttle_thermal_policy_available)
> > > + if (!asus->throttle_thermal_policy_dev)
> > > return 0;
> > >  
> > > asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > > @@ -3691,7 +3672,7 @@ static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
> > > u8 new_mode = asus->throttle_thermal_policy_mode + 1;
> > > int err;
> > >  
> > > - if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > > + if (new_mode > PLATFORM_PROFILE_MAX)
> > > new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > >  
> > > asus->throttle_thermal_policy_mode = new_mode;
> > > @@ -3730,7 +3711,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
> > > if (result < 0)
> > > return result;
> > >  
> > > - if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > > + if (new_mode > PLATFORM_PROFILE_MAX)
> > > return -EINVAL;
> > >  
> > > asus->throttle_thermal_policy_mode = new_mode;
> > > @@ -3747,10 +3728,56 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
> > > return count;
> > > }
> > >  
> > > -// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> > > +/*
> > > + * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> > > + */
> > > static DEVICE_ATTR_RW(throttle_thermal_policy);
> > >  
> > > /* Platform profile ***********************************************************/
> > > +static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus,
> > > +   int mode)
> > 
> > Given the internals of this function I'm still not sure if this naming makes sense. Perhaps "maybe_platform_profile_to_vivo()"
> >
> you're right. this function doesn't only remap to vivo but if the laptop
> is a not a vivo (in our case a ROG) it doesn't change the mapping.
> 
> The way I see it is that there is a logical mapping (the ROG mode
> mapping) which is stored in the asus_wmi struct and a physical mapping
> that is used when writing to the acpi device (the vivo in this case). 
> so maybe naming them asus_wmi_platform_profile_from_logical_mapping() 
> and asus_wmi_platform_profile_to_logical_mapping() is a better naming.
> in the future there will be other device ids for different laptops.

If we go ahead with a function name change it should be shorter, and add a oneline comment to describe what you just did here.

Perhaps "asus_wmi_map_<to/from>_platform_profile()".

> sorry for the late reply
> > > +{
> > > + bool vivo;
> > > +
> > > + vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> > > +
> > > + if (vivo) {
> > > + switch (mode) {
> > > + case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> > > + return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
> > > + case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
> > > + return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
> > > + case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> > > + return ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
> > > + }
> > > + }
> > > +
> > > + return mode;
> > > +
> > > +}
> > > +
> > > +static int asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus,
> > > +   int mode)
> > 
> > Same as the last function.
> > 
> same as the above
> > > +{
> > > + bool vivo;
> > > +
> > > + vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> > > +
> > > + if (vivo) {
> > > + switch (mode) {
> > > + case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO:
> > > + return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > > + case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO:
> > > + return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> > > + case ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO:
> > > + return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> > > + }
> > > + }
> > > +
> > > + return mode;
> > > +
> > > +}
> > > +
> > > static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > > enum platform_profile_option *profile)
> > > {
> > > @@ -3758,10 +3785,9 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > > int tp;
> > >  
> > > asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
> > > -
> > > tp = asus->throttle_thermal_policy_mode;
> > >  
> > > - switch (tp) {
> > > + switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
> > > case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> > > *profile = PLATFORM_PROFILE_BALANCED;
> > > break;
> > > @@ -3775,6 +3801,7 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > > return -EINVAL;
> > > }
> > >  
> > > +
> > > return 0;
> > > }
> > >  
> > > @@ -3800,7 +3827,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> > > return -EOPNOTSUPP;
> > > }
> > >  
> > > - asus->throttle_thermal_policy_mode = tp;
> > > + asus->throttle_thermal_policy_mode = asus_wmi_platform_profile_to_vivo(asus, tp);
> > > return throttle_thermal_policy_write(asus);
> > > }
> > >  
> > > @@ -3813,7 +3840,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
> > > * Not an error if a component platform_profile relies on is unavailable
> > > * so early return, skipping the setup of platform_profile.
> > > */
> > > - if (!asus->throttle_thermal_policy_available)
> > > + if (!asus->throttle_thermal_policy_dev)
> > > return 0;
> > >  
> > > dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
> > > @@ -4228,7 +4255,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
> > > if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
> > > if (asus->fan_boost_mode_available)
> > > fan_boost_mode_switch_next(asus);
> > > - if (asus->throttle_thermal_policy_available)
> > > + if (asus->throttle_thermal_policy_dev)
> > > throttle_thermal_policy_switch_next(asus);
> > > return;
> > >  
> > > @@ -4436,7 +4463,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
> > > else if (attr == &dev_attr_fan_boost_mode.attr)
> > > ok = asus->fan_boost_mode_available;
> > > else if (attr == &dev_attr_throttle_thermal_policy.attr)
> > > - ok = asus->throttle_thermal_policy_available;
> > > + ok = asus->throttle_thermal_policy_dev != 0;
> > > else if (attr == &dev_attr_ppt_pl2_sppt.attr)
> > > devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
> > > else if (attr == &dev_attr_ppt_pl1_spl.attr)
> > > @@ -4745,16 +4772,15 @@ static int asus_wmi_add(struct platform_device *pdev)
> > > else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
> > > asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
> > >  
> > > + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
> > > + asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
> > > + else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
> > > + asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> > > +
> > > err = fan_boost_mode_check_present(asus);
> > > if (err)
> > > goto fail_fan_boost_mode;
> > >  
> > > - err = throttle_thermal_policy_check_present(asus);
> > > - if (err)
> > > - goto fail_throttle_thermal_policy;
> > > - else
> > > - throttle_thermal_policy_set_default(asus);
> > > -
> > > err = platform_profile_setup(asus);
> > > if (err)
> > > goto fail_platform_profile_setup;
> > > @@ -4849,7 +4875,6 @@ static int asus_wmi_add(struct platform_device *pdev)
> > > fail_input:
> > > asus_wmi_sysfs_exit(asus->platform_device);
> > > fail_sysfs:
> > > -fail_throttle_thermal_policy:
> > > fail_custom_fan_curve:
> > > fail_platform_profile_setup:
> > > if (asus->platform_profile_support)
> > > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> > > index 3eb5cd677..982a63774 100644
> > > --- a/include/linux/platform_data/x86/asus-wmi.h
> > > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > > @@ -64,6 +64,7 @@
> > > #define ASUS_WMI_DEVID_SCREENPAD_LIGHT 0x00050032
> > > #define ASUS_WMI_DEVID_FAN_BOOST_MODE 0x00110018
> > > #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
> > > +#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
> > >  
> > > /* Misc */
> > > #define ASUS_WMI_DEVID_PANEL_OD 0x00050019
> > > -- 
> > > 2.44.0
> > > 
> >  
> > If Hans and Ilpo don't have any requirements then:
> > 
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > 
> 

