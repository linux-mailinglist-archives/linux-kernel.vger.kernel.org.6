Return-Path: <linux-kernel+bounces-449379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7359F4E00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448C1162E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9821F63D6;
	Tue, 17 Dec 2024 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JK1BeZq3"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000D762F7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446418; cv=none; b=rTb/LMK75V4lkd01Db3lyY8/4jsOoBakADHBRjdBjzjCEmBWjkMXRP7D8PBtgDtkFVxpTAQAbgrhXiaQRt3wG3iMxiD1rJtnJzMqXTUvSOfJZPl3U4l+JJurZcVrW8XUKI/ZJ8T9vbhUZrK1J9rvXcWaPF2mFVxvVngTP/4po28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446418; c=relaxed/simple;
	bh=A1XIGvxeV2VFnVHx/hseqMs44z6j0pkz+jZmIS1lBRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhLdZIgbPYiapH7rduP+WpsZTRmWevHMZlhRf30PtwWFzeNQRAKuduS65acdSIo5d3Yc75wu6yPVOoDVGJJQ+OHFTKHbWD25+539X3gLueZ2WJ1ZyYgl6ROySsb9NvurH+eB3Ryk60Vt9MIri8vGP37iBvJghWJv1CH4aXZo+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JK1BeZq3; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e384d00f4so898845e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734446414; x=1735051214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9YMcdH8avPXNZfQXLzQwJPKuLvhjYfkBvWblo32XnJE=;
        b=JK1BeZq38goqQ2ScIjraNlI3hNTCaATKIyCplz7emQJ3p8YJaYfhCZMGEr0AHlYKKe
         9UP3CSGccZSVJXhEphPIWxV+xYzVqZnYAyNjlr+AsC18h0AoTvZBspzhTVoTNFqSABA0
         rag/TYLvsubt79BMkzg3WsNp6n2r7D/BNSTISVuFzk0V+jB4vpx6/OMY/AbJCeqFPlhy
         pSHfFkaXCojy7JGcfeXY/eNnq3ttUTIQDM13vw/NdLeIJg98jjzdMq0ExHNxh/PZ0YCi
         6BNpsykFYrYXZp+u4dvDNT+On9H1tX+nMiv6fM8KtSz0wLOFX8X7+bQatnkH2ophjjIc
         MnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734446414; x=1735051214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YMcdH8avPXNZfQXLzQwJPKuLvhjYfkBvWblo32XnJE=;
        b=trFI2sAgWeXAm56CH/mY8tuln+ckyEiKpIv3HcRcQ14SaLgi252s1KpYp9/u41VIKm
         nyw19vBz/CWl5nP1QewyQUINuNnoaD1uhQNNuQEgMboLjuZzsPAgSgyqdxHArcGUSlGl
         CYj1VqUphafmUEFDSoZvJDwjBMtR6IknaQ30IvNKxOnm/KYkxbMWZPxN3eCZlBZuM6Jf
         qnI2A+dODKjiddnGX2KlXDBQjId7mSBpU0U8L2ndZ2/OWwPcRQP2fHhn66dgwUdaeMQb
         9GJD2jGUSGe9t6ifG0ErAEUXKVitGVbilJg33pBmcFsSbSpc9DivQinGjMJq3q8cFhfT
         +8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVMRDuA8ovNeec4ADaHCV+U6k9MAk4X/iz3+xEJZjW5T3YaC06j0DKXQ2GPexbSjypDK6qpcnjwGPKpVfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXrR4ymvtbsEkdiVeM5IabNYsN7X7RXWM8oRurK5F9F5kiJ3U
	Y3gfEyPK+84FggejDuELelMMXbMU+0UZ8IhWal6HivVAc1H4cf/mckUuX+u7Ve8=
X-Gm-Gg: ASbGncsBtyY2mjFIWLq1c8X1bYtbBenTEL3SvAsM8LXcWdNG4DpdBKwhRb7tRkqP3j6
	q6yBByyvppJvtkDOYuSHSXsW2jGyLqvVb7qsM6inEPuJxCm0pgjeK/P4GFpUQxTUVUfppm3ddX0
	k6QVdMfw3LgpnM+Eh0RfgayRIiAO75qKAUvXW+rt+HaURQsppLuGBwkmtQwILWXHl7OS8D85oCu
	glseMoZPVEdzzmeoHFx8ZuCAqiO2g2XAbSzcljRaKbYsNQ39sxo8r4auQiWXCW3qQ1fMlsmgaf5
	uel2KsSju6/O6mUXgiF9xMeV1J4TuPHJTZI=
X-Google-Smtp-Source: AGHT+IHOWR0Y5fR+2uxPBxCjytt0LUgJIVwtzY4VhNEtFXNjP9j8AdE4VL7hkzuX+HhMism2gVrkcA==
X-Received: by 2002:a05:6512:68c:b0:53e:3756:80b4 with SMTP id 2adb3069b0e04-54099b6d711mr1779475e87.12.1734446413951;
        Tue, 17 Dec 2024 06:40:13 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120baa73csm1180366e87.101.2024.12.17.06.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 06:40:13 -0800 (PST)
