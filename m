Return-Path: <linux-kernel+bounces-302871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F55296047E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933871F2099A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB014156F28;
	Tue, 27 Aug 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsN6V9hE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8D15534E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747605; cv=none; b=VznwiU5av+6WXzUHvRS9dVfUvCXiY4aWAdQpkqk7i1Gnn67p//VPJM+w5dnecgvPj9quugg42/IxKmDCNCP0LSLHd1bM36hsx7Z5s3kWwCzsmtLIgeOpLgo6a6AB4Uj2jPrITRYundadKxCU+vzJLZEA48l8wHq/1yD0fkyBYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747605; c=relaxed/simple;
	bh=negRtRnRQXXFlSjvTDFYnERC6ZgxtSJWq6teijWeBnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxfFeOhK5WWAg8cNegx7Xh0OB11jyY7SpyM5fkdLAAxDHGM42jxdxwv0hxZfA3ZZqoiccnq8ytSSejiFxJEOvHH6R9SwZKXL/nsAHun1kCZB8+yzSXczir6pmmgvdoZ0aVrnkRUroe1Hc2M65PUkU7rlBjzOfoqKoR7LEOx8+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsN6V9hE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724747602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2xW65G6z4ADem06lU/Xv8UzMPSFryt6wA1DVVwuTeE=;
	b=fsN6V9hEFtp0GRdPPYTNeUX6/4SdX8IvNUvVL8KXIzc4wAy06RbGXaQVLNu/0P/d0a5Due
	KPVkN7z4HL3Z7RKxtF9A2+ypBsw3qXwWSYGX7kvcqJLPKQrQUD5wQEPwuvy92ZYn73zhtz
	V1UV2iTIOsJa4vftb2I02E+WW9ouXLE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-Tw-eiZATPwuwlSjjLR5cqg-1; Tue, 27 Aug 2024 04:33:21 -0400
X-MC-Unique: Tw-eiZATPwuwlSjjLR5cqg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f3f4dcbee9so22205091fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724747599; x=1725352399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2xW65G6z4ADem06lU/Xv8UzMPSFryt6wA1DVVwuTeE=;
        b=ZAJTpdxQEMXRtic5IUaj6xZKO8yIzimJQ6qLLrcyQ/E/UzTmGeUIUK6h5MbKCdpfMX
         cImNX1dFgTbVqE3GI/y14DuuZ7hSPu6gU1+JawQzKlBHnzMzwEugU0/egkPhTfdKg2nR
         AaCs4gbB0ml+QceNj183HCSgLkgCnygzHN0s/jgDgwjAJuaovPpAD4cLUEWmIhtwKuU1
         6+J8Ih3yrp/JpYlqjcAzj5XzPnJMmdaMfGUce7kDWCTqo+OS8pLcT/S/TP39P/iAVbZK
         7+7sWirNfUg8hUyoa7/g0A51erFs2FoRKwQDbidV5DfT1V7eOr1q09wR/SYh2NDiwovY
         gItg==
X-Forwarded-Encrypted: i=1; AJvYcCWMKQGEs1GG4ne2lklR3JVrBFEKx8IS63mb9H09NW/p1xFuV7fGjOAv6rsjk33EhEs+5Dn0X/w1hzbLnCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCyzd0t4Quso+eaOJF6DM4bhj+LSY+n6bbV1/mK0jtMyfTDlfE
	irozTLrhG2W/YMqxLz4hd2XfLqsAUvokA+WqTOi4GOMKRylA69XNsWC1yGg2dtapHyXbuFaY+4q
	0aKDe7rkjcDYShHWPapAcD8VFMNZTbMcURlmjmkl89pNhQRcn44q1t/gCTZF4lw==
X-Received: by 2002:a05:651c:1989:b0:2f5:806:5cee with SMTP id 38308e7fff4ca-2f514a2dd5emr15937531fa.11.1724747599232;
        Tue, 27 Aug 2024 01:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVnQw6E3+puevtxOGn6sERcXOy0/91W7RrQF96jnkcm+Rp/3ZJKoJgzLpm4ZNLAsEVQ947Aw==
X-Received: by 2002:a05:651c:1989:b0:2f5:806:5cee with SMTP id 38308e7fff4ca-2f514a2dd5emr15937261fa.11.1724747598577;
        Tue, 27 Aug 2024 01:33:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb48106dsm730981a12.79.2024.08.27.01.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 01:33:18 -0700 (PDT)
