Return-Path: <linux-kernel+bounces-227449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C7915165
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410AA1F21E88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E45E19B3E2;
	Mon, 24 Jun 2024 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vk8yt2ea"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47913D88B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241699; cv=none; b=GwCneah7i+4k0oyK70pcaD0H27/OFhgHRCCEuXLksB6U5HEfq+T1pYl8tvDIWQTMLvUZIrTGjSX4+4OhSjptxu/6SXirDZ8rubLaELOwDHy3+Zovy8pP0HVjU9I6/32OEqqWl05LjsQfkBoV6UsSv8xsyi+rDv+3gGLDgEjDdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241699; c=relaxed/simple;
	bh=ft4tT0UQ22Hu2W+Pyk0ebx25WCKyu/3L2mVuUHGIFQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSmVVAm/mD6WElRLohov7SKcQTAFaFEvnQyMF+yUKFb6h+l2ClJQhI7FkgL2xl0VGSv5SbWTswxwR0yW864WT0GhHyzPOpItF/eg0TEI3WcEbHPlgAFY0NUWaPqlplPv6WQdB68H5HJOgQZgcfFhvLq2hUspTMbFAsvzV9pchP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vk8yt2ea; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so36840845e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719241696; x=1719846496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wafc/q0nXR3Ye8LsHgCDkHwmKjVfo3c4oHVHMDrj/Aw=;
        b=vk8yt2eaYwhW7f72SDOl5261xikcP+xruoLxe5Waa65T4fHod2eYL07PLwJkHZtFbj
         iEmxo391Ym00xAFQ0Hny9vlN0ugeZbWxselJdlxPAYAfbLXKnoUSZ53i5d5OJfytpFOW
         +A78H60YWZlKw5fwmLjOW16OawSag/ECkZ7QJuiOVSDfSMb9j4G75fiHeIPezy0MvuVQ
         CJxw8DfieKdKqTqyZnm9mYsrg+XNxd8iGgHLXjD6VNkS5n1SGvM1WLT0BbjXUN0uIfPv
         CxeZ3QX4usQi4M/KMqU+YkL0f2cyFKyVMSir5EkSDUCjrr7+JsVM9Z8/eGeQDSgl3zjV
         LsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241696; x=1719846496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wafc/q0nXR3Ye8LsHgCDkHwmKjVfo3c4oHVHMDrj/Aw=;
        b=xQC/laKcrOAbYVvnKrWnDlwgSBn5ikjY7VTZlSEegfu7h5n4zsGLP0O86hJe688BGY
         54b0aeWUTKbnraqK9TZ5OtI26tOqzlBtPq/B4vf19tqr8WvHyPlgLbI6Xplre8LadKDC
         cfKdXxeQ4X26m8I2s+HFVT70YNnu/Phoolmpb63Y0/OlB6jrgyU0XdD5P07EFGK9pPGE
         Jx8x5vdH3lZt/sU1bgejytCnwJztCC7gCAMpkIomEeFacjp+npS5dgQPGB2SyxWVpYir
         EqxXcILqeZMSEeo3HIhRlmrHw+wsJOypAIBOarf3lzfE9UOy5f8IgVTPGsMYEyToCAE0
         vhEA==
X-Forwarded-Encrypted: i=1; AJvYcCV6gIUpHpH+7AbhZoCnOpOYs5GReXQChqxFkPaJNZLVF3gChLRe6RZ+G0UkrdXNH4ElDneqDf/uDG0nEo5FLBW8rMlzbC7lpQuRFh8c
X-Gm-Message-State: AOJu0YxH5EsQwnpYD9GI5rGYNm58sxBXWAmEE0ARj33JpCWFooeLN5+e
	zrZGakwP4ckDTuBq00EbzKduV57+nBiQ579Klh7RmnVOzSUQAYC2sVnrkFMmQdM=
X-Google-Smtp-Source: AGHT+IE5Azx1tp6IG+TkRkPA4t2eMISvGoO8x7MCXtH6yPnmaWLIdsqd5JLP1NfTp42KWcMq7VY1ag==
X-Received: by 2002:a05:600c:68c:b0:421:de31:81 with SMTP id 5b1f17b1804b1-4248cc35d9cmr32718155e9.24.1719241695473;
        Mon, 24 Jun 2024 08:08:15 -0700 (PDT)
