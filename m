Return-Path: <linux-kernel+bounces-513524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC79A34AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E623B7A2FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC914D428;
	Thu, 13 Feb 2025 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lomr7dAH"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEAA28A2AF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465813; cv=none; b=EXta37+3XLqTB3m92W19GTnZjEjHI6QRdJAaGxZefwVJz+2oaQ5sysRZ5uzcdzA44vcJrbVyxs/d8ys1awcxplFN5PXkAsPDoKTT+n3koOc87l9Ig8UuVoweHfPKIg+//PeFYxXlnHECXftqqGNTL18lLMhW0ORHbhI5/Utlb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465813; c=relaxed/simple;
	bh=MvrtoHxe/saZ1n2D1pB5Nw3joZKQpDZfJcJqITQNRDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNOl/lj9qJ2r7GR6MDRlpy2p7cUtYFHcySrxOL0o1yRStv6mbp/RyIBmNEgKsCc/4gKObEQaDcmWAVg1BkBGM9NBhvklie+lF6ry/623b4wWkIf+Zur5DP0hw1uGBkv372i0Y0NIyDmIgxV3f7Y1MzCaDA8pVzxJCj7+R6FMgu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lomr7dAH; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54509f46614so1100831e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739465810; x=1740070610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YyQ7iBPn2LLvOrCnmEhJGLbqAv4rLkRdUEyL8CZvRP4=;
        b=Lomr7dAHmAHUkv3zN+ZuzLXpCcP6Uc/LXY2Z/i1OeuEHTaOD1Ww3+4fKKTBY/HMfIi
         bBihgTmwD4PHmAP7wonR003TcsS5hs4+yMJCznPSfumy6a3pJ1Enebr3slolsjB3aMIh
         CyvZJWY8XEZcroZnVOgwt2Zz16pLFMfJqjDOu7F0HM65UAK0qy6seamruhHfc8yVdaxq
         HC2sarvy+DdspLEqNbIq+wqYUovg2Z8ZT1Vc5rsPkRAidbmPxkYBKHFlUZAWYEb9FdwU
         no/0FAeNGN7xKCEawrhZ5CF+qdm1Akug8QlVqaql55gCuL/xp0JOVjw3/BMMSZ78hSM5
         Dd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739465810; x=1740070610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyQ7iBPn2LLvOrCnmEhJGLbqAv4rLkRdUEyL8CZvRP4=;
        b=UIqytSY82AoW0uVT+INiW4qii9vtqJMfbqsYqFAgJJ/mVkqatr6j422HnP7AYtaSel
         uosokmapdKmdCzndY+H7F8h0RdHRKFmCU7PPVNME6+7g6EfgVxUgVHIlBlnkiiGP0j/g
         4oHLybu54phOcF4KLP9unmvSHYBE82ZHY2LC29NaM7XlnEa0eGleA80sgbxP40gMdzV2
         1FUxAvnoT+j5YW4mWoEXVsUYyzAd8IXBOsBffEjmGQPgXaAFbfC5wO1DW29p2aKOZkZ8
         mM0w8my2nmDOluOA6u1sHOuMQczY6bMHkUToBxZ5dmqdLljl9UerT52wVgeq48ZYRNou
         x/3w==
X-Forwarded-Encrypted: i=1; AJvYcCUN0sViEwJrFpRym5Db8hz1y6xPOY9KWYhLNUai+IUeQlD7sqx2vD0EIdDKHMopdUuKS16fIZJHXkhhRXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3TAmSJs/K/A2Dg8XhYPy6/G03X+jIQD2Eu2urPRjuGOdvhh5J
	h9yqUGiHxygbTKW10VuhTOBpAMonK8NAWGhs9sRlSOGpMFhOG17MuUBH26AhmbA=
