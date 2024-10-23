Return-Path: <linux-kernel+bounces-378363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF849ACEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A748B25A13
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CF91C75E6;
	Wed, 23 Oct 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQLoPq6M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257721C68A6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697788; cv=none; b=uljI3c+y3cOnaLF5bn0qYwF6Fk+YvKcUtbnL27SBfewN7Uurf9LLutRwWZdcX9cCaHcWio766w4IK7ufMO3KDrTZgu0Gcipa7jzWbc6HjBrKUUoxZxT49aOtF/GR8PpX6dY9E3PutCW07PPJyvL7MetkGiugvMyIUdW9r5BVuOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697788; c=relaxed/simple;
	bh=hLA1RQo8/RcVFBLspjlNQ/FEotGEHQu2tn1mH5H7qGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/XSm8Fdtg3JWUc64x5wKjsLvUNwG1ecHH/FFHY2n6N1fyTzaCMTHnO0NtuwN7J9kHpxQ+qQRgEoqF4of5a7jgcQOqXW3GQxNRQOn4PvT6HEiffiCXj4GeNe1EdSC46D/GuyyQh7+oonqQHicwBAMpA5MZ4KmA+rtflEc52B3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQLoPq6M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729697786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W12atCawGWIIMbzM+o0TKKbvEulWWaQhHboBuLLrayc=;
	b=AQLoPq6ML+xqtDEZecEkdd80iFdqx87P04OXvnUejQf/t7AbYb4JoNmUdXaeN5C8FuAAz8
	LMFpEpSiBKmLExLhJH0ZsLwbxNhrV/LACgkkCI2cYR90wjjVonKX8gtj0eY/uNNCozqlmD
	jMGQxo8/lrbYVNFXiHuGD9p4hpNc8uU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-JV9OWgiyO6K9It33EK-_Ow-1; Wed, 23 Oct 2024 11:36:24 -0400
X-MC-Unique: JV9OWgiyO6K9It33EK-_Ow-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539ed93e08aso5263986e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697782; x=1730302582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W12atCawGWIIMbzM+o0TKKbvEulWWaQhHboBuLLrayc=;
        b=Pe+H1qQyamHyWowG641c5nx1WzNtJZ4n6XCylAgvU8GwDdwxj88i9PHrthGpo84LJb
         Qy0N2tHbBOr1/gmmzRQlLSDc7UYYSq40L9Ms609F6P1Ee6qkwt7mH2OyU+mEU2Kqjdd+
         tEDgyv4XxbqapFTexCZcGpbpk4hESgijRSX4I2vL+3V1SBVOoSqVHRUePr0vkBFBhRgi
         nztXRZK2xfojhKbwl1kuifLEqbCKgVWS4+l/SFVWGx11H0LjfVppmfhJ7xEdyq1SEFWw
         3VUw1yqEJlAcBSXjHT6hKXJm3PbRlafAIWcFpWlUgqUZgA5JsYrvniUbrGpr1TcaN7+e
         WLtw==
X-Forwarded-Encrypted: i=1; AJvYcCVGpPKeXad6k8B4hGy3196zY+KskjejJy73VPg4SGPHdfCwP8SLzVceqrbCkJAgpoWJXwrgVubLRbRUed4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZz9SGVHFz9Q9MK4KNDDw9ZIPsEZ2MX3+WCvvZJXm8ZyaPaT9e
	bG5VEkxy5Rh2SRTofznhWjk/UzAs4OE4t0pdCgZM7jYFOGU9ReNk9nJcdPQTUe5v6O9hMQezJin
	Z4lO+qrOqhSnLG+vvCIDxpitdDnV2mTJdVItSkg3WaRqC0j3E6UOsxjD9W9Sa62nrFt1bjw==
X-Received: by 2002:a05:6512:3caa:b0:539:f630:f233 with SMTP id 2adb3069b0e04-53b1a396616mr1704036e87.57.1729697782031;
        Wed, 23 Oct 2024 08:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOTmpkqv0SJnjqxX01hB8AB1rRaXAa5SfDtN0cPFdQexruh9uHn2xIIyAyw/VnACPHbMqdEA==
X-Received: by 2002:a05:6512:3caa:b0:539:f630:f233 with SMTP id 2adb3069b0e04-53b1a396616mr1704015e87.57.1729697781553;
        Wed, 23 Oct 2024 08:36:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a653f5sm4571880a12.26.2024.10.23.08.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 08:36:21 -0700 (PDT)
Message-ID: <6d6d038a-bc0a-4a13-9dcb-94e289767b44@redhat.com>
Date: Wed, 23 Oct 2024 17:36:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/13] iio: Clean up acpi_match_device() use cases
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
References: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 23-Oct-24 5:17 PM, Andy Shevchenko wrote:
> There are current uses of acpi_match_device():
> - as strange way of checking if the device was enumerated via ACPI
> - as a way to get IIO device name as ACPI device instance name
> - as above with accompanying driver data
> 
> Deduplicate its use by providing two new helper functions in IIO ACPI
> library and update the rest accordingly.
> 
> This also includes a rework of previously sent ltr501 patch.

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans


> Andy Shevchenko (13):
>   iio: magnetometer: bmc150: Drop dead code from the driver
>   iio: adc: pac1934: Replace strange way of checking type of enumeration
>   iio: imu: inv_mpu6050: Replace strange way of checking type of
>     enumeration
>   iio: acpi: Improve iio_read_acpi_mount_matrix()
>   iio: acpi: Add iio_get_acpi_device_name_and_data() helper function
>   iio: accel: mma9551: Replace custom implementation of
>     iio_get_acpi_device_name()
>   iio: accel: mma9553: Replace custom implementation of
>     iio_get_acpi_device_name()
>   iio: gyro: bmg160: Replace custom implementation of
>     iio_get_acpi_device_name()
>   iio: light: isl29018: Replace a variant of
>     iio_get_acpi_device_name_and_data()
>   iio: light: isl29018: drop ACPI_PTR() and CONFIG_ACPI guards
>   iio: light: ltr501: Drop most likely fake ACPI IDs
>   iio: light: ltr501: Add LTER0303 to the supported devices
>   iio: light: ltr501: Replace a variant of
>     iio_get_acpi_device_name_and_data()
> 
>  drivers/iio/accel/mma9551.c                | 19 ++-------
>  drivers/iio/accel/mma9553.c                | 19 ++-------
>  drivers/iio/adc/pac1934.c                  |  2 +-
>  drivers/iio/gyro/bmg160_core.c             | 15 --------
>  drivers/iio/gyro/bmg160_i2c.c              |  4 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c |  5 +--
>  drivers/iio/industrialio-acpi.c            | 45 ++++++++++++++++++++--
>  drivers/iio/light/isl29018.c               | 38 ++++++------------
>  drivers/iio/light/ltr501.c                 | 29 +++++---------
>  drivers/iio/magnetometer/bmc150_magn.c     | 15 --------
>  include/linux/iio/iio.h                    | 10 +++++
>  11 files changed, 86 insertions(+), 115 deletions(-)
> 


