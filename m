Return-Path: <linux-kernel+bounces-556699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C1FA5CD98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375BD1623AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55D1EEA35;
	Tue, 11 Mar 2025 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzRvAZeL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B30260A5A;
	Tue, 11 Mar 2025 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716921; cv=none; b=R0retZS+nEr5blOrhyNpHD8H+lgO1LIGp+cs4ssQgatwuPRuJxqekwfbsQSriyVWbLBvzBR9BL9Cx3Er7PBDsuZSKshV0JE49sU8JGnJUR5Z+/HSldzvXwFVzS/R1lLDthJStgOHQcg9rhy+DA1bBCAP2iMvYpw+H4P6PJ7fOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716921; c=relaxed/simple;
	bh=QVKm1/ggon8nkDEmT9UXPEAL4izORGEQ9UkuDXgyZBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hv5M/Htohp5jFvMEkw2i+Ky2n7YVI7IYerGhXePO7e5guy3fUP6aqSuXmIZP1vmmSq28G91FN5c7DtVktLrIVYT21NJA8Ed5mM0HnPpgEHwbuGbEBcP41wnQLwnpl0LH2AflMGBi90+iUiuoB6EeqrABZQDt3PBTWadaWcq88+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzRvAZeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE63C4CEEA;
	Tue, 11 Mar 2025 18:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741716921;
	bh=QVKm1/ggon8nkDEmT9UXPEAL4izORGEQ9UkuDXgyZBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzRvAZeLYZVBx5UHTI50AopOoUuWTwRnPh40r49hYd3anLJbxT97umDFmTfLSwpJl
	 z9OFRE+yaqy7PaYaB7F25BNW7paU2yfkT3/rDiZqdYoAxdj2I6mOaaUJOsE9Nymh18
	 dwIGAWXKtBjq7DR1TDwUqZ5rVpcsVES/NwZqEU/FwB0rES1P8okJc4IzW0FwEft/7R
	 EFgd0bIWOWIALBRzyE6RsT3IhCp1VJtfOJEkxyY35GDqfCPTel/2W5cQbJ8b7sTNRL
	 z5mMrMqlmp/G4ZQ0QRWonBJS9HfYviL6ySabRP+/yg64WrtTytiDXczfCzXVY02E0s
	 M1fr1T0AL4xsw==
Date: Tue, 11 Mar 2025 18:15:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [PATCH 03/10] dt-bindings: vendor-prefixes: add eswin
Message-ID: <20250311-reproduce-smoked-b6a6025985d6@spud>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311073432.4068512-4-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dPdjNx0Q/ARv4t6y"
Content-Disposition: inline
In-Reply-To: <20250311073432.4068512-4-pinkesh.vaghela@einfochips.com>


--dPdjNx0Q/ARv4t6y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 01:04:25PM +0530, Pinkesh Vaghela wrote:
> From: Pritesh Patel <pritesh.patel@einfochips.com>
>=20
> Add new vendor string to dt bindings.
> This new vendor string is used by
> - ESWIN EIC770X SoC
> - HiFive Premier P550 board which uses EIC7700 SoC.
>=20
> Link: https://www.eswin.com/en/
> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 5079ca6ce1d1..07ff140e67dc 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -490,6 +490,8 @@ patternProperties:
>      description: Espressif Systems Co. Ltd.
>    "^est,.*":
>      description: ESTeem Wireless Modems
> +  "^eswin,.*":
> +    description: Beijing ESWIN Technology Group Co. Ltd.
>    "^ettus,.*":
>      description: NI Ettus Research
>    "^eukrea,.*":
> --=20
> 2.25.1
>=20

--dPdjNx0Q/ARv4t6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9B9sQAKCRB4tDGHoIJi
0pZoAP9+XoAhB5X/zHXubQ1FiTw4muY9Itw2e6V5S/HY/Q3fwwEAllR8f3pNGCJ1
8Qaas6YgZerepyiwoergLbDFV1ASUws=
=7vdG
-----END PGP SIGNATURE-----

--dPdjNx0Q/ARv4t6y--

