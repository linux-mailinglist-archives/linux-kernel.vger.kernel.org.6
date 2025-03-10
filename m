Return-Path: <linux-kernel+bounces-555253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574DAA5A9C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF861891507
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A610C1F4C98;
	Mon, 10 Mar 2025 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU5BiYrM"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83644A02;
	Mon, 10 Mar 2025 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741647318; cv=none; b=e4BM2WfrR3ch/4pwRafB/IGYrGA8BPMLQDCcb9Q0xE3GBJjdgFfLinDumy8Zlh0y0VC3DFMzvgX64PElmaKw2WHkHJtoQM5ncMOcGAk18tyq3jCw1WQ8eGPWFCEnllOTdejhCYueWjipWlUHh12z+CVycv+135Q9uvgGLXtz/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741647318; c=relaxed/simple;
	bh=hlY1dv1gsjczRYzkupbSUKONxAByppwiV87sRmUeWg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6ZzN4zn8bcyo+GIBkKbI1uMCR8gd+BPNAlH6ctwyJk/x1Omv7/416k/K1EzxBM2slTjtid8iGWo82W9+F03ZVWtGV5qFq9fk+X0v20ECqS7RRsa3DlB9WZCC4t1yaS9IwHHram9HMyKkys2yIQLlVs91yEowBlwKY1HGwFpyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU5BiYrM; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e6c082eac0so44408176d6.0;
        Mon, 10 Mar 2025 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741647314; x=1742252114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nLYw+mzv4TphSNwmiwRbeHXYNP0BYpntdGXzmgHZ/k=;
        b=jU5BiYrMfOZPiFQDtN3/ZTdJflzCSbnp//lxfV7BBwXd5Y9KIGMt4vgdxs/BMJZqEj
         JRM6l9W2C5XI2sHOoFfYN2mReWA78UwmrZbUBK+GiMg0/UZPD7C4qHSQ9ZYRzdSC0GHP
         QK6rNB5+QrLzOAsSJQ516SVKjSjb0IiFckt5r0xzKup6OZosxUwdwGfKXCG7QG/Fmon4
         klNc6hGRBZOwCekAeSyS/4Fx02T0RpMhNmvhVRW59ZZOlCSjaPU2OJuiv/VJK7wjCl+t
         th9G/ZccrDnBXsSYnF5tCGOxqe7u3On7nB38TtyYGde6Tn40RURIsieLRLonhMnoZKLj
         4bGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741647314; x=1742252114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nLYw+mzv4TphSNwmiwRbeHXYNP0BYpntdGXzmgHZ/k=;
        b=d4YmDzt6MB0fUosXsnGC4kFytXmXSvLDgbLXPUniMzjttl8Lm6+i8A1n0vddcTznB3
         MIyPdMnQ2Xb3S/iLqbQsSEJiNkOvXbBA48I/Ij3LheKyGlCLBWSjYZgSVx3A7LaDzMKm
         OnD1UIrVBPBDXTAh5NC7OJWx51ccv6eW4V+Ya5GrjZ12IAanLFZ+cq6QEqx0DRXzqXcI
         OiuDpfrx66V6o1bOIgc1kXjWT2BFw0lNqQISyNHR4RhPFYdU7TIziRDyAFhApcWTffam
         M2daXND5PUnRRkUaGPYN1zDaNzlZ+V1zDZ1z/bkVV3fCn/RDa9rVmM7BQ0EIWluM8aCQ
         Niog==
X-Forwarded-Encrypted: i=1; AJvYcCV7c65f8+KDHo+FEN+LeQ4aApuFbSrKBJF1RN2zD6yhzZTFy0Qk1MHJjRbEYRAbaQcRbyAaSMcFP14A0GWa@vger.kernel.org, AJvYcCW+CGANFXknoSSHXPYCjDr1wE9FCmCQC1+YBotbU2Rjg4t8Haiq2gceMFOTiTUro5cPebTWYAWjMZ5lOos93WGBtggZ2w==@vger.kernel.org, AJvYcCW28xaS3mj3PE+ZARmONBrmzDv1Lo6Oa4gUfKtFxaZMcVbHw+DtPC+D6JXAfMFo+cwqV4dOAzWQtho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6s4RawV6PFr4NPMSyEksJNJfcC65FHhq2d7nVXAxGvctes3E
	tkHv2p5EXgx5wJRhwH78AIVIiznkGAFeURa06uycs50gSI8UvjQs0ldwVi5MiQq8FprrYxfKlPY
	Mb1fAhTBdxCpJc8WYp/Tc1ZcXF/Y=
X-Gm-Gg: ASbGnctUPpbdsxMAVzxhLKqcKUTDzcTX2bqu+zhEaTDBpcLm3CUN3WI2pox5+bHfYnh
	xNg4TTpJ2Bu/v9YQRn0EoKOfPO3gHnFrLizdn4yiMR5DUpR0eEx/5wxa6IVq00V0sn65axFF3Xg
	DLvsxd1+F/vxIk4IdK0xSaJTHxGFQ=
