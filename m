Return-Path: <linux-kernel+bounces-410971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265669CF0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6771E1F2364F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C061D4610;
	Fri, 15 Nov 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qmovczre"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597E1B982C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686728; cv=none; b=besL0ZvnIXjVR76JQBCCKiDONtsSXWnGjLars9aGcYfBUHOfx//0zqPABpJWvJgJEtauzs0S1LQpi/tVAlHwP1s4Ba44ut39jQU+RZSjLcIcjoRi1wM0+Fia7lpti7fbIneF+52TmXTbzHWS9XyxkUTzeEQ4ixzRc23ncxolTbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686728; c=relaxed/simple;
	bh=AiCrCdtxoEFEeIFaKHGzaI8DqsRzxsiTrVhWRGf7Wxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDxRRou+ZsY2LhzSKxuG0h3yM+Mcv4jHM1G8NPv/I4cNQMHczCd5V0RG7xdsM1qLy2vkuRNUEn9lJuj5/u7BaLMyaHe0PfV76hk4NaX7XiB843MqGp4v0x9SoFflo5KbfhKwCoAx6UdgEv3wii9R8ObxOh/N2popk2EcK9UwCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qmovczre; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53d9ff8ef3aso2185280e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731686724; x=1732291524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qv0WPXRPIqQqwTh/ogUFCfsKiGp9/hWbSnGnwEUev20=;
        b=Qmovczre8pQMW1M5dTdjcSEa7fB85Uw2wheDEe+uOkmKhdncPK4pUDMtowgsBteJYz
         qlg5qT0wVb7e7Bc2J7/RHzJYhaiSG/0MGWnZkSbj1+DKwe0AMpQ2YWynW8aSeskgxFr/
         Zt6GHpuA6cuo7j3N2FdPm5ULGj//JGYRwo+SqwNrRUnE3zNG5+TmmeW/bmYjFaMwZ0XO
         WbsKVSKPqLFt2zjMuQ9GDMMOuNeDB+pxCWeijfC9MMREEjlFYS0oSVPZs/ZZYPMmrL1g
         wThp9ssexpOGzouEjuMSUhyzGlmXqCkeH7QKoAsjiJYaSdd09RnYe/5yiQD9yJXZTyOO
         pfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686724; x=1732291524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qv0WPXRPIqQqwTh/ogUFCfsKiGp9/hWbSnGnwEUev20=;
        b=bdqid5cRY+wfIW+QVgTAWmLdAcJjqvIAujF4Ws3l9WYGo0bPNFbmEIE8LlXACsCEP5
         5h09qwaD3BlMTl20ZZgjsRVf3qOEHsS+HXs5+vYqNDavB9Cj28vq7xqPJo4R9FXuRUjF
         flWOZEFoVuoOLbuaFBnmHj6+9pjAYfgrU31Q+FYm03CZaKipODZ8gnoafkrWfx6+2ItH
         vTv9WCnNocGCOTXExTT0hhS3TuE+ZafheMHauMaLt+AouBx8ZXXnuA2QT7ZP2XEutXYL
         0hRrOKvUZYy4+yZqtP0vVHxFWgTCgYBeW2TeRhCo1f4PgOA92iI5liYH/Eonn2eAAYFP
         B8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrK35MtajwiusyzbzNIDoQr2cGRNhufxg7JHPU0oYKmxUwgeYpMKStnak0zHnUx4uWS6qDpjhosiYAiaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoL+n3+kTlOw9XCpcQ2d12oe0dhsMOiz0ufMUAwwEkeVroR9wt
	xeEpXnHViSGp0/XgUHuuR29XMPw/z9c4Px8SCfCG2Mj+LuMQYbxFfyOCPradL7o=
X-Google-Smtp-Source: AGHT+IHrBECP4OjSU34WVOJhQG9Udf7rrAPtjXGsGS2ldnGooEzSZ30zGQ8cCWs4Gi4JIBh8DsTSxA==
X-Received: by 2002:a05:6512:128a:b0:539:e8c6:7c1c with SMTP id 2adb3069b0e04-53dab29dc5dmr1918279e87.20.1731686723590;
        Fri, 15 Nov 2024 08:05:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da64f2b97sm612157e87.53.2024.11.15.08.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:05:23 -0800 (PST)
Date: Fri, 15 Nov 2024 18:05:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Wasim Nazir <quic_wasimn@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: qcom: Add support for QCS9075 RB8
Message-ID: <glvtcxuaniuzxg46rr2a6nvem2ruxxmvidafcn33xpeskjkqal@fyehlwys43vc>
References: <20241110145339.3635437-1-quic_wasimn@quicinc.com>
 <20241110145339.3635437-5-quic_wasimn@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110145339.3635437-5-quic_wasimn@quicinc.com>

On Sun, Nov 10, 2024 at 08:23:38PM +0530, Wasim Nazir wrote:
> Add device tree support for the QCS9075-RB8 board.
> 
> Basic changes are supported for boot to shell.
> 
> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>  arch/arm64/boot/dts/qcom/qcs9075-rb8.dts | 287 +++++++++++++++++++++++
>  2 files changed, 288 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs9075-rb8.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 9bb8b191aeb5..5d9847119f2e 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -115,6 +115,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9075-rb8.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qcs9075-rb8.dts b/arch/arm64/boot/dts/qcom/qcs9075-rb8.dts
> new file mode 100644
> index 000000000000..8d4a27a8f371
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs9075-rb8.dts
> +
> +&tlmm {
> +	/* FIXME: mdss0_dp0 is dependent on this so adding a dummy node for now */
> +	dp_hot_plug_det: dp-hot-plug-det-state {};
> +
> +	/* FIXME: mdss0_dp1 is dependent on this so adding a dummy node for now */
> +	dp1_hot_plug_det: dp1-hot-plug-det-state {};

I don't see these two being used in the MDSS node. Please drop.

LGTM otherwise.

> +
> +	qup_uart10_default: qup-uart10-state {
> +		pins = "gpio46", "gpio47";
> +		function = "qup1_se3";
> +	};
> +};

-- 
With best wishes
Dmitry

