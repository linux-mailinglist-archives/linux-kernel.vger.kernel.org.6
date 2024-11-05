Return-Path: <linux-kernel+bounces-396800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09169BD253
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6133A1F22CF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53EC1D63F3;
	Tue,  5 Nov 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ARvzQqc5"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617EF17E918;
	Tue,  5 Nov 2024 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824149; cv=none; b=JFvGmoTUwKoIYzJHhPg3GQx0JBPY+HdazCD4g837tt7fO1XGXRIHc3v9gx8r4IgqTb7123hYsI7IxBmptSiN5BcdBYluLiAqwru9ZQQC1Kq8gYazHINcQCsoYU5GP41YiTe7MeqRRpj1KaKj135Fb/Y+zmrbg/t9Pg6L2svS3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824149; c=relaxed/simple;
	bh=dHz9b5sCGgbriiY0hHe2c5ULnhkhg06zPsGoOVDNQL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CSsy12Cru5+aUj5i98VRqrc2Dz0Q9b6TvTx/x54kNCIx0Q8WW/AV37HOl+avIk7cvAimgZ60N1bh3RpDxnH69QRXCHGkCo+cDLg7ZBppnHHA1RBvSAjMei8wTezSt5CQEwwEhh6dDSZKSdeZbHVff0OsbZ2fWypLAkCOEzLE7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ARvzQqc5; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E0EC60005;
	Tue,  5 Nov 2024 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730824138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AN1bWAbi3duehwYx5SBuZr7Xa5uywTWSqhm9jKKAOk=;
	b=ARvzQqc5HPpCmHdnTV2rAb6bK/xZRs+BEcyWdS4dC/pjfvIUtH41X3QCUmZcFL2BFUml+3
	hhNxXYZlAJrAN6HCztj7pdW8ApgO+OxeFRkGngR865q/ykH9cCRbMu2lfbDUf6Tr+RQDei
	io4eHHm15qlQooA8v5SBu1AKl71tPBGHSgtcdexhg3OEXq3kn++qEBfSJRCsBP0R2I/zJ6
	x8QpGvYpfvgPFXEYm0EplDvjKky8lc3PoGKpgTJtn/6NdKmVj5GfCgk45Tj3fG4BLeO4cD
	M3SsaLCCrqNSTCyjlKD3BiiwCEloXaqBrdd0rsKR11wWyNORA48NtW6qiB2geQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frank Wunderlich <linux@fw-web.de>
Subject: Re: [PATCH] arm64: dts: marvell: Drop undocumented SATA phy names
In-Reply-To: <20241014193528.1896905-2-robh@kernel.org>
References: <20241014193528.1896905-2-robh@kernel.org>
Date: Tue, 05 Nov 2024 17:28:57 +0100
Message-ID: <87r07p8x12.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

"Rob Herring (Arm)" <robh@kernel.org> writes:

> While "phy-names" is allowed for sata-port nodes, the names used aren't
> documented and are incorrect ("sata-phy" is what's documented). The name
> for a single entry is fairly useless, so just drop the property.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
> Cc: Frank Wunderlich <linux@fw-web.de>
>
> There's also this 2 year old patch fixing other SATA errors[1] which=20
> was never picked up. :(
>
> [1] https://lore.kernel.org/linux-arm-kernel/20220311210357.222830-3-linu=
x@fw-web.de/
>
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts             | 1 -
>  arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts       | 2 --
>  arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 1 -
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts             | 2 --
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi         | 1 -
>  arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts    | 2 --
>  6 files changed, 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/=
boot/dts/marvell/armada-7040-db.dts
> index 5e5baf6beea4..1e0ab35cc686 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -214,7 +214,6 @@ &cp0_sata0 {
>=20=20
>  	sata-port@1 {
>  		phys =3D <&cp0_comphy3 1>;
> -		phy-names =3D "cp0-sata0-1-phy";
>  	};
>  };
>=20=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/=
arm64/boot/dts/marvell/armada-7040-mochabin.dts
> index 40b7ee7ead72..7af949092b91 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> @@ -433,13 +433,11 @@ &cp0_sata0 {
>  	/* 7 + 12 SATA connector (J24) */
>  	sata-port@0 {
>  		phys =3D <&cp0_comphy2 0>;
> -		phy-names =3D "cp0-sata0-0-phy";
>  	};
>=20=20
>  	/* M.2-2250 B-key (J39) */
>  	sata-port@1 {
>  		phys =3D <&cp0_comphy3 1>;
> -		phy-names =3D "cp0-sata0-1-phy";
>  	};
>  };
>=20=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b=
/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> index 67892f0d2863..7005a32a6e1e 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> @@ -475,7 +475,6 @@ &cp1_sata0 {
>=20=20
>  	sata-port@1 {
>  		phys =3D <&cp1_comphy0 1>;
> -		phy-names =3D "cp1-sata0-1-phy";
>  	};
>  };
>=20=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/=
boot/dts/marvell/armada-8040-db.dts
> index 92897bd7e6cf..2ec19d364e62 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -145,11 +145,9 @@ &cp0_sata0 {
>=20=20
>  	sata-port@0 {
>  		phys =3D <&cp0_comphy1 0>;
> -		phy-names =3D "cp0-sata0-0-phy";
>  	};
>  	sata-port@1 {
>  		phys =3D <&cp0_comphy3 1>;
> -		phy-names =3D "cp0-sata0-1-phy";
>  	};
>  };
>=20=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/ar=
m64/boot/dts/marvell/armada-8040-mcbin.dtsi
> index c864df9ec84d..e88ff5b179c8 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> @@ -245,7 +245,6 @@ &cp0_sata0 {
>  	/* CPM Lane 5 - U29 */
>  	sata-port@1 {
>  		phys =3D <&cp0_comphy5 1>;
> -		phy-names =3D "cp0-sata0-1-phy";
>  	};
>  };
>=20=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts b/ar=
ch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
> index 42a60f3dd5d1..3e5e0651ce68 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
> @@ -408,12 +408,10 @@ &cp0_sata0 {
>=20=20
>  	sata-port@0 {
>  		phys =3D <&cp0_comphy2 0>;
> -		phy-names =3D "cp0-sata0-0-phy";
>  	};
>=20=20
>  	sata-port@1 {
>  		phys =3D <&cp0_comphy5 1>;
> -		phy-names =3D "cp0-sata0-1-phy";
>  	};
>  };
>=20=20
> --=20
> 2.45.2
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

