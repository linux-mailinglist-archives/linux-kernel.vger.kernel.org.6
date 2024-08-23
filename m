Return-Path: <linux-kernel+bounces-298958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8208795CE42
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B63C1F22645
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CC61586D3;
	Fri, 23 Aug 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPcOiE1w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032B4430;
	Fri, 23 Aug 2024 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420623; cv=none; b=aJr1+ozGh39CPG7qIrMk8TbZUulhNwRHgtMgeOEr4+zL3Wsy0dp26oxFIZyh2CrEyh58Jlynh1Rwl1wDfMl/bl7lhpFUpcu7U+8yKgpnhKS5yjx2JOruVtA7ARHwzaZuciYhriN4AD+OiTjPQebozJykpB0AhfBpGvW/McAfkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420623; c=relaxed/simple;
	bh=1KLzU72H9HpFzFTrNnIbhXToQZtbWCT9AM/EaZEMT9g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qGq5sfX/0o3N4BgxcPT4uBC/9LW90f18YqTzCfCTmSdGS5Y37miw2bL4dILC18I086yGOnOELfUkpFok9NW0UN8wD8RzBfa4l9pg0LNLUNra+qykA/DAmhTLV+nwFIGb9C+klQ9YGLM6LNUFskIb/sU1VKH+gMXMV5+w4MVLnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPcOiE1w; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724420622; x=1755956622;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1KLzU72H9HpFzFTrNnIbhXToQZtbWCT9AM/EaZEMT9g=;
  b=BPcOiE1whdjn12Sn+iB+iW8f7kn11dT+rsXUZeGY+edIV576x0jT+K1W
   4DdwNAN2oCiBIVyNb8GGGkEtdxIcIh2T1hEl6OTyOw3r7vZBF7Mzu//Aq
   Rz9spFAtncBkLMdW2zzQwyIZBKxjeCFaM2ftvI5OsSyCoXjUxm/tNcaDw
   itwsWQ+PIPWUN6hE6vk6vmMXwhV2o2TlT4ockgN0BBQ+s59gBIajcTa+D
   6fQO2ZXkhrtyu9kPdqEoecdPYB/OsI6fh2Zud7phrJeQGLHYRnfpZ7CH8
   JTxsrbw9XfPcJeLZpwRabVOG4xcbtEezIWkj75UhakgfFkaVr+8NPYOqz
   Q==;
X-CSE-ConnectionGUID: W/o6jgNrTx+4ODpZNPhBBQ==
X-CSE-MsgGUID: t7l8K+pZRpCjHK9kCqdvSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22752332"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="22752332"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 06:43:41 -0700
X-CSE-ConnectionGUID: yCwH8bAnSGuAvleyt6vArw==
X-CSE-MsgGUID: BgUdmcg3QiScT9xpGAhu5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61803516"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.2])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 06:43:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Aug 2024 16:43:32 +0300 (EEST)
To: Mathieu Fenniak <mathieu@fenniak.net>
cc: Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: Fix spurious rfkill on
 UX8406MA
In-Reply-To: <20240823115657.69053-1-mathieu@fenniak.net>
Message-ID: <45764fd3-f715-c461-1f6f-071bad742460@linux.intel.com>
References: <20240823115657.69053-1-mathieu@fenniak.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2062772605-1724420612=:2230"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2062772605-1724420612=:2230
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 23 Aug 2024, Mathieu Fenniak wrote:

> The Asus Zenbook Duo (UX8406MA) has a keyboard which can be
> placed on the laptop to connect it via USB, or can be removed from the
> laptop to reveal a hidden secondary display in which case the keyboard
> operates via Bluetooth.
>=20
> When it is placed on the secondary display to connect via USB, it emits
> a keypress for a wireless disable.  This causes the rfkill system to be

One space is enough (the second one might have been auto-added by your=20
editor).

> activated disconnecting the current wifi connection, which doesn't
> reflect the user's true intention.
>=20
> Detect this hardware and suppress any wireless switches from the
> keyboard; this keyboard does not have a wireless toggle capability so
> these presses are always suprious.

spurious

>=20
> Signed-off-by: Mathieu Fenniak <mathieu@fenniak.net>
> ---
>  drivers/platform/x86/asus-nb-wmi.c | 20 +++++++++++++++++++-
>  drivers/platform/x86/asus-wmi.h    |  1 +
>  2 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/as=
us-nb-wmi.c
> index fceffe2082ec..ed3633c5955d 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -145,6 +145,10 @@ static struct quirk_entry quirk_asus_ignore_fan =3D =
{
>  =09.wmi_ignore_fan =3D true,
>  };
> =20
> +static struct quirk_entry quirk_asus_zenbook_duo_kbd =3D {
> +=09.ignore_key_wlan =3D true,
> +};
> +
>  static int dmi_matched(const struct dmi_system_id *dmi)
>  {
>  =09pr_info("Identified laptop model '%s'\n", dmi->ident);
> @@ -516,6 +520,15 @@ static const struct dmi_system_id asus_quirks[] =3D =
{
>  =09=09},
>  =09=09.driver_data =3D &quirk_asus_ignore_fan,
>  =09},
> +=09{
> +=09=09.callback =3D dmi_matched,
> +=09=09.ident =3D "ASUS Zenbook Duo UX8406MA",
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "UX8406MA"),
> +=09=09},
> +=09=09.driver_data =3D &quirk_asus_zenbook_duo_kbd,
> +=09},
>  =09{},
>  };
> =20
> @@ -630,7 +643,12 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_d=
river *asus_wmi, int *code,
>  =09case 0x32: /* Volume Mute */
>  =09=09if (atkbd_reports_vol_keys)
>  =09=09=09*code =3D ASUS_WMI_KEY_IGNORE;
> -
> +=09=09break;
> +=09case 0x5D: /* Wireless console Toggle */
> +=09case 0x5E: /* Wireless console Enable */
> +=09case 0x5F: /* Wireless console Disable */
> +=09=09if (quirks->ignore_key_wlan)
> +=09=09=09*code =3D ASUS_WMI_KEY_IGNORE;
>  =09=09break;
>  =09}
>  }
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-=
wmi.h
> index cc30f1853847..a6ee9440d932 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -50,6 +50,7 @@ struct quirk_entry {
>  =09 */
>  =09int no_display_toggle;
>  =09u32 xusb2pr;
> +=09bool ignore_key_wlan;

Please put this next to the other bool values.

Seems fine otherwise so after correcting these small things, you can add:

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-2062772605-1724420612=:2230--

