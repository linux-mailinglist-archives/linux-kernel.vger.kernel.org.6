Return-Path: <linux-kernel+bounces-350750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ACD990903
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF6328161E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3EB1C7295;
	Fri,  4 Oct 2024 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hJl5Z07e"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31411C7294
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058962; cv=none; b=mt25zmTDGDDVS/SqTQMhzT84tkmXSGrtmx1/u7C5LwjOapwgTAwkO8yj1Yy9ZVOYsBCiYom1MFxqyx+NnVnK5gLiHR6ovdTpgOfAbPiu8q160Hldojk+P9b/oc5vR3SJwXa0kHCwR2dk0LoP80T/o3MaBvL2qN71srSf0A3dAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058962; c=relaxed/simple;
	bh=OW3oP33x3PxA4gdYXyjY0vacWaWZ+M921+FbsBzfR+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvAVBIvLmL+Lw65PL+wcFnneCd17f/o4gcyYsoVungWCqCFU8C58kZucyZazq4WYvFpqOlnIZ+u3i87n8ZXpOYZA8SoP3VTMtrs38+zvLp0EqoNpQkkKsuvCQTJIaWUNqWfnbNaM1OSBU8qyiwtX1JFWGkpBskhV7LLA/d2JjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hJl5Z07e; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25ADF4000B;
	Fri,  4 Oct 2024 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728058953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFJZiZ70kuhVJM7CKPrrjtdjJ4PTniafhKm6S3phoZQ=;
	b=hJl5Z07e9oxr1TwZw9Ch9RBk7tos3r+M+r5M51lvHnaDYMyG5qfg/OdFfiapl3YMYVAsRs
	xxy/G9yTIvQCHQsdKY7PCEWeDq+Qx41KjYQO2oVbjPJd2DT+p85F2dHKTv2EdIiP6GdgM/
	k5c2/DPV+7wlauVCGZJLGIzA38tslBs0LugAls/cD9wk2f+7wTOkrsqsgbC+3dyk4YOw3w
	eWHsnIw5UXBzawSsxf0ijIPAbd0J4Vv7KLKNz71Q0YkjBLhcsBo4Ao7ngIZjCiVKw2mMZb
	o11z7oLOAnv0KvQVgLIxmN+3mtdsgZFxDAeRKr379QSdlEMMTIf8zTg+ej07ZQ==
Date: Fri, 4 Oct 2024 18:22:29 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 bbrezillon@kernel.org, boris.brezillon@collabora.com,
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev,
 pthombar@cadence.com, ravindra.yashvant.shinde@nxp.com
Subject: Re: [PATCH v6 2/3] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_DESIRED
Message-ID: <20241004182229.6e08d02c@xps-13>
In-Reply-To: <ZwAHziElHUR7ZdKS@lizhi-Precision-Tower-5810>
References: <20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com>
	<20241003-i3c_dts_assign-v6-2-eae2569c92ca@nxp.com>
	<20241004092914.42701e56@xps-13>
	<ZwAHziElHUR7ZdKS@lizhi-Precision-Tower-5810>
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

> > > @@ -1918,9 +1959,10 @@ static int i3c_master_bus_init(struct i3c_mast=
er_controller *master)
> > >  			goto err_rstdaa;
> > >  		}
> > >
> > > -		i3c_bus_set_addr_slot_status(&master->bus,
> > > -					     i3cboardinfo->init_dyn_addr,
> > > -					     I3C_ADDR_SLOT_I3C_DEV);
> > > +		i3c_bus_set_addr_slot_status_mask(&master->bus,
> > > +						 i3cboardinfo->init_dyn_addr,
> > > +						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_DESIRED,
> > > +						 I3C_ADDR_SLOT_EXT_STATUS_MASK); =20
> >
> > However I'm not sure I understand the use of the
> > set_addr_slot_status_mask() function. Can't we just use the normal
> > function and just extend the mask in the fist place? =20
>=20
> The major purpose of set_addr_slot_status_mask() is that reduce code
> change. There are already address alloc/free by using I3C_ADDR_SLOT_FREE.
>=20
> we don't want i3c_bus_set_addr_slot_status() touch bit
> I3C_ADDR_SLOT_EXT_DESIRED since it was init at scan dts.

I agree, but in general you will never remove any "desired" slot, so
the "set status", besides at init time, should never touch these extra
bits?

> There are 18 place, using i3c_bus_set_addr_slot_status(), but we only need
> touch I3C_ADDR_SLOT_EXT_DESIRED bit when scan dts.
>=20

Thanks,
Miqu=C3=A8l

