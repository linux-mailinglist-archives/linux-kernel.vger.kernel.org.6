Return-Path: <linux-kernel+bounces-542385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0E2A4C91C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A988B17615B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366DE263883;
	Mon,  3 Mar 2025 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+fiwHUZ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF9262D1F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020862; cv=none; b=R+BgvQXKr8rhuhrytLb1VfeOAvzyhTL9PBf/ZxnLKq/K5LSCmllan3Yg9JA4UJj6bpR2AGhDQLyyYL6DkVDiUdWKsXiRJBRPI67kb/zSORx/3jE5gzVOQ9V68Dog5HltMTk5UtWmRliMcChlqq6AQuaYl9l8zpBFRl5lSyTp4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020862; c=relaxed/simple;
	bh=TqG4inTbI58GeXNn2jdYJcdrz/yN7Nwl/LBiE3hddGg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fVN9fcpE1uVm+7NCrUmU2jAjG9vT32pqNOjSvCGPSJcu5lgw7ASOl003jeJrIWg+ZLHvStCsJk87WIxq73MjFpuBSJUNLvcra/ulKU1XneYiwdtKFwFpaZNG1ssag2PlddOw7hbF3i/GfMkLBTpSGYZz1ohzH+s7+hJJ7wDxv/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q+fiwHUZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bc63876f1so7501645e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741020858; x=1741625658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxWgkFt79rQrjB13JnAOXFuAB8VTulqV3Xpey4gNzq4=;
        b=Q+fiwHUZAx0dU0sF9xcKppDFltPuH3a1pyG2I1eo7wG6YGlxeNPNLodssMn+FKBIgA
         B76GTEtUGsSdKZrldx0+dXSt6rjfFf9yyq4aK4rYwwOhE2e/vCeXFDykDUOqMx7W1nGc
         dQfAuj8vnWRia8EU39JgVedK1hbLFGeZOF9mynoOKK7sDoUjBL6+dfep2F+Ljug8DGx0
         AV46BPivQ2tIeg/5dHHoKkGa/AX6K+/bXou9SQURBKqNCXw7cGJ+OHIlHaioRWeRpER6
         w75iLpgt9+xRzeVORi//jl1b6gEmXhQ/ay9uSxll/ASBXifMP2VdNqHuaKTg4WTwzhub
         /G/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020858; x=1741625658;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GxWgkFt79rQrjB13JnAOXFuAB8VTulqV3Xpey4gNzq4=;
        b=GWES1vqf3BTvjY1qNL16rdvRCyVunLvXk0iJ1wFXu6Gtg42YY40UlD4pkodX8YGtbg
         Fszx1pXxAC5rXzaCHa1Jn1eBrKqeUEfvqTCvnCKlojcJW7eJlTxhijafZ9/TnTmI1KBz
         I29va1BJd4hPOOCZQuf8lMG2cQbDARMnVHBlPjzNm2dpMXsH91p4bx+YEmDnHB7jaMCo
         MztBtCNtll4OPIhh9Oh7ArDyO5nnQ9cYxRMtVr18xcxRXZB673f73bGfHdmT3MHe7pb3
         kMYgk1osXyiyZrgRHhgT+RXpz+eFvFsqAm2cdPEM31yTNgtK+w7LzRczAsWYuCCIBOWt
         B39w==
X-Forwarded-Encrypted: i=1; AJvYcCUuLP7oHZ30jL0IqHENm/TIfi+jiqsm/QIigEdU6hqKJnS0BhLnkCLJQV5IBerIP6F+GOAEEqKVlMEGgbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6nTyQqCq9OlF/OYWZ1kJhwnHZmFiIfJvmru8wWgEfqQYCU1m
	Z1WFhiMCLvNgZWrxuSOBb2SU4WmVmsZF0so3eM8pNSAscQBP81VQKvfFblDTXnA=
