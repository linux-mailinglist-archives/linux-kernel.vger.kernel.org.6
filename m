Return-Path: <linux-kernel+bounces-519985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A37DEA3A465
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A71087A4BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83CB26FDB3;
	Tue, 18 Feb 2025 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPMWrvNO"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77A26E636
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899943; cv=none; b=hZg8QAn5HUV46Rcy1kCH4iUcYfF+ENBvLPEN4xjmM23uB7n/r6c1y8TK9eTB7SvZkLgNuCbqSetVjfhpzJVZkmhtACXcdwxqxkc3Jrouxcr4lIhT2SzGJLj+7WxZJEQ7FH9vsIkP0FcppGZCLXgNTBq+0OiuRCWVR6SVjuxkIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899943; c=relaxed/simple;
	bh=4YRuBZLDQUyim+eVfx+z6hk8k3OtVqhP2mJd5G3ozRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/63AnM3DNPwIQZlVk5CA6Qws3dqa+Gt3KomRtTpUXxjvW22MhlSGLWxut5LbWUM74rzciOf35je4YFtKUXjThYbtE7CvMypog5GFkLIgE+FNldC6kzJFTd95aa4+2aKzDfk2QrYwLIccRe78mxxmtqy0qKBM0rF/V6SGFZq+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aPMWrvNO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5452ed5b5b2so3993022e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739899939; x=1740504739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXedXzQG5Wbyyq0jTams5IijNuTfQ87Imlxg0WuUfRo=;
        b=aPMWrvNOgawGj1rwMp9DbuVWIndn+4iq+Xy4tICsMrFuvo04wLh645I6ykv4iyKY1z
         fQjZLoW1AA8pJ+MAa6wWRwT4ktAIvQr73eP9lis9v5uK0gGnHNp90w8hDte3Prr0E8qI
         VMnxMpv6qA32cQlfUUqNbvouJDnAaJLpkyd0KwDZqkGjiuazKkmBiBQORtpU5cxkzvRH
         aSx1gk91emWeIp85jHV9LfyCtb9l+5AkIaAW8NnYno5Q4oF78rSY814CIu+rZrNm0bFQ
         z/xAKWuKNGL6CyaaY9Hjuw8gcJ0qmZFohvGTHVzKM6h8E8QDbLvaTJYgpFH4TbGMt4B5
         Agzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899939; x=1740504739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXedXzQG5Wbyyq0jTams5IijNuTfQ87Imlxg0WuUfRo=;
        b=bGmVWqG/6x6rYDvkTTLESrvt/c1utNEaIMA4+49qhf2OQJyxvacqRsH3XcAZp1KxpK
         c6uz6KN4wywT5hI9oatqpJnv2/epO3hEIqqodGAVlCv4vgYM+dBBgnTDOy6tHKx++TFa
         N3KWZzzaqZUkrbX8TGyzSeXU4FpuVmFUS/qmJar0KA7HId6cab1Sv3axWsMseerxOuIx
         b69/MABbZzcaUK4nLgPrNFYWvUgzVVwHsnOo1w6S54NLhzsKSBG98jgh0Chu3kzCtYx/
         1kWBWCJw6n3hSkMcfZgjNJgv10rRUh3LHCrRFk8F+ZpKVFDmdEAe5Wg9o3P89JFRZEZH
         h1XA==
X-Forwarded-Encrypted: i=1; AJvYcCVEoZh4e0dbsRcZUKHp1C7069aQMqcbqFJW4h3IW34zTJG2NyiYzA8vhVC1xULoLl+XoHXFXuerD9EKVqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyma4QehZvTr+ge6d20QdroBOk1J6dUfqN+0zpCqdlZZSYdo4C9
	zV1uaUXzVkKrQJ7wDb1VH8sSZPqrawlHDwM3XVTuxBCTFlwAU8w4XOWiWYlMsts=
