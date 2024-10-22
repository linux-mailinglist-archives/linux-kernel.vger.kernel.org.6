Return-Path: <linux-kernel+bounces-376341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3509B9AAE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563E01C2240A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F5319F116;
	Tue, 22 Oct 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAgOcPfJ"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868619E96A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604860; cv=none; b=osST1tY92IL3tC3gJqD1tDfXaPOvzrB6wEoO1ERnP0g1KMBp9Kqx5GlUFvEn1PkFXZat6U9rouF5ffrjm1RhuBRSUP6h1X7SdwxbSTfTXqcOgP1DINcv76OxXN5U9Fpd9pd7smDsetz2FllFkw404opOFhNsdWYOpZpMIXf9584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604860; c=relaxed/simple;
	bh=NW6X1KgAEwkWwuoMcNCBxlfIFw1BZ+v6/Dg37czJJS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLAUCPZoT68UX+PFaTLkMjHGCnyDb4lbQMj6fWJleTfY2AQvhb7u9eya5pcMD/ttrcDjEXCdOcpQeGecR7BIfnIEwpoc+kZDZpj+TF01Gm6c+e7rb1sdYHW0CkP8XM+2wyxXJLj2k0xXrvukIbK1EH6crHYVwC8du1qTYm0hvso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FAgOcPfJ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e29047bec8fso5124397276.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729604857; x=1730209657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2VDJdcsPo1rknoaxJbITWrtiiYpwrip82kNdr/uTJTo=;
        b=FAgOcPfJFsrIU9MbZe51gPnKGgZ/REl8KQoya1ptsiu98v69m+6340RmwcV8ArY1qz
         aS197HT3AUmcsb/uEL1zoJH8nddy1DKyt+cAB4LBAd7pSP0Anr6IQ21D08TCgug6hbuU
         y76yh3JB+0NWjpEOQooMYh1Y9sXV5jlnlC6M+wu+tjwzb0uw/PUm10SzippPGjZLLDOt
         5zqFJpinUMJxLSQN4KHvIVzS8BxsBxZxzsrhSjRjtiz+TkZ1jDA4q2/U8ixn1SztqvNa
         lpH4JZ9vlSkkS11XkYXCsgikhkHUO2yK9vcgpkXblm0rjWMjQF75ThicalERmziG0VWZ
         6Mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729604857; x=1730209657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VDJdcsPo1rknoaxJbITWrtiiYpwrip82kNdr/uTJTo=;
        b=Q1LgVvnyrjYHKk8r1i3r3Bl3OBXQ4P3XBQkCpjSEA3ouI1K7/rt6vp70Z42mWTe4U5
         oegU/cFX6szJBWduHIo90fRpOSd5+aDEt1bPjJb7R8+//WF7ni+giDTsEAmi+XVFOmMn
         gkfL3llhEU4k1OhXduA7qtCW3PQkCwF/8qnRXUJdg8Wfd8wTJt7pK184BPtTOjxBTPQc
         b7MnaifvIJV2ZEV3ETeJWDAYighFRMJ7oFkTtFkUqrIDUpCXLSbGqawz0WMuO8JuxfJa
         hlDTbFtkVAXNfYhWng5QjNxt2+9qfKkuGKxyID4gYu2kvkmYXRBaMmaLAQyJKwBpoOl7
         EDqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5fw1Iv76a3RzvAMfSRV1v3vcOY7KuoYMVIR03TmYRJPOmyZTBtoPGqkIhJ2IaY94Rq9EzwsYqYX6hzh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVt+0pPEJpQtlGcXaan41lwyl5UaRAnuKZRN3GPQfYmY7Fg4T
	Qo+OsdtHo0itZrz49DcaSZaDLwgQ8hkGeIFSteCHWMBs+qgvNaMcNBAdjEiE5d7koAWZKeaPJYh
	ceznZzheGz8dpXa2/TUnNjUZnhgH7cN5YtOQjBA==
