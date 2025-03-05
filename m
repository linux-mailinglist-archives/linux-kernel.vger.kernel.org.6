Return-Path: <linux-kernel+bounces-547147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32405A50372
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BA93A841E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B973250BE1;
	Wed,  5 Mar 2025 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNKwr4dO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68842500C5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188418; cv=none; b=PxNIN21VErjPCWiolF6ZitnZvlstGh3aHAF9ogUHHY6GZmf9pGkM6mG898AdIXkWX0e5W037bBdQGtIBaM5IRHf/tfxEla5vbz70e8dzFSv+lJjdG21OPGTsC5peZ71lH/Qc/23uD1YFu+yXahuNchzgvKlMRZ0UIrY/Xs6h7jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188418; c=relaxed/simple;
	bh=DQLJQEbSar6wdhkMvPdsQKCsY9/20ojKwZI2nZPlYbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXMm8l6+ysoKIKGzM5eHb2O/mlRjS0gmFDoCMfwReT9FOoyhXBK5+8p9k9Ex0wFSoqTkZYWQRlRxXzBIKFTcYg6lAg96WEGWrg7TPy1lskopxhALK2FgQonkWUtv2ooqdIbxvHoIX+LY3EfNSOOWcMIYl2rZkzhhBlKU0FD9eAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNKwr4dO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741188415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg3WsSbbabdBza8WhjItm9qFRXZmyL+gE9D8KXi0c28=;
	b=LNKwr4dOKWt+/BioEQnkr2/PY8KhJhIUGBOyLvbBZuCEhET0BYAq24ZnF66cZR4ugw6yJu
	6hkP2pI7DkC4iS9l/JiJWfEFtbPqRBGSFtgv+1MV3n8FPAc7bE2Fh0UYQUq8BbnzSz3El6
	/zuubSu1yPG+0EkTEQsqDC1qow8+d7k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648--C1ULEFfNgSR6mev3Cka_w-1; Wed, 05 Mar 2025 10:26:49 -0500
X-MC-Unique: -C1ULEFfNgSR6mev3Cka_w-1
X-Mimecast-MFC-AGG-ID: -C1ULEFfNgSR6mev3Cka_w_1741188408
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5daa661ec3dso2082317a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188408; x=1741793208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xg3WsSbbabdBza8WhjItm9qFRXZmyL+gE9D8KXi0c28=;
        b=U/XFqp69rLb7w8OqjVIxPjAoxfvtcFxTTyafApm/VPa44Wl1PKhfU7NuOKr/fk5MGz
         pfTQPfPTlU2y9Tk+w7x7Xf8obWhSSZZz1UFPSWspziTg0GwGYTlgg2jIF9s/NvTrZylj
         QMHEINLv60hN1jFi5jBtfumbWzfIZAz0RQBboj8x1TElORlsmIyPcAhsMdhkvRr2F48J
         lsprYCaLESNtRk+VrOxkc0LvNcuS+VSV4tugJjLEIYqgPORiXuVGmLXKvzR2+dds4p6k
         LIguYkxq2iDlvCXHE5W+9yja7x0VQYxbnPONV7t5n6O2y3sTnFasMbZG/ziohx9moDpQ
         9uwA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Iqj1oXuWMWlhxslrEpN8RV6pVZQ/+WO8JnDQLyUUpb2o5XJvnI2e8/NwMqKeID19CEu1sRIvkPpPDoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtVPLfglJ0Qmm0Qca/GQllQKVcGd9wZHAsL52A8hdPKR3yLaO
	8wXj60XE4qTsqcGDmq0QEypQd9+9+cKFhXrxzUtZeVniRgF+KYDj2ETSM1DluqQ5Srv7cSOpusx
	drNbUFYGlVowgMyuUvrPuq6ctLTn3GIr/Aa4HoHBgJqMwwCs+aVx82mKmkkOaCg==
X-Gm-Gg: ASbGncv124Cr8C2HIsNJVD2jxkgf/LoQtP1ZUea9HRTDBWeXaIA7JqrGFZWvejpmeyx
	PfbPAu+cQqfEUA1gUr2fSXtRDD8lQUktDBZud55vzT+3pDM1VhKY84NC9iyjlYfsJLA2xUJC5TP
	l5Tx1NpBUOC81M7vQy8kWjMoWs2pen+wSXZkzKI17eUJlSrkXzn7p6/9xKhcA8RcFmpTWlfRQjn
	1d5tsmBaPnoYIpq929LQD/jHeEUhTIutg9kai4e98kfnOhtPPWGlDbfqK/fZ3bXIXvV6xtJEfsL
	Lt7pkXnNyTeEvxOVydbeI4HhTeugmqQoeyKVOc0a1fTds1d9Zadp5gT2IlCG6m09WBuF5+prQ/m
	MWM7XyHptE9ocb3xE+PQ7/OCEI9GI9ONUFaBu4bUAysMyN+wf/ccNwDbHb+fuXKvPTg==
