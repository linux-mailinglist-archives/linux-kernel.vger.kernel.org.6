Return-Path: <linux-kernel+bounces-275971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8748948CA2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB0528363F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081D31BE233;
	Tue,  6 Aug 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRFE4PU/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92145EADC;
	Tue,  6 Aug 2024 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722939402; cv=none; b=M1E0eGbWI/Dbp3xduVNqbKBS4mpANJvKnkeas1J/IBZ63J2sD5d0gBldWkw05KbOXJhtOAHsrWvnJWsNAiZ4vASfDCHCChwMIJ/euKFykz8lXMf+ttqFhdpWF15ZZnoANzbOz1vyKaioLocIZDDz1sMhWBsxvMUou2fRCi622Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722939402; c=relaxed/simple;
	bh=r0qXqflS1SWVP4fWyg7a32ilqECzbT4vUNMq8RrXrAI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y2ZvQZMWWAPeQg+wOuLZT0eEuQrXNFfwL0qPtL/SVlgZTg/iBaZLT8+AorAlnNaw9I+IH0OcUntvQ9Hldw+XLfRmuAmU48n50kML83iDBil2Gr0qaOWou8Tg/GX5nH9RFIyC9rOvVpuRrOY+PxCffyam2xxb5bAGi43bVT09kRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRFE4PU/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722939399; x=1754475399;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r0qXqflS1SWVP4fWyg7a32ilqECzbT4vUNMq8RrXrAI=;
  b=jRFE4PU/0HkfRZ4/cxnYA8lMVNddEkkVnkrIPTYkRMSPyq/KpXQcrWTL
   XZZpK/43Lnz840jlQsOPloZ/ehL6q1k0F/nHp0X6xfRcUHCZB2oJyM7N/
   GrDFFVjjtdJgiCMecvfgo5rmUNqI23zVoO1d05omjFWlHCh5JCBCH6GHw
   qCG7jEq0KfmPE9gw+MslWftTZtqHLRqPNliNIPiHVifL0Vn5TGCgn4kiZ
   EuJjV8wL3caECmULWXLrKgSfGBDxMUbcYUctsSJ0drCbjQ5Ma5DkfCOSy
   zDrDxwsnZU0WpncKlVm+WvgfsIJZKhGrAJCbLM+2dKCxGuGOdM9uSshiu
   w==;
X-CSE-ConnectionGUID: tZTg6vhpTiO6E+zWAhyykQ==
X-CSE-MsgGUID: WDPv2HgRT4OpIPdtXC/ujA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20823557"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="20823557"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 03:16:38 -0700
X-CSE-ConnectionGUID: QVpbSD9xQ02jVfSniowm5A==
X-CSE-MsgGUID: cpXNjbzaQli3yT1V9kEmvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="60833643"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 03:16:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Aug 2024 13:16:31 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com
Subject: Re: [PATCH v2 2/6] platform/x86: asus-armoury: move existing tunings
 to asus-armoury module
In-Reply-To: <20240806020747.365042-3-luke@ljones.dev>
Message-ID: <bb056dee-508c-6186-324a-d45bbd1c2306@linux.intel.com>
References: <20240806020747.365042-1-luke@ljones.dev> <20240806020747.365042-3-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1468362119-1722939391=:1027"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1468362119-1722939391=:1027
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 6 Aug 2024, Luke D. Jones wrote:

