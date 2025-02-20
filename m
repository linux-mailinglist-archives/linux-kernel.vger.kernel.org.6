Return-Path: <linux-kernel+bounces-524162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093F6A3DFD4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7769919C22BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E28F20C034;
	Thu, 20 Feb 2025 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5YAsf0u"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134702080CC;
	Thu, 20 Feb 2025 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067524; cv=none; b=G/BcoyeQqb5wXyjQUd2aYOgoYfbYSGjNUr2eWA2zZZur4UC4ovhDtMehs9cLBtBsPEbD4WLCytlCq/jBga44xuA2/3ctKMELXnrf3S9zQaEbAL1Kr4WpbXSnfebwjxN0jRUw4wkSxQyq5hFhL1ofp1P+7I4FJtRBD0Er7cumgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067524; c=relaxed/simple;
	bh=qjSOCgJQ4uSGZOPmPDVIFW2f0zZNS/JgFmShPrux1Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLg1SoxDo3x1GDd2btZZYybo41GOX21hT8wtmoFeVh8a/EsBxFRlVFg07iaZP7R+BhoBjC4Y3u8VgvYsBYfQUyOptZHYw1KQLaqszw47+b+jRKawFBT843d+lApECePFiK7lNP1P8dhmdjmPUybE3VvqVOsIgn09N8rZj+LjhPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5YAsf0u; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43948021a45so9837265e9.1;
        Thu, 20 Feb 2025 08:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740067521; x=1740672321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeC/y/vh1tkJh+M+/QzTRw0yFeyaFGiu3MMBcm9DXsQ=;
        b=b5YAsf0uR3Rp2nI1lWJ2hpPgPU8lBNgU11J98TP1Kra96838nC+Sx3TAyxttyVS1lp
         PTPiON48RqRLey+ZZzyuBiqpJlRaB1qj/hpyBwgjo+USjGUlPr2tDGLs9R/Y1KGan7lw
         Aq0oWmKATs3dxRGw06547JKki82gl1aUcUgaQpF+G9RZ05GOG0g1xv04J/QsxSbJcLGT
         YrnWVpqsPiWZzj9OdlX0x3+LePsRvvLr9DV9PC026aulED3d5+sXNN0vQqmPnDapPxSj
         bJRDrJXObkNTfqQxmDwWVhC6k5OombnTZInX7t6zZbCwEoWzVyGbk21+m5/Gu+rmhNK2
         JppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067521; x=1740672321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeC/y/vh1tkJh+M+/QzTRw0yFeyaFGiu3MMBcm9DXsQ=;
        b=hdou6V/JIMdHfRvOfX9Shh51XjdmayMYWwHdjOZQSPsNEwNjKysMo/0FbYI5K3Na13
         DQHSDFfRV/fqi7Nu/rqqcJAs228VA3aV1CsoXONFtAaJfNBhiMVRnz7IlgvjoNHPa+67
         7INpCMXXH1MWExKxhax1O3NT8Pq31Go31Bcft7lVgmB2QwQ//zVNt8uGNhFE2sgogx1s
         aD9rTDYKfHX2ikI53X/N0KOa42iHLX6cT1aK04wSsvP6lTwvxGfi2g6uwbOCKv5W8iWI
         XJspYjpGupLFGUKGPwBmckfVJuZy0O5d6oHGUhWV6WEqM3Nx3QJG4PR/oZTV+0pXKKpg
         dOog==
X-Forwarded-Encrypted: i=1; AJvYcCUM7HP3e07LlYHM8hzOemcO+xP9U4r5ufHouV+H5QMIj3qMhApM0smM7B95Udp7/99u9PnCyrL0e7sGtGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCJ+PRXX698AudM2BnIfuc3sjS7+/PO2f2zNFZa9OU+mHygPK6
	pE8w3qi2t4ju5PO/kdyg0QMZXdJW1LMgwJRUdiBOzHccP2Dd7Wh/
