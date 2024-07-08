Return-Path: <linux-kernel+bounces-244668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A928A92A797
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8801F21601
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72392146586;
	Mon,  8 Jul 2024 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JarX0xlZ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2B1D69E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457382; cv=none; b=YPNKd3eCtzjj2JdMNcN23ZQJZNxSC8qBmOExIa/W9wBnR5JiU0yzkR6uG9zHJE8F8G1DhkHm6D0ruQ4HytJcgeWVJ6AGBwxqT5aOE/p8OoMIubbwVxG7YSZGAtKoIdSEoAZpL3oDEzLYuHGhN/iWVfv519E6p7TvzjHHl7AKUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457382; c=relaxed/simple;
	bh=38O5tYiUeu6BQ0UCErCZy/FI2MURCpJPkePGIDgKNxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3KntVPqBjRYfbzgw/mO0/wNbMMl1FaFScD3ywfxz/S1H3lp8FmYnQQ/aAHAVOwYPJr7vuTYDZ4i0BgpzwMbgai2ZfEXKEswZVNfJFcUepfgsFQcUGhwrbNKdSOB+mG0zRMQ7CHqG75uyEzYzFcrRK5hCnFGqdJdqbYkAsbHcfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JarX0xlZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4266f535e82so1749735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720457379; x=1721062179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rp3R4cib1Zeaxm8jFtF9C6khZfb6CGKVgyOo5y3pEDw=;
        b=JarX0xlZfU62RV2K3VJZJ3kZn18cZeLZTK04ZSh/a0Gw33MlnHHvmBZ9ruZ1zknyUg
         8e1tK+EnB6MaKfmQBxt2Px7fuGuu67lC3htV5lI8UIxqFxWD/WNyvxSERySAl+hbdxgr
         srE6W1w3n95VMzM4yIWvyCfNrCEsmvtpk4786PGnFLU609bux1TKQf3OmvNdgIC+xE+o
         Z0uQJsiQEizTxLQ0TkOvWSEABm+ZEEjz/HqQA0Q4FnraHNZpEb0QnSYayTJzbyQMxohh
         f6Cyeii8WwGHsxZThxR0uvCCp0Lbme7jHcoouETvo9agTdrLhWjKIwdeGutt4hr7Iuta
         UEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720457379; x=1721062179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp3R4cib1Zeaxm8jFtF9C6khZfb6CGKVgyOo5y3pEDw=;
        b=d1YdZYaEvTyW/400GsX20Pre9VXTBpmv5QfVFkk1d7qUhMKps4zataZAnjRM0pljds
         sPO71tfXy75V94vs7TilwiJlYG6LUKywF9/fGFJmQEe+miCiDK6wiNy+R4DPbDpO1W7c
         5QTu8Rq7FKmOkGITEbFmmZvP86eehRPx6Kk3q8nGOVXNy++tFpekJGUZUdYsskosqRvj
         A+r4fC1IwXTrV1EviFkIUTZ8ulvN7b+4tSW/9hihhsHP806cn631U1L4TNztUhnl0YVW
         5Ad0F60pvdjDbjVxEwBb6NyAS/J8A5njNUcuLYTqZyahWBs7P6Ma78hrQCW4Tc3vUwiy
         sBDg==
X-Forwarded-Encrypted: i=1; AJvYcCVgT1aq+f9yOs7oDJJG/mouXulblA1BTIZjV57WlJDgswxMwjJGRlNgmSVErlxWxSqihEiR0GPCXhA/pVJhh9kqFC8FuFyDEACNtH+b
X-Gm-Message-State: AOJu0YxaKVhqo2Ib2hGCCVRV0K+pVnQgrkHZ/BrBLVDtw8wWNph35svU
	l9NyZBClmxV8TNCxQCYS2fdZmpWlzS9TD4PPffoVU7UeIR/4pXIp6pvKJvPD+Nw=
X-Google-Smtp-Source: AGHT+IFKead1I13aWVfFHtBOYYoWJyJxwmMF203zfTMM0cnTLZDUD7Yzpi8BOWx2qpDlTcn/ijTd8Q==
X-Received: by 2002:a05:600c:1587:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-426708f1df1mr1071645e9.29.1720457379381;
        Mon, 08 Jul 2024 09:49:39 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cf24:cce:17df:12ab? ([2a05:6e02:1041:c10:cf24:cce:17df:12ab])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4266f7361b5sm5261415e9.29.2024.07.08.09.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 09:49:39 -0700 (PDT)
Message-ID: <2b946a68-dcdd-4a1e-b7c3-416725033c2e@linaro.org>
Date: Mon, 8 Jul 2024 18:49:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: sp804: Make user selectable
To: Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ross Burton <ross.burton@arm.com>
References: <20240529-arm64-vexpress-sp804-v2-1-c542a80af33a@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240529-arm64-vexpress-sp804-v2-1-c542a80af33a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/05/2024 21:48, Mark Brown wrote:
> The sp804 is currently only user selectable if COMPILE_TEST, this was
> done by commit dfc82faad725 ("clocksource/drivers/sp804: Add
> COMPILE_TEST to CONFIG_ARM_TIMER_SP804") in order to avoid it being
> spuriously offered on platforms that won't have the hardware since it's
> generally only seen on Arm based platforms.  This config is overly
> restrictive, while platforms that rely on the SP804 do select it in
> their Kconfig there are others such as the Arm fast models which have a
> SP804 available but currently unused by Linux.  Relax the dependency to
> allow it to be user selectable on arm and arm64 to avoid surprises and
> in case someone comes up with a use for extra timer hardware.

Would it make sense to add the option in the platform so it selects the 
timer ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


