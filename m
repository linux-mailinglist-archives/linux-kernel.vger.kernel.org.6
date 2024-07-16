Return-Path: <linux-kernel+bounces-253574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F69E93233B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219C4284250
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E0198832;
	Tue, 16 Jul 2024 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NM0nQsb0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EE7C8F3;
	Tue, 16 Jul 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123111; cv=none; b=NfGHyxLWKVRg1OFD1zLGLEAn9HjiXEfOUW+ijDWEh1GZY0ho5mEnbO7uCivUD5MspiF0fcH8UZ3jzEl0hkLmgl97f/DPdMPZ7IT2Af/sEQ1cQhenJdXY4vGKBkOwjIom+C9NURkzK6abWyMkaC4+Qc9cmZo8GwtYrmWEW/S68uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123111; c=relaxed/simple;
	bh=mKQnOVFYB5UwZtBMmK8ai4dUa4ooHCxMkuNw8w9DFMU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tv+UBcBVf1U+UclLVhs4IBldznsUMvyHQxj3INCz7DiiR2WONkDk45TPtiargdXNCm6Vshe1mYUxk4WKrxtl+rNSZR2ttWBI767QxQ5lsxpIU3DsikcF3UtpweESXw32g7XoEMd0nYk9/+XyWUiaM/ZCVs8iAdlSPn5f/ulXuBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NM0nQsb0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721123109; x=1752659109;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=mKQnOVFYB5UwZtBMmK8ai4dUa4ooHCxMkuNw8w9DFMU=;
  b=NM0nQsb0VP2SyOVmx8AfA77aUu9bTaPJv6SP/zdVByJPmumGE3tTATqk
   KT/+8YcxGfd6515xh9mUn8JgvGPd9EXKOmY4azRoF30euDp/oqp+JCb2/
   Cf8cgDyZ7/zQRLFIXpCLdemVNYD2v25KoDmY7cs4oTa0+Maa3LCz6a0W9
   EK/cRuWgmivBPaqFlVjn9Jb3Z/kZ8DiMeOvygDfsnKPRQVuNjc1xUH2Fq
   aKm8hcuKPTFyJFd7PEBakS6jqH1Fb+WYkT8kX74f6gANOr1PYVuMImklP
   WIejn9B55DVKY/UL6PA5HdzYgvjTZKbXdVDr+zDfa55HDfeCDP0KARjRr
   A==;
X-CSE-ConnectionGUID: Y+C/v5m2TrKtYgsCS7Nt/A==
X-CSE-MsgGUID: tvr3eOFFQeK3etwR3H0acA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29961948"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29961948"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 02:45:08 -0700
X-CSE-ConnectionGUID: IqcK+ZkVTP+/GkQDzmFoIw==
X-CSE-MsgGUID: 1BWMDx94QRGaYDsurBFfZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="81017035"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.133])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 02:45:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Jul 2024 12:45:02 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, mario.limonciello@amd.com, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] platform/x86 asus-bioscfg: move existing tunings to
 asus-bioscfg module
In-Reply-To: <20240716051612.64842-2-luke@ljones.dev>
Message-ID: <951d3dc4-5330-2bbb-0372-8ab2761bf8f3@linux.intel.com>
References: <20240716051612.64842-1-luke@ljones.dev> <20240716051612.64842-2-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2053776027-1721121671=:1037"
Content-ID: <8170618d-686f-d9fd-8c16-c1df47ec9b4a@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2053776027-1721121671=:1037
Content-Type: text/plain; CHARSET=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <5e25fcd4-40f4-c81d-ea63-7b639063b311@linux.intel.com>

On Tue, 16 Jul 2024, Luke D. Jones wrote:

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
> /sys/class/firmware-attributes/asus-bioscfg/attributes/dgpu_disable/
> =86=80=80 current_value
> =86=80=80 display_name
> =86=80=80 possible_values
> =84=80=80 type
>=20
> as do other attributes.
>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/Kconfig               |  14 +
>  drivers/platform/x86/Makefile              |   1 +
>  drivers/platform/x86/asus-bioscfg.c        | 666 +++++++++++++++++++++
>  drivers/platform/x86/asus-bioscfg.h        | 243 ++++++++
>  drivers/platform/x86/asus-wmi.c            |  18 +-
>  include/linux/platform_data/x86/asus-wmi.h |  11 +
>  6 files changed, 952 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/platform/x86/asus-bioscfg.c
>  create mode 100644 drivers/platform/x86/asus-bioscfg.h
>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 665fa9524986..b4a5a5bec7f3 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -265,6 +265,18 @@ config ASUS_WIRELESS
>  =09  If you choose to compile this driver as a module the module will be
>  =09  called asus-wireless.
> =20
> +config ASUS_BIOS
> +=09tristate "ASUS BIOS Driver"
> +=09depends on ACPI_WMI
> +=09depends on ASUS_WMI
> +=09select FW_ATTR_CLASS
> +=09help
> +=09  Say Y here if you have a WMI aware Asus laptop and would like to us=
e the
> +=09  firmware_attributes API.
> +
> +=09  To compile this driver as a module, choose M here: the module will
> +=09  be called asus-bios.
> +
>  config ASUS_WMI
>  =09tristate "ASUS WMI Driver"
>  =09depends on ACPI_WMI
> @@ -276,6 +288,8 @@ config ASUS_WMI
>  =09depends on HOTPLUG_PCI
>  =09depends on ACPI_VIDEO || ACPI_VIDEO =3D n
>  =09depends on SERIO_I8042 || SERIO_I8042 =3D n
> +=09select ASUS_BIOS

