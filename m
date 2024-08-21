Return-Path: <linux-kernel+bounces-295877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD9F95A279
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40D0B2A127
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47A414D71F;
	Wed, 21 Aug 2024 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GcpjF4ao"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA651C687
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256437; cv=none; b=alYiqNCEf8kWjSrocB1kSgY37kp+cX3TuoYdHSnBbSM6Z4Kdb0Fehv0RDzXOzEcHx5NmaxFY//QynHEzDwtQ8CLm1qwzG5SQ8ydFfHkYBxTsqLmAI7+oG8A/PLUKlHpU7+VGY4bHM7UXlw+o/A4GJgqgjG+IMBH0qbeqi95I6zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256437; c=relaxed/simple;
	bh=3XF0N1B2T/pWRahCgRMNnjH+o+PGKXAQ6wQbBvt3NgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inBJ8Cy+A3eArR8mSdgAh6TmrQUjonMpPZvN75uerLehKlukfSVvz9Z54jzUvloZ+U3xgAeE2nes0U9OPhhL615aTqj5oK4zKmqYK0pI7Z4CI2j1Lhbw1pGQnAyFKqbiHtAUhsdaLTroo7OXvDrzbd/X4i2Otc2CRZihRmNUShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GcpjF4ao; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2B491C0003;
	Wed, 21 Aug 2024 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724256431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ipppIHAkC8/bs1pXjcH7GbKoIPUWZRYTJEl71STi7I=;
	b=GcpjF4aoXMVSFvFw1OOdjBS0qlqNXzreKykK8lyXpxK4jxyKj3LFfd3aFd9C8YaHn2G4Ml
	pVdhaokC5uSbExAZQ5pOnQPfspp0f83WqFTQIF8G/Ihe4sUYECvxWfwGc6tyN9u/8UKVhN
	adNSQNjN/drIn6RQ8kPUgYTh7v03yE7IWUVeiM1l/y9CUFc7/2AgJta6POryHplMzN9ese
	FfULQxWq7HinZsWMKJ5s3g82Kpyq029hHv4rZP1bIJR04mgx2f2UB40bt3zHTNUdnrAgtS
	VtJR817rYOJhdPWX6xf9DYyynD4gsoz0QuX9/ZBc0U6/iEjg2tLwg8t52Wxbrg==
Date: Wed, 21 Aug 2024 18:07:09 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: carlos.song@nxp.com
Cc: alexandre.belloni@bootlin.com, frank.li@nxp.com,
 conor.culhane@silvaco.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-imx@nxp.com
Subject: Re: [PATCH v2 1/2] i3c: master: support to adjust first broadcast
 address speed
Message-ID: <20240821180709.1626dd64@xps-13>
In-Reply-To: <20240807061306.3143528-1-carlos.song@nxp.com>
References: <20240807061306.3143528-1-carlos.song@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi carlos.song@nxp.com,

carlos.song@nxp.com wrote on Wed,  7 Aug 2024 14:13:05 +0800:

> From: Carlos Song <carlos.song@nxp.com>
>=20
> According to I3C spec 6.2 Timing Specification, the Open Drain High Period
> of SCL Clock timing for first broadcast address should be adjusted to 200=
ns
> at least. I3C device working as i2c device will see the broadcast to close
> its Spike Filter then change to work at I3C mode. After that I3C open dra=
in
> SCL high level should be adjusted back.
>=20
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> - Fix set_speed description from Frank's comment
> ---
>  drivers/i3c/master.c       | 12 ++++++++++++
>  include/linux/i3c/master.h | 18 ++++++++++++++++++
>  2 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 7028f03c2c42..6f3eb710a75d 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1868,6 +1868,12 @@ static int i3c_master_bus_init(struct i3c_master_c=
ontroller *master)
>  		goto err_bus_cleanup;
>  	}
> =20
> +	if (master->ops->set_speed) {
> +		ret =3D master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
> +		if (ret)
> +			goto err_bus_cleanup;
> +	}
> +
>  	/*
>  	 * Reset all dynamic address that may have been assigned before
>  	 * (assigned by the bootloader for example).
> @@ -1876,6 +1882,12 @@ static int i3c_master_bus_init(struct i3c_master_c=
ontroller *master)
>  	if (ret && ret !=3D I3C_ERROR_M2)
>  		goto err_bus_cleanup;
> =20
> +	if (master->ops->set_speed) {
> +		master->ops->set_speed(master, I3C_OPEN_DRAIN_NORMAL_SPEED);
> +		if (ret)
> +			goto err_bus_cleanup;
> +	}
> +
>  	/* Disable all slave events before starting DAA. */
>  	ret =3D i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
>  				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 074f632868d9..b8daf09a9a4a 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -277,6 +277,20 @@ enum i3c_bus_mode {
>  	I3C_BUS_MODE_MIXED_SLOW,
>  };
> =20
> +/**
> + * enum i3c_open_drain_speed - I3C open drain speed
> + * @I3C_OPEN_DRAIN_SLOW_SPEED: Slow open drain speed for First Broadcast=
 Address.

A few minor style comments:

open-drain

...for sending the first broadcast address.

> + *				First Broadcast Address in this speed is visible to all I2C/I3C

The first broadcast address at this speed will be visible to all=20

> + *				devices on the I3C bus. I3C device working as a I2C device will

... I3C devices working in I2C mode will

> + *				turn off its 50ns Spike Filter to change to work in I3C mode.

					their     spike filter when
					switching into I3C mode.

> + * @I3C_OPEN_DRAIN_NORMAL_SPEED: Normal open drain speed configured acco=
rding to

open-drain

> + *				I3C bus mode.

I'm sorry, can you rephrase "configured according to I3C bus mode" ?

> + */
> +enum i3c_open_drain_speed {
> +	I3C_OPEN_DRAIN_SLOW_SPEED,
> +	I3C_OPEN_DRAIN_NORMAL_SPEED,
> +};
> +
>  /**
>   * enum i3c_addr_slot_status - I3C address slot status
>   * @I3C_ADDR_SLOT_FREE: address is free
> @@ -436,6 +450,9 @@ struct i3c_bus {
>   *		      NULL.
>   * @enable_hotjoin: enable hot join event detect.
>   * @disable_hotjoin: disable hot join event detect.
> + * @set_speed: adjust I3C bus speed, which is generally used for reducin=
g the speed
> + *		for first broardcast address.
> + *
>   */
>  struct i3c_master_controller_ops {
>  	int (*bus_init)(struct i3c_master_controller *master);
> @@ -464,6 +481,7 @@ struct i3c_master_controller_ops {
>  				 struct i3c_ibi_slot *slot);
>  	int (*enable_hotjoin)(struct i3c_master_controller *master);
>  	int (*disable_hotjoin)(struct i3c_master_controller *master);
> +	int (*set_speed)(struct i3c_master_controller *master, enum i3c_open_dr=
ain_speed speed);
>  };
> =20
>  /**

Otherwise lgtm.

Thanks,
Miqu=C3=A8l

