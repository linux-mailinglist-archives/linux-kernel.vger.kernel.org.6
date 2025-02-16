Return-Path: <linux-kernel+bounces-516572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 841EFA37427
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863D07A1C4C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36648191461;
	Sun, 16 Feb 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWv2zOKY"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2E18C91F;
	Sun, 16 Feb 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739709442; cv=none; b=oiTHlEL3ksvi7qGY5AEAnaBLuMeO7jSDj77cyro2pYYDny5n4oHTGzVCaV2rtG93I/lwd9CFKKnhdL45gFmI6CsRw+7DWAyeWDpD/gApZ7izeXGcbBb7Dw1Si4mzYn+zdGyJxUbE2HlAX5yQYPAledzjVKUbwYIZM8fB7nyyaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739709442; c=relaxed/simple;
	bh=HIGEJB0qUycZsdckTlxaaoA0bk1Jt2vpqEozX5IOtYQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AzM6gI4pr/sFrLDCCbAggpM27U2gj1oYB4Cy6IREY2n9VZ9Uld/o0VCwEDeX4fMcX1fpzIJk585+1wpVQtaRuAVcF3nYJTwr4rd+RudRWC+VMivUxvT0HaP3SoE1tl/ws9BYUpbHS6MK5PHbyKrP/SpGGChGi2viRChOg0Cwv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWv2zOKY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaecf50578eso695785066b.2;
        Sun, 16 Feb 2025 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739709439; x=1740314239; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JuodrbTqt2kISAe95cYUvufIOl8Fb0pi3tva7a0oDw=;
        b=QWv2zOKYj5lcPQGBr3lClx2aBXsNJI7rUke9/j2utxjF8V5NwEgz1Fnx92JIkkLMuZ
         cSObtQfp/CEJPl9UG0dVsVrJ99M5RHkwFHUzSApwsPZ1+1H5dwT7ZrlkT0JeDXcy3O8p
         2uZOS5+LI9D10Liw8hImOEvGf9y7BTSOymylS2KcV+2cxVAGyj3EzcD08r39cYC7wsMc
         +60i6Fnh5GTqBQNBX3YLF2agLSYmZ8edH37HSWS6QspBsbZ659T/ABTpqHJbnPQmYi8R
         0XUxqivzv8186wgkn1EHpATRjYndMmLzRFe9GcAz1s9H3cBnwDRMPsjEgevLC4oChv5F
         3YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739709439; x=1740314239;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JuodrbTqt2kISAe95cYUvufIOl8Fb0pi3tva7a0oDw=;
        b=vWAyTlXr9qx15jox3CE6Z8Odg37ZxYhNhsRGh6lsw/UQxXtAxC20GAIbxKgJph1j1Y
         Xk6eUYLV5FVE8/tiB6lPngJNKsf4Cedr7mJ0B7IKPh2xc7JkGFsuMV78AyJZt9KqYlCc
         uhn6sLEHN08mom79JWy8CN0NM18z7Q7EX+GTkwdw5CSAfb8nSJlWz/oMmJClK9MKeNWb
         NokmrcsVhFv780PK11oP6/3gOCV0IddTACgXMhx41B6u93ryVQ2ztkNKWWWRM4EeuiHV
         I0jYbK2KcBmwUPH/ZCWFuc6To/Q64BWT1+sDG+aqjyW79OhUfkhIHNZgZsTUrUamoWkS
         kxjA==
X-Forwarded-Encrypted: i=1; AJvYcCUMpdtEMVGfG9WNagZ9lo26hUH/3aQlpEBG71jKjsypEtEvc2jNI0E0mxzFECInZZahNvxsgwW5pazd@vger.kernel.org, AJvYcCUai3LiubEP83UKN0hqFJFYJhfgJCiT5NwgW/95Et3+V2/1HVFnHWkNtmUwVNYrgFTZEnjQ0zFA5vSL0I31@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0WC6IUsF+tV04w0SmqbVtczw3n6cDw+Tg+JlQD1gfFWdIRzFJ
	MlzS6k6onQf0slua0wm9xZyPbFEoqsxzTVCCNK50EQ63ZKC+XzQ5
