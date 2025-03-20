Return-Path: <linux-kernel+bounces-570359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF7AA6AF56
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7E23B8C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE7C229B0C;
	Thu, 20 Mar 2025 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kpt3j7rE"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7286212FB3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503387; cv=none; b=ILI317hSK6v7X8Pndq9X7ZjhAIKAlvUj7QjQMOd8EJaEIBDhtZ79ljunsMrT51QXVPFWCm4sWdnMxEWfgqezGoS0qHii0crYkHterZkBkCtleTyN1eXEywam7vSalpoelnYpJ3HTTc5NJHYiSe2yK+9lKJMR+hwqYEKpexnNBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503387; c=relaxed/simple;
	bh=FpuegLmU5tbQxu4BeI6waAfSkfTSY0kMV2xhhNvEvm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTpCf9VVPkKciJVk70im7zoxjRdtec5tHYfhGUs/GbGtdq0CMJ8GkLfDaLkjVsG4mXI0NW/StE+mQoGQvc/645XwrR0rbvbc6NjObxeus4M2p7GCFdCm6HKXAwlgNvYbmP/pY/oHdQaBoe6Bk20hwF9tec+VcB7yPctTG1/YrZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kpt3j7rE; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3fea67e64caso746394b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742503384; x=1743108184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JndwPcEu40LTfcktnqoRyV1fHHjivjql1RHGUu6ZCpk=;
        b=kpt3j7rETHSFaFIAO+I3sKZH9baiTJ5sqT8BYFy9kuZK+aH3yKsmd0DyDmcGgKTPYJ
         KkNijPHk+4eHa5efJIqGDD2eo0DEUix7af5hcRSHd4fkJ15BA/aosl/JPemddTIAe92u
         PKEQoIuZVt1ZOtuNb51CqAX0qehMaYl6h5QEOg5COFuI3Hf0nc1NZooTTMXwJjDFSTJN
         DDZJ0gRa4admAOtzuTPqJ/yqhm6dIpy+jRBZECQKXHw8vlteVEY3SE3ssi+36r6Q/gTD
         on3h96wteoecb+X5oKEYNYbHEfZ/g2w/DlPsvzFiNkXGPPry7X5vbeX27AOADvx1KQi2
         xtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742503384; x=1743108184;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JndwPcEu40LTfcktnqoRyV1fHHjivjql1RHGUu6ZCpk=;
        b=pDDzzxN68IKQi1uzKsde5xkPa5kfCUpWu6T7JoHvtmh1H7tZmNVmYDuxib4dhy+a5C
         hAQORiHmVcFA/muyjdkQE+sHbLhBhIOIktlywfE8bXPRt0POi7OIes4LI+eRKq0SQ4BO
         7qHj2VQAW4HwpC4Af5aaSNxcKigm4kg/esytxZihY33ckCOaqDxGERAuG//NVjdueCo5
         o29uTwZyFM9BaUXBseo6FySoi+zGsSTgVK0m0IHE5F1hycH4QSosQBtWBRRVm3PFhYYF
         +fnIYws+NIoEZ+ntDW/y2OlU+s4dXBHnIpPwJq4mxLHu6gH3K47487c6dNSRlsxl+3cU
         kXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYZIVX5EpnSa3rl9w8Nuhz9BJOAA5CvDe//mFwLIeRNvzeTzgNc4MRhn/aQSrWi/JW5iJe/KYPIo9mNsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+ap8QbMZ2ynBnWMu6sMYhuDqpvgCOQxaVqzGU8SyS+Tok6qR
	3WHBDv2/P1nDUL/FV7ZXEzz1Jut4iMrjvxbslBmR7Xe1BEbdGyxWce3JLxkY2j8UQzKEqXtaxlt
	pEOo=
X-Gm-Gg: ASbGncuRU6x8HXp3noKcOaeZIrQAL55z6cuMTGKZGG3sKBncftWS7DxDqJ009limFLC
	V3Fw346cbQZEMX0xs3nN5m5koe1jexN5FqOBwhIJor2Ug9IcYzvOjkA6z3z4onKLSCFwNpJmk3V
	5WnzgYgN08XIDfxeqeOqBf27vMWWT0Eg52w0jYm5cCmiorQU9QrNYv1Iz7qOPYcgCz1WjBeRL8y
	zLPTqhPLwaIeM7fT7CMyBHFD0r6421GiqmDlM0151HK3Pbl/kt3uf8+oGjph2SXcFUUmiP+g4aH
	YE1I2zE95YzSAayz9DetBbOONgoXnJRpR+u52V2/Ozfkrf2vIweUlFwZLxy68GPJxYgaICq46hE
	i6Y7qVw==
X-Google-Smtp-Source: AGHT+IGrPQlyXSXYBY7u+saxCR6isREiortDVdrxVss20iMydrEK8XXm7gPitUstCTe1G0rs6K8I/Q==
X-Received: by 2002:a05:6808:178d:b0:3fa:cf11:1493 with SMTP id 5614622812f47-3febf70afbfmr451429b6e.1.1742503383804;
        Thu, 20 Mar 2025 13:43:03 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf6dce65sm62432b6e.14.2025.03.20.13.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 13:43:02 -0700 (PDT)
Message-ID: <4fb5329f-be34-4d98-b34e-2da4e035f44c@baylibre.com>
Date: Thu, 20 Mar 2025 15:43:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] iio: adc: ad400: Set transfer bits_per_word to
 have data in CPU endianness
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
 <930560a0d0ca7af597d4ad901422bc9ba3fc6a79.1742394806.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <930560a0d0ca7af597d4ad901422bc9ba3fc6a79.1742394806.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:57 AM, Marcelo Schmitt wrote:
> When SPI `bits_per_word` is not set, SPI transfers default 8-bit word size
> and ADC data gets stored in big-endian format in memory. Because of that,
> the IIO driver requests ADC data to be rearranged from BE to CPU
> endianness. However, with `bits_per_word` set to the number of ADC
> precision bits, transfers use larger word sizes that get stored in
> 'in-memory wordsizes' and can be read in CPU endianness.
> 
> Use proper `bits_per_word` size for SPI transfers thus saving the driver
> from requesting endianness conversions. With that, shifting the buffer
> data is also no longer needed. This change has no impact on IIO device
> functionality.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

This is a breaking change. Some SPI controllers, like RPi can only do 8-bit
transfers, so this driver would stop working on those platforms. Also, if
anyone made software already that depended on the big-endian ordering without
checking the scan_type attribute, it would break that software.

I would leave this as-is (drop this patch) and just make it:

	.endianness = _offl ? IIO_CPU : IIO_BE,

in the next patch.

