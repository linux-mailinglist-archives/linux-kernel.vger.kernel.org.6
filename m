Return-Path: <linux-kernel+bounces-363223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5508D99BF32
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DCE1C2164E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1419052F88;
	Mon, 14 Oct 2024 04:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEmjXqw3"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688BF4A1C;
	Mon, 14 Oct 2024 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728881105; cv=none; b=FwNo7EbT4IbqYIukdZw8c47FZT06Nl9TUuRqqyiVeo3VPFVCUSzv8Gu3+17Z/Q4dFJ5FzwY05ZYlzLuNIZ/bGThjJ1iiCgzbA84g9iJrmdKP4T+htTCwe1yLGnNj9R0164m/2iKX50pccheLfm2LJzErmazarKzBm89r1j3kCOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728881105; c=relaxed/simple;
	bh=l3Z8viThKZh1oiS+/bkaB8EpTs79utadXuECg1YEoao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaEv9wtmLJzVcgOTrxAtskiJ3IjBdrn+NVinHAeuXoH9cOqY8F4GGxxgyNTQMdSFLAJ5Pq7QZUDNE9LB7oesFDKj8M0Tj6uoEfi0xTl9knj8VXeewo4kJITj1Vnlt+gNx8XCEltN6NhPIdrgtzVg05z48e+Bxo1nJdk3FmnZVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEmjXqw3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so2375754f8f.1;
        Sun, 13 Oct 2024 21:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728881102; x=1729485902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UKeLghLjeCgQYXLcqszTN85GeABrzJa0W3ZVrL32nU=;
        b=YEmjXqw3YKgouiIuIDvMcL9pH2RkR6JiINNjJzfIMmkEOpJQ1YpFnhKY16ILQE3Pg3
         YxHVP2NJd7YszBoekD3GJe0DrRuOBjdHuEKM3mOzgOuPJwhrLbNKzEMN3wJjWUB5QDwW
         UPLvOvah/WLTHnnn0FVxU09pUuA3S9vPVIneUmKNrHXsI4EARnhenBQd/VbvIEBoo0a6
         3H2yULXsgOQ/z10pNPAiVb6t2KaaVCQ5bVAqhXc4BzUPZ1OImZZl2GcV06s6/Od1b7Sv
         RARZ0h7zK7cH606207dgY0Ee7WYMpbCYth4XpC9XpDYeOuXX2/s6lyqDRgshGaQJBtTh
         HzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728881102; x=1729485902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UKeLghLjeCgQYXLcqszTN85GeABrzJa0W3ZVrL32nU=;
        b=RNxfbNQlVXbKSaqzy/aWnUFhaO7SM407gbZBMeW69tFkZ9h+7T7h7rN2kaIly6dzsS
         BFdjhorEvvCiTCoVhycmStVyV0q+5cLl9hQjD15P1dLhyEOtCGhvFVpMrrPE7ifHVZ+X
         PqvR1YP6qFoem4O4/bmRleXPL4DDelZ8q6jg71kSHUEXc5qR8I/li1MKkp6sC+ubwA9n
         RMa4ztmN2r7flOPLwYiuTu+aDRXhnkLGszFv7F4g8ktMvnr/OpLKWd9Og2R1pVZZlJIs
         yvOR4Q9Gc0OjI33nqp1CAkBzhcYJRdyQLaHazcBnC88/6OMSIWf3Js0gRPxZkph8KBTk
         KGqg==
X-Forwarded-Encrypted: i=1; AJvYcCVR0x9dtpchiXMc+8kJC1jm42IzdLoVgffmIAgf3J4dNx/jWipGoOWK8UIzw/kdZa6G1iPXVz/2YG3ZOjZq@vger.kernel.org, AJvYcCVlKPZ1DLW0xAEuf/Ikz9JDRvjE/ZoN4bAdvRoMYidjQ78FluQuGMwjLgEyfFgHt9FThvvsArJwXoIy@vger.kernel.org
X-Gm-Message-State: AOJu0YzlAE2fef2K/v3pVCy53pwMqVjVNXBayA7gBACzYeAI8X0wtLT7
	NSKmB0/BZm+0LXkVl6mKx8BdkQmh7JmjbC422mbRCnOFbcEy3OrYpWkVKpC6rAgUgJ+hcnqRj3C
	EoiksTESDUSiiiMri2eR4/EJ860Y=
X-Google-Smtp-Source: AGHT+IGAK9ALbpvZxrD4MsOrzSNBBfXAkPN05nxOFAoxUQMJYEijL97sQKwLLbqOqimNKPU29nqDYewjzNuG70qqOc8=
X-Received: by 2002:adf:fa8d:0:b0:37d:36f2:e2cb with SMTP id
 ffacd0b85a97d-37d54debf9fmr7723606f8f.0.1728881101342; Sun, 13 Oct 2024
 21:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013213305.310844-1-cenk.uluisik@googlemail.com>
In-Reply-To: <20241013213305.310844-1-cenk.uluisik@googlemail.com>
From: Jimmy Hon <honyuenkwun@gmail.com>
Date: Sun, 13 Oct 2024 23:44:50 -0500
Message-ID: <CALWfF7L7mHV-MwsQLMmA4kx_trWCO4mn36ooyjc5fVq_DL4nzw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] arm64: dts: rockchip: Add rk3588-orangepi-5b
 device tree and refactor
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Michael Riesch <michael.riesch@wolfvision.net>, Andy Yan <andyshrk@163.com>, 
	Dragan Simic <dsimic@manjaro.org>, Jing Luo <jing@jing.rocks>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 4:33=E2=80=AFPM Cenk Uluisik