> The fw_attributes_class provides a much cleaner interface to all of the
> attributes introduced to asus-wmi. This patch moves all of these extra
> attributes over to fw_attributes_class, and shifts the bulk of these
> definitions to a new kernel module to reduce the clutter of asus-wmi
> with the intention of deprecating the asus-wmi attributes in future.
>=20
> The work applies only to WMI methods which don't have a clearly defined
> place within the sysfs and as a result ended up lumped together in
> /sys/devices/platform/asus-nb-wmi/ with no standard API.
>=20
> Where possible the fw attrs now implement defaults, min, max, scalar,
> choices, etc. As en example dgpu_disable becomes:
>=20
> /sys/class/firmware-attributes/asus-armoury/attributes/dgpu_disable/
> =E2=94=9C=E2=94=80=E2=94=80 current_value
> =E2=94=9C=E2=94=80=E2=94=80 display_name
> =E2=94=9C=E2=94=80=E2=94=80 possible_values
> =E2=94=94=E2=94=80=E2=94=80 type
>=20
> as do other attributes.
>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/Kconfig               |  14 +
>  drivers/platform/x86/Makefile              |   1 +
>  drivers/platform/x86/asus-armoury.c        | 706 +++++++++++++++++++++
>  drivers/platform/x86/asus-armoury.h        | 195 ++++++
>  drivers/platform/x86/asus-wmi.c            |  48 +-
>  include/linux/platform_data/x86/asus-wmi.h |  11 +
>  6 files changed, 973 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/platform/x86/asus-armoury.c
>  create mode 100644 drivers/platform/x86/asus-armoury.h
>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 665fa9524986..8ecc73ef2670 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -265,6 +265,19 @@ config ASUS_WIRELESS
>  =09  If you choose to compile this driver as a module the module will be
>  =09  called asus-wireless.
> =20
> +config ASUS_ARMOURY
> +=09tristate "ASUS Armoury (firmware) Driver"
> +=09depends on ACPI_WMI
> +=09depends on ASUS_WMI
> +=09select FW_ATTR_CLASS
> +=09help
> +=09  Say Y here if you have a WMI aware Asus laptop and would like to us=
e the
> +=09  firmware_attributes API to control various settings typically expos=
ed in
> +=09  the ASUS Armoury Crate application available on Windows.
> +
> +=09  To compile this driver as a module, choose M here: the module will
> +=09  be called asus-armoury.
> +
>  config ASUS_WMI
>  =09tristate "ASUS WMI Driver"
>  =09depends on ACPI_WMI
> @@ -276,6 +289,7 @@ config ASUS_WMI
>  =09depends on HOTPLUG_PCI
>  =09depends on ACPI_VIDEO || ACPI_VIDEO =3D n
>  =09depends on SERIO_I8042 || SERIO_I8042 =3D n
> +=09select ASUS_ARMOURY
>  =09select INPUT_SPARSEKMAP
>  =09select LEDS_CLASS
>  =09select NEW_LEDS
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index e1b142947067..fe3e7e7dede8 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_GMUX)=09+=3D apple-gmux.o
>  # ASUS
>  obj-$(CONFIG_ASUS_LAPTOP)=09+=3D asus-laptop.o
>  obj-$(CONFIG_ASUS_WIRELESS)=09+=3D asus-wireless.o
> +obj-$(CONFIG_ASUS_ARMOURY)=09+=3D asus-armoury.o
>  obj-$(CONFIG_ASUS_WMI)=09=09+=3D asus-wmi.o
>  obj-$(CONFIG_ASUS_NB_WMI)=09+=3D asus-nb-wmi.o
>  obj-$(CONFIG_ASUS_TF103C_DOCK)=09+=3D asus-tf103c-dock.o
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/a=
sus-armoury.c
> new file mode 100644
> index 000000000000..bb049ead00f9
> --- /dev/null
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -0,0 +1,706 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Asus Armoury (WMI) attributes driver. This driver uses the fw_attribu=
tes
> + * class to expose the various WMI functions that many gaming and some
> + * non-gaming ASUS laptops have available.
> + * These typically don't fit anywhere else in the sysfs such as under LE=
D class,
> + * hwmon or other, and are set in Windows using the ASUS Armoury Crate t=
ool.
> + *
> + * Copyright(C) 2010 Intel Corporation.
> + * Copyright(C) 2024-2024 Luke Jones <luke@ljones.dev>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/platform_data/x86/asus-wmi.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/types.h>
> +#include <linux/dmi.h>
> +#include <linux/device.h>
> +#include <linux/kmod.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/kernel.h>
> +#include "asus-armoury.h"
> +#include "firmware_attributes_class.h"
> +
> +#define ASUS_NB_WMI_EVENT_GUID "0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1C"
> +
> +#define ASUS_MINI_LED_MODE_MASK 0x03
> +/* Standard modes for devices with only on/off */
> +#define ASUS_MINI_LED_OFF 0x00
> +#define ASUS_MINI_LED_ON 0x01
> +/* New mode on some devices, define here to clarify remapping later */
> +#define ASUS_MINI_LED_STRONG_MODE 0x02
> +/* New modes for devices with 3 mini-led mode types */
> +#define ASUS_MINI_LED_2024_WEAK 0x00
> +#define ASUS_MINI_LED_2024_STRONG 0x01
> +#define ASUS_MINI_LED_2024_OFF 0x02
> +
> +/* Default limits for tunables available on ASUS ROG laptops */
> +#define PPT_CPU_LIMIT_MIN 5
> +#define PPT_CPU_LIMIT_MAX 150
> +#define PPT_CPU_LIMIT_DEFAULT 80
> +#define PPT_PLATFORM_MIN 5
> +#define PPT_PLATFORM_MAX 100
> +#define PPT_PLATFORM_DEFAULT 80
> +#define NVIDIA_BOOST_MIN 5
> +#define NVIDIA_BOOST_MAX 25
> +#define NVIDIA_TEMP_MIN 75
> +#define NVIDIA_TEMP_MAX 87
> +
> +/* Tunables provided by ASUS for gaming laptops */
> +struct rog_tunables {
> +=09u32 cpu_default;
> +=09u32 cpu_min;
> +=09u32 cpu_max;
> +
> +=09u32 platform_default;
> +=09u32 platform_min;
> +=09u32 platform_max;
> +
> +=09u32 ppt_pl1_spl; // cpu
> +=09u32 ppt_pl2_sppt; // cpu
> +=09u32 ppt_apu_sppt; // plat
> +=09u32 ppt_platform_sppt; // plat
> +=09u32 ppt_fppt; // cpu
> +
> +=09u32 nv_boost_default;
> +=09u32 nv_boost_min;
> +=09u32 nv_boost_max;
> +=09u32 nv_dynamic_boost;
> +
> +=09u32 nv_temp_default;
> +=09u32 nv_temp_min;
> +=09u32 nv_temp_max;
> +=09u32 nv_temp_target;
> +};
> +
> +static const struct class *fw_attr_class;
> +
> +struct asus_armoury_priv {
> +=09struct device *fw_attr_dev;
> +=09struct kset *fw_attr_kset;
> +
> +=09struct rog_tunables *rog_tunables;
> +=09u32 mini_led_dev_id;
> +=09u32 gpu_mux_dev_id;
> +
> +=09struct mutex mutex;
> +};
> +
> +static struct asus_armoury_priv asus_armoury =3D { .mutex =3D __MUTEX_IN=
ITIALIZER(
> +=09=09=09=09=09=09=09 asus_armoury.mutex) };

Please put the mutex member on own line.

