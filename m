Return-Path: <linux-kernel+bounces-256390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D02B934D90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F841C22316
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D63213C9CF;
	Thu, 18 Jul 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kiO1KRkE"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC5D13C699
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307460; cv=none; b=oTM5w+6TkjSsdcwvhhkkbiJODCfDfKCn4phxYHXmjjeh9hu23liHEZqLmBrU7a7Hafgf6yaKfj2UJQPga0OpnXg3uI6cC8G3FgDUJzyYe3rYSrphnqo4IT/xN2l/UCZfkHm1Nvww9YP9OKzBDLD1icCs0CQ+rjYVeYovZrPk6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307460; c=relaxed/simple;
	bh=6t33ExFXMVqeGGgCcowq/z2Ijk+S8jKWguFiKLwxv5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpVjczQ4wjX+XD1Xh7x7wMCmRFBBqES29iV15iTPvUmH0eX5fzG/BQ52gCMziH5U35IZlPRamtGShHD71Sguhlr4bGyvNp7AFzxwLywR1TTcdpMDgULzDiZ4xvCfh9vsQT1l9y3PsGnK5u84v4kRxEyQTUn1kQM0Q7J5ZgVuOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kiO1KRkE; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48fde151f25so265325137.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721307458; x=1721912258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVInjStjvITEQ5VnpuqHo8nXnIumN5+C3sE443bU/vk=;
        b=kiO1KRkEYBJuFPangZqYcEgBuxHChwnPks6T9DCs3EISZWy3O+ndZvHEtNpcx0gBKK
         EP0HKEWtTLKildmILDD9bt9ioOn1AqmIImAzxRmEPgwt3avKiaM293Nr/XeBA0x/8RHy
         jJ7k5Z28GQPZMNskRg+tghM72lDivuvIUKlblrdVCYuKn8jjAVWZgWPSrOs4sQ4jnR/3
         Mt3eY5fN/XZSvGnbzAThs4gEP9T+MJE6vfFmc+D+DobeG9cHLKITmw6ckWvsBdaEVY79
         1mAVLWonBEj2mx7waQGgp3l32zw3t9V/M9gLD9+6Wz7ez5pAhzUX87ySxobzFRDsECRf
         Q8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721307458; x=1721912258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVInjStjvITEQ5VnpuqHo8nXnIumN5+C3sE443bU/vk=;
        b=CLe3z23G8RR8mD1ZfWnhSBdLY6iG7FgCG4hVP7Ir7TU/qubKwFiqa9DqgTytnawi1a
         krrjHP3abcXOM5KdGgo+Cbyy+w8rNU4kqDD02NUt2TYIm75K4J2P2Tl1FIuqU6FDZDCQ
         dogJWNDmpTaeD+ZHt7VK/3SlEHdiy2KtovZ1BG+wKQ5LRclAwV6l7PAN2kSxy8ZJ+8YZ
         eJ+uMpkXsTigF8YpG4lc+K2uoR9omhDfcSp4jnNTUv4WnDsElPtx613gkkSRau0BYOOi
         ekFDiSXE9MsoZZcyIvM0xRdITED6iQqvDk8UtstDl5EmjV1DbLPXhVYwWphfFGQEeVXf
         wrsw==
X-Forwarded-Encrypted: i=1; AJvYcCUQZAlkU8mBqYxbIEqGu86hGbsdM76xsSC0KYy89kBTyYWSSoRtQvx0aWS9h80V6ChS3jvURPYTTsjhqIaGQpTZk8+C0NMwjSfQPnQK
X-Gm-Message-State: AOJu0YzNC/qXJBZyuvos4Hg3WUzEzwZC3xuCcERcuVN240ZlvgrW0HHo
	lkhPDfObDPGkRaEn7111hMFjNpzywoeAdrA2xuJvQpROYypn7/eRrigBoq1QfGermoDFT5X+Yxj
	C7Tu9wm+KQqmiSia95ES8R/oMnQSer6UOqLSIkw==
