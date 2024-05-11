Return-Path: <linux-kernel+bounces-176548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E758C3177
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903F71C20C98
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9005502B1;
	Sat, 11 May 2024 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8Z/hvEH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220218C15;
	Sat, 11 May 2024 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715432606; cv=none; b=ENmwy1F1pxc69qsvSMyMUNsl/IXIGsjrDl4ZSB49ySU+o92kOlVuY83ipbOomjzK+ktKA0fWK/Yaxj9e6pUHCj0ttVthwKQBl+vqK+WHUnqGpL6qZO4bxr4HGjHiryX8aRk53YAWPt/YZldcdVhUc3WnXunSa7bsu4BuL7wMqi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715432606; c=relaxed/simple;
	bh=nmhW8quEOj7e8lsF6Vgn3FxigiWdqJzbbfjcHiI4FF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3F9Q2sQGYTPahCjUeYUjNHhwGFQ4afNboHIbPugo/ry3LGiIblceYGsBpJJ8ksyOFmUMwpM2N4VBppt9o5qeT6L9mLTGQhOUbUkLK+h2QgyOKZQoouhWiZCVWsrgOc0s98eylRVXtAuZf7b3F9aiDJsoDAVk9e00VS6nN/ZX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8Z/hvEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD50C32781;
	Sat, 11 May 2024 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715432606;
	bh=nmhW8quEOj7e8lsF6Vgn3FxigiWdqJzbbfjcHiI4FF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8Z/hvEH0Tz1Wsjzc/s0tw6Uk0zCa+ZRb2ykAVHUAAiicT+RL/2IHtFXpl9nOYA8y
	 1nYGa04Pr6qqXAZOzxQC36PT0UNXhJLEb+CXlbAGAoCjnh0ksm1dsDjZnPZtkqVN8/
	 TaJ4mpR7fvKC0jJpcBNWzg6oZRZTlgxnKVL6hK3UTV2xjGDmcawxm2CYozyH254u7i
	 WJx3LP/8IWIrb5k1runTAru/m4IXfWTTxDmTGa7BiHyEDrjkLqS8ytPd19VNNaUDU3
	 JazlPNSUrmoJ34YYBloFSLuWxAOSeKJzDYTMHbEfvHqE1kvKCsn1BNTtj9HGTk8Q51
	 5jrBl4gUZoUUw==
Date: Sat, 11 May 2024 14:03:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: neil.armstrong@linaro.org, jbrunet@baylibre.com,
	mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
	martin.blumenstingl@googlemail.com, jian.hu@amlogic.com,
	kernel@sberdevices.ru, rockosov@gmail.com,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/7] dt-bindings: clock: meson: a1: peripherals:
 support sys_pll_div16 input
Message-ID: <20240511-courier-afflicted-e351af5cded2@spud>
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
 <20240510090933.19464-5-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TNx0su8gnKIgNzEa"
Content-Disposition: inline
In-Reply-To: <20240510090933.19464-5-ddrokosov@salutedevices.com>


--TNx0su8gnKIgNzEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:08:56PM +0300, Dmitry Rokosov wrote:
> The 'sys_pll_div16' input clock is used as one of the sources for the
> GEN clock.
>=20
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Provided that this new clock is optional in the driver,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/clock/amlogic,a1-peripherals-clkc.yaml        | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-periphera=
ls-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-periphera=
ls-clkc.yaml
> index 6d84cee1bd75..11862746ba44 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc=
=2Eyaml
> @@ -30,6 +30,7 @@ properties:
>        - description: input fixed pll div7
>        - description: input hifi pll
>        - description: input oscillator (usually at 24MHz)
> +      - description: input sys pll div16
> =20
>    clock-names:
>      items:
> @@ -39,6 +40,7 @@ properties:
>        - const: fclk_div7
>        - const: hifi_pll
>        - const: xtal
> +      - const: sys_pll_div16
> =20
>  required:
>    - compatible
> @@ -65,9 +67,10 @@ examples:
>                       <&clkc_pll CLKID_FCLK_DIV5>,
>                       <&clkc_pll CLKID_FCLK_DIV7>,
>                       <&clkc_pll CLKID_HIFI_PLL>,
> -                     <&xtal>;
> +                     <&xtal>,
> +                     <&clkc_pll CLKID_SYS_PLL_DIV16>;
>              clock-names =3D "fclk_div2", "fclk_div3",
>                            "fclk_div5", "fclk_div7",
> -                          "hifi_pll", "xtal";
> +                          "hifi_pll", "xtal", "sys_pll_div16";
>          };
>      };
> --=20
> 2.43.0
>=20
>=20

--TNx0su8gnKIgNzEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj9smAAKCRB4tDGHoIJi
0sVPAP4qBtz3ATp9etCU/S5CukAKn4AJFaAGHLtaVCEhh9TnJwEApgjVh2zKcIAl
WlAU5kVo+VO3uM0AxaBrQrhxsiADUQA=
=31o0
-----END PGP SIGNATURE-----

--TNx0su8gnKIgNzEa--

