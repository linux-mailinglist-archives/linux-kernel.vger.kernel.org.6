Return-Path: <linux-kernel+bounces-570459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BA8A6B08F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64934188A5A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D852922156B;
	Thu, 20 Mar 2025 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFhPGhrR"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84D1EF388
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509000; cv=none; b=OqTlKL8WJWk3YlhaA573hKL5b/6DK8VbMbFoF0lQ+SAkRDa/k4/RtFdheWAh68WaXrUvSvE9v5vv3i6jOpkhGKq+wO9ESotXWvZXP+TivTnCq1J/Lm1sW2OdlrixvIQiV+7vIXSzrrIZCgKABFG8+UIFBv6Ul7YhcXXEoOI7JDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509000; c=relaxed/simple;
	bh=XDkXkOYgIyPoo6Enp9hnq1lKySVeP/oOl29rKkY3590=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYiXnHYfomIuC1YNdMKiZcQkaCnW7GUmvbYmx9xNm8mB3txv7hFa+QY/jN5BJqAMesH2yH4CjihmX0fHupz0vyP/pDd+8jKDPj+wy+CRjA95kSWy6xns7B50qVLR3SthM9PmOnxEnFZI/AddYOuuNG3DkjrddG9KL2Nex3k6qag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GFhPGhrR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so9067895e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742508997; x=1743113797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WfPnk7WQgtcfoHo8JXsI+oWzDaDs3bw9jASaZ3sIJgg=;
        b=GFhPGhrR3D2PbkBXSPgE3mgQWcuVmKLcv6Hy74RlsvBBdMDlvsFiRfGT5eN5G15sP9
         aa30XCvaxs7KSBnCgwBoLC5BgZUKhwq736HS2aSwckpoXKfKFNgkpjquo+J2CasyzHEu
         eW2xOfiXD/j7J2Ee9Rq0ssOjkBk9HL3NHie+h0z1jGOfmkQxhdTDxboBibuBANiCQjUq
         NLfCB9/W0Q7DToGsiKPlDeJTPUCM3uOS38uTaMt2+66PYXbY23u78E7lXqwsIcRM3HiK
         sicqhMt/vkH7CKKM9LZ5d5HIbg28RBw/gRIAvaXnTIqHw6BwOZ/ptMja2+YxupqhruHY
         o81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742508997; x=1743113797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfPnk7WQgtcfoHo8JXsI+oWzDaDs3bw9jASaZ3sIJgg=;
        b=TghX0aXQskvGwuK4B32LsKekZLgElfDTEPRngdxRty+APi9Yyb/MJQwVyAIQhU6xkR
         Xv1qUgMcm8apznkxr+jQKf6Q9/t2DZLkCzcRPfvu/h3RdcH4GAf8F4PVJbDlQfjR6p/V
         PrlEqMSjvugUJb5oNWzTFwHGXVf7RjPZMg6nmaWaZPqtctHjQ24R7fWMTB6D19fnhK3L
         kt+YfbmS6VI5lB+oKuEOD3IKPMEi4X1hHGfS8hkxtWUqq4a5kQkW/WNZqC+wcn3C793E
         qkHJeRUxdm0jA8VwkPiaUcICYQV3U9Lm8dSnoz0UTy5CcYlsKHi92z4tqXLNlgHBV369
         Pk3A==
X-Forwarded-Encrypted: i=1; AJvYcCU2ay/du7P4ZoubOOj9KB5j6MIy8jtYz+BJL8cNViIjWN82QXbTyajiQXh/I91iVcUE9c4W4t6yPTAW+wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAlm/rTtVj9o7SIhBtRiFPF998BnDLoEmNzXdBAT3hpRvlVK+b
	FdskTkjL1SYG3OhzVGxFB8rjYGgNe3969GpHQOx7kgm6RD3mt4qU/XF8RsFYpKY=
X-Gm-Gg: ASbGncsepggWbI6MDWnIDBPyPMmK8tjCyj0m9r6rznUZ2bWjWzrjbfHgdsEFBmH7feG
	AnJUJB436NQizeMpIKKSW0rq7Tw9WfbE1lnfX91XL1aBvoXI3nX8AQOD6SP83cNUF60REKTniRY
	fLJFn5580EOVS1aNynaYdK/jDQuOC1DFrop/0lvAjh054KEXrMCp7qVpErPVdz5x4Nebr2kLi+3
	fqvw86prxckBN+E5sVu8V/L7RIGvaVLi06UZY2Aqf49FQEbMK/myRdHPaiqWXcmoGR7rNcrhLw+
	h50632QC2VAyHGJp7Y85jJn09wwMNtshrkjw3N0TMoF+T+BjT/Pw7/woRFPTx6JTnd4P+2i0V2k
	fOLBR31hcpw==
