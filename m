Return-Path: <linux-kernel+bounces-318055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13996E7B8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8D2B23B33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E4922064;
	Fri,  6 Sep 2024 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="F3FTkZXx"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CE2E62C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725589733; cv=none; b=SCO31y67G2x1YSY51osc3OVdRusDO0/i2osDFXN4LuZFbQuZL1sRswHnDpHvyH/m5x59z+V/nFgHSM1OZigk7jtReuAFAOUwd9wIP2gIko5i1CUjuZkf1KFw8HCCEkUmYPjM7qhafUHicRyznMtVDi8VODOfdy+e2i5cf/Es3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725589733; c=relaxed/simple;
	bh=OkuQP8GGUbsjpkJW7AUCQX3rxujXaiedJtgcoVUVLB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCO1BPernHYkWaeHXGVElO0QYYCEEP43/UqnKsb0SFFhUKhzFo/5slrpyg5obLt2mXDW+dcpseIRwe4FeG2luiQGfoSr6m0iSEqJ8ATCr3E5935m2uXIlM2mmTGCBm+HxDwYd8TDWTTthkicGV4ONEFogrfTu85vKczK+YpW74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=F3FTkZXx; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E5E4E3F1C0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 02:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725589725;
	bh=D33DP173HQ3sM4JzkRWdQ29nFSy60oZoLXqXyU1a/Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=F3FTkZXxOUiQRcXwCfBAiGnvK2hJqW/LCHkKQ32+rI5UXp1NLL1EhLDnayTtHMS73
	 AErtR7ekuekQtEaJUyqLk7ZZJgAxbmut3KyJf578X4DUL3UwQ9b20Q8CuNR48hNKpt
	 jtRYZP1m/5slI41oQdHnCy7G6pDbukIvquwPcw4iiiooOjs3CT+8jfOxf4ejQ8QiAG
	 i5fSF1J2TudLAxBY2CcrrgQAJ3xICSDZCRkEwEa8jFAPdvxLJ31MDJRfcTccUh5V17
	 +LFdNguB8Lo+tDqXi9Pf97amiwZAmYWYX/qc1iGp28TidpUIlvXHIM6y72+RMbj3ho
	 bOdyXBN4tXxXw==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f74d4423d2so10872781fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 19:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725589725; x=1726194525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D33DP173HQ3sM4JzkRWdQ29nFSy60oZoLXqXyU1a/Ys=;
        b=gy/RxPGf0Rcs0LUicjkzyPgQkYNHWmx27LpUPfymjYjLBQWhN/ksBASSB0gTvCSJlW
         dJ2i5EcpqMvlIOI3gZwENqWpbWiKbNmLHqWzZxo7sW3i8zk8n2Xq/4+LUW8V4pEH49kG
         XulEd5/G4Yd1upauFrKnmHJgbSmsx1w81/KBVIByK+cOJPMTUwUmnqz404giVZAbgN2O
         9nUyTJlDdoUs+JX7QvYBjb1l15IVsBIgGkWXQZKULQ9DFCiEPFwngtX16UWg9Nm7ypdO
         S9mKDhrG8tCyUV5YLqEu1hXiMpE/okiQenA10uIKyJBgpRfx+2YyZyi3ZCmiS1gHV79k
         ix9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6wWVxZMIycpc5MwmIjv9Sc5t9OVeKubX1qTh/qVu/BcW0gFeJinRAD8FTR6o/yhEG6/9c/UnIvSrIr84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOC4gXJVeZtlEtZNFcU/yKxWo3A/y8KXHKlodj8j4JjsfZUqU
	0Y9+Lh0LbjaOyOQ7wMfUje34bYRhJt1KlZqxmePNG3mW7ewU5ZCfxvTODM5GpOa2ggUb8oHWMUP
	okE6+LlJTG5j9kyOxYV5Oi91mBBaxMa8Wa3FQl7YndUQPeCeSqeVaYubV94rg+mbAWcJvnsV8xp
	MNVQlBfEjsyAbWldq5q09+zkeybNk25vbjlJTp/Lo+9/ua2rmGnjAs
X-Received: by 2002:a2e:4c02:0:b0:2f6:4aed:9973 with SMTP id 38308e7fff4ca-2f7524a3509mr4708121fa.44.1725589724775;
        Thu, 05 Sep 2024 19:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsJuR8zPgCf4lkerjcwSbQEX9fiFYVWJsPlZ1e01j7vn8MH5cH2SMuSKO+wh3rm8TmRkZuvU4OaRDetYMUxPk=
X-Received: by 2002:a2e:4c02:0:b0:2f6:4aed:9973 with SMTP id
 38308e7fff4ca-2f7524a3509mr4707991fa.44.1725589724093; Thu, 05 Sep 2024
 19:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905042447.418662-1-kai.heng.feng@canonical.com>
 <20240905042447.418662-2-kai.heng.feng@canonical.com> <5544d302-9480-4cca-9cfd-ed56cecf6bd3@redhat.com>
