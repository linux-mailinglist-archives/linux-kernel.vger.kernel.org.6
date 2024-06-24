Return-Path: <linux-kernel+bounces-227264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 955A7914E62
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD761F2305C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3720E13D8B4;
	Mon, 24 Jun 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pS4vnABl"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931641311A1;
	Mon, 24 Jun 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235679; cv=none; b=DhKVHbxS6XhwjG640aitr5ZDcTeRmcmklRzGctrFDLE6j+tGjLUjWhDUWC+1qTfsbMhrALVOVzoqCt6FHinNEYRaSmCdKSkJru1TKZPk0F+EVPz60oqudvqKcHyIXJRMRBYFP8oZIjHc7oJB0IX0Z/n15un7s7MxA8qWgN6vzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235679; c=relaxed/simple;
	bh=q7W2bWuaPX2NCVpdPsnP07OilATFFr6iOsEfWBJMp5o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv1uIfHz39pelkaN4b5fYWI92+C958tNSKnsxzQG78G8TKkXtKgkA4UV6qJCss+kH02FLvqDJfyEypuLKdi11yeg6Jwts23TAKD5nkb7745bwtBdf9TkDxBnbwHDneb5fQUnVFVfhk/olej/8fwPkRmYWPhik2kZ6hFluZy11mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pS4vnABl; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719235678; x=1750771678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q7W2bWuaPX2NCVpdPsnP07OilATFFr6iOsEfWBJMp5o=;
  b=pS4vnABlpvBqWLLuoU5pPW5m2pQm0FFBQwvqmfrAsw+4nist55ZajOyX
   ggvO6V1qF0bd2m+j/MUfV0D7hey4MLMiDPBIizcB+TtCfWLastcsIayps
   lAUH1LgkNFiAFws049UZdQ3bkKyMjheyTaMeE3p4bq9KBlaNRbPu5X31F
   lX28weNd1Wp1VaID3p0c/i6RlkLajzRc6EqAzyDxjd58ibpywIIoTkYTF
   gm1i9hrWQL6STPM6cQ+rNHrQ14/ALR1OF3Kd8gaPbh+bhEozaf/WvUu5g
   1lhWJqLFuTuSGn9XgtyebpX1+HSm7b8PhcZ3QvFfTjPyMjry5gylXKycv
   w==;
X-CSE-ConnectionGUID: 37UdzrFwQgCgH3/erkWXeg==
X-CSE-MsgGUID: c1HRnwrASlmIF8Z2xRtoJA==
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="asc'?scan'208";a="28421989"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2024 06:27:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 24 Jun 2024 06:27:21 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 24 Jun 2024 06:27:18 -0700
Date: Mon, 24 Jun 2024 14:27:03 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
CC: Conor Dooley <conor@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Message-ID: <20240624-skylight-coveting-27247d5a861e@wendy>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-2-a7d28dea5c4a@nxp.com>
 <20240617-control-calamari-317f59c4eb09@spud>
 <AM9PR04MB86049915593D86599C67975F95CE2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <AM9PR04MB8604DEB65CB32FF7D68013ED95D42@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RQcy21NTdWFXwBvy"
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8604DEB65CB32FF7D68013ED95D42@AM9PR04MB8604.eurprd04.prod.outlook.com>

--RQcy21NTdWFXwBvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 01:12:22PM +0000, Pankaj Gupta wrote:
> Hi Conor,
>=20
> > > > +properties:
> > > > +  $nodename:
> > > > +    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> > >
> > > Just "firmware@<hex>" please.
> > >
>=20
> Modified as per your suggestion,=20
> -    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> +    pattern: "^[0-9a-z]*-if@<hex>"
>=20
> encountering the following error:
> /home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,i=
mx-se.example.dtb: ele-if@0: $nodename:0: 'ele-if@0' does not match '^[0-9a=
-z]*-if@<hex>'
> 	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> /home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,i=
mx-se.example.dtb: v2x-if@3: $nodename:0: 'v2x-if@3' does not match '^[0-9a=
-z]*-if@<hex>'
> 	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> /home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,i=
mx-se.example.dtb: v2x-if@4: $nodename:0: 'v2x-if@4' does not match '^[0-9a=
-z]*-if@<hex>'
> 	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> /home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,i=
mx-se.example.dtb: v2x-if@5: $nodename:0: 'v2x-if@5' does not match '^[0-9a=
-z]*-if@<hex>'
> 	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
>=20
> Please help and guide to resolve this comment, correctly.
> Highly appreciated. Thanks.

I replied to you on the 18th:
https://lore.kernel.org/all/20240618-antonym-tabloid-8f721ee752a5@wendy/

Thanks,
Conor.

--RQcy21NTdWFXwBvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnl0JwAKCRB4tDGHoIJi
0jz7APwJ/pBI/FTKj8G6Nd1k2S7YdmUU71LWEV/UgLs3cQzfSgD+NqkbNG6eOv3S
ri+Ml/rq9NafPyGzrfg+BjBsM4MNoQA=
=dsov
-----END PGP SIGNATURE-----

--RQcy21NTdWFXwBvy--

