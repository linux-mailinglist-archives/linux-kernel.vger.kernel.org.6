Return-Path: <linux-kernel+bounces-571232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629DFA6BAB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BAC3BD9E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA863225761;
	Fri, 21 Mar 2025 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PylM+OmA"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93142227E99
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560158; cv=none; b=PzjzZobRQfl+dtlnq2gBx1tuwEjop+dLMP8LHAlj6qLTYbF1nO2VKFdAd2ur/MWiS6kNcXyjt0t2pG4EWI8dot2XMBJld34qNTDqnwZfcbmRvMfeQr3D05bv8f6uZQ4IsqtVx4ja8yCiPC20dm1NIn82D/3Ue2z5UyrlS5sViqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560158; c=relaxed/simple;
	bh=rVnQZXzA6JyIyOTUd7XuexNwWQ+JpNN7mt/BrTRTsVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQDwJe6iCcz4xiat3CMKUwjTMglWYt0lEl/5DROUPs0vsk0qNkK1WqeR6j7V7Yj/tzamODUzmbwq0QdVtHb7bneJsG2uMK9mYLbAnxFPCMxNjO+P3Lf6Ld8ilbd3jGDAJ+uUd2Dt4TrVVPf8dho0qf2HPpkSXPASxpIAop7w2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PylM+OmA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913d45a148so1574818f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742560155; x=1743164955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3SbkmY/ZqJcTj/0FuWSzOs5OjdIbM9VrnkM1LTgh1k=;
        b=PylM+OmAE9PCm3Tcq1DmejBitqz3rSVDqWvS2+bvHjo98lkHGa+4hZnSzTWdX0qupE
         6rOSZRGk/g6r1+tz+RCcm950UcCVP9J66v32S+X79KEsYBqZhdb6urXm0vw/Mtz9lZFm
         G/CP3+fcOKvWI5k/5eltvrbg3rbXRL560ap9UhVskDfnQLo2kvUBPUau6HVaZafwWzWI
         vn0LFCcVkvlzbpwayU+OwG6oPeD4wzjw9fJFX1drprYK0Wc2qECIi17z0SMIpXbeNTpF
         c23lue4e5/c9MAdk+C0s3sVLsWPPiUT7y2hy+8v1OXbqMonMzJeU/dL48WzG0uedT2eG
         3J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560155; x=1743164955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3SbkmY/ZqJcTj/0FuWSzOs5OjdIbM9VrnkM1LTgh1k=;
        b=ZI5SKfV8k2tZjNEPENzVlKUoMFhjWu+IOXHbqKBeDIz/WYzOsaicsImHlFyNkD2uJx
         Q7aMLMu2X3JHkSynO5mA+xJYKUlI0YyEX+nPUn4sMkzB+UWki3l4fKXBbe2tAw0KYVae
         um2MO3cpqMhauWhymiMZVGnENaTiXFPIqe4Ht39pOEDk0hkFbJm4RSkh/pBlizJVmCu4
         FmSqRhPkWTRc9RMhdCME7Yq1H5ErLMB7WMt37v6bWPg1rLQpzNmET4Tgs2sKzWjTE7Ic
         SfRRE217l6zyyGLw1TbcX8FPOco4WU+8sp39MKMrTXeEgHiTIUNqDmj3q+baG4ky35F8
         CjCw==
X-Forwarded-Encrypted: i=1; AJvYcCUf9oVqW2c+AfVkDqJ1yUmdeheH22kQF6+WcQE7G4ilL/2XMxBx3aNY7Z0s5eZX6EvJ8NIMdtrVMU9hb2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMeMdd8V+44GMgKiSJLu5WuBfmnmyN6u6aA+tNhs4JpEQKHXE
	hYrYigsuQ3w4VXxVwHJUNa5p7qw7REzRohlM0Ll5O+Xk32ejudR6xvgDbi6+8Is=
X-Gm-Gg: ASbGncup18g6uqK3GweD+1Z1HsWONqP6/Jbz43eC35Aqq/FdWGvhAIkJQFTEIZXQnVh
	kiBMcnsZNm8MlWgAGuG6Ts7uHVdAJsisaZfd7vUF83NqHLlHOoWnmOpoIs3tcK7N93O2bV+1w/G
	LVXTtJDAvsRQtE6bhjJYLuqDiXbrsVVgqz/TbKhmiAhhi8y2/G/IqShRj7jsnZORO+xacZru04F
	PlmuZSIGTEsV61P1HUb84gr7/+1c9ohOo84NjIaNDu4JFsVMJfUMVFQ1tUQMbtYnxi9Yz+KPjNt
	5cAehN0gO6jkitTCemCrf455AZVVV9RNSoc5Wpm/r+A74XaOQd9cxeFK+jvorOo=
X-Google-Smtp-Source: AGHT+IFBZoh/8u7yI73Eo6y4FHWJpjFIM1ekg9sKkOS3yKX2k4UHIdny93pk+Zu+zSOxe3lYxYq5TA==
X-Received: by 2002:a5d:47c6:0:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-3997f937cd7mr3013030f8f.34.1742560154684;
        Fri, 21 Mar 2025 05:29:14 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9b25c9sm2225387f8f.42.2025.03.21.05.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 05:29:13 -0700 (PDT)
Message-ID: <c276c310-c6af-4ee6-8635-73430aeb4bbf@linaro.org>
Date: Fri, 21 Mar 2025 12:29:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] ASoC: dt-bindings: wcd93xx: add bindings for audio
 mux controlling hp
To: Krzysztof Kozlowski <krzk@kernel.org>, peda@axentia.se,
 broonie@kernel.org, andersson@kernel.org, krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com, luca.ceresoli@bootlin.com,
 zhoubinbin@loongson.cn, paulha@opensource.cirrus.com, lgirdwood@gmail.com,
 robh@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 perex@perex.cz, tiwai@suse.com, dmitry.baryshkov@oss.qualcomm.com,
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 johan+linaro@kernel.org
References: <20250320115633.4248-1-srinivas.kandagatla@linaro.org>
 <20250320115633.4248-4-srinivas.kandagatla@linaro.org>
 <e2dc0587-28c1-4294-9bce-e18952ba645d@kernel.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <e2dc0587-28c1-4294-9bce-e18952ba645d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/03/2025 09:29, Krzysztof Kozlowski wrote:
> On 20/03/2025 12:56, srinivas.kandagatla@linaro.org wrote:
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
>> index 10531350c336..e7aa00a9c59a 100644
>> --- a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
>> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
>> @@ -23,8 +23,13 @@ properties:
>>         - qcom,wcd9380-codec
>>         - qcom,wcd9385-codec
>>   
>> +  mux-controls:
>> +    description: A reference to the audio mux switch for
>> +      switching CTIA/OMTP Headset types
>> +
>>     us-euro-gpios:
>> -    description: GPIO spec for swapping gnd and mic segments
>> +    description: GPIO spec for swapping gnd and mic segments.
>> +      This property is considered obsolete, recommended to use mux-controls.
>>       maxItems: 1
> 
> 
> Assuming intention is to really obsolete/deprecate, then please add:
> 
>    deprecated: true

Thanks, I was looking for this flag..

v3 will fix this.

--srini
> 
> 
> 
> 
> Best regards,
> Krzysztof

