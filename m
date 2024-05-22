Return-Path: <linux-kernel+bounces-186237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7498F8CC177
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA821F234E5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E99213D899;
	Wed, 22 May 2024 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3BTuPI0"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DED13D636
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381750; cv=none; b=A4hVLRXjXimcpaHmIFdniRzgK+OT8i6X+IDXWO9fNCad+xyrmOQHvM2ENRnHxrvUB7Rw5pPJ3ms0EC9FGshKHff/B/ZwddFTyip3MYPGWl++/UeKU7oALGP2Q1skk9PDskF3M5kd7CKXgF56dWVKypYSfb0A2L0lmzq3et9FRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381750; c=relaxed/simple;
	bh=7wiXa/iWDYflvFRo8c5DidPTf7zKXEj/6WnLlAc9P70=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mf/zlPHNj3fTX0dZhFndorYO+jW/cfI4aTJ/hCQPndaANUaETuM3km6Q9svQvinB+VnsDcav7qKwwADs5LY0xcU8vLMsibafKdcCASVVxcFunzd4ynRZfIs2Ufa7SG9GQdNiFG4TphytLWv71miPcb61HyQD2izxTspGiO/Lwn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E3BTuPI0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-574d1a1c36aso9931468a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716381747; x=1716986547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cwBpBrNlg7bYd5+wIqoNBCJCZKw3R87piqG048jZ3k=;
        b=E3BTuPI0Je9gmniVxelXrM3oXdmA6DnC0rnFXmmFiHG8H65lAgx2qAAhccyZi2Lx8E
         KpUbyde3/jsgHIEucuodqgn5FiR8G+z93StdsOCWAc1M0nqD4ix+swc34eFFiA6LHbX0
         BHBSH1MCXp3N89rHjfaMrRHuqLNce0QZcxpV4L+Yj2wgtF2CJv3lUDzgHdkULwemXCRr
         hThxotb8EDNhkyYKqxg340OJR/FPo/YVSgRyzrRBrDvJbAz1pQQQintrRIuM4Ijqwluv
         AtnxSKeD58Gp4glZJLEhu+oVXMsvYiVICzGrTLRAoWy/DVrzuwRqJwh3Vk5URC8oiYsM
         9l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716381747; x=1716986547;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3cwBpBrNlg7bYd5+wIqoNBCJCZKw3R87piqG048jZ3k=;
        b=DXfmZ7taKEEhUx9DBMvEBsaclV4Cc0liIN5BrCVjDNH+sDTnmucuftyvYZHj+RCUat
         VDw3wCY/Y+hS6wbo3jQqctpXilHDnMiIuNSi/DvNCl98Af3Bsz3czN/kI4xqMCAUYfjZ
         kiiGnK0g9H7nD4hCwchtAbYkxKguP4t3gS6T/LXQSeN2n+MyG5QraRxeiX8iWomjp/AQ
         0SjC0LgsFgd6aEfCr1tdIlNKAi4paAEIB2dUTLmSjjsUSV2Yfa69uV7YVWQ9n6kpl3q8
         j4T8kwCjAGKFt3EByx6Acc/W7Rc1G/abvEldm2lW5SVTFiuGpMr/BDzahAK535kN3Xq9
         2oDA==
X-Forwarded-Encrypted: i=1; AJvYcCW4xp3GmGQA5TeR/ORlWsu29pqq2nvYtKNQOjxG1x11A/0SaPM+DFX54W9HtYxNlWJBF32wvRHKZnwBHkICTeiLr9enUjxIKYvjn6Nh
X-Gm-Message-State: AOJu0YxssoVkvQXmIGdLAoevOKPbM+7cNGqEsNeoMu6XQP4WzpJ/ahxX
	L4fSzOBWe3+y1Qshv6AlEB1/VleRfZ8lUcDLtpT1FVA2r2HMQ7TaUUcREonwp1I=
