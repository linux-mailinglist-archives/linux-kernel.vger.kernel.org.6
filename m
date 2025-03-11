Return-Path: <linux-kernel+bounces-556697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DC2A5CD91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D5C16BBAD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7A9263C6C;
	Tue, 11 Mar 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPORfjjy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9FA262D38;
	Tue, 11 Mar 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716880; cv=none; b=mvCbN6PEnkxwYuukozryj9SDzI7BokM8meWTB9HfuVYjN152qcN0GFsKPuAGuAZ6Ac5UPkBytoBKuz2S2FgTdaZGlYqRIM1C9MQsSrFWbVGYEsKUyKIJRAcS0p5OwLfGTgBuMOQ6le5nxDevcLr69AztC72AtG7u45jXv8GMGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716880; c=relaxed/simple;
	bh=OarDzLhzfup2s63X87NTaLZokagXoDKFBQHrlDLogGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLhVSyck2DmxLG04xHdKLBB8+0oGJUm+hbD4EqteSWd6O7wXQbOYVQNYgpRQvsvA+eXUdiYeX7YuNXkpg6X9heHGSxnVU2B+7llO65oqniqCItlGLPYSSIByzTkAtlTPAAepsQf8+wTDNtNKJDHtpNXjsmvXQfGzkis46NseLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPORfjjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C28C4CEF0;
	Tue, 11 Mar 2025 18:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741716880;
	bh=OarDzLhzfup2s63X87NTaLZokagXoDKFBQHrlDLogGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPORfjjyIudmmX4168iKMjff37zMqmd9De93SPA0Pgbjq8ao5d4jTVWnNVUCdU9x7
	 XP6GC7R+xPM6zaiu39UiPi9xknzVjKyd3vXLBU++qgFFJJMBrEpgQvnh9P0U1w6R4N
	 aNbNHY9pfLShgd1scjJLb0sF2jenbw0NNNzbEu7l3ndDPFIMsAVrX9SqDGJ2lpTtxJ
	 Wsx6spxuEklVM4sWNeMme5+uA2fwimYcIBqeM4lTt5bIoybboytTWoP060pPMAKZIr
	 KOlwu6yIX441Qpm2B6lKCIt63SVLsmglUWV9WAHXSEsbkH1/gaMMvoogaBGPiwGHkA
	 lQXIw7dz8fLrQ==
Date: Tue, 11 Mar 2025 18:14:33 +0000
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
Subject: Re: [PATCH 01/10] dt-bindings: riscv: Add SiFive P550 CPU compatible
Message-ID: <20250311-sedate-dazzling-1d17139aa6aa@spud>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311073432.4068512-2-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d6X9i2ow7QF9txQ0"
Content-Disposition: inline
In-Reply-To: <20250311073432.4068512-2-pinkesh.vaghela@einfochips.com>


--d6X9i2ow7QF9txQ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 01:04:23PM +0530, Pinkesh Vaghela wrote:
> From: Darshan Prajapati <darshan.prajapati@einfochips.com>
>=20
> Update Documentation for supporting SiFive P550 based CPU
>=20
> Signed-off-by: Darshan Prajapati <darshan.prajapati@einfochips.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 2c72f148a74b..3ee7468001f6 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -51,6 +51,7 @@ properties:
>                - sifive,e5
>                - sifive,e7
>                - sifive,e71
> +              - sifive,p550
>                - sifive,rocket0
>                - sifive,s7
>                - sifive,u5
> --=20
> 2.25.1
>=20

--d6X9i2ow7QF9txQ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9B9iQAKCRB4tDGHoIJi
0hKaAQCNeTF/CkJ1PsIfFWh3MLO3yqNzXeLOsBlbLEXai24e9wD/ZmjSMalBpaGW
X7Rd5P6hbu+uwF9WmLALnIVk3brMAAo=
=zGNV
-----END PGP SIGNATURE-----

--d6X9i2ow7QF9txQ0--

