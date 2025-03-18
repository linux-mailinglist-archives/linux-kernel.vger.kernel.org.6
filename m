Return-Path: <linux-kernel+bounces-566380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3641A67727
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C624919A5851
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E910420E01E;
	Tue, 18 Mar 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wbxAswXQ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E920E003
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309831; cv=none; b=ZrW41W1zU11K3M3PvjhAHF2P3CqsVRQWdKcfa2o/6+76BPEJ++aPamHpQnOrViEFwfMPuwkZJx7N9JoUNVmrAjZbS3Odcp/I6tjEatNdHZyCQRW8uEnWlJUCgn9yaFjkQGTsBaRIKrZv/xfS+HwF65l8Hz/hvKQwVDc1J8OqZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309831; c=relaxed/simple;
	bh=N+sFJXUfBMA0CoJhUPLBMoIsImXXvb0Qq+jGqBryElU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtsfMlInH3FKviZJ5iOExhf7kEgpheWpseSKiElvvnqJpev6Heu6wrTuvygKsLBZ+Tp3HM2cc2YkGdQsd5/yB4hPRn782uS1PqEKj6HZET/wxFTxbsGVmxwvLwun4gdu3mfIJJ5BxRwlX0htUnU9Wmw1DaFGQF00h81hoobjP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wbxAswXQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac289147833so993788866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742309824; x=1742914624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VVVI1GriwyXPsCwD+FNmlh5SAMatdc1NEjAoi7sx58=;
        b=wbxAswXQ6h9hvVyqLzZGZhMpub+q7TrY5QLHz2CEyeAxIkiuC6eAN6HIKqth4g/gpZ
         Xfh9Z1WDhZd0PDV2knkgsYN9LPIyZ06/dRBtUmG9YjRbjXS7NI+1IITkdTJH65/gKNr6
         Tk5SzVktBHM3hlIuCEfSjkweQlEzWzAQYSR/SBfuVKT/bn4jsRKJ+xfIRExrdqGu6RBv
         PbEKJ3ClFTQcCn+xUi5PrGPRleRy1VsxZ3CbtEsivxd9r3PhZes1+N/no0JztgR94sfc
         Yh7vBRB908pmXIdte3gyeK4OsLu7FcBvsexIJhOcuKDxKyB1B9LTqjPKSdyMFpgDzfe4
         FsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309824; x=1742914624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VVVI1GriwyXPsCwD+FNmlh5SAMatdc1NEjAoi7sx58=;
        b=D2Ls8yMRWo4WLY37pWbwENDZh7o0rESRSG0ef1RtV1ygY8iIz5fBvWOHm8MlTgEMai
         WAK1wZ0fzSax7oMEdYpyFiNLjQZMOphOdHskVHe32KeR0PDRCDIEULgc4wpapNRBXreH
         ppLSCVYxHREDyyPVndyF3mJBJ4ASfQNJskr7hiwyr1L5q/46qZxiwuoBfL90IZcz0SE6
         WIjyB/RP6GpmYob+uajdBp9FGfL2vxeLh/AGPMZzgT0zy+SrVr+RJ601BCS6HPdy2Ter
         iFqTLse7wiYbjwaJ22WHCUd5QBC22vxhyUwf/mf4z5Ock7hMNZ3PSjrKYpQ3u7cjFJfz
         Qsvg==
X-Forwarded-Encrypted: i=1; AJvYcCWGQQ3nWgB44VGLsnCuF56Vh76ZeueT1fo5a0HL16Yt/xziWyIU/zAqFhnnPQNxirWNhAp2YaCu7QsJrKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeycOSPqVODeDNZqSJMr1vkqLgkDN9NpU19IBf9GMR/jfyY0kA
	wHLR90k8P9Y73GJLh1UxaPLYJwFqFcNznjmk/IzgGWnbWyBOpwkNLISixyIGxaI=
X-Gm-Gg: ASbGncu4rVHIYywp4EjTY1hIQpYMQ3k/9U+9RQy7lUrMTx4bSQht8+RoAmD7Lok9tLV
	2kSkEiu3R1+HhtpKWFdA9+auVMmebOItLR6uRYA+3qQ1WiMlJd4s7MG9XoWG32BDv2PvNLzL+n7
	9ZDmfYBHdgTUWYxZEQdADejk+jaADVvruTbLRTqJc1wyuFQhwiCz7tfvkrb61f3Ml1tvRMSfyol
	voXJAQzMTE28d48BmZxowvsUdfR3VMUwIlhUxnDq6JjKXUHgDRT67WbsfjvuiC1usjYYVxitlcM
	S+XgjlUADRP0a/MOxk9KUg4nI/G3jqU2ehfusz58ZLe3zfGbconC
X-Google-Smtp-Source: AGHT+IFPBNRVXxeGQms9vMv75e9tPnzez+MLNXkizMdoSmRWOjlnAFWQdlrvFmC3VIruWWq7ehbuMQ==
X-Received: by 2002:a17:907:3d8d:b0:abf:614a:3e48 with SMTP id a640c23a62f3a-ac3304042e6mr2319157866b.50.1742309823976;
        Tue, 18 Mar 2025 07:57:03 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cfbfasm867829366b.104.2025.03.18.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:57:03 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:57:02 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e001de-devkit: fix USB retimer reset
 polarity
Message-ID: <Z9mJvh2KGwhOJ6I9@linaro.org>
References: <20250318074907.13903-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318074907.13903-1-johan+linaro@kernel.org>

On 25-03-18 08:49:07, Johan Hovold wrote:
> The ps8830 retimer reset is active low.
> 
> Fix up the retimer nodes which were based on an early version of the
> driver which inverted the polarity.
> 
> Fixes: 019e1ee32fec ("arm64: dts: qcom: x1e001de-devkit: Enable external DP support")
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> index f92bda2d34f2..dc1a8f5d485a 100644
> --- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> @@ -788,7 +788,7 @@ typec-mux@8 {
>  		vddat-supply = <&vreg_rtmr2_1p15>;
>  		vddio-supply = <&vreg_rtmr2_1p8>;
>  
> -		reset-gpios = <&tlmm 185 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&tlmm 185 GPIO_ACTIVE_LOW>;
>  
>  		orientation-switch;
>  		retimer-switch;
> @@ -843,7 +843,7 @@ typec-mux@8 {
>  		vddat-supply = <&vreg_rtmr0_1p15>;
>  		vddio-supply = <&vreg_rtmr0_1p8>;
>  
> -		reset-gpios = <&pm8550_gpios 10 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&pm8550_gpios 10 GPIO_ACTIVE_LOW>;
>  
>  		retimer-switch;
>  		orientation-switch;
> @@ -898,7 +898,7 @@ typec-mux@8 {
>  		vddat-supply = <&vreg_rtmr1_1p15>;
>  		vddio-supply = <&vreg_rtmr1_1p8>;
>  
> -		reset-gpios = <&tlmm 176 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&tlmm 176 GPIO_ACTIVE_LOW>;
>  
>  		retimer-switch;
>  		orientation-switch;
> -- 
> 2.48.1
> 

