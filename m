Return-Path: <linux-kernel+bounces-179626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301578C6281
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C2B282089
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1282B4A99C;
	Wed, 15 May 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nzUFl2Kx"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188B4C62E;
	Wed, 15 May 2024 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760400; cv=none; b=Qe97Mu+6R47RSngnBB/jErRbu7Gr3R754IL6HvFWzCgXkWwN/E5Sedwm4OQxjB67uOpcTFJdHeXkz3GBBtQJLgUHd3azgQrQQCQJx64OZwDYqD7rTCU8pBtTTzTHSICAbJEda/86JcoG6KpVWrPtwpcNf35vy59+jx6KX1N4Y4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760400; c=relaxed/simple;
	bh=h0Sqhr4ifyZrC1b5lPNa6Gyug/wpM7myXaQxIuh3AZ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqC11zrJcf19aZ6ktVGTNzOAAHSpsxEaeKL9zmcYHU63b8ffQdT6O4g3SwoP5TOefiN8NpechCAuu0psOoQI0JvtKK1pm83Xw0pBVYNsjIdW/ruYsXV1E8jE9GXnL4fPQsxajz/nP4Cu9uPmtqQSgQlf0kW4AUHsjf7gk1clDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nzUFl2Kx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715760398; x=1747296398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h0Sqhr4ifyZrC1b5lPNa6Gyug/wpM7myXaQxIuh3AZ4=;
  b=nzUFl2KxHPlZyCxSu7RzeKN3iZy4YGBVDp/ohKEDRKIQu/j1Ia1QrFby
   QCCdAQBsllYyRSV8S2wOBdj1Sf7aScUsbByFWD45upZr2UyUF2nvJTJF1
   nztaDtcXU09yEpBEfHk/BwGMqlF9PVEmH4aZKpQbTh/CEMBYFksafRB31
   uSRXnVH8k+mtOtVnfcRE9YufAkfLArWa8+SMJa2APjtKkWcAX4oVMMQWW
   LcOpBp/mGajcFORdRfsw6ngR6V3Crtm8SenK9rzOG6GcBrt501SxkzfhX
   IfFA8k/GEKMLWVLPwihI+amyN8Oxu4NJ8K08MkiGMa1plI42ELgz7IQCL
   g==;
X-CSE-ConnectionGUID: EvxhA01VQR6BcbhVcVTEIw==
X-CSE-MsgGUID: gMj862SdQQKslckEPmEeNQ==
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="asc'?scan'208";a="25383960"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2024 01:06:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 01:06:22 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 15 May 2024 01:06:20 -0700
Date: Wed, 15 May 2024 09:06:06 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Alina Yu <alina_yu@richtek.com>
CC: Conor Dooley <conor@kernel.org>, Mark Brown <broonie@kernel.org>,
	<lgirdwood@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: Re: [PATCH v3 6/6] regulator: dt-bindings: rtq2208: Add property to
 get ldo of RTQ2208 is adjustable or not
Message-ID: <20240515-wrinkle-engross-ab6b089baae3@wendy>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>
 <20240513-tissue-repave-13d2e3bf88fd@spud>
 <d97752ed-4032-4681-b28f-17f149fdc3d4@sirena.org.uk>
 <20240514-plunging-chair-803d9e342e6f@spud>
 <20240515073830.GA12525@linuxcarl2.richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0FcHBb/wqZoBsRLq"
Content-Disposition: inline
In-Reply-To: <20240515073830.GA12525@linuxcarl2.richtek.com>

--0FcHBb/wqZoBsRLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 03:38:30PM +0800, Alina Yu wrote:
> On Tue, May 14, 2024 at 07:01:21PM +0100, Conor Dooley wrote:
> > On Tue, May 14, 2024 at 11:34:29AM +0100, Mark Brown wrote:
> > > On Mon, May 13, 2024 at 05:22:54PM +0100, Conor Dooley wrote:
> > > > On Fri, May 10, 2024 at 08:06:25PM +0800, Alina Yu wrote:
> > >=20
> > > > > +            richtek,fixed-microvolt =3D <1200000>;
> > > > >              regulator-min-microvolt =3D <1200000>;
> > > > >              regulator-max-microvolt =3D <1200000>;
> > >=20
> > > > I'm dumb and this example seemed odd to me. Can you explain to me w=
hy
> > > > it is not sufficient to set min-microvolt =3D=3D max-microvolt to a=
chieve
> > > > the same thing?
> > >=20
> > > This is for a special mode where the voltage being configured is out =
of
> > > the range usually supported by the regulator, requiring a hardware
> > > design change to achieve.  The separate property is because otherwise=
 we
> > > can't distinguish the case where the mode is in use from the case whe=
re
> > > the constraints are nonsense, and we need to handle setting a fixed
> > > voltage on a configurable regulator differently to there being a
> > > hardware fixed voltage on a normally configurable regulator.
> >=20
> > Cool, I think an improved comment message and description would be
> > helpful then to describe the desired behaviour that you mention here.
> > The commit message in particular isn't great:
> > | Since there is no way to check is ldo is adjustable or not.
> > | As discussing in v2 series, 'richtek,fixed-microvolt' is added for th=
at.
> > | user is supposed to know whether vout of ldo is adjustable.
> >=20
> > It also doesn't seem like this sort of behaviour would be limited to
> > Richtek either, should this actually be a common property in
> > regulator.yaml w/o the vendor prefix?
> >=20
> > Cheers,
> > Conor.
>=20
>=20
> Hi Conor,
>=20
>=20
> Should I update v4 to fix the commit message ?
> I will modify it as follows.
>=20
>=20
> There are two types of LDO VOUT: fixed voltage mode and adjustable voltag=
e mode.
>=20
> As the fixed voltage for the LDO is outside the range of the adjustable v=
oltage mode,
> the constraints for this scenario are not suitable to represent both mode=
s.

That's definitely an improvement, yes. The property description could
also do with an update to explain that this is for a situation where the
fixed voltage is out of the adjustable range, it doesn't mention that at
all right now.

> In version 3, a property has been added to specify the fixed voltage.

Don't refer to previous versions of the patchset in your commit message,
that doesn't help people reading a commit log in the future etc. If
there's some relevant information in a previous version patchset, put it
in the commit message directly.

Cheers,
Conor.

--0FcHBb/wqZoBsRLq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkRs7gAKCRB4tDGHoIJi
0vH7AQD9Pv88a/PkA91egE2kjvXH7h48NPsjCN8xwJ8vNsM5XgEAuD17AiUn8eu7
CNpGygjTUdxaBxaAC0nC6jR2+XMgXwg=
=ELYJ
-----END PGP SIGNATURE-----

--0FcHBb/wqZoBsRLq--