> +
> +struct fw_attrs_group {
> +=09u32 pending_reboot;
> +};
> +
> +static struct fw_attrs_group fw_attrs =3D {
> +=09.pending_reboot =3D 0,
> +};
> +
> +struct asus_attr_group {
> +=09const struct attribute_group *attr_group;
> +=09u32 wmi_devid;
> +};
> +
> +/**
> + * asus_wmi_is_present() - determine if a WMI interface is available.
> + * @dev_id: The WMI function ID to use.
> + *
> + * Returns: Boolean state. Note that an error will also return false.
> + */
> +static bool asus_wmi_is_present(u32 dev_id)
> +{
> +=09u32 retval;
> +=09int status;
> +
> +=09status =3D asus_wmi_get_devstate_dsts(dev_id, &retval);
> +=09pr_debug("%s called (0x%08x), retval: 0x%08x\n", __func__, dev_id, re=
tval);
> +
> +=09return status =3D=3D 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
> +}
> +
> +static void asus_set_reboot_and_signal_event(void)
> +{
> +=09fw_attrs.pending_reboot =3D 1;
> +=09kobject_uevent(&asus_armoury.fw_attr_dev->kobj, KOBJ_CHANGE);
> +}
> +
> +static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_att=
ribute *attr, char *buf)
> +{
> +=09return sysfs_emit(buf, "%u\n", fw_attrs.pending_reboot);
> +}
> +
> +static struct kobj_attribute pending_reboot =3D __ATTR_RO(pending_reboot=
);
> +
> +static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
> +{
> +=09return !strcmp(attr->attr.name, "gpu_mux_mode") ||
> +=09       !strcmp(attr->attr.name, "panel_hd_mode");
> +}
> +
> +/**
> + * attr_int_store() - Generic store function for use with most WMI funct=
ions.
> + * @kobj: Pointer to the driver object.
> + * @kobj_attribute: Pointer the attribute calling this function.
> + * @buf: The buffer to read from, this is parsed to `int` type.
> + * @count:
> + * @min: Minimum accepted value. Below this returns -EINVAL.
> + * @max: Maximum accepted value. Above this returns -EINVAL.
> + * @store_value: Pointer to where the parsed value should be stored.
> + * @wmi_dev: The WMI function ID to use.
> + *
> + * The WMI functions available on most ASUS laptops return a 1 as "succe=
ss", and
> + * a 0 as failed. However some functions can return n > 1 for additional=
 errors.
> + * attr_int_store() currently treats all values which are not 1 as error=
s, ignoring
> + * the possible differences in WMI error returns.
> + *
> + * Returns: Either count, or an error.
> + */
> +static ssize_t attr_int_store(struct kobject *kobj, struct kobj_attribut=
e *attr,
> +=09=09=09      const char *buf, size_t count, u32 min, u32 max, u32 *sto=
re_value,
> +=09=09=09      u32 wmi_dev)
> +{
> +=09u32 result, value;
> +=09int err;
> +
> +=09err =3D kstrtouint(buf, 10, &value);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (value < min || value > max)
> +=09=09return -EINVAL;
> +
> +=09err =3D asus_wmi_set_devstate(wmi_dev, value, &result);
> +=09if (err) {
> +=09=09pr_err("Failed to set %s: %d\n", attr->attr.name, err);
> +=09=09return err;
> +=09}
> +
> +=09if (result !=3D 1) {
> +=09=09pr_err("Failed to set %s (result): 0x%x\n", attr->attr.name, resul=
t);
> +=09=09return -EIO;
> +=09}
> +
> +=09if (store_value !=3D NULL)
> +=09=09*store_value =3D value;
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +=09if (asus_bios_requires_reboot(attr))
> +=09=09asus_set_reboot_and_signal_event();
> +
> +=09return count;
> +}
> +
> +/* Mini-LED mode *******************************************************=
*******/
> +static ssize_t mini_led_mode_current_value_show(struct kobject *kobj,
> +=09=09=09=09=09=09struct kobj_attribute *attr, char *buf)
> +{
> +=09u32 value;
> +=09int err;
> +
> +=09err =3D asus_wmi_get_devstate_dsts(asus_armoury.mini_led_dev_id, &val=
ue);
> +=09if (err)
> +=09=09return err;
> +
> +=09value =3D value & ASUS_MINI_LED_MODE_MASK;

value &=3D ASUS_MINI_LED_MODE_MASK;

> +
> +=09/*
> +=09 * Remap the mode values to match previous generation mini-led. The l=
ast gen

LED

> +=09 * WMI 0 =3D=3D off, while on this version WMI 2 =3D=3Doff (flipped).

inconsistent spaces.

> +=09 */
> +=09if (asus_armoury.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2=
) {
> +=09=09switch (value) {
> +=09=09case ASUS_MINI_LED_2024_WEAK:
> +=09=09=09value =3D ASUS_MINI_LED_ON;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_2024_STRONG:
> +=09=09=09value =3D ASUS_MINI_LED_STRONG_MODE;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_2024_OFF:
> +=09=09=09value =3D ASUS_MINI_LED_OFF;
> +=09=09=09break;
> +=09=09}
> +=09}
> +
> +=09return sysfs_emit(buf, "%u\n", value);
> +}
> +
> +static ssize_t mini_led_mode_current_value_store(struct kobject *kobj,
> +=09=09=09=09=09=09 struct kobj_attribute *attr, const char *buf,
> +=09=09=09=09=09=09 size_t count)
> +{
> +=09int result, err;
> +=09u32 mode;
> +
> +=09err =3D kstrtou32(buf, 10, &mode);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (asus_armoury.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE =
&&
> +=09    mode > ASUS_MINI_LED_ON)
> +=09=09return -EINVAL;
> +=09if (asus_armoury.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2=
 &&
> +=09    mode > ASUS_MINI_LED_STRONG_MODE)
> +=09=09return -EINVAL;
> +
> +=09/*
> +=09 * Remap the mode values so expected behaviour is the same as the las=
t
> +=09 * generation of mini-LED with 0 =3D=3D off, 1 =3D=3D on.
> +=09 */
> +=09if (asus_armoury.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2=
) {
> +=09=09switch (mode) {
> +=09=09case ASUS_MINI_LED_OFF:
> +=09=09=09mode =3D ASUS_MINI_LED_2024_OFF;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_ON:
> +=09=09=09mode =3D ASUS_MINI_LED_2024_WEAK;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_STRONG_MODE:
> +=09=09=09mode =3D ASUS_MINI_LED_2024_STRONG;
> +=09=09=09break;
> +=09=09}
> +=09}
> +
> +=09err =3D asus_wmi_set_devstate(asus_armoury.mini_led_dev_id, mode, &re=
sult);
> +=09if (err) {
> +=09=09pr_warn("Failed to set mini-LED: %d\n", err);
> +=09=09return err;
> +=09}
> +
> +=09if (result !=3D 1) {
> +=09=09pr_warn("Failed to set mini-LED mode (result): 0x%x\n", result);
> +=09=09return -EIO;
> +=09}
> +
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +=09return count;
> +}
> +
> +static ssize_t mini_led_mode_possible_values_show(struct kobject *kobj,
> +=09=09=09=09=09=09  struct kobj_attribute *attr, char *buf)
> +{
> +=09switch (asus_armoury.mini_led_dev_id) {
> +=09case ASUS_WMI_DEVID_MINI_LED_MODE:
> +=09=09return sysfs_emit(buf, "0;1\n");
> +=09case ASUS_WMI_DEVID_MINI_LED_MODE2:
> +=09=09return sysfs_emit(buf, "0;1;2\n");
> +=09}
> +
> +=09return sysfs_emit(buf, "0\n");
> +}
> +
> +ATTR_GROUP_ENUM_CUSTOM(mini_led_mode, "mini_led_mode", "Set the mini-LED=
 backlight mode");
> +
> +static ssize_t gpu_mux_mode_current_value_store(struct kobject *kobj,
> +=09=09=09=09=09=09struct kobj_attribute *attr, const char *buf,
> +=09=09=09=09=09=09size_t count)
> +{
> +=09int result, err;
> +=09u32 optimus;
> +
> +=09err =3D kstrtou32(buf, 10, &optimus);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (optimus > 1)
> +=09=09return -EINVAL;
> +
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU)) {
> +=09=09err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_DGPU, &result);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09if (result && !optimus) {
> +=09=09=09err =3D -ENODEV;
> +=09=09=09pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled:=
 %d\n",
> +=09=09=09=09err);
> +=09=09=09return err;
> +=09=09}
> +=09}
> +
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU)) {
> +=09=09err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU, &result);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09if (result && !optimus) {
> +=09=09=09err =3D -ENODEV;
> +=09=09=09pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled: =
%d\n",
> +=09=09=09=09err);
> +=09=09=09return err;
> +=09=09}
> +=09}
> +
> +=09err =3D asus_wmi_set_devstate(asus_armoury.gpu_mux_dev_id, optimus, &=
result);
> +=09if (err) {
> +=09=09pr_err("Failed to set GPU MUX mode: %d\nn", err);

Double n at the end of the string.

> +=09=09return err;
> +=09}
> +=09/* !1 is considered a fail by ASUS */
> +=09if (result !=3D 1) {
> +=09=09pr_warn("Failed to set GPU MUX mode (result): 0x%x\n", result);
> +=09=09return -EIO;
> +=09}
> +
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +=09return count;
> +}
> +WMI_SHOW_INT(gpu_mux_mode_current_value, "%d\n", asus_armoury.gpu_mux_de=
v_id);
> +ATTR_GROUP_BOOL_CUSTOM(gpu_mux_mode, "gpu_mux_mode", "Set the GPU displa=
y MUX mode");
> +
> +/*
> + * A user may be required to store the value twice, typcial store first,=
 then

typical

> + * rescan PCI bus to activate power, then store a second time to save co=
rrectly.
> + * The reason for this is that an extra code path in the ACPI is enabled=
 when
> + * the device and bus are powered.
> + */
> +static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
> +=09=09=09=09=09=09struct kobj_attribute *attr, const char *buf,
> +=09=09=09=09=09=09size_t count)
> +{
> +=09int result, err;
> +=09u32 disable;
> +
> +=09err =3D kstrtou32(buf, 10, &disable);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (disable > 1)
> +=09=09return -EINVAL;
> +
> +=09if (asus_armoury.gpu_mux_dev_id) {
> +=09=09err =3D asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &r=
esult);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09if (!result && disable) {
> +=09=09=09err =3D -ENODEV;
> +=09=09=09pr_warn("Can not disable dGPU when the MUX is in dGPU mode: %d\=
n", err);
> +=09=09=09return err;
> +=09=09}
> +=09}
> +
> +=09err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, disable, &result);
> +=09if (err) {
> +=09=09pr_warn("Failed to set dgpu disable: %d\n", err);
> +=09=09return err;
> +=09}
> +
> +=09if (result !=3D 1) {
> +=09=09pr_warn("Failed to set dgpu disable (result): 0x%x\n", result);
> +=09=09return -EIO;
> +=09}
> +
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +=09return count;
> +}
> +WMI_SHOW_INT(dgpu_disable_current_value, "%d\n", ASUS_WMI_DEVID_DGPU);
> +ATTR_GROUP_BOOL_CUSTOM(dgpu_disable, "dgpu_disable", "Disable the dGPU")=
;
> +
> +/* The ACPI call to enable the eGPU also disables the internal dGPU */
> +static ssize_t egpu_enable_current_value_store(struct kobject *kobj,
> +=09=09=09=09=09       struct kobj_attribute *attr, const char *buf,
> +=09=09=09=09=09       size_t count)
> +{
> +=09int result, err;
> +=09u32 enable;
> +
> +=09err =3D kstrtou32(buf, 10, &enable);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (enable > 1)
> +=09=09return -EINVAL;
> +
> +=09err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU_CONNECTED, &re=
sult);
> +=09if (err) {
> +=09=09pr_warn("Failed to get egpu connection status: %d\n", err);

eGPU

> +=09=09return err;
> +=09}
> +
> +=09if (asus_armoury.gpu_mux_dev_id) {
> +=09=09err =3D asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &r=
esult);
> +=09=09if (err) {
> +=09=09=09pr_warn("Failed to get gpu mux status: %d\n", result);

GPU MUX

> +=09=09=09return result;
> +=09=09}
> +=09=09if (!result && enable) {
> +=09=09=09err =3D -ENODEV;
> +=09=09=09pr_warn("Can not enable eGPU when the MUX is in dGPU mode: %d\n=
", err);
> +=09=09=09return err;
> +=09=09}
> +=09}
> +
> +=09err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
> +=09if (err) {
> +=09=09pr_warn("Failed to set egpu state: %d\n", err);

eGPU

> +=09=09return err;
> +=09}
> +
> +=09if (result !=3D 1) {
> +=09=09pr_warn("Failed to set egpu state (retval): 0x%x\n", result);

eGPU

> +=09=09return -EIO;
> +=09}
> +
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +=09return count;
> +}
> +WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
> +ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (als=
o disables dGPU)");
> +
> +/* Simple attribute creation */
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL=
1_SPL, cpu_default,
> +=09=09       cpu_min, cpu_max, 1, "Set the CPU slow package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, "ppt_pl2_sppt", ASUS_WMI_DEVID_PPT_=
PL2_SPPT, cpu_default,
> +=09=09       cpu_min, cpu_max, 1, "Set the CPU fast package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_apu_sppt, "ppt_apu_sppt", ASUS_WMI_DEVID_PPT_=
APU_SPPT,
> +=09=09       platform_default, platform_min, platform_max, 1,
> +=09=09       "Set the CPU slow package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_platform_sppt, "ppt_platform_sppt", ASUS_WMI_=
DEVID_PPT_PLAT_SPPT,
> +=09=09       platform_default, platform_min, platform_max, 1,
> +=09=09       "Set the CPU slow package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_fppt, "ppt_fppt", ASUS_WMI_DEVID_PPT_FPPT, cp=
u_default, cpu_min,
> +=09=09       cpu_max, 1, "Set the CPU slow package limit");
> +
> +ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DE=
VID_NV_DYN_BOOST,
> +=09=09       nv_boost_default, nv_boost_min, nv_boost_max, 1,
> +=09=09       "Set the Nvidia dynamic boost limit");
> +ATTR_GROUP_ROG_TUNABLE(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_=
NV_THERM_TARGET,
> +=09=09       nv_temp_default, nv_boost_min, nv_temp_max, 1,
> +=09=09       "Set the Nvidia max thermal limit");
> +
> +ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE=
_MODE, "0;1;2",
> +=09=09       "Show the current mode of charging");
> +ATTR_GROUP_BOOL_RW(boot_sound, "boot_sound", ASUS_WMI_DEVID_BOOT_SOUND,
> +=09=09   "Set the boot POST sound");
> +ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_MCU_PO=
WERSAVE,
> +=09=09   "Set MCU powersaving mode");
> +ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
> +=09=09   "Set the panel refresh overdrive");
> +ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_=
HD,
> +=09=09   "Set the panel HD mode to UHD<0> or FHD<1>");
> +ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU=
_CONNECTED,
> +=09=09   "Show the eGPU connection status");
> +
> +/* If an attribute does not require any special case handling add it her=
e */
> +static const struct asus_attr_group armoury_attr_groups[] =3D {
> +=09{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
> +=09{ &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
> +=09{ &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
> +
> +=09{ &ppt_pl1_spl_attr_group, ASUS_WMI_DEVID_PPT_PL1_SPL },
> +=09{ &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_PPT_PL2_SPPT },
> +=09{ &ppt_apu_sppt_attr_group, ASUS_WMI_DEVID_PPT_APU_SPPT },
> +=09{ &ppt_platform_sppt_attr_group, ASUS_WMI_DEVID_PPT_PLAT_SPPT },
> +=09{ &ppt_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
> +=09{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
> +=09{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
> +
> +=09{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
> +=09{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> +=09{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
> +=09{ &panel_od_attr_group, ASUS_WMI_DEVID_PANEL_OD },
> +=09{ &panel_hd_mode_attr_group, ASUS_WMI_DEVID_PANEL_HD },
> +};
> +
> +static int asus_fw_attr_add(void)
> +{
> +=09int err;
> +
> +=09err =3D fw_attributes_class_get(&fw_attr_class);
> +=09if (err)
> +=09=09goto fail_class_created;
> +
> +=09asus_armoury.fw_attr_dev =3D
> +=09=09device_create(fw_attr_class, NULL, MKDEV(0, 0), NULL, "%s", DRIVER=
_NAME);
> +
> +=09if (IS_ERR(asus_armoury.fw_attr_dev)) {
> +=09=09err =3D PTR_ERR(asus_armoury.fw_attr_dev);
> +=09=09goto fail_class_created;
> +=09}
> +
> +=09asus_armoury.fw_attr_kset =3D
> +=09=09kset_create_and_add("attributes", NULL, &asus_armoury.fw_attr_dev-=
>kobj);
> +=09if (!asus_armoury.fw_attr_dev) {
> +=09=09err =3D -ENOMEM;
> +=09=09pr_debug("Failed to create and add attributes\n");
> +=09=09goto err_destroy_classdev;
> +=09}
> +
> +=09err =3D sysfs_create_file(&asus_armoury.fw_attr_kset->kobj, &pending_=
reboot.attr);
> +=09if (err) {
> +=09=09pr_warn("Failed to create sysfs level attributes\n");
> +=09=09goto fail_class_created;
> +=09}
> +
> +=09err =3D 0;
> +=09asus_armoury.mini_led_dev_id =3D 0;
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE)) {
> +=09=09asus_armoury.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE;
> +=09=09err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +=09=09=09=09=09 &mini_led_mode_attr_group);
> +=09} else if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE2)) {
> +=09=09asus_armoury.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE2;
> +=09=09err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +=09=09=09=09=09 &mini_led_mode_attr_group);
> +=09}
> +=09if (err)
> +=09=09pr_warn("Failed to create sysfs-group for mini_led\n");
> +
> +=09err =3D 0;
> +=09asus_armoury.gpu_mux_dev_id =3D 0;
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX)) {
> +=09=09asus_armoury.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX;
> +=09=09err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +=09=09=09=09=09 &gpu_mux_mode_attr_group);
> +=09} else if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX_VIVO)) {
> +=09=09asus_armoury.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX_VIVO;
> +=09=09err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +=09=09=09=09=09 &gpu_mux_mode_attr_group);
> +=09}
> +=09if (err)
> +=09=09pr_warn("Failed to create sysfs-group for gpu_mux\n");
> +
> +=09for (int i =3D 0; i < ARRAY_SIZE(armoury_attr_groups); i++) {
> +=09=09if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
> +=09=09=09continue;
> +
> +=09=09err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +=09=09=09=09=09 armoury_attr_groups[i].attr_group);
> +=09=09if (err)
> +=09=09=09pr_warn("Failed to create sysfs-group for %s\n",
> +=09=09=09=09armoury_attr_groups[i].attr_group->name);
> +=09=09else
> +=09=09=09pr_debug("Created sysfs-group for %s\n",
> +=09=09=09=09 armoury_attr_groups[i].attr_group->name);
> +=09}
> +
> +=09return 0;
> +
> +err_destroy_classdev:
> +=09device_destroy(fw_attr_class, MKDEV(0, 0));
> +
> +fail_class_created:
> +=09fw_attributes_class_put();
> +=09return err;
> +}
> +
> +/* Init / exit *********************************************************=
*******/
> +
> +/* Set up the min/max and defaults for ROG tunables */
> +static void init_rog_tunables(struct rog_tunables *rog)
> +{
> +=09const char *product;
> +=09u32 max_boost =3D NVIDIA_BOOST_MAX;
> +=09u32 cpu_default =3D PPT_CPU_LIMIT_DEFAULT;
> +=09u32 cpu_max =3D PPT_CPU_LIMIT_MAX;
> +=09u32 platform_default =3D PPT_PLATFORM_DEFAULT;
> +=09u32 platform_max =3D PPT_PLATFORM_MAX;
> +
> +=09/*
> +=09 * ASUS product_name contains everything required, e.g,
> +=09 * "ROG Flow X16 GV601VV_GV601VV_00185149B"
> +=09 */
> +=09product =3D dmi_get_system_info(DMI_PRODUCT_NAME);
> +
> +=09if (strstr(product, "GA402R")) {
> +=09=09cpu_default =3D 125;
> +=09} else if (strstr(product, "13QY")) {
> +=09=09cpu_max =3D 250;
> +=09} else if (strstr(product, "X13")) {
> +=09=09cpu_max =3D 75;
> +=09=09cpu_default =3D 50;
> +=09} else if (strstr(product, "RC71")) {
> +=09=09cpu_max =3D 50;
> +=09=09cpu_default =3D 30;
> +=09} else if (strstr(product, "G814") || strstr(product, "G614") ||
> +=09=09   strstr(product, "G834") || strstr(product, "G634")) {
> +=09=09cpu_max =3D 175;
> +=09} else if (strstr(product, "GA402X") || strstr(product, "GA403") ||
> +=09=09   strstr(product, "FA507N") || strstr(product, "FA507X") ||
> +=09=09   strstr(product, "FA707N") || strstr(product, "FA707X")) {
> +=09=09cpu_max =3D 90;
> +=09}
> +
> +=09if (strstr(product, "GZ301ZE"))
> +=09=09max_boost =3D 5;
> +=09else if (strstr(product, "FX507ZC4"))
> +=09=09max_boost =3D 15;
> +=09else if (strstr(product, "GU605"))
> +=09=09max_boost =3D 20;

It would be nice if driver_data could be used to store per model=20
information rather than using if forests. It's a bit tricky to realize=20
with dmi_check_system() though, only because you've rog available on=20
global level, a callback could store info directly into rog fields but it=
=20
doesn't not feel very clean solution having to have a global variable.

> +=09/* ensure defaults for tunables */
> +=09rog->cpu_default =3D cpu_default;
> +=09rog->cpu_min =3D PPT_CPU_LIMIT_MIN;
> +=09rog->cpu_max =3D cpu_max;
> +
> +=09rog->platform_default =3D platform_default;
> +=09rog->platform_max =3D PPT_PLATFORM_MIN;
> +=09rog->platform_max =3D platform_max;
> +
> +=09rog->ppt_pl1_spl =3D cpu_default;
> +=09rog->ppt_pl2_sppt =3D cpu_default;
> +=09rog->ppt_apu_sppt =3D cpu_default;
> +
> +=09rog->ppt_platform_sppt =3D platform_default;
> +=09rog->ppt_fppt =3D platform_default;
> +
> +=09rog->nv_boost_default =3D NVIDIA_BOOST_MAX;
> +=09rog->nv_boost_max =3D NVIDIA_BOOST_MIN;
> +=09rog->nv_boost_max =3D max_boost;
> +=09rog->nv_dynamic_boost =3D NVIDIA_BOOST_MIN;
> +
> +=09rog->nv_temp_default =3D NVIDIA_TEMP_MAX;
> +=09rog->nv_temp_max =3D NVIDIA_TEMP_MIN;
> +=09rog->nv_temp_max =3D NVIDIA_TEMP_MAX;
> +=09rog->nv_temp_target =3D NVIDIA_TEMP_MIN;
> +}
> +
> +static int __init asus_fw_init(void)
> +{
> +=09int err;
> +
> +=09fw_attrs.pending_reboot =3D 0;
> +
> +=09mutex_lock(&asus_armoury.mutex);
> +
> +=09asus_armoury.rog_tunables =3D kzalloc(sizeof(struct rog_tunables), GF=
P_KERNEL);
> +=09if (!asus_armoury.rog_tunables) {
> +=09=09mutex_unlock(&asus_armoury.mutex);

Please use guard() to make this function much simpler. But why you need=20
to take mutex here at all?

> +=09=09return -ENOMEM;
> +=09}
> +=09init_rog_tunables(asus_armoury.rog_tunables);
> +
> +=09err =3D asus_fw_attr_add();
> +=09mutex_unlock(&asus_armoury.mutex);
> +=09if (err)
> +=09=09return err;
> +
> +=09return 0;
> +}
> +
> +static void __exit asus_fw_exit(void)
> +{
> +=09mutex_lock(&asus_armoury.mutex);
> +
> +=09sysfs_remove_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.a=
ttr);
> +=09kset_unregister(asus_armoury.fw_attr_kset);
> +=09device_destroy(fw_attr_class, MKDEV(0, 0));
> +=09fw_attributes_class_put();
> +
> +=09mutex_unlock(&asus_armoury.mutex);
> +}
> +
> +module_init(asus_fw_init);
> +module_exit(asus_fw_exit);
> +
> +MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
> +MODULE_DESCRIPTION("ASUS BIOS Configuration Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("wmi:" ASUS_NB_WMI_EVENT_GUID);
> diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/a=
sus-armoury.h
> new file mode 100644
> index 000000000000..146170f91e69
> --- /dev/null
> +++ b/drivers/platform/x86/asus-armoury.h
> @@ -0,0 +1,195 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Definitions for kernel modules using asus-armoury driver
> + *
> + *  Copyright (c) 2024 Luke Jones <luke@ljones.dev>
> + */
> +
> +#ifndef _ASUS_BIOSCFG_H_
> +#define _ASUS_BIOSCFG_H_
> +
> +#include <linux/types.h>

This is missing some includes for structs and functions you use below.

> +
> +#define DRIVER_NAME "asus-armoury"
> +
> +static ssize_t attr_int_store(struct kobject *kobj, struct kobj_attribut=
e *attr,
> +=09=09=09      const char *buf, size_t count, u32 min, u32 max, u32 *sto=
re_value,
> +=09=09=09      u32 wmi_dev);
> +
> +static ssize_t int_type_show(struct kobject *kobj, struct kobj_attribute=
 *attr, char *buf)

inline missing

> +{
> +=09return sysfs_emit(buf, "integer\n");

Lukas Wunner might have done something to make emitting constant strings=20
easier, please check out if that's already in mainline.

> +}
> +
> +static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribut=
e *attr, char *buf)

