Return-Path: <linux-kernel+bounces-229757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA89173A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AD51F2595E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9C417DE2C;
	Tue, 25 Jun 2024 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7jeQAPc"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8724417D8AA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351820; cv=none; b=lnuotGTdJ280aHk9ev0yyzlK1eA8gFAD/rAYsneCD64gAZXZuGA3HlcXN3z/BE2w6fvhWP0Py+gmglMgkUTffz0GjCep7VsxsfCCILvvOv3fMbF4Fag2elMcqZjbmwWtpSTfprZQsq0eX2/7390+1qMALr0YWAQtIIQ88U/uDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351820; c=relaxed/simple;
	bh=eK8jnNsLrrwlG3hHsRnPuKUXreDbP+T+9J+d/Ndtgz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFTJ0IVdM5PJ9wLM1bAF3jki72B0Jq7jgp+XNEQEFXJ3vB/9XoCM0v0XbLGKvCxgyTgWYqzvfHlL5xJ1KS85Z7aSKdtKk/V/hkOGlFS1ZxmxD2qeSbEApdpb962fvZZOz1/I2cbJU9jE3V63z1pp4A92HfVnZGUwZxJC1kfiJR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A7jeQAPc; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4248e28de9eso25012335e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719351817; x=1719956617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXpVGAgwaXGnHWzmK/3ybQ7VK229d1+vDFY8MfYFxcQ=;
        b=A7jeQAPcNwVJVN03cHHTA+ib/0Rh74RUxy3c5xV7upsOUU6kNrQlmekPCZT/cPpbBI
         FmMVumGKy2gMbrQnPYNkPCdmYXnWJHtH/1LgE0+qAwqp+r/ZFLvxk4Av9Cj/5NUN0R+Y
         xgZiDJ143Cb/Je9f8SLmZzWG7aTlFxm79o/wPycH6bNrJ6K1qZSAbCXTvui1acxMC77d
         8yfzlDhNtp/V7kZikGETMulGCbFzr7XylaOr51qMMxTZeQiAPpyhFhiigYAnnyD6kq1A
         gBmeiEqsYV/zkOGBvLhVdZ+trE3DoergrVA9Hyx3cgLo/pw8e6mQ3JzL2IluepoiIAE/
         beYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351817; x=1719956617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXpVGAgwaXGnHWzmK/3ybQ7VK229d1+vDFY8MfYFxcQ=;
        b=qyyjx+A2sM7iv8NtfiylsiztjN1JbY/lYWvkvj0zxfMk67nN0Dv+wH3dErcZHkNy0+
         ve4LorRv8lKAm7aZfIUb+IfKi2aFxGXjkBA+i8thSMxv7mNpSeDbQFaHNcucfx0LVskh
         JU7JK4wTuLFOfGT5J80iddkR7+97NY5HbmlpVQT2xal974JU9jA5VYbNrPuNC2d8beDX
         ez5ORBKpNb+mMqOSWyuEcq95f349tGI5gmmZF4iC8OzZ0iupmOA5fuyRLiDGvyS4U/4r
         tCQJ4/fpTI9MoIq1+yTYKX3OQs+vsQ+eyPk4Oa0Zh/Y/tlDDE7Z8Z7yWbrY5DJC9giCQ
         rCig==
X-Forwarded-Encrypted: i=1; AJvYcCV5HoFd1QaeHnvVjxnzlASvPRdKMB8c/IiTcC1/gAB05evsYerSwsLEY2yoKmQcpbkwsddaM5uBFjPk1xwZy2rC9GhvZ8TZLoLDRo5S
X-Gm-Message-State: AOJu0YxtMZUXIc5oIWHEGzfC6v9qG/hHJw5VkzZ7pptlKoQhN7pW7mVz
	PiaNrrDAHSYJIgnS3+ozOcsSSB8UZRg+U5BykPQACykqTf3niKbfXzhsCtk0opw=
X-Google-Smtp-Source: AGHT+IGSc2wgdCJSQ2IQbEeJTeTHpxgUkGGoqpZteI2TbE3JWwvNoFt8wgeJm4phRg+xVk17xHRjjA==
X-Received: by 2002:a05:600c:5686:b0:424:798a:f7f6 with SMTP id 5b1f17b1804b1-4248cc1838dmr67897875e9.8.1719351816915;
        Tue, 25 Jun 2024 14:43:36 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3667c2fd7fbsm13663529f8f.89.2024.06.25.14.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 14:43:36 -0700 (PDT)
Message-ID: <1ba23d2b-473b-41e4-99dd-fa6a489c5af3@linaro.org>
Date: Tue, 25 Jun 2024 22:43:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: pm8916: add temp-alarm thermal zone
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240625-pm8916-tz-v1-1-a4c1f61e92dd@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240625-pm8916-tz-v1-1-a4c1f61e92dd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2024 21:16, Dmitry Baryshkov wrote:
> Define the themal zones using the temperature values in stage1 for this
> platform so that the spmi-temp-alarm driver becomes active.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/pm8916.dtsi | 31 ++++++++++++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
> index 4b2e8fb47d2d..2def48f2d101 100644
> --- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
> @@ -4,8 +4,37 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/spmi/spmi.h>
>   
> -&spmi_bus {
> +/ {
> +	thermal-zones {
> +		pm8150-thermal {
> +			polling-delay-passive = <100>;
> +
> +			thermal-sensors = <&pm8916_temp>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <105000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <125000>;
> +					hysteresis = <0>;
> +					type = "hot";
> +				};
> +
> +				trip2 {
> +					temperature = <145000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +};
145 c seemed amazingly hot to me but apparently this is the more 
conservative of the possible set.

https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blob/LA.BR.1.2.9.c26/Documentation/devicetree/bindings/thermal/qpnp-temp-alarm.txt?ref_type=heads#L28

Heating up even typing this email..

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

