Return-Path: <linux-kernel+bounces-424631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1CB9DB738
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8AB280C92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172152CCC0;
	Thu, 28 Nov 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tS3TCf9G"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F219004B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732795923; cv=none; b=ge//AMKTgNo7YZ6Oaf+sGHZw1XhvSYrQhfoanQeWBN2fyl4iZQZfSF8/ctl6s7Tsy7jVhyOWT7FG1qe8bfkKHSFz62ph2iZ/w4Bp9lyIHmtW3V2YxWKWtx/xG8T2VgNYuzf7SqV+fJSh42hpPYVp5nWoBsADjfLjjdbolh3u0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732795923; c=relaxed/simple;
	bh=0MeGc/7s/CWBQN05R+oTUtFBb/goOcovHE356j/Oszg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVqwLgPmKnPr0sasoxN6USyGwkaxP7RR5BkdP5drhZh9qcdT4+LikHUecG2RSr1zwh2fYK3tI+qL7tRp2SfYCVwKeOgnn7MN5Q7SL/FVnYagDL8cG06SsghxZsugSrNIBkgZatAURoeyIBYZEW0iaMh5Wf/NpW46k6mwHZ2c+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tS3TCf9G; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa535eed875so105363966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732795920; x=1733400720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlagLEJFtywwVUMe1dgXgwPpKrkSCr7O7E/5icGZLn4=;
        b=tS3TCf9GbJVM54xegz7nf2GORR0cBMfxRDySJhFON77Ma0hMri69nqnIR9Ib9LtmaM
         jMCE15QfBVHx2dugiNIfuFN8omGzdXEorwGSLZTj/u/XOZsVhm/+NDts3qOl5vam9XzP
         psjleL5Fx/kke0pdY1a2UnMLbCSr3J3d/NVkNpRGOrLWdU3uxqDFVeRiZhrMq9FYjKdS
         j67QErPvpwTUKPy2xjdTGlP4ho6AYsPXWd55rhYabuPGb4dSTuoQizgmnuqXZmCedjhW
         +vVrJj/7/qSnZoQKRwVbX4/akOQVcgTU3P/U0Z670theUBZAidOyfpR3ZE4SChdjxck6
         nofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732795920; x=1733400720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlagLEJFtywwVUMe1dgXgwPpKrkSCr7O7E/5icGZLn4=;
        b=wnPIfrrUS3Q99MeB7bT9e2wGbSnKFzWkCIjfCDfhiMf/tUv7EFBGSXnh5xr1QY3P/E
         ER0CFcE25qbfjCra6LnZDw0HSsdfkneLX99I7neBH2ayNQmgA8g1w10oExxxSlwEwLvO
         OHuQnTZHUJIMZG4/db+U+sr4vkHGQNat/reLD3/ogsKVua8rJz7dMS8RRCc1ivA35kdS
         mYvtFZzSmKOv7P70/JMQQsGq+oZ/AbHMeaoLXh9DAE6jS2YYu1XONayaUsc60pyPBBPh
         cuOWKYdLVuG0XSojxR5u2PXJthzfOm1XuOFTLw4SGnSlSSol/4m6AqradzaWEZXfgTSE
         EkFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNbVFjvwWG4Sqi+tl8jqkr9BzxP6AB1hs1Aa1j0+uQS8suTEPOtN4hyB5QQXQZ2uQI+ZdhR4KcasCk1p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG8ocPcRv4hL0dcfC2XDWTeyduBhLtVq/8iccLZI3d1Q65Wa9V
	NMUZAkVP9JoF1YH9ESeKqvgbm8MedBTlRUzYk10vPtGbOpiCFwYCab6X0Xdxc1w=
X-Gm-Gg: ASbGnct+rURVJX+M6x5SrruJHnCkdAF/btRkAHG2emNU13aEXO1PggcaydR8/y/syuk
	opbuVvLOfvfbsQGHi0vQHhk5TtJms6HGjYOyKyRP22zqoi9ACjIyKK8o5IoPYTs2kaFT7qOR2II
	TalVQqH2uBpPo8kkF1p0Wk4ELm7YxilGe1cW9+gtCovx/V3QVDvPBTJiDJwWMOJ8h0BjIrqmM9w
	wiK9Q1VyhN1l2Usd4PL23t0OFBwjeEoKhtLGukUfADRxImCVJPUg72UNK1TytE=
X-Google-Smtp-Source: AGHT+IHvAUIzZYTgmNUEdyRVWk60wm4MmFIPzbhwhInYSuwK9GJKfO8YoQIj0jmD405fTVDHMr0VFg==
X-Received: by 2002:a17:906:b3a4:b0:aa5:aa3:8c45 with SMTP id a640c23a62f3a-aa581055163mr464111866b.48.1732795920072;
        Thu, 28 Nov 2024 04:12:00 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e63a2sm59846366b.113.2024.11.28.04.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 04:11:59 -0800 (PST)
Message-ID: <b76cea3a-b330-45b1-92a5-844aa081b0a3@linaro.org>
Date: Thu, 28 Nov 2024 12:11:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] clk: qcom: common: Add support for power-domain
 attachment
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-0-836dad33521a@linaro.org>
 <20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-2-836dad33521a@linaro.org>
 <8189fe4a-b6f5-43a6-9f7f-1abddc366ada@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <8189fe4a-b6f5-43a6-9f7f-1abddc366ada@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/11/2024 12:07, Vladimir Zapolskiy wrote:
> Hello Bryan.
> 
> On 11/27/24 01:44, Bryan O'Donoghue wrote:
>> Right now we support one power-domain per clock controller.
>> These single power-domains are switched on by the driver platform logic.
>>
>> However when we have multiple power-domains attached to a clock- 
>> controller
>> that list of power-domains must be handled outside of driver platform
>> logic.
>>
>> Use devm_pm_domain_attach_list() to automatically hook the list of given
>> power-domains in the dtsi for the clock-controller driver.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   drivers/clk/qcom/common.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
> 
> Is there any particular reason why my review comment was ignored?
> 
> https://lore.kernel.org/all/8a33c0ff-0c6d-4995- 
> b239-023d2a2c2af5@linaro.org/
> 
> There is no signs of the change improvement, unfortunately.
> 
> -- 
> Best wishes,
> Vladimir

In the cover letter I cover what was done and not done and why.

I made a new function because it "looks neater" to me that way.

I implemented your feedback on ret and -EEXIST.

Passing NULL instead of &pd_data doesn't work unfortunately.

Let me know what else you'd like covered or revised from the cover letter.

---
bod

