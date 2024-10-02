Return-Path: <linux-kernel+bounces-347116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7CA98CE13
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C4A1C2117C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED14194143;
	Wed,  2 Oct 2024 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X2XevZN2"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B615D517
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855391; cv=none; b=Xhvx/v5GFJO0156FAatUOB2R2vmCddKfG4PZYD4/9w1xJXLT1yc1VBDmqoY3KvfyZEvbNBSM6TV0Ouc2DiXpN+rTc9frLxBquqKzEc7haG8F1RpuWy5wA4kvkdaqJMIOAO9LL+qNSS3hh0BhxJ+OjyuxaPCcDoIvY4MiWcbutqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855391; c=relaxed/simple;
	bh=zDypmlhgKNXGUVhJM1au38sVT9RyMMUwtY83nfkbj6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coLcvZ12Bg2ZkV6Cm4zJnvBX2xkTUJAM9vrjcvUyvSCFyjACwQpZJuiXY/F354u1M0sgLmmbaqOdaga1pLEi8oHNX4tXKhyqo2mJ5PHnz1Fb2ibIy14kPc3lyN+qH9TuTJaPOhsyyQfFLpTi7ihMKGgampvf3nRN20C9/uhBsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X2XevZN2; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92AB060003;
	Wed,  2 Oct 2024 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727855386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQuzEv53DXwXTjUws25SPYwCyjtC4EtFl20S+EvFVXY=;
	b=X2XevZN2I6w4A58T4JP3rdr7t9cc97h6c0Uig+ECNQKmzlya7dAguyl6IurOp/P+36kY4i
	bR7MwJAmi9IL1PIFYYpQutXol7ap4vG+C3f6G8jrVtLy2vs36o+qAlGDif22GXYityYkk4
	p2sQGe3izMCox+BPCHbpZs9hTQtviNsc8YXp8HAh1e3HdjembQ4bifZRw+b8bVd17RuqQN
	3bm3qMVL0Z07ReXspr/1ExJb6KSFuXH1wOzMJXXYWPbYoKvxJ2WWmWpWis9cp1DTPNY2U2
	DpH0cFQwqo5p0r6Bq387PWyv5RkFiydIyM66/rBf4tIxXMthREbPQNl8FXKeQA==
Date: Wed, 2 Oct 2024 09:49:44 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 bbrezillon@kernel.org, boris.brezillon@collabora.com,
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev,
 pthombar@cadence.com, ravindra.yashvant.shinde@nxp.com
Subject: Re: [PATCH 2/3] i3c: master: Extend address status bit to 4 and add
 I3C_ADDR_SLOT_EXT_INIT
Message-ID: <20241002094944.5c0c83c8@xps-13>
In-Reply-To: <20241001-i3c_dts_assign-v1-2-6ba83dc15eb8@nxp.com>
References: <20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com>
	<20241001-i3c_dts_assign-v1-2-6ba83dc15eb8@nxp.com>
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

Frank.Li@nxp.com wrote on Tue, 01 Oct 2024 13:08:21 -0400:

