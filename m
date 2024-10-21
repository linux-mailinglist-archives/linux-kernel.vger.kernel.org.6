Return-Path: <linux-kernel+bounces-374059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B009A6148
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AB71C24B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455411E5701;
	Mon, 21 Oct 2024 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gpnuc2bx"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65DA1E47A9
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505051; cv=none; b=jil5+n8EJAno4a8pQDMlrWEvO1TYsv0tEI02Dl7O5zMCDsbr8geYuCUNnoU7tuS9sMH4G74fj27eRlinUiLMOdu3sNaKNgV12RqU8yiD02yXulKMopa34SikolYgwOs6e9sla6viNtQwQNXEKBIP8GPzQnxhBuwnU2jsKjC/0G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505051; c=relaxed/simple;
	bh=yYLvBpAYmUK56m0PfHd3poc6rZTPG+fsk8qd+nooKIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KC3Xct5ggPDgYDbKZeEHDDhC3S7RlOE2p7ckobPLcvfg7E2IgL8hOdPKDmVGLlfawvXv00fPJJuzfkZultFW44Ie8N5u5olKv1I3JMD1thGAlgzJXgi5ckGv4hLYl/pyeUjE7F9gZVB8OO+5u3kl/8E7Qe/N+m1x63pltnbCtlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gpnuc2bx; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4E4F40003;
	Mon, 21 Oct 2024 10:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729505046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FuSdVZXDqTu6KPSGBLpmBKD6jIhd+Wm5khRva2m4vgM=;
	b=gpnuc2bxeHdPO4arqDA5C+wIpkjl+nRAOIL1QthTSWnKQgpiIhOOv9orCjyWqLXlYkBCba
	lp8hxwnzrgagoIHo2H5wL70r4YoAm9a4xEt8CzWTNb3+NiMkFkQhjWQ1RRtQTg6fb2sViW
	eXtPtJhWvWu3P1Er/zs9TvkfCAIJSGjc5h87LHNR06Y6WRDs0lk0qQquZW6mgbGgWHUboN
	dxYEEy+847vdpuyDpnHodgnNhvEc1jyjeTIyQ1GEPcRarKJBF2GHv2bnjy1yfGyA4lggCH
	ixgUWZciQn/GmA1dn4jz1GZAEDUCGLGbSV0BZeq+HrQQJJPhB5EbdhJdxDdFJg==
Date: Mon, 21 Oct 2024 12:04:03 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 bbrezillon@kernel.org, boris.brezillon@collabora.com,
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev,
 pthombar@cadence.com, ravindra.yashvant.shinde@nxp.com, stable@kernel.org
Subject: Re: [PATCH v7 3/3] i3c: master: Fix dynamic address leak when
 'assigned-address' is present
Message-ID: <20241021120403.5764abbf@xps-13>
In-Reply-To: <20241008-i3c_dts_assign-v7-3-96ec93d1f34c@nxp.com>
References: <20241008-i3c_dts_assign-v7-0-96ec93d1f34c@nxp.com>
	<20241008-i3c_dts_assign-v7-3-96ec93d1f34c@nxp.com>
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

Frank.Li@nxp.com wrote on Tue, 08 Oct 2024 11:18:26 -0400:

> If the DTS contains 'assigned-address', a dynamic address leak occurs
> during hotjoin events.
>=20
> Assume a device have assigned-address 0xb.
>   - Device issue Hotjoin
>   - Call i3c_master_do_daa()
>   - Call driver xxx_do_daa()
>   - Call i3c_master_get_free_addr() to get dynamic address 0x9
>   - i3c_master_add_i3c_dev_locked(0x9)
>   -     expected_dyn_addr  =3D newdev->boardinfo->init_dyn_addr (0xb);
>   -     i3c_master_reattach_i3c_dev(newdev(0xb), old_dyn_addr(0x9));
>   -         if (dev->info.dyn_addr !=3D old_dyn_addr &&
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 0xb !=3D 0x9 -> TRUE
>                 (!dev->boardinfo ||
>                  ^^^^^^^^^^^^^^^ ->  FALSE
>                  dev->info.dyn_addr !=3D dev->boardinfo->init_dyn_addr)) {
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                  0xb !=3D 0xb      ->  FALSE
>                  ...
>                  i3c_bus_set_addr_slot_status(&master->bus, old_dyn_addr,
>                                                      I3C_ADDR_SLOT_FREE);
> 		 ^^^
>                  This will be skipped. So old_dyn_addr never free
>             }
>=20
>   - i3c_master_get_free_addr() will return increased sequence number.
>=20
> Remove dev->info.dyn_addr !=3D dev->boardinfo->init_dyn_addr condition ch=
eck.
> dev->info.dyn_addr should be checked before calling this function because
> i3c_master_setnewda_locked() has already been called and the target device
> has already accepted dyn_addr. It is too late to check if dyn_addr is free
> in i3c_master_reattach_i3c_dev().
>=20
> Add check to ensure expected_dyn_addr is free before
> i3c_master_setnewda_locked().
>=20
> Fixes: cc3a392d69b6 ("i3c: master: fix for SETDASA and DAA process")
> Cc: stable@kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Chagne v6 to v7
> - none
>=20
> Chagne v5 to v6
> - fixed version number to v5
> - fix merge conflict because change function name and macro name.
>=20
> Change v3 to v4
> - none
> ---
>  drivers/i3c/master.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index e0962a17de7f0..9ccfabf849c42 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1548,16 +1548,9 @@ static int i3c_master_reattach_i3c_dev(struct i3c_=
dev_desc *dev,
>  				       u8 old_dyn_addr)
>  {
>  	struct i3c_master_controller *master =3D i3c_dev_get_master(dev);
> -	enum i3c_addr_slot_status status;
>  	int ret;
> =20
> -	if (dev->info.dyn_addr !=3D old_dyn_addr &&
> -	    (!dev->boardinfo ||
> -	     dev->info.dyn_addr !=3D dev->boardinfo->init_dyn_addr)) {
> -		status =3D i3c_bus_get_addr_slot_status(&master->bus,
> -						      dev->info.dyn_addr);
> -		if (status !=3D I3C_ADDR_SLOT_FREE)
> -			return -EBUSY;
> +	if (dev->info.dyn_addr !=3D old_dyn_addr) {
>  		i3c_bus_set_addr_slot_status(&master->bus,
>  					     dev->info.dyn_addr,
>  					     I3C_ADDR_SLOT_I3C_DEV);
> @@ -1960,9 +1953,10 @@ static int i3c_master_bus_init(struct i3c_master_c=
ontroller *master)
>  			goto err_rstdaa;
>  		}
> =20
> +		/* Not mark as occupied until real device exist in bus */

		/* Do not mark

But with this changed,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