X-Google-Smtp-Source: AGHT+IE5Tnokc7QdDplSczZ+cKv9LxnraYIxNIAltSdB9dqDye8mcBSttNmQnCIsVVqHNgSPb3W/yw==
X-Received: by 2002:a50:8d4d:0:b0:56e:232b:95cd with SMTP id 4fb4d7f45d1cf-57832c8a6f8mr987724a12.41.1716381746888;
        Wed, 22 May 2024 05:42:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8b9d:52bd:4757:6b10? ([2a01:e0a:982:cbb0:8b9d:52bd:4757:6b10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c323866sm18286039a12.87.2024.05.22.05.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 05:42:26 -0700 (PDT)
Message-ID: <e89c3270-e51f-4d5b-87db-09ff8f0961e6@linaro.org>
Date: Wed, 22 May 2024 14:42:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/5] dt-bindings: remoteproc: qcom,sm8550-pas: Document
 the SA8775p ADSP, CDSP and GPDSP
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jassi Brar <jassisinghbrar@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Alex Elder <elder@kernel.org>
References: <20240522-topic-lemans-iot-remoteproc-v1-0-af9fab7b27f0@linaro.org>
 <20240522-topic-lemans-iot-remoteproc-v1-1-af9fab7b27f0@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240522-topic-lemans-iot-remoteproc-v1-1-af9fab7b27f0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2024 14:08, Bartosz Golaszewski wrote:
> From: Tengfei Fan <quic_tengfan@quicinc.com>
> 
> Document the compatibles for the components used to boot the ADSP, CDSP0,
> CDSP1, GPDSP0 and GPDSP1 on the SA8775p SoC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 76 +++++++++++++++++++++-
>   1 file changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> index 73fda7565cd1..9d3a862c39e1 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> @@ -16,6 +16,11 @@ description:
>   properties:
>     compatible:
>       enum:
> +      - qcom,sa8775p-adsp-pas
> +      - qcom,sa8775p-cdsp0-pas
> +      - qcom,sa8775p-cdsp1-pas
> +      - qcom,sa8775p-gpdsp0-pas
> +      - qcom,sa8775p-gpdsp1-pas
>         - qcom,sm8550-adsp-pas
>         - qcom,sm8550-cdsp-pas
>         - qcom,sm8550-mpss-pas
> @@ -44,12 +49,13 @@ properties:
>   
>     firmware-name:
>       $ref: /schemas/types.yaml#/definitions/string-array
> +    minItems: 1

This will allow a single firmware name for all compatible,
which is wrong

>       items:
>         - description: Firmware name of the Hexagon core
>         - description: Firmware name of the Hexagon Devicetree
>   
>     memory-region:
> -    minItems: 2
> +    minItems: 1

Same here

>       items:
>         - description: Memory region for main Firmware authentication
>         - description: Memory region for Devicetree Firmware authentication
> @@ -81,6 +87,21 @@ allOf:
>             maxItems: 5
>           memory-region:
>             maxItems: 2
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,sa8775p-adsp-pas
> +            - qcom,sa8775p-cdsp0-pas
> +            - qcom,sa8775p-cdsp1-pas
> +            - qcom,sa8775p-gpdsp0-pas
> +            - qcom,sa8775p-gpdsp1-pas
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 5
> +        interrupt-names:
> +          maxItems: 5
>     - if:
>         properties:
>           compatible:
> @@ -128,6 +149,7 @@ allOf:
>         properties:
>           compatible:
>             enum:
> +            - qcom,sa8775p-adsp-pas
>               - qcom,sm8550-adsp-pas
>               - qcom,sm8650-adsp-pas
>               - qcom,x1e80100-adsp-pas
> @@ -177,6 +199,58 @@ allOf:
>               - const: cx
>               - const: mxc
>               - const: nsp
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,sa8775p-cdsp-pas
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: CX power domain
> +            - description: MXC power domain
> +            - description: NSP0 power domain
> +        power-domain-names:
> +          items:
> +            - const: cx
> +            - const: mxc
> +            - const: nsp0
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,sa8775p-cdsp1-pas
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: CX power domain
> +            - description: MXC power domain
> +            - description: NSP1 power domain
> +        power-domain-names:
> +          items:
> +            - const: cx
> +            - const: mxc
> +            - const: nsp1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,sa8775p-gpdsp0-pas
> +            - qcom,sa8775p-gpdsp1-pas
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: CX power domain
> +            - description: MXC power domain
> +        power-domain-names:
> +          items:
> +            - const: cx
> +            - const: mxc
>   
>   unevaluatedProperties: false
>   
> 


