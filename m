Return-Path: <linux-kernel+bounces-307948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D14965564
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1601F241AA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F4213632B;
	Fri, 30 Aug 2024 02:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="FMo5kMCe"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3EF18035
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985968; cv=none; b=h2bIDr/k8/5jzWACP2Ht/1xuv5TA7s3I+9eXRri8ucL7/ZBu9JF4E9vtsOwbIr99WA5ZbctCvAz6HLu/dHuhikN/P+hL+nCNo37f3AAErkxvE8rq/d/fQpRqF7JVCSsVffovCI8LW0OfAwwZ0a1sUeEmavrkGq2kYVEiKkpu5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985968; c=relaxed/simple;
	bh=wtWkvGSjlXZXTYQKx6/38CslYo9+83dsq1V6yyUkNPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnjnLDd3z2tV9kYdHZJ4+ImfjxuG63fWMA6BrTDGB7NoeEay5IZg4iCEUgji7q/LETFuQS4a2PR7/vLYj7aWj02V8a1aSG9yByRDhMy/JaGYPQE0zL0CaLXMB71A4ec0ShbgxTd5zTnwcqBn4fANDEGDwJoagr9Xm3tOR0nKEYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=FMo5kMCe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c210e23651so1441163a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1724985962; x=1725590762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NLQbhC1282ULxsCaBihcnXu9jioILEFI4pw0BnUik0=;
        b=FMo5kMCe2wHvALEzR1tRQnMP3pT7lKmX26ULOP6oA6xolEBb8PvyBXBC+tAJiNpNnZ
         rM7XGbV8kJMeL1QBQMbLrfMMWTiLgzyRMJJgz6bSegEge9vptAMSnJMbLAkAMOVNs8d1
         SBhYyMZo8xOLWCJfhkKPzQHSbCBMyM2x2CNemeppo/RWXaZeXUnkcwmAbwk7Eq45yQib
         4/md9SCyKXoJgYKDtWqsXYEyuOv5JB+EbpugQbzxS101KpKLiCcFnkksjIGguNA51ipO
         hrdIp/A7pTE70+gUkGpsV6qFmEYdRbBJ6/bNvfoSi0rtnJYuit6L80H7fUxsdtAh869j
         7d0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724985962; x=1725590762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NLQbhC1282ULxsCaBihcnXu9jioILEFI4pw0BnUik0=;
        b=B7OuZ1Sy09oPWYUaMpudQrXE1TKSuIMLed+AyqXefChen8Wfu5JTIYmwRAlndkWbwg
         S7RCoOQ5umWKua7bmQ2qW0skcQRxxmjsVphF3FclUO6forWOG4i6vwhLWixfcBEvO9JZ
         gfnHwM/umRltk7lZsFSzOykPO431eL5LhnoiwA5QHmUXMwl2YH2XSpRXnJdBQ04OiaCk
         BHuPjYyjURnvOP0ER7XgEI/RhZjGnVtO78Htgqa+Hj2M9PZ6jO41fHrv7NZkb447rhx0
         DMaQ8bIWkorFgaX8Ng8f/eT+7cXndfLAKay82Lvorbx1nojf0Q1alDOjVCCbvRApK2ix
         ke+w==
X-Forwarded-Encrypted: i=1; AJvYcCVzxavz3Pb3n+zBMMBTLXAxMBV4uhJLoBd7pE/D+280qDBmgxLK1rs+5xVruQHFzfONwAiQCjY1mvfWosY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzub5tix2RPwfC9vbU4UOiBewdglhoOCC4uA3Yb5lkxq9iKuO3O
	zuLN2qlu7YaB66OQ7rJjXmplyx5/YLutycS7rn2e382KR/INBdQHvNieQmfoI8qzlgCNwBvtQed
	V4fiv0jqlwjTf6NrDtWlbj5Ttw1f4gOkoxLrBKw==
