Return-Path: <linux-kernel+bounces-530490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2A3A4341D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0EA189CD59
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79441684AE;
	Tue, 25 Feb 2025 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hMwkPLVt"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE28156677
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740457662; cv=none; b=K9tWZNEinvDgpUqhePrcfX8CJL84VSmRQe1RR2i+eaq3DilgUUnQTvgYxOWBM1/nCHq3VPQxsIh5Q7ZX+tuhkO22H9ACWn4ZgHV4rudLstiSSo4vDsrssoE80egll/9kkyGEw01zZhw4pOJDrjy4x8pjTaLlNsdF+IiRpdezzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740457662; c=relaxed/simple;
	bh=tBq+uED9VcLqvQWo73iw5X2/Rdc3ERYOyoMS/2j02eE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QLEK9Obb516ZYe3X3p56vbVySf4ijKeEf79TDf0x4Du6FFEL6MyOGKFtREv2on+ChifssxUl3B16hHKpWNxe/T033dK34WcH1HwHxWKmgvLJjAZM4Vl2M4ns+PY3Zzbe1pGbDMfrHrzcwgdZlVsUbDuBy41YBh7UATecX46aVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hMwkPLVt; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1740457652;
	bh=tBq+uED9VcLqvQWo73iw5X2/Rdc3ERYOyoMS/2j02eE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hMwkPLVtLK1ZvJmQYYIrH7ps60fu/iAzOkiB+OHVTznrOoYho7yywweETK0X0NaWm
	 VAH9Vw8zS4N79Anp6DLvAZkOvP5EGe0vjl2prTuESNbvsoN6ElpXzFhjmmO7UajEeU
	 1yFOi6oZH3LsRLC6Krils2x/d1nxkfxnYDhuPTU8DgBlfnQ4Bq+eHkde7I0VIHxBTw
	 Vdqli5J76dtZmqgFj/LIfvZhGM97a6ltsYJ+JiIOmhIf+D0UhM0+bWgnSRn3z2pw2b
	 oJ4iVtEVLv9k54HnzOrlqRJxs7ymdnH6PCq8kMYC0HDdmwmyFoTYzhgeczEvTxencD
	 YTsIsVvw3hegg==
Received: from [IPv6:2405:6e00:2421:8fa3:333c:2fc8:332d:ddb4] (unknown [120.20.122.15])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4021170B52;
	Tue, 25 Feb 2025 12:27:27 +0800 (AWST)
Message-ID: <f7369d6205e05c7aac3f3de7cbd08c3b08960d75.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Chen <kevin_chen@aspeedtech.com>, "joel@jms.id.au"
 <joel@jms.id.au>,  Z-ChiaWei Wang <chiawei_wang@aspeedtech.com>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>
Cc: "tomer.maimon" <tomer.maimon@nuvoton.com>, Krzysztof Kozlowski
	 <krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>, "robh@kernel.org"
	 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org"
	 <conor+dt@kernel.org>, Jenmin Yuan <jenmin_yuan@aspeedtech.com>, BMC-SW
	 <BMC-SW@aspeedtech.com>
Date: Tue, 25 Feb 2025 14:57:25 +1030
In-Reply-To: <PSAPR06MB494947E21AB39369ADFA8C9489C72@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
	 <20250217114831.3225970-4-kevin_chen@aspeedtech.com>
	 <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
	 <6fd7cd57261ddf9831f57dc4c637b24e9f8982d9.camel@codeconstruct.com.au>
	 <PSAPR06MB4949C65DF5C034BD6B40C9B589FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
	 <d4945482509cad0bf3e8cd93c1fb21bac2e0c7f2.camel@codeconstruct.com.au>
	 <TY0PR06MB4960EA7255DF0BDF235F0D9689C52@TY0PR06MB4960.apcprd06.prod.outlook.com>
	 <ba2757fd02b3e7c8f9c862c76f2cfcd2b6bfb41b.camel@codeconstruct.com.au>
	 <PSAPR06MB494947E21AB39369ADFA8C9489C72@PSAPR06MB4949.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-21 at 00:51 +0000, Kevin Chen wrote:
> > On Wed, 2025-02-19 at 11:59 +0000, Kevin Chen wrote:
> > > > On Tue, 2025-02-18 at 11:11 +0000, Kevin Chen wrote:
> > > > > > On Mon, 2025-02-17 at 13:00 +0100, Krzysztof Kozlowski wrote:
> > > > > > > On 17/02/2025 12:48, Kevin Chen wrote:
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->mdev.parent=
 =3D dev;
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->mdev.minor =
=3D MISC_DYNAMIC_MINOR;
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->mdev.name =
=3D devm_kasprintf(dev, GFP_KERNEL,
> > > > > > > > "%s%d",
> > > > > > > > DEVICE_NAME,
> > > > > > > >=20
> > > > > >=20
> > > >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0pcc->mdev_id);
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->mdev.fops =
=3D &pcc_fops;
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D misc_regi=
ster(&pcc->mdev);
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc) {
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(dev, "Couldn't register misc
> > > > > > > > device\n");
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_free_kfifo;
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > > > >=20
> > > > > > > You cannot expose user-space interfaces from SoC drivers. Use
> > > > > > > appropriate subsystem for this with proper ABI documentation.
> > > > > > >=20
> > > > > > > See:
> > > > > > > https://lore.kernel.org/all/bc5118f2-8982-46ff-bc75-d0c71475e=
9
> > > > > > > 09@a
> > > > > > > pp.f
> > > > > > > astmail.com/
> > > > > > > and more discussions on LKML
> > > > > >=20
> > > > > > Further, drivers/misc/aspeed-lpc-snoop.c already exists:
> > > > > >=20
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
g
> > > > > > it/c
> > > > > > ommit/?id=3D
> > > > > > 9f4f9ae81d0affc182f54dd00285ddb90e0b3ae1
> > > > > >=20
> > > > > > Kevin: Did you consider reworking it?
> > > > > Andrew: No, I do not rework it but add the post code capture
> > > > > driver using the SNOOP registers. As a result, I add some code in
> > > > > aspeed_a2600_15 to check the SNOOP enable bit. PCC driver probe
> > > > > abort if snoop is enabled.
> > > >=20
> > > > Hmm, I think OpenBMC's history regarding POST code support caused
> > > > some confusion on my part. For whatever reason, the snoop device wa=
s
> > > > used as a source of POST codes despite the existence of the
> > > > dedicated POST code hardware since at least the AST2400, but...
> > > What I know about the dedicated POST code hardware in ASPEED should b=
e
> > > the same one in LPC module.
> > >=20
> > > >=20
> > > > > PCC is used for port I/O byte snooping over eSPI.
> > > >=20
> > > > ... it seems that they're largely interchangeable, just with
> > > > different hardware features (PCC has DMA)? My impression is that th=
e
> > > > snoop device could also be used over eSPI?
> > > Yes, PCC has DMA to capture the POST code.
> > > And snoop device also can be used over eSPI.
> > >=20
> > > These two devices of PCC and snoop use the same port I/O of 80h and
> > > 81h.
> > > But, in current usage of PCC, it can support a continuous, 4-bytes
> > > maximum region from port I/O 80h to 83h.
> > > What I know about PCC or snoop usage, depends on INTEL platform or AM=
D
> > > platform.
> > >=20
> > > For ASPEED, we want to upstream the PCC driver for the PCC usage.
> >=20
> > Yeah, that's fine, but I think some work needs to be done to provide co=
herence
> > in the devicetree binding and userspace APIs across both the ASPEED sno=
op
> > and PCC bits, as well as the Nuvoton BPC. Bespoke designs create pain.
> https://lore.kernel.org/linux-kernel//7661de74-f68c-6617-6a4e-3b0eb76a2a2=
e@linaro.org/T/
> Andrew, I find the "NPCM BPC driver" to get the link. Are these patches m=
atch what you mentioned?

That looks about right.

Note Rob's response there about disparate bindings:

https://lore.kernel.org/linux-kernel//20221130193014.GA2645083-robh@kernel.=
org/

>=20
> >=20
> > The PCC driver above reads the data out of the DMA ring-buffer straight=
 into
> > the kfifo hooked up the the miscdev read callback. The datasheet
> > notes: "the data structure of the FIFO is mode dependent" in the descri=
ption of
> > PCCR3, but no in-band or out-of-band mechanism (sysfs,
> > ioctl) is provided for userspace to query whether it's 1B, 2B, 4B or "f=
ull" mode.
> For the data structure in PCCR3, I checked with designer. We only need 2B=
 mode to get the information about data and related addresses.
> For example, from espi master send the port 80h~83h with first data 0x112=
23344 and second data 0x55667788. The PCC kfifo would be written in the fol=
lowing output from hexdump.
> # hexdump=C2=A0 /dev/aspeed-lpc-pcc0
> 0000000 4044 4133 4222 4311 4088 4177 4266 4355

Right, but that's different to how the Aspeed snoop chardev behaves.
Both the snoop and PCC features can be used to present the same data
(POST codes) to userspace. There should be a unified chardev behaviour
for POST codes so we don't end up with a mess in userspace to deal with
the differences in hardware capabilities.

If we've got a chardev it would feel idiomatic to me to have ioctls to
configure the hardware to the required capture mode for the platform.

> >=20
> > The situation with the snoop driver is similar (1 or 2 1B channels mult=
iplexed
> > into the one data stream). It also looks a bit quirky with multiple cha=
nnels
> > enabled, as what userspace reads will depend on the host access pattern=
s, but
> > no metadata is provided to userspace about what it's reading.
> Yes, for the snoop driver and PCC driver, some mechanism is the same. But=
 snoop only supports 2 bytes data from the 2 1B channels multiplexed.
> So, we need to add PCC driver to upstream for customer's 4 Bytes POST cod=
e capture usage even the PCC driver needs to check the snoop enabled or not=
.

I understand.

> Or, could you please give us come comments about how I can upstream the P=
CC driver.

Essentially I don't think it's okay that each driver implement a
bespoke chardev, or that the devices don't share a common devicetree
binding. I think what's needed is a small abstraction that provides
common chardev semantics to userspace (e.g. /dev/postcodeN) that can be
connected to the different backends provided by the hardware (Aspeed
snoop and PCC, Nuvoton BPC) and act on the needs of userspace (1, 2, 4-
byte POST codes, configured using ioctls).

Andrew

