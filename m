Return-Path: <linux-kernel+bounces-234912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D7291CC5E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1625B21E06
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA24D8BA;
	Sat, 29 Jun 2024 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkCQSxq3"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED7B44C64
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719660171; cv=none; b=O+A84N2+nEsVb4FWIZyDuUAdgL0BZwwQoALdr8UpL/BVU5tYJ+zBwX8VpQ9OPZcGQgD0unk2dA2c5IquZnDUPuzzB6luVsFX7FNtSlw9vYUncqGJTiPTUmwcu+3r4AoYb8hbbTQZ+k4lexKpP1PtulORCCo7wqf+EgSKc98EZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719660171; c=relaxed/simple;
	bh=Av93i/QyUh4OYcXyVOOSs9eI7fMpyKFObao+NmMCYUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNHDM1au79SrRBemcSs0AHUOR0Sks1Xw7mHv1dL1SEtYsRPOIKaA9ngllhDqhSOv8C5/Xrul20yXKW0q9fS0CX8nznB0moijgvpWwIg0vg4Khx4aU9Z6GcRhOJtZKhDjBotfNOuQNmF1wuLJ03+IKMgR7d/95HrXfr3ynkLxjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HkCQSxq3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42565670e20so15154255e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719660167; x=1720264967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDoFQoEVoTH0KyrppY3Q5bf7siRqAXS+wrJGNY8J5w0=;
        b=HkCQSxq3QPv7O1BaSJ0FGj2cOYfo/oZr+TW5QXwqWBMCHgWeaplOs46pNlWqzxW5WB
         g+hLfLkez9vMER1xBk5p2ShIczc2RwQHSm+OHwJP78PhKndTugVdq2ZBU5wXHzDK/o3M
         XhBObMRkAWj14EW4ON+TCUoCVl1EEkjcOOB08MDNn0G/0DZfbl/BogWmVAPpP2qdY7dI
         i3FHgS2vTA32q8g4gt/Woa/6YISOqLR9SbrSv0hogtcxorLb1uwquJ247QLLuQ2JIAUk
         qvhHSW3AcLX7ZiyiqrPPaKOsNcz1kzU4owEkiESIk7AqfujyLpa+sciHGKr6W+ggdwmr
         rn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719660167; x=1720264967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDoFQoEVoTH0KyrppY3Q5bf7siRqAXS+wrJGNY8J5w0=;
        b=qqwxumhXO2QtKfzkVJnsS650m5U0pqi1n4LptxEzs+gDLIyPaj6ngE0XAaJ7J1Qm9f
         E7qkVxHbHWf5VGJgYXDfCxvt4NdAuMRmvG1xyBaqqajFTRkS3VJzoHlQCFtEhyhRpEQ1
         3R5wB4jy+Xpx+3PMSOPtFzRuemBkIh6LErWXfXgYFHxDqssZs/yG5hy5MM9UJEqRncMi
         W5WS0tbzjTMXv9NZVD4Q+pSa7FQI7EIYRXgsdT1tknv/f3PLfnIv752cRCNZz574oPk5
         i5gHOgKbvfr7CeqnY1i9NMDYZ0wRdoE4MqBcB0DCmZebKLDbzRe8qtE+GegCqXkyVo+n
         /d3w==
X-Forwarded-Encrypted: i=1; AJvYcCXjDTtd6z8yEnOGpQRhxJL5orvxsB+ciwRgzhDbeFqWv0ORBUcUGzq4ynl1PbHT7dN2DbixxiDonzes0Bg430FWojP08z3qD4p5mckQ
X-Gm-Message-State: AOJu0Yz3xY4TvIGoATMtCXHIcQvW9wjJLQjj15v7rQi5JRiYSXw12HtM
	mMdzhEc4HMrDJbC5JonRno/Gw0PhLwZ98Z/otvGkJkINmrP5dbiOZhiRNf+LUQU=