X-Google-Smtp-Source: AGHT+IGfVznspNbF11C2UWiJwxcg9xhRwrx6BhnGzJT7LtCnIoWZZZeWx2FrkQDENIrKQGJO62nbFjB2O+t212QmwtM=
X-Received: by 2002:a05:6402:4313:b0:5c0:ad94:1d3 with SMTP id
 4fb4d7f45d1cf-5c21eda3e88mr4451621a12.32.1724985961666; Thu, 29 Aug 2024
 19:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-dts-qcom-label-v2-0-5deaada3e6b2@linaro.org> <20240829-dts-qcom-label-v2-5-5deaada3e6b2@linaro.org>
In-Reply-To: <20240829-dts-qcom-label-v2-5-5deaada3e6b2@linaro.org>
From: Steev Klimaszewski <steev@kali.org>
Date: Thu, 29 Aug 2024 21:45:50 -0500
Message-ID: <CAKXuJqiT-6WXSV3aFeMqRp0K3Nr16OKQKX+gwypsnoiRxj-GfA@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] arm64: dts: qcom: sc8280xp: change labels to lower-case
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 7:41=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DTS coding style expects labels to be lowercase.  No functional impact.
> Verified with comparing decompiled DTB (dtx_diff and fdtdump+diff).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  16 +--
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 158 ++++++++++-----=
------
>  2 files changed, 87 insertions(+), 87 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b=
/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 6a28cab97189..83208b10f994 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -346,18 +346,18 @@ skin-temp-crit {
>                         cooling-maps {
>                                 map0 {
>                                         trip =3D <&skin_temp_alert0>;
> -                                       cooling-device =3D <&CPU4 THERMAL=
_NO_LIMIT THERMAL_NO_LIMIT>,
> -                                                        <&CPU5 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> -                                                        <&CPU6 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> -                                                        <&CPU7 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>;
> +                                       cooling-device =3D <&cpu4 THERMAL=
_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu5 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu6 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu7 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>;
>                                 };
>
>                                 map1 {
>                                         trip =3D <&skin_temp_alert1>;
> -                                       cooling-device =3D <&CPU4 THERMAL=
_NO_LIMIT THERMAL_NO_LIMIT>,
> -                                                        <&CPU5 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> -                                                        <&CPU6 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> -                                                        <&CPU7 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>;
> +                                       cooling-device =3D <&cpu4 THERMAL=
_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu5 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu6 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu7 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>;
>                                 };
>                         };
>                 };
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts=
/qcom/sc8280xp.dtsi
> index 80a57aa22839..2f2fb074d804 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -44,7 +44,7 @@ cpus {
>                 #address-cells =3D <2>;
>                 #size-cells =3D <0>;
>
> -               CPU0: cpu@0 {
> +               cpu0: cpu@0 {
>                         device_type =3D "cpu";
>                         compatible =3D "arm,cortex-a78c";
>                         reg =3D <0x0 0x0>;
> @@ -52,19 +52,19 @@ CPU0: cpu@0 {
>                         enable-method =3D "psci";
>                         capacity-dmips-mhz =3D <981>;
>                         dynamic-power-coefficient =3D <549>;
> -                       next-level-cache =3D <&L2_0>;
> -                       power-domains =3D <&CPU_PD0>;
> +                       next-level-cache =3D <&l2_0>;
> +                       power-domains =3D <&cpu_pd0>;
>                         power-domain-names =3D "psci";
>                         qcom,freq-domain =3D <&cpufreq_hw 0>;
>                         operating-points-v2 =3D <&cpu0_opp_table>;
>                         interconnects =3D <&epss_l3 MASTER_EPSS_L3_APPS &=
epss_l3 SLAVE_EPSS_L3_SHARED>;
>                         #cooling-cells =3D <2>;
> -                       L2_0: l2-cache {
> +                       l2_0: l2-cache {
>                                 compatible =3D "cache";
>                                 cache-level =3D <2>;
>                                 cache-unified;
> -                               next-level-cache =3D <&L3_0>;
> -                               L3_0: l3-cache {
> +                               next-level-cache =3D <&l3_0>;
> +                               l3_0: l3-cache {
>                                         compatible =3D "cache";
>                                         cache-level =3D <3>;
>                                         cache-unified;
> @@ -72,7 +72,7 @@ L3_0: l3-cache {
>                         };
>                 };
>
> -               CPU1: cpu@100 {
> +               cpu1: cpu@100 {
>                         device_type =3D "cpu";
>                         compatible =3D "arm,cortex-a78c";
>                         reg =3D <0x0 0x100>;
> @@ -80,22 +80,22 @@ CPU1: cpu@100 {
>                         enable-method =3D "psci";
>                         capacity-dmips-mhz =3D <981>;
>                         dynamic-power-coefficient =3D <549>;
> -                       next-level-cache =3D <&L2_100>;
> -                       power-domains =3D <&CPU_PD1>;
> +                       next-level-cache =3D <&l2_100>;
> +                       power-domains =3D <&cpu_pd1>;
>                         power-domain-names =3D "psci";
>                         qcom,freq-domain =3D <&cpufreq_hw 0>;
>                         operating-points-v2 =3D <&cpu0_opp_table>;
>                         interconnects =3D <&epss_l3 MASTER_EPSS_L3_APPS &=
epss_l3 SLAVE_EPSS_L3_SHARED>;
>                         #cooling-cells =3D <2>;
> -                       L2_100: l2-cache {
> +                       l2_100: l2-cache {
>                                 compatible =3D "cache";
>                                 cache-level =3D <2>;
>                                 cache-unified;
> -                               next-level-cache =3D <&L3_0>;
> +                               next-level-cache =3D <&l3_0>;
>                         };
>                 };
>
> -               CPU2: cpu@200 {
> +               cpu2: cpu@200 {
>                         device_type =3D "cpu";
>                         compatible =3D "arm,cortex-a78c";
>                         reg =3D <0x0 0x200>;
> @@ -103,22 +103,22 @@ CPU2: cpu@200 {
>                         enable-method =3D "psci";
>                         capacity-dmips-mhz =3D <981>;
>                         dynamic-power-coefficient =3D <549>;
> -                       next-level-cache =3D <&L2_200>;
> -                       power-domains =3D <&CPU_PD2>;
> +                       next-level-cache =3D <&l2_200>;
> +                       power-domains =3D <&cpu_pd2>;
>                         power-domain-names =3D "psci";
>                         qcom,freq-domain =3D <&cpufreq_hw 0>;
>                         operating-points-v2 =3D <&cpu0_opp_table>;
>                         interconnects =3D <&epss_l3 MASTER_EPSS_L3_APPS &=
epss_l3 SLAVE_EPSS_L3_SHARED>;
>                         #cooling-cells =3D <2>;
> -                       L2_200: l2-cache {
> +                       l2_200: l2-cache {
>                                 compatible =3D "cache";
>                                 cache-level =3D <2>;
>                                 cache-unified;
> -                               next-level-cache =3D <&L3_0>;
> +                               next-level-cache =3D <&l3_0>;
>                         };
>                 };
>
> -               CPU3: cpu@300 {
> +               cpu3: cpu@300 {
>                         device_type =3D "cpu";
>                         compatible =3D "arm,cortex-a78c";
>                         reg =3D <0x0 0x300>;
> @@ -126,22 +126,22 @@ CPU3: cpu@300 {
>                         enable-method =3D "psci";
>                         capacity-dmips-mhz =3D <981>;
>                         dynamic-power-coefficient =3D <549>;
> -                       next-level-cache =3D <&L2_300>;
> -                       power-domains =3D <&CPU_PD3>;
> +                       next-level-cache =3D <&l2_300>;
> +                       power-domains =3D <&cpu_pd3>;
>                         power-domain-names =3D "psci";
>                         qcom,freq-domain =3D <&cpufreq_hw 0>;
>                         operating-points-v2 =3D <&cpu0_opp_table>;
>                         interconnects =3D <&epss_l3 MASTER_EPSS_L3_APPS &=
epss_l3 SLAVE_EPSS_L3_SHARED>;
>                         #cooling-cells =3D <2>;
> -                       L2_300: l2-cache {
> +                       l2_300: l2-cache {
>                                 compatible =3D "cache";
>                                 cache-level =3D <2>;
>                                 cache-unified;
> -                               next-level-cache =3D <&L3_0>;
> +                               next-level-cache =3D <&l3_0>;
>                         };
>                 };
>
> -               CPU4: cpu@400 {
> +               cpu4: cpu@400 {
>                         device_type =3D "cpu";
>                         compatible =3D "arm,cortex-x1c";
>                         reg =3D <0x0 0x400>;
> @@ -149,22 +149,22 @@ CPU4: cpu@400 {
>                         enable-method =3D "psci";
>                         capacity-dmips-mhz =3D <1024>;
>                         dynamic-power-coefficient =3D <590>;
> -                       next-level-cache =3D <&L2_400>;
> -                       power-domains =3D <&CPU_PD4>;
> +                       next-level-cache =3D <&l2_400>;
> +                       power-domains =3D <&cpu_pd4>;
>                         power-domain-names =3D "psci";
>                         qcom,freq-domain =3D <&cpufreq_hw 1>;
>                         operating-points-v2 =3D <&cpu4_opp_table>;
>                         interconnects =3D <&epss_l3 MASTER_EPSS_L3_APPS &=
epss_l3 SLAVE_EPSS_L3_SHARED>;
>                         #cooling-cells =3D <2>;
> -                       L2_400: l2-cache {
> +                       l2_400: l2-cache {
>                                 compatible =3D "cache";
>                                 cache-level =3D <2>;
>                                 cache-unified;
> -                               next-level-cache =3D <&L3_0>;
> +                               next-level-cache =3D <&l3_0>;
>                         };
>                 };
>
> -               CPU5: cpu@500 {
> +               cpu5: cpu@500 {
>                         device_type =3D "cpu";
>                         compatible =3D "arm,cortex-x1c";
>                         reg =3D <0x0 0x500>;
> @@ -172,22 +172,22 @@ CPU5: cpu@500 {
>                         enable-method =3D "psci";
>                         capacity-dmips-mhz =3D <1024>;
>                         dynamic-power-coefficient =3D <590>;
> -                       next-level-cache =3D <&L2_500>;
> -                       power-domains =3D <&CPU_PD5>;
> +                       next-level-cache =3D <&l2_500>;
> +                       power-domains =3D <&cpu_pd5>;
>                         power-domain-names =3D "psci";
>                         qcom,freq-domain =3D <&cpufreq_hw 1>;
>                         operating-points-v2 =3D <&cpu4_opp_table>;
>                         interconnects =3D <&epss_l3 MASTER_EPSS_L3_APPS &=
epss_l3 SLAVE_EPSS_L3_SHARED>;
>                         #cooling-cells =3D <2>;
> -                       L2_500: l2-cache {
> +                       l2_500: l2-cache {
>                                 compatible =3D "cache";
>                                 cache-level =3D <2>;
>                                 cache-unified;
> -                               next-level-cache =3D <&L3_0>;
> +                               next-level-cache =3D <&l3_0>;
>                         };
>                 };
>
> -               CPU6: cpu@600 {
> +               cpu6: cpu@600 {
>                         device_type =3D "cpu";
>                         compatible =3D "arm,cortex-x1c";
>                         reg =3D <0x0 0x600>;
> @@ -195,22 +195,22 @@ CPU6: cpu@600 {
>                         enable-method =3D "psci";
>                         capacity-dmips-mhz =3D <1024>;
>                         dynamic-power-coefficient =3D <590>;
> -                       next-level-cache =3D <&L2_600>;
> -                       power-domains =3D <&CPU_PD6>;
> +                       next-level-cache =3D <&l2_600>;
> +                       power-domains =3D <&cpu_pd6>;
>                         power-domain-names =3D "psci";
>                         qcom,freq-domain =3D <&cpufreq_hw 1>;
>                         operating-points-v2 =3D <&cpu4_opp_table>;
>                         interconnects =3D <&epss_l3 MASTER_EPSS_L3_APPS &=
epss_l3 SLAVE_EPSS_L3_SHARED>;
>                         #cooling-cells =3D <2>;
> -                       L2_600: l2-cache {
> +                       l2_600: l2-cache {
>                                 compatible =3D "cache";
>                                 cache-level =3D <2>;
>                                 cache-unified;
> -                               next-level-cache =3D <&L3_0>;
> +                               next-level-cache =3D <&l3_0>;
>                         };
>                 };
>
> -               CPU7: cpu@700 {
> +               cpu7: cpu@700 {
>                         device_type =3D "cpu";
>                         compatible =3D "arm,cortex-x1c";
>                         reg =3D <0x0 0x700>;
> @@ -218,53 +218,53 @@ CPU7: cpu@700 {
>                         enable-method =3D "psci";
>                         capacity-dmips-mhz =3D <1024>;
>                         dynamic-power-coefficient =3D <590>;
> -                       next-level-cache =3D <&L2_700>;
> -                       power-domains =3D <&CPU_PD7>;
> +                       next-level-cache =3D <&l2_700>;
> +                       power-domains =3D <&cpu_pd7>;
>                         power-domain-names =3D "psci";
>                         qcom,freq-domain =3D <&cpufreq_hw 1>;
>                         operating-points-v2 =3D <&cpu4_opp_table>;
>                         interconnects =3D <&epss_l3 MASTER_EPSS_L3_APPS &=
epss_l3 SLAVE_EPSS_L3_SHARED>;
>                         #cooling-cells =3D <2>;
> -                       L2_700: l2-cache {
> +                       l2_700: l2-cache {
>                                 compatible =3D "cache";
>                                 cache-level =3D <2>;
>                                 cache-unified;
> -                               next-level-cache =3D <&L3_0>;
> +                               next-level-cache =3D <&l3_0>;
>                         };
>                 };
>
>                 cpu-map {
>                         cluster0 {
>                                 core0 {
> -                                       cpu =3D <&CPU0>;
> +                                       cpu =3D <&cpu0>;
>                                 };
>
>                                 core1 {
> -                                       cpu =3D <&CPU1>;
> +                                       cpu =3D <&cpu1>;
>                                 };
>
>                                 core2 {
> -                                       cpu =3D <&CPU2>;
> +                                       cpu =3D <&cpu2>;
>                                 };
>
>                                 core3 {
> -                                       cpu =3D <&CPU3>;
> +                                       cpu =3D <&cpu3>;
>                                 };
>
>                                 core4 {
> -                                       cpu =3D <&CPU4>;
> +                                       cpu =3D <&cpu4>;
>                                 };
>
>                                 core5 {
> -                                       cpu =3D <&CPU5>;
> +                                       cpu =3D <&cpu5>;
>                                 };
>
>                                 core6 {
> -                                       cpu =3D <&CPU6>;
> +                                       cpu =3D <&cpu6>;
>                                 };
>
>                                 core7 {
> -                                       cpu =3D <&CPU7>;
> +                                       cpu =3D <&cpu7>;
>                                 };
>                         };
>                 };
> @@ -272,7 +272,7 @@ core7 {
>                 idle-states {
>                         entry-method =3D "psci";
>
> -                       LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> +                       little_cpu_sleep_0: cpu-sleep-0-0 {
>                                 compatible =3D "arm,idle-state";
>                                 idle-state-name =3D "little-rail-power-co=
llapse";
>                                 arm,psci-suspend-param =3D <0x40000004>;
> @@ -282,7 +282,7 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
>                                 local-timer-stop;
>                         };
>
> -                       BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> +                       big_cpu_sleep_0: cpu-sleep-1-0 {
>                                 compatible =3D "arm,idle-state";
>                                 idle-state-name =3D "big-rail-power-colla=
pse";
>                                 arm,psci-suspend-param =3D <0x40000004>;
> @@ -294,7 +294,7 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
>                 };
>
>                 domain-idle-states {
> -                       CLUSTER_SLEEP_0: cluster-sleep-0 {
> +                       cluster_sleep_0: cluster-sleep-0 {
>                                 compatible =3D "domain-idle-state";
>                                 arm,psci-suspend-param =3D <0x4100c344>;
>                                 entry-latency-us =3D <3263>;
> @@ -593,57 +593,57 @@ psci {
>                 compatible =3D "arm,psci-1.0";
>                 method =3D "smc";
>
> -               CPU_PD0: power-domain-cpu0 {
> +               cpu_pd0: power-domain-cpu0 {
>                         #power-domain-cells =3D <0>;
> -                       power-domains =3D <&CLUSTER_PD>;
> -                       domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
> +                       power-domains =3D <&cluster_pd>;
> +                       domain-idle-states =3D <&little_cpu_sleep_0>;
>                 };
>
> -               CPU_PD1: power-domain-cpu1 {
> +               cpu_pd1: power-domain-cpu1 {
>                         #power-domain-cells =3D <0>;
> -                       power-domains =3D <&CLUSTER_PD>;
> -                       domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
> +                       power-domains =3D <&cluster_pd>;
> +                       domain-idle-states =3D <&little_cpu_sleep_0>;
>                 };
>
> -               CPU_PD2: power-domain-cpu2 {
> +               cpu_pd2: power-domain-cpu2 {
>                         #power-domain-cells =3D <0>;
> -                       power-domains =3D <&CLUSTER_PD>;
> -                       domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
> +                       power-domains =3D <&cluster_pd>;
> +                       domain-idle-states =3D <&little_cpu_sleep_0>;
>                 };
>
> -               CPU_PD3: power-domain-cpu3 {
> +               cpu_pd3: power-domain-cpu3 {
>                         #power-domain-cells =3D <0>;
> -                       power-domains =3D <&CLUSTER_PD>;
> -                       domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
> +                       power-domains =3D <&cluster_pd>;
> +                       domain-idle-states =3D <&little_cpu_sleep_0>;
>                 };
>
> -               CPU_PD4: power-domain-cpu4 {
> +               cpu_pd4: power-domain-cpu4 {
>                         #power-domain-cells =3D <0>;
> -                       power-domains =3D <&CLUSTER_PD>;
> -                       domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
> +                       power-domains =3D <&cluster_pd>;
> +                       domain-idle-states =3D <&big_cpu_sleep_0>;
>                 };
>
> -               CPU_PD5: power-domain-cpu5 {
> +               cpu_pd5: power-domain-cpu5 {
>                         #power-domain-cells =3D <0>;
> -                       power-domains =3D <&CLUSTER_PD>;
> -                       domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
> +                       power-domains =3D <&cluster_pd>;
> +                       domain-idle-states =3D <&big_cpu_sleep_0>;
>                 };
>
> -               CPU_PD6: power-domain-cpu6 {
> +               cpu_pd6: power-domain-cpu6 {
>                         #power-domain-cells =3D <0>;
> -                       power-domains =3D <&CLUSTER_PD>;
> -                       domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
> +                       power-domains =3D <&cluster_pd>;
> +                       domain-idle-states =3D <&big_cpu_sleep_0>;
>                 };
>
> -               CPU_PD7: power-domain-cpu7 {
> +               cpu_pd7: power-domain-cpu7 {
>                         #power-domain-cells =3D <0>;
> -                       power-domains =3D <&CLUSTER_PD>;
> -                       domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
> +                       power-domains =3D <&cluster_pd>;
> +                       domain-idle-states =3D <&big_cpu_sleep_0>;
>                 };
>
> -               CLUSTER_PD: power-domain-cpu-cluster0 {
> +               cluster_pd: power-domain-cpu-cluster0 {
>                         #power-domain-cells =3D <0>;
> -                       domain-idle-states =3D <&CLUSTER_SLEEP_0>;
> +                       domain-idle-states =3D <&cluster_sleep_0>;
>                 };
>         };
>
> @@ -5111,7 +5111,7 @@ apps_rsc: rsc@18200000 {
>                         qcom,tcs-config =3D <ACTIVE_TCS  2>, <SLEEP_TCS  =
 3>,
>                                           <WAKE_TCS    3>, <CONTROL_TCS 1=
>;
>                         label =3D "apps_rsc";
> -                       power-domains =3D <&CLUSTER_PD>;
> +                       power-domains =3D <&cluster_pd>;
>
>                         apps_bcm_voter: bcm-voter {
>                                 compatible =3D "qcom,bcm-voter";
>
> --
> 2.43.0
>
>
Tested on the Thinkpad X13s
Tested-by: Steev Klimaszewski <steev@kali.org>

