Return-Path: <linux-kernel+bounces-555228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502E6A5A72A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA44F3A6501
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6FC1F4C95;
	Mon, 10 Mar 2025 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPc1IagY"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D41E8350;
	Mon, 10 Mar 2025 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645586; cv=none; b=eQfjnl4uDHz4trvMlgL40XyqKeiDgc9JB9wMD8/8YRwGMBYUAtE2MaNZNa7Hga46rdTpzowIWSUpYIu5P1QIkeQy70SjDmSbkDIYf6ASy/NlAf7OTgIWd82sscVZMm1dfZE60WbjcFbQaxISLbGx5sUxG2urk3I1iG/ggirKxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645586; c=relaxed/simple;
	bh=QpRmGbvP4X/5heBRLNBD4IuyoJtGMe6MZWjJPqWiqvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dskcr/igJiIQoSpjGVgsKGPGYQq11xfZbI8Giv4DU5J4OlCpDZPaL6XU10QDDpH/xrviYXXg2GkzLWcOhieA5CJ1YECy7syHo5JMPhP2ItMrIcLrAYzT3kA8bpBQY/RF0mpvgdemWX2/JDcIxFtOteZ6QGtHJd0nImioOuapPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPc1IagY; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dd0d09215aso34445396d6.2;
        Mon, 10 Mar 2025 15:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741645583; x=1742250383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hIE+Xy7SXxZm8owgh0LhDSs+jijOnrEORpdJsqvc0I=;
        b=VPc1IagYigz23HkIi3NHhwzlFhStOlm4RefyhTdX5En5Zo6TaLHdN6GIvEh59SRzlz
         OaDBImYq8xWrTZlaHIZ+59UwzDrknfrqbd2InsfrZ1iESM7/mWJO3BZTabfnIL2r+8v+
         UcFsc4ONuZSipENPicxepEqINFG3bYtdwDMMrU2KPHbY4VTYreT5FayaKsA/CLTfC7YU
         qL1jTf1958k9P+453UE9zrbf6JoUhciTg/dwBfa4xNc3xagWrM6r2OV4xKR9Vo8OwY3+
         huCgUH/XjSoz6q26he2POC15/HcidXdhY1YqA/OwQ5LV0UYaoq5HNR5t450SG+T+OkKH
         HY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741645583; x=1742250383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hIE+Xy7SXxZm8owgh0LhDSs+jijOnrEORpdJsqvc0I=;
        b=NYxYUmPTAQya9oIeJYaqZW7ts7h41N6UMaSvouIUCGy/YE0susmdYYjmKk50dhiGY5
         UOyKQtixcpbLNQVdW77X7Ja2A3BQp6fuujON+e2ski5U9+y8udVCrkmszH4ahBt83Koq
         1u8WhrAyrXke+omWs2Uw81/mRPEO4cVf8DSSW0BaeAu5K9jupChwjGVTMRkSLfNkWDH4
         wRCpYy2WICbz+NFneTzY9xYvq081OI5Y8S7Ha4x7OSH+Az/tmlZJhGwV69BQaEPJyqK3
         R4P3n+zpWS5Pkpw/GgeZ+2RpcuHxXy/RAzqp6HGTwiQZ8NyCYkxh60isvi/bnErti0Jj
         jLPA==
X-Forwarded-Encrypted: i=1; AJvYcCUY4YJg6nMbDZZ0ulLz1bzalWm48hO362EFW4Krqbzxh8u4E5YcpAziHbEZ+MIyD8l6IUn+tIDS2FYax+rj@vger.kernel.org, AJvYcCVGixETkXEwzW7Nxujkd1XrGneGMjti2+PbA5xU49nG4Y6r6NbwsWRo6i4BZXFEIwGdQElA3vnQgmLvsMctsm4OtR1v6A==@vger.kernel.org, AJvYcCWJOMkTuc+W5gAWk43GfyPW0neCApctC0W/LJnuF0mOcRScIwSIAsPGJtDuJw5z6R5oFYXfsIBPLL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJmJUqjPuuoAjV5lgUtc6TXRIgC860cZYPQfI3xfDodwm9jk05
	PO+KXv9T5SqVZ1BMLt8kJzctULF3/xYC2UEczClW0h4m3Bw6deLxc4j3HU1a9Sld3sl4zqdMaZ6
	i/G+NdL+ODMS3kgjooOTX4MJ6wUF+CCe4qJY=