X-Google-Smtp-Source: AGHT+IHNuD3oxALNHIxu9dYwYRUPmP+cyvEmCJ1ayFakdYJH3c8S+O6yOUzhs//I8smCyDXpzHD2VQ==
X-Received: by 2002:a05:600c:3155:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-43d509eae2dmr5415125e9.9.1742508996459;
        Thu, 20 Mar 2025 15:16:36 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd348sm9042715e9.39.2025.03.20.15.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 15:16:35 -0700 (PDT)
Message-ID: <d64b222b-0b4f-4a17-a4db-74079502f7f4@linaro.org>
Date: Thu, 20 Mar 2025 22:16:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100-dell-xps13-9345: Enable
 fingerprint sensor
To: bjorn.andersson@oss.qualcomm.com, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250318-xps13-fingerprint-v1-0-fbb02d5a34a7@oss.qualcomm.com>
 <1nCVo0cfBlz7dR2Jqu8M0rjyv_aRuYvO5M8Ho3sHTuU7-BfteG7JQ6iklpXIsiVEheMKOx4-JSJNsdf37ObJag==@protonmail.internalid>
 <20250318-xps13-fingerprint-v1-2-fbb02d5a34a7@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250318-xps13-fingerprint-v1-2-fbb02d5a34a7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/03/2025 03:22, Bjorn Andersson via B4 Relay wrote:
> From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> 
> The fingerprint sensor, hidden in the power button, is connected to one
> of the USB multiport ports; while the other port is unused.
> 
> Describe the USB controller, the four phys and the repeater involved to
> make the fingerprint sensor operational.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>   .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     | 59 +++++++++++++++++++++-
>   1 file changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> index 967f6dba0878b51a985fd7c9570b8c4e71afe57d..a35557c562d771e2ce209fca05b82c1943d70f63 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> @@ -744,8 +744,21 @@ touchscreen@10 {
> 
>   &i2c9 {
>   	clock-frequency = <400000>;
> -	status = "disabled";
> -	/* USB3 retimer device @0x4f */
> +	status = "okay";
> +
> +	eusb6_repeater: redriver@4f {

How about

eusb6_frp_repeater: redriver@4f

leading to> +		compatible = "nxp,ptn3222";
> +		reg = <0x4f>;
> +		#phy-cells = <0>;
> +
> +		vdd3v3-supply = <&vreg_l13b_3p0>;
> +		vdd1v8-supply = <&vreg_l4b_1p8>;
> +
> +		reset-gpios = <&tlmm 184 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-0 = <&eusb6_reset_n>;
> +		pinctrl-names = "default";
> +	};
>   };
> 
>   &i2c17 {
> @@ -967,6 +980,14 @@ edp_reg_en: edp-reg-en-state {
>   		bias-disable;
>   	};
> 
> +	eusb6_reset_n: eusb6-reset-n-state {
> +		pins = "gpio184";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;
> +	};
> +
>   	hall_int_n_default: hall-int-n-state {
>   		pins = "gpio92";
>   		function = "gpio";
> @@ -1172,3 +1193,37 @@ &usb_1_ss1_dwc3_hs {
>   &usb_1_ss1_qmpphy_out {
>   	remote-endpoint = <&retimer_ss1_ss_in>;
>   };
> +
> +&usb_mp {
> +	status = "okay";
> +};
> +
> +&usb_mp_hsphy0 {
> +	vdd-supply = <&vreg_l2e_0p8>;
> +	vdda12-supply = <&vreg_l3e_1p2>;
> +
> +	phys = <&eusb6_repeater>;

phys = <&eusb6_frp_repeater>;

That's how I did it on Insprion14 and it helps me make sense of the dts 
back to the schematic.

> +
> +	status = "okay";
> +};
> +
> +&usb_mp_hsphy1 {
> +	vdd-supply = <&vreg_l2e_0p8>;
> +	vdda12-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_mp_qmpphy0 {
> +	vdda-phy-supply = <&vreg_l3e_1p2>;
> +	vdda-pll-supply = <&vreg_l3c_0p9>;
> +
> +	status = "okay";
> +};
> +
> +&usb_mp_qmpphy1 {
> +	vdda-phy-supply = <&vreg_l3e_1p2>;
> +	vdda-pll-supply = <&vreg_l3c_0p9>;
> +
> +	status = "okay";
> +};
> 
> --
> 2.48.1
> 
> 
> 
Completely optional obviously.
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

