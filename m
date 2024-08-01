Return-Path: <linux-kernel+bounces-271574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4403194503C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED16D2814B4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5721B3F04;
	Thu,  1 Aug 2024 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ut9hH4gH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17E13B79F;
	Thu,  1 Aug 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528770; cv=none; b=eBwiHZ5dpKBiAvkF4EHaEptelilb2c/TkEQaxEAdXC5eRt71WWIhxFmO3XWQK9NWHMwYipXUagaxkF5lNQmXEuHhi201s0wHjx8bArahBXnNWA4oKZeyQvlPSaDabvJ/rjkJom0P0ybb6VJyiHqO55lV9qlklB2ijMV8NuDcVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528770; c=relaxed/simple;
	bh=2Ie04mSHgFdn3r8Q7k1jYkG+oGrFLofZ+lysI1ZWPOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSu2CVXFzGFJ6Z2vZNHPIIkI6YmfCOxDJ3Zhi1Y+Bfwjp7quEHdXyi9AkPOUWvhpnpFYACb1OQYIkoQBKyIf5DO/2VqAcZeyCXqP9LKhNsjtrIqn6eRSFbM9V77CJqUGiIGoYhutahKim60lpdzLkj6RXaYli1HklGwzdAnw50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ut9hH4gH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1146C4AF0C;
	Thu,  1 Aug 2024 16:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722528769;
	bh=2Ie04mSHgFdn3r8Q7k1jYkG+oGrFLofZ+lysI1ZWPOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ut9hH4gHjPyq5vDMGhVWueCxfwZezELn8OEFXLVb/NUb5exmVb9gKIMoZpyMqS9Iu
	 fIUvQNfCd5Q3ZO6dbEIGOPwzYxrhqDav4D050DZqJNCRYzcwW+1KCwd7xnZipjNeX6
	 fza3Q6zvlmVsSbMmTNdX8++eweR2xNw2ALuzd34opRkD8oT6YaTumlXp0JPIKTJZOv
	 xdaSmnus8Iqbyz61keFQniAdw/noOBCwQHERXA9bMDGXJWy9ORHz3CK5dme8kkqeMZ
	 +/nGZwredybhVLxneYBGN24rwGIF4XasDEV/JLdp/Mm8Z3jOTDjAadJVTVls97nGx2
	 EwD6lV1UoaiSw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f035ae0fd1so82577871fa.2;
        Thu, 01 Aug 2024 09:12:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDTFE0koV4BF/H0dDafN2a8Qf2l+bPxmrmsDw0UNRIWTGnvPnKMHeNLYA3P5Su5SSWvRMAYzscnXkX@vger.kernel.org, AJvYcCX/EAGPNya+iwgvtNMGHzl1vUVmxCOsraDEFb/z4A3WgMzgO5P/CLwzw5aGJAONfQg16dcSxqEOIEJD8GZt@vger.kernel.org
X-Gm-Message-State: AOJu0YxUztT85Vzvi39qZ4mTQWBMQ+bNWbFGPnnbHL7Ok5AcQH4bKlE6
	TuDw8g5zkblS6zA64w+Cjnrn9AOBcc5JJnC636tNxS3KJI6U61/1nyB1linSgpkZADD/h4vGUJa
	1o+pwiyANwgVX9me0WO2UptNN1g==
X-Google-Smtp-Source: AGHT+IGncQu6neIyJIzYRmFRoi4mAUStoczccHBnCM7t9chOdIKJaL1uoXvQ/+Sivukw+eV00ecVLPXJOtrZ7y8gFZA=
X-Received: by 2002:a2e:8718:0:b0:2ef:21e5:1f01 with SMTP id
 38308e7fff4ca-2f15aa888ecmr5842651fa.20.1722528768109; Thu, 01 Aug 2024
 09:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801051402.584652-1-paweldembicki@gmail.com>
In-Reply-To: <20240801051402.584652-1-paweldembicki@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Aug 2024 10:12:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+YMHAv312PQoSCRpgGedhg3OYJnDC9=YHWg6nJkQSaLQ@mail.gmail.com>
Message-ID: <CAL_Jsq+YMHAv312PQoSCRpgGedhg3OYJnDC9=YHWg6nJkQSaLQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: dtc: update P2020RDB dts
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:14=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:
>

On the subject, every patch is an 'update'. Please make it more
specific. If you have a hard time coming up with something specific,
that's a sign your patch is making too many separate changes.

