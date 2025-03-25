Return-Path: <linux-kernel+bounces-575701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B58A705FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9223A168E75
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8935253B62;
	Tue, 25 Mar 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFQFl3oU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8B1BD9C8;
	Tue, 25 Mar 2025 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918617; cv=none; b=PaaCjx7gs8fH8E9cDkLLqV2/gUPKMNNbuRKPg4Fdv+aRmhKMvCtCRIalz6Luuet1/uahOrtGIZOC38LYySBLAjg54aN+r43etfWO7s1WbxIe4r+JC37ymd6E7dVNY39pc5/e2c4jJrhJn5KhtZ6Kf02cIQ4PrQJA1dj1C7Ye68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918617; c=relaxed/simple;
	bh=Uv1XF8v9S9z8FOJgIj6yPF0v787n7/slgtL5peSFUV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T54WErdLRPsK83mFZfT5/ZoS2xTNN80bH6K7YMFn3K1ckh2x0WPGa/6JGMoSLoTbhAlRNoEalYQR/NeuL2oleHGf7AmQvgaBFIHg1kyPDlmAcu8h7OSD+s/B44CcjCUw/wKIT5IeOmLPdZWv23Z6+jE3KDlSprKZOakvwqQvUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFQFl3oU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E514C4CEED;
	Tue, 25 Mar 2025 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742918616;
	bh=Uv1XF8v9S9z8FOJgIj6yPF0v787n7/slgtL5peSFUV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFQFl3oUGhZFZYbVJ6KTPzRZPcHuVzGRpvTwThMVO2ZdvvT5w6taPLBd61GiIxpOo
	 KVMELhfKXQuiDcMd9SGOpd88skWUWldK3GwwUDAPexBYEknxs9VNJMEXSNxEh9r2mo
	 1r5FzSqbpH2OP1YVlLTHZA/vhohcW7YACW+z9nWjVY8yoFzOhDMMvn6RFxk0BjOOZN
	 fDf5S5SwrMDBJvogOA+t9XhjuaJEkm9nUJL1AUEx5wtce4g/f8BGOCeTnaEfVLkj05
	 UArXGGPbXIGq4oVKwsAovg31pLmWiQMfqTdOxUZwD8JPlRFC9l2mJWXKtiui89EHX8
	 g4V1KsBRaPXoQ==
Date: Tue, 25 Mar 2025 16:03:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/9] dt-bindings: soc: microchip: document the
 simple-mfd syscon on PolarFire SoC
Message-ID: <20250325-feline-roundworm-dc391b755673@spud>
References: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
 <20250321-ramrod-scabby-a1869f9979b6@spud>
 <20250325-quiet-waxbill-of-realization-675469@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RsVPJiZ0GmQKz8rg"
Content-Disposition: inline
In-Reply-To: <20250325-quiet-waxbill-of-realization-675469@krzk-bin>


--RsVPJiZ0GmQKz8rg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 09:13:22AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Mar 21, 2025 at 05:22:35PM +0000, Conor Dooley wrote:
> > +title: Microchip PolarFire SoC Microprocessor Subsystem (MSS) sysreg r=
egister region
> > +
> > +maintainers:
> > +  - Conor Dooley <conor.dooley@microchip.com>
> > +
> > +description:
> > +  An wide assortment of registers that control elements of the MSS on =
PolarFire
> > +  SoC, including pinmuxing, resets and clocks among others.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: microchip,mpfs-mss-top-sysreg
> > +      - const: syscon
> > +      - const: simple-mfd
>=20
> You need to list the children if you use simple-mfd. Commit msg
> mentioned clock controller, so where is it?

I don't think a child node is required here, there's not enough
clock-related properties for it to require one. However, I think you're
correct about missing properties in a general sense - there should be a
#clock-cells here and a clocks/clock-names too.
The reason there aren't is because the existing driver (that binds to
microchip,mpfs-clkcfg) looks this node up by compatible, and implements
the clock parent for this node etc. Obviously that's not an excuse to
leave the properties out, so I'll add them even though they're going to
end up ignored.

> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#reset-cells':
> > +    description:
> > +      The AHB/AXI peripherals on the PolarFire SoC have reset support,=
 so
> > +      from CLK_ENVM to CLK_CFM. The reset consumer should specify the
> > +      desired peripheral via the clock ID in its "resets" phandle cell.
> > +      See include/dt-bindings/clock/microchip,mpfs-clock.h for the ful=
l list
> > +      of PolarFire clock/reset IDs.
> > +    const: 1
>=20
> Best regards,
> Krzysztof
>=20

--RsVPJiZ0GmQKz8rg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+LT0gAKCRB4tDGHoIJi
0vN+AP4t8YJUz+gmpo9mQKUTUBdHoSDi7e3nBrvIm/mCF/we4wEA1jBDbRKUs6Ny
zoe8o2WcUJLVSpT03NVcKTxFiD46Sw0=
=9sfG
-----END PGP SIGNATURE-----

--RsVPJiZ0GmQKz8rg--