> Extend the address status bit to 4 and introduce the I3C_ADDR_SLOT_EXT_IN=
IT
> macro to indicate that a device prefers a specific address. This is
> generally set by the 'assigned-address' in the device tree source (dts)
> file.
>=20
>  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>  =E2=94=82S/Sr=E2=94=82 7'h7E RnW=3D0 =E2=94=82ACK=E2=94=82 ENTDAA  =E2=
=94=82 T =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=98    =E2=94=82
>  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98
>  =E2=94=82  =E2=94=8C=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>  =E2=94=94=E2=94=80=E2=96=BA=E2=94=82Sr=E2=94=827'h7E RnW=3D1  =E2=94=82A=
CK=E2=94=8248bit UID BCR DCR=E2=94=82Assign 7bit Addr=E2=94=82PAR=E2=94=82 =
ACK/NACK=E2=94=82
>     =E2=94=94=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=
=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>=20
> Some master controllers (such as HCI) need to prepare the entire above
> transaction before sending it out to the I3C bus. This means that a 7-bit
> dynamic address needs to be allocated before knowing the target device's
> UID information.
>=20
> However, some I3C targets want a specific address (called as
> "init_dyn_addr"), which is typically specified by the DT's assigned-addre=
ss
> property. (Lower addresses have higher IBI priority, and the target can
> adjust this by using the assigned-address property if using DT). The
> function i3c_master_add_i3c_dev_locked() will switch to this
> "init_dyn_addr" if it is not in use.
>=20
> Therefore, i3c_bus_get_free_addr() should return a free address that has
> not been claimed by any target devices as "init_dyn_addr" (indicated by
> I3C_ADDR_SLOT_EXT_INIT). This allows the device with the "init_dyn_addr"
> to switch to its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise,
> if the "init_dyn_addr" is already in use by another I3C device, the target
> device will not be able to switch to its desired address.
>=20
> If all of above address are already used, i3c_bus_get_free_addr() return
> one from the claimed as init_dyn_addr and free address slot. This ensures
> support devices as much as possible.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v3 to v4
> - rewrite commit message and comment for i3c_bus_get_free_addr()
> ---
>  drivers/i3c/master.c       | 68 ++++++++++++++++++++++++++++++++++++++++=
------
>  include/linux/i3c/master.h |  7 +++--
>  2 files changed, 64 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index dcf8d23c5941a..a56cb281e6b6d 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -345,7 +345,7 @@ const struct bus_type i3c_bus_type =3D {
>  EXPORT_SYMBOL_GPL(i3c_bus_type);
> =20
>  static enum i3c_addr_slot_status
> -i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
> +i3c_bus_get_addr_slot_status_ext(struct i3c_bus *bus, u16 addr)
>  {
>  	unsigned long status;
>  	int bitpos =3D addr * I3C_ADDR_SLOT_STATUS_BITS;
> @@ -356,11 +356,17 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u=
16 addr)
>  	status =3D bus->addrslots[bitpos / BITS_PER_LONG];
>  	status >>=3D bitpos % BITS_PER_LONG;
> =20
> -	return status & I3C_ADDR_SLOT_STATUS_MASK;
> +	return status & I3C_ADDR_SLOT_EXT_STATUS_MASK;
>  }
> =20
> -static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
> -					 enum i3c_addr_slot_status status)
> +static enum i3c_addr_slot_status
> +i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
> +{
> +	return i3c_bus_get_addr_slot_status_ext(bus, addr) & I3C_ADDR_SLOT_STAT=
US_MASK;
> +}
> +
> +static void i3c_bus_set_addr_slot_status_mask(struct i3c_bus *bus, u16 a=
ddr,
> +					      enum i3c_addr_slot_status status, int mask)
>  {
>  	int bitpos =3D addr * I3C_ADDR_SLOT_STATUS_BITS;
>  	unsigned long *ptr;
> @@ -369,11 +375,22 @@ static void i3c_bus_set_addr_slot_status(struct i3c=
_bus *bus, u16 addr,
>  		return;
> =20
>  	ptr =3D bus->addrslots + (bitpos / BITS_PER_LONG);
> -	*ptr &=3D ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
> -						(bitpos % BITS_PER_LONG));
> +	*ptr &=3D ~((unsigned long)mask << (bitpos % BITS_PER_LONG));
>  	*ptr |=3D (unsigned long)status << (bitpos % BITS_PER_LONG);
>  }
> =20
> +static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
> +					 enum i3c_addr_slot_status status)
> +{
> +	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_STAT=
US_MASK);
> +}
> +
> +static void i3c_bus_set_addr_slot_status_ext(struct i3c_bus *bus, u16 ad=
dr,
> +					     enum i3c_addr_slot_status status)
> +{
> +	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_EXT_=
STATUS_MASK);
> +}

Can we drop this helper and instead modify the
i3c_bus_set_addr_slot_status() prototype to get the mask from its
parameters?=20