X-Google-Smtp-Source: AGHT+IFocwxg+Yw/6+8kr3UBrqHon5fbk+ltRcHbOsURvNCG2TTGiAnblNym7cTdQpUqS5TMQiYURaQkBcvP+Y59f5U=
X-Received: by 2002:ad4:5aa2:0:b0:6e8:feae:9291 with SMTP id
 6a1803df08f44-6e90063df9amr191946876d6.24.1741647314293; Mon, 10 Mar 2025
 15:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225220037.16073-1-derekjohn.clark@gmail.com>
 <20250225220037.16073-5-derekjohn.clark@gmail.com> <630b3040-a0ad-4438-8c52-bf9d7b8cfd63@gmx.de>
In-Reply-To: <630b3040-a0ad-4438-8c52-bf9d7b8cfd63@gmx.de>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 15:55:03 -0700
X-Gm-Features: AQ5f1Jq0g7_cpz9km07HhYPNuAtfUFeo8TT2LFP5VbLqU3SV92cIJZK-P99m1ds
Message-ID: <CAFqHKTnBfmSoxou1Kze=q9VoqMGXYJUb=BOR3QMn4msi+ygwrQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] platform/x86: Add Lenovo Other Mode WMI Driver
To: Armin Wolf <W_Armin@gmx.de>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mario Limonciello <superm1@kernel.org>, Luke Jones <luke@ljones.dev>, 
	Xino Ni <nijs1@lenovo.com>, Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, "Cody T . -H . Chiu" <codyit@gmail.com>, 
	John Martens <johnfanv2@gmail.com>, platform-driver-x86@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:25=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 25.02.25 um 22:59 schrieb Derek J. Clark:
>
> > Adds lenovo-wmi-other.c which provides a driver for the Lenovo
> > "Other Mode" WMI interface that comes on some Lenovo "Gaming
> > Series" hardware. Provides a firmware-attributes class which
> > enables the use of tunable knobs for SPL, SPPT, and FPPT.
> >
> > v3:
> > - Add notifier block and store result for getting the Gamezone interfac=
e
> >    profile changes.
> > - Add driver as master component of capdata01 driver.
> > - Use FIELD_PREP where appropriate.
> > - Move macros and associated functions out of lemovo-wmi.h that are onl=
y
> >    used by this driver.
> > v2:
> > - Use devm_kmalloc to ensure driver can be instanced, remove global
> >    reference.
> > - Ensure reverse Christmas tree for all variable declarations.
> > - Remove extra whitespace.
> > - Use guard(mutex) in all mutex instances, global mutex.
> > - Use pr_fmt instead of adding the driver name to each pr_err.
> > - Remove noisy pr_info usage.
> > - Rename other_method_wmi to lenovo_wmi_om_priv and om_wmi to priv.
> > - Use list to get the lenovo_wmi_om_priv instance in some macro
> >    called functions as the data provided by the macros that use it
> >    doesn't pass a member of the struct for use in container_of.
> > - Do not rely on GameZone interface to grab the current fan mode.
> >
> > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > ---
> >   MAINTAINERS                             |   1 +
> >   drivers/platform/x86/Kconfig            |  14 +
> >   drivers/platform/x86/Makefile           |   1 +
> >   drivers/platform/x86/lenovo-wmi-other.c | 549 +++++++++++++++++++++++=
+
> >   drivers/platform/x86/lenovo-wmi.h       |  13 +
> >   5 files changed, 578 insertions(+)
> >   create mode 100644 drivers/platform/x86/lenovo-wmi-other.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f6d3e79e50ce..f6e16b2346a2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13159,6 +13159,7 @@ F:    Documentation/wmi/devices/lenovo-wmi-game=
zone.rst
> >   F:  Documentation/wmi/devices/lenovo-wmi-other.rst
> >   F:  drivers/platform/x86/lenovo-wmi-capdata01.c
> >   F:  drivers/platform/x86/lenovo-wmi-gamezone.c
> > +F:   drivers/platform/x86/lenovo-wmi-other.c
> >   F:  drivers/platform/x86/lenovo-wmi.c
> >   F:  drivers/platform/x86/lenovo-wmi.h
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 56336dc3c2d0..017ecdfad8ce 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -480,6 +480,20 @@ config LENOVO_WMI_DATA01
> >       depends on ACPI_WMI
> >       select LENOVO_WMI
> >
> > +config LENOVO_WMI_TUNING
> > +     tristate "Lenovo Other Mode WMI Driver"
> > +     depends on ACPI_WMI
> > +     select FW_ATTR_CLASS
> > +     select LENOVO_WMI
> > +     select LENOVO_WMI_DATA01
> > +     help
> > +       Say Y here if you have a WMI aware Lenovo Legion device and wou=
ld like to use the
> > +       firmware_attributes API to control various tunable settings typ=
ically exposed by
> > +       Lenovo software in Windows.
> > +
> > +       To compile this driver as a module, choose M here: the module w=
ill
> > +       be called lenovo-wmi-other.
> > +
> >   config IDEAPAD_LAPTOP
> >       tristate "Lenovo IdeaPad Laptop Extras"
> >       depends on ACPI
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
> > index be9031bea090..28ce39631a6d 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -71,6 +71,7 @@ obj-$(CONFIG_LENOVO_WMI)    +=3D lenovo-wmi.o
> >   obj-$(CONFIG_LENOVO_WMI_CAMERA)     +=3D lenovo-wmi-camera.o
> >   obj-$(CONFIG_LENOVO_WMI_GAMEZONE)   +=3D lenovo-wmi-gamezone.o
> >   obj-$(CONFIG_LENOVO_WMI_DATA01)     +=3D lenovo-wmi-capdata01.o
> > +obj-$(CONFIG_LENOVO_WMI_TUNING)      +=3D lenovo-wmi-other.o
> >
> >   # Intel
> >   obj-y                               +=3D intel/
> > diff --git a/drivers/platform/x86/lenovo-wmi-other.c b/drivers/platform=
/x86/lenovo-wmi-other.c
> > new file mode 100644
> > index 000000000000..cd04ead94ba3
> > --- /dev/null
> > +++ b/drivers/platform/x86/lenovo-wmi-other.c
> > @@ -0,0 +1,549 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Lenovo Other Mode WMI interface driver. This driver uses the fw_att=
ributes
> > + * class to expose the various WMI functions provided by the "Other Mo=
de" WMI
> > + * interface. This enables CPU and GPU power limit as well as various =
other
> > + * attributes for devices that fall under the "Gaming Series" of Lenov=
o laptop
> > + * devices. Each attribute exposed by the "Other Mode"" interface has =
a
> > + * corresponding LENOVO_CAPABILITY_DATA_01 struct that allows the driv=
er to
> > + * probe details about the attribute such as set/get support, step, mi=
n, max,
> > + * and default value. Each attibute has multiple pages, one for each o=
f the
> > + * fan profiles managed by the Gamezone interface.
> > + *
> > + * These attributes typically don't fit anywhere else in the sysfs and=
 are set