inline missing

> +{
> +=09return sysfs_emit(buf, "enumeration\n");
> +}
> +
> +#define __ASUS_ATTR_RO(_func, _name)                                  \
> +=09{                                                             \
> +=09=09.attr =3D { .name =3D __stringify(_name), .mode =3D 0444 }, \
> +=09=09.show =3D _func##_##_name##_show,                       \
> +=09}
> +
> +#define __ASUS_ATTR_RO_AS(_name, _show)                               \
> +=09{                                                             \
> +=09=09.attr =3D { .name =3D __stringify(_name), .mode =3D 0444 }, \
> +=09=09.show =3D _show,                                        \
> +=09}
> +
> +#define __ASUS_ATTR_RW(_func, _name) \
> +=09__ATTR(_name, 0644, _func##_##_name##_show, _func##_##_name##_store)
> +
> +#define __WMI_STORE_INT(_attr, _min, _max, _wmi)                        =
                \
> +=09static ssize_t _attr##_store(struct kobject *kobj, struct kobj_attrib=
ute *attr, \
> +=09=09=09=09     const char *buf, size_t count)                     \
> +=09{                                                                    =
           \
> +=09=09return attr_int_store(kobj, attr, buf, count, _min, _max, NULL, _w=
mi);  \
> +=09}
> +
> +#define WMI_SHOW_INT(_attr, _fmt, _wmi)                                 =
               \