X-Gm-Gg: ASbGnct+H7F66nXM/hd+dx0GbI9tBgEXgeMDDE4nWnS8rC0fVRgSgE+57+d5uALrz2U
	lIqSt1nSpdvaeuUHEhc1qUyVu4HeiKfHwjKQH4ZPlGMbzwOfTbxmTv0HalCgBY8S/CW3JNNFYxe
	qeMEGV0LgcqdyUUHBTNi2FWrJEFBY=
X-Google-Smtp-Source: AGHT+IEwwIymUUD1fcd497zAAV4ccCa41xEe0DUhLg3HhDdM/OYa2DrHLk6DmWpVyIhGzSfAdtgNZ08Co4iFeRU60r8=
X-Received: by 2002:ad4:5cae:0:b0:6e8:f940:50af with SMTP id
 6a1803df08f44-6ea3a6ad9aemr19897316d6.44.1741645583605; Mon, 10 Mar 2025
 15:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225220037.16073-1-derekjohn.clark@gmail.com>
 <20250225220037.16073-4-derekjohn.clark@gmail.com> <8605fff9-0fac-45e6-a5ce-a3b04fe81b9f@gmx.de>
In-Reply-To: <8605fff9-0fac-45e6-a5ce-a3b04fe81b9f@gmx.de>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 15:26:12 -0700
X-Gm-Features: AQ5f1Jqm3X2JRrO3_8IG68-hrpg_Sq_5TIwIladiEHYjdIPbWG7tJvlvAq3QgvI
Message-ID: <CAFqHKTkjvd96P5WQPnyJYUNky3FOXT1gLOmFM6vFa7NGR2t8gA@mail.gmail.com>
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

On Fri, Mar 7, 2025 at 3:05=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 25.02.25 um 22:59 schrieb Derek J. Clark:
>
> > Adds lenovo-wmi-capdata01.c which provides a driver for the
> > LENOVO_CAPABILITY_DATA_01 WMI data block that comes on "Other Mode"
> > enabled hardware. Provides an interface for querying if a given
> > attribute is supported by the hardware, as well as its default_value,
> > max_value, min_value, and step increment.
> > v3:
> > - Add as component to lenovo-wmi-other driver.
> > v2:
> > - Use devm_kmalloc to ensure driver can be instanced, remove global
> >    reference.
> > - Ensure reverse Christmas tree for all variable declarations.
> > - Remove extra whitespace.
> > - Use guard(mutex) in all mutex instances, global mutex.
> > - Use pr_fmt instead of adding the driver name to each pr_err.
> > - Remove noisy pr_info usage.
> > - Rename capdata_wmi to lenovo_wmi_cd01_priv and cd01_wmi to priv.
> > - Use list to get the lenovo_wmi_cd01_priv instance in
> >    lenovo_wmi_capdata01_get as none of the data provided by the macros
> >    that will use it can pass a member of the struct for use in
> >    container_of.
> >
> > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > ---
> >   MAINTAINERS                                 |   1 +
> >   drivers/platform/x86/Kconfig                |   5 +
> >   drivers/platform/x86/Makefile               |   1 +
> >   drivers/platform/x86/lenovo-wmi-capdata01.c | 140 +++++++++++++++++++=
+
> >   drivers/platform/x86/lenovo-wmi.h           |  19 +++
> >   5 files changed, 166 insertions(+)
> >   create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cf7f4fce1a25..f6d3e79e50ce 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13157,6 +13157,7 @@ L:    platform-driver-x86@vger.kernel.org
> >   S:  Maintained
> >   F:  Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> >   F:  Documentation/wmi/devices/lenovo-wmi-other.rst
> > +F:   drivers/platform/x86/lenovo-wmi-capdata01.c
> >   F:  drivers/platform/x86/lenovo-wmi-gamezone.c
> >   F:  drivers/platform/x86/lenovo-wmi.c
> >   F:  drivers/platform/x86/lenovo-wmi.h
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 875822e6bd65..56336dc3c2d0 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -475,6 +475,11 @@ config LENOVO_WMI_GAMEZONE
> >         To compile this driver as a module, choose M here: the module w=
ill
> >         be called lenovo-wmi-gamezone.
> >
> > +config LENOVO_WMI_DATA01
> > +     tristate
> > +     depends on ACPI_WMI
> > +     select LENOVO_WMI
> > +
> >   config IDEAPAD_LAPTOP
> >       tristate "Lenovo IdeaPad Laptop Extras"
> >       depends on ACPI
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
> > index 4a7b2d14eb82..be9031bea090 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -70,6 +70,7 @@ obj-$(CONFIG_YT2_1380)              +=3D lenovo-yoga-=
tab2-pro-1380-fastcharger.o
> >   obj-$(CONFIG_LENOVO_WMI)    +=3D lenovo-wmi.o
> >   obj-$(CONFIG_LENOVO_WMI_CAMERA)     +=3D lenovo-wmi-camera.o
> >   obj-$(CONFIG_LENOVO_WMI_GAMEZONE)   +=3D lenovo-wmi-gamezone.o
> > +obj-$(CONFIG_LENOVO_WMI_DATA01)      +=3D lenovo-wmi-capdata01.o
> >
> >   # Intel
> >   obj-y                               +=3D intel/
> > diff --git a/drivers/platform/x86/lenovo-wmi-capdata01.c b/drivers/plat=
form/x86/lenovo-wmi-capdata01.c
> > new file mode 100644
> > index 000000000000..0fe156d5d770
> > --- /dev/null
> > +++ b/drivers/platform/x86/lenovo-wmi-capdata01.c
> > @@ -0,0 +1,140 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * LENOVO_CAPABILITY_DATA_01 WMI data block driver. This interface pro=
vides
> > + * information on tunable attributes used by the "Other Mode" WMI inte=
rface,
> > + * including if it is supported by the hardware, the default_value, ma=
x_value,
> > + * min_value, and step increment.
> > + *
> > + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>
> 2025

