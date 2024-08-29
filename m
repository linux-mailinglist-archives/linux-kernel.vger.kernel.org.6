Return-Path: <linux-kernel+bounces-306656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA939641C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27DE1C24A10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8707E1B3F0E;
	Thu, 29 Aug 2024 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="la+XfnQ3"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAD18EFFB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926886; cv=none; b=Khazl6ztq3lq4XLgY/idr1krC0iKcaFs08EvWOWuewdon8DbK/0oyYxf3WTjPp9GPS8AKDE63lFD5OkkUrqEdfWg5Frw3EQzsqTN6PazJMY8euSZY0FTDaRMmkeyrTzluQz8RYYBDQ8vZ/KGVRHZyEEEIxFBYzw7uNsBQc8rslg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926886; c=relaxed/simple;
	bh=mTnyfs5iyXk2A8jVh4g9909p7wCslrKHActf8v2jCu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG4qdNw6o8kL/If3ZEySU0UkqMyCGB1RWUCtYJywqgjhuRlY38V5LBeZYoLHu70KMOBI7DPUeDFpBKquYUdEPCsZbn21S9qKMHwBEPOkAk0QpbvD3/Djg6xsToFpgpj3UAbUi/YGuDbx07jBDUVR6QsQuewaTdSGvH3qKC1WjLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=la+XfnQ3; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5334adf7249so663666e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926883; x=1725531683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=puTnCF9XRDK7owVjEuZhSKV7rRgleAu/KF+YmSYOfOo=;
        b=la+XfnQ39aD2eISdLWJCeT0Xl5wH07yhFOCx7ghJ5hRtn26l/+hvZaZy6Ie4DzwiG6
         QHWX3hp9/PgXrwL5Yf6YtHaiOss7v+U47cF2K8SHMBdpNJq3Xvp0vmFVMKthWsoZIiQG
         qmOptEyHPFFJI8sAMA28d7p5Wclb8QSV87GSnWKkarEWCoLj1DF7hSzIJSGYWSdL2QSl
         +LnQ0UBaGT+mimTQXthic42MPaI4tYxSr+pG0N4w3lKsjYWVZfOS8SQgA27MQt0E2i9K
         dVxg0rTLMkYw4xK7B8nBYbx/shu5gHEDbvQEsSKiGSgLTdKhzTTOACDfhRWD8L3zjCl8
         z66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926883; x=1725531683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puTnCF9XRDK7owVjEuZhSKV7rRgleAu/KF+YmSYOfOo=;
        b=HyHrFCth5FnOMrZca4yQsk3Q1qx/vO4sEe7JmfiV5h4jllPL/UMpoIxLQPYqhPOe4P
         8BkyTff6zBlgSAxFO6jS/nJ0LvaKprF12/NDlkvZnF5dzjW4Wm7TpRrfRnmg1MflWkQg
         dATnj/6WuzvkJzksFyHFUrctdr2yf+oYKP7xniT7mqcWk8GXBQevTJRs3ody/0+5Itv1
         fIPBgEwu00q+qW7o0v2hl9Y0T7TNTAYmjI7JVjVf5xHiI9ydHvLd6PQ4DfuVXYD2hBHJ
         MgYu7u4UOxD3KJGAd3pSPeIPIvlVRwN7GAB24Zz9mxVbgzUU56wNkVCvOgL78CSO2BAx
         1z8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxjbQFUVcdQcwHDdhcAQqImNTN9poM+53R9ntbdedaDDAjWXGRdojKFpS+y0BdGw2p1D4MvKJv6UsO+6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXFfrlSZt86iRyNfUFkJCeqCttHlDKcn3FBI+/R2xL5Obfzzcc
	4NaMR0abrD2UBO0N+zUWcbPEY4w0A+lB55ioq1nfh+UIFifL7BRjnINpTGxpXoM=
X-Google-Smtp-Source: AGHT+IFFNsu2a9NDRGs85OJjM17UuETV7H8yjux3hgCI70M+fCsa984v1mj68+Le6L8itmReRpHr3A==
X-Received: by 2002:a05:6512:3d8e:b0:530:dab8:7dd9 with SMTP id 2adb3069b0e04-5353e53fbafmr1854704e87.12.1724926882119;
        Thu, 29 Aug 2024 03:21:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079be8esm117031e87.48.2024.08.29.03.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:21:21 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:21:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, djakov@kernel.org, richardcochran@gmail.com, 
	geert+renesas@glider.be, neil.armstrong@linaro.org, arnd@arndb.de, 
	nfraprado@collabora.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: Re: [PATCH v5 7/8] arm64: dts: qcom: ipq5332: add support for the
 NSSCC
Message-ID: <hvbrd7lyf4zjhwphxiephohuoy7olmqb5hxsa4qnidmuuae45p@swezjh3lfpzi>
References: <20240829082830.56959-1-quic_varada@quicinc.com>
 <20240829082830.56959-8-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829082830.56959-8-quic_varada@quicinc.com>

On Thu, Aug 29, 2024 at 01:58:29PM GMT, Varadarajan Narayanan wrote:
> From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> 
> Describe the NSS clock controller node and it's relevant external
> clocks.

Who generates these clocks? 300 MHz crystal?

> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v5: Remove #power-domain-cells
>     Add #interconnect-cells
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 28 +++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 71328b223531..1cc614de845c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -16,6 +16,18 @@ / {
>  	#size-cells = <2>;
>  
>  	clocks {
> +		cmn_pll_nss_200m_clk: cmn-pll-nss-200m-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <200000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		cmn_pll_nss_300m_clk: cmn-pll-nss-300m-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <300000000>;
> +			#clock-cells = <0>;
> +		};
> +
>  		sleep_clk: sleep-clk {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
> @@ -479,6 +491,22 @@ frame@b128000 {
>  				status = "disabled";
>  			};
>  		};
> +
> +		nsscc: clock-controller@39b00000 {
> +			compatible = "qcom,ipq5332-nsscc";
> +			reg = <0x39b00000 0x80000>;
> +			clocks = <&cmn_pll_nss_200m_clk>,
> +				 <&cmn_pll_nss_300m_clk>,
> +				 <&gcc GPLL0_OUT_AUX>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <&xo_board>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#interconnect-cells = <1>;
> +		};
>  	};
>  
>  	timer {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

