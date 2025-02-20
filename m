Return-Path: <linux-kernel+bounces-524197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED6AA3E06E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8989A3BA4D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FD820C024;
	Thu, 20 Feb 2025 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AM+bYgeN"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F172040B5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068358; cv=none; b=eGPxrsHCKNob1yPVAdr5xXA4b2H2aL6pBHRrcdY+WqUJ6SUKNJd9iMtI9wCBsHtqFzn1z1ym+aBpdbfZDQNMYcfiR5hjjSlBtlO1tsGPKb2oAG/f7z1rF5sDV/1OXLg7aNEYKDW+R9x3xaTEzTXyCU+ZmwLVNgyOXdPAx7npZ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068358; c=relaxed/simple;
	bh=/B922pkbs/U6oOvx+Im8KE0wQFfockKMJbcW42nwAlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a18A03IXcj/rth//7jHFIB+Fv/MOu8ujbzdeJgxX+PNweqFsyZxlzBUDInANLkNBdjR4RNSCXScCYK6sFmFUb/93q4b20hXzFzyOTT7rZNfvbd0DwaH4DbQ7c0qSODtcmP5VqEnJ0bHnMMp2vMZdOWhTFsreu4zN+1rxyxbfwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AM+bYgeN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-545fed4642aso1200846e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740068355; x=1740673155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FbLGtpaYb7GP8BUC9A3SVhEyUFy/pRikzTZLrMMHtrI=;
        b=AM+bYgeN4SwhHPFPi0pcnUOuqkooYXpe4KyS4TKkc2Y9wtMNfQsmedAey1C9a1rkPv
         5Aq+D7N8zYCLLUMIl53fuzp44OYcZ05TrkIVBGqt+DdaSW9UiwmiOlbOiiMfMn1PfQ1P
         yiG3X6vumX52Oqvzcx3TlCYnCLL7rRokCRMU77NrgKRvHtWoNyja6AA9TBgdZsDmRABD
         nw2K+v/jq+ygCkvd9FlcvbxQ97S4JCy0nGUNL2THdm22syx3IcdX1aG2+9uWKOZbyHOi
         +Bs9+Ygt3oHe4xuu+3tF3+Owq9j4S7RpC2yfV2nh/dYlmBlLAqNqSu6R7Js1/EFeqTMh
         VAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068355; x=1740673155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbLGtpaYb7GP8BUC9A3SVhEyUFy/pRikzTZLrMMHtrI=;
        b=fmxD4djOcsdA+/ioc721oqhriONSg6depXenWFlZ4Ng1by3Nw1W/3dPK4l2w1Jo1Q5
         up2TsKTk0diht4pJtA4U2APmHaGYWhB8u43lApR0qg/vBjJGEjGhH3UWrqH1/Fg1w3LU
         g9oi79FeIMAsxWKH8ctMGgL6dhuW15Zz4DBxx0MGNufOq5n+EmJY/H3zjhJzzj67LL1d
         TAQPrZyPBtL8JqEpWhbPIFRfd76OJ4PwuogkurWNgZSYiGwVHUph4Qs7AvuEpKTpkx8Y
         nLTnCOWPpt7Al7FMHA7FXERsZJ+kCpMR/f1l5kCbNV8GPEMiqKvDAFiUbKnuv2Lnwqjw
         hVzg==
X-Forwarded-Encrypted: i=1; AJvYcCUz8//JdQVaSGrq0oeckXjYJn/vMWMdGhiYCUX4pXYyRNx492GOqI4M84VUdjFXG1vuHKlLVM7Rovf5E+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJX4cE8UCp9D3MEv2G2nRhnAiqEw4sC4+XPvH/Ayo/shmvf4/
	TF2627SXMgSoCz1cDQSA0Ds+febikwoKTzxpjcnURq6H5i6WiLAKQfixWSeyDVkhWJcIg0G+dGF
	P
X-Gm-Gg: ASbGncvY3GZzOBMb/T7zk++siMSO1+zY0N6YS1k7/i7r/ls6dqLx79GR9JPoSuqx5+M
	01HPqScqzov5+hFOjZgLAmiw86jwNn53WlXj2OYq9lgAzct8cZtlq7K2rUvgq1+vEEsAw6D+pME
	fS0pC0GcC7gSk4HpXVv3PRXzhtW6152ExzRu5t/RmQPsfXt47uP8Qr8J8o7c+2W14sv6foO9km9
	TkPaSnsCF3yOMaPSyePTaBPqwEJQqPeuJKDRac+Bjs5na7FUdW3A6iIkwWVuuSJtMywm2FqwgmT
	T8/e0+hXZhylGnP7dZur9ymm5IDvf1GFJQERRoPKgdpJMdDOSMrv1g82a+R9ZUtyLhIk47M=
X-Google-Smtp-Source: AGHT+IGXy8UPjP+6V4rWOhniIYo8XO01HbjN5gyUL77WHLsu40hdggfhlw5BeDY+CUVIKw0g6aq+Vw==
X-Received: by 2002:a05:6512:128b:b0:545:60b:f38b with SMTP id 2adb3069b0e04-54723e04635mr1484163e87.8.1740068354786;
        Thu, 20 Feb 2025 08:19:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461d1d8fcbsm1473583e87.83.2025.02.20.08.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:19:13 -0800 (PST)
Date: Thu, 20 Feb 2025 18:19:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sm8750-mtp: Enable CDSP and
 mention MPSS
Message-ID: <dihnqsdjqxq7uhomceeiejey7dezfyvhpnyc3zyzhyuyfdjtec@d4ruo5xbxid3>
References: <20250220-b4-sm8750-cdsp-v2-0-a70dd2d04419@linaro.org>
 <20250220-b4-sm8750-cdsp-v2-3-a70dd2d04419@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-b4-sm8750-cdsp-v2-3-a70dd2d04419@linaro.org>

On Thu, Feb 20, 2025 at 04:44:13PM +0100, Krzysztof Kozlowski wrote:
> Enable the CDSP on MPT8750 board and add firmware for the modem, however
> keep it as failed because modem crashes after booting for unknown
> reasons.

So the modem crashes on MTP, but does not on QRD?

> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> index 8eeed7f2f7766326cfc7830002768087e9783b9b..72f081a890dfe49bfbee5e91b9e51da53b9d8baf 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> @@ -791,6 +791,21 @@ &remoteproc_adsp {
>  	status = "okay";
>  };
>  
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/sm8750/cdsp.mbn",
> +			"qcom/sm8750/cdsp_dtb.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_mpss {
> +	firmware-name = "qcom/sm8750/modem.mbn",
> +			"qcom/sm8750/modem_dtb.mbn";
> +
> +	/* Modem crashes after some time with "DOG detects stalled initialization" */
> +	status = "fail";
> +};
> +
>  &tlmm {
>  	/* reserved for secure world */
>  	gpio-reserved-ranges = <36 4>, <74 1>;
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

