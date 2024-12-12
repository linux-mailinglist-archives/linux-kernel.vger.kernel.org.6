Return-Path: <linux-kernel+bounces-442694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1CA9EE06B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79742167A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330A20B816;
	Thu, 12 Dec 2024 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yf51mtGd"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FC014387B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989354; cv=none; b=P3Y2WocvwzMWr/tQV/5L0+O56mnTDbIs/mHfXjPfvoBYq9AZoiqGFYJQIxQc1/Hobu9ChhRE9PSLIV2fdlM+xGW77+GFc+T3h/eEw9TNh1ohLadDg7iiDAeR+PCgqQ67ql5RUxknMtKdA7DQCsR6qUrSCo7pRptq7mja618Q2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989354; c=relaxed/simple;
	bh=lCCQie4pQ1F9vSOZNO0l3UQB38u97D8jap8/KM8tuB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1XLUclFJMtCVpDwMFM3C/tKVriew0OzT2jdkCePnDGtRD/QhQoj5aAOSsT7t0Mkbl8umlR08pBay/oYEi0nnIuVVuOVerSBSKZ/Yu/+gIoNVNRQvnzkvycN3otS8UQvWMfs3kXm11eUdbXMmgSXYEFvlpcR1xXlm6+adUnfhB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yf51mtGd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5402a4547dbso57394e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733989350; x=1734594150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fb6HVbCShRnjLJanLtEWXGGQsHuXVT1l5Vx7FnmvFko=;
        b=yf51mtGdpgJqIoW1gLN0gt15FPracGC9CQ/kvx8r46KGzLBvfFtAOmaVNhiru1CGO9
         XrsAC3WNQ5Ze7Z2VXfCCn7rA+lyytucPpFgXf0L6yMFCX5pu9gN62EKKiO+AcE5xI5Qc
         iwCOqXUYKLH5MHraP3nLVZCNW+1Ln2UvlU4GPHtw8eUts8kLjI2jL8T3HXMwYzlMjfkd
         WfnHRWVCvBPlA1r6Hepe8dcYMlcuEzSKf7/HJBUt9uftXjp9RMNy9jQx038Hdz8qXqup
         IWTP0AdfP3GHiQsc1x0DJMefZDqXq518QGZyyUEnfLTPEZKFnohGWuM90O1VSRFIN5f7
         fYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733989350; x=1734594150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fb6HVbCShRnjLJanLtEWXGGQsHuXVT1l5Vx7FnmvFko=;
        b=BaDceevImqu7jgh80kOavBKa0C4Zs0J8vWuudIR83TsDJ9+Obsiwba79QIMriiM8sm
         AuwBNdaiV3CTEBLju+Tylohru4I2GfHBFH2TzrceDSNYITnBW2i/1ZkPzResJ8VWXeio
         Ralx5iO+FOBAmXVeoIRtfe1+OURTFt7fdgkaR4GvkvZp78rrZ76SdoIkt+DWColwiLON
         sSr+93LnpBsUcv4XoaRPvflvzQ3d5MWKpYkjBApg3GbXYhWo2DKCLsL0gCEJOqvOSYK/
         g3hCbACYEh0ZRHsdBz8voEYbzglTA2e+XnruPGsKlyfAQ1rhutlennHMERMKiUsIRQ3W
         bplA==
X-Forwarded-Encrypted: i=1; AJvYcCVbv/NG/R3SXQAoqVo0fXqkKOGAIX8ZcsrzBL/UK8/BvrSCsQ3fE1jsK5HzElQxDjbNPdD1TbDfqDxwgPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVlwknmS7EgBG9EvUyrRTOAF1uG3RhSYJqpqef90InzeApcHsw
	yZjjjj+e4cVKAyRYrZLorQ7iGdgXyZTDzhSbVQgYiSmeM28nQTJEhsy7brU6l+s=
X-Gm-Gg: ASbGncuT6n43tKcLn1bNjTgT6gzKK6EbFZeJzFP9RyWQFBiYHHTn18O3P3zJlzf1ypq
	DctXm6+KrE2bCgLrN+jTokByxVq48aaeuHxX5kmCGI6bHAqa+ggI3Jl09m5iyR7FvPMHVoJcTtf
	JQpOw9YUXZ8mxyLXt8+XaO/BmXvEY0UJxfXN82+HCycCGgSCy39gnNTgPfffi/TY8D0NLOsWc+J
	wu1RbP9TuAKO0e57C54oVCoKGTTZ66hNeCYH2AzWchWCcq/Bz8+qgkP/DfEiH6t/HUuPR1DmYDl
	kjyfa01jZ0zakvILZtFxU7gj2Bqw3mqNARc=
X-Google-Smtp-Source: AGHT+IHHF3eBrkcbLgZjV07jB++O6f1X9HXUZITRIyKBGz5tBzelSPFXBegqOWH9Yj6quetQS7N+aA==
X-Received: by 2002:a05:6512:b01:b0:540:1b2d:8edf with SMTP id 2adb3069b0e04-54032c30272mr48070e87.1.1733989350220;
        Wed, 11 Dec 2024 23:42:30 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5402042ad64sm1142957e87.178.2024.12.11.23.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 23:42:28 -0800 (PST)
Message-ID: <f5e2c304-c2b2-409b-9300-9b236c2e3354@linaro.org>
Date: Thu, 12 Dec 2024 09:42:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] media: qcom: camss: Add callback API for RUP update
 and buf done
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
 <20241211140738.3835588-10-quic_depengs@quicinc.com>
 <1ac23fa1-fc35-45fb-9338-d5f304c869ba@linaro.org>
 <dcfaf9ef-87bf-4ec5-bf86-5c432380ae9a@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <dcfaf9ef-87bf-4ec5-bf86-5c432380ae9a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 03:32, Bryan O'Donoghue wrote:
> On 12/12/2024 01:09, Vladimir Zapolskiy wrote:
>>>
>>> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>
>> It's unexpected to see two your Signed-off-by: tags, either one is invalid
>> or the authorship of the change shall be changed appropriately.
> 
> TBH I thought nothing of this at all.
> 
> @Depeng for the record you can add Co-developed-by with my SOB.
> 

Thank you, then this will become aligned with Documentation/process/5.Posting.rst

--
Best wishes,
Vladimir

