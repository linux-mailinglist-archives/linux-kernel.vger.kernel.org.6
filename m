Return-Path: <linux-kernel+bounces-409365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B359C8BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC6B1F25A31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F831FAF0F;
	Thu, 14 Nov 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmtJLVSq"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660D1FAC3D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731590931; cv=none; b=Ae75PlSCTsqiwFscHJHAI6+UWGfuLq1e/u24FAVTToJMHBfRbXP/7kTllBfWOq3nc8rEsu7S+CVMNXN/gcUyLo2NBlM6ZEdZ3qznBArGEBsQScZFlMnYd8g2jmxDmzqVb7fJj1QtCsTihAgIEQtbEJP05MVBzrFXb9hPX8R42VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731590931; c=relaxed/simple;
	bh=Sxx/Lai0zK42h/U29LKjUmar6IFE1Dx8OHn26s0hyjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyeyjTM80OXzSb0fBT5jStAdwOj2EwDw7MMf7oUO1QVvWKDnyVTFGqwMLtvggA6PY8K6quvN8x54ag+mhhCmXJD2lzyisGcTFtbqYKp1sGZZRcRFMYe+RhsupUjwa0iN/e2MyujB747i/jF1EOk0tWJ57l30RZMW5HkI0WV4Vlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UmtJLVSq; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ea7c9226bbso6829877b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731590927; x=1732195727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcQ5UiOW6mD+0cy+sSW1sUJ7XuSBho0hmBvy+z6MjTw=;
        b=UmtJLVSq6uIZ8AO9ntnUrJXFoa+SW0xXRZBYfGcMTBHz9+UIhl0/w8rEy1js0sgkid
         s6eddXSJZG1qS7R4or73xTyi9uFPtHmfsBkwfLkNlV1GBMsUVr7yKMKpygC6CtrhuZ8T
         Tgoms0tAuhBuOK/0XxgmXiA6AK610j19wdJXE9lbXf7w23QFy20RG0Lkf9CVKEI1elau
         B7aa3R980UbX+cEkPOHfXxmtD0DEEPVkJVnQYaekJ8GZ1xQp8qyPOOaz2+3Uw4QVdG3k
         Ucc1ZQ/O7fbGzbcZAQgEbh9C2YF9Y2zLJO/rnmdnbwPnh5nxR9xWEQGhDfxeb+D7c1eI
         72Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731590927; x=1732195727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcQ5UiOW6mD+0cy+sSW1sUJ7XuSBho0hmBvy+z6MjTw=;
        b=tErIWv1KqAwOBDoEjj9hTUPxEX24UHD4vnexjzX9CFHogIclrL3EMDjzl2MxjpHCZE
         JyY9L4tMtbHLJfCPHys3abZ3/9h7zvdRB7dwMiBpETuh7m2zQpYtbuIUhbBt5/cDNWOH
         uT0R9kGA+hjjMgtuwWYH2Dt3L9thdqf+MDIVIql3G/JMkl6lVFC85i+DF5vV8UEZKBql
         N523+Re0QVibKIhHAwXE8Nrg84UKs/RLEHDd2SR0ZaIPLCb1JWYcRDv2ZKfwldVvCkfo
         /K+k4w/0VJ8iZ/gewOosfQCoUog+16xcTM7KlUvbNmze/N/j6+xa1kuHHV6hlSVKmj8Q
         dWSw==
X-Forwarded-Encrypted: i=1; AJvYcCV6+0H6yMtRfHz2wfuUInJ7y7HWJ5yYnBZZzs8+6nDXTAGXUqC/lYAJyyFAg7ZRJwHgpMEAdqJnYYNFwow=@vger.kernel.org
X-Gm-Message-State: AOJu0YweE5vMfwuNCm42AO0/Jgfq+974ho2Ky4BNQYbP2W6lZo8Lw1Iy
	997OZsp2JfbwSljWxQhvD4xhNs6JrWWc9dK7aN1kte2/1x71hpgYpAHQEb9k1TcMnXuw3qGUkis
	sRIrgADr1dPBnINadHYc7a55nMtDSbBcRLTSm5w==
X-Google-Smtp-Source: AGHT+IEugYhO3qu2pI5GTy+5MNobr83Oj1LIe7KV1mNroQS/7Hdfjqfs3RZ2KahktWJFX5bf8Yw2oc7xssKAL6x6h1s=
X-Received: by 2002:a05:690c:2501:b0:6dd:cdd7:ce49 with SMTP id
 00721157ae682-6eca4640ff7mr126602127b3.6.1731590927516; Thu, 14 Nov 2024
 05:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114074722.4085319-1-quic_varada@quicinc.com> <20241114074722.4085319-7-quic_varada@quicinc.com>
