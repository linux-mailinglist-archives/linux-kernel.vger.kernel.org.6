Return-Path: <linux-kernel+bounces-397747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A900E9BDFCC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06270B23F15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7C81D1724;
	Wed,  6 Nov 2024 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8J56eWG"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5CB1CF2AE;
	Wed,  6 Nov 2024 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879742; cv=none; b=jx8kiOGgGyDwtfhX6Gw2tIPE3cxRALF9O5SLAPAwPV8BNp4j8iEe4Rlk51AzZkrk3mORIngUgGp+qqiZJPy4L5hMlKNDGjOlRZSnB2S4YcfJbBM6Sx6NS68n1yMRGgVqnRDYt1gqh+0KLk3epelqQHhlDPDCpsgPHEELu4MXWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879742; c=relaxed/simple;
	bh=gjlS76/98Cni8neei4/F8MwTiistLFcbZLmXlKdzIZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMW1hjzwmLehkFRyU2mfQsZ3MIotygdlv6GbtyxJYqPa4kztIzvahkX1egLbRuMeacmnu+RTcBzhtzHmp2LyZvRRA1z4xxaUQUCNIVUNkhZn3aDmdMk3k5dWvpssy3AH9FOD9fqgTnj2KdTakJxCQ1K2w42NFc3y62SkCss4mqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8J56eWG; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1418058bbso449278585a.3;
        Tue, 05 Nov 2024 23:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730879739; x=1731484539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ3Y8x4A9Kv0VojRXE40fqCjR+Xz0wiILYeF1Q+j1Bk=;
        b=N8J56eWG7ORNoRaIcC+2KyIOndkce8ImAH3E7BM4i7UeOVOpU1fcpyEjIHdiMa0RKU
         6crztYIRUscTm8hnkAHMeQb1jvIhBk6Fgtq2/1qQsFoL4u0Kwza3r4yrvNgcgJkGfdFM
         amxtzxAnrv4rMCZGVDOwykYI2FvwLbcFaPncNzPvF4RzivnK4v3ky/ZSIR8zRY994HWM
         5kRaMSj/NPkZG6oRqqN6OgBvRQ+kqo0XShKxNikVjEY8AeZS9XoT6pds/CECYPBN0Gev
         8XRsJoMNKry6iE34Om5lKOaYUkWp9Lokc7fvC4esRX3SRdOsarqjDZyraNYiINCpxWFx
         Bv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730879739; x=1731484539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ3Y8x4A9Kv0VojRXE40fqCjR+Xz0wiILYeF1Q+j1Bk=;
        b=t9NcptM+RoKZJxsJSesfIimIoJiR99jKo593KY95d3EMsgDSwNoM9/uwa29x8mzaa5
         vyokoYX0mJElDmjzUc2cw6pLzJeBT/p4HA3R61n4P0z0sggssfFc3lYlgrayxtbt4+2p
         8MVzoZEZHwlNX7SS/svr/pwh4yIEgfDewCZd7X48J8q3oRHMsUysqSbcT1l9pH0sWh96
         WnB4nBeB3PMsOwoBmPZJAV86GX9ivQe9Z9l4Xbvo9Nnxm4qAwnXFfoSAlBVjifn5p8A6
         lkjC9+2uS4NEy7XMMCxro2ayEKT+2tCxgDbpe0BXaIXagIYH6hjGWMCxdfQLhWKc0xc5
         4n1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVR6ZZ+gb3qa5QTCzBFVecJpa4hWLUEg3//EtVyF3eWyi3mmPkPZf6clOXTdpI+k52T10KU2pocO/PIYQ+V@vger.kernel.org, AJvYcCVxqFeCD87zhHgMuHrP4UjlIMEn+dhLEV6Mv8OJ8wmCDlJObnX2Y4rIYWeyM4tefhX5U1x0FR27le6g@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8jLpUp9/iP5wEP27nDck25zwvmVpddhpPsQvrygtapHAQYZ2
	y/C6/+rGRF0OVo/DH0FyDaZpfYtFIZmyKTQfq/LqGZSdS2YZiy4E0Z5YedyuKm2bTNtwJhYuXvs
	T3n5xYjbkRDQgaaDmdxBffMVZWc4=
X-Google-Smtp-Source: AGHT+IFhJbaqJv3pBEr11USTxaLxjnqc8AtjiRuH9iIT4+AXTrfXWWty6WhGqpPLOlJvr+SCaUZfi6Qr61u5KxyZgZQ=
X-Received: by 2002:a05:620a:294d:b0:7af:c3e6:651 with SMTP id
 af79cd13be357-7b2fb9d0c40mr2615260085a.44.1730879738759; Tue, 05 Nov 2024
 23:55:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <806d5e2a07ae0c81d9907bbe8bec4e3e1138b392.1730838347.git.dsimic@manjaro.org>
In-Reply-To: <806d5e2a07ae0c81d9907bbe8bec4e3e1138b392.1730838347.git.dsimic@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 6 Nov 2024 11:55:28 +0400
Message-ID: <CABjd4Yyt6WiY5E5DbyjnboFvsTpp33dydkGMF7AwMB9m7bfX6A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add OPP voltage ranges to RK3399
 OP1 SoC dtsi
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragan,

On Wed, Nov 6, 2024 at 11:50=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Add support for voltage ranges to the CPU, GPU and DMC OPPs defined in th=
e
> SoC dtsi for Rockchip OP1, as a variant of the Rockchip RK3399.  This may=
 be
> useful if there are any OP1-based boards whose associated voltage regulat=
ors
> are unable to deliver the exact voltages; otherwise, it causes no functio=
nal
> changes to the resulting OPP voltages at runtime.
>
> These changes cannot cause stability issues or any kind of damage, becaus=
e
> it's perfectly safe to use the highest voltage from an OPP group for each=
 OPP
> in the same group.  The only possible negative effect of using higher vol=
tages
> is wasted energy in form of some additionally generated heat.
>
> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi | 52 ++++++++++----------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi b/arch/arm64/bo=
ot/dts/rockchip/rk3399-op1.dtsi
> index b24bff511513..aa79219471d3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
> @@ -12,125 +12,125 @@ cluster0_opp: opp-table-0 {
>
>                 opp00 {
>                         opp-hz =3D /bits/ 64 <408000000>;
> -                       opp-microvolt =3D <800000>;
> +                       opp-microvolt =3D <800000 800000 1150000>;
>                         clock-latency-ns =3D <40000>;
>                 };
>                 opp01 {
>                         opp-hz =3D /bits/ 64 <600000000>;
> -                       opp-microvolt =3D <825000>;
> +                       opp-microvolt =3D <825000 825000 1150000>;
>                 };
>                 opp02 {
>                         opp-hz =3D /bits/ 64 <816000000>;
> -                       opp-microvolt =3D <850000>;
> +                       opp-microvolt =3D <850000 850000 1150000>;
>                 };
>                 opp03 {
>                         opp-hz =3D /bits/ 64 <1008000000>;
> -                       opp-microvolt =3D <900000>;
> +                       opp-microvolt =3D <900000 900000 1150000>;
>                 };
>                 opp04 {
>                         opp-hz =3D /bits/ 64 <1200000000>;
> -                       opp-microvolt =3D <975000>;
> +                       opp-microvolt =3D <975000 975000 1150000>;
>                 };
>                 opp05 {
>                         opp-hz =3D /bits/ 64 <1416000000>;
> -                       opp-microvolt =3D <1100000>;
> +                       opp-microvolt =3D <1100000 1100000 1150000>;
>                 };
>                 opp06 {
>                         opp-hz =3D /bits/ 64 <1512000000>;
> -                       opp-microvolt =3D <1150000>;
> +                       opp-microvolt =3D <1150000 1150000 1150000>;
>                 };
>         };
>
>         cluster1_opp: opp-table-1 {
>                 compatible =3D "operating-points-v2";
>                 opp-shared;
>
>                 opp00 {
>                         opp-hz =3D /bits/ 64 <408000000>;
>                         opp-microvolt =3D <800000>;
> -                       clock-latency-ns =3D <40000>;
> +                       clock-latency-ns =3D <40000 40000 1250000>;

Did you mean to update opp-microvolt instead?

Speaking of which, this single opp having clock-latency-ns while none
of the others do (except the first one in cluster0) looks weird.

Best regards,
Alexey

