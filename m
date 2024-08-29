Return-Path: <linux-kernel+bounces-306583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C76509640CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD2CB21355
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CAB18DF9F;
	Thu, 29 Aug 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALkcPi6i"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CBB18CC1E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925702; cv=none; b=mCGp4dOatHVmNdgkNKbKuU1myyBjvvBNz7QDN+bNwVpYyWc7MTvklOlsrkDaN2ObV45MJFKwKALwZUUtaZhDBdI2E6qkiSa59/z/GvjANhb0jufPmASQ0wD6v61Cx6gWPazbN3o0Wi0c86f6ZL9syedbmr4+64w4snBZSmK3cdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925702; c=relaxed/simple;
	bh=QkJs4CrekP9zveKcRB8E5vMSHA3LUXNSKxF0D4rR54c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m8M9d+llb+eFEnCG1Y1bkJ5sLRJ++vtECJEhJPmLhnNS7adWscCP7esSw3ArvKqTp4zlN5od2JdacACv4ivkUeEdIaJBjzu7qnGuu0dtKM3cGyypz2yqoKaAlaJpXrqJKCL13MvlgDX27sw4PHrRtJv+W+qpEMMiBB6yUKvoxDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ALkcPi6i; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a83562f9be9so38023966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724925698; x=1725530498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fs/w7RGOKoomepefPnSh95RXx0WMdJK0RxeYg2QBR8I=;
        b=ALkcPi6iS284ReEG/KdFqgsz8bufWmYqO/IMdvW1sdD4DDjtAQUSGKpsDBpvbpCJCv
         LRhRQwuDQZVMVL2AktOeg5Vda11oZY8pDsZMoCxcgCzL3wf10gee3P2iD8tXf5/Pl/T3
         Q4qn4V4+7oCBrOX1JnP1ingQKA4RrSrxuFQZ6staeDNAT+uJLF8QT5CTW36GpwhAJyeM
         ns1BevueBbpolsmfUa+xYDMLPI7Cl4bmGoZAb2fAGROK7xGWF49N/kGMi2lxFO2N7TBu
         rwt4jOGnrYz+0mh80gXWwVddLMyQmfU+XNlt5+Hzdo+nq5wxI0LZESUlZYLgDlOQyKvQ
         wwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724925698; x=1725530498;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fs/w7RGOKoomepefPnSh95RXx0WMdJK0RxeYg2QBR8I=;
        b=mf7Sgp485oMdI7W7V9881P5N9aOZXqLOu0ga21Tm8iV2oUxdW3hQiOgTapj77h73dd
         3Ywyoh5bkND8NsWiuRrSOPW6M5Cbzsps7MnU6lQUsctl8aEpVkmaaKIbrS1ohVTQrrNj
         bqocy7GgoSTd7f87rYOLrWGbBt5PDnLORZC3kiaYZDUoMyr/VhdP5WfzUpjrhYSEM3e/
         KL89qbsb7LBz+ZLTEndgwvE/f8VpPG7/m1NJ2Lr0xq25U9dln15/v9zv99Hzq/W4WKQt
         WSYy2lO6gYj9Ey6ObXO5Oh5PZHeDPiKPVZ8RGVErIXlg3JyKw1+FwL6iidhbbdf4Oabh
         UapA==
X-Forwarded-Encrypted: i=1; AJvYcCV4ZSm424UU3zx0Tyl6vrpF/gMCm9HTleUG3fO/PyWg7mYnAe0kx0/1gMAwfYmRAK3rJoA5q4gxmsLER6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfmXE+aqya6CJh82B9ogkN8NOtTRUOjRIdvzmKUTbnzKi3psqb
	pOxBUpUsJRV4F+qC/dXlWAyPeKPblPpytl0TQ4NBfsF8R/OJUMcyzfUvcI6QVAQ=
X-Google-Smtp-Source: AGHT+IFiJjRLJqEBHrBxAeKhFuSOYhxbp+eWk1q/oUNun9oHTLDnVUAlE6tWzNqyPEolTRb6dSK1Pw==
X-Received: by 2002:a17:907:1c28:b0:a86:9058:c01b with SMTP id a640c23a62f3a-a897fad6fdemr162051766b.65.1724925698450;
        Thu, 29 Aug 2024 03:01:38 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb32asm57927366b.23.2024.08.29.03.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 03:01:38 -0700 (PDT)
Message-ID: <b2cfda34-f8e2-4db2-b4d4-9c707bfc8417@linaro.org>
Date: Thu, 29 Aug 2024 11:01:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] dt-bindindgs: i2c: qcom,i2c-geni: Document shared
 flag
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
 konrad.dybcio@linaro.org, andersson@kernel.org, andi.shyti@kernel.org,
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: quic_vdadhani@quicinc.com
References: <20240829092418.2863659-1-quic_msavaliy@quicinc.com>
 <20240829092418.2863659-2-quic_msavaliy@quicinc.com>
 <9af7518c-45e5-44a2-bbb7-19ce7ed899c3@linaro.org>
Content-Language: en-US
In-Reply-To: <9af7518c-45e5-44a2-bbb7-19ce7ed899c3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/08/2024 10:58, Bryan O'Donoghue wrote:
> On 29/08/2024 10:24, Mukesh Kumar Savaliya wrote:
>> Adds qcom,shared-se flag usage. Use this when particular I2C serial
>> controller needs to be shared between two subsystems.
>>
>> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml 
>> b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
>> index 9f66a3bb1f80..ae423127f736 100644
>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
>> @@ -60,6 +60,10 @@ properties:
>>     power-domains:
>>       maxItems: 1
>> +  qcom,shared-se:
>> +    description: True if I2C needs to be shared between two or more 
>> subsystems.
>> +    type: boolean
>> +
>>     reg:
>>       maxItems: 1
> 
> SE = shared execution ?
> 
> ---
> bod
> 

Serial Engines

This is a good example of defining TLAs

commit eddac5af06546d2e7a0730e3dc02dde3dc91098a
Author: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Date:   Fri Mar 30 11:08:17 2018 -0600

     soc: qcom: Add GENI based QUP Wrapper driver

     This driver manages the Generic Interface (GENI) firmware based
     Qualcomm Universal Peripheral (QUP) Wrapper. GENI based QUP is the
     next generation programmable module composed of multiple Serial
     Engines (SE)

...

