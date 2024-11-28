Return-Path: <linux-kernel+bounces-424725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA09DB88F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 777ABB22F64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB74F1A9B31;
	Thu, 28 Nov 2024 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOClgjSr"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE2158527
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800389; cv=none; b=L4Ei5xw1naXaC9QVIIySjx5WHCjiO5kh0qQpYhYY/458HThSczaZELJsXFbNjFAMhVkdNu8IhLnYoXPFt4VGZb96j1E3KnwxsX1CuEC+zRtgED0Ik61B91x2UOLDnHo3dZBzZZSAxNNfbrhMaT9uuqkbpZFnvbatWwLiSXFDhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800389; c=relaxed/simple;
	bh=gywptusl9FMGIrT/EUCh7xuj8f5tlNTEJcvfd3Ekin0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnv6LCAouBk30hdzr67ldIqh8CG3WyVitM2BjREPS5D4J+BQ87/dEpazUo39jGZ7NdKC2NSLrANWXqz5VtYnJItp7UKaY9jjjfGtZjHgSfn4qosrprdilJKzoTByy5vVqPkwcWKC/1/LZnTLOija4uvEm+6fsD3rwM++GsRipu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OOClgjSr; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffa3e8e917so9664471fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732800386; x=1733405186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hptatYvEA8Enrguk8oP5vLAEt4VLsfMiRBE5rNfad/M=;
        b=OOClgjSr0iQy7F898QTRBCQVDJtcJVM2I9Yz4ci98Go1nkU2uohhkyeBRbkKtRFXxn
         ommbVdAjte00aGLXVnH7Hj5Nqon0d2iooJuLLdUa8RD5X2CX5bpprpMeaODAwGmpxV6b
         puxZ6cUh2/rtzV9fegr+tEih7YbM3+5O+1hHYofGIxx+jVcrfY5nQvtkvdhzY72dU2eC
         OyI7tiVWRuIkdB/pxgpekZF0BRR5DnOALcGN/suigvVzF3siR+CXOA51zmpkOW/mlT7L
         9PQifgfELOpBGubCr0Jkqaor5Q/95K4cYf5YsfmuQh4Dogbv+nsXs1Sx9J2FmL/loyE6
         GdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800386; x=1733405186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hptatYvEA8Enrguk8oP5vLAEt4VLsfMiRBE5rNfad/M=;
        b=febEEZUxSFSfR13W7Ud3sHlsaKhs4AD1VaE8eMUUBAzLD/tQaB7qvd2xzKmsDMKF7J
         4MWO3kiy3mGvb8FWVuD8PnhMQM5jbA+4dQIb+bi0zJYrO1jXxw6aMWSqiI+VFPv7gowU
         uvQLqyJyZqf7qhskJ844KXiagMgcx3WIB2hKEeMkqyYYjRnyiQtpqDSJew+IVFp9MY8n
         Ck1xW3rqVFN4zak+VT1X5soZvies/9hURjAr3cmiLo/MlyVF9sKUrNd+EWfWhv7cHv2j
         D1tnQVSuIhSmMO++FsWv0ZtfYs9rI78OpapbrQ59z3GymBX4MZY8grP+Nu3y6hPFqIgy
         i3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRSgIuayYjZ8HAYhTRW7b8Hoi5zz1uXyYWTqAKSxQ9yYDQ1AWjm/Qd9IB5A7JcCZyIN/7Kff0Bkk8cuzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3QIxYTe3CyiSzK5zWQJCNI1raG9Rmp8VZfx5PkYxs+v9O34+
	7z/WYcJHqhTcze3sNyLFjWZEMVXcGjHot410i8vdLrenEfiukkGK9kvzbe4gC9A=
X-Gm-Gg: ASbGncvpVYFMsqeuELRvww4rXrOWVkWMgwM3QJXsOw1FoMHUfZeCAIOH8IK2bsTD3QV
	vpNhOZmRYJxldfeo4/8SOkmje+K+cThZmB0b+9o9p5CAxPE/BsU3r4PBo1hEjTbOqnsLn+hMgwx
	2UvqZb5lHbkpHCNou/FC3TAbngApQJKSa93e27HKmffnTZ3a2viQ4e145/KReGjnpIwOl5Dbdbn
	qR4R2klmaSEmd/CwYuJqomaG9+jOQJTniurydZB8rp5uvdAK0JNTwG89MW2savWUb529xaA/+Hz
	TFSsXGz0LCmIfXbkj6imC3jJcQXmDQ==