Message-ID: <154d5d69-09c3-460a-945b-3f4f3b452d9d@redhat.com>
Date: Tue, 27 Aug 2024 10:33:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: lg-laptop: Add operation region support
To: Armin Wolf <W_Armin@gmx.de>, matan@svgalib.org, ghostwind@gmail.com
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240813022903.20567-1-W_Armin@gmx.de>
 <bb7926e9-759b-4899-b616-c8c7ffcc9a55@redhat.com>
 <1f6d06a3-1e5a-4b34-b43f-c3d23ee7218a@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1f6d06a3-1e5a-4b34-b43f-c3d23ee7218a@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Armin,

On 8/26/24 10:09 PM, Armin Wolf wrote:
> Am 19.08.24 um 13:37 schrieb Hans de Goede:
> 
>> Hi,
>>
>> On 8/13/24 4:29 AM, Armin Wolf wrote:
>>> The LEGX0820 ACPI device is expected to provide a custom operation
>>> region:
>>>
>>>     OperationRegion (XIN1, 0x8F, Zero, 0x04B0)
>>>          Field (XIN1, AnyAcc, Lock, Preserve)
>>>          {
>>>              DMSG,   8,
>>>              HDAP,   8,
>>>              Offset (0x03),
>>>              AFNM,   8,
>>>              Offset (0x10),
>>>              P80B,   8,
>>>              P81B,   8,
>>>              P82B,   8,
>>>              P83B,   8,
>>>              P84B,   8,
>>>              P85B,   8,
>>>              P86B,   8,
>>>              P87B,   8,
>>>              Offset (0x20),
>>>              DTTM,   8,
>>>              TMP1,   8,
>>>              LTP1,   8,
>>>              HTP1,   8,
>>>              TMP2,   8,
>>>              LTP2,   8,
>>>              HTP2,   8,
>>>              Offset (0x3E8),
>>>              PMSG,   1600
>>>          }
>>>
>>> The PMSG field is used by AML code to log debug messages when DMSG is
>>> true. Since those debug messages are already logged using the standard
>>> ACPI Debug object, we set DMSG unconditionally to 0x00 and ignore any
>>> writes to PMSG.
>>>
>>> The TMPx, LTPx, HTPx and AFNM fields are used to inform the driver when
>>> the temperature/(presumably) trip points/fan mode changes. This only
>>> happens when the DTTM flag is set.
>>>
>>> Unfortunately we have to implement support for this operation region
>>> because the AML codes uses code constructs like this one:
>>>
>>>     If (((\_SB.XINI.PLAV != Zero) && (\_SB.XINI.DTTM != Zero)))
>>>
>>> The PLAV field gets set to 1 when the driver registers its address space
>>> handler, so by default XIN1 should not be accessed.
>>>
>>> However ACPI does not use short-circuit evaluation when evaluating
>>> logical conditions. This causes the DTTM field to be accessed even
>>> when PLAV is 0, which results in an ACPI error.
>>> Since this check happens inside various thermal-related ACPI control
>>> methods, various thermal zone become unusable since any attempt to
>>> read their temperature results in an ACPI error.
>>>
>>> Fix this by providing support for this operation region. I suspect
>>> that the problem does not happen under Windows (which seemingly does
>>> not use short-circuit evaluation either) because the necessary driver
>>> comes preinstalled with the machine.
>>>
>>> Tested-by: Chris <ghostwind@gmail.com>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Regards,
>>
>> Hans
>>
> Any updates on this? I would prefer to have this merged for the upcoming 6.12 kernel since
> without this patch many LG notebooks have unusable thermal zones.

This patch has already been merged and already is in linux-next,
but I see that I forgot to send my usual email confirming that
I merged it, sorry.

Regards,

Hans




