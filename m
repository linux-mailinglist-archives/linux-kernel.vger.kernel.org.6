Return-Path: <linux-kernel+bounces-424964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525249DBBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171F8281EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A02F1C173F;
	Thu, 28 Nov 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAmaXley"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0E1C173D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732815497; cv=none; b=qF1pJ5ZpENRgdsywYAubz2EBHvJ46yD1Z3Bejkhtymuemw1A1jZcaiagOxlEb/M4Zz6+XfCA7djspXcQZYpNyMDqUlIVq4ybGG2+0ICB39nVOpzDu4qREgoiZzEIdNZ2vp1cMr6q4ZbiOabSnkh3JpUldWYX7fX2GyE1ySUeaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732815497; c=relaxed/simple;
	bh=7Wg7RpuZOM/HyrjX0bWWh7XXJ/yOw0T82VzA/PUnTxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLwXSIExMfYVJ6KSfPOFMrIgIEYFQBCyemdZUjUjBg585EqBvnmrjKRnwBFFPMNHIRvdKFkK8rnewq84YBivz3k1QezRsdFl0Hilq/lNND7ZsT8hl0UqSkIhY6y1KLnIL6LZw2OpXzNYfM0sPRoyoDuwpHm+mNvu89oRLyRALTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DAmaXley; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4349cc45219so9494795e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732815494; x=1733420294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10gOONKYd0Gk3rZPYV0aoJyh1TGfB9PFutKnizLk6Y4=;
        b=DAmaXleyI2w5Pod442rCsFxEJe2rHFKbx6/Iyj4/XGok5Yq/jKCjntGw12ynFMS3n4
         T8iStoSQH18DMLcWWOEhECChaZ/ITXGhw0/bZY/aTxwtDmd7g2szUxTREken1V+wjiGA
         EkOPZKATsV1Nuy0Yy0rKPbM0sdiazZoj5SigVGJnur/Hpdhl/8VotdUBHsJzqWZDExWA
         c9atkGBBBY2384aFg+GK1VYST97pUmNAtj4O9YH6hrgMzA+Ej7LFgzglzENnNNEiHn8d
         6cqQOVPfxpsi/d95U0kg/S0NAGiJc8QjVK4jGpdk1XVPM9E900SsWU7B/kdB4E2ImvkE
         ey/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732815494; x=1733420294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10gOONKYd0Gk3rZPYV0aoJyh1TGfB9PFutKnizLk6Y4=;
        b=CI7e505v79yBxLwEFbho/grmHz2upDf7vfaSmEnDHVNs0sb1EmbI6t6B119+ok5tYW
         KxIoKJNJJnh2Y6Rwih3x7HDNr+N7VHzgA97XzHV68jTOjsuib1S/Ad6E91GGXlM5foUO
         PFgsTcYXSGOMaXO467+hgW2dZS4l5Ty0m6HDFJaJv7AVCbwrdTep/+e1BhAqSxPOWSIg
         CpCnMuFB45vkRucbHEDHaZ2tI08O0XIaJy9tRBb3OjS7eq0lUGxLAnVl89Hp0R/jpkLh
         +ksQ4AD/fak6/D2KYcWn7eU/YSm9vwZsEwvhnTuBNDyeM8OefCWWjhwj+vzY/u7Iuvhm
         HfWw==
X-Gm-Message-State: AOJu0YwAXxI/HoyRL/I8pfhlfDNJrmaYOEhdrUlm38OMG5Rmx35pcIAm
	0dU9a7WatM3IflRFeW/Gt35lnePN8Qu++u8rsQEsJ0cwBysEJxhsxxZuS3ng5no=
X-Gm-Gg: ASbGnctHTIEvpcKx7TtdGDnindOsr/HA/O6xasp/muLprO61XAjoNCAfa2ZYl35wKeT
	EkSg6FD6oCvORM59vcMKFKW1UUeN2e3yFOiE5cxbtf3VeKUasR3Yt59vIzKRwz8odZaw5AjSBuX
	GFzJxNMmayPs7FrNnkvSEXpU08EGvhbGJh9snr/YU6boS5JOI4oxM8wUf5qRwptcDWsjmuPRQG2
	NgFvM+MjmcoWYoCJuXxdg/2TGT058XIbxuyBrWCtcx+0+WHxgLbYqXeVx3PQ7aeN9GJHhuL1bYK
	PrroHx14NktNLA==
X-Google-Smtp-Source: AGHT+IGyiJDbepmBMbDSY4970QLlGU0+MdW25rYKAMlGZRbsCkkVDjf5WuEnqq8LxT5+l+e+vpF+ww==
X-Received: by 2002:a05:600c:4447:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-434a9dbaed6mr78728755e9.4.1732815494001;
        Thu, 28 Nov 2024 09:38:14 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm28022775e9.15.2024.11.28.09.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 09:38:13 -0800 (PST)
Message-ID: <c1c14ada-c0bf-4353-a8ba-7b3a2fb6d971@linaro.org>
Date: Thu, 28 Nov 2024 18:38:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] thermal: multi-sensor aggregation support
To: Nicolas Pitre <nico@fluxnic.net>, "Rafael J . Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexandre Bailon <abailon@baylibre.com>
References: <20241112052211.3087348-1-nico@fluxnic.net>
 <s120q967-4r69-pps2-1qo3-9952r9173125@syhkavp.arg>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <s120q967-4r69-pps2-1qo3-9952r9173125@syhkavp.arg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Nicolas,

On 27/11/2024 23:05, Nicolas Pitre wrote:
> Gentle ping, feedback appreciated.

I'm currently reviewing the series.

We have been discussing this feature since a long time and multiple 
times at different plumbers without any progress since then. So thank 
you for proposing an implementation of this feature.

I have some concerns regarding the approach I will raise tomorrow.

Thanks

   -- Daniel

> On Tue, 12 Nov 2024, Nicolas Pitre wrote:
> 
>> This series provides support for thermal aggregation of multiple sensors.
>> The "one sensor per zone" model is preserved for all its advantages.
>> Aggregation is performed via the creation of a special zone whose purpose
>> consists in aggregating its associated primary zones using a weighted
>> average.
>>
>> Motivation for this work stems from use cases where multiple sensors are
>> contained within the same performance domain. In such case it is preferable
>> to apply thermal mitigation while considering all such sensors as a whole.
>>
>> Previous incarnation by Alexandre Bailon can be found here:
>> https://patchwork.kernel.org/project/linux-pm/cover/20240613132410.161663-1-abailon@baylibre.com/
>>
>> diffstat:
>>   .../bindings/thermal/thermal-zones.yaml       |   5 +-
>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 210 +-----
>>   drivers/thermal/Kconfig                       |  27 +
>>   drivers/thermal/thermal_core.c                | 643 ++++++++++++++++++
>>   drivers/thermal/thermal_core.h                |  14 +
>>   drivers/thermal/thermal_of.c                  |  86 ++-
>>   6 files changed, 780 insertions(+), 205 deletions(-)
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

