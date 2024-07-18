Return-Path: <linux-kernel+bounces-256139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC09093499E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA331F23B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D8678C7A;
	Thu, 18 Jul 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+h2uelQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719CB36B17;
	Thu, 18 Jul 2024 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290332; cv=none; b=oiyiyNIhbkMD1Z4hF2yuJxDFgj4V7Q4EK48J8IuclnJoltydALDesIKeIX10nrYGfC05moLdCScbya8Fkdel8sRwLc7leIY0iHL4Q8UcfHgXGIXQb+KNFnHxKOhdx7Z11Wj8ZuxuqKfjKIfNlxcXmTWJt6u2LZQ5g9zpNJPBMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290332; c=relaxed/simple;
	bh=58Ckkg/yHlJWy/5mI1KEcwYFqhulQou92mBWspAtLzs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z4Z5s3QeTTRa9Xe3Hl+62E4gzCV4kXodvSPrrELtG0mqM+bBLo/CthEDVcpJZK2htwLdLNmxyJiL5Co666Ye4AFyVPyh/VfmFb7+4wJS+k1yEW2/sQ9ivb1oX1wR/6WqCWQ9bgiVeU1C73/Ddf+B+DIwlgpixGe442TRSLaPhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+h2uelQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721290330; x=1752826330;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=58Ckkg/yHlJWy/5mI1KEcwYFqhulQou92mBWspAtLzs=;
  b=W+h2uelQvZLPkqABIXHcBkpafU/khBdI7e0NrW6so+ZpqCrbVsuJo0UG
   iDhALyuVx4bzFZy0hi8FC1wdtRcv6JWX72/R+6eNvKhE2lzyVR7HwJvGC
   0F3Qq+Ackq5AttGamKnN1M2OthHiuTTGtLwkrBTK/nODVfBWrbIGmon87
   yGWENmOadQH3BM+Dqrg2Kr0OIQSwj6vPu3EB3k6OKiEaAvuTC9D10ElxB
   SgODboigTm6ZGdugGLhByFEwwSABCB8BDQyoj1EVdv1XV9Mw6GDckbB36
   N/HBzwF4dTHvLIdsBZIssxeEn6507vNxbk6KfIsuZXPO7UzRohD5ffzl2
   Q==;
X-CSE-ConnectionGUID: X1IJVwdxQHmJ1GoodUZv1A==
X-CSE-MsgGUID: 4/EJxDztSxG54YNQ8qIj7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18537686"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="18537686"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:12:09 -0700
X-CSE-ConnectionGUID: sxDCoTIwRxmgp51d6wsxtg==
X-CSE-MsgGUID: hpb+PWUsSxaxZo3Ok+66gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="54993898"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.139])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:12:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Jul 2024 11:12:04 +0300 (EEST)
To: Gergo Koteles <soyer@irl.hu>
cc: Hans de Goede <hdegoede@redhat.com>, Ike Panhc <ike.pan@canonical.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] platform/x86: ideapad-laptop: move ACPI helpers
 from header to source file
In-Reply-To: <0d11fe28dedb77c0dd8a27e76d0bf467c6ab6c7d.1721258854.git.soyer@irl.hu>
Message-ID: <33138d92-9f0f-de0f-b1d0-e89651574717@linux.intel.com>
References: <cover.1721258854.git.soyer@irl.hu> <0d11fe28dedb77c0dd8a27e76d0bf467c6ab6c7d.1721258854.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-66280176-1721290324=:1055"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-66280176-1721290324=:1055
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 18 Jul 2024, Gergo Koteles wrote:

> Since moving ymc_trigger_ec from lenovo-ymc to ideapad-laptop, only the
> latter uses these definitions and functions.
>=20
> Move them back to source file.
>=20
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/platform/x86/ideapad-laptop.c | 136 +++++++++++++++++++++++++
>  drivers/platform/x86/ideapad-laptop.h | 139 --------------------------
>  2 files changed, 136 insertions(+), 139 deletions(-)
>=20
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86=
/ideapad-laptop.c
> index 1d61bd921528..66b34e99147e 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -21,6 +21,7 @@
>  #include <linux/init.h>
>  #include <linux/input.h>
>  #include <linux/input/sparse-keymap.h>
> +#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/leds.h>
>  #include <linux/module.h>
> @@ -86,6 +87,34 @@ enum {
>  =09SALS_FNLOCK_OFF       =3D 0xf,
>  };
> =20
> +enum {
> +=09VPCCMD_R_VPC1 =3D 0x10,
> +=09VPCCMD_R_BL_MAX,
> +=09VPCCMD_R_BL,
> +=09VPCCMD_W_BL,
> +=09VPCCMD_R_WIFI,
> +=09VPCCMD_W_WIFI,
> +=09VPCCMD_R_BT,
> +=09VPCCMD_W_BT,
> +=09VPCCMD_R_BL_POWER,
> +=09VPCCMD_R_NOVO,
> +=09VPCCMD_R_VPC2,
> +=09VPCCMD_R_TOUCHPAD,
> +=09VPCCMD_W_TOUCHPAD,
> +=09VPCCMD_R_CAMERA,
> +=09VPCCMD_W_CAMERA,
> +=09VPCCMD_R_3G,
> +=09VPCCMD_W_3G,
> +=09VPCCMD_R_ODD, /* 0x21 */
> +=09VPCCMD_W_FAN,
> +=09VPCCMD_R_RF,
> +=09VPCCMD_W_RF,
> +=09VPCCMD_W_YMC =3D 0x2A,
> +=09VPCCMD_R_FAN =3D 0x2B,
> +=09VPCCMD_R_SPECIAL_BUTTONS =3D 0x31,
> +=09VPCCMD_W_BL_POWER =3D 0x33,
> +};
> +
>  /*
>   * These correspond to the number of supported states - 1
>   * Future keyboard types may need a new system, if there's a collision
> @@ -234,6 +263,7 @@ static void ideapad_shared_exit(struct ideapad_privat=
e *priv)
>  /*
>   * ACPI Helpers
>   */
> +#define IDEAPAD_EC_TIMEOUT 200 /* in ms */
> =20
>  static int eval_int(acpi_handle handle, const char *name, unsigned long =
*res)
>  {
> @@ -249,6 +279,29 @@ static int eval_int(acpi_handle handle, const char *=
name, unsigned long *res)
>  =09return 0;
>  }
> =20
> +static int eval_int_with_arg(acpi_handle handle, const char *name, unsig=
ned long arg,
> +=09=09=09     unsigned long *res)
> +{
> +=09struct acpi_object_list params;
> +=09unsigned long long result;
> +=09union acpi_object in_obj;
> +=09acpi_status status;
> +
> +=09params.count =3D 1;
> +=09params.pointer =3D &in_obj;
> +=09in_obj.type =3D ACPI_TYPE_INTEGER;
> +=09in_obj.integer.value =3D arg;
> +
> +=09status =3D acpi_evaluate_integer(handle, (char *)name, &params, &resu=
lt);
> +=09if (ACPI_FAILURE(status))
> +=09=09return -EIO;
> +
> +=09if (res)
> +=09=09*res =3D result;
> +
> +=09return 0;
> +}
> +
>  static int exec_simple_method(acpi_handle handle, const char *name, unsi=
gned long arg)
>  {
>  =09acpi_status status =3D acpi_execute_simple_method(handle, (char *)nam=
e, arg);
> @@ -291,6 +344,89 @@ static int eval_dytc(acpi_handle handle, unsigned lo=
ng cmd, unsigned long *res)
>  =09return eval_int_with_arg(handle, "DYTC", cmd, res);
>  }
> =20
> +static int eval_vpcr(acpi_handle handle, unsigned long cmd, unsigned lon=
g *res)
> +{
> +=09return eval_int_with_arg(handle, "VPCR", cmd, res);
> +}
> +
> +static int eval_vpcw(acpi_handle handle, unsigned long cmd, unsigned lon=
g data)
> +{
> +=09struct acpi_object_list params;
> +=09union acpi_object in_obj[2];
> +=09acpi_status status;
> +
> +=09params.count =3D 2;
> +=09params.pointer =3D in_obj;
> +=09in_obj[0].type =3D ACPI_TYPE_INTEGER;
> +=09in_obj[0].integer.value =3D cmd;
> +=09in_obj[1].type =3D ACPI_TYPE_INTEGER;
> +=09in_obj[1].integer.value =3D data;
> +
> +=09status =3D acpi_evaluate_object(handle, "VPCW", &params, NULL);
> +=09if (ACPI_FAILURE(status))
> +=09=09return -EIO;
> +
> +=09return 0;
> +}
> +
> +static int read_ec_data(acpi_handle handle, unsigned long cmd, unsigned =
long *data)
> +{
> +=09unsigned long end_jiffies, val;
> +=09int err;
> +
> +=09err =3D eval_vpcw(handle, 1, cmd);
> +=09if (err)
> +=09=09return err;
> +
> +=09end_jiffies =3D jiffies + msecs_to_jiffies(IDEAPAD_EC_TIMEOUT) + 1;
> +
> +=09while (time_before(jiffies, end_jiffies)) {
> +=09=09schedule();
> +
> +=09=09err =3D eval_vpcr(handle, 1, &val);
> +=09=09if (err)
> +=09=09=09return err;
> +
> +=09=09if (val =3D=3D 0)
> +=09=09=09return eval_vpcr(handle, 0, data);
> +=09}
> +
> +=09acpi_handle_err(handle, "timeout in %s\n", __func__);
> +
> +=09return -ETIMEDOUT;
> +}
> +
> +static int write_ec_cmd(acpi_handle handle, unsigned long cmd, unsigned =
long data)
> +{
> +=09unsigned long end_jiffies, val;
> +=09int err;
> +
> +=09err =3D eval_vpcw(handle, 0, data);
> +=09if (err)
> +=09=09return err;
> +
> +=09err =3D eval_vpcw(handle, 1, cmd);
> +=09if (err)
> +=09=09return err;
> +
> +=09end_jiffies =3D jiffies + msecs_to_jiffies(IDEAPAD_EC_TIMEOUT) + 1;
> +
> +=09while (time_before(jiffies, end_jiffies)) {
> +=09=09schedule();
> +
> +=09=09err =3D eval_vpcr(handle, 1, &val);
> +=09=09if (err)
> +=09=09=09return err;
> +
> +=09=09if (val =3D=3D 0)
> +=09=09=09return 0;
> +=09}
> +
> +=09acpi_handle_err(handle, "timeout in %s\n", __func__);
> +
> +=09return -ETIMEDOUT;
> +}
> +
>  /*
>   * debugfs
>   */
> diff --git a/drivers/platform/x86/ideapad-laptop.h b/drivers/platform/x86=
/ideapad-laptop.h
> index 948cc61800a9..1e52f2aa0aac 100644
> --- a/drivers/platform/x86/ideapad-laptop.h
> +++ b/drivers/platform/x86/ideapad-laptop.h
> @@ -9,9 +9,6 @@
>  #ifndef _IDEAPAD_LAPTOP_H_
>  #define _IDEAPAD_LAPTOP_H_
> =20
> -#include <linux/acpi.h>
> -#include <linux/jiffies.h>
> -#include <linux/errno.h>
>  #include <linux/notifier.h>
> =20
>  enum ideapad_laptop_notifier_actions {
> @@ -22,140 +19,4 @@ int ideapad_laptop_register_notifier(struct notifier_=
block *nb);
>  int ideapad_laptop_unregister_notifier(struct notifier_block *nb);
>  void ideapad_laptop_call_notifier(unsigned long action, void *data);
> =20
> -enum {
> -=09VPCCMD_R_VPC1 =3D 0x10,
> -=09VPCCMD_R_BL_MAX,
> -=09VPCCMD_R_BL,
> -=09VPCCMD_W_BL,
> -=09VPCCMD_R_WIFI,
> -=09VPCCMD_W_WIFI,
> -=09VPCCMD_R_BT,
> -=09VPCCMD_W_BT,
> -=09VPCCMD_R_BL_POWER,
> -=09VPCCMD_R_NOVO,
> -=09VPCCMD_R_VPC2,
> -=09VPCCMD_R_TOUCHPAD,
> -=09VPCCMD_W_TOUCHPAD,
> -=09VPCCMD_R_CAMERA,
> -=09VPCCMD_W_CAMERA,
> -=09VPCCMD_R_3G,
> -=09VPCCMD_W_3G,
> -=09VPCCMD_R_ODD, /* 0x21 */
> -=09VPCCMD_W_FAN,
> -=09VPCCMD_R_RF,
> -=09VPCCMD_W_RF,
> -=09VPCCMD_W_YMC =3D 0x2A,
> -=09VPCCMD_R_FAN =3D 0x2B,
> -=09VPCCMD_R_SPECIAL_BUTTONS =3D 0x31,
> -=09VPCCMD_W_BL_POWER =3D 0x33,
> -};
> -
> -static inline int eval_int_with_arg(acpi_handle handle, const char *name=
, unsigned long arg, unsigned long *res)
> -{
> -=09struct acpi_object_list params;
> -=09unsigned long long result;
> -=09union acpi_object in_obj;
> -=09acpi_status status;
> -
> -=09params.count =3D 1;
> -=09params.pointer =3D &in_obj;
> -=09in_obj.type =3D ACPI_TYPE_INTEGER;
> -=09in_obj.integer.value =3D arg;
> -
> -=09status =3D acpi_evaluate_integer(handle, (char *)name, &params, &resu=
lt);
> -=09if (ACPI_FAILURE(status))
> -=09=09return -EIO;
> -
> -=09if (res)
> -=09=09*res =3D result;
> -
> -=09return 0;
> -}
> -
> -static inline int eval_vpcr(acpi_handle handle, unsigned long cmd, unsig=
ned long *res)
> -{
> -=09return eval_int_with_arg(handle, "VPCR", cmd, res);
> -}
> -
> -static inline int eval_vpcw(acpi_handle handle, unsigned long cmd, unsig=
ned long data)
> -{
> -=09struct acpi_object_list params;
> -=09union acpi_object in_obj[2];
> -=09acpi_status status;
> -
> -=09params.count =3D 2;
> -=09params.pointer =3D in_obj;
> -=09in_obj[0].type =3D ACPI_TYPE_INTEGER;
> -=09in_obj[0].integer.value =3D cmd;
> -=09in_obj[1].type =3D ACPI_TYPE_INTEGER;
> -=09in_obj[1].integer.value =3D data;
> -
> -=09status =3D acpi_evaluate_object(handle, "VPCW", &params, NULL);
> -=09if (ACPI_FAILURE(status))
> -=09=09return -EIO;
> -
> -=09return 0;
> -}
> -
> -#define IDEAPAD_EC_TIMEOUT 200 /* in ms */
> -
> -static inline int read_ec_data(acpi_handle handle, unsigned long cmd, un=
signed long *data)
> -{
> -=09unsigned long end_jiffies, val;
> -=09int err;
> -
> -=09err =3D eval_vpcw(handle, 1, cmd);
> -=09if (err)
> -=09=09return err;
> -
> -=09end_jiffies =3D jiffies + msecs_to_jiffies(IDEAPAD_EC_TIMEOUT) + 1;
> -
> -=09while (time_before(jiffies, end_jiffies)) {
> -=09=09schedule();
> -
> -=09=09err =3D eval_vpcr(handle, 1, &val);
> -=09=09if (err)
> -=09=09=09return err;
> -
> -=09=09if (val =3D=3D 0)
> -=09=09=09return eval_vpcr(handle, 0, data);
> -=09}
> -
> -=09acpi_handle_err(handle, "timeout in %s\n", __func__);
> -
> -=09return -ETIMEDOUT;
> -}
> -
> -static inline int write_ec_cmd(acpi_handle handle, unsigned long cmd, un=
signed long data)
> -{
> -=09unsigned long end_jiffies, val;
> -=09int err;
> -
> -=09err =3D eval_vpcw(handle, 0, data);
> -=09if (err)
> -=09=09return err;
> -
> -=09err =3D eval_vpcw(handle, 1, cmd);
> -=09if (err)
> -=09=09return err;
> -
> -=09end_jiffies =3D jiffies + msecs_to_jiffies(IDEAPAD_EC_TIMEOUT) + 1;
> -
> -=09while (time_before(jiffies, end_jiffies)) {
> -=09=09schedule();
> -
> -=09=09err =3D eval_vpcr(handle, 1, &val);
> -=09=09if (err)
> -=09=09=09return err;
> -
> -=09=09if (val =3D=3D 0)
> -=09=09=09return 0;
> -=09}
> -
> -=09acpi_handle_err(handle, "timeout in %s\n", __func__);
> -
> -=09return -ETIMEDOUT;
> -}
> -
> -#undef IDEAPAD_EC_TIMEOUT
>  #endif /* !_IDEAPAD_LAPTOP_H_ */
>=20
--8323328-66280176-1721290324=:1055--

