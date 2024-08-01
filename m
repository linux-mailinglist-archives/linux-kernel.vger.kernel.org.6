Return-Path: <linux-kernel+bounces-270830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 722F89445E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D51B2310B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BA8158872;
	Thu,  1 Aug 2024 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjCGDazB"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61D141987
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498695; cv=none; b=c8MhFdR/vC+ZnzYwoBh4geAfwn08MJXc0fBXaZtVVc6dkS5pgtBM2SWc2TnGZFu0OmUj5pLNOgL06THuPzZ/yTZG+Wrqgt4b6r/JfQMLKzz5livA7b+Kvx3sWa/3eft60UDlJO3BC3OGD3Cf5zCglxXgndgtAfhFlzq6Qt6LcDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498695; c=relaxed/simple;
	bh=PhDLQgNQUqBWO+mydssFM/K/F7iU/3Kxh3P0a2s0qpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWBH5fc2x/wilcB/Wss4n+YaYh24FS60+79ge/tNU/b9m6b+lNCvPD/V1wNqTNtPrPLH8+q13ax30CZ2T7bEWSIBfPvGm2LS6j/N+ppALogG6ma+Sfb9HjLsfjQBdqvHy0ubxrWsUexnOunUb3s7PBLUFnY0OVQA4FeHnmZzzZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fjCGDazB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42812945633so44241795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722498690; x=1723103490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FZEfKgAUYgQD4guqTZYcdll8kLH83l6dhKBOEKXkEV0=;
        b=fjCGDazBE9qbKWzT7s0THak2vMBUgGN4adyQOhHv8QuMSoqVw6h3Acri6RO1c/kU5z
         EbN53rw+1c6VZAamOU0qrXf7ou0KuVkLPi7zCxQWEJMdo2+jJRn1WxnX1eKKQ7PmU2P5
         ZjJpIU8iCqqcUpfvEBXix5Mn0a8Ijy9uPMDxfnSGTODBf8vAMjZSfWupMLm1kEjwOZ9X
         oP5+CUHgBQ+fWBPnOlLCiK8udi5FSH3O/3ai4wTVZ4IZ9vEhVN2HVGdN87La3lwDzY7U
         bk57oqq7ZPeBkkUQ2QHsFz4RA4BnT9bONzLQkkZRQ4PwwRt/q/3Jvm7wzcxJA4JDu/I9
         T3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722498690; x=1723103490;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZEfKgAUYgQD4guqTZYcdll8kLH83l6dhKBOEKXkEV0=;
        b=LbH4me8lm1dpoGWN9PYa3WFLSLXwUpCRacV3dOalSVmsuz3qVSPZ7XzCfZgzPzD01N
         bOKecT7fZ2NldUdDb05/WB9ydLtu6bXH0aeTG+yBBHgV+YfM+Z9LYBmRikicFoXAXMHO
         D0czyd9ceLj0lq10f2/cOpHUr8jEHlC3xZOWzcOSVB/11gTdcE4GUaUTFEy3BP9RW+Uo
         2GEJhIW6/nf4Iw51qoWEuFBT9UWFyuls5w2BXnRLxxjEiw/xl0Xf5L6aWpPL5Qcj7hAx
         X8kPB4EpR8+OOIjEQmo9mWYt6sIZWf/FHQqOW19k9l9nRPCC4hRQbco21tZBEQiH1O3q
         +3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzsRsKZqb62NUfRJEiEpS23RPFAvMcfUkdZqV0s4ODOGyGpa8kKUrC0THj/KkjOvxsVeRo1dxG3ewv6gaHihGwMgTqHbpnXQ341WP7
X-Gm-Message-State: AOJu0YxTx42eqxNkK/MBaeQ20CbmZo7u1PUZXk3zKzmJLH3percshXJ9
	MfnkFCz+qlohx3j4QKNmOWP90f1rG9gx0UDj6bl1wt99lE6Y3oY3R6HVt29k3cg=
X-Google-Smtp-Source: AGHT+IFVUiYgg7q9EZX8uWtt6E+3CIxmrat+d5VUvc7kZZlt8Ar9KLUB/uBZeH3PYHiZfb+ex/J2UQ==
X-Received: by 2002:a05:600c:4f96:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-428b4ad24f3mr11215855e9.26.1722498690129;
        Thu, 01 Aug 2024 00:51:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb63f21sm46870285e9.29.2024.08.01.00.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 00:51:29 -0700 (PDT)
Message-ID: <bc9dc9c6-fefb-4d13-9fa4-21768add59c3@linaro.org>
Date: Thu, 1 Aug 2024 09:51:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom-bwmon: Document
 SA8775p bwmon compatibles
To: Trilok Soni <quic_tsoni@quicinc.com>,
 Tengfei Fan <quic_tengfan@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240730-add_sa8775p_bwmon-v1-0-f4f878da29ae@quicinc.com>
 <20240730-add_sa8775p_bwmon-v1-1-f4f878da29ae@quicinc.com>
 <1e78eeb9-3280-45ea-9d21-92efd939efe7@linaro.org>
 <d8807827-5ad4-e442-a072-d564a55623fb@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d8807827-5ad4-e442-a072-d564a55623fb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/07/2024 21:30, Trilok Soni wrote:
> On 7/31/2024 2:23 AM, Krzysztof Kozlowski wrote:
>> On 30/07/2024 09:16, Tengfei Fan wrote:
>>> Document the compatibles used to describe the bwmons present on the
>>> SA8775p platform.
>>>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
>>>  1 file changed, 2 insertions(+)
>>
>> I admit I don't know what to do with all these sa8775p patches. I am
>> afraid now you say these are valid but in half a year this will change.
>> If I give Ack, I feel like I am agreeing to such approach, which I do not.
> 
> Are you referring to sa8775p moving to scmi later in the year? sa8755p will not move to scmi
> as per the latest discussions. We will have another SOC SKU to start adding
> the SCMI. 

Yeah, thanks for clarification.

Best regards,
Krzysztof