In-Reply-To: <5544d302-9480-4cca-9cfd-ed56cecf6bd3@redhat.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 6 Sep 2024 10:28:32 +0800
Message-ID: <CAAd53p51jtJywwK3rNwe2gy7qKSx823EeAJqEtTE-u3L2Ym0Hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86/hp: Avoid spurious wakeup on HP ProOne 440
To: Hans de Goede <hdegoede@redhat.com>
Cc: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org, 
	jorge.lopez2@hp.com, acelan.kao@canonical.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 4:56=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi Kai-Heng Feng,
>
> On 9/5/24 6:24 AM, Kai-Heng Feng wrote:
> > The HP ProOne 440 has a power saving design that when the display is
> > off, it also cuts the USB touchscreen device's power off.
> >
> > This can cause system early wakeup because cutting the power off the
> > touchscreen device creates a disconnect event and prevent the system
> > from suspending:
> > [  445.814574] hub 2-0:1.0: hub_suspend
> > [  445.814652] usb usb2: bus suspend, wakeup 0
> > [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 11, p=
ortsc: 0x202a0
> > [  445.824639] xhci_hcd 0000:00:14.0: resume root hub
> > [  445.824651] xhci_hcd 0000:00:14.0: handle_port_status: starting usb1=
 port polling.
> > [  445.844039] xhci_hcd 0000:00:14.0: PM: pci_pm_suspend(): hcd_pci_sus=
pend+0x0/0x20 returns -16
> > [  445.844058] xhci_hcd 0000:00:14.0: PM: dpm_run_callback(): pci_pm_su=
spend+0x0/0x1c0 returns -16
> > [  445.844072] xhci_hcd 0000:00:14.0: PM: failed to suspend async: erro=
r -16
> > [  446.276101] PM: Some devices failed to suspend, or early wake event =
detected
> >
> > So add a quirk to make sure the following is happening:
> > 1. Let the i915 driver suspend first, to ensure the display is off so
> >    system also cuts the USB touchscreen's power.
> > 2. If the touchscreen is present, wait a while to let the USB disconnec=
t
> >    event fire.
> > 3. Since the disconnect event already happened, the xhci's suspend
> >    routine won't be interrupted anymore.
>
> You only set the suspend-handler from the dmi-quirk callback, so it
> is only ever set on the affected laptop-model. So this can be simplified
> by simply always doing the msleep(200) on suspend, instead of poking at
> USB system internals to find out if the touchscreen is there on suspend.
>
> I guess there may be versions of this specific laptop with/without
> the touchscreen, but I'm not overly worried about adding a 200 ms delay
> on just 1 model laptop for the versions which don't have a touchscreen.

My original idea is not to impose the delay for unaffected systems.
But yes not poking at USB subsystem can make things much easier.

>
> A bigger worry which I have is that we are going to see the same problem
> on other vendor's laptops. So I think in the end we may need something
> done in a more generic manner, in e.g. the drm subsystem (since this
> is display related). For now lets go with this fix and when we hit simila=
r
> cases we can figure out what a generic fix will look like.

Right now this is the only model I've seen that exhibit such behavior.
So I am not overly worried about such problem.

>
> One more comment inline below.
>
>
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/platform/x86/hp/hp-wmi.c | 104 ++++++++++++++++++++++++++++++-
> >  1 file changed, 103 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp=
/hp-wmi.c
> > index 876e0a97cee1..80fc3ee4deaf 100644
> > --- a/drivers/platform/x86/hp/hp-wmi.c
> > +++ b/drivers/platform/x86/hp/hp-wmi.c
> > @@ -30,6 +30,9 @@
> >  #include <linux/rfkill.h>
> >  #include <linux/string.h>
> >  #include <linux/dmi.h>
> > +#include <linux/delay.h>
> > +#include <linux/pci.h>
> > +#include <linux/usb.h>
> >
> >  MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
> >  MODULE_DESCRIPTION("HP laptop WMI driver");
> > @@ -1708,6 +1711,52 @@ static void __exit hp_wmi_bios_remove(struct pla=
tform_device *device)
> >               platform_profile_remove();
> >  }
> >
> > +static int hp_wmi_suspend_handler(struct device *device)
> > +{
> > +     acpi_handle handle;
> > +     struct acpi_device *adev;
> > +     struct device *physdev;
> > +     struct usb_port *port_dev;
> > +     struct usb_device *udev;
> > +     acpi_status status;
> > +     bool found =3D false;
> > +
> > +     /* The USB touchscreen device always connects to HS11 */
> > +     status =3D acpi_get_handle(NULL, "\\_SB.PC00.XHCI.RHUB.HS11", &ha=
ndle);
> > +     if (ACPI_FAILURE(status))
> > +             return 0;
> > +
> > +     adev =3D acpi_fetch_acpi_dev(handle);
> > +     if (!adev)
> > +             return 0;
> > +
> > +     physdev =3D get_device(acpi_get_first_physical_node(adev));
> > +     if (!physdev)
> > +             return 0;
> > +
> > +     port_dev =3D to_usb_port(physdev);
> > +     if (port_dev->state =3D=3D USB_STATE_NOTATTACHED)
> > +             return 0;
> > +
> > +     udev =3D port_dev->child;
> > +
> > +     if (udev) {
>
> This is racy. Often desktop environments will turn off the display
> before doing a system-suspend, so the touchscreen is already disconnected
> at this point but the USB subsystem may not have processed it yet.
>
> What if the USB subsystem processes the disconnect exactly at this point?
>
> Then your port_dev->child pointer is no longer valid and your passing
> a pointer to free-ed mem to usb_get_dev()
>
> As I said above since this code only runs on 1 model based on a DMI
> match just simplify this entire function to a single "msleep(200)"
> and be done with it.

OK, will scratch the poking part in next revision. Thanks for the review.

Kai-Heng

>
> Regards,
>
> Hans
>
>
> > +             usb_get_dev(udev);
> > +             if (le16_to_cpu(udev->descriptor.idVendor) =3D=3D 0x1fd2 =
&&
> > +                 le16_to_cpu(udev->descriptor.idProduct) =3D=3D 0x8102=
) {
> > +                     dev_dbg(&hp_wmi_platform_dev->dev, "LG Melfas tou=
chscreen found\n");
> > +                     found =3D true;
> > +             }
> > +             usb_put_dev(udev);
> > +
> > +             /* Let the xhci have time to handle disconnect event */
> > +             if (found)
> > +                     msleep(200);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int hp_wmi_resume_handler(struct device *device)
> >  {
> >       /*
> > @@ -1745,7 +1794,7 @@ static int hp_wmi_resume_handler(struct device *d=
evice)
> >       return 0;
> >  }
> >
> > -static const struct dev_pm_ops hp_wmi_pm_ops =3D {
> > +static struct dev_pm_ops hp_wmi_pm_ops =3D {
> >       .resume  =3D hp_wmi_resume_handler,
> >       .restore  =3D hp_wmi_resume_handler,
> >  };
> > @@ -1871,6 +1920,57 @@ static int hp_wmi_hwmon_init(void)
> >       return 0;
> >  }
> >
> > +static int lg_usb_touchscreen_quirk(const struct dmi_system_id *id)
> > +{
> > +     struct pci_dev *vga, *xhci;
> > +     struct device_link *vga_link, *xhci_link;
> > +
> > +     vga =3D pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
> > +
> > +     xhci =3D pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, NULL);
> > +
> > +     if (vga && xhci) {
> > +             xhci_link =3D device_link_add(&hp_wmi_platform_dev->dev, =
&xhci->dev,
> > +                                   DL_FLAG_STATELESS);
> > +             if (xhci_link)
> > +                     dev_info(&hp_wmi_platform_dev->dev, "Suspend befo=
re %s\n",
> > +                              pci_name(xhci));
> > +             else
> > +                     return 1;
> > +
> > +             vga_link =3D device_link_add(&vga->dev, &hp_wmi_platform_=
dev->dev,
> > +                                        DL_FLAG_STATELESS);
> > +             if (vga_link)
> > +                     dev_info(&hp_wmi_platform_dev->dev, "Suspend afte=
r %s\n",
> > +                              pci_name(vga));
> > +             else {
> > +                     device_link_del(xhci_link);
> > +                     return 1;
> > +             }
> > +     }
> > +
> > +
> > +     /* During system bootup, the display and the USB touchscreen devi=
ce can
> > +      * be on and off several times, so the device may not be present =
during
> > +      * hp-wmi's probe routine. Try to find the device in suspend rout=
ine
> > +      * instead.
> > +      */
> > +     hp_wmi_pm_ops.suspend =3D hp_wmi_suspend_handler;
> > +
> > +     return 1;
> > +}
> > +
> > +static const struct dmi_system_id hp_wmi_quirk_table[] =3D {
> > +     {
> > +             .callback =3D lg_usb_touchscreen_quirk,
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "HP ProOne 440 23.8 i=
nch G9 All-in-One Desktop PC"),
> > +             },
> > +     },
> > +     {}
> > +};
> > +
> >  static int __init hp_wmi_init(void)
> >  {
> >       int event_capable =3D wmi_has_guid(HPWMI_EVENT_GUID);
> > @@ -1909,6 +2009,8 @@ static int __init hp_wmi_init(void)
> >                       goto err_unregister_device;
> >       }
> >
> > +     dmi_check_system(hp_wmi_quirk_table);
> > +
> >       return 0;
> >
> >  err_unregister_device:
>

