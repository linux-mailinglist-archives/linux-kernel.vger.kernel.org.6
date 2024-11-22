Return-Path: <linux-kernel+bounces-418103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525BE9D5D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7731F2484E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A021DE8A6;
	Fri, 22 Nov 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4E8tg14"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE73A1DE88B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270971; cv=none; b=XU0I7lkL3tKexKfdIWfvkNxl3r+RfgOpfXX66VKYiqLtdouta8kTb1g9P78hTQhaTjJ1jebc5gB1z0cMe3lT3hg0sqo5AbxL84cabj3UaIBbw6pumPuyj5oHWz03kUdDx2AXJvjIUnBGSTXJOlGqHn4tqdlWREphwjVXkhK1JRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270971; c=relaxed/simple;
	bh=FUMOsTI1XKBWnpseE8vk0dVqvDxYGIbH+QH+cNwOnAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcbxukpHF2SJHT8vdeONZSyoANxP5qvxE8VNiG+8eHVuIFLO8ObCFCddPqOhv2vtlqaozd5FGB/d3BMQ+xCst+nUqYm0fYlKbhU1cnhdebRc9OqwJjoXXlz7GPsE8V+KhzSq/kDQ3lxSFrvVK8LQAVCeUCm7n3YkKMAs53/vYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E4E8tg14; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f6e1f756so2130326e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732270967; x=1732875767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ISPB4u0k/IY3WdqyYBfvJI1MUBGbBsUm1AW/lweuam4=;
        b=E4E8tg14BnFU6aqnJV+wSX/8IlXVgoEozhcYuhOzWUIMXXj6U/X4Yq3ir0TPKLSvd6
         Vj9ly0Og7QiZTArctGx489cqOic4bxWpT9RA/u6c7tvyuOTKhUP+Q7tfHP75diBmXqT6
         F4XhTUWg3pJmwPown+9Ze3iAFllM96aVSgoUxDrKAgI02awf37iODbuoyJDxttorcOfJ
         TY1tom/SIFcGlG1uZSz8HFehAhi4QjG2IZPENCeoL7diEYheTj01EZMpOECijDP3I8Ov
         sKvGzOZyADvNQi5PP1xhVaYV/4Mgp29YQRrDTm51jMZVooXFjx4WhAmsyu/FpNbEwCja
         f7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732270967; x=1732875767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISPB4u0k/IY3WdqyYBfvJI1MUBGbBsUm1AW/lweuam4=;
        b=wPj7LThoymPwpU8cWNwalx/j/AOA1oJDcwZpCbj31fH24fM8AQ49ftZzuCj3+Nf5HO
         lLmqvnJTMQQTHJrX84PtziCJ3JbdzSxZJWXaZ9ex6S1RdFUDQ++rBiL7rWN8rBEpjaBE
         TrBy5IsZu+DiocF53sM/RVtsOKmdo5D+boRcPGCIOGxSBC/akobi9gWqpY0Dri7/455w
         e/LryFXihBQi2ItnQIsHYocKQSGwtqhMRxdRZQFm1L9uIY4h1K5A1ItAic7GZh7eum8K
         BzC2nuq0c/3/L93RUCkzguvQwsV0dx5B+rJkhWagkCDP6W27k0koO6u5+eEW3COeZFiA
         +T+w==
X-Forwarded-Encrypted: i=1; AJvYcCWPv2P1tB93F4WrgVQFYWShR6rx6FdzQpbWEHo13iwueJHvTaS9+44hU7ZWP3jQJGaJQeca1AbAGfW7SeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6T1lNjFS70BOPzOn1RKWfWm10jTzRnWal6aK6BJQ5i5AAnLw
	Meuus8WID35F+ud06xTlh5ANk9rM+8Y05RYQCpEHTG7+pUSWnmZy2VrxnGpSzn0=
X-Gm-Gg: ASbGncsbr/GCnfQfBsBwpwIjBQelssjTdzSKxB2SgK7R5KG3XOidn0qL2nfZszgQg1Q
	ehWcIIAcBgZFXzgllvdocMC8E+ZtIdyrzB5zT7mcroBLRy8/C+oTo1zpsnS5psgezAtrQZcLmlV
	hC5Vh9MOtE3jgWr+njCujalJFtux7ZohLjhKdCMAudDbgKpdjoQnsWSk4RRP+33L/yEryn69jwc
	GxHRD5Dlvmt/WmD+oGiPe4T7D+uLlmUaT8I3j6VEqx36a9u0l9T2I/M3f5ic1iTnUu9r9KIjCFz
	/Q/PTYFqD7gdHEUeWyBi+VX3NbnmuQ==
X-Google-Smtp-Source: AGHT+IFS7C183Wt8hN7C/INKvkL1qt9YbaPn5aBu73dBkn87fnUOLWLXeKl+x6xSQFdRyLKoKS4qmA==
X-Received: by 2002:ac2:51b5:0:b0:53d:d3ff:77f6 with SMTP id 2adb3069b0e04-53dd3ff77fdmr829792e87.46.1732270966827;
        Fri, 22 Nov 2024 02:22:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd88b54cbsm62838e87.214.2024.11.22.02.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:22:45 -0800 (PST)
Date: Fri, 22 Nov 2024 12:22:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Fange Zhang <quic_fangez@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Li Liu <quic_lliu6@quicinc.com>, 
	Xiangxu Yin <quic_xiangxuy@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 9/9] arm64: dts: qcom: Add display support for QCS615
 RIDE board
Message-ID: <azdmcs7uafw3n6cqbq4ei66oybzhtyvdyz2xl4wtaf3u5zextb@vdhbs6wnbeg4>
References: <20241122-add-display-support-for-qcs615-platform-v3-0-35252e3a51fe@quicinc.com>
 <20241122-add-display-support-for-qcs615-platform-v3-9-35252e3a51fe@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-add-display-support-for-qcs615-platform-v3-9-35252e3a51fe@quicinc.com>

On Fri, Nov 22, 2024 at 05:56:52PM +0800, Fange Zhang wrote:
> From: Li Liu <quic_lliu6@quicinc.com>
> 
> Add display MDSS and DSI configuration for QCS615 RIDE board.
> QCS615 has a DP port, and DP support will be added in a later patch.
> 
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 76 ++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> index ee6cab3924a6d71f29934a8debba3a832882abdd..cc7dadc411ab79b9e60ccb15eaff84ea5f997c4c 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> @@ -202,6 +202,82 @@ &gcc {
>  		 <&sleep_clk>;
>  };
>  
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	ioexp: gpio@3e {
> +		compatible = "semtech,sx1509q";
> +		reg = <0x3e>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <58 0>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		semtech,probe-reset;
> +	};
> +
> +	i2c-mux@77 {
> +		compatible = "nxp,pca9542";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			anx7625@58 {
> +				compatible = "analogix,anx7625";
> +				reg = <0x58>;
> +				interrupt-parent = <&ioexp>;
> +				interrupts = <0 0>;
> +				enable-gpios = <&tlmm 4 GPIO_ACTIVE_HIGH>;
> +				reset-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
> +				wakeup-source;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						anx_7625_in: endpoint {
> +							remote-endpoint = <&mdss_dsi0_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						anx_7625_out: endpoint {
> +						};

Where is it connected? Is it DP port? USB-C? eDP?

> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +	vdda-supply = <&vreg_l11a>;
> +	status = "okay";
> +};
> +
> +&mdss_dsi0_out {
> +	remote-endpoint = <&anx_7625_in>;
> +	data-lanes = <0 1 2 3>;
> +};
> +
> +&mdss_dsi0_phy {
> +	vdds-supply = <&vreg_l5a>;
> +	status = "okay";
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

