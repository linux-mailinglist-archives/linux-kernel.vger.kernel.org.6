Return-Path: <linux-kernel+bounces-519971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2832A3A426
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925E21889C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1048626FD9A;
	Tue, 18 Feb 2025 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2LuVvTB"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374AB26FA77;
	Tue, 18 Feb 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899442; cv=none; b=QPWSCKsFjc2TmMAse1NeOmnzB3uNPUQbdogIO0PzpW3mBo/Vm4hpf7rAfAP3sIltlvPTIYHW0v2BQPTUCM6DRncHtD+Ca3MEw5QWZcaH+lG9nw3qPtigowuzzSQNijecQaJ62pxT0Jt1ctsp8DSl218mlkYp2HiBR0TBudrJWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899442; c=relaxed/simple;
	bh=WmheXIVvAj3UxMixyj4UA80+kW7AvVq4N+19neOVuTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+mM7mRwADmtMy9EyaAKThFJTyYmNrSmLNgnAzLbyhi3KP1F1scyBlw3ttiFVTgjZ1Ec9an0a7lKQPBQV15VaWqX6iOuy4DF2PUMr8W39uJYFfLjXPs4M9t68vmiXFfbE9nO4S5hsbmb+zqCtWvFiegecyRUUgyWq0yMPEEt2wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2LuVvTB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso64311505e9.3;
        Tue, 18 Feb 2025 09:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739899437; x=1740504237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9Kw7qFxKXcr45whwRwvA4Mj2NB/oA7RxSCK/IlKNzo=;
        b=Y2LuVvTBbxtY4DhIJLIrGw0WeieXOqh0It70OSR9MjtDdHBymVrWYZB991GToP31lZ
         AsYh2IoZ36MFjIeGlwSNsEsTZ6+5WOdSYG2Q/dQ4gc1a1Zzns/+2MQFRTS4qQ9qhRAmE
         T5etdFw7y9S+Aw/P8kiJ8EzJBZwiUyIHz272oe/nSlthsrUpAV+1p/apB/HPyrq4dum4
         kTkBgIe5q0rhaQwbCa1PBQ/dYTLFK37W3HBmQNavnOA2y2JROLeY0bby9PGWxsWFig3N
         XMAz+WYR6IriMNhDKQs/cQ62G58Vn9f2RGgccVbe8yQ9LUBS+x5rcKacj/FtACY3Us/1
         L+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899437; x=1740504237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9Kw7qFxKXcr45whwRwvA4Mj2NB/oA7RxSCK/IlKNzo=;
        b=M1XNfI2xLsaPjSB94ooPXTLFw7IV0aE441yvzxZViRT/khSaT2eJ62vYze+lQMmrKk
         Nr5MO/GCk55ZZ3mz+BZhRXRUj9Y4sdYoyu3qcXl51K4RpdKbb55lf48zYNHP2gNEWoIe
         /m8aaIjHO47QsuZdxuXbpGGpdT4NBGUEQj7kkUSR3ufQigtnz7LbASNEhS2uQPMyFjxo
         D/T8vZIweJZRbNJ1xJZa+EhdOTSdgNPHGbea7srrT79jREs584Ab94eX9JpsBbP7tg+9
         y5NYMmLdzQiqKeWs1gVL49CnyLqOHyFkQVNRYcV7H1LygsFBclZrnrI+aeYJycis2E/6
         4UFw==
X-Forwarded-Encrypted: i=1; AJvYcCU6bSb+k3y9zHA8U/fpxq61ozqbpGSRIIV6K7SANgZizDuCvkc4bt7kaV9fI1w8HMr1rhnNfSHZx9GumzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjKvsMkMkyaAPupT5/LoOcGM7Tergj6t/bUh1WVNRGDZu7hXGf
	faiXpUBJ+S8cQRHzRK7u6Bdyyt5IJpDyTs8AST0YP7DjMOGvQbqn