In-Reply-To: <20241114074722.4085319-7-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 14 Nov 2024 15:28:36 +0200
Message-ID: <CAA8EJpr6xb=TPPgk7ERhKVp7OnYdPGCK6+1_2TBRLBt_eWM43A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: Add USB controller and phy nodes
 for IPQ5424
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, andersson@kernel.org, 
	konradybcio@kernel.org, mantas@8devices.com, quic_kbajaj@quicinc.com, 
	quic_kriskura@quicinc.com, quic_rohiagar@quicinc.com, abel.vesa@linaro.org, 
	quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 09:48, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> The IPQ5424 SoC has both USB2.0 and USB3.0 controllers. The USB3.0
> can connect to either of USB2.0 or USB3.0 phy and operate in the
> respective mode.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: Regulator node names, labels and 'regulator-name' changed per review suggestions
>     Stray newline removed
>
> v2: Add dm/dp_hs_phy_irq to usb3@8a00000 node
>     Add u1/u2-entry quirks to usb@8a00000 node
> ---
>  arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts |  66 ++++++++
>  arch/arm64/boot/dts/qcom/ipq5424.dtsi       | 159 ++++++++++++++++++++
>  2 files changed, 225 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> index d4d31026a026..859e15befb3f 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> @@ -16,12 +16,70 @@ / {
>         aliases {
>                 serial0 = &uart1;
>         };
> +
> +       vreg_misc_3p3: regulator-3300000 {

Technically these names are correct. However they don't match the
approach that Qualcomm DT files have been using up to now.
You can compare your data with the output of `git grep :.regulator-
arch/arm64/boot/dts/qcom/`

> +               compatible = "regulator-fixed";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-name = "usb_hs_vdda_3p3";
> +       };
> +
> +       vreg_misc_1p8: regulator-1800000 {
> +               compatible = "regulator-fixed";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-name = "vdda_1p8_usb";
> +       };
> +
> +       vreg_misc_0p925: regulator-0925000 {
> +               compatible = "regulator-fixed";
> +               regulator-min-microvolt = <925000>;
> +               regulator-max-microvolt = <925000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-name = "vdd_core_usb";
> +       };
> +};
> +
> +&dwc_0 {
> +       dr_mode = "host";
> +};
> +
> +&dwc_1 {
> +       dr_mode = "host";
> +};
> +
> +&qusb_phy_0 {
> +       vdd-supply = <&vreg_misc_0p925>;
> +       vdda-pll-supply = <&vreg_misc_1p8>;
> +       vdda-phy-dpdm-supply = <&vreg_misc_3p3>;
> +
> +       status = "okay";
> +};
> +
> +&qusb_phy_1 {
> +       vdd-supply = <&vreg_misc_0p925>;
> +       vdda-pll-supply = <&vreg_misc_1p8>;
> +       vdda-phy-dpdm-supply = <&vreg_misc_3p3>;
> +
> +       status = "okay";
>  };
>
>  &sleep_clk {
>         clock-frequency = <32000>;
>  };
>
> +&ssphy_0 {
> +       vdda-pll-supply = <&vreg_misc_1p8>;
> +       vdda-phy-supply = <&vreg_misc_0p925>;
> +
> +       status = "okay";
> +};
> +
>  &tlmm {
>         sdc_default_state: sdc-default-state {
>                 clk-pins {
> @@ -53,6 +111,14 @@ &uart1 {
>         status = "okay";
>  };
>
> +&usb2 {
> +       status = "okay";
> +};
> +
> +&usb3 {
> +       status = "okay";
> +};
> +
>  &xo_board {
>         clock-frequency = <24000000>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> index 5e219f900412..f8afd6f0412d 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> @@ -233,6 +233,165 @@ intc: interrupt-controller@f200000 {
>                         msi-controller;
>                 };
>
> +               qusb_phy_1: phy@71000 {
> +                       compatible = "qcom,ipq5424-qusb2-phy";
> +                       reg = <0 0x00071000 0 0x180>;
> +                       #phy-cells = <0>;
> +
> +                       clocks = <&gcc GCC_USB1_PHY_CFG_AHB_CLK>,
> +                               <&xo_board>;
> +                       clock-names = "cfg_ahb", "ref";
> +
> +                       resets = <&gcc GCC_QUSB2_1_PHY_BCR>;
> +                       status = "disabled";
> +               };
> +
> +               usb2: usb2@1e00000 {
> +                       compatible = "qcom,ipq5424-dwc3", "qcom,dwc3";
> +                       reg = <0 0x01ef8800 0 0x400>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +
> +                       clocks = <&gcc GCC_USB1_MASTER_CLK>,
> +                                <&gcc GCC_USB1_SLEEP_CLK>,
> +                                <&gcc GCC_USB1_MOCK_UTMI_CLK>,
> +                                <&gcc GCC_USB1_PHY_CFG_AHB_CLK>,
> +                                <&gcc GCC_CNOC_USB_CLK>;
> +
> +                       clock-names = "core",
> +                                     "sleep",
> +                                     "mock_utmi",
> +                                     "iface",
> +                                     "cfg_noc";
> +
> +                       assigned-clocks = <&gcc GCC_USB1_MASTER_CLK>,
> +                                         <&gcc GCC_USB1_MOCK_UTMI_CLK>;
> +                       assigned-clock-rates = <200000000>,
> +                                              <24000000>;
> +
> +                       interrupts-extended = <&intc GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&intc GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&intc GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&intc GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "pwr_event",
> +                                         "qusb2_phy",
> +                                         "dm_hs_phy_irq",
> +                                         "dp_hs_phy_irq";
> +
> +                       resets = <&gcc GCC_USB1_BCR>;
> +                       qcom,select-utmi-as-pipe-clk;
> +                       status = "disabled";
> +
> +                       dwc_1: usb@1e00000 {
> +                               compatible = "snps,dwc3";
> +                               reg = <0 0x01e00000 0 0xe000>;
> +                               clocks = <&gcc GCC_USB1_MOCK_UTMI_CLK>;
> +                               clock-names = "ref";
> +                               interrupts = <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>;
> +                               phys = <&qusb_phy_1>;
> +                               phy-names = "usb2-phy";
> +                               tx-fifo-resize;
> +                               snps,is-utmi-l1-suspend;
> +                               snps,hird-threshold = /bits/ 8 <0x0>;
> +                               snps,dis_u2_susphy_quirk;
> +                               snps,dis_u3_susphy_quirk;
> +                       };
> +               };
> +
> +               qusb_phy_0: phy@7b000 {
> +                       compatible = "qcom,ipq5424-qusb2-phy";
> +                       reg = <0 0x0007b000 0 0x180>;
> +                       #phy-cells = <0>;
> +
> +                       clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +                               <&xo_board>;
> +                       clock-names = "cfg_ahb", "ref";
> +
> +                       resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> +                       status = "disabled";
> +               };
> +
> +               ssphy_0: phy@7d000 {
> +                       compatible = "qcom,ipq5424-qmp-usb3-phy";
> +                       reg = <0 0x0007d000 0 0xa00>;
> +                       #phy-cells = <0>;
> +
> +                       clocks = <&gcc GCC_USB0_AUX_CLK>,
> +                                <&xo_board>,
> +                                <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +                                <&gcc GCC_USB0_PIPE_CLK>;
> +                       clock-names = "aux",
> +                                     "ref",
> +                                     "cfg_ahb",
> +                                     "pipe";
> +
> +                       resets = <&gcc GCC_USB0_PHY_BCR>,
> +                                <&gcc GCC_USB3PHY_0_PHY_BCR>;
> +                       reset-names = "phy",
> +                                     "phy_phy";
> +
> +                       #clock-cells = <0>;
> +                       clock-output-names = "usb0_pipe_clk";
> +
> +                       status = "disabled";
> +               };
> +
> +               usb3: usb3@8a00000 {
> +                       compatible = "qcom,ipq5424-dwc3", "qcom,dwc3";
> +                       reg = <0 0x08af8800 0 0x400>;
> +
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +
> +                       clocks = <&gcc GCC_USB0_MASTER_CLK>,
> +                                <&gcc GCC_USB0_SLEEP_CLK>,
> +                                <&gcc GCC_USB0_MOCK_UTMI_CLK>,
> +                                <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +                                <&gcc GCC_CNOC_USB_CLK>;
> +
> +                       clock-names = "core",
> +                                     "sleep",
> +                                     "mock_utmi",
> +                                     "iface",
> +                                     "cfg_noc";
> +
> +                       assigned-clocks = <&gcc GCC_USB0_MASTER_CLK>,
> +                                         <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +                       assigned-clock-rates = <200000000>,
> +                                              <24000000>;
> +
> +                       interrupts-extended = <&intc GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&intc GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&intc GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&intc GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "pwr_event",
> +                                         "qusb2_phy",
> +                                         "dm_hs_phy_irq",
> +                                         "dp_hs_phy_irq";
> +
> +                       resets = <&gcc GCC_USB_BCR>;
> +                       status = "disabled";
> +
> +                       dwc_0: usb@8a00000 {
> +                               compatible = "snps,dwc3";
> +                               reg = <0 0x08a00000 0 0xcd00>;
> +                               clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +                               clock-names = "ref";
> +                               interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
> +                               phys = <&qusb_phy_0>, <&ssphy_0>;
> +                               phy-names = "usb2-phy", "usb3-phy";
> +                               tx-fifo-resize;
> +                               snps,is-utmi-l1-suspend;
> +                               snps,hird-threshold = /bits/ 8 <0x0>;
> +                               snps,dis_u2_susphy_quirk;
> +                               snps,dis_u3_susphy_quirk;
> +                               snps,dis-u1-entry-quirk;
> +                               snps,dis-u2-entry-quirk;
> +                       };
> +               };
> +
>                 timer@f420000 {
>                         compatible = "arm,armv7-timer-mem";
>                         reg = <0 0xf420000 0 0x1000>;
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

