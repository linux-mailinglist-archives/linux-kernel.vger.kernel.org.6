Return-Path: <linux-kernel+bounces-284281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDD394FF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3CC1F24977
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A08136320;
	Tue, 13 Aug 2024 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="et1USiSw"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447CE3B192;
	Tue, 13 Aug 2024 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536328; cv=none; b=Epez+qgzD9gdazjhWok/Kwcab9cvEZ9fDMSJZgeeDAmYgFEFf9QLmj+qTlvHVTsV70f/LzYtee6LqFKizbumeQvt0Xef1C0y2/WpV1v4axD3eTkye2bBrmS7eG18ef2oWijiy0ZjXXcpRLus1rZs7/e7mYI8az7xHRHwg54BfX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536328; c=relaxed/simple;
	bh=FIdrhg5f7gPL8C52+sglRjEBy/cZyurxJLuVYrykLcs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3viIMpL0SRPdjA8Pm9dFC2nvydpCRVEKvOF9M/jyKwDT6wtTG98FRaoYHFDveUCG8LhuKH5lYocw1ALW6e7RZSmd74f+4iYt2MPFqrFXveSi9zAA/hmPjgecaxfmo4BJive9lSrFjwBTGI1D/Ca6/BeCBxK8rbdzwdNVaecJfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=et1USiSw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723536326; x=1755072326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FIdrhg5f7gPL8C52+sglRjEBy/cZyurxJLuVYrykLcs=;
  b=et1USiSwpizgdot7p6iM7dqRE0GqlI1+zJIR/LXdMWOP8nU1ctLcsycb
   qyuN3+/S88KcJclKlTxGh2dUDU+N01ZjXqmPDX1PF/Ve09Dm9viZIFb+N
   DYL7GSs4pjLn1o36ye4XNdDLeywytvp1so2k7SWeTsWqmjq3CDAtZIOks
   9pouFE6DE/ePSHpb8jO65D+4s9soCzGabrjJ2t2XibhdFFe4FZ4qx+1IU
   j9TCxEiKaJXf4+iCX6UTM9rQD2GwKF+8UHc5+WY0h+n7aaL2pRf6iDogv
   qqINRARic2JK5q9uhlw1fotAQgt3qYtA6nxk1bFBu+sz3y1J8UGcBNRzt
   A==;
X-CSE-ConnectionGUID: oFI4QnJZT5WrEkZVyaQ1bA==
X-CSE-MsgGUID: HZzKbVx5Sh+M+65LtEXbHA==
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="asc'?scan'208";a="197845690"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 01:05:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Aug 2024 01:04:57 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Aug 2024 01:04:55 -0700
Date: Tue, 13 Aug 2024 09:04:17 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Conor Dooley <conor@kernel.org>, Minda Chen <minda.chen@starfivetech.com>,
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	<linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: jh7110-usb-phy: Add sys-syscon
 property
Message-ID: <20240813-haiku-pusher-f2fb037a2f49@wendy>
References: <cover.1723472153.git.jan.kiszka@siemens.com>
 <30f3ca9f6bd788e16767b36aa22c0e9dc4d1c6a4.1723472153.git.jan.kiszka@siemens.com>
 <20240812-overstuff-skirt-7a8aabbcdc6f@spud>
 <8cdba8b0-7364-4c09-b18a-f3f59da1eae2@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4yclWa1Vx5GaX1/H"
Content-Disposition: inline
In-Reply-To: <8cdba8b0-7364-4c09-b18a-f3f59da1eae2@siemens.com>

--4yclWa1Vx5GaX1/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 07:31:50AM +0200, Jan Kiszka wrote:
> On 12.08.24 17:55, Conor Dooley wrote:
> > On Mon, Aug 12, 2024 at 04:15:51PM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Analogously to the PCI PHY, access to sys_syscon is needed to connect
> >> the USB PHY to its controller.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >> ---
> >> CC: Rob Herring <robh@kernel.org>
> >> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> >> CC: Conor Dooley <conor+dt@kernel.org>
> >> ---
> >>  .../bindings/phy/starfive,jh7110-usb-phy.yaml         | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb=
-phy.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.y=
aml
> >> index 269e9f9f12b6..eaf0050c6f17 100644
> >> --- a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.ya=
ml
> >> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.ya=
ml
> >> @@ -19,6 +19,16 @@ properties:
> >>    "#phy-cells":
> >>      const: 0
> >> =20
> >> +  starfive,sys-syscon:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >> +    items:
> >> +      - items:
> >> +          - description: phandle to System Register Controller sys_sy=
scon node.
> >> +          - description: PHY connect offset of SYS_SYSCONSAIF__SYSCFG=
 register for USB PHY.
> >=20
> > Why is having a new property for this required? The devicetree only has
> > a single usb phy, so isn't it sufficient to look up the syscon by
> > compatible, rather than via phandle + offset?
> >=20
>=20
> I didn't design this, I just copied it from
> starfive,jh7110-pcie-phy.yaml. As that already exists, I'm neither sure
> we want to change that anymore nor deviate in the pattern here.

To be honest, I think some of the other users of phandle + offset on
this soc were just copy-pasted without thinking about whether or not they
were required too. This one seems like it should just be a lookup by
compatible in the driver instead of by phandle. As a bonus, it will work
with existing devicetrees - whereas your current implementation will
fail to probe on systems that have the old devicetree, a regression for
systems running with that devicetree and downstream firmware.

Cheers,
Conor.

> Jan
>=20
> >> +    description:
> >> +      The phandle to System Register Controller syscon node and the P=
HY connect offset
> >> +      of SYS_SYSCONSAIF__SYSCFG register. Connect PHY to USB controll=
er.
> >> +
> >>    clocks:
> >>      items:
> >>        - description: PHY 125m
> >> @@ -47,4 +57,5 @@ examples:
> >>                   <&stgcrg 6>;
> >>          clock-names =3D "125m", "app_125m";
> >>          #phy-cells =3D <0>;
> >> +        starfive,sys-syscon =3D <&sys_syscon 0x18>;
> >>      };
> >> --=20
> >> 2.43.0
> >>
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center
>=20

--4yclWa1Vx5GaX1/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrsTdQAKCRB4tDGHoIJi
0qFLAP9V1J8PxI9x0hWQY9Q7/h1oGpyntcEVazVyrJCTuLV1iwEAgBTmAnTv+AkD
7ty2V6D+iyeVdmYHbEWBlDVrNlDeKA0=
=cWfz
-----END PGP SIGNATURE-----

--4yclWa1Vx5GaX1/H--

