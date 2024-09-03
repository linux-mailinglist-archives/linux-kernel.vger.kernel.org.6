Return-Path: <linux-kernel+bounces-312655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 310AB969968
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BE41F22851
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201E41A0BDF;
	Tue,  3 Sep 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpWJiwrw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731701A0BCB;
	Tue,  3 Sep 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356549; cv=none; b=PAvGfaQUGb9+skl2tSvW0TbWj2CwAJqD+1Uu7fpjaTIxK1oSio/x52b/Hw4rdZyXeVzBfnQD7nur601bHDiCmXWswdmgkA+VWFshr8+AQzXCgcTJ7WLZKzIK4N2mJpY9jcYpQJe5VewsVgozH5u1Dr5/FSHn4+5KLIuTZDRTs7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356549; c=relaxed/simple;
	bh=5BLz5g5ZXnWApa/H8Ah2Nu3ZSoDtsGE5Qt5nhSeqhdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkcxFDsi1Z5R+rj4lSK2lghuM3WebwpDC0o1Mcqcv5GUzIRmvwUlprYJ1UpqTmC/wFw7XBLl2lyHf77XMl5V57KZ9UxcxbCKjnQxtdN8inT7j2OLomJbA0+Rq0bJ4KtPvlAfxgfC9DwXzvKgVhzATfp9c7vpUFsYN2TW4YE4Ncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpWJiwrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE20C4CEC4;
	Tue,  3 Sep 2024 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725356549;
	bh=5BLz5g5ZXnWApa/H8Ah2Nu3ZSoDtsGE5Qt5nhSeqhdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpWJiwrwBxT7rWN+9/oKqNvpR+ufP71dFF1FTsDNfzANX/Nj/bigOjITeTIxXHdOt
	 nG3Ot6/tpDS03RaC2jtz+XgT9WwZQz7UEJjsxed+xrO24kTIfBNlCtVa3v+Kc0bt3B
	 ZYs1ebjQXYxPPfq11YzTKqL8Voc16LR7exKuRy6/OlL7TPsSgt6mxoOg9txiYJe4u+
	 jzXNfGLZH+BpA22zL1XF1JJMEY+D23K96KK5SUDZVnHnttnVOc1JkkObL8um+4+fZM
	 z5KEvA4BwWDThCEMjQaj7AKNDQkBgbE5vZVFNbyBUNCY0hqmJQjjUHCnCXJlf3ZOw/
	 qPcsTSZBncIFA==
Date: Tue, 3 Sep 2024 10:42:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: jh7110-usb-phy: Add sys-syscon
 property
Message-ID: <20240903-gating-shamrock-c0d4415d1eb3@squawk>
References: <cover.1723472153.git.jan.kiszka@siemens.com>
 <30f3ca9f6bd788e16767b36aa22c0e9dc4d1c6a4.1723472153.git.jan.kiszka@siemens.com>
 <20240812-overstuff-skirt-7a8aabbcdc6f@spud>
 <8cdba8b0-7364-4c09-b18a-f3f59da1eae2@siemens.com>
 <20240813-haiku-pusher-f2fb037a2f49@wendy>
 <SHXPR01MB08633B523DA1F6C5632F6D9DE6802@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <20240815-endless-credible-324438d164f4@spud>
 <SHXPR01MB08632E50DFE53BE0CFAA99ABE6922@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V8qJgUi9TxzWpM4h"
Content-Disposition: inline
In-Reply-To: <SHXPR01MB08632E50DFE53BE0CFAA99ABE6922@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>


