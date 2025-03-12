Return-Path: <linux-kernel+bounces-557740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B196CA5DD15
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F382A165F52
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A35242902;
	Wed, 12 Mar 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn68zqO3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041F7083C;
	Wed, 12 Mar 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783862; cv=none; b=Qcyu0zDAa1j8vy22669V/Scqtd7WeDjb79Fw2r0eyE5nJDtJbcBCqu8yOd9g60LbHTPE9jfFPu4kPk2oCqHSlFR6TeQWu3GX5FRVjzzXyDJW/L0n6K4uvuPv34T/RUaGYsZJw7nQedlBdwGg/alD6WrDaYUgdOrifp0tT97PCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783862; c=relaxed/simple;
	bh=6rYvu3ypCkOsZirJfiuRrHLmYoQEVDdMOsLJXAG7xN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1pUyL5aAkI2N2xJuAyTDH9dzd0Sh5mj0R70DevEsJBlLzjHVAC9CDg1fIWX8tr+D+h+KOljhuh+rm69XS+QxADJsOfg8whLyyNv7jagx5EFky35czgHYArlyxIJurT+GPBtnI4Jywu+s4T1E5pkJqSoS0xQq242jac+bV8kRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn68zqO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E436C4CEE3;
	Wed, 12 Mar 2025 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741783862;
	bh=6rYvu3ypCkOsZirJfiuRrHLmYoQEVDdMOsLJXAG7xN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jn68zqO3cR5YMuyMQ9UAjbUTN43VYWcotjS3h1cr30W/Fz3lr3/pgTyganZzg4smW
	 qDCyd7jEcdx53zHs2Zcd4BxnwlJdsw0yV8If5N1f78WiyVDRUSfp8pHNy0vaoUUpBB
	 ka7qOqKGLeesTCalK0FUM3LtoYSsVrwXPDAPTDGgwL5+pEbQlXwdTrpu61nX3/57jO
	 xA0N05/lV92AkhN5888csRZ+Nv2/fcDb1hhhh5Zfaij0fidYzRfIB8UqtIUqQVdXUm
	 dlA99+ReL4OP8q4NdrXusf1lUjh+6bWlN7D0CBHESvsCWl4NPXzZAqpGIeYDu5LUKw
	 RMuPO064s5baQ==
Date: Wed, 12 Mar 2025 12:50:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Matthias Brugger <matthias.bgg@kernel.org>
Cc: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl, Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: riscv: Add SiFive HiFive Premier P550
 board
Message-ID: <20250312-unloving-shamrock-babbedab8cbe@spud>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311073432.4068512-5-pinkesh.vaghela@einfochips.com>
 <Z9F3_Zb4RvHLvgSd@ziggy.stardust>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zt/ZnHn6R085mdRK"
Content-Disposition: inline
In-Reply-To: <Z9F3_Zb4RvHLvgSd@ziggy.stardust>


--Zt/ZnHn6R085mdRK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 01:03:09PM +0100, Matthias Brugger wrote:
> On Tue, Mar 11, 2025 at 01:04:26PM +0530, Pinkesh Vaghela wrote:
> > From: Pritesh Patel <pritesh.patel@einfochips.com>
> >=20
> > Add DT binding documentation for the ESWIN EIC7700 SoC and
> > HiFive Premier P550 Board
> >=20
> > Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> > ---
> >  .../devicetree/bindings/riscv/eswin.yaml      | 29 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 ++++
> >  2 files changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/eswin.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/riscv/eswin.yaml b/Docum=
entation/devicetree/bindings/riscv/eswin.yaml
> > new file mode 100644
> > index 000000000000..c603c45eef22
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/eswin.yaml
> > @@ -0,0 +1,29 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/eswin.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ESWIN SoC-based boards
> > +
> > +maintainers:
> > +  - Min Lin <linmin@eswincomputing.com>
> > +  - Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> > +  - Pritesh Patel <pritesh.patel@einfochips.com>
> > +
> > +description:
> > +  ESWIN SoC-based boards
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - sifive,hifive-premier-p550
> > +          - const: eswin,eic7700
>=20
> That should be the other way around. You could have, let's say eic7701
> with different peripherals but smae p550 IP core. I don't expect a new
> eic7700 with a CPU IP other then p550.

No, this is correct. The SoC is made by Eswin (eic7700) and the board
(hifive premier) by SiFive. None of the compatibles listed here are for
the IP core.

If there's another SoC with different peripherals and the same p550 IP
core, I would expect a new SoC compatible /and/ a new board compatible.

Cheers,
Conor.

--Zt/ZnHn6R085mdRK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9GDLwAKCRB4tDGHoIJi
0p9mAQCg9E5gJqtTAUQyV0MdPda6ImaeAtaeO9C49jodJHDuDgD/TWh7dIoVaMlp
ncCuRxGiz+l4FIYXdmWDQkAx4jjqfww=
=WEsp
-----END PGP SIGNATURE-----

--Zt/ZnHn6R085mdRK--

