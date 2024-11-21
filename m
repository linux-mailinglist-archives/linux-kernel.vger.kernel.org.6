Return-Path: <linux-kernel+bounces-416796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C04B9D4A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16AEFB2152F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BCD5FEED;
	Thu, 21 Nov 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4LOCfhh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEDA1BBBDC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183299; cv=none; b=cScnC66mPaRc38uqdFlkNEPLXLqlLWIbX8KaaPkFkAWr8jZTTOs1KaD50D27d+oqtbr25NEE5NJ1gG5ndHkE39T4y+0O/U1mPv060Mwyy9zSR2IqUvIuCAPncJAftv6HSfblDvaNaXsfH0nrZAUTQK3Cbx9zn+zdmq3g6z7dfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183299; c=relaxed/simple;
	bh=JjNvXC0ZmNL9tTmmEX68lHKJt4TdXge4SCVOn8mxtSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9c76FVmU1kbYoApRpKCzXUTmjLUZwElO1Z/j2UH3vH/Q5j5lwOqkopZ2NLyJdKE/OPL7hoZUV6viTlPRHRc165t9NfE1UNldS+saDVPF0+1K7YP/rl4TfxWRaOyLwrLvGFCJyygar4jglMvd5F1/TP++8Xmhz679TiZ8a+AxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F4LOCfhh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43159555f29so266795e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732183296; x=1732788096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rmhHnsY+RuLEc30H9+/JH1oprc05PF6GVYC48mw3MuY=;
        b=F4LOCfhhw4/uKrj2Mmt3GzkePi/yH8ZpUmj7sqJRPGz0vIkTldaZdQtOnAF1YbDs0r
         Jx1tDrlZtNAq9QQsslqIWA5P+c/JcCBdcvLyQ93Nf1lhIMVPDlDOryhUF00yNmXkTddd
         3624X+vMExHiUglGsYwZgtOHrx7NXi0RGJZesdbWLWvFJnB79Qn6ALIw8TnsKlQMmLQk
         JzBbM8oZhYJpx8nOWMq59Gvoey1z3TW4Ckufc+TWJj9NJM1OJGHkxM1+heMbXcM9hgtK
         gQhdb9kKFUEzKiBi48OAr9u/KkaJTD9K/62le5+Ae5MYEl89d0sefyHMm2zCmp0/8ysE
         1F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732183296; x=1732788096;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmhHnsY+RuLEc30H9+/JH1oprc05PF6GVYC48mw3MuY=;
        b=Zs8oTsr2Ve7lcNyIwAuxK0U5OfNh+Hxhd6Do0H8QeCX60RJf40UUX2NBaUrqWI/Ez8
         Af2EbguK94E99v6d8YXEGDuTXdxQ52+mD4qesvDmYka7x4IyWbamKqpURz0ywPKB9xZz
         KcxFg39wLRN2m+bElXw2xKDMc2NUiwICaLVI0+Nu7k3HTfLt983PEbheG78lxoMjTHIU
         PjOhM/60oqnryv+NRxXQVYUFWvj8DbBMYOXKYCJF4ArtW/GnWdGHzKxvVJYu+xgWz63L
         NV5fTHtFH2jbhSWcXK2cBfh3pCU7CB7v9Tpb/SLn/E6dZuIAKLo3rGwO5yq4JuLvZZs2
         i4qA==
X-Forwarded-Encrypted: i=1; AJvYcCU9TiBjr0QECEdbzyFAjR1Wq0+KIvrlpRNZD6HCv8F/yesmvQCKQSiWqIQO1uIohv0IeUD8iIm06Ycbwuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzf/7Qfq29Wzwy4Pa8FniQ5FRKy+a9jmeKnZITUVH06W3ezb56
	f+L9xAMIqvII2g+lch/TaMCyQjEdpdCAp4xx30mE0DYoq0bxXpiO4FICyGxokmo=
X-Gm-Gg: ASbGncvRfYrpu5UZTFgak4XSPLpkiafhZWYPJm6CYEQfLsHuhXjDT1Qyf/z7HftZ4Dd
	ckJOy+ti9cjWpd0HC281Qg4v+hS4yI0cT7uzsP8M1dVwgWpfl6vC76LSh40CH+Eb6gHrW30G2W+
	cA/4E5lbnKxKmYl4+X9OlpLwWv40bwhCxgiCSUVoSBxr32q9yVYS6jUdFwFKwuqWJr4H/f3RW63
	EoEs1aMSRx9FQY5Y6uKWc3Ifhl4ON3k8NgqcqJdVlXuZm7vra9PzJSB/L5iFCfgPGSLTg==
X-Google-Smtp-Source: AGHT+IGid3k2FbUqpmxPUw0L/CPBfwbLK7sR1jKTvwOdIaiv7UN/Cz5YznPz0xaogVOdoCqoXeZsjg==
X-Received: by 2002:a05:600c:444f:b0:430:4db0:3ffd with SMTP id 5b1f17b1804b1-4334f013d8cmr21221655e9.4.1732183294620;
        Thu, 21 Nov 2024 02:01:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45f9d99sm51608945e9.13.2024.11.21.02.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 02:01:34 -0800 (PST)
Message-ID: <26392a7f-82c6-4b7b-829e-76f3d78115d1@linaro.org>
Date: Thu, 21 Nov 2024 11:01:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: ufs: qcom: Add UFS Host Controller
 for QCS615
To: Xin Liu <quic_liuxin@quicinc.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>,
 Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 quic_jiegan@quicinc.com, quic_aiquny@quicinc.com, quic_tingweiz@quicinc.com,
 quic_sayalil@quicinc.com
References: <20241119022050.2995511-1-quic_liuxin@quicinc.com>
 <20241119022050.2995511-2-quic_liuxin@quicinc.com>
 <d9c3dc82-24e5-465d-bd1c-7a7c97e17136@kernel.org>
 <eae9d141-9c88-4856-9287-2ba6ea6f4a06@kernel.org>
 <242451d6-2b77-417c-bd98-4455f739dc0d@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <242451d6-2b77-417c-bd98-4455f739dc0d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/11/2024 09:37, Xin Liu wrote:
> 
> 
> 在 2024/11/21 15:40, Krzysztof Kozlowski 写道:
>> On 20/11/2024 17:57, Krzysztof Kozlowski wrote:
>>> On 19/11/2024 03:20, Xin Liu wrote:
>>>> From: Sayali Lokhande <quic_sayalil@quicinc.com>
>>>>
>>>> Document the Universal Flash Storage(UFS) Host Controller on the Qualcomm
>>>> QCS615 Platform.
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
>>>> Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
>>>> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
>>> That's a bit odd SoB chain. First, these are just one-liners. Second,
>>> who authored the patches?
>> To be clear: SoB regarding authorship is correct, but regarding Acks and
>> Reviews is not. Savali did not receive these tags. If so, please point
>> to lore discussion with it.
>>
>> All this needs fixing.
> Thank you for your comments. These are the two reviews I received. One 
> is your reviewd-by, and the other is Manivannan's acked-by.I have also 
> cc Sayali on the email.
> 
> https://lore.kernel.org/linux-arm-msm/rv3ukz6rhgp3x32s74nbftmoqmdxjxmoii3zsd4wipmhudyq7q@ha4l2svl5lim/
> 
> https://lore.kernel.org/linux-arm-msm/20241112075619.2ilsccnnk4leqmdy@thinkpad/

I meant order of tags. Who received them? You, not Sayali. Then they
cannot be before Sayali SoB.


Best regards,
Krzysztof