--V8qJgUi9TxzWpM4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 09:19:29AM +0000, Minda Chen wrote:
>=20
>=20
> >=20
> > On Thu, Aug 15, 2024 at 10:33:55AM +0000, Minda Chen wrote:
> > >
> > >
> > > >
> > > > On Tue, Aug 13, 2024 at 07:31:50AM +0200, Jan Kiszka wrote:
> > > > > On 12.08.24 17:55, Conor Dooley wrote:
> > > > > > On Mon, Aug 12, 2024 at 04:15:51PM +0200, Jan Kiszka wrote:
> > > > > >> From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > >>
> > > > > >> Analogously to the PCI PHY, access to sys_syscon is needed to
> > > > > >> connect the USB PHY to its controller.
> > > > > >>
> > > > > >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > >> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > > > >> ---
> > > > > >> CC: Rob Herring <robh@kernel.org>
> > > > > >> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > > > > >> CC: Conor Dooley <conor+dt@kernel.org>
> > > > > >> ---
> > > > > >>  .../bindings/phy/starfive,jh7110-usb-phy.yaml         | 11
> > > > +++++++++++
> > > > > >>  1 file changed, 11 insertions(+)
> > > > > >>
> > > > > >> diff --git
> > > > > >> a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy
> > > > > >> .yam
> > > > > >> l
> > > > > >> b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy
> > > > > >> .yam l index 269e9f9f12b6..eaf0050c6f17 100644
> > > > > >> ---
> > > > > >> a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy
> > > > > >> .yam
> > > > > >> l
> > > > > >> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb
> > > > > >> +++ -phy
> > > > > >> +++ .yaml
> > > > > >> @@ -19,6 +19,16 @@ properties:
> > > > > >>    "#phy-cells":
> > > > > >>      const: 0
> > > > > >>
> > > > > >> +  starfive,sys-syscon:
> > > > > >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > > >> +    items:
> > > > > >> +      - items:
> > > > > >> +          - description: phandle to System Register Controller
> > > > sys_syscon node.
> > > > > >> +          - description: PHY connect offset of
> > > > SYS_SYSCONSAIF__SYSCFG register for USB PHY.
> > > > > >
> > > > > > Why is having a new property for this required? The devicetree
> > > > > > only has a single usb phy, so isn't it sufficient to look up the
> > > > > > syscon by compatible, rather than via phandle + offset?
> > > > > >
> > > > >
> > > > > I didn't design this, I just copied it from
> > > > > starfive,jh7110-pcie-phy.yaml. As that already exists, I'm neither
> > > > > sure we want to change that anymore nor deviate in the pattern he=
re.
> > > >
> > > > To be honest, I think some of the other users of phandle + offset on
> > > > this soc were just copy-pasted without thinking about whether or no=
t they
> > were required too.
> > > > This one seems like it should just be a lookup by compatible in the
> > > > driver instead of by phandle. As a bonus, it will work with existing
> > > > devicetrees - whereas your current implementation will fail to probe
> > > > on systems that have the old devicetree, a regression for systems
> > > > running with that devicetree and downstream firmware.
> > > >
> > > > Cheers,
> > > > Conor.
> > > >
> > > Hi Conor
> > > I know you would like to put the offset value to the code, Just set s=
yscon in dts.
> > > Just like pcie-starfive.c. right?
> >=20
> > No, not quite. That still uses a phandle lookup, I was talking about us=
ing
> > syscon_regmap_lookup_by_compatible().
>=20
> Okay. Using syscon_regmap_lookup_by_compatible() can just modify the driv=
er code only.
> But syscon_regmap_lookup_by_compatible() is not exist in uboot now. If I =
want to enable
> CONFIG_OF_UPSTREAM in uboot. I have to add this function in u-boot...

You can use
	node =3D ofnode_by_compatible(ofnode_null(), "foo");
	*regmap =3D syscon_node_to_regmap(node);
in U-Boot.


--V8qJgUi9TxzWpM4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtbaAQAKCRB4tDGHoIJi
0qddAQCykV/8wdobsflqJGegk8VpG4PfIyVD95Ps/lFiN6N8EAEA3A0m+qTJUFXs
meGu8AGVsKo0mah3sBBHmXQzCetNhA8=
=t0GZ
-----END PGP SIGNATURE-----

--V8qJgUi9TxzWpM4h--

