Return-Path: <linux-kernel+bounces-365193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B4B99DED9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAED283863
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A256218B478;
	Tue, 15 Oct 2024 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2hL0BQAF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D5172BCE;
	Tue, 15 Oct 2024 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975405; cv=none; b=ERBSInzMSJGLaxcUlr+gCY8j3IrwY9dzkyMlV1C06SHD9ar7wCdzCQk+VFgtMohFBZpGdsKXGQ5W9/R1lnQakT63U7nLItcFdwXwpdH3sCEEWsx3im0Vxx50Hhw+ZWYsiYsqpeW7QUn6Z9IaXrqtK/1ggUcDoXKahtnEtXACyRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975405; c=relaxed/simple;
	bh=4Sj4pR4hDeqqU2JhHI+sXnxUm8jUqiCpTHuhpkV97O4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDh6jC0tQOzbFSIHguSJG3OzUl47Zi6nx+aHMB9DoBSGRzhJHhJ67Dy44sQixUpCZTDX4+/iYG7RV4hSrwJi5lAZedly/VF0+nN4LeeO/ay8GnTaXLIqK7P8vVHA2gBFgqhxMU0Bjzylcq7EPayQPNbRnZzTzzmnn8FZ1o7u6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2hL0BQAF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728975403; x=1760511403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Sj4pR4hDeqqU2JhHI+sXnxUm8jUqiCpTHuhpkV97O4=;
  b=2hL0BQAF+FKXuxRAWpfMiE8uiJEQaWyq6ZfK8UfyyhS93FDUuEZ4KqwM
   6uedrr75rW9FJurMJHFnTEb8/5tKtgWflYcmk8ckLc4oIumhg6feOYV0i
   DYMyyACwSR/Kz5IGOWL7WiaERMXwuNlh0T+b+LYd1JRn8KhBW4r5/dz55
   uHDdQ8XpeZd6VFUhVzfQPAq/VTVHub39EaPDZ84BSk81Uenfv3N7lDKRB
   vcS2joTlxZJLjpfh0/279lrVWCXCm5l2DYp23LG+1Ha00Vs9oNaLTamSw
   b8Sruj4lNJ+5R02QoG8h5LD/awsjL0cH3jidMKNFM656Vkcf2P6buFa8A
   w==;
X-CSE-ConnectionGUID: XyjmHW/JQKad8t5tqwiT3A==
X-CSE-MsgGUID: wlxq7VeBR3KD9OaaVPDVjA==
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="asc'?scan'208";a="33020112"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2024 23:56:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 14 Oct 2024 23:56:40 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 14 Oct 2024 23:56:39 -0700
Date: Tue, 15 Oct 2024 07:56:20 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Naresh Solanki <naresh.solanki@9elements.com>
CC: Andrew Jeffery <andrew@codeconstruct.com.au>, "Rob Herring (Arm)"
	<robh@kernel.org>, <devicetree@vger.kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Joel Stanley <joel@jms.id.au>, Conor
 Dooley <conor+dt@kernel.org>, <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Message-ID: <20241015-portion-parish-4ca08647bb4c@wendy>
References: <20241010112337.3840703-1-naresh.solanki@9elements.com>
 <172857036038.1533242.5775916298170949713.robh@kernel.org>
 <4d596ac9a2215be8510369c948e0b9680ee2fce3.camel@codeconstruct.com.au>
 <CABqG17gmjvBmpp2a7tgVwR+q3tsrbejVmezWaXH__txytr30hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zgnNujWOZf5FzJWM"
Content-Disposition: inline
In-Reply-To: <CABqG17gmjvBmpp2a7tgVwR+q3tsrbejVmezWaXH__txytr30hQ@mail.gmail.com>

--zgnNujWOZf5FzJWM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 01:38:52PM +0530, Naresh Solanki wrote:
> Hi Andrew,
>=20
>=20
> On Fri, 11 Oct 2024 at 05:15, Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >
> > Hi Naresh,
> >
> > On Thu, 2024-10-10 at 09:30 -0500, Rob Herring (Arm) wrote:
> > > On Thu, 10 Oct 2024 16:53:31 +0530, Naresh Solanki wrote:
> > > > Document the new compatibles used on IBM SBP1.
> > > >
> > > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > > Changes in V4:
> > > > - Retain Acked-by from v2.
> > > > - Fix alphabetic order
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > >
> > >
> > > My bot found new DTB warnings on the .dts files added or changed in t=
his
> > > series.
> > >
> > > Some warnings may be from an existing SoC .dtsi. Or perhaps the warni=
ngs
> > > are fixed by another series. Ultimately, it is up to the platform
> > > maintainer whether these warnings are acceptable or not. No need to r=
eply
> > > unless the platform maintainer has comments.
> > >
> > > If you already ran DT checks and didn't see these error(s), then
> > > make sure dt-schema is up to date:
> > >
> > >   pip3 install dtschema --upgrade
> > >
> > >
> > > New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ibm-sbp1.=
dtb' for 20241010112337.3840703-1-naresh.solanki@9elements.com:
> > >
> >
> > ...
> >
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mux@77: interrupts:=
 False schema does not allow [[44, 4]]
> > >       from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca9=
54x.yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-c=
pu2@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >       from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccf=
a-cpu2@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >       from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-c=
pu1@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >       from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccf=
a-cpu1@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >       from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-c=
pu3@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >       from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccf=
a-cpu3@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >       from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regu=
lators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >       from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regu=
lators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >       from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regu=
lators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >       from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regu=
lators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >       from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-c=
pu0@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >       from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccf=
a-cpu0@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >       from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
> >
> > These still must be addressed as mentioned on v3 (with more specific
> > comments regarding the infineon,ir38263 on v4). Please look through the
> > binding documents for the affected nodes and make sure the nodes in
> > your DTS conform to their definitions. You can check your work with
> > `make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ibm-sbp1.dtb` prior to sending.
>=20
> These are the warnings coming for trivial devices. Even for regulator@5f
>=20
> grep -rsn mp2973 Documentation/
> Documentation/devicetree/bindings/trivial-devices.yaml:286:
> # Monolithic Power Systems Inc. multi-phase controller mp2973
> Documentation/devicetree/bindings/trivial-devices.yaml:287:          -
> mps,mp2973

It coming from trivial-devices.yaml means that the device does not
actually qualify as a trivial device, but rather needs to be described
in a binding of its own.

--zgnNujWOZf5FzJWM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZw4SEwAKCRB4tDGHoIJi
0nIjAPwIEU8NPVESdU3NKkpEF0S/EBcc+8Exu+WbEkvqoq2nIAD+KK53TduJay6t
7wAqGuWhZfn8YbO16ghift7SX79yeg8=
=Gv8+
-----END PGP SIGNATURE-----

--zgnNujWOZf5FzJWM--

