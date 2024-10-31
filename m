Return-Path: <linux-kernel+bounces-391395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14199B861F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A641C21016
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402861D0157;
	Thu, 31 Oct 2024 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JHzSLQo8"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767891E481
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414116; cv=none; b=KpzW4uBWKavWLSXIAb9ey/JhNcd6KlEabslk05d9OCkW1up+mqnM9RImc4Qn7Xa9C/4xTRIqLYCGc0eiRq3f8nu0hrWnvXlt7ameCzrn/MmRhYkZaJbgS4c/J3468iZAZ8S77cpZP41ZrcHajjlcEOE79Bn8tUwTxHidSqW5pMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414116; c=relaxed/simple;
	bh=gksB+9p7mD3lGcgVSrGwEF4VBHu4ZqFeMnqk9Lgchgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NydtmSeD8bUt9asqK18vuu6O6dwI18Qdk+xae0P+3aD/j9ZBp/TPKaafznb6HdPz3WC9GUzoMt7jmh8/FYtXef1szvk3008HQHraWh4QYdd+R5F57Y13SJyw2PJndJi+2bGITRI2G4RtoGh22BAV3sxNdLMx7tTqh0v1CQi78Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JHzSLQo8; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e2e41bd08bso15584237b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730414108; x=1731018908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/41OVM2xcwWBkow/4jRlYjcEzYW3yWFtXG6Jn1l6IW4=;
        b=JHzSLQo8R907k0uSuwhpk/7b4nDnyvSOVXKjoc0BHxIlsjugRlNUKn368scuYrW2pV
         HQkOOmUmSc/wDp5uJzly3yHuGN2tldvLsJ22zCy0EYJ2nkvYEfK8zxNHM3a6t410BkZu
         qmmK24Sf492IPj0mU32YcnEl1IaqIepEC3L5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414108; x=1731018908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/41OVM2xcwWBkow/4jRlYjcEzYW3yWFtXG6Jn1l6IW4=;
        b=bgRnVF875pAlILiaRmF5nBkocn9rfhxBje3mD5Cinu5BYbg6fBz0sazSb4Zn2vOkie
         0KVxv5fVNqeQd41jJMvttPXvelU4RyVEV5gRSVhggG/nwrB05AslG9f1im2GCjOOpO++
         ePfVZAYiYET7Lwp48eu/jDE5E4ZzlVE6OreE4KqBdiuc7nonIUWAZo/ZHBvmrfYKclbS
         wWZNoL1lp0cufkM8RzzhTXzMbPcdXKROPdqJf1nHKWHWOeRsYb7ibRb2tzrYfQ4O064q
         HJmQaaspiQNNgSmxRbB1ICH+4inKeEQz4qxJPPsvAU68g8LAcrrRlpNW5wOUKxNq0EUx
         kKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Wx4/VVgbfBvaL0Ak/fZIjus2ZdhNZQKbukTvwYwqqcYN0x0YegcK+0SQbSgHSuxO+bZDXvph+WiSdYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCStQ9oK38G5ZjCidAE9+2PO0LffPs4f3jELUnrTSptZUAaTWT
	c1/xKZxxwS8MmI6OVQOOAjVcBo4Wu6ukm2SoergF/bKxxcAKKIwCYHAkVE2QfXbq2gogkCW0A9U
	aIKHkUooODRXU9DQBZxrKqmVGHprxjktwAGzr
X-Google-Smtp-Source: AGHT+IHFBLQx2c6IbqW7eGb36gJpxMLM5wEc1nfmvXVIuDaq5sXJUBYeVuAZVc9cthNIwPqSAsqyKDq6iI9hxMRt5xA=
X-Received: by 2002:a05:690c:e05:b0:6e3:ed8:7f17 with SMTP id
 00721157ae682-6ea64aec9b2mr22493057b3.16.1730414108422; Thu, 31 Oct 2024
 15:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
 <20241030142833.v2.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid> <zrgmtbmln3dyjzi7qsweptmeihijwbe6jqmsg2w2bcnzeaeprs@2u2emyenm23w>
In-Reply-To: <zrgmtbmln3dyjzi7qsweptmeihijwbe6jqmsg2w2bcnzeaeprs@2u2emyenm23w>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Thu, 31 Oct 2024 15:34:56 -0700
Message-ID: <CANFp7mWbtM-fhXEz5Cij+A-z3Tu-S3CvdhUhoX=v6fYn57zSBg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] platform/chrome: cros_ec_typec: Displayport support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, 
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev, jthies@google.com, 
	akuchynski@google.com, pmalani@chromium.org, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 11:54=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, Oct 30, 2024 at 02:28:36PM -0700, Abhishek Pandit-Subedi wrote:
