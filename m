Return-Path: <linux-kernel+bounces-192301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A5A8D1B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D881C20F87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0418F16D9A6;
	Tue, 28 May 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhLPtL2d"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947DF16D4E9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899297; cv=none; b=mb5PDu2QHou1suozgk8wXFKWVJERdbB1Hjr4ZfHlDwLADkXUpCCvFyOo9nR0k+klZWSg6i5IlUvLkkbdw2dWdqCS1ifJTTKtReUAls4QEgZg0BmV4Vm14a1siktGnt0++441UHHhuXdbArqLazF1uSeonTO/sO4WplYYGdhJkGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899297; c=relaxed/simple;
	bh=gfouMYV/06+BHL/0bAd6EAcNAZoOTw8W+qLqYPqa1OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jA7JG1Y/SUz8MBc2uZSBK3iihYveigyIrGgqsmQxq3mBP8VMt2vLQuMhIamFBCWCHuPIjpmedY1eJQhg6IMPanAuwFWCKYIbCXrIDYmwhlSVBg3H9z6rT/1eFwDAxDhM0UWg2CV4jpyNGbn/JUkROhMl/3viIB1f6UpvKAkxiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MhLPtL2d; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e95a60dfcdso8050811fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716899294; x=1717504094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOuf1rNiHEqjRIxx7oHLdZte2vsAcehwFkh3KgmNv+k=;
        b=MhLPtL2dHrGJ2o3L5dUIld5meLRgD7oMCyLwhgAYT5AX77s3t3JDOH3lkITuJVaavF
         7/mCKUXm2Zv8wcJWFU+LJKuLPPmqJ8cPXBB7hHTqFdg+E2+BxBUxSrRZ9SK4e2aM3kFR
         qaWJMghUX+n2NB3quooDBWDnAKTwRhB0WNbz87OVyvNe5UYm4i6XaT7H26AUJSNBdVGZ
         twgwiWDY5UfxKqVJhiiPyzCMW0eKADE0ay412YPDCC9ZT/WaXwRUsL8GrOVozt772hi2
         ilgdOO5iW0UZlXM2flQUk5oLURDMQ6t0m139bWQzgiQOjylBn9SkajKfL787jIRQoBIn
         GMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716899294; x=1717504094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOuf1rNiHEqjRIxx7oHLdZte2vsAcehwFkh3KgmNv+k=;
        b=nspKe4UgamF6pC3S+RBBGkY9NT2+YGh4yuiRcaIHSvBmLLy4lU9BPQUWaTPQYTBxpg
         sEkLZenS1y7muHZ0gNZ925bobY0wRixubbHWGdTIIR2nDuNVAD7BLWgGXrtfMgLCAuIe
         EN/lXfcaX6wHjk3yTbQRrfum9Eg/Ev9VnCZ3PKux8ZZOUeYUMLuGQHxkaEc8WdrUT4z7
         rK7tYD3uNrw2xbX3BEyvgCQcIZHK0wPP96yxexntyTxVjvEFdRPAJoVrvWDqTA1yIz0f
         qnCTsGRC0Y9bmVysxnc5tfxvLo2lIxWVEf36PsPichtmV3+yQgqJrLE92106ORcpn44C
         iPPw==
X-Forwarded-Encrypted: i=1; AJvYcCWWtZ4RPZ5P/KWVhkcP+G9u5o7MmgjN4rr15ldOobHBhqNf08JMiYcchZyBVYyn4dOYPoaxEeKt8vI0B7eTphmJFqilsxL5dvHkio6W
X-Gm-Message-State: AOJu0YzCLC7SIFrEUPAsPfjAsMAwseXamrcJ20v/khlXla0kqV09+tvE
	Dy0fA8OvBRv/qcnRSw0iZQFNisLrOc8RvMqQVzdLfqOCM/xN5VSw+N0q69X9qLE=
X-Google-Smtp-Source: AGHT+IGfLl/jpqILtIojTGh4cDkPEbEGQQOhY0bVSNspFg/dKAiACdONA9Zkl13ynZ7NG50BdEBj3w==
X-Received: by 2002:a19:435d:0:b0:523:6a08:1c91 with SMTP id 2adb3069b0e04-52964ea97a2mr7518620e87.26.1716899293468;
        Tue, 28 May 2024 05:28:13 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c97:23a9:35bc:df2e:d894:2c76? ([2a00:f41:c97:23a9:35bc:df2e:d894:2c76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b067sm956720e87.168.2024.05.28.05.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 05:28:13 -0700 (PDT)
Message-ID: <68e51df8-5553-4df7-91f8-65bef924a407@linaro.org>
Date: Tue, 28 May 2024 14:28:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: x1e80100-crd: Add pmic-glink node
 with all 3 connectors
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240527-x1e80100-dts-pmic-glink-v1-0-7ea5c8eb4d2b@linaro.org>
 <20240527-x1e80100-dts-pmic-glink-v1-2-7ea5c8eb4d2b@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240527-x1e80100-dts-pmic-glink-v1-2-7ea5c8eb4d2b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/27/24 10:07, Abel Vesa wrote:
> Add the pmic-glink node and describe all 3 USB Type-C connectors. Do this
> for USB only, for now. The DP port will come at a later stage since it
> uses a retimer.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 143 ++++++++++++++++++++++++++++++
>   1 file changed, 143 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> index c5c2895b37c7..2fcc994cbb89 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> @@ -49,6 +49,101 @@ chosen {
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> +	pmic-glink {
> +		compatible = "qcom,x1e80100-pmic-glink",
> +			     "qcom,sm8550-pmic-glink",
> +			     "qcom,pmic-glink";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
> +				    <&tlmm 123 GPIO_ACTIVE_HIGH>,
> +				    <&tlmm 125 GPIO_ACTIVE_HIGH>;
> +
> +		connector@0 {

Could you describe them somehow? e.g.


/* Left rear port */
connector @0 {


There is probably some better terminology to describe the one closer and
farther away from the user, do as you will..

For the QCP, they're numbered on the chassis

Konrad

