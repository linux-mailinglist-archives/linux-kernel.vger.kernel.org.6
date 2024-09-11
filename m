Return-Path: <linux-kernel+bounces-324389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F23E3974BED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7726C1F224F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EDF14036E;
	Wed, 11 Sep 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IyYNT+/e"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395F13A884
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041314; cv=none; b=VwsikaRBq8JIyxqW8lSvPcZx1QRXkoR9bO7fIgtK1ADHkqIBVWhXuBwVlgDig8l2faUCnDCVk1BGgAvEqm+m8CDITs8gy9FIVZdTWoHCnKRHngUuKV8T+KtlviSAPAgAo2D5brqjxg5O/FHcBdvwKct/1AW1zMWuTqXmVBCAbqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041314; c=relaxed/simple;
	bh=Dor0WC6DLG8S6/GkiuX2dQy+8ml1968UfALjsPmQoRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+5OxtdEDuB1WrF3VKv7Wb2lQW2MOfsb6AnzCtJcy9uOx8hhLykkSxTYpBvUMULRCtA9/4TcAy1ec8HJbUQVRQ8pnHWgrBPBPzDoaIYbuh3XdmTFquXDce6JF9Vtl1z3CpJXSm2BI5d3PR96aQ1oZCQ/bP/CPX8vVEaB9OHTGZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IyYNT+/e; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53661a131b4so4847842e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726041311; x=1726646111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wf8RcCRH70uR1M+lt6nyReZBEZIz6g++OuJL3RrvMOI=;
        b=IyYNT+/eW6HEOSi0insz3CxxH3Y7mapo/rBX7h1JnwCKgKtJZpO9vhixmShlunPRtN
         4Jo/jjScyUZLW6xv9/Woi7DaZzobx2sFNAhB27Wd5uBJ+8eDC2OB2aa326MUC1EEzFms
         7KXGK77wnERoz+zPhQ+LhfrRPxijEr50OaNJxwG1epKDo8ukX+n8b33yCOPEZijNaq7P
         ehVtPy3byLJeVHMQw6Fsx7g764wBTpWXte56sEr5SVq6SsCgd5/Xzb32PhW7xTjy1GZ/
         YwIuiVLiVR8UYUZr3fw4tJlxxpclY62cKtcC915ss1lffpYztTP2c2zs1CDIAi3xQVMx
         iDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041311; x=1726646111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wf8RcCRH70uR1M+lt6nyReZBEZIz6g++OuJL3RrvMOI=;
        b=SeJ4wdbqeY4gHFgHSFSi2dILN34jwZ0kLXR7nfGRgp74RSUaEUCe/I6gio1RkW9/Eh
         tx8/K8lOHlbkjx4ojlxwQ7FnxbIl/1RHtw8NCsBI/6imINCnCzYv0Ef/05TTV4Y6Nkl8
         Tq0zMhPLmh3p5MGM0I+aocwQ/hrB4hh80ilU+E3mo5Bucj5vyOMw/IAeBOzOSs5zVCWx
         pd+YfqYChaxWRrH9HszUNaoyJw0AraBmixF9xgzmoDwhmBn8mVy4+cQi2T4o/ZTETi0N
         Lg29Gn8BptYxOF5j3Qf5h4hV5/3IHdlG8U2uqJUZ1Zu+jry8D3Z1OC7mAP9UYVUJCMaK
         pX4g==
X-Forwarded-Encrypted: i=1; AJvYcCVXsqLYjo49VJI/rIqsQ3wbJhUD4Q8XTtK+4VBqJvXfL8ME5HQuYEqk5ihL9hQPmBpK9j2Hz2zb85dMUu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA5K/A+nvULUfzDtAmTy6LPH9MQCFxeQW/Gc1VBuu4JFq8tgrh
	wR7FekFEAAg+XLHmOfhm5o++tk52dUMkDRHn3PJNeq1O7LG+y7khOHPB5qWtT8k=
