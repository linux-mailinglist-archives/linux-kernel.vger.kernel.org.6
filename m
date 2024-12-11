Return-Path: <linux-kernel+bounces-441210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BAB9ECB21
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DB2188359A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C8E238E10;
	Wed, 11 Dec 2024 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzEHgHx3"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9F238E00;
	Wed, 11 Dec 2024 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916423; cv=none; b=DK1M3mddB2aGDs5NqApFdcbD8qwSaoE7sIxTre0TAfBomUAPnTc9RzXUfQGjrBoH2Cgbxzjv+wpFXAdCPl1GRvkxypLuvfhjGTaVxVO+TvfOJMXCZVrYMhtLFrpq/Vw58nOQszPsqlCryPzjgoeu1HzP1afE1sR9BQW08wAUB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916423; c=relaxed/simple;
	bh=kRoCN44NiV2nWFB+xquMsmKtCCz/Ubb4phkGmdcrVT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gR7pVDBmJqVaafIDHj1ooxgb7y7QwR2pgn0sTiN/TIsdCDix3d9zJZRvP3mdAkDoYRLLvTcgF7ve6npMEi9bc5LVgJxqKhrACboMaLNXScOkw4DPwxJWW8+iKUwpuMoaKMnDEVCtl8St2nyAsAj/3P+onPuLh/hECaWIkK3m2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzEHgHx3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d34030ebb2so9157396a12.1;
        Wed, 11 Dec 2024 03:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733916420; x=1734521220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QTNgmzYB7WhakHI7BtpiVfr7WRGVdLXuQWsgOk30eY=;
        b=JzEHgHx3PbqSQ916RlxflELMa9bLHoNVPBFhxNT4uCpCRiTBFxlt7AUoQPEUe9aiTP
         tEuJYv4DrFdpQnADS+5jdk68+QEQKs+b02xCiGvqZyKnUWIu+fq6QTT+qbfm+Uoh5237
         lOxgH9olsCYmN9+md6i8+O8kX2Y4NtUAYnIdbhHaK+R5rMZQtzTxxE/HwRiwkrzD6KlC
         HzZDf0l6JcJ23M0vWjaYaFAjhCdbKvvDlZFceR20vzPtidLjWXzsfKmU4Ym+2UsDGBUN
         eFy8s1OZbRbg1YihOiimvU70x91q6/oIqBAj5flr2IH17w+UmPM1qujKFrpZR9DCC+EN
         /wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733916420; x=1734521220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QTNgmzYB7WhakHI7BtpiVfr7WRGVdLXuQWsgOk30eY=;
        b=OG+ysDl8GGvFO8jUxWU+yz7EiMmgY+/PKw81/jiyxMj1q9wTl9CmemtXIrb56XawQL
         poRg+SQBtaHPjEWEkC3IX3jcNITJxxc78BXY5FNLmYVkzVOs4yonmDdiYIMnVdb16utZ
         7sIHxUWSztuFvNeD+pMsrUH3FnZpI12F+MUdXKUAefbnJdnU2Bi877I+60Zhlc11H5ad
         k4ssRkK0iVPnjbxBZ2WJGozpjPeylQw4OICrON4m0IeAodMcRn8epmu939R1xTirhAfm
         STxCzvZ1QkepjzQI7h35738Q3p7Vx5V+6PsfrwiLfdiMVRrUrDCD40ZqtKAzClGfNlL/
         nfjw==
X-Forwarded-Encrypted: i=1; AJvYcCUJq4KZgVaLBl7Dfs8OKP50RQsaboFK/0KmKjed7/od9WHwSvkN+JnNWs9zg954azXTF9rWA0mKzhgiVk/n@vger.kernel.org, AJvYcCX7Rk4s1TqAs5spw08bvDowGv4K9W0U2/09UjQ0ZvF+387Zx5rO1f6i+PfxLIU7c8AT4qrRfdnfpPng@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/039/87mGHxU/EGobckmTojnpR96a1exgluMok9Qm7n4nuerR
	V51qAvK37SW2DHqFX+44hCc9kjfKMWD5SAv9d6GnSJ2Edypj3RQaas7gSXQfWW4Hqzz6VOMOZ//
	AcbddbvOGyFaeyVw/RnX+e5DWEV4=
X-Gm-Gg: ASbGncvfi5wnViU+NS7BmBgXg65AW4Pi8+N1ZZmUXJ/Ytsm4XMvz9YXP0wruB/e527Y
	gDGgDLuH/8dybfhP5xr9LYeStfVubrx5CiDfT
