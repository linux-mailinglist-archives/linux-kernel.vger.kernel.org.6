Return-Path: <linux-kernel+bounces-321223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE1097161B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158FE1C21DA9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A341B5ECD;
	Mon,  9 Sep 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dm2JnQHZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4351B5EC4;
	Mon,  9 Sep 2024 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879704; cv=none; b=CRRZ/+/ct6/at/zNUo89HsbUdbsEvfMyHWAto9KPsdtp7a4KMYSdrx68NqnB3G9GZuekeDfkVrdQ0kiZhoPk5FrKgv32jPtGJsL1SnJrLUwFi2rUa9dDQmTGS8OupI4NrgtUueRohO77JAzloB98NM9A1qkgUBiBDACfl+GYPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879704; c=relaxed/simple;
	bh=NBfetU1tuPGF40NFwCRfjXTAnVcsd+jrqT6DGlVV8zY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuNQp3p4qbQa22/LBFIi7B7N70wM1GJt9oIoS+NSv3PnHKJqyuycJrTbCZGLpzqu0zaJWKvo/wQjlZ3jMyK9C4QJa3dvUf7n3a1V63pHZ6jTX4DleDf88tTIH31DpH1YVkLHZZia2PODasGUIX2AwH7fFrvKE+WIeGFp3xObv1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dm2JnQHZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725879702; x=1757415702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NBfetU1tuPGF40NFwCRfjXTAnVcsd+jrqT6DGlVV8zY=;
  b=dm2JnQHZmRyewanb4rOQQVLEMfxz/oRPuZ6IbQ3g9vLiDE+okHb8zLDI
   XYCFjMryHobWHHl/hnAOOVbdxgLz1w+l9q87ofSgzvS9+cyr646RAa4bT
   f4vcldDNeHAWU0Dr1y5+nX9KRfMTY/Az0FXW8ooDnpOIE0UiTwdzRaCjq
   WkJP6Fs0VgXrX+STAB8RZJp883DrqlbHnIJWBbHAS7HbdzzCc8FVYxG3+
   9tfiE1RYKuDYkSLERerQslnnM/56RLT32fG6+cDMUNFkddalaxiBL2iM4
   KWTpODlba41tzRMhCjchQrMBcLn2gxzbmPz8aerHitZZGjOs3CEibOhdc
   Q==;
X-CSE-ConnectionGUID: qk8WIiT/Qs+26UX25OgPcA==
X-CSE-MsgGUID: UxG/giFbSdKmvRiPoMmIeA==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="asc'?scan'208";a="31414583"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 04:01:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 04:01:28 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 04:01:26 -0700
Date: Mon, 9 Sep 2024 12:00:53 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Conor Dooley <conor@kernel.org>, <devicetree@vger.kernel.org>,
	<cyril.jean@microchip.com>, <valentina.fernandezalanis@microchip.com>,
	<nitin.deshpande@microchip.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC v1] dt-bindings: add IP versioning document for Microchip
 FPGAs
Message-ID: <20240909-smock-displease-75d3fc0ff5da@wendy>
References: <20240830-culinary-cautious-2c2c19902dcb@spud>
 <4lsua4cxpxlla4i5rn7zmw3tvkbxz664a7as6jqy6qceljlj4x@ssev4fvuqz36>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W2pgH3A4lbTX5fCP"
Content-Disposition: inline
In-Reply-To: <4lsua4cxpxlla4i5rn7zmw3tvkbxz664a7as6jqy6qceljlj4x@ssev4fvuqz36>

--W2pgH3A4lbTX5fCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 08:45:06AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Aug 30, 2024 at 05:00:40PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > This is a pretty rough document I conjured up in 5 minutes, to document
> > my expectations for compatible strings for both our FPGA IP blocks and
> > reference designs that we ship, a la the one that exists for SiFive IPs.
> > There's been some internal conversations lately about this naming etc,
> > so good to have something written down.
> >=20
>=20
> You can try to make it a schema. Take a peak at:
> Documentation/devicetree/bindings/arm/qcom-soc.yaml

Sure, I don't mind doing that - however given the breadth of microchip's
portfolio (and thus naming schemes) there may actually be little by way
of enforcement gained by making it into a binding. I'll give it a go and
see how permissive it ends up having to be.

--W2pgH3A4lbTX5fCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt7VZQAKCRB4tDGHoIJi
0oy9AQDuvyK7TvTcOXYEM/syqaPEZAQg2cgpALVduaXtN5yS+QD/SJHA/qGm6WLp
Lu3nUG55BU97sLgdGYRQ/TqZZB92/Ao=
=EQpM
-----END PGP SIGNATURE-----

--W2pgH3A4lbTX5fCP--

