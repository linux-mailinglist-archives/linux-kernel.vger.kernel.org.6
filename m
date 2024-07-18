Return-Path: <linux-kernel+bounces-256138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C254D93499C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AE7AB23451
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1053B7BB15;
	Thu, 18 Jul 2024 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKetorwL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984D768EE;
	Thu, 18 Jul 2024 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290239; cv=none; b=IuYFCYgBzfUPXTZSQnEFqVSlNnrqp9RVapNZChCpjIgy2wdNaneMTUMjfta18xFf2McZIkcYHd6nZPQJhSLKlnGA+HtTYsPQ8cGqiQbK0j+UjfhT9CGCVQUj4WlOcs/YSY9GT1R+sHX4Evdurbu2LZeJNdtBvcQTJ5EXqiA/X0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290239; c=relaxed/simple;
	bh=IP34QX/7zEhuTAIlUsIgd0SZj4Rso3c6uxd45ljBkHo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=drPw7A8j3rfw4+Nhd5N52GiaIZNtnqTTxaT4n3AwrSykRyREtjbuJdtSr+ikvmaP9kYUIhdLkzEjvzzxxrQt3uw3J6G0fd1kAP2L/+SNY9Su/iWv5xY8hP88aMHgbsrf0Z8vRt1bxQj8W5esd3RTLlBYBM+3z73NW21FJ4Q1HUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKetorwL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721290237; x=1752826237;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IP34QX/7zEhuTAIlUsIgd0SZj4Rso3c6uxd45ljBkHo=;
  b=LKetorwL2xqN8snLQRN8V9TK8R9u33PBKoPh1dsbf0vy7xzKOsB6xgR/
   /B3i8Cre1HRVsbXjdqUdYhJguWQSLF+G1j52bcH9k2u0FXyZCZDrVcy2M
   kZ88ztdKPmAMvpNcNmIrnaCiEd8Nq6Ffnr6JYLLh8nPiB/9FeeLFKmdc7
   bkaJ1g3O1jSmCfiSGIQ4bQ1BN91RHfxtFq5acBphVa06JCjF5bUY5B6mF
   ZSH8VQuChP7YRIlQ4VOUb6FeS3bBkpQFVKARDIR6E9JSTScafR/oOBbqb
   4gPhoLlqLH2pQFPMl640gILBpQpIDEM1kJXdFRlk+SKsHk/EcPrpMQSeb
   g==;
X-CSE-ConnectionGUID: YBEBJ60+SkaZrBwMlASnBg==
X-CSE-MsgGUID: mevSf+w+R9C/EuB4uFtQoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="12604807"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="12604807"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:10:36 -0700
X-CSE-ConnectionGUID: 2emZovPMSzKJBDKqVG8Y2g==
X-CSE-MsgGUID: YOZVO1/8SVW+DlO+Ocri2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="50556199"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.139])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:10:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Jul 2024 11:10:30 +0300 (EEST)
To: Gergo Koteles <soyer@irl.hu>
cc: Hans de Goede <hdegoede@redhat.com>, Ike Panhc <ike.pan@canonical.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] platform/x86: ideapad-laptop: move ymc_trigger_ec
 from lenovo-ymc
In-Reply-To: <8c90b1b6d7be7d80650568975d79ef35d18e551c.1721258854.git.soyer@irl.hu>
Message-ID: <de67120b-8e88-0fae-e1b2-900bc13b0157@linux.intel.com>
References: <cover.1721258854.git.soyer@irl.hu> <8c90b1b6d7be7d80650568975d79ef35d18e551c.1721258854.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-155597919-1721290230=:1055"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-155597919-1721290230=:1055
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 18 Jul 2024, Gergo Koteles wrote:

> Some models need to trigger the EC after each YMC event for the yoga
> mode control to work properly. EC triggering consist of a VPC call from
> the lenovo-ymc module. Except for this, all VPC calls are in the
> ideapad-laptop module.
>=20
> Since ideapad-laptop has a notification chain, a new YMC_EVENT action
> can be added and triggered from the lenovo-ymc module. Then the
> ideapad-laptop can trigger the EC.
>=20
> If the triggering is in the ideapad-laptop module, then the ec_trigger
> module parameter should be there as well.
>=20
> Move the ymc_trigger_ec functionality and the ec_trigger module
> parameter to the ideapad-laptop module.
>=20
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

