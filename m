Return-Path: <linux-kernel+bounces-292094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB1956AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36C31F21009
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C426916B38F;
	Mon, 19 Aug 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ppwKtcjJ"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A85116B39C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071126; cv=none; b=SulOC3d4IiSkN2sKBhrBQRpDMIGlebIK3KiIG7HV+DVjJ3ANHv7ZiiqGWtafeNr275GL/HcBGYpL7T8BZuIIsUc1/deDubyhHBq9DHQFyIZLPDA86H4fRPhKTIaFp8Z4nACEpANJXzGNdEZxLYjHwBp6lqhmL8UJ0ixdRN9GM6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071126; c=relaxed/simple;
	bh=vMn7bOnvoOHNpw5Huz8R9HFC86Zb4QOtPXMeOq4M2EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7UxQtPvxuCk/ZDoezKexz3e5IqmjC+UFmXAf76a25DMPTAK3w5t5l6B3Yi7Bnd8RStlVZpqSQ2fsDqllfgh2F5lFNO8MClYKcWkVlb20GrqVdJPrJyihLPMvgTutpESaXP00BuIgnjUP8AgMo3DQQh7nwah0vU5k4vUpkHTtv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ppwKtcjJ; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4929fa64542so1456612137.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724071122; x=1724675922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMn7bOnvoOHNpw5Huz8R9HFC86Zb4QOtPXMeOq4M2EY=;
        b=ppwKtcjJH/4b9ZzHJQQ8DesbDC/BIx+NcvdaJ2UW42msbvvvRQWotmAz+bZER45EZC
         yV3oMQkOa4lMPQxcUJn0GQZfTzQJ4ie/1ffxwDxM8VRAmi2gylNz9OjnXmfhuYnRG7iQ
         Q68eL4rFbP8t1BKOz8DvZgoSOTp8lbwn6dc4z0JC3vMglXpW710mdxjXOnqnHcYyic3I
         ExB1Q/UvlT58rcvuxF0SylCke4lOuOEw0jRcIngMQat2eeVB+RKxsoRVyQWIYLC8k7a5
         lsqu1i90rP0bG4W90MzcJGmyOiK5+kZP9AKglKNzBi//GE6nKanN6GpV+SRvD0pQHvlf
         jjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071122; x=1724675922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMn7bOnvoOHNpw5Huz8R9HFC86Zb4QOtPXMeOq4M2EY=;
        b=q/Cio3JZjr2jSOrnZntCFqkwB7nleQ6XIghISwTCSoslg0afd8xOmv5c78TsFweta8
         38dh0uiqz0WHswOgJInBj7pNCOK19LsaiMeTrp2amKWSEclJ+iDqp13FOeQXtJbTOaDz
         FMykA6s0VOAVnVRC4xMupPuYT3umhBKDtWvEUG1W5BxlJxL6Cis0mQXxLXc6YdvCHmaq
         VNNl2+j3LGFacL8E5UCF3cfi8STEekEbfexA/KiAhpaK2pDqThf4J7ZODKEX6pbH39Lw
         Gk1hKqqLQpGr1Xe0OT7RXC6qz9s99T2aSIyJOnc2xIG6jqd2uRKMrE7mvyd6GcJex4Yx
         SbRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6KNGkdic++6+5xQR9JQ5EEP7mBhWNwN27pTQiBr8wCFNbmA2RbsJTLLKlJSPh7LeqPnW5KUpObbBLYPxt99vbd7U6vmnKEb6jYcSc
X-Gm-Message-State: AOJu0Yxhtub+37zqV+faRUARRv89icsLdKbuTcBnTu0tDe+rsw+FcFXM
	/XA1t1Ox/ShGVCeqpsZwHG4sWsTchvlwRWgWy/WbTqIxeabWGVzN4fxNMl/8xEA=
X-Google-Smtp-Source: AGHT+IGp6MdnP3Khhov+7iI5h+lG3ocEnkCPS56pNZDl3tn3+e/uJwlfHRCj4p5R/7sR0EnP+2ZLwA==
X-Received: by 2002:a05:6102:94c:b0:493:effa:e721 with SMTP id ada2fe7eead31-49779a0778dmr13557400137.27.1724071122291;
        Mon, 19 Aug 2024 05:38:42 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02f7a2sm427301885a.14.2024.08.19.05.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 05:38:41 -0700 (PDT)
Message-ID: <2fcae752-39ac-4332-9365-f25599a991b1@baylibre.com>
Date: Mon, 19 Aug 2024 08:38:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: adc: ad7625: add driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Lechner <dlechner@baylibre.com>,
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240809-ad7625_r1-v2-0-f85e7ac83150@baylibre.com>
 <20240809-ad7625_r1-v2-2-f85e7ac83150@baylibre.com>
 <20240817124752.3a6c1b49@jic23-huawei>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20240817124752.3a6c1b49@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-08-17 7:47 a.m., Jonathan Cameron wrote:
> On Fri, 09 Aug 2024 14:41:09 -0400
> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>
>> Add a driver for the AD762x and AD796x family of ADCs. These are
>> pin-compatible devices using an LVDS interface for data transfer,
>> capable of sampling at rates of 6 (AD7625), 10 (AD7626), and 5
>> (AD7960/AD7961) MSPS, respectively. They also feature multiple voltage
>> reference options based on the configuration of the EN1/EN0 pins, which
>> can be set in the devicetree.
>>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Hi Trevor
>
> LGTM, so I'll pick up v3 once you've made that weak to the DT binding
> and it's been reviewed (assuming no one else has feedback).

Awesome, thanks for the review. I'll get a v3 submitted soon.

- Trevor

>
> Thanks,
>
> Jonathan
>