X-Google-Smtp-Source: AGHT+IGm7Cc0UCKCXs6Zci5MhmEB6BM+vhudXV8nstxvwpWP8Qfr3RbFbc33+jNWjYOvcsdishshabpxzxK6uMTtoQo=
X-Received: by 2002:a05:6402:35c6:b0:5d1:2652:42ba with SMTP id
 4fb4d7f45d1cf-5d4330ab69dmr2432050a12.16.1733916419489; Wed, 11 Dec 2024
 03:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e00f08d2351e82d6acd56271a68c7ed05b3362e8.1733901896.git.dsimic@manjaro.org>
In-Reply-To: <e00f08d2351e82d6acd56271a68c7ed05b3362e8.1733901896.git.dsimic@manjaro.org>
From: Peter Geis <pgwipeout@gmail.com>
Date: Wed, 11 Dec 2024 06:26:46 -0500
Message-ID: <CAMdYzYpnx=pHJ+oqshgfZFp=Mfqp3TcMmEForqJ+s9KuhkgnqA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Delete redundant RK3328 GMAC
 stability fixes
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:29=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>

Good Morning,

> Since the commit 8a469ee35606 ("arm64: dts: rockchip: Add txpbl node for
> RK3399/RK3328"), having "snps,txpbl" properties defined as Ethernet stabi=
lity
> fixes in RK3328-based board dts(i) files is redundant, because that commi=
t
> added the required fix to the RK3328 SoC dtsi, so let's delete them.
>
> It has been determined that the Ethernet stability fixes no longer requir=
e
> the "snps,rxpbl" and "snps,aal" properties, [1] out of which the latter a=
lso
> induces performance penalties, so let's delete these properties from the
> relevant RK3328-based board dts(i) files.

You may want to include snps,force_thresh_dma_mode in this group such
as on the rock64. It's even more limiting than snps,aal.

Otherwise,
Acked-by: Peter Geis <pgwipeout@gmail.com>

Very Respectfully,
Peter Geis

>
> This commit completes the removal of these redundant "snps,*" properties
> that was started by a patch from Peter Geis. [2]
>
> [1] https://lore.kernel.org/linux-rockchip/CAMdYzYpj3d7Rq0O0QjV4r6HEf_e07=
R0QAhPT2NheZdQV3TnQ6g@mail.gmail.com/
> [2] https://lore.kernel.org/linux-rockchip/20241210013010.81257-7-pgwipeo=
ut@gmail.com/
>
> Cc: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328-a1.dts                | 1 -
>  arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi        | 1 -
>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi | 1 -
>  arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts         | 3 ---
>  4 files changed, 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts b/arch/arm64/boot=
/dts/rockchip/rk3328-a1.dts
> index 824183e515da..24baaa7f1d8c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
> @@ -110,7 +110,6 @@ &gmac2io {
>         phy-supply =3D <&vcc_io>;
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&rgmiim1_pins>;
> -       snps,aal;
>         snps,pbl =3D <0x4>;
>         tx_delay =3D <0x26>;
>         rx_delay =3D <0x11>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
> index f9fab35aed23..d5f129e304e5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
> @@ -142,7 +142,6 @@ &gmac2io {
>         phy-supply =3D <&vcc_io_33>;
>         pinctrl-0 =3D <&rgmiim1_pins>;
>         pinctrl-names =3D "default";
> -       snps,aal;
>
>         mdio {
>                 compatible =3D "snps,dwmac-mdio";
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi b/=
arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
> index 181ec6de0019..9ec93f61433e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
> @@ -113,7 +113,6 @@ &gmac2io {
>         phy-supply =3D <&vcc_io>;
>         pinctrl-0 =3D <&rgmiim1_pins>;
>         pinctrl-names =3D "default";
> -       snps,aal;
>
>         mdio {
>                 compatible =3D "snps,dwmac-mdio";
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm=
64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> index 3e08e2fd0a78..59dead1cc503 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> @@ -153,9 +153,6 @@ &gmac2io {
>         phy-supply =3D <&vcc_io>;
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&rgmiim1_pins>;
> -       snps,aal;
> -       snps,rxpbl =3D <0x4>;
> -       snps,txpbl =3D <0x4>;
>         tx_delay =3D <0x26>;
>         rx_delay =3D <0x11>;
>         status =3D "okay";

