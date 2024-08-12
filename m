Return-Path: <linux-kernel+bounces-283076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A39794ECBF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED8C1C21BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C3B178378;
	Mon, 12 Aug 2024 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsJTb3NF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CCC1E488;
	Mon, 12 Aug 2024 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465171; cv=none; b=u1a4lsxLuyNWpoci69p9cI3Y8hDHgDW6bLfBHtZmoqPAyP1h9/xkbRPnY3wj3mbbt2sL1h65tDmosB6bx6K5xhc85+uzXgI0FKjhCFsLWppZUUdmiN5SrqxEk2ersD6b2rUYdxYOdXYWHPOLz+k9qsyGLIoO0HzAH1vDdvKh/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465171; c=relaxed/simple;
	bh=FDgfGSoDP9XMfPf7vo5ecBOQ5J/89MCzalVm2yaUwHA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rpgqTBb3xQ8DDBxDHIDDlw2FJHpCnJR4ChKNH597S4Fi3i4zNSYnaK7Q9aYE2RP3lgQGClKU5m6dOyvVrarMgD6Qc2qeER6Pnp0UW5CtesShc7es6n1Kc4DEHcdZ77Lon0iN4KY0hQzRgLi3jaBLQwnbNbObGcgPTspLmdprp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsJTb3NF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723465169; x=1755001169;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FDgfGSoDP9XMfPf7vo5ecBOQ5J/89MCzalVm2yaUwHA=;
  b=NsJTb3NFO2e83XVPwjL8nwtOsCVXixwxZWqouX3dZVrhGBtCgc3rcvPF
   Kb7y6B52OQnjkmcimTAe1drrskieahDb/O4X2incdPbD3dUYJa86/pbyh
   rspJyA81iXo6bfiPZG3DfwjunTmnQTFQV6RsTElj5gSd7jEaOlQtOCu7i
   gu64HuI3wPArN+kM5W9ShYoZ9uUt7g02rhOs0Eth9TTig5LIbu9geth6r
   YpZVgbu/BSU04+22lqsCWe/ESX4JDI5hnh1VmfpXe7/kcaC5IAbNqpK4L
   /jQ8AP6+Rk3RvRzcCXK6KxKIb/AED8z2LVGnmG061FdOFsCgw6oOJ7VNu
   Q==;
X-CSE-ConnectionGUID: ICB265S4T0ab+LdypxzdRg==
X-CSE-MsgGUID: KKDMthP8RoeSIM3U+tgeDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="46971249"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="46971249"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 05:19:29 -0700
X-CSE-ConnectionGUID: lbwKucxKQsmZ8QTreqWMAA==
X-CSE-MsgGUID: vljc+7UpSZWcAoNTLpjLVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="63096360"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 05:19:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Aug 2024 15:19:23 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: matan@svgalib.org, ghostwind@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: lg-laptop: Add operation region support
In-Reply-To: <20240809175211.5962-1-W_Armin@gmx.de>
Message-ID: <4cbf5396-37e5-5e66-e26f-c43186e285da@linux.intel.com>
References: <20240809175211.5962-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2042051820-1723465163=:1039"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2042051820-1723465163=:1039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 9 Aug 2024, Armin Wolf wrote:

> The LEGX0820 ACPI device is expected to provide a custom operation
> region:
>=20
> =09OperationRegion (XIN1, 0x8F, Zero, 0x04B0)
>         Field (XIN1, AnyAcc, Lock, Preserve)
>         {
>             DMSG,   8,
>             HDAP,   8,
>             Offset (0x03),
>             AFNM,   8,
>             Offset (0x10),
>             P80B,   8,
>             P81B,   8,
>             P82B,   8,
>             P83B,   8,
>             P84B,   8,
>             P85B,   8,
>             P86B,   8,
>             P87B,   8,
>             Offset (0x20),
>             DTTM,   8,
>             TMP1,   8,
>             LTP1,   8,
>             HTP1,   8,
>             TMP2,   8,
>             LTP2,   8,
>             HTP2,   8,
>             Offset (0x3E8),
>             PMSG,   1600
>         }
>=20
> The PMSG field is used by AML code to log debug messages when DMSG is
> true. Since those debug messages are already logged using the standard
> ACPI Debug object, we set DMSG unconditionally to 0x00 and ignore any
> writes to PMSG.
>=20
> The TMPx, LTPx, HTPx and AFNM fields are used to inform the driver when
> the temperature/(presumably) trip points/fan mode changes. This only
> happens when the DTTM flag is set.
>=20
> Unfortunately we have to implement support for this operation region
> because the AML codes uses code constructs like this one:
>=20
> =09If (((\_SB.XINI.PLAV !=3D Zero) && (\_SB.XINI.DTTM !=3D Zero)))
>=20
> The PLAV field gets set to 1 when the driver registers its address space
> handler, so by default XIN1 should not be accessed.
>=20
> However ACPI does not use short-circuit evaluation when evaluating
> logical conditions. This causes the DTTM field to be accessed even
> when PLAV is 0, which results in an ACPI error.
> Since this check happens inside various thermal-related ACPI control
> methods, various thermal zone become unusable since any attempts to

