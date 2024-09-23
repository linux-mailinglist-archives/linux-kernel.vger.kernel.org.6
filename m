Return-Path: <linux-kernel+bounces-332080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93597B528
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2F21C22E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 21:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82C51922DA;
	Tue, 17 Sep 2024 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vc7xCuoy"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79918893F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608431; cv=none; b=P8E7jZgLhD+5xcsU4WfF1UouomyetZxXYVyopihbfHbGlAZB3a5DFsZyyywxiCc4ARVt8z3At0qJl5sGa7WH/COFAbdSYJ1a4QIwtVl8oYBmeQgQKEEer8C5pHfoMkPYNmel0EFUJwArzx4u1Tn/JJYK+iG5VRNoQMhj+kHCvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608431; c=relaxed/simple;
	bh=6c9f9GMk0RwJmVnM261XKRTWoq80B+gB/g6JMY3uYy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSlCk55aP9KzqkgGlXrIpl4c9wVmHJOvIakVupsRlIGwkbJu9XxWUqEuuDRycz+Jfn0wbzGtMMdoD5S00PT8nSWuEq6/fh/7O8LiaHPDMoITw0xr6NoiPSUR+12fqWHm0rxVkLwEbA5GMOvKfih93ey9XStSKxtgpEDguudGif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vc7xCuoy; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so64558111fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 14:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726608427; x=1727213227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tK+eryvZIWB7XUY6xEZS8PhI/lDVITII9hGxNEZ3sN0=;
        b=Vc7xCuoyqm72XUQEgmzEsSrnaV6Y+0UjosmGGP4scYrV0ad9zZx882+GogUe+Olb9A
         0ROtun+rRwlW+qYayiKeJRKivFaxn3TUkYf57yomLDALft0bhgCsEAcBolXLrCV9zOg2
         QqtQVgq05Y2wiMnhOqrviEogJDiXNI/NA8HkjnTZtGcyUoWiUGwfqM3kTfM1/QoWF5Y9
         dG1S3PibQHNBSwhS2QOoIxmDJ+tfvBPxoG3GocDiEKKuvBOmfe6lKQzfAGXhnmA11NLG
         ha9XbtEhjZNuMSw++0wGh1NIitV2DeJoA6r/psdwMRvP1296r8ZQKj1fKbXAMU7lJ7Q+
         gNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726608427; x=1727213227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK+eryvZIWB7XUY6xEZS8PhI/lDVITII9hGxNEZ3sN0=;
        b=K6jPxqqhPipZq8r7SQ+F8UbEHHntntFbUElSrxGHhZomMRZL4Eh/OLh7ZoqljNM5aC
         7PZ/rNMrWexvQkAXq0aX8VGYfBCOYUNbmqxCHD1u6LELmjABB+kd7JzrpgndpqE/vlYg
         4siF610pdAcxNdutI6Vh8l0ckR1NkI+7aMbMMzo6VJ2V2q1AxT1D9Tqzvv6/D9vzH1ij
         KNxt9OuybWyPZKiraIt//GeornsA0PL78JsHHHWESFp6TZ4gm/bemL1dA/QVIoNyuszY
         znYDs6kz3hLbmccCqXXRgE7YfzIyXgOa5CisX4HBLZqnyDop0bwXCa/G/qOlHB4umsrB
         yAyw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Jo+HT9A4uxi+ixgjNdABuV9LJqcaNDUt426Fp+xX2iDmJzFEfL/N/8X6PvqsKYRBmG9PKawdy2+JDfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7esAaaJUJVdEYFxp7QlJ8aUdL37U/xFO9GKOgUcw0aOZYzUHh
	IOAGVKcAk3KH8NaUeHLuujjrQufiW9mlRQiCHpcVsLcZf286TTz1TmncPt0UN84=
X-Google-Smtp-Source: AGHT+IF3NskUcf8RUOcTnIF63jZutapZ5Jeb7rdsU+2KtEQcoz8cIrf/mUhNgh51RCcY1c8ixVHM1Q==
X-Received: by 2002:a05:6512:118a:b0:52e:e3c3:643f with SMTP id 2adb3069b0e04-53678fb1d3bmr11190040e87.2.1726608427105;
        Tue, 17 Sep 2024 14:27:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a89d7sm1324239e87.239.2024.09.17.14.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 14:27:06 -0700 (PDT)
