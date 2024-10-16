Return-Path: <linux-kernel+bounces-367647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DC89A04E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02C61F24163
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE82204F8B;
	Wed, 16 Oct 2024 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CrynI8QC"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6306204F74;
	Wed, 16 Oct 2024 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069113; cv=none; b=JquORrF0gUJt8n0I81wLeCT/R7uqWPYYkmfq+Qu5aS1zjvvfDx+TzgaUId81eYRWQ+5R0altP67dWdhrsZ68qR/oDimo8cvnUmkoPDGWS20PsE4ut3pBvCWtHY7RN4MDc7U/1kw+VwUcJq3+jNLJjk8uIpykY6okrt8DFAfIRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069113; c=relaxed/simple;
	bh=GiMJprnXspvPV/ACpRlvXGDB0qHzjjI6ZCKEXGqE6IU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bl4nVPqqhcOfSM8X7U50apGUrfonNapDT3awc10NrZ0n8BTAjsJnnq3VMPKdXXTONKK8q3TOBLyPSQFM+efrZweky8XqBlVUGffTgclZ2Cre688/r+v/G/dUdVMqJd5zAxb5ZFwttWpiOXN1Bqr+puAhL05QF052RvyWhl+DqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CrynI8QC; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C8FAE240008;
	Wed, 16 Oct 2024 08:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729069109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3U/ETveGyfKnjLcVyYOTm+ngXWvKY86THZrnq130qU=;
	b=CrynI8QCFY+rV6CUfg7oqNg5Cn+axWaZvu7why2KR7lINNVmbCFmYzoaV/z7/evseoEgkG
	CMupTxXlD0rF9cm6UkwEwGYZRoofd7GLOm9aSc5zQdX7l7EK0mIPk1p0m2slbJi/kitpY2
	r5irEDbDgCDXsmVvpMqVen3IBSKf93tn7szEEkbY8UKTnsUxBAEmQHLnJTjzz1fpjbkPVk
	9eOGicU+Yfa6iKRHmzRbfxJ85A8E4jvjqHOrDMeGzuFTcaAJR6SC5DoCwlopXjcilEjSXL
	iowz7wqk8gWADsiWx5xhNSc2wthSPU3G6hjJlfOFOZEsucpUbduPKlgPlY81yg==
Date: Wed, 16 Oct 2024 10:58:27 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Saravana Kannan
 <saravanak@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Bianconi
 <lorenzo@kernel.org>, upstream@airoha.com
Subject: Re: [PATCH 2/3] dt-bindings: mtd: Add Documentation for Airoha
 fixed-partitions
Message-ID: <20241016105827.22a6bb45@xps-13>
In-Reply-To: <670f6c5e.170a0220.373da5.7bb7@mx.google.com>
References: <20240925101422.8373-3-ansuelsmth@gmail.com>
	<20240925133003.619c40c4@xps-13>
	<66f3f58e.5d0a0220.5d655.b48a@mx.google.com>
	<20240925135256.32d3a0f7@xps-13>
	<66f3fcb7.5d0a0220.3ca4c2.ba83@mx.google.com>
	<20240930114819.609f9341@xps-13>
	<66fa7915.050a0220.1da288.aeca@mx.google.com>
	<20241001104225.67483dab@xps-13>
	<66fbcee8.df0a0220.2ad0cb.4f6a@mx.google.com>
	<20241002100006.5995fd10@xps-13>
	<670f6c5e.170a0220.373da5.7bb7@mx.google.com>
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

Hi Christian,

ansuelsmth@gmail.com wrote on Wed, 16 Oct 2024 09:33:46 +0200:

