Return-Path: <linux-kernel+bounces-306163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E760963A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A187D1C21A86
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD1715B98D;
	Thu, 29 Aug 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdAvFojR"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718815B57B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910976; cv=none; b=cq9GMvF6gZ1KR46ujdMQc7hQAXYfVAeu7wbUVaU6yGctTD7zmT5MeWQaLDJotK75hRtXF6iNbfHx1gCTxYv2/nOGD5BneaFrgH/idVjM0Isc/BSajwAA1bGhdazB6/onVkD5CoHH0/ikCQgSouaL7E9mSfrMRoK62M/jVP6IlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910976; c=relaxed/simple;
	bh=DkM87PgupUqOVr1MKYRG5uAeLJQosGBM/rYSsJnV5Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doZhsFHgDPNFRziKB+M7bAf4Z3SY/AfHevCanJ19MNJZ/v9T9D8gFHFE1fq/8K6kkt9Bjn+vPHcha2svWh/xKJeGtUYGkfS2ww25lHNJAQE53q5QfS++SlqaNP+ICg6FVhMX4GRG5g4fqv4yrT0DbZrlRSqWpdJfISqVgUqZyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OdAvFojR; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3e071eb64so2914801fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724910973; x=1725515773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=REb9QwYqCwNcM0/u5f0z7eG80lM1IACg6W8vp2NUNSM=;
        b=OdAvFojR4Yxa1Vht9wVS2WOdvLewT5qBQLZdMapdSRSnZ/6eQ4fuEtNpyhTfHA7LXZ
         jmQktL8k8v0F1CTwkZR2MTvtcbUiyRdimo0XSUvHgLO0WZAWsNlIPtQatqOnI+E3UfSt
         k41aN0MxP5TbUYELdQfj/lA9Wjuq+q4jVcIF+3DEw2hbEeww/sESoUCtf5d9/OcmoHEN
         J+0zwdjVXUtBQ2nA0aFLJOD0XzAPCA+j2X17FTwVAwTKdr+bcASF7MYW452fsFQ9DTjS
         bmh9x2eEXZrB2rhB4T1nwdMlRQCowH/+Hj5bc1VtOAL+8YBJnntMa1sktBx9kUYaxevP
         Hq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724910973; x=1725515773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REb9QwYqCwNcM0/u5f0z7eG80lM1IACg6W8vp2NUNSM=;
        b=R3RV0bNQtJXfs3HZHwmi1dt0b8ZP4B6mp8p84xL2Rdk1OyBsyX2yYhaOXeQsGtd6Ve
         SVPaaLo6Gq3co5ioyt22z0NiDVXUc6BBdm2itDMZSRmWLvgx35/MWatVAfCofecO8o8u
         bjszge7cYopqqKiiogfOj3ys7crXgzWLX08pchER9J3RbxE/58/gUJYtni/CgiEMuY+g
         A5+PBnZAbfrqdLlqxdXrwbStou8WKhh+85T5QmFehJofUAYndqfW6M7Hu4IQ74yTkQpq
         qGuHUePBDn198kb/UAmVhDtbtgkVhBJG2qiaaMLgHyTlxvvbhEnlu+XcmKvfqLxurDDH
         jmUA==
X-Forwarded-Encrypted: i=1; AJvYcCUt/6v8AYuevNOisupOof2kJoO+AXTlbg5jrb31SfBfGLyXHZJQFcgYCBXSBe4cxwBv/l6pnJE8zhLhwRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsWFbhVoy9fGhEEKKVE/9qFXbety3ZEQtkINkaBIJLOhhyrFvD
	KFdcwvTW/AgYNlvnyZTbisPI3rKTjcJJkpBsEixg3EeZKueAx6bFy8e6QIN7GQc=
X-Google-Smtp-Source: AGHT+IF/7IaW8TH3k5xG0pABz3d3jlS9jSXgHIfutb16x9nJiddV9N2toKH+9UXsTyU+Op4Srk6DGg==
X-Received: by 2002:a2e:a987:0:b0:2ef:226e:e150 with SMTP id 38308e7fff4ca-2f6108930d5mr16453911fa.32.1724910972049;
        Wed, 28 Aug 2024 22:56:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f6151828b2sm835111fa.108.2024.08.28.22.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 22:56:11 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:56:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU
 Frequency
Message-ID: <f3g2tvddqyt5vjt6x7h6oirtm2ighnesu2pmtn2br6jpbxf5zr@tprelogpljuh>
References: <20240821101025.858961-1-amadeus@jmu.edu.cn>
 <20240821101025.858961-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821101025.858961-2-amadeus@jmu.edu.cn>

On Wed, Aug 21, 2024 at 06:10:22PM GMT, Chukun Pan wrote:
> Some IPQ6000 SoCs (fused)[1] have CPU frequencies up to 1.2GHz,
> so add this frequency.

opp-supported-hw is selected for all IPQ6000. Please add more details
here. Is 1.2 GHz really to be enabled for all IPQ6000?

> 
> [1] Usually the SBL version is BOOT.XF.0.3-00086-IPQ60xxLZB-1
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 8edd535a188f..1b584d9aadd1 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -119,6 +119,13 @@ opp-1056000000 {
>  			clock-latency-ns = <200000>;
>  		};
>  
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <850000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <200000>;
> +		};
> +
>  		opp-1320000000 {
>  			opp-hz = /bits/ 64 <1320000000>;
>  			opp-microvolt = <862500>;
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