Acked for all as Mario suggested.

> > + */
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/component.h>
> > +#include <linux/container_of.h>
> > +#include <linux/device.h>
> > +#include <linux/gfp_types.h>
> > +#include <linux/types.h>
> > +#include <linux/wmi.h>
> > +#include "lenovo-wmi.h"
> > +
> > +/* Interface GUIDs */
> > +#define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE=
018154"
> > +
> > +static int lenovo_cd01_component_bind(struct device *cd01_dev,
> > +                                   struct device *om_dev, void *data)
> > +{
> > +     struct lenovo_wmi_cd01 *cd01 =3D dev_get_drvdata(cd01_dev);
> > +     struct lenovo_wmi_om *om =3D dev_get_drvdata(om_dev);
>
> Why not using the *data pointer to pass the cd01 data? This way the capda=
ta driver
> does not need to know the structure of the private data of the lenovo-wmi=
-other driver.
>

I can do that, sure. Seems preferable TBH as it allows me to call it priv a=
gain.

> > +
> > +     om->cd01 =3D cd01;
> > +     return 0;
> > +}
> > +
> > +static void lenovo_cd01_component_unbind(struct device *cd01_dev,
> > +                                      struct device *om_dev, void *dat=
a)
> > +
> > +{
> > +     struct wmi_device *om_wdev =3D
> > +             container_of(om_dev, struct wmi_device, dev);
> > +     struct lenovo_wmi_om *om =3D
> > +             container_of(&om_wdev, struct lenovo_wmi_om, wdev);
> > +
> > +     om->cd01 =3D NULL;
>
> I think this is unnecessary, please remove the unbind callback.
>

Acked.

> > +}
> > +
> > +static const struct component_ops lenovo_cd01_component_ops =3D {
> > +     .bind =3D lenovo_cd01_component_bind,
> > +     .unbind =3D lenovo_cd01_component_unbind,
> > +};
> > +
> > +static int lenovo_wmi_cd01_setup(struct lenovo_wmi_cd01 *cd01)
> > +{
> > +     size_t cd_size =3D sizeof(struct capdata01);
> > +     int count, idx;
> > +
> > +     count =3D wmidev_instance_count(cd01->wdev);
> > +
> > +     cd01->capdata =3D devm_kmalloc_array(&cd01->wdev->dev, (size_t)co=
unt,
> > +                                        sizeof(*cd01->capdata), GFP_KE=
RNEL);
>
> Cast to size_t is unnecessary here.
>

Acked.

> > +     if (!cd01->capdata)
> > +             return -ENOMEM;
> > +
> > +     cd01->instance_count =3D count;
> > +
> > +     for (idx =3D 0; idx < count; idx++) {
> > +             union acpi_object *ret_obj __free(kfree) =3D NULL;
>
> I am not sure if the compiler frees ret_obj after each loop iteration. Di=
d you test this?
>

No, but I'm not sure how I would. I was manually using kfree before
but was asked to change to the free macro in an earlier rev.

> > +             struct capdata01 *cap_ptr =3D
> > +                     devm_kmalloc(&cd01->wdev->dev, cd_size, GFP_KERNE=
L);
>
> Please call devm_kmalloc() on a separate line.
>

Acked.

> > +             ret_obj =3D wmidev_block_query(cd01->wdev, idx);
> > +             if (!ret_obj)
> > +                     continue;
> > +
> > +             if (ret_obj->type !=3D ACPI_TYPE_BUFFER)
> > +                     continue;
> > +
> > +             if (ret_obj->buffer.length !=3D cd_size)
> > +                     continue;
> > +
> > +             memcpy(cap_ptr, ret_obj->buffer.pointer,
> > +                    ret_obj->buffer.length);
>
> Using devm_kmemdup() would make sense here.
>

That's a cool function. Ty, I'll use it

> > +             cd01->capdata[idx] =3D cap_ptr;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int lenovo_wmi_cd01_probe(struct wmi_device *wdev, const void *=
context)
> > +
> > +{
> > +     struct lenovo_wmi_cd01 *cd01;
> > +     int ret;
> > +
> > +     cd01 =3D devm_kzalloc(&wdev->dev, sizeof(*cd01), GFP_KERNEL);
> > +     if (!cd01)
> > +             return -ENOMEM;
> > +
> > +     cd01->wdev =3D wdev;
> > +
> > +     ret =3D lenovo_wmi_cd01_setup(cd01);
> > +     if (ret)
> > +             return ret;
> > +
> > +     dev_set_drvdata(&wdev->dev, cd01);
> > +
> > +     ret =3D component_add(&wdev->dev, &lenovo_cd01_component_ops);
> > +
> > +     return ret;
> > +}
> > +
> > +static void lenovo_wmi_cd01_remove(struct wmi_device *wdev)
> > +{
> > +     component_del(&wdev->dev, &lenovo_cd01_component_ops);
> > +}
> > +
> > +static const struct wmi_device_id lenovo_wmi_cd01_id_table[] =3D {
> > +     { LENOVO_CAPABILITY_DATA_01_GUID, NULL },
> > +     {}
> > +};
> > +
> > +static struct wmi_driver lenovo_wmi_cd01_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "lenovo_wmi_cd01",
> > +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +     },
> > +     .id_table =3D lenovo_wmi_cd01_id_table,
> > +     .probe =3D lenovo_wmi_cd01_probe,
> > +     .remove =3D lenovo_wmi_cd01_remove,
> > +     .no_singleton =3D true,
> > +};
> > +
> > +int lenovo_wmi_cd01_match(struct device *dev, void *data)
> > +{
> > +     return dev->driver =3D=3D &lenovo_wmi_cd01_driver.driver;
> > +}
> > +EXPORT_SYMBOL_GPL(lenovo_wmi_cd01_match);
>
> Please put this symbol into a namespace too.
>

