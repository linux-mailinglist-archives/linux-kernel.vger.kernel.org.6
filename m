Return-Path: <linux-kernel+bounces-570363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0E5A6AF61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46CE16BE03
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23722A4E6;
	Thu, 20 Mar 2025 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LvCtxvMI"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5067422A80F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503688; cv=none; b=ulMXslYR6FCok0FIkmdrxwQNlIQGohxwaHojfl9ykIfJUX7gT/ZSaz+TrEokbsn+7FeJ8aUNWeI5GcEFhz6k0bK7tOPmgeH90kTML+jf1oyc8E7Oda7kIceCQUeSK86q7BQ4qVaBJUlEjnOcV+qiKnSYnndxmOxngQfBgjXz17g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503688; c=relaxed/simple;
	bh=w4h+/8fL9J+p9KQSOjGKVkQlxbicGt5HKPq7/GWmc/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+FzoRmmD4wALekfjgVy67+AY+r6MubIxd2CcA01GVK8QQZn7YaduJRwGpniINWModCMeJhakG7LGkTf6riAhjxnHmg7DnVEA8cXvZTgN43zdgPNw73qdZ9Rm5utpL5vjaiH97/1qfGAjHJVPfjH5EJ3YimnSzEkGTTIPjDhIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LvCtxvMI; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c77f0136e9so95866fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742503685; x=1743108485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOIKlzsIUoqxD9nEckILpbLfS+//3DA7P6FxcgFgX1I=;
        b=LvCtxvMICD4IOByaajO/ZmOevSbJlryjl5iuxcnKIQz6Rb1XO9TOBksx7Jj57gKNVm
         rfRuRLYqhMCVL0upmDT8FX4tM18QP5r/8rcjKrnFrE95rw/lBYIY7XJuqoqm1dKZksMf
         UlNBG/s2r5GBOWc9JG/6P72xysAoUNsaWpZMiKhqLktYhwCgq/C0z/U6N563k1wUqHBt
         +4KljHvXO3FThxYrNRG5W1dAVTUEy57bwQp1EXXquf8uRRrQuLOoct//dljW4CgR12nx
         zfkYl9zCSVEBrW7I0/Dk5SWJBkGxV9xqogL5zYVgyFROgzNJ0P5flyO0v6WzKk3hBHXM
         zy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742503685; x=1743108485;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOIKlzsIUoqxD9nEckILpbLfS+//3DA7P6FxcgFgX1I=;
        b=kObJ4FmK9CC5KpEqqP8XCnSUjvcAk9yxYYiO4ULYU7F+S0XFqb4wwcEZZqVFkGlLxA
         UIG0MP4K/JdVWv6gPR2uiFpaEMB9LpzTxLRCc0qRLmrMLDWmHVt4/burU8mbIhVfAWi6
         qMIUuXgGfn0mfgvu5wQtUyAffXqYSX+qsqG9pSzVlCpvT4XpUyy9E5TVYtXCKLl+x2oZ
         GH11uhG+MTV/iA+Qnx4KeDsXC+bYuKZ1HxlJXu0ZV0r4Ivr1J4V+x1IgFoniV65yj9ds
         B+Z/b1M82mVVOW9bDhgjGywGQfcRg4qfvPufWi3W4Rk8lh9Ms0vxS6anwx6sfwk1WG8d
         lyWA==
X-Forwarded-Encrypted: i=1; AJvYcCW0YjoIYFMSBR7Yak+InFt31qZUQcDwQiCG7ehcX9qC6xrnkw7yfzwtmlj+Jk2N1cr3d6Q6oqQLt455x6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtqRWZxOEq80HVHdSkaQzjbxEu0KeLQzK9lM+6QYibb5FzBYX
	fuTv+p7muTR0oy4LT/qzWbYTYdpLz3kDmtzymalNvGwlOhuDjBCsqHbEuwbucAI=
X-Gm-Gg: ASbGncsz6OYfcwow56GyJ8J8+3kzbzo2zK3JG8v3SNyas+90j2ychKzjmkR4apJwLk+
	VEYnTvitZTWRYXce50uwFo+T+b38p1S7VYjDO9HptvGb+VqViOgxByz+WudNpGgbZBVRVbbJHp9
	W+OhssNz1IJxu0m31C4kXTdL2NBB8sSJVp40x5I0wj9HXQFqVbKWJhdYyeBVD+ID1yqioUh2QRs
	EQRAsg6R7yKYqNxF1kcQXeEy9IQwHXgIMoCZmFm7EVQxM94xU2ZxNmoQfVq9NjISiPbClUoKbs3
	NB05TGQRmeW02fDZn0B6MR8Dh5T6+KvWK6XwLFUT0XcOP48c5DzAJP7VHo8Gxx8yaDv8mSXNhzo
	x5N5idg==
X-Google-Smtp-Source: AGHT+IE0vhpxH7UDXDB9KJbEa1T/74UWrlWb1s0UUKXXPblhRsfUxYaG9aNkhXf3SmFfKn141a/Obg==
X-Received: by 2002:a05:6871:28d:b0:2c1:62e9:584b with SMTP id 586e51a60fabf-2c7805b2ca4mr626009fac.39.1742503684988;
        Thu, 20 Mar 2025 13:48:04 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f05ec85sm132955fac.32.2025.03.20.13.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 13:48:03 -0700 (PDT)
Message-ID: <fcbe9c0c-b088-4115-b5c3-8e6f8a0dc961@baylibre.com>
Date: Thu, 20 Mar 2025 15:48:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] Documentation: iio: ad4000: Describe offload
 support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
 <888928d2224f5dad03a86b7108217f7b4b078979.1742394806.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <888928d2224f5dad03a86b7108217f7b4b078979.1742394806.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:58 AM, Marcelo Schmitt wrote:
> When SPI offloading is supported, the IIO device provides different sysfs
> interfaces to allow using the adjusting the sample rate. Document SPI
> offload support for AD4000 and similar devices.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