Selecting user visible configs is not a good idea. Also, there=20
seems to be circular dependency now between ASUS_BIOS & ASUS_WMI ?

> +=09select ASUS_WMI_BIOS
>  =09select INPUT_SPARSEKMAP
>  =09select LEDS_CLASS
>  =09select NEW_LEDS
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index e1b142947067..d9b5b3f3b241 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_GMUX)=09+=3D apple-gmux.o
>  # ASUS
>  obj-$(CONFIG_ASUS_LAPTOP)=09+=3D asus-laptop.o
>  obj-$(CONFIG_ASUS_WIRELESS)=09+=3D asus-wireless.o
> +obj-$(CONFIG_ASUS_BIOS)=09=09+=3D asus-bios.o
>  obj-$(CONFIG_ASUS_WMI)=09=09+=3D asus-wmi.o
>  obj-$(CONFIG_ASUS_NB_WMI)=09+=3D asus-nb-wmi.o
>  obj-$(CONFIG_ASUS_TF103C_DOCK)=09+=3D asus-tf103c-dock.o
> diff --git a/drivers/platform/x86/asus-bioscfg.c b/drivers/platform/x86/a=
sus-bioscfg.c
> new file mode 100644
> index 000000000000..0b34e727aab4
> --- /dev/null
> +++ b/drivers/platform/x86/asus-bioscfg.c
> @@ -0,0 +1,666 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Asus BIOS attributes driver
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
> +#include "asus-bios.h"
> +#include "firmware_attributes_class.h"
> +
> +MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
> +MODULE_DESCRIPTION("ASUS BIOS Configuration Driver");
> +MODULE_LICENSE("GPL");

The usual place for these is at the end of file

> +#define ASUS_NB_WMI_EVENT_GUID=09"0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1C"
> +
> +MODULE_ALIAS("wmi:"ASUS_NB_WMI_EVENT_GUID);

Ditto.

> +#define ASUS_MINI_LED_MODE_MASK=09=090x03
> +/* Standard modes for devices with only on/off */
> +#define ASUS_MINI_LED_OFF=09=090x00
> +#define ASUS_MINI_LED_ON=09=090x01
> +/* New mode on some devices, define here to clarify remapping later */
> +#define ASUS_MINI_LED_STRONG_MODE=090x02
> +/* New modes for devices with 3 mini-led mode types */
> +#define ASUS_MINI_LED_2024_WEAK=09=090x00
> +#define ASUS_MINI_LED_2024_STRONG=090x01
> +#define ASUS_MINI_LED_2024_OFF=09=090x02
> +
> +/* Default limits for tunables available on ASUS ROG laptops */
> +#define PPT_CPU_LIMIT_MIN=095
> +#define PPT_CPU_LIMIT_MAX=09150
> +#define PPT_CPU_LIMIT_DEFAULT=0980
> +#define PPT_PLATFORM_MIN=095
> +#define PPT_PLATFORM_MAX=09100
> +#define PPT_PLATFORM_DEFAULT=0980
> +#define NVIDIA_BOOST_MIN=095
> +#define NVIDIA_BOOST_MAX=0925
> +#define NVIDIA_TEMP_MIN=09=0975
> +#define NVIDIA_TEMP_MAX=09=0987
> +
> +/* Tunables provided by ASUS for gaming laptops */
> +struct rog_tunables {
> +=09u32 cpu_default;
> +=09u32 cpu_max;
> +
> +=09u32 platform_default;
> +=09u32 platform_max;
> +
> +=09u32 ppt_pl1_spl; // cpu
> +=09u32 ppt_pl2_sppt; // cpu
> +=09u32 ppt_apu_sppt; // plat
> +=09u32 ppt_platform_sppt; // plat
> +=09u32 ppt_fppt; // cpu
> +
> +=09u32 nv_boost_default;
> +=09u32 nv_boost_max;
> +=09u32 nv_dynamic_boost;
> +
> +=09u32 nv_temp_default;
> +=09u32 nv_temp_max;
> +=09u32 nv_temp_target;
> +};
> +
> +static const struct class *fw_attr_class;
> +
> +struct asus_bios_priv {
> +=09struct device *fw_attr_dev;
> +=09struct kset *fw_attr_kset;
> +
> +=09struct rog_tunables *rog_tunables;
> +=09u32 mini_led_dev_id;
> +=09u32 gpu_mux_dev_id;
> +=09bool dgpu_disable_available;
> +=09bool egpu_enable_available;
> +
> +=09struct mutex mutex;
> +} asus_bioscfg =3D {
> +=09.mutex =3D __MUTEX_INITIALIZER(asus_bioscfg.mutex),

Don't try to initialize it on the same go like this.

You might want static too.

> +};
> +
> +static struct fw_attrs_group {
> +=09u32 pending_reboot;
> +} fw_attrs =3D {
> +=09.pending_reboot =3D 0,
> +};

Same here.

