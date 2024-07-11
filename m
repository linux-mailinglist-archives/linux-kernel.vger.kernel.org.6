Return-Path: <linux-kernel+bounces-248926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AA792E3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7DA1C21AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2A3157495;
	Thu, 11 Jul 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0QR077U"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D915747C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692056; cv=none; b=hYMpXCFqnhzuojr6t4GnX3++PeMLlz94ZT2xTUYwi9Qp5y2WVjiM62CQMsHQqeJypdbqCAawrHMt5cawrqxsNUaN8qKeI/utMSM/H4dDXMjmXGPeAHI3QiwBcvRKGU0yx6QEtChzzR0zdWm1CpYWQHkh7wwNm6WXXNmkpTjadoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692056; c=relaxed/simple;
	bh=Gk8bIow0J+Zb+3HXWKHfOllEFT0LGnZiQIPudI7cyvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjprMXVCZoft4c2TCeBul1JsulXBmptBGKd7Ydko8FWdW/y+M7VT+d5yDz0VZzQ2Vs4XZS5F1UAoFdTItNg0A4FAOZEgD3VH2gTb+k82CBlREZTfCdAL5SpEDSKhaTUVDrMVhn8K48zYz59IiIV/k//bji3IEusqnYc3/SAmSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W0QR077U; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77baa87743so79940166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720692053; x=1721296853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o2fLrpnY2OFXTI/2z6+IbgCmNHL/Iy6X0ASNnkah1Sc=;
        b=W0QR077UTJ5dprCeoLN8hbzif8Qjnu8ir/0d9oihFGb91TIBz7CJcc7aGDgzhsqFGA
         lD9WtPTEERoA09Badr+OXSM8x8/+uXHkVB1w4OdPzTS8+Vgo1RBWdegdz8Us3iakxV8A
         shocRxE8YAdNl+p/L/AJIWFqJyb3pZrRfvSwUrRWdhfQMZL7JEQlNbiYvTdcYOQ92jdR
         IugkyrvpA6RZYDnKtliEjCRXC5szJhGjQ84Be8K2QBeT0TMeTupVk8q3abtOr6pVY/yo
         v4B4ZmDVHmkYI+A34jY4DZAGM/bsw5rhXWOT/sDZr2CX0HfgBn+pVTi/JBIaxTVUvAn9
         SggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720692053; x=1721296853;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2fLrpnY2OFXTI/2z6+IbgCmNHL/Iy6X0ASNnkah1Sc=;
        b=kUMGp7oX6wlj0R3WI2Of5EgXbX8SGJbYSv3KRvXv4fP6KlLJYRNShQ3rBvABxu90ZA
         m6zqfAmOpWMHTRPOlJbAYrUj0fIX2F/nLcDSpnsS1/4IyDpnbNBKsRLEyFMNQBhfCQ+V
         tX083I5ZzpFPcEZV/kFbmAlhOSGLcO1R256yB3KHM7uugci9cZo7yDjUjVTVNJ3EILa6
         sNQlDg1yu+sXjTZOooBB7lcSuRAiSBG9zB69p5zjXwM4reMXavXDZPA2gFnfj0gbRCbO
         ++EewDvoqTbpt6+CrdoYnkHlFT2jlp5WZfBDGRHHqCxy4fuaXk/sRRaX3LKBQAZw5aef
         5GPg==
X-Forwarded-Encrypted: i=1; AJvYcCXQmShYYj4LBuDEkOW/MG/u2GZQXKGCEOwJ6Wf7H/lRFmvAZOF3yUbvsOozQXNc3pAKg/CulWmRyx1Cy139pUAtzHmvAqprHVrs1Ap2
X-Gm-Message-State: AOJu0YwGj3hjC8MpvPRa7zi6xGDDzPJdHCExMhJo2yVqwOyyhr7HyzVQ
	POl/SytvYOVxSTIcisSJFXFsU+30M9tod2VS2EQZnyqCLkcGt5Z/OCSOQf/HpOU=
X-Google-Smtp-Source: AGHT+IF0SzZ5gBhyjX6kOL6plbwNTEzSm62HnomYfO//u0WXELiPcgYVQCh7J1lzkGO2ax0Mf9HRyA==
X-Received: by 2002:a17:907:d93:b0:a75:20f7:2c71 with SMTP id a640c23a62f3a-a780b6ff667mr823368666b.38.1720692053227;
        Thu, 11 Jul 2024 03:00:53 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e065dsm237893166b.84.2024.07.11.03.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 03:00:52 -0700 (PDT)
Message-ID: <bf41aa8b-6a49-4610-8a8e-c2dab8ef4334@linaro.org>
Date: Thu, 11 Jul 2024 12:00:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: enable GICv3 ITS for PCIe
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240711090250.20827-1-johan+linaro@kernel.org>
 <f7e74a6f-0548-4caa-a8fc-8180c619c9aa@linaro.org>
 <Zo-ssBBDbHRLtAwG@hovoldconsulting.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <Zo-ssBBDbHRLtAwG@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.07.2024 11:58 AM, Johan Hovold wrote:
> On Thu, Jul 11, 2024 at 11:54:15AM +0200, Konrad Dybcio wrote:
>> On 11.07.2024 11:02 AM, Johan Hovold wrote:
>>> The DWC PCIe controller can be used with its internal MSI controller or
>>> with an external one such as the GICv3 Interrupt Translation Service
>>> (ITS).
>>>
>>> Add the msi-map properties needed to use the GIC ITS. This will also
>>> make Linux switch to the ITS implementation, which allows for assigning
>>> affinity to individual MSIs.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>
>> X1E CRD throws tons of correctable errors with this on PCIe6a:
>>
>> [    9.358915] pcieport 0007:00:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
>> [    9.358916] pcieport 0007:00:00.0:   device [17cb:0111] error status/mask=00000001/0000e000
>> [    9.358917] pcieport 0007:00:00.0:    [ 0] RxErr                 
>> [    9.358921] pcieport 0007:00:00.0: AER: Multiple Correctable error message received from 0007:00:00.0
>> [    9.358952] pcieport 0007:00:00.0: AER: found no error details for 0007:00:00.0
>> [    9.358953] pcieport 0007:00:00.0: AER: Multiple Correctable error message received from 0007:00:00.0
>> [    9.359003] pcieport 0007:00:00.0: AER: found no error details for 0007:00:00.0
>> [    9.359004] pcieport 0007:00:00.0: AER: Multiple Correctable error message received from 0007:01:00.0
>> [    9.359008] pcieport 0007:00:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Transmitter ID)
>> [    9.359009] pcieport 0007:00:00.0:   device [17cb:0111] error status/mask=00001001/0000e000
>> [    9.359010] pcieport 0007:00:00.0:    [ 0] RxErr                 
>> [    9.359011] pcieport 0007:00:00.0:    [12] Timeout  
> 
> What branch are you using? Abel reported seeing this with his branch
> which has a few work-in-progress patches that try to enable 4-lane PCIe.
> 
> There are no errors with my wip branch based on rc7, and I have the same
> drive as Abel.

linux-next/master

> 
> Also note that the errors happen also without this patch applied, they
> are just being reported now.

Ouch.. wonder how much that drives the perf down

Konrad

