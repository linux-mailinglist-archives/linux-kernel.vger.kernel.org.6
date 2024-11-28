Return-Path: <linux-kernel+bounces-424719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BDB9DB875
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF87A1622A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628A81A2630;
	Thu, 28 Nov 2024 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zyvz5NeP"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D51A0BFE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800156; cv=none; b=KZlzA3QQTyDSbenkJnXXt9VLJClWpoWbz7BdrZFrllrpymjbf1yXgsFJWxDbmt7IEWm1qGZnqwNPyPeoiViXBrliuS0issNW6fZzujycKnWhrARt6svmPWw27I+CpDvUwv0HALFZ0rN/n3nSbtF1gCeqm8YLtRAoQA8Ur/Au23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800156; c=relaxed/simple;
	bh=Wrj6BNOJyB1/SD7ZTt8SzVwfNMLVUbl/Hb4ZD2t2L5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUcCRxspBDT9AdrThrKYZyMw9MCLT4HJjH2WT+5owdpxbl3zYc/8QF3DN/ODAoMDyDqlbn6eGHx8m/mvbsHXmcNHeqT+9iFljszQoP8R9iEY9kP8Z6nq1hHqLMEsfGk1XHibKjgsNQB496JO3IKkGz3x1BQyz1Revg7Y7BX3Oyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zyvz5NeP; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffdd9fc913so8674491fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732800153; x=1733404953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34gZUZi5tu048lw280ahbLQ/y69l+6hlbhcpQA4G+Uk=;
        b=Zyvz5NePljV5VJm3r8CgjUnqs0j9OUKtyt1Sf815hgdfIaPakxbhawX+6T4zHdnpfo
         MQ9J0lBE57hTmql1sokUa/DeXW6biN/sEBV2O48EJDKcbhqouNzwDsorTl09X3py0Q9w
         r/lO2XWlBxZd2sF6UYJUpNFq/dO5gX58XTjiBQdO8YgQyWcaPiybA1pdkQApflJSCwuI
         /Q+fInJLDDtV9sLQrsTPlKyx7vP55F0U7ofRxb+tb8tWDcCp7fQ6LqNEGUPbFWF87ewS
         /i8s42/jyTGrnfAxstI/pzX0LdKaOHg5D+jsSXKF9J6u4PoQMkqQtWNZsQIMUl/DLXOn
         L8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800153; x=1733404953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34gZUZi5tu048lw280ahbLQ/y69l+6hlbhcpQA4G+Uk=;
        b=gt+bO/h7rj27fBTzxhGns9+IUk2Nbv90n55nVYvcowirKsGpxYaZLfCQIkVGhbUHlq
         KNEEqNSUGBGLqqg5a2m/M1jTAu0kM2uy77Avm6m5cvBEmLq7Jcdo8smKR2uGlbsL5QxO
         /ti+OsWFVqvF/o0voN/jtpTSrf0KkSXhfWPYLm6u8vpQc2Alz0DCDbkCkEoVVeb2SHqK
         UvgPJ6TBoXBP8XZOcg9awNTfagQFpsRgui92X87PTugEvkO1MnLF11hJqmPykCRdnkUU
         9/jrVmjDaP39pWH/P5oG315qoJTM/N8RWTvh3+yOmmJ40nr02Hz960zGO5Cef1IEELjB
         2TdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI8b4dfzB3h6BcLAhmsSF51ClQc5WdSl0VF3p2bxS/wkOQzXWXZm6QYDFcOFgQrHRYdC1BUVIpvHLWlk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDgC7ztQzVt0oiELZBUn4y7SFFk5ZURqmuJ8ljjJk163/84iu3
	j95lVn6zB8bWlTOe/5J2/4SrIxlj0cwW/+QDoiY6jfFmONhsOAq3m3MvT5RoYHw=
X-Gm-Gg: ASbGncv1poc8AA/+CmbGgzwCQOHhebkegZE6iUwGjB3Fz8Qy7ccHM6g8L5voSZY/y87
	Qt3VP6htVBvTettwqQ19VMmzycnEiKunVKTSVLtjr6D5C8aUutPkKjBGzTHc7bw2ymRCDNDDlGB
	vLsj2oA5V5J1tdfnwqKd847z7DWeDcKu7sZLKRttnBT6yf5G2SP9kg38Va6App0qPfY599ZrJb1
	l8dMm21iDLd0rUdlzsmdafhNGOS+nAseq9CkyDToQif0StKIEJrvB3kAF0AnOr/JGqutfQZi4o0
	4Yx5wsv4fbCZe9yF2gyqnA1tWmQIzA==
X-Google-Smtp-Source: AGHT+IGvVPSZJFn7GQ36svvA57XZmhphOcMaYWe+5MpoDcJNDcG1XTTXDgvR+lt04+d/kuWcwV5Plw==
X-Received: by 2002:a2e:bc22:0:b0:2fb:5035:7e4 with SMTP id 38308e7fff4ca-2ffd5fc81e9mr42772491fa.5.1732800152993;
        Thu, 28 Nov 2024 05:22:32 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbe5373sm1925311fa.26.2024.11.28.05.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:22:32 -0800 (PST)
Date: Thu, 28 Nov 2024 15:22:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org, 
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com, lpieralisi@kernel.org, 
	quic_qianyu@quicinc.com, conor+dt@kernel.org, neil.armstrong@linaro.org, 
	andersson@kernel.org, konradybcio@kernel.org, quic_tsoni@quicinc.com, 
	quic_shashim@quicinc.com, quic_kaushalk@quicinc.com, quic_tdas@quicinc.com, 
	quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: qcs8300: enable pcie0 for
 qcs8300 platform
Message-ID: <v4s6vj25vzsywiptfy76urngwvfjxymzgrlocu3ewdzgbp5f5v@djn4f6ous7y7>
References: <20241128081056.1361739-1-quic_ziyuzhan@quicinc.com>
 <20241128081056.1361739-6-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128081056.1361739-6-quic_ziyuzhan@quicinc.com>

On Thu, Nov 28, 2024 at 04:10:53PM +0800, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe0, board related gpios,
> PMIC regulators, etc.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 44 ++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> index 7eed19a694c3..7f97f771c44a 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> @@ -213,7 +213,7 @@ vreg_l9c: ldo9 {
>  &gcc {
>  	clocks = <&rpmhcc RPMH_CXO_CLK>,
>  		 <&sleep_clk>,
> -		 <0>,
> +		 <&pcie0_phy>,

Review comment was ignored, NAK.

>  		 <0>,
>  		 <0>,
>  		 <0>,
> @@ -223,6 +223,23 @@ &gcc {
>  		 <0>;
>  };
>  
> +&pcie0 {
> +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-0 = <&pcie0_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&vreg_l6a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +
> +	status = "okay";
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> @@ -247,6 +264,31 @@ &rpmhcc {
>  	clock-names = "xo";
>  };
>  
> +&tlmm {
> +	pcie0_default_state: pcie0-default-state {
> +		clkreq-pins {
> +			pins = "gpio1";
> +			function = "pcie0_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-pins {
> +			pins = "gpio2";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		wake-pins {
> +			pins = "gpio0";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +};
> +
>  &uart7 {
>  	status = "okay";
>  };
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

