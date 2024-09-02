Return-Path: <linux-kernel+bounces-311356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CDE9687FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FAA1C21C33
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D149185947;
	Mon,  2 Sep 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kX4phIEd"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F1B19E99C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281635; cv=none; b=PdhJBbdibPKGwFnJkamkvNiqOz+zSF8RNToKN89Ndg5KynZRTHjuHGl8KpPYdU/SG8Mf4M+ayHDBr3fgws44YD1xMHMSCuSr/tyR4V1pYqhZhfpMHW9rR/oJgTFgZ7IILxsZycGG4P2gWhPxXG8eItS8Ao/o0c7ctOe7LhzJNz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281635; c=relaxed/simple;
	bh=k/rqK/fsyAAxu01hLM+DEkP03vIbUpsf+yI4TuJVRt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUpSOt05rC70csgRSVdGZhg2dVQ2/Q5Ble2D52FNSgyL0DZXcL7396O7rINHVwBLQr2pfJmBc67/56fJ8KQ78+s8ZSQJyZA0oUx7lv3PBNRBqsn2/1/IONikvZxZ1rg33sKuNohOT5/1WsjqJpJrHChWIbx4P4GJoOoaUIoV4Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kX4phIEd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42c7a49152aso20831525e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725281632; x=1725886432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYlJfld1OvJo7FXFpNVhWm7SC21Y/tMv59WgvqIWK2o=;
        b=kX4phIEd/enC1NTmxWfXemtCz0Yzbu4cr8KxogQzuGDNxjIAKzmQ3DX32VxISpYbhe
         u+Ctr0BcrXy9SUYZ6mAbT+qq3fw85/h0scRp4ccrnQ3lmBJt/4H1AirQ2WS1c0blilm8
         oNskENj7viCUU78FWdAiqqgUHCY6abY0ec010g83sKIxd6gXhmZa3/Ec/BQiHuFUQy33
         9wcdsq5vy6ShWY9kcS/oNoTFbAal0mAMQor91u4BFNfv1vu9yfwmryuhIx1EeV/kUP/r
         Zp6sIZL9XjDYSwOUxelNEPRvIHcv/H7BBzh0GpucI5NDzhD+QPJ3DVSD8P0qHWN+3q8u
         EnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281632; x=1725886432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYlJfld1OvJo7FXFpNVhWm7SC21Y/tMv59WgvqIWK2o=;
        b=J2fM6LDB/nOwKpDKIOGZMaU0aI3XoqI5NwRkHLiuKvi2jxz/sgA8IuJC1UDOH5D71D
         e1Z7pcjq+pqEhMgjRyql+d9eyZ69n8W1XYuJwDPhNwQv7lcXoulQiEz2RqjXuA3HQlyy
         Rbq7QJUGmqcR3faDOR1Tx5pmEBaT8E9iTpZP7AB8xTygXi8V0ufnpz2QeYkiJbQraQI6
         SKG9iySIt4ex0PagGpiU2GgsZHu8MtQm/ve9+DHr1DLLYmfLmZEeUFKYKUs9JOkf83DD
         4OdBVMzmKpowweASzf8Dq7CSbA9sWFbFGNmkL0YtOc5T5ik4ynUHpQa8hHbjFU2zHycK
         7jGw==
X-Forwarded-Encrypted: i=1; AJvYcCVrCKt61S9OrDe76ef36pkVwNaUDb3b97FbdaLXW1mW60znNHKdHbQqOVfFKBPuMDdy7luzKaUnvtwxwGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLKbYFoevkAEEPalZrOumSsnk2utY2UQD9H+YvvvawHgKJBLs2
	NvS3jfpUvNwD9ers0KOtXxqs57vwTOXqMrG9iEy8YH8eT0kpOeouLg+z6zbo5s+27qJxkWbWfYX
	A
X-Google-Smtp-Source: AGHT+IHdiaq9foCcLMZVQVOKflL4aCKzsVoXf1uFuakGM7Pbj8dkiE/ZKrcDDwoeGEvsoy82V/DI8A==
X-Received: by 2002:a05:600c:4684:b0:426:593c:9359 with SMTP id 5b1f17b1804b1-42bb020bf2fmr147345605e9.32.1725281631455;
        Mon, 02 Sep 2024 05:53:51 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bba3f2875sm116718355e9.41.2024.09.02.05.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 05:53:51 -0700 (PDT)
Message-ID: <98d86d3a-833a-4eef-a4c3-d7922e5841cb@linaro.org>
Date: Mon, 2 Sep 2024 14:53:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource/drivers/jcore: Use request_percpu_irq()
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>
References: <20240902104810.21080-1-ubizjak@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240902104810.21080-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/09/2024 12:48, Uros Bizjak wrote:
> Use request_percpu_irq() instead of request_irq() to solve
> the following sparse warning:
> 
> jcore-pit.c:173:40: warning: incorrect type in argument 5 (different address spaces)
> jcore-pit.c:173:40:    expected void *dev
> jcore-pit.c:173:40:    got struct jcore_pit [noderef] __percpu *static [assigned] [toplevel] jcore_pit_percpu
> 
> Compile tested only.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rich Felker <dalias@libc.org>
> ---
> v2: Also remove this_cpu_ptr() from jcore_timer_interrupt().
> ---
>   drivers/clocksource/jcore-pit.c | 7 +++----

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

