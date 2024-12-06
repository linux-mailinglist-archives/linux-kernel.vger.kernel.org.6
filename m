Return-Path: <linux-kernel+bounces-435748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF99E7BC2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5637C1887B26
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ECF20458C;
	Fri,  6 Dec 2024 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YCZTHeUe"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119691AAA24
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733524069; cv=none; b=B3BUYcR/xB7duiBLL6cpiDX7ksVdNEX3YJB27gR3x5MPcIgGPHip27FW236vJOrIjuWEHli0baiS+8zpZSEhmMtG5ElhFAYMN46ekUJ/lz/j+rGggUGy+Sok2mt2JijdtVRryZyTKATJJBh5T+VJYD+szqjPXLf/GtXNw5Jeoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733524069; c=relaxed/simple;
	bh=TvP11RkYkDe271+6L8FrC8PQWAHtA0zlwoHsF/KT648=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLPbBCkwnrXxqNiVPBWMnqAkmbyNZGSHXqyV1PDZF7nKLYxjMWuSIjHST3IYRqDhGyNJMr4RG+czWy1Wby0aWS1D2C1EjRl3raOCbsDMIRKYx7mLiejYLDrXWgRzFJ4XKl4ZOSNAMjXbtmkoRUHzjq0oND2KXvEzq2DrXzQbs08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YCZTHeUe; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ef402e4589so20083827b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 14:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733524066; x=1734128866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OiTZvZN/gOalwFQFE9Xzv4FQzzb45pgvL25Y0MdfAU=;
        b=YCZTHeUe2Z+4Y01ymo251satBF7S6jQRczbQaWE4rL2n2fNcIlQoag2LgcRwWITUPw
         li4AM0PTIsuUMqYIHE7Tv35u3nYRUMEG9qG6dcM86MVfOKgNXPfKGZtyondLh7qZCSUT
         GM8QL22m+cWMroi6iQ8ZFIEvGezsktB5npM3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733524066; x=1734128866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OiTZvZN/gOalwFQFE9Xzv4FQzzb45pgvL25Y0MdfAU=;
        b=rXf2od+yr2T8hD9OYrhDI6XpRuooUiPytFSsmaw3MuFSJL9j+FTAmSSNKJPVvtbNA7
         +6kRsnJh4xgW0N4nYRaUubPW6Hm3vaJntRPI4at5kv771DL0CG/PkCbHtLFMjlS2ewfM
         DrKKNZ6/5qiC60U+HdqidEGZn5OD4il8UyH9a7UqTJN2nuUMh6LXNs/peXL/UJzK7aUB
         0GcTv0q7gBlN5Nqf88r6wMScvS/NDQOZZ0pO0L3jeHk3tB+JNLhwu8J+TXon86P2GZga
         gwPsJ1W5FstwJ+yFgS7acl7O8JbO6rRfo7EHwPQIbge6vLpeBd/M56fNjPqZY+xstsWC
         VQbg==
X-Forwarded-Encrypted: i=1; AJvYcCUohJcFagJ0dhbv/+YilO/HFVPKDeC8AJdqCv2U3lnDaRUGaLBJTAbbfqcqtM5n5Gu5niJ0i4AXlyxLYRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJu+cEO/3hC2kuQArqD7nufRQlrAXaTpgvSxQ0Jlzo8+jUleAm
	ke2giL8TgJ/xLVgvXq8p8KOKXtxT+81l8x9bbehyqAqYNWUJq7Djl/p/ZKXeQJYb0M2AFe3d6Mw
	XHmWhfWZQ69mH12xNHZyOJcEyFJPolFaHoUWz
X-Gm-Gg: ASbGnctn1rpa/XXEsDCO+28RvlX8YosyZlsqkxqskyTrKj2lRL6Wx9czxwTQJ4er03y
	SnkszifDedBSpTpq5/o5do1af2otMUd8=
X-Google-Smtp-Source: AGHT+IHWfqt6v2VxHM3ebs7G/Mrp/SPebkZ/kxNk3Cr7o5R2tewboE/agfJZTYTvbjKU1baaq2RURhlWulqw+zVBFMg=
X-Received: by 2002:a05:690c:4b11:b0:6ef:96f8:b609 with SMTP id
 00721157ae682-6efe3c987d3mr47575877b3.31.1733524065909; Fri, 06 Dec 2024
 14:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107193021.2690050-1-abhishekpandit@chromium.org>
 <20241107112955.v3.2.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid> <Z0DRWhZ745-N0DFE@google.com>
