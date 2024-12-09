Return-Path: <linux-kernel+bounces-438068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDF19E9C5C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16735280EE4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB1156F3B;
	Mon,  9 Dec 2024 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHZm+tcd"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F612C9A;
	Mon,  9 Dec 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763503; cv=none; b=W/sRUorWVkpIEGNVa8Ckln34SBwmoQN6pL6etBhJgtPu+ysaVGGPAv1gZciL/pFjItjl/fh6LMoz9ud7h/dSt1LzKAKbHkwo9MuufXIud2M/O22y8zYNVgzZLyTIQ77XKNuRLJn6BQ3X8K92J+6cGrZn5+DcE9vaXQcar8NVpAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763503; c=relaxed/simple;
	bh=YUj7Qg5/fJrC2XlqZJm7bd32RtgEwrCX8T75T9yYfW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=adO+TdKKr9hRpIsnZCwr6w+SaSZ70A0yUf/mVCqiVp372drWYJIj7Y14bZvvi4T/JC3unooxzUjnLjRb1988NY1aU/IecEyMMqlTIJ9dEd3zAhfvVyWhb9p/ycA3WuWdzVXnpbw/aMU64P0VMyGp0yOQliEFWuL6Loi0m/7t97Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHZm+tcd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21636268e43so20539995ad.2;
        Mon, 09 Dec 2024 08:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763500; x=1734368300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+rYfOh/bW/4Ozr3Z/h2PSmrT5udkBAtA23cZGYKRxQo=;
        b=GHZm+tcdPns0MFaWj2vShs+SH+dohqOHFoqZ91zmRIjJaOo+WAduc9I8gdwo74/kpl
         2aUkX1oeRo1kD/FuBiGLY3wPWXQhKoRwhQtvlTk7un+UOkkaDWQB/7qp3VmAojHqemu+
         RXvFj1KiL7J3ojZvZ2eJQNHGu5Ia8j8htnh9mlpM66+Ube/d0HcmkCgxYRvG9GjhaEYk
         Ofiw2jFmK/oLUZ4ClFrmU8dLzPEqVl2X/7rNiRaq7HRcvsqHxL4R0GG19EaR5jdi5hYu
         HIoFlrT32IaPZ31YisaoMW2agSZwS0h6jcz57lzP9k3xApxc5Jo4yNjXocIlRhj4d35X
         Oisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763500; x=1734368300;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rYfOh/bW/4Ozr3Z/h2PSmrT5udkBAtA23cZGYKRxQo=;
        b=wVR2excazT2TVTOs+xz7iLp8GzcC3Y1oQ5eBOZESlUx79CKxl9raS9hQEFg1PciaWf
         +eyssCmJLTUUcXz/cM/1rd8/kZSfPNEUtG30NV1Ove+3W9+q9L+/LpAOVDFr3/rzRfDG
         kRx0YLrqAn9ysmIA/Lp4ZRIdqPv4cRvLUbrtYfyU1cVOmaXtrooC5fx6sUwpe3XAEg30
         jvGfO9YMhFPb8DqWHctGQdlaQFw1+ml7ukKhvSxw4e+ldV6ciR9xrQSol8fl3RfKy/oF
         VobsrQWzQ2RT0lCu9YFtgoaMv1Zvk+ZTkp7eLgOiBgNfJqB5SzTgNNQNtuDiw8rcJbHF
         t7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXTPd9bBTnswsY3Pby3niMGVod42yAo52Qg39+UlMwd+GIZIVLrQiPEX2mzOEDmVvQEMlUBGAPlFVcr00C@vger.kernel.org, AJvYcCWTEiUsWGY3haVf05d+K5XRiCIU7rDbm00MvTdEa+uvxKa64SNDh1qr/se5M7GxmEWaVASnHYEK6qs=@vger.kernel.org, AJvYcCWjE4ZopIOdhoI7ON6+WexKLYJj2kd/zGuPCl5SHISPCu4K+GkTiEi20snLcxiGwY6J8NLba6grqwqXzRA=@vger.kernel.org, AJvYcCXIQclXqwBHnra1OPMbPGbtjmHWmRcJ5bVNvmKHl+9NtHV6N7McHy6a0Nt1v/5EuxN07pB5RB9ldsIKgyAJt4iId5uZjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLegtVgxosq/zk4BB3rI7IIT1FX9Xay6RZPCXhxLwxsyPiD29q
	waHBsG8DsO5vBROxUm30OQ9RICEWLIlqKc8A8VPuUuxtBWKsDh/2