X-Gm-Gg: ASbGncuNFXWS7FAG42k4//9DtopJGd1ilrBUVzgO3UiR/rjBisjb39D5YdFByT7pNa9
	ONqO47OMI8aMZTjOsKssDOhw24KTi2QMibJExvdoDdzHeSJtng6h/bRA6kiBS59mcPBqJPjVZyq
	YxiibSO4Te0RhRWH68Ys9mh8OgF0IjPnqFTOzOjNaG7Ya7ZzjX02H8SSW+EpcygX/TIiGpGOjyU
	fn6EIy3Tj3EVH8q/t8r4S3tOA27mC/6RC7sY0MCUxebam/o/GCwc3p6vRLxG/HLyDtbjf24wgdf
	YwxC+hscvwsg/c8KtTNkSgbT1dfcoYs6RZujM5ofyCgDf7XWBRSaeJsIVfHXbI6plS/3VS2t
X-Google-Smtp-Source: AGHT+IF7Li7Lm7POp1hY1DOd+YXcUFGnt79PSyFeoLFF1fqoqNga9gqKiKlCsi70OcwAnvjg618OOA==
X-Received: by 2002:a17:907:7244:b0:ab7:d6c:5781 with SMTP id a640c23a62f3a-abb70b35452mr579701566b.24.1739709438780;
        Sun, 16 Feb 2025 04:37:18 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb67732cd5sm343423666b.183.2025.02.16.04.37.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2025 04:37:17 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20250215152550.3975614-1-liujianfeng1994@gmail.com>
Date: Sun, 16 Feb 2025 13:37:05 +0100
Cc: linux-rockchip@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <566E6F11-765C-4415-8805-55DFD3C2BD4D@gmail.com>
References: <20250215152550.3975614-1-liujianfeng1994@gmail.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Jianfeng Liu =
<liujianfeng1994@gmail.com> w dniu 15 lut 2025, o godz. 16:25:
>=20
> Enable the HDMI port next to ethernet port.
>=20
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
>=20
> .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 53 +++++++++++++++++++
> 1 file changed, 53 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts =
b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> index 6d68f70284e..a4fdced052c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> @@ -11,6 +11,7 @@
> #include <dt-bindings/leds/common.h>
> #include <dt-bindings/pinctrl/rockchip.h>
> #include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> #include "dt-bindings/usb/pd.h"
> #include "rk3588.dtsi"
>=20
> @@ -89,6 +90,17 @@ fan0: pwm-fan {
> pwms =3D <&pwm14 0 10000 0>;
> };
>=20
> + hdmi1-con {
> + compatible =3D "hdmi-connector";
> + type =3D "a";
> +
> + port {
> + hdmi1_con_in: endpoint {
> + remote-endpoint =3D <&hdmi1_out_con>;
> + };
> + };
> + };
> +
> /* M.2 E-KEY */
> sdio_pwrseq: sdio-pwrseq {
> compatible =3D "mmc-pwrseq-simple";
> @@ -261,6 +273,32 @@ &gpu {
> status =3D "okay";
> };
>=20
> +&hdmi1 {
> + pinctrl-0 =3D <&hdmim0_tx1_cec &hdmim0_tx1_hpd
> +     &hdmim1_tx1_scl &hdmim1_tx1_sda>;
> + status =3D "okay";
> +};
> +
> +&hdmi1_in {
> + hdmi1_in_vp1: endpoint {
> + remote-endpoint =3D <&vp1_out_hdmi1>;
> + };
> +};
> +
> +&hdmi1_out {
> + hdmi1_out_con: endpoint {
> + remote-endpoint =3D <&hdmi1_con_in>;
> + };
> +};
> +
> +&hdptxphy_hdmi0 {
> + status =3D "okay";
> +};
> +
> +&hdptxphy1 {
> + status =3D "okay";
> +};
> +
> &i2c0 {
> pinctrl-names =3D "default";
> pinctrl-0 =3D <&i2c0m2_xfer>;
> @@ -1209,3 +1247,18 @@ &usbdp_phy1 {
> rockchip,dp-lane-mux =3D <2 3>;
> status =3D "okay";
> };
> +
> +&vop {
> + status =3D "okay";
> +};
> +
> +&vop_mmu {
> + status =3D "okay";
> +};
> +
> +&vp1 {
> + vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
> + reg =3D <ROCKCHIP_VOP2_EP_HDMI1>;
> + remote-endpoint =3D <&hdmi1_in_vp1>;
> + };
> +};
> --=20
> 2.43.0
>=20
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

Jianfeng,

Is there anywhere repo with this patch applied to test it on rock5 itx =
hw?

(asking as I can=E2=80=99t get it working; even with hdmi1 only vop =
clocks like here: =
https://gist.github.com/warpme/49feadbe1f53ea31fca76f41d5bb3ee4)