> +=09static ssize_t _attr##_show(struct kobject *kobj, struct kobj_attribu=
te *attr, \
> +=09=09=09=09    char *buf)                                         \
> +=09{                                                                    =
          \
> +=09=09u32 result;                                                       =
     \
> +=09=09int err;                                                          =
     \
> +=09=09err =3D asus_wmi_get_devstate_dsts(_wmi, &result);                =
       \
> +=09=09if (err)                                                          =
     \
> +=09=09=09return err;                                                    =
\
> +=09=09return sysfs_emit(buf, _fmt, result & ~ASUS_WMI_DSTS_PRESENCE_BIT)=
;    \
> +=09}
> +
> +/* Create functions and attributes for use in other macros or on their o=
wn */
> +
> +#define __ATTR_CURRENT_INT_RO(_attr, _wmi)                          \
> +=09WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi);          \
> +=09static struct kobj_attribute attr_##_attr##_current_value =3D \
> +=09=09__ASUS_ATTR_RO(_attr, current_value)
> +
> +#define __ATTR_CURRENT_INT_RW(_attr, _minv, _maxv, _wmi)            \
> +=09__WMI_STORE_INT(_attr##_current_value, _minv, _maxv, _wmi); \
> +=09WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi);          \
> +=09static struct kobj_attribute attr_##_attr##_current_value =3D \
> +=09=09__ASUS_ATTR_RW(_attr, current_value)
> +
> +/* Shows a formatted static variable */
> +#define __ATTR_SHOW_FMT(_prop, _attrname, _fmt, _val)                   =
                  \
