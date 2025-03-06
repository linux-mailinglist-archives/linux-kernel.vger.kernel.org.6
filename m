Return-Path: <linux-kernel+bounces-548458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EFCA54512
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EE0188407C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF34D207A22;
	Thu,  6 Mar 2025 08:39:41 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A41A725A;
	Thu,  6 Mar 2025 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250381; cv=none; b=B5l8KmNKVJlEEwAE7o2po6bj+vA5it8wMTGrFXmh7TfxpzWXhWkEf9WIQokS3QPv0dSYS3k8lfS2nZH9mTSvwDAeMzYUt5lf9O9a67xhFGuRiLQ66Bw01ZUL2/4Frjkl9RTXgBLS3p/TPZNY87dRK8v9hsVS8w6hT+amlr76Dgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250381; c=relaxed/simple;
	bh=iDkV5gjpY3dyW4nwDKqAuu6OmmPWl23UtJ7XJhnjj7U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=FrBzVIlWulDZd8JTlaPyrMwv5AWfm0tPnEnzOtlWcN2TiUk9zuxwJv92UJwL4qO78EvBPVgAxu/3FwGUy2BHjL1Ed1x1i9B3vE7WHs3Inu1EFF9+cgV+CnhppeBGaafdgddD3QwE9NIkswOpAupjOWBaN+mwDscjbdNqY9YPCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id F3E21287;
	Thu,  6 Mar 2025 09:39:31 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Mar 2025 09:39:31 +0100
Message-Id: <D891QPQIT13L.1S55ZM1J286PE@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>,
 <Manikandan.M@microchip.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <tudor.ambarus@linaro.org>,
 <pratyush@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <Varshini.Rajendran@microchip.com>
X-Mailer: aerc 0.16.0
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
 <D889CRJC6W19.2LDQCDVG7BLNG@kernel.org>
 <6fee6e71-106f-474b-9a0c-5df5fb0caa00@microchip.com>
 <87eczawo9q.fsf@bootlin.com>
In-Reply-To: <87eczawo9q.fsf@bootlin.com>

> >>> +static int sst26vf_nor_post_sfdp(struct spi_nor *nor)
> >>> +{
> >>> +     struct nvmem_device *nvmem;
> >>> +
> >>> +     sst26vf_sfdp_nvmem_config.dev =3D nor->dev;
> >>> +     sst26vf_sfdp_nvmem_config.size =3D nor->sfdp->num_dwords * size=
of(*nor->sfdp->dwords);
> >>> +     sst26vf_sfdp_nvmem_config.priv =3D nor;
> >>> +     sst26vf_sfdp_nvmem_config.reg_read =3D sst26vf_sfdp_mac_addr_re=
ad;
> >>> +
> >>> +     nvmem =3D devm_nvmem_register(nor->dev, &sst26vf_sfdp_nvmem_con=
fig);
> >>> +     if (IS_ERR(nvmem)) {
> >>> +             dev_err(nor->dev, "failed to register NVMEM device: %ld=
\n", PTR_ERR(nvmem));
> >>> +             return PTR_ERR(nvmem);
> >>=20
> >> I don't think it makes sense to have this one-off in a particular
> >> driver. If at all, this should be handled in the core. Sorry, but
> >> this really looks like an ugly hack.
> >>=20
> >
> > Because the EUI identifier within the SFDP is unique to the=20
> > SST26VF064BEUI flash, I opted to handle it here rather than in the core=
.
> >
> > Also here the MAC address data resides within the 0x260-0x26F range, I=
=20
> > will resize the nvmem_config.size to 0x10 instead of registering the=20
> > full SFDP region as NVMEM.
>
> Open question to all parties in this thread: how do we give an offset in
> the device tree that is relative to the sfdp region and not the data
> region? I believe we care not to mix these areas while describing.

You don't do it, because there is not even a relative offset that is
fixed. There should be a pointer to the vendor table inside the SFDP
structure. Thus, you need to properly parse it.

Regarding how to reference it within the device tree, I'd assume
something along 'compatible =3D "jedec,sfdp-vendor-table-NNN";' or
similar. But no static/relative offsets.

-michael