> P2020RDB contains multiple peripherals, which isn't added to
> devicetree:
>   - Switch: Microchip VSC7385
>   - PMIC: Renesas ZL2006
>   - Temperature sensor: Analog Devices ADT7461
>   - Two eeproms: 24C256 and 24C01
>   - GPIO expander: NXP PCA9557
>   - reset gpios of Ethernet PHYs
>
> This commit adds it.
>
> Some refreshments was done:
>   - fixed link in ethernet-node
>   - platform drivers nodes names
>   - added 'gpio0' label in pq3-gpio-0.dtsi
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
>  arch/powerpc/boot/dts/fsl/p2020rdb.dts    | 85 +++++++++++++++++++++--
>  arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi |  2 +-
>  2 files changed, 81 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/fsl/p2020rdb.dts b/arch/powerpc/boot/d=
ts/fsl/p2020rdb.dts
> index 3acd3890b397..d563d37b91f1 100644
> --- a/arch/powerpc/boot/dts/fsl/p2020rdb.dts
> +++ b/arch/powerpc/boot/dts/fsl/p2020rdb.dts
> @@ -6,6 +6,7 @@
>   */
>
>  /include/ "p2020si-pre.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>
>  / {
>         model =3D "fsl,P2020RDB";
> @@ -33,7 +34,7 @@ lbc: localbus@ffe05000 {
>                           0x1 0x0 0x0 0xffa00000 0x00040000
>                           0x2 0x0 0x0 0xffb00000 0x00020000>;
>
> -               nor@0,0 {
> +               nor@0 {

Make these clean-ups a separate patch.

>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         compatible =3D "cfi-flash";
> @@ -79,7 +80,7 @@ partition@f00000 {
>                         };
>                 };
>
> -               nand@1,0 {
> +               nand@1 {
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         compatible =3D "fsl,p2020-fcm-nand",
> @@ -128,11 +129,49 @@ partition@1100000 {
>                         };
>                 };
>
> -               L2switch@2,0 {
> +               ethernet-switch@2 {
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> -                       compatible =3D "vitesse-7385";
> +                       compatible =3D "vitesse,vsc7385";

There are 7 occurrences of this. Please fix them all. (And again,
separate patch).

>                         reg =3D <0x2 0x0 0x20000>;
> +                       reset-gpios =3D <&gpio0 12 GPIO_ACTIVE_LOW>;
> +
> +                       ports {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +
> +                               port@1 {
> +                                       reg =3D <1>;
> +                                       label =3D "lan1";
> +                               };
> +                               port@2 {
> +                                       reg =3D <2>;
> +                                       label =3D "lan2";
> +                               };
> +                               port@3 {
> +                                       reg =3D <3>;
> +                                       label =3D "lan3";
> +                               };
> +                               port@4 {
> +                                       reg =3D <4>;
> +                                       label =3D "lan4";
> +                               };
> +                               vsc: port@6 {
> +                                       reg =3D <6>;
> +                                       label =3D "cpu";
> +                                       ethernet =3D <&enet0>;
> +                                       phy-mode =3D "rgmii";
> +                                       rx-internal-delay-ps =3D <1400>;
> +                                       tx-internal-delay-ps =3D <2000>;
> +
> +                                       fixed-link {
> +                                               speed =3D <1000>;
> +                                               full-duplex;
> +                                               pause;
> +                                       };
> +                               };
> +                       };
> +
>                 };
>
>         };
> @@ -141,12 +180,39 @@ soc: soc@ffe00000 {
>                 ranges =3D <0x0 0x0 0xffe00000 0x100000>;
>
>                 i2c@3000 {
> +                       temperature-sensor@4c {
> +                               compatible =3D "adi,adt7461";
> +                               reg =3D <0x4c>;
> +                       };
> +
> +                       eeprom@50 {
> +                               compatible =3D "atmel,24c256";
> +                               reg =3D <0x50>;
> +                       };
> +
>                         rtc@68 {
>                                 compatible =3D "dallas,ds1339";
>                                 reg =3D <0x68>;
>                         };
>                 };
>
> +               i2c@3100 {
> +                       pmic@11 {
> +                               compatible =3D "zl2006";

Missing vendor prefix.

> +                               reg =3D <0x11>;
> +                       };
> +
> +                       gpio@18 {
> +                               compatible =3D "nxp,pca9557";
> +                               reg =3D <0x18>;
> +                       };
> +
> +                       eeprom@52 {
> +                               compatible =3D "atmel,24c01";
> +                               reg =3D <0x52>;
> +                       };
> +               };
> +
>                 spi@7000 {
>                         flash@0 {
>                                 #address-cells =3D <1>;
> @@ -200,11 +266,15 @@ mdio@24520 {
>                         phy0: ethernet-phy@0 {
>                                 interrupts =3D <3 1 0 0>;
>                                 reg =3D <0x0>;
> +                               reset-gpios =3D <&gpio0 14 GPIO_ACTIVE_LO=
W>;
>                         };
> +
>                         phy1: ethernet-phy@1 {
>                                 interrupts =3D <3 1 0 0>;
>                                 reg =3D <0x1>;
> +                               reset-gpios =3D <&gpio0 6 GPIO_ACTIVE_LOW=
>;
>                         };
> +
>                         tbi-phy@2 {
>                                 device_type =3D "tbi-phy";
>                                 reg =3D <0x2>;
> @@ -232,8 +302,13 @@ ptp_clock@24e00 {
>                 };
>
>                 enet0: ethernet@24000 {
> -                       fixed-link =3D <1 1 1000 0 0>;
>                         phy-connection-type =3D "rgmii-id";
> +
> +                       fixed-link {
> +                               speed =3D <1000>;
> +                               full-duplex;
> +                               pause;
> +                       };
>                 };
>
>                 enet1: ethernet@25000 {
> diff --git a/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi b/arch/powerpc/boo=
t/dts/fsl/pq3-gpio-0.dtsi
> index a1b48546b02d..5181117ea6b5 100644
> --- a/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
> @@ -32,7 +32,7 @@
>   * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>
> -gpio-controller@fc00 {
> +gpio0: gpio-controller@fc00 {
>         #gpio-cells =3D <2>;
>         compatible =3D "fsl,pq3-gpio";
>         reg =3D <0xfc00 0x100>;
> --
> 2.34.1
>

