Return-Path: <linux-kernel+bounces-329274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A63C978F72
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA441C21DDC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7E1474B9;
	Sat, 14 Sep 2024 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bMFxqsqy"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9119D885
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726305702; cv=none; b=alSsWxQjZKYQVsLzi7vkO0+dFgEqCNNMTJFYMTkIny9F5nqAYMjc0iNN3qfTIaxaWtfft8cghQqfY/u5Se4P/0Q29IJ6AG17qTjhPpr9I48PieBVKR3lfB6WioQzRQm+IhYU9yKLQlrGLprRgdkJ5cl6Djr0/i9NKX8Sp7vk6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726305702; c=relaxed/simple;
	bh=QWLN81duHcC98U8Wgfo/hW2STVBwULFC4YNBCXuyjVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yp7Zr5yCfiu45tELXrAjsYG4kvSrBBBTaPZlChvqR008m4hkId1xGrDhYUfuG3ur37Iw+0+h33SK+y1HHCxBq8rdtn1Dt1EEQ7m0bYjwygJ/K9nGvgSdHldyBuUGqPYUW6ZkGZCB5GZ2wfRYLbT5FyiRDgNAghitrdqsTS9nwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bMFxqsqy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so1804231f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726305698; x=1726910498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0vwYUdOyrcmqsU8fkyOeRsFNoi3+GuwHokLYeTePag=;
        b=bMFxqsqyWEjPrbHHUC9TCakNJgnrB5KppFykmlFKAaHSV8UbbR30zYdJlZf/LMGJVV
         GNIO14YfippErn0PqCSVgGgsyxzCnuooFOpQ2FmDCKljxjL4fJNJjd62AhYOlLs2i4NJ
         U/vz2577IwD1NG0cRrOgkMTDWPB0WcD0037Ml2qqU2I5KWDZsD74OJ2FiK4dVfAIemiY
         XgcWdBrVtUsFd3ewqMC5vKwZK0RKEQQ7FH6zsEfKIYYbrC/F8PkCGv06c2REWPNN3ICl
         6qNxDzvsk5r6jqEokatD20dmfFyi4RYtsIcLNvaiHCsqxywpRz5wWm+E29A+XDkPQYvM
         IseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726305698; x=1726910498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0vwYUdOyrcmqsU8fkyOeRsFNoi3+GuwHokLYeTePag=;
        b=SwMkyYx+cfE0b2cZbUAyG1D6bqAmnerpNmIbMEBPgnheSQwUWYLbP/CpH46V1qZOCv
         P+LV3KoiLVXIWycp6Te0mGGUlzGH0e7VVqymx+HlvVN+W+Xm8wq3Kx2b/txt0NAwc/Dk
         Jpb9iTEXYYLnLoGTS4Yw61RN3dJ1JB7Q+sXc0IWhXAHqsuGuaO7CGKEg5heCYFkOGTsY
         g967xu8DrSfS77VLGsy/ccFuwoD51Rt1Jk4v/WrNc2S6vhHkQ/SCx303ufEDyMITg61A
         7rlJJGGZp9jmFSZ5n5/hB2SltE3/d7mZP9YAbWSUXJqCG1AClxfdAQn6CDeOFJpEfrmg
         hApQ==
X-Forwarded-Encrypted: i=1; AJvYcCV47d6iakvpbS0BgQOGekYcdIFkawIX0wzReB7CN4Ktoq5SkBmR3lgNw9KiBxXqH3ZFJzZ8YfkEosw5+dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMeYMUyo60VFyxr/rKDZHInAmJeljEshoyq2m2EuJi5eqURGaV
	gDcu7td6hl2rYdXCIct/mNaRmWu1I+/Er095vW/SWIV5e5LsydMKO3INXDnL3gU=
X-Google-Smtp-Source: AGHT+IH45xR6Gog1ZY7V2YLrPhCGhfQF/3R1gLbHp9LuneqGr615sJyZ4/UcDCFDXXJAze+fTRg3rg==
X-Received: by 2002:a5d:4f12:0:b0:374:ccb0:66c7 with SMTP id ffacd0b85a97d-378c2d0623bmr5708624f8f.16.1726305696892;
        Sat, 14 Sep 2024 02:21:36 -0700 (PDT)
Received: from ?IPV6:2a04:cec2:24:e9b5:6dd7:b979:f3bd:3baf? ([2a04:cec2:24:e9b5:6dd7:b979:f3bd:3baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e837csm1242741f8f.27.2024.09.14.02.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 02:21:36 -0700 (PDT)
Message-ID: <e6d3926a-002d-445a-8ac5-8d47b2be27b0@baylibre.com>
Date: Sat, 14 Sep 2024 11:21:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] iio: adc: ad7606: Switch to xxx_get_device_match_data
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, aardelean@baylibre.com
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
 <20240815-ad7606_add_iio_backend_support-v1-7-cea3e11b1aa4@baylibre.com>
 <20240817163354.68ec95f4@jic23-huawei>
Content-Language: en-US
From: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <20240817163354.68ec95f4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/17/24 17:33, Jonathan Cameron wrote:
> On Thu, 15 Aug 2024 12:12:01 +0000
> Guillaume Stols <gstols@baylibre.com> wrote:
>
>> On the parallel version, the current implementation is only compatible
>> with id tables and won't work with fx_nodes. So in this commit, the goal
>> is to switch to use get_device_match_data, in order to simplify the
>> logic of retrieving chip data.
>>
>> Also, chip info is moved in the .h file so to be accessible to all the
>> driver files that can set a pointer to the corresponding chip as the
>> driver data.
> This means each driver gets their own copy.
>
> Better to use an extern in the header and keep the actual data
> in the core module.

ack.

Given your previous comment about introducing 
platform_device_get_match_data, I guess I should instead do it directly 
in the driver's probe, like its done in axp20x_adc.c ? Somehting like that:

if (!dev_fwnode(&pdev->dev)) {
     const struct platform_device_id *id;

     id = platform_get_device_id(pdev);
     chip_info = (const struct ad7606_chip_info *)id->driver_data;
} else {
     struct device *dev = &pdev->dev;
     chip_info = device_get_match_data(dev);
}


