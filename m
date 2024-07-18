Return-Path: <linux-kernel+bounces-256156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF08A9349FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BB9282E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724A47D3EF;
	Thu, 18 Jul 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MhAAoliR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1C76C76;
	Thu, 18 Jul 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291745; cv=none; b=MCUzJ5aPniU826+bm5sUakdoLDi6jGyKSmRcuCNObt5UGaIz0BBhk97OBuXNLtZGCcsOYA2q+AQyeVJ6ZZsvwOE+c1oYku7qwYybCc/U4JKOqUnPVV4XytqldT8JoqlgsZOhIcIukuO94S2/WPKVtvzBwGGSiP9KT55LAMXOC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291745; c=relaxed/simple;
	bh=GQ90CfiUp9GQFH+stXjB6UhzFZ658zc2hJxfnnw6+LY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbSrCxK69toTepiu61ELMt+O8D8Yh1asS0Y6k8Hjr2Lx0iKtRe9uv7733wRKpCmEjXOfEbP1PMiLuI42SBAEwnV5+x2wjHFX0RnsgPVeQ1j2JZf/TwoBQ3q1za/rH7alYFiP8GjTdNZIBHxxkqtl5EBqcwFijKsR4Fd4+UpFlEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MhAAoliR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721291745; x=1752827745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GQ90CfiUp9GQFH+stXjB6UhzFZ658zc2hJxfnnw6+LY=;
  b=MhAAoliRpWm2GrYv/VKhJ3FKc8hkgAs6ctLCWlcUkLpmFc5FDXVT3vlA
   U3oskTcMZGACIvo5Ocs6CCq1ovX7HxAaf57Qqkob85bWUkO6NRZXzWWKd
   c9JzO42njeOzzDBM36L8+7jgQUMD/iaVdfO1pHlFepdXLqCQH6Gc/Xo1v
   cet1DWVT/7mIo7sGmDSxLLlSpJdfHdCBcnT5vGlLLCWgF+1bK83pVuaa7
   4mpaBlpf6shvsRX/OR940/Mtg5oQC+NOT0nmld3jLOeAB7MHJW2XwVgPJ
   VSh4XevMSlHZsTTYEGDqU92onk6tsBNQltviBCG3ERPt0wnR5HMqHK+qP
   A==;
X-CSE-ConnectionGUID: NM8UNeGTS0KDNHePX5xKhQ==
X-CSE-MsgGUID: MOPJ3pYaRz2lBbyyYGSU7g==
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="asc'?scan'208";a="29395384"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2024 01:35:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jul 2024 01:35:12 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 18 Jul 2024 01:35:10 -0700
Date: Thu, 18 Jul 2024 09:34:47 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Christopher Obbard <chris.obbard@collabora.com>
CC: Dragan Simic <dsimic@manjaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Kever Yang <kever.yang@rock-chips.com>,
	Collabora Kernel Mailing List <kernel@collabora.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: rockchip: Add Firefly
 Core-PX30-JD4 with baseboard
Message-ID: <20240718-lapped-suffocate-0216bad82c68@wendy>
References: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
 <20240717-rockchip-px30-firefly-v2-1-06541a5a5946@collabora.com>
 <0c804e9a0227904b16bfb779f2009af1@manjaro.org>
 <e34f1a0a81de24437be7f582c719d3f128d44b51.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M/eED5uvzfX3fiyD"
Content-Disposition: inline
In-Reply-To: <e34f1a0a81de24437be7f582c719d3f128d44b51.camel@collabora.com>

--M/eED5uvzfX3fiyD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 09:31:45AM +0100, Christopher Obbard wrote:
> Hi Dragan,
>=20
> Thanks for the review.
>=20
> On Thu, 2024-07-18 at 06:36 +0200, Dragan Simic wrote:
> > Hello Christopher,
> >=20
> > On 2024-07-17 18:46, Christopher Obbard wrote:
> > > Add binding for the Firefly Core-PX30-JD4 SoM when used in conjunction
> > > with the MB-JD4-RK3328 & PX30 baseboard.
> > >=20
> > > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> > > ---
> > > =A0Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
> > > =A01 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > index 1ef09fbfdfaf5..33ca8028bc151 100644
> > > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > @@ -148,6 +148,12 @@ properties:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: engicam,px30-core
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: rockchip,px30
> > >=20
> > > +=A0=A0=A0=A0=A0 - description: Firefly Core-PX30-JD4 with MB-JD4-PX3=
0 baseboard
> > > +=A0=A0=A0=A0=A0=A0=A0 items:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: firefly,px30-mb-jd4
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: firefly,px30-core-jd4
> >=20
> > Similarly to how I suggested the new dts(i) files to be named, [1]
> > the model names should be named like this:
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: firefly,px30-jd4-core
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: firefly,px30-jd4-core-mb
>=20
> I suppose the order should be the other way around to match other entries=
, e.g
> firefly,px30-jd4-core-mb first?

Yes. Mainboard first, then som, then soc.

--M/eED5uvzfX3fiyD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpjTpwAKCRB4tDGHoIJi
0vYvAQChwfkGIE0/32IduBh2GaPYUCNW5YeTpiVEW/KfbjUjKgD/Z5aFyRvBUtXs
pIgZsf1TuAhLvjyp1ogTqoO51XQfPA0=
=a7op
-----END PGP SIGNATURE-----

--M/eED5uvzfX3fiyD--

