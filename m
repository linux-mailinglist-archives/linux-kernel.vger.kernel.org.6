Return-Path: <linux-kernel+bounces-535236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75045A47070
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744F63A61BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2464427005B;
	Thu, 27 Feb 2025 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+2O+jGA"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE11BC41;
	Thu, 27 Feb 2025 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616964; cv=none; b=A2zESLtq4ChwBejztbhrzmeAAtMfcXOf6MHDQ6bLNacBwtim1OXRV8BxE4gQm4AScRxsoE8+Vde1AQ5JfEd0VyFQ6Ol2dPwnsZylyr38LzfhkxcTSKHspbCXoiWm/fXqkAsrM89fPm/Omp/YDNqHkk2FNCss1Z063cjsHeRFhzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616964; c=relaxed/simple;
	bh=+3dQT/aRswMjN1dJ0eacrnc0LdQrN+mv4UvYJatnB8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/qVO5QoqvjXYBgnRPANQWgtlymDy4gRrQ9GgwLgcuHMmtm25ETjhcsJTU02FjSuQoqKiyTTC+W0pn2YNpusoHBUEyDwDKXlR4cIoABXyf/nTHmYls8iX6ui8MkKCryTvj6BqLq+wDJKdmlbwokXBFYTMK7q/pPhfUEHw5s09ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+2O+jGA; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be8f28172dso37516085a.3;
        Wed, 26 Feb 2025 16:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740616961; x=1741221761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5B9ytgPFuP5pQBxBoUpkMvke0cQp+39ToawJVjcZfM=;
        b=l+2O+jGA2/IyfMPGWhFaVjfspj6DmWxcXRfydGeCyZtmQuMrFcLOnMq0u1Fgd/2F8Q
         4r6ZN4QnTA+vJMlyw9fk+VziG3GOndJuEZ2ERF6kDoPJ7wHRo+1NZXpDHD7wJY/jNcnl
         g5STNlYRockV0viXCa+SCYp/3+lhWPihK99JJWKdY/niWCRUjcI5wHNb2cVXHh3m5G0C
         EBGBO4DVapgy+/7i/tttIiK6j5E57ZeFUya2hlo0pXoT0r6GmDOY3lqAZVCdrZ44cJT6
         i3ho3e9VWnjff38Q69DP2M9Dv7WxPQpJatU9b4Z6wmYAfkambiSO1Lxi4BdnucnL9f9W
         T3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616961; x=1741221761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5B9ytgPFuP5pQBxBoUpkMvke0cQp+39ToawJVjcZfM=;
        b=oQzLw5+vCO71u2mLjc6raLGZ29pfzFLB7F+DnZ1aVtrW2DzGzr6WCoDUk73nMKmNhf
         USOIXhoiK6tJeyKXOm6hBHVpVI3EmAgZsaMovyv2SHVRGcf1JifMmic/oeeSRzoF2MJs
         c1GGvPyhQA1LIDgBmF3xozSMOPDwn/6feEdEwYwpnD3AX0G4PT9/0D+/O6NY+/FiNGiU
         pJcpx8dENvFVAiCC+FN/YGJAQUmvWpBGUYEqOLjtkXrer8eZhezpX22UuI+P8F1mmWge
         ZZOzsYsOmtOPhxx6b0//GrmdZq1Fv8kkgi7HXbSLPlyv8iQt7PZl7uj/Sp2ZKTSW7U1V
         bl6w==
X-Forwarded-Encrypted: i=1; AJvYcCUVdf/7WVW4GoVovklewxFSUIDFC6uiHHNi2VO93HokGfTXoP6WTRgGTYjae2syiEJPvcjv3TczTJ4=@vger.kernel.org, AJvYcCUdakw6/ngEtGXB4f9IWLZ1qNhwEl9jxFikgKHLzXN2YeA313EwcaKs62U5dlOpMT4+iX13iHwsGb2TCetBR527FPJdLA==@vger.kernel.org, AJvYcCWvfzt3FUR3u5Vq0+UhaETT15Hj7ppamb/+X1f4IpSpBVhgxc8gMVzlOqF0366qmfBKc6WGCO0UdKn+5x14@vger.kernel.org
X-Gm-Message-State: AOJu0YzCcmzOMT9lvxybbPDCVU522LasbGAAKDnFDySUIybbc2E8IU4P
	7WCudC94m9O8WPh1rLQCk14Gb0GxQVuB8/Oip6t0ojziZ+OO4g3cDt09VFojKGSHRF+kdP2ndRk
	aDoHkuXwg1sh1VTD4cf+u/HqFpMk=