X-Received: by 2002:a05:6402:d09:b0:5e5:49af:411d with SMTP id 4fb4d7f45d1cf-5e59f3e9424mr3490584a12.17.1741188407907;
        Wed, 05 Mar 2025 07:26:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7f0okBMNauR5yQoPtz6CCt+SLIRMeLxuXvZXGEx+lVcJUM7S3PaNIKLXJXG4F4CbgUscmNw==
X-Received: by 2002:a05:6402:d09:b0:5e5:49af:411d with SMTP id 4fb4d7f45d1cf-5e59f3e9424mr3490542a12.17.1741188407354;
        Wed, 05 Mar 2025 07:26:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb633bsm9754114a12.63.2025.03.05.07.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 07:26:46 -0800 (PST)
Message-ID: <9b8c9eb7-c8d5-4c12-9ce5-c4b4df3b4223@redhat.com>
Date: Wed, 5 Mar 2025 16:26:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: amd: Add ISP platform info
To: "Nirujogi, Pratap" <pnirujog@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, ilpo.jarvinen@linux.intel.com,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 benjamin.chan@amd.com, bin.du@amd.com, king.li@amd.com,
 gjorgji.rosikopulos@amd.com, dominic.antony@amd.com
References: <20250228170238.3484860-1-pratap.nirujogi@amd.com>
 <cd25d131-bead-4a38-98dc-1011c2843286@redhat.com>
 <3d57b624-7753-4a4d-9051-0a55cbdff1ec@amd.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3d57b624-7753-4a4d-9051-0a55cbdff1ec@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Pratap,

On 4-Mar-25 12:14 AM, Nirujogi, Pratap wrote:
> Hi Hans,
> 
> Thanks for your review. Please see the inline comments and let us know your insights.
> 
> Thanks,
> Pratap
> 
> 
> On 3/3/2025 8:41 AM, Hans de Goede wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> Hi Pratap,
>>
>> Thank you for your patch.
>>
>> On 28-Feb-25 18:02, Pratap Nirujogi wrote:
>>> Add ov05c i2c boardinfo and GPIO pin info for AMD ISP platform.
>>>
>>> Details of the resources added:
>>>
>>> - Added i2c bus number for AMD ISP platform is 99.
>>> - Added GPIO 85 to allow ISP driver to enable and disable ISP access.
>>> - Added GPIO 0 to allow sensor driver to enable and disable sensor module.
>>>
>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>> ---
>>>   drivers/platform/x86/amd/Kconfig   | 11 +++++
>>>   drivers/platform/x86/amd/Makefile  |  1 +
>>>   drivers/platform/x86/amd/amd_isp.c | 72 ++++++++++++++++++++++++++++++
>>>   3 files changed, 84 insertions(+)
>>>   create mode 100644 drivers/platform/x86/amd/amd_isp.c
>>>
>>> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
>>> index c3e086ea64fc..4b373edd750d 100644
>>> --- a/drivers/platform/x86/amd/Kconfig
>>> +++ b/drivers/platform/x86/amd/Kconfig
>>> @@ -32,3 +32,14 @@ config AMD_WBRF
>>>
>>>          This mechanism will only be activated on platforms that advertise a
>>>          need for it.
>>> +
>>> +config AMD_ISP_PLATFORM
>>> +     bool "AMD platform with ISP4 that supports Camera sensor device"
>>> +     depends on I2C && X86_64 && AMD_ISP4
>>> +     help
>>> +       For AMD platform that support Image signal processor generation 4, it
>>> +       is necessary to add platform specific camera sensor module board info
>>> +       which includes the sensor driver device id and the i2c address.
>>> +
>>> +       If you have a AMD platform that support ISP4 and with a sensor
>>> +       connected to it, say Y here
>>> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
>>> index 56f62fc9c97b..0d89e2d4f7e6 100644
>>> --- a/drivers/platform/x86/amd/Makefile
>>> +++ b/drivers/platform/x86/amd/Makefile
>>> @@ -10,3 +10,4 @@ obj-$(CONFIG_AMD_PMC)               += pmc/
>>>   obj-$(CONFIG_AMD_HSMP)               += hsmp/
>>>   obj-$(CONFIG_AMD_PMF)                += pmf/
>>>   obj-$(CONFIG_AMD_WBRF)               += wbrf.o
>>> +obj-$(CONFIG_AMD_ISP_PLATFORM)       += amd_isp.o
>>> diff --git a/drivers/platform/x86/amd/amd_isp.c b/drivers/platform/x86/amd/amd_isp.c
>>> new file mode 100644
>>> index 000000000000..751f209e9509
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/amd/amd_isp.c
>>> @@ -0,0 +1,72 @@
>>> +/* SPDX-License-Identifier: MIT */
>>> +/*
>>> + * Copyright 2025 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>> + * copy of this software and associated documentation files (the "Software"),
>>> + * to deal in the Software without restriction, including without limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + */
>>> +
>>> +#include <linux/init.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/gpio/machine.h>
>>> +
>>> +#define AMDISP_I2C_BUS               99
>>
>> I'm not a fan of using static i2c-bus numbers for this. static bus numbers are
>> something of the past and we typically do not use these on x86 anymore.
>>
>> Using this static number + i2c_register_board_info() also requires this code
>> to be builtin rather then modular which is also undesirable.
>>
>> For a more dynamic way of manually adding i2c-devices see:
>>
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/dell/dell-lis3lv02d.c
>>
>> But a better question here is why instantiate the sensor i2c device
>> manually at all.
>>
>> ACPI has a standardized way to describe I2C-clients which tyically
>> is used for all I2C devices on ACPI platforms like I2C touchscreens /
>> touchpads / audio-codecs / accelerometers / etc.
>> I don't see why the camera sensor on AMD platforms is so special that
>> it could not be described in ACPI using an ACPI child-device of the
>> i2c-controller with a ACPI resource (_CRS entry) of the I2cSerialBusV2()
>> type.
>>
>> Likewise the sensor enable GPIO should also be described in the ACPI
>> table as a Gpio type resource in the same _CRS table.
>>
> 
> We have to take this approach because ISP is a child to GFX PCI device in AMD HW architectures, and since it is not an independent device, its device specific configuration (gpio pin ids, i2c-bus number etc.) is not registered in ACPI.

