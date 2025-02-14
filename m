Return-Path: <linux-kernel+bounces-514445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0190CA3571E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9ED17A6B93
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26057202C47;
	Fri, 14 Feb 2025 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GTq+bIyv"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3A17E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514683; cv=none; b=kMVc4xqNcd5X2xm4LqEmAaeIA9QeCEPqPRz7/UPM+VCNqkRakUHrHO0KhnyPkKPvZffRkF14VupCIdEe7/Xlxjj1MsSOhFT7SxSqavedUnEhsGoTqTQ0i+DDBeFT+YHc+M0VcTRUCw9DKJ2THYsBD4DcQaWL0SajbJYTGFhueHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514683; c=relaxed/simple;
	bh=bd3Ix1OlxqfISy3/YXIyFe4/qznReagdpNKuiCq9fzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jXLB2Kf8tdzKc+no2dZmbcDQDHNVYN3vlkqN238flJwBAO5aVJi6FFSh7baVQxrqQNe62jlwMwiRsboawTrgzcZl/0qSfhqeK+x9cUIcbMe/KwEKjf4L0dVHYTFbvG6NVldzDvK1KKoBqQrM00IQVbmURtd3kBDdP5/gXPI/QWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GTq+bIyv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dea50ee572so2465748a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739514680; x=1740119480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RS4NhYdSKIq0ZCVoddU4UM3ba+/5N5wTfgewbJrHpVM=;
        b=GTq+bIyvVaCw26jlpZ9dhBnWI1Scr3lEuVZhWSEHpar+mQi4qnTNxJiM18DPvM44V5
         vLaw7lAvoZ5HT3MgnNDZ+q8apl0N2jj1zU22I8OME9DaKcylJ6ZnlQj+wFErF/xYxlf0
         hdEKG9Q5ZagUhG2331Ixj6hSuLvKgOUuLP4GFD6J7846BqgHTFxwIyALqhU2rBb6dQw1
         1YHCAthQuli0sOuix8qqKsIbotyIr9QvNu5Ubrl6/0NtYxoTi6FaRsslYgaKK1BAf7ww
         B7xcpEItFgdl8g3zGMsYD09bL3PBGyl2OpQaVJevPjB0hKqs19dtkStQyxAIOs6c81ji
         OyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739514680; x=1740119480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RS4NhYdSKIq0ZCVoddU4UM3ba+/5N5wTfgewbJrHpVM=;
        b=H9nxrKxg/8uQlU9B+6jYw3j/p8jFHUQT9Ny2gEnavGTFZ1QyiPWKLk/KfsI8xXPbCS
         q5e6JcRQu3fN/zJDmc2/Iw0EowSIZYenHKZDjmrX+gUGf2kta62MXn4dO8YJZ6hWMbpH
         Js98U0S0UZifhraP7HaV1xzKA5JoXJ6SE+dleqaSCr3LvFCwMxQX8az8zUNcpdwhPdiy
         R07wyGokIJtwv0fU4lKOSyOLyCHkVFcAkn1uEBxNTBL0+xEadAv7ueis+gfO3MweGY+P
         fy5Fmxozkw7oU3XhzNdJcdcSoz/e7+ScBKmTmKGmnKWqOuS+D1Wfu77ZvcUfv/ky8ViL
         7ozA==
X-Forwarded-Encrypted: i=1; AJvYcCWPkCnljv1pTLEb6ftYXW4VAbdAdCml3u24xwMqqK4KuopvvJtQcdtSA85yzBeUjjRC5kZ7yzW4RnY9jCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFi6mK2JuqzS92Qqxm9GI8lmALz9mxmnWCTWuPNUjT0owFPoW9
	gGXDgWT4mcm9Vc0qKCrP3Ckr93POljg4VwV75v8ULHE788KFo0DaqvkFGPD5fJc=
X-Gm-Gg: ASbGncu58GT7pkWKi7JBp83dkcdExVePf+VZFpLfMFwVwMy/QxM+Pu/ytdS9QuksugY
	8YQ8Ao4JZUC2+9u8Pf3UKqhoTw+jtXSnIuYIBKjldL/d61WaXvcY+DOO4ie6pfuI996xdjzhHZd
	BgbldtbA7LqaDfSmyhJhwAThSMn2WCIq7PjneCC2QXrZL9YuVCoq/oFzGT2i/w3KXWUBieIvBn6
	iII/RTKQCT8Q3JrrsAb9O5xzC1oqYLxzYC2XxlTLHXq6cDZLxyFQexoVYFDNkRU7qaK33s2p6u3
	medZqq6r89IXBI5E+Bzkf6nz
X-Google-Smtp-Source: AGHT+IEN/RRE5hxQ5xNZNtT7rJsPTV3GPjWwm8qrFkScK0MAqhU1b09AXyINMIOW8g0Zg6OABiY4tw==
X-Received: by 2002:a17:907:3da8:b0:aa6:79fa:b47d with SMTP id a640c23a62f3a-ab7f336d454mr924285066b.1.1739514680163;
        Thu, 13 Feb 2025 22:31:20 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece288e38sm2350948a12.79.2025.02.13.22.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 22:31:18 -0800 (PST)
Message-ID: <49ce4bf7-fec2-4d1a-aff0-e342b31c4f57@linaro.org>
Date: Fri, 14 Feb 2025 06:31:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] spi: s3c64xx: add support exynos990-spi to new
 port config data
To: Denzeel Oliva <wachiturroxd150@gmail.com>, andi.shyti@kernel.org,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250213204044.660-1-wachiturroxd150@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250213204044.660-1-wachiturroxd150@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/25 8:40 PM, Denzeel Oliva wrote:
> - Added a default "fifo_depth = 64" to prevent crashes when "fifo-depth"
>   is missing in the device tree (avoids divide-by-zero issues).

no, you shouldn't use fifo_depth as a fallback, it's misleading.
fifo_depth shall be used only if all your SPI instances use the same
FIFO size. If that's not the case, as in yours, you specify the FIFO
depth via DT.

You need to determine whether your IP works with 0 sized FIFOs and if
not, make the the DT fifo-depth mandatory and check that its value is > 0.

If the IP works with 0 sized FIFOs, you need to update the driver to
allow that and let the fifo-depth property optional in DT.

