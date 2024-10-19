Return-Path: <linux-kernel+bounces-372766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C2F9A4CE6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 12:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574CC1C211E1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B2C1DF749;
	Sat, 19 Oct 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4CyEaMU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABC6187858
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729334044; cv=none; b=TFZugDclpAvUsiDcwj/743duTNHyFOIehpmPH72lhxlFtjY38+1ASaKd3uFNOfpJzKUtUTwGd73IT6U1YL/RCS++FBxKuN8BNCtqqB6lEuvJIntQAp59nvTyPp9N2bHaIsT1HHNX9YDMsWCpD1KorbaaHsrhrPGjzUwQLar+URw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729334044; c=relaxed/simple;
	bh=WKD2VUu1VUZFL/i+siPCUW1cDpqRV46S8o+S7UVVOvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fd/LMdjZbJbdPu4ZKZTSLkvsA8ViituEvZpDa0eaD33jkKoFJHBfcz9lGzqrnYEeqCWGSE1B5RQczkyIkRDzrF9y8v9C3iIh630x5+xeuFN7Zxu0lpm7XAS/c66CZa8UQZNVTWFwrjiYj5sUCTEIqIwoFtp85q8MK1g7anBpQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4CyEaMU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729334040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ilk3CSIftMozUI7syqFVY15ByMjnzeurICXCGBQvEc=;
	b=b4CyEaMUs/Ll95v9jJxZpeb6DZQtgGd7shG2JSpx5PFIrawc39gSKe5Ak8phRaUMhjB74k
	UTfYhmUpv9Pqd3tc/Teh/xOMwQofspsJV7lsaSoPG/UdQuyN0Msh29nby+qpxqGBl6C4ed
	Py5+/mhCDTuFoOyRr4OOS2YiQq6xQhA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-I6DNXvOuN-CqGgPquKGb2w-1; Sat, 19 Oct 2024 06:33:59 -0400
X-MC-Unique: I6DNXvOuN-CqGgPquKGb2w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a99efe7369dso268178566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 03:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729334038; x=1729938838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ilk3CSIftMozUI7syqFVY15ByMjnzeurICXCGBQvEc=;
        b=gEroHjJl6RRFSeAe1h2EHBM6RsMAG9WAkhk63ET2oT6Ig6+ZJKk1UO3GIVbccF0kaZ
         z5K2XidJggkVC6DSSjislTALKxWbMBRxMreVHVHYNI+EipTrvdz9ePJAY9qykv5tsW9X
         UeNrttDmfqTs7BNY+zd2P9pa5KuwA1qRFD9QGoi77xNr3wN+kEB2Zo4ZSOqbjxQA8szJ
         PDM3hvMZKtpip/RpbmMaJtjNYgvJTKHdo+uzC30Hcy8jzzrRQm3Ou8+uyd0EV7sLXXIw
         KaVVdqu27zp5M84QSVYHYQSIMNmAEO0DMpfAL91ZlaD0GgmUA0oo56SoHXX4oGnmJV8Q
         WLhw==
X-Forwarded-Encrypted: i=1; AJvYcCVA1wlq6TmhhqJzwS00muFk5U0wpUwI3DTd/V9+Mf4DJ4olb2uNAeDAz4K0q/IQN20+2gfYpl8Q4al0U/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzUVYoXULOVsVDdqyuPdSHk/Iszwxhesq2uf9TWBj+q/lcrRw
	BJL0gPUkImyJJbK0QGoWNUh/fu1AVUG4k1/5TOYEwiW4r5fbIFqMreLXzb+jgUjifHqS2fl/Qb2
	Hswqlxj9c/3B63U9k5hJMYcrahOYEt+tacAc7dhXdBl5NhyssD9Pg5E0OYsvQzg==
X-Received: by 2002:a17:907:9404:b0:a99:ee26:f416 with SMTP id a640c23a62f3a-a9a4c2ef2a6mr984291266b.14.1729334037879;
        Sat, 19 Oct 2024 03:33:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiRLik/Qx7H7nLBueSJfiADvAIJ6pdoT4Rr1fTobbt7uumNL3SmFFDQ+LERBNDSORlGnSucw==
X-Received: by 2002:a17:907:9404:b0:a99:ee26:f416 with SMTP id a640c23a62f3a-a9a4c2ef2a6mr984289666b.14.1729334037498;
        Sat, 19 Oct 2024 03:33:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a921c9sm201127066b.4.2024.10.19.03.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 03:33:56 -0700 (PDT)
Message-ID: <aa7f2214-203d-4b7d-82f3-188fdc6b8673@redhat.com>
Date: Sat, 19 Oct 2024 12:33:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: gyro: bmg160: Drop most likely fake ACPI IDs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <20241018145732.2181309-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241018145732.2181309-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Oct-24 4:57 PM, Andy Shevchenko wrote:
> The commits in question do not proove that ACPI IDs exist.
> Quite likely it was a cargo cult addition while doing that
> for DT-based enumeration. Drop most likely fake ACPI IDs.
> 
> The to be removed IDs has been checked against the following resources:
> 1) DuckDuckGo
> 2) Google
> 3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
> This gives no useful results in regard to DSDT, moreover, the official
> vendor IDs in the registry for Bosh are BSG and BOSC.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/gyro/bmg160_i2c.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
> index 672d0b720f61..a81814df5205 100644
> --- a/drivers/iio/gyro/bmg160_i2c.c
> +++ b/drivers/iio/gyro/bmg160_i2c.c
> @@ -39,8 +39,6 @@ static void bmg160_i2c_remove(struct i2c_client *client)
>  
>  static const struct acpi_device_id bmg160_acpi_match[] = {
>  	{"BMG0160", 0},
> -	{"BMI055B", 0},
> -	{"BMI088B", 0},
>  	{},
>  };
>  

Doing a grep on my acpidump collection shows that the BMI prefix is used
for some Bosch IMU-s. It seems that some of the Bosch ACPI HID
prefixes are like this:

Bosch Measurement Accel -> BMAxxxx
Bosch Measurement Gyro  -> BMGxxxx
Bosch Measurement IMU   -> BMIxxxx

In itself these 3 non official vendor prefixis seem to be quite
wildly used and such are not an indication that a HID is not in use.

But using BMI which is for IMU-s in a non IMU driver is suspect.
Note that has Jonathan has pointed out there is a valid BMI0160
HID used by the drivers/iio/imu/bmi160/ code.

I also notice a "BMI055A" HID in the bmc150-accel-[i2c|spi].c drivers,
which seems equally wrong.

It seems that if anything there should be a "BMI055" (no suffix) HID
for drivers/iio/imu/bno055/bno055_i2c.c, but we should only add that
if we actually encounter it in the wild.

TL;DR:

I agree with the removal of the "BMI055B" and "BMI088B" ACPI HIDs
from this driver, because if these are valid for anything they
are valid for the bno055 + some unknown 088 IMU drivers and not
for a gyro driver.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