In-Reply-To: <Z0DRWhZ745-N0DFE@google.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Fri, 6 Dec 2024 14:27:34 -0800
Message-ID: <CANFp7mVhOHC7R_gyr1tK26yvUxqjnZCEDR+aR=cSGzME0CwCHg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] usb: typec: Add driver for Thunderbolt 3 Alternate Mode
To: Benson Leung <bleung@google.com>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, 
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev, jthies@google.com, 
	akuchynski@google.com, pmalani@chromium.org, dmitry.baryshkov@linaro.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	danielgeorgem@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 10:51=E2=80=AFAM Benson Leung <bleung@google.com> w=
rote:
>
> Hi Abhishek,
>
>
> On Thu, Nov 07, 2024 at 11:29:55AM -0800, Abhishek Pandit-Subedi wrote:
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> > Thunderbolt 3 Alternate Mode entry flow is described in
> > USB Type-C Specification Release 2.0.
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Co-developed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes:
> > * Delay cable + plug checks so that the module doesn't fail to probe
> >   if cable + plug information isn't available by the time the partner
> >   altmode is registered.
> > * Remove unncessary brace after if (IS_ERR(plug))
> >
> > The rest of this patch should be the same as Heikki's original RFC.
> >
> >
> > Changes in v3:
> > - Revert rename of TYPEC_TBT_MODE
> > - Remove mode from typec_device_id
> >
> > Changes in v2:
> > - Use <linux/usb/typec_tbt.h> and add missing TBT_CABLE_ROUNDED
> > - Pass struct typec_thunderbolt_data to typec_altmode_notify
> > - Rename TYPEC_TBT_MODE to USB_TYPEC_TBT_MODE
> > - Use USB_TYPEC_TBT_SID and USB_TYPEC_TBT_MODE for device id
> > - Change module license to GPL due to checkpatch warning
> >
> >  drivers/usb/typec/altmodes/Kconfig       |   9 +
> >  drivers/usb/typec/altmodes/Makefile      |   2 +
> >  drivers/usb/typec/altmodes/thunderbolt.c | 308 +++++++++++++++++++++++
> >  include/linux/usb/typec_tbt.h            |   1 +
> >  4 files changed, 320 insertions(+)
> >  create mode 100644 drivers/usb/typec/altmodes/thunderbolt.c
> >
> > diff --git a/drivers/usb/typec/altmodes/Kconfig b/drivers/usb/typec/alt=
modes/Kconfig
> > index 1a6b5e872b0d..7867fa7c405d 100644
> > --- a/drivers/usb/typec/altmodes/Kconfig
> > +++ b/drivers/usb/typec/altmodes/Kconfig
> > @@ -23,4 +23,13 @@ config TYPEC_NVIDIA_ALTMODE
> >         To compile this driver as a module, choose M here: the
> >         module will be called typec_nvidia.
> >
> > +config TYPEC_TBT_ALTMODE
> > +     tristate "Thunderbolt3 Alternate Mode driver"
> > +     help
> > +       Select this option if you have Thunderbolt3 hardware on your
> > +       system.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called typec_thunderbolt.
> > +
> >  endmenu
> > diff --git a/drivers/usb/typec/altmodes/Makefile b/drivers/usb/typec/al=
tmodes/Makefile
> > index 45717548b396..508a68351bd2 100644
> > --- a/drivers/usb/typec/altmodes/Makefile
> > +++ b/drivers/usb/typec/altmodes/Makefile
> > @@ -4,3 +4,5 @@ obj-$(CONFIG_TYPEC_DP_ALTMODE)                +=3D type=
c_displayport.o
> >  typec_displayport-y                  :=3D displayport.o
> >  obj-$(CONFIG_TYPEC_NVIDIA_ALTMODE)   +=3D typec_nvidia.o
> >  typec_nvidia-y                               :=3D nvidia.o
> > +obj-$(CONFIG_TYPEC_TBT_ALTMODE)              +=3D typec_thunderbolt.o
> > +typec_thunderbolt-y                  :=3D thunderbolt.o
> > diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typ=
ec/altmodes/thunderbolt.c
> > new file mode 100644
> > index 000000000000..a945b9d35a1d
> > --- /dev/null
> > +++ b/drivers/usb/typec/altmodes/thunderbolt.c
> > @@ -0,0 +1,308 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/**
> > + * USB Typec-C Thuderbolt3 Alternate Mode driver
> > + *
> > + * Copyright (C) 2019 Intel Corporation
> > + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/mutex.h>
> > +#include <linux/module.h>
> > +#include <linux/usb/pd_vdo.h>
> > +#include <linux/usb/typec_altmode.h>
> > +#include <linux/usb/typec_tbt.h>
> > +
> > +enum tbt_state {
> > +     TBT_STATE_IDLE,
> > +     TBT_STATE_SOP_P_ENTER,
> > +     TBT_STATE_SOP_PP_ENTER,
> > +     TBT_STATE_ENTER,
> > +     TBT_STATE_EXIT,
> > +     TBT_STATE_SOP_PP_EXIT,
> > +     TBT_STATE_SOP_P_EXIT
> > +};
> > +
> > +struct tbt_altmode {
> > +     enum tbt_state state;
> > +     struct typec_cable *cable;
> > +     struct typec_altmode *alt;
> > +     struct typec_altmode *plug[2];
> > +     u32 enter_vdo;
> > +
> > +     struct work_struct work;
> > +     struct mutex lock; /* device lock */
> > +};
> > +
> > +static bool tbt_ready(struct typec_altmode *alt);
> > +
> > +static int tbt_enter_mode(struct tbt_altmode *tbt)
> > +{
> > +     struct typec_altmode *plug =3D tbt->plug[TYPEC_PLUG_SOP_P];
> > +     u32 vdo;
> > +
> > +     vdo =3D tbt->alt->vdo & (TBT_VENDOR_SPECIFIC_B0 | TBT_VENDOR_SPEC=
IFIC_B1);
> > +     vdo |=3D tbt->alt->vdo & TBT_INTEL_SPECIFIC_B0;
> > +     vdo |=3D TBT_MODE;
> > +
> > +     if (plug) {
> > +             if (typec_cable_is_active(tbt->cable))
> > +                     vdo |=3D TBT_ENTER_MODE_ACTIVE_CABLE;
> > +
> > +             vdo |=3D TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_SPEED(plug-=
>vdo));
> > +             vdo |=3D plug->vdo & TBT_CABLE_ROUNDED;
> > +             vdo |=3D plug->vdo & TBT_CABLE_OPTICAL;
> > +             vdo |=3D plug->vdo & TBT_CABLE_RETIMER;
> > +             vdo |=3D plug->vdo & TBT_CABLE_LINK_TRAINING;
> > +     } else {
> > +             vdo |=3D TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_USB3_PASSIV=
E);
> > +     }
> > +
> > +     tbt->enter_vdo =3D vdo;
> > +     return typec_altmode_enter(tbt->alt, &vdo);
> > +}
> > +
> > +static void tbt_altmode_work(struct work_struct *work)
> > +{
> > +     struct tbt_altmode *tbt =3D container_of(work, struct tbt_altmode=
, work);
> > +     int ret;
> > +
> > +     mutex_lock(&tbt->lock);
> > +
> > +     switch (tbt->state) {
> > +     case TBT_STATE_SOP_P_ENTER:
> > +             ret =3D typec_altmode_enter(tbt->plug[TYPEC_PLUG_SOP_P], =
NULL);
> > +             if (ret)
> > +                     dev_dbg(&tbt->plug[TYPEC_PLUG_SOP_P]->dev,
> > +                             "failed to enter mode (%d)\n", ret);
> > +             break;
> > +     case TBT_STATE_SOP_PP_ENTER:
> > +             ret =3D typec_altmode_enter(tbt->plug[TYPEC_PLUG_SOP_PP],=
 NULL);
> > +             if (ret)
> > +                     dev_dbg(&tbt->plug[TYPEC_PLUG_SOP_PP]->dev,
> > +                             "failed to enter mode (%d)\n", ret);
> > +             break;
> > +     case TBT_STATE_ENTER:
> > +             ret =3D tbt_enter_mode(tbt);
> > +             if (ret)
> > +                     dev_dbg(&tbt->alt->dev, "failed to enter mode (%d=
)\n",
> > +                             ret);
> > +             break;
> > +     case TBT_STATE_EXIT:
> > +             typec_altmode_exit(tbt->alt);
> > +             break;
> > +     case TBT_STATE_SOP_PP_EXIT:
> > +             typec_altmode_exit(tbt->plug[TYPEC_PLUG_SOP_PP]);
> > +             break;
> > +     case TBT_STATE_SOP_P_EXIT:
> > +             typec_altmode_exit(tbt->plug[TYPEC_PLUG_SOP_P]);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     tbt->state =3D TBT_STATE_IDLE;
> > +
> > +     mutex_unlock(&tbt->lock);
> > +}
> > +
> > +static int tbt_altmode_vdm(struct typec_altmode *alt,
> > +                        const u32 hdr, const u32 *vdo, int count)
> > +{
> > +     struct tbt_altmode *tbt =3D typec_altmode_get_drvdata(alt);
> > +     int cmd_type =3D PD_VDO_CMDT(hdr);
> > +     int cmd =3D PD_VDO_CMD(hdr);
> > +
> > +     mutex_lock(&tbt->lock);
> > +
> > +     if (tbt->state !=3D TBT_STATE_IDLE) {
> > +             mutex_unlock(&tbt->lock);
> > +             return -EBUSY;
> > +     }
> > +
> > +     switch (cmd_type) {
> > +     case CMDT_RSP_ACK:
> > +             switch (cmd) {
> > +             case CMD_ENTER_MODE:
> > +                     /*
> > +                      * Following the order describeded in USB Type-C =
Spec
> > +                      * R2.0 Section 6.7.3.
> > +                      */
> > +                     if (alt =3D=3D tbt->plug[TYPEC_PLUG_SOP_P]) {
> > +                             if (tbt->plug[TYPEC_PLUG_SOP_PP])
> > +                                     tbt->state =3D TBT_STATE_SOP_PP_E=
NTER;
> > +                             else
> > +                                     tbt->state =3D TBT_STATE_ENTER;
> > +                     } else if (alt =3D=3D tbt->plug[TYPEC_PLUG_SOP_PP=
]) {
> > +                             tbt->state =3D TBT_STATE_ENTER;
> > +                     } else {
> > +                             struct typec_thunderbolt_data data;
> > +
> > +                             data.device_mode =3D tbt->alt->vdo;
> > +                             data.cable_mode =3D
> > +                                     tbt->plug[TYPEC_PLUG_SOP_P] ?
> > +                                             tbt->plug[TYPEC_PLUG_SOP_=
P]
> > +                                                     ->vdo :
> > +                                             0;
> > +                             data.enter_vdo =3D tbt->enter_vdo;
> > +
> > +                             typec_altmode_notify(alt, TYPEC_STATE_MOD=
AL, &data);
> > +                     }
> > +                     break;
> > +             case CMD_EXIT_MODE:
> > +                     if (alt =3D=3D tbt->alt) {
> > +                             if (tbt->plug[TYPEC_PLUG_SOP_PP])
> > +                                     tbt->state =3D TBT_STATE_SOP_PP_E=
XIT;
> > +                             else if (tbt->plug[TYPEC_PLUG_SOP_P])
> > +                                     tbt->state =3D TBT_STATE_SOP_P_EX=
IT;
> > +                     } else if (alt =3D=3D tbt->plug[TYPEC_PLUG_SOP_PP=
]) {
> > +                             tbt->state =3D TBT_STATE_SOP_P_EXIT;
> > +                     }
> > +                     break;
> > +             }
> > +             break;
> > +     case CMDT_RSP_NAK:
> > +             switch (cmd) {
> > +             case CMD_ENTER_MODE:
> > +                     dev_warn(&alt->dev, "Enter Mode refused\n");
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     if (tbt->state !=3D TBT_STATE_IDLE)
> > +             schedule_work(&tbt->work);
> > +
> > +     mutex_unlock(&tbt->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static int tbt_altmode_activate(struct typec_altmode *alt, int activat=
e)
> > +{
> > +     struct tbt_altmode *tbt =3D typec_altmode_get_drvdata(alt);
> > +     int ret;
> > +
> > +     mutex_lock(&tbt->lock);
> > +
> > +     if (!tbt_ready(alt))
> > +             return -ENODEV;
>
>
> You need to mutex_unlock(&tbt->lock);  before the return.
>
> Credit to danielgeorgem@google.com for his catching this in his code revi=
ew.

Good catch! Next update will have this.

Sorry for late replies -- it took me a while to get back to this +
refactor to use the new cable ops apis. In the process, I also
discovered some mistakes in how we were entering TBT from .activate so
I opted to follow a similar pattern to what RD has done for DP with
cables.

v4 will come soon.

>
> > +
> > +     /* Preventing the user space from entering/exiting the cable alt =
mode */
> > +     if (alt !=3D tbt->alt)
> > +             ret =3D -EPERM;
> > +     else if (activate)
> > +             ret =3D tbt_enter_mode(tbt);
> > +     else
> > +             ret =3D typec_altmode_exit(alt);
> > +
> > +     mutex_unlock(&tbt->lock);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct typec_altmode_ops tbt_altmode_ops =3D {
> > +     .vdm            =3D tbt_altmode_vdm,
> > +     .activate       =3D tbt_altmode_activate
> > +};
> > +
> > +static int tbt_altmode_probe(struct typec_altmode *alt)
> > +{
> > +     struct tbt_altmode *tbt;
> > +
> > +     tbt =3D devm_kzalloc(&alt->dev, sizeof(*tbt), GFP_KERNEL);
> > +     if (!tbt)
> > +             return -ENOMEM;
> > +
> > +     INIT_WORK(&tbt->work, tbt_altmode_work);
> > +     mutex_init(&tbt->lock);
> > +     tbt->alt =3D alt;
> > +
> > +     alt->desc =3D "Thunderbolt3";
> > +     typec_altmode_set_drvdata(alt, tbt);
> > +     typec_altmode_set_ops(alt, &tbt_altmode_ops);
> > +
> > +     if (tbt_ready(alt)) {
> > +             if (tbt->plug[TYPEC_PLUG_SOP_PP])
> > +                     tbt->state =3D TBT_STATE_SOP_PP_ENTER;
> > +             else if (tbt->plug[TYPEC_PLUG_SOP_P])
> > +                     tbt->state =3D TBT_STATE_SOP_P_ENTER;
> > +             else
> > +                     tbt->state =3D TBT_STATE_ENTER;
> > +             schedule_work(&tbt->work);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void tbt_altmode_remove(struct typec_altmode *alt)
> > +{
> > +     struct tbt_altmode *tbt =3D typec_altmode_get_drvdata(alt);
> > +
> > +     for (int i =3D TYPEC_PLUG_SOP_PP; i > 0; --i) {
> > +             if (tbt->plug[i])
> > +                     typec_altmode_put_plug(tbt->plug[i]);
> > +     }
> > +
> > +     if (tbt->cable)
> > +             typec_cable_put(tbt->cable);
> > +}
> > +
> > +static bool tbt_ready(struct typec_altmode *alt)
> > +{
> > +     struct tbt_altmode *tbt =3D typec_altmode_get_drvdata(alt);
> > +     struct typec_altmode *plug;
> > +
> > +     if (tbt->cable)
> > +             return true;
> > +
> > +     /* Thundebolt 3 requires a cable with eMarker */
> > +     tbt->cable =3D typec_cable_get(typec_altmode2port(tbt->alt));
> > +     if (!tbt->cable)
> > +             return false;
> > +
> > +     /* We accept systems without SOP' or SOP''. This means the port a=
ltmode
> > +      * driver will be responsible for properly ordering entry/exit.
> > +      */
> > +     for (int i =3D 0; i < TYPEC_PLUG_SOP_PP + 1; i++) {
> > +             plug =3D typec_altmode_get_plug(tbt->alt, i);
> > +             if (IS_ERR(plug))
> > +                     continue;
> > +
> > +             if (!plug || plug->svid !=3D USB_TYPEC_VENDOR_INTEL)
> > +                     break;
> > +
> > +             plug->desc =3D "Thunderbolt3";
> > +             plug->ops =3D &tbt_altmode_ops;
> > +             typec_altmode_set_drvdata(plug, tbt);
> > +
> > +             tbt->plug[i] =3D plug;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static const struct typec_device_id tbt_typec_id[] =3D {
> > +     { USB_TYPEC_TBT_SID },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(typec, tbt_typec_id);
> > +
> > +static struct typec_altmode_driver tbt_altmode_driver =3D {
> > +     .id_table =3D tbt_typec_id,
> > +     .probe =3D tbt_altmode_probe,
> > +     .remove =3D tbt_altmode_remove,
> > +     .driver =3D {
> > +             .name =3D "typec-thunderbolt",
> > +             .owner =3D THIS_MODULE,
> > +     }
> > +};
> > +module_typec_altmode_driver(tbt_altmode_driver);
> > +
> > +MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("Thunderbolt3 USB Type-C Alternate Mode");
> > diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tb=
t.h
> > index fa97d7e00f5c..55dcea12082c 100644
> > --- a/include/linux/usb/typec_tbt.h
> > +++ b/include/linux/usb/typec_tbt.h
> > @@ -44,6 +44,7 @@ struct typec_thunderbolt_data {
> >
> >  #define   TBT_GEN3_NON_ROUNDED                 0
> >  #define   TBT_GEN3_GEN4_ROUNDED_NON_ROUNDED    1
> > +#define TBT_CABLE_ROUNDED            BIT(19)
> >  #define TBT_CABLE_OPTICAL            BIT(21)
> >  #define TBT_CABLE_RETIMER            BIT(22)
> >  #define TBT_CABLE_LINK_TRAINING              BIT(23)
> > --
> > 2.47.0.277.g8800431eea-goog
> >
> >