X-Gm-Gg: ASbGncvYbx+VFePbMa+uoTankzFxJInA9zs++7GkeUCu3sPmYLlvbEya0cZCWHj61Dz
	BhGokqAQRAo7H3fGf4IKs9q2Cj1TSPJndnzPS+PuhbLYxs1bT8HbHkruG6KBiIwrNQGolXH+ktz
	BjQuVc6QDOaj5hHWbLzO6sDEyXc/ch8xKk8TEq4XFahC+M9WV/LrJyb6mySa111cum4E8ebHgH2
	7chmctJhFCFsRT9Io2tUWp7Lteb1/3B3D1EXi/UcaPDru7960g4GwMw/wJ3/lXYWwbE2pilFSas
	rZB0+0PQrAwTZBgNH7G4uDxpUruGky40z3WTa9otbFX5geimq/u31j3igrpr1LtgaXM4w1CWnAu
	PbgL4g5avy7jvplnAGqWhQw==
X-Google-Smtp-Source: AGHT+IEHzgntCiIyFIejt+velJ1DKYJeY/DP/PmofPesUSGSnk34CcJB8gGDJCJeXZwhol/qtJoMiQ==
X-Received: by 2002:a05:6000:1789:b0:391:13d6:c9f0 with SMTP id ffacd0b85a97d-39113d6cc41mr1329180f8f.47.1741020857759;
        Mon, 03 Mar 2025 08:54:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1c49:dea2:d749:5015? ([2a01:e0a:982:cbb0:1c49:dea2:d749:5015])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a5esm15251582f8f.35.2025.03.03.08.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:54:17 -0800 (PST)
Message-ID: <1058b59c-af0c-45ba-87ac-e3e243883f3e@linaro.org>
Date: Mon, 3 Mar 2025 17:54:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/4] dt-bindings: media: qcom,sm8550-iris: document SM8650
 IRIS accelerator
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250225-topic-sm8x50-iris-v10-v1-0-128ef05d9665@linaro.org>
 <20250225-topic-sm8x50-iris-v10-v1-1-128ef05d9665@linaro.org>
 <9799775e-f754-f717-538a-cfea3dbc794b@quicinc.com>
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
In-Reply-To: <9799775e-f754-f717-538a-cfea3dbc794b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/02/2025 13:21, Dikshita Agarwal wrote:
> 
> 
> On 2/25/2025 2:35 PM, Neil Armstrong wrote:
>> Document the IRIS video decoder and encoder accelerator found in the
>> SM8650 platform, it requires 2 more reset lines in addition to the
>> properties required for the SM8550 platform.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../bindings/media/qcom,sm8550-iris.yaml           | 33 ++++++++++++++++++----
>>   1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
>> index e424ea84c211f473a799481fd5463a16580187ed..536cf458dcb08141e5a1ec8c3df964196e599a57 100644
>> --- a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
>> +++ b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
>> @@ -14,12 +14,11 @@ description:
>>     The iris video processing unit is a video encode and decode accelerator
>>     present on Qualcomm platforms.
>>   
>> -allOf:
>> -  - $ref: qcom,venus-common.yaml#
>> -
>>   properties:
>>     compatible:
>> -    const: qcom,sm8550-iris
>> +    enum:
>> +      - qcom,sm8550-iris
>> +      - qcom,sm8650-iris
>>   
>>     power-domains:
>>       maxItems: 4
>> @@ -49,11 +48,15 @@ properties:
>>         - const: video-mem
>>   
>>     resets:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 3
>>   
>>     reset-names:
>> +    minItems: 1
>>       items:
>>         - const: bus
>> +      - const: xo
>> +      - const: core
>>   
>>     iommus:
>>       maxItems: 2
>> @@ -75,6 +78,26 @@ required:
>>     - iommus
>>     - dma-coherent
>>   
>> +allOf:
>> +  - $ref: qcom,venus-common.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - qcom,sm8650-iris
>> +    then:
>> +      properties:
>> +        resets:
>> +          minItems: 3
>> +        reset-names:
>> +          minItems: 3
>> +    else:
>> +      properties:
>> +        resets:
>> +          maxItems: 1
>> +        reset-names:
>> +          maxItems: 1
>> +
>>   unevaluatedProperties: false
>>   
>>   examples:
>>
> Since we are using same binding for SM8550 and SM8650, I think, it would be
> good to rename this file to qcom,iris-commom.yaml

The usage is to name the file based on the first compatible introduce,
and split/rename when adding new very different HW, here the difference
is minimal so it's ok to keep the current name.

Neil

> 
> Thanks,
> Dikshita


