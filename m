Return-Path: <linux-kernel+bounces-408659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B999C81AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A75F281E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 04:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA711E7C16;
	Thu, 14 Nov 2024 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JjwOXvFh"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC505154C0B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556931; cv=none; b=izrZSFImIvPHVdM6VXZFJtgASnSRgmVPeHqwY5XZbJf19eCsXg71W1vTZOwrt2S9s8gnNuaQBd9CGmrPF6mbyXuwJJl4mYlNqfSeUOadnf6e1AWYzFK1LwM5sy8ntFEVTkOTQLiysvHb7SJcTtmrVz0TJdgWkr1DTbcVf7Q2B/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556931; c=relaxed/simple;
	bh=YJ/PNFMy7eytH2sdc6qw3KJg3cs9o0CXw8z9D3SJjxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbVVJyCerduxgwN1Zoj0McuS13qoAKGziCcMePIQv+lwvs/5ZH3FCZF+A9PX+eticSSez2WExG2xKr02/tf6XrsUVxAHcuDuxLT+5K48zZ1AiCkImBspj7oKm6UH6UOBvPoJTev8//EXh4Y0DtML41g9/shOGLW2ZX+gqPG76lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JjwOXvFh; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e29218d34f8so88629276.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731556928; x=1732161728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0sNye+maLIdSg0lsRIzTAqeOAvvkwvAnWjJVGRFi10=;
        b=JjwOXvFhHbzGX7aTf+rNSk7W9tloID2PbkV+VJ+558r7G6YXIsHGDyWHQAsmAXTex0
         3AbsdOWRtg3gEq7uElUEKRCwroqemAiVwIXUqjgoById51kWNv8PTeBfOpiXtzmOpfLo
         8TZWjieGh8nIhrGhTMg/DR/BIp0HtdR4s/DQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731556928; x=1732161728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0sNye+maLIdSg0lsRIzTAqeOAvvkwvAnWjJVGRFi10=;
        b=YpFayxVAgNZ8De/ahaqDKgWuXrhbcytpNcAVtGWO2ZNlvST7XYz/kcpkYJuDVPJICP
         NTiTL5RJA3eWacOYxb9YTRpzvCVuwh8tcPjaXiriUiGCib0SZL+C/kZ9kEfKRIcInc0u
         MI0DQCBkDcuzrofkbbCB/ZZr5tNjEX1YqWpoayDm2vG8AxC6QSdQOlDOREvOo/oaTN24
         /vjWI9n755RZ2rPVf0EjC5QL/u92G/YxUao1C0EYvVSsgwkI4Aqh2RYRlBlqucPe8NOt
         Ol55ONRj2m+kP7z1xwY6fHiAlZiupACEvbvBCZKKjXieeiZOrBy7cJ5fBrE3JVee7xiC
         OL2w==
X-Forwarded-Encrypted: i=1; AJvYcCUUPn8JJ8F3H2mHI/g620e/oqI1oHPba0wFWBn+xdGHOszmjiL+J5HWmjBL8Fa8DATal6AX3ztFAagY+gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJ5ugErf4W8a/DrZBA4QeH7f7CqEpjUKKb+16PmhACr1jDYjz
	L8CA0jX2QMg6h4v2MiV7P+A6Os02dIbqRDjFfafX+bEP9fArLckjbSIXIN2uanQoloc1iZhsqQS
	YgUx5BjjJtKvmAQmRRgHTZ4+U0Vy57w8zCB/K
X-Google-Smtp-Source: AGHT+IFcKUJEq0oxNZf9Q26L6Km225GEC702ST90PsWorQv9GhFUlo1KdTT2fsTlwmnBXKHbcMoRHaKDPM0ei/6fIMA=
X-Received: by 2002:a25:83ce:0:b0:e2b:d6c4:5543 with SMTP id
 3f1490d57ef6-e380e26f847mr1889344276.22.1731556927830; Wed, 13 Nov 2024
 20:02:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107193021.2690050-1-abhishekpandit@chromium.org>
 <20241107112955.v3.6.Ic61ced3cdfb5d6776435356061f12307da719829@changeid> <zbtwtfywopvuh5b6skzxf53if7s7lxf53x6uxqnenpe3mipsdg@zdk7wfp7mqbg>