> +=09static ssize_t _attrname##_##_prop##_show(struct kobject *kobj,      =
             \
> +=09=09=09=09=09=09  struct kobj_attribute *attr, char *buf) \
> +=09{                                                                    =
             \
> +=09=09return sysfs_emit(buf, _fmt, _val);                               =
        \
> +=09}                                                                    =
             \
> +=09static struct kobj_attribute attr_##_attrname##_##_prop =3D          =
               \
> +=09=09__ASUS_ATTR_RO(_attrname, _prop)
> +
> +/* Boolean style enumeration, base macro. Requires adding show/store */
> +#define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)     =
                       \
> +=09__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);         =
                  \
> +=09__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible);      =
                  \
> +=09static struct kobj_attribute attr_##_attrname##_type =3D             =
                    \
> +=09=09__ASUS_ATTR_RO_AS(type, enum_type_show);                          =
             \
> +=09static struct attribute *_attrname##_attrs[] =3D {                   =
                    \
> +=09=09&attr_##_attrname##_current_value.attr, &attr_##_attrname##_displa=
y_name.attr, \
> +=09=09&attr_##_attrname##_possible_values.attr, &attr_##_attrname##_type=
=2Eattr, NULL  \
> +=09};                                                                   =
                  \
> +=09static const struct attribute_group _attrname##_attr_group =3D {     =
                    \