X-Google-Smtp-Source: AGHT+IEEwN02s0WJ6kvX8g1m5DiQM2gPOZaTCZeBq8oHAoK0b4KYGOLJfEmhHme9GAsl+rkmVCSpdQ==
X-Received: by 2002:a05:6512:39ce:b0:536:54df:bff2 with SMTP id 2adb3069b0e04-53658812f84mr11677473e87.54.1726041309975;
        Wed, 11 Sep 2024 00:55:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f870c1csm1478744e87.92.2024.09.11.00.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:55:08 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:55:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	robh+dt@kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, abel.vesa@linaro.org, 
	srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add X1E001DE Snapdragon Devkit for
 Windows
Message-ID: <pt4wtycddqhcvw2iblaojmzsdggmlafft4vu6lg5j2vstbhbqj@acenyi5k3yeq>
References: <20240911073337.90577-1-quic_sibis@quicinc.com>
 <20240911073337.90577-3-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911073337.90577-3-quic_sibis@quicinc.com>

On Wed, Sep 11, 2024 at 01:03:37PM GMT, Sibi Sankar wrote:
> Add initial support for x1e001de devkit platform. This includes:
> 
> -DSPs
> -Ethernet (RTL8125BG) over the pcie 5 instance.
> -NVme
> -Wifi
> -USB-C ports
> 
> Link: https://www.qualcomm.com/news/releases/2024/05/qualcomm-accelerates-development-for-copilot--pcs-with-snapdrago
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile            |   1 +
>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 813 +++++++++++++++++++
>  2 files changed, 814 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> 

> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index ae002c7cf126..1cbc7b91389d 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -268,6 +268,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk-display-card.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= x1e001de-devkit.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= x1e78100-lenovo-thinkpad-t14s.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-asus-vivobook-s15.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
> diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> new file mode 100644
> index 000000000000..07b4e60d9b66
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> @@ -0,0 +1,813 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "x1e80100.dtsi"
> +#include "x1e80100-pmics.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. X1E001DE Snapdragon Devkit for Windows";
> +	compatible = "qcom,x1e001de-devkit", "qcom,x1e001de", "qcom,x1e80100";
> +
> +	aliases {
> +		serial0 = &uart21;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	pmic-glink {
> +		compatible = "qcom,x1e80100-pmic-glink",
> +			     "qcom,sm8550-pmic-glink",
> +			     "qcom,pmic-glink";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
> +				    <&tlmm 123 GPIO_ACTIVE_HIGH>,
> +				    <&tlmm 125 GPIO_ACTIVE_HIGH>;
> +
> +		/* Back panel port closer to the RJ45 connector */
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_ss0_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_ss0_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss0_ss_in: endpoint {
> +						remote-endpoint = <&usb_1_ss0_qmpphy_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* Back panel port closer to the audio jack */
> +		connector@1 {
> +			compatible = "usb-c-connector";
> +			reg = <1>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_ss1_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_ss1_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss1_ss_in: endpoint {
> +						remote-endpoint = <&usb_1_ss1_qmpphy_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* Front panel port */
> +		connector@2 {
> +			compatible = "usb-c-connector";
> +			reg = <2>;
> +			power-role = "dual";
> +			data-role = "dual";
> +

[trimmed]

> +
> +&pcie5 {
> +	perst-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> +
> +	vddpe-3v3-supply = <&vreg_wwan>;

Please use pwrseq instead.

> +
> +	pinctrl-0 = <&pcie5_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie5_phy {
> +	vdda-phy-supply = <&vreg_l3i_0p8>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&pcie6a {
> +	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
> +
> +	vddpe-3v3-supply = <&vreg_nvme>;

Please use pwrseq instead.

> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie6a_default>;
> +
> +	status = "okay";
> +};
> +
> +&pcie6a_phy {
> +	vdda-phy-supply = <&vreg_l1d_0p8>;
> +	vdda-pll-supply = <&vreg_l2j_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&qupv3_0 {
> +	status = "okay";
> +};
> +
> +&qupv3_1 {
> +	status = "okay";
> +};
> +
> +&qupv3_2 {
> +	status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +	firmware-name = "qcom/x1e80100/devkit/qcadsp8380.mbn",
> +			"qcom/x1e80100/devkit/adsp_dtbs.elf";

qcom/SoC/Vendor/Device/foo.ext. Here the Vendor part is missing.

> +
> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/x1e80100/devkit/qccdsp8380.mbn",
> +			"qcom/x1e80100/devkit/cdsp_dtbs.elf";
> +
> +	status = "okay";
> +};
> +
> +&smb2360_0_eusb2_repeater {
> +	vdd18-supply = <&vreg_l3d_1p8>;
> +	vdd3-supply = <&vreg_l2b_3p0>;
> +};
> +
> +&smb2360_1_eusb2_repeater {
> +	vdd18-supply = <&vreg_l3d_1p8>;
> +	vdd3-supply = <&vreg_l14b_3p0>;
> +};
> +
> +&smb2360_2 {
> +	status = "okay";
> +};
> +
> +&smb2360_2_eusb2_repeater {
> +	vdd18-supply = <&vreg_l3d_1p8>;
> +	vdd3-supply = <&vreg_l8b_3p0>;
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <34 2>, /* Unused */
> +			       <44 4>, /* SPI (TPM) */
> +			       <238 1>; /* UFS Reset */

A comment would be nice. Usually the GPIOs are reserved because
accessing them is forbidden by TZ / hyp. Is this the case for the Unused
GPIOs? And why is the UFS reset marked as reserved?

> +
> +	nvme_reg_en: nvme-reg-en-state {
> +		pins = "gpio18";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	pcie4_default: pcie4-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio147";
> +			function = "pcie4_clk";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio146";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio148";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie5_default: pcie5-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio150";
> +			function = "pcie5_clk";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio149";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio151";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie6a_default: pcie6a-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio153";
> +			function = "pcie6a_clk";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio152";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio154";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	wwan_sw_en: wwan-sw-en-state {
> +		pins = "gpio221";
> +		function = "gpio";
> +		drive-strength = <4>;
> +		bias-disable;
> +	};
> +};
> +
> +&uart21 {
> +	compatible = "qcom,geni-debug-uart";
> +	status = "okay";
> +};
> +
> +&usb_1_ss0_hsphy {
> +	vdd-supply = <&vreg_l3j_0p8>;
> +	vdda12-supply = <&vreg_l2j_1p2>;
> +
> +	phys = <&smb2360_0_eusb2_repeater>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss0_qmpphy {
> +	vdda-phy-supply = <&vreg_l3e_1p2>;
> +	vdda-pll-supply = <&vreg_l1j_0p8>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss0 {
> +	status = "okay";
> +};
> +
> +&usb_1_ss0_dwc3 {
> +	dr_mode = "host";
> +};
> +
> +&usb_1_ss0_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_ss0_hs_in>;
> +};
> +
> +&usb_1_ss0_qmpphy_out {
> +	remote-endpoint = <&pmic_glink_ss0_ss_in>;
> +};
> +
> +&usb_1_ss1_hsphy {
> +	vdd-supply = <&vreg_l3j_0p8>;
> +	vdda12-supply = <&vreg_l2j_1p2>;
> +
> +	phys = <&smb2360_1_eusb2_repeater>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss1_qmpphy {
> +	vdda-phy-supply = <&vreg_l3e_1p2>;
> +	vdda-pll-supply = <&vreg_l2d_0p9>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss1 {
> +	status = "okay";
> +};
> +
> +&usb_1_ss1_dwc3 {
> +	dr_mode = "host";

All three USB-C connectors have data-role set to "dual". So this needs a
comment.

> +};
> +
> +&usb_1_ss1_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_ss1_hs_in>;
> +};
> +
> +&usb_1_ss1_qmpphy_out {
> +	remote-endpoint = <&pmic_glink_ss1_ss_in>;
> +};
> +
> +&usb_1_ss2_hsphy {
> +	vdd-supply = <&vreg_l3j_0p8>;
> +	vdda12-supply = <&vreg_l2j_1p2>;
> +
> +	phys = <&smb2360_2_eusb2_repeater>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss2_qmpphy {
> +	vdda-phy-supply = <&vreg_l3e_1p2>;
> +	vdda-pll-supply = <&vreg_l2d_0p9>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss2 {
> +	status = "okay";
> +};
> +
> +&usb_1_ss2_dwc3 {
> +	dr_mode = "host";
> +};
> +
> +&usb_1_ss2_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_ss2_hs_in>;
> +};
> +
> +&usb_1_ss2_qmpphy_out {
> +	remote-endpoint = <&pmic_glink_ss2_ss_in>;
> +};
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