X-Gm-Gg: ASbGnctycsmXOk1NQSpOlgQfMDsZp4P8IqUI4lJIzHsPNBd7R1oD3R5mxRG28lXFEh1
	NTSCVtzafz/MgD9Rk2cceiqQkpzxbRYGiFuJJm8R54weXSGVA0r2SycMa+b/eioQ9tnEux2jypa
	Ga+E7KRJHbp7FWNgn8u+JAkhOYyxwGZxEocx3LDNAt/Dr8zYKo65iKqNajpJsx3scGkGTu9YusH
	S+u2tjoKhcqgDTBaXeE0KVPGIXOlOzBWpRvhG6UQYJB/8ALCPRXywoVeSOe+RI6RaMrTGPCPqXO
	pFJucZdnh40ZHuBrC2juPqtZp/rHldTuTMnOEfcfLfcTW2HElzPHZsaW9soJZ2rPfEU=
X-Google-Smtp-Source: AGHT+IH4UynjVIIpSlbvfcPnRuzuDf6FHbdwZq/2+3kemkCHgCd8NUoqXYSrlF9BQGYXBcqlYeePNg==
X-Received: by 2002:a05:600c:3ba6:b0:439:9828:c434 with SMTP id 5b1f17b1804b1-43999dd0fe3mr80636455e9.20.1740067520987;
        Thu, 20 Feb 2025 08:05:20 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399b430912sm54276465e9.0.2025.02.20.08.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:05:20 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maxim Kiselev <bigunclemax@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 John Watts <contact@jookia.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 John Watts <contact@jookia.org>
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Add thermal sensor
Date: Thu, 20 Feb 2025 17:05:19 +0100
Message-ID: <4835098.rnE6jSC6OK@jernej-laptop>
In-Reply-To: <20250220-thermal-v1-1-5168ddfc86e8@jookia.org>
References: <20250220-thermal-v1-1-5168ddfc86e8@jookia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 20. februar 2025 ob 10:25:10 Srednjeevropski standardni =
=C4=8Das je John Watts napisal(a):
> From: Maxim Kiselev <bigunclemax@gmail.com>
>=20
> This patch adds a thermal sensor controller node for the D1/T113s.
> Also it adds a THS calibration data cell to efuse node.
>=20
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: John Watts <contact@jookia.org>
> [John Watts: Remove disabled status]

I prefer other patch, which was posted not too long ago since it also has
thermal zones.

Best regards,
Jernej

> ---
> This is a quick fixed version of Maxim Kiselev's patch from here:
>=20
> https://lore.kernel.org/all/20231217210629.131486-4-bigunclemax@gmail.com/
>=20
> It removes the disabled status as requested. I've tested it by adding the=
rmal
> zones to my board and it works from what I can see.
> ---
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/ris=
cv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index e4175adb028da2be539e7aa316206fec4810adfc..cc3f9cc9b8ed20121924cc932=
412a6b6342a2f86 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -166,6 +166,18 @@ gpadc: adc@2009000 {
>  			#io-channel-cells =3D <1>;
>  		};
> =20
> +		ths: thermal-sensor@2009400 {
> +			compatible =3D "allwinner,sun20i-d1-ths";
> +			reg =3D <0x02009400 0x400>;
> +			interrupts =3D <SOC_PERIPHERAL_IRQ(58) IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_THS>;
> +			clock-names =3D "bus";
> +			resets =3D <&ccu RST_BUS_THS>;
> +			nvmem-cells =3D <&ths_calibration>;
> +			nvmem-cell-names =3D "calibration";
> +			#thermal-sensor-cells =3D <0>;
> +		};
> +
>  		dmic: dmic@2031000 {
>  			compatible =3D "allwinner,sun20i-d1-dmic",
>  				     "allwinner,sun50i-h6-dmic";
> @@ -426,6 +438,10 @@ sid: efuse@3006000 {
>  			reg =3D <0x3006000 0x1000>;
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
> +
> +			ths_calibration: thermal-sensor-calibration@14 {
> +				reg =3D <0x14 0x4>;
> +			};
>  		};
> =20
>  		crypto: crypto@3040000 {
>=20
> ---
> base-commit: eca631b8fe808748d7585059c4307005ca5c5820
> change-id: 20250220-thermal-803de9da0ce6
>=20
> Best regards,
>=20





