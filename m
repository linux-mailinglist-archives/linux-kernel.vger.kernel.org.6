Return-Path: <linux-kernel+bounces-408665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6D89C81CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3829B2497A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 04:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843A313D53E;
	Thu, 14 Nov 2024 04:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hJzd+n1/"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568BC1DFD82
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731557620; cv=none; b=FrLCRXQVhe2Sy78vRbdgS18rCiCW0WDNsnDYjaz+jg8O6Bqrpxa5Mvfp7kLviF9RDyBUqQktiTqGheM+fTS4iUnNFTbmes9nVn7bpJF0dRir4tTgiYAE2dtF+DzfNw2t+/A8ZRqPMd+y/JEKXxfR4bhuvTYfgv2XpH6qt4+T/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731557620; c=relaxed/simple;
	bh=3mU0scaUGgUWKX1hRn8jmxW57wc0bnS23LU8ZpyRDOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMiU5zqKUAZTTApZzX9YhigWq5yIAKIsOQxKaIiw0/gTqJ+Ji/wGihhSeDe/Og2Xlwz65n2YwFcxhWdidhgIDBUbBpWINgTT261h2SfLuJbwmcuQh52Kz71u+tnToW1/IZj+4Bpg++KqQ/YKl7GGDP6b/26GlAmSF0+3P20xul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hJzd+n1/; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea339a41f1so2125177b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731557617; x=1732162417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44Q/aPbFlYhVCXSzrBx+bv3Dj1qvfzdZYziElmalgMY=;
        b=hJzd+n1/98qOPegsFPypkSiwCQ3BBBObjoRRfy8GgxXpcBna1bIIGHAAGvZv6P+1OE
         zZIAFLA8vutGXHbulQw5FakhbiZ9r6YRwjRzPueG7asjrmPs0pgxDn02bwopxyARKdQm
         gSvFsSBx85O+nUNZzf0pHqs1MFMteuObLABtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731557617; x=1732162417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44Q/aPbFlYhVCXSzrBx+bv3Dj1qvfzdZYziElmalgMY=;
        b=gaeIcO2kfP0hePqHKfrAJcYRJcTykuaAQl/9ONsxzDCsTqzULXkFavQGDi6r1CO4D/
         OEZb4RASVc8Ex4xU8gIs+rCxLu4UxpUuBrWH45giUPlnD7qYaGsyzV2L2khBX51kSxR8
         OTGWM/uic3WLcz9Y3maUmr0qeEAbcomnz78qK8J3oKNxABvm8c+THZ0wHTage6ah/s55
         OBNZf4Lp/FGt/c4mxu4iIpVoeTuFfmg9cBpUWcO5EVJRVVRgXeMr+CHBIJLK0by5J3dT
         XY7FL0y7DAO3c/WAIDhV3imlv2e48nDHvsvT5GuGLUFvJ5pmj2Xn9rpWaiQ67yb+/69Y
         6IjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTsDtaQxiCcCjSkduijwD2N9R3eNa6Rpu7UO+4v3F5S8rGO+fCJvX25WmMxohRCviVpgarQXHpTFE1d2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnryRFipWiRgPRKAvhBiYZH3jeqzUyY4MbEqMO7U3KO88b3GN
	NdkTOOGWgO8PKroLX7YZ6IAYaxhbEZDWWpYbfoNi9/FSn5vO6swJU0ynC5NTGMQYNS+gun1zM9p
	KGvgAtjORag5N3wSa9QUgrY+WS2D2GTowN0i8
X-Google-Smtp-Source: AGHT+IFr37e4CByWxx6+FYDal+xuEhbfifrWuNble58xdLv1E8aRPTSzhtXgwuQQAe5rI2nq4FqOa+rt7iShMbOZ+gI=
X-Received: by 2002:a05:690c:3810:b0:6ea:3075:1fb5 with SMTP id
 00721157ae682-6ecb345ee5emr67440367b3.33.1731557617298; Wed, 13 Nov 2024
 20:13:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107193021.2690050-1-abhishekpandit@chromium.org>
 <20241107112955.v3.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid> <7qqbf6hgonsk7zusbljdgamneqkec5yxpr6bewr4aeyhpxcjao@yevfpcsg6r52>