The ISP still could and really should be an ACPI child device of
the GFX PCI device in this case with its own _CRS for for example
the enable ISP GPIO.

>> Can you run acpidump -o acpidump.txt on a laptop with this camera
>> sensor and send me the acpidupm.txt offlist ? Please run this
>> on a production hardware laptop model using production firmware.
>>
> 
> Please refer the attached acpidump.txt

Thanks.

So looking at this there are ACPI devices for the sensors, which
unfortunately lack a _CRS with an I2CSerialBusV2 resource pointing
to the ISP childdevice as bus-controller. So that i2c-client
instantiating would be instant.

+Cc Mario

Mario any chance that for the next (or the next-next) generation of
AMD devices we can get the ACPI tables fixed to properly describe
the sensors as having an I2cSerialBusV2 resource, just like how e.g.
I2C touchpads / touchscreens have this ?  I suspect this will benefit
Windows too. Likewise any enable GPIOs for the sensor really also
should be proper ACPi Gpio resources in the ACPI device describing
the sensor.

Ok, back to the current generation devices. So there is an ACPI
device for the sensor there. This should lead to a:
/dev/bus/platform/devices/OMNI5C10:00 device getting created
(please check this).

So this driver for adding the sensor GPIO lookup + creating
the i2c_client should be rewritten to be a platform_driver
binding to that device and it should be a module rather then
being builtin using module_platform_driver():

- Binding using a struct acpi_device_id table to match the ACPI HID of
  OMNI5C10 + using MODULE_DEVICE_TABLE(acpi, table_name) for auto module
  loading.
  The driver_data of the acpi_device_id should point to i2c_board_info to
  use for that HID to future proof the driver for adding support for other
  sensor models

- Loading as module means this can be loaded after the i2c adapter driver,
  so instead of registering board-info it should use the mechanism used
  in drivers/platform/x86/dell/dell-lis3lv02d.c combined with a unique
  adapter name, then the module load ordering does not matter and it is
  also unnecessary to have a magic fixed i2c bus-number of 99

- probe() should copy the const i2c_board_info info from
  acpi_device_id.driver_data and then set the fwnode so that the sensor
  driver can e.g. get to the _PLD info to determine sensor location
  (e.g. front vs back)

- The GPIO sensor lookup for the ISP enable should be registered by
  the ISP driver itself. Also this seems to be something which might be
  board specific so maybe this needs DMI matching?

I'm looking forward to see a new version implementing the above approach
which would be a big improvement IMHO.

Regards,

Hans