Date: Wed, 18 Sep 2024 00:27:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8775p: Add gpu and gmu nodes
Message-ID: <udt76i3sl7zekhudqpnvhvhfxchvixwoinz7metuwfrpynl47k@wlpforwv7mcf>
References: <20240918-a663-gpu-support-v1-0-25fea3f3d64d@quicinc.com>
 <20240918-a663-gpu-support-v1-3-25fea3f3d64d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918-a663-gpu-support-v1-3-25fea3f3d64d@quicinc.com>

On Wed, Sep 18, 2024 at 02:08:43AM GMT, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> 
> Add gpu and gmu nodes for sa8775p based platforms.

Which platforms? The commit adds nodes to the SoC and the single RIDE
platform.

> 
> Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi |  8 ++++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi      | 75 ++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> index 2a6170623ea9..a01e6675c4bb 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> @@ -407,6 +407,14 @@ queue3 {
>  	};
>  };
>  
> +&gpu {
> +	status = "okay";
> +
> +	zap-shader {

It's easier to add gpu_zap_shader_link label in the DTSI file and then
reference it instead of using the subnode again.

> +		firmware-name = "qcom/sa8775p/a663_zap.mbn";
> +	};
> +};

Separate patch, please.

> +
>  &i2c11 {
>  	clock-frequency = <400000>;
>  	pinctrl-0 = <&qup_i2c11_default>;
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 23f1b2e5e624..12c79135a303 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -2824,6 +2824,81 @@ tcsr_mutex: hwlock@1f40000 {
>  			#hwlock-cells = <1>;
>  		};
>  
> +		gpu: gpu@3d00000 {
> +			compatible = "qcom,adreno-663.0", "qcom,adreno";
> +			reg = <0 0x03d00000 0 0x40000>,
> +			      <0 0x03d9e000 0 0x1000>,
> +			      <0 0x03d61000 0 0x800>;

I think it's suggested to use 0x0 now

> +			reg-names = "kgsl_3d0_reg_memory",
> +				    "cx_mem",
> +				    "cx_dbgc";
> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +			iommus = <&adreno_smmu 0 0xc00>,
> +				 <&adreno_smmu 1 0xc00>;
> +			operating-points-v2 = <&gpu_opp_table>;
> +			qcom,gmu = <&gmu>;
> +			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;

QCOM_ICC_TAG_ALWAYS instead of 0

> +			interconnect-names = "gfx-mem";
> +			#cooling-cells = <2>;

No speed bins?

> +
> +			status = "disabled";
> +
> +			zap-shader {

gpu_zap_shader: zap-shader

> +				memory-region = <&pil_gpu_mem>;
> +			};
> +
> +			gpu_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-405000000 {

Just a single freq?

> +					opp-hz = /bits/ 64 <405000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					opp-peak-kBps = <8368000>;
> +				};
> +

Drop the empty line, please.

> +			};
> +		};
> +
> +		gmu: gmu@3d6a000 {
> +			compatible = "qcom,adreno-gmu-663.0", "qcom,adreno-gmu";
> +			reg = <0 0x03d6a000 0 0x34000>,
> +				<0 0x3de0000 0 0x10000>,
> +				<0 0x0b290000 0 0x10000>;

Wrong indentation, please align to the angle bracket.
Also I think it's suggested to use 0x0 now

> +			reg-names = "gmu", "rscc", "gmu_pdc";
> +			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;

And here

> +			interrupt-names = "hfi", "gmu";
> +			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> +				 <&gpucc GPU_CC_CXO_CLK>,
> +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gpucc GPU_CC_AHB_CLK>,
> +				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
> +			clock-names = "gmu",
> +				      "cxo",
> +				      "axi",
> +				      "memnoc",
> +				      "ahb",
> +				      "hub",
> +				      "smmu_vote";
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>,
> +					<&gpucc GPU_CC_GX_GDSC>;
> +			power-domain-names = "cx",
> +					     "gx";
> +			iommus = <&adreno_smmu 5 0xc00>;
> +			operating-points-v2 = <&gmu_opp_table>;
> +
> +			gmu_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-200000000 {
> +					opp-hz = /bits/ 64 <200000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> +				};
> +			};
> +		};
> +
>  		gpucc: clock-controller@3d90000 {
>  			compatible = "qcom,sa8775p-gpucc";
>  			reg = <0x0 0x03d90000 0x0 0xa000>;
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