X-Google-Smtp-Source: AGHT+IGC3gaQ62hMn2mc57Lh3Z4Pgu5XWI0vf5vOjcb88KgIQmcjU1q/2zOc0M3t3qprl3ZV7jTR3g==
X-Received: by 2002:a05:6512:b1c:b0:53d:d19f:1c7e with SMTP id 2adb3069b0e04-53df010ea53mr4138862e87.51.1732800385828;
        Thu, 28 Nov 2024 05:26:25 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443257sm178638e87.70.2024.11.28.05.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:26:24 -0800 (PST)
Date: Thu, 28 Nov 2024 15:26:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/7] arm64: qcom: dts: sm8650: add interconnect and
 opp-peak-kBps for GPU
Message-ID: <2lelgxo32rx6r2ivg2ni53re7c3kwvhyhtg6puwvvet7v5wpah@ysdqjscrgw7t>
References: <20241128-topic-sm8x50-gpu-bw-vote-v3-0-81d60c10fb73@linaro.org>
 <20241128-topic-sm8x50-gpu-bw-vote-v3-7-81d60c10fb73@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-topic-sm8x50-gpu-bw-vote-v3-7-81d60c10fb73@linaro.org>

On Thu, Nov 28, 2024 at 11:25:47AM +0100, Neil Armstrong wrote:
> Each GPU OPP requires a specific peak DDR bandwidth, let's add
> those to each OPP and also the related interconnect path.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 25e47505adcb790d09f1d2726386438487255824..dc85ba8fe1d8f20981b6d7e9672fd7137b915b98 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2636,6 +2636,9 @@ gpu: gpu@3d00000 {
>  			qcom,gmu = <&gmu>;
>  			#cooling-cells = <2>;
>  
> +			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;

QCOM_ICC_TAG_ALWAYS, LGTM otherwise

> +			interconnect-names = "gfx-mem";
> +
>  			status = "disabled";
>  
>  			zap-shader {
> @@ -2649,56 +2652,67 @@ gpu_opp_table: opp-table {
>  				opp-231000000 {
>  					opp-hz = /bits/ 64 <231000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
> +					opp-peak-kBps = <2136718>;
>  				};
>  
>  				opp-310000000 {
>  					opp-hz = /bits/ 64 <310000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
> +					opp-peak-kBps = <6074218>;
>  				};
>  
>  				opp-366000000 {
>  					opp-hz = /bits/ 64 <366000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
> +					opp-peak-kBps = <6074218>;
>  				};
>  
>  				opp-422000000 {
>  					opp-hz = /bits/ 64 <422000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					opp-peak-kBps = <8171875>;
>  				};
>  
>  				opp-500000000 {
>  					opp-hz = /bits/ 64 <500000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
> +					opp-peak-kBps = <8171875>;
>  				};
>  
>  				opp-578000000 {
>  					opp-hz = /bits/ 64 <578000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					opp-peak-kBps = <12449218>;
>  				};
>  
>  				opp-629000000 {
>  					opp-hz = /bits/ 64 <629000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
> +					opp-peak-kBps = <12449218>;
>  				};
>  
>  				opp-680000000 {
>  					opp-hz = /bits/ 64 <680000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					opp-peak-kBps = <16500000>;
>  				};
>  
>  				opp-720000000 {
>  					opp-hz = /bits/ 64 <720000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
> +					opp-peak-kBps = <16500000>;
>  				};
>  
>  				opp-770000000 {
>  					opp-hz = /bits/ 64 <770000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					opp-peak-kBps = <16500000>;
>  				};
>  
>  				opp-834000000 {
>  					opp-hz = /bits/ 64 <834000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					opp-peak-kBps = <16500000>;
>  				};
>  			};
>  		};
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

