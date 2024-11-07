Return-Path: <linux-kernel+bounces-399875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381EC9C05B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A7D1C22330
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0B620EA4A;
	Thu,  7 Nov 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gsW5RuK/"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F9C1F668B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982321; cv=none; b=rk8FS0OMwDOLXSC67AtkEvVSsrng6fEe4Utgm/amDmDLWIqM+PZmz4rab2VLdSLFUbCByIslPe6DXLH1Zj5JcMnGdd3iU24DbK3enKi9kKj3GvpckPIddjdL3vPsckNh6ZcuVvt9OiKfchW3zLsKI6UykD+Pv9NzBdF3Ze3ElVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982321; c=relaxed/simple;
	bh=uOHtoOGSDgDkow1wLA2awmZ3A8Qe3ptAdpnofZDjgqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahQibMVlkpLxdLMtb8byZxEI0yrNrKniR1EgHg+z7O+CrPM8YVAwnNHAa96wz3fosDyZJd6w3Ce2IMaSbTanSNo1e61r5A5pTURyfgahJOBwsDEX7YlnvvdhOsrp/FPGBysp70jQa+Jzod0+ksaThWGH4TXKn/SLDmK0yYjtZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gsW5RuK/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3807e72c468so134408f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730982317; x=1731587117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzbdXmjU7p6o20uBK8Vs/ZUnlHfeyC3jV0YTi+RLdZs=;
        b=gsW5RuK/QVDvjg+NYAX3GtP5VTunCSDJIGe0M5t3ED9PufbRLLGCEYp7BKtAoIoKwg
         k1ziHzQxjJWkq1QgynrKATcUyjVCu1Go/r2KFM6XGhaLgvojxIIQf0p4SjpMfUQe6OaZ
         wcQ9AaE6to2Q20J8bZ1KwaH0UF2SvBRTS98XRch6vxmxABwXhwQ6FfB5kBPVnBiRgN5t
         mrrh3HOoDTBkDfOXi9aMAsXe/LlfUZsYsm8KWLbNHlTlwkLlQhtT03MtZcw3VqGRHl4N
         1GqjAi7hrdDOsFWtq0So6qjnNZWVHBO8fGAcInoOtr6wvsptaQ1VQZpFBOQg8ZJn9NRt
         TDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982317; x=1731587117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzbdXmjU7p6o20uBK8Vs/ZUnlHfeyC3jV0YTi+RLdZs=;
        b=hVYAajemcuyjMlO4+4nBu9vShsw7Hrz1YDFgqGtSmWo7c17YipuFQhkJXJsdVtYUP8
         MtvFKOqilFkOukVgDCu4JaB+nZO3PjsqWQ5G1VZrTM6Yp6Osv5wKsuLZRjSDwBjU54i1
         /6Tdm8oBxKeTflVo3d4yIQpYRD15T8qlZNDWOt0ccgWK5svWmaLqQ1FeeiEQ675jpWkk
         jcwDxCkxMYI0Df1x6uwfMkoqqYYbN7kOkYg0MoVJcOyzs9EhW1IeiVhdu+5iFqDCIGOV
         4w3zuXX0ph4VOx3arvXiviW+pTDRWIVQa0ipUgUvNVEithuRbWNFaGszUkZfFLrqALN1
         jQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwqcV0qiymr2UGvKjLabFQFpuqFDfN3Rga6iT/Aq4wey2E2La3greBCnhXEzuQAtyuUJ34bGB5uTLghBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpCz+EWLXRih/uOZx1U1Zui7N//TK+OsIjXI2cpGhR5qHwcAOu
	gmYNlGIMzR0oenIZaUsgeObOe19xwXoYTfbAoouSOtRwwHT21WRSvqhX6pWNrY8=
X-Google-Smtp-Source: AGHT+IFOgPssWZsDH1j5T86iLoVp1PjuAQf1YJ308gU5MuuoGMyMeA0iydRzzX36J0FJAIprsNb+6w==
X-Received: by 2002:a05:6000:400b:b0:37e:d940:a9fe with SMTP id ffacd0b85a97d-381ef746475mr362301f8f.13.1730982316616;
        Thu, 07 Nov 2024 04:25:16 -0800 (PST)
Received: from [172.20.144.41] ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea5c1sm1625361f8f.81.2024.11.07.04.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 04:25:16 -0800 (PST)
Message-ID: <0ce2df56-85be-44da-af23-cc5bee98e14d@linaro.org>
Date: Thu, 7 Nov 2024 12:25:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: qcom: Add CAMCC clocks for
 QCS8300
To: Imran Shaik <quic_imrashai@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>, Taniya Das
 <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241106-qcs8300-mm-patches-v3-0-f611a8f87f15@quicinc.com>
 <20241106-qcs8300-mm-patches-v3-3-f611a8f87f15@quicinc.com>
Content-Language: en-US
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241106-qcs8300-mm-patches-v3-3-f611a8f87f15@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 11:51, Imran Shaik wrote:
> The QCS8300 camera clock controller is mostly identical to SA8775P, but
> QCS8300 has one additional clock and minor differences. Hence, reuse the
> SA8775P camera bindings and add additional clock required for QCS8300.
> 
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
>   .../devicetree/bindings/clock/qcom,sa8775p-camcc.yaml    |  6 +++++-
>   include/dt-bindings/clock/qcom,qcs8300-camcc.h           | 16 ++++++++++++++++
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml
> index 36a60d8f5ae3..81623f59d11d 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml
> @@ -8,16 +8,20 @@ title: Qualcomm Camera Clock & Reset Controller on SA8775P
>   
>   maintainers:
>     - Taniya Das <quic_tdas@quicinc.com>
> +  - Imran Shaik <quic_imrashai@quicinc.com>
>   
>   description: |
>     Qualcomm camera clock control module provides the clocks, resets and power
>     domains on SA8775p.
>   
> -  See also: include/dt-bindings/clock/qcom,sa8775p-camcc.h
> +  See also:
> +    include/dt-bindings/clock/qcom,qcs8300-camcc.h
> +    include/dt-bindings/clock/qcom,sa8775p-camcc.h
>   
>   properties:
>     compatible:
>       enum:
> +      - qcom,qcs8300-camcc
>         - qcom,sa8775p-camcc
>   
>     clocks:
> diff --git a/include/dt-bindings/clock/qcom,qcs8300-camcc.h b/include/dt-bindings/clock/qcom,qcs8300-camcc.h
> new file mode 100644
> index 000000000000..fc535c847859
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,qcs8300-camcc.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_QCS8300_CAM_CC_H
> +#define _DT_BINDINGS_CLK_QCOM_QCS8300_CAM_CC_H
> +
> +#include "qcom,sa8775p-camcc.h"
> +
> +/* QCS8300 introduces below new clocks compared to SA8775P */
> +
> +/* CAM_CC clocks */
> +#define CAM_CC_TITAN_TOP_ACCU_SHIFT_CLK				86
> +
> +#endif
> 

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

