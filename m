Return-Path: <linux-kernel+bounces-426411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A29DF2AE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D71B2111C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1561A7259;
	Sat, 30 Nov 2024 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l4USdOr0"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432F17BD3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732992644; cv=none; b=N35B1OZ63pZ05IaBGKGe7Igp/2br+9ch/wZk0F+rv5dVkprtizIpU8aCgF5pKFVkg8T7jm30yxVvU1OzA9A5WlDw6s3UC/POegkFNTpTSqfk5y6lf3YLLGyQ+wNQ76lXo7/uBs99LMuez5T4k1EHCcqr5Ll7QRKju1kfae4YwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732992644; c=relaxed/simple;
	bh=QEwOBohegim/6DNi0o5P9p435b9KwpkcXOXYxL1//f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoRRzCi1zDKuE1TLPZkMVfP7Bx1htF8CDGSp8RgpEhVYaPJQkyDvD0uSLl0YWneHWSXieu3xk87cg+zPRUHCL9ZL42s7vsOkvVEmGtY19Fum1AzvpOv3eKzDsjML7ytjzvoI54yZOYDP34MRYToaal7Y5rm6xbnjFBywtc4vqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l4USdOr0; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29e2e768952so833209fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732992642; x=1733597442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I25x18j8ZN6wv+m57NL159iqLWMt9+yWlrxyycszO84=;
        b=l4USdOr0/aWzNAy8FTgxXhc+oxrb2nTALkKkAfRrUUG50RuwkMoEBsTWiKWshpuCUK
         YuC9oTdHLQ3EIOx+DbTmK5fEeOFi9nYnyTvtMCy6eBG942S89aU5KGVtchC+MQntYufe
         mb22FKZYi8Gts9ufmf/zv5slR/CgSLyxtD3i7izpxYAMf0Arf2Q7sM0pMHTtyZU3H0a2
         tiPRzBc+aZIHnRdPaOtiRzcoiyBRX9qwlKhCXECF4+hXPa9jY8iB7mJ3nKEH+DygqksM
         DWDwF8VNo9FYEAGhdj0tTK3cQIWpTKAGomZiKcD5/uab3BvdWAdPD4Kah8AZt3N22b1Q
         n7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732992642; x=1733597442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I25x18j8ZN6wv+m57NL159iqLWMt9+yWlrxyycszO84=;
        b=hl37TvEsf5Zelwj59Yr7WruTCLHfg39lcaBWLAVZ0HUk1Eq0bOYe75tmCBIBVWFf9E
         ijAVz/FWKuAslOg6dl6TEQ8ccmaMllaIwM0vhiXNJSUtO6wlT5OCTX+KrPHm/CgmZTaq
         wkWHSTMiXmtTBIBzFdigVs1qPBWaqMGz/Jq/91yk0MOrRl+MO/bQ0frx8h3s3TJphgER
         wxmlOfwZP1GBGmNlCyPWsmqGQpeNeL477yuhX3Dsz0ZMrilXyjsDjMG0TYVJS67D0YS6
         T/03PIm7qOaK1Fsp2xH8ujebtZjKc3uBQ6/5A8XEyNEt+CNhK2NM2azNpnzenBk2ql0K
         H93w==
X-Forwarded-Encrypted: i=1; AJvYcCVHxICdJWFRVRdFjqxNRRWTolVA32LgLlbXDq3Y75quT4sZ9IBY8NDlhfjPE9jPmiwK3CJzxZBQcQeiOIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB6dXNF6QGDMZizz5N6QFIaUxKc/dwnYKA/DrXwnjLdFVBxx9+
	qhOCEXqAQgrRoZvvGVm7K9tR1KqrPUY0Kbl3YCV0jIm017u1eNEa7vLPnpM/BnQ=
X-Gm-Gg: ASbGncvxNg6sjSHKKOJEGUdClXqLsam9lgZx/YK0FoXbQ7BSMATl+fch6i99epxANaU
	osXEn1J9uBuswQORwINApkbgvBRPQvxLSQPJReegJ0LrPM7xCqr2Gk+iC40FKnbK4NDMTTz8TGB
	DRi6o5Rx9nLDeK+Fd/St0RnTyWf7/Hzww5Gnu7YWXgEc3AQ3GMOPMvH2mybR0pOLYTYwrWtwpRh
	ZTNNxwbmATMG7eTFhZoFHosh+SgZO3SJVSvk/kyNnbfPyGA/WGrX1zjdzkPa1vXDYxFEEUCbAFY
	cE2hL299mRQ=
X-Google-Smtp-Source: AGHT+IHMQHi+XSb10ft1yQND1yWWDCFYjk610SkV9fX/M2s2WKAmpH/Fd9zfkJK5BDgIWnYP03FRKw==
X-Received: by 2002:a05:6871:5e06:b0:277:d8ee:6dda with SMTP id 586e51a60fabf-29dc4198fb1mr14233141fac.23.1732992641928;
        Sat, 30 Nov 2024 10:50:41 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de9945eb6sm1893519fac.34.2024.11.30.10.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 10:50:41 -0800 (PST)
Message-ID: <2c6a435e-23aa-446c-bec6-6fc4d24e2d66@baylibre.com>
Date: Sat, 30 Nov 2024 12:50:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iio: adc: ad7173: fix non-const info struct
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Guillaume Ranquet <granquet@baylibre.com>
References: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
 <20241130184306.51e5bb8c@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241130184306.51e5bb8c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/24 12:43 PM, Jonathan Cameron wrote:
> On Wed, 27 Nov 2024 14:01:52 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> While working ad7124, Uwe pointed out a bug in the ad7173 driver.
>> static struct ad_sigma_delta_info ad7173_sigma_delta_info was not const
>> and was being modified during driver probe, which could lead to race
>> conditions if two instances of the driver were probed at the same time.
>>
>> The actual fix part is fairly trivial but I have only compile tested it.
>> Guillaume has access to ad4111 hardware, so it would be good to get a
>> Tested-by from him to make sure this doesn't break anything.
>>
> This is very big for a backport.  So I replied to previous version to suggest
> instead duplicating the data before modifying.  That has much less code
> movement and maybe a cleaner fix.  Perhaps we then cycle back to avoiding
> that copy later.
> 
That is exactly what I did in v2. "iio: adc: ad7173: fix using shared
static info struct" copies the struct before modifying it and is the
only patch with a Fixes: tag.