> On Wed, Oct 02, 2024 at 10:00:06AM +0200, Miquel Raynal wrote:
> > Hi Christian,
> >  =20
> > > > > > > Ok probably the description isn't clear enough. The missing i=
nfo that
> > > > > > > require this parser is the flash end.
> > > > > > >=20
> > > > > > > Following the example we know the size of rootfs_data and sta=
rt offset
> > > > > > > AND we know the size of the ART partition.
> > > > > > >=20
> > > > > > > There might be a space in the middle unused between the rootf=
s_data
> > > > > > > partition and the art partition. What is derived is the start=
ing offset
> > > > > > > of the art partition that is flash end - art partition size.
> > > > > > > (where flash end change and is not always the same due to how=
 the special
> > > > > > > bad block managament table reserved space is handled)
> > > > > > >=20
> > > > > > > This is why 0xffffffff, used as a dummy offset to signal it w=
ill be parsed at
> > > > > > > runtime. On second tought tho maybe using this dummy offset i=
s wrong and
> > > > > > > I should just have something like
> > > > > > >=20
> > > > > > > length =3D <0x300000>;
> > > > > > >=20
> > > > > > > Is it clear now? Sorry for any confusion.     =20
> > > > > >=20
> > > > > > I'm sorry but not really. You know the end of the physical devi=
ce and
> > > > > > the size of the ART partition, so you must know its start as we=
ll?
> > > > > >     =20
> > > > >=20
> > > > > Before the system boot we know:
> > > > > - size of the ART partition
> > > > > - real size of the physical device (512mb... 1G... 64mb...)
> > > > >=20
> > > > > When the physical device is probed (nand) a special driver is loa=
ded
> > > > > (before mtd parsing logic) that change the physical size of the d=
evice
> > > > > (mtd->size) as at the end of the nand some space is reserved for =
bad
> > > > > block management and other metadata info.   =20
> > > >=20
> > > > Here you are explaining what you intend Linux to do, right? I would
> > > > like to understand what you are trying to solve. I dont understand =
why
> > > > you need the size change, I don't understand why you don't know the
> > > > start of the ART partition, I don't understand what the data you are
> > > > hiding contains and who uses it :-) I'm sorry, this is too unclear =
yet.   =20
> > >=20
> > > Totally not a problem and thanks a lot for you keep asking them... Mo=
re
> > > than happy to clear things, I'm trying to solve a problem present on
> > > Airoha SoC and upstreaming a correct parser for it.
> > >=20
> > > What I'm trying to solve:
> > >=20
> > > Correct access to this partition at the end of the flash in an automa=
ted
> > > way.
> > >=20
> > > The content of this partition is the usual ART partition found on lot=
s of
> > > embedded devices. MAC address, wifi calibration data, serial. Usage is
> > > NVMEM cells and userspace with dd command to extract data from.
> > >=20
> > > Airoha use something also used by some mediatek SoC. They call it BMT
> > > and it's currently used downstream in OpenWrt and they firmware. This=
 is
> > > also used in the bootloader.
> > >=20
> > > The usage of BMT is a custom way to handle bad blocks entirely by
> > > software. At the end of the flash some space is reserved where info
> > > about all the blocks of the flash are put. I'm not 100% sure about the
> > > functionality of this but it can relocate block and do magic things to
> > > handle bad blocks. For the scope of this change, the important info is
> > > that after the BMT is probed, the operation of "reserving space" is d=
one
> > > by reducing the MTD flash size. So from the MTD subsystem, it does se=
e a
> > > smaller flash than it actually is.
> > >=20
> > > The reserved space change! Across SoC or even devices but the BMT is a
> > > must where it's used as bootloader makes use of it and writing to it
> > > might confuse the bootloader corrupting data. (one block might be
> > > flagged as bad ad data moved, BMT driver validates his table and do
> > > operation) =20
> >=20
> > Ok, I think that's way clearer now.
> > =20
>=20
> Hi sorry for the delay, very happy this is better now.
>=20
> > So the BMT driver does not exist in mainline Linux, but you would like
> > to skip this part of the MTD device to avoid smashing it. And it is in
> > use by the vendor Bootloader I guess? =20
>=20
> Yes correct, idea is to permit easier access to the partition. I hope
> (and assume) this driver will come upstream.
>=20
> >=20
> > Is it some kind of table that is written by the chip itself in order to
> > maintain a list of auto-replacement blocks for bad blocks? Can the size
> > of this table move with the use of the device? (if yes, it's
> > problematic, we don't want to resize MTD partitions without noticing,
> > it would break eg. UBI).
> >  =20
>=20
> No chip hw bad block is disabled with this implementation and the table
> size doesn't move/change so MTD partitions will stay at the same offset
> after the first parse on boot.
>=20
> > I believe this BMT block is going against the bad block handling in
> > Linux, so I really wonder how one can use both mechanisms in a system.
> > If the BMT layer takes "one random block" to map a corrupted one on it,
> > it totally defeats the current bad block model we have in MTD/UBI
> > and simply cannot be supported at all. Just skipping the
> > currently-used-for-BMT blocks sounds like a very bad idea that will
> > break your system, later.
> > =20
>=20
> Well we disable it and since it's reserved, from the system side you can
> do all kind of magic since the space used for the driver is not
> available to the system but I will try to gather more info about this in
> the next few days.

I understand, but if you cannot get rid of it, it means "someone" is
using it, presumably the bootloader, right? How can the bootloader use
this feature?

Or maybe you need this table to show the (vendor) bootloader "nothing
changed, use PEB normally, none of them is bad, there is no ongoing
remapping"?

In this case I guess the size of the table is a linear function against
the size of the chip and thus can be statically derived?

Thanks,
Miqu=C3=A8l