X-Google-Smtp-Source: AGHT+IFEGzCehqhHrE96BokN6D5KEiwIgmb1dMkGmj2/r3pX5GHg8telpnC2cM3FNqew3gkL/pGsvsFYhSmexAiNsDk=
X-Received: by 2002:a05:690c:4442:b0:6db:d02f:b2c4 with SMTP id
 00721157ae682-6e7d456b19bmr28659157b3.7.1729604857324; Tue, 22 Oct 2024
 06:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010105107.30118-1-quic_janathot@quicinc.com>
 <jywgmxfhzwvoknpar7hr4ekfnajauzgk5q3bewgpdv2ghpemtw@4vvhit4jb3tm> <bc72b450-4cd8-4cd4-b160-36fb6031d035@quicinc.com>
In-Reply-To: <bc72b450-4cd8-4cd4-b160-36fb6031d035@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 22 Oct 2024 16:47:25 +0300
Message-ID: <CAA8EJpq=3iK9S99j_ez7F-G1X+e9PdEyn6vGZmxKjEpnEs_W4g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: qcs6490-rb3gen2: enable Bluetooth
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 13:06, Janaki Ramaiah Thota
<quic_janathot@quicinc.com> wrote:
>
>
>
> On 10/10/2024 6:09 PM, Dmitry Baryshkov wrote:
> > On Thu, Oct 10, 2024 at 04:21:07PM GMT, Janaki Ramaiah Thota wrote:
> >> Add Bluetooth and UART7 support for qcs6490-rb3gen2.
> >>
> >> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 122 ++++++++++++++++++-
> >>   1 file changed, 121 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> >> index 0d45662b8028..c0bc44be7dd4 100644
> >> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> >> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> >> @@ -1,6 +1,6 @@
> >>   // SPDX-License-Identifier: BSD-3-Clause
> >>   /*
> >> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> >> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> >>    */
> >>
> >>   /dts-v1/;
> >> @@ -32,6 +32,8 @@
> >>
> >>      aliases {
> >>              serial0 = &uart5;
> >> +            bluetooth0 = &bluetooth;
> >> +            serial1 = &uart7;
> >>      };
> >>
> >>      chosen {
> >> @@ -688,6 +690,39 @@
> >>      status = "okay";
> >>   };
> >>
> >
> > Please review the file carefully and find the right spot for these
> > parts.
> >
>
> Thanks for the review, corrected in [PATCH v3].
>
> >> +&qup_uart7_cts {
> >> +    /*
> >> +     * Configure a bias-bus-hold on CTS to lower power
> >> +     * usage when Bluetooth is turned off. Bus hold will
> >> +     * maintain a low power state regardless of whether
> >> +     * the Bluetooth module drives the pin in either
> >> +     * direction or leaves the pin fully unpowered.
> >> +     */
> >> +    bias-bus-hold;
> >> +};
> >> +
> >> +&qup_uart7_rts {
> >> +    /* We'll drive RTS, so no pull */
> >> +    drive-strength = <2>;
> >> +    bias-disable;
> >> +};
> >> +
> >> +&qup_uart7_rx {
> >> +    /*
> >> +     * Configure a pull-up on RX. This is needed to avoid
> >> +     * garbage data when the TX pin of the Bluetooth module is
> >> +     * in tri-state (module powered off or not driving the
> >> +     * signal yet).
> >> +     */
> >> +    bias-pull-up;
> >> +};
> >> +
> >> +&qup_uart7_tx {
> >> +    /* We'll drive TX, so no pull */
> >> +    drive-strength = <2>;
> >> +    bias-disable;
> >> +};
> >> +
> >>   &qupv3_id_0 {
> >>      status = "okay";
> >>   };
> >> @@ -719,12 +754,97 @@
> >>   &tlmm {
> >>      gpio-reserved-ranges = <32 2>, /* ADSP */
> >>                             <48 4>; /* NFC */
> >> +    bt_en: bt-en-state {
> >> +            pins = "gpio85";
> >> +            function = "gpio";
> >> +            output-low;
> >> +            bias-disable;
> >> +    };
> >> +
> >> +    qup_uart7_sleep_cts: qup-uart7-sleep-cts-state {
> >> +            pins = "gpio28";
> >> +            function = "gpio";
> >> +            /*
> >> +             * Configure a bias-bus-hold on CTS to lower power
> >> +             * usage when Bluetooth is turned off. Bus hold will
> >> +             * maintain a low power state regardless of whether
> >> +             * the Bluetooth module drives the pin in either
> >> +             * direction or leaves the pin fully unpowered.
> >> +             */
> >> +            bias-bus-hold;
> >> +    };
> >> +
> >> +    qup_uart7_sleep_rts: qup-uart7-sleep-rts-state {
> >> +            pins = "gpio29";
> >> +            function = "gpio";
> >> +            /*
> >> +             * Configure pull-down on RTS. As RTS is active low
> >> +             * signal, pull it low to indicate the BT SoC that it
> >> +             * can wakeup the system anytime from suspend state by
> >> +             * pulling RX low (by sending wakeup bytes).
> >> +             */
> >> +            bias-pull-down;
> >> +    };
> >> +
> >> +    qup_uart7_sleep_rx: qup-uart7-sleep-rx-state {
> >> +            pins = "gpio31";
> >> +            function = "gpio";
> >> +            /*
> >> +             * Configure a pull-up on RX. This is needed to avoid
> >> +             * garbage data when the TX pin of the Bluetooth module
> >> +             * is floating which may cause spurious wakeups.
> >> +             */
> >> +            bias-pull-up;
> >> +    };
> >> +
> >> +    qup_uart7_sleep_tx: qup-uart7-sleep-tx-state {
> >> +            pins = "gpio30";
> >> +            function = "gpio";
> >> +            /*
> >> +             * Configure pull-up on TX when it isn't actively driven
> >> +             * to prevent BT SoC from receiving garbage during sleep.
> >> +             */
> >> +            bias-pull-up;
> >> +    };
> >> +
> >> +    sw_ctrl: sw-ctrl-state {
> >> +            pins = "gpio86";
> >> +            function = "gpio";
> >> +            bias-pull-down;
> >> +    };
> >>   };
> >>
> >>   &uart5 {
> >>      status = "okay";
> >>   };
> >>
> >> +&uart7 {
> >> +    status = "okay";
> >> +    /delete-property/interrupts;
> >> +    interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
> >> +                            <&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
> >
> > Why? Is it a UART interrupt? Or a BT-related interrupt?
> >
>
> it is HS UART interrupt for BT.

I don't see it being handled by the UART driver. It if is a BT
interrupt, it should go to the BT node.

>
> >> +    pinctrl-names = "default", "sleep";
> >> +    pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>,
> >> +                    <&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;
> >> +
> >> +    bluetooth: bluetooth {
> >> +            compatible = "qcom,wcn6750-bt";
> >
> > Please use pwrseq and define the PMU unit.
> >
>
> we are in process of migrating to pwrseq, mean while can we merge this
> change ?

No, why? Please implement the recommended way to handle the hardware, pwrseq.

>
> >> +            pinctrl-names = "default";
> >> +            pinctrl-0 = <&bt_en>, <&sw_ctrl>;
> >> +            enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
> >> +            swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
> >> +            vddaon-supply = <&vreg_s7b_0p972>;
> >> +            vddbtcxmx-supply = <&vreg_s7b_0p972>;
> >> +            vddrfacmn-supply = <&vreg_s7b_0p972>;
> >> +            vddrfa0p8-supply = <&vreg_s7b_0p972>;
> >> +            vddrfa1p7-supply = <&vreg_s1b_1p872>;
> >> +            vddrfa1p2-supply = <&vreg_s8b_1p272>;
> >> +            vddrfa2p2-supply = <&vreg_s1c_2p19>;
> >> +            vddasd-supply = <&vreg_l11c_2p8>;
> >> +            max-speed = <3200000>;
> >> +    };
> >> +};
> >> +
> >>   &usb_1 {
> >>      status = "okay";
> >>   };
> >> --
> >> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> >> a Linux Foundation Collaborative Project
> >>
> >
>
> --
> Thanks
> Janakiram
>


-- 
With best wishes
Dmitry

