Return-Path: <linux-kernel+bounces-246077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123A492BD56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A7F1F248D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE4D19CD01;
	Tue,  9 Jul 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AT+ccygl"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B078319CCF4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536276; cv=none; b=srPufGnZRG9pXawobNa7pVJNTlZdA1W15BDwr2Un3oqAw7oDYsLBWRYGVo0XR9H6W7qV0UwJMk2w0+6/Q5aPPzBTVBlOVGG+zO7e8ylhwOZhkRe246d3AfH9U4F2IJjIcl1zdgWHIhcpslA3W9jvwh5uOp6UGISEchdNXlmgpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536276; c=relaxed/simple;
	bh=EO91cNaboL0EoiGeo8it3eM5gZi9/8eY9iBNXjCzwnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fo/w1XiyX4j00kQdeWVeiop1zHNZgYZZs2V30NnQ1bCjNJuutn0N3nOzsAoS3XHig/skqZ851wKpr+KxMZ29UnB7A5uNeY+8KOoJs+hCl9h6XeaPEYmgEapNbM4to8wk5ycTC8j0/BIEvw5zCE0b+2IW0MrFuOOGDCOnEUD53mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AT+ccygl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4267300145eso7275135e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720536272; x=1721141072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=89CVG8PirKJGd2p5qKYHfkn2Q7yb/GNdpOG0+3K7ucE=;
        b=AT+ccyglHWZ01kJAxftnZuGU6l4yA+XGzgfOOD4Wt9DNc/YSuzj1Xf1yp7us5Ypubq
         npsB97bh2ORq9wwqoScGOztRrOAlVvCOd4Y2FKWJmR0odiNCj4TJUfBMI7QPHxD9YIGs
         fLpWzkuWQn0J+LOiUkiG77jmPoQlQgZg0Bjl1Cr/JmU86vWuq01yFCyzWfw3nEqtpLXJ
         rdXIgV91bRk50I1t8eBOsjzfj4Clo9x84hNgfe3TgA0fjOH9GAd7mzjVREgobcAGvGDP
         vlZPRTybKCYY5FHgGlCFbY+O1fjH95qajBPR6y2GzF90dEW5NDtTSZ+c0AEZuJPL7iB0
         Bsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720536272; x=1721141072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89CVG8PirKJGd2p5qKYHfkn2Q7yb/GNdpOG0+3K7ucE=;
        b=Nl9L7PxmRp5ma5XrkIlQyV1w6NP4M9l3my4DR78wMKSaqq7lFhe3so8P2cDRqSROrw
         dhDRSTxBw1j6W31zISIYtiWTASMmDL9lTl0S9kNjskWIi59JP3sbvPcY/icl56rGmE32
         BMrW7AEOn5AUeSDjki8FKAybYMuDMHM8YbbNGO2oxezTJTcmZkVr+zjgYKQ8v9iIOJvi
         FS1IsyMtGrzGFXaUj+GNWkrsoYr9pSQW7ujIDynsvoqr1k1JS6Xv+HGcDKqPGp9Hvteb
         KvMVFeKszUKOs5FHFDdRF8OKALIcJSlM2mYflLa/1Ev9aYZjxONKZ2h0VhiuwxvRYQCn
         wEJA==
X-Forwarded-Encrypted: i=1; AJvYcCWdWyEqPLTC2NOa6f7qdxwSgRoiaTbBY9xGeqV47mApJzadOiGhewlVV6kfGGKIBTOrnbWx7r9fMJ+MtsIxkvqpmDblgiT2gJaoHSTn
X-Gm-Message-State: AOJu0YydvbQoTg5BvjvS0TbTXYtJ/tEt0UPMyYYDQc5hCv9maSR+eQSn
	B/TuhMpTkz/3xMF2+YcsR3S57k65/sZHPRB+wX+V5L6AShCouHLqvSTj7GzD5ic=
X-Google-Smtp-Source: AGHT+IFkFXzBarn+QW1p3ZRC4QomUej0KLISgkPxDiaxdu6n3ii95nyG25cGUx1uHTHEwI4s7SiaFQ==
X-Received: by 2002:a1c:4b0e:0:b0:426:5b76:13bd with SMTP id 5b1f17b1804b1-426708f2127mr23089575e9.38.1720536272077;
        Tue, 09 Jul 2024 07:44:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cf24:cce:17df:12ab? ([2a05:6e02:1041:c10:cf24:cce:17df:12ab])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42725eca905sm21529105e9.11.2024.07.09.07.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 07:44:31 -0700 (PDT)
Message-ID: <4729a8ba-655d-4127-9f14-33b4521b4442@linaro.org>
Date: Tue, 9 Jul 2024 16:44:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] clocksource: mips-gic-timer: Always use cluster
 0 counter as clocksource
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Chao-ying Fu <cfu@wavecomp.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@kernel.org>,
 Hauke Mehrtens <hauke@hauke-m.de>,
 Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>, linux-kernel@vger.kernel.org,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, "paulburton@kernel.org"
 <paulburton@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Serge Semin <fancer.lancer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20240511104341.151550-1-aleksandar.rikalo@syrmia.com>
 <20240511104341.151550-8-aleksandar.rikalo@syrmia.com>
 <bf4a45e9-4ed3-4d3b-bb96-add20a71b04c@linaro.org>
 <8b133053-247f-414b-9c01-e0e5291e347d@app.fastmail.com>
 <Zoz6kvcio/wl/015@alpha.franken.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Zoz6kvcio/wl/015@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/07/2024 10:53, Thomas Bogendoerfer wrote:
> On Tue, Jul 09, 2024 at 09:47:52AM +0800, Jiaxun Yang wrote:
>>
>>
>> 在2024年7月9日七月 上午12:36，Daniel Lezcano写道：
>>> On 11/05/2024 12:43, Aleksandar Rikalo wrote:
>>>> From: Paul Burton <paulburton@kernel.org>
>>>>
>>>> In a multi-cluster MIPS system we have multiple GICs - one in each
>>>> cluster - each of which has its own independent counter. The counters in
>>>> each GIC are not synchronised in any way, so they can drift relative to
>>>> one another through the lifetime of the system. This is problematic for
>>>> a clocksource which ought to be global.
>>>>
>>>> Avoid problems by always accessing cluster 0's counter, using
>>>> cross-cluster register access. This adds overhead so we only do so on
>>>> systems where we actually have CPUs present in multiple clusters.
>>>> For now, be extra conservative and don't use gic counter for vdso or
>>>> sched_clock in this case.
>>>>
>>>> Signed-off-by: Paul Burton <paulburton@kernel.org>
>>>> Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
>>>> Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
>>>> Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>>>> ---
>>>
>>> Applied patch 7 and 8
>>
>> I think it won't compile without patch 1 being applid.
>>
>> Thomas, do you mind to apply patch 1 for now? Given that it's just some extra
>> function definitions.
> 
> no problem, I've applied patch 1 und 2 to mips-next.

Usually we create a shared immutable branch, but as we are close to the 
PR, I propose I ack these two patches and let them go through the mips 
tree this time

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


