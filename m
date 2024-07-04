Return-Path: <linux-kernel+bounces-240630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DCE927023
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0774428308E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00521A0AFB;
	Thu,  4 Jul 2024 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gglCOG7u"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C78187349;
	Thu,  4 Jul 2024 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076315; cv=none; b=LHEM5hDHOyFGSp8pE9UlWeySqZT2qxL43185rw9w62EF3b83D9lxsfkkmhRqtfF41GTrPdhmSBF8EfakJrdME+Ok0q6+q/C6Og5O00fjputJXmI+/ZL/+EpoVD0JhK0WQsYysvwoPQlLsvL0hcd6JK2TV9Dwanjj4lWW1D5Hzns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076315; c=relaxed/simple;
	bh=3UgLpSJokSXHz03kcWhO4MDgWt9anQgFe2EtKmPtrhU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMSvBMfY5YSYmajpBscK9rMXDU6E31ayJTghO92Th5hpiqSIxYDzmg5Am9MwS9A6vEXkP5DUqyLigdIK3y5Pp1dJjmQwgj/FNI9ZHvH86JFmAkJbYFbSc7VHr4eTW4jO2knemTwGBJRPMyGzg8SjA1KYAeahGk9juJi/AAIUlj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gglCOG7u; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720076313; x=1751612313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3UgLpSJokSXHz03kcWhO4MDgWt9anQgFe2EtKmPtrhU=;
  b=gglCOG7uq72bb1HEfGXyLj6W4XSizqJopYV1SUK6+7+h44ESUglITDKN
   RT39TBrAFmyt0d/GfAq+Zs79pjFeSJhoCJOlWK4PPQvedzGMNolbUN+Po
   ubgcyQBwzVwjQdyfMZ2k8NLJTfs9uLz/HA8cnG7o75s0iw3VvpM/J9Jkh
   abWMGO7nzM0eFHtXRVsZ8PaKy/zR7YmyeWeu0TrjFIkn5lmrS8SuUvd/m
   jQMYUhBrhHWsU4+CyV4fdUp0ym3m11t3/7yK2p+VJRnFxC43OME0+Hs/k
   ITzcdaWxWl0NKC6o0sbP/ooma5+P1UqZxJG/+V+Hc9TwNa6Uk6fcctjkf
   g==;
X-CSE-ConnectionGUID: iv4bRy3fTFqIlUfcw5UgKw==
X-CSE-MsgGUID: 0TbRDD8NR8CjV9LrSEDbHw==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="asc'?scan'208";a="196237195"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 23:58:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 23:58:14 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 3 Jul 2024 23:58:12 -0700
Date: Thu, 4 Jul 2024 07:57:52 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Frank Li <Frank.Li@nxp.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<imx@lists.linux.dev>, Ran Wang <ran.wang_1@nxp.com>, Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add chip-specific compatible
 string 'fsl,ls-dwc3'
Message-ID: <20240704-ladies-economy-1adc905930bf@wendy>
References: <20240703-dwc-v1-0-9cbc93d49180@nxp.com>
 <20240703-dwc-v1-1-9cbc93d49180@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rDYC5f6Mi3xyoxwn"
Content-Disposition: inline
In-Reply-To: <20240703-dwc-v1-1-9cbc93d49180@nxp.com>

--rDYC5f6Mi3xyoxwn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 07:06:54PM -0400, Frank Li wrote:
> From: Ran Wang <ran.wang_1@nxp.com>
>=20
> Some Layerscape paltforms (such as LS1088A, LS2088A, etc) require update =
HW
> default cache type configuration to fix DWC3 init failure when applying
> property dma-coherent.

Your driver patch looks odd because it doesn't actually check if
dma-coherent is present before setting this configuration. Is it okay to
set this configuration when dma-coherent is not present?

> The cache type configuration is actually native feature of DWC3, not
> additional desgin (or glue layer) coming from SoC, so add compatible stri=
ng
> 'fsl,ls-dwc3'.

You'd need to add specific compatibles here for the broken platforms,
otherwise it is not clear to users what platforms to actually use this
one.

> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Docum=
entation/devicetree/bindings/usb/snps,dwc3.yaml
> index 1cd0ca90127d9..02cb986d0fd32 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -32,6 +32,7 @@ properties:
>    compatible:
>      contains:
>        oneOf:
> +        - const: fsl,ls-dwc3

This clearly was not actually tested properly - your driver patch never
changes of_dwc3_match, so providing only this property won't work & your
expectation is actually that there is a fallback to snps,dwc3. The
binding does not allow that fallback as written.

Thanks,
Conor.

>          - const: snps,dwc3
>          - const: synopsys,dwc3
>            deprecated: true
>=20
> --=20
> 2.34.1
>=20

--rDYC5f6Mi3xyoxwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoZH7wAKCRB4tDGHoIJi
0i6nAQCkZy/zco37CZqlrgT7inFam7MhyjRdvvMhrg+P/2/8WAEAv+CiekNGPqHM
VnQaM4xxKBfi3ZcK+G6O9dhws0B8iwQ=
=WAI2
-----END PGP SIGNATURE-----

--rDYC5f6Mi3xyoxwn--