In-Reply-To: <zbtwtfywopvuh5b6skzxf53if7s7lxf53x6uxqnenpe3mipsdg@zdk7wfp7mqbg>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Wed, 13 Nov 2024 20:01:57 -0800
Message-ID: <CANFp7mVDpi_g=9LiDZ1mu+GHwkmLVXf7_MnOewFs-Zvu9gqLUQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] platform/chrome: cros_ec_typec: Thunderbolt support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, 
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev, jthies@google.com, 
	akuchynski@google.com, pmalani@chromium.org, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 10:41=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, Nov 07, 2024 at 11:29:59AM -0800, Abhishek Pandit-Subedi wrote:
> > Add support for entering and exiting Thunderbolt alt-mode using AP
> > driven alt-mode.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Fix usage of TBT sid and mode.
> > - Removed unused vdm operations during altmode registration
> >
> > Changes in v2:
> > - Refactored thunderbolt support into cros_typec_altmode.c
> >
> >  drivers/platform/chrome/Makefile             |  3 +
> >  drivers/platform/chrome/cros_ec_typec.c      | 23 +++---
> >  drivers/platform/chrome/cros_typec_altmode.c | 85 ++++++++++++++++++++
> >  drivers/platform/chrome/cros_typec_altmode.h | 14 ++++
> >  4 files changed, 114 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome=
/Makefile
> > index 2f90d4db8099..b9b1281de063 100644
> > --- a/drivers/platform/chrome/Makefile
> > +++ b/drivers/platform/chrome/Makefile
> > @@ -21,6 +21,9 @@ cros-ec-typec-objs                  :=3D cros_ec_type=
c.o cros_typec_vdm.o
> >  ifneq ($(CONFIG_TYPEC_DP_ALTMODE),)
> >       cros-ec-typec-objs              +=3D cros_typec_altmode.o
> >  endif
> > +ifneq ($(CONFIG_TYPEC_TBT_ALTMODE),)
> > +     cros-ec-typec-objs              +=3D cros_typec_altmode.o
> > +endif
>
> Doesn't this also result in the object file being included twice and
> thus in a duplicate symbols declaration?

I was trying to figure out how to add this file if either of those
config options existed in
https://docs.kernel.org/kbuild/makefiles.html#built-in-object-goals-obj-y
and it says, "Duplicates in the lists are allowed: the first instance
will be linked into built-in.a and succeeding instances will be
ignored."

Is there a preferred way of doing the following in the Makefile:
    if (defined(CONFIG_TYPEC_TBT_ALTMODE) ||
defined(CONFIG_TYPEC_DP_ALTMODE)) {...}

I briefly considered the following and dropped it because it is
terrible readability-wise:
  ifneq ($(CONFIG_TYPEC_TBT_ALTMODE)$(CONFIG_TYPEC_DP_ALTMODE),)