I certainly like this approch more than the one in v1.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/platform/x86/Kconfig          |  1 +
>  drivers/platform/x86/ideapad-laptop.c | 49 ++++++++++++++++++++++
>  drivers/platform/x86/ideapad-laptop.h |  4 ++
>  drivers/platform/x86/lenovo-ymc.c     | 60 +--------------------------
>  4 files changed, 56 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 6dbd40e2aeda..4af0a060cd47 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -464,6 +464,7 @@ config LENOVO_YMC
>  =09tristate "Lenovo Yoga Tablet Mode Control"
>  =09depends on ACPI_WMI
>  =09depends on INPUT
> +=09depends on IDEAPAD_LAPTOP
>  =09select INPUT_SPARSEKMAP
>  =09help
>  =09  This driver maps the Tablet Mode Control switch to SW_TABLET_MODE i=
nput
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86=
/ideapad-laptop.c
> index e4d32a788339..1d61bd921528 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -145,6 +145,7 @@ struct ideapad_private {
>  =09=09bool touchpad_ctrl_via_ec : 1;
>  =09=09bool ctrl_ps2_aux_port    : 1;
>  =09=09bool usb_charging         : 1;
> +=09=09bool ymc_ec_trigger       : 1;
>  =09} features;
>  =09struct {
>  =09=09bool initialized;
> @@ -188,6 +189,12 @@ MODULE_PARM_DESC(touchpad_ctrl_via_ec,
>  =09"Enable registering a 'touchpad' sysfs-attribute which can be used to=
 manually "
>  =09"tell the EC to enable/disable the touchpad. This may not work on all=
 models.");
> =20
> +static bool ymc_ec_trigger __read_mostly;
> +module_param(ymc_ec_trigger, bool, 0444);
> +MODULE_PARM_DESC(ymc_ec_trigger,
> +=09"Enable EC triggering work-around to force emitting tablet mode event=
s. "
> +=09"If you need this please report this to: platform-driver-x86@vger.ker=
nel.org");
> +
>  /*
>   * shared data
>   */
> @@ -1498,10 +1505,50 @@ static void ideapad_sync_touchpad_state(struct id=
eapad_private *priv, bool send_
>  =09priv->r_touchpad_val =3D value;
>  }
> =20
> +static const struct dmi_system_id ymc_ec_trigger_quirk_dmi_table[] =3D {
> +=09{
> +=09=09/* Lenovo Yoga 7 14ARB7 */
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
> +=09=09},
> +=09},
> +=09{
> +=09=09/* Lenovo Yoga 7 14ACN6 */
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "82N7"),
> +=09=09},
> +=09},
> +=09{ }
> +};
> +
> +static void ideapad_laptop_trigger_ec(void)
> +{
> +=09struct ideapad_private *priv;
> +=09int ret;
> +
> +=09guard(mutex)(&ideapad_shared_mutex);
> +
> +=09priv =3D ideapad_shared;
> +=09if (!priv)
> +=09=09return;
> +
> +=09if (!priv->features.ymc_ec_trigger)
> +=09=09return;
> +
> +=09ret =3D write_ec_cmd(priv->adev->handle, VPCCMD_W_YMC, 1);
> +=09if (ret)
> +=09=09dev_warn(&priv->platform_device->dev, "Could not write YMC: %d\n",=
 ret);
> +}
> +
>  static int ideapad_laptop_nb_notify(struct notifier_block *nb,
>  =09=09=09=09    unsigned long action, void *data)
>  {
>  =09switch (action) {
> +=09case IDEAPAD_LAPTOP_YMC_EVENT:
> +=09=09ideapad_laptop_trigger_ec();
> +=09=09break;
>  =09}
> =20
>  =09return 0;
> @@ -1667,6 +1714,8 @@ static void ideapad_check_features(struct ideapad_p=
rivate *priv)
>  =09priv->features.ctrl_ps2_aux_port =3D
>  =09=09ctrl_ps2_aux_port || dmi_check_system(ctrl_ps2_aux_port_list);
>  =09priv->features.touchpad_ctrl_via_ec =3D touchpad_ctrl_via_ec;
> +=09priv->features.ymc_ec_trigger =3D
> +=09=09ymc_ec_trigger || dmi_check_system(ymc_ec_trigger_quirk_dmi_table)=
;
> =20
>  =09if (!read_ec_data(handle, VPCCMD_R_FAN, &val))
>  =09=09priv->features.fan_mode =3D true;
> diff --git a/drivers/platform/x86/ideapad-laptop.h b/drivers/platform/x86=
/ideapad-laptop.h
> index 3eb0dcd6bf7b..948cc61800a9 100644
> --- a/drivers/platform/x86/ideapad-laptop.h
> +++ b/drivers/platform/x86/ideapad-laptop.h
> @@ -14,6 +14,10 @@
>  #include <linux/errno.h>
>  #include <linux/notifier.h>
> =20
> +enum ideapad_laptop_notifier_actions {
> +=09IDEAPAD_LAPTOP_YMC_EVENT,
> +};
> +
>  int ideapad_laptop_register_notifier(struct notifier_block *nb);
>  int ideapad_laptop_unregister_notifier(struct notifier_block *nb);
>  void ideapad_laptop_call_notifier(unsigned long action, void *data);
> diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/len=
ovo-ymc.c
> index e1fbc35504d4..e0bbd6a14a89 100644
> --- a/drivers/platform/x86/lenovo-ymc.c
> +++ b/drivers/platform/x86/lenovo-ymc.c
> @@ -20,32 +20,10 @@
>  #define LENOVO_YMC_QUERY_INSTANCE 0
>  #define LENOVO_YMC_QUERY_METHOD 0x01
> =20
> -static bool ec_trigger __read_mostly;
> -module_param(ec_trigger, bool, 0444);
> -MODULE_PARM_DESC(ec_trigger, "Enable EC triggering work-around to force =
emitting tablet mode events");
> -
>  static bool force;
>  module_param(force, bool, 0444);
>  MODULE_PARM_DESC(force, "Force loading on boards without a convertible D=
MI chassis-type");
> =20
> -static const struct dmi_system_id ec_trigger_quirk_dmi_table[] =3D {
> -=09{
> -=09=09/* Lenovo Yoga 7 14ARB7 */
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
> -=09=09},
> -=09},
> -=09{
> -=09=09/* Lenovo Yoga 7 14ACN6 */
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "82N7"),
> -=09=09},
> -=09},
> -=09{ }
> -};
> -
>  static const struct dmi_system_id allowed_chasis_types_dmi_table[] =3D {
>  =09{
>  =09=09.matches =3D {
> @@ -62,21 +40,8 @@ static const struct dmi_system_id allowed_chasis_types=
_dmi_table[] =3D {
> =20
>  struct lenovo_ymc_private {
>  =09struct input_dev *input_dev;
> -=09struct acpi_device *ec_acpi_dev;
>  };
> =20
> -static void lenovo_ymc_trigger_ec(struct wmi_device *wdev, struct lenovo=
_ymc_private *priv)
> -{
> -=09int err;
> -
> -=09if (!priv->ec_acpi_dev)
> -=09=09return;
> -
> -=09err =3D write_ec_cmd(priv->ec_acpi_dev->handle, VPCCMD_W_YMC, 1);
> -=09if (err)
> -=09=09dev_warn(&wdev->dev, "Could not write YMC: %d\n", err);
> -}
> -
>  static const struct key_entry lenovo_ymc_keymap[] =3D {
>  =09/* Laptop */
>  =09{ KE_SW, 0x01, { .sw =3D { SW_TABLET_MODE, 0 } } },
> @@ -125,11 +90,9 @@ static void lenovo_ymc_notify(struct wmi_device *wdev=
, union acpi_object *data)
> =20
>  free_obj:
>  =09kfree(obj);
> -=09lenovo_ymc_trigger_ec(wdev, priv);
> +=09ideapad_laptop_call_notifier(IDEAPAD_LAPTOP_YMC_EVENT, &code);
>  }
> =20
> -static void acpi_dev_put_helper(void *p) { acpi_dev_put(p); }
> -
>  static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
>  {
>  =09struct lenovo_ymc_private *priv;
> @@ -143,29 +106,10 @@ static int lenovo_ymc_probe(struct wmi_device *wdev=
, const void *ctx)
>  =09=09=09return -ENODEV;
>  =09}
> =20
> -=09ec_trigger |=3D dmi_check_system(ec_trigger_quirk_dmi_table);
> -
>  =09priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>  =09if (!priv)
>  =09=09return -ENOMEM;
> =20
> -=09if (ec_trigger) {
> -=09=09pr_debug("Lenovo YMC enable EC triggering.\n");
> -=09=09priv->ec_acpi_dev =3D acpi_dev_get_first_match_dev("VPC2004", NULL=
, -1);
> -
> -=09=09if (!priv->ec_acpi_dev) {
> -=09=09=09dev_err(&wdev->dev, "Could not find EC ACPI device.\n");
> -=09=09=09return -ENODEV;
> -=09=09}
> -=09=09err =3D devm_add_action_or_reset(&wdev->dev,
> -=09=09=09=09acpi_dev_put_helper, priv->ec_acpi_dev);
> -=09=09if (err) {
> -=09=09=09dev_err(&wdev->dev,
> -=09=09=09=09"Could not clean up EC ACPI device: %d\n", err);
> -=09=09=09return err;
> -=09=09}
> -=09}
> -
>  =09input_dev =3D devm_input_allocate_device(&wdev->dev);
>  =09if (!input_dev)
>  =09=09return -ENOMEM;
> @@ -192,7 +136,6 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, =
const void *ctx)
>  =09dev_set_drvdata(&wdev->dev, priv);
> =20
>  =09/* Report the state for the first time on probe */
> -=09lenovo_ymc_trigger_ec(wdev, priv);
>  =09lenovo_ymc_notify(wdev, NULL);
>  =09return 0;
>  }
> @@ -217,3 +160,4 @@ module_wmi_driver(lenovo_ymc_driver);
>  MODULE_AUTHOR("Gergo Koteles <soyer@irl.hu>");
>  MODULE_DESCRIPTION("Lenovo Yoga Mode Control driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IDEAPAD_LAPTOP);
>=20

--8323328-155597919-1721290230=:1055--