In-Reply-To: <7qqbf6hgonsk7zusbljdgamneqkec5yxpr6bewr4aeyhpxcjao@yevfpcsg6r52>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Wed, 13 Nov 2024 20:13:26 -0800
Message-ID: <CANFp7mWvxK5DWJZBqHdJJmjo_X5n5NJv+mZ7U5FQ4Aj7-VRpSw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] platform/chrome: cros_ec_typec: Displayport support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, 
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev, jthies@google.com, 
	akuchynski@google.com, pmalani@chromium.org, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 10:38=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, Nov 07, 2024 at 11:29:58AM -0800, Abhishek Pandit-Subedi wrote:
> > Add support for entering and exiting displayport alt-mode on systems
> > using AP driven alt-mode.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Refactored typec_altmode_dp_data per review request
> > - Removed unused vdm operations during altmode registration
> >
> > Changes in v2:
> > - Refactored displayport into cros_typec_altmode.c to extract common
> >   implementation between altmodes
> >
> >  MAINTAINERS                                  |   3 +
> >  drivers/platform/chrome/Makefile             |   4 +
> >  drivers/platform/chrome/cros_ec_typec.c      |  12 +-
> >  drivers/platform/chrome/cros_ec_typec.h      |   1 +
> >  drivers/platform/chrome/cros_typec_altmode.c | 275 +++++++++++++++++++
> >  drivers/platform/chrome/cros_typec_altmode.h |  34 +++
> >  6 files changed, 326 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/platform/chrome/cros_typec_altmode.c
> >  create mode 100644 drivers/platform/chrome/cros_typec_altmode.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cd6aa609deba..5f9d8b8f1cb3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5369,9 +5369,12 @@ F:     include/linux/platform_data/cros_usbpd_no=
tify.h
> >
> >  CHROMEOS EC USB TYPE-C DRIVER
> >  M:   Prashant Malani <pmalani@chromium.org>
> > +M:   Benson Leung <bleung@chromium.org>
> > +M:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >  L:   chrome-platform@lists.linux.dev
> >  S:   Maintained
> >  F:   drivers/platform/chrome/cros_ec_typec.*
> > +F:   drivers/platform/chrome/cros_typec_altmode.*
> >  F:   drivers/platform/chrome/cros_typec_switch.c
> >  F:   drivers/platform/chrome/cros_typec_vdm.*
> >
> > diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome=
/Makefile
> > index 2dcc6ccc2302..2f90d4db8099 100644
> > --- a/drivers/platform/chrome/Makefile
> > +++ b/drivers/platform/chrome/Makefile
> > @@ -18,7 +18,11 @@ obj-$(CONFIG_CROS_EC_SPI)          +=3D cros_ec_spi.=
o
> >  obj-$(CONFIG_CROS_EC_UART)           +=3D cros_ec_uart.o
> >  cros_ec_lpcs-objs                    :=3D cros_ec_lpc.o cros_ec_lpc_me=
c.o
> >  cros-ec-typec-objs                   :=3D cros_ec_typec.o cros_typec_v=
dm.o
> > +ifneq ($(CONFIG_TYPEC_DP_ALTMODE),)
> > +     cros-ec-typec-objs              +=3D cros_typec_altmode.o
> > +endif
> >  obj-$(CONFIG_CROS_EC_TYPEC)          +=3D cros-ec-typec.o
> > +
> >  obj-$(CONFIG_CROS_EC_LPC)            +=3D cros_ec_lpcs.o
> >  obj-$(CONFIG_CROS_EC_PROTO)          +=3D cros_ec_proto.o cros_ec_trac=
e.o
> >  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT) +=3D cros_kbd_led_backlight.o
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform=
/chrome/cros_ec_typec.c
> > index e3eabe5e42ac..3a6f5f2717b9 100644
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
> > @@ -293,12 +294,11 @@ static int cros_typec_register_port_altmodes(stru=
ct cros_typec_data *typec,
> >       desc.svid =3D USB_TYPEC_DP_SID;
> >       desc.mode =3D USB_TYPEC_DP_MODE;
> >       desc.vdo =3D DP_PORT_VDO;
> > -     amode =3D typec_port_register_altmode(port->port, &desc);
> > +     amode =3D cros_typec_register_displayport(port, &desc,
> > +                                             typec->ap_driven_altmode)=
;
> >       if (IS_ERR(amode))
> >               return PTR_ERR(amode);
> >       port->port_altmode[CROS_EC_ALTMODE_DP] =3D amode;
> > -     typec_altmode_set_drvdata(amode, port);
> > -     amode->ops =3D &port_amode_ops;
> >
> >       /*
> >        * Register TBT compatibility alt mode. The EC will not enter the=
 mode
> > @@ -575,6 +575,10 @@ static int cros_typec_enable_dp(struct cros_typec_=
data *typec,
> >       if (!ret)
> >               ret =3D typec_mux_set(port->mux, &port->state);
> >
> > +     if (!ret)
> > +             cros_typec_displayport_status_update(port->state.alt,
> > +                                                  port->state.data);
> > +
> >       return ret;
> >  }
> >
> > @@ -1254,6 +1258,8 @@ static int cros_typec_probe(struct platform_devic=
e *pdev)
> >
> >       typec->typec_cmd_supported =3D cros_ec_check_features(ec_dev, EC_=
FEATURE_TYPEC_CMD);
> >       typec->needs_mux_ack =3D cros_ec_check_features(ec_dev, EC_FEATUR=
E_TYPEC_MUX_REQUIRE_AP_ACK);
> > +     typec->ap_driven_altmode =3D cros_ec_check_features(
> > +             ec_dev, EC_FEATURE_TYPEC_REQUIRE_AP_MODE_ENTRY);
> >
> >       ret =3D cros_ec_cmd(typec->ec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
> >                         &resp, sizeof(resp));
> > diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform=
/chrome/cros_ec_typec.h
> > index deda180a646f..9fd5342bb0ad 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.h
> > +++ b/drivers/platform/chrome/cros_ec_typec.h
> > @@ -39,6 +39,7 @@ struct cros_typec_data {
> >       struct work_struct port_work;
> >       bool typec_cmd_supported;
> >       bool needs_mux_ack;
> > +     bool ap_driven_altmode;
> >  };
> >
> >  /* Per port data. */
> > diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/pla=
tform/chrome/cros_typec_altmode.c
> > new file mode 100644
> > index 000000000000..3598b8a6ceee
> > --- /dev/null
> > +++ b/drivers/platform/chrome/cros_typec_altmode.c
> > @@ -0,0 +1,275 @@
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
> > +
> > +#include "cros_typec_altmode.h"
> > +
> > +struct cros_typec_altmode_data {
> > +     struct work_struct work;
> > +     struct cros_typec_port *port;
> > +     struct typec_altmode *alt;
> > +     bool ap_mode_entry;
> > +
> > +     u32 header;
> > +     u32 *vdo_data;
> > +     u8 vdo_size;
> > +
> > +     u16 sid;
> > +     u8 mode;
> > +};
> > +
> > +struct cros_typec_dp_data {
> > +     struct cros_typec_altmode_data adata;
> > +     struct typec_displayport_data data;
> > +     bool configured;
> > +     bool pending_status_update;
> > +};
> > +
> > +static void cros_typec_altmode_work(struct work_struct *work)
> > +{
> > +     struct cros_typec_altmode_data *data =3D
> > +             container_of(work, struct cros_typec_altmode_data, work);
> > +
> > +     if (typec_altmode_vdm(data->alt, data->header, data->vdo_data,
> > +                           data->vdo_size))
> > +             dev_err(&data->alt->dev, "VDM 0x%x failed", data->header)=
;
> > +
> > +     data->header =3D 0;
> > +     data->vdo_data =3D NULL;
> > +     data->vdo_size =3D 0;
>
> What protects data->header / vdo_data / vdo_size from concurrent
> modification?

Good catch! This needs a mutex -- will add for the next series.

>
> > +}
> > +
> > +static int cros_typec_altmode_enter(struct typec_altmode *alt, u32 *vd=
o)
> > +{
> > +     struct cros_typec_altmode_data *data =3D typec_altmode_get_drvdat=
a(alt);
> > +     struct ec_params_typec_control req =3D {
> > +             .port =3D data->port->port_num,
> > +             .command =3D TYPEC_CONTROL_COMMAND_ENTER_MODE,
> > +     };
> > +     int svdm_version;
> > +     int ret;
> > +
> > +     if (!data->ap_mode_entry) {
> > +             const struct typec_altmode *partner =3D
> > +                     typec_altmode_get_partner(alt);
> > +             dev_warn(&partner->dev,
> > +                      "EC does not support ap driven mode entry\n");
>
> Nit: AP, not ap

Ack for next series.

>
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (data->sid =3D=3D USB_TYPEC_DP_SID)
> > +             req.mode_to_enter =3D CROS_EC_ALTMODE_DP;
> > +     else
> > +             return -EOPNOTSUPP;
> > +
> > +     ret =3D cros_ec_cmd(data->port->typec_data->ec, 0, EC_CMD_TYPEC_C=
ONTROL,
> > +                       &req, sizeof(req), NULL, 0);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     svdm_version =3D typec_altmode_get_svdm_version(alt);
> > +     if (svdm_version < 0)
> > +             return svdm_version;
> > +
> > +     data->header =3D VDO(data->sid, 1, svdm_version, CMD_ENTER_MODE);
> > +     data->header |=3D VDO_OPOS(data->mode);
> > +     data->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> > +
> > +     data->vdo_data =3D NULL;
> > +     data->vdo_size =3D 1;
> > +
> > +     schedule_work(&data->work);
> > +
> > +     return ret;
> > +}
> > +
> > +static int cros_typec_altmode_exit(struct typec_altmode *alt)
> > +{
> > +     struct cros_typec_altmode_data *data =3D typec_altmode_get_drvdat=
a(alt);
> > +     struct ec_params_typec_control req =3D {
> > +             .port =3D data->port->port_num,
> > +             .command =3D TYPEC_CONTROL_COMMAND_EXIT_MODES,
> > +     };
> > +     int svdm_version;
> > +     int ret;
> > +
> > +     if (!data->ap_mode_entry) {
> > +             const struct typec_altmode *partner =3D
> > +                     typec_altmode_get_partner(alt);
> > +             dev_warn(&partner->dev,
> > +                      "EC does not support ap driven mode entry\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     ret =3D cros_ec_cmd(data->port->typec_data->ec, 0, EC_CMD_TYPEC_C=
ONTROL,
> > +                       &req, sizeof(req), NULL, 0);
> > +
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     svdm_version =3D typec_altmode_get_svdm_version(alt);
> > +     if (svdm_version < 0)
> > +             return svdm_version;
> > +
> > +     data->header =3D VDO(data->sid, 1, svdm_version, CMD_EXIT_MODE);
> > +     data->header |=3D VDO_OPOS(data->mode);
> > +     data->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> > +
> > +     data->vdo_data =3D NULL;
> > +     data->vdo_size =3D 1;
> > +
> > +     schedule_work(&data->work);
> > +
> > +     return ret;
> > +}
> > +
> > +static int cros_typec_displayport_vdm(struct typec_altmode *alt, u32 h=
eader,
> > +                                   const u32 *data, int count)
> > +{
> > +     struct cros_typec_dp_data *dp_data =3D typec_altmode_get_drvdata(=
alt);
> > +     struct cros_typec_altmode_data *adata =3D &dp_data->adata;
> > +
> > +
> > +     int cmd_type =3D PD_VDO_CMDT(header);
> > +     int cmd =3D PD_VDO_CMD(header);
> > +     int svdm_version;
> > +
> > +     if (!adata->ap_mode_entry) {
> > +             const struct typec_altmode *partner =3D
> > +                     typec_altmode_get_partner(alt);
> > +             dev_warn(&partner->dev,
> > +                      "EC does not support ap driven mode entry\n");
> > +             return -EOPNOTSUPP;
> > +     }
>
> Move the ckeck to cros_typec_altmode_vdm() ?
>
> But this makes me wonder, should the driver use different ops in such a
> case? Can't we just use a stubbed version of ops if
> cros_typec_register_displayport() gets ap_mode_entry =3D false ?
>

I could leave out `.vdm` in typec_altmode_ops and I'd get the same
result (-ENOTSUPP) but without the warning message. That'll remove the
need to store the bool entirely. Expect it next series -- thanks!

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
> > +             /*
> > +              * DP_CMD_CONFIGURE: We can't actually do anything with t=
he
> > +              * provided VDO yet so just send back an ACK.
> > +              *
> > +              * DP_CMD_STATUS_UPDATE: We wait for Mux changes to send
> > +              * DPStatus Acks.
> > +              */
> > +             switch (cmd) {
> > +             case DP_CMD_CONFIGURE:
> > +                     dp_data->data.conf =3D *data;
> > +                     adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> > +                     dp_data->configured =3D true;
> > +                     schedule_work(&adata->work);
> > +                     break;
> > +             case DP_CMD_STATUS_UPDATE:
> > +                     dp_data->pending_status_update =3D true;
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
> > +static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 heade=
r,
> > +                                   const u32 *data, int count)
> > +{
> > +     struct cros_typec_altmode_data *adata =3D typec_altmode_get_drvda=
ta(alt);
> > +
> > +     if (adata->sid =3D=3D USB_TYPEC_DP_SID)
> > +             return cros_typec_displayport_vdm(alt, header, data, coun=
t);
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static const struct typec_altmode_ops cros_typec_altmode_ops =3D {
> > +     .enter =3D cros_typec_altmode_enter,
> > +     .exit =3D cros_typec_altmode_exit,
> > +     .vdm =3D cros_typec_altmode_vdm,
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
> > +int cros_typec_displayport_status_update(struct typec_altmode *altmode=
,
> > +                                      struct typec_displayport_data *d=
ata)
> > +{
> > +     struct cros_typec_dp_data *dp_data =3D
> > +             typec_altmode_get_drvdata(altmode);
> > +     struct cros_typec_altmode_data *adata =3D &dp_data->adata;
> > +
> > +     if (!dp_data->pending_status_update) {
> > +             dev_dbg(&altmode->dev,
> > +                     "Got DPStatus without a pending request");
> > +             return 0;
> > +     }
> > +
> > +     if (dp_data->configured && dp_data->data.conf !=3D data->conf)
> > +             dev_dbg(&altmode->dev,
> > +                     "DP Conf doesn't match. Requested 0x%04x, Actual =
0x%04x",
> > +                     dp_data->data.conf, data->conf);
> > +
> > +     dp_data->data =3D *data;
> > +     dp_data->pending_status_update =3D false;
> > +     adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> > +     adata->vdo_data =3D &dp_data->data.status;
> > +     adata->vdo_size =3D 2;
> > +
> > +     schedule_work(&adata->work);
> > +     return 0;
> > +}
> > +
> > +struct typec_altmode *
> > +cros_typec_register_displayport(struct cros_typec_port *port,
> > +                             struct typec_altmode_desc *desc,
> > +                             bool ap_mode_entry)
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
> > +     data->ap_mode_entry =3D ap_mode_entry;
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
> > new file mode 100644
> > index 000000000000..c6f8fb02c99c
> > --- /dev/null
> > +++ b/drivers/platform/chrome/cros_typec_altmode.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef __CROS_TYPEC_ALTMODE_H__
> > +#define __CROS_TYPEC_ALTMODE_H__
> > +
> > +struct cros_typec_port;
> > +struct typec_altmode;
> > +struct typec_altmode_desc;
> > +struct typec_displayport_data;
> > +
> > +#if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
> > +struct typec_altmode *
> > +cros_typec_register_displayport(struct cros_typec_port *port,
> > +                             struct typec_altmode_desc *desc,
> > +                             bool ap_mode_entry);
> > +
> > +int cros_typec_displayport_status_update(struct typec_altmode *altmode=
,
> > +                                      struct typec_displayport_data *d=
ata);
> > +#else
> > +static inline struct typec_altmode *
> > +cros_typec_register_displayport(struct cros_typec_port *port,
> > +                             struct typec_altmode_desc *desc,
> > +                             bool ap_mode_entry)
> > +{
> > +     return typec_port_register_altmode(port->port, desc);
> > +}
> > +
> > +static inline int cros_typec_displayport_status_update(struct typec_al=
tmode *altmode,
> > +                                      struct typec_displayport_data *d=
ata)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +#endif /* __CROS_TYPEC_ALTMODE_H__ */
> > --
> > 2.47.0.277.g8800431eea-goog
> >
>
> --
> With best wishes
> Dmitry

