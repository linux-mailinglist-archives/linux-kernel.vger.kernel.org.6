Return-Path: <linux-kernel+bounces-374988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E49A72DE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923C0B219F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CD11FBCB3;
	Mon, 21 Oct 2024 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v/MiqTyT"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF31FBCAB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537388; cv=none; b=sdZYU+VOfg5GZZI/1i5FCJmwJSVxv1njzXSkJkhp3YqcXLIGgsZ5eBUsWZeyUzgz+KmSTVTpM/CFFreMCdJlvsek2NWu6DSFQHyQ9xa+lmEn8ni9xrKA2uz2LtNVcvc8ME2A5eJaIfK0huPklrQCFTRWMnw4qK4ia4RKe4M7ZFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537388; c=relaxed/simple;
	bh=LODD5aIjCy0vXXpBJmD6sWkaJbwO78xoBVCR+mjYBM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fs/QgIJoh/ZRHPcyeBbX6LtWUFLD3TMDoda6xv6kw+iLtKZ7Ss29nYzlZTdjQOulN5/+xgV1vartfHPQWTyAUa6bEkNbeZRjqPGf4e6Gx49v8A+LyISrUNBeQX2sRxB33Mula9+9Bm7QZUsm0ceWmgeH9r8ZXzweBpSaijWqyI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v/MiqTyT; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ebbfcab9f4so811035eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729537385; x=1730142185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QE97s5W5M1Y1wOsbZgZtxmFuWdto5fcKTbIB0ICckqY=;
        b=v/MiqTyTf1/f1QFMnhUqUuMdDO1/Z6pIvEH3AhM5H0Oexhd315oXbV6NGfpW7+DruT
         6W1VK3hbt8pLh2MuXV9UluAzhw0ryhMXAwEnlHS+opbGDBGWPYOMT5+fkjyaKv9wDHHd
         hGaRuksHZAnh0nXWea0G5AVwDhDmZEpxfIzqDbx5Rkd6Mq7D8BfVAm8H2u9TDipbVWJc
         C2e1zEO3oBsBxCf3hSUbsCC+m4/5+H29UUgnIndn0gwvNzIfgRRGK+vbVAbti9X949Y1
         KHl5MxEb2n9YRHwHoiFtFFyl1b4TrQH8MqKC+lVdt03c5OiU4o/f9jR9Z/XOZ6iUf5AK
         viFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537385; x=1730142185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QE97s5W5M1Y1wOsbZgZtxmFuWdto5fcKTbIB0ICckqY=;
        b=iUQaXYjEeiaQAxc/mHweSQy9NZVWr42t+oe9mRThVraKQBospBgsKEZJ4DUyeTAtk3
         99c19ib4B4AAy2FHcjX+J0HmwWNpagzPPgkBy9zAGN3C5rsD74qjkeaDB5DI+vBq28SD
         clMZTJ+bcQSZd/QqIKzpUG8YtbHQ1nwNA2HQcIoq6OljeoWZrV8po/Adr+KbTLOySflI
         fW9DOaT7FrldqYGvpuoucB75A+blZHDbflMcr3yOFn//6iBv3macqArIYLwVQvBhhg6e
         K5BykhlZlCDFPyDfZJ3sfq1shsj2ZEgHV1k3aOma62GXJyjrufrXAOjrys/nadxJFsfC
         Gmlg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ3mR5ON/BRQ+DKRzy/NqsbWyriQx6EEJCICydu7KtD6+grTxq7pc6bu2QlLdlyuHjXqjg6lQ2+Q9UVxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxllbDnkURL5iEwu42uQXCqdR+dhYp0Le6t7jOM2/4AsuytsBf0
	JRmG8cTho5GtrDdxcQ/qEmZAjeCcGkTMtkJ9JIAojWyJqxMHYozIdrJ6nOi24Jo=
X-Google-Smtp-Source: AGHT+IH1xpgA/kOZJWYGBwISqeSDfG6sU3cpBsN6YG6vC9283k8IYCQM4h/E8Bn/DQhe+UrDboQVbg==
X-Received: by 2002:a05:6871:150:b0:277:f14c:844b with SMTP id 586e51a60fabf-28cb0108483mr87125fac.37.1729537385115;
        Mon, 21 Oct 2024 12:03:05 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-28c79250fc7sm1251661fac.17.2024.10.21.12.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 12:03:03 -0700 (PDT)
Message-ID: <2842cbb5-680e-483a-af62-4c08e7818a85@baylibre.com>
Date: Mon, 21 Oct 2024 14:03:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] iio: adc: ad7606: fix issue/quirk with find_closest()
 for oversampling
To: Alexandru Ardelean <aardelean@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 michael.hennerich@analog.com, gstols@baylibre.com
References: <20241021130221.1469099-1-aardelean@baylibre.com>
 <20241021130221.1469099-3-aardelean@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241021130221.1469099-3-aardelean@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 8:02 AM, Alexandru Ardelean wrote:
> There's a small issue with setting oversampling-ratio that seems to have
> been there since the driver was in staging.
> Trying to set an oversampling value of '2' will set an oversampling value
> of '1'. This is because find_closest() does an average + rounding of 1 + 2,
> and we get '1'.
> 
> This is the only issue with find_closest(), at least in this setup. The
> other values (above 2) work reasonably well. Setting 3, rounds to 2, so a
> quick fix is to round 'val' to 3 (if userspace provides 2).

This sounds like a bug in find_closest() instead of in this driver.

If there is an exact match in the list, it seems reasonable to expect
that the exact match is returned by find_closest().


