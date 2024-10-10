Return-Path: <linux-kernel+bounces-359545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE3998DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33860B2CBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DC71CDA3F;
	Thu, 10 Oct 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0I54elw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF943A1BF;
	Thu, 10 Oct 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577017; cv=none; b=HPEQ+tMiHho6iEO/Z/b+CK45rlLnmQHY4paAPw/WUaWK9DPNf99BwTAbK+UnXOzhsYg6t7DXAdmdVgAEI6mw+etg4zz0+7AS0Pn0cWuFnG+PZvtZ0ipGe8MZcG9M+0zVNEfZ0FJHfKdmSnwymfOlKpmpvN709NPk6QdwJlnFloI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577017; c=relaxed/simple;
	bh=voGVJTL+cAj6EmXPR+KQJh9ISLK3DMAUVPirCQBGkik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofG+e7ibo+aQIsTdCH7Vueq8SyzvlYgrCfsmqNSsAO/n58JO4cWb39ecCVgQNOTEbP4P6fLP1ywzGpEEWUu68gc4yDAgstQb3r4hXcd8W6Fc6fr2sF9Af1GVJlmyy97diREjA2klvx/IobK87RCpq7igA8JvuVawb60l7RZyijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0I54elw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AAFC4CEC5;
	Thu, 10 Oct 2024 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577017;
	bh=voGVJTL+cAj6EmXPR+KQJh9ISLK3DMAUVPirCQBGkik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0I54elwvtUsv/BNkncmFRr3FnQw1wYW4MAwz+lOyhu2lmD+2DO3YJmOhuSyC97Zh
	 TXouELUyGL8SJqJcZdZApJm545a1UzQt4g4aPOpat+cVu0OpvWtg1mEave1Q0Qz0Bh
	 sDu+4Ym++e5RZezklw3A/IlGVg/4JlZYssR+oO6jb3RoKcqvCnQRHq84GmSVJ02Laj
	 Z3/pXkavUIIRo7h4ONPbjmlV4n8K5Jq+oDJFpEBdmZvfkKeXbaIrfDI3wP/Y1PF0Fo
	 C3vbq1hnrf4FdrQNOhJy/jp8jYHWZpqJ3X+d/2453D2TThC4TAIcdu+cJL8if2K28P
	 koSx87d8f32fw==
Date: Thu, 10 Oct 2024 17:16:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2044
 ACLINT SSWI
Message-ID: <20241010-playtime-liquid-cf9888d27052@spud>
References: <20241004080557.2262872-1-inochiama@gmail.com>
 <20241004080557.2262872-2-inochiama@gmail.com>
 <20241004-patronize-doily-8406fa214347@spud>
 <42ndts6wuoor3tbt3uv5kuco37kc6bnnoepqtauqosw2gg2xn7@7hfdc6wgvlsm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NLIrl1uOyUVux6/2"
Content-Disposition: inline
In-Reply-To: <42ndts6wuoor3tbt3uv5kuco37kc6bnnoepqtauqosw2gg2xn7@7hfdc6wgvlsm>


--NLIrl1uOyUVux6/2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2024 at 08:46:37AM +0800, Inochi Amaoto wrote:
> On Fri, Oct 04, 2024 at 04:44:22PM +0100, Conor Dooley wrote:
> > On Fri, Oct 04, 2024 at 04:05:55PM +0800, Inochi Amaoto wrote:
> > > Sophgo SG2044 has a new version of T-HEAD C920, which implement
> > > a fully featured ACLINT device. This ACLINT has an extra SSWI
> > > field to support fast S-mode IPI.
> > >=20
> > > Add necessary compatible string for the T-HEAD ACLINT sswi device.
> > >=20
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > ---
> > >  .../thead,c900-aclint-sswi.yaml               | 58 +++++++++++++++++=
++
> > >  1 file changed, 58 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-contr=
oller/thead,c900-aclint-sswi.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/t=
head,c900-aclint-sswi.yaml b/Documentation/devicetree/bindings/interrupt-co=
ntroller/thead,c900-aclint-sswi.yaml
> > > new file mode 100644
> > > index 000000000000..0106fbf3ea1f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c9=
00-aclint-sswi.yaml
> > > @@ -0,0 +1,58 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/interrupt-controller/thead,c900-a=
clint-sswi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Sophgo sg2044 ACLINT Supervisor-level Software Interrupt Devi=
ce
> > > +
> > > +maintainers:
> > > +  - Inochi Amaoto <inochiama@outlook.com>
> > > +
> > > +description:
> > > +  The SSWI device is a part of the riscv ACLINT device. It provides
> > > +  supervisor-level IPI functionality for a set of HARTs on a RISC-V
> > > +  platform. It provides a register to set an IPI (SETSSIP) for each
> > > +  HART connected to the SSWI device.
> >=20
> > If it is part of the aclint, why should it have a separate node, rather
> > than be part of the existing aclint node as a third reg property?
>=20
> For aclint, the current nodes that have documented are mswi and mtime.
> Since the mtime is a M-mode time source, it is not suitable to add the
> sswi reg into this device. For mswi, it is OK to add a sswi reg, but
> this will cause problem while checking "interrupt-extend". Do we just
> double the maxItem? Or just left it unchanged?
>=20
> Another reason to add it as a separate node is that the draft says
> sswi can be multiple. If we add this device by adding reg. It will be
> hard if we have multiple sswi devices but one mswi device.

Ah, I see we do indeed have 2 devices already for the aclint, one for
mswi and mtimer.

--NLIrl1uOyUVux6/2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwf98wAKCRB4tDGHoIJi
0tquAQCi8VLHi3iAdTSDUqGhkFnId5un/ek8rvYQaquTvHU4sAD/el+Rhz0sf/CY
mqYHgZepBr3qqOqJeAvrc6p2sIuS2A4=
=6zwW
-----END PGP SIGNATURE-----

--NLIrl1uOyUVux6/2--

