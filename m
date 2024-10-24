Return-Path: <linux-kernel+bounces-380725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121119AF525
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A4E1C21833
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A2021830D;
	Thu, 24 Oct 2024 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0Wgioe9"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036AD2178EA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808027; cv=none; b=FYl3/XXqS400Rx4tXy+qjsOiEhPTMN6TCYV9b9R3+J7v4xIHYZz4v24OFPuIb+Kqm0dSY0/maoDC7WGr+0RPG1PKohCcQnZNzfJReBT3ayAhQ3VXiCnSUM3Yt/7r9I4fJ31IdbtzgYZhyX4QC95bp7S11HbayRvXX6CYq/8OtFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808027; c=relaxed/simple;
	bh=9lMSENVIJJRpnSCggPkSPu1+oPLoGZ0nvK2QkBlWz30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwVtOhzAqOJefQcjnlkes9WlhoqkNDVNXsM6AEOlC5K+tFc53J+SPKUvpP2FtLZkN6RR1WNo7oViQbT7bdGbAHOSWv+SKnMpU9cHoi2XR2bf+mZOSDtrJE4fVeqOlGVW9TvNtwbgzYb48LqBZ9YkEQ2bEm/XX1NwYY+JNR5GJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j0Wgioe9; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539ee1acb86so1615376e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729808023; x=1730412823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eBfosn3dMOIW9KAAEmKKkFXzmH4oZmgd1l/2Gdt9RF8=;
        b=j0Wgioe9YqQ2C16mKvGay91mHrBVcsi5Jd8gQKpfeZfKwuk60OY4p2jg4CyckncV/0
         +DD/aA8c6Ua0/8JOPqaDUG3BQzVXudxmGySQC3TAVdSVgV9s2melEU/drSD+7o0ueq08
         +DsNj8rI+MAvoycunZMsAFmIJE9cGM43Vh8J2vWIT3I0zaTsFZ8QZDgJ85tKTruGM/EF
         wfElox0XY9tH0ATuwN+RgRrOHPbe1qcgem5swzDuYNTzmJVOy8P2QoMfBBpIVxVNHtaY
         kvdDf7TbebCon2GTbixN3QlMDQlMsqO+Xdd+JFCNOdI35rWbozdkdW0dX53VRmLMygbz
         1apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808023; x=1730412823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBfosn3dMOIW9KAAEmKKkFXzmH4oZmgd1l/2Gdt9RF8=;
        b=ShLeSRyE17OX8/j2i3VdrjC5E8sjmRpS1LDDJ3yeqs03JRCaI1CKZmu0WLMp150K4W
         uEDYLH9HNLaHimMuQcylRo2sfyNadCz3F9wfSGkBEL+lApfY6mv9IREQ+lCWh7tDJj7C
         ggLFzG7FxvxlhVYQT6yUYIEL3sgG6/GsTfnteZ4OcNVDQV66BnyxAWejkWLDtjXkplcI
         O4txBzb/a7ZFhRhfzvW36AM8vTdKLjKYOBPZLj2yeKT9bTvywozpiQY1QKh1mU27oCnp
         ONp0+c8jCHe3nUIr8pPG3IyeLI5R7o4Ens5/JGiWS1xjZGKIdTJqC7sOXXv9u6JdkMIJ
         X9lw==
X-Forwarded-Encrypted: i=1; AJvYcCUzarM3UmXaOtgO4wSx/Z10rTgCnjtgW3f/TQk2xan23oO9RylMiE9580oOYQR40iRcTX0K56KkhvYLYdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyLVOgyyWD/srM4Zkp+VYBfPTYoAdIHd5xT1odlI7J0vkpEb+V
	MGzQdYy53xo4sLlCuLF9lWqDwnJX0n7vSl/8GkyEjJPaTUsI+3i7qEgAp1cXew+IFic1DnAqllr
	g
X-Google-Smtp-Source: AGHT+IFejQ+dzTn6UBP+4jkDIy3TF8AM4cqHLEWGCqd4joA6Qse3z9EVZDKmi3LosTveQZZlcUMUnA==
X-Received: by 2002:a05:6512:3d27:b0:539:e3cc:721a with SMTP id 2adb3069b0e04-53b1a3616c0mr4958178e87.47.1729808022997;
        Thu, 24 Oct 2024 15:13:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e5951sm1477988e87.58.2024.10.24.15.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 15:13:42 -0700 (PDT)
Date: Fri, 25 Oct 2024 01:13:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: qcs6490-rb3gen2: enable Bluetooth
Message-ID: <5ivx2nmsr2buq7huiu4rv23lnuzqq3yhhyydhwmi5pz5lrr6ny@w3o6iawiyj64>
References: <20241022104600.3228-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022104600.3228-1-quic_janathot@quicinc.com>

On Tue, Oct 22, 2024 at 04:16:00PM +0530, Janaki Ramaiah Thota wrote:
> Add Bluetooth and UART7 support for qcs6490-rb3gen2.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 122 ++++++++++++++++++-
>  1 file changed, 121 insertions(+), 1 deletion(-)
> 

[...]

>  
> +&uart7 {
> +	status = "okay";
> +	/delete-property/interrupts;
> +	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
> +				<&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>,
> +			<&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;
> +
> +	bluetooth: bluetooth {
> +		compatible = "qcom,wcn6750-bt";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_en>, <&sw_ctrl>;
> +		enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
> +		swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
> +		vddaon-supply = <&vreg_s7b_0p972>;
> +		vddbtcxmx-supply = <&vreg_s7b_0p972>;
> +		vddrfacmn-supply = <&vreg_s7b_0p972>;
> +		vddrfa0p8-supply = <&vreg_s7b_0p972>;
> +		vddrfa1p7-supply = <&vreg_s1b_1p872>;
> +		vddrfa1p2-supply = <&vreg_s8b_1p272>;
> +		vddrfa2p2-supply = <&vreg_s1c_2p19>;
> +		vddasd-supply = <&vreg_l11c_2p8>;

No, this is not correct, these supplies are connected to the on-chip
PMU. Please add PMU node and use pwrseq subsystem to power up the BT.

> +		max-speed = <3200000>;
> +	};
> +};
> +
>  &usb_1 {
>  	status = "okay";
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
With best wishes
Dmitry