<cenk.uluisik@googlemail.com> wrote:
>
> Implements a slightly modified rk3588s-orangepi-5b.dts from the vendor.
> Unfortunately the &wireless_bluetooth and &wireless_wlan overlays don't s=
eem
> to compile, so I removed them for now:
>
> Error: arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts:20.1-20 Label=
 or path wireless_bluetooth not found
> Error: arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts:24.1-15 Label=
 or path wireless_wlan not found
>
> Bigger parts of the rk3588s-orangepi-5.dts file were moved into a new
> rk3588s-orangepi-5.dtsi file, so that both device trees from the orangepi=
-5 and 5b include from it and avoid including from the .dts.
>
> How does this board differ from the original Orange Pi 5?
>   - builtin eMMC storage
>   - no SPI NOR flash (u-boot, preboot etc. initiates from within the eMMC
>     storage)
>   - ap6275p Wifi module (like the Orange Pi 5 Plus)
>   - builtin BlueTooth module
>
> Beside that everything is exactly the same as far as I know.

Another difference is the Orange Pi 5 has a M.2 NVMe M-key PCI 2.0x1
slot (hooked to combphy0_ps) whereas the Orange Pi 5b uses combphy0_ps
for the WiFi.
I mention this because the vendor kernel defines each boards pcie2 differen=
tly
https://github.com/orangepi-xunlong/linux-orangepi/blob/orange-pi-6.1-rk35x=
x/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts#L441
https://github.com/orangepi-xunlong/linux-orangepi/blob/orange-pi-6.1-rk35x=
x/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts#L373

The Orange Pi 5 with the M.2 socket has a regulator defined hooked to
"GPIO0_C5" (i.e. PCIE_PWREN_H) whereas the Orange Pi 5B has GPIO0_C5
hooked to BT_WAKE_HOST.

> --- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> @@ -1,766 +1,10 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -

> -       vcc3v3_pcie20: vcc3v3-pcie20-regulator {
> -               compatible =3D "regulator-fixed";
> -               enable-active-high;
> -               gpios =3D <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
> -               regulator-name =3D "vcc3v3_pcie20";
> -               regulator-boot-on;
> -               regulator-min-microvolt =3D <1800000>;
> -               regulator-max-microvolt =3D <1800000>;
> -               startup-delay-us =3D <50000>;
> -               vin-supply =3D <&vcc5v0_sys>;
> -       };
As mentioned at the top, you may want to only define this in the
Orange Pi 5 board, and leave it out of the Orange Pi 5B board.

> -&pcie2x1l2 {
> -       reset-gpios =3D <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> -       vpcie3v3-supply =3D <&vcc3v3_pcie20>;
> -       status =3D "okay";
> -};
Then this can be defined differently between the Orange Pi 5 vs Orange Pi 5=
b.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/a=
rm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
> similarity index 99%
> copy from arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> copy to arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
> index feea6b20a6bf..739c4d9f58e0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
> @@ -10,9 +10,6 @@
>  #include "rk3588s.dtsi"
>
>  / {
> -       model =3D "Xunlong Orange Pi 5";
> -       compatible =3D "xunlong,orangepi-5", "rockchip,rk3588s";
> -
>         aliases {
>                 ethernet0 =3D &gmac1;
>                 mmc0 =3D &sdmmc;
Since the sdhci is enabled for the Orange Pi 5b, it'd be nice to add
an alias for it.

Heiko, can we change the sdmmc alias to be mmc1, and let the sdhci be
mmc0? That way it's consistent with all the other rk3588 DTS? A change
like this could break existing users if they coded using /dev/mmc0
device file.

Seems like it's only the NanoPi and Orange Pi 5 rk3588 that use a
different convention. The Orange Pi 5 Plus is consistent with the
other rk3588 device trees.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts?h=3Dv6.11#n20

This is the new default that rockchip wants to use.
https://github.com/orangepi-xunlong/linux-orangepi/commit/bce92d16b230b8e93=
c2831fb7768839fd7bbab04

Orange Pi flipped it in their 5.10 kernel.
https://github.com/orangepi-xunlong/linux-orangepi/commit/7e6c3163aa7e58b19=
730aa2aa259f1bb957cbca0#diff-0c7ddd2f22091009f8e7a4970aa293bfae425f25d0fe2c=
19418b886ec9eab3fa

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts b/arch/=
arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> new file mode 100644
> index 000000000000..049227af0252
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3588s-orangepi-5.dtsi"
> +
> +/ {
> +       model =3D "Xunlong Orange Pi 5B";
> +       compatible =3D "rockchip,rk3588s-orangepi-5b", "rockchip,rk3588";
The second part of the compatible should be "rockchip,rk3588s" to
match the binding.
> +};
> +
> +&sdhci {
> +       status =3D "okay";
> +};
The mainline dtsi does not have the sdhci node elaborated on for the
Orange Pi 5 like the vendor kernel does. Do you want to add it to the
common dtsi?
https://github.com/orangepi-xunlong/linux-orangepi/blob/orange-pi-6.1-rk35x=
x/arch/arm64/boot/dts/rockchip/rk3588s-orangepi.dtsi#L461-L470
The Orange Pi 5 Plus has a similar sdhci node definition in mainline at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts?h=3Dv6.11#n433
> +
> +&sfc {
> +       status =3D "disabled";
> +};
Since the sfc is a difference between board variants, would it be a
better practice to mark the node disabled in the common dtsi, and mark
it enabled only in the 5.dts?

> \ No newline at end of file
> --
> 2.46.0
>

