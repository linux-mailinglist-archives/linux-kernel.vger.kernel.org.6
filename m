Return-Path: <linux-kernel+bounces-231551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F99199DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE24E1C220D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672D194083;
	Wed, 26 Jun 2024 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZN3Wfrj"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC12AF1A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719437964; cv=none; b=g5HQBpKNVHZWF0WlyQHYH0PuYlswYb5O8ZeQrjNPXC+tbnWO+Q5lDEU/lsfylyxw3sFxpfRash8EW8GdGGHYnaChPXTxH2y99ZW+LGm63l2fFbfyTFB/mCmIxIqROUdeVxfNKiD4x9RXM+E8rDp9FEdFwTuYzb4p5rei5Rr2NJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719437964; c=relaxed/simple;
	bh=33mMACKJg1itHjizVY8KDMXAd48Jw+lFkhVQuOQumQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ulq8mahThxV55RjqI6nrwpP/zmY8twm5KJWQmxzNqXEDKJhBe999dTp4TvH3oVOHz0OyvEKuBHlsiZtZ1BnYyPBAuiRAj8/rOCSJ2el/tFv9VMpOGpnxX/8NiCqzIoGL+kHs3RUPYy6TwtmhpxmhhgZgcbDxRKzZUpaENV5K17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wZN3Wfrj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso970029a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719437961; x=1720042761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7L7e5C1/vFl5s/Wn77Ses23ies+BIoOorCDyigrw8VM=;
        b=wZN3WfrjSNduCWkxjRNnj91ipF3jsYNF080NlHgon5jUsO2ZtYqB448DzHndMX5UpP
         J50jxsPqcCP9zy3qtCeJ18c+QGTQfaUAKjtZw0IixMBBEW9gTj63eoFNPxUUVD3MWxDa
         VDpklkeuIU0bx27+DmlR4NPt/Jm2A5RRQIdw4e2374scsIz4ltIUVuIWmJQVfbbDkG5U
         X/usqvfW1bQoGfyOoX6nn1XpILNm6Z3/UkvTmy9/CEz4zqNm5MMV09cP06nqfdT+hq26
         5u93p+Zrn1/7IT9zE414qZ7iozbezDY0cLDzzjJiHDCJLjH1Y8cozHHtqJ2Eg9DUIVIR
         tyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719437961; x=1720042761;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7L7e5C1/vFl5s/Wn77Ses23ies+BIoOorCDyigrw8VM=;
        b=V2lSWWCyYnmhQcEFcIGKLT/Ta4qbqiqxKBRPr3iGL1CfQuspFC1C8v+/UymV0KYGkv
         ST+EYaAi4YSjNWTYHQkpRcqRiuJV3H8bOyTJlMvAbYFvo7bg6FpnCcOxl9MOcIWG1tOt
         T/Z85M9zagIMqMFdJTSz2ehtYV9kJarCWjntumSImeyQ8bYcSKUWKrXcx4Vokch0UKqR
         8aGn0eQWbISbd458S3fXJWcggVyjRC5sExjR4bKkD0i9FabUFwpcE5jtEkiUjoz1oZ+D
         aDjFXyLBcmsXStZrVYavbm1cDGCiyJmPdkpQmLG/y5C4gxzb9rNKQAA+mmRzeXNF5+In
         sUeg==
X-Forwarded-Encrypted: i=1; AJvYcCUrQtZTMiQ8O7cS/xFgC+jJ8yOrrqnuDpouVI9yOqnjmkIbmjea8V7mjsVUi6rnq7m5KIWrhspz5zNFMjyD3b+8s//ITc3T3915r/vE
X-Gm-Message-State: AOJu0YwPT0VyWi/+fQHEYXGYFv8KBJ5GXLFUV1e2hJYaeGxZFG9E8CE9
	+3TQowD8obNG2TKnqMmNvmyohcHwAX7e9ProqXhmc1FDJrUK82YQvaE2mo/i7OGPXmbv6vmepo4
	HxDQ=
X-Google-Smtp-Source: AGHT+IGvq7E13DV9iNnVcdPiYH+SNAfpHIkr3zyoKHgWKaXG17u39y1+WTSsnYZulR9cqSdqq4pACg==
X-Received: by 2002:a50:cc85:0:b0:57c:70b0:d541 with SMTP id 4fb4d7f45d1cf-57d4a28e5bcmr9805574a12.20.1719437960467;
        Wed, 26 Jun 2024 14:39:20 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d0c9dbe6sm15489a12.16.2024.06.26.14.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 14:39:19 -0700 (PDT)
Message-ID: <20b5533a-25e9-447d-8138-7328088f8efe@linaro.org>
Date: Wed, 26 Jun 2024 23:39:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: x1e80100: Add gpu support
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: freedreno <freedreno@lists.freedesktop.org>,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240623110753.141400-1-quic_akhilpo@quicinc.com>
 <20240623110753.141400-4-quic_akhilpo@quicinc.com>
 <f5ef4e3c-66e8-4833-86bb-c38658b923ae@linaro.org>
 <20240626210420.uapn2dauiskluidq@hu-akhilpo-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240626210420.uapn2dauiskluidq@hu-akhilpo-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.06.2024 11:04 PM, Akhil P Oommen wrote:
> On Mon, Jun 24, 2024 at 03:57:35PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 6/23/24 13:06, Akhil P Oommen wrote:
>>> Add the necessary dt nodes for gpu support in X1E80100.
>>>
>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>> ---
>>
>> [...]
>>
>>> +
>>> +				opp-1100000000 {
>>> +					opp-hz = /bits/ 64 <1100000000>;
>>> +					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
>>> +					opp-peak-kBps = <16500000>;
>>
>> No speedbins?
> 
> Coming soon! I am waiting for some confirmations on some SKU related
> data. This is the lowest Fmax among all SKUs which we can safely enable
> for now.

Sounds good, thanks

Konrad

