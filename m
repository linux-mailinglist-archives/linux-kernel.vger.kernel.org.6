Return-Path: <linux-kernel+bounces-291960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C19956963
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34AF28398D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8737B166F0C;
	Mon, 19 Aug 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jH3evXTk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DhE9D1D8"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8377515DBB2;
	Mon, 19 Aug 2024 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067310; cv=none; b=m8ESFORcnpQ9U5vMeCheg2sq7SAPaznWRilXALF6TG8bEhysgo40GL5QIdUc7fOWRiecgNigD77SZJis5zeRJ6lNmfRoNcpuEcZU/O+IXolGYnLGiSTPfQK57DnhL6mLiSExMzLe5PW1CykMoWpMTxIhroquk3PexLZE1weiaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067310; c=relaxed/simple;
	bh=FZ88kgAbDiM+8rWx3JLKtnx3vWamNJnTiO6nxHD3QN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFb1TL4uZN+sK5KEed7KaMhgv+Dkx++U+LxqWHOUpebVrOkKzGiFILq0kgY98PTjWKaD5XwWSsYNbCgHwcjWWft/15baA4JFmSSwCocaudiR/fNmM27CJYu7f2bUSEb4oOI1nRK6iGgbUTlU98T+R4kVIwz+TgtlPKcIpbt1pvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jH3evXTk; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=DhE9D1D8 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724067306; x=1755603306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N15B/fpX6Wf+7yRZPzvZUR8uMg/qc8/OqC4E1tAFR00=;
  b=jH3evXTkh6XeTT73g/uR7bBUExFSeNNJADgSF+yXjZFTPxvNHl/od6is
   X68wZEgzrmrnVKQljIPGWOZ88FIMhmEWAOoD1K6pfuoJNe+bbw4GWD2UL
   b0bt5ytEmBzV2rMkVAVOK7qYL+jVF6akeHpgeruy/tbqYFaQniUKV1xui
   ZsdZ2gxD1437xbHVyWT+1OuSTjvfMOngI/+X71T4jfe8HZgP9rrTo/sow
   hh9pqOT4msQ1AI0DGQ+dq8SrKqAczXmZGp/qlmBoTJI9NjgVpG3nOrsFU
   /w7h2SP6Yy7+jkycr8y7IRTCirXH6nVCZ/dc9uy0lJ1j/gZnVAmbc0JhA
   w==;
X-CSE-ConnectionGUID: faJc6t2ST8evPLTvnb7ZnA==
X-CSE-MsgGUID: 8BZy0lFMQPuHx7v62NpeGA==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38466299"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 13:35:04 +0200
X-CheckPoint: {66C32DE8-B-E9ED6009-C4B0BEC8}
X-MAIL-CPID: 436127ADD3E6AA614B224FC9CA86742D_3
X-Control-Analysis: str=0001.0A782F26.66C32DE8.00EC,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F37216141D;
	Mon, 19 Aug 2024 13:34:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724067299;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=N15B/fpX6Wf+7yRZPzvZUR8uMg/qc8/OqC4E1tAFR00=;
	b=DhE9D1D86sGzuRlnxoWc/CkbXtKJg/quYOSybQDXoNb+1ImLjY3dRftM/jvjKQf/sDbPDn
	upnezyp4nwym3XJqZ+Wz1N+cm+1jGSJDUffMG1ZcO3csVno9mWsNc0nK3VO731x8IZSJ3r
	Ehw6juC4OqHuurHQHzx5/ZCgGpE2/aGKpLX0TNyuzMjhA6Hk+IYCt8mTNXlFOF6IJijX/4
	JbUkZ122zTgx/v4oaSpoEi1kh0MdyfcDIPFSFydoaESNvigoSbZKdjE3KYjd6lK/RY/xip
	uTbJUMrFDYZrb05ssp14HWlXuPvefUi8AefGAeiXM4TCjfqVTl40VFirND5Qcw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, "linux@ew.tq-group.com" <linux@ew.tq-group.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla: improve pad configuration
Date: Mon, 19 Aug 2024 13:34:58 +0200
Message-ID: <2197430.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <PAXPR04MB84593B8DF03B5CFA7CA2D29F88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com> <20240724125901.1391698-7-alexander.stein@ew.tq-group.com> <PAXPR04MB84593B8DF03B5CFA7CA2D29F88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Peng,

thanks for the review.

Am Donnerstag, 1. August 2024, 05:04:49 CEST schrieb Peng Fan:
> > Subject: [PATCH 06/14] arm64: dts: freescale: imx93-tqma9352-
> > mba93xxla: improve pad configuration
> >=20
> > From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> >=20
> > - disable PU/PD if already done with external resistors
> > - do not configure Schmitt Trigger for outputs
> > - do not configure DSE / FSEL for inputs
> > - add missing pad groups
> > - assign muxed GPIO pads for X1 to gpio2 node
> >=20
> > Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  .../freescale/imx93-tqma9352-mba93xxla.dts    | 237 ++++++++++++----
> > --
> >  1 file changed, 164 insertions(+), 73 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> > mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> > mba93xxla.dts
> > index e2ee9f5a042c..c663b6585c3a 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> > @@ -222,6 +222,11 @@ rtc-irq-hog {
> >  	};
> >  };
> >=20
> > +&gpio2 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_gpio2>;
>=20
> I am not sure this is correct,  what are this used for?

This is for general GPIOs usable from userspace. I'll add a new patch for
adding gpio-line-names, so it should be clear.

> And this is new, not pad improvement.

Okay, I'll separate the changes from adding new/missing ones.

> I would prefer the other improvement part merged
> with patch 2.=20

Patch 2 already got merged, but despite that this patch is for the mainboard
while patch is addressing the module only.

> > +};
> > +
> >  &gpio3 {
> >  	ethphy-eqos-irq-hog {
> >  		gpio-hog;
> > @@ -509,25 +514,39 @@ &usdhc2 {
> >  };
> >=20
> >  &iomuxc {
> > +	pinctrl_afe: afegrp {
>=20
> no users?

There is no driver yet, but the pinctrl settings can still be created
meanwhile.

Thanks and best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