Received: from [10.2.5.170] (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248191116fsm142780645e9.37.2024.06.24.08.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 08:08:15 -0700 (PDT)
Message-ID: <62dadd31-5fd1-45b4-99e8-44ffb367bad5@baylibre.com>
Date: Mon, 24 Jun 2024 17:08:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] iio: adc: ad7606: fix oversampling gpio array
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>,
 Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
 <20240618-cleanup-ad7606-v1-8-f1854d5c779d@baylibre.com>
 <20240623164542.53a9f2b1@jic23-huawei>
Content-Language: en-US
From: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <20240623164542.53a9f2b1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Resend, previous mail was erroneously sent in HTML. I apologize for the 
spamming.

On 6/23/24 17:45, Jonathan Cameron wrote:

 > On Tue, 18 Jun 2024 14:02:40 +0000
 > Guillaume Stols <gstols@baylibre.com> wrote:
 >> gpiod_set_array_value was misused here: the implementation relied on the
 >> assumption that an unsigned long was required for each gpio, while the
 >> function expects a bit array stored in "as much unsigned long as needed
 >> for storing one bit per GPIO", i.e it is using a bit field.
 >>
 >> Fixes: d2a415c86c6b ("iio: adc: ad7606: Add support for AD7606B ADC")
 >> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
 > Always drag fixes to the start of a series.  Probably doesn't matter
 > in this case but we want it to be obvious there are no necessary 
precursors
 > in this series for anyone backporting.

OK will do this change in the next version.

 >
 > What is the user visible outcome of this bug?  Superficially the numbers
 > all end up the same I think even though the code is clearly working
 > mostly by luck.  So might not warrant a fixes tag?

This is leading into some issues I should maybe have better documented 
in the commit message.

See below

 >
 >> ---
 >>   drivers/iio/adc/ad7606.c     | 4 ++--
 >>   drivers/iio/adc/ad7606_spi.c | 5 +++--
 >>   2 files changed, 5 insertions(+), 4 deletions(-)
 >>
 >> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
 >> index e3426287edf6..502344e019e0 100644
 >> --- a/drivers/iio/adc/ad7606.c
 >> +++ b/drivers/iio/adc/ad7606.c
 >> @@ -235,9 +235,9 @@ static int ad7606_write_os_hw(struct iio_dev 
*indio_dev, int val)
 >>       struct ad7606_state *st = iio_priv(indio_dev);
 >>       DECLARE_BITMAP(values, 3);
 >>   -    values[0] = val;
 >> +    values[0] = val & GENMASK(2, 0);
 >>   -    gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
 >> +    gpiod_set_array_value(st->gpio_os->ndescs, st->gpio_os->desc,
 >>                     st->gpio_os->info, values);

ARRAY_SIZE(values) is 1 because DECLARE_BITMAP will declare a dimension 
1 unsigned long array (more than enough for 3 bits !).
We want to set 3 bits in gpiod_set_array_value, thus the first parameter 
should be 3, not 1.

 >>         /* AD7616 requires a reset to update value */
 >> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
 >> index 263a778bcf25..287a0591533b 100644
 >> --- a/drivers/iio/adc/ad7606_spi.c
 >> +++ b/drivers/iio/adc/ad7606_spi.c
 >> @@ -249,8 +249,9 @@ static int ad7616_sw_mode_config(struct iio_dev 
*indio_dev)
 >>   static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 >>   {
 >>       struct ad7606_state *st = iio_priv(indio_dev);
 >> -    unsigned long os[3] = {1};
 >> +    DECLARE_BITMAP(os, 3);
 >>   +    bitmap_fill(os, 3);

Here we need 3 bits set HIGH in one unsigned long (i.e 0x07) and we get 
3 times 0x01 instead.

Thus, it will not switch to software mode if OS pins are not hardwired 
(which is I must admit, rather unlikely).

 >>       /*
 >>        * Software mode is enabled when all three oversampling
 >>        * pins are set to high. If oversampling gpios are defined
 >> @@ -258,7 +259,7 @@ static int ad7606B_sw_mode_config(struct iio_dev 
*indio_dev)
 >>        * otherwise, they must be hardwired to VDD
 >>        */
 >>       if (st->gpio_os) {
 >> -        gpiod_set_array_value(ARRAY_SIZE(os),
 >> +        gpiod_set_array_value(st->gpio_os->ndescs,
 >>                         st->gpio_os->desc, st->gpio_os->info, os);
 >>       }
 >>       /* OS of 128 and 256 are available only in software mode */
 >>

