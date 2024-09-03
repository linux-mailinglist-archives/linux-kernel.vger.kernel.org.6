Return-Path: <linux-kernel+bounces-313783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AE996A9AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5E12828FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489531DA607;
	Tue,  3 Sep 2024 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arnet.am header.i=@arnet.am header.b="cHi03LIw"
Received: from mail.matrix.am (mail.matrix.am [116.203.124.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF541CDFA6;
	Tue,  3 Sep 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.124.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396952; cv=none; b=mBXmB6vXo2pSjxgQSxRhxtwKWuo5zqI7v5NPdveQAnL0AqGhCnGAluMoTKxvqXvuwUa8DDVmebdF+2Z7kay7BnlBeme9jQacxjxnrcCIb2IvTEngWRDfXV66LhUNlH5UepflvDf0+nVcmakfUTPfHfn7AYaz6PHN6OLittg3f58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396952; c=relaxed/simple;
	bh=DUMm6nz6XnzBridnUivBSoK7+llNYN2oF8ISpeNJzEM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PunV8OnJem03SWQDNGDWquY1clhlDfhD/Kr+rX89nikzu7Nuhgjps9OHIZUpopueHw2GipTgNwza47dkIe84g6ekiGUAJIOizuuBviDZRYMM1oN52leU8f49AmoRLYku5VLqR1lRKnMO3nNsYsYwOFarKPUTjW/XtD0RlKV/BuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arnet.am; spf=pass smtp.mailfrom=arnet.am; dkim=pass (1024-bit key) header.d=arnet.am header.i=@arnet.am header.b=cHi03LIw; arc=none smtp.client-ip=116.203.124.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arnet.am
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnet.am
Received: from arnet (unknown [37.252.77.193])
	by mail.matrix.am (Postfix) with ESMTPSA id B941D4050F;
	Tue,  3 Sep 2024 22:45:48 +0200 (CEST)
Received: from arnet (localhost [127.0.0.1])
	by arnet (OpenSMTPD) with ESMTP id e0e800fd;
	Tue, 3 Sep 2024 20:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=arnet.am; h=date:from:to
	:cc:subject:message-id:in-reply-to:references:mime-version
	:content-type; s=mail; bh=DUMm6nz6XnzBridnUivBSoK7+llNYN2oF8ISpe
	NJzEM=; b=cHi03LIwRwH87jaf0gvizX2Gekez+BoesdeObdIShZzW+NkSOTohJn
	8m41M9YGit1OqyqwKuyFJss6Wi5AW+Dkz11+dAcXK/3FOHnY0WA8WfFsRzRocOOa
	dyTzwRHoCulGhsEKCdV3Ev4m2wzgTZ4XoSWeI4sBkiEIkCyH9fLVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=arnet.am; h=date:from:to:cc
	:subject:message-id:in-reply-to:references:mime-version
	:content-type; q=dns; s=mail; b=JKE2IdFoB0/9Zk1SzuASLJgxAb9M1l6W
	pRh6cezKJVmHtWCoaAq00y7yV58NvuFt3DzdWYg3F3Aa3G+JXIBhb0xQOqj8XjkV
	MHyjl2GKM8s1LBCeWzRFnuJXfbFeu9i/fleHQ39i/vPamSyGhkCx3Jc4LdBIFIfO
	l6XKJl6Fb+c=
Received: from localhost (<unknown> [10.0.0.5])
	by arnet (OpenSMTPD) with ESMTPSA id 7d9355e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 20:45:46 +0000 (UTC)
Date: Wed, 4 Sep 2024 00:46:15 +0400
From: =?UTF-8?B?1bbVuNaA1aHVtdaA?= <norayr@arnet.am>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-sunxi@lists.linux.dev, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, uwu@icenowy.me,
 wenst@chromium.org, broonie@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH v2] arm64: dts: allwinner: a64: Add GPU thermal trips to
 the SoC dtsi
Message-Id: <20240904004615.15ccf4ec1d764c5a163ebc13@arnet.am>
In-Reply-To: <0a6110a7b27a050bd58ab3663087eecd8e873ac0.1724126053.git.dsimic@manjaro.org>
References: <0a6110a7b27a050bd58ab3663087eecd8e873ac0.1724126053.git.dsimic@manjaro.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__4_Sep_2024_00_46_15_+0400_R/qTOGzL1=rQB4Mt"

--Signature=_Wed__4_Sep_2024_00_46_15_+0400_R/qTOGzL1=rQB4Mt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I have tested this patch to the device tree on my pinephone (1.2 edition) u=
nder Gentoo Linux (vanilla-sources-6.10.7)
before the test, my dmesg contained:

---
[    0.156933] thermal_sys: Registered thermal governor 'fair_share'
[    0.156942] thermal_sys: Registered thermal governor 'bang_bang'
[    0.156960] thermal_sys: Registered thermal governor 'step_wise'
[    0.156976] thermal_sys: Registered thermal governor 'user_space'
[    0.156992] thermal_sys: Registered thermal governor 'power_allocator'
[    1.409536] thermal_sys: Failed to find 'trips' node
[    1.409555] thermal_sys: Failed to find trip points for thermal-sensor i=
d=3D1
[    1.409594] thermal_sys: Failed to find 'trips' node
[    1.409607] thermal_sys: Failed to find trip points for thermal-sensor i=
d=3D2
----

after applying the patch and booting with newer dtb, when i grep for the st=
ring 'thermal' in dmesg i only have:

----
[    0.159456] thermal_sys: Registered thermal governor 'fair_share'
[    0.159465] thermal_sys: Registered thermal governor 'bang_bang'
[    0.159484] thermal_sys: Registered thermal governor 'step_wise'
[    0.159499] thermal_sys: Registered thermal governor 'user_space'
[    0.159515] thermal_sys: Registered thermal governor 'power_allocator'
----

Tested-by: Norayr Chilingarian <norayr@arnet.am>

On Tue, 20 Aug 2024 05:57:47 +0200
Dragan Simic <dsimic@manjaro.org> wrote:

> Add thermal trips for the two GPU thermal sensors found in the Allwinner =
A64.
> There's only one GPU OPP defined since the commit 1428f0c19f9c ("arm64: d=
ts:
> allwinner: a64: Run GPU at 432 MHz"), so defining only the critical therm=
al
> trips makes sense for the A64's two GPU thermal zones.
>=20
> Having these critical thermal trips defined ensures that no hot spots dev=
elop
> inside the SoC die that exceed the maximum junction temperature.  That mi=
ght
> have been possible before, although quite unlikely, because the CPU and G=
PU
> portions of the SoC are packed closely inside the SoC, so the overheating=
 GPU
> would inevitably result in the heat soaking into the CPU portion of the S=
oC,
> causing the CPU thermal sensor to return high readings and trigger the CPU
> critical thermal trips.  However, it's better not to rely on the heat soak
> and have the critical GPU thermal trips properly defined instead.
>=20
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>=20
> Notes:
>     Changes in v2:
>       - Added "a64:" at the end of the patch subject prefix and adjusted =
the
>         patch subject a bit, to match the usual prefix better
>       - Dropped the removal of potentially redundant comments that descri=
be
>         the units, as suggested by Icenowy [1] and Chen-Yu [2]
>    =20
>     Link to v1: https://lore.kernel.org/linux-sunxi/a17e0df64c5b976b47f19=
c5a29c02759cd9e5b8c.1723427375.git.dsimic@manjaro.org/T/#u
>    =20
>     [1] https://lore.kernel.org/linux-sunxi/24406e36f6facd93e798113303e22=
925b0a2dcc1.camel@icenowy.me/
>     [2] https://lore.kernel.org/linux-sunxi/662f2332efb1d6c21e722066562a7=
2b9@manjaro.org/T/#mdd7b18962c1ae339141061af51b89cd68bc04d50
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index e868ca5ae753..a5c3920e0f04 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -263,13 +263,29 @@ gpu0_thermal: gpu0-thermal {
>  			polling-delay-passive =3D <0>;
>  			polling-delay =3D <0>;
>  			thermal-sensors =3D <&ths 1>;
> +
> +			trips {
> +				gpu0_crit: gpu0-crit {
> +					temperature =3D <110000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
>  		};
> =20
>  		gpu1_thermal: gpu1-thermal {
>  			/* milliseconds */
>  			polling-delay-passive =3D <0>;
>  			polling-delay =3D <0>;
>  			thermal-sensors =3D <&ths 2>;
> +
> +			trips {
> +				gpu1_crit: gpu1-crit {
> +					temperature =3D <110000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
>  		};
>  	};
> =20



--Signature=_Wed__4_Sep_2024_00_46_15_+0400_R/qTOGzL1=rQB4Mt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE/NXb7z5U+F4QLot8j7bhHrSgEjYFAmbXdZcACgkQj7bhHrSg
EjYAxg//RiUpiRXuwUNDYUo0zByDk75PdUXyOxZYrH9NRIl3KPp/5uGZS13/nP4T
YxrtRxm7/Kez9ZFq26DDxjjCDbK6ux1WiPMRDHoB/u7p8cWfMYplnueYa0YI3U0b
QCuOSs43VIHkYjKAiJQ11G9ZoP8AYfSeI/fiP2DDq7vbhfkyLuRdUCFQseW9Jp3S
shkb3yh4lShqQJSq7AALF8lrat2aEYOrsJ32zfTGBIbz/Jc5u8ldGCaPb7RrkYaa
YeYHgKPcip2vVspA2S3bKffTmWF8t0OXFCWTD7FM1ouNcXTSw/J6ZpDq6n94ZW77
acAGoCuc0v6eomlxTsHUKeUY/0cm8y3Jp1rITFHDjK3X6M1zmSbWacBTlcWEcQj8
Tr5PWOkkU06MwHQHY7hRjAECObYMl7/m069eknOfE0RjPDkix4wb0z4WJnhDHnpB
fk320HxFeujsA6X2Y4T78CaF9wnVLXfRCPfsH1q+xUndnb7zmXN+JMabbMo20SJ/
uLT6da4+zDqUb0RpgRHokmyfsx013hvg3yr7PBwos3vTyBnB46DmGP7Sd5/3tQdc
iIlhX/fVoLrNXsWllAWJmioljl0aC32/7HiBh3IzzZRlH5WonR4UE/v1tsqhIiAE
PTjXJnslPE9LrVRwaTtoBk3wZyAIJRVJKUbCp2hyiJbf47y6gdc=
=dVCU
-----END PGP SIGNATURE-----

--Signature=_Wed__4_Sep_2024_00_46_15_+0400_R/qTOGzL1=rQB4Mt--

