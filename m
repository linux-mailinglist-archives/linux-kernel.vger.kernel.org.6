Return-Path: <linux-kernel+bounces-253739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B901693262A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1CA1C21DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209BD19A294;
	Tue, 16 Jul 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="a2He631p"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79D1990DE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131579; cv=none; b=arzuSQK7C/rI5y9W3E+iEO08t84PpUuYAWmuIpy5EDs2+daJbBjAZEbhHuW50R2nP03T2tAJ4tniTKUIWmdOKH2OzuHYJA8gteicscX1cu8yDr8y4wbgYPLyafK1GOkG7jeB+opCgehTjlB4/T2lnOg/sDKwnTbXKOTqfgXbWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131579; c=relaxed/simple;
	bh=n782T7h+02g1mc6ge/roaPDCLEZTPuQnrUqCVqCcf14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbUeo+7M8WLQ5gJywa4jTpm42LUqOQH/AL79Pt2N+Abi6rSwr1dsGax6Sij4ExERVOnRJP6xYwEZ7ZI7YKtmFO8gRFkpzTe3rvfqDIWKKl5K5zcCDZsuebnN259XgzH8LzVJWgRRzAO201N+HpHxgSKlRpoUWkfWtyIVFm8gBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=a2He631p; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so71038681fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721131574; x=1721736374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocsignr/nvawl0jQHFR0CEaSXqr4vVO85JAIikTyjZ0=;
        b=a2He631pcp4pzywKY9p4bTW4krrbal9MnkUpo/eF6/ExpggEkhaaItMvaAGhGltt6I
         0yKCHNSTiBc7sZ9ULoLeQDNV5o9Y5u7m3mjbDiO3gmJHbK7qdIPZqpLnJOO90JvHYpKZ
         HG7g7oTySKVm5PTbCmbW5ysfLNezyFnAdQVp8IEbETLj2mVF1CdPMFlA1ptdZ6/WyF/7
         MX67LPIgpGtSjOuNfKEqromEjpLZWT9HdUu2Ly6iC0RZgGOFYe+1bMxEkJBe5KIT+8L9
         GkkH8gvOReD1o4Y937F0FPtyz1WRPiUXuzADmBAy2IBlkfo6ayNvdEFPDmt+yfiv+NcY
         A1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721131574; x=1721736374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocsignr/nvawl0jQHFR0CEaSXqr4vVO85JAIikTyjZ0=;
        b=Tksn8FCIVETtaaEVCrCn8YtK3Z1rYi9m2ndTrZfe3Ax/rqDBZCRPKfM56n8V1Odj8T
         Dd92DEZIpZWFTS3Mpumz7TGNe8dFJ05hE/M/4zeMciHWAIN3emVf8FUSZNSpo4v6AXTa
         ugW7H5MRbqHzAhjF4V0hefyxIKWldA2gOg9AEW0bBOgCXtkAxd5pZsLhv06XOhmbs63q
         Hraw4gF8TtC64w12sMMrxP/1uCCt/ia/iP4qGoX8MUAfuUJXTRkOZ/c/qGLkdMocg0Jm
         Q7r9qAPxAIC6DXsDwBjgvpDyQeW9xgsINdf09XjEiqR0hQRG26CA47fCKkaD8Zn/hGLA
         GCHg==
X-Forwarded-Encrypted: i=1; AJvYcCUkNqfM5ZDXKhe0erOwrl4zFPP0uPggdlDZUAXaSVE6PZ+RHm95DROJMYCGg9Kfd8kGPga/fihdlDfrScG0B8D4F8CveEx0dxO7LEho
X-Gm-Message-State: AOJu0YzmnHHnhyJnN+jACND3kvQVi/xxWczC6A/KpsvCrVQOktV9qtyH
	pPcTy5ouTF51UkG7pLTHsveVXZVF7OQl2MrqsoSzujfOdJiycIP0Ys3wq5dGoRpgsVFdNq4BE0k
	1aVND2JKH0fpn2b8AepgtNFhFotT7iuRzpBqK8A==
