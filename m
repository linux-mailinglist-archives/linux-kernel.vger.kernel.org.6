Return-Path: <linux-kernel+bounces-427700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE9C9E0512
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223E9168731
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25F22040BB;
	Mon,  2 Dec 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhMfzhAD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F6204086;
	Mon,  2 Dec 2024 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149802; cv=none; b=arxB25hkQ/X6gW1Jpsz1zu099ZCK2hRXAPGoI9cXv7fxQxAc4PPOMu0pui0c3KVbipoIizy7lQwnB10xnGihZzqpc5Ti6EhWqg9qSbtpTyfzaV5JR1MSsVqX1LHHsYDZzVlEp6e2mx72dMZNCwYvAnJeUyeYW/9Y1nHUgy7c7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149802; c=relaxed/simple;
	bh=BfsczZnxqw0bdhiznQxUcWmZYiHdqyMkpjGQf0x/yLs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d5o6LJvOc6nsol7HL6W91L7pxFi1RM34J7lq69HrxgR97mAUUbjoCXYMS36FputSeb8vKHz+kiyHSnCn5J1xP7XiYBrJCIrrOeFTb8V60x5PjTbBAfHqbDSaXhdLcUfxwzey/phJ8In2fJAqZwGf8B15pMomniT57qPoTgElDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhMfzhAD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733149800; x=1764685800;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BfsczZnxqw0bdhiznQxUcWmZYiHdqyMkpjGQf0x/yLs=;
  b=NhMfzhADSrDtdbmUECrYYbew4nHBbtoEroRUsVuYmS17fGMt3cbA/ZbB
   5V1S4+zV6e33p0lCUPYbJXKpyqJ3++F+gS2fSKD+TtohWJ0z3na62yYJq
   KFOF/DZe5O2XynC1aJPM1Fb3vd4ggMPOjFKKcnFHTWbI7c2VuGEkq4u2c
   G3sTKj0JeyMl5D7juLJtxHZg6+r+NixMKBV6IznwxHarzd9aNaMlZkqIt
   QLpwwopqrIi1XKKnnFNolkI5cn74OOE+6108nwgWoGaMdYFb4DEnNyqeN
   7BL0LPdFPdtQeZkzSCwsmloQOGjHV901OHWmbpEJmnnW33vb662gwFkpf
   A==;
X-CSE-ConnectionGUID: zcvK7/Z6Rl6I4cmeN99TUA==
X-CSE-MsgGUID: 8K4RlW0IR4ibzJMkT1Q1OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33248632"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="33248632"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 06:29:59 -0800
X-CSE-ConnectionGUID: BWHWWzvKQrikfPJzrYywzw==
X-CSE-MsgGUID: B9+TQja6Ss63IV2/mvvNOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="98223306"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.61])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 06:29:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Dec 2024 16:29:52 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, auslands-kv@gmx.de, 
    corentin.chary@gmail.com, luke@ljones.dev, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: Ignore return value when writing
 thermal policy
In-Reply-To: <c06686ad-f755-4f14-8df8-f5b47e246f98@gmx.de>
Message-ID: <877a18c8-048c-6c7c-72c3-d899349b278d@linux.intel.com>
References: <20241124171941.29789-1-W_Armin@gmx.de> <13590dd6-1529-487c-842a-85b44c577811@redhat.com> <a56a1bed-de18-4530-aed5-ea8471962c71@gmx.de> <c06686ad-f755-4f14-8df8-f5b47e246f98@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-175535707-1733149792=:932"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-175535707-1733149792=:932
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 2 Dec 2024, Armin Wolf wrote:
> Am 29.11.24 um 20:29 schrieb Armin Wolf:
> > Am 25.11.24 um 10:39 schrieb Hans de Goede:
> > > On 24-Nov-24 6:19 PM, Armin Wolf wrote:
> > > > On some machines like the ASUS Vivobook S14 writing the thermal pol=
icy
> > > > returns the currently writen thermal policy instead of an error cod=
e.
> > > >=20
> > > > Ignore the return code to avoid falsely returning an error when the
> > > > thermal policy was written successfully.
> > > >=20
> > > > Reported-by: auslands-kv@gmx.de
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219517
> > > > Fixes: 2daa86e78c49 ("platform/x86: asus_wmi: Support throttle
> > > > thermal policy")
> > > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > Thanks, patch looks good to me:
> > >=20
> > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > >=20
> > > Regards,
> > >=20
> > > Hans
> >=20
> > I forgot to add the following tag:
> >=20
> > Tested-by: auslands-kv@gmx.de
> >=20
> > Can we pick this patch for the next fixes pull?
> >=20
> > Thanks,
> > Armin Wolf
> >=20
> Another user (Edoardo Brogiolo <brogioloedoardo@gmail.com>) reported a si=
milar
> issue with another Asus machine,
> see https://bbs.archlinux.org/viewtopic.php?id=3D301341 for details.
>=20
> Are there any blockers left for this patch to get accepted upstream?

Hi Armin,

I don't think there are any blocker I'm aware of. It's just that I'm=20
extremely busy right after the merge window has closed as usual.

--=20
 i.

> > > > ---
> > > > =C2=A0 drivers/platform/x86/asus-wmi.c | 11 ++---------
> > > > =C2=A0 1 file changed, 2 insertions(+), 9 deletions(-)
> > > >=20
> > > > diff --git a/drivers/platform/x86/asus-wmi.c
> > > > b/drivers/platform/x86/asus-wmi.c
> > > > index ba8b6d028f9f..8bd187e8b47f 100644
> > > > --- a/drivers/platform/x86/asus-wmi.c
> > > > +++ b/drivers/platform/x86/asus-wmi.c
> > > > @@ -3696,7 +3696,6 @@ static int
> > > > asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
> > > > =C2=A0 /* Throttle thermal policy
> > > > ****************************************************/
> > > > =C2=A0 static int throttle_thermal_policy_write(struct asus_wmi *as=
us)
> > > > =C2=A0 {
> > > > -=C2=A0=C2=A0=C2=A0 u32 retval;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 value;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
> > > >=20
> > > > @@ -3718,8 +3717,8 @@ static int
> > > > throttle_thermal_policy_write(struct asus_wmi *asus)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D as=
us->throttle_thermal_policy_mode;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0 err =3D asus_wmi_set_devstate(asus->throttle_th=
ermal_policy_dev,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value, &retval);
> > > > +=C2=A0=C2=A0=C2=A0 /* Some machines do not return an error code as=
 a result, so we
> > > > ignore it */
> > > > +=C2=A0=C2=A0=C2=A0 err =3D asus_wmi_set_devstate(asus->throttle_th=
ermal_policy_dev,
> > > > value, NULL);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_notify(&asus->platform_device-=
>dev.kobj, NULL,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "throttle_thermal_policy");
> > > > @@ -3729,12 +3728,6 @@ static int
> > > > throttle_thermal_policy_write(struct asus_wmi *asus)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0 if (retval !=3D 1) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("Failed to set =
throttle thermal policy (retval):
> > > > 0x%x\n",
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 retval);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
> > > > -=C2=A0=C2=A0=C2=A0 }
> > > > -
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Must set to disabled if mode is t=
oggled */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (asus->cpu_fan_curve_available)
> > > > asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled =3D false;
> > > > --
> > > > 2.39.5
> > > >=20
> > >=20
> >=20
>=20
--8323328-175535707-1733149792=:932--