> +=09=09.name =3D _fsname, .attrs =3D _attrname##_attrs                   =
                 \
> +=09}
> +
> +#define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname) \
> +=09__ATTR_CURRENT_INT_RO(_attrname, _wmi);                 \
> +=09__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +#define ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname) \
> +=09__ATTR_CURRENT_INT_RW(_attrname, 0, 1, _wmi);           \
> +=09__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + */
> +#define ATTR_GROUP_BOOL_CUSTOM(_attrname, _fsname, _dispname)           =
\
> +=09static struct kobj_attribute attr_##_attrname##_current_value =3D \
> +=09=09__ASUS_ATTR_RW(_attrname, current_value);               \
> +=09__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi, _possible, _dis=
pname) \
> +=09__ATTR_CURRENT_INT_RO(_attrname, _wmi);                              =
  \
> +=09__ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + * and <name>_possible_values_show()
> + */
> +#define ATTR_GROUP_ENUM_CUSTOM(_attrname, _fsname, _dispname)           =
                       \
> +=09__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);         =
                  \
> +=09static struct kobj_attribute attr_##_attrname##_current_value =3D    =
                    \
> +=09=09__ASUS_ATTR_RW(_attrname, current_value);                         =
             \
> +=09static struct kobj_attribute attr_##_attrname##_possible_values =3D  =
                    \
> +=09=09__ASUS_ATTR_RO(_attrname, possible_values);                       =
             \
> +=09static struct kobj_attribute attr_##_attrname##_type =3D             =
                    \
> +=09=09__ASUS_ATTR_RO_AS(type, enum_type_show);                          =
             \
> +=09static struct attribute *_attrname##_attrs[] =3D {                   =
                    \
> +=09=09&attr_##_attrname##_current_value.attr, &attr_##_attrname##_displa=
y_name.attr, \
> +=09=09&attr_##_attrname##_possible_values.attr, &attr_##_attrname##_type=
=2Eattr, NULL  \
> +=09};                                                                   =
                  \
> +=09static const struct attribute_group _attrname##_attr_group =3D {     =
                    \
> +=09=09.name =3D _fsname, .attrs =3D _attrname##_attrs                   =
                 \
> +=09}
> +
> +/*
> + * ROG PPT attributes need a little different in setup as they
> + * require rog_tunables members.
> + */
> +
> +#define __ROG_TUNABLE_RW(_attr, _min, _max, _wmi)                       =
                       \
> +=09static ssize_t _attr##_current_value_store(struct kobject *kobj,     =
                  \
> +=09=09=09=09=09=09   struct kobj_attribute *attr,                \
> +=09=09=09=09=09=09   const char *buf, size_t count)              \
> +=09{                                                                    =
                  \
> +=09=09return attr_int_store(kobj, attr, buf, count, asus_armoury.rog_tun=
ables->_min, \
> +=09=09=09=09      asus_armoury.rog_tunables->_max,                      =
   \
> +=09=09=09=09      &asus_armoury.rog_tunables->_attr, _wmi);             =
   \
> +=09}                                                                    =
                  \
> +=09static ssize_t _attr##_current_value_show(struct kobject *kobj,      =
                  \