X-Google-Smtp-Source: AGHT+IE646b9knV3NyerMzOxtymWvWfzL4uzox56mIVkmCycSdvNmnfz7nxmOgZQS2I/2F0Z0lVpvWR4zo+8YyHHc+s=
X-Received: by 2002:a05:6102:571a:b0:48f:a83f:7d10 with SMTP id
 ada2fe7eead31-49159883121mr5585168137.10.1721307457682; Thu, 18 Jul 2024
 05:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702091655.278974-1-amit.pundir@linaro.org> <d3416be5-b97f-4db6-a779-9c436e41dd72@linaro.org>
In-Reply-To: <d3416be5-b97f-4db6-a779-9c436e41dd72@linaro.org>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Thu, 18 Jul 2024 18:27:00 +0530
Message-ID: <CAMi1Hd1Tinhd-dXS3dXjvSWqe6rNZgPJF+3kZOXQj03LkuMPcA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8550-hdk: add the Wifi node
To: neil.armstrong@linaro.org
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, dt <devicetree@vger.kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 15:10, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 02/07/2024 11:16, Amit Pundir wrote:
> > Describe the ath12k WLAN on-board the WCN7850 module present on the
> > board.
> >
> > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > ---
> > Kanged verbatim from 490812872449 ("arm64: dts: qcom: sm8550-qrd: add the Wifi node").
> >
> >   arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 97 +++++++++++++++++++++++++
> >   1 file changed, 97 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> > index 12d60a0ee095..c453d081a2df 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> > @@ -279,6 +279,68 @@ platform {
> >                       };
> >               };
> >       };
> > +
> > +     wcn7850-pmu {
> > +             compatible = "qcom,wcn7850-pmu";
> > +
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&wlan_en>, <&pmk8550_sleep_clk>;
> > +
> > +             wlan-enable-gpios = <&tlmm 80 GPIO_ACTIVE_HIGH>;
> > +             /*
> > +              * TODO Add bt-enable-gpios once the Bluetooth driver is
> > +              * converted to using the power sequencer.
> > +              */
>
> <snip>
>
> Now [1] driver & bindings changes were merged, could you resend with the following squashed:

Done. Thank you very much Neil.

>
> [1] https://lore.kernel.org/all/20240709-hci_qca_refactor-v3-0-5f48ca001fed@linaro.org/
>
> ====><=====================================
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> index 0fa0b79de741..01c921602605 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> @@ -284,13 +284,10 @@ wcn7850-pmu {
>                 compatible = "qcom,wcn7850-pmu";
>
>                 pinctrl-names = "default";
> -               pinctrl-0 = <&wlan_en>, <&pmk8550_sleep_clk>;
> +               pinctrl-0 = <&wlan_en>, <&bt_default>, <&pmk8550_sleep_clk>;
>
>                 wlan-enable-gpios = <&tlmm 80 GPIO_ACTIVE_HIGH>;
> -               /*
> -                * TODO Add bt-enable-gpios once the Bluetooth driver is
> -                * converted to using the power sequencer.
> -                */
> +               bt-enable-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
>
>                 vdd-supply = <&vreg_s5g_0p85>;
>                 vddio-supply = <&vreg_l15b_1p8>;
> @@ -1312,20 +1309,15 @@ &uart14 {
>         bluetooth {
>                 compatible = "qcom,wcn7850-bt";
>
> -               vddio-supply = <&vreg_l15b_1p8>;
> -               vddaon-supply = <&vreg_s4e_0p95>;
> -               vdddig-supply = <&vreg_s4e_0p95>;
> -               vddrfa0p8-supply = <&vreg_s4e_0p95>;
> -               vddrfa1p2-supply = <&vreg_s4g_1p25>;
> -               vddrfa1p9-supply = <&vreg_s6g_1p86>;
> +               vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> +               vddaon-supply = <&vreg_pmu_aon_0p59>;
> +               vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> +               vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> +               vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> +               vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> +               vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
>
>                 max-speed = <3200000>;
> -
> -               enable-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
> -               swctrl-gpios = <&tlmm 82 GPIO_ACTIVE_HIGH>;
> -
> -               pinctrl-0 = <&bt_default>;
> -               pinctrl-names = "default";
>         };
>   };
> ====><=====================================
>
> Thanks,
> Neil