X-Gm-Gg: ASbGncvTeEl9CVcfWuJRWnpmIsPwYQ1kvujhHzG9aoqeLccfWIfnDb0M2ioKYUhIscL
	H86Pn5PKIANLVhOvN6zqyzaWaLTLnd29yE/XI77xfdGiW105tEKxFR/8T5MprN4VlfeAlPoDoj6
	H1nmNqMw0y
X-Google-Smtp-Source: AGHT+IH+898E/46i7aoMsWQfLCP8RjWUGlt2aXxp8CWX91FAvnZyLzKI+I0+pxP6I1weoSR0GWH6RA/lRDD8XSWJXxE=
X-Received: by 2002:a05:6214:21a9:b0:6e6:a60f:24cf with SMTP id
 6a1803df08f44-6e886899494mr88858666d6.19.1740616961249; Wed, 26 Feb 2025
 16:42:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225220037.16073-1-derekjohn.clark@gmail.com>
 <20250225220037.16073-3-derekjohn.clark@gmail.com> <ea4a8b87-e3d7-4550-bf18-ee21ed621276@kernel.org>
In-Reply-To: <ea4a8b87-e3d7-4550-bf18-ee21ed621276@kernel.org>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Wed, 26 Feb 2025 16:42:30 -0800
X-Gm-Features: AQ5f1JqouFJijAHYSOC7K0Dqc-BWUMPFnrt_8oiR28tM93G6iHk_HCmhkj_34W0
Message-ID: <CAFqHKTnzXYv368pVbnJO92ndo6P4e-M2zejsS7zX9gZKBSOJvQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] platform/x86: Add Lenovo Gamezone WMI Driver
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>, Luke Jones <luke@ljones.dev>, 
	Xino Ni <nijs1@lenovo.com>, Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, "Cody T . -H . Chiu" <codyit@gmail.com>, 
	John Martens <johnfanv2@gmail.com>, platform-driver-x86@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:41=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> On 2/25/2025 13:59, Derek J. Clark wrote:
> > Adds lenovo-wmi-gamezone.c which provides a driver for the Lenovo
> > Gamezone WMI interface that comes on Lenovo "Gaming Series" hardware.
> > Provides ACPI platform profiles over WMI.
> >
> > Adds lenovo-wmi.h and lenovo-wmi.c which provide helper functions for
> > wmidev_evaluate_method as well as prototypes for exported functions.
> > v3:
> > - Use notifier chain to report platform profile changes to any
> >    subscribed drivers.
> > - Adds THERMAL_MODE_EVENT GUID and .notify function to trigger notifier
> >    chain.
> > - Adds support for Extreme Mode profile on supported hardware, as well
> >    as a DMI quirk table for some devices that report extreme mode versi=
on
> >    support but so not have it fully implemented.
> > - Update to include recent changes to platform-profile.
> > v2:
> > - Use devm_kmalloc to ensure driver can be instanced, remove global
> >    reference.
> > - Ensure reverse Christmas tree for all variable declarations.
> > - Remove extra whitespace.
> > - Use guard(mutex) in all mutex instances, global mutex.
> > - Use pr_fmt instead of adding the driver name to each pr_err.
> > - Remove noisy pr_info usage.
> > - Rename gamezone_wmi to lenovo_wmi_gz_priv and gz_wmi to priv.
> > - Remove GZ_WMI symbol exporting.
> >
> > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > ---
> >   MAINTAINERS                                |   3 +
> >   drivers/platform/x86/Kconfig               |  16 +
> >   drivers/platform/x86/Makefile              |   2 +
> >   drivers/platform/x86/lenovo-wmi-gamezone.c | 374 ++++++++++++++++++++=
+
> >   drivers/platform/x86/lenovo-wmi.c          |  77 +++++
> >   drivers/platform/x86/lenovo-wmi.h          |  62 ++++
> >   6 files changed, 534 insertions(+)
> >   create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
> >   create mode 100644 drivers/platform/x86/lenovo-wmi.c
> >   create mode 100644 drivers/platform/x86/lenovo-wmi.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e20c32b3c480..cf7f4fce1a25 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13157,6 +13157,9 @@ L:    platform-driver-x86@vger.kernel.org
> >   S:  Maintained
> >   F:  Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> >   F:  Documentation/wmi/devices/lenovo-wmi-other.rst
> > +F:   drivers/platform/x86/lenovo-wmi-gamezone.c
> > +F:   drivers/platform/x86/lenovo-wmi.c
> > +F:   drivers/platform/x86/lenovo-wmi.h
> >
> >   LETSKETCH HID TABLET DRIVER
> >   M:  Hans de Goede <hdegoede@redhat.com>
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 7e20a58861eb..875822e6bd65 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -459,6 +459,22 @@ config IBM_RTL
> >        state =3D 0 (BIOS SMIs on)
> >        state =3D 1 (BIOS SMIs off)
> >
> > +config LENOVO_WMI
> > +     tristate
> > +     depends on ACPI_WMI
> > +
> > +config LENOVO_WMI_GAMEZONE
> > +     tristate "Lenovo GameZone WMI Driver"
> > +     depends on ACPI_WMI
> > +     select ACPI_PLATFORM_PROFILE
> > +     select LENOVO_WMI
> > +     help
> > +       Say Y here if you have a WMI aware Lenovo Legion device and wou=
ld like to use the
> > +       platform-profile firmware interface to manage power usage.
>
> Power limits; not usage right?
>

We could use that verbiage if desired, sure.

> > +
> > +       To compile this driver as a module, choose M here: the module w=
ill
> > +       be called lenovo-wmi-gamezone.
> > +
> >   config IDEAPAD_LAPTOP
> >       tristate "Lenovo IdeaPad Laptop Extras"
> >       depends on ACPI
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
> > index 5f6307246e69..4a7b2d14eb82 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -67,7 +67,9 @@ obj-$(CONFIG_THINKPAD_ACPI) +=3D thinkpad_acpi.o
> >   obj-$(CONFIG_THINKPAD_LMI)  +=3D think-lmi.o
> >   obj-$(CONFIG_YOGABOOK)              +=3D lenovo-yogabook.o
> >   obj-$(CONFIG_YT2_1380)              +=3D lenovo-yoga-tab2-pro-1380-fa=
stcharger.o
> > +obj-$(CONFIG_LENOVO_WMI)     +=3D lenovo-wmi.o
> >   obj-$(CONFIG_LENOVO_WMI_CAMERA)     +=3D lenovo-wmi-camera.o
> > +obj-$(CONFIG_LENOVO_WMI_GAMEZONE)    +=3D lenovo-wmi-gamezone.o
> >
> >   # Intel
> >   obj-y                               +=3D intel/
> > diff --git a/drivers/platform/x86/lenovo-wmi-gamezone.c b/drivers/platf=
orm/x86/lenovo-wmi-gamezone.c
> > new file mode 100644
> > index 000000000000..d5329fecba47
> > --- /dev/null
> > +++ b/drivers/platform/x86/lenovo-wmi-gamezone.c
> > @@ -0,0 +1,374 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Lenovo GameZone WMI interface driver. The GameZone WMI interface pr=
ovides
> > + * platform profile and fan curve settings for devices that fall under=
 the
> > + * "Gaming Series" of Lenovo Legion devices.
> > + *
> > + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>
> I know you started in 2024, but should be 2025 now right?
>
Good point. Acked

> > + */
> > +
> > +#include "linux/container_of.h"
> > +#include "linux/printk.h"
>
> Do you need these two?  If so, please sort them into the right place.
> Also shouldn't they be <linux/$foo.h>?

I don't, my LSP likes to bring them in. I'll be more diligent. Thanks.

