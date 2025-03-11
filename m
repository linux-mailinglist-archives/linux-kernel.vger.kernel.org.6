Return-Path: <linux-kernel+bounces-557053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0097A5D308
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCEE189A880
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6858922C331;
	Tue, 11 Mar 2025 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpjKsEAm"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442971D6DBB;
	Tue, 11 Mar 2025 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734961; cv=none; b=VOguHFq9iGMTykcNoHzVB/p2TMsVX35zavtB2eyTnbcwe5wh93C4dJEdlkSFdbj7sCcWr3OBgo1IpqRScuQCHh/8Z2zUSO4KJ3JcIffSXndLrHoR1M+uIh7fyQg5WwitzJE1eO0siLeaMFH5pkkm1jSJBlzEKoebaWf7HslKU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734961; c=relaxed/simple;
	bh=JfqA/cREN5ap0KC+NOoguLsVwcHMC4kC6hiUOpBMvyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RT1eNH/kZOkLWw5wq9wNziLB/dgYITDslxqItPpxvF7SzZA84+o0Favf4negmHtXgbszWt9Z2tNlG65rN26dfCZu2Np1XVZLSyfvUHsHmlshfACDFxP6RFNcAlzQW93ig77qWRkqfw4Yp3QzOua0nT6qgF4H5BQ4IvlhRO8Zj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpjKsEAm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso36594205e9.0;
        Tue, 11 Mar 2025 16:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741734958; x=1742339758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tX/dTIeYNxTzj5gZHvJ5AtwpzySsIM3wBh1XC79KOyI=;
        b=EpjKsEAm86dqI/AbWJorn+3jEH0EEXafb/YkpdV4iBQor+MoVVz6bZmAxImn9TcMtu
         k3zKtv475p3Ki22bfMaaEksDLrT+CnQpi/GWOktqyJbDUX9mX2QfMjXxpvAW4vkdjZFq
         yPGH+NGRMAFlGsYKglcQzCDGOQHlxveIvl95a4B5kazFeVNUuL4lWMicSkxos+XJQFlZ
         YN0hXCJJGxNRbNz4bsMpILG0ZRZ/8K/cG5mzx/tCAb0Wc9CWeOV6FuXvZ81koM03ltAI
         /AloDX8Uav+6UIMyYOIi87FXGfhq/jDBg22KRAHmSPsrSB6oi0vL+vRusDFLu09eqi2f
         XZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741734958; x=1742339758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tX/dTIeYNxTzj5gZHvJ5AtwpzySsIM3wBh1XC79KOyI=;
        b=DpowqH51dZ2lPgkNIVduaG1S/BXv4soG4WIqCgwfo4KtLxZUJaKBQNDwnIpqZ4u1wr
         Pzt8ibUAnLmfucMALRCdPtCg5DVKmkZhYx+mVsPlOYWxo4ZvqxWzv1ttXt4cefa1xwf5
         dBObou1PwMC0W0eoy35msgVauq3FJ6tPdxwvtorMfQNh6U2WTeo0PD7m1eU8suDq1478
         HL84OZGJ8EOs6LHLg6GutSFT45evfgAzmOStZl9FQHWNlOFM0f8/q+tfe9sH5ZIMLu6Z
         hO8ENbA8nyyoNLh0ZYzXjE5uQ+0Eh67RSnVNDjzbmJu3NH2BmbBXCHEKdy+nCg2MsqYE
         wKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH6cAXA9a5lBi76iJRZBQ2HYaHP0NcmjIVypnRm8LekeBk9giwITZKUfw7h0wFix9QbBWVEELgJ+O2wNI+@vger.kernel.org, AJvYcCWPu4puuwMGvR23NkrVfBt0bergGbZtYuMHeNoLxVcYBTCODaN+V7iXFxMFRsdTWLQxBJkeHgpep8RG@vger.kernel.org
X-Gm-Message-State: AOJu0YxsR6ocTTN469Mvpr6VGLLZpr9prtsCjrpqPyK+l2z+OPEcaMIm
	MoLcXfRbfBZbBG7qH0l7NcTZok377Md5jlARbBJ1kL2zhI3YvuIY3RAzthn6+mdYcVxxXeKmnK0
	C4mtu1zt7oBlduLxDAVxfyFQxlNM=
X-Gm-Gg: ASbGncsTzC0tYYi+e1VmYbnD/Z9ybpfHZ/jiSu7UfLG3gPvsPXNgo16I9Y3QaNBLgOC
	mYgBVD8RVmEjjrlwY4Xn0G0S/OblXDI2Q0jvzcG/HyH+M2WykxAsWOQNZj63DGQCrGL2gXtVh6S
	79+hyeWSVKkr/flRD97++9iwKHyL7BudKD8520ksDaDzpjmqdV5+4nkJDwbaS+ymocgGIf
X-Google-Smtp-Source: AGHT+IHdE+IvjKPy/H/187X9ESbJuc1W239VyqGDem3VC44hAK/6v4MUY7Ogj5IPUx6y6MopfRCWPyu9jEmvdN+2VSY=
X-Received: by 2002:a5d:47cc:0:b0:391:23de:b1b4 with SMTP id
 ffacd0b85a97d-39132db0648mr15300763f8f.45.1741734958355; Tue, 11 Mar 2025
 16:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311141245.2719796-1-liujianfeng1994@gmail.com>
In-Reply-To: <20250311141245.2719796-1-liujianfeng1994@gmail.com>
From: Jimmy Hon <honyuenkwun@gmail.com>
Date: Tue, 11 Mar 2025 18:15:47 -0500
X-Gm-Features: AQ5f1JpTXjTmVT-uFEQ-cp0wVYjs646Qn0g9ep9yELCKIu65h4ws4boyJnIroik
Message-ID: <CALWfF7JfJxudKKfvOBXiLOMijUi+xZCAUL_WRsB-UxpV3XKDEg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix pcie reset gpio on Orange Pi 5 Max
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:13=E2=80=AFAM Jianfeng Liu <liujianfeng1994@gmail=
.com> wrote:
>
> According to the schematic, pcie reset gpio is GPIO3_D4,
> not GPIO4_D4.
Thanks for the correction.
Also applies to the Orange Pi 5 Ultra.

I made the typo when starting with the Orange Pi 5 Plus with "gpio3
RK_PB3" and changed both "3" to "4".

I'm guessing u-boot has already initialized the device, otherwise the
problem would be more obvious.

>
> Fixes: c600d252dc52 ("arm64: dts: rockchip: Add Orange Pi 5 Max board")
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Reviewed-by: Jimmy Hon <honyuenkwun@gmail.com>

> ---
>
>  arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-compact.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-compact.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-compact.dtsi
> index 6e4dcd8fff26..f748c6f760d8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-compact.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-compact.dtsi
> @@ -64,7 +64,7 @@ &led_blue_pwm {
>
>  /* phy2 */
>  &pcie2x1l1 {
> -       reset-gpios =3D <&gpio4 RK_PD4 GPIO_ACTIVE_HIGH>;
> +       reset-gpios =3D <&gpio3 RK_PD4 GPIO_ACTIVE_HIGH>;
>         vpcie3v3-supply =3D <&vcc3v3_pcie_eth>;
>         status =3D "okay";
>  };
> --
> 2.43.0
>

