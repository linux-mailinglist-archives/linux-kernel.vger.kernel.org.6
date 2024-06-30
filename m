Return-Path: <linux-kernel+bounces-235280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214F591D2CD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 18:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129F6281507
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E33615532E;
	Sun, 30 Jun 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTjxmLdf"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272DC153836
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719766126; cv=none; b=vAGhhg6i20Huy8dNSLH6vkhdhOJuh+u4gSeza75+sLnDzpIDqMzArVfHYUQNH7CbzU9IIiKbec9aoHR5o0ONiP3A6oq0IsG/65NzhEEDZouK8YDdzxpPHw/o2DRavROxnOvxxNJH+rbai2vTk6hxGYtXPHVuRQEVgTy+hcFOpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719766126; c=relaxed/simple;
	bh=dQxOvyQctP51qAuDaFhd7Pyp06kI7BkC/OjsIIqnZE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9qqbgjEi3aTXNfNjOI2LPogJ0VTAql8E3K5DEOr4/l0+B671iTCNq/OWzA89Wif4lV+faFDG9IxvL3d6LnXiFJ6T6HTQHmkhkpeyxJj7h1EB5ypFL+LIVTMWGKnQx7wLS/Cewsdn5Y0HcB+/0q/IgP+Ke7APZxOB08NGI8QWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mTjxmLdf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec5779b423so21094881fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719766122; x=1720370922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HtpZiswc8Frh06Fro0Rn2Oot+7AiSiHCpH2d6ugWZiw=;
        b=mTjxmLdfqSp4Dwa6I/7qiJjiV4HV5BFFcohPqPZm+pXhZP9BR1nUGFWVHfdGqBnGq0
         G9pN5znfLBDzZcylfkTfYWcbBfiNXymU/rlTnS07a2SILlmqZYJH2fv49the4pjkZWUJ
         at7CKVdhtzEC8RNXQeyhI2MukagdVokbcsiqieQGiWWrOHM77eWPYJoEZm6sIc1TBQSE
         CLM4X8ErDaORMEG40dYKWdFS54ByDLikRciwAHLfmww9KHRvKvKNivAlNNShx3j+cqQW
         8SjkECrqVjVBLOznPFdbtY5FYwoVec3Hs2k6MPQo1yVY4KrDe4ibqmaGBAwV9bCIO5yT
         iQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719766122; x=1720370922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtpZiswc8Frh06Fro0Rn2Oot+7AiSiHCpH2d6ugWZiw=;
        b=UXnQ7E3tP+leWSLvhUlZH/jUPJ3EBhQB73kjX5GENB+GOS3JnTqNBS8x1FSg4lESBC
         Br07KnqxtnkB+8obRhH12Vtkd7OC+O8hHyzefNhA8Ptjy3aTd+zqBd7dHJeX9QtHcrTC
         ua/wPuMjiCG4nMq0m5MJHM7DrVRd0hrSs8Gi0T0rN27rFzieiSujkTnSFRSqyXeotqJh
         7pzwcvjDLcnU2bALmqSAYSNO5oFcG9wuyEa9ZZmkB3G7m0Wz8fr1X2F4rOXmbSX1KqCE
         nEgO2cZfekVdxXGCTb6U2ci/g9hxDTtEo0lOKdr0ST0byAXtuR0cpgwFTLvEbV5Mxzxv
         d9iw==
X-Forwarded-Encrypted: i=1; AJvYcCWe+wTLl8S/eov7E+1JV86FBiyHCHowBHNGOUUiU+SxyGdGd/Of+VxFL1T27E1tYsSwccPB0hcAX85mUo1ZaqgBYV0i5DklNliN8Eq5
X-Gm-Message-State: AOJu0YwHVc11StziAqrmLuA5Ndx6yaYe+rrSUFb1zLeUfflEBU0CoR67
	kwbbYhJH0OQL5e9kDi+I49RnSEan8GKIecWu8izST/o8/6YczemilH/nVrzwTzY=
X-Google-Smtp-Source: AGHT+IFe8LtvSKfiScnj6cA+bXz58PKF6siHRWmnd1ywun5R1OuL/3z5Hp9esY9KcJBl6V83EXSZoA==
X-Received: by 2002:a05:6512:1089:b0:52c:952a:67da with SMTP id 2adb3069b0e04-52e826f15b3mr2950955e87.55.1719766121955;
        Sun, 30 Jun 2024 09:48:41 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257c4e1112sm43926645e9.3.2024.06.30.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 09:48:41 -0700 (PDT)
Date: Sun, 30 Jun 2024 19:48:40 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: wuxilin123@gmail.com
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add device tree for ASUS
 Vivobook S 15
Message-ID: <ZoGMaOdyDFjoyqww@linaro.org>
References: <20240630-asus-vivobook-s15-v3-0-bce7ca4d9683@gmail.com>
 <20240630-asus-vivobook-s15-v3-2-bce7ca4d9683@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630-asus-vivobook-s15-v3-2-bce7ca4d9683@gmail.com>

On 24-06-30 16:59:27, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> ASUS Vivobook S 15 is a laptop based on the Qualcomm Snapdragon X Elite
> SoC (X1E78100).
> 
> Add the device tree for the laptop with support for the following features:
> 
> - CPU frequency scaling up to 3.4GHz
> - NVMe storage on PCIe 6a (capable of Gen4x4, currently limited to Gen4x2)
> - Keyboard and touchpad
> - WCN7850 Wi-Fi
> - Two Type-C ports on the left side (USB3 only in one orientation)
> - internal eDP display
> - ADSP and CDSP remoteprocs
> 
> Further details could be found in the cover letter.
> 
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  .../boot/dts/qcom/x1e80100-asus-vivobook-s15.dts   | 616 +++++++++++++++++++++
>  2 files changed, 617 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 5576c7d6ea06..fe08b6be565d 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -258,5 +258,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk-display-card.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-asus-vivobook-s15.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-qcp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
> new file mode 100644
> index 000000000000..34f90e45a5d7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
> @@ -0,0 +1,616 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2024, Xilin Wu <wuxilin123@gmail.com>
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
> +	model = "ASUS Vivobook S 15";
> +	compatible = "asus,vivobook-s15", "qcom,x1e80100";
> +	chassis-type = "laptop";
> +

[ ... ]

> +
> +	tpad_default: tpad-default-state {
> +		pins = "gpio3";
> +		function = "gpio";
> +		bias-disable;
> +	};
> +};
> +
> +&usb_1_ss0_hsphy {
> +	vdd-supply = <&vreg_l2e_0p8>;

I think you will probably want to use vreg_l3j_0p8 here. See following
fix for CRD and QCP:

https://lore.kernel.org/linux-kernel/20240629-x1e80100-dts-fix-hsphy-0-8v-supplies-v1-1-de99ee030b27@linaro.org/T/

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
> +	orientation-switch;
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
> +	vdd-supply = <&vreg_l2e_0p8>;

Same here.

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
> +	orientation-switch;
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
> +};
> +
> +&usb_1_ss1_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_ss1_hs_in>;
> +};
> +
> +&usb_1_ss1_qmpphy_out {
> +	remote-endpoint = <&pmic_glink_ss1_ss_in>;
> +};
> 
> -- 
> 2.45.2
> 
> 

