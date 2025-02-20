Return-Path: <linux-kernel+bounces-522801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1119FA3CE9C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B832189AC14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C731BBBFD;
	Thu, 20 Feb 2025 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jDPkX9yb"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD21AC88B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014558; cv=none; b=uaOZDse+XIag4v26/IBIRWU+SOl28DyH2Q5c0eW+HdW0L3Od+wVoBOYc+7Xt9sMboqN66ELDXW0Ay7ytDzfQZlQfSuDSCCsaHyXUMF6GEZhjG+LG1ld704O1+uTium1jfjuSSUwzvCf5+i1nFsbPpLDD7VJDrP9pTMjIBC9TthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014558; c=relaxed/simple;
	bh=/aBZNCva4WH3GgF1JWE0vCHAorP1a+UaOp78AtPSvIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWRvNlwjRM1RElnVLN5/wD1tD4uxORBwEbwq0kN5XW/vyot0dGIrONXKteydMbBDoY8w37y0oL5lHfkA0nZ9/+4WIcqCwZwg3Knuqrn22wmxlWg54ar1rZdIFRet3U+IdEhr7+Zx9JqQfFLa6htobf4n1jTLn4K9oNC0a/sCnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jDPkX9yb; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1740014547;
	bh=/aBZNCva4WH3GgF1JWE0vCHAorP1a+UaOp78AtPSvIs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jDPkX9ybPVbYrZwggfWgeyoBnY0mjGJ8ASBUDf5oFON4YnflN9naB/3vgG1afQQTX
	 GFOY0t7ZJXkBgeTkXiIHwYp5gpVuZeyntuTHe2jtjNvTj2qsIJ0YID9Oiv7KHwN179
	 +QBCsAliWT8EV1jf7Tu1XH0aEpdTiy/ajFd05daKgIqqx7uUEitI/7FsZqjH8lPE47
	 6jrlxSBjvY+DLtPHKQPSpTWcQpoyrERhBrRk7egdOetj5VnlsamurHTeqv8zo+zCf/
	 Y9souM03kgD780Kvvnknx8NQjYG+QSKUAU7QV+NpR74yIvrzptt9jkgBBDuuLWCtHv
	 +/o4S0PDEWLGw==
Received: from [192.168.68.112] (ppp118-210-187-53.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.53])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E1E3C76942;
	Thu, 20 Feb 2025 09:22:23 +0800 (AWST)
Message-ID: <ba2757fd02b3e7c8f9c862c76f2cfcd2b6bfb41b.camel@codeconstruct.com.au>
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
	 <conor+dt@kernel.org>
Date: Thu, 20 Feb 2025 11:52:23 +1030
In-Reply-To: <TY0PR06MB4960EA7255DF0BDF235F0D9689C52@TY0PR06MB4960.apcprd06.prod.outlook.com>
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
	 <20250217114831.3225970-4-kevin_chen@aspeedtech.com>
	 <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
	 <6fd7cd57261ddf9831f57dc4c637b24e9f8982d9.camel@codeconstruct.com.au>
	 <PSAPR06MB4949C65DF5C034BD6B40C9B589FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
	 <d4945482509cad0bf3e8cd93c1fb21bac2e0c7f2.camel@codeconstruct.com.au>
	 <TY0PR06MB4960EA7255DF0BDF235F0D9689C52@TY0PR06MB4960.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-19 at 11:59 +0000, Kevin Chen wrote:
> > On Tue, 2025-02-18 at 11:11 +0000, Kevin Chen wrote:
> > > > On Mon, 2025-02-17 at 13:00 +0100, Krzysztof Kozlowski wrote:
> > > > > On 17/02/2025 12:48, Kevin Chen wrote:
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->mdev.parent =3D=
 dev;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->mdev.minor =3D =
MISC_DYNAMIC_MINOR;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->mdev.name =3D d=
evm_kasprintf(dev, GFP_KERNEL,
> > > > > > "%s%d",
> > > > > > DEVICE_NAME,
> > > > > >=20
> > > >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0pcc->mdev_id);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->mdev.fops =3D &=
pcc_fops;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D misc_register=
(&pcc->mdev);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(dev, "Couldn't register misc
> > > > > > device\n");
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_free_kfifo;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > >=20
> > > > > You cannot expose user-space interfaces from SoC drivers. Use
> > > > > appropriate subsystem for this with proper ABI documentation.
> > > > >=20
> > > > > See:
> > > > > https://lore.kernel.org/all/bc5118f2-8982-46ff-bc75-d0c71475e909@=
a
> > > > > pp.f
> > > > > astmail.com/
> > > > > and more discussions on LKML
> > > >=20
> > > > Further, drivers/misc/aspeed-lpc-snoop.c already exists:
> > > >=20
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
c
> > > > ommit/?id=3D
> > > > 9f4f9ae81d0affc182f54dd00285ddb90e0b3ae1
> > > >=20
> > > > Kevin: Did you consider reworking it?
> > > Andrew: No, I do not rework it but add the post code capture
> > > driver
> > > using the SNOOP registers. As a result, I add some code in
> > > aspeed_a2600_15 to check the SNOOP enable bit. PCC driver probe
> > > abort
> > > if snoop is enabled.
> >=20
> > Hmm, I think OpenBMC's history regarding POST code support caused
> > some
> > confusion on my part. For whatever reason, the snoop device was
> > used as a
> > source of POST codes despite the existence of the dedicated POST
> > code
> > hardware since at least the AST2400, but...
> What I know about the dedicated POST code hardware in ASPEED should
> be the same one in LPC module.
>=20
> >=20
> > > PCC is used for port I/O byte snooping over eSPI.
> >=20
> > ... it seems that they're largely interchangeable, just with
> > different hardware
> > features (PCC has DMA)? My impression is that the snoop device
> > could also be
> > used over eSPI?
> Yes, PCC has DMA to capture the POST code.
> And snoop device also can be used over eSPI.
>=20
> These two devices of PCC and snoop use the same port I/O of 80h and
> 81h.
> But, in current usage of PCC, it can support a continuous, 4-bytes
> maximum region from port I/O 80h to 83h.
> What I know about PCC or snoop usage, depends on INTEL platform or
> AMD platform.
>=20
> For ASPEED, we want to upstream the PCC driver for the PCC usage.

Yeah, that's fine, but I think some work needs to be done to provide
coherence in the devicetree binding and userspace APIs across both the
ASPEED snoop and PCC bits, as well as the Nuvoton BPC. Bespoke designs
create pain.

The PCC driver above reads the data out of the DMA ring-buffer straight
into the kfifo hooked up the the miscdev read callback. The datasheet
notes: "the data structure of the FIFO is mode dependent" in the
description of PCCR3, but no in-band or out-of-band mechanism (sysfs,
ioctl) is provided for userspace to query whether it's 1B, 2B, 4B or
"full" mode.

The situation with the snoop driver is similar (1 or 2 1B channels
multiplexed into the one data stream). It also looks a bit quirky with
multiple channels enabled, as what userspace reads will depend on the
host access patterns, but no metadata is provided to userspace about
what it's reading.

This should be fixed so userspace can have some certainty and a useful
API to work against (one that provides a direct description of what's
being read out).

I expect we could similarly consolidate the devicetree bindings,
covering what IO port range to attach to.

Andrew

