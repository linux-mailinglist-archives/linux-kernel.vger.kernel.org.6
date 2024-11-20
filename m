Return-Path: <linux-kernel+bounces-415565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC19D3838
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D049AB27336
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8319D093;
	Wed, 20 Nov 2024 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DsZxB6Ba"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C574040
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732097637; cv=none; b=RZ9V152ChVMcT0XUjreRDFezpw+2QaV1VQcAvX5UdKU6wXX1CvuW7NM5i3PE3I6sPrWbhyNKIUY4zJG7ntli6IX4MzpootT08/JjqbIMEeqce/D/bjMhJyOqYqhWQooo10lPqmxOmY97oIEfHmr+O9PK8xoo687xmEPEmvFOAsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732097637; c=relaxed/simple;
	bh=Rund3eXE33gunWroliBrDttepEeQJ9PST86ln98CDmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRGqxJaZo7nbygmDEMI66HZkhsL5V2Al4ZI+ymfIp2bWUFIy53ybWr2m1tfPdP39AKYtBS5VPRFJccJ9IF5B9u/9yfzBb2wgsXr+RaTJYDkGiIo5H2AEsjGv2+dTuF86cQypyO7JhHLJq8E0oQHwH5c4yomMNmJSQhu6Gr822zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DsZxB6Ba; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E611E6000F;
	Wed, 20 Nov 2024 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732097632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rund3eXE33gunWroliBrDttepEeQJ9PST86ln98CDmg=;
	b=DsZxB6BaaT/0Ww5LZyO6h+V9XleVnpsXjDfY5zxvRIDAwQW65PwtYmnLLAljfjYyKGqlgp
	bDLfpZ0E5Izwtgcvl3CS26oT6kV64zOBR2tL8huPCdjRhieUxdgmx0U64xscJhvY/qhmHT
	6DWzyH79UKH5SDm8+Gb24BHpLaImXVuG9GI39rx4uFGHD+GwvM2scmQf1yVUbVttX8ociB
	+YxLVHELGy/vnzGmEfR7uxMvGxsGHrs8Qqs7yoJO7GnNhOffwe3+kocUgQF8b2CI5HD0si
	V8tyweBYu8Aty8g6hVSki1wddilYdWjwsg9QU3+m+G2Xz3OxrtsktTnlz6frOw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: SkyLake Huang (=?utf-8?B?6buD5ZWf5r6k?=) <SkyLake.Huang@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,  "acelan.kao@canonical.com"
 <acelan.kao@canonical.com>,  "chengminglin@mxic.com.tw"
 <chengminglin@mxic.com.tw>,  "mika.westerberg@linux.intel.com"
 <mika.westerberg@linux.intel.com>,  "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,  Steven Liu
 <steven.liu@mediatek.com>,  "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>,  "daniel@makrotopia.org"
 <daniel@makrotopia.org>,  "vigneshr@ti.com" <vigneshr@ti.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  "richard@nod.at" <richard@nod.at>
