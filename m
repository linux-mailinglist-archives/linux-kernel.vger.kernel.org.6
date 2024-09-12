Return-Path: <linux-kernel+bounces-326185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF62976475
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80461F24E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253C1917EC;
	Thu, 12 Sep 2024 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OSHqFeot"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691018BB9F;
	Thu, 12 Sep 2024 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726129729; cv=none; b=M8DYHL37lrS9d3bB4U123Ev4m1y0eDx05l63UQwfRmh1BXYCvegLBVgFfd0aZhx0cRMYv58obwGnrs3qw4lAB6OOkVoinCQXmy4Yugi1ZD1LqvM2EG8KfIi3C4gR1OGmTAGxE+fjenX3pQbg7wgjWpOuzhlgfeTkmPNL7xQOxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726129729; c=relaxed/simple;
	bh=8Ddv7HUWuYQvmUZWtwWJeKEmMDUpqmgyTgmsWwrISAM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGIOExsZIrHvT6nr/9yTn4xTL4G9XtD8J4bXvQRSRzy00a3RMvTmAog+RJC5p2CIx0Dy8Wv4Sr35rMosG/jDGN0Nn7K89YjpCiRLJMDl9PcVYvKcyI2ZH0tUujKSyHvrMmAfxELLeO3SqD+KaVBnTP2I39nRar/tqIzhsIIxCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OSHqFeot; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726129727; x=1757665727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Ddv7HUWuYQvmUZWtwWJeKEmMDUpqmgyTgmsWwrISAM=;
  b=OSHqFeotgO28xatVqat7ydlOhmMSEPMuGLO2sd/+BVXEMnDkVv5gPXqg
   In9HBgdVUiY4sdA6dYEQslBK3pJ4xd1DF54dpUREDTiwD8Uj6ajQ0dRa8
   KUsJpFOkFWXsSijXs9Kf/S1QvSnaFW0/dACcYPKDsHDa9E4kgVENlLtgF
   qz8EVbo/9rT98561yCit+4OWeOZWcGf+as+x70sHF2cLfrG1H2Bp4nRj5
   MmVNx/qcbHtgqUu6f263nVRM/ZdoCuxRBO7tRyKryT3HjmYzf5uyneFlo
   RTN/EKVpZX5Wjx1FKq1h/5LOYmMjaBhWjnLeFX8V8Z0iYkA87cay6wJ2m
   w==;
X-CSE-ConnectionGUID: T7JnfdXURN2u+9KF+BrmJA==
X-CSE-MsgGUID: /5FdtCw2ReGk+R3+EKNFcg==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="asc'?scan'208";a="31689468"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2024 01:28:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 12 Sep 2024 01:28:05 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 12 Sep 2024 01:28:03 -0700
Date: Thu, 12 Sep 2024 09:27:30 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Conor Dooley <conor@kernel.org>, <krzk+dt@kernel.org>,
	<jassisinghbrar@gmail.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<matthias.bgg@gmail.com>, <houlong.wei@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<kernel@collabora.com>, <fshao@chromium.org>
Subject: Re: [PATCH] dt-bindings: mailbox: mediatek,gce-mailbox: Stop
 requiring clock-names
Message-ID: <20240912-unsaddle-rubbing-9aedc46c024b@wendy>
References: <20240911104327.123602-1-angelogioacchino.delregno@collabora.com>
 <20240911-unhappy-wifi-b0a851e261bb@spud>
 <01020191e53e7670-d04af181-0137-4f35-962e-2f1119d026df-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EYD/Iv1Qa4+YYkTp"
Content-Disposition: inline
In-Reply-To: <01020191e53e7670-d04af181-0137-4f35-962e-2f1119d026df-000000@eu-west-1.amazonses.com>

--EYD/Iv1Qa4+YYkTp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 07:59:21AM +0000, AngeloGioacchino Del Regno wrote:
> Il 11/09/24 19:51, Conor Dooley ha scritto:
> > On Wed, Sep 11, 2024 at 12:43:27PM +0200, AngeloGioacchino Del Regno wr=
ote:
> > > There is no reason to make specifying the clock-names property
> > > mandatory, as the Global Command Engine HW needs only one clock.
> >=20
> > Have you checked to make sure that there are no users that do the lookup
> > by name?
> >=20
>=20
> It's just that I didn't want to mention any "driver" word in the commit d=
escription
> for a binding ;-)
>=20
> (Of course I did, and the driver is not doing any by_name lookup)

It's fine to mention drivers in this case, it'd save us asking. Given
your choice of article, is the gce-mailbox not used outside of the
kernel?

>=20
> > >=20
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@=
collabora.com>
> > > ---
> > >   .../bindings/mailbox/mediatek,gce-mailbox.yaml        | 11 --------=
---
> > >   1 file changed, 11 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-m=
ailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbo=
x.yaml
> > > index cef9d7601398..ff5d010fbcf0 100644
> > > --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.=
yaml
> > > +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.=
yaml
> > > @@ -56,17 +56,6 @@ required:
> > >     - interrupts
> > >     - clocks
> > > -allOf:
> > > -  - if:
> > > -      not:
> > > -        properties:
> > > -          compatible:
> > > -            contains:
> > > -              const: mediatek,mt8195-gce
> > > -    then:
> > > -      required:
> > > -        - clock-names
> > > -
> > >   additionalProperties: false
> > >   examples:
> > > --=20
> > > 2.46.0
> > >=20
>=20
>=20

--EYD/Iv1Qa4+YYkTp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuKl4wAKCRB4tDGHoIJi
0tumAP943qZFgBuFVe+btsj1qTbWlXxCqsq4MWQNp77G2A6MbwEA1XQp6AQftUQi
i/4Z6mryf6pc/ploLFfLEnuNprWc/g4=
=ZrkD
-----END PGP SIGNATURE-----

--EYD/Iv1Qa4+YYkTp--