> +
> +/* WMI helper methods */
> +static bool asus_wmi_is_present(u32 dev_id)
> +{
> +=09int status =3D asus_wmi_get_devstate_dsts(dev_id, &retval);
> +=09u32 retval;
> +
> +=09pr_debug("%s called (0x%08x), retval: 0x%08x\n", __func__, dev_id, re=
tval);
> +
> +=09return status =3D=3D 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
> +}
> +
> +static void asus_set_reboot_and_signal_event(void)
> +{
> +=09fw_attrs.pending_reboot =3D 1;
> +=09kobject_uevent(&asus_bioscfg.fw_attr_dev->kobj, KOBJ_CHANGE);
> +}
> +
> +static ssize_t pending_reboot_show(struct kobject *kobj,
> +=09=09=09=09   struct kobj_attribute *attr,
> +=09=09=09=09   char *buf)
> +{
> +=09return sysfs_emit(buf, "%d\n", fw_attrs.pending_reboot);

%u

> +}
> +
> +static struct kobj_attribute pending_reboot =3D __ATTR_RO(pending_reboot=
);
> +
> +static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
> +{
> +=09return !strcmp(attr->attr.name, "gpu_mux_mode");
> +=09=09!strcmp(attr->attr.name, "panel_hd_mode");

???

Semicolon and && confusion here?

> +}
> +
> +/*
> + * Generic store function for use with many ROG tunables
> + */
> +static ssize_t attr_int_store(struct kobject *kobj,
> +=09=09=09=09struct kobj_attribute *attr,
> +=09=09=09=09const char *buf, size_t count,
> +=09=09=09=09u32 min, u32 max, u32 *store_value, u32 wmi_dev)
> +{
> +=09int result, value;
> +
> +=09result =3D kstrtoint(buf, 10, &value);

Is signed value needed, if not, use unsigned variant of kstrto*?

> +=09if (result)
> +=09=09return result;
> +
> +=09if (value < min || value > max)
> +=09=09return -EINVAL;
> +
> +=09asus_wmi_set_devstate(wmi_dev, value, &result);

Type confusion, u32 * vs int pointer being passed.

> +=09if (result) {
> +=09=09pr_err("Failed to set %s: %d\n", attr->attr.name, result);
> +=09=09return result;
> +=09}
> +
> +=09if (result > 1) {

What's this supposed to mean given you've the type confusion to begin=20
with and return on the earlier line if result is non-zero?

Did you mean to capture the return value of asus_wmi_set_devstate() and=20
test that in the first if ()?

If you make a previously internal function such as asus_wmi_set_devstate()=
=20
EXPORTed, you should document it with kerneldoc so the interface is clear.

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
> +=09=09=09=09=09struct kobj_attribute *attr, char *buf)
> +{
> +=09u32 value;
> +=09int err;
> +
> +=09err =3D asus_wmi_get_devstate_dsts(asus_bioscfg.mini_led_dev_id, &val=
ue);
> +=09if (err)
> +=09=09return err;
> +
> +=09value =3D value & ASUS_MINI_LED_MODE_MASK;
> +
> +=09/*
> +=09 * Remap the mode values to match previous generation mini-led. The l=
ast gen
> +=09 * WMI 0 =3D=3D off, while on this version WMI 2 =3D=3Doff (flipped).
> +=09 */
> +=09if (asus_bioscfg.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2=
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
> +=09return sysfs_emit(buf, "%d\n", value);

%u

> +}
> +
> +static ssize_t mini_led_mode_current_value_store(struct kobject *kobj,
> +=09=09=09=09=09=09struct kobj_attribute *attr,
> +=09=09=09=09=09=09const char *buf, size_t count)
> +{
> +=09int result, err;
> +=09u32 mode;
> +
> +=09result =3D kstrtou32(buf, 10, &mode);
> +=09if (result)
> +=09=09return result;
> +
> +=09if (asus_bioscfg.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE =
&&
> +=09    mode > ASUS_MINI_LED_ON)
> +=09=09return -EINVAL;
> +=09if (asus_bioscfg.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2=
 &&
> +=09    mode > ASUS_MINI_LED_STRONG_MODE)
> +=09=09return -EINVAL;
> +
> +=09/*
> +=09 * Remap the mode values so expected behaviour is the same as the las=
t
> +=09 * generation of mini-LED with 0 =3D=3D off, 1 =3D=3D on.
> +=09 */
> +=09if (asus_bioscfg.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2=
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
> +=09err =3D asus_wmi_set_devstate(asus_bioscfg.mini_led_dev_id, mode, &re=
sult);
> +=09if (err) {
> +=09=09pr_warn("Failed to set mini-LED: %d\n", err);
> +=09=09return err;
> +=09}
> +
> +=09if (result > 1) {
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
> +=09=09=09=09=09struct kobj_attribute *attr, char *buf)
> +{
> +=09switch (asus_bioscfg.mini_led_dev_id) {
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
> +=09=09=09=09struct kobj_attribute *attr,
> +=09=09=09=09const char *buf, size_t count)
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
> +=09if (asus_bioscfg.dgpu_disable_available) {
> +=09=09err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_DGPU, &result);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09if (err && !optimus) {

How can err be non-zero at this point??? Did you mean result like below?

> +=09=09=09err =3D -ENODEV;
> +=09=09=09pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled:=
 %d\n", err);
> +=09=09=09return err;
> +=09=09}
> +=09}
> +
> +=09if (asus_bioscfg.egpu_enable_available) {
> +=09=09err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU, &result);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09if (result && !optimus) {
> +=09=09=09err =3D -ENODEV;
> +=09=09=09pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled: =
%d\n", err);
> +=09=09=09return err;
> +=09=09}
> +=09}
> +
> +=09err =3D asus_wmi_set_devstate(asus_bioscfg.gpu_mux_dev_id, optimus, &=
result);
> +=09if (err) {
> +=09=09pr_err("%s Failed to set GPU MUX mode: %d\nn", __func__, err);

Never use __func__ for messages shown to normal user.

> +=09=09return err;
> +=09}
> +=09/* !1 is considered a fail by ASUS */

If the interface is documented with kerneldoc, this is unnecessary=20
comment. Is 0 also a failure (this differs from >1 checks elsewhere)?

> +=09if (result !=3D 1) {
> +=09=09pr_warn("%s Failed to set GPU MUX mode (result): 0x%x\n", __func__=
, result);

Ditto.

> +=09=09return -EIO;
> +=09}
> +
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +=09return count;
> +}
> +WMI_SHOW_INT(gpu_mux_mode_current_value, "%d\n", asus_bioscfg.gpu_mux_de=
v_id);
> +ATTR_GROUP_BOOL_CUSTOM(gpu_mux_mode, "gpu_mux_mode", "Set the GPU displa=
y MUX mode");
> +
> +/*
> + * A user may be required to store the value twice, typcial store first,=
 then
> + * rescan PCI bus to activate power, then store a second time to save co=
rrectly.
> + * The reason for this is that an extra code path in the ACPI is enabled=
 when
> + * the device and bus are powered.
> + */
> +static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
> +=09=09=09=09struct kobj_attribute *attr,
> +=09=09=09=09const char *buf, size_t count)
> +{
> +=09int result, err;
> +=09u32 disable;
> +
> +=09result =3D kstrtou32(buf, 10, &disable);
> +=09if (result)
> +=09=09return result;

You're likely shooting yourself into your foot by not having consistency=20
in variable naming. Here you store the return value into "result", whereas=
=20
you used "err" in the previous function. Try to maintain consistency=20
across the entire driver.

> +
> +=09if (disable > 1)
> +=09=09return -EINVAL;
> +
> +=09if (asus_bioscfg.gpu_mux_dev_id) {
> +=09=09err =3D asus_wmi_get_devstate_dsts(asus_bioscfg.gpu_mux_dev_id, &r=
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
> +=09if (result > 1) {
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
> +=09=09=09=09struct kobj_attribute *attr,
> +=09=09=09=09const char *buf, size_t count)
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
> +=09=09return err;
> +=09}
> +
> +=09if (asus_bioscfg.gpu_mux_dev_id) {
> +=09=09err =3D asus_wmi_get_devstate_dsts(asus_bioscfg.gpu_mux_dev_id, &r=
esult);
> +=09=09if (err) {
> +=09=09=09pr_warn("Failed to get gpu mux status: %d\n", result);
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
> +=09=09return err;
> +=09}
> +
> +=09if (result > 1) {
> +=09=09pr_warn("Failed to set egpu state (retval): 0x%x\n", result);
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
> +ATTR_GROUP_ENUM_INT_RW(thermal_policy, "thermal_policy", ASUS_WMI_DEVID_=
THROTTLE_THERMAL_POLICY,
> +=09=090, 3, "0;1;2", "Set the thermal profile: 0=3Dnormal, 1=3Dperforman=
ce, 2=3Dquiet");
> +ATTR_GROUP_PPT_RW(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL=
,
> +=09=09cpu_default, 5, cpu_max, 1, "Set the CPU slow package limit");
> +ATTR_GROUP_PPT_RW(ppt_pl2_sppt, "ppt_pl2_sppt", ASUS_WMI_DEVID_PPT_PL2_S=
PPT,
> +=09=09cpu_default, 5, cpu_max, 1, "Set the CPU fast package limit");
> +ATTR_GROUP_PPT_RW(ppt_apu_sppt, "ppt_apu_sppt", ASUS_WMI_DEVID_PPT_APU_S=
PPT,
> +=09=09platform_default, 5, platform_max, 1, "Set the CPU slow package li=
mit");
> +ATTR_GROUP_PPT_RW(ppt_platform_sppt, "ppt_platform_sppt", ASUS_WMI_DEVID=
_PPT_PLAT_SPPT,
> +=09=09platform_default, 5, platform_max, 1, "Set the CPU slow package li=
mit");
> +ATTR_GROUP_PPT_RW(ppt_fppt, "ppt_fppt", ASUS_WMI_DEVID_PPT_FPPT,
> +=09=09cpu_default, 5, cpu_max, 1, "Set the CPU slow package limit");
> +
> +ATTR_GROUP_PPT_RW(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_N=
V_DYN_BOOST,
> +=09=09nv_boost_default, 5, nv_boost_max, 1, "Set the Nvidia dynamic boos=
t limit");
> +ATTR_GROUP_PPT_RW(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_TH=
ERM_TARGET,
> +=09=09nv_temp_default, 75, nv_temp_max, 1, "Set the Nvidia max thermal l=
imit");
> +
> +ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE=
_MODE,
> +=09=09"0;1;2", "Show the current mode of charging");
> +ATTR_GROUP_BOOL_RW(boot_sound, "boot_sound", ASUS_WMI_DEVID_BOOT_SOUND,
> +=09=09"Set the boot POST sound");
> +ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_MCU_PO=
WERSAVE,
> +=09=09"Set MCU powersaving mode");
> +ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
> +=09=09"Set the panel refresh overdrive");
> +ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_=
HD,
> +=09=09"Set the panel HD mode to UHD<0> or FHD<1>");
> +ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU=
_CONNECTED,
> +=09"Show the eGPU connection status");
> +
> +static int asus_fw_attr_add(void)
> +{
> +=09int ret;
> +
> +=09ret =3D fw_attributes_class_get(&fw_attr_class);
> +=09if (ret)
> +=09=09goto fail_class_created;
> +=09else

Unnecessary else since you goto in the if block.

> +=09=09asus_bioscfg.fw_attr_dev =3D device_create(fw_attr_class, NULL,
> +=09=09=09MKDEV(0, 0), NULL, "%s", DRIVER_NAME);
> +
> +=09if (IS_ERR(asus_bioscfg.fw_attr_dev)) {
> +=09=09ret =3D PTR_ERR(asus_bioscfg.fw_attr_dev);
> +=09=09goto fail_class_created;
> +=09}
> +
> +=09asus_bioscfg.fw_attr_kset =3D kset_create_and_add("attributes", NULL,
> +=09=09=09=09&asus_bioscfg.fw_attr_dev->kobj);
> +=09if (!asus_bioscfg.fw_attr_dev) {
> +=09=09ret =3D -ENOMEM;
> +=09=09pr_debug("Failed to create and add attributes\n");
> +=09=09goto err_destroy_classdev;
> +=09}
> +
> +=09/* Add any firmware_attributes required */

Unnecessary comment.

> +=09ret =3D sysfs_create_file(&asus_bioscfg.fw_attr_kset->kobj, &pending_=
reboot.attr);
> +=09if (ret) {
> +=09=09pr_warn("Failed to create sysfs level attributes\n");
> +=09=09goto fail_class_created;
> +=09}
> +
> +=09// TODO: logging

?? Logging of what if you intend to keep this message around.

> +=09asus_bioscfg.mini_led_dev_id =3D 0;
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE)) {
> +=09=09asus_bioscfg.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE;
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &mini_led_mod=
e_attr_group);
> +=09} else if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE2)) {
> +=09=09asus_bioscfg.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE2;
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &mini_led_mod=
e_attr_group);
> +=09}
> +
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX)) {
> +=09=09asus_bioscfg.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX;
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &gpu_mux_mode=
_attr_group);
> +=09} else if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX_VIVO)) {
> +=09=09asus_bioscfg.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX_VIVO;
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &gpu_mux_mode=
_attr_group);
> +=09}
> +
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU)) {
> +=09=09asus_bioscfg.dgpu_disable_available =3D true;
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &dgpu_disable=
_attr_group);
> +=09}
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU)) {
> +=09=09asus_bioscfg.egpu_enable_available =3D true;
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &egpu_enable_=
attr_group);
> +=09}
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU_CONNECTED))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &egpu_connect=
ed_attr_group);
> +
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &thermal_poli=
cy_attr_group);
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PL1_SPL))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_pl1_spl_=
attr_group);
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PL2_SPPT))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_pl2_sppt=
_attr_group);
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_APU_SPPT))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_apu_sppt=
_attr_group);
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PLAT_SPPT))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_platform=
_sppt_attr_group);
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_FPPT))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_fppt_att=
r_group);
> +
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_NV_DYN_BOOST))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &nv_dynamic_b=
oost_attr_group);
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_NV_THERM_TARGET))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &nv_temp_targ=
et_attr_group);
> +
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_CHARGE_MODE))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &charge_mode_=
attr_group);
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_BOOT_SOUND))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &boot_sound_a=
ttr_group);
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_MCU_POWERSAVE))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &mcu_powersav=
e_attr_group);
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_PANEL_OD))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &panel_od_att=
r_group);
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_PANEL_HD))
> +=09=09sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &panel_hd_mod=
e_attr_group);
> +
> +=09return 0;
> +
> +err_destroy_classdev:
> +=09device_destroy(fw_attr_class, MKDEV(0, 0));
> +
> +fail_class_created:
> +=09fw_attributes_class_put();
> +=09return ret;
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
> +=09} else if (strstr(product, "G814")
> +=09=09|| strstr(product, "G614")
> +=09=09|| strstr(product, "G834")
> +=09=09|| strstr(product, "G634")) {
> +=09=09cpu_max =3D 175;
> +=09} else if (strstr(product, "GA402X")
> +=09=09|| strstr(product, "GA403")
> +=09=09|| strstr(product, "FA507N")
> +=09=09|| strstr(product, "FA507X")
> +=09=09|| strstr(product, "FA707N")
> +=09=09|| strstr(product, "FA707X")) {
> +=09=09cpu_max =3D 90;
> +=09}
> +
> +=09if (strstr(product, "GZ301ZE"))
> +=09=09max_boost =3D 5;
> +=09else if (strstr(product, "FX507ZC4"))
> +=09=09max_boost =3D 15;
> +=09else if (strstr(product, "GU605"))
> +=09=09max_boost =3D 20;
> +
> +=09/* ensure defaults for tunables */
> +=09rog->cpu_default =3D cpu_default;
> +=09rog->cpu_max =3D cpu_max;
> +
> +=09rog->platform_default =3D platform_default;
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
> +=09rog->nv_boost_max =3D max_boost;
> +=09rog->nv_dynamic_boost =3D NVIDIA_BOOST_MIN;
> +
> +=09rog->nv_temp_default =3D NVIDIA_TEMP_MAX;
> +=09rog->nv_temp_max =3D NVIDIA_TEMP_MAX;
> +=09rog->nv_temp_target =3D NVIDIA_TEMP_MIN;
> +
> +}
> +
> +static int __init asus_fw_init(void)
> +{
> +=09int err;
> +
> +=09mutex_lock(&asus_bioscfg.mutex);
> +
> +=09asus_bioscfg.rog_tunables =3D kzalloc(sizeof(struct rog_tunables), GF=
P_KERNEL);
> +=09if (!asus_bioscfg.rog_tunables) {
> +=09=09mutex_unlock(&asus_bioscfg.mutex);
> +=09=09return -ENOMEM;
> +=09}
> +=09init_rog_tunables(asus_bioscfg.rog_tunables);
> +
> +=09err =3D asus_fw_attr_add();
> +=09mutex_unlock(&asus_bioscfg.mutex);
> +=09if (err)
> +=09=09return err;
> +
> +=09return 0;
> +}
> +
> +static void __exit asus_fw_exit(void)
> +{
> +=09mutex_lock(&asus_bioscfg.mutex);
> +
> +=09sysfs_remove_file(&asus_bioscfg.fw_attr_kset->kobj, &pending_reboot.a=
ttr);
> +=09kset_unregister(asus_bioscfg.fw_attr_kset);
> +=09device_destroy(fw_attr_class, MKDEV(0, 0));
> +=09fw_attributes_class_put();
> +
> +=09mutex_unlock(&asus_bioscfg.mutex);
> +}
> +
> +module_init(asus_fw_init);
> +module_exit(asus_fw_exit);
> diff --git a/drivers/platform/x86/asus-bioscfg.h b/drivers/platform/x86/a=
sus-bioscfg.h
> new file mode 100644
> index 000000000000..403563c25f53
> --- /dev/null
> +++ b/drivers/platform/x86/asus-bioscfg.h
> @@ -0,0 +1,243 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Definitions for kernel modules using asus-bios driver
> + *
> + *  Copyright (c) 2024 Luke Jones <luke@ljones.dev>
> + */
> +
> +#ifndef _ASUS_BIOSCFG_H_
> +#define _ASUS_BIOSCFG_H_
> +
> +#include "firmware_attributes_class.h"
> +#include <linux/types.h>
> +
> +#define DRIVER_NAME=09"asus-bioscfg"
> +
> +static ssize_t attr_int_store(struct kobject *kobj, struct kobj_attribut=
e *attr,
> +=09=09=09=09const char *buf, size_t count,
> +=09=09=09=09u32 min, u32 max, u32 *store_value, u32 wmi_dev);
> +
> +
> +static ssize_t int_type_show(struct kobject *kobj, struct kobj_attribute=
 *attr,
> +=09=09=09 char *buf)
> +{
> +=09return sysfs_emit(buf, "integer\n");
> +}
> +
> +static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribut=
e *attr,
> +=09=09=09 char *buf)
> +{
> +=09return sysfs_emit(buf, "enumeration\n");
> +}
> +
> +#define __ASUS_ATTR_RO(_func, _name) {=09=09=09=09\
> +=09.attr=09=3D { .name =3D __stringify(_name), .mode =3D 0444 },=09\
> +=09.show=09=3D _func##_##_name##_show,=09=09=09\
> +}
> +
> +#define __ASUS_ATTR_RO_AS(_name, _show) {=09=09=09\
> +=09.attr=09=3D { .name =3D __stringify(_name), .mode =3D 0444 },=09\
> +=09.show=09=3D _show,=09=09=09=09=09\
> +}
> +
> +#define __ASUS_ATTR_RW(_func, _name) __ATTR(_name, 0644,=09\
> +=09=09_func##_##_name##_show, _func##_##_name##_store)
> +
> +#define __WMI_STORE_INT(_attr, _min, _max, _wmi)=09=09=09=09\
> +static ssize_t _attr##_store(struct kobject *kobj,=09=09=09=09\
> +=09=09=09struct kobj_attribute *attr,=09=09=09=09\
> +=09=09=09const char *buf, size_t count)=09=09=09=09\
> +{=09=09=09=09=09=09=09=09=09=09\
> +=09return attr_int_store(kobj, attr, buf, count, _min, _max, NULL, _wmi)=
;=09\
> +}
> +
> +#define WMI_SHOW_INT(_attr, _fmt, _wmi)=09=09=09=09\
> +static ssize_t _attr##_show(struct kobject *kobj,=09=09\
> +=09=09=09struct kobj_attribute *attr, char *buf)=09\
> +{=09=09=09=09=09=09=09=09\
> +=09u32 result;=09=09=09=09=09=09\
> +=09int err;=09=09=09=09=09=09\
> +=09err =3D asus_wmi_get_devstate_dsts(_wmi, &result);=09\
> +=09if (err)=09=09=09=09=09=09\
> +=09=09return err;=09=09=09=09=09\
> +=09return sysfs_emit(buf, _fmt,=09=09=09=09\
> +=09=09result & ~ASUS_WMI_DSTS_PRESENCE_BIT);=09=09\
> +}
> +
> +/* Create functions and attributes for use in other macros or on their o=
wn */
> +
> +#define __ROG_TUNABLE_RW(_attr, _min, _max, _wmi)=09=09=09\
> +static ssize_t _attr##_current_value_store(struct kobject *kobj,=09\
> +=09=09=09struct kobj_attribute *attr,=09=09=09\
> +=09=09=09const char *buf, size_t count)=09=09=09\
> +{=09=09=09=09=09=09=09=09=09\
> +=09return attr_int_store(kobj, attr, buf, count,=09=09=09\
> +=09=09_min, asus_bioscfg.rog_tunables->_max,=09=09=09\
> +=09=09&asus_bioscfg.rog_tunables->_attr, _wmi);=09=09\
> +}=09=09=09=09=09=09=09=09=09\
> +static ssize_t _attr##_current_value_show(struct kobject *kobj,=09=09\
> +=09=09=09struct kobj_attribute *attr, char *buf)=09=09\
> +{=09=09=09=09=09=09=09=09=09\
> +=09return sysfs_emit(buf, "%u\n", asus_bioscfg.rog_tunables->_attr);\
> +}=09=09=09=09=09=09=09=09=09\
> +static struct kobj_attribute attr_##_attr##_current_value =3D=09=09\
> +=09__ASUS_ATTR_RW(_attr, current_value)
> +
> +#define __ROG_TUNABLE_SHOW(_prop, _attrname, _val)=09=09=09\
> +static ssize_t _attrname##_##_prop##_show(struct kobject *kobj,=09=09\
> +=09=09=09struct kobj_attribute *attr, char *buf)=09=09\
> +{=09=09=09=09=09=09=09=09=09\
> +=09return sysfs_emit(buf, "%d\n", asus_bioscfg.rog_tunables->_val);\
> +}=09=09=09=09=09=09=09=09=09\
> +static struct kobj_attribute attr_##_attrname##_##_prop =3D=09=09\
> +=09__ASUS_ATTR_RO(_attrname, _prop)
> +
> +#define __ATTR_CURRENT_INT_RO(_attr, _wmi)=09\
> +WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi);=09=09\
> +static struct kobj_attribute attr_##_attr##_current_value =3D=09\
> +=09__ASUS_ATTR_RO(_attr, current_value)
> +
> +#define __ATTR_CURRENT_INT_RW(_attr, _minv, _maxv, _wmi)=09\
> +__WMI_STORE_INT(_attr##_current_value, _minv, _maxv, _wmi);=09\
> +WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi);=09=09\
> +static struct kobj_attribute attr_##_attr##_current_value =3D=09\
> +=09__ASUS_ATTR_RW(_attr, current_value)
> +
> +/* Shows a formatted static variable */
> +#define __ATTR_SHOW_FMT(_prop, _attrname, _fmt, _val)=09=09\
> +static ssize_t _attrname##_##_prop##_show(struct kobject *kobj,=09\
> +=09=09=09struct kobj_attribute *attr, char *buf)=09\
> +{=09=09=09=09=09=09=09=09\
> +=09return sysfs_emit(buf, _fmt, _val);=09=09=09\
> +}=09=09=09=09=09=09=09=09\
> +static struct kobj_attribute attr_##_attrname##_##_prop =3D=09\
> +=09__ASUS_ATTR_RO(_attrname, _prop)
> +
> +/* Int style min/max range, base macro. Requires current_value show&|sto=
re */
> +#define __ATTR_GROUP_INT(_attrname, _fsname, _default,=09=09\
> +=09=09=09=09_min, _max, _incstep, _dispname)\
> +__ATTR_SHOW_FMT(default_value, _attrname, "%d\n", _default);=09\
> +__ATTR_SHOW_FMT(min_value, _attrname, "%d\n", _min);=09=09\
> +__ATTR_SHOW_FMT(max_value, _attrname, "%d\n", _max);=09=09\
> +__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", _incstep);=09\
> +__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);=09\
> +static struct kobj_attribute attr_##_attrname##_type =3D=09=09\
> +=09__ASUS_ATTR_RO_AS(type, int_type_show);=09=09=09\
> +static struct attribute *_attrname##_attrs[] =3D {=09=09\
> +=09=09&attr_##_attrname##_current_value.attr,=09=09\
> +=09=09&attr_##_attrname##_default_value.attr,=09=09\
> +=09=09&attr_##_attrname##_min_value.attr,=09=09\
> +=09=09&attr_##_attrname##_max_value.attr,=09=09\
> +=09=09&attr_##_attrname##_scalar_increment.attr,=09\
> +=09=09&attr_##_attrname##_display_name.attr,=09=09\
> +=09=09&attr_##_attrname##_type.attr,=09=09=09\
> +=09=09NULL=09=09=09=09=09=09\
> +};=09=09=09=09=09=09=09=09\
> +static const struct attribute_group _attrname##_attr_group =3D {=09\
> +=09=09.name =3D _fsname,=09=09=09=09\
> +=09=09.attrs =3D _attrname##_attrs=09=09=09\
> +}
> +
> +/* Boolean style enumeration, base macro. Requires adding show/store */
> +#define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)=09\
> +__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);=09=09\
> +__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible);=09=09\
> +static struct kobj_attribute attr_##_attrname##_type =3D=09=09=09\
> +=09__ASUS_ATTR_RO_AS(type, enum_type_show);=09=09=09\
> +static struct attribute *_attrname##_attrs[] =3D {=09=09=09\
> +=09=09&attr_##_attrname##_current_value.attr,=09=09=09\
> +=09=09&attr_##_attrname##_display_name.attr,=09=09=09\
> +=09=09&attr_##_attrname##_possible_values.attr,=09=09\
> +=09=09&attr_##_attrname##_type.attr,=09=09=09=09\
> +=09=09NULL=09=09=09=09=09=09=09\
> +};=09=09=09=09=09=09=09=09=09\
> +static const struct attribute_group _attrname##_attr_group =3D {=09=09\
> +=09=09.name =3D _fsname,=09=09=09=09=09\
> +=09=09.attrs =3D _attrname##_attrs=09=09=09=09\
> +}
> +
> +#define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname)=09\
> +do {=09=09=09=09=09=09=09=09\
> +=09__ATTR_CURRENT_INT_RO(_attrname, _wmi);=09=09=09\
> +=09__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname);\
> +} while (0)
> +
> +#define ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname)=09\
> +do {=09=09=09=09=09=09=09=09\
> +=09__ATTR_CURRENT_INT_RW(_attrname, 0, 1, _wmi);=09=09\
> +=09__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname);\
> +} while (0)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + */
> +#define ATTR_GROUP_BOOL_CUSTOM(_attrname, _fsname, _dispname)=09\
> +static struct kobj_attribute attr_##_attrname##_current_value =3D \
> +=09__ASUS_ATTR_RW(_attrname, current_value);=09=09\
> +__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi,=09=09\
> +=09=09=09=09=09_possible, _dispname)=09=09\
> +do {=09=09=09=09=09=09=09=09=09\
> +=09__ATTR_CURRENT_INT_RO(_attrname, _wmi);=09=09=09=09\
> +=09__ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname);=09\
> +} while (0)
> +
> +#define ATTR_GROUP_ENUM_INT_RW(_attrname, _fsname, _wmi, _min,=09=09\
> +=09=09=09=09_max, _possible, _dispname)=09=09\
> +do {=09=09=09=09=09=09=09=09=09\
> +=09__ATTR_CURRENT_INT_RW(_attrname, _min, _max, _wmi);=09=09\
> +=09__ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname);=09\
> +} while (0)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + * and <name>_possible_values_show()
> + */
> +#define ATTR_GROUP_ENUM_CUSTOM(_attrname, _fsname, _dispname)=09=09\
> +__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);=09=09\
> +static struct kobj_attribute attr_##_attrname##_current_value =3D=09=09\
> +=09__ASUS_ATTR_RW(_attrname, current_value);=09=09=09\
> +static struct kobj_attribute attr_##_attrname##_possible_values =3D=09\
> +=09__ASUS_ATTR_RO(_attrname, possible_values);=09=09=09\
> +static struct kobj_attribute attr_##_attrname##_type =3D=09=09=09\
> +=09__ASUS_ATTR_RO_AS(type, enum_type_show);=09=09=09\
> +static struct attribute *_attrname##_attrs[] =3D {=09=09=09\
> +=09=09=09&attr_##_attrname##_current_value.attr,=09=09\
> +=09=09=09&attr_##_attrname##_display_name.attr,=09=09\
> +=09=09=09&attr_##_attrname##_possible_values.attr,=09\
> +=09=09=09&attr_##_attrname##_type.attr,=09=09=09\
> +=09=09=09NULL=09=09=09=09=09=09\
> +};=09=09=09=09=09=09=09=09=09\
> +static const struct attribute_group _attrname##_attr_group =3D {=09=09\
> +=09=09=09.name =3D _fsname,=09=09=09=09\
> +=09=09=09.attrs =3D _attrname##_attrs=09=09=09\
> +}
> +
> +/* ROG PPT attributes need a little different in setup */
> +#define ATTR_GROUP_PPT_RW(_attrname, _fsname, _wmi, _default,=09\
> +=09=09=09_min, _max, _incstep, _dispname)=09\
> +__ROG_TUNABLE_RW(_attrname, _min, _max, _wmi);=09=09=09\
> +__ROG_TUNABLE_SHOW(default_value, _attrname, _default);=09=09\
> +__ATTR_SHOW_FMT(min_value, _attrname, "%d\n", _min);=09=09\
> +__ROG_TUNABLE_SHOW(max_value, _attrname, _max);=09=09=09\
> +__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", _incstep);=09\
> +__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);=09\
> +static struct kobj_attribute attr_##_attrname##_type =3D=09=09\
> +=09__ASUS_ATTR_RO_AS(type, int_type_show);=09=09=09\
> +static struct attribute *_attrname##_attrs[] =3D {=09=09\
> +=09=09&attr_##_attrname##_current_value.attr,=09=09\
> +=09=09&attr_##_attrname##_default_value.attr,=09=09\
> +=09=09&attr_##_attrname##_min_value.attr,=09=09\
> +=09=09&attr_##_attrname##_max_value.attr,=09=09\
> +=09=09&attr_##_attrname##_scalar_increment.attr,=09\
> +=09=09&attr_##_attrname##_display_name.attr,=09=09\
> +=09=09&attr_##_attrname##_type.attr,=09=09=09\
> +=09=09NULL=09=09=09=09=09=09\
> +};=09=09=09=09=09=09=09=09\
> +static const struct attribute_group _attrname##_attr_group =3D {=09\
> +=09=09.name =3D _fsname,=09=09=09=09\
> +=09=09.attrs =3D _attrname##_attrs=09=09=09\
> +}
> +
> +#endif /* _ASUS_BIOSCFG_H_ */
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index 2b968003cb9b..3f1998638fea 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -529,12 +529,28 @@ static int asus_wmi_get_devstate(struct asus_wmi *a=
sus, u32 dev_id, u32 *retval)
>  =09return 0;
>  }
> =20
> -static int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
> +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
> +{
> +=09int err;
> +
> +=09err =3D asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, r=
etval);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (*retval =3D=3D ~0)
> +=09=09return -ENODEV;
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(asus_wmi_get_devstate_dsts);
> +
> +int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
>  =09=09=09=09 u32 *retval)

Should fit to one line just fine.

As general feel of the readiness of this code, I suspect there were many=20
more problems which I failed to notice :-(.

--=20
 i.

>  {
>  =09return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
>  =09=09=09=09=09ctrl_param, retval);
>  }
> +EXPORT_SYMBOL_GPL(asus_wmi_set_devstate);
> =20
>  /* Helper for special devices with magic return codes */
>  static int asus_wmi_get_devstate_bits(struct asus_wmi *asus,
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/p=
latform_data/x86/asus-wmi.h
> index 74b32e1d6735..889336a932fb 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -67,6 +67,7 @@
>  #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
> =20
>  /* Misc */
> +#define ASUS_WMI_DEVID_PANEL_HD=09=090x0005001C
>  #define ASUS_WMI_DEVID_PANEL_OD=09=090x00050019
>  #define ASUS_WMI_DEVID_CAMERA=09=090x00060013
>  #define ASUS_WMI_DEVID_LID_FLIP=09=090x00060062
> @@ -152,8 +153,18 @@
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
--8323328-2053776027-1721121671=:1037--

