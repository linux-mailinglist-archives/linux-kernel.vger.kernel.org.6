Return-Path: <linux-kernel+bounces-545998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE4A4F4FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4BE16C38B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155BC15A843;
	Wed,  5 Mar 2025 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRwbldEA"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD91547E9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143477; cv=none; b=hGPy/UwBl2bPIhUKnvBKPstxknqCis7AYhRD1LdreqY1ZD111bH1SrgeYQ8G7iAdyMahzTfAEIQyGUtzWwkkPvrJnw02UxBmNq3CLceI40HlEjfz2cctpoNszkPg5PHV0rXuXHK62tUprT8MxN6fdv+dEDOL3UG43xqShLMaJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143477; c=relaxed/simple;
	bh=y7bMw3N+68dF2gots6s3j4ZbxaLrFGvk8JUQ//skTXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP1ctUEWMeG3+p+CvBxJvFlXYGf57fiqXgQ48D52Ht/yuzuonaqoVjEMQvTmU6Z3bz1Rm/Jhs0ijHTVvfzI03HndVy635uN8+LKVhWnaLsxQkZtnHtKBn1BNQ3dN3hPBu9pjHQq4hoSbRfbGc8Omb7JqrU1XbOm6/LYqyuopHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MRwbldEA; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so244755e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741143473; x=1741748273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8qDHMP0/psqxw/XtRcA0VzgZ/XpGSLC12c3xrF1aPA=;
        b=MRwbldEA57KcJhDX+SrkJg1FQxa3kFG7QIOne+i2iH05bzCydH8C/4yAuyJLFEyRqL
         IDx4TzaEG6TG3MRmTOVEQB6HW+WI2+jQm7ywYxUg3KgOtZSQnTxHbF8orXgR2aqIkGXa
         qy/WV51MoazPOn20HjtLlonAQ6Wqpp9MA5kdoYJyvLfh0mtKkb3+EbX/62+8MxAGxXOI
         kHwKpqpbe5boU7GyZr8vxd3IVQlbWTC8oAYbB90wSw8rgi6zA+Uo+l2N41bFQDQuK0Io
         51Kit/3fCJx4PKVHDhz7HiySMGeLQKdnoakKjnjd20Yea10lpAWq4ZqEeG8SriMRg7b0
         Llqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143473; x=1741748273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8qDHMP0/psqxw/XtRcA0VzgZ/XpGSLC12c3xrF1aPA=;
        b=cDLZAzAIovv5OiIpRNm/LkiT1ZbY5TPFx2iWEcRWXBFXX/y4cYgETMNn3qXt5tZp6H
         saVs5jC5sGdEUm03KK7USosPKkrZT5JQko6ZrTTCH7z7/w5ov0Cq/8OTKCQBjHgxKoQ5
         yGyXrhKN9j9iuNmEDU/SQLTiKN64UM25iJjkyVvQ9F0YzVlmIYaEETRwAHxFgrIrua/D
         NCqqZns3tNxeB2IwKmgZzmclqIRqPvvk5DuTqGwEyHrAk9Y1Fqyek1k3bPC9yJ/Upjiw
         lRycOHvioz0H8aUZvtY6gC/jyKzESpQfmuqdV7d4qo9RUEi5+XH7PRR081v2oLNd3vnd
         r0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAEAdC7ALXBfesk1DOecg2uziD9Wb8SujgxRV4BeYNrwvzRG16IF7vBb3ZuRwuv77/w/A6oFBHufqkBVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgwxDT8ahpYixdTjtRj6KrQqKbtfx47R2i48Vz5qZq0V8o34B4
	DLApl87dfmxb7oNH1y6B0J7dI1+QXHIw4iXreanLmhY+9xcMBpVm9nMMa5Lz4S4=
X-Gm-Gg: ASbGncsWfWkVeLKWc8AoxJ7o4EURmzmgSuWT36v17ymq4q+yMIWZYBSSYvg3RE0jCXO
	ou37dhNf6d0hw8ZtDrKt1IpAXNBU09S8UB94CrJyRrPYmiAYvrYtiMANOQSs+BbZUONv3QIQ+qr
	T49QtqaqO1DdxjgdmFIVMfaQQig0t84/C5TtO+HadIROoiVq0qrIFN1vhSHU46RiQuh73xfQPTT
	8lqODg6g/kT+PvMq2X34KfsTSCk4Id+gUF8G736+DGv2PkhJKfMw5QuqzfMCl6Zwyn6d654r7eZ
	zXHoq4SlMhmcWbBegUqGFvK/5dzx51gqN5yGN/Hpf7cGkhm+Msjkf0+Qr4r5T9Zh1XU8XbCGfmR
	zDzT5Me/hzRzWaRb96GkAryK0
