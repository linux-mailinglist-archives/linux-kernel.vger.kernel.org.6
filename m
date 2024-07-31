Return-Path: <linux-kernel+bounces-269957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD5943943
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628C91F21A84
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8213916DC20;
	Wed, 31 Jul 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnpszk2Q"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412516D9B3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722467590; cv=none; b=ZQqJI9K/l6R0dmiu6sUF68Zu4BLzV7EP6YpdTyyEXgcVGH0HKJihw/ET+KQFuJDc0MO5RdH5R3HKHtXKfhjq5UWCnJ7zR0vesQsizUxt3iYO1tPSlCZcFCuRmPLCTRakyGvCgO3LFEMJErJTBRWEa7U8WtfzdzZYwjVhCffcrCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722467590; c=relaxed/simple;
	bh=AVt6aayRlVI4u4lXQ38g5LptWQXU1wjBRjWmLIjh0dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIRfxzmfdkxGMVKwWMOaTyYYKxcnkWW9j+gxotV7oXo1IQ3gzYHmAIsmyd+S0uqG9YpKeIs40eNoWpu2WY7+HJKiSFs66BDIWzUTrRJWXpWdyJTSn+T/OJjELrE0CxbAblb9zv5rnkkp0cW9Qg8QEBp2ktJ9+tPqchR7fibXHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qnpszk2Q; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef20c3821cso12291431fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722467587; x=1723072387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9FwulalC5BN3JPzCPlj/3jn9GulBvv3L0dsk5iTXac=;
        b=qnpszk2QQOZ/cHgGoav0IhbsV4+vLWas5tx+xzksFslz8Msf1bmg4Pc9+Ph8XMGeGo
         M4fwLA5F6ayPI3y+YMNsqXbHOezzwbl8c9kk44N4ZrsTXmIsxw94GIMj4N3AgkaWwML8
         juSQe1GCKf1erLSJh0pwB4X+4+F2FFAKvG4PbXpbEZCzYCxI7uPyYezEXv7bmFX/g3JU
         z1dSct5bPFkru/bTl+ysgcBFY8EZ8U45yjzpSmZbOef7eTC8HaeqMJTU1mX7zEr306rk
         X/XnAFmGy8iwsyrx7Zn6srA8LKgybPhx385sxx1yTNsUEAPpk67SIXnW6Z9bi0L2yGXt
         Eq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722467587; x=1723072387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9FwulalC5BN3JPzCPlj/3jn9GulBvv3L0dsk5iTXac=;
        b=avydnArj0xbntMwEeX9Bpxkr0pgQbYLBUEkXW5MLzEBWJ8EEAl8SQrdMQ28Vv1bGUl
         mvpM3Hb//HyFXHIOdU5OBJ7AzUyY7waUfpfT4fdCpNN3H7vG+4mNiNshhPUFBUPC8lE+
         YocVpTqFjXJz+WrrYKjVtINZO3iR2zvFaNsNn2n9b5UdVHHhvq/YWIVFk2LCdn0ZwL8q
         vn5JPO1lYbO9NgXeS5XKtXS4BpWWuRG6iZopr46czpB9FBiUw4oT54DgNStFERD/99mO
         jwFPrReEh2FL54KAnFfmf0VmABMSD6MfojO1Suo6FJZrSZsvKfJKECAHvoM7UIUMooNN
         DJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwJgmhxGnr8LJ/ts3UnbvCvTiq5bSejdNzWcgRNhlc7ujePHHVj2IJHniHhywkPeZrgV9jj5eMlsNJ2Xwe4LQIhd1RmR71NJ9opsDw
X-Gm-Message-State: AOJu0YyCU7iJerfQ17q47JYiun7H9YWkfAn0Ri8Pw9fbPHfxSlpLVIAW
	+KRfa9EeJchUY3dE1UQJaq2e1Zax8KNg9NSBui9HlKh1gBemxDe7I1uNdt2QWwQ=
X-Google-Smtp-Source: AGHT+IGqyMlEYX2+sT4G392f7X7dB6d41xG6FEU9f+59xOrGeXr7RGxTPSasSiLCScH1hTs87g/jJQ==
X-Received: by 2002:a05:6512:2809:b0:52e:9beb:bc09 with SMTP id 2adb3069b0e04-530b61af9eamr137194e87.3.1722467587196;
        Wed, 31 Jul 2024 16:13:07 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530abeefd04sm671995e87.121.2024.07.31.16.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 16:13:06 -0700 (PDT)
Message-ID: <0062e300-cfbe-4d6a-8985-04699ee1d467@linaro.org>
Date: Thu, 1 Aug 2024 02:13:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] dt-bindings: clock: qcom,sm8450-gpucc: Add SM8475
 GPUCC bindings
Content-Language: en-US
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 vkoul@kernel.org, quic_jkona@quicinc.com, dmitry.baryshkov@linaro.org,
 konradybcio@kernel.org, quic_tdas@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@mainlining.org
References: <20240731175919.20333-1-danila@jiaxyga.com>
 <20240731175919.20333-6-danila@jiaxyga.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240731175919.20333-6-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 20:59, Danila Tikhonov wrote:
> Add SM8475 GPUCC bindings, which are simply a symlink to the SM8450
> bindings. Update the documentation with the new compatible.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>   Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml | 3 +++
>   include/dt-bindings/clock/qcom,sm8475-gpucc.h                  | 1 +
>   include/dt-bindings/reset/qcom,sm8475-gpucc.h                  | 1 +
>   3 files changed, 5 insertions(+)
>   create mode 120000 include/dt-bindings/clock/qcom,sm8475-gpucc.h
>   create mode 120000 include/dt-bindings/reset/qcom,sm8475-gpucc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
> index d10bb002906e..608fe63fb43a 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
> @@ -15,8 +15,10 @@ description: |
>   
>     See also::
>       include/dt-bindings/clock/qcom,sm8450-gpucc.h
> +    include/dt-bindings/clock/qcom,sm8475-gpucc.h
>       include/dt-bindings/clock/qcom,sm8550-gpucc.h
>       include/dt-bindings/reset/qcom,sm8450-gpucc.h
> +    include/dt-bindings/reset/qcom,sm8475-gpucc.h
>       include/dt-bindings/reset/qcom,sm8650-gpucc.h
>       include/dt-bindings/reset/qcom,x1e80100-gpucc.h
>   
> @@ -24,6 +26,7 @@ properties:
>     compatible:
>       enum:
>         - qcom,sm8450-gpucc
> +      - qcom,sm8475-gpucc
>         - qcom,sm8550-gpucc
>         - qcom,sm8650-gpucc
>         - qcom,x1e80100-gpucc
> diff --git a/include/dt-bindings/clock/qcom,sm8475-gpucc.h b/include/dt-bindings/clock/qcom,sm8475-gpucc.h
> new file mode 120000
> index 000000000000..2ba622290833
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,sm8475-gpucc.h
> @@ -0,0 +1 @@
> +qcom,sm8450-gpucc.h
> \ No newline at end of file
> diff --git a/include/dt-bindings/reset/qcom,sm8475-gpucc.h b/include/dt-bindings/reset/qcom,sm8475-gpucc.h
> new file mode 120000
> index 000000000000..2ba622290833
> --- /dev/null
> +++ b/include/dt-bindings/reset/qcom,sm8475-gpucc.h
> @@ -0,0 +1 @@
> +qcom,sm8450-gpucc.h
> \ No newline at end of file

Please remove the added symlinks.

--
Best wishes,
Vladimir