X-Google-Smtp-Source: AGHT+IFnPf4gdtng1h81DxL6ov04hUIHNKlMLZdAa4y0dEXy3qbzBXoIaMxSrv7huJ7B6ferjV9jcA==
X-Received: by 2002:a05:600c:1994:b0:424:ade3:c6b7 with SMTP id 5b1f17b1804b1-4256d4c1b1dmr39012145e9.2.1719660166761;
        Sat, 29 Jun 2024 04:22:46 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a2bcsm71749135e9.36.2024.06.29.04.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 04:22:46 -0700 (PDT)
Message-ID: <90fa688a-8107-4c7e-8056-761f7432dff8@linaro.org>
Date: Sat, 29 Jun 2024 12:22:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm64: dts: qcom: qcs6490-rb3gen2: Enable IMX577
 camera sensor
To: Vikram Sharma <quic_vikramsa@quicinc.com>, Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kapatrala Syed <akapatra@quicinc.com>,
 Hariram Purushothaman <hariramp@quicinc.com>,
 cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Loic Poulain <loic.poulain@linaro.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, Hariram Purushothaman <quic_hariramp@quicinc.com>
References: <20240629-camss_first_post_linux_next-v1-0-bc798edabc3a@quicinc.com>
 <20240629-camss_first_post_linux_next-v1-4-bc798edabc3a@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240629-camss_first_post_linux_next-v1-4-bc798edabc3a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/06/2024 19:32, Vikram Sharma wrote:
> Enable IMX577 camera sensor for qcs6490-rb3gen2.
> 
> Signed-off-by: Hariram Purushothaman <quic_hariramp@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 67 ++++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index c4cde4328e3d..237231600dca 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts

I believe the rb3gen2 can be sold with and without the camera mezzanine 
[1], so the approach we have taken for a similar situation on rb5 was to 
have a separate mezzanine dts which includes the baseboard and extends it.


arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dts

Please replicate that model here.

[1] https://www.thundercomm.com/product/qualcomm-rb3-gen-2/#versions

> @@ -513,6 +513,73 @@ vreg_bob_3p296: bob {
>   	};
>   };
>   
> +&camcc {
> +	status = "okay";
> +};
> +
> +&camss {
> +	status = "disabled";

once you move this into its own dts the camera should be enabled by 
default for that .dtb

> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* The port index denotes CSIPHY id i.e. csiphy2 */
> +		port@3 {
> +			reg = <3>;

copy/past splat from the rb5

port@3 means csiphy3

> +			csiphy3_ep: endpoint {
> +				clock-lanes = <7>;
> +				data-lanes = <0 1 2 3>;
> +				remote-endpoint = <&imx412_ep>;
> +			};
> +		};
> +	};
> +};
> +
> +&cci0 {
> +	status = "okay";
> +};

You're enabling cci0 here but not the sensor for it - presumably a 
monochrome sensor attached to one of the other CSIPHYs.

Zap cci0 here until you add that other sensor.

> +
> +&cci1 {
> +	status = "okay";
> +};
> +
> +&cci1_i2c1 {
> +	camera@1a {
> +		/*
> +		 * rb3gen2 ships with an imx577. qcom treats imx412
> +		 * and imx577 the same way. Absent better data do the same here.
> +		 */
> +		compatible = "sony,imx412";
> +		reg = <0x1a>;

The commit log says imx577 but the comapt string says imx412.

Choose which one and maintain the namespace. Its an imx577 right ? 
Upstream kernel has the relevant compat string

Commit: 1251663220d9 ("media: i2c: imx412: Add new compatible strings")

You can just cherry-pick that commit to your kernel and then the 
upstream dts and downstream dts will be compatible.


> +
> +		reset-gpios = <&tlmm 78 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default", "suspend";
> +		pinctrl-0 = <&cam2_default>;
> +		pinctrl-1 = <&cam2_suspend>;
> +
> +		clocks = <&camcc CAM_CC_MCLK3_CLK>,
> +				 <&camcc CAM_CC_MCLK2_CLK>;
> +		assigned-clocks = <&camcc CAM_CC_MCLK3_CLK>,
> +				 <&camcc CAM_CC_MCLK2_CLK>;

This looks funny - why do you have MCLK2 ?

One final thing, you appear to be missing some power rails here no ?

e.g. rb5

         vdda-phy-supply = <&vreg_l5a_0p88>;
         vdda-pll-supply = <&vreg_l9a_1p2>;

---
bod

