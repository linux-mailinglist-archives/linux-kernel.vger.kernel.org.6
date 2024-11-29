Return-Path: <linux-kernel+bounces-415688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE59D39E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1121282475
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A711B3B2E;
	Wed, 20 Nov 2024 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5dJ/DVh"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E211A76B4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103264; cv=none; b=jKAIgpm3FhOvRh3DvUHwuarw5m3OYvLUC8AjlBQc+JbSWAqCYwXqICwQwut5Zf5aKpPlMC7cgdnpe5Za8kaxkzLQtPQdgPTs5vLN7RTXCY5R8rNJMnnSZ33yGd86P0byb1Rq4nlRETw23ZBbE/xXcdvcpxAL4uNr8zlePT6sBg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103264; c=relaxed/simple;
	bh=b2Vy2pl7YZjOyYyxnjN6Ku6naKZCDnkxrPRBrvIPZOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Est1FXFFfPVdY330ZzuNamBzVM61+Pd7wtOmvGdmNW2X0CeA+UjhN48QuNPH+Nc5Hp4SuYbU/j1uZb/+wcugSQIIY+1PGG86W0M4sYWrbYqK4eJnKVF06Ax2BjdOA5MfI6afJ9IzpA8dFuhqEr1XN8Go7kbhvpNOVzppzXYtB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h5dJ/DVh; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so21831341fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732103261; x=1732708061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YvHyFkCVt5nrP8pRwp8qyG7YK/1OHDPY1k+9vQvn+9s=;
        b=h5dJ/DVh5zt0MKhR7DyP91FmOzdStBt1j0BP4gseJOF87XnecemlxE1AaRu2bTtDoN
         ghnxOaCa9nnw0h5CPPzxm09b7o4rgxuExP+5Asv6Gmb7isf160UCQ3sXANn70rPYtzgL
         5TV7oiuqV6xBE05KH9sux0pMpGhg333ADP8oGr3dnaEn6TupRakCa4dk3BL2/u0uoqkp
         sffNbRhvE8fulZ6qEItcJgKLfB9oQLA5ujLIW4pyzBSFOY4EWVgPHBNeVYfKTN7PeWSp
         WdN75Ok0F+3Ji52SGAm39lZdTy9OPUC0fCY8bhnY1dp98P0u4Jet8qiR3kdcd0SsJuK6
         W94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103261; x=1732708061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvHyFkCVt5nrP8pRwp8qyG7YK/1OHDPY1k+9vQvn+9s=;
        b=RsVn+i0MT/7+/DSHgfjNcAX4ml8CMjfJW23fD5LIdmy9zujOBd1htkqR7VpowYjzvR
         COAhh6/nMXpT31f+X5Arj2VmcZTyBYoGf+6oJfhdDUJYq8OJa5p9V6dN8fktw/UTgzMF
         Q2L0CYEjmBM2fW4ub4o0e70/TqugBxZBtXcXt0zC9Y2HuV87HUJ90iT5ZZW2NNMThPli
         yu8Qn4qbu/ckBdjIIIo0oAWnZc8jqKfDgQaD9juOf1NTeYSbYdU6xxpe8rTK4v25nJCN
         giIhBAIfJxelIja283gwEPGxGuU/rCeFpDKgtgwqp1G0PKTF0BG8U/EGjfla4RNPnRQT
         eIGw==
X-Forwarded-Encrypted: i=1; AJvYcCWYqL+0Cn4toipwLw9v7U+DjrJDqKyV/1v/iZ04pzcA7eRhhDSi96nrZaIp/+ZSMHq6O3GPN86AbjO+hFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BGTkcudaAklWHuKE9o9VPC2BC1ne6hhB7ApAzaudLFhe3FFH
	VvJVCaVjJvNE7YJ9huwZewzTYdn/77UECKs93GPOSrbIh5lcHMA22t7IT8uZKM0=
X-Google-Smtp-Source: AGHT+IGdBgJ9SG4Q86oceaqgtGvWQW5N2wMC1Yx2vW9WKHOfA6+7+2CUAYtCbkMpsl2RiVqaia78Ow==
X-Received: by 2002:a2e:a541:0:b0:2fb:4c08:be08 with SMTP id 38308e7fff4ca-2ff8db32b64mr13216281fa.11.1732103261034;
        Wed, 20 Nov 2024 03:47:41 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff6996872esm14826371fa.63.2024.11.20.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:47:40 -0800 (PST)
Date: Wed, 20 Nov 2024 13:47:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/11] arm64: qcom: dts: sm8650: add interconnect and
 opp-peak-kBps for GPU
Message-ID: <bklfpks3umni7elel2sf2ltgwor6vrndht5vh2tgrtyl6kufjk@l5kqdctv7xhq>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-11-4deb87be2498@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-11-4deb87be2498@linaro.org>

On Tue, Nov 19, 2024 at 06:56:46PM +0100, Neil Armstrong wrote:
> Each GPU OPP requires a specific peak DDR bandwidth, let's add
> those to each OPP and also the related interconnect path.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 01ac3769ffa62ffb83c5c51878e2823e1982eb67..331c5140c16bf013190d6da136c0920009d2646b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2636,6 +2636,9 @@ gpu: gpu@3d00000 {
>  			qcom,gmu = <&gmu>;
>  			#cooling-cells = <2>;
>  
> +			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;

QCOM_ICC_TAG_ALWAYS

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