Message-ID: <22479c27-9265-4994-8974-9739ecbae5ee@linaro.org>
Date: Tue, 17 Dec 2024 16:40:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/4] arm64: dts: qcom:
 qcs6490-rb3gen2-vision-mezzanine: Add vision mezzanine
Content-Language: ru-RU
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 akapatra@quicinc.com, hariramp@quicinc.com, andersson@kernel.org,
 konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20241217140656.965235-1-quic_vikramsa@quicinc.com>
 <20241217140656.965235-5-quic_vikramsa@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241217140656.965235-5-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 16:06, Vikram Sharma wrote:
> The Vision Mezzanine for the RB3 ships with an imx577 camera sensor.
> Enable the IMX577 on the vision mezzanine.
> 
> An example media-ctl pipeline for the imx577 is:
> 
> media-ctl --reset
> media-ctl -v -V '"imx577 '19-001a'":0[fmt:SRGGB10/4056x3040 field:none]'
> media-ctl -V '"msm_csiphy3":0[fmt:SRGGB10/4056x3040]'
> media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
> media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
> media-ctl -l '"msm_csiphy3":1->"msm_csid0":0[1]'
> media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
> 
> yavta -B capture-mplane -c -I -n 5 -f SRGGB10P -s 4056x3040 -F /dev/video0
> 
> Signed-off-by: Hariram Purushothaman <quic_hariramp@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> Signed-off-by: Trishansh Bhardwaj <quic_tbhardwa@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile             |   4 +
>   .../qcs6490-rb3gen2-vision-mezzanine.dtso     | 109 ++++++++++++++++++
>   2 files changed, 113 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-vision-mezzanine.dtso
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 4686f2a8ddd8..a7e88fcabded 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -115,6 +115,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs615-ride.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
> +
> +qcs6490-rb3gen2-vision-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-vision-mezzanine.dtbo
> +
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-vision-mezzanine.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs8300-ride.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-vision-mezzanine.dtso b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-vision-mezzanine.dtso
> new file mode 100644
> index 000000000000..7782c4aee576
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-vision-mezzanine.dtso
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/*
> + * Camera Sensor overlay on top of rb3gen2 core kit.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/qcom,camcc-sc7280.h>

Please sort the header files alphabetically.

> +
> +/dts-v1/;
> +/plugin/;
> +

Please put these two lines right after the comments header.

> +&camss {
> +	vdda-phy-supply = <&vreg_l10c_0p88>;
> +	vdda-pll-supply = <&vreg_l6b_1p2>;
> +
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* The port index denotes CSIPHY id i.e. csiphy3 */
> +		port@3 {
> +			reg = <3>;
> +
> +			csiphy3_ep: endpoint {
> +				clock-lanes = <7>;
> +				data-lanes = <0 1 2 3>;
> +				remote-endpoint = <&imx577_ep>;
> +			};
> +		};
> +	};
> +};
> +
> +&cci1 {
> +	status = "okay";
> +};
> +
> +&cci1_i2c1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	camera@1a {
> +		compatible = "sony,imx577";
> +
> +		reg = <0x1a>;
> +
> +		reset-gpios = <&tlmm 78 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default", "suspend";
> +		pinctrl-0 = <&cam2_default>;
> +		pinctrl-1 = <&cam2_suspend>;
> +
> +		clocks = <&camcc CAM_CC_MCLK3_CLK>;
> +		assigned-clocks = <&camcc CAM_CC_MCLK3_CLK>;
> +		assigned-clock-rates = <24000000>;
> +
> +		dovdd-supply  = <&vreg_l18b_1p8>;

Please remove double space before '='.

> +		avdd-supply = <&vph_pwr>;
> +		dvdd-supply = <&vph_pwr>;
> +
> +		port {
> +			imx577_ep: endpoint {
> +				clock-lanes = <7>;

It is an invalid property/value of the sensor, please remove it.

> +				link-frequencies = /bits/ 64 <600000000>;
> +				data-lanes = <0 1 2 3>;

data-lanes = <1 2 3 4>;

> +				remote-endpoint = <&csiphy3_ep>;
> +			};
> +		};
> +	};
> +};
> +
> +&tlmm {
> +	cam2_default: cam2-default-state {
> +		mclk-pins {
> +			pins = "gpio67";
> +			function = "cam_mclk";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		rst-pins {
> +			pins = "gpio78";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	cam2_suspend: cam2-suspend-state {
> +		mclk-pins {
> +			pins = "gpio67";
> +			function = "cam_mclk";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		rst-pins {
> +			pins = "gpio78";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +			output-low;
> +		};

I have doubts that it's proper to embed a reset gpio into driver's
pinctrl suspend/resume power management.

Konrad, can you please confirm that it's really accepted?

I'd rather ask to remove this reset pin control.

> +	};
> +};

--
Best wishes,
Vladimir

