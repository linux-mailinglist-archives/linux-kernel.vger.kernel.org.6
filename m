Return-Path: <linux-kernel+bounces-219180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374F490CAF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A04293CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B19415666A;
	Tue, 18 Jun 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6D9tNuL"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9106A15623D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711930; cv=none; b=gppjP3CH5XfIKkGV3lAwo9ag9EpCePrwzyncVLrs42xeLYdqQTLq0Oh7QXPRRQW6Hkq8/mFC+MQzXixINN+2neKHQJbbZ9FV4x2NyGP9b05ae8WXx7bxBQzY80HltefWKEbipMZ1qmVf++TyMeydla6iscT2ysR+AvhCcWwNP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711930; c=relaxed/simple;
	bh=wZNDOpKTHd8ecMNd02qDgiQzqSAwFcy8iQEhq7EYuXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ax1NQhWhPL2xBvbC4UHhHMV78/zrP9wR34I9pYD0Y0Of3VsuzslU5L33nMaNbjvOvbkX5iedKMQVFoAIgUI2BPfHTGXlX3DZ/xnWHFuA+r0gWjlyI3mW6wDPMiq1aOw7cWTCD/Z3Sq8FuDdIEC7Jnb3Dc/uxUG5z443aKzCkAqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R6D9tNuL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52c84a21c62so5939861e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718711926; x=1719316726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0mT3XAsM1Zdtz0rmlruEJnGJo+to5fPb6ArUIDmdJk=;
        b=R6D9tNuLndazqa4wIMQ7K+k+I7+GXnNJb2HwtC6ToGoYAeb8kokZLDjxzxFechzTu7
         k6jl6MKhQH5xVNLZQcEQc/rmu24oPTVOA4WllEntBPbdTB7mpgZyhAY2r5m0YWdZWMQd
         cqguxHA1M3H18KTqrWqV+N4dHMeDE6JssFy5oAXIcAS5TyxFcb3uoMbOX7f5je+hSh6m
         lnfGjD4xTPMglnLAPafurqJB5jX8SGSqm35jR9RibGYOpqkGGhi2JEU9lTDtDOCXUvvH
         7QyIpWzGoASmgBfeicLctasfBk+9aItxGYMXXb/w4F69arskevECmpjAioZF9/jku+ZZ
         roXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718711926; x=1719316726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0mT3XAsM1Zdtz0rmlruEJnGJo+to5fPb6ArUIDmdJk=;
        b=FoaiMY4SKxJkfR6mECyHTta+iok3C/xmdE3z9lTjTyAK83GXiGaXyjwOaT0MzRSk13
         bI3eb9xCiMheTuZLyMdB405Bm9VGqPBguc0mLmp3L9t+rjG8PnKPzwDkYtmYi975SxLH
         5NptMsh9Xh6AFLU3d9Kcbd2sSOsDO4NZb6XggepYjjyg2Yg5TBntAuox2PsB6Gpv5/WR
         BX2c3F/yrMu1hXMRraQv4o1+QoxxkmzuwVo36pVwt67cjOaDvmOMn7eoZM5gw3ptzX3B
         AfNetIqSVqXm/TjHirU5TVnC164prMBxnx3pUbSByujelLIxMnShubno4dFFQgt7iH/C
         03gA==
X-Forwarded-Encrypted: i=1; AJvYcCWQDPc1oVrnThd56FzNPd9+SaeALsV68ax51EZw5iugfWe4aE3ufGtDJKZI3B3qc6hwD2dM4oCHVNYdl2pXSPiiwtvmcItISHQwOVPi
X-Gm-Message-State: AOJu0YwNIC0inYVvrpYyTbf2QQZ0KEIY8Fa7uL+1zkLOI0+KPcpdYzAe
	4xPWUa4ELbZeDHlYhFmGCP5U8RkicjB64W8Z1Gy2LRMxLKWZo5c5mptLL8v9iFM=
X-Google-Smtp-Source: AGHT+IFVN5opPFCyVRbiMdFP/MEYoH1ZpA6hRXvw7NtnUj084W/GcW3Rkzq1niVmtjR+lXnvSn5rUQ==
X-Received: by 2002:a19:e015:0:b0:52c:a483:4cc6 with SMTP id 2adb3069b0e04-52ca6e6dd0emr7019928e87.36.1718711925772;
        Tue, 18 Jun 2024 04:58:45 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282f07dsm1491804e87.81.2024.06.18.04.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:58:45 -0700 (PDT)
Message-ID: <ae8cf864-11e7-4bfc-87b2-afc5490b90a9@linaro.org>
Date: Tue, 18 Jun 2024 13:58:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] arm64: dts: qcom: sc8280xp-x13s: enable pm8008
 camera pmic
To: Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd
 <swboyd@chromium.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240608155526.12996-1-johan+linaro@kernel.org>
 <20240608155526.12996-13-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240608155526.12996-13-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/8/24 17:55, Johan Hovold wrote:
> Enable the PM8008 PMIC which is used to power the camera sensors.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---


>   .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 123 ++++++++++++++++++
>   1 file changed, 123 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 642705b7d896..daca6bd2e34c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -297,6 +297,27 @@ linux,cma {
>   	};
>   
>   	thermal-zones {
> +		pm8008-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;

This single line can be dropped now

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

