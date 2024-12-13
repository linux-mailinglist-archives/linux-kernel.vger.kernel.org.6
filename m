Return-Path: <linux-kernel+bounces-445685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 090129F19AF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2129E166199
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340591B4F2B;
	Fri, 13 Dec 2024 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YVTlMtk8"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F71B393A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131462; cv=none; b=VNo9gHdyPdl0ebHEcv5QbB7IYbTcoDaqwQ/CoWjzv3IRbzFM/SbaxJU2K/lpna+/KCd9ADJ+iwXBJbWnQQaOuTqZWD0ONLuJW4LyBiSmAl+0K2B/4+QQnaNq82RnTSoJlDfN4mvsMYyzktTyprRKz/ZlRccK+laJgJ73vGFvOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131462; c=relaxed/simple;
	bh=rmUX76AAhJtcbKbS/MKBhumEX3FZeF756LBDXcfM/+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=adt5BdCanSQjvNz9KvGE1LQt81XUVBQueQPQ+dXppK4gQJDqtS/IT9zK9qD4nkLFYpiUvHJI4Ud8sdbhfKvXUpHrkdS2GRdtqEWZC2cv7WjhP+/AzoRSU91uhW3sxtWhadZVE+Q4I1eGXlnoH9iTYNo01w+ZX0B7xVxkcoo7c9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YVTlMtk8; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e19fee3b3so1771382a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734131460; x=1734736260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6wCKCByuAlAaTXDYVy4N76cFvOrIazxQnE0CZ0HL/Is=;
        b=YVTlMtk8/qddeqAYeD/4WSY4D5wB8+Vtzhp87Pwg2DeyD87QvTWYwv1uTZxAT73p+S
         CZCXI+B9QI7p3BlrqnbjejS5APvutEbap1uB2Ql/KAmIGwCDQLAn0pBnUjXjPyl2JzOX
         xDr/a3HJCGMe2nXvdf7+0h/OsCmZDoaUTspY73fiSE1MFWPiGcD1EjxjQ6I22094tq/P
         fO023AOZO7JJfbe30SHUK72hNcakDBFmReObO7M2NFLMJ1/Diw/Jc3w7b47Qzu/rOghL
         FDXFQgvBFqUyX3BkOblgZDTHMftzS5fe48sdyoYXvUPUxKIgUVN2UAD9MimTDpKkCFvz
         pziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131460; x=1734736260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wCKCByuAlAaTXDYVy4N76cFvOrIazxQnE0CZ0HL/Is=;
        b=KZnbGrkbbH0RP70gBb9QYeN4jPxaxUyXQQehs85a+cZHBswun0d6e1+HVxabBHAQ3i
         c44IF+h79bNxtzKdI+kLJEm+d28OmZ0jWmqpJYfmVnrz2698yhrTGRXH2bjUIVIHvQY/
         DjnqYqwvD1a0VkHqZD6ZzccNBEjZQUyeaKEChYZCfjwEZCNlOuFYXZ6ZqzSo+HlYzPOD
         eR5S5wiwZ3r++wJnT+dh4fd8LTefHAaSYHJFuQ4nCab2Dt6EK1FXECllhHk4Bd5WGi9T
         AK7Vzi+V6wI5tEL9iMUHHpfRAEv2WI84y8JeGczLmCOQhV8w/TS9/IOFlpxaTjIL7d5o
         /BHg==
X-Forwarded-Encrypted: i=1; AJvYcCW2KgAfBLo4iXA0s2jrmBTZPur+cQs+YNeMhbJprTkhukqWpfeMo1P41KK6GSSj8GixT6CGNFw4wjZfbKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQGU0JfrjlEQ9An59P0CEC4cwkXlVRix64ipdBY56E6RFx/IF
	2BiPL8Npbnt7FEE5a23mKFCY0rn+rRDZVYfUdQ18PaaKM7NsRIv5BR/HmevDyxafzwT03UWEu9E
	s
X-Gm-Gg: ASbGnctPUMKSPfF4xgszA2GMkoiHrxhm8WTdWVccLegyjRAFf3JSwyQ9chGtW3JA0Ak
	mu1F9+PWBS77aoa1QJWgu5OcoRsBO0rDe/J18TMNPTxmlNBuUZnv0lP9zVkKdpqXL6XkUpBIark
	bTDAlAW2sDfaVSl/imcaUAPND2gZVTD15r6ucGt4T/em1Mqi476coJ9T7fR647iKOZO92Zu5Tr7
	q4EiYZhaw063xbFWxxtGg8yLQrFUvjTDxuMDpERbZhcyXEDa51ofC7o4CAzsw0Y7DmZ2WCs0dfO
	433m+xL0KIhSz6xHKw==
X-Google-Smtp-Source: AGHT+IF/HrkFYofu0XYPQ8FOsQdBFSwRshag+zqD1aQtDkwS7D9uEJpxpNj5EPvXNNnZAMQKCg6HNQ==
X-Received: by 2002:a05:6808:190a:b0:3eb:3d21:9cf1 with SMTP id 5614622812f47-3eba6bc2f20mr1744768b6e.13.1734131460011;
        Fri, 13 Dec 2024 15:11:00 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ebb48ce912sm119808b6e.40.2024.12.13.15.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:10:58 -0800 (PST)
Message-ID: <ac529e7c-8655-4ef1-9bc8-9081d3c365c3@baylibre.com>
Date: Fri, 13 Dec 2024 17:10:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/8] iio: backend: add API for oversampling
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
 <20241213164445.23195-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241213164445.23195-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:44 AM, Antoniu Miclaus wrote:
> Add backend support for setting oversampling ratio.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v8:
>  - pass oversampling ratio
>  drivers/iio/industrialio-backend.c | 15 +++++++++++++++
>  include/linux/iio/backend.h        |  5 +++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index ea184fc2c838..e56b1e96652d 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -681,6 +681,21 @@ int iio_backend_data_size_set(struct iio_backend *back, unsigned int size)
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
>  
> +/**
> + * iio_backend_oversampling_ratio_set - set the oversampling ratio
> + * @back: Backend device
> + * @ratio: The oversampling ratio
> + *
> + * Return:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_oversampling_ratio_set(struct iio_backend *back,
> +				       unsigned int ratio)
> +{
> +	return iio_backend_op_call(back, oversampling_ratio_set, ratio);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_ratio_set, IIO_BACKEND);
> +
Needs quotes on "IIO_BACKEND" here.

With that...

Reviewed-by: David Lechner <dlechner@baylibre.com>


