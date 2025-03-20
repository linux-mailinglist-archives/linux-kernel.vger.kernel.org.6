Return-Path: <linux-kernel+bounces-569927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A8CA6A9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9195E4842BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E71A1E5B9F;
	Thu, 20 Mar 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rmicgVpP"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55851DDC2B;
	Thu, 20 Mar 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484194; cv=none; b=Nqw1QqjacJWJv4CkZZLyMD0r6z26oWG5xsah+m+pqFLuvdPMF3y6pnVtt5HZNp4ebg3RERUv73G5eUDBqHnKJ8DoxpgtW8NMd8DfQ/StEPCc2gnbE2+bpkEMM/7LTBX2wK+5xdRP2vO3IyDqJ/RpPPqyQ7/Xy02T2sIrhijqZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484194; c=relaxed/simple;
	bh=oOrd6qUPDwbA6xtfAP+LiWV2/BgQTJ0wqwd0cqsXxO8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVDk12gxu2Co0GROfe1NEdkPWyhw6FycNoaYbmx+4yMgq7r32euFG4lyC+jwVs76IzZ0RctlZ+mhqi6n8tJncMpc2Zr0E7Xgh6385kmQc3klxDB+bDQj+RZ5f5WTOBPpiZgtahPMkf9LCluLBUl+/jW4HWHlLDJY2R+Fkh7EUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rmicgVpP; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52KFMrVn664173
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 10:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742484173;
	bh=tdhjUaEpge+sh2/HmxIDfMo+ucgquiWth6F5utS9+iA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=rmicgVpPt+9HzF5sfuP7w95FjMue2MaSO+ZFAmsZA5JioKrnIsHEYxovOMjlluulm
	 mUjyxg0nFxQPQ32YPMKYIjeg1ETzTiq53HcuFwlBNWJ25zGHE/O1qn1qcEBPAOrvP4
	 zfBw+1Crfd7Gtsn+tvsVxQF6UZl5ZmepRUB2KEaI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52KFMrUY054048
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Mar 2025 10:22:53 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Mar 2025 10:22:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Mar 2025 10:22:53 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52KFMrJ6023231;
	Thu, 20 Mar 2025 10:22:53 -0500
Date: Thu, 20 Mar 2025 10:22:53 -0500
From: Nishanth Menon <nm@ti.com>
To: Parth Pancholi <parth105105@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Parth Pancholi
	<parth.pancholi@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-j784s4-main: Enable ACSPCIE
 outputs for PCIe interfaces
Message-ID: <20250320152253.rm7zavvnqvzmy6pv@galore>
References: <20250320122259.525613-1-parth105105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320122259.525613-1-parth105105@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 13:22-20250320, Parth Pancholi wrote:
> From: Parth Pancholi <parth.pancholi@toradex.com>
> 
> TI J784S4-based devices, such as the AM69 SoC, provide PCIE_REFCLK outputs
> from the SoC, which can be used to clock external PCIe endpoint devices.
> Each PCIE_REFCLK output is enabled via the corresponding ACSPCIE clock buffer,
> with each buffer supporting two PADs to provide reference clocks for two
> associated PCIe instances. The mappings are as follows:
>         - PCIe0 -> ACSPCIE1 PAD0
>         - PCIe1 -> ACSPCIE0 PAD0
>         - PCIe2 -> ACSPCIE1 PAD1
>         - PCIe3 -> ACSPCIE0 PAD1
> 
> This patch enables each ACSPCIE module and its corresponding PADs to ensure
> that all PCIE_REFCLK outputs are functional.
> 
> This change have been tested on an AM69-based custom hardware platform,
> where all four PCIe instances (PCIe0, PCIe1, PCIe2, and PCIe3) with the
> internal PCIE_REFCLK are utilized with various endpoint devices such as
> a WiFi card, NVMe SSD, and PCIe-to-USB bridge.
> 
> Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1484211/am69-pcie-refclk-out-and-acspcie-mappings
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> ---
> This change depends on https://lore.kernel.org/all/20241209085157.1203168-1-s-vadapalli@ti.com/
> ---
>  .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi      | 10 ++++++++--
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi             | 10 ++++++----
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> index 591609f3194c..854fdf7b771e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> @@ -132,6 +132,11 @@ acspcie0_proxy_ctrl: clock-controller@1a090 {
>  			compatible = "ti,j784s4-acspcie-proxy-ctrl", "syscon";
>  			reg = <0x1a090 0x4>;
>  		};
> +
> +		acspcie1_proxy_ctrl: clock-controller@1a094 {
> +			compatible = "ti,j784s4-acspcie-proxy-ctrl", "syscon";

We have the same challenge with bindings as well?

> +			reg = <0x1a094 0x4>;
> +		};
>  	};
>  
>  	main_ehrpwm0: pwm@3000000 {
> @@ -1067,11 +1072,12 @@ pcie0_rc: pcie@2900000 {
>  		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
>  		device_type = "pci";
>  		ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x0>;
> +		ti,syscon-acspcie-proxy-ctrl = <&acspcie1_proxy_ctrl 0x1>;
>  		max-link-speed = <3>;
>  		num-lanes = <4>;
>  		power-domains = <&k3_pds 332 TI_SCI_PD_EXCLUSIVE>;
> -		clocks = <&k3_clks 332 0>;
> -		clock-names = "fck";
> +		clocks = <&k3_clks 332 0>, <&serdes1 CDNS_TORRENT_REFCLK_DRIVER>;
> +		clock-names = "fck", "pcie_refclk";
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		bus-range = <0x0 0xff>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 0160fe0da983..ebbc315649d0 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -34,8 +34,8 @@ pcie2_rc: pcie@2920000 {
>  		max-link-speed = <3>;
>  		num-lanes = <2>;
>  		power-domains = <&k3_pds 334 TI_SCI_PD_EXCLUSIVE>;
> -		clocks = <&k3_clks 334 0>;
> -		clock-names = "fck";
> +		clocks = <&k3_clks 334 0>, <&serdes1 CDNS_TORRENT_REFCLK_DRIVER>;
> +		clock-names = "fck", "pcie_refclk";
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		bus-range = <0x0 0xff>;
> @@ -45,6 +45,7 @@ pcie2_rc: pcie@2920000 {
>  		dma-coherent;
>  		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
>  		ti,syscon-pcie-ctrl = <&pcie2_ctrl 0x0>;
> +		ti,syscon-acspcie-proxy-ctrl = <&acspcie1_proxy_ctrl 0x3>;
>  		status = "disabled";
>  	};
>  
> @@ -63,8 +64,8 @@ pcie3_rc: pcie@2930000 {
>  		max-link-speed = <3>;
>  		num-lanes = <2>;
>  		power-domains = <&k3_pds 335 TI_SCI_PD_EXCLUSIVE>;
> -		clocks = <&k3_clks 335 0>;
> -		clock-names = "fck";
> +		clocks = <&k3_clks 335 0>, <&serdes0 CDNS_TORRENT_REFCLK_DRIVER>;
> +		clock-names = "fck", "pcie_refclk";
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		bus-range = <0x0 0xff>;
> @@ -74,6 +75,7 @@ pcie3_rc: pcie@2930000 {
>  		dma-coherent;
>  		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
>  		ti,syscon-pcie-ctrl = <&pcie3_ctrl 0x0>;
> +		ti,syscon-acspcie-proxy-ctrl = <&acspcie0_proxy_ctrl 0x3>;
>  		status = "disabled";
>  	};
>  
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

