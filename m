Return-Path: <linux-kernel+bounces-407273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3F99C6B25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5661F251A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C361BE86A;
	Wed, 13 Nov 2024 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HVYdKZtu"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A791AA792
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488722; cv=none; b=tCy4GC0UxcI7ENkAtYiNV+5E7wx/WxhWRFBEX7j/Fk/HU6629fjP5vtFUKJ2nHGl0enABv8LcGknFMnyjv9hJD29XnhQ0vNoVnVJq4KzqeiVo1OvOBo8IZNEOd8Zz9oSJdn2KBvEKRKZO4XucnI+Voc/FAvQlOz2m/0OV0KcdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488722; c=relaxed/simple;
	bh=4pzdwduV3E3sigQDNHbRFtsN90uitBQ9OIl63oA0zQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BSJPUKQ4YHE2J0/Kxte7/8oCdhOSQkQu+jv+hm/x2mTjEXdTeAM0W3oRSM3yGg9Z1/6C8UqurtoSFS+JJGKIBmPItnug4oSYJS6xiXeg+dlZfv79IcAOYKOTz3CMxZxlRK2ST+65V91pX/ThanYehYGFR0kesRkxgQiVpKHelWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HVYdKZtu; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAD4E1BF207;
	Wed, 13 Nov 2024 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731488718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pzdwduV3E3sigQDNHbRFtsN90uitBQ9OIl63oA0zQQ=;
	b=HVYdKZtuLWrNKSapXa9VCXfCH6r+MAmzEwmShfrOhvPLsAbvhXcD0muMG5UtO3f4/ANMsN
	6g6GOogMHuyn9IGA5d0GY7YrifedGpnMOSEOpul/5wSVdwW2gbGWrVTpiw+J3QY++9j167
	sWRLuCtOxpWGwS/0NlY8QAdVOMZuaLEWDsb5HuaDXDw9T1n8I3thbqX+Vi5WCsusI88keS
	0MfahMs9YyK6CANycALk1uhUQJmIQWb5IEnsotzxJuBe+oZtjKuNLEEwQ2ip9inuI6bx6Q
	g0BbE47tZFc5u7FS/kP5Kz720bZNqAsSJme5VKHTZ6liT4sIn1MWLt2Lx6tT4w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: SkyLake Huang (=?utf-8?B?6buD5ZWf5r6k?=) <SkyLake.Huang@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "mmkurbanov@salutedevices.com" <mmkurbanov@salutedevices.com>,
  "kernel@sberdevices.ru" <kernel@sberdevices.ru>,  "d-gole@ti.com"
 <d-gole@ti.com>,  "dev@kicherer.org" <dev@kicherer.org>,
  "gch981213@gmail.com" <gch981213@gmail.com>,  "vigneshr@ti.com"
 <vigneshr@ti.com>,  "richard@nod.at" <richard@nod.at>
Subject: Re: [PATCH v2] mtd: spinand: add support for FORESEE F35SQA002G
In-Reply-To: <12f4d28f3efb7fe319ec919df92145c4ad24da01.camel@mediatek.com>
	("SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCkiJ3M=?= message of "Tue, 12 Nov
 2024 11:25:25
	+0000")
References: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
	<20241108163455.885-4-SkyLake.Huang@mediatek.com>
	<dbdb45ed1135e73b4eebd76e6f61b96d48aaedc6.camel@mediatek.com>
	<87ikssu3qq.fsf@bootlin.com>
	<12f4d28f3efb7fe319ec919df92145c4ad24da01.camel@mediatek.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 13 Nov 2024 10:05:17 +0100
Message-ID: <87h68bsdv6.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 12/11/2024 at 11:25:25 GMT, SkyLake Huang (=E9=BB=83=E5=95=9F=E6=BE=A4) =
<SkyLake.Huang@mediatek.com> wrote:

> On Tue, 2024-11-12 at 11:48 +0100, Miquel Raynal wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>=20
>>=20
>> Hi Sky,
>>=20
>> On 12/11/2024 at 10:08:31 GMT, SkyLake Huang (=E9=BB=83=E5=95=9F=E6=BE=
=A4) <
>> SkyLake.Huang@mediatek.com> wrote:
>>=20
>> > Hi Miquel/Martin,
>> > About this driver, including F35SQA001G/F35SQA002G parts, I'm
>> > concerned
>> > that the driver will always use 32H for update_cache operations,
>> > which
>> > means it's not compitable with those SPI controller who can't
>> > transmit
>> > 2048 bytes (most small-density SPI-NAND's page size nowadays) at
>> > one
>> > time.
>> >=20
>> > The following controller's driver seems that they can't transmit
>> > 2048
>> > bytes in one transmission:
>> > - spi-amd.c: 64 bytes (AMD_SPI_MAX_DATA)
>> > - spi-amlogic-spifc-a1.c: 512 bytes (SPIFC_A1_BUFFER_SIZE)
>> > - spi-fsl-qspi.c: 1KB
>> > - spi-hisi-sfc-v3xx.c: 64*6 bytes
>> > - spi-intel.c: 64 bytes (INTEL_SPI_FIFO_SZ)
>> > - spi-microchip-core-qspi.c: 256 bytesc (MAX_DATA_CMD_LEN)
>> > - spi-nxp-fspi.c: TX:1KB, RX: 512B in FIFO mode
>> > - spi-wpcm-fiu.c: 4B
>>=20
>> I believe most of these drivers are still able to send one page of
>> data
>> without toggling the CS (which is what actually matters, I believe).
>> If
>> they were broken, they would be broken with all spi memory devices,
>> not
>> only Foresee's.
>>=20
> Hi Miquel,
> I think it's not about toggling the CS?
>
> If a SPI controller tries to execute write page and it's capable to
> send only 1KB in one transmission, it should transmit data in two
> steps: 1st 34H (random program load x4) and 2nd 34H. However, when
> F35SQA002G executes 2nd 34H command, it needs to execute 32H first, and
> it will clear data transmitted by 1st 34H in NAND flash's cache. This
> will cause data corruption. Other SPI-NANDs doesn't need to execute 32H
> before 34H.

Is it really what happens? I'd instead expect the spi controller to
send:
- 34h
- 1k data
- 1k data
...

Why should we repeat the command while we are in the I/O phase?

Thanks,
Miqu=C3=A8l