> > + * in Windows using one of Lenovo's multiple user applications.
> > + *
> > + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>
> 2025
>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/component.h>
> > +#include <linux/container_of.h>
> > +#include <linux/device.h>
> > +#include <linux/kobject.h>
> > +#include <linux/notifier.h>
> > +#include <linux/types.h>
> > +#include <linux/wmi.h>
> > +#include "lenovo-wmi.h"
> > +#include "firmware_attributes_class.h"
> > +
> > +/* Interface GUIDs */
> > +#define LENOVO_OTHER_METHOD_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B=
"
> > +
> > +/* Device IDs */
> > +#define WMI_DEVICE_ID_CPU 0x01
> > +
> > +/* WMI_DEVICE_ID_CPU feature IDs */
> > +#define WMI_FEATURE_ID_CPU_SPPT 0x01 /* Short Term Power Limit */
> > +#define WMI_FEATURE_ID_CPU_FPPT 0x03 /* Long Term Power Limit */
> > +#define WMI_FEATURE_ID_CPU_SPL 0x02 /* Peak Power Limit */
> > +
> > +/* Type IDs*/
> > +#define WMI_TYPE_ID_NONE 0x00
> > +
> > +/* Method IDs */
> > +#define WMI_FAN_TABLE_GET 5 /* Other Mode FAN_METHOD Getter */
> > +#define WMI_FAN_TABLE_SET 6 /* Other Mode FAN_METHOD Setter */
> > +#define WMI_FEATURE_VALUE_GET 17 /* Other Mode Getter */
> > +#define WMI_FEATURE_VALUE_SET 18 /* Other Mode Setter */
> > +
> > +/* Attribute ID bitmasks */
> > +#define ATTR_DEV_ID_MASK GENMASK(31, 24)
> > +#define ATTR_FEAT_ID_MASK GENMASK(23, 16)
> > +#define ATTR_MODE_ID_MASK GENMASK(15, 8)
> > +#define ATTR_TYPE_ID_MASK GENMASK(7, 0)
> > +
> > +enum attribute_property {
> > +     DEFAULT_VAL,
> > +     MAX_VAL,
> > +     MIN_VAL,
> > +     STEP_VAL,
> > +     SUPPORTED,
> > +};
> > +
> > +/* Tunable attribute that uses LENOVO_CAPABILITY_DATA_01 */
> > +struct tunable_attr_01 {
> > +     u32 type_id;
> > +     u32 device_id;
> > +     u32 feature_id;
> > +     u32 store_value;
> > +     struct device *dev;
> > +     struct capdata01 *capdata;
> > +};
> > +
> > +/* Tunable Attributes */
> > +struct tunable_attr_01 ppt_pl1_spl =3D { .device_id =3D WMI_DEVICE_ID_=
CPU,
> > +                                    .feature_id =3D WMI_FEATURE_ID_CPU=
_SPL,
> > +                                    .type_id =3D WMI_TYPE_ID_NONE };
> > +struct tunable_attr_01 ppt_pl2_sppt =3D { .device_id =3D WMI_DEVICE_ID=
_CPU,
> > +                                     .feature_id =3D WMI_FEATURE_ID_CP=
U_SPPT,
> > +                                     .type_id =3D WMI_TYPE_ID_NONE };
> > +struct tunable_attr_01 ppt_pl3_fppt =3D { .device_id =3D WMI_DEVICE_ID=
_CPU,
> > +                                     .feature_id =3D WMI_FEATURE_ID_CP=
U_FPPT,
> > +                                     .type_id =3D WMI_TYPE_ID_NONE };
> > +
> > +struct capdata01_attr_group {
> > +     const struct attribute_group *attr_group;
> > +     struct tunable_attr_01 *tunable_attr;
> > +};
> > +
> > +#define FW_ATTR_FOLDER "lenovo-wmi-other"
> > +
> > +/**
> > + * int_type_show() - Emit the data type for an integer attribute
> > + * @kobj: Pointer to the driver object.
> > + * @kobj_attribute: Pointer to the attribute calling this function.
> > + * @buf: The buffer to write to.
> > + *
> > + * Returns: Number of characters written to buf.
> > + */
> > +static ssize_t int_type_show(struct kobject *kobj, struct kobj_attribu=
te *kattr,
> > +                          char *buf)
> > +{
> > +     return sysfs_emit(buf, "integer\n");
> > +}
> > +
> > +/**                                      .
> > + * attr_capdata01_get - Get the data of the specified attribute
> > + * from lenovo_wmi_om->cd01.
> > + * @tunable_attr: The attribute to be populated.
> > + *
> > + * Returns: Either 0 or an error.
> > + */
> > +static struct capdata01 *
> > +attr_capdata01_get_data(struct lenovo_wmi_om *om,
> > +                     struct tunable_attr_01 *tunable_attr,
> > +                     enum thermal_mode mode)
> > +{
> > +     u32 attribute_id =3D
> > +             FIELD_PREP(ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> > +             FIELD_PREP(ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> > +             FIELD_PREP(ATTR_MODE_ID_MASK, mode) |
> > +             FIELD_PREP(ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> > +     int idx;
> > +
> > +     if (!om->cd01)
> > +             return NULL;
> > +
> > +     for (idx =3D 0; idx < om->cd01->instance_count; idx++) {
> > +             if (om->cd01->capdata[idx]->id !=3D attribute_id)
> > +                     continue;
> > +             return om->cd01->capdata[idx];
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +/**
> > + * attr_capdata01_show() - Get the value of the specified attribute pr=
operty
> > + * from LENOVO_CAPABILITY_DATA_01.
> > + * @kobj: Pointer to the driver object.
> > + * @kobj_attribute: Pointer to the attribute calling this function.
> > + * @buf: The buffer to write to.
> > + * @tunable_attr: The attribute to be read.
> > + * @prop: The property of this attribute to be read.
> > + *
> > + * This function is intended to be generic so it can be called from an=
y "_show"
> > + * attribute which works only with integers.
> > + *
> > + * If the WMI is success, then the sysfs attribute is notified.
> > + *
> > + * Returns: Either number of characters written to buf, or an error.
> > + */
> > +static ssize_t attr_capdata01_show(struct kobject *kobj,
> > +                                struct kobj_attribute *kattr, char *bu=
f,
> > +                                struct tunable_attr_01 *tunable_attr,
> > +                                enum attribute_property prop)
> > +{
> > +     struct lenovo_wmi_om *om =3D dev_get_drvdata(tunable_attr->dev);
> > +     struct capdata01 *capdata;
> > +     int value;
> > +
> > +     if (!om)
> > +             return -ENODEV;
> > +
> > +     capdata =3D attr_capdata01_get_data(om, tunable_attr,
> > +                                       SMARTFAN_MODE_CUSTOM);
> > +
> > +     if (!capdata)
> > +             return -ENODEV;
> > +
> > +     switch (prop) {
> > +     case DEFAULT_VAL:
> > +             value =3D capdata->default_value;
> > +             break;
> > +     case MAX_VAL:
> > +             value =3D capdata->max_value;
> > +             break;
> > +     case MIN_VAL:
> > +             value =3D capdata->min_value;
> > +             break;
> > +     case STEP_VAL:
> > +             value =3D capdata->step;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +     return sysfs_emit(buf, "%d\n", value);
> > +}
> > +
> > +/* Simple attribute creation */
> > +
> > +/*
> > + * att_current_value_store() - Set the current value of the given attr=
ibute
> > + * @kobj: Pointer to the driver object.
> > + * @kobj_attribute: Pointer to the attribute calling this function.
> > + * @buf: The buffer to read from, this is parsed to `int` type.
> > + * @count: Required by sysfs attribute macros, pass in from the callee=
 attr.
> > + * @tunable_attr: The attribute to be stored.
> > + *
> > + * This function is intended to be generic so it can be called from an=
y
> > + * attribute's "current_value_store" which works only with integers. T=
he
> > + * integer to be sent to the WMI method is range checked and an error =
returned
> > + * if out of range.
> > + *
> > + * If the value is valid and WMI is success, then the sysfs attribute =
is
> > + * notified.
> > + *
> > + * Returns: Either count, or an error.
> > + */
> > +static ssize_t attr_current_value_store(struct kobject *kobj,
> > +                                     struct kobj_attribute *kattr,
> > +                                     const char *buf, size_t count,
> > +                                     struct tunable_attr_01 *tunable_a=
ttr)
> > +{
> > +     struct lenovo_wmi_om *om =3D dev_get_drvdata(tunable_attr->dev);
> > +     struct capdata01 *capdata;
> > +     u32 attribute_id;
> > +     u32 value;
> > +     int err;
> > +
> > +     if (!om)
> > +             return -ENODEV;
> > +
> > +     capdata =3D attr_capdata01_get_data(om, tunable_attr,
> > +                                       SMARTFAN_MODE_CUSTOM);
> > +
> > +     if (!capdata)
> > +             return -ENODEV;
> > +
> > +     attribute_id =3D FIELD_PREP(ATTR_DEV_ID_MASK, tunable_attr->devic=
e_id) |
> > +                    FIELD_PREP(ATTR_FEAT_ID_MASK, tunable_attr->featur=
e_id) |
> > +                    FIELD_PREP(ATTR_MODE_ID_MASK, SMARTFAN_MODE_CUSTOM=
) |
> > +                    FIELD_PREP(ATTR_TYPE_ID_MASK, tunable_attr->type_i=
d);
> > +
> > +     err =3D kstrtouint(buf, 10, &value);
> > +     if (err)
> > +             return err;
> > +
> > +     if (value < capdata->min_value || value > capdata->max_value)
> > +             return -EINVAL;
> > +
> > +     err =3D lenovo_wmidev_evaluate_method_2(om->wdev, 0x0,
> > +                                           WMI_FEATURE_VALUE_SET,
> > +                                           attribute_id, value, NULL);
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     tunable_attr->store_value =3D value;
> > +     return count;
> > +};
> > +
> > +/*
> > + * attr_current_value_show() - Get the current value of the given attr=
ibute
> > + * @kobj: Pointer to the driver object.
> > + * @kobj_attribute: Pointer to the attribute calling this function.
> > + * @buf: The buffer to write to.
> > + * @tunable_attr: The attribute to be read.
> > + *
> > + * This function is intended to be generic so it can be called from an=
y "_show"
> > + * attribute which works only with integers.
> > + *
> > + * If the WMI is success, then the sysfs attribute is notified.
> > + *
> > + * Returns: Either number of characters written to buf, or an error.
> > + */
> > +static ssize_t attr_current_value_show(struct kobject *kobj,
> > +                                    struct kobj_attribute *kattr, char=
 *buf,
> > +                                    struct tunable_attr_01 *tunable_at=
tr)
> > +{
> > +     struct lenovo_wmi_om *om =3D dev_get_drvdata(tunable_attr->dev);
> > +     u32 attribute_id;
> > +     int retval;
> > +     int err;
> > +
> > +     if (!om)
> > +             return -ENODEV;
> > +
> > +     attribute_id =3D FIELD_PREP(ATTR_DEV_ID_MASK, tunable_attr->devic=
e_id) |
> > +                    FIELD_PREP(ATTR_FEAT_ID_MASK, tunable_attr->featur=
e_id) |
> > +                    FIELD_PREP(ATTR_MODE_ID_MASK, om->mode) |
> > +                    FIELD_PREP(ATTR_TYPE_ID_MASK, tunable_attr->type_i=
d);
> > +
> > +     err =3D lenovo_wmidev_evaluate_method_1(om->wdev, 0x0, WMI_FEATUR=
E_VALUE_GET,
> > +                                           attribute_id, &retval);
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     return sysfs_emit(buf, "%d\n", retval);
> > +}
> > +
> > +/* Attribute macros */
> > +#define __LL_ATTR_RO(_func, _name)                                    =
\
> > +     {                                                             \
> > +             .attr =3D { .name =3D __stringify(_name), .mode =3D 0444 =
}, \
> > +             .show =3D _func##_##_name##_show,                       \
> > +     }
> > +
> > +#define __LL_ATTR_RO_AS(_name, _show)                                 =
\
> > +     {                                                             \
> > +             .attr =3D { .name =3D __stringify(_name), .mode =3D 0444 =
}, \
> > +             .show =3D _show,                                        \
> > +     }
> > +
> > +#define __LL_ATTR_RW(_func, _name) \
> > +     __ATTR(_name, 0644, _func##_##_name##_show, _func##_##_name##_sto=
re)
> > +
> > +/* Shows a formatted static variable */
> > +#define __ATTR_SHOW_FMT(_prop, _attrname, _fmt, _val)                 =
         \
> > +     static ssize_t _attrname##_##_prop##_show(                       =
      \
> > +             struct kobject *kobj, struct kobj_attribute *kattr, char =
*buf) \
> > +     {                                                                =
      \
> > +             return sysfs_emit(buf, _fmt, _val);                      =
      \
> > +     }                                                                =
      \
> > +     static struct kobj_attribute attr_##_attrname##_##_prop =3D      =
        \
> > +             __LL_ATTR_RO(_attrname, _prop)
> > +
> > +/* Attribute current value read/write */
> > +#define __LL_TUNABLE_CURRENT_VALUE_CAP01(_attrname)                   =
         \
> > +     static ssize_t _attrname##_current_value_store(                  =
      \
> > +             struct kobject *kobj, struct kobj_attribute *kattr,      =
      \
> > +             const char *buf, size_t count)                           =
      \
> > +     {                                                                =
      \
> > +             return attr_current_value_store(kobj, kattr, buf, count, =
      \
> > +                                             &_attrname);             =
      \
> > +     }                                                                =
      \
> > +     static ssize_t _attrname##_current_value_show(                   =
      \
> > +             struct kobject *kobj, struct kobj_attribute *kattr, char =
*buf) \
> > +     {                                                                =
      \
> > +             return attr_current_value_show(kobj, kattr, buf, &_attrna=
me);  \
> > +     }                                                                =
      \
> > +     static struct kobj_attribute attr_##_attrname##_current_value =3D=
        \
> > +             __LL_ATTR_RW(_attrname, current_value)
> > +
> > +/* Attribute property read only */
> > +#define __LL_TUNABLE_RO_CAP01(_prop, _attrname, _prop_type)           =
         \
> > +     static ssize_t _attrname##_##_prop##_show(                       =
      \
> > +             struct kobject *kobj, struct kobj_attribute *kattr, char =
*buf) \
> > +     {                                                                =
      \
> > +             return attr_capdata01_show(kobj, kattr, buf, &_attrname, =
      \
> > +                                        _prop_type);                  =
      \
> > +     }                                                                =
      \
> > +     static struct kobj_attribute attr_##_attrname##_##_prop =3D      =
        \
> > +             __LL_ATTR_RO(_attrname, _prop)
> > +
> > +#define ATTR_GROUP_LL_TUNABLE_CAP01(_attrname, _fsname, _dispname)    =
 \
> > +     __LL_TUNABLE_CURRENT_VALUE_CAP01(_attrname);                   \
> > +     __LL_TUNABLE_RO_CAP01(default_value, _attrname, DEFAULT_VAL);  \
> > +     __ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);   \
> > +     __LL_TUNABLE_RO_CAP01(max_value, _attrname, MAX_VAL);          \
> > +     __LL_TUNABLE_RO_CAP01(min_value, _attrname, MIN_VAL);          \
> > +     __LL_TUNABLE_RO_CAP01(scalar_increment, _attrname, STEP_VAL);  \
> > +     static struct kobj_attribute attr_##_attrname##_type =3D         =
\
> > +             __LL_ATTR_RO_AS(type, int_type_show);                  \
> > +     static struct attribute *_attrname##_attrs[] =3D {               =
\
> > +             &attr_##_attrname##_current_value.attr,                \
> > +             &attr_##_attrname##_default_value.attr,                \
> > +             &attr_##_attrname##_display_name.attr,                 \
> > +             &attr_##_attrname##_max_value.attr,                    \
> > +             &attr_##_attrname##_min_value.attr,                    \
> > +             &attr_##_attrname##_scalar_increment.attr,             \
> > +             &attr_##_attrname##_type.attr,                         \
> > +             NULL,                                                  \
> > +     };                                                             \
> > +     static const struct attribute_group _attrname##_attr_group =3D { =
\
> > +             .name =3D _fsname, .attrs =3D _attrname##_attrs          =
  \