X-Gm-Gg: ASbGncuVnpIvmLG1as45N0MxD2MuEjj1vf/MR+fbxiPQ8UNZUo9cfau7QjWVQ5HyXNS
	zapIAs+XPChkyE21Gnxl40U1xvsorSfQ0xcaUNi7rE0WKTG6CSLIu1K/ZN29PUNtZrUFnP8yGoE
	47oybxQ/xLaJ2xge94sMOVwHIIgT1dtr0JUJyaSKQK6dXD9u7J1zcoSsUDesIfa9/sAqSfUQnHX
	QM0e/B1+zM4UWSEVmgq6MXvMSMKR/fYLN9NibpAFrwhJc8OwYFQdwO/pWCKXaLiaVey1lbChA35
	RzhpjVxYBUVWjY5Bn4VnkmSF2fsEC6MK/vUkYVJ9gjcWMj1XGJspMV3fgQ0KhPBAiPTmZuo=
X-Google-Smtp-Source: AGHT+IHPp7z9mHrglxs4Ys3IyXNLHHY1OQEK7JqWZvEuKQ6rWpt9p/SBEJZ/ltRNQXoWyTRbRwY6vQ==
X-Received: by 2002:a05:6512:128a:b0:53e:3a7c:c0b5 with SMTP id 2adb3069b0e04-545180e5df1mr2549482e87.10.1739465809683;
        Thu, 13 Feb 2025 08:56:49 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f10cc28sm221256e87.201.2025.02.13.08.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:56:48 -0800 (PST)
Date: Thu, 13 Feb 2025 18:56:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
Subject: Re: [PATCH 4/5] arm64: dts: qcom: qcs8300: Add gpu and gmu nodes
Message-ID: <p36nz6p6bbzur7uoitbzc63hv4qf7hhsix3mqa36igarasj67b@evcdfpeybgsh>
References: <20250213-a623-gpu-support-v1-0-993c65c39fd2@quicinc.com>
 <20250213-a623-gpu-support-v1-4-993c65c39fd2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-a623-gpu-support-v1-4-993c65c39fd2@quicinc.com>

On Thu, Feb 13, 2025 at 09:40:09PM +0530, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Add gpu and gmu nodes for qcs8300 chipset.
> 
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 93 +++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index f1c90db7b0e6..2dc487dcc584 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -2660,6 +2660,99 @@ serdes0: phy@8909000 {
>  			status = "disabled";
>  		};
>  
> +		gpu: gpu@3d00000 {
> +			compatible = "qcom,adreno-623.0", "qcom,adreno";
> +			reg = <0x0 0x03d00000 0x0 0x40000>,
> +			      <0x0 0x03d9e000 0x0 0x1000>,
> +			      <0x0 0x03d61000 0x0 0x800>;
> +			reg-names = "kgsl_3d0_reg_memory",
> +				    "cx_mem",
> +				    "cx_dbgc";
> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +			iommus = <&adreno_smmu 0 0xc00>,
> +				 <&adreno_smmu 1 0xc00>;
> +			operating-points-v2 = <&gpu_opp_table>;
> +			qcom,gmu = <&gmu>;
> +			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> +			interconnect-names = "gfx-mem";
> +			#cooling-cells = <2>;
> +
> +			status = "disabled";
> +
> +			gpu_zap_shader: zap-shader {
> +				memory-region = <&gpu_microcode_mem>;
> +			};
> +
> +			gpu_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-877000000 {
> +					opp-hz = /bits/ 64 <877000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +					opp-peak-kBps = <12484375>;
> +				};
> +
> +				opp-780000000 {
> +					opp-hz = /bits/ 64 <780000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +					opp-peak-kBps = <10687500>;
> +				};
> +
> +				opp-599000000 {
> +					opp-hz = /bits/ 64 <599000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					opp-peak-kBps = <8171875>;
> +				};
> +
> +				opp-479000000 {
> +					opp-hz = /bits/ 64 <479000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					opp-peak-kBps = <5285156>;
> +				};

Does it have no speed bins or are they pending on the nvmem patchset?

> +			};
> +		};
> +

-- 
With best wishes
Dmitry

