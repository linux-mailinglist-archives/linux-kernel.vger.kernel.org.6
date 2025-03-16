Return-Path: <linux-kernel+bounces-563066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75CBA63692
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD6116E4D7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F121A3A80;
	Sun, 16 Mar 2025 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtxinjFO"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66143155A21;
	Sun, 16 Mar 2025 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742144435; cv=none; b=VUbY6FP4r8MpnPTylnAxUt1IilGw6z7ZVZLMoyUBqyFoKr76JUIuMwbZl2O/x6kuf5Z4cE2MXAU91E+3LhnkJO3UDYzQzJ4cGGeQQ/u49STaTZ1364dqEubvzD3QGVD7CqKNUt1ULSdGs5a//UKLmEiw2yXKhcd9AcrHlo16rls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742144435; c=relaxed/simple;
	bh=NdpxTQrqwCj7l2j4hP4cG3/7Am28YTj1Z+ZPyht0pkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ko14eFJW8OrX0TZ1R6pcrw+ZeTst9cpDYZ+JvkB31zAMqWfsiVxk4Of7BAB0yFSSdmZ+tnX5oWMDzGhtQsNt8ytW/ukHMLk3QF+4BAa81g+bRCDnpq1odL532lkyLeVHIHR2XjrC8V63uL8Z8CVL3gkkO8mBtHgxCk/DJ+y0iDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtxinjFO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e1b11859a7so12301116d6.1;
        Sun, 16 Mar 2025 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742144432; x=1742749232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYk6uEZ1vOWL1Bv1a42RvMwV0QviiksYG5xq3x77f3w=;
        b=FtxinjFOzfmyFMuf/QNrHJD/DHN57oMfSm1nlHREJWct3kil5w1j0Mq5ooNnDwZY38
         8Cs+pinDK1Ov4BGDH2hAHkvnmP1nEmwKzpNqwmBGGXiPCpqzzGFz7f6R5xzcHH4LougK
         eDinmDnlM2JkQSBJTl9uahJKeCuhVw1bYFhiZBc4DAJwnJwc8IsumVbxZhWZt+6aNBUs
         +ZdcJfUX89vZ8eKX7aTs/GwOOauJi7gePQzTZgj3Tb9yznHlZ2oiV8QTbJSEif77jHTs
         Lhc8hRoSLJ6IfywF3t7ey8EvsncKjPhD4oXY3UDPzxTHovjOMoQH9t8f5qYgGsCyaN9F
         KvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742144432; x=1742749232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYk6uEZ1vOWL1Bv1a42RvMwV0QviiksYG5xq3x77f3w=;
        b=JEsP6MTAT9n6m1cD6XntsEILNk3CrxXrY3r3Ee9Z/quW9QoNAwv6dH7wlnuqxEioLH
         eZnYqlrEayTSlTa/DGyXIMbotSSb/AeRKqFyJXQQdJIc9ZRqCU1B0qzhqm9a+LpDuIA6
         iG2lPNkoTJILG9qIg66bmZ8yX98UtF5rgcKD6qW1XGa8mdC+EZVpnu1SdcqTdISNyOOC
         qKTBRYNajVz14CxWD5qlNQVSXUwtny92mzAJei1gzMCQbOnzeXSlqfZp/WFzS8Sf0Ll/
         Z2jtF0WUs3RplRhuEwxlyE1CWdXU8TpkhYx04no86u2U/OWW6ErhwJVXlFfM3SbzCCUN
         RAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeN+7gk2/3uS+wwBo7hSJs32Mise7tvi9jGWEgwEE18OWqN9uNRZ9A8iIHc8begxuALIEf7MNizsuTfBrJ@vger.kernel.org, AJvYcCWzsrA/sTOHfNcfsvrD75UMNmd5j6DcFhQ/rQVuZ6Y91+E1BABoQPTDaIjcuQ1pc4hFM1BwYXybP+lc8BeJA2NWZhGeyw==@vger.kernel.org, AJvYcCXzLiowVkjlsLT5iWB2F70iimZ6qYXZH9xixczBtS583lAmIHDx+Iil9cW4v1YsfB0eSVIFU69gPIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbd9oVMZq7AItXpvPHy86eS9boG00jgsrNQQrmaFxZwqr/gWRr
	Uc+3dPCaV5rJMx4ZWfhrHMFWO1XkLvS3kyMuoo9NPHKDPjX0HyizvgQ8pDa70hKgszjjRTMWdrq
	H+9XN9RCDvpAZPS1qr/SLi+kDiEw=
