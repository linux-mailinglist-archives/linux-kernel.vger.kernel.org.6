Return-Path: <linux-kernel+bounces-332136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB58197B5D8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5BA1C23B35
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315719148F;
	Tue, 17 Sep 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qptWSB0R"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5A15B0F2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612830; cv=none; b=hbIlYpKoEx+sW7tordQYhKSXYh5gW38NkOnx2fnTKxQUCenUHgtGvE00NcjFXJSaVgikmMGiTjJ586JXxNbaXFSpWWLmcphncNEbWp8U2idHlzepM85eZrWQkweirf7WXDT9yCBOMejv5tAATLFeg3VBCVcLCDLuivi0PU1B+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612830; c=relaxed/simple;
	bh=swxROHGBOQwTMcDCgjqL8DLK48S6IR6xf/yufIyqLkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNJ8IPDSEt+Sf2oaxw76wbvCjeTPQAFQ/wvvebpLtzBUW56r7lQKdZM/AWTXTns1G0wpXNbCVe9qnHN+BCwBi7buRtOo22Ah31U85mZ0J5BHN9nBJyTe7kAAptq0J5yTnt+MX2syupxnMDmW2J/pvNEDoEncyAA+qr+J2Po49sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qptWSB0R; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso1023501266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726612827; x=1727217627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CjZpdfv4P2hHCjsU7XxJ4hyGhQ9pjUlUIY0HPHLeOyM=;
        b=qptWSB0RZg4DA9a3/WkJXoNv6PLloq34qNiwNhTlcyOD5vRjGiMW8qoPMDeDjrvYal
         ZU9Qx5UfCKcQm8bR8dB+b+992fQ9NDwhyA9/5fAgjN7IXVUr2sLcq8p57SvbacUtvkQF
         G6axkrTztrlNTrmLDdSElMFhu5kF39UaKDwKp/VBqjk9J0kO6UMCdRXMXvF8rc2TcFAG
         v70jW0c3BJYLQztidLlP4l1h0du+NqN35xQOoOlyXokGENIXsYxBwDU+dU6/ThK6GNob
         W/irvfUKYnEMqttEo2MBeM6QSDYMHrVTGzQv3E003FZHBI8umsQyK0HEN8zMKS2HliTD
         ZJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726612827; x=1727217627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjZpdfv4P2hHCjsU7XxJ4hyGhQ9pjUlUIY0HPHLeOyM=;
        b=rxOgaQx5S9bm+VTCVcbqJ2gePWkDRAbb61iZOKaKOaqKF3Z94rLUMjNpDRoD3G3dM4
         25WXXFFL+HfAOZ/9HtPsHwaAaZ6mA+FfEq+XFlNB0NaGGjPVo2/NXFU6k8Co6hQeU/M1
         ZPdbGVBxJ6q1H8MnuMZflNtqPGBjGqHw3W8oImTexXLnVxhsy7lSKvXe7PLO3URzgTqk
         hzFKGb4uITCPhGFP1MSIjXMX00a1uEmYpwm31PBpWL29avwCzCCGfSlEMbEojT7D37ax
         n0WKZ2O8tiWfhHamEVaTwV+XmB91zuFi/qOn8/NINjAapJw+nCkibKmuybCqsOto/O7t
         kQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCURR5GJ1c3ThH1pbfnY64OUut1SyEj+9glajtLpx3ByIL3Py2kF8x9dB2DvuiaUaTs2V+rBwbi8uzdddy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOk2j5imqzP/ncoRv35fGP5id27zV5KTiaV2GC6ZjoN8l5aSoe
	YqdoCvnQp1rJgC6J3jMCvj3QqPMgh/v6NJXzsKiGm1sce+OdAWq5mTtjpVQGuyw=
X-Google-Smtp-Source: AGHT+IEuuG5BzCGQ7pmXlfxdxtwrWJds6DmXr7d1iwy2Tum8R8ba0KsEaDFGlJgE3NUk3rVYWit7wQ==
X-Received: by 2002:a17:907:60d4:b0:a8a:794b:9891 with SMTP id a640c23a62f3a-a9029620387mr2219746866b.51.1726612827072;
        Tue, 17 Sep 2024 15:40:27 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3eb6sm502564666b.105.2024.09.17.15.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 15:40:26 -0700 (PDT)
Message-ID: <4e94106d-5ca9-485b-8c51-c18dcd4e64b0@linaro.org>
Date: Tue, 17 Sep 2024 23:40:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] dt-bindings: media: camss: Add qcom,sm8550-camss
 binding
To: Vladimir Zapolskiy <vz@mleia.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Yongsheng Li <quic_yon@quicinc.com>
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-8-quic_depengs@quicinc.com>
 <b1b4a866-fa64-4844-a49b-dfdcfca536df@linaro.org>
 <82dd61ab-83c0-4f9c-a2ee-e00473f4ff23@linaro.org>
 <da60cf71-13a4-465d-a0ee-ca2ad3775262@linaro.org>
 <97e4f888-1ed7-4d82-b972-3e0b95610198@linaro.org>
 <6eadc285-f413-4bf0-8795-59ff19c734da@linaro.org>
 <6562a958-47e9-4a49-b235-fe8deba3c051@linaro.org>
 <cab95caa-9ffb-446a-858b-342939e80811@mleia.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <cab95caa-9ffb-446a-858b-342939e80811@mleia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/09/2024 06:06, Vladimir Zapolskiy wrote:
> On 9/13/24 01:41, Bryan O'Donoghue wrote:
>> On 12/09/2024 21:57, Vladimir Zapolskiy wrote:
>>>> 3. Required not optional in the yaml
>>>>
>>>>       => You can't use the PHY without its regulators
>>>
>>> No, the supplies shall be optional, since it's absolutely possible to 
>>> have
>>> such a board, where supplies are merely not connected to the SoC.
>>
>> For any _used_ PHY both supplies are certainly required.
>>
>> That's what the yaml/dts check for this should achieve.
> 
> I believe it is technically possible by writing an enormously complex
> scheme, when all possible "port" cases and combinations are listed.
> 
> Do you see any simpler way? Do you insist that it is utterly needed?

I asked Krzysztof about this offline.

He said something like

Quote:
This is possible, but I think not between child nodes.
https://elixir.bootlin.com/linux/v6.11-rc7/source/Documentation/devicetree/bindings/example-schema.yaml#L194

You could require something in children, but not in parent node. For
children something around:
https://elixir.bootlin.com/linux/v6.4-rc7/source/Documentation/devicetree/bindings/net/qcom,ipa.yaml#L174

allOf:
   - if:
       required:
         - something-in-parent
     then:
       properties:
         child-node:
           required:
             - something-in-child

I will see if I can turn that into a workable proposal/patch.

---
bod

