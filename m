Return-Path: <linux-kernel+bounces-404930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53AD9C4A88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752002816FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8D370820;
	Tue, 12 Nov 2024 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1H4jOx7c"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A023774
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370605; cv=none; b=oebyPrCOXTGzlOab6EO1vmDS8aKK0LJzyYvD1G5jcyWB+Z6HvzTg/rMwNK99TVBie9yXACrnqYmTkZmb1fhO8lwweLapRIABeenGLZpgjy3t/VUUevzOrx5W9oL8BbyDfezO2s0FugYsbtG590LjXot0er9RqIYFyaDc5Di4Zas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370605; c=relaxed/simple;
	bh=2vLFfyUQ/dpoi4iaOhGymGFCB+H3Nw5IZsGfOK7p+uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8g2lt3GJ24J3eqT9ccFsOGqFfc37th1kgzS8TRC+k4uXIvWVBix+Hm9a2+OccqasAlGKAugZ4Zs3GRYvSQNusFb9mV/l/ONkffVhFqZGObarrjdnczRkBFuvq5r7TXs+IESJBKyMJfJBTTmH3Nr+HPCWeqp6Gd0Lmde9iVTb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1H4jOx7c; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso3772283b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731370603; x=1731975403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+2d0eRXAkmyV5CZ3mOiKq9e9pd057IakuTB3MH2vmA=;
        b=1H4jOx7cZNMR9mrg54O354dM/u2VuQN0+Q9SnPpZFRNc5HeufGj2fPIF2rH0Td6XV3
         Hm3PGyTk7U0gySiD6tKvIelwrfmkkif1UZO+nmaynD3qsEfz0dPolqI3fWZ63yqmtfTQ
         QjLQLme/iHhDOz3EjlwxqAR959vmz32jDjMCQcE+VMxvp8l1Pg62MQ+fXAi/pq9gWZLq
         L6VpYj0IkvFZ/tHAhw/Ct+o+p5+RnpPGmWo4h5odMgIReLWcv1ZyKBZqSA3sW4In00Gg
         aeR79vL9pCYNvtznQT/3Kp5ntI8aPrzhSiGpX85opNi5wQzBReOxzV/n9sxUYHX+kAJN
         bnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731370603; x=1731975403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+2d0eRXAkmyV5CZ3mOiKq9e9pd057IakuTB3MH2vmA=;
        b=A8mtLQdPGbeWw2Rjr3SIMys35Lam9eBghLuPF6QcqlXSDERcbq/JLX+pSqracK9/fi
         pGNIR7Uj0WJpRWnLMi/fGX7+92Oy4oiJZpB43C+ZuRZeowTAsgFqUDi5fzXQu6454Pus
         cWG4bKJs/k27H0KHOrGMPvQ5qFMztAe1aveB7GS4uuw8aYts5jNo3Oa1clAw4idCDr7R
         08/uvDVJENYLhkaX8Cn+v2dt18TvUyyPY4Zcbqw1qn4j53VdJeFiFjEuVXFnRt86R2Gc
         I1/1Niup57zkzU1FxJ5B8Bsu+hj/47ChrnvJFu51JTWLtGCKy7HzFjFj4YxlC9JejWcv
         QygA==
X-Forwarded-Encrypted: i=1; AJvYcCXSQNcXLstomkstV8cAn/V0B6PtPL44bTMVVlu4/duA4uYV/DqLjjiVox/viCs9aXloQxoeRFl+V504Yt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOqdSQ4QQ1Q2aDrynPtWtHHyNEJOz4U+wZS7RjOOnGm8dxU+KG
	4uvdgpuW2WlPR7VX7ESEsUISBLDpr0+eMrtkURo/O0pX1a3n9MIUr4xK3bPQTA==
X-Google-Smtp-Source: AGHT+IFFQ16YUGU0HvK+6FX4i6bZ/TSJ11PAHRPpiKERpyPzLBFyV3i8gjTUxLB+FIJoAL6eKQnapw==
X-Received: by 2002:a05:6a00:230a:b0:71e:108e:9c16 with SMTP id d2e1a72fcca58-724132c73a8mr19604190b3a.12.1731370602151;
        Mon, 11 Nov 2024 16:16:42 -0800 (PST)
