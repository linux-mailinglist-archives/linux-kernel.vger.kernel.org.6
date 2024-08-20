Return-Path: <linux-kernel+bounces-293494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECC195807F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E6D1C23AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B746189F48;
	Tue, 20 Aug 2024 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n3DlwWdz"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB7189B81
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141143; cv=none; b=KWUCXa9/GjwpQXp2afO5sizwVuE4nJ0+Nb+aJNvKSqygdiyN9RMVbPabiWOSy9aS6k7lRPFipDs8ObM8+C0jSdrxSXthBjPLW1V+TrHBp0yAql+sqMDrncLMWfijudLpWLQm5grb4bKglQiF0qBY/CjqD4+zLij8mj1iVbSPv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141143; c=relaxed/simple;
	bh=EHd8RNwJxQFBJ9k25QBZN2pksAWvbgMik6YMrlwPCX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyjWEBfRE+MArB4oyLy0+JQEUfBqVCbbYYuOg/vcFR+IeVjfWDkG4CibAp4FHAqCShyfT8QpRKrQGJS0cltFnPjfHGUHS2/MbiItsJ9grAc0L2OaMQmF2CzhVDNtHFz6zYqMZNPXpuNPz7zFDXgUQHvF+nuROaSdQw/Zhl1/yNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n3DlwWdz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4281c164408so40865535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724141139; x=1724745939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUrBtVd9BLV5NodOKrgO2/cphE/4UyWw8eXELeGJ9WA=;
        b=n3DlwWdz3P2dwFKrVCNdJLPUEBVM1uVvF5qfAfv6El0k5hlw3elS7dRlTAm5ZYLyLf
         uI5b7s60V3ZIugCkZF17zXd0t+iC0+8bm7LX49XJMI6TB0uRofLlJTYS5/cEZ8jzDJcs
         nSBTI7+sMoOuTDntb0roPiFd+IzHcucFOUMw3ELmKvdF3NtxvMg4s86GJaBHkELC4mzc
         WBWqUYwiRo1qTHp4LiX+c8ptoJclgohAkjoDk0k9zPcbUgL1V8P/UnzRdHuj89/a4Zxr
         +Nsf3hc7A2erInmwXwRaHapeLlSOXGejRZQngHx8bVdq9/lrQq/vYNdmoTbfN1XuEaQ1
         I4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724141139; x=1724745939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUrBtVd9BLV5NodOKrgO2/cphE/4UyWw8eXELeGJ9WA=;
        b=wt2qFTS6j/JbCznQ0+SQ1xAIZqelpnFf2Z3m/V6E4BAH0X5Krj9/eI6ZzF/eSC73I6
         J2sVOYp3Zg1OAGnE/S6gQwa+9KUoeiXRxASl8kUQC6AV6io55rG9raSHxXaatJSiv+yC
         ChEE0YgVSVhPrQR38Sao9MvW3jsU7q4CLtcACr0VM4f9BRgOLYOwtmhqBSG3qToB5kzs
         vK5UAJjh8y0PSVLPXX9dlA9PPZXzU4IehZGEtzHA7THsu0kJyAzNG+RIbFLosHh3UC/G
         h07Oan+AVlqBMkyF4UeGUzVUWupCvJZBoBzjOGvLjlWkz4KxU7r9s+nMy9O0Iew5veam
         BDew==
X-Forwarded-Encrypted: i=1; AJvYcCXQJDZK4GH/O914oXg81kSveS7v2Lnyr5LfZ6d4hevsZ3WF0F6kNATa/BipXvwk8RFqd0/9H/adJiXsLRnLcy3kXNJlHGGreQekP8QU
X-Gm-Message-State: AOJu0YyJRWyzIckHTG66a9a8nxIRoOVsoClWsAt7afX5L99ABzJ7lXxV
	8yEfk/OsOMPG1jK0iw0jCDq9lG6SdUDYQcqyKyM5WamdpV7q8GZAOyk1uw8LJMpQooE+pGxWEfw
	4
X-Google-Smtp-Source: AGHT+IEeE1ef7g/ycQmCjSQj8MBpZAH2kJ9KOcQsu0ftfibRwdYkeus8X/03YczgKnaOrugc4fW/bg==
X-Received: by 2002:a05:600c:138a:b0:428:f41:d467 with SMTP id 5b1f17b1804b1-429ed78900cmr93821075e9.10.1724141138716;
        Tue, 20 Aug 2024 01:05:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429eeadfafbsm131877645e9.47.2024.08.20.01.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 01:05:38 -0700 (PDT)
Message-ID: <c1722b7e-9378-454d-84f6-3f9399224cf8@linaro.org>
Date: Tue, 20 Aug 2024 10:05:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add thermal management support for STi platform
To: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20240716-thermal-v4-0-947b327e165c@gmail.com>
 <85eedb28-c02f-40ef-9d65-e8689b3f7dbd@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <85eedb28-c02f-40ef-9d65-e8689b3f7dbd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 22:21, Raphaël Gallais-Pou wrote:
> Hello,
> 
> Le 16/07/2024 à 19:34, Raphael Gallais-Pou a écrit :
>> This patch series enhances the st_thermal driver in order to enable
>> support for thermal zones. The changes include:
>>
>> 1. Replace deprecated PM runtime macros with their updated counterparts.
>> 2. Implementing devm_* based thermal of zone functions within the driver.
>> 3. Updating the stih418 device-tree.
>>
>> The device-tree patch depends on an earlier patch sent to the mailing
>> list [1].
>>
>> As it is currently implemented, an alert threshold of 85°C is set to
>> trigger the CPU throttling, and when the temperature exceeds the
>> critical threshold of 95°C, the system shuts down. There is for now no
>> active cooling device on the platform, which explains the use of the
>> cpufreq framework.
>>
>> [1] https://lore.kernel.org/lkml/20240320-thermal- 
>> v3-2-700296694c4a@gmail.com
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>> Changes in v4:
>> - [2/2] optimize dependencies
>> - [2/2] do not return devm_* exit code
>> - Link to v3: https://lore.kernel.org/r/20240714-thermal- 
>> v3-0-88f2489ef7d5@gmail.com
> 
> Gentle ping on this serie :)
> 
> Thanks for your time,

Applied, thanks

Thanks for the patch 2/2 ;)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