X-Google-Smtp-Source: AGHT+IHQkWukYzzeysse6GyDGTpm4Go8NkOdv1U0kWFvPW5EmkgZO13EEqDl/YlMIiN+HSC7RTkOxGEwEX9VG6reBiA=
X-Received: by 2002:a05:6512:3d15:b0:52c:850b:cfc6 with SMTP id
 2adb3069b0e04-52edf01caf1mr1503628e87.38.1721131574187; Tue, 16 Jul 2024
 05:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716-topic-sm8x50-upstream-use-pmu-to-power-up-bt-v1-0-67b3755edf6a@linaro.org>
 <20240716-topic-sm8x50-upstream-use-pmu-to-power-up-bt-v1-2-67b3755edf6a@linaro.org>
In-Reply-To: <20240716-topic-sm8x50-upstream-use-pmu-to-power-up-bt-v1-2-67b3755edf6a@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Jul 2024 14:06:02 +0200
Message-ID: <CAMRc=McjheYOKzp7fjqk8HXWMza2EsZkerkXCBV6d=PFgVbEPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550-qrd: use the PMU to power up bluetooth
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 11:45=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Change the HW model in sm8550-qrd.dts to a one closer to reality - where
> the WLAN and Bluetooth modules of the WCN7850 are powered by the PMU
> inside the package.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dt=
s/qcom/sm8550-qrd.dts
> index 774bdfcffec3..6052dd922ec5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -219,13 +219,10 @@ wcn7850-pmu {
>                 compatible =3D "qcom,wcn7850-pmu";
>
>                 pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&wlan_en>, <&pmk8550_sleep_clk>;
> +               pinctrl-0 =3D <&wlan_en>, <&bt_default>, <&pmk8550_sleep_=
clk>;
>
>                 wlan-enable-gpios =3D <&tlmm 80 GPIO_ACTIVE_HIGH>;
> -               /*
> -                * TODO Add bt-enable-gpios once the Bluetooth driver is
> -                * converted to using the power sequencer.
> -                */
> +               bt-enable-gpios =3D <&tlmm 81 GPIO_ACTIVE_HIGH>;
>
>                 vdd-supply =3D <&vreg_s5g_0p85>;
>                 vddio-supply =3D <&vreg_l15b_1p8>;
> @@ -1175,20 +1172,15 @@ &uart14 {
>         bluetooth {
>                 compatible =3D "qcom,wcn7850-bt";
>
> -               vddio-supply =3D <&vreg_l15b_1p8>;
> -               vddaon-supply =3D <&vreg_s4e_0p95>;
> -               vdddig-supply =3D <&vreg_s4e_0p95>;
> -               vddrfa0p8-supply =3D <&vreg_s4e_0p95>;
> -               vddrfa1p2-supply =3D <&vreg_s4g_1p25>;
> -               vddrfa1p9-supply =3D <&vreg_s6g_1p86>;
> +               vddrfacmn-supply =3D <&vreg_pmu_rfa_cmn>;
> +               vddaon-supply =3D <&vreg_pmu_aon_0p59>;
> +               vddwlcx-supply =3D <&vreg_pmu_wlcx_0p8>;
> +               vddwlmx-supply =3D <&vreg_pmu_wlmx_0p85>;
> +               vddrfa0p8-supply =3D <&vreg_pmu_rfa_0p8>;
> +               vddrfa1p2-supply =3D <&vreg_pmu_rfa_1p2>;
> +               vddrfa1p8-supply =3D <&vreg_pmu_rfa_1p8>;
>
>                 max-speed =3D <3200000>;
> -
> -               enable-gpios =3D <&tlmm 81 GPIO_ACTIVE_HIGH>;
> -               swctrl-gpios =3D <&tlmm 82 GPIO_ACTIVE_HIGH>;
> -
> -               pinctrl-0 =3D <&bt_default>;
> -               pinctrl-names =3D "default";
>         };
>  };
>
>
> --
> 2.34.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