Received: from google.com (30.176.125.34.bc.googleusercontent.com. [34.125.176.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078bfccfsm9886763b3a.82.2024.11.11.16.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 16:16:41 -0800 (PST)
Date: Tue, 12 Nov 2024 00:16:37 +0000
From: Benson Leung <bleung@google.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org,
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev,
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
	dmitry.baryshkov@linaro.org, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] platform/chrome: cros_ec_typec: Displayport
 support
Message-ID: <ZzKeZQfbxeZNDVzE@google.com>
References: <20241107193021.2690050-1-abhishekpandit@chromium.org>
 <20241107112955.v3.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TbHvfp6kUy+f6lxN"
Content-Disposition: inline
In-Reply-To: <20241107112955.v3.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>


--TbHvfp6kUy+f6lxN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

On Thu, Nov 07, 2024 at 11:29:58AM -0800, Abhishek Pandit-Subedi wrote:
> Add support for entering and exiting displayport alt-mode on systems
> using AP driven alt-mode.
>=20
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>=20
> Changes in v3:
> - Refactored typec_altmode_dp_data per review request
> - Removed unused vdm operations during altmode registration
>=20
> Changes in v2:
> - Refactored displayport into cros_typec_altmode.c to extract common
>   implementation between altmodes
>=20
>  MAINTAINERS                                  |   3 +
>  drivers/platform/chrome/Makefile             |   4 +
>  drivers/platform/chrome/cros_ec_typec.c      |  12 +-
>  drivers/platform/chrome/cros_ec_typec.h      |   1 +
>  drivers/platform/chrome/cros_typec_altmode.c | 275 +++++++++++++++++++
>  drivers/platform/chrome/cros_typec_altmode.h |  34 +++
>  6 files changed, 326 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_typec_altmode.c
>  create mode 100644 drivers/platform/chrome/cros_typec_altmode.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd6aa609deba..5f9d8b8f1cb3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5369,9 +5369,12 @@ F:	include/linux/platform_data/cros_usbpd_notify.h
> =20
>  CHROMEOS EC USB TYPE-C DRIVER
>  M:	Prashant Malani <pmalani@chromium.org>
> +M:	Benson Leung <bleung@chromium.org>
> +M:	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>  L:	chrome-platform@lists.linux.dev
>  S:	Maintained
>  F:	drivers/platform/chrome/cros_ec_typec.*
> +F:	drivers/platform/chrome/cros_typec_altmode.*
>  F:	drivers/platform/chrome/cros_typec_switch.c
>  F:	drivers/platform/chrome/cros_typec_vdm.*
> =20
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/M=
akefile
> index 2dcc6ccc2302..2f90d4db8099 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -18,7 +18,11 @@ obj-$(CONFIG_CROS_EC_SPI)		+=3D cros_ec_spi.o
>  obj-$(CONFIG_CROS_EC_UART)		+=3D cros_ec_uart.o
>  cros_ec_lpcs-objs			:=3D cros_ec_lpc.o cros_ec_lpc_mec.o
>  cros-ec-typec-objs			:=3D cros_ec_typec.o cros_typec_vdm.o
> +ifneq ($(CONFIG_TYPEC_DP_ALTMODE),)
> +	cros-ec-typec-objs		+=3D cros_typec_altmode.o
> +endif
>  obj-$(CONFIG_CROS_EC_TYPEC)		+=3D cros-ec-typec.o
> +
>  obj-$(CONFIG_CROS_EC_LPC)		+=3D cros_ec_lpcs.o
>  obj-$(CONFIG_CROS_EC_PROTO)		+=3D cros_ec_proto.o cros_ec_trace.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+=3D cros_kbd_led_backlight.o
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index e3eabe5e42ac..3a6f5f2717b9 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -18,6 +18,7 @@
> =20
>  #include "cros_ec_typec.h"
>  #include "cros_typec_vdm.h"
> +#include "cros_typec_altmode.h"
> =20
>  #define DRV_NAME "cros-ec-typec"
> =20
> @@ -293,12 +294,11 @@ static int cros_typec_register_port_altmodes(struct=
 cros_typec_data *typec,

As we debugged late last week, this desc here needs to be initialized ahead
of  the register, as it had some junk from the stack that was causing the
"active" property to be sometimes set to no.

memset(&desc, 0, sizeof(desc));

This worked for me when testing your series.

>  	desc.svid =3D USB_TYPEC_DP_SID;
>  	desc.mode =3D USB_TYPEC_DP_MODE;
>  	desc.vdo =3D DP_PORT_VDO;
> -	amode =3D typec_port_register_altmode(port->port, &desc);
> +	amode =3D cros_typec_register_displayport(port, &desc,
> +						typec->ap_driven_altmode);
>  	if (IS_ERR(amode))
>  		return PTR_ERR(amode);
>  	port->port_altmode[CROS_EC_ALTMODE_DP] =3D amode;
> -	typec_altmode_set_drvdata(amode, port);
> -	amode->ops =3D &port_amode_ops;
> =20
>  	/*
>  	 * Register TBT compatibility alt mode. The EC will not enter the mode
> @@ -575,6 +575,10 @@ static int cros_typec_enable_dp(struct cros_typec_da=
ta *typec,
>  	if (!ret)
>  		ret =3D typec_mux_set(port->mux, &port->state);
> =20
> +	if (!ret)
> +		cros_typec_displayport_status_update(port->state.alt,
> +						     port->state.data);
> +
>  	return ret;
>  }
> =20
> @@ -1254,6 +1258,8 @@ static int cros_typec_probe(struct platform_device =
*pdev)
> =20
>  	typec->typec_cmd_supported =3D cros_ec_check_features(ec_dev, EC_FEATUR=
E_TYPEC_CMD);
>  	typec->needs_mux_ack =3D cros_ec_check_features(ec_dev, EC_FEATURE_TYPE=
C_MUX_REQUIRE_AP_ACK);
> +	typec->ap_driven_altmode =3D cros_ec_check_features(
> +		ec_dev, EC_FEATURE_TYPEC_REQUIRE_AP_MODE_ENTRY);
> =20
>  	ret =3D cros_ec_cmd(typec->ec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
>  			  &resp, sizeof(resp));
> diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform/c=
hrome/cros_ec_typec.h
> index deda180a646f..9fd5342bb0ad 100644
> --- a/drivers/platform/chrome/cros_ec_typec.h
> +++ b/drivers/platform/chrome/cros_ec_typec.h
> @@ -39,6 +39,7 @@ struct cros_typec_data {
>  	struct work_struct port_work;
>  	bool typec_cmd_supported;
>  	bool needs_mux_ack;
> +	bool ap_driven_altmode;
>  };
> =20
>  /* Per port data. */
> diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platf=
orm/chrome/cros_typec_altmode.c
> new file mode 100644
> index 000000000000..3598b8a6ceee
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_typec_altmode.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Alt-mode implementation on ChromeOS EC.
> + *
> + * Copyright 2024 Google LLC
> + * Author: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> + */
> +#include "cros_ec_typec.h"
> +
> +#include <linux/usb/typec_dp.h>
> +#include <linux/usb/pd_vdo.h>
> +
> +#include "cros_typec_altmode.h"
> +
> +struct cros_typec_altmode_data {
> +	struct work_struct work;
> +	struct cros_typec_port *port;
> +	struct typec_altmode *alt;
> +	bool ap_mode_entry;
> +
> +	u32 header;
> +	u32 *vdo_data;
> +	u8 vdo_size;
> +
> +	u16 sid;
> +	u8 mode;
> +};
> +
> +struct cros_typec_dp_data {
> +	struct cros_typec_altmode_data adata;
> +	struct typec_displayport_data data;
> +	bool configured;
> +	bool pending_status_update;
> +};
> +
> +static void cros_typec_altmode_work(struct work_struct *work)
> +{
> +	struct cros_typec_altmode_data *data =3D
> +		container_of(work, struct cros_typec_altmode_data, work);
> +
> +	if (typec_altmode_vdm(data->alt, data->header, data->vdo_data,
> +			      data->vdo_size))
> +		dev_err(&data->alt->dev, "VDM 0x%x failed", data->header);
> +
> +	data->header =3D 0;
> +	data->vdo_data =3D NULL;
> +	data->vdo_size =3D 0;
> +}
> +
> +static int cros_typec_altmode_enter(struct typec_altmode *alt, u32 *vdo)
> +{
> +	struct cros_typec_altmode_data *data =3D typec_altmode_get_drvdata(alt);
> +	struct ec_params_typec_control req =3D {
> +		.port =3D data->port->port_num,
> +		.command =3D TYPEC_CONTROL_COMMAND_ENTER_MODE,
> +	};
> +	int svdm_version;
> +	int ret;
> +
> +	if (!data->ap_mode_entry) {
> +		const struct typec_altmode *partner =3D
> +			typec_altmode_get_partner(alt);
> +		dev_warn(&partner->dev,
> +			 "EC does not support ap driven mode entry\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (data->sid =3D=3D USB_TYPEC_DP_SID)
> +		req.mode_to_enter =3D CROS_EC_ALTMODE_DP;
> +	else
> +		return -EOPNOTSUPP;
> +
> +	ret =3D cros_ec_cmd(data->port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
> +			  &req, sizeof(req), NULL, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	svdm_version =3D typec_altmode_get_svdm_version(alt);
> +	if (svdm_version < 0)
> +		return svdm_version;
> +
> +	data->header =3D VDO(data->sid, 1, svdm_version, CMD_ENTER_MODE);
> +	data->header |=3D VDO_OPOS(data->mode);
> +	data->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> +
> +	data->vdo_data =3D NULL;
> +	data->vdo_size =3D 1;
> +
> +	schedule_work(&data->work);
> +
> +	return ret;
> +}
> +
> +static int cros_typec_altmode_exit(struct typec_altmode *alt)
> +{
> +	struct cros_typec_altmode_data *data =3D typec_altmode_get_drvdata(alt);
> +	struct ec_params_typec_control req =3D {
> +		.port =3D data->port->port_num,
> +		.command =3D TYPEC_CONTROL_COMMAND_EXIT_MODES,
> +	};
> +	int svdm_version;
> +	int ret;
> +
> +	if (!data->ap_mode_entry) {
> +		const struct typec_altmode *partner =3D
> +			typec_altmode_get_partner(alt);
> +		dev_warn(&partner->dev,
> +			 "EC does not support ap driven mode entry\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret =3D cros_ec_cmd(data->port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
> +			  &req, sizeof(req), NULL, 0);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	svdm_version =3D typec_altmode_get_svdm_version(alt);
> +	if (svdm_version < 0)
> +		return svdm_version;
> +
> +	data->header =3D VDO(data->sid, 1, svdm_version, CMD_EXIT_MODE);
> +	data->header |=3D VDO_OPOS(data->mode);
> +	data->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> +
> +	data->vdo_data =3D NULL;
> +	data->vdo_size =3D 1;
> +
> +	schedule_work(&data->work);
> +
> +	return ret;
> +}
> +
> +static int cros_typec_displayport_vdm(struct typec_altmode *alt, u32 hea=
der,
> +				      const u32 *data, int count)
> +{
> +	struct cros_typec_dp_data *dp_data =3D typec_altmode_get_drvdata(alt);
> +	struct cros_typec_altmode_data *adata =3D &dp_data->adata;
> +
> +
> +	int cmd_type =3D PD_VDO_CMDT(header);
> +	int cmd =3D PD_VDO_CMD(header);
> +	int svdm_version;
> +
> +	if (!adata->ap_mode_entry) {
> +		const struct typec_altmode *partner =3D
> +			typec_altmode_get_partner(alt);
> +		dev_warn(&partner->dev,
> +			 "EC does not support ap driven mode entry\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	svdm_version =3D typec_altmode_get_svdm_version(alt);
> +	if (svdm_version < 0)
> +		return svdm_version;
> +
> +	switch (cmd_type) {
> +	case CMDT_INIT:
> +		if (PD_VDO_SVDM_VER(header) < svdm_version) {
> +			typec_partner_set_svdm_version(adata->port->partner,
> +						       PD_VDO_SVDM_VER(header));
> +			svdm_version =3D PD_VDO_SVDM_VER(header);
> +		}
> +
> +		adata->header =3D VDO(adata->sid, 1, svdm_version, cmd);
> +		adata->header |=3D VDO_OPOS(adata->mode);
> +
> +		/*
> +		 * DP_CMD_CONFIGURE: We can't actually do anything with the
> +		 * provided VDO yet so just send back an ACK.
> +		 *
> +		 * DP_CMD_STATUS_UPDATE: We wait for Mux changes to send
> +		 * DPStatus Acks.
> +		 */
> +		switch (cmd) {
> +		case DP_CMD_CONFIGURE:
> +			dp_data->data.conf =3D *data;
> +			adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> +			dp_data->configured =3D true;
> +			schedule_work(&adata->work);
> +			break;
> +		case DP_CMD_STATUS_UPDATE:
> +			dp_data->pending_status_update =3D true;
> +			break;
> +		default:
> +			adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> +			schedule_work(&adata->work);
> +			break;
> +		}
> +
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
> +				      const u32 *data, int count)
> +{
> +	struct cros_typec_altmode_data *adata =3D typec_altmode_get_drvdata(alt=
);
> +
> +	if (adata->sid =3D=3D USB_TYPEC_DP_SID)
> +		return cros_typec_displayport_vdm(alt, header, data, count);
> +
> +	return -EINVAL;
> +}
> +
> +static const struct typec_altmode_ops cros_typec_altmode_ops =3D {
> +	.enter =3D cros_typec_altmode_enter,
> +	.exit =3D cros_typec_altmode_exit,
> +	.vdm =3D cros_typec_altmode_vdm,
> +};
> +
> +#if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
> +int cros_typec_displayport_status_update(struct typec_altmode *altmode,
> +					 struct typec_displayport_data *data)
> +{
> +	struct cros_typec_dp_data *dp_data =3D
> +		typec_altmode_get_drvdata(altmode);
> +	struct cros_typec_altmode_data *adata =3D &dp_data->adata;
> +
> +	if (!dp_data->pending_status_update) {
> +		dev_dbg(&altmode->dev,
> +			"Got DPStatus without a pending request");
> +		return 0;
> +	}
> +
> +	if (dp_data->configured && dp_data->data.conf !=3D data->conf)
> +		dev_dbg(&altmode->dev,
> +			"DP Conf doesn't match. Requested 0x%04x, Actual 0x%04x",
> +			dp_data->data.conf, data->conf);
> +
> +	dp_data->data =3D *data;
> +	dp_data->pending_status_update =3D false;
> +	adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> +	adata->vdo_data =3D &dp_data->data.status;
> +	adata->vdo_size =3D 2;
> +
> +	schedule_work(&adata->work);
> +	return 0;
> +}
> +
> +struct typec_altmode *
> +cros_typec_register_displayport(struct cros_typec_port *port,
> +				struct typec_altmode_desc *desc,
> +				bool ap_mode_entry)
> +{
> +	struct typec_altmode *alt;
> +	struct cros_typec_altmode_data *data;
> +
> +	alt =3D typec_port_register_altmode(port->port, desc);
> +	if (IS_ERR(alt))
> +		return alt;
> +
> +	data =3D devm_kzalloc(&alt->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		typec_unregister_altmode(alt);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	INIT_WORK(&data->work, cros_typec_altmode_work);
> +	data->alt =3D alt;
> +	data->port =3D port;
> +	data->ap_mode_entry =3D ap_mode_entry;
> +	data->sid =3D desc->svid;
> +	data->mode =3D desc->mode;
> +
> +	typec_altmode_set_ops(alt, &cros_typec_altmode_ops);
> +	typec_altmode_set_drvdata(alt, data);
> +
> +	return alt;
> +}
> +#endif
> diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platf=
orm/chrome/cros_typec_altmode.h
> new file mode 100644
> index 000000000000..c6f8fb02c99c
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_typec_altmode.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __CROS_TYPEC_ALTMODE_H__
> +#define __CROS_TYPEC_ALTMODE_H__
> +
> +struct cros_typec_port;
> +struct typec_altmode;
> +struct typec_altmode_desc;
> +struct typec_displayport_data;
> +
> +#if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
> +struct typec_altmode *
> +cros_typec_register_displayport(struct cros_typec_port *port,
> +				struct typec_altmode_desc *desc,
> +				bool ap_mode_entry);
> +
> +int cros_typec_displayport_status_update(struct typec_altmode *altmode,
> +					 struct typec_displayport_data *data);
> +#else
> +static inline struct typec_altmode *
> +cros_typec_register_displayport(struct cros_typec_port *port,
> +				struct typec_altmode_desc *desc,
> +				bool ap_mode_entry)
> +{
> +	return typec_port_register_altmode(port->port, desc);
> +}
> +
> +static inline int cros_typec_displayport_status_update(struct typec_altm=
ode *altmode,
> +					 struct typec_displayport_data *data)
> +{
> +	return 0;
> +}
> +#endif
> +#endif /* __CROS_TYPEC_ALTMODE_H__ */
> --=20
> 2.47.0.277.g8800431eea-goog
>=20
>=20

--TbHvfp6kUy+f6lxN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZzKeZAAKCRBzbaomhzOw
wgEIAQCdKzt65IStBSmMvdRMro0bcESyEJpmF0YrU0SonsTLUAEAg2ySnWBoNnja
gvmOM+RRA3gC9yeEB22cd3vCEF1dugI=
=9q05
-----END PGP SIGNATURE-----

--TbHvfp6kUy+f6lxN--