Yes, I noticed the mistake right after I sent the patch.

> > +
> > +module_wmi_driver(lenovo_wmi_cd01_driver);
> > +
> > +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_cd01_id_table);
> > +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> > +MODULE_DESCRIPTION("Lenovo Capability Data 01 WMI Driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/platform/x86/lenovo-wmi.h b/drivers/platform/x86/l=
enovo-wmi.h
> > index 113928b4fc0f..07fa67ed89d6 100644
> > --- a/drivers/platform/x86/lenovo-wmi.h
> > +++ b/drivers/platform/x86/lenovo-wmi.h
> > @@ -45,6 +45,22 @@ enum lenovo_wmi_action {
> >       THERMAL_MODE_EVENT =3D 1,
> >   };
> >
> > +/* capdata01 structs */
> > +struct lenovo_wmi_cd01 {
> > +     struct capdata01 **capdata;
> > +     struct wmi_device *wdev;
> > +     int instance_count;
> > +};
> > +
> > +struct capdata01 {
> > +     u32 id;
> > +     u32 supported;
> > +     u32 default_value;
> > +     u32 step;
> > +     u32 min_value;
> > +     u32 max_value;
> > +};
>
> Please put those struct definitions into a separate header file.
>

Acked.

> Thanks,
> Armin Wolf
>
> > +
> >   /* wmidev_evaluate_method helper functions */
> >   int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 insta=
nce,
> >                                   u32 method_id, u32 arg0, u32 arg1,
> > @@ -52,6 +68,9 @@ int lenovo_wmidev_evaluate_method_2(struct wmi_device=
 *wdev, u8 instance,
> >   int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 insta=
nce,
> >                                   u32 method_id, u32 arg0, u32 *retval)=
;
> >
> > +/* lenovo_wmi_cd01_driver match function */
> > +int lenovo_wmi_cd01_match(struct device *dev, void *data);
> > +
> >   /* lenovo_wmi_gz_driver notifier functions */
> >   int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigned l=
ong action,
> >                               enum platform_profile_option *profile);

