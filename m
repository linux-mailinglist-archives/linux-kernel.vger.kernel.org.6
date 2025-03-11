Return-Path: <linux-kernel+bounces-556997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9981AA5D21F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338083B3A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A7264FB1;
	Tue, 11 Mar 2025 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/4EFY6c"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF381264A98
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730216; cv=none; b=K8ugHgiviNXp+gW3to6F0K0b1RVe7b9rKt15PVDIYCzTggrtf4KX3MdXtzxVlL5de3cbgoxjPsnhepKv/aPjI4t9O9oi9u0/14M7w+oyDL4HIABcak9qyyUpIKvjZ04rvb/eLY5044R5P2GtINXkrVKgJI6U/tmIIvXa30pcFS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730216; c=relaxed/simple;
	bh=avNY8ak+JQWmkFVsZS0aeZyCgTV7dWit3U7qT7O+ZI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIjhkrwLv1mYwJjLGLcnCNPL9YPrKGPdp83FF2J/CD8BKYe5c4P7mJY2lbC1QHaFbxSOO9iPD5vha9NGJ4yAZLhoECTfLjV1oFL1Y+Z5TgtBlK6HKBYjxZr+Q+JzeqF78zi6ILo4R9DwIg1I3/yMe+skQxOHsetvPUB2Xq/QQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M/4EFY6c; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bf4be81e3so3741181fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741730211; x=1742335011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXfL2talT+3Pc3/IEr/DhQxuVz1xDl6VWwKjRxG3X98=;
        b=M/4EFY6cIVYvdw2LILkLrz9hi5jz+hEd0WxqKe2+e2uXEhWds1c8wNc2TUGmnDd3F8
         bvF+yC8mu3usy+jlHfhVXFZF+Smn4TSKgjHxWS7xgfJC/msJ7kJoamlnTfhDziUUPCe5
         njbxjOMWOc84SrvU9qwyrO4/rCZ1moRke350leqQ2147BDUlevwfTEMyP43eKyVrLlPA
         LDUEalgs8XfrRcYrlJulv2k77ZUSeXlGPzO9d+ImhM+ca2U+OePyOZ8GK3dLsTGrp9Se
         nM3KAXw3aMM+jc/NpoIavEonN/HT32Nl8gUuAr6i6r7eI3G3LktTTa77Gh7HGIWKeXGe
         Q4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741730211; x=1742335011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXfL2talT+3Pc3/IEr/DhQxuVz1xDl6VWwKjRxG3X98=;
        b=KgrrDSwBCHM64n9XL4hlj51MSbLLiw9QFHZCGYWWC4vDKvmHj8Tfo7nsmu7HdAl6HC
         De69X82+n2/KiwEX92KfxPU5Iaw8BZJ/fRrm4AFodetec60+WfyG6RsbdasruANlGa98
         nMoQK3Zc1bKOGWtGpNGgY3RJ4+vj0dz2Idfvck/nkiH6Mn/BnvGC3xy8i/Yv7/gx7VIZ
         AcORc9VJK5i+z6VPFOgnBp5H2yOP3u1bXflLuRkUE1lbueN4f+zv3pTSIJvGtRs2nWRq
         68VQIfm73HRN+sDo/be9NvqgIW0Dfbkfnn+j4X32Gh/DacQWH7LgcszZ8Xbb2K3GmMR8
         M2zA==
X-Forwarded-Encrypted: i=1; AJvYcCVluDaJB8cywGNl+INT2yw3OZw0ZM9F1rW/311W2JaAUtExGpVzBDE9RJw0TsdxUgpVT9E6Wepyq2X8Izc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVGN/pJU73JnpBqUTd67OZTJHz39HrXjqzcdUIl9ulb8acN0k
	cPoVWNiyY9+t9MQBp732lcGvpm5CR0jaqwbGz1IzwXwGnZY9kgYcJnCkZMr71Vg=
X-Gm-Gg: ASbGncteUn6q/4HyXHTCC3gUpyRxzml4FV5WRwVFxA0PX7d0gpPrMTqvWVIHWFO8fcx
	6L+lSeXGGkdNQkzW/xNVCPjB9NaG2iV2X5stmx0BX/xzvJIbq7sKHagHsOJPrYhf0m3XdqgCYqG
	EpgmBtAxh18N0DY6K14oal1qISozLCu2mUKkWdejSymc+k7I0mBd+/yFc0fpAdOVfAcNAls977H
	E6e5kT6Sf6Hk63+fe+Wy64pUpz3lntJwlByWYfDCjIlajVCIRFdRSrYcYc5QwgcN6o4z2a1xAtX
	FiEEGJKnJ9cfSuNGaA5dT74YM1z0gjbcuE/v9WXvJdpdMVHO1FAk9mQ6+wRUnml7gzIMBrU9LwH
	0BSdbFDxZsyd3eSz+8sQGhTQ=
X-Google-Smtp-Source: AGHT+IEYO4fmrspVYYrTHdjMDWmEnFADk1AWRMVfCLAiR2Kql+MwftBAWZmi1W1b6z3wGvyZYMCvEg==
X-Received: by 2002:a05:6512:158e:b0:549:8b24:9889 with SMTP id 2adb3069b0e04-549ababf63cmr763732e87.6.1741730210970;
        Tue, 11 Mar 2025 14:56:50 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bd5b5sm1901122e87.158.2025.03.11.14.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 14:56:49 -0700 (PDT)
Message-ID: <3caf6aa5-32d4-4e2a-8872-87e5ddadd7c4@linaro.org>
Date: Tue, 11 Mar 2025 23:56:44 +0200
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

On 1/19/25 02:54, Bryan O'Donoghue wrote:
> Add bindings for qcom,x1e80100-camss in order to support the camera
> subsystem for x1e80100 as found in various Co-Pilot laptops.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

<snip>

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
> +
> +        description:
> +          Input port for receiving CSI data from a CSIPHY.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +

bus-type property of the endpoint is missing.

--
Best wishes,
Vladimir

