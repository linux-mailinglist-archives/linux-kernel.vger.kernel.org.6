Return-Path: <linux-kernel+bounces-394920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DCA9BB607
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC621F22E4F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEFD42A9F;
	Mon,  4 Nov 2024 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8S7YWTl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3A33FE;
	Mon,  4 Nov 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726779; cv=none; b=TIWE+tiGVcFubYLUin/LHSmzd62dG55gg0JBgVVvm7sS8Gio5eJ3xoitaICJ1h5RGvBn+jK7JP6RMCKICvnRaBhDmYVVIdklobU5Nhovgq+zRRA0SaNEJH2OAI+83DAUd9YPtSvHFwU4xG0r+d5FSFCD+1l056xNmt5D3/q+MWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726779; c=relaxed/simple;
	bh=Ijo8Sq1mgBUB6sBszy//feBUAboDIQErEOZUwjZS0JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jsb5MItXXPq8QyycsqOuJxRBkBZwmmdvOBLfqezg1rTFrd14tF5ep06DMZ7vUpHdoWu2Jrv0JkU4F2lczwF6VxV1KyiObWmpGOIZJNFWaYDNZ+2Hb4wr2OU5BATThdB2C8GX2/7RZzPuE0Yqty4iUdaJ0y5dgBgMmsKqLzS0Ndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8S7YWTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA667C4CED4;
	Mon,  4 Nov 2024 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730726776;
	bh=Ijo8Sq1mgBUB6sBszy//feBUAboDIQErEOZUwjZS0JI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M8S7YWTl+LeAP5CbBcAv72Zcx5wrIgUTNgW3dav7Ek9DtMb/NFGuLb3i0yPH5eZn7
	 TDKgKax5EWxJD9p0xKJOljllimViMRwy0Fl098Lzj4rkwwYY8XcLHqxjW8TSyx9lys
	 NHvm2Q0tIw6a5Xb4W7BLeQWO/E1llQh5lxvvsj4xwiBCyfT9FZ8vMZI2BoU9EFXrdb
	 aEaZg9Esc/JFy64HGu0FVXklOItWs02swCQnhVPeIAI/VwqSPzudqVZOZr/xiM+ssb
	 uaFAWRDagfev/ceJM4QSkO5SVQwvmBKfsWJB99DwO5+59qO0A72fzqc8hmdcq3ZhOR
	 bMKDWiVtgFUXg==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e290e857d56so3697389276.1;
        Mon, 04 Nov 2024 05:26:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQ0tMyiBkrLniVJAMnbPD9LJnQjwDOljXyQEC4BXcWWzQvi00svQjp+aENTWPE75f0RBS8rYm9pxI+Tb6J@vger.kernel.org, AJvYcCWyNRteeuJLT254sUXEDTdF6vVHW0BQq2zWhR4UU1f47B+C6z4qES8TC6/t6tlVNIOwBEKZoWragDn/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp37fgVNjW79/Tg/7sU5gyjhAkUBXyg2BYAiTyD+wV1ILP3tTN
	et+S0jgmhdJege4nWB/9BJ29T8nSANEy+nKDvFm8SDeMlQinwykGuCELJkd54ELimGDWo8gHD+e
	x0lMrKa+u04Cc2U/4O6PEmgqWwA==
X-Google-Smtp-Source: AGHT+IENFmPCgLa2f0tPo8wbahVEAD5smWzhDagnbAka8mwN23BytgHgO4bTbOLBkWEzwe5RdypOb1vOLgv6wD8TjbY=
X-Received: by 2002:a05:690c:9c0f:b0:6de:a3:a7ca with SMTP id
 00721157ae682-6e9d8acb4a9mr376026027b3.32.1730726775947; Mon, 04 Nov 2024
 05:26:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910215905.823337-1-robh@kernel.org>
In-Reply-To: <20240910215905.823337-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Nov 2024 07:26:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJBeoD4yPj1Wva5cbPHweK3RU6pF-Vn=P+MsW0-RhKhZQ@mail.gmail.com>
Message-ID: <CAL_JsqJBeoD4yPj1Wva5cbPHweK3RU6pF-Vn=P+MsW0-RhKhZQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: nuvoton: Fix at24 EEPROM node names
To: Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:59=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> at24.yaml defines the node name for at24 EEPROMs as 'eeprom'.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts           | 6 +++---
>  .../arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Ping!

>
> diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts b/arch/arm=
/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts
> index 9f64c85e1c20..c3501786d600 100644
> --- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts
> +++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts
> @@ -661,7 +661,7 @@ &i2c5 {
>         clock-frequency =3D <100000>;
>         status =3D "okay";
>
> -       mb_fru@50 {
> +       eeprom@50 {
>                 compatible =3D "atmel,24c64";
>                 reg =3D <0x50>;
>         };
> @@ -704,7 +704,7 @@ max31725@5d {
>                                 reg =3D <0x5d>;
>                                 status =3D "okay";
>                         };
> -                       fan_fru@51 {
> +                       eeprom@51 {
>                                 compatible =3D "atmel,24c64";
>                                 reg =3D <0x51>;
>                         };
> @@ -714,7 +714,7 @@ i2c5_hsbp_fru_3: i2c@3 {
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         reg =3D <3>;
> -                       hsbp_fru@52 {
> +                       eeprom@52 {
>                                 compatible =3D "atmel,24c64";
>                                 reg =3D <0x52>;
>                                 status =3D "okay";
> diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts=
 b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
> index 087f4ac43187..f67ede148209 100644
> --- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
> +++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
> @@ -824,7 +824,7 @@ tmp75@4a {
>                 reg =3D <0x4a>;
>                 status =3D "okay";
>         };
> -       m24128_fru@51 {
> +       eeprom@51 {
>                 compatible =3D "atmel,24c128";
>                 reg =3D <0x51>;
>                 pagesize =3D <64>;
> --
> 2.45.2
>