X-Gm-Gg: ASbGncuMT9g2tU4l4rz8Uma7Qb2kjzfxNFQ3ElKoazrgkv6BMefZYGI/iPfZdXYbyKt
	aRNmHHImBhZzPHtmgfQxGeqkCZVVggXv/hHp0D7OaPQs4iuNmHKukChcD/0TcFcRaN/bbK2scjy
	kqBz6Yf8DiO9gOOzVBbFNGjsaNX1i3DNlJO1jmnm8CZB+UcMgPFskYkH+zuDvhFuymM4WDn6LH8
	va30QDuSo1Jv1Y1I1lgV6UQjgaWSKAViz1BZva/b+34AlRM+UlFiByeoIUTIhQAs56F9hftxE3G
	jSTVxYD6jr8MJgzlvRbV/JE=
X-Google-Smtp-Source: AGHT+IG1okg2U/sHeu2eM1s7++hO3cgqOlZEvvf+0ocw6eYLyLL2Uvq4UdnhqLacC2IJoGZEqv/AdA==
X-Received: by 2002:a17:902:dac9:b0:215:620f:8de4 with SMTP id d9443c01a7336-21669fc67b2mr19332495ad.2.1733763500399;
        Mon, 09 Dec 2024 08:58:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3ef29sm74899105ad.50.2024.12.09.08.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 08:58:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f8db26af-c6c6-478c-a69c-0bc811e0b59d@roeck-us.net>
Date: Mon, 9 Dec 2024 08:58:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook
 driver
To: Joshua Grisham <josh@joshuagrisham.com>, ilpo.jarvinen@linux.intel.com,
 hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209163720.17597-1-josh@joshuagrisham.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241209163720.17597-1-josh@joshuagrisham.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/24 08:37, Joshua Grisham wrote:
> This patch will add a new driver for Samsung Galaxy Book series notebook
> devices. This should hopefully include all suggestions from my original
> mailing list feedback thread [1], as well as a first version for
> associated updates to the documentation, Kconfig, Makefile, and the
> MAINTAINERS file related to this new driver.
> 
> I have tested the driver both using m and y in the config, as well as
> with various other options mentioned in the patch checklist of the
> documentation.
> 
> Other users with other device IDs have also tested successfully using
> a version of these same driver updates which I have maintained in a
> separate branch of my GitHub repository [2].
> 
> I have made an attempt with the coding style to find a balance between what
> is written in the kernel documentation and what actually exists in current
> x86 platform drivers, but any feedback on this (or anything else) is
> certainly welcome!
> 
> [1]: https://lore.kernel.org/platform-driver-x86/CAMF+KeYus9dW00WNJMLVxLLHdG9JgCfrGJ491fu7NM8GAEqqCg@mail.gmail.com/
> [2]: https://github.com/joshuagrisham/samsung-galaxybook-extras/pull/44
> 
> Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
> ---
...
> +/*
> + * Hwmon device
> + */
> +
> +#if IS_ENABLED(CONFIG_HWMON)
> +static umode_t galaxybook_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_types type,
> +					   u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		if (channel < galaxybook_ptr->fans_count &&
> +		    (attr == hwmon_fan_input || attr == hwmon_fan_label))
> +			return 0444;
> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int galaxybook_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +				 u32 attr, int channel, long *val)
> +{
> +	unsigned int speed;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		if (channel < galaxybook_ptr->fans_count && attr == hwmon_fan_input) {

Why is this check necesary ? The is_visible function should have masked it out.

> +			if (fan_speed_get(&galaxybook_ptr->fans[channel], &speed))
> +				return -EIO;
> +			*val = speed;
> +			return 0;
> +		}
> +		return -EOPNOTSUPP;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int galaxybook_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
> +					u32 attr, int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		if (channel < galaxybook_ptr->fans_count && attr == hwmon_fan_label) {
> +			*str = galaxybook_ptr->fans[channel].description;
> +			return 0;
> +		}

Same as above.

Guenter


