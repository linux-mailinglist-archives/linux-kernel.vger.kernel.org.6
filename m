Return-Path: <linux-kernel+bounces-425127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1F9DBDA9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442FD28255A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383D1C4A3E;
	Thu, 28 Nov 2024 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJrVLhy5"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90B1C3F03
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833288; cv=none; b=DQak4nRkdhI45xZsqAofKWIdBB4McMa5UUf2IwB8lnPer8l6D97XoVF9nHjj42rAVIkHIwRPyt0adBAdcK5BBKyOc0J7pkJvtVSZAzY7s5ujpheGucIBGlGHIvcVlb+HvOLBILuKR2oeNiX5Smj0S59WwZCDgSktc4dvVXh4Hss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833288; c=relaxed/simple;
	bh=AUkT88Th6kutpsO9rSnKuodwKE5fXwcpQTd6174vA6k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XLylyT7yw4Kd0RYONzYlhylNc9u6VfEdAXVptW/YxQ3KCHctbMwVN67+OCvMCegA5jmZzmRfCoCaDBNFpue678XoxU/2ABkntdOCJG47I9BRAYPjfca+pFAN87UsYBs6tHHh3z2FUYd1F2lWvss9kxr5p7P8717Drlxco3L4ino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CJrVLhy5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so11120845e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732833285; x=1733438085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mPjrQlS/j4lgnq4nZOck4tCS7rWNRW0RmXaCV/t217s=;
        b=CJrVLhy5H5xIVbsF/pS1hp7tYgWyva3X+IOClnq/cm6hucVBgxUCUzIPTpjLZ+mHfd
         sYhl1rcOnW5Fvl9Um9EEW6KHlyf9rPZYiB7on5SIY3KWwEBywkDkskSL6UQoPxFQq9bM
         /9LIywAKTCXPx9O6G6I/HBNhfQwaV7z232Uo0WVE5jlEB8QyWR6AlMrdv+b5icCkFkj5
         Y78IHwpq/LrHl+i9yQo0FIe40e7gv0mcUPwRk8q132yEZ1hGUIj/RpRpUdcgPzR0k+b/
         q7k42VkpVoUqhkXbqDbckxZubwJf3DWDOjnvociWqv55SJIthF5P/sOAWI3kzUznKQjz
         YZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732833285; x=1733438085;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPjrQlS/j4lgnq4nZOck4tCS7rWNRW0RmXaCV/t217s=;
        b=Lo2UdOeJOEJXj5q4/pUA7ASC46/bBoDoVR+0rGsbce+piImFjWXYQNQ+aBYOvWYqcT
         kb8eD4Z3wB2nafoLGnQ8wRmOGEC68DP92XIlx66k7p66Ei8bwpvBB3F8T9UJbxJ/HVhL
         Jo8kJ+0a/UFI9mLW/yHoAnMAUgRoXwz6nwb7KosneIMMsW2HvamAZW0Dz5oqmz91DfSU
         armUKOmKD4Kln/Nfqz0Dhmr7t+KvryWXM3LARcftddnOgFAP353to4UJu28cpk5UisW4
         V8vasyU4QcVhXdkmWkLBvbjEKZ5juIvUE5xkDu0tIfDvb/R7Vh7PtTius4jS3SQjKrPM
         edfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqKFi208iombvK+kmtrG6l8i2a/GLKVYd/Y7h56NEFD2OYHpBCfysXdOyt75n73BVb6kR08j462dLZ4qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxAWES405ErbDIXy34S/auTpjKkihS17/8Am0xQvUxl4R1fCDR
	rFwvOBtHavglwaO6Nf8hvwwN0Nq/NDb0oKdtz+VtQmmf11TxkC2BhlHwpbAKa+Y=
X-Gm-Gg: ASbGncsasQ4orWB6Z5tU8N/idxGXXb5ykkHyK9jSfa/IeBVr7Xxh3WbRts+7JwjpctW
	452DfBU3SbwQvjVj2Le9GfVhVe/ifhJSX7wmV5aG1zAVC7prCEqCuqb/qq15yBR13XyhWbVTcLv
	tXEQleCGoIm7Hew7abhb9HPWN2p5begV2SmJF7vrQC8sIsbrtYDUe+SlNwGVLMD7bv/Q85tOEOp
	HufHO6VsFF+ia+ZkLHkC8oMoHhfWpCC+ssp3CVdIJ3eDf/m9RfDQbCHWWnRez0=
X-Google-Smtp-Source: AGHT+IH8HKeLrud/hmB58OwNwUNUc0fecGxOTCsVoS2qCTKMbmueDaSl/mes9YkrPVY95d4pKo7gpg==
X-Received: by 2002:a05:6000:18ab:b0:382:4978:2ab9 with SMTP id ffacd0b85a97d-385c6cca356mr8106802f8f.5.1732833285140;
        Thu, 28 Nov 2024 14:34:45 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385d6e60909sm1601043f8f.76.2024.11.28.14.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 14:34:44 -0800 (PST)
Message-ID: <f88dbe6d-ceac-4fb3-83ad-f202a4703003@linaro.org>
Date: Thu, 28 Nov 2024 22:34:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] media: venus: Add support for static video
 encoder/decoder declarations
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com,
 quic_dikshita@quicinc.com, konradybcio@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, devicetree@vger.kernel.org
References: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v1-0-99c16f266b46@linaro.org>
 <20241127-media-staging-24-11-25-rb3-hw-compat-string-v1-1-99c16f266b46@linaro.org>
 <7d344377-f1cf-400e-a9c4-442123dcf4ab@oss.qualcomm.com>
 <95ec73c9-da38-4888-9e00-4458b5a7661c@linaro.org>
Content-Language: en-US
In-Reply-To: <95ec73c9-da38-4888-9e00-4458b5a7661c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/11/2024 22:14, Bryan O'Donoghue wrote:
> On 28/11/2024 20:02, Konrad Dybcio wrote:
>> Bryan,
>>
>> I'm still not sure if keeping the logic behind this makes sense at all.
>>
>> Could we not just call platform_device_register_data() with a static
>> configuration of 1 core being enc and the other dec?
> 
> That's another way to do this. One reason I wrote this series to 
> continue to rely on the existing compat= method though is it stuck in my 
> mind that we have some dependency ordering logic in at the moment.
> 
> For example:
> 
> commit 08b1cf474b7f72750adebe0f0a35f8e9a3eb75f6
> Author: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Date:   Fri Feb 5 19:11:49 2021 +0100
> 
> And the other reason is the prototype platform_device_register_* looks 
> like more surgery and ultimately more validation / potential for bugs.
> 
> Since this driver is supposed to be moving to maintenance mode, I didn't 
> want to do a more major rewrite of the probe() and remove() paths.
> 
> ---
> bod
> 

and.. I wanted to continue support sdm630/sdm660/msm8996/msm8998 without 
any additional effort to go finding power-domains and clocks which in 
those cases the existing compat= method actually does something useful.

Also potentially other/new additions to venus which have xcoder specific 
PDs and clocks would logically want to specify those as we do for the 
above listed SoCs.

---
bod