X-Gm-Gg: ASbGnctIrwzPDhqoD3ho7yh2k9DmF1dxvFY8EXWGYgXGzLKIXFDi1wnkjZ1MeRqg3m0
	DjfcHd7EgZE1JffEbpWhNVUcrTlwWsAKsxFdFjMdUK2Tw+57dszSE9TvkHrqfRu1onoJX23xcOL
	Mn/GH/oI55cGh9Qu8Q24jVGF0nkV0=
X-Google-Smtp-Source: AGHT+IHmBRk7ohDmSZGwLReqoceOznVGyO+yr/LvUV4TDJfjawwbRK4LhOeE0CapeF57j/CHPnaobZ2LvPWDSt+o8cY=
X-Received: by 2002:a05:6214:629:b0:6e8:8e10:424d with SMTP id
 6a1803df08f44-6eaeab03342mr123102176d6.41.1742144432071; Sun, 16 Mar 2025
 10:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225220037.16073-1-derekjohn.clark@gmail.com>
 <20250225220037.16073-4-derekjohn.clark@gmail.com> <8605fff9-0fac-45e6-a5ce-a3b04fe81b9f@gmx.de>
 <CAFqHKTkjvd96P5WQPnyJYUNky3FOXT1gLOmFM6vFa7NGR2t8gA@mail.gmail.com> <e75f2513-fe24-4de5-aa90-6dd6e8a12cee@gmx.de>
In-Reply-To: <e75f2513-fe24-4de5-aa90-6dd6e8a12cee@gmx.de>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Sun, 16 Mar 2025 10:00:21 -0700
X-Gm-Features: AQ5f1JrkRpzqLot_AU6TKBRYA3GAwF4jtJuRKs475Qcx7PdWY34kOCMmGMUztDg
Message-ID: <CAFqHKT=e1hzGjkiEZ_0XF3oj1u-bH16rp0zv19snjY0X7W+0pg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] platform/x86: Add Lenovo Capability Data 01 WMI Driver
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

