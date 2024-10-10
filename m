Return-Path: <linux-kernel+bounces-359412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161F6998B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EAC1C2432D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2D21CBEB9;
	Thu, 10 Oct 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eu1yqvo1"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B261CB338
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573139; cv=none; b=aO6aQqzzC7e/jRzS+70k2eTJ/4SmqQeACOWfyGl3wj8ylNXlXvgV92pbYYIlonzc7oQTHVbSat6fahp4hZ1EzJ+9+vrMgkPnmAK8PxIWqD0xXCiEMHQuhtmz3JLA6Nurw62nN5OwRqBoo0cveulDjnjaQPVI9XjzDG96f0gZ4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573139; c=relaxed/simple;
	bh=xO+xrsV0m6ktnljEcqpoAG1lE8azlumTtyyOZH61p8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6e4tu6gdZTkk4aqC79EZR6rBxUkUcSJHXql7XRzbFBatihEoZsC5sWDKj8IgtnPpq/XdlqNRB+JRlZ3hh8tqgeUvDgH6a0NcMu5Maq3F4J+jbsv+jkolCCWtM55Z6csFp+qUjwEV3BT2kDWOheByslZ37+5B5nvO8fkdg/ofQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eu1yqvo1; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e28ff55468dso1023393276.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728573137; x=1729177937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8r9lf5vsYGAZg3qoBN90Qx8Rz8zTJDhUxvIq7CGMNYg=;
        b=eu1yqvo1k0jl+i7FS9kr6OszcjHNFc2QBwrvwATsCNEHQHsYdf4+bD6O1R1+RSD4I3
         yBwkWxZu3z6hXXY07vXWBmFa6S2rgmNaaJbyjCP9xjIahmekER+euySLAGvPa8zmEVgg
         kETpYcVfJ0Hzzf/OEYUAsoBX6ovhJf2eBYQDf6zzaNRmhi+6JFVTYCGKGcxItKR+H7sl
         jZ/xwElBE7zUzFqkFBlV3GEJWQnA2llIUeeVnpVkYeaaYA1qQIqPdINL9jLNGycGbMPC
         T4mrDGOZAh+WG1t0mP6pdV3a3IeJU2lXTfPUxN31ajGIf6onbwxf4d5s1cO+FfP914bh
         Flgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573137; x=1729177937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8r9lf5vsYGAZg3qoBN90Qx8Rz8zTJDhUxvIq7CGMNYg=;
        b=ojqTeXB874scl9h998km5lPsceHKu9xwc0Tyhn2f7Owizaa9QdKjh1yZrMhWjlgRA0
         odVCp+nG8VJ9b3o/0dIKyrFKvpH3icw/CuuW4j7lf+eKCzG0WrBf2+t8MYbfNvjLgHEQ
         +u9fmMmtpKRk5zCo6squeiNVf/CeqfyfoCQ852qE21DKhyfQ5v6P436sw3nCo7cDI7+e
         B1dMpa00Fs6fRAfj/tMHp7zVpUB/tUfixlQLB7iDJr69Vy04T+BuTSmoOLLnjLozjif1
         wVaRm30YSLLQFBewZWEPlSPnOS9/D64B1620RVb76SXdPhOzrR6fjQxvIW1oy676QnOJ
         HRxA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Md3jhLrBRLMiSJKPYAerQhEPDGRrnaz/J9aw+K3ibpSsGUWcgJIjCfz+2DSYJaolWPOmFU85yV3Y+xM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ZHk55hloSUhUH3DLLQw1UTboGt7ZEQuEqImpZHEldhDoBKRF
	HmRwE9mW1xGN/mnH09dRkW2xvazKUEZLcbTNSqSzcSS/h/bFC1lkBeEuyh85QWY117Qhbh94nyR
	uXNt96F8oiFBaxPzcxmEgJgBsK+K5XxhWBB6beg==
X-Google-Smtp-Source: AGHT+IEaEnIgwjZvAhRFQl53GhDBElGnM3KPGeMsZ+GGPwd8gASrTFJB007EfgE2E3zzOPq9Cvir8gU+v2p8b/OdcZA=
X-Received: by 2002:a05:6902:726:b0:e28:ec71:eb87 with SMTP id
 3f1490d57ef6-e2909c00af1mr4623491276.4.1728573137216; Thu, 10 Oct 2024
 08:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009195636.2649952-1-quic_kriskura@quicinc.com>
 <20241009195636.2649952-2-quic_kriskura@quicinc.com> <xwidjnw3fqc2slwl3vftw7yi4j7juiw6rwszjhtxepqd6zz33s@ncoi4aikbb4e>
 <fe3ebd31-946c-499f-ac96-2cf71c6752e6@quicinc.com>
