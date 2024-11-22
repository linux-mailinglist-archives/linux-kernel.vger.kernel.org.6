Return-Path: <linux-kernel+bounces-418686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670169D6453
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D09161BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5E11DF97F;
	Fri, 22 Nov 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vpxm+/ud"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02129A5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732301463; cv=none; b=HaUwGdE1iCha8JfbHPZmlje03fkgkC/Sw9faWZvXeJ2Zj9HnlkHObBOj5BI/F3wKIqTLlXfnkMeht5KyPrs7jVtlq4ceIlMHKNyG8I5ULkYxEiwev0XzN9n+4O624Muv5oqp0P9n51MRVrxUQelXZVpMRK7D8T/qCkfxqOgkvSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732301463; c=relaxed/simple;
	bh=P8f3z3KImlG0Iv7G9gouR/0Ewo2VbVuTWyHT/5H1kcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzC4CBc5KsFYmtGLZBU3S7fZo6NPcxjVIfFXPHvhjGNtBozgOyK3aBfjhZkoaznMbt76NJZzCnIu5ynlk1xwG//FDk2aWldqciRJ9HfxefoZ4DdQc+XUt7yKemga6mdDcR230neGRpIrj8aNp9GBpwwZ8BJ6vceB/0WjlOJWEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vpxm+/ud; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7246c8c9b1cso2026274b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732301460; x=1732906260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6gj0+7Va7J9njdmM7N9rJJ2/haGWOYo/Av9YNf4X90=;
        b=Vpxm+/udgeqv833mBTDF4Sq4pOa3RE0tFLzWCZcjdjqN8lK72yXJluVdoVWjl/bZBZ
         kt5mijtE68Ekv5HGEVebJgjX+9FOAbDjY9vxE04yQhPgmUYmVutxvNZ7rvILRdhsfMGk
         +ueOeHk6TjNXClUYte/j0tWs5enseZOC9xrRzaz4gCnlK1b28X64sMap8xuraDW7EA49
         wudJ4CgSk/8lZtfiLSKT/64xpSMSmkeltTwKnMqDPRwByu6YKg47A3XJrmhbhLLInJcZ
         9C7i5U8cNT7zQNJkrty3NGoQR0MCfmQv1OW6mDIlWJLviyuFLrWZ3ma2ZFZ4w1baWwHA
         40tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732301460; x=1732906260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6gj0+7Va7J9njdmM7N9rJJ2/haGWOYo/Av9YNf4X90=;
        b=QcrCecMWp4eTWEDT6JzPOp6DaEfbaKwlxpsu+63j+A6i1ALXlK+lsCH+oX02zRA0LB
         toXHHg81ukJPBCDvA98JvI25rg/Ew5k13mi7EkZ6oX2DCjxI+Tsd8KpAoDpqkk3tJJsM
         bNhZAwgd62Cy1Jy8AfQTDPQUclNhx608AJ4YJpwkChaTiKrCcecuId6mEnltODYPqBPc
         k4LM2Rxps9paMpT0IB5ljv+fx1U/MvFkeaIAD3D8x2xAXrAWq+9wPZ0FlopYuTVtor7g
         0zt2AzkoJRjlix/jWm2FQovQ8VTaW8Ad5VUnUCPNI+S1QG+65b+lvNBnD5sYZCdfuEnl
         IWCw==
X-Forwarded-Encrypted: i=1; AJvYcCWBx8aLQy5xhj+npHw2a0YL6e5tC1NcYyIoS+Q5qLQ+Fl8kUabeoS86t040ChKzA7z7VPZua6diLUWZ7iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl1LH4dqq41y8KTPIfDe/cRYWC+E7HmYDh2mEFJNRtQF7PA2/q
	CwIqbYZCnyW6JpqUAA1eypog/Sfs6qpP7MBKI3OrW0m2wva3Xd0dVKm7EG3lOQ==
X-Gm-Gg: ASbGncvju9BEX5oXxRIMFxa+QLW4dYEjiTQXDIqwCqQ0FyfDjQxOghdUlixstjtt4EW
	KNljGAR+pJLB6N2vC/AP8QmsOmR2++OtibKpzJpSaBETnwCD1raJtSKJNcP86DpG3cI3eIyoyrY
	0dyX2wBplAYMoYlNun3TsYN1ntfLmrYsgdJW5ZXFFwCWVBgMZvfouX++ZxWI/I5SfTT6xIUd2U3
	bkSzj8vQGsjh/9hUmwHp+S7Db11P2byoTKFPlyNCrxminl89WZs2EbWEnMYGgLoR9XdFqJMkK/a
	VxuaBGWB4Q==