On Tue, Mar 11, 2025 at 1:34=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 10.03.25 um 23:26 schrieb Derek John Clark:
>
> > On Fri, Mar 7, 2025 at 3:05=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
> >> Am 25.02.25 um 22:59 schrieb Derek J. Clark:
> >>
> >>> Adds lenovo-wmi-capdata01.c which provides a driver for the
> >>> LENOVO_CAPABILITY_DATA_01 WMI data block that comes on "Other Mode"
> >>> enabled hardware. Provides an interface for querying if a given
> >>> attribute is supported by the hardware, as well as its default_value,
> >>> max_value, min_value, and step increment.
> >>> v3:
> >>> - Add as component to lenovo-wmi-other driver.
> >>> v2:
> >>> - Use devm_kmalloc to ensure driver can be instanced, remove global
> >>>     reference.
> >>> - Ensure reverse Christmas tree for all variable declarations.
> >>> - Remove extra whitespace.
> >>> - Use guard(mutex) in all mutex instances, global mutex.
> >>> - Use pr_fmt instead of adding the driver name to each pr_err.
> >>> - Remove noisy pr_info usage.
> >>> - Rename capdata_wmi to lenovo_wmi_cd01_priv and cd01_wmi to priv.
> >>> - Use list to get the lenovo_wmi_cd01_priv instance in
> >>>     lenovo_wmi_capdata01_get as none of the data provided by the macr=
os
> >>>     that will use it can pass a member of the struct for use in
> >>>     container_of.
> >>>
> >>> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> >>> ---
> >>>    MAINTAINERS                                 |   1 +
> >>>    drivers/platform/x86/Kconfig                |   5 +
> >>>    drivers/platform/x86/Makefile               |   1 +
> >>>    drivers/platform/x86/lenovo-wmi-capdata01.c | 140 ++++++++++++++++=
++++
> >>>    drivers/platform/x86/lenovo-wmi.h           |  19 +++
> >>>    5 files changed, 166 insertions(+)
> >>>    create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index cf7f4fce1a25..f6d3e79e50ce 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -13157,6 +13157,7 @@ L:    platform-driver-x86@vger.kernel.org
> >>>    S:  Maintained
> >>>    F:  Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> >>>    F:  Documentation/wmi/devices/lenovo-wmi-other.rst
> >>> +F:   drivers/platform/x86/lenovo-wmi-capdata01.c
> >>>    F:  drivers/platform/x86/lenovo-wmi-gamezone.c
> >>>    F:  drivers/platform/x86/lenovo-wmi.c
> >>>    F:  drivers/platform/x86/lenovo-wmi.h
> >>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kcon=
fig
> >>> index 875822e6bd65..56336dc3c2d0 100644
> >>> --- a/drivers/platform/x86/Kconfig
> >>> +++ b/drivers/platform/x86/Kconfig
> >>> @@ -475,6 +475,11 @@ config LENOVO_WMI_GAMEZONE
> >>>          To compile this driver as a module, choose M here: the modul=
e will
> >>>          be called lenovo-wmi-gamezone.
> >>>
> >>> +config LENOVO_WMI_DATA01
> >>> +     tristate
> >>> +     depends on ACPI_WMI
> >>> +     select LENOVO_WMI
> >>> +
> >>>    config IDEAPAD_LAPTOP
> >>>        tristate "Lenovo IdeaPad Laptop Extras"
> >>>        depends on ACPI
> >>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Mak=
efile
> >>> index 4a7b2d14eb82..be9031bea090 100644
> >>> --- a/drivers/platform/x86/Makefile
> >>> +++ b/drivers/platform/x86/Makefile
> >>> @@ -70,6 +70,7 @@ obj-$(CONFIG_YT2_1380)              +=3D lenovo-yog=
a-tab2-pro-1380-fastcharger.o
> >>>    obj-$(CONFIG_LENOVO_WMI)    +=3D lenovo-wmi.o
> >>>    obj-$(CONFIG_LENOVO_WMI_CAMERA)     +=3D lenovo-wmi-camera.o
> >>>    obj-$(CONFIG_LENOVO_WMI_GAMEZONE)   +=3D lenovo-wmi-gamezone.o
> >>> +obj-$(CONFIG_LENOVO_WMI_DATA01)      +=3D lenovo-wmi-capdata01.o
> >>>
> >>>    # Intel
> >>>    obj-y                               +=3D intel/
> >>> diff --git a/drivers/platform/x86/lenovo-wmi-capdata01.c b/drivers/pl=
atform/x86/lenovo-wmi-capdata01.c
> >>> new file mode 100644
> >>> index 000000000000..0fe156d5d770
> >>> --- /dev/null
> >>> +++ b/drivers/platform/x86/lenovo-wmi-capdata01.c
> >>> @@ -0,0 +1,140 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-or-later
> >>> +/*
> >>> + * LENOVO_CAPABILITY_DATA_01 WMI data block driver. This interface p=
rovides
> >>> + * information on tunable attributes used by the "Other Mode" WMI in=
terface,
> >>> + * including if it is supported by the hardware, the default_value, =
max_value,
> >>> + * min_value, and step increment.
> >>> + *
> >>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
> >> 2025
> > Acked for all as Mario suggested.
> >
> >>> + */
> >>> +
> >>> +#include <linux/cleanup.h>
> >>> +#include <linux/component.h>
> >>> +#include <linux/container_of.h>
> >>> +#include <linux/device.h>
> >>> +#include <linux/gfp_types.h>
> >>> +#include <linux/types.h>
> >>> +#include <linux/wmi.h>
> >>> +#include "lenovo-wmi.h"
> >>> +
> >>> +/* Interface GUIDs */
> >>> +#define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3=
BE018154"
> >>> +
> >>> +static int lenovo_cd01_component_bind(struct device *cd01_dev,
> >>> +                                   struct device *om_dev, void *data=
)
> >>> +{
> >>> +     struct lenovo_wmi_cd01 *cd01 =3D dev_get_drvdata(cd01_dev);
> >>> +     struct lenovo_wmi_om *om =3D dev_get_drvdata(om_dev);
> >> Why not using the *data pointer to pass the cd01 data? This way the ca=
pdata driver
> >> does not need to know the structure of the private data of the lenovo-=
wmi-other driver.
> >>
> > I can do that, sure. Seems preferable TBH as it allows me to call it pr=
iv again.
> >
> >>> +
> >>> +     om->cd01 =3D cd01;
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static void lenovo_cd01_component_unbind(struct device *cd01_dev,
> >>> +                                      struct device *om_dev, void *d=
ata)
> >>> +
> >>> +{
> >>> +     struct wmi_device *om_wdev =3D
> >>> +             container_of(om_dev, struct wmi_device, dev);
> >>> +     struct lenovo_wmi_om *om =3D
> >>> +             container_of(&om_wdev, struct lenovo_wmi_om, wdev);
> >>> +
> >>> +     om->cd01 =3D NULL;
> >> I think this is unnecessary, please remove the unbind callback.
> >>
> > Acked.
> >
> >>> +}
> >>> +
> >>> +static const struct component_ops lenovo_cd01_component_ops =3D {
> >>> +     .bind =3D lenovo_cd01_component_bind,
> >>> +     .unbind =3D lenovo_cd01_component_unbind,
> >>> +};
> >>> +
> >>> +static int lenovo_wmi_cd01_setup(struct lenovo_wmi_cd01 *cd01)
> >>> +{
> >>> +     size_t cd_size =3D sizeof(struct capdata01);
> >>> +     int count, idx;
> >>> +
> >>> +     count =3D wmidev_instance_count(cd01->wdev);
> >>> +
> >>> +     cd01->capdata =3D devm_kmalloc_array(&cd01->wdev->dev, (size_t)=
count,
> >>> +                                        sizeof(*cd01->capdata), GFP_=
KERNEL);
> >> Cast to size_t is unnecessary here.
> >>
> > Acked.
> >
> >>> +     if (!cd01->capdata)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     cd01->instance_count =3D count;
> >>> +
> >>> +     for (idx =3D 0; idx < count; idx++) {
> >>> +             union acpi_object *ret_obj __free(kfree) =3D NULL;
> >> I am not sure if the compiler frees ret_obj after each loop iteration.=
 Did you test this?
> >>
> > No, but I'm not sure how I would. I was manually using kfree before
> > but was asked to change to the free macro in an earlier rev.
>
> When loading this driver on you machine you can use kmemleak (https://doc=
s.kernel.org/dev-tools/kmemleak.html)
> to detect memory leaks. If no leaks are detected then ret_obj is likely f=
reed after each iteration and you
> can keep using __free().
>
> Thanks,
> Armin Wolf
>

No leaks were detected. I'll leave this in for v4.

Thanks,
Derek

> >
> >>> +             struct capdata01 *cap_ptr =3D
> >>> +                     devm_kmalloc(&cd01->wdev->dev, cd_size, GFP_KER=
NEL);
> >> Please call devm_kmalloc() on a separate line.
> >>
> > Acked.
> >
> >>> +             ret_obj =3D wmidev_block_query(cd01->wdev, idx);
> >>> +             if (!ret_obj)
> >>> +                     continue;
> >>> +
> >>> +             if (ret_obj->type !=3D ACPI_TYPE_BUFFER)
> >>> +                     continue;
> >>> +
> >>> +             if (ret_obj->buffer.length !=3D cd_size)
> >>> +                     continue;
> >>> +
> >>> +             memcpy(cap_ptr, ret_obj->buffer.pointer,
> >>> +                    ret_obj->buffer.length);
> >> Using devm_kmemdup() would make sense here.
> >>
> > That's a cool function. Ty, I'll use it
> >
> >>> +             cd01->capdata[idx] =3D cap_ptr;
> >>> +     }
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int lenovo_wmi_cd01_probe(struct wmi_device *wdev, const void=
 *context)
> >>> +
> >>> +{
> >>> +     struct lenovo_wmi_cd01 *cd01;
> >>> +     int ret;
> >>> +
> >>> +     cd01 =3D devm_kzalloc(&wdev->dev, sizeof(*cd01), GFP_KERNEL);
> >>> +     if (!cd01)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     cd01->wdev =3D wdev;
> >>> +
> >>> +     ret =3D lenovo_wmi_cd01_setup(cd01);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     dev_set_drvdata(&wdev->dev, cd01);
> >>> +
> >>> +     ret =3D component_add(&wdev->dev, &lenovo_cd01_component_ops);
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +static void lenovo_wmi_cd01_remove(struct wmi_device *wdev)
> >>> +{
> >>> +     component_del(&wdev->dev, &lenovo_cd01_component_ops);
> >>> +}
> >>> +
> >>> +static const struct wmi_device_id lenovo_wmi_cd01_id_table[] =3D {
> >>> +     { LENOVO_CAPABILITY_DATA_01_GUID, NULL },
> >>> +     {}
> >>> +};
> >>> +
> >>> +static struct wmi_driver lenovo_wmi_cd01_driver =3D {
> >>> +     .driver =3D {
> >>> +             .name =3D "lenovo_wmi_cd01",
> >>> +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> >>> +     },
> >>> +     .id_table =3D lenovo_wmi_cd01_id_table,
> >>> +     .probe =3D lenovo_wmi_cd01_probe,
> >>> +     .remove =3D lenovo_wmi_cd01_remove,
> >>> +     .no_singleton =3D true,
> >>> +};
> >>> +
> >>> +int lenovo_wmi_cd01_match(struct device *dev, void *data)
> >>> +{
> >>> +     return dev->driver =3D=3D &lenovo_wmi_cd01_driver.driver;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(lenovo_wmi_cd01_match);
> >> Please put this symbol into a namespace too.
> >>
> > Yes, I noticed the mistake right after I sent the patch.
> >
> >>> +
> >>> +module_wmi_driver(lenovo_wmi_cd01_driver);
> >>> +
> >>> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_cd01_id_table);
> >>> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> >>> +MODULE_DESCRIPTION("Lenovo Capability Data 01 WMI Driver");
> >>> +MODULE_LICENSE("GPL");
> >>> diff --git a/drivers/platform/x86/lenovo-wmi.h b/drivers/platform/x86=
/lenovo-wmi.h
> >>> index 113928b4fc0f..07fa67ed89d6 100644
> >>> --- a/drivers/platform/x86/lenovo-wmi.h
> >>> +++ b/drivers/platform/x86/lenovo-wmi.h
> >>> @@ -45,6 +45,22 @@ enum lenovo_wmi_action {
> >>>        THERMAL_MODE_EVENT =3D 1,
> >>>    };
> >>>
> >>> +/* capdata01 structs */
> >>> +struct lenovo_wmi_cd01 {
> >>> +     struct capdata01 **capdata;
> >>> +     struct wmi_device *wdev;
> >>> +     int instance_count;
> >>> +};
> >>> +
> >>> +struct capdata01 {
> >>> +     u32 id;
> >>> +     u32 supported;
> >>> +     u32 default_value;
> >>> +     u32 step;
> >>> +     u32 min_value;
> >>> +     u32 max_value;
> >>> +};
> >> Please put those struct definitions into a separate header file.
> >>
> > Acked.
> >
> >> Thanks,
> >> Armin Wolf
> >>
> >>> +
> >>>    /* wmidev_evaluate_method helper functions */
> >>>    int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 in=
stance,
> >>>                                    u32 method_id, u32 arg0, u32 arg1,
> >>> @@ -52,6 +68,9 @@ int lenovo_wmidev_evaluate_method_2(struct wmi_devi=
ce *wdev, u8 instance,
> >>>    int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 in=
stance,
> >>>                                    u32 method_id, u32 arg0, u32 *retv=
al);
> >>>
> >>> +/* lenovo_wmi_cd01_driver match function */
> >>> +int lenovo_wmi_cd01_match(struct device *dev, void *data);
> >>> +
> >>>    /* lenovo_wmi_gz_driver notifier functions */
> >>>    int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigne=
d long action,
> >>>                                enum platform_profile_option *profile)=
;

