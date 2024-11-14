Return-Path: <linux-kernel+bounces-408654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6CB9C8190
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 04:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58767281378
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699701E7C15;
	Thu, 14 Nov 2024 03:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X6fsf508"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601D346BF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556326; cv=none; b=byXOI13vwqUxAvS3Ba/xDKbjP4b++bTb20Lg+ktxr/2w5/cKjPGvRkqOoJox0/h12fcVmFp/bylfn0/5YozBXU5zmIcmZyBijRYsK2/1My7A8rZHSu+4750Vpz+TITQiO2qwBYpE3CwIRpEzb2KGHIw4VGskQhbYxdLgHgRrSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556326; c=relaxed/simple;
	bh=5o2YpYmDQeqiBEmx9tAheREWAmB4OWaaGWTu9mSzmzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1vJG3HLM9TYrXASBzAOCZg2QZgfPYU14DCf+BQBZKr+v/ZOmKckVpKqE8Yl0zz2wo+80CyxzZHqkZxwZM5iqXtDOHtrenh2dOX2qEi4rPUw/yKCXERTwMtTovwLB9vhgu0ZW8AgmrEPtNkFNjeCJ4lVpTN6Wmd5bx7Um8SmdGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X6fsf508; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ea053b5929so2138907b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731556323; x=1732161123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZt/NxUk7vzqYHQvDk9IbF5sHUc+agHdf7TzbJdSgxs=;
        b=X6fsf508wfQhn1ZfvFAJJkV86RrtEbueTW20j4UfCz6tdy+K4svKg80iPJ9MJ4sYPV
         u+aTkb1GMQJLN/jh9kIleGX453mV3TvpKF/j7c+OFiZrUAnoJi/eGt5NbMNMk1a+HVKh
         7vq7Zl4raJt+tG7/KaPq2+o0ws1N6c4aZIGP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731556323; x=1732161123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZt/NxUk7vzqYHQvDk9IbF5sHUc+agHdf7TzbJdSgxs=;
        b=sowUFiHbmWpelLe1SzO2MYUsAM03Zv8CLQ1WXvc3ylilm80XTVcrpEp4J00bSQFDO+
         WMZ1Lqs0lTYNFSZSUErbB+SE/rW0pZJtdAhXp1cWsGVehkSrdn7yviEJsW78d1DMgcPc
         UWCePlILCjXyI1WPGs3rcC6Zt4lOdHVQgzoD08kk4nSncDFU4zdcdV8HWS8Z1FCwpstB
         oBqwH6zgchgcupAPJXZ9nwndG0UPwv2g9QTJbieMnhW1Drbbnr4D/vT1BJDnfj2M9ukE
         xZHcFt3BaWcLQhruKB1rfeZCKFeaiZ1UKX3xH4GbULk2oOb/32mbwlt88PSfPgfLyIQL
         VOpg==
X-Forwarded-Encrypted: i=1; AJvYcCWslzDPMKv1srZs7vtXtjTthLFxVAJcHa4MEeKwE109AZS+Lp4Nf17GQ8KD7+YrqXeeid/C1Nl5Nu0xGOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzizRcReOUp6C9nH8OGdSelxivtN8Ml6BkjgJKNE/sfXU97PMJe
	b+wXXR3E9GdKjZgv+rLRD7pCZu828zwQ0Jt/epvMtsMHUJPN6i1VtxHbsQNSWlIz9NmFQ22bwGQ
	smRPZqFE5zhIWLMVgo3Q5/g3warDURsorXmKP
X-Google-Smtp-Source: AGHT+IEUsedTREynMQobbHqMRP3fSHTT1USVWKnO0D2n/CaITF5lbTm0T2Ri4v3nHPeW85lm1SuKBjpf/ccKaBLPvU4=
X-Received: by 2002:a05:690c:6f81:b0:6e2:313a:a01e with SMTP id
 00721157ae682-6ee433f12a3mr7993557b3.32.1731556323306; Wed, 13 Nov 2024
 19:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107193021.2690050-1-abhishekpandit@chromium.org>
 <20241107112955.v3.2.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid> <iywsqdf2lzrd2fs3ipw4aykjjliirei556kuyr22a24ht6r74x@bwprbwk26prs>
In-Reply-To: <iywsqdf2lzrd2fs3ipw4aykjjliirei556kuyr22a24ht6r74x@bwprbwk26prs>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Wed, 13 Nov 2024 19:51:52 -0800
Message-ID: <CANFp7mWpDHim9ibL0rQQqUjY5-irjJuTAHuo+39CHP0QqEzgQg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] usb: typec: Add driver for Thunderbolt 3 Alternate Mode
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, 
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev, jthies@google.com, 
	akuchynski@google.com, pmalani@chromium.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 10:21=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
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
>
> typec_cable_altmode_enter() ?
>
> > +             if (ret)
> > +                     dev_dbg(&tbt->plug[TYPEC_PLUG_SOP_P]->dev,
> > +                             "failed to enter mode (%d)\n", ret);
> > +             break;
> > +     case TBT_STATE_SOP_PP_ENTER:
> > +             ret =3D typec_altmode_enter(tbt->plug[TYPEC_PLUG_SOP_PP],=
 NULL);
>
> typec_cable_altmode_enter() ?
>
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
>
> I'd say, please move the -> vdo to the previous line, otherwise it's a
> bit unreadable.
>
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
>
> !=3D USB_TYPEC_TBT_SID
>
> > +                     break;
> > +
> > +             plug->desc =3D "Thunderbolt3";
> > +             plug->ops =3D &tbt_altmode_ops;
>
> Should this be plug->cable_ops ?
>
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
>
> Should not be necessary, it is set by __typec_altmode_register_driver()
>
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
>
> --
> With best wishes
> Dmitry

Will address all comments in the next series.

The cable alt-modes are new to me. Looking at the implementation, one
part confuses me -- it looks like cable alt-modes expect the partner
to already be active when entering
(https://github.com/torvalds/linux/blob/master/drivers/usb/typec/bus.c#L272=
).
I'll reach out to the author of cable altmodes to see how to integrate
this correctly with the current series.