X-Google-Smtp-Source: AGHT+IHlHdUQZrAYBrn8jYfzeAbm/PUGlL+6jkZKwPyjqhDb+NJB7h3nT1GxGlaQHCtKtx7JDklLTQ==
X-Received: by 2002:a05:6a00:2d10:b0:71e:695:41ee with SMTP id d2e1a72fcca58-724df3e2869mr5107604b3a.5.1732301459241;
        Fri, 22 Nov 2024 10:50:59 -0800 (PST)
Received: from google.com (30.176.125.34.bc.googleusercontent.com. [34.125.176.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfbc69esm1713825a12.6.2024.11.22.10.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 10:50:58 -0800 (PST)
Date: Fri, 22 Nov 2024 18:50:54 +0000
From: Benson Leung <bleung@google.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org,
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev,
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
	dmitry.baryshkov@linaro.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, danielgeorgem@google.com
Subject: Re: [PATCH v3 2/7] usb: typec: Add driver for Thunderbolt 3
 Alternate Mode
Message-ID: <Z0DRWhZ745-N0DFE@google.com>
References: <20241107193021.2690050-1-abhishekpandit@chromium.org>
 <20241107112955.v3.2.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RLz5mJDVYXyB69SQ"
Content-Disposition: inline
In-Reply-To: <20241107112955.v3.2.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>


--RLz5mJDVYXyB69SQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,


On Thu, Nov 07, 2024 at 11:29:55AM -0800, Abhishek Pandit-Subedi wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>=20
> Thunderbolt 3 Alternate Mode entry flow is described in
> USB Type-C Specification Release 2.0.
>=20
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Co-developed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>=20
> Changes:
> * Delay cable + plug checks so that the module doesn't fail to probe
>   if cable + plug information isn't available by the time the partner
>   altmode is registered.
> * Remove unncessary brace after if (IS_ERR(plug))
>=20
> The rest of this patch should be the same as Heikki's original RFC.
>=20
>=20
> Changes in v3:
> - Revert rename of TYPEC_TBT_MODE
> - Remove mode from typec_device_id
>=20
> Changes in v2:
> - Use <linux/usb/typec_tbt.h> and add missing TBT_CABLE_ROUNDED
> - Pass struct typec_thunderbolt_data to typec_altmode_notify
> - Rename TYPEC_TBT_MODE to USB_TYPEC_TBT_MODE
> - Use USB_TYPEC_TBT_SID and USB_TYPEC_TBT_MODE for device id
> - Change module license to GPL due to checkpatch warning
>=20
>  drivers/usb/typec/altmodes/Kconfig       |   9 +
>  drivers/usb/typec/altmodes/Makefile      |   2 +
>  drivers/usb/typec/altmodes/thunderbolt.c | 308 +++++++++++++++++++++++
>  include/linux/usb/typec_tbt.h            |   1 +
>  4 files changed, 320 insertions(+)
>  create mode 100644 drivers/usb/typec/altmodes/thunderbolt.c
>=20
> diff --git a/drivers/usb/typec/altmodes/Kconfig b/drivers/usb/typec/altmo=
des/Kconfig
> index 1a6b5e872b0d..7867fa7c405d 100644
> --- a/drivers/usb/typec/altmodes/Kconfig
> +++ b/drivers/usb/typec/altmodes/Kconfig
> @@ -23,4 +23,13 @@ config TYPEC_NVIDIA_ALTMODE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called typec_nvidia.
> =20
> +config TYPEC_TBT_ALTMODE
> +	tristate "Thunderbolt3 Alternate Mode driver"
> +	help
> +	  Select this option if you have Thunderbolt3 hardware on your
> +	  system.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called typec_thunderbolt.
> +
>  endmenu
> diff --git a/drivers/usb/typec/altmodes/Makefile b/drivers/usb/typec/altm=
odes/Makefile
> index 45717548b396..508a68351bd2 100644
> --- a/drivers/usb/typec/altmodes/Makefile
> +++ b/drivers/usb/typec/altmodes/Makefile
> @@ -4,3 +4,5 @@ obj-$(CONFIG_TYPEC_DP_ALTMODE)		+=3D typec_displayport.o
>  typec_displayport-y			:=3D displayport.o
>  obj-$(CONFIG_TYPEC_NVIDIA_ALTMODE)	+=3D typec_nvidia.o
>  typec_nvidia-y				:=3D nvidia.o
> +obj-$(CONFIG_TYPEC_TBT_ALTMODE)		+=3D typec_thunderbolt.o
> +typec_thunderbolt-y			:=3D thunderbolt.o
> diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec=
/altmodes/thunderbolt.c
> new file mode 100644
> index 000000000000..a945b9d35a1d
> --- /dev/null
> +++ b/drivers/usb/typec/altmodes/thunderbolt.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * USB Typec-C Thuderbolt3 Alternate Mode driver
> + *
> + * Copyright (C) 2019 Intel Corporation
> + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/module.h>
> +#include <linux/usb/pd_vdo.h>
> +#include <linux/usb/typec_altmode.h>
> +#include <linux/usb/typec_tbt.h>
> +
> +enum tbt_state {
> +	TBT_STATE_IDLE,
> +	TBT_STATE_SOP_P_ENTER,
> +	TBT_STATE_SOP_PP_ENTER,
> +	TBT_STATE_ENTER,
> +	TBT_STATE_EXIT,
> +	TBT_STATE_SOP_PP_EXIT,
> +	TBT_STATE_SOP_P_EXIT
> +};
> +
> +struct tbt_altmode {
> +	enum tbt_state state;
> +	struct typec_cable *cable;
> +	struct typec_altmode *alt;
> +	struct typec_altmode *plug[2];
> +	u32 enter_vdo;
> +
> +	struct work_struct work;
> +	struct mutex lock; /* device lock */
> +};
> +
> +static bool tbt_ready(struct typec_altmode *alt);
> +
> +static int tbt_enter_mode(struct tbt_altmode *tbt)
> +{
> +	struct typec_altmode *plug =3D tbt->plug[TYPEC_PLUG_SOP_P];
> +	u32 vdo;
> +
> +	vdo =3D tbt->alt->vdo & (TBT_VENDOR_SPECIFIC_B0 | TBT_VENDOR_SPECIFIC_B=
1);
> +	vdo |=3D tbt->alt->vdo & TBT_INTEL_SPECIFIC_B0;
> +	vdo |=3D TBT_MODE;
> +
> +	if (plug) {
> +		if (typec_cable_is_active(tbt->cable))
> +			vdo |=3D TBT_ENTER_MODE_ACTIVE_CABLE;
> +
> +		vdo |=3D TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_SPEED(plug->vdo));
> +		vdo |=3D plug->vdo & TBT_CABLE_ROUNDED;
> +		vdo |=3D plug->vdo & TBT_CABLE_OPTICAL;
> +		vdo |=3D plug->vdo & TBT_CABLE_RETIMER;
> +		vdo |=3D plug->vdo & TBT_CABLE_LINK_TRAINING;
> +	} else {
> +		vdo |=3D TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_USB3_PASSIVE);
> +	}
> +
> +	tbt->enter_vdo =3D vdo;
> +	return typec_altmode_enter(tbt->alt, &vdo);
> +}
> +
> +static void tbt_altmode_work(struct work_struct *work)
> +{
> +	struct tbt_altmode *tbt =3D container_of(work, struct tbt_altmode, work=
);
> +	int ret;
> +
> +	mutex_lock(&tbt->lock);
> +
> +	switch (tbt->state) {
> +	case TBT_STATE_SOP_P_ENTER:
> +		ret =3D typec_altmode_enter(tbt->plug[TYPEC_PLUG_SOP_P], NULL);
> +		if (ret)
> +			dev_dbg(&tbt->plug[TYPEC_PLUG_SOP_P]->dev,
> +				"failed to enter mode (%d)\n", ret);
> +		break;
> +	case TBT_STATE_SOP_PP_ENTER:
> +		ret =3D typec_altmode_enter(tbt->plug[TYPEC_PLUG_SOP_PP], NULL);
> +		if (ret)
> +			dev_dbg(&tbt->plug[TYPEC_PLUG_SOP_PP]->dev,
> +				"failed to enter mode (%d)\n", ret);
> +		break;
> +	case TBT_STATE_ENTER:
> +		ret =3D tbt_enter_mode(tbt);
> +		if (ret)
> +			dev_dbg(&tbt->alt->dev, "failed to enter mode (%d)\n",
> +				ret);
> +		break;
> +	case TBT_STATE_EXIT:
> +		typec_altmode_exit(tbt->alt);
> +		break;
> +	case TBT_STATE_SOP_PP_EXIT:
> +		typec_altmode_exit(tbt->plug[TYPEC_PLUG_SOP_PP]);
> +		break;
> +	case TBT_STATE_SOP_P_EXIT:
> +		typec_altmode_exit(tbt->plug[TYPEC_PLUG_SOP_P]);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	tbt->state =3D TBT_STATE_IDLE;
> +
> +	mutex_unlock(&tbt->lock);
> +}
> +
> +static int tbt_altmode_vdm(struct typec_altmode *alt,
> +			   const u32 hdr, const u32 *vdo, int count)
> +{
> +	struct tbt_altmode *tbt =3D typec_altmode_get_drvdata(alt);
> +	int cmd_type =3D PD_VDO_CMDT(hdr);
> +	int cmd =3D PD_VDO_CMD(hdr);
> +
> +	mutex_lock(&tbt->lock);
> +
> +	if (tbt->state !=3D TBT_STATE_IDLE) {
> +		mutex_unlock(&tbt->lock);
> +		return -EBUSY;
> +	}
> +
> +	switch (cmd_type) {
> +	case CMDT_RSP_ACK:
> +		switch (cmd) {
> +		case CMD_ENTER_MODE:
> +			/*
> +			 * Following the order describeded in USB Type-C Spec
> +			 * R2.0 Section 6.7.3.
> +			 */
> +			if (alt =3D=3D tbt->plug[TYPEC_PLUG_SOP_P]) {
> +				if (tbt->plug[TYPEC_PLUG_SOP_PP])
> +					tbt->state =3D TBT_STATE_SOP_PP_ENTER;
> +				else
> +					tbt->state =3D TBT_STATE_ENTER;
> +			} else if (alt =3D=3D tbt->plug[TYPEC_PLUG_SOP_PP]) {
> +				tbt->state =3D TBT_STATE_ENTER;
> +			} else {
> +				struct typec_thunderbolt_data data;
> +
> +				data.device_mode =3D tbt->alt->vdo;
> +				data.cable_mode =3D
> +					tbt->plug[TYPEC_PLUG_SOP_P] ?
> +						tbt->plug[TYPEC_PLUG_SOP_P]
> +							->vdo :
> +						0;
> +				data.enter_vdo =3D tbt->enter_vdo;
> +
> +				typec_altmode_notify(alt, TYPEC_STATE_MODAL, &data);
> +			}
> +			break;
> +		case CMD_EXIT_MODE:
> +			if (alt =3D=3D tbt->alt) {
> +				if (tbt->plug[TYPEC_PLUG_SOP_PP])
> +					tbt->state =3D TBT_STATE_SOP_PP_EXIT;
> +				else if (tbt->plug[TYPEC_PLUG_SOP_P])
> +					tbt->state =3D TBT_STATE_SOP_P_EXIT;
> +			} else if (alt =3D=3D tbt->plug[TYPEC_PLUG_SOP_PP]) {
> +				tbt->state =3D TBT_STATE_SOP_P_EXIT;
> +			}
> +			break;
> +		}
> +		break;
> +	case CMDT_RSP_NAK:
> +		switch (cmd) {
> +		case CMD_ENTER_MODE:
> +			dev_warn(&alt->dev, "Enter Mode refused\n");
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (tbt->state !=3D TBT_STATE_IDLE)
> +		schedule_work(&tbt->work);
> +
> +	mutex_unlock(&tbt->lock);
> +
> +	return 0;
> +}
> +
> +static int tbt_altmode_activate(struct typec_altmode *alt, int activate)
> +{
> +	struct tbt_altmode *tbt =3D typec_altmode_get_drvdata(alt);
> +	int ret;
> +
> +	mutex_lock(&tbt->lock);
> +
> +	if (!tbt_ready(alt))
> +		return -ENODEV;


You need to mutex_unlock(&tbt->lock);  before the return.

Credit to danielgeorgem@google.com for his catching this in his code review.

> +
> +	/* Preventing the user space from entering/exiting the cable alt mode */
> +	if (alt !=3D tbt->alt)
> +		ret =3D -EPERM;
> +	else if (activate)
> +		ret =3D tbt_enter_mode(tbt);
> +	else
> +		ret =3D typec_altmode_exit(alt);
> +
> +	mutex_unlock(&tbt->lock);
> +
> +	return ret;
> +}
> +
> +static const struct typec_altmode_ops tbt_altmode_ops =3D {
> +	.vdm		=3D tbt_altmode_vdm,
> +	.activate	=3D tbt_altmode_activate
> +};
> +
> +static int tbt_altmode_probe(struct typec_altmode *alt)
> +{
> +	struct tbt_altmode *tbt;
> +
> +	tbt =3D devm_kzalloc(&alt->dev, sizeof(*tbt), GFP_KERNEL);
> +	if (!tbt)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&tbt->work, tbt_altmode_work);
> +	mutex_init(&tbt->lock);
> +	tbt->alt =3D alt;
> +
> +	alt->desc =3D "Thunderbolt3";
> +	typec_altmode_set_drvdata(alt, tbt);
> +	typec_altmode_set_ops(alt, &tbt_altmode_ops);
> +
> +	if (tbt_ready(alt)) {
> +		if (tbt->plug[TYPEC_PLUG_SOP_PP])
> +			tbt->state =3D TBT_STATE_SOP_PP_ENTER;
> +		else if (tbt->plug[TYPEC_PLUG_SOP_P])
> +			tbt->state =3D TBT_STATE_SOP_P_ENTER;
> +		else
> +			tbt->state =3D TBT_STATE_ENTER;
> +		schedule_work(&tbt->work);
> +	}
> +
> +	return 0;
> +}
> +
> +static void tbt_altmode_remove(struct typec_altmode *alt)
> +{
> +	struct tbt_altmode *tbt =3D typec_altmode_get_drvdata(alt);
> +
> +	for (int i =3D TYPEC_PLUG_SOP_PP; i > 0; --i) {
> +		if (tbt->plug[i])
> +			typec_altmode_put_plug(tbt->plug[i]);
> +	}
> +
> +	if (tbt->cable)
> +		typec_cable_put(tbt->cable);
> +}
> +
> +static bool tbt_ready(struct typec_altmode *alt)
> +{
> +	struct tbt_altmode *tbt =3D typec_altmode_get_drvdata(alt);
> +	struct typec_altmode *plug;
> +
> +	if (tbt->cable)
> +		return true;
> +
> +	/* Thundebolt 3 requires a cable with eMarker */
> +	tbt->cable =3D typec_cable_get(typec_altmode2port(tbt->alt));
> +	if (!tbt->cable)
> +		return false;
> +
> +	/* We accept systems without SOP' or SOP''. This means the port altmode
> +	 * driver will be responsible for properly ordering entry/exit.
> +	 */
> +	for (int i =3D 0; i < TYPEC_PLUG_SOP_PP + 1; i++) {
> +		plug =3D typec_altmode_get_plug(tbt->alt, i);
> +		if (IS_ERR(plug))
> +			continue;
> +
> +		if (!plug || plug->svid !=3D USB_TYPEC_VENDOR_INTEL)
> +			break;
> +
> +		plug->desc =3D "Thunderbolt3";
> +		plug->ops =3D &tbt_altmode_ops;
> +		typec_altmode_set_drvdata(plug, tbt);
> +
> +		tbt->plug[i] =3D plug;
> +	}
> +
> +	return true;
> +}
> +
> +static const struct typec_device_id tbt_typec_id[] =3D {
> +	{ USB_TYPEC_TBT_SID },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(typec, tbt_typec_id);
> +
> +static struct typec_altmode_driver tbt_altmode_driver =3D {
> +	.id_table =3D tbt_typec_id,
> +	.probe =3D tbt_altmode_probe,
> +	.remove =3D tbt_altmode_remove,
> +	.driver =3D {
> +		.name =3D "typec-thunderbolt",
> +		.owner =3D THIS_MODULE,
> +	}
> +};
> +module_typec_altmode_driver(tbt_altmode_driver);
> +
> +MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Thunderbolt3 USB Type-C Alternate Mode");
> diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
> index fa97d7e00f5c..55dcea12082c 100644
> --- a/include/linux/usb/typec_tbt.h
> +++ b/include/linux/usb/typec_tbt.h
> @@ -44,6 +44,7 @@ struct typec_thunderbolt_data {
> =20
>  #define   TBT_GEN3_NON_ROUNDED                 0
>  #define   TBT_GEN3_GEN4_ROUNDED_NON_ROUNDED    1
> +#define TBT_CABLE_ROUNDED		BIT(19)
>  #define TBT_CABLE_OPTICAL		BIT(21)
>  #define TBT_CABLE_RETIMER		BIT(22)
>  #define TBT_CABLE_LINK_TRAINING		BIT(23)
> --=20
> 2.47.0.277.g8800431eea-goog
>=20
>=20

--RLz5mJDVYXyB69SQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZ0DSjQAKCRBzbaomhzOw
wkZvAP9YUwUqtJYVatouMpu3qUVFMaRJg1rnGFyCqyYzyt8bnwD/RarBErzGvVKG
2GIfmjuCfDWuTW5U74cOleOqWkpscgM=
=1bCC
-----END PGP SIGNATURE-----

--RLz5mJDVYXyB69SQ--