> > +#include <linux/cleanup.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/dmi.h>
> > +#include <linux/list.h>
> > +#include <linux/notifier.h>
> > +#include <linux/platform_profile.h>
> > +#include <linux/types.h>
> > +#include <linux/wmi.h>
> > +#include "lenovo-wmi.h"
> > +
> > +/* Interface GUIDs */
> > +#define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
> > +#define THERMAL_MODE_EVENT_GUID "D320289E-8FEA-41E0-86F9-911D83151B5F"
> > +
> > +/* Method IDs */
> > +#define WMI_METHOD_ID_SMARTFAN_SUPP 43 /* IsSupportSmartFan */
> > +#define WMI_METHOD_ID_SMARTFAN_SET 44 /* SetSmartFanMode */
> > +#define WMI_METHOD_ID_SMARTFAN_GET 45 /* GetSmartFanMode */
> > +
> > +enum lenovo_wmi_gz_type {
> > +     GAMEZONE_FULL =3D 1,
> > +     THERMAL_MODE,
> > +};
> > +
> > +#define GAMEZONE_WMI_DEVICE(guid, type)                              \
> > +     .guid_string =3D (guid), .context =3D &(enum lenovo_wmi_gz_type) =
\
> > +     {                                                            \
> > +             type                                                 \
> > +     }
> > +
> > +static BLOCKING_NOTIFIER_HEAD(gz_chain_head);
> > +static DEFINE_MUTEX(gz_chain_mutex);
> > +
> > +struct lenovo_wmi_gz_priv {
> > +     enum platform_profile_option current_profile;
> > +     struct wmi_device *wdev;
> > +     bool extreme_supported;
> > +     struct device *ppdev; /*platform profile device */
> > +     enum lenovo_wmi_gz_type type;
> > +     struct blocking_notifier_head nhead;
> > +};
> > +
> > +struct quirk_entry {
> > +     bool extreme_supported;
> > +};
> > +
> > +static struct quirk_entry quirk_no_extreme_bug =3D {
>
> Is this a bug?  You made it sound like in the documentation patch it's
> just a legacy device.

Yes. I gave an overview to this in my response to your reply in 1/4,
but I'll point out the relevant code below for clarity.

> > +     .extreme_supported =3D false,
> > +};
> > +
> > +/* Platform Profile Methods & Setup */
> > +static int
> > +lenovo_wmi_gz_platform_profile_supported(struct lenovo_wmi_gz_priv *pr=
iv,
> > +                                      int *supported)
> > +{
> > +     return lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
> > +                                            WMI_METHOD_ID_SMARTFAN_SUP=
P, 0, supported);
> > +}
> > +
> > +static int lenovo_wmi_gz_profile_get(struct device *dev,
> > +                                  enum platform_profile_option *profil=
e)
> > +{
> > +     struct lenovo_wmi_gz_priv *priv =3D dev_get_drvdata(dev);
> > +     int sel_prof;
> > +     int ret;
> > +
> > +     ret =3D lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
> > +                                           WMI_METHOD_ID_SMARTFAN_GET,=
 0, &sel_prof);
