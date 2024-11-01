Return-Path: <linux-kernel+bounces-392609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B7B9B962A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42921C20B19
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768FF1CACC8;
	Fri,  1 Nov 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="bzeQE7jx"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D514A09E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480536; cv=none; b=An914rD4DS06uxrKgdGT3g9mWeAlsMHeFw71vHex9gCUywXJRAadNvP0x89+R9dsfWMcADGntqoaadz3BmSlYlburdJukv3RlFLZFBAk74lSHLQ8jFcieKBI7PMc5xWnQN5zzXdBO08o4XLd621iXOa+PFHcWBO6CRxqaw6+l6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480536; c=relaxed/simple;
	bh=0g1xc/g9SdMvarbgTwaQcoW0GinerdmxMD7QfBpVIZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TA6w8XN7j6m3eg4hKTY7oBvgwj3E17vuW3ub/CcCpZ9VoLzI041N+wTN8G3eEL8ynKQzmdaBKL0C63Wru/U5ozmkGPxk1/U94TfDBeqI8pm26ihM/HJGx2dvU/Tr1VWyiCEJo2sP/AXPjQlprKgI4JcoakvpKsCjpoGrJBPSMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=bzeQE7jx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315abed18aso18106725e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1730480533; x=1731085333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ttt7kTTmjlcB9/HFrg2BcZdwAtIWFatPix1EDSZicqI=;
        b=bzeQE7jxJN5i9p7zLXA3v0o4BHTy8bDvwdzlVES6ITMXAr0NP5HtwC9mVoukqn55Mf
         87JLXeAPyi1DWHhl4EQaBJIro/aXiKTXOIeuSGZcJOSjOG6hkkFrnqNL6b5z1OHB8PRo
         s0w2lwjmUIAX2aQK0KZGMlX3JZRUn+DEC590DpeAe5zpdQmmA1OIJpDdR0KmM6wfQ2C/
         ll/4HlKvI4eSxKBKNL2VwnzMJCmCJMJ0x3GqyOqs59Uab0aqY5AjQK3vYFOdukZfU3IP
         SYxRF/firCat9mOqLHHTTFp/iM9U6aewtPUkmr3KxIRU8cei0UWSVaS72hFMpgh2J8mE
         C6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480533; x=1731085333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ttt7kTTmjlcB9/HFrg2BcZdwAtIWFatPix1EDSZicqI=;
        b=WVdpmHXmYq434rvWAmsMJAZTJQnftcU3loDdlZWgcanhCrxzYsy95uXOn9yk3RNJTZ
         PeZzFtUmG7c+32BmOvZrRrT/qoG0PLeOOCm8UViIk4b58Okl0qno2Qu6M66AClyV3osE
         iIgE9XUWftQq4BSfMbW2zYxoryoZKmAQ1ea08TL9hBQHMjZvT0aWso6hfOL40fm97R90
         5ZoSfJdJ99XLUAGV/cZJsSnbI3oCxJJ0AaKcJ1LRubRbMDLPILyTFrWgd4FXV3d+6P8W
         AJODAfOY/CZcUJH3Q2j337fEtHARltVS2ojholWQ//6g6uj2ou7cbc9wDvPx0MPyNoyX
         3Jsw==
X-Forwarded-Encrypted: i=1; AJvYcCUmCCRJtavZdpKkA4n1KOpbWDbEt2Yqay0x7F8lPSWGHv76eB2/LWoQ3/ylPMHU9772uVeSlSfbHfMrZhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJVnTd6eM8FnZxZsByMakibZd0JF9B+PFkqA/vPWngAakzMGF
	ySmgkmBVDP1V7r3TXapidTP1h6ffKUR1/8okASgeb0hhgP9Cn2wBEsRwU1w1Ds4=
X-Google-Smtp-Source: AGHT+IFUQcN/SdaEyOni7ENfa3fZm4nyzrTwYYuXbVvH6ohI0n1l6mT12HgcuX8791J1w+nxUayUNQ==
X-Received: by 2002:a05:600c:4ed1:b0:42f:7ed4:4c25 with SMTP id 5b1f17b1804b1-43283249aa9mr33112075e9.14.1730480533028;
        Fri, 01 Nov 2024 10:02:13 -0700 (PDT)
Received: from [192.168.0.35] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116abb5sm5661498f8f.100.2024.11.01.10.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 10:02:12 -0700 (PDT)
Message-ID: <4e3b879a-0663-440a-9630-97834c5f5d43@nexus-software.ie>
Date: Fri, 1 Nov 2024 17:02:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] media: qcom: camss: Add MSM8953 resources
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Vladimir Lypak <vladimir.lypak@gmail.com>
References: <20241101-camss-msm8953-v1-0-4012559fcbc2@mainlining.org>
 <20241101-camss-msm8953-v1-3-4012559fcbc2@mainlining.org>
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20241101-camss-msm8953-v1-3-4012559fcbc2@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/11/2024 13:47, Barnabás Czémán wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> This commit describes the hardware layout for the MSM8953/SDM450/SDM632
> for the following hardware blocks:
> 
> - 2 x VFE, 3 RDI per VFE
> - 3 x CSID
> - 3 x CSI PHY
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
Good work.

Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod

