Return-Path: <linux-kernel+bounces-439415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCC69EAEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D316D1880552
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F399A19CC1C;
	Tue, 10 Dec 2024 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6PspFLi"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ECA198823
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828545; cv=none; b=W8CNzlyeod81x5AfSv8EyveOxCFSSRYm6svpXF2PmI9RwPDY7CLvVdwau9qmAuTqpTY1oGN5gi857H+VZeq3tDfQ+iY9p69GlXPVHhJdywEwzEFtLG8tGGVfflqGma6I+MadW5tbCEFA+Cq96ScG+ZhHw7X9WMf5iYOoSYNl0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828545; c=relaxed/simple;
	bh=DNo6FDFuEfWbaNhgVAj/2RWAC5OMfkXtgieNFFRPoWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQNe2RuAnjFgV6Qxs+y8yMCnKl8bsVeN+g4f3x2Dpq653hev/kn/n6ISlSzir4OWe4yJq6R9Yad+VreS5au23D5NTxTKW2cd/chzjaQLDmHFNxp9R0GSYB3Z96bCoENUzuPZzgV/FI+gBwKPESCkZsAlcEtrXh0Dwofu5kSSYGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6PspFLi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-540215984f0so1704282e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733828541; x=1734433341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLSLnG5Y+Q5zBa0vxq3CyVrMI+PkK9k80FsG1LPecs4=;
        b=l6PspFLi8+2zMzKIuQ6gfct3OyHyQEOSn200eQxnzVnaR/Cd5EiQCwpy1esOW8DLaV
         PW7V3AA8OBtCVChzlWZSc6RzqLNqiU2tAN5ZGF66bnxIBlVF5E56l0zbVJ2eajjylJ0k
         naEZRj2FKwegmA/MS+/YEkzrE9W5lJgJ3+Qn+OSaj3wpCdw0f7OQk7QjMB+Vd4tfxpHC
         nVny+4nkyXFS6KLwoAnVl8WV8dqaRDaU+qtSA3KzhlEhwScDeMtW9RW8Kan5BKjpkp/7
         znbkj9/ct+thhq7u3blvFz9IXF7de9Yy6gKv89uy8Pz7GGdCo1zd7rGaYLtVYO6iqSwm
         b0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733828541; x=1734433341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLSLnG5Y+Q5zBa0vxq3CyVrMI+PkK9k80FsG1LPecs4=;
        b=XxISrAlWtkJZP0GQsqw315NFjl8mm8kSERxQSVZ+6OzeJyZMNJ2MVdj7A7QuiMIeY/
         +lRsH15CUH4yV4/iCaFbksXs4W63Lp+cPpgvi8MHtQ+uTEekHXuNPaSwX7tKFqgB9jWl
         qo9+zg1x5k0bG37YUGZNd5+ZFW4Z7Rwz+0RfJMa10T43wkPGpaxhSPWm6IYeCYNiSTIH
         I3DXWoj2FyZ3sTRCUqod1EMzjFOZCeIA8XsiLPm8GTHuQBZNlQO7j/W3HB7qpXN1WZaU
         +Hf8e3gGaPDUZ9j46boAryTlJfVyfSchaLrXc6WBtKHYtYTLC2f8JZbribkxzLhx0w8n
         QQEA==
X-Forwarded-Encrypted: i=1; AJvYcCVLnPdcXVMDCf9sJT6RYsN9exrBM876tzLg//jNzuHSpqWcjFJaPZKHsoiQs1x/tUZcRCmds79Ngr6boKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykXOuIpfW3kQV8UJnggZyuTOB1ke8qpleSYwlb89SUEbR+EzAU
	AR9ded1zfCJZ8cfxyPANUwJIL90qYGNTbkBnlnXMMQYwc9Zr5ECCn12f18brGEY=
X-Gm-Gg: ASbGncu/WkB38f+gH3iV1b6Drrjkusl8xz8iL6WXDQLn7ucIQNXjlInvStM3gt8toVE
	ZQg5xcBSXcMKBjuJPFyWxMBjt5HeckJvOa5h4N3+FQu82NjZ/Baql9j6o02Tvqv6BS8vqGv4W90
	cEfT6INkK2bUMQQ1L7A9ZY0hdp9cr0lTXFP8OOhz9XV2cKkiHjGK16oFp6EAZnXF2IbL7RoIMnw
	BEhhLVbU6UjmImJwERHsi73yGyadGiuZZ8+F3y4N5lSLG9Jp7o5QMkxCJFTpv6IpgCoyGwfh1Re
	hTf1t+GyckHFI/6oLzFvq+25/S0+vr8wkA==
X-Google-Smtp-Source: AGHT+IGd9pUHyOFytE8kKcuQvQX5JanFuKXTkqWjRgdaLSxeotjVnnczl7OXF6dV39l7CqIuih4Vog==
X-Received: by 2002:a05:6512:104b:b0:53e:362e:ed6 with SMTP id 2adb3069b0e04-5402410d24emr1565097e87.50.1733828541548;
        Tue, 10 Dec 2024 03:02:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e39ce0551sm1148049e87.29.2024.12.10.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 03:02:20 -0800 (PST)
Date: Tue, 10 Dec 2024 13:02:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Fange Zhang <quic_fangez@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Liu Li <quic_lliu6@quicinc.com>, 
	Xiangxu Yin <quic_xiangxuy@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 9/9] arm64: dts: qcom: Add display support for QCS615
 RIDE board
Message-ID: <cfdyvcxdkmf4sv5f75koflayyx74wd3tuscdl7byp5peaag5ty@yhr3275jhftn>
References: <20241210-add-display-support-for-qcs615-platform-v4-0-2d875a67602d@quicinc.com>
 <20241210-add-display-support-for-qcs615-platform-v4-9-2d875a67602d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-add-display-support-for-qcs615-platform-v4-9-2d875a67602d@quicinc.com>

On Tue, Dec 10, 2024 at 02:54:00PM +0800, Fange Zhang wrote:
> From: Li Liu <quic_lliu6@quicinc.com>
> 
> Add display MDSS and DSI configuration for QCS615 RIDE board.
> QCS615 has a DP port, and DP support will be added in a later patch.
> 
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 89 ++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> index a25928933e2b66241258e418c6e5bc36c306101e..694719a09ac46bfa2fe34f1883c0970b9d0902be 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> @@ -32,6 +32,18 @@ xo_board_clk: xo-board-clk {
>  			#clock-cells = <0>;
>  		};
>  	};
> +
> +	dp-connector {
> +		compatible = "dp-connector";
> +		label = "DP";
> +		type = "mini";
> +
> +		port {
> +			dp_connector_out: endpoint {
> +				remote-endpoint = <&anx_7625_out>;
> +			};
> +		};
> +	};
>  };
>  
>  &apps_rsc {
> @@ -202,6 +214,83 @@ &gcc {
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

Use IRQ flags instead of just 0 (here and further on). Also it might be
better to use interrupts-extended instead.

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

Add empty line before device nodes (here and furher on).

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
> +							remote-endpoint = <&dp_connector_out>;
> +						};
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