> > +     if (ret)
> > +             return ret;
> > +
> > +     switch (sel_prof) {
> > +     case SMARTFAN_MODE_QUIET:
> > +             *profile =3D PLATFORM_PROFILE_LOW_POWER;
> > +             break;
> > +     case SMARTFAN_MODE_BALANCED:
> > +             *profile =3D PLATFORM_PROFILE_BALANCED;
> > +             break;
> > +     case SMARTFAN_MODE_PERFORMANCE:
> > +             if (priv->extreme_supported) {
> > +                     *profile =3D PLATFORM_PROFILE_BALANCED_PERFORMANC=
E;
> > +                     break;
> > +             }
> > +             *profile =3D PLATFORM_PROFILE_PERFORMANCE;
> > +             break;
> > +     case SMARTFAN_MODE_EXTREME:
> > +             *profile =3D PLATFORM_PROFILE_PERFORMANCE;
> > +             break;

Here we determine what SMARTFAN_MODE_PERFORMANCE means. If
extreme_supported was determined at probe we report
balanced_performance, otherwise it reports performance. This will only
ever return SMARTFAN_MODE_EXTREME from WMI if the hardware set it
through Fn+Q cycling or if it was available in _set.

As for why I am using performance in two different ways, it mostly
comes down to there not being a concept for PLATFORM_PROFILE_EXTREME
in the kernel. This simply ensures that the profiles scale from lowest
to highest in a logical way no matter what. I think it would be very
confusing to users if userspace (i.e. PPD) set balanced_performance
and that went to the highest setting, followed by a lower setting when
at performance. The term EXTREME is essentially marketing.

> > +     case SMARTFAN_MODE_CUSTOM:
> > +             *profile =3D PLATFORM_PROFILE_CUSTOM;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     priv->current_profile =3D *profile;
> > +
> > +     ret =3D blocking_notifier_call_chain(&gz_chain_head, THERMAL_MODE=
_EVENT,
> > +                                        &sel_prof);
> > +     if (ret =3D=3D NOTIFY_BAD)
> > +             pr_err("Failed to send notification to call chain for WMI=
 event %u\n",
> > +                    priv->type);
> > +     return 0;
> > +}
> > +
> > +static int lenovo_wmi_gz_profile_set(struct device *dev,
> > +                                  enum platform_profile_option profile=
)
> > +{
> > +     struct lenovo_wmi_gz_priv *priv =3D dev_get_drvdata(dev);
> > +     int sel_prof;
> > +     int ret;
> > +
> > +     switch (profile) {
> > +     case PLATFORM_PROFILE_LOW_POWER:
> > +             sel_prof =3D SMARTFAN_MODE_QUIET;
> > +             break;
> > +     case PLATFORM_PROFILE_BALANCED:
> > +             sel_prof =3D SMARTFAN_MODE_BALANCED;
> > +             break;
> > +     case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> > +             sel_prof =3D SMARTFAN_MODE_PERFORMANCE;
> > +             break;
> > +     case PLATFORM_PROFILE_PERFORMANCE:
> > +             if (priv->extreme_supported) {
> > +                     sel_prof =3D SMARTFAN_MODE_EXTREME;
> > +                     break;
> > +             }
> > +             sel_prof =3D SMARTFAN_MODE_PERFORMANCE;
> > +             break;

Here is where we determine what performance means when setting a
profile. PLATFORM_PROFILE_BALANCED_PERFORMANCE is only available if
extreme is supported, so we've safely done the check for it in probe.

> > +     case PLATFORM_PROFILE_CUSTOM:
> > +             sel_prof =3D SMARTFAN_MODE_CUSTOM;
> > +             break;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     ret =3D lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
> > +                                           WMI_METHOD_ID_SMARTFAN_SET,=
 sel_prof, NULL);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dmi_system_id fwbug_list[] =3D {
> > +     {
> > +             .ident =3D "Legion Go 8APU1",
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1")=
,
> > +             },
> > +             .driver_data =3D &quirk_no_extreme_bug,
> > +     },
> > +     {
> > +             .ident =3D "Legion Go S 8ARP1",
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8ARP1=
"),
> > +             },
> > +             .driver_data =3D &quirk_no_extreme_bug,
> > +     },
> > +     {
> > +             .ident =3D "Legion Go S 8APU1",
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8APU1=
"),
> > +             },
> > +             .driver_data =3D &quirk_no_extreme_bug,
> > +     },
> > +     {},
> > +
> > +};
> > +
> > +static bool extreme_supported(int profile_support_ver)
> > +{
> > +     const struct dmi_system_id *dmi_id;
> > +     struct quirk_entry *quirks;
> > +
> > +     if (profile_support_ver < 6)
> > +             return false;
> > +
> > +     dmi_id =3D dmi_first_match(fwbug_list);
> > +     if (!dmi_id)
> > +             return true;
> > +
> > +     quirks =3D dmi_id->driver_data;
> > +     return quirks->extreme_supported;
> > +}

This is where we determine if extreme is supported. Legacy devices
will be version 5 or less. The quirk table is for ver 6+ with a bugged
BIOS.