X-Gm-Gg: ASbGncvVVMWCxTgO0QxVG0FmUFoPAjO2lkxr1IxB/d2i+46jHds5EgWMHmvHKtJOko4
	8qscZ3shMS/yfp0wWCd53H1k+h8x4HOzBRogMy+4nHyph8Yfw8gEOJ/2VliuFOavV4VHlPkLdyC
	pYIM0eOXHhsnF/8Ye3wvz7Ms1esAAGMlVnCgbfOOG7qSRgmoN2tpnsHSH8wiE3p86FkdMKC5lki
	7HVd8z0KeXF/5h5hHo4qhuO4UX0I7bMZD3QxdN83WH9FxJPxGE2lYQuR9JA95TGlKuBxbKGfU9/
	S2JZVgV/3/elVbRRPSd5jBE+K2jUuXNckVjppi85+sECI3Ge/VzptVPumrQsoXldzHY=
X-Google-Smtp-Source: AGHT+IGdwqkgJU4MRYllMptDMTLx9Cq7fV8Bn0/VLRCRyd2ghtgYLKpjvlKzjZW3cSM9dRF5TKWB+w==
X-Received: by 2002:a05:600c:4450:b0:439:916a:b3db with SMTP id 5b1f17b1804b1-439916ab5bdmr58879435e9.6.1739899437098;
        Tue, 18 Feb 2025 09:23:57 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439922141a5sm32958965e9.2.2025.02.18.09.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:23:56 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Alex Studer <alex@studer.dev>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Alex Studer <alex@studer.dev>
Subject:
 Re: [PATCH] riscv: dts: allwinner: d1: Add CPU thermal sensor and zone
Date: Tue, 18 Feb 2025 18:23:52 +0100
Message-ID: <4628970.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20250218020629.1476126-1-alex@studer.dev>
References: <20250218020629.1476126-1-alex@studer.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 18. februar 2025 ob 03:06:29 Srednjeevropski standardni =C4=8Das=
 je Alex Studer napisal(a):
> The sun20i THS (built in CPU thermal sensor) is supported in code, but
> was never added to the device tree. So, add it to the device tree,
> along with a thermal zone for the CPU.
>=20
> Signed-off-by: Alex Studer <alex@studer.dev>
> ---
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 31 +++++++++++++++++++
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 16 ++++++++++
>  2 files changed, 47 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/b=
oot/dts/allwinner/sun20i-d1s.dtsi
> index 6367112e6..bdde82aa8 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -3,6 +3,8 @@
> =20
>  #define SOC_PERIPHERAL_IRQ(nr)	(nr + 16)
> =20
> +#include <dt-bindings/thermal/thermal.h>

Put above line on top (before SOC_PERIPHERAL_IRQ()).

> +
>  #include "sunxi-d1s-t113.dtsi"
> =20
>  / {
> @@ -115,4 +117,33 @@ pmu {
>  			<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
>  			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
>  	};
> +
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive =3D <0>;
> +			polling-delay =3D <0>;
> +			thermal-sensors =3D <&ths>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu_alert>;
> +					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +
> +			trips {
> +				cpu_alert: cpu-alert {
> +					temperature =3D <85000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				cpu-crit {
> +					temperature =3D <100000>;
> +					hysteresis =3D <0>;
> +					type =3D "critical";
> +				};

Where do those limits come from?

> +			};
> +		};
> +	};
>  };
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/ris=
cv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index e4175adb0..fcfcaf06c 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -426,6 +426,10 @@ sid: efuse@3006000 {
>  			reg =3D <0x3006000 0x1000>;
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
> +
> +			ths_calibration: thermal-sensor-calibration@14 {
> +				reg =3D <0x14 0x8>;
> +			};
>  		};
> =20
>  		crypto: crypto@3040000 {
> @@ -934,5 +938,17 @@ rtc: rtc@7090000 {
>  			clock-names =3D "bus", "hosc", "ahb";
>  			#clock-cells =3D <1>;
>  		};
> +
> +		ths: thermal-sensor@2009400 {
> +			compatible =3D "allwinner,sun20i-d1-ths";
> +			reg =3D <0x2009400 0x100>;

Size should be 0x400.

Best regards,
Jernej

> +			interrupts =3D <SOC_PERIPHERAL_IRQ(58) IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_THS>;
> +			clock-names =3D "bus";
> +			resets =3D <&ccu RST_BUS_THS>;
> +			nvmem-cells =3D <&ths_calibration>;
> +			nvmem-cell-names =3D "calibration";
> +			#thermal-sensor-cells =3D <0>;
> +		};
>  	};
>  };
>=20