> > Add support for entering and exiting displayport alt-mode on systems
> > using AP driven alt-mode.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Refactored displayport into cros_typec_altmode.c to extract common
> >   implementation between altmodes
>
> Thanks!
>
> >
> >  MAINTAINERS                                  |   3 +
> >  drivers/platform/chrome/Makefile             |   3 +-
> >  drivers/platform/chrome/cros_ec_typec.c      |  13 +-
> >  drivers/platform/chrome/cros_ec_typec.h      |   1 +
> >  drivers/platform/chrome/cros_typec_altmode.c | 277 +++++++++++++++++++
> >  drivers/platform/chrome/cros_typec_altmode.h |  34 +++
> >  6 files changed, 329 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/platform/chrome/cros_typec_altmode.c
> >  create mode 100644 drivers/platform/chrome/cros_typec_altmode.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e9659a5a7fb3..de99bcbda7d4 100644
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
> > index 2dcc6ccc2302..8b007404c024 100644
> > --- a/drivers/platform/chrome/Makefile
> > +++ b/drivers/platform/chrome/Makefile
> > @@ -17,8 +17,9 @@ obj-$(CONFIG_CROS_EC_RPMSG)         +=3D cros_ec_rpms=
g.o
> >  obj-$(CONFIG_CROS_EC_SPI)            +=3D cros_ec_spi.o
> >  obj-$(CONFIG_CROS_EC_UART)           +=3D cros_ec_uart.o
> >  cros_ec_lpcs-objs                    :=3D cros_ec_lpc.o cros_ec_lpc_me=
c.o
> > -cros-ec-typec-objs                   :=3D cros_ec_typec.o cros_typec_v=
dm.o
> > +cros-ec-typec-objs                   :=3D cros_ec_typec.o cros_typec_v=
dm.o cros_typec_altmode.o
> >  obj-$(CONFIG_CROS_EC_TYPEC)          +=3D cros-ec-typec.o
> > +
> >  obj-$(CONFIG_CROS_EC_LPC)            +=3D cros_ec_lpcs.o
> >  obj-$(CONFIG_CROS_EC_PROTO)          +=3D cros_ec_proto.o cros_ec_trac=
e.o
> >  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT) +=3D cros_kbd_led_backlight.o
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform=
/chrome/cros_ec_typec.c
> > index 0c8db11bd8a4..7997e7136c4c 100644
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
> > @@ -293,12 +294,16 @@ static int cros_typec_register_port_altmodes(stru=
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
> > +
> > +#if !IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
> >       typec_altmode_set_drvdata(amode, port);
> >       amode->ops =3D &port_amode_ops;
> > +#endif
> >
> >       /*
> >        * Register TBT compatibility alt mode. The EC will not enter the=
 mode
> > @@ -575,6 +580,10 @@ static int cros_typec_enable_dp(struct cros_typec_=
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
> > @@ -1254,6 +1263,8 @@ static int cros_typec_probe(struct platform_devic=
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
> > index 000000000000..af2f077674f1
> > --- /dev/null
> > +++ b/drivers/platform/chrome/cros_typec_altmode.c
> > @@ -0,0 +1,277 @@
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
> > +struct cros_typec_dp_data {
> > +     struct typec_displayport_data data;
> > +
> > +     bool configured;
> > +     bool pending_status_update;
> > +};
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
> > +
> > +     union am_specific {
> > +             struct cros_typec_dp_data dp;
> > +     } am_data;
>
> Can this be done other way around?
>
> struct cros_typec_dp_altmode_data {
>   struct cros_typec_altmode_data base;
>   struct cros_typec_dp_data dp;
> };

Ack -- expect in the next patch series.

>
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
> > +     struct cros_typec_altmode_data *adata =3D typec_altmode_get_drvda=
ta(alt);
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
> > +                     adata->am_data.dp.data.conf =3D *data;
> > +                     adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> > +                     adata->am_data.dp.configured =3D true;
> > +                     schedule_work(&adata->work);
> > +                     break;
> > +             case DP_CMD_STATUS_UPDATE:
> > +                     adata->am_data.dp.pending_status_update =3D true;
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
> > +     struct cros_typec_altmode_data *adata =3D
> > +             typec_altmode_get_drvdata(altmode);
> > +
> > +     if (!adata->am_data.dp.pending_status_update) {
> > +             dev_dbg(&altmode->dev,
> > +                     "Got DPStatus without a pending request");
> > +             return 0;
> > +     }
> > +
> > +     if (adata->am_data.dp.configured && adata->am_data.dp.data.conf !=
=3D data->conf)
> > +             dev_dbg(&altmode->dev,
> > +                     "DP Conf doesn't match. Requested 0x%04x, Actual =
0x%04x",
> > +                     adata->am_data.dp.data.conf, data->conf);
> > +
> > +     adata->am_data.dp.data =3D *data;
> > +     adata->am_data.dp.pending_status_update =3D false;
> > +     adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> > +     adata->vdo_data =3D &adata->am_data.dp.data.status;
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
> > +     data->sid =3D USB_TYPEC_DP_SID;
> > +     data->mode =3D USB_TYPEC_DP_MODE;
> > +
> > +     data->am_data.dp.configured =3D false;
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
> > 2.47.0.163.g1226f6d8fa-goog
> >
>
> --
> With best wishes
> Dmitry