> > +static int lenovo_wmi_platform_profile_probe(void *drvdata,
> > +                                          unsigned long *choices)
> > +{
> > +     struct lenovo_wmi_gz_priv *priv =3D drvdata;
> > +     enum platform_profile_option profile;
> > +     int profile_support_ver;
> > +     int ret;
> > +
> > +     ret =3D lenovo_wmi_gz_platform_profile_supported(priv,
> > +                                                    &profile_support_v=
er);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (profile_support_ver < 1)
> > +             return -ENODEV;
> > +
> > +     priv->extreme_supported =3D extreme_supported(profile_support_ver=
);
> > +
> > +     set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > +     set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +     set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> > +     set_bit(PLATFORM_PROFILE_CUSTOM, choices);
> > +
> > +     if (priv->extreme_supported)
> > +             set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> > +
> > +     return 0;
> > +}

This is where we enable balanced_perfomance if extreme is supported.

- Derek
> > +
> > +static const struct platform_profile_ops lenovo_wmi_gz_platform_profil=
e_ops =3D {
> > +     .probe =3D lenovo_wmi_platform_profile_probe,
> > +     .profile_get =3D lenovo_wmi_gz_profile_get,
> > +     .profile_set =3D lenovo_wmi_gz_profile_set,
> > +};
> > +
> > +/* Notifier Methods */
> > +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb)
> > +{
> > +     guard(mutex)(&gz_chain_mutex);
> > +     return blocking_notifier_chain_register(&gz_chain_head, nb);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_register_notifier, "GZ_WMI");
> > +
> > +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb)
> > +{
> > +     guard(mutex)(&gz_chain_mutex);
> > +     return blocking_notifier_chain_unregister(&gz_chain_head, nb);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_unregister_notifier, "GZ_WMI");
> > +
> > +static void devm_lenovo_wmi_gz_unregister_notifier(void *data)
> > +{
> > +     struct notifier_block *nb =3D data;
> > +
> > +     lenovo_wmi_gz_unregister_notifier(nb);
> > +}
> > +
> > +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
> > +                                      struct notifier_block *nb)
> > +{
> > +     int ret;
> > +
> > +     ret =3D lenovo_wmi_gz_register_notifier(nb);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return devm_add_action_or_reset(dev, devm_lenovo_wmi_gz_unregiste=
r_notifier, nb);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(devm_lenovo_wmi_gz_register_notifier, "GZ_WMI");
> > +
> > +/* Driver Methods */
> > +static void lenovo_wmi_gz_notify(struct wmi_device *wdev,
> > +                              union acpi_object *obj)
> > +{
> > +     struct lenovo_wmi_gz_priv *tm_priv =3D dev_get_drvdata(&wdev->dev=
);
> > +     struct lenovo_wmi_gz_priv *gz_priv =3D
> > +             container_of(&gz_chain_head, struct lenovo_wmi_gz_priv, n=
head);
> > +     int sel_prof;
> > +     int ret;
> > +
> > +     if (obj->type !=3D ACPI_TYPE_INTEGER)
> > +             return;
> > +
> > +     switch (tm_priv->type) {
> > +     case THERMAL_MODE:
> > +             sel_prof =3D obj->integer.value;
> > +             break;
> > +     default:
> > +             return;
> > +     }
> > +
> > +     /* Update primary Gamezone instance */
> > +     switch (sel_prof) {
> > +     case SMARTFAN_MODE_QUIET:
> > +             gz_priv->current_profile =3D PLATFORM_PROFILE_LOW_POWER;
> > +             break;
> > +     case SMARTFAN_MODE_BALANCED:
> > +             gz_priv->current_profile =3D PLATFORM_PROFILE_BALANCED;
> > +             break;
> > +     case SMARTFAN_MODE_PERFORMANCE:
> > +             if (gz_priv->extreme_supported) {
> > +                     gz_priv->current_profile =3D
> > +                             PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> > +                     break;
> > +             }
> > +             gz_priv->current_profile =3D PLATFORM_PROFILE_PERFORMANCE=
;
> > +             break;
> > +     case SMARTFAN_MODE_EXTREME:
> > +             gz_priv->current_profile =3D PLATFORM_PROFILE_PERFORMANCE=
;
> > +             break;
> > +     case SMARTFAN_MODE_CUSTOM:
> > +             gz_priv->current_profile =3D PLATFORM_PROFILE_CUSTOM;
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     ret =3D blocking_notifier_call_chain(&gz_chain_head, THERMAL_MODE=
_EVENT,
> > +                                        &sel_prof);
> > +     if (ret =3D=3D NOTIFY_BAD)
> > +             pr_err("Failed to send notification to call chain for WMI=
 event %u\n",
> > +                    tm_priv->type);
> > +}
> > +
> > +static int lenovo_wmi_gz_probe(struct wmi_device *wdev, const void *co=
ntext)
> > +{
> > +     struct lenovo_wmi_gz_priv *priv =3D
> > +             devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
> > +
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     if (!context)
> > +             return -EINVAL;
> > +
> > +     priv->wdev =3D wdev;
> > +     priv->type =3D *((enum lenovo_wmi_gz_type *)context);
> > +
> > +     dev_set_drvdata(&wdev->dev, priv);
> > +
> > +     if (priv->type !=3D GAMEZONE_FULL)
> > +             return 0;
> > +
> > +     priv->nhead =3D gz_chain_head;
> > +     priv->ppdev =3D platform_profile_register(&wdev->dev, "lenovo-wmi=
-gamezone",
> > +                                             priv, &lenovo_wmi_gz_plat=
form_profile_ops);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct wmi_device_id lenovo_wmi_gz_id_table[] =3D {
> > +     { GAMEZONE_WMI_DEVICE(LENOVO_GAMEZONE_GUID, GAMEZONE_FULL) },
> > +     { GAMEZONE_WMI_DEVICE(THERMAL_MODE_EVENT_GUID, THERMAL_MODE) },
> > +     {}
> > +};
> > +
> > +static struct wmi_driver lenovo_wmi_gz_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "lenovo_wmi_gamezone",
> > +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +     },
> > +     .id_table =3D lenovo_wmi_gz_id_table,
> > +     .probe =3D lenovo_wmi_gz_probe,
> > +     .notify =3D lenovo_wmi_gz_notify,
> > +     .no_singleton =3D true,
> > +};
> > +
> > +module_wmi_driver(lenovo_wmi_gz_driver);
> > +
> > +MODULE_IMPORT_NS("LENOVO_WMI");
> > +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_gz_id_table);
> > +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> > +MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/platform/x86/lenovo-wmi.c b/drivers/platform/x86/l=
enovo-wmi.c
> > new file mode 100644
> > index 000000000000..0de2c37e69bd
> > --- /dev/null
> > +++ b/drivers/platform/x86/lenovo-wmi.c
> > @@ -0,0 +1,77 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI interface=
 is
