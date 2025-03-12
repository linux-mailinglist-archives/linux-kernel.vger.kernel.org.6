Return-Path: <linux-kernel+bounces-558088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C338A5E175
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FAA19C1112
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9251DFF7;
	Wed, 12 Mar 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsCGXmXL"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DDC1BB6BA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795705; cv=none; b=kHU6jIouIP3mVfEz0waHecUe59WAZCunJziM57BjgnMwebnp18GeXVo/qBedWJrLwXrE3noMa3YimvcxKyrVnZbjB0sEwWUj5nZ6KjsdoCZOUna7HEVWdOJ6wDulrThXOJxhf0dOM//CU9ZXQLUbiO4W9my20gZNV+uVsXqxjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795705; c=relaxed/simple;
	bh=/l81mkc4n15BgZGzuE4Us34XgHcjyXIkl5hqU1q+Oo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahOL9Bd4MPBcJSpT9qiNcJC87Ae/OI5qVdgZLUQhwT3GcCjBtfRu1amr4YnSuYcDEF88KC5xxUOY4N6E44u5bFBsZQaKrvQmYqbNgqvcvzTlGXOoiZ0bIYnVRiqNkF4BfAwlhj1Zt5I6rICw8l0+nIXIrDpx+TTBI5tsfk9MzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rsCGXmXL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso35502765e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741795702; x=1742400502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kRABI63t00ZhwHPnXAq2zHuyopqgID5ECRPytCo344=;
        b=rsCGXmXLzu/bprVNKhb4LZlry8lLTQOjhsTSTEc24P8xM4uyfaTuyO+5+HNnDofwKp
         PLejQLSQJ/jLXh82TzAm5XNxYBJdGuDrAhwd0408pEiMavOzistsb5j45Ug7UYWATBpT
         sKhMII+Akt43jRry/Y3LyCFPmNudCrJUpVreLenyPb4n/finvgvjXmCXrCudXWen8Vyx
         0dLpVIq2yQXxFEQZdQvORlD5VHpLcisJ03vJxYLNuKrsgO4nRnojLpPCiHKhG6w1N4pf
         fBfDYyJf1rV0tuEM4D4fiU5XFFGlYxSDYGkid448QCYD5FVlRSY3pF2GBsjFiAmXh7hu
         IKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795702; x=1742400502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kRABI63t00ZhwHPnXAq2zHuyopqgID5ECRPytCo344=;
        b=ts3ujpRbsalCYJ4RHfuSj/o1BjffB0cCA0jW//iDMRaEc9YNtIczpEsb7z+qVAh8pQ
         h9Osynhw0Q+qaMeW/PI9yDJE8WtuCPzVqMk6NcasYQWqOVE/yP1zPu7ad+HU89bgveQH
         eO4dtkB0IZiD8jalBYMEbwtLJYpempAG0q6PlJMotNe9H+oShiQD7U3cgcWPaDIOZ20p
         /D4KYg3MQiRFqzP3UA4Dw4blye50Tf4h2hRFWNYeciakFy5txMRaLkgty+B9k1Frc+o8
         C/ruKxiLvtdt6JH50CnE0AJyrn7SemAjObd0yr53z963ktIQuaqQDKOdKKH0UHJS4mu1
         NAIg==
X-Forwarded-Encrypted: i=1; AJvYcCVHusg8kXkOlz1+qweBSSmwgYoQPE/Zi8pfG8lac7kVQsjXMoOsVcPZ9qC6dqT+II57fG9J0pHOOpwlM/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfsHf/6fQse8Cn9SilPWyaxOm3pcXVmtDuGmy8PsePhsalKDs
	ncfJguesn/ZXwHNpfWZR2lYxtuPaN7rSxUEVh5VSE+RF1DaC872qUo3jVybpWqM=
X-Gm-Gg: ASbGncupFllmDskk7Tk7si+w40NyGsYn+BcEGQxMKiUGt/gPdekNh/6HowD2rTkVdLt
	76gJ0GOq7HU423A+snv8rzdxHAv635NW1+vMTFMqum5LATwZomwybDvIu8IXwu7w5t3HuaTbXGK
	DhGKcMzuS+Wp0jhNmyzxTbKaZVQCZoKA/057N9qVmBw9LZpPrFG5aNEnA0Zm1XWlKqyMqhCgQ+U
	JYBocSJ2zYs6SqqSGn+1qxaExI/bThrxJErF6UcQMlUe8jSQWLrTcKLVvt/KEkzOdf3IOE0bvlc
	r0WbyKmgM+0sEJJCA1bj+K6ZDm686OTDXkeIaAmGYr6CstrRhcnVc1AUFD6UN5MVhkdS6ZLF4rI
	DHJ4lFlPV
X-Google-Smtp-Source: AGHT+IF+4mY3bB11AO8af31IGQWD2xZOhSkCDSiLj78VIR/ojQV2gPQFAWRE0UoElYony/PXJed0CQ==
X-Received: by 2002:a05:600c:1c9d:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-43c549dcc0amr199565905e9.0.1741795700168;
        Wed, 12 Mar 2025 09:08:20 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d0a731265sm25382605e9.4.2025.03.12.09.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:08:19 -0700 (PDT)
Message-ID: <2372dced-c786-4699-9317-2ebcbda1b0cd@linaro.org>
Date: Wed, 12 Mar 2025 17:08:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/qcom-spmi-temp-alarm: drop unused driver
 data
To: Johan Hovold <johan+linaro@kernel.org>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250228082936.5694-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250228082936.5694-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/02/2025 09:29, Johan Hovold wrote:
> The platform device driver data has not been used since commit
> 7a4ca51b7040 ("thermal/drivers/qcom-spmi: Use devm_iio_channel_get") so
> drop the unnecessary assignment.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> I noticed this when doing some rework for pm8008 last year that I have
> yet to finish.

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