>>> ---
>>> Changes since v1:
>>>   - attempts -> attempt
>>>   - sort defines in numerical order
>>>   - make lg_laptop_address_space_write() take a plain u64
>>>   - use BITS_PER_BYTE
>>>   - manually check fw_debug when handling fan mode updates
>>> ---
>>>   drivers/platform/x86/lg-laptop.c | 136 +++++++++++++++++++++++++++++++
>>>   1 file changed, 136 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
>>> index 9c7857842caf..55d31d4fefd6 100644
>>> --- a/drivers/platform/x86/lg-laptop.c
>>> +++ b/drivers/platform/x86/lg-laptop.c
>>> @@ -8,6 +8,9 @@
>>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>
>>>   #include <linux/acpi.h>
>>> +#include <linux/bits.h>
>>> +#include <linux/device.h>
>>> +#include <linux/dev_printk.h>
>>>   #include <linux/dmi.h>
>>>   #include <linux/input.h>
>>>   #include <linux/input/sparse-keymap.h>
>>> @@ -31,6 +34,26 @@ MODULE_AUTHOR("Matan Ziv-Av");
>>>   MODULE_DESCRIPTION("LG WMI Hotkey Driver");
>>>   MODULE_LICENSE("GPL");
>>>
>>> +static bool fw_debug;
>>> +module_param(fw_debug, bool, 0);
>>> +MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
>>> +
>>> +#define LG_ADDRESS_SPACE_ID            0x8F
>>> +
>>> +#define LG_ADDRESS_SPACE_DEBUG_FLAG_ADR        0x00
>>> +#define LG_ADDRESS_SPACE_FAN_MODE_ADR        0x03
>>> +
>>> +#define LG_ADDRESS_SPACE_DTTM_FLAG_ADR        0x20
>>> +#define LG_ADDRESS_SPACE_CPU_TEMP_ADR        0x21
>>> +#define LG_ADDRESS_SPACE_CPU_TRIP_LOW_ADR    0x22
>>> +#define LG_ADDRESS_SPACE_CPU_TRIP_HIGH_ADR    0x23
>>> +#define LG_ADDRESS_SPACE_MB_TEMP_ADR        0x24
>>> +#define LG_ADDRESS_SPACE_MB_TRIP_LOW_ADR    0x25
>>> +#define LG_ADDRESS_SPACE_MB_TRIP_HIGH_ADR    0x26
>>> +
>>> +#define LG_ADDRESS_SPACE_DEBUG_MSG_START_ADR    0x3E8
>>> +#define LG_ADDRESS_SPACE_DEBUG_MSG_END_ADR    0x5E8
>>> +
>>>   #define WMI_EVENT_GUID0    "E4FB94F9-7F2B-4173-AD1A-CD1D95086248"
>>>   #define WMI_EVENT_GUID1    "023B133E-49D1-4E10-B313-698220140DC2"
>>>   #define WMI_EVENT_GUID2    "37BE1AC0-C3F2-4B1F-BFBE-8FDEAF2814D6"
>>> @@ -646,6 +669,107 @@ static struct platform_driver pf_driver = {
>>>       }
>>>   };
>>>
>>> +static acpi_status lg_laptop_address_space_write(struct device *dev, acpi_physical_address address,
>>> +                         size_t size, u64 value)
>>> +{
>>> +    u8 byte;
>>> +
>>> +    /* Ignore any debug messages */
>>> +    if (address >= LG_ADDRESS_SPACE_DEBUG_MSG_START_ADR &&
>>> +        address <= LG_ADDRESS_SPACE_DEBUG_MSG_END_ADR)
>>> +        return AE_OK;
>>> +
>>> +    if (size != sizeof(byte))
>>> +        return AE_BAD_PARAMETER;
>>> +
>>> +    byte = value & 0xFF;
>>> +
>>> +    switch (address) {
>>> +    case LG_ADDRESS_SPACE_FAN_MODE_ADR:
>>> +        /*
>>> +         * The fan mode field is not affected by the DTTM flag, so we
>>> +         * have to manually check fw_debug.
>>> +         */
>>> +        if (fw_debug)
>>> +            dev_dbg(dev, "Fan mode set to mode %u\n", byte);
>>> +
>>> +        return AE_OK;
>>> +    case LG_ADDRESS_SPACE_CPU_TEMP_ADR:
>>> +        dev_dbg(dev, "CPU temperature is %u °C\n", byte);
>>> +        return AE_OK;
>>> +    case LG_ADDRESS_SPACE_CPU_TRIP_LOW_ADR:
>>> +        dev_dbg(dev, "CPU lower trip point set to %u °C\n", byte);
>>> +        return AE_OK;
>>> +    case LG_ADDRESS_SPACE_CPU_TRIP_HIGH_ADR:
>>> +        dev_dbg(dev, "CPU higher trip point set to %u °C\n", byte);
>>> +        return AE_OK;
>>> +    case LG_ADDRESS_SPACE_MB_TEMP_ADR:
>>> +        dev_dbg(dev, "Motherboard temperature is %u °C\n", byte);
>>> +        return AE_OK;
>>> +    case LG_ADDRESS_SPACE_MB_TRIP_LOW_ADR:
>>> +        dev_dbg(dev, "Motherboard lower trip point set to %u °C\n", byte);
>>> +        return AE_OK;
>>> +    case LG_ADDRESS_SPACE_MB_TRIP_HIGH_ADR:
>>> +        dev_dbg(dev, "Motherboard higher trip point set to %u °C\n", byte);
>>> +        return AE_OK;
>>> +    default:
>>> +        dev_notice_ratelimited(dev, "Ignoring write to unknown opregion address %llu\n",
>>> +                       address);
>>> +        return AE_OK;
>>> +    }
>>> +}
>>> +
>>> +static acpi_status lg_laptop_address_space_read(struct device *dev, acpi_physical_address address,
>>> +                        size_t size, u64 *value)
>>> +{
>>> +    if (size != 1)
>>> +        return AE_BAD_PARAMETER;
>>> +
>>> +    switch (address) {
>>> +    case LG_ADDRESS_SPACE_DEBUG_FLAG_ADR:
>>> +        /* Debug messages are already printed using the standard ACPI Debug object */
>>> +        *value = 0x00;
>>> +        return AE_OK;
>>> +    case LG_ADDRESS_SPACE_DTTM_FLAG_ADR:
>>> +        *value = fw_debug;
>>> +        return AE_OK;
>>> +    default:
>>> +        dev_notice_ratelimited(dev, "Attempt to read unknown opregion address %llu\n",
>>> +                       address);
>>> +        return AE_BAD_PARAMETER;
>>> +    }
>>> +}
>>> +
>>> +static acpi_status lg_laptop_address_space_handler(u32 function, acpi_physical_address address,
>>> +                           u32 bits, u64 *value, void *handler_context,
>>> +                           void *region_context)
>>> +{
>>> +    struct device *dev = handler_context;
>>> +    size_t size;
>>> +
>>> +    if (bits % BITS_PER_BYTE)
>>> +        return AE_BAD_PARAMETER;
>>> +
>>> +    size = bits / BITS_PER_BYTE;
>>> +
>>> +    switch (function) {
>>> +    case ACPI_READ:
>>> +        return lg_laptop_address_space_read(dev, address, size, value);
>>> +    case ACPI_WRITE:
>>> +        return lg_laptop_address_space_write(dev, address, size, *value);
>>> +    default:
>>> +        return AE_BAD_PARAMETER;
>>> +    }
>>> +}
>>> +
>>> +static void lg_laptop_remove_address_space_handler(void *data)
>>> +{
>>> +    struct acpi_device *device = data;
>>> +
>>> +    acpi_remove_address_space_handler(device->handle, LG_ADDRESS_SPACE_ID,
>>> +                      &lg_laptop_address_space_handler);
>>> +}
>>> +
>>>   static int acpi_add(struct acpi_device *device)
>>>   {
>>>       struct platform_device_info pdev_info = {
>>> @@ -653,6 +777,7 @@ static int acpi_add(struct acpi_device *device)
>>>           .name = PLATFORM_NAME,
>>>           .id = PLATFORM_DEVID_NONE,
>>>       };
>>> +    acpi_status status;
>>>       int ret;
>>>       const char *product;
>>>       int year = 2017;
>>> @@ -660,6 +785,17 @@ static int acpi_add(struct acpi_device *device)
>>>       if (pf_device)
>>>           return 0;
>>>
>>> +    status = acpi_install_address_space_handler(device->handle, LG_ADDRESS_SPACE_ID,
>>> +                            &lg_laptop_address_space_handler,
>>> +                            NULL, &device->dev);
>>> +    if (ACPI_FAILURE(status))
>>> +        return -ENODEV;
>>> +
>>> +    ret = devm_add_action_or_reset(&device->dev, lg_laptop_remove_address_space_handler,
>>> +                       device);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>>       ret = platform_driver_register(&pf_driver);
>>>       if (ret)
>>>           return ret;
>>> -- 
>>> 2.39.2
>>>
>>
> 


