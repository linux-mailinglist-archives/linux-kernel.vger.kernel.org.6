Return-Path: <linux-kernel+bounces-442187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7CF9ED92A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8E11884B64
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA361F0E2B;
	Wed, 11 Dec 2024 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB1LaUrL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740751EC4D6;
	Wed, 11 Dec 2024 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954313; cv=none; b=AIewNXfyXO+7NM34K1mEEwfPqJBDESdvXnuy5TM0R+2rPLnVWUwsY7Ug4o0oTu6rcinyLi5rG7JL9z/8EKioglZwHXaDMlO5irB2HTLrNdSXo3aNP5E/OJoc4tpYvFdKiUBGceN9lUBakeIfCVikUn/0DgvAJ9676ZujfAqZ/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954313; c=relaxed/simple;
	bh=ecYaIqbhPkBRnuxvN6uDBKdB3dID8uXl1k/yBNk9WKk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=DbNtHG22rsp0kE9w4EiJil+w72ZvD64CUy8leIRBwxdTzAXCwvIkMm1aWWZocitXcUmx4xQdHm/Y+j4vK+WkI/skdDP2byAkVKg8+gXW0CDaDEErKONKZcuQ75QN006RUmVxbCpYB/UArdZdmq5r8zSkn79AIqo6dBDHAlZg02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB1LaUrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B62FC4CED3;
	Wed, 11 Dec 2024 21:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733954313;
	bh=ecYaIqbhPkBRnuxvN6uDBKdB3dID8uXl1k/yBNk9WKk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=eB1LaUrLAjVkJMp0r+/TknFJUX3D9KF3mx5R0C0sSljyiM1ONcDQHQ8PchdwcoZJi
	 yCyBZ9sgPOJs3EgNGPiz7cxqpxDp+F0sxkspQIcpVpy51kaMPcuVwxUn/+2vFUVgd8
	 nw3FDuIv4ygJ7J2R+YckfrRdQzkS/S//26Ty23HyLsYPv+BfOTTNikeQ5fERTxspOK
	 wyVys8PL+E/fBuVnPvbuAch84rEyHOOWwXwUTCqSWUjgS04VvtGlEUWnsyICjGkX0+
	 +ZG3SFF0vTKfGr0sVH3alKbzBAWVGuArGawPhIfltTPPoe0Ww69Z4WwhLTYDnyirjg
	 Vxv4xz7HSA5eA==
Message-ID: <2bfe74d6a29ca13a7f89f116a2f0c6be.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241206153813.v4.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
References: <20241206233830.2401638-1-abhishekpandit@chromium.org> <20241206153813.v4.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
Subject: Re: [PATCH v4 5/7] platform/chrome: cros_ec_typec: Displayport support
From: Stephen Boyd <sboyd@kernel.org>
Cc: akuchynski@google.com, pmalani@chromium.org, jthies@google.com, dmitry.baryshkov@linaro.org, badhri@google.com, rdbabiera@google.com, Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev, heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, tzungbi@kernel.org
Date: Wed, 11 Dec 2024 13:58:30 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Abhishek Pandit-Subedi (2024-12-06 15:38:16)
> diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platf=
orm/chrome/cros_typec_altmode.c
> new file mode 100644
> index 000000000000..bb7c7ad2ff6e
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_typec_altmode.c
> @@ -0,0 +1,281 @@
[...]
> +
> +static const struct typec_altmode_ops cros_typec_altmode_ops =3D {
> +       .enter =3D cros_typec_altmode_enter,
> +       .exit =3D cros_typec_altmode_exit,
> +       .vdm =3D cros_typec_altmode_vdm,
> +};
> +
> +#if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
> +int cros_typec_displayport_status_update(struct typec_altmode *altmode,
> +                                        struct typec_displayport_data *d=
ata)
> +{
> +       struct cros_typec_dp_data *dp_data =3D
> +               typec_altmode_get_drvdata(altmode);

How does this work? I see that the type of the drvdata is struct
cros_typec_altmode_data per the allocation in
cros_typec_register_displayport(), but here we're treating it as the
type struct cros_typec_dp_data, which has a struct
cros_typec_altmode_data as the first member. The allocation is too small
from what I can tell. The same problem looks to be there in
cros_typec_displayport_vdm().

> +       struct cros_typec_altmode_data *adata =3D &dp_data->adata;
> +
> +       if (!dp_data->pending_status_update) {
> +               dev_dbg(&altmode->dev,
> +                       "Got DPStatus without a pending request");
> +               return 0;
> +       }
> +
> +       if (dp_data->configured && dp_data->data.conf !=3D data->conf)
> +               dev_dbg(&altmode->dev,
> +                       "DP Conf doesn't match. Requested 0x%04x, Actual =
0x%04x",
> +                       dp_data->data.conf, data->conf);
> +
> +       mutex_lock(&adata->lock);
> +
> +       dp_data->data =3D *data;
> +       dp_data->pending_status_update =3D false;
> +       adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
> +       adata->vdo_data =3D &dp_data->data.status;
> +       adata->vdo_size =3D 2;
> +       schedule_work(&adata->work);
> +
> +       mutex_unlock(&adata->lock);
> +
> +       return 0;
> +}
> +
> +struct typec_altmode *
> +cros_typec_register_displayport(struct cros_typec_port *port,
> +                               struct typec_altmode_desc *desc,
> +                               bool ap_mode_entry)
> +{
> +       struct typec_altmode *alt;
> +       struct cros_typec_altmode_data *data;
> +
> +       alt =3D typec_port_register_altmode(port->port, desc);
> +       if (IS_ERR(alt))
> +               return alt;
> +
> +       data =3D devm_kzalloc(&alt->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data) {
> +               typec_unregister_altmode(alt);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       INIT_WORK(&data->work, cros_typec_altmode_work);
> +       mutex_init(&data->lock);
> +       data->alt =3D alt;
> +       data->port =3D port;
> +       data->ap_mode_entry =3D ap_mode_entry;
> +       data->sid =3D desc->svid;
> +       data->mode =3D desc->mode;
> +
> +       typec_altmode_set_ops(alt, &cros_typec_altmode_ops);
> +       typec_altmode_set_drvdata(alt, data);

'data' is of type struct cros_typec_altmode_data here

> +
> +       return alt;
> +}