> +
>  static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
>  {
>  	enum i3c_addr_slot_status status;
> @@ -383,11 +400,44 @@ static bool i3c_bus_dev_addr_is_avail(struct i3c_bu=
s *bus, u8 addr)
>  	return status =3D=3D I3C_ADDR_SLOT_FREE;
>  }
> =20
> +/*
> + * =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> + * =E2=94=82S/Sr=E2=94=82 7'h7E RnW=3D0 =E2=94=82ACK=E2=94=82 ENTDAA  =
=E2=94=82 T =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> + * =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=98    =E2=94=82
> + * =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98
> + * =E2=94=82  =E2=94=8C=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> + * =E2=94=94=E2=94=80=E2=96=BA=E2=94=82Sr=E2=94=827'h7E RnW=3D1  =E2=94=
=82ACK=E2=94=8248bit UID BCR DCR=E2=94=82Assign 7bit Addr=E2=94=82PAR=E2=94=
=82 ACK/NACK=E2=94=82
> + *    =E2=94=94=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=
=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> + * Some master controllers (such as HCI) need to prepare the entire abov=
e transaction before
> + * sending it out to the I3C bus. This means that a 7-bit dynamic addres=
s needs to be allocated
> + * before knowing the target device's UID information.
> + *
> + * However, some I3C targets want a specific address (called as "init_dy=
n_addr"), which is

				may request specific addresses (called "init...

> + * typically specified by the DT's assigned-address property. (Lower add=
resses have higher IBI

				   -'s

> + * priority, and the target can adjust this by using the assigned-addres=
s property if using DT).

Can we remove the whole "( ... )" sentence, and replace it with:

	"... property, lower addresses having higher IBI priority."

> + * The function i3c_master_add_i3c_dev_locked() will switch to this "ini=
t_dyn_addr" if it is not
> + * in use.

	if it is available.

> + *
> + * Therefore, i3c_bus_get_free_addr() should return a free address that =
has not been claimed by any

					preferably return

	that is not in the list of desired addresses.

> + * target devices as "init_dyn_addr". This allows the device with the "i=
nit_dyn_addr" to switch to
> + * its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise, if the =
"init_dyn_addr" is already
> + * in use by another I3C device, the target device will not be able to s=
witch to its desired
> + * address.
> + *
> + * If all of above address are already used, i3c_bus_get_free_addr() ret=
urn one from the claimed as
> + * init_dyn_addr and free address slot. This ensures support devices as =
much as possible.

If the previous step fails, fallback returning one of the remaining
unassigned address, regardless of its state in the desired list.

> + */

Please update your commit message as well with these changes.

>  static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
>  {
>  	enum i3c_addr_slot_status status;
>  	u8 addr;
> =20
> +	for (addr =3D start_addr; addr < I3C_MAX_ADDR; addr++) {
> +		status =3D i3c_bus_get_addr_slot_status_ext(bus, addr);

So here it could look like:

		status =3D ...get_addr_slot_status(bus, addr, <extended>)

> +		if (status =3D=3D I3C_ADDR_SLOT_FREE)
> +			return addr;
> +	}
> +
>  	for (addr =3D start_addr; addr < I3C_MAX_ADDR; addr++) {
>  		status =3D i3c_bus_get_addr_slot_status(bus, addr);
>  		if (status =3D=3D I3C_ADDR_SLOT_FREE)
> @@ -1918,9 +1968,9 @@ static int i3c_master_bus_init(struct i3c_master_co=
ntroller *master)
>  			goto err_rstdaa;
>  		}
> =20
> -		i3c_bus_set_addr_slot_status(&master->bus,
> -					     i3cboardinfo->init_dyn_addr,
> -					     I3C_ADDR_SLOT_I3C_DEV);
> +		i3c_bus_set_addr_slot_status_ext(&master->bus,
> +						 i3cboardinfo->init_dyn_addr,
> +						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_INIT);
> =20
>  		/*
>  		 * Only try to create/attach devices that have a static
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 2100547b2d8d2..57ad6044ac856 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -298,7 +298,8 @@ enum i3c_open_drain_speed {
>   * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
>   * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
>   * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
> - *
> + * @I3C_ADDR_SLOT_EXT_INIT: the bitmask represents addresses that are pr=
eferred by some devices,
> + *			    such as the "assigned-address" property in a device tree source=
 (DTS).

The naming could be improved, because "extended" does not mean much. I
believe we should express the fact that this is a desired addressed, so
what about:

	I3C_ADDR_SLOT_I3C_ASSIGNED/DESIRED

>   * On an I3C bus, addresses are assigned dynamically, and we need to kno=
w which
>   * addresses are free to use and which ones are already assigned.
>   *
> @@ -311,9 +312,11 @@ enum i3c_addr_slot_status {
>  	I3C_ADDR_SLOT_I2C_DEV,
>  	I3C_ADDR_SLOT_I3C_DEV,
>  	I3C_ADDR_SLOT_STATUS_MASK =3D 3,
> +	I3C_ADDR_SLOT_EXT_STATUS_MASK =3D 7,
> +	I3C_ADDR_SLOT_EXT_INIT =3D BIT(2),
>  };
> =20
> -#define I3C_ADDR_SLOT_STATUS_BITS 2
> +#define I3C_ADDR_SLOT_STATUS_BITS 4
> =20
>  /**
>   * struct i3c_bus - I3C bus object
>=20


Thanks,
Miqu=C3=A8l

