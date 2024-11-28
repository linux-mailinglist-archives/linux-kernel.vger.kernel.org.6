Return-Path: <linux-kernel+bounces-424724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0325E9DB88B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F160316471B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8638A1A9B31;
	Thu, 28 Nov 2024 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+oVdQmp"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84E1A0BC9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800374; cv=none; b=I7ZSqjJ8R3ubAUK7ccugHvbqv4lFPAeGXXOMHouH8Ch4ixPfow2TOG0YxICPYNJCIISH2TgAb6VBV9IwNqX0aM+Is8nkduBx/n+1+5aJgoHrmSslw4kGpmmLCc/CpvveV4KzAKNKfg2dIX0dmJSMbUqSiSRKYj+R+TPtuAWVUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800374; c=relaxed/simple;
	bh=jeF3AzRXu/kZv/Zs+2hBUK+871eHe48/0ki7AixpUrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGCt7CeyxapyDy8/UTpZZUCLofXpV95o4vfgz39SNGb9FwQy+CiwRsAqZiXC7DyAWg9ARWOQp/OoKdAxfd1kuCrUoQ7uJTe3neLsU/0/wnGC3TTPJbNme1Ance4pd0KU5R9Luu6b8l1v+D8Y6RRaKnvtJ6uueR6gyNhKMpAncoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a+oVdQmp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53df1e0641fso926965e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732800370; x=1733405170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jPSeZs2I9m/vryfi0ZM9iDP+RKgceUThW/Per9F688=;
        b=a+oVdQmpMcR7MEWyMOF8ZGuoKFZYfBlpHWZcqNZFqNpp5456LfBOitwihWXN5hrRiH
         zl2/QAecePZi7VeDW6WB50Lfggpnim8s+iA0DTuFgh2XgjXF06X5Nxi2ykZo4DFhZmgk
         IGcE4pMjICRKo5tCQNQK+rW6rdMNkdbCNJ6PXk0+70TdA57lrtp2uWC3F/g3q4yfj5Kc
         HiDEWW78KTFKGq7Tctv8j4iGv/ifW/P8Z+FpbIOILhBZedENcJTYqER3Gey11INqTRHy
         yHxVgGcTdo9n3RzP80C1o9CwoEUF7xjYkzk88w/6Ctwv8Ubbcfgbss0KkJ73MiqcGRZA
         PlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800370; x=1733405170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jPSeZs2I9m/vryfi0ZM9iDP+RKgceUThW/Per9F688=;
        b=kgZZCkisyw7WQ3HYlPCiQ6X1TpNDDWM+dPbTK5JbFc2/2joJcUIk7CWg7pdPZCJoUo
         mEXLfPsAFnCyTG0iatSzYfUxY4ApkSthounXwz/7HzP6DW8VHpf2OtsySWNu2yPoPdVr
         0YERI0Uu+bDgQlZ9nqvwOXzcmqFoChjH0Wj9AwdQCSj9Jp8X0hp4+DY+J34ypaWLPa8J
         V9nHl1LidjczOmIq+1xwj2vvSUxSvqEiRONo19sWv/Ps3C7IkegLvJ1M1SRzOdZZ5F9I
         EOmqSiykKplcTuzOEop22ZAVLaQmtvDDeRZ8LvJJ8/zQAoF+14gKxQaWaOXgNtS3Gy6A
         V07w==
X-Forwarded-Encrypted: i=1; AJvYcCXjgwMpcjOPuh+pWCaf342A7DjwkXnKC36w57XpiM780FsJHxyJG0WEqBZ/iAhwcjRdV/C94niH7KIRUok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFbMv/WY0mvXfXKXyjRV/hXLhuRojRDp51QHxwie1Ak872njF
	WLYZ0pBWQXpchjTSR6kfc5i/L9BNlqaXwpVDVN3ytWe5Ex4kLTW5dG+L0cJiu7g=