>
> >  obj-$(CONFIG_CROS_EC_TYPEC)          +=3D cros-ec-typec.o
> >
> >  obj-$(CONFIG_CROS_EC_LPC)            +=3D cros_ec_lpcs.o
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform=
/chrome/cros_ec_typec.c
> > index 3a6f5f2717b9..558b618df63c 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -302,18 +302,19 @@ static int cros_typec_register_port_altmodes(stru=
ct cros_typec_data *typec,
> >
> >       /*
> >        * Register TBT compatibility alt mode. The EC will not enter the=
 mode
> > -      * if it doesn't support it, so it's safe to register it uncondit=
ionally
> > -      * here for now.
> > +      * if it doesn't support it and it will not enter automatically b=
y
> > +      * design so we can use the |ap_driven_altmode| feature to check =
if we
> > +      * should register it.
> >        */
> > -     memset(&desc, 0, sizeof(desc));
> > -     desc.svid =3D USB_TYPEC_TBT_SID;
> > -     desc.mode =3D TYPEC_ANY_MODE;
> > -     amode =3D typec_port_register_altmode(port->port, &desc);
> > -     if (IS_ERR(amode))
> > -             return PTR_ERR(amode);
> > -     port->port_altmode[CROS_EC_ALTMODE_TBT] =3D amode;
> > -     typec_altmode_set_drvdata(amode, port);
> > -     amode->ops =3D &port_amode_ops;
> > +     if (typec->ap_driven_altmode) {
> > +             memset(&desc, 0, sizeof(desc));
> > +             desc.svid =3D USB_TYPEC_TBT_SID;
> > +             desc.mode =3D TBT_MODE;
> > +             amode =3D cros_typec_register_thunderbolt(port, &desc);
> > +             if (IS_ERR(amode))
> > +                     return PTR_ERR(amode);
> > +             port->port_altmode[CROS_EC_ALTMODE_TBT] =3D amode;
> > +     }
> >
> >       port->state.alt =3D NULL;
> >       port->state.mode =3D TYPEC_STATE_USB;
> > diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/pla=
tform/chrome/cros_typec_altmode.c
> > index 3598b8a6ceee..9cf2cef6c277 100644
> > --- a/drivers/platform/chrome/cros_typec_altmode.c
> > +++ b/drivers/platform/chrome/cros_typec_altmode.c
> > @@ -8,6 +8,7 @@
> >  #include "cros_ec_typec.h"
> >
> >  #include <linux/usb/typec_dp.h>
> > +#include <linux/usb/typec_tbt.h>
> >  #include <linux/usb/pd_vdo.h>
> >
> >  #include "cros_typec_altmode.h"
> > @@ -67,6 +68,8 @@ static int cros_typec_altmode_enter(struct typec_altm=
ode *alt, u32 *vdo)
> >
> >       if (data->sid =3D=3D USB_TYPEC_DP_SID)
> >               req.mode_to_enter =3D CROS_EC_ALTMODE_DP;
> > +     else if (data->sid =3D=3D USB_TYPEC_TBT_SID)
> > +             req.mode_to_enter =3D CROS_EC_ALTMODE_TBT;
> >       else
> >               return -EOPNOTSUPP;
> >
> > @@ -196,6 +199,53 @@ static int cros_typec_displayport_vdm(struct typec=
_altmode *alt, u32 header,
> >       return 0;
> >  }
> >
> > +static int cros_typec_thunderbolt_vdm(struct typec_altmode *alt, u32 h=
eader,
> > +                                   const u32 *data, int count)
> > +{
> > +     struct cros_typec_altmode_data *adata =3D typec_altmode_get_drvda=
ta(alt);
> > +
> > +     int cmd_type =3D PD_VDO_CMDT(header);
> > +     int cmd =3D PD_VDO_CMD(header);
> > +     int svdm_version;
>
> I suppose that with the current approach this misses the ap_mode_entry
> check. If it gets moved to cros_typec_altmode_vdm(), then it should be
> okay.

We don't register the thunderbolt port driver if ap_mode_entry is
false so it's an unnecessary check.

>
> > +
> > +     svdm_version =3D typec_altmode_get_svdm_version(alt);
> > +     if (svdm_version < 0)
> > +             return svdm_version;
> > +
> > +     switch (cmd_type) {
> > +     case CMDT_INIT:
> > +             if (PD_VDO_SVDM_VER(header) < svdm_version) {
> > +                     typec_partner_set_svdm_version(adata->port->partn=
er,
> > +                                                    PD_VDO_SVDM_VER(he=
ader));
> > +                     svdm_version =3D PD_VDO_SVDM_VER(header);
> > +             }
> > +
> > +             adata->header =3D VDO(adata->sid, 1, svdm_version, cmd);
> > +             adata->header |=3D VDO_OPOS(adata->mode);
> > +
> > +             switch (cmd) {
> > +             case CMD_ENTER_MODE:
> > +                     /* Don't respond to the enter mode vdm because it
> > +                      * triggers mux configuration. This is handled di=
rectly
> > +                      * by the cros_ec_typec driver so the Thunderbolt=
 driver
> > +                      * doesn't need to be involved.
> > +                      */
> > +                     break;
> > +             default:
> > +                     adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> > +                     schedule_work(&adata->work);
> > +                     break;
> > +             }
> > +
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +
> >  static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 heade=
r,
> >                                     const u32 *data, int count)
> >  {
> > @@ -204,6 +254,9 @@ static int cros_typec_altmode_vdm(struct typec_altm=
ode *alt, u32 header,
> >       if (adata->sid =3D=3D USB_TYPEC_DP_SID)
> >               return cros_typec_displayport_vdm(alt, header, data, coun=
t);
> >
> > +     if (adata->sid =3D=3D USB_TYPEC_TBT_SID)
> > +             return cros_typec_thunderbolt_vdm(alt, header, data, coun=
t);
> > +
> >       return -EINVAL;
> >  }
> >
> > @@ -273,3 +326,35 @@ cros_typec_register_displayport(struct cros_typec_=
port *port,
> >       return alt;
> >  }
> >  #endif
> > +
> > +#if IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
> > +struct typec_altmode *
> > +cros_typec_register_thunderbolt(struct cros_typec_port *port,
> > +                             struct typec_altmode_desc *desc)
> > +{
> > +     struct typec_altmode *alt;
> > +     struct cros_typec_altmode_data *data;
> > +
> > +     alt =3D typec_port_register_altmode(port->port, desc);
> > +     if (IS_ERR(alt))
> > +             return alt;
> > +
> > +     data =3D devm_kzalloc(&alt->dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data) {
> > +             typec_unregister_altmode(alt);
> > +             return ERR_PTR(-ENOMEM);
> > +     }
> > +
> > +     INIT_WORK(&data->work, cros_typec_altmode_work);
> > +     data->alt =3D alt;
> > +     data->port =3D port;
> > +     data->ap_mode_entry =3D true;
> > +     data->sid =3D desc->svid;
> > +     data->mode =3D desc->mode;
> > +
> > +     typec_altmode_set_ops(alt, &cros_typec_altmode_ops);
> > +     typec_altmode_set_drvdata(alt, data);
> > +
> > +     return alt;
> > +}
> > +#endif
> > diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/pla=
tform/chrome/cros_typec_altmode.h
> > index c6f8fb02c99c..810b553ddcd8 100644
> > --- a/drivers/platform/chrome/cros_typec_altmode.h
> > +++ b/drivers/platform/chrome/cros_typec_altmode.h
> > @@ -31,4 +31,18 @@ static inline int cros_typec_displayport_status_upda=
te(struct typec_altmode *alt
> >       return 0;
> >  }
> >  #endif
> > +
> > +#if IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
> > +struct typec_altmode *
> > +cros_typec_register_thunderbolt(struct cros_typec_port *port,
> > +                             struct typec_altmode_desc *desc);
> > +#else
> > +static inline struct typec_altmode *
> > +cros_typec_register_thunderbolt(struct cros_typec_port *port,
> > +                             struct typec_altmode_desc *desc)
> > +{
> > +     return typec_port_register_altmode(port->port, desc);
> > +}
> > +#endif
> > +
> >  #endif /* __CROS_TYPEC_ALTMODE_H__ */
> > --
> > 2.47.0.277.g8800431eea-goog
> >
>
> --
> With best wishes
> Dmitry

