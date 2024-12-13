Return-Path: <linux-kernel+bounces-445352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C268D9F14F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D8F285254
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607941E47DB;
	Fri, 13 Dec 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Shm9nV5M"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509171E883A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114606; cv=none; b=u6wYVB42Fl2ThKsCoroD2h9Y/UUSJ3HeOaDWjbYb8b6KvNHEP2Yn63BhyKNLnvnXh6oNBO75ZU4s4m6Z276Nn1hv96URRsR65/2U0TpSMTOnJieX2hdnjJmQTy3VcUum6vcAwWvOAnpI3bMYdYZy/GPJo7wj5RoSX2QDV4+Pru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114606; c=relaxed/simple;
	bh=aWd18ZwsBXDoMhJQGSXNqymKnTH67wiZpgP1TgurVWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PV64jHCxgTYPG7NAJvKPXdEv15njOdDqosS8LuXvmb7QFSVAq+3VzXI83lKvz4NVf0GoUjRZDD9OpstGnLg+An+djqnzOpigh3fBmJ2xLROATMllS12BB6TN/JzG2pm+466FlExcD+ROFyN2MdxlWodLAqHtTs9KLPcG7Vvfh3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Shm9nV5M; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e39841c8fd6so1572560276.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734114603; x=1734719403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qfx9dVZRYyvAe+To+1Ux5w/pFeuMxXKQcObZK/xVCVY=;
        b=Shm9nV5MoA4KjM5wQaYkUo/uKAqvwoo4NfBvC8fL8J7hbW9m+m/AkT84tz0yRiCQUn
         ZOzwD7uMTF2SHkVUt2skaVLLaQYodsYV/mttus2c1dTocTIb90aPReG21S0Lg/OTsqkk
         HQmOyDd0/b81bA1y2Rp2z3JZXMG+DRjgwInds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734114603; x=1734719403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qfx9dVZRYyvAe+To+1Ux5w/pFeuMxXKQcObZK/xVCVY=;
        b=J641M2K4jPoY6bovFJPYDrNHQ0OBjhWbY/y0ylLTLYGTiXCnPYrGEgpFMBV0jB9Jtp
         X+QKuOSJAC5KvOlsqEFZkgtnoDvxMqIH/+in4ulbLyq4fx4evc9BIZJOhG+FKe2NG6tJ
         /48yB82QBTdjgtTSCOxhKG4bKcyeteoHSZOiZH3vkPKk8Mo2xuSHSDzRdit4ABuhUvaN
         ZoemIJDVNh6hPz4QbTLY5XRWeABTJBpUeVKxCReG0p8g5oDyC1MMD6zMFf/f5+kPYTQd
         6M0Cimphvu+9sDlbfaztTtpYcoxaDkVl8RwgQR7CNW41h1B8wCUK6Z6Vtj94QCDT1O1Q
         94TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXawQ+g6NeDpX7SE9U0w8FQ9vYhFC00erKHjeTqpwykkCNXiobxFtbNm4JtXsEiviIP0RfKn8ntdLLaM1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hZkwr0vpWTYrDYadQo0UWQRUkXsy4oCqBkNePvyzyYGG05xw
	akPy05HtIfkCucnPN8e/Gh7byDJKW9Xs0/dO63nkXc78Vj9t1WbgxcLyW3oXmtNX+I69r/1KykL
	na87+zlvWEs6gyEcf4T+I3iU1vHdaK3H40Y+V/rrVGETy/lg=
X-Gm-Gg: ASbGncuhmaHYtY28As8pIqgKbK6MXEjnKFqG94SGhEFDD2S7SK/RJ/7PTlC3TXMyf4t
	W6A+wNge7Bo82Ot0DLar1OaVjePfpXvrSoQ0aoQ==
