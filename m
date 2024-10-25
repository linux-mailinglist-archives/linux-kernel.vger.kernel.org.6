Return-Path: <linux-kernel+bounces-381841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D391C9B0530
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0133A1C22490
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D291EF958;
	Fri, 25 Oct 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NopL/FBy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106113B584;
	Fri, 25 Oct 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865483; cv=none; b=rkcoxGBY1V142jjkEsBvBkdxtUNvCZnQFzKzLsHHVLCIYi+9MlJpb9Jha5VRCOPAgji52GfaaoiaJXHDouaFWgGmnOrr5TJ/0bVuBzaBiIqdzvAgPoEsyXnsYUjSR1DuyPc33J6819bz9snGTU1VCS1NDoPzQej9qxeJaDKQOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865483; c=relaxed/simple;
	bh=xAV+1gr9q7aMx1tiVqz0CbPaRZ63Q9kmsicir3h6vTQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LSIG6n6CGHkVUl2rCRsbzKyrRvApkhca+gQK3G0wWhGccFFfbsBWAvDneTaGfWc44JeJxKPEsILggzQsoRSGseuDgeM/91N2bIF9vdxXbLNx9SW4JshyYyiBWXWgDwsAtgvNxyyLBOTMFr5zlQFEVc7wwVS4Fybyf8RKo3Q1aGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NopL/FBy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729865480; x=1761401480;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xAV+1gr9q7aMx1tiVqz0CbPaRZ63Q9kmsicir3h6vTQ=;
  b=NopL/FByMggxNMk2bUDcXOD1at9yFABplPenaPJOZSVBlcAQafKNwrji
   d1BWnQFm9zXKkKcPvkoKRd5R+T3Oo+9DnzkLCj/VKHwot2kqXp6Z7HQfw
   4NiF6IAJN//mtVl625tC6Po1WDM/tXRpEvkcqNMiDjlbkX23cEM/OovXP
   XJEzVWce1duVr4Wi/BZ//1nQYBBykaQuL1fjw1XzklY8Atw22zHQFQ9HK
   TypTW+Tfbu7fxZcZ3p2GygnoRj3yReky6i+oEe94MGg10y12OFdIHUSWq
   RckSIxYhTg1V0UiroLPJeTu+kpSZbmiC/qdsZukefogOjDHWv3xu1coQe
   w==;
X-CSE-ConnectionGUID: BHqHMLhWQ2azSF0+849z9A==
X-CSE-MsgGUID: FpL04xIaTzmiktUudCGVhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="33339367"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="33339367"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:11:20 -0700
X-CSE-ConnectionGUID: MxDC1G0MQ/WjCgBco82PJg==
X-CSE-MsgGUID: E5lpoBx+Th+lXf5DDPXBVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81033280"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:11:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Oct 2024 17:11:14 +0300 (EEST)
To: Kurt Borja <kuurtb@gmail.com>
cc: W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v8 1/4] alienware-wmi: fixed indentation and clean up
In-Reply-To: <20241025014016.4927-2-kuurtb@gmail.com>
Message-ID: <18792d2f-f848-eb37-87dc-b7cd5b73925b@linux.intel.com>
References: <20241025013856.4729-2-kuurtb@gmail.com> <20241025014016.4927-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1430041361-1729865474=:946"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1430041361-1729865474=:946
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Oct 2024, Kurt Borja wrote:

> Fixed inconsistent indentation and removed unnecessary (acpi_size) and
> (u32 *) casts.
>=20
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> ---
> v8:
>  - Unchanged
> v7:
>  - Unchanged
> v6:
>  - Unchanged
> ---
>  drivers/platform/x86/dell/alienware-wmi.c | 134 +++++++++++-----------
>  1 file changed, 67 insertions(+), 67 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform=
/x86/dell/alienware-wmi.c
> index f5ee62ce1..16a3fe9ac 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -116,68 +116,68 @@ static int __init dmi_matched(const struct dmi_syst=
em_id *dmi)
> =20
>  static const struct dmi_system_id alienware_quirks[] __initconst =3D {
>  =09{
> -=09 .callback =3D dmi_matched,
> -=09 .ident =3D "Alienware X51 R3",
> -=09 .matches =3D {
> -=09=09     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -=09=09     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R3"),
> -=09=09     },
> -=09 .driver_data =3D &quirk_x51_r3,
> -=09 },
> +=09=09.callback =3D dmi_matched,
> +=09=09.ident =3D "Alienware X51 R3",
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R3"),
> +=09=09},
> +=09=09.driver_data =3D &quirk_x51_r3,
> +=09},
>  =09{
> -=09 .callback =3D dmi_matched,
> -=09 .ident =3D "Alienware X51 R2",
> -=09 .matches =3D {
> -=09=09     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -=09=09     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R2"),
> -=09=09     },
> -=09 .driver_data =3D &quirk_x51_r1_r2,
> -=09 },
> +=09=09.callback =3D dmi_matched,
> +=09=09.ident =3D "Alienware X51 R2",
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R2"),
> +=09=09},
> +=09=09.driver_data =3D &quirk_x51_r1_r2,
> +=09},
>  =09{
> -=09 .callback =3D dmi_matched,
> -=09 .ident =3D "Alienware X51 R1",
> -=09 .matches =3D {
> -=09=09     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -=09=09     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51"),
> -=09=09     },
> -=09 .driver_data =3D &quirk_x51_r1_r2,
> -=09 },
> +=09=09.callback =3D dmi_matched,
> +=09=09.ident =3D "Alienware X51 R1",
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51"),
> +=09=09},
> +=09=09.driver_data =3D &quirk_x51_r1_r2,
> +=09},
>  =09{
> -=09 .callback =3D dmi_matched,
> -=09 .ident =3D "Alienware ASM100",
> -=09 .matches =3D {
> -=09=09     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -=09=09     DMI_MATCH(DMI_PRODUCT_NAME, "ASM100"),
> -=09=09     },
> -=09 .driver_data =3D &quirk_asm100,
> -=09 },
> +=09=09.callback =3D dmi_matched,
> +=09=09.ident =3D "Alienware ASM100",
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "ASM100"),
> +=09=09},
> +=09=09.driver_data =3D &quirk_asm100,
> +=09},
>  =09{
> -=09 .callback =3D dmi_matched,
> -=09 .ident =3D "Alienware ASM200",
> -=09 .matches =3D {
> -=09=09     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -=09=09     DMI_MATCH(DMI_PRODUCT_NAME, "ASM200"),
> -=09=09     },
> -=09 .driver_data =3D &quirk_asm200,
> -=09 },
> +=09=09.callback =3D dmi_matched,
> +=09=09.ident =3D "Alienware ASM200",
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "ASM200"),
> +=09=09},
> +=09=09.driver_data =3D &quirk_asm200,
> +=09},
>  =09{
> -=09 .callback =3D dmi_matched,
> -=09 .ident =3D "Alienware ASM201",
> -=09 .matches =3D {
> -=09=09     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -=09=09     DMI_MATCH(DMI_PRODUCT_NAME, "ASM201"),
> -=09=09     },
> -=09 .driver_data =3D &quirk_asm201,
> -=09 },
> -=09 {
> -=09 .callback =3D dmi_matched,
> -=09 .ident =3D "Dell Inc. Inspiron 5675",
> -=09 .matches =3D {
> -=09=09     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -=09=09     DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5675"),
> -=09=09     },
> -=09 .driver_data =3D &quirk_inspiron5675,
> -=09 },
> +=09=09.callback =3D dmi_matched,
> +=09=09.ident =3D "Alienware ASM201",
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "ASM201"),
> +=09=09},
> +=09=09.driver_data =3D &quirk_asm201,
> +=09},
> +=09{
> +=09=09.callback =3D dmi_matched,
> +=09=09.ident =3D "Dell Inc. Inspiron 5675",
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5675"),
> +=09=09},
> +=09=09.driver_data =3D &quirk_inspiron5675,
> +=09},
>  =09{}
>  };
> =20
> @@ -221,8 +221,8 @@ static struct platform_zone *zone_data;
> =20
>  static struct platform_driver platform_driver =3D {
>  =09.driver =3D {
> -=09=09   .name =3D "alienware-wmi",
> -=09=09   }
> +=09=09.name =3D "alienware-wmi",
> +=09}
>  };
> =20
>  static struct attribute_group zone_attribute_group =3D {
> @@ -292,7 +292,7 @@ static int alienware_update_led(struct platform_zone =
*zone)
>  =09=09guid =3D WMAX_CONTROL_GUID;
>  =09=09method_id =3D WMAX_METHOD_ZONE_CONTROL;
> =20
> -=09=09input.length =3D (acpi_size) sizeof(wmax_basic_args);
> +=09=09input.length =3D sizeof(wmax_basic_args);
>  =09=09input.pointer =3D &wmax_basic_args;
>  =09} else {
>  =09=09legacy_args.colors =3D zone->colors;
> @@ -306,7 +306,7 @@ static int alienware_update_led(struct platform_zone =
*zone)
>  =09=09=09guid =3D LEGACY_CONTROL_GUID;
>  =09=09method_id =3D zone->location + 1;
> =20
> -=09=09input.length =3D (acpi_size) sizeof(legacy_args);
> +=09=09input.length =3D sizeof(legacy_args);
>  =09=09input.pointer =3D &legacy_args;
>  =09}
>  =09pr_debug("alienware-wmi: guid %s method %d\n", guid, method_id);
> @@ -358,7 +358,7 @@ static int wmax_brightness(int brightness)
>  =09=09.led_mask =3D 0xFF,
>  =09=09.percentage =3D brightness,
>  =09};
> -=09input.length =3D (acpi_size) sizeof(args);
> +=09input.length =3D sizeof(args);
>  =09input.pointer =3D &args;
>  =09status =3D wmi_evaluate_method(WMAX_CONTROL_GUID, 0,
>  =09=09=09=09     WMAX_METHOD_BRIGHTNESS, &input, NULL);
> @@ -508,7 +508,7 @@ static acpi_status alienware_wmax_command(struct wmax=
_basic_args *in_args,
>  =09struct acpi_buffer input;
>  =09struct acpi_buffer output;
> =20
> -=09input.length =3D (acpi_size) sizeof(*in_args);
> +=09input.length =3D sizeof(*in_args);
>  =09input.pointer =3D in_args;
>  =09if (out_data) {
>  =09=09output.length =3D ACPI_ALLOCATE_BUFFER;
> @@ -542,7 +542,7 @@ static ssize_t show_hdmi_cable(struct device *dev,
>  =09};
>  =09status =3D
>  =09    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> -=09=09=09=09   (u32 *) &out_data);
> +=09=09=09=09   &out_data);
>  =09if (ACPI_SUCCESS(status)) {
>  =09=09if (out_data =3D=3D 0)
>  =09=09=09return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -563,7 +563,7 @@ static ssize_t show_hdmi_source(struct device *dev,
>  =09};
>  =09status =3D
>  =09    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> -=09=09=09=09   (u32 *) &out_data);
> +=09=09=09=09   &out_data);
> =20
>  =09if (ACPI_SUCCESS(status)) {
>  =09=09if (out_data =3D=3D 1)
> @@ -643,7 +643,7 @@ static ssize_t show_amplifier_status(struct device *d=
ev,
>  =09};
>  =09status =3D
>  =09    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> -=09=09=09=09   (u32 *) &out_data);
> +=09=09=09=09   &out_data);
>  =09if (ACPI_SUCCESS(status)) {
>  =09=09if (out_data =3D=3D 0)
>  =09=09=09return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -695,7 +695,7 @@ static ssize_t show_deepsleep_status(struct device *d=
ev,
>  =09=09.arg =3D 0,
>  =09};
>  =09status =3D alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_ST=
ATUS,
> -=09=09=09=09=09(u32 *) &out_data);
> +=09=09=09=09=09&out_data);
>  =09if (ACPI_SUCCESS(status)) {
>  =09=09if (out_data =3D=3D 0)
>  =09=09=09return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
>=20
--8323328-1430041361-1729865474=:946--

