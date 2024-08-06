Return-Path: <linux-kernel+bounces-275808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A25948A21
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD5BB243B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB3A166F35;
	Tue,  6 Aug 2024 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9EA/Hhf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77729165F1F;
	Tue,  6 Aug 2024 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929333; cv=none; b=oCNxxWauVQL4QPmb4ELY0iJB4jqtfNfhD90Tk4rTRHlUM+02Ih8uLCChk1ibap/IRHNFFJZ7u2OcRvrY/LOgOMaZtqEhN0OGAqKWg7YDgMNt3eZWuIuXfLS8Pl+Sz+u0lBtoH8XmiKJhUf2uzbrdeVazG1bDCdZd6EtwriJBhtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929333; c=relaxed/simple;
	bh=9D+0NjOt3KntCM54yS0urPQiBIqOtAJZOIbLRRmMZ+E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FMPaerPlE1R7pqorneSiwJxdNVIsVDCq/GLaTamo+6ZVPJWezSnHleov5NB1RqbOnpccRsB7XAesw4CcLGc5GyJ7BCOd1BvzWqn1ubwvT8wl94m746Ev8UIimBk0WHMlWTshNwIr2ZxIxW0ksvrKcaA4w5QxxH2hEmKiU2D3wq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9EA/Hhf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722929333; x=1754465333;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9D+0NjOt3KntCM54yS0urPQiBIqOtAJZOIbLRRmMZ+E=;
  b=Y9EA/Hhfle1yZGKmDvvbkgj8xvOo8++g5/uwLwhC8Zer+Xi1QAzval4c
   DNGXjgqXvrU38I72xLVUUDrqH/NZNMilLyjY2oXOVoF/WOzQrQ17QlpGw
   Som9EmWW+VBqIehFKoLb04cPn9Fwpp2n97avX09qKZ0qi2WYn2VeVpXWL
   Egiwgw5804WLUVUqky72pwet11jY0gZON1Wm3Wps6/xxg5l05nLSs0w90
   Ih25sQrcL4F80nvE19H/ONIf5850NK+I4KdWbKnonKBfA4142A9HHYvmb
   qIGYoNN4eP6wrsQ+U/uebqHpW+UFTyc6oleC+oHgyN7kQu4YI48OYOttV
   Q==;
X-CSE-ConnectionGUID: QvjiRbJHQ52ALnffrShp6w==
X-CSE-MsgGUID: iMrUwQKCQCasW0lx8zLSFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21076071"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="21076071"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 00:28:47 -0700
X-CSE-ConnectionGUID: mfoKG3RUQ3uks+MipdEmIQ==
X-CSE-MsgGUID: /W8TOMkxTD6ck4TWh4QctA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56636343"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 00:28:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Aug 2024 10:28:41 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com
Subject: Re: [PATCH v2 1/6] platform/x86: asus-wmi: Add quirk for ROG Ally
 X
In-Reply-To: <20240806020747.365042-2-luke@ljones.dev>
Message-ID: <76178389-f99e-d625-df38-8202309310d9@linux.intel.com>
References: <20240806020747.365042-1-luke@ljones.dev> <20240806020747.365042-2-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-361996996-1722929321=:1027"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-361996996-1722929321=:1027
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 6 Aug 2024, Luke D. Jones wrote:

> The new ROG Ally X functions the same as the previus model so we can use

previous

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> the same method to ensure the MCU USB devices wake and reconnect
> correctly.
>=20
> Given that two devices marks the start of a trend, this patch also adds
> a quirk table to make future additions easier if the MCU is the same.
>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index f15fcb45e1aa..0c80c6b0399b 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -152,6 +152,20 @@ static const char * const ashs_ids[] =3D { "ATK4001"=
, "ATK4002", NULL };
> =20
>  static int throttle_thermal_policy_write(struct asus_wmi *);
> =20
> +static const struct dmi_system_id asus_ally_mcu_quirk[] =3D {
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> +=09=09},
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> +=09=09},
> +=09},
> +=09{ },
> +};
> +
>  static bool ashs_present(void)
>  {
>  =09int i =3D 0;
> @@ -4751,7 +4765,7 @@ static int asus_wmi_add(struct platform_device *pde=
v)
>  =09asus->dgpu_disable_available =3D asus_wmi_dev_is_present(asus, ASUS_W=
MI_DEVID_DGPU);
>  =09asus->kbd_rgb_state_available =3D asus_wmi_dev_is_present(asus, ASUS_=
WMI_DEVID_TUF_RGB_STATE);
>  =09asus->ally_mcu_usb_switch =3D acpi_has_method(NULL, ASUS_USB0_PWR_EC0=
_CSEE)
> -=09=09=09=09=09=09&& dmi_match(DMI_BOARD_NAME, "RC71L");
> +=09=09=09=09=09=09&& dmi_check_system(asus_ally_mcu_quirk);
> =20
>  =09if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
>  =09=09asus->mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE;
>=20

--=20
 i.

--8323328-361996996-1722929321=:1027--

