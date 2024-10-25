Return-Path: <linux-kernel+bounces-381026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8489AF944
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33461C21C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904A176AAD;
	Fri, 25 Oct 2024 05:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCXmVn1V"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99071433CE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729835278; cv=none; b=Lk8/QeVEyVf3ghbyAN1/+MXlABcwAspCRh4Bvh1bFoi+pPO/VYwU40DUXLEc1H1votuVXJlLJrkgjZ5k42tK/R3YnGJ34wdocg8HqLGqJB2hxotmoqhDBc7DhUmqDa+30rs6WB5EM/BmTIdNL0gbKzJPPr7dOQ/ozUSprBruNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729835278; c=relaxed/simple;
	bh=lJQ1WHYAhrL5HBnnhuX25B0c94sVYGFWR3u2dwp9rvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPc2AhAO/3oycI8lsQ4ZrRgKaz+KffJy+Is7xDTBjtOj0Quk0iPznOAUyskV7bl6PzLESoxmaBxHfWli49yWheJP6vDNWWiX0inUuY78rrxtXXd1VB3et5ojAMFufpJh4N/MsbYk5xTCSFbsqU12c3SCGnM94DEXZSdAm1ZkW+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WCXmVn1V; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e2f4c1f79bso14980567b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729835275; x=1730440075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wl6YifJ4SUzVbUe53cxHW8w6WiKuaOl79ml6CEbwbHk=;
        b=WCXmVn1V6LDBOy0FjWJDrLOgXO6Cfp3dLQmdH720ntZ8+oEFLjSYDsEQREcdF8cWJq
         ChxZrdYSaiizmyS0FsqICO+kGE3OB9OkHFmVrPkSQOPLmrIaFvoLp+gRrQAPQSxeMoDt
         GEkCLjlYCihqcrpRbL2z8RtxUMyVJx9D1xuUb4aGgXhVWitz0stSHI27c7Gc1OHh1tiV
         gLBhhHruprsE4dUnk7cSsG8m9kDdmJC8vDirShq2jZTTyRKdmOA9UWLE6EodYz1ujBzC
         u7KxdYPX8aQJV7ki+6xFuZStDn3kWzF5Z2jrcIIi10ytjG0IGOQJ865SKdeurF9g8Rx9
         pNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729835275; x=1730440075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wl6YifJ4SUzVbUe53cxHW8w6WiKuaOl79ml6CEbwbHk=;
        b=TLTJa+J96ZryjK+NBYHA5YLPdxOMkglsduo1+Dtk6FVNqAV31LJQeaBzVGpzBttd1Q
         tnT4filPy/jyWutSSPkD3xv+XY9BlivWnkUclnOXHQRD98WojekhfKBlWzwIwzXkalyG
         b4tShbmT5cesBX01XyxwMu8YoAUz6Wc4LtEJ/wUAEaB8kH4bONCbiBDMyD+W0Js0goLI
         9EN897850zudmp1Ht2q8pJOwR+29HAXWmLXQfl3aEYZXvxtl7LUog6QMF+nCQCysU9fB
         TtN/eIvvuM8kJI6GsW5wPkYNyl3Y5B57Fk8Z9zYmaFDhDK7GZ6MKu1597dXafeAbptuL
         oYag==
X-Forwarded-Encrypted: i=1; AJvYcCWdFoDMSOMM2b88/4WLQP/ZMc01Euik9jMeMsYjWABqP53IZQpAdBmr3G8J/c6sCtooMRBk+6/zKFkDLvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygCOJ+fw9Jg9XCWzHvNrJmuI+Av8hup4t5ExXB81hgXhALJlV2
	S8xe8or5DZDHfS+dUd8m5z0mHWwYVkLROCD5WlVW/9g4bCLyzijH2SucDut6p21P+mHDzOG6KlS
	ScgGcIniPQKEmdOZZ1pdxrJ6YxphzYZK64IUTqg==