attempt

> read their temperature results in an ACPI error.
>=20
> Fix this by providing support for this operation region. I suspect
> that the problem does not happen under Windows (which seemingly does
> not use short-circuit evaluation either) because the necessary driver
> comes preinstalled with the machine.
>=20
> Tested-by: Chris <ghostwind@gmail.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/lg-laptop.c | 128 +++++++++++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>=20
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-l=
aptop.c
> index 9c7857842caf..6310a23f808c 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -8,6 +8,8 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>=20
>  #include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
>  #include <linux/dmi.h>
>  #include <linux/input.h>
>  #include <linux/input/sparse-keymap.h>
> @@ -31,6 +33,25 @@ MODULE_AUTHOR("Matan Ziv-Av");
>  MODULE_DESCRIPTION("LG WMI Hotkey Driver");
>  MODULE_LICENSE("GPL");
>=20
> +static bool fw_debug;
> +module_param(fw_debug, bool, 0);
> +MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages")=
;
> +
> +#define LG_ADDRESS_SPACE_ID=09=09=090x8F
> +
> +#define LG_ADDRESS_SPACE_DEBUG_FLAG_ADR=09=090x00
> +#define LG_ADDRESS_SPACE_DEBUG_MSG_START_ADR=090x3E8
> +#define LG_ADDRESS_SPACE_DEBUG_MSG_END_ADR=090x5E8
> +
> +#define LG_ADDRESS_SPACE_DTTM_FLAG_ADR=09=090x20
> +#define LG_ADDRESS_SPACE_FAN_MODE_ADR=09=090x03

Any particular reason why there are not in numerical order?

> +#define LG_ADDRESS_SPACE_CPU_TEMP_ADR=09=090x21
> +#define LG_ADDRESS_SPACE_CPU_TRIP_LOW_ADR=090x22
> +#define LG_ADDRESS_SPACE_CPU_TRIP_HIGH_ADR=090x23
> +#define LG_ADDRESS_SPACE_MB_TEMP_ADR=09=090x24
> +#define LG_ADDRESS_SPACE_MB_TRIP_LOW_ADR=090x25
> +#define LG_ADDRESS_SPACE_MB_TRIP_HIGH_ADR=090x26
> +
>  #define WMI_EVENT_GUID0=09"E4FB94F9-7F2B-4173-AD1A-CD1D95086248"
>  #define WMI_EVENT_GUID1=09"023B133E-49D1-4E10-B313-698220140DC2"
>  #define WMI_EVENT_GUID2=09"37BE1AC0-C3F2-4B1F-BFBE-8FDEAF2814D6"
> @@ -646,6 +667,101 @@ static struct platform_driver pf_driver =3D {
>  =09}
>  };
>=20
> +static acpi_status lg_laptop_address_space_write(struct device *dev, acp=
i_physical_address address,
> +=09=09=09=09=09=09 size_t size, u64 *value)

Why is this write function taking u64 _pointer_?

