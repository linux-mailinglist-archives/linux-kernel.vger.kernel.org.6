Return-Path: <linux-kernel+bounces-269956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4965B943940
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E814D1F220D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF1016E868;
	Wed, 31 Jul 2024 23:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmjsm7LS"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2016E86B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722467558; cv=none; b=a5m5gufrfn9Kv7S6lDxGfeo8CX63frO+FwG1v5B/uI6OIgHPbJ8awDGmxJDHr56cfh/LUEr1RJklMqJXUGv7Ugc/Ihif9xFG9r/PVh5CwFvGf2wZMhr2KN32rEiHIE4qQGHYZAxar+WkLnMbvrpQrBRgPQI9TVeRPSopZZ2938g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722467558; c=relaxed/simple;
	bh=POSv4ihxBb0Obca530vynvy7d8gZlc4PFHsId7FQDZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCMaa4Kxx5lwuH4Yo5g6e+tDtpdyCOZiWiarnWGhAqVd9JX/WYgFnXtKSIvWtygxe54GTjz94kt5lgHY15JOUj3VspLYcnzT5U0hoiSdvj3Lv2WFpBUA5dgf0lH8babTZ/96vMu+HasvOs/MtWxvy6AdqO3Xa0DgpR/AQl2+Lzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jmjsm7LS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef260c4467so12167521fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722467554; x=1723072354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hyHP6tHqa7ubkYpRyv3ZvH3jJj0lSTMgse6k+aChAtM=;
        b=jmjsm7LS2RGnqg87x+m9HouMJoJj+imjiNsSn0DQfL86aUt/l4/m2GppmN3/uGbM/G
         7sd0APpLM92ZM9/OcqpKnhUQzJ5bTv+ReL29ctoHFHRn6BxVCziIDsdGGuX0Q3ykVZKe
         /zaF7RfADNhEkbfh7EY1bk0nnt7wb0QEa/BgCFeU1Sunb+CrlpSOHJCMzqTCHaVr2Qww
         Y0YUV+RhfBlndyYAj0rShbfCD7B3kSv06n1ABeFsr7bogO4SRCOb4zpajFfluy/iF+e6
         gTpvblQ+OMVH+B04XtGuoRZV96l3MBX+4O3YHGA1LDpTQRdHOUSA56VyoBxcCGrra+CP
         iMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722467554; x=1723072354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyHP6tHqa7ubkYpRyv3ZvH3jJj0lSTMgse6k+aChAtM=;
        b=IFDxjP58gsFsvlJ83vl9/F0ennqgAoAuAPYAYXesH9dyzyV72h/aQokUgnlwgdpSTD
         a+myhmnSreaOTXZK7onLMHS5rf84Y4oVnxRmMb0IrGCmznmpGV9Xc2YZn/e63G5pFs55
         pAOV3CApF3eFFloXf2NwsP3ORYjElyohTTD1x/xgeXLdNERF9UeX5ZIB70H1DnrW3OoG
         yYczD4yBnpEYMNvE32QWOJuxmvnQb9iHVq4T/566ybO3KntIBlBYgugPr+Qb6a+QvLds
         X85uc82rzhXZ+Halg3pNa7Y0SJ8RSLHuNe+XkPzXQSi/Kn9n56oDY2yCWnpCceiUHUnK
         Mf8A==
X-Forwarded-Encrypted: i=1; AJvYcCVJQcDSPFuvSJxJJu+Kvm+k0v4+w+bd6bKXsBTi6dBshmLCixu2lBsrSjVBH5MXDS49gX15ONo5bp8EazQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOXAlba2mBizzRbaEQEeupNlpo7cqscqdweGJzBuYM6PWx1gSg
	sC0YUeGGnUeFXyLWq12/VwKK1ZqWBksD3mxHTKPPJKpRBhO9ZRIEb6A2m8Q7TsY=
X-Google-Smtp-Source: AGHT+IH84HGzXPBSEaAQTdQqM0Mt6cjjb+kg+ySp7HlVzAOaHTrPTsoT0ZoE+Fo8WL54KqX2ZmFmMQ==
X-Received: by 2002:a05:6512:3b1e:b0:52e:ccf5:7c3e with SMTP id 2adb3069b0e04-530b62151c0mr133165e87.7.1722467553510;
        Wed, 31 Jul 2024 16:12:33 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530abeefd04sm671995e87.121.2024.07.31.16.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 16:12:33 -0700 (PDT)
Message-ID: <07a64faf-f97e-4a9e-87a2-598ff73817f4@linaro.org>
Date: Thu, 1 Aug 2024 02:12:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] dt-bindings: clock: qcom,sm8450-dispcc: Add SM8475
 DISPCC bindings
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
 <20240731175919.20333-4-danila@jiaxyga.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240731175919.20333-4-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Danila.

On 7/31/24 20:59, Danila Tikhonov wrote:
> Add SM8475 DISPCC bindings, which are simply a symlink to the SM8450
> bindings. Update the documentation with the new compatible.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>   .../devicetree/bindings/clock/qcom,sm8450-dispcc.yaml        | 5 ++++-
>   include/dt-bindings/clock/qcom,sm8475-dispcc.h               | 1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)
>   create mode 120000 include/dt-bindings/clock/qcom,sm8475-dispcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml
> index 4794c53793a8..76f5a8cc42cc 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml
> @@ -13,12 +13,15 @@ description: |
>     Qualcomm display clock control module provides the clocks, resets and power
>     domains on SM8450.
>   
> -  See also:: include/dt-bindings/clock/qcom,sm8450-dispcc.h
> +  See also::
> +    include/dt-bindings/clock/qcom,sm8450-dispcc.h
> +    include/dt-bindings/clock/qcom,sm8475-dispcc.h

Here a new header file is not needed.

>   properties:
>     compatible:
>       enum:
>         - qcom,sm8450-dispcc
> +      - qcom,sm8475-dispcc

This added line shall be kept though.

>     clocks:
>       minItems: 3
> diff --git a/include/dt-bindings/clock/qcom,sm8475-dispcc.h b/include/dt-bindings/clock/qcom,sm8475-dispcc.h
> new file mode 120000
> index 000000000000..21a9db2d0f09
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,sm8475-dispcc.h
> @@ -0,0 +1 @@
> +qcom,sm8450-dispcc.h
> \ No newline at end of file

Please remove the symlink, it will not be used.

--
Best wishes,
Vladimir