X-Gm-Gg: ASbGnctA9F2vC8CMqdKQjQFKFaM8RtCwA6+OEeXlbd1M94mf7BWOvvH7ediyWJKo05q
	sMh9XtoRDoJtyC2WuGsYqUuipsXU+LR+mPU/ZfzEajZVoDXTqmxmNgRGa1hX1QFtNAlgXaaZSbH
	FqF8KRCA3/reBqWs0ny0fqdZiTX5R4ZS91x8QqZ67WOrZ18T+bkQLZLF0f2oxNFp17kjNXn6Kwr
	uPPdXzwZJ/awUpa2NODcmiPXRNa3ct9jJl9uRjtbB3f0m7oYgBT8znhEHCaG+UdeBDdTWttN41W
	SiOHAr2uJtQFLYtq4zKCxfUYuEVTqldlj9DGTtpiLIT1B5ELg6Owg594hNUih3xawg+ytQA=
X-Google-Smtp-Source: AGHT+IEZQHb1Cbq6+Wc0+JU30WNtq8/8OAvVChOQXjRCoOixsaJ5QkA4bdoc/n8R7EUcEzdYXlMpRg==
X-Received: by 2002:a05:6512:b12:b0:545:6fa:bf60 with SMTP id 2adb3069b0e04-5452fe2eaebmr5379475e87.19.1739899939195;
        Tue, 18 Feb 2025 09:32:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461d4f2aa5sm960232e87.0.2025.02.18.09.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:32:17 -0800 (PST)
Date: Tue, 18 Feb 2025 19:32:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: Add MXC power domain to videocc
 nodes
Message-ID: <dprxueuq5avpv3mek4kc4sy2mddydsoskqgbizi4lpyapuhg4t@zcdgm2wcsaco>
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-5-cfe6289ea29b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-videocc-pll-multi-pd-voting-v1-5-cfe6289ea29b@quicinc.com>

On Tue, Feb 18, 2025 at 07:56:50PM +0530, Jagadeesh Kona wrote:
> Videocc requires both MMCX and MXC rails to be powered ON
> to configure the video PLLs on SM8450, SM8550 and SM8650
> platforms. Hence add MXC power domain to videocc node on
> these platforms.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 3 ++-
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 3 ++-
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)

Three separate patches, please. With that in mind:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 9c809fc5fa45a98ff5441a0b6809931588897243..4f8dca8fc64212191780067c5d8815e3a2bb137f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -3136,7 +3136,8 @@ videocc: clock-controller@aaf0000 {
>  			reg = <0 0x0aaf0000 0 0x10000>;
>  			clocks = <&rpmhcc RPMH_CXO_CLK>,
>  				 <&gcc GCC_VIDEO_AHB_CLK>;
> -			power-domains = <&rpmhpd RPMHPD_MMCX>;
> +			power-domains = <&rpmhpd RPMHPD_MMCX>,
> +					<&rpmhpd RPMHPD_MXC>;
>  			required-opps = <&rpmhpd_opp_low_svs>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index eac8de4005d82f246bc50f64f09515631d895c99..a039ae71e1b7bba8124128d19de5e00c65217770 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2889,7 +2889,8 @@ videocc: clock-controller@aaf0000 {
>  			reg = <0 0x0aaf0000 0 0x10000>;
>  			clocks = <&bi_tcxo_div2>,
>  				 <&gcc GCC_VIDEO_AHB_CLK>;
> -			power-domains = <&rpmhpd RPMHPD_MMCX>;
> +			power-domains = <&rpmhpd RPMHPD_MMCX>,
> +					<&rpmhpd RPMHPD_MXC>;
>  			required-opps = <&rpmhpd_opp_low_svs>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 86684cb9a9325618ddb74458621cf4bbdc1cc0d1..32af2a0f7a0030f155b7d8c93faeffa384a42768 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -3524,7 +3524,8 @@ videocc: clock-controller@aaf0000 {
>  			reg = <0 0x0aaf0000 0 0x10000>;
>  			clocks = <&bi_tcxo_div2>,
>  				 <&gcc GCC_VIDEO_AHB_CLK>;
> -			power-domains = <&rpmhpd RPMHPD_MMCX>;
> +			power-domains = <&rpmhpd RPMHPD_MMCX>,
> +					<&rpmhpd RPMHPD_MXC>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

