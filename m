Return-Path: <linux-kernel+bounces-405256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B49C59C4F20
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654A91F245A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D23720A5E3;
	Tue, 12 Nov 2024 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiUwcarV"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B029CBE6C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395212; cv=none; b=lESYpxNAvG6IZKpWrLAeuu71s70bcmM2oj9ME972Nfa3IwUnhQNQOd1JqW7kAN2qhSRl2pkZnFiHxoaQXR5PKX5oAT3jO3z99gOLGkHBjy/d43XrhSNPSiNlk1jd3NfOnLlvc1BSREwpvwAxRpII1RI5Eq3e3Az8CTVD4SWvCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395212; c=relaxed/simple;
	bh=WjpwijtD5u174kYoeapRsdwOFOq3X6wZmU8wYWLfhts=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rJz1tSdUuL5upcgtGOi7sUdftJcu95/deIlIFgVfzKtlAZBSQi57+UTE+gyij/SGkTvB1ZcmOwM124OM6/m0q+bBztK4i3QJKJIJBEJ4JGd6QvfbZdKs+RADsMH+thb9tmuyNSiZ/fkh/ExoB/NsMFAyxwsk0oOqjY2KWTyBT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MiUwcarV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so4947433f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731395209; x=1732000009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hObYuYl1ei/ScT2ORpCtLDWMlshHpVMx0blZrTEJrO4=;
        b=MiUwcarVXT05QocsiTYKR7KfUwj6+1IN3N2UDHcVPAFRWTF8/2Jl1wgngLuEH5NExW
         oFGihJYFgq04Y02Vkl3CCD31VyUAj0SUoUEMqU+2dVLe/HEqjLIdWqtxqbqfVzVGTZA7
         mkqua9EE6EmpmXxgj26hu1F3LAcyfrCMcrhlKmkzgc5bwEAP4PiuVPMbFrG5z7AHDo1Y
         E0yYqAB1mxR2k2vr+ZbcBCVbofMOCgrxoXtSjP2v7wvkyUhLaACcwszXd2fzBUugFHz1
         UJl5RKHGZlqFQ7NfGLXRcmeDU9aGvX99K+sGa0dqZI50xf191tc5ZvHPS6T1F1Gio8GZ
         OM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731395209; x=1732000009;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hObYuYl1ei/ScT2ORpCtLDWMlshHpVMx0blZrTEJrO4=;
        b=mH+Im/CIuMHE/xV+yEyNJiNpezqe+5VhE2ET/77azaI3aC6L+Y3vM3e4cNS8MjmcrD
         BKrZXhg7HWva9lD6LnEPChucLkFXQf8lp6xY55tKHgM2vnY7c8Wb5/Ud+gER1cbnu7cf
         ZqHdA7h7NMSP+kIaF2O0Gy4XzYSyRX5kE/+c7ZDfRz5+lX7Mm/SiZ8xntKPa8T96xcqu
         KplhzMT5HQMSmuPSgaQ9hoEhpFx88jF1zDI+cSrHEH6LBZbOXwNN09AICd/hu1xQF7eB
         l8nUt3k0yPtHmRMNQfQRBXhYpr4N6A+InqG9+IVrMlLsb4lCEWci0QjQscc7b0FbA3cB
         V0bg==
X-Forwarded-Encrypted: i=1; AJvYcCWKmQZbvbIvGXUDPIP7TU61YeiD6cN5Ma3yk144+T8npciSi3/oZXA5vur2sCZE4g83ykjfT3OZC7DUUhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvEsnasHSKH6kZ/qxlsgLHaOndoydPE8va8PzIi8b8rlfQx4Cv
	OW+CcWsIuX4Mbb70g6raBsQT//mfU5sOMiz0RPIP4MIgNTxQQKKvwujoN6csFZg9Cu79p3GTihj
	s
X-Google-Smtp-Source: AGHT+IH8gDIE5xOMkpAzeXeRAOV1bnomwYmpdgqhgYxSHOdPk/NbqhfDihFAmoQcWiKF7A/HXTTLwQ==
X-Received: by 2002:a05:6000:20c3:b0:381:f603:ff62 with SMTP id ffacd0b85a97d-381f603ff95mr10336826f8f.20.1731395208994;
        Mon, 11 Nov 2024 23:06:48 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432cf1216d6sm6086765e9.0.2024.11.11.23.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 23:06:48 -0800 (PST)
Message-ID: <5a2c8f53-117f-4ffb-9f85-de1ae83ff835@linaro.org>
Date: Tue, 12 Nov 2024 07:06:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: core: replace dummy buswidth from addr to
 data
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw,
 Cheng Ming Lin <chengminglin@mxic.com.tw>
References: <20241107093016.151448-1-linchengming884@gmail.com>
 <437e9c87-fbae-4402-858c-ce6de0a992c7@linaro.org>
 <CAAyq3Sb-dmmF8YsOdTYxZqX8Wn4d=WiAXkS4bHp5FLn3S+ouXg@mail.gmail.com>
 <01160386-a65f-44b0-ac57-ad77754f01cc@linaro.org>
Content-Language: en-US
In-Reply-To: <01160386-a65f-44b0-ac57-ad77754f01cc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/12/24 6:45 AM, Tudor Ambarus wrote:
> 
> 
> On 11/12/24 2:42 AM, Cheng Ming Lin wrote:
>> Hi Tudor,
>>
>> Tudor Ambarus <tudor.ambarus@linaro.org> 於 2024年11月11日 週一 下午6:18寫道：
>>>
>>>
>>>
>>> On 11/7/24 9:30 AM, Cheng Ming Lin wrote:
>>>> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>>>>
>>>> The default dummy cycle for Macronix SPI NOR flash in Octal Output
>>>> Read Mode(1-1-8) is 20.
>>>>
>>>> Currently, the dummy buswidth is set according to the address bus width.
>>>> In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
>>>> dummy cycles to bytes, this results in 20 x 1 / 8 = 2 bytes, causing the
>>>> host to read data 4 cycles too early.
>>>>
>>>> Since the protocol data buswidth is always greater than or equal to the
>>>> address buswidth. Setting the dummy buswidth to match the data buswidth
>>>> increases the likelihood that the dummy cycle-to-byte conversion will be
>>>> divisible, preventing the host from reading data prematurely.
>>>
>>> This is still very wrong and the `fix` is working just by chance.
>>> Consider what happens when one requires 10 dummy cycles. BTW, does this
>>> fix a real problem, or it's just a theoretical fix?
>>
>> In 1-1-8 mode, setting the dummy buswidth to match the data
>> buswidth ensures a dummy buswidth of 8, which can accommodate
>> all types of dummy cycles.
>>
>> This patch resolves a significant issue in 1-1-8 mode, as described above.
>>
> 
> shall we add a fixes tag then, and a cc to stable?

I need a patch today if you want it integrated in the SPI NOR PR.
Otherwise we'll queue one in the -rc phase.