In-Reply-To: <fe3ebd31-946c-499f-ac96-2cf71c6752e6@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 10 Oct 2024 18:12:05 +0300
Message-ID: <CAA8EJpojz9-xhoxdp78b5=6R8gpjjHQgjb_P0LGfHs4PsdS3vA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: Add support for usb nodes on QCS8300
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 17:57, Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
>
>
> On 10/10/2024 7:52 PM, Dmitry Baryshkov wrote:
> > On Thu, Oct 10, 2024 at 01:26:35AM GMT, Krishna Kurapati wrote:
> >> Add support for USB controllers on QCS8300. The second
> >> controller is only High Speed capable.
> >>
> >> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/qcs8300.dtsi | 165 ++++++++++++++++++++++++++
> >>   1 file changed, 165 insertions(+)
> >
> > [...]
> >
> >> +
> >> +            usb_2: usb@a4f8800 {
> >> +                    compatible = "qcom,qcs8300-dwc3", "qcom,dwc3";
> >> +                    reg = <0x0 0x0a4f8800 0x0 0x400>;
> >> +                    #address-cells = <2>;
> >> +                    #size-cells = <2>;
> >> +                    ranges;
> >> +
> >> +                    clocks = <&gcc GCC_CFG_NOC_USB2_PRIM_AXI_CLK>,
> >> +                             <&gcc GCC_USB20_MASTER_CLK>,
> >> +                             <&gcc GCC_AGGRE_USB2_PRIM_AXI_CLK>,
> >> +                             <&gcc GCC_USB20_SLEEP_CLK>,
> >> +                             <&gcc GCC_USB20_MOCK_UTMI_CLK>;
> >> +                    clock-names = "cfg_noc",
> >> +                                  "core",
> >> +                                  "iface",
> >> +                                  "sleep",
> >> +                                  "mock_utmi";
> >> +
> >> +                    assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
> >> +                                      <&gcc GCC_USB20_MASTER_CLK>;
> >> +                    assigned-clock-rates = <19200000>, <120000000>;
> >> +
> >> +                    interrupts-extended = <&intc GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
> >> +                                          <&intc GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>,
> >> +                                          <&pdc 10 IRQ_TYPE_EDGE_BOTH>,
> >> +                                          <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
> >> +                    interrupt-names = "pwr_event",
> >> +                                      "hs_phy_irq",
> >> +                                      "dp_hs_phy_irq",
> >> +                                      "dm_hs_phy_irq";
> >> +
> >> +                    power-domains = <&gcc GCC_USB20_PRIM_GDSC>;
> >> +                    required-opps = <&rpmhpd_opp_nom>;
> >> +
> >> +                    resets = <&gcc GCC_USB20_PRIM_BCR>;
> >> +
> >> +                    interconnects = <&aggre1_noc MASTER_USB2 0 &mc_virt SLAVE_EBI1 0>,
> >> +                                    <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB2 0>;
> >> +                    interconnect-names = "usb-ddr", "apps-usb";
> >
> > As this is a USB2-only host, shouldn't it also have qcom,select-utmi-as-pipe-clk ?
> >
>
> Hi Dmitry,
>
> Thanks for the catch. You are right, it needs to be added according to
> bindings. Since I would be sending another patch after this series to
> enable the second controller, would it be fine if I add it in that patch
> or do you suggest updating this one.

I think it's better to fix it from the beginning.

>
> Also I see some others are not using it as well, like sc7280 which also
> might need to be updated.

Interesting enough I don't see this option being enabled on SC7280 platforms.

>
> Regards,
> Krishna,
>
> >> +
> >> +                    status = "disabled";
> >> +
> >> +                    usb_2_dwc3: usb@a400000 {
> >> +                            compatible = "snps,dwc3";
> >> +                            reg = <0x0 0x0a400000 0x0 0xe000>;
> >> +                            interrupts = <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>;
> >> +                            iommus = <&apps_smmu 0x20 0x0>;
> >> +                            phys = <&usb_2_hsphy>;
> >> +                            phy-names = "usb2-phy";
> >> +                            snps,dis_u2_susphy_quirk;
> >> +                            snps,dis_enblslpm_quirk;
> >> +                    };
> >> +            };
> >>      };
> >>
> >>      arch_timer: timer {
> >> --
> >> 2.34.1
> >>
> >



-- 
With best wishes
Dmitry

