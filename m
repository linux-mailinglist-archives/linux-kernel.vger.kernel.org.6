Return-Path: <linux-kernel+bounces-385247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C6C9B3487
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0354282942
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B5C1DE3B4;
	Mon, 28 Oct 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gsVmE8zJ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79F1DE2B5
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128468; cv=none; b=GECf2yDRZaN6JWv1AgsRzjyIjYl3yndhE6Xlr6w7650fH2JCMqETDikLVCn3sN86fnFVX3ERqD9FEdFJXqZ5vI/HMzMZKe/Z3+qti0CR5nsdt273LWM0xvHrVZ+Ycq4OzE2p4zNV0fgPYzJPXBKvzgYLxzqIivnkBKOTO2xmNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128468; c=relaxed/simple;
	bh=LoUG+WushGrhUtTjBP8q+hJXMFnzURSlog5LVeeUqdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTD3ZF/JNIhtXaXIXvCCQUaEOBZ1a7kA79leGyDuSVAkp6tGRFBebeB1jHkTzOULPWXRkBMLF3qiHaUogqYY/lnijr3PK6OHb635BiP1pRfJdkABiorAD5mbbOIuBoRB/YHdcTvYLFOHDvOMYssgsurevQ8ibX+x6izeFWljPow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gsVmE8zJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4fd00574so2792700f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730128464; x=1730733264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S14Ja8TvpYHg5GWG8LhAgryrj3IOiPlZfsRPSr2ffck=;
        b=gsVmE8zJMKOBTKmYhpEPJLerFtU7moxjg1+8mt4uRqfDndNj3+YSAsM2DwFqXFmirs
         bhZJb7ckU4KuLbC9gh0zlaUQBNlEtQFqfjIkN2OWOgvNdznh/fDvaLRW88zCGoWy/HAU
         mrb0FoD0XHYctmsPJCA95CXdbgRvfOr/oWAl8RSj0UZiFjQannmm4s6qJUzd7Z4z0NwY
         K4jvvPqeaShG8YJMXkjPm0kfnBs7dmXXE3QjgTU6YrLVyU2kHTKS8oiwWpDoDOdZmKlq
         t+JnLyLYyD79xl2F/l89R14nb8u2S81druLjhjMrctEy7HoOG5wXDnWQatRwV/IlEJwz
         5t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128464; x=1730733264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S14Ja8TvpYHg5GWG8LhAgryrj3IOiPlZfsRPSr2ffck=;
        b=Y5SZV7mF10h3qA9emaiV6FxdjEhRvzwF2q2RPB5qpu10Ly5eLE/Huf1lUmGWCW/udn
         VbsTan4pKjqseV39csk+adyJMcBtfV+f9vsiFxpUCg7LWBijsiRhhNSXA4zTkI2aM/UR
         8gXsPCTGU9y5x0y9/G8D+IefuZStMJEabrJG3f8eM7epFFXlPjOchJKKemETkrFWLQRV
         Iq6Fb2t5MFGdy76RDijf8UfZ5WHXxaQGG7cLgJ7cNmH2GpnCFwlZo6yu5c6+Zrge6MbX
         irxb6qNUWYfLrhWRLSoG4gaymLqU5KD5U764Zkf+7WdMPM5YIJ5kvbvfIFR1p9CvM9fF
         rumw==
X-Gm-Message-State: AOJu0YzrKGxejn3IQVC3Ydfd3n1KhOFUsR1rvOrusHHnJyYrDo3GBBe6
	w3ym06P4eqWjDeTb/nzqUKjn0JPvQijxi6eUn+dxjnCMGMIPPXhOVEwNjiML4cc=
X-Google-Smtp-Source: AGHT+IH3+SpiyekJXa7oMk0TmA9cbvjr3oOnnSsLzuXAaTjPZGekOj/z6IeauVg0ZYMXgVk9ARZNqQ==
X-Received: by 2002:a5d:5902:0:b0:37d:443b:7ca4 with SMTP id ffacd0b85a97d-38080e38ed4mr129613f8f.14.1730128464068;
        Mon, 28 Oct 2024 08:14:24 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4318b55f784sm142481545e9.19.2024.10.28.08.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 08:14:23 -0700 (PDT)
Message-ID: <530409c9-a611-4de8-b6dd-0164c1d067da@linaro.org>
Date: Mon, 28 Oct 2024 16:14:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource/drivers/timer-ti-dm: Don't fail probe if
 int not found
To: Judith Mendez <jm@ti.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>
References: <20241011175203.1040568-1-jm@ti.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241011175203.1040568-1-jm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/2024 19:52, Judith Mendez wrote:
> Some timers may not have an interrupt routed to
> the A53 GIC, but the timer PWM functionality can still
> be used by Linux Kernel. Therefore, do not fail probe
> if interrupt is not found and ti,timer-pwm exists.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