> +{
> +=09u8 byte;
> +
> +=09/* Ignore any debug messages */
> +=09if (address >=3D LG_ADDRESS_SPACE_DEBUG_MSG_START_ADR &&
> +=09    address <=3D LG_ADDRESS_SPACE_DEBUG_MSG_END_ADR)
> +=09=09return AE_OK;
> +
> +=09if (size !=3D sizeof(byte))
> +=09=09return AE_BAD_PARAMETER;
> +
> +=09byte =3D *value & 0xFF;
> +
> +=09switch (address) {
> +=09case LG_ADDRESS_SPACE_FAN_MODE_ADR:
> +=09=09dev_dbg(dev, "Fan mode set to mode %u\n", byte);
> +=09=09return AE_OK;
> +=09case LG_ADDRESS_SPACE_CPU_TEMP_ADR:
> +=09=09dev_dbg(dev, "CPU temperature is %u =C2=B0C\n", byte);
> +=09=09return AE_OK;
> +=09case LG_ADDRESS_SPACE_CPU_TRIP_LOW_ADR:
> +=09=09dev_dbg(dev, "CPU lower trip point set to %u =C2=B0C\n", byte);
> +=09=09return AE_OK;
> +=09case LG_ADDRESS_SPACE_CPU_TRIP_HIGH_ADR:
> +=09=09dev_dbg(dev, "CPU higher trip point set to %u =C2=B0C\n", byte);
> +=09=09return AE_OK;
> +=09case LG_ADDRESS_SPACE_MB_TEMP_ADR:
> +=09=09dev_dbg(dev, "Motherboard temperature is %u =C2=B0C\n", byte);
> +=09=09return AE_OK;
> +=09case LG_ADDRESS_SPACE_MB_TRIP_LOW_ADR:
> +=09=09dev_dbg(dev, "Motherboard lower trip point set to %u =C2=B0C\n", b=
yte);
> +=09=09return AE_OK;
> +=09case LG_ADDRESS_SPACE_MB_TRIP_HIGH_ADR:
> +=09=09dev_dbg(dev, "Motherboard higher trip point set to %u =C2=B0C\n", =
byte);
> +=09=09return AE_OK;
> +=09default:
> +=09=09dev_notice_ratelimited(dev, "Ignoring write to unknown opregion ad=
dress %llu\n",
> +=09=09=09=09       address);
> +=09=09return AE_OK;
> +=09}
> +}
> +
> +static acpi_status lg_laptop_address_space_read(struct device *dev, acpi=
_physical_address address,
> +=09=09=09=09=09=09size_t size, u64 *value)
> +{
> +=09if (size !=3D 1)
> +=09=09return AE_BAD_PARAMETER;
> +
> +=09switch (address) {
> +=09case LG_ADDRESS_SPACE_DEBUG_FLAG_ADR:
> +=09=09/* Debug messages are already printed using the standard ACPI Debu=
g object */
> +=09=09*value =3D 0x00;
> +=09=09return AE_OK;
> +=09case LG_ADDRESS_SPACE_DTTM_FLAG_ADR:
> +=09=09*value =3D fw_debug;
> +=09=09return AE_OK;
> +=09default:
> +=09=09dev_notice_ratelimited(dev, "Attempt to read unknown opregion addr=
ess %llu\n",
> +=09=09=09=09       address);
> +=09=09return AE_BAD_PARAMETER;
> +=09}
> +}
> +
> +static acpi_status lg_laptop_address_space_handler(u32 function, acpi_ph=
ysical_address address,
> +=09=09=09=09=09=09   u32 bits, u64 *value, void *handler_context,
> +=09=09=09=09=09=09   void *region_context)
> +{
> +=09struct device *dev =3D handler_context;
> +=09size_t size;
> +
> +=09if (bits % 8)
> +=09=09return AE_BAD_PARAMETER;
> +
> +=09size =3D bits / 8;

BITS_PER_BYTE x2

--=20
 i.

> +
> +=09switch (function) {
> +=09case ACPI_READ:
> +=09=09return lg_laptop_address_space_read(dev, address, size, value);
> +=09case ACPI_WRITE:
> +=09=09return lg_laptop_address_space_write(dev, address, size, value);
> +=09default:
> +=09=09return AE_BAD_PARAMETER;
> +=09}
> +}
> +
> +static void lg_laptop_remove_address_space_handler(void *data)
> +{
> +=09struct acpi_device *device =3D data;
> +
> +=09acpi_remove_address_space_handler(device->handle, LG_ADDRESS_SPACE_ID=
,
> +=09=09=09=09=09  &lg_laptop_address_space_handler);
> +}
> +
>  static int acpi_add(struct acpi_device *device)
>  {
>  =09struct platform_device_info pdev_info =3D {
> @@ -653,6 +769,7 @@ static int acpi_add(struct acpi_device *device)
>  =09=09.name =3D PLATFORM_NAME,
>  =09=09.id =3D PLATFORM_DEVID_NONE,
>  =09};
> +=09acpi_status status;
>  =09int ret;
>  =09const char *product;
>  =09int year =3D 2017;
> @@ -660,6 +777,17 @@ static int acpi_add(struct acpi_device *device)
>  =09if (pf_device)
>  =09=09return 0;
>=20
> +=09status =3D acpi_install_address_space_handler(device->handle, LG_ADDR=
ESS_SPACE_ID,
> +=09=09=09=09=09=09    &lg_laptop_address_space_handler,
> +=09=09=09=09=09=09    NULL, &device->dev);
> +=09if (ACPI_FAILURE(status))
> +=09=09return -ENODEV;
> +
> +=09ret =3D devm_add_action_or_reset(&device->dev, lg_laptop_remove_addre=
ss_space_handler,
> +=09=09=09=09       device);
> +=09if (ret < 0)
> +=09=09return ret;
> +
>  =09ret =3D platform_driver_register(&pf_driver);
>  =09if (ret)
>  =09=09return ret;
> --
> 2.39.2
>=20

--8323328-2042051820-1723465163=:1039--

