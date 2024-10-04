Return-Path: <linux-kernel+bounces-349954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FA098FDD9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23ABE1C21C24
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1883C139579;
	Fri,  4 Oct 2024 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L/UbZ7LX"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDAA69D2B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728026961; cv=none; b=Mz1Py97RK9F+yQg0TvqZgWu/q7LT0Si/CgxaIm5u1vmoaEj3ML5kS/zjUN0HXc8YxEvg4ctYZeZxxjjqU6rIJU5JnbBMAuRwtVhZ5X+1j+oNhTSa5IVw+qdRZT146VRyUMjtfid75v0upRXa0pu0h0jLLTXVDYx0Wg6/INNNlHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728026961; c=relaxed/simple;
	bh=OKTalwAfmZPrK30DJvgcKg0WV9e6RurHz1166FHQk1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHAe4ed5IlTSTCUKLDZlWT9CDSzcN0GWLCm0Yh+OD1uNVp7mRLxx/UcIcpQGhKgz6XgAQi5AhvwBYOL7e+8u3cLhHW+OSYV/BiuSYMjm9Kbo2mWrzGTalHpD20rFXRJ1sgnN1tSaNHFci8ZS1jKc3l0e+Ggnk2CEAn0BdPwRJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L/UbZ7LX; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09B37240008;
	Fri,  4 Oct 2024 07:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728026956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3TTnuR28kslWEwBM5pyA9qaAOzOesXM2P5x5soXKlY=;
	b=L/UbZ7LXGUN/3HkPF6ZE6gq/YEeIC9acHhUTIOU8ZWEFtcbBccwLW55PzEpNEgi7EJ68Jm
	PEQ1RBotR3N3WMpiVfup4bVAIpnB+XN+6PFrsluhkXdZaqkjOvHjkiA8GP7NdgLxIDorGa
	VjC3BThwK/N6lX8Ncnhv6ymRO3FZ66gi0cJ9fSomrMYE2a2CO0XB7Ie8OqLZtDhtB8DhXW
	FDAcaQfk6WlAHln+mtWyYUWR2FEMNG1/f/8QQB73WM6npBm84Ii66O/B6bkRmgCypG4JKr
	6M5v2reYu0ifPmXbOIWhOtJa2YMsjhecYMDIwAXeKH/IJ7wip6BrvgJ6gtR+JA==
Date: Fri, 4 Oct 2024 09:29:14 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 bbrezillon@kernel.org, boris.brezillon@collabora.com,
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev,
 pthombar@cadence.com, ravindra.yashvant.shinde@nxp.com
Subject: Re: [PATCH v6 2/3] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_DESIRED
Message-ID: <20241004092914.42701e56@xps-13>
In-Reply-To: <20241003-i3c_dts_assign-v6-2-eae2569c92ca@nxp.com>
References: <20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com>
	<20241003-i3c_dts_assign-v6-2-eae2569c92ca@nxp.com>
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

Hi Frank,

> + * However, some I3C targets may request specific addresses (called as "=
init_dyn_addr"), which is
> + * typically specified by the DT-'s assigned-address property. Lower add=
resses having higher IBI
> + * priority. If it is available, i3c_bus_get_free_addr() preferably retu=
rn a free address that is
> + * not in the list of desired addresses (called as "init_dyn_addr"). Thi=
s allows the device with
> + * the "init_dyn_addr" to switch to its "init_dyn_addr" when it hot-join=
s the I3C bus. Otherwise,
> + * if the "init_dyn_addr" is already in use by another I3C device, the t=
arget device will not be
> + * able to switch to its desired address.
> + *
> + * If the previous step fails, fallback returning one of the remaining u=
nassigned address,
> + * regardless of its state in the desired list.
> + */
>  static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
>  {
>  	enum i3c_addr_slot_status status;
>  	u8 addr;
> =20
> +	for (addr =3D start_addr; addr < I3C_MAX_ADDR; addr++) {
> +		status =3D i3c_bus_get_addr_slot_status_mask(bus, addr,
> +							   I3C_ADDR_SLOT_EXT_STATUS_MASK);
> +		if (status =3D=3D I3C_ADDR_SLOT_FREE)
> +			return addr;
> +	}
> +
>  	for (addr =3D start_addr; addr < I3C_MAX_ADDR; addr++) {
>  		status =3D i3c_bus_get_addr_slot_status(bus, addr);

Maybe here we could also use the same status_mask() with the other mask,
just to clarify the difference.

>  		if (status =3D=3D I3C_ADDR_SLOT_FREE)
> @@ -1918,9 +1959,10 @@ static int i3c_master_bus_init(struct i3c_master_c=
ontroller *master)
>  			goto err_rstdaa;
>  		}
> =20
> -		i3c_bus_set_addr_slot_status(&master->bus,
> -					     i3cboardinfo->init_dyn_addr,
> -					     I3C_ADDR_SLOT_I3C_DEV);
> +		i3c_bus_set_addr_slot_status_mask(&master->bus,
> +						 i3cboardinfo->init_dyn_addr,
> +						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_DESIRED,
> +						 I3C_ADDR_SLOT_EXT_STATUS_MASK);

However I'm not sure I understand the use of the
set_addr_slot_status_mask() function. Can't we just use the normal
function and just extend the mask in the fist place?

>  		/*
>  		 * Only try to create/attach devices that have a static
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 2100547b2d8d2..6e5328c6c6afd 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -298,7 +298,8 @@ enum i3c_open_drain_speed {
>   * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
>   * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
>   * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
> - *
> + * @I3C_ADDR_SLOT_EXT_DESIRED: the bitmask represents addresses that are=
 preferred by some devices,
> + *			       such as the "assigned-address" property in a device tree sou=
rce.
>   * On an I3C bus, addresses are assigned dynamically, and we need to kno=
w which
>   * addresses are free to use and which ones are already assigned.
>   *
> @@ -311,9 +312,11 @@ enum i3c_addr_slot_status {
>  	I3C_ADDR_SLOT_I2C_DEV,
>  	I3C_ADDR_SLOT_I3C_DEV,
>  	I3C_ADDR_SLOT_STATUS_MASK =3D 3,
> +	I3C_ADDR_SLOT_EXT_STATUS_MASK =3D 7,
> +	I3C_ADDR_SLOT_EXT_DESIRED =3D BIT(2),
>  };
> =20
> -#define I3C_ADDR_SLOT_STATUS_BITS 2
> +#define I3C_ADDR_SLOT_STATUS_BITS 4
> =20
>  /**
>   * struct i3c_bus - I3C bus object
>=20

Otherwise lgtm.

Thanks,
Miqu=C3=A8l