Subject: Re: [RFC PATCH nand/next 0/4] mtd: nand: spi: Add CASN page support
In-Reply-To: <9880b3b2f71afd1b020c393fd5d4c0c5673df187.camel@mediatek.com>
	("SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCkiJ3M=?= message of "Wed, 20 Nov
 2024 07:24:28
	+0000")
References: <20241020132722.20565-1-SkyLake.Huang@mediatek.com>
	<87jzd0zuc0.fsf@bootlin.com>
	<9880b3b2f71afd1b020c393fd5d4c0c5673df187.camel@mediatek.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 20 Nov 2024 11:13:48 +0100
Message-ID: <87ldxew6ub.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 20/11/2024 at 07:24:28 GMT, SkyLake Huang (=E9=BB=83=E5=95=9F=E6=BE=A4) =
<SkyLake.Huang@mediatek.com> wrote:

> On Mon, 2024-11-18 at 11:53 +0100, Miquel Raynal wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>=20
>>=20
>> On 20/10/2024 at 21:27:18 +08, Sky Huang <SkyLake.Huang@mediatek.com>
>> wrote:
>>=20
>> > From: "Sky Huang" <skylake.huang@mediatek.com>
>> >=20
>> > Hi, this is Qi-Ze Huang(Sky Huang) from MediaTek. On our router
>> > platforms
>> > chips, we have to quality lots of SPI-NAND devices and are eager
>> > for
>> > a standard so that we don't need to maintain trivial flash ID table
>> > anymore. I also noticed a talk in 2019 Embedded Linux Conference,
>> > Memory Technology Devices: what's new, which mentioned "ONFI for
>> > SPI-NANDs? Maybe, maybe not".
>> >=20
>> > So earlier this year, I proposed a bold idea, CASN page (Common
>> > Attributes
>> > for SPI-NAND). I worked together with top 3 SPI-NAND market share
>> > flash
>> > vendors and other vendors to integrate CASN page on their SPI-NAND
>> > devices
>> > including but not limited to:
>> > [ESMT]
>> > F50L1G41LB
>> > F50L2G41KA
>> >=20
>> > [Etron]
>> > EM73C044VCF-H
>> > EM73D044VCO-H
>> > EM73E044VCE-H
>> > EM73F044VCA-H
>> >=20
>> > [GigaDevice]
>> > GD5F1GM7UE
>> > GD5F1GQ5UEYIG
>> > GD5F2GM7UE
>> > GD5F2GQ5UEYIG
>> > GD5F4GM8UE
>> > GD5F4GQ6UEYIG
>> >=20
>> > [Macronix (MXIC)]
>> > MX35LF1GE4ABZ4IG
>> >=20
>> > [Winbond]
>> > W25N01GV
>> > W25N01KV
>> > W25N02KV
>> > W25N04KV
>> >=20
>> > A document of CASN is hosted on github(
>> > https://urldefense.com/v3/__https://github.com/mtk-openwrt/__;!!CTRNKA=
9wMg0ARbw!j_TES7dJ_An-9wtyQqWgGBE9ovPnUA-tDNlZ-pGpUdYv4gphzW4v54Fal8i_nLwSm=
PAzK9ApgSBG1XQ_mREdTS0ZwrBWRA$
>> > doc/blob/main/CASN%20Page%20Introduction.pdf) So I'll try to keep
>> > it
>> > simple here.
>> >=20
>> > With CASN page, we don't need to maintain SPI-NAND flash ID table
>> > anymore.
>> > Currently, it's integrated in 3.3V SPI-NANDs of small density and
>> > it's not
>> > JEDEC standard yet. But it should be able to handle 1.8V and can be
>> > easily
>> > integrated by flash vendors.
>> >=20
>> > I believe this idea and implementation have room for improvement.
>> > Hope to
>> > hear you open source community's comments soon.
>>=20
>> I think this is a bright initiative. I'd welcome some standardisation
>> on
>> the discovery indeed.
>>=20
>> But to be really useful, I believe this table must be really
>> complete,
>> otherwise ID's will remain. For instance SDR/DDR modes are not
>> entirely
>> defined as we already have mixed modes. There is also no information
>> about what maximum frequencies can be used with each operation.=20
>
> Maximum frequencies are limited by SPI controller's max freq now, I
> guess?

No, this is just the PCB/controller limitation. But there are chips with
frequency limitations depending on the type of command (see for instance
Winbond AC timings tables for DDR capable devices).

>> As
>> another example, there is no read retry information.
> What will retry information look like?

Number of retry modes, how to enable retry mode (which is maybe
standardized per manufacturer, in this case we can just get the right
hook from the manufacturer information, but otherwise if there are
differences inside production lines from a single manufacturer, we'll
still need either a table or some extension of CASN.

>> Nor anything about
>> the fact that the on-die ECC engine might not be disabled.
> As far as I know, only SkyHigh's SPI-NAND's ECC engine can't be
> disabled since its on-die ECC engine contains randomizer.

Randomizer and ECC engine are two different things, there are many raw
NAND controllers with a programmable ECC engine *and* randomizer. They
just choose to hide the controls.

Today it is SkyHigh. What about tomorrow?

> There are some reserved fields. We can handle above requirements in
> CASN V1.2 or V2. But may I ask what's the purpose of involving above
> information in CASN? Are there any practical application scenarios?

You claim you want to replace the ID tables. These tables are filled
with all the relevant data to make the chips supported in Linux. If one
of these fields is missing from CASN, it means we need to keep the
tables. So it kind of defeats the CASN purpose. Yes we may have dynamic
vendor hooks to adapt these parameters "on the fly", but we still need
internal tables for that.

>> Overall I think this is an interesting initiative but I would like it
>> to
>> be more advanced.
> Agree.
>
>> Is there a plan on getting this standardized through
>> eg. a JEDEC spec?
>>=20
>> Thanks,
>> Miqu=C3=A8l
> Yes. We're working on it. But it will take some time. Your opinions
> mean a lot to CASN page standardisation.

Thanks,
Miqu=C3=A8l