> +=09=09=09=09=09=09  struct kobj_attribute *attr, char *buf)      \
> +=09{                                                                    =
                  \
> +=09=09return sysfs_emit(buf, "%u\n", asus_armoury.rog_tunables->_attr); =
             \
> +=09}                                                                    =
                  \
> +=09static struct kobj_attribute attr_##_attr##_current_value =3D        =
                    \
> +=09=09__ASUS_ATTR_RW(_attr, current_value)
> +
> +#define __ROG_TUNABLE_SHOW(_prop, _attrname, _val)                      =
                  \
> +=09static ssize_t _attrname##_##_prop##_show(struct kobject *kobj,      =
             \
> +=09=09=09=09=09=09  struct kobj_attribute *attr, char *buf) \
> +=09{                                                                    =
             \
> +=09=09return sysfs_emit(buf, "%d\n", asus_armoury.rog_tunables->_val);  =
        \
> +=09}                                                                    =
             \
> +=09static struct kobj_attribute attr_##_attrname##_##_prop =3D          =
               \
> +=09=09__ASUS_ATTR_RO(_attrname, _prop)
> +
> +#define ATTR_GROUP_ROG_TUNABLE(_attrname, _fsname, _wmi, _default, _min,=
 _max, _incstep, \
> +=09=09=09       _dispname)                                              =
  \
> +=09__ROG_TUNABLE_SHOW(default_value, _attrname, _default);              =
            \
> +=09__ROG_TUNABLE_RW(_attrname, _min, _max, _wmi);                       =
            \
> +=09__ROG_TUNABLE_SHOW(min_value, _attrname, _min);                      =
            \
> +=09__ROG_TUNABLE_SHOW(max_value, _attrname, _max);                      =
            \
> +=09__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", _incstep);      =
            \
> +=09__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);         =
            \
> +=09static struct kobj_attribute attr_##_attrname##_type =3D             =
              \
> +=09=09__ASUS_ATTR_RO_AS(type, int_type_show);                           =
       \
> +=09static struct attribute *_attrname##_attrs[] =3D {                   =
              \
> +=09=09&attr_##_attrname##_current_value.attr,                           =
       \
> +=09=09&attr_##_attrname##_default_value.attr,                           =
       \
> +=09=09&attr_##_attrname##_min_value.attr,                               =
       \
> +=09=09&attr_##_attrname##_max_value.attr,                               =
       \
> +=09=09&attr_##_attrname##_scalar_increment.attr,                        =
       \
> +=09=09&attr_##_attrname##_display_name.attr,                            =
       \
> +=09=09&attr_##_attrname##_type.attr,                                    =
       \
> +=09=09NULL                                                              =
       \
> +=09};                                                                   =
            \
> +=09static const struct attribute_group _attrname##_attr_group =3D {     =
              \
> +=09=09.name =3D _fsname, .attrs =3D _attrname##_attrs                   =
           \
> +=09}
> +
> +#endif /* _ASUS_BIOSCFG_H_ */
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index 0c80c6b0399b..165e7932c371 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -550,12 +550,56 @@ static int asus_wmi_get_devstate(struct asus_wmi *a=
sus, u32 dev_id, u32 *retval)
>  =09return 0;
>  }
> =20
> -static int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
> -=09=09=09=09 u32 *retval)
> +/**
> + * asus_wmi_get_devstate_dsts() - Get the WMI function state.
> + * @dev_id: The WMI function to call.
> + * @retval: A pointer to where to store the value returned from WMI.
> + *
> + * The returned WMI function state can also be used to determine if the =
WMI
> + * function is supported by checking if the asus_wmi_get_devstate_dsts()
> + * returns an error.
> + *
> + * On success the return value is 0, and the retval is a valid value ret=
urned
> + * by the successful WMI function call. An error value is returned only =
if the
> + * WMI function failed, or if it returns "unsupported" which is typicall=
y a 0
> + * (no return, and no 'supported' bit set), or a 0xFFFFFFFE (~1) which i=
f not
> + * caught here can result in unexpected behaviour later.
> + */
> +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
> +{
> +=09int err;
> +
> +=09err =3D asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, r=
etval);
> +=09if (err)
> +=09=09return err;
> +=09/* Be explicit about retval */
> +=09if (*retval =3D=3D 0xFFFFFFFE || *retval =3D=3D 0)

Please name the literals with defines.

> +=09=09return -ENODEV;
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(asus_wmi_get_devstate_dsts);
> +
> +/**
> + * asus_wmi_set_devstate() - Set the WMI function state.
> + * @dev_id: The WMI function to call.
> + * @ctrl_param: The argument to be used for this WMI function.
> + * @retval: A pointer to where to store the value returned from WMI.
> + *
> + * The returned WMI function state if not checked here for error as
> + * asus_wmi_set_devstate() is not called unless first paired with a call=
 to
> + * asus_wmi_get_devstate_dsts() to check that the WMI function is suppor=
ted.
> + *
> + * On success the return value is 0, and the retval is a valid value ret=
urned
> + * by the successful WMI function call. An error value is returned only =
if the
> + * WMI function failed.
> + */
> +int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
>  {
>  =09return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
>  =09=09=09=09=09ctrl_param, retval);
>  }
> +EXPORT_SYMBOL_GPL(asus_wmi_set_devstate);

Namespace exports.


--=20
 i.

>  /* Helper for special devices with magic return codes */
>  static int asus_wmi_get_devstate_bits(struct asus_wmi *asus,
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/p=
latform_data/x86/asus-wmi.h
> index b601b245a035..c164e656ae0b 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -72,6 +72,7 @@
>  #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
> =20
>  /* Misc */
> +#define ASUS_WMI_DEVID_PANEL_HD=09=090x0005001C
>  #define ASUS_WMI_DEVID_PANEL_OD=09=090x00050019
>  #define ASUS_WMI_DEVID_CAMERA=09=090x00060013
>  #define ASUS_WMI_DEVID_LID_FLIP=09=090x00060062
> @@ -157,8 +158,18 @@
>  #define ASUS_WMI_DSTS_LIGHTBAR_MASK=090x0000000F
> =20
>  #if IS_REACHABLE(CONFIG_ASUS_WMI)
> +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval);
> +int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval);
>  int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *ret=
val);
>  #else
> +static int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
> +{
> +=09return -ENODEV;
> +}
> +static int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval=
)
> +{
> +=09return -ENODEV;
> +}
>  static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 =
arg1,
>  =09=09=09=09=09   u32 *retval)
>  {
>=20

--8323328-1468362119-1722939391=:1027--