X-Gm-Gg: ASbGncvd7PcGayClopuzSO8W1jfSXh+MBf9P9Ff+U9FBnVWksoUSev7nWIjamAA5aLk
	n/EJF+paGjERzJdLeHwlQLC5kjhYZhECstUa0cmFtO3aSU1JOWo4cU9+Lt9Z8XdF7uS5oQDWc9n
	G9epAipBg4bg9OLc3AKMYqvs82Hry07bZUFi2YGWXKU0ZCjRaMjZ+rlQgTfcXplaXMMf6mQgnlu
	+IRKgVTnib7ch+2yhHEctCyYtQ1I+3MR61EVXQshH7ggBCQMNijSrYZxKCsH7wN4EL24NP3J/Gn
	RjoB/HvFXx+Lywk/13044HMfqZIuFg==
X-Google-Smtp-Source: AGHT+IF/6PgZ+LtPfmfUOVevzirM+qCJqHyVs/NHs1RDx6TmQskfyIC9ph9W+JY2vHF9iu8Qa8S+1w==
X-Received: by 2002:a05:6512:3d88:b0:53d:d3cb:dee9 with SMTP id 2adb3069b0e04-53df00c604amr4180999e87.10.1732800370439;
        Thu, 28 Nov 2024 05:26:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443199sm177806e87.98.2024.11.28.05.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:26:09 -0800 (PST)
Date: Thu, 28 Nov 2024 15:26:06 +0200
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
Subject: Re: [PATCH v3 6/7] arm64: qcom: dts: sm8550: add interconnect and
 opp-peak-kBps for GPU
Message-ID: <7ylrgy44dlitavefgwaobve7runpy6eqyhufmtkxmwnqkj2g25@pfdjlf5aj4j6>
References: <20241128-topic-sm8x50-gpu-bw-vote-v3-0-81d60c10fb73@linaro.org>
 <20241128-topic-sm8x50-gpu-bw-vote-v3-6-81d60c10fb73@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-topic-sm8x50-gpu-bw-vote-v3-6-81d60c10fb73@linaro.org>

On Thu, Nov 28, 2024 at 11:25:46AM +0100, Neil Armstrong wrote:
> Each GPU OPP requires a specific peak DDR bandwidth, let's add
> those to each OPP and also the related interconnect path.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index e7774d32fb6d2288748ecec00bf525b2b3c40fbb..545eb52174c704bbefa69189fad9fbff053d8569 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2114,6 +2114,9 @@ gpu: gpu@3d00000 {
>  			qcom,gmu = <&gmu>;
>  			#cooling-cells = <2>;
>  
> +			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;

QCOM_ICC_TAG_ALWAYS

LGTM otherwise.

> +			interconnect-names = "gfx-mem";
> +
>  			status = "disabled";
>  
>  			zap-shader {
> @@ -2127,41 +2130,49 @@ gpu_opp_table: opp-table {
>  				opp-680000000 {
>  					opp-hz = /bits/ 64 <680000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					opp-peak-kBps = <16500000>;
>  				};
>  
>  				opp-615000000 {
>  					opp-hz = /bits/ 64 <615000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
> +					opp-peak-kBps = <16500000>;
>  				};
>  
>  				opp-550000000 {
>  					opp-hz = /bits/ 64 <550000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					opp-peak-kBps = <12449218>;
>  				};
>  
>  				opp-475000000 {
>  					opp-hz = /bits/ 64 <475000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
> +					opp-peak-kBps = <8171875>;
>  				};
>  
>  				opp-401000000 {
>  					opp-hz = /bits/ 64 <401000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					opp-peak-kBps = <6671875>;
>  				};
>  
>  				opp-348000000 {
>  					opp-hz = /bits/ 64 <348000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
> +					opp-peak-kBps = <6074218>;
>  				};
>  
>  				opp-295000000 {
>  					opp-hz = /bits/ 64 <295000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
> +					opp-peak-kBps = <6074218>;
>  				};
>  
>  				opp-220000000 {
>  					opp-hz = /bits/ 64 <220000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
> +					opp-peak-kBps = <6074218>;
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