X-Google-Smtp-Source: AGHT+IHGOGwNINTW4ac1tC6VSgjqBJC0+1KyVOaHFcHtINPFKwdR1g09IOAfwlXr5N6PwikUjAqrUg==
X-Received: by 2002:a05:6512:ac7:b0:545:2335:6597 with SMTP id 2adb3069b0e04-5497d383726mr462845e87.50.1741143473438;
        Tue, 04 Mar 2025 18:57:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494efff26esm1486481e87.73.2025.03.04.18.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:57:52 -0800 (PST)
Date: Wed, 5 Mar 2025 04:57:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom: sm8750: Add USB support to
 SM8750 SoCs
Message-ID: <qr5vsq5b4pf5po3uq4esrozfjkmzq5q55tqlxxc74fh2pcygzi@vb7txcm5wpst>
References: <20250304-sm8750_usb_master-v2-0-a698a2e68e06@quicinc.com>
 <20250304-sm8750_usb_master-v2-7-a698a2e68e06@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-sm8750_usb_master-v2-7-a698a2e68e06@quicinc.com>

On Tue, Mar 04, 2025 at 01:56:40PM -0800, Melody Olvera wrote:
> From: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> Add the base USB devicetree definitions for SM8750 platforms.  The overall
> chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
> (rev. v8) and M31 eUSB2 PHY.  The major difference for SM8750 is the
> transition to using the M31 eUSB2 PHY compared to previous SoCs.
> 
> Enable USB support on SM8750 MTP and QRD variants. SM8750 has a QMP combo
> PHY for the SSUSB path, and a M31 eUSB2 PHY for the HSUSB path.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 163 +++++++++++++++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> index 3bbd7d18598ee0a3a0d5130c03a3166e1fc14d82..e543e65c7aba3213ca0b8a8f6dbaf1371ed8317e 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/interconnect/qcom,icc.h>
>  #include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>  #include <dt-bindings/power/qcom,rpmhpd.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> @@ -1966,6 +1967,168 @@ lpass_lpicx_noc: interconnect@7420000 {
>  			#interconnect-cells = <2>;
>  		};
>  
> +		usb_1_hsphy: phy@88e3000 {
> +			compatible = "qcom,sm8750-m31-eusb2-phy";
> +			reg = <0x0 0x88e3000 0x0 0x29c>;
> +
> +			clocks = <&tcsrcc TCSR_USB2_CLKREF_EN>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		usb_dp_qmpphy: phy@88e8000 {
> +			compatible = "qcom,sm8750-qmp-usb3-dp-phy";
> +			reg = <0x0 0x088e8000 0x0 0x4000>;
> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "ref",
> +				      "com_aux",
> +				      "usb3_pipe";
> +
> +			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
> +				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
> +			reset-names = "phy",
> +				      "common";
> +
> +			power-domains = <&gcc GCC_USB3_PHY_GDSC>;
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <1>;
> +
> +			orientation-switch;
> +
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					usb_dp_qmpphy_out: endpoint {
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					usb_dp_qmpphy_usb_ss_in: endpoint {
> +						remote-endpoint = <&usb_1_dwc3_ss>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					usb_dp_qmpphy_dp_in: endpoint {
> +					};
> +				};
> +			};
> +		};
> +
> +		usb_1: usb@a6f8800 {
> +			compatible = "qcom,sm8750-dwc3", "qcom,dwc3";
> +			reg = <0x0 0x0a6f8800 0x0 0x400>;
> +			status = "disabled";

Status should be the last property

> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +				 <&tcsrcc TCSR_USB3_CLKREF_EN>;
> +			clock-names = "cfg_noc",
> +				      "core",
> +				      "iface",
> +				      "sleep",
> +				      "mock_utmi",
> +				      "xo";
> +
> +			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <200000000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +						  <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,

Misaligned

> +					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "pwr_event",
> +					  "hs_phy_irq",
> +					  "dp_hs_phy_irq",
> +					  "dm_hs_phy_irq",
> +					  "ss_phy_irq";
> +
> +			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +
> +			resets = <&gcc GCC_USB30_PRIM_BCR>;
> +
> +			interconnects = <&aggre1_noc MASTER_USB3_0 0 &mc_virt SLAVE_EBI1 0>,

QCOM_ICC_TAG_ALWAYS

> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";
> +

-- 
With best wishes
Dmitry