X-Google-Smtp-Source: AGHT+IFJ4dFSQDlXbVhPLTWFaIYL2rQaeo5jGI63gUMvA4/VuSC5JCDiVmi0DKqC5WQq1y6AJNdeNW9v1vPfFGnBp+w=
X-Received: by 2002:a05:6902:2303:b0:e39:59b6:4202 with SMTP id
 3f1490d57ef6-e434aee7cd3mr3570434276.22.1734114603255; Fri, 13 Dec 2024
 10:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206233830.2401638-1-abhishekpandit@chromium.org>
 <20241206153813.v4.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid> <CAE-0n513GoDKW7mA_rjCLsgZZFq=CEb5S8WLYr2rskq8fJW9LA@mail.gmail.com>
In-Reply-To: <CAE-0n513GoDKW7mA_rjCLsgZZFq=CEb5S8WLYr2rskq8fJW9LA@mail.gmail.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Fri, 13 Dec 2024 10:29:51 -0800
Message-ID: <CANFp7mU=wjXc6FrdzWT5oe25wtZnxOXvpVmbMqeVhOeEUchpcA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] platform/chrome: cros_ec_typec: Displayport support
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, heikki.krogerus@linux.intel.com, 
	linux-usb@vger.kernel.org, tzungbi@kernel.org, akuchynski@google.com, 
	pmalani@chromium.org, jthies@google.com, dmitry.baryshkov@linaro.org, 
	badhri@google.com, rdbabiera@google.com, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:08=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> Quoting Abhishek Pandit-Subedi (2024-12-06 15:38:16)
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform=
/chrome/cros_ec_typec.c
> > index e3eabe5e42ac..0f3bc335f583 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -18,6 +18,7 @@
> >
> >  #include "cros_ec_typec.h"
> >  #include "cros_typec_vdm.h"
> > +#include "cros_typec_altmode.h"
> >
> >  #define DRV_NAME "cros-ec-typec"
> >
> > @@ -290,15 +291,15 @@ static int cros_typec_register_port_altmodes(stru=
ct cros_typec_data *typec,
> >         struct typec_altmode *amode;
> >
> >         /* All PD capable CrOS devices are assumed to support DP altmod=
e. */
> > +       memset(&desc, 0, sizeof(desc));
> >         desc.svid =3D USB_TYPEC_DP_SID;
> >         desc.mode =3D USB_TYPEC_DP_MODE;
> >         desc.vdo =3D DP_PORT_VDO;
> > -       amode =3D typec_port_register_altmode(port->port, &desc);
> > +       amode =3D cros_typec_register_displayport(port, &desc,
> > +                                               typec->ap_driven_altmod=
e);
> >         if (IS_ERR(amode))
> >                 return PTR_ERR(amode);
> >         port->port_altmode[CROS_EC_ALTMODE_DP] =3D amode;
> > -       typec_altmode_set_drvdata(amode, port);
> > -       amode->ops =3D &port_amode_ops;
> >
> >         /*
> >          * Register TBT compatibility alt mode. The EC will not enter t=
he mode
> > @@ -575,6 +576,10 @@ static int cros_typec_enable_dp(struct cros_typec_=
data *typec,
> >         if (!ret)
> >                 ret =3D typec_mux_set(port->mux, &port->state);
> >
> > +       if (!ret)
> > +               cros_typec_displayport_status_update(port->state.alt,
>
> Should we forward the return value from here?
Done

>
> > +                                                    port->state.data);
> > +
> >         return ret;
> >  }
> >
> > @@ -1254,6 +1259,8 @@ static int cros_typec_probe(struct platform_devic=
e *pdev)
> >
> >         typec->typec_cmd_supported =3D cros_ec_check_features(ec_dev, E=
C_FEATURE_TYPEC_CMD);
> >         typec->needs_mux_ack =3D cros_ec_check_features(ec_dev, EC_FEAT=
URE_TYPEC_MUX_REQUIRE_AP_ACK);
> > +       typec->ap_driven_altmode =3D cros_ec_check_features(
> > +               ec_dev, EC_FEATURE_TYPEC_REQUIRE_AP_MODE_ENTRY);
> >
> >         ret =3D cros_ec_cmd(typec->ec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
> >                           &resp, sizeof(resp));
> > diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform=
/chrome/cros_ec_typec.h
> > index deda180a646f..9fd5342bb0ad 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.h
> > +++ b/drivers/platform/chrome/cros_ec_typec.h
> > @@ -39,6 +39,7 @@ struct cros_typec_data {
> >         struct work_struct port_work;
> >         bool typec_cmd_supported;
> >         bool needs_mux_ack;
> > +       bool ap_driven_altmode;
>
> Do we need to stash this? Can we cros_ec_check_features() in
> cros_typec_init_ports() and pass the bool to
> cros_typec_register_port_altmodes() instead to save a struct member?

We don't need to stash this but it keeps the feature checks
consistently in `cros_typec_probe`.

>
> >  };
> >
> >  /* Per port data. */
> > diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/pla=
tform/chrome/cros_typec_altmode.c
> > new file mode 100644
> > index 000000000000..bb7c7ad2ff6e
> > --- /dev/null
> > +++ b/drivers/platform/chrome/cros_typec_altmode.c
> > @@ -0,0 +1,281 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Alt-mode implementation on ChromeOS EC.
> > + *
> > + * Copyright 2024 Google LLC
> > + * Author: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > + */
> > +#include "cros_ec_typec.h"
> > +
> > +#include <linux/usb/typec_dp.h>
> > +#include <linux/usb/pd_vdo.h>
>
> Please include workqueue.h, mutex.h, etc. for things used in this file.
Done. Btw, is there a script that does this for you in the kernel like
include-what-you-use does for userspace?

>
> > +
> > +#include "cros_typec_altmode.h"
> > +
> > +struct cros_typec_altmode_data {
> > +       struct work_struct work;
> > +       struct cros_typec_port *port;
> > +       struct typec_altmode *alt;
> > +       bool ap_mode_entry;
>
> The UCSI driver (drivers/usb/typec/ucsi/displayport.c) calls this
> 'override', can it be named the same thing? I also see that the UCSI
> driver has two bools, 'override' and 'initialized', which seems to be to
> support a DP_CMD_CONFIGURE that will respond with an ACK and then the
> next DP_CMD_CONFIGURE will call ucsi_altmode_update_active() to set the
> altmode as active. Maybe the same method can be followed here so that on
> older chromebooks where EC is in control of mode entry we can emulate
> entering the mode?

The reason it's called `override` in UCSI is because the feature is
called "alternate mode override supported". When this optional bit is
set, the UCSI method "SET_NEW_CAM" can be used to change what
alternate mode is active. However, it behaves differently from cros_ec
because even when override is set, the PD controller can/will still
autonomously enter a mode on connection. Whereas on cros_ec_typec, if
you set "ap-driven-mode", the EC will not enter any modes until the AP
tells it to.

Also, the reason the UCSI driver does the DP_CMD_CONFIGURE dance is
because the UCSI command, SET_NEW_CAM, requires the DP configuration
VDO as a parameter. Since UCSI doesn't define a VDM mechanism, the
UCSI driver fakes the ".entry" call and then uses the first
DP_CONFIGURE to do the actual entry. This also doesn't match the
cros_ec driver (either ap-driven or not) because the interface does
not allow setting the DP VDO at all. DP_CONFIGURE will be generated
and consumed entirely within the EC and all we can really use is the
mux update to generate a status update for the DP state machine.

Right now, EC driven Chromebooks will simply report active/inactive
for DP without reporting any configuration/status info. If you want to
handle DP_CONFIGURE and DP_STATUS from the altmode driver, you'll need
to fake the interactions in the port driver in a subsequent CL.

>
> > +
> > +       struct mutex lock;
> > +       u32 header;
> > +       u32 *vdo_data;
> > +       u8 vdo_size;
> > +
> > +       u16 sid;
> > +       u8 mode;
> > +};
> > +
> > +struct cros_typec_dp_data {
> > +       struct cros_typec_altmode_data adata;
> > +       struct typec_displayport_data data;
> > +       bool configured;
> > +       bool pending_status_update;
> > +};
> > +
> > +static void cros_typec_altmode_work(struct work_struct *work)
> > +{
> > +       struct cros_typec_altmode_data *data =3D
> > +               container_of(work, struct cros_typec_altmode_data, work=
);
> > +
> > +       mutex_lock(&data->lock);
> > +
> > +       if (typec_altmode_vdm(data->alt, data->header, data->vdo_data,
> > +                             data->vdo_size))
> > +               dev_err(&data->alt->dev, "VDM 0x%x failed", data->heade=
r);
>
> These printks need newlines.
Done.

>
>                dev_err(&data->alt->dev, "VDM 0x%x failed\n", data->header=
);
>
> > +
> > +       data->header =3D 0;
> > +       data->vdo_data =3D NULL;
> > +       data->vdo_size =3D 0;
> > +
> > +       mutex_unlock(&data->lock);
> > +}
> > +
> > +static int cros_typec_altmode_enter(struct typec_altmode *alt, u32 *vd=
o)
> > +{
> > +       struct cros_typec_altmode_data *data =3D typec_altmode_get_drvd=
ata(alt);
> > +       struct ec_params_typec_control req =3D {
> > +               .port =3D data->port->port_num,
> > +               .command =3D TYPEC_CONTROL_COMMAND_ENTER_MODE,
> > +       };
> > +       int svdm_version;
> > +       int ret;
> > +
> > +       if (!data->ap_mode_entry) {
> > +               dev_warn(&alt->dev,
> > +                        "EC does not support AP driven mode entry\n");
>
> Like this one.
>
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       if (data->sid =3D=3D USB_TYPEC_DP_SID)
> > +               req.mode_to_enter =3D CROS_EC_ALTMODE_DP;
> > +       else
> > +               return -EOPNOTSUPP;
> > +
> > +       ret =3D cros_ec_cmd(data->port->typec_data->ec, 0, EC_CMD_TYPEC=
_CONTROL,
>
> Do we plan to delete drivers/platform/chrome/cros_typec_vdm.c file at
> some point? I ask because 'port_amode_ops' becomes unused after this
> series.

Yes - I don't think we ever launched with the VDM request/response
feature enabled. I was going to do it as a follow-up to this CL to
handle attention.

>
> > +                         &req, sizeof(req), NULL, 0);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       svdm_version =3D typec_altmode_get_svdm_version(alt);
> > +       if (svdm_version < 0)
> > +               return svdm_version;
> > +
> > +       mutex_lock(&data->lock);
> > +
> > +       data->header =3D VDO(data->sid, 1, svdm_version, CMD_ENTER_MODE=
);
> > +       data->header |=3D VDO_OPOS(data->mode);
> > +       data->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> > +       data->vdo_data =3D NULL;
> > +       data->vdo_size =3D 1;
> > +       schedule_work(&data->work);
> > +
> > +       mutex_unlock(&data->lock);
> > +       return ret;
> > +}
> > +
> > +static int cros_typec_altmode_exit(struct typec_altmode *alt)
> > +{
> > +       struct cros_typec_altmode_data *data =3D typec_altmode_get_drvd=
ata(alt);
> > +       struct ec_params_typec_control req =3D {
> > +               .port =3D data->port->port_num,
> > +               .command =3D TYPEC_CONTROL_COMMAND_EXIT_MODES,
> > +       };
> > +       int svdm_version;
> > +       int ret;
> > +
> > +       if (!data->ap_mode_entry) {
> > +               dev_warn(&alt->dev,
> > +                        "EC does not support AP driven mode exit\n");
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       ret =3D cros_ec_cmd(data->port->typec_data->ec, 0, EC_CMD_TYPEC=
_CONTROL,
> > +                         &req, sizeof(req), NULL, 0);
> > +
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       svdm_version =3D typec_altmode_get_svdm_version(alt);
> > +       if (svdm_version < 0)
> > +               return svdm_version;
> > +
> > +       mutex_lock(&data->lock);
> > +
> > +       data->header =3D VDO(data->sid, 1, svdm_version, CMD_EXIT_MODE)=
;
> > +       data->header |=3D VDO_OPOS(data->mode);
> > +       data->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> > +       data->vdo_data =3D NULL;
> > +       data->vdo_size =3D 1;
> > +       schedule_work(&data->work);
> > +
> > +       mutex_unlock(&data->lock);
> > +       return ret;
> > +}
> > +
> > +static int cros_typec_displayport_vdm(struct typec_altmode *alt, u32 h=
eader,
> > +                                     const u32 *data, int count)
> > +{
> > +       struct cros_typec_dp_data *dp_data =3D typec_altmode_get_drvdat=
a(alt);
> > +       struct cros_typec_altmode_data *adata =3D &dp_data->adata;
> > +
> > +
> > +       int cmd_type =3D PD_VDO_CMDT(header);
> > +       int cmd =3D PD_VDO_CMD(header);
> > +       int svdm_version;
> > +
> > +       svdm_version =3D typec_altmode_get_svdm_version(alt);
> > +       if (svdm_version < 0)
> > +               return svdm_version;
> > +
> > +       mutex_lock(&adata->lock);
> > +
> > +       switch (cmd_type) {
> > +       case CMDT_INIT:
> > +               if (PD_VDO_SVDM_VER(header) < svdm_version) {
> > +                       typec_partner_set_svdm_version(adata->port->par=
tner,
> > +                                                      PD_VDO_SVDM_VER(=
header));
> > +                       svdm_version =3D PD_VDO_SVDM_VER(header);
> > +               }
> > +
> > +               adata->header =3D VDO(adata->sid, 1, svdm_version, cmd)=
;
> > +               adata->header |=3D VDO_OPOS(adata->mode);
> > +
> > +               /*
> > +                * DP_CMD_CONFIGURE: We can't actually do anything with=
 the
> > +                * provided VDO yet so just send back an ACK.
> > +                *
> > +                * DP_CMD_STATUS_UPDATE: We wait for Mux changes to sen=
d
> > +                * DPStatus Acks.
> > +                */
> > +               switch (cmd) {
> > +               case DP_CMD_CONFIGURE:
> > +                       dp_data->data.conf =3D *data;
> > +                       adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> > +                       dp_data->configured =3D true;
> > +                       schedule_work(&adata->work);
> > +                       break;
> > +               case DP_CMD_STATUS_UPDATE:
> > +                       dp_data->pending_status_update =3D true;
> > +                       break;
> > +               default:
> > +                       adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> > +                       schedule_work(&adata->work);
> > +                       break;
> > +               }
> > +
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       mutex_unlock(&adata->lock);
> > +       return 0;
> > +}
> > +
> > +static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 heade=
r,
> > +                                     const u32 *data, int count)
> > +{
> > +       struct cros_typec_altmode_data *adata =3D typec_altmode_get_drv=
data(alt);
> > +
> > +       if (!adata->ap_mode_entry)
> > +               return -EOPNOTSUPP;
> > +
> > +       if (adata->sid =3D=3D USB_TYPEC_DP_SID)
> > +               return cros_typec_displayport_vdm(alt, header, data, co=
unt);
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static const struct typec_altmode_ops cros_typec_altmode_ops =3D {
> > +       .enter =3D cros_typec_altmode_enter,
> > +       .exit =3D cros_typec_altmode_exit,
> > +       .vdm =3D cros_typec_altmode_vdm,
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
> > +int cros_typec_displayport_status_update(struct typec_altmode *altmode=
,
> > +                                        struct typec_displayport_data =
*data)
> > +{
> > +       struct cros_typec_dp_data *dp_data =3D
> > +               typec_altmode_get_drvdata(altmode);
> > +       struct cros_typec_altmode_data *adata =3D &dp_data->adata;
> > +
> > +       if (!dp_data->pending_status_update) {
> > +               dev_dbg(&altmode->dev,
> > +                       "Got DPStatus without a pending request");
> > +               return 0;
> > +       }
> > +
> > +       if (dp_data->configured && dp_data->data.conf !=3D data->conf)
> > +               dev_dbg(&altmode->dev,
> > +                       "DP Conf doesn't match. Requested 0x%04x, Actua=
l 0x%04x",
> > +                       dp_data->data.conf, data->conf);
> > +
> > +       mutex_lock(&adata->lock);
> > +
> > +       dp_data->data =3D *data;
> > +       dp_data->pending_status_update =3D false;
> > +       adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> > +       adata->vdo_data =3D &dp_data->data.status;
> > +       adata->vdo_size =3D 2;
> > +       schedule_work(&adata->work);
> > +
> > +       mutex_unlock(&adata->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +struct typec_altmode *
> > +cros_typec_register_displayport(struct cros_typec_port *port,
> > +                               struct typec_altmode_desc *desc,
> > +                               bool ap_mode_entry)
> > +{
> > +       struct typec_altmode *alt;
> > +       struct cros_typec_altmode_data *data;
>
> Can you name it 'adata' consistently? That makes it easy to search for
> 'adata' in this file and know it's always talking about a struct
> cros_typec_altmode_data type of data.
Done

>
> > +
> > +       alt =3D typec_port_register_altmode(port->port, desc);
> > +       if (IS_ERR(alt))
> > +               return alt;
> > +
> > +       data =3D devm_kzalloc(&alt->dev, sizeof(*data), GFP_KERNEL);
> > +       if (!data) {
> > +               typec_unregister_altmode(alt);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> > +       INIT_WORK(&data->work, cros_typec_altmode_work);
> > +       mutex_init(&data->lock);
> > +       data->alt =3D alt;
> > +       data->port =3D port;
> > +       data->ap_mode_entry =3D ap_mode_entry;
> > +       data->sid =3D desc->svid;
> > +       data->mode =3D desc->mode;
> > +
> > +       typec_altmode_set_ops(alt, &cros_typec_altmode_ops);
> > +       typec_altmode_set_drvdata(alt, data);
> > +
> > +       return alt;
> > +}
> > +#endif
> > diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/pla=
tform/chrome/cros_typec_altmode.h
> > new file mode 100644
> > index 000000000000..c6f8fb02c99c
> > --- /dev/null
> > +++ b/drivers/platform/chrome/cros_typec_altmode.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef __CROS_TYPEC_ALTMODE_H__
> > +#define __CROS_TYPEC_ALTMODE_H__
>
> #include <linux/kconfig.h> for IS_ENABLED()
> #include <linux/usb/typec.h> for typec_port_register_altmode()
Done

>
> > +
> > +struct cros_typec_port;
> > +struct typec_altmode;
> > +struct typec_altmode_desc;
> > +struct typec_displayport_data;
> > +
> > +#if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
> > +struct typec_altmode *
> > +cros_typec_register_displayport(struct cros_typec_port *port,
> > +                               struct typec_altmode_desc *desc,
> > +                               bool ap_mode_entry);
> > +
> > +int cros_typec_displayport_status_update(struct typec_altmode *altmode=
,
> > +                                        struct typec_displayport_data =
*data);
> > +#else
> > +static inline struct typec_altmode *
> > +cros_typec_register_displayport(struct cros_typec_port *port,
> > +                               struct typec_altmode_desc *desc,
> > +                               bool ap_mode_entry)
> > +{
> > +       return typec_port_register_altmode(port->port, desc);
> > +}