> > + * broken up into multiple GUID interfaces that require cross-referenc=
es
> > + * between GUID's for some functionality. The "Custom Method" interfac=
e is a
> > + * legacy interface for managing and displaying CPU & GPU power and hw=
mon
> > + * settings and readings. The "Other Mode" interface is a modern inter=
face
> > + * that replaces or extends the "Custom Method" interface methods. The
> > + * "Gamezone" interface adds advanced features such as fan profiles an=
d
> > + * overclocking. The "Lighting" interface adds control of various stat=
us
> > + * lights related to different hardware components. "Other Mode" uses
> > + * the data structs LENOVO_CAPABILITY_DATA_00, LENOVO_CAPABILITY_DATA_=
01
> > + * and LENOVO_CAPABILITY_DATA_02 structs for capability information.
> > + *
> > + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
> > + *
> > + */
> > +
> > +#include <linux/wmi.h>
> > +#include "lenovo-wmi.h"
> > +
> > +/* wmidev_evaluate_method helper functions */
> > +static int lenovo_wmidev_evaluate_method(struct wmi_device *wdev, u8 i=
nstance,
> > +                                      u32 method_id, struct acpi_buffe=
r *in,
> > +                                      struct acpi_buffer *out)
> > +{
> > +     acpi_status status;
> > +
> > +     status =3D wmidev_evaluate_method(wdev, instance, method_id, in, =
out);
> > +
> > +     if (ACPI_FAILURE(status))
> > +             return -EIO;
> > +
> > +     return 0;
> > +};
> > +
> > +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 instan=
ce,
> > +                                 u32 method_id, u32 arg0, u32 arg1,
> > +                                 u32 *retval)
> > +{
> > +     struct wmi_method_args args =3D { arg0, arg1 };
> > +     struct acpi_buffer input =3D { (acpi_size)sizeof(args), &args };
> > +     struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> > +     union acpi_object *ret_obj __free(kfree) =3D NULL;
> > +     int err;
> > +
> > +     err =3D lenovo_wmidev_evaluate_method(wdev, instance, method_id, =
&input,
> > +                                         &output);
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     if (retval) {
> > +             ret_obj =3D (union acpi_object *)output.pointer;
> > +             if (!ret_obj)
> > +                     return -ENODATA;
> > +
> > +             if (ret_obj->type !=3D ACPI_TYPE_INTEGER)
> > +                     return -ENXIO;
> > +
> > +             *retval =3D (u32)ret_obj->integer.value;
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_2, "LENOVO_WMI");
> > +
> > +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 instan=
ce,
> > +                                 u32 method_id, u32 arg0, u32 *retval)
> > +{
> > +     return lenovo_wmidev_evaluate_method_2(wdev, instance, method_id,=
 arg0,
> > +                                            0, retval);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_1, "LENOVO_WMI");
> > +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> > +MODULE_DESCRIPTION("Lenovo WMI Common Driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/platform/x86/lenovo-wmi.h b/drivers/platform/x86/l=
enovo-wmi.h
> > new file mode 100644
> > index 000000000000..113928b4fc0f
> > --- /dev/null
> > +++ b/drivers/platform/x86/lenovo-wmi.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI interface=
 is
> > + * broken up into multiple GUID interfaces that require cross-referenc=
es
> > + * between GUID's for some functionality. The "Custom Method" interfac=
e is a
> > + * legacy interface for managing and displaying CPU & GPU power and hw=
mon
> > + * settings and readings. The "Other Mode" interface is a modern inter=
face
> > + * that replaces or extends the "Custom Method" interface methods. The
> > + * "Gamezone" interface adds advanced features such as fan profiles an=
d
> > + * overclocking. The "Lighting" interface adds control of various stat=
us
> > + * lights related to different hardware components. "Other Mode" uses
> > + * the data structs LENOVO_CAPABILITY_DATA_00, LENOVO_CAPABILITY_DATA_=
01
> > + * and LENOVO_CAPABILITY_DATA_02 structs for capability information.
> > + *
> > + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
> > + *
> > + */
> > +#include <linux/notifier.h>
> > +#include <linux/platform_profile.h>
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#ifndef _LENOVO_WMI_H_
> > +#define _LENOVO_WMI_H_
> > +
> > +#include <linux/bits.h>
> > +#include <linux/types.h>
> > +#include <linux/wmi.h>
> > +
> > +struct wmi_method_args {
> > +     u32 arg0;
> > +     u32 arg1;
> > +};
> > +
> > +/* gamezone structs */
> > +enum thermal_mode {
> > +     SMARTFAN_MODE_QUIET =3D 0x01,
> > +     SMARTFAN_MODE_BALANCED =3D 0x02,
> > +     SMARTFAN_MODE_PERFORMANCE =3D 0x03,
> > +     SMARTFAN_MODE_EXTREME =3D 0xE0, /* Ver 6+ */
> > +     SMARTFAN_MODE_CUSTOM =3D 0xFF,
> > +};
> > +
> > +enum lenovo_wmi_action {
> > +     THERMAL_MODE_EVENT =3D 1,
> > +};
> > +
> > +/* wmidev_evaluate_method helper functions */
> > +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 instan=
ce,
> > +                                 u32 method_id, u32 arg0, u32 arg1,
> > +                                 u32 *retval);
> > +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 instan=
ce,
> > +                                 u32 method_id, u32 arg0, u32 *retval)=
;
> > +
> > +/* lenovo_wmi_gz_driver notifier functions */
> > +int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigned lo=
ng action,
> > +                             enum platform_profile_option *profile);
> > +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb);
> > +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb);
> > +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
> > +                                      struct notifier_block *nb);
> > +#endif /* !_LENOVO_WMI_H_ */
>

