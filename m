Return-Path: <linux-kernel+bounces-555166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B0BA5A64F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270283AB0E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9461E379B;
	Mon, 10 Mar 2025 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHXsfkyz"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BAA1DFFD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642539; cv=none; b=l7vSIVRlTwgcfLzItTB4WkVfc3KLo881CZJ5sBnBom0aJ7IR9FsXojbmc1XtGcylhFRKiwTjxgGKTA0hpM5x0cQr3SaKFi+0VTdd74HENEFD8KFnchvgwZ/3E7VaYXlFTomoGkj1l67PlpjmqCQGPiynE3TP024alBp7FjSHJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642539; c=relaxed/simple;
	bh=yOO+kcznc9jGj+Su8RqYwWEA8F6gmuzqRQmyUr/FcyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ky2dOELK7NEcwnY4UOS00/V+dnjEOlNjuBYAzXWcX9RmBRc2zt9nP0N97pEU20uXgp0vqI83pBkNGmtttEFzB8SVTVNymaBxPinLbo3+zlkCbHQaYAqY5/IpI5yibjrVikYL3hu3MAk+5sNGctCJoqPNK6K5pCFkPj8Gao6FeUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lHXsfkyz; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5498cd09cbfso536708e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741642536; x=1742247336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5nGNIjoZJal1by6jAmqJfEMBdj6g2CPD4ZYPpb59g0=;
        b=lHXsfkyzZMHhhFuKdlZ6wP9rupu1JIYKBC0xy+xgjfuoqoctUzu6KswF6VJMgJc80S
         Qkk4lPXZotV8DR7xv2Utsig4m14df16mbYh/v0oDIHYIOaC6i7wzGolY5VRFTjf3gGDU
         I7Rzgh3HGB0kFPvGR/YtMQvzyC3Y7YWODcvsFpiL9lbyBBLfy5ATQWTjz0FfxHmnM2Ph
         bHG1kxqy7OJNOhLRAdAUVF7b7yXNvZJBrxqI/ca3Oxmfx/xx1X5UZdWc6eHw6TAUcZE8
         +BtSvvYU6uR0KJD7qN+K8dj5mMrVHnGzsL1a8Oa7JLDNIY/fEfNW2CFuQIZ6xk3R3VSy
         7aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741642536; x=1742247336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5nGNIjoZJal1by6jAmqJfEMBdj6g2CPD4ZYPpb59g0=;
        b=LTO4MtiKZUHwR/blVik6NyaS2KA98bT2rwLZRUHoemw0xq2QTOKSHiOrxvHxlj6nZj
         c5H8A+aAmEXu35myOU+lBVt95Cj8sZqE2bLIY1z4Hn4fO0IqR/OdzlatM6hoqA/t3ofO
         Ne8WyhtBuAz/2hWMNqPgntzgeOS9nGBELe3o8TpTKcLtHM7WpRd/aSoLrR7guih/xgsB
         E3vB61oK4CXQUtEl4V2Tfq6o26Cuv47vBDPPM2VHFhYVwOmMhDtlfFxP1Ns2KN3VtOFu
         kiDyK841yAZKIO+TpUjfFVIomTZopbyJYW27lMn0fW5OjT6D0Q2v4ED0AjaB3ql6bQAI
         spPA==
X-Forwarded-Encrypted: i=1; AJvYcCU8q6RHGgJtu7fe5eOjaZJy/BvUPemhJOuat2ZL3awziRMAje7u36hGI4kSFScVCy4l2Dc2rHqB22KZNQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8a3+DZYtl6ajUodZ2/I+cENNcBycORKnHICjVgOH0NDuE1SKd
	JUzNzc6MbXXK7KdXAXrSTMq2KB6e3EHNYzlNGYsxeN6K+KfS29UlIhijanehnVs=
X-Gm-Gg: ASbGnctoDv6HpNTbnDanS1yuwuaBBuUArQztgbRcqL45gtzzB2r8t2GvQx3D74bAsng
	ABhbKh3BmOc9Oa4oO9eSdDjnVDjFmXSzDrL4HTdoKEtJZFmsuWsA6TyJwpLTX8tPOftSWTQ13Ng
	U0rSrb3qUYYx+RmWdDyM9LWozu4fH5S+3TAnO3dFmQC0+5CncVxagv81sq2gUMor8FBFngX5sbR
	MrjtJ+8/URXxZdqZ8NBk7LA7uElvBwZe8LnvbgZFosMGODDgq1dEaY2oevKfCdwHbL8rTjwuhKx
	YG1scKcyWKYqIiRkBhOOAXguf/mSrMONZQb95yVWMBgB5mXemrHQsjC9Fq+QoQzOesg8d6qGinL
	/Us3Q68Qk7X/Gs5qV5r6oYhQ=
X-Google-Smtp-Source: AGHT+IF3UbdFVNzHKttXVepOd/BWp8z+1ePpZ96mJNjgJzTuGPbY+EoLScTTvRSPkloK2EvbHVRnsQ==
X-Received: by 2002:a05:6512:3b9a:b0:545:8a1:536d with SMTP id 2adb3069b0e04-549abaadbfbmr140818e87.2.1741642535438;
        Mon, 10 Mar 2025 14:35:35 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bc679sm1569216e87.194.2025.03.10.14.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 14:35:34 -0700 (PDT)
Message-ID: <7928a52a-ff6f-4705-a55c-8b60fd7797bc@linaro.org>
Date: Mon, 10 Mar 2025 23:35:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: media: Add qcom,x1e80100-camss
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Loic Poulain <loic.poulain@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-clk@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v4-0-c2964504131c@linaro.org>
 <20250119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v4-1-c2964504131c@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20250119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v4-1-c2964504131c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryan.

On 1/19/25 02:54, Bryan O'Donoghue wrote:
> Add bindings for qcom,x1e80100-camss in order to support the camera
> subsystem for x1e80100 as found in various Co-Pilot laptops.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   .../bindings/media/qcom,x1e80100-camss.yaml        | 367 +++++++++++++++++++++
>   1 file changed, 367 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml b/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml
> new file mode 100644
> index 0000000000000..88eeac262f0e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml
> @@ -0,0 +1,367 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,x1e80100-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm X1E80100 Camera Subsystem (CAMSS)
> +
> +maintainers:
> +  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> +
> +description: |

Please drop '|' here.

> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
> +

<snip>

> +
> +  interconnects:
> +    maxItems: 4
> +
> +  interconnect-names:
> +    items:
> +      - const: cam_ahb
> +      - const: cam_hf_mnoc
> +      - const: cam_sf_mnoc
> +      - const: cam_sf_icp_mnoc

Once Krzysztof objected to the "cam_" prefix in the interconnect names,
and it's a pretty reasonable comment, and also it's been applied for
sc7280-camss and sm8550-camss:

https://lore.kernel.org/all/087e7f29-1fa8-4bc2-bb3d-acb941432381@kernel.org/

<snip>

> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    description:
> +      CSI input ports.
> +
> +    patternProperties:
> +      "^port@[0-3]+$":
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false

It's a smart enumeration, nice to see it.

After minor updates done,

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

