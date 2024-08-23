Return-Path: <linux-kernel+bounces-299289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3B895D25B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0621D2819E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2330418953F;
	Fri, 23 Aug 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aoEsic4m"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14CE1C680
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429079; cv=none; b=EC8tnxCjlwqgTTEJVLieDtFv9BjJwaqQne/fY6j4mGi0GJl6vdPDQtn3p0keHSMpgVu9jFR5DZdzdV8zTpsyjpFCFHLeKlpT0Nmv735r2X94WN5empRhAcZvXuq4K7R1mNxxr7KBBCxoSICPeaemAcJxzvbxxc6WMdiFojuGww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429079; c=relaxed/simple;
	bh=177xgDYdFO5QHTNUZBJcTtp1IMBMsPqEb0gndm8UzoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ch1TncvtqgNZhTppBl5dLO0005xFPND+afA/m117xHR4/WlyZme8l9evTgSh3BuyfVnVDZuUDPWEbdGyW6yiCYWZw7te4CIuEMGQEO6V0Cqu+Yq1o8npmiJU+LIix4lWB5UfdS5vLhtPqAme6zm/j+d4X+xZazF5IlLtRnckWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aoEsic4m; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7F221C0007;
	Fri, 23 Aug 2024 16:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724429068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mF0jJ+XEsMsD5uzCbms/Umdhg76zuMSa2D9a98I2W8I=;
	b=aoEsic4mvBwrZmCLdfeoItEW+UzVqev1VH0kORDjuuE7d2xIYkApkVl+hKqE/GTz6WZ7an
	LEjcRon50pIKvTdEchNepMY5SWGZANXT9Fj/NJWIkvzc34TrmCNF4nVzCjySYovpgHaYbw
	kLWg5pzHSkQV7egl3zX7VSzhr375K3FCM03Vn50AMgOrNmi1h6fi6fDvOBaU4DgbAwTm7q
	P7Bkse6b3/gQ53y66UGiZDZrpRZPC262rsN8Vh4oiUslPXNPRY7IX+4+RVansh4rBNC3t5
	D7FH9CPEfS5uyTh5nAZQL276rNEEVxZxZb6F0VPGw1gfgfWMCDkOHfofsQPVGQ==
Date: Fri, 23 Aug 2024 18:04:26 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Parshuram Thombare <pthombar@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Boris Brezillon
 <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Conor Culhane
 <conor.culhane@silvaco.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 03/11] i3c: master: Extend address status bit to 4
 and add I3C_ADDR_SLOT_EXT_INIT
Message-ID: <20240823180426.056ac093@xps-13>
In-Reply-To: <20240819-i3c_fix-v3-3-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
	<20240819-i3c_fix-v3-3-7d69f7b0a05e@nxp.com>
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


>  static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
>  {
>  	enum i3c_addr_slot_status status;
> @@ -388,6 +405,14 @@ static int i3c_bus_get_free_addr(struct i3c_bus *bus=
, u8 start_addr)
>  	enum i3c_addr_slot_status status;
>  	u8 addr;
> =20
> +	/* try find an address, which have not pre-allocated by assigned-addres=
s */

	Try	to find			has   been

pre-allocated?

> +	for (addr =3D start_addr; addr < I3C_MAX_ADDR; addr++) {
> +		status =3D i3c_bus_get_addr_slot_status_ext(bus, addr);
> +		if (status =3D=3D I3C_ADDR_SLOT_FREE)
> +			return addr;
> +	}
> +
> +	/* use pre-allocoated by assigned-address because such device was remov=
ed at bus*/

	  Use      allocated=20

pre-allocated or assigned?

I guess the logic should be:
- try the assigned-address
- look for a free slot
- look for an already in use slot that must concern a disconnected
  device

But the comments are not precise enough IMHO. Can you rephrase them?

>  	for (addr =3D start_addr; addr < I3C_MAX_ADDR; addr++) {
>  		status =3D i3c_bus_get_addr_slot_status(bus, addr);
>  		if (status =3D=3D I3C_ADDR_SLOT_FREE)
> @@ -1906,9 +1931,9 @@ static int i3c_master_bus_init(struct i3c_master_co=
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
> index 4601b6957f799..c923b76bbc321 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -284,6 +284,8 @@ enum i3c_bus_mode {
>   * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
>   * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
>   * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
> + * @I3C_ADDR_SLOT_EXT_INIT: the bit mask display of addresses is preferr=
ed by some devices,

I'm sorry, but I don't understand what "bit mask display of addresses"
means.

> + *			    such as the "assigned-address" in device tree source (dts).
>   *
>   * On an I3C bus, addresses are assigned dynamically, and we need to kno=
w which
>   * addresses are free to use and which ones are already assigned.
> @@ -297,9 +299,11 @@ enum i3c_addr_slot_status {
>  	I3C_ADDR_SLOT_I2C_DEV,
>  	I3C_ADDR_SLOT_I3C_DEV,
>  	I3C_ADDR_SLOT_STATUS_MASK =3D 3,
> +	I3C_ADDR_SLOT_EXT_STATUS_MASK =3D 7,
> +	I3C_ADDR_SLOT_EXT_INIT =3D BIT(2),
>  };
> =20
> -#define I3C_ADDR_SLOT_BITS 2
> +#define I3C_ADDR_SLOT_BITS 4
> =20
>  /**
>   * struct i3c_bus - I3C bus object
>=20


Thanks,
Miqu=C3=A8l

