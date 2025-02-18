Return-Path: <linux-kernel+bounces-519880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC2A3A316
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A863AE205
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772F26F446;
	Tue, 18 Feb 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLnSo7/W"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDE24336D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897052; cv=none; b=OKG6+JxSJ7lD5JjVRRuxY9Sv/yIhT7iOPUihmOKCvIm8LE0ONF/FTOU+Z6mwRFt8ichxzRViM/vO9bUSFVaE8GL/Nnz8rD9buxMR+fWMyU4IkBk5U1DV2wOTvwQePV0Sfn8v+ZlcaB2WEV7Vd9uehE5FYKzMFRA8QgBmWxbRqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897052; c=relaxed/simple;
	bh=ecVY+gv1Bw65DvJhP3WRsBzu8IgIbbZITzxHtqJ/Ow0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tFbmJ3ZLpbUHEwuJ/Xhj4ktClDy4EUw6VJHR1znts7ntrNvsBpgvRwKK7IlnhWKSeAbzTgk5fe6oU1pQdKYXyqCXSKdhrsuidigB5yLR0tSqwoPdP5V5xH32Hkk6Lmu7MQJGdOUOqK+5YWy3IKrQHqfpAuwzuOJl4CtOCNGtuLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LLnSo7/W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43937cf2131so38763755e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739897049; x=1740501849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rNolTsZiemwL3MqHvmSKz5sOO+WofguQrhSb8yM7bJM=;
        b=LLnSo7/Wrx/TOXZwwpTh5iDQKrGRXm0/eyiHuMxnt2ej+x4bPCI9hWm6PLXr6QZsCP
         ltxaopu5I0UNowQbvj5DnMtVAOZbQ3ntdERzRyBKoKvGJJ6CB/fpr+O/L7N1Xb34Ybbh
         b6XAP+nF/lV2+YoWBu1rKlIXX6eMekxmrdbYlREwWrKiRkEgmxmgY37SI3qpsItnLNPM
         kko4UmjalEHMmp8LgZNybTuzmE0MAPF7qWGDnB5ceu45ClJv3aINB56mEGxCtYRkO+yg
         fq8M51JKcmw1BiYmAnZxZRdFGJr/fP9LJ0N3GnzrsbParooItfs3q679uDyemXe5WoIx
         OsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739897049; x=1740501849;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNolTsZiemwL3MqHvmSKz5sOO+WofguQrhSb8yM7bJM=;
        b=HxAKOOnTEHocLJz8XbPhPayDTC7kwvywCgirvd4Xauvs3Cj8ifqELp7OEY2G3TH9m/
         RB6n0O/rZ300LgS+pE/2YwvLsGcR24sN5SuBJZGwuY1kjSSZGGEMLBs+6zEzj/9qGb45
         N6JZ4lU37/TUAogDx40p4jhXLXpk14sMPWzKlWmbm8iqR3Son0KiDazzMumlBDxLPCaB
         LNfEIBkGCcnykbSnFN6E3ViuJHPfTZTxZ/XRyQ+mmK6RS9FX3i3kZJdQobNjkzm4bEOK
         va/k/z9OLjAQo2Eac4t/lEbY4Y0sFCZoGxq9W/47BNOzFAv4pODo5HSvC/fPwr2ZWsA2
         LidQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS12r0FCvF+hIsQjM5Wme8wotVAxQXNti0+UgT0f2rbiULP6lfKtFw3a0CF+c2BEM0HV0zPP14aAhv1+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaiyt0D0udwgjoG8dbeWe/eznmgmZyGpPKLbeX+2ziXGBMC6If
	abjaZy2mgWnoYw3iRtrGcKs4W7p99olebVIq51LkY74fZTOThwUjW8Qd5tXNHNE=
X-Gm-Gg: ASbGncukmqOox0foC7//vEYnvcPu41McQ5bKINMnFYTL0LbKw3BQ24BVFJU1A+961S2
	jgDYuDs6t8fJizT8y0mo3BICRbPCFFeLodkkIAO6hzItLGuKQAkuOzIKvVELBSHFrPurTembBSR
	2A78hgjpNr8jelQmjLq8eFCRen6P1Zb+B5IgYnNZT/U7nYmRsQwaf2wh4G5ci7zERZO5IKzAFie
	q48TBJ7YKW/sCB2wZC5sv5CduyVmtGX6lBTJVizaQgDTq6np9RwFBaR+s1l/LaCp4nu40J4fzLJ
	X9VJaTgc0N+C6xrv6nyDWDKZVjii+XpJZIp8x2DqtHaxthVjwIBjUnYL
X-Google-Smtp-Source: AGHT+IHRNK4mSxCdis54SwXkqCDZrb5jymOcpWY4wAXt2MV8r6iy6nxS/LiPmAc4W5Fyl5byIMaTTA==
X-Received: by 2002:a5d:5f50:0:b0:38f:28dc:db50 with SMTP id ffacd0b85a97d-38f33f11953mr14595414f8f.1.1739897049224;
        Tue, 18 Feb 2025 08:44:09 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddbbdsm15567675f8f.37.2025.02.18.08.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 08:44:08 -0800 (PST)
Message-ID: <9e9f742a-2972-476a-91cf-fc596221bedb@linaro.org>
Date: Tue, 18 Feb 2025 16:44:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: videocc: Add support to attach multiple
 power domains
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-4-cfe6289ea29b@quicinc.com>
 <eec2869a-fa8f-4aaf-9fc5-e7a8baf0f864@linaro.org>
Content-Language: en-US
In-Reply-To: <eec2869a-fa8f-4aaf-9fc5-e7a8baf0f864@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/02/2025 15:46, Bryan O'Donoghue wrote:
>> +    ret = qcom_cc_attach_pds(&pdev->dev, &video_cc_sm8550_desc);
>> +    if (ret)
>> +        return ret;
>> +
>>       ret = devm_pm_runtime_enable(&pdev->dev);
>>       if (ret)
>>           return ret;
>>
> 
> What's the difference between doing the attach here or doing it in 
> really_probe() ?
> 
> There doesn't seem to be any difference except that we will have an 
> additional delay introduced.
> 
> Are you describing a race condition ?
> 
> I don't see _logic_ here to moving the call into the controller's higher 
> level probe.

I see you're saying do this before waking up the local PLLs prior to 
really_probe.

hmm.. the existing code works for me on the CRD but not on the Dell 
Insprion14 so I missed this on my series.

Instead of pushing qcom_cc_attach_pds() back up one level and having to 
do that over and over again for each clock controller that has multiple 
power domains, we could just move the configure pll logic to a callback.

Add a new callback to qcom_cc_desc()->configure_plls()

Then qcom_cc_really_probe() would look like:

ret = devm_pm_domain_attach_list();
if (ret < 0 && ret != -EEXIST);
	return ret;

desc->configure_plls();

There's no point in having devm_pm_domain_attach_list() twice within < 
20 LOC we should just force the sequencing in the right order once and 
IMO do it in really_probe() so that we don't keep adding custom logic to 
multi-pd controllers.

Its a generic problem we can solve closer to the core logic.

---
bod