> > +     }
>
> Those macros look a bit chaotic, can you help me a bit in understanding t=
heir purpose?
>

These macros create an attribute group (and associated show/store
functions) for each firmware attribute exposed by other mode with the
capdata_01 class. Each firmware attribute has the following sysfs
fields:
 - current_value
 - default_value
 - display_name
 - max_value
 - min_value
 - scalar_increment
 - type

The main ATTR_GROUP_LL_TUNABLE_CAP01 macro creates all of these sysfs
entries for a specific attribute. Most of these are RO attributes that
only have a _show call. current_value is the only RW attribute so it
binds _show and _store. display_name and type emit strings through
sysfs_emit.

Currently we're only exposing 3 of these attributes
(pl1_ppt/pl2_sppt/pl3_fppt), but the MOF data provides details on 68
total attributes. This approach reduces the size & complexity of the
driver by turning a lot of repeated boilerplate into macros for the
compiler to manage.

> > +
> > +ATTR_GROUP_LL_TUNABLE_CAP01(ppt_pl1_spl, "ppt_pl1_spl",
> > +                         "Set the CPU sustained power limit");
> > +ATTR_GROUP_LL_TUNABLE_CAP01(ppt_pl2_sppt, "ppt_pl2_sppt",
> > +                         "Set the CPU slow package power tracking limi=
t");
> > +ATTR_GROUP_LL_TUNABLE_CAP01(ppt_pl3_fppt, "ppt_pl3_fppt",
> > +                         "Set the CPU fast package power tracking limi=
t");
> > +
> > +static struct capdata01_attr_group capdata01_attr_groups[] =3D {
> > +     { &ppt_pl1_spl_attr_group, &ppt_pl1_spl },
> > +     { &ppt_pl2_sppt_attr_group, &ppt_pl2_sppt },
> > +     { &ppt_pl3_fppt_attr_group, &ppt_pl3_fppt },
> > +     {},
> > +};
> > +
> > +static int lenovo_wmi_om_fw_attr_add(struct lenovo_wmi_om *om)
> > +{
> > +     int err, i;
> > +
> > +     om->fw_attr_dev =3D device_create(&firmware_attributes_class, NUL=
L,
> > +                                     MKDEV(0, 0), NULL, "%s",
> > +                                     FW_ATTR_FOLDER);
> > +     if (IS_ERR(om->fw_attr_dev)) {
> > +             err =3D PTR_ERR(om->fw_attr_dev);
> > +             return err;
> > +     }
> > +
> > +     om->fw_attr_kset =3D
> > +             kset_create_and_add("attributes", NULL, &om->fw_attr_dev-=
>kobj);
> > +     if (!om->fw_attr_kset) {
> > +             err =3D -ENOMEM;
> > +             goto err_destroy_classdev;
> > +     }
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(capdata01_attr_groups) - 1; i++) {
> > +             err =3D sysfs_create_group(&om->fw_attr_kset->kobj,
> > +                                      capdata01_attr_groups[i].attr_gr=
oup);
> > +             if (err) {
> > +                     pr_debug("Failed to create sysfs-group for %s: %d=
\n",
> > +                              capdata01_attr_groups[i].attr_group->nam=
e,
> > +                              err);
> > +                     goto err_remove_groups;
> > +             }
> > +             capdata01_attr_groups[i].tunable_attr->dev =3D &om->wdev-=
>dev;
> > +     }
> > +     return 0;
> > +
> > +err_remove_groups:
> > +     while (i-- > 0) {
> > +             sysfs_remove_group(&om->fw_attr_kset->kobj,
> > +                                capdata01_attr_groups[i].attr_group);
> > +     }
> > +     kset_unregister(om->fw_attr_kset);
> > +
> > +err_destroy_classdev:
> > +     device_unregister(om->fw_attr_dev);
> > +     return err;
>
> Maybe using devm_add_action_or_reset() would make sense here?
>

I'll look into it.

> > +}
> > +
> > +static int lenovo_wmi_om_notifier(struct notifier_block *nb, unsigned =
long cmd,
> > +                               void *data)
> > +{
> > +     struct lenovo_wmi_om *om =3D container_of(nb, struct lenovo_wmi_o=
m, nb);
> > +
> > +     if (!om)
> > +             NOTIFY_BAD;
> > +
> > +     if (cmd !=3D THERMAL_MODE_EVENT)
> > +             NOTIFY_OK;
> > +
> > +     om->mode =3D *((enum thermal_mode *)data);
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static int lenovo_wmi_om_master_bind(struct device *dev)
> > +{
> > +     struct lenovo_wmi_om *om =3D dev_get_drvdata(dev);
> > +
> > +     int ret;
> > +
> > +     ret =3D component_bind_all(dev, om);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return lenovo_wmi_om_fw_attr_add(om);
> > +}
> > +
> > +static void lenovo_wmi_om_master_unbind(struct device *dev)
> > +{
> > +     component_unbind_all(dev, NULL);
>
> You need to remove the attributes here.

That makes sense, yeah.

> > +}
> > +
> > +static const struct component_master_ops lenovo_wmi_om_master_ops =3D =
{
> > +     .bind =3D lenovo_wmi_om_master_bind,
> > +     .unbind =3D lenovo_wmi_om_master_unbind,
> > +};
> > +
> > +static int lenovo_wmi_other_probe(struct wmi_device *wdev, const void =
*context)
> > +{
> > +     struct notifier_block lenovo_wmi_om_notifier_block =3D {
> > +             .notifier_call =3D lenovo_wmi_om_notifier,
> > +     };
> > +     struct component_match *master_match =3D NULL;
> > +     struct lenovo_wmi_om *om;
> > +     int ret;
> > +
> > +     om =3D devm_kzalloc(&wdev->dev, sizeof(*om), GFP_KERNEL);
> > +     if (!om) {
> > +             ret =3D -ENOMEM;
> > +             goto err_exit;
> > +     }
> > +
> > +     om->wdev =3D wdev;
> > +     om->nb =3D lenovo_wmi_om_notifier_block;
>
> Please dont create a separate struct for the notifier block.

I was doing this to get access to priv in _notifier with container_of
as I don't have access to dev/wdev. Is there a better way for me to
get ahold of priv there?

> > +     om->mode =3D SMARTFAN_MODE_CUSTOM; /* fallback */
> > +
> > +     dev_set_drvdata(&wdev->dev, om);
> > +
> > +     ret =3D devm_lenovo_wmi_gz_register_notifier(&wdev->dev, &om->nb)=
;
> > +     if (ret) {
> > +             pr_err("Failed to register notifier_block\n");
> > +             goto err_exit;
> > +     }
> > +
> > +     component_match_add(&wdev->dev, &master_match, lenovo_wmi_cd01_ma=
tch,
> > +                         NULL);
> > +     if (IS_ERR_OR_NULL(master_match)) {
>
> Why are you checking for NULL here too?
>

My understanding was that if no component shows up this would return
NULL and we'd want to abort since we're missing all our data. If it
will just ERR in that case then I can change it to IS_ERR.

> > +             ret =3D -ENOMEM;
> > +             goto err_exit;
> > +     }
> > +
> > +     ret =3D component_master_add_with_match(&wdev->dev,
> > +                                           &lenovo_wmi_om_master_ops,
> > +                                           master_match);
> > +     if (ret < 0) {
> > +             dev_err(&wdev->dev, "Master comp add failed %d\n", ret);
> > +             goto err_exit;
> > +     }
> > +
> > +     return 0;
> > +err_exit:
> > +     kfree(om);
>
> devm_kfree() already takes care of that, please remove.
>
> > +     return ret;
> > +}
> > +
> > +static void lenovo_wmi_other_remove(struct wmi_device *wdev)
> > +{
> > +     struct lenovo_wmi_om *om =3D dev_get_drvdata(&wdev->dev);
> > +
> > +     kset_unregister(om->fw_attr_kset);
> > +     device_destroy(&firmware_attributes_class, MKDEV(0, 0));
>
> Please use device_unregister() instead.
>

Acked

> > +     component_master_del(&wdev->dev, &lenovo_wmi_om_master_ops);
>
> Please call this first before removing the firmware attribute kset and de=
vice.
>

Acked

> > +}
> > +
> > +static const struct wmi_device_id lenovo_wmi_other_id_table[] =3D {
> > +     { LENOVO_OTHER_METHOD_GUID, NULL },
> > +     {}
> > +};
> > +
> > +static struct wmi_driver lenovo_wmi_other_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "lenovo_wmi_other",
> > +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +     },
> > +     .id_table =3D lenovo_wmi_other_id_table,
> > +     .probe =3D lenovo_wmi_other_probe,
> > +     .remove =3D lenovo_wmi_other_remove,
> > +     .no_singleton =3D true,
> > +};
> > +
> > +module_wmi_driver(lenovo_wmi_other_driver);
> > +
> > +MODULE_IMPORT_NS("CAPDATA_WMI");
> > +MODULE_IMPORT_NS("GZ_WMI");
> > +MODULE_IMPORT_NS("LENOVO_WMI");
> > +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_other_id_table);
> > +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> > +MODULE_DESCRIPTION("Lenovo Other Mode WMI Driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/platform/x86/lenovo-wmi.h b/drivers/platform/x86/l=
enovo-wmi.h
> > index 07fa67ed89d6..40b6418fbf02 100644
> > --- a/drivers/platform/x86/lenovo-wmi.h
> > +++ b/drivers/platform/x86/lenovo-wmi.h
> > @@ -61,6 +61,19 @@ struct capdata01 {
> >       u32 max_value;
> >   };
> >
> > +/* other method structs */
> > +struct lenovo_wmi_om {
> > +     struct component_master_ops *ops;
> > +     struct lenovo_wmi_cd01 *cd01;
> > +     struct capdata01 **capdata;
> > +     struct device *fw_attr_dev;
> > +     struct kset *fw_attr_kset;
> > +     struct notifier_block nb;
> > +     struct wmi_device *wdev;
> > +     enum thermal_mode mode;
> > +     int instance_count;
> > +};
>
> Please only pass *cd01 to the components and make this struct private.
>

Acked

> Thanks,
> Armin Wolf
>
> > +
> >   /* wmidev_evaluate_method helper functions */
> >   int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 insta=
nce,
> >                                   u32 method_id, u32 arg0, u32 arg1,

