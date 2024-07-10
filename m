Return-Path: <linux-kernel+bounces-247778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C90B292D46E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061B21C21484
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8D6194082;
	Wed, 10 Jul 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yVsDsvp6"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66409193479
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622593; cv=none; b=ltP1P3M1kqUbVfzBld20/Xdqji1UqShDp671058pMCJQYwXDA1qe3d/ffFO2IxPJI82GZEiqBdFmCaTEZ6Y9NyjIvzwVBhq6Deq7jLjQ/yywF6IIwLCtlqSn+yLOx4d5lcy7YIgK2OZOiEKy1nVVND4pImkqjKeRTNgv8/fFB6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622593; c=relaxed/simple;
	bh=KpsIZ6jzaxZLqZC+0GjwVgDUh89rNXpUnOtFQAHPfIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EThvx8PBuEsPnPl0MKl5NfN385Crn0lNRWIS2jpECX6BQhfUVEK56MYlbTZk8bom3XHqIT4j44NZmCkb5YBaV0hVBPFSNizUo8fVp2gPGr/zhp3c0IG6n7dCcuzYcYCtkIHhHyxre/S7Wfq6fnOnTkKUSq++Kp3aga59JwbkjqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yVsDsvp6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42662d80138so25431895e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720622590; x=1721227390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOsOdIxYv2ExEMFqfT+PN67MY38Sp+oZzT0Ko1qTmks=;
        b=yVsDsvp6KjjX9KCLs5jt8OP5Lcb/GInB6Lo9r1vMlhKQgW6c8lGaCo4tC5h2RezO5x
         DU7rcWMyB3CUVXJscUgLpunZLr3WxcwFDXSGGQs5mSkYMrt3C5zcqRr/vKB+gP21TU5u
         RcVQqrAsntFy6ufBQRq/1tB6VD4hGN49QPHL7xNi9vhYROn6VEpWTULdY6NU+XVxeaqD
         wf3irod1d/vrZfk80MzwSPwJSx73qdYnDB0+Oyak2fIr3BhRgBIvo7+v9EI49t8q/B61
         Uq5QVkl2g9QeyYt2Jf9BG2Jvn8oBA6quq8yckQZH99EKfzeqRGsH5/y/zM8V09tW58gv
         i/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622590; x=1721227390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOsOdIxYv2ExEMFqfT+PN67MY38Sp+oZzT0Ko1qTmks=;
        b=I5eTOtQy8tIko5w0ZlXDp9PJA/hR/Fep8DP/3nTZZYo0hVtQTMxIzMR7iwtC325kkO
         ysY/7pSnEsJ3D7qCQ45gSAP3mCCvc4ASJntaObg6WwwM37UhfjiHaNs5ir18vMp7C/+N
         FF061JUDFQ2D9a8F6YrJJ1Yc/UTCaKmRhDKtnkrh7pSmgBbm56nuq+0aZMK1bx/sjvlc
         DxNN0oHkxH2MiXrOYuCVckmbLOMC2IVxDo7RxT5QGbAtWSvLgpqOSmuTozzaCkvHpYfl
         mLf7+e7qiVKNKtk5iBD8hNbYsQb9yrNdVwM3Gj9dDOWk1x6zvYubAWJW4RHXFA5DDqJ9
         rHuw==
X-Forwarded-Encrypted: i=1; AJvYcCUjxwY9z1qe9w9C8r4aYCy+abq47cUgh1dy/cE9BFRYgFziN7VePT4CTI45NYI49n/RpCe0i6jfJFse+Ab8niU3t8c008+/KZTejgwy
X-Gm-Message-State: AOJu0Yzw3jBVHtNSgRK3LK9KY5UJINg3FJncHCWFhemmRZaUKFXy6wig
	asptpONVeugkSzCs1IOiwwgZYIOqwSiyN++idIyFTfOAn3C+N5tjaXyYyeIXQeo=
X-Google-Smtp-Source: AGHT+IGVb8T0zmjUppXKMiGZvXO5lSsizz8CluNzkaf++om0s6TaTa5apn/9eqEINpHhSmfa5Hi0zQ==
X-Received: by 2002:a05:600c:5584:b0:426:6087:198f with SMTP id 5b1f17b1804b1-426708fa98emr36208235e9.39.1720622589688;
        Wed, 10 Jul 2024 07:43:09 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89108sm5480933f8f.55.2024.07.10.07.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:43:09 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:43:07 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Fix up BAR spaces
Message-ID: <Zo6d+3T/wcVHiWi1@linaro.org>
References: <20240710-topic-barman-v1-1-5f63fca8d0fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-topic-barman-v1-1-5f63fca8d0fc@linaro.org>

On 24-07-10 16:07:23, Konrad Dybcio wrote:
> The 32-bit BAR spaces are reaching outside their assigned register
> regions. Shrink them to match their actual sizes.
> While at it, unify the style.
> 
> Fixes: 5eb83fc10289 ("arm64: dts: qcom: x1e80100: Add PCIe nodes")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Also tested on CRD, so:

Tested-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 7bca5fcd7d52..bc5b4f5ea127 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -2895,9 +2895,9 @@ pcie6a: pci@1bf8000 {
>  				    "mhi";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> -			ranges = <0x01000000 0 0x00000000 0 0x70200000 0 0x100000>,
> -				 <0x02000000 0 0x70300000 0 0x70300000 0 0x3d00000>;
> -			bus-range = <0 0xff>;
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x70200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x70300000 0x0 0x70300000 0x0 0x1d00000>;
> +			bus-range = <0x00 0xff>;
>  
>  			dma-coherent;
>  
> @@ -3016,8 +3016,8 @@ pcie4: pci@1c08000 {
>  				    "mhi";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> -			ranges = <0x01000000 0 0x00000000 0 0x7c200000 0 0x100000>,
> -				 <0x02000000 0 0x7c300000 0 0x7c300000 0 0x3d00000>;
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x7c200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x7c300000 0x0 0x7c300000 0x0 0x1d00000>;
>  			bus-range = <0x00 0xff>;
>  
>  			dma-coherent;
> 
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20240710-topic-barman-57a52f7de103
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 