X-Google-Smtp-Source: AGHT+IEsaI/6tz7DT/S4WkGZIbdt80SDqgonFiXQSxZEpVOm4o7NhIft5y8tZp6wPwiJGnccrS/yDyoo/AojGneZeGY=
X-Received: by 2002:a05:690c:650c:b0:6e5:adb6:5d8 with SMTP id
 00721157ae682-6e7f0fd6c9emr103635937b3.44.1729835275503; Thu, 24 Oct 2024
 22:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-adds-spmi-pmic-peripherals-for-qcs615-v2-1-f262ba243b63@quicinc.com>
 <ddonr55gfcmaj74ciowd23y2qtq3l6yj7g6hp63xoojvkgepwr@czigbkgexbpj> <17a7079b-f05a-4272-b4c4-780a02d455fe@quicinc.com>
In-Reply-To: <17a7079b-f05a-4272-b4c4-780a02d455fe@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Oct 2024 08:47:44 +0300
Message-ID: <CAA8EJppOxbT+rY35yvYao0r5ezLkNAOtQu6wY8xPAJ5d0eKjvg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: qcs615: Adds SPMI bus, PMIC and peripherals
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, kernel@quicinc.com, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 06:03, Tingguo Cheng <quic_tingguoc@quicinc.com> wrote:
>
>
>
> On 10/24/2024 10:11 PM, Dmitry Baryshkov wrote:
> > On Thu, Oct 24, 2024 at 04:09:48PM +0800, Tingguo Cheng wrote:
> >> Add SPMI bus arbiter and include pm8150.dtsi for PMIC peripherals in
> >> pmm6155au which is a variant of pm8150. The power key and volume do-
> >> wn key are controlled by PMIC PON hardware on pmm6155au.
> >>
> >> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> >> ---
> >> This patch depends on the patch series:
> >> - https://lore.kernel.org/all/20241022-add_initial_support_for_qcs615-v4-0-0a551c6dd342@quicinc.com/
> >> ---
> >> Changes in v2:
> >> - Include "pm8150.dtsi" for QCS615 PMIC instead of creating a new
> >>    qcs615-pmic.dtsi in the case that pmm6155au is a variant of pm8150.
> >> - Fixed comments from community in V1.
> >> - Link to v1: https://lore.kernel.org/r/20241014-adds-spmi-pmic-peripherals-for-qcs615-v1-1-8a3c67d894d8@quicinc.com
> >> ---
> >>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 27 +++++++++++++++++++++++++++
> >>   arch/arm64/boot/dts/qcom/qcs615.dtsi     | 23 +++++++++++++++++++++++
> >>   2 files changed, 50 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> >> index ee6cab3924a6d71f29934a8debba3a832882abdd..71ea0cb32eebed713b2a80ab692b14fdb4bd0ce4 100644
> >> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> >> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> >> @@ -6,6 +6,7 @@
> >>
> >>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >>   #include "qcs615.dtsi"
> >> +#include "pm8150.dtsi"
> >>   / {
> >>      model = "Qualcomm Technologies, Inc. QCS615 Ride";
> >>      compatible = "qcom,qcs615-ride", "qcom,qcs615";
> >> @@ -210,6 +211,32 @@ &rpmhcc {
> >>      clocks = <&xo_board_clk>;
> >>   };
> >>
> >> +&spmi_bus {
> >> +    pmm6155au_0: pmic@0 {
> >
> > There is a label already, please use it.
> Okay, then pm8150.
> >
> >> +
> >> +            pon: pon@800 {
> >
> > No, use the label syntax instead of extending the node in-tree.
> Okay, I will use &lable instead.
> >
> >> +
> >> +                    /delete-property/ mode-bootloader;
> >> +                    /delete-property/ mode-recovery;
> >> +
> >> +                    pon_pwrkey: pwrkey {
> >> +                            status = "okay";
> >> +                    };
> >> +
> >> +                    pon_resin: resin {
> >> +                            linux,code = <KEY_VOLUMEDOWN>;
> >> +                            status = "okay";
> >> +                    };
> >> +            };
> >> +
> >> +            pmm6155au_0_gpios: gpio@c000 {};
> >
> > What for?
> Because the silk screen is pmm6155au, I'm thinking using this phandle
> name could be more accurate.

Could you please post /sys/kernel/debug/qcom_socinfo/pmic_* contents?

> >
> >> +    };
> >> +
> >> +    pmm6155au_1: pmic@1 {
> >> +            status = "disabled";
> >
> > Why?
> qcs615-ride board only contains 1 PMIC on the board, this is the board
> settings.

PM8150 takes two USIDs, so this is not for the second PMIC, this is
for a part of the same PMIC.

> >
> >> +    };
> >> +};
> >> +
> >>   &uart0 {
> >>      status = "okay";
> >>   };
> >> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> >> index ac4c4c751da1fbb28865877555ba317677bc6bd2..3fc928913239cfc61c24d1b16c183b96f38e589d 100644
> >> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> >
> > Don't mix SoC and board changes into a single patch, unless they are
> > really touching the same function. In this case they are not.
> Okay, will split into two patches.
> >
> >> @@ -517,6 +517,29 @@ sram@c3f0000 {
> >>                      reg = <0x0 0x0c3f0000 0x0 0x400>;
> >>              };
> >>
> >> +            spmi_bus: spmi@c440000 {
> >> +                    compatible = "qcom,spmi-pmic-arb";
> >> +                    reg = <0x0 0x0c440000 0x0 0x1100>,
> >> +                          <0x0 0x0c600000 0x0 0x2000000>,
> >> +                          <0x0 0x0e600000 0x0 0x100000>,
> >> +                          <0x0 0x0e700000 0x0 0xa0000>,
> >> +                          <0x0 0x0c40a000 0x0 0x26000>;
> >> +                    reg-names = "core",
> >> +                                "chnls",
> >> +                                "obsrvr",
> >> +                                "intr",
> >> +                                "cnfg";
> >> +                    interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
> >> +                    interrupt-names = "periph_irq";
> >> +                    interrupt-controller;
> >> +                    #interrupt-cells = <4>;
> >> +                    #address-cells = <2>;
> >> +                    #size-cells = <0>;
> >> +                    cell-index = <0>;
> >> +                    qcom,channel = <0>;
> >> +                    qcom,ee = <0>;
> >> +            };
> >> +
> >>              intc: interrupt-controller@17a00000 {
> >>                      compatible = "arm,gic-v3";
> >>                      reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
> >>
> >> ---
> >> base-commit: de938618db2bafbe1a70c8fc43f06ccdd60364b2
> >> change-id: 20240929-adds-spmi-pmic-peripherals-for-qcs615-16ee53179a7d
> >> prerequisite-change-id: 20241022-add_initial_support_for_qcs615-2256f64a9c24:v4
> >> prerequisite-patch-id: 09782474af7eecf1013425fd34f9d2f082fb3616
> >> prerequisite-patch-id: 624720e543d7857e46d3ee49b8cea413772deb4c
> >> prerequisite-patch-id: 04ca722967256efddc402b7bab94136a5174b0b9
> >> prerequisite-patch-id: ab88a42ec69ad90e8509c9c5b7c6bdd595a7f783
> >> prerequisite-patch-id: 918724fafe43acaa4c4b980bfabe36e9c3212cd1
> >> prerequisite-patch-id: 3bd8edd83297815fcb1b81fcd891d3c14908442f
> >> prerequisite-patch-id: fc1cfec4ecd56e669c161c4d2c3797fc0abff0ae
> >>
> >> Best regards,
> >> --
> >> Tingguo Cheng <quic_tingguoc@quicinc.com>
> >>
> >
>
> --
> Thank you & BRs
> Tingguo
>


-- 
With best wishes
Dmitry

