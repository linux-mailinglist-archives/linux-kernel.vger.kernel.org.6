Return-Path: <linux-kernel+bounces-291966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D00C956972
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26541283987
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A26166F25;
	Mon, 19 Aug 2024 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnSxAI55"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22615DBB2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067433; cv=none; b=YsF1xaaiwy//Kx1w2WJW2936q9Bmm/VhrkLK9FCSYY8es1vw8/ZyHNpKfFqkN/6+jCw3GakS3HgXiBGXajsGcC8GbAe06NJKoamFcYxRHTmcHmfT+ilfQ3HpvnxpC56YArvf/EaEW9+e98qjAy8Ub2LdqdRGEPKtbXCz3UHzvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067433; c=relaxed/simple;
	bh=opTswjUzHppgEeloIcv07JHGBQ7IAkSFD3TNPDbUU80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkmuGoJseTaxHk/KHxoYLfHhaNgjHxfnbTNZURTaJQp+rwR5ukU5aZEMZqgxZFQWmD6s+LjlXQ/DxjOxnxfROJzmN6C6Bz61VUW5uVGX3ZAqKfIv6O58dEmB+/mXL7vAyeRASC8i9+SqJV8Ia6C/FsrUPFo6Daw+6At4wEP5YbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnSxAI55; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724067429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aASggTj8zScZUAMVRuTxe/1yeuEnr9EhJsxLPCIt2Tk=;
	b=RnSxAI55+fpT80pVcHXUG3CSKEzZ82kJZdID54r/xC8//DfGt72LFlAXQd90EPE1ebMp+z
	s9RS2QCqy/z5Qnh2cN+8qphEoZTl5GOOTDWbB2RGlBu9+T1QwGC+ZFlfaFUFeE5Y/ExAIw
	4xljdJ/Dt8ODIHs5aldtQ+KJbysHt6M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-459-S7JSPxmc5c9rwcVLRg-1; Mon, 19 Aug 2024 07:37:08 -0400
X-MC-Unique: 459-S7JSPxmc5c9rwcVLRg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-530ad977cb6so4744187e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067427; x=1724672227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aASggTj8zScZUAMVRuTxe/1yeuEnr9EhJsxLPCIt2Tk=;
        b=YY/lw7dmUNW9OkAj+EIwDrF2jZpoZynsgOoXMSH8LL0vXDDzvsPtpe5L0SZbGnQaC7
         aWmzlI/ptVXo5WmP1wIqDex+ltH161w2utjT9GdE8fulPbo8D3R/e6einwQ2aHpSOXyT
         g//s5e+UfCSkvoPxaPqu5B3/XwFpzCy1i7Jd70pnjhb3nFMiknOEM74NPjFlTZAVSD9S
         ulmxDEWQNcYxcGN+/BESbSAIsaJA3V7FeRIP/K2tHRsQQvVs5ZBqpcUPsbMP4HeCCgKb
         QnJw/bjUVLdQUhHw1Q+OvRlaEWHj7TlldjhBNoNObfl3ossQEq5F1RIW8a2ickR2I2CI
         1g3g==
X-Forwarded-Encrypted: i=1; AJvYcCUrwplu+BVaHqDlFMHeg/208t4Rc99hJP8zWK6vBLrZ88tYNGPlYG73FMCX6Vec4fHGxTwkqUPLlR5oVGOJmxy0tAfr4+AK1ifHsejW
X-Gm-Message-State: AOJu0YzijYqzKP6H7i6YPcYGPj8pGyi0sa4VnEi818LA9+Il4gA8BxvB
	ELRKVk4X1WuTFRIONRse9cYhtWAthcNFZRdxIWZ5uGZMZRDR0HFGASwFK8ybIiE+evGrEPsbmqD
	shjGoc249X1QCahS9pi3mziCk63aYmk455an58MddbCC2DF/rLTp8XsmOLLMvXw==
X-Received: by 2002:a05:6512:3a82:b0:52e:be50:9c55 with SMTP id 2adb3069b0e04-5331c6e9741mr7698984e87.52.1724067426744;
        Mon, 19 Aug 2024 04:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIOifAQMPVPESrzfbzw8SGRMWYm/N0EKOvxL6PgC0QCoDMGgF5j2CYJuukUYvZTYYfF+aaqA==
X-Received: by 2002:a05:6512:3a82:b0:52e:be50:9c55 with SMTP id 2adb3069b0e04-5331c6e9741mr7698963e87.52.1724067426137;
        Mon, 19 Aug 2024 04:37:06 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6b07sm626920766b.30.2024.08.19.04.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:37:05 -0700 (PDT)
Message-ID: <bb7926e9-759b-4899-b616-c8c7ffcc9a55@redhat.com>
Date: Mon, 19 Aug 2024 13:37:05 +0200
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
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240813022903.20567-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/13/24 4:29 AM, Armin Wolf wrote:
> The LEGX0820 ACPI device is expected to provide a custom operation
> region:
> 
> 	OperationRegion (XIN1, 0x8F, Zero, 0x04B0)
>         Field (XIN1, AnyAcc, Lock, Preserve)
>         {
>             DMSG,   8,
>             HDAP,   8,
>             Offset (0x03),
>             AFNM,   8,
>             Offset (0x10),
>             P80B,   8,
>             P81B,   8,
>             P82B,   8,
>             P83B,   8,
>             P84B,   8,
>             P85B,   8,
>             P86B,   8,
>             P87B,   8,
>             Offset (0x20),
>             DTTM,   8,
>             TMP1,   8,
>             LTP1,   8,
>             HTP1,   8,
>             TMP2,   8,
>             LTP2,   8,
>             HTP2,   8,
>             Offset (0x3E8),
>             PMSG,   1600
>         }
> 
> The PMSG field is used by AML code to log debug messages when DMSG is
> true. Since those debug messages are already logged using the standard
> ACPI Debug object, we set DMSG unconditionally to 0x00 and ignore any
> writes to PMSG.
> 
> The TMPx, LTPx, HTPx and AFNM fields are used to inform the driver when
> the temperature/(presumably) trip points/fan mode changes. This only
> happens when the DTTM flag is set.
> 
> Unfortunately we have to implement support for this operation region
> because the AML codes uses code constructs like this one:
> 
> 	If (((\_SB.XINI.PLAV != Zero) && (\_SB.XINI.DTTM != Zero)))
> 
> The PLAV field gets set to 1 when the driver registers its address space
> handler, so by default XIN1 should not be accessed.
> 
> However ACPI does not use short-circuit evaluation when evaluating
> logical conditions. This causes the DTTM field to be accessed even
> when PLAV is 0, which results in an ACPI error.
> Since this check happens inside various thermal-related ACPI control
> methods, various thermal zone become unusable since any attempt to
> read their temperature results in an ACPI error.
> 
> Fix this by providing support for this operation region. I suspect
> that the problem does not happen under Windows (which seemingly does
> not use short-circuit evaluation either) because the necessary driver
> comes preinstalled with the machine.
> 
> Tested-by: Chris <ghostwind@gmail.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
> Changes since v1:
>  - attempts -> attempt
>  - sort defines in numerical order
>  - make lg_laptop_address_space_write() take a plain u64
>  - use BITS_PER_BYTE
>  - manually check fw_debug when handling fan mode updates
> ---
>  drivers/platform/x86/lg-laptop.c | 136 +++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
> index 9c7857842caf..55d31d4fefd6 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -8,6 +8,9 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
>  #include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
>  #include <linux/dmi.h>
>  #include <linux/input.h>
>  #include <linux/input/sparse-keymap.h>
> @@ -31,6 +34,26 @@ MODULE_AUTHOR("Matan Ziv-Av");
>  MODULE_DESCRIPTION("LG WMI Hotkey Driver");
>  MODULE_LICENSE("GPL");
> 
> +static bool fw_debug;
> +module_param(fw_debug, bool, 0);
> +MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
> +
> +#define LG_ADDRESS_SPACE_ID			0x8F
> +
> +#define LG_ADDRESS_SPACE_DEBUG_FLAG_ADR		0x00
> +#define LG_ADDRESS_SPACE_FAN_MODE_ADR		0x03
> +
> +#define LG_ADDRESS_SPACE_DTTM_FLAG_ADR		0x20
> +#define LG_ADDRESS_SPACE_CPU_TEMP_ADR		0x21
> +#define LG_ADDRESS_SPACE_CPU_TRIP_LOW_ADR	0x22
> +#define LG_ADDRESS_SPACE_CPU_TRIP_HIGH_ADR	0x23
> +#define LG_ADDRESS_SPACE_MB_TEMP_ADR		0x24
> +#define LG_ADDRESS_SPACE_MB_TRIP_LOW_ADR	0x25
> +#define LG_ADDRESS_SPACE_MB_TRIP_HIGH_ADR	0x26
> +
> +#define LG_ADDRESS_SPACE_DEBUG_MSG_START_ADR	0x3E8
> +#define LG_ADDRESS_SPACE_DEBUG_MSG_END_ADR	0x5E8
> +
>  #define WMI_EVENT_GUID0	"E4FB94F9-7F2B-4173-AD1A-CD1D95086248"
>  #define WMI_EVENT_GUID1	"023B133E-49D1-4E10-B313-698220140DC2"
>  #define WMI_EVENT_GUID2	"37BE1AC0-C3F2-4B1F-BFBE-8FDEAF2814D6"
> @@ -646,6 +669,107 @@ static struct platform_driver pf_driver = {
>  	}
>  };
> 
> +static acpi_status lg_laptop_address_space_write(struct device *dev, acpi_physical_address address,
> +						 size_t size, u64 value)
> +{
> +	u8 byte;
> +
> +	/* Ignore any debug messages */
> +	if (address >= LG_ADDRESS_SPACE_DEBUG_MSG_START_ADR &&
> +	    address <= LG_ADDRESS_SPACE_DEBUG_MSG_END_ADR)
> +		return AE_OK;
> +
> +	if (size != sizeof(byte))
> +		return AE_BAD_PARAMETER;
> +
> +	byte = value & 0xFF;
> +
> +	switch (address) {
> +	case LG_ADDRESS_SPACE_FAN_MODE_ADR:
> +		/*
> +		 * The fan mode field is not affected by the DTTM flag, so we
> +		 * have to manually check fw_debug.
> +		 */
> +		if (fw_debug)
> +			dev_dbg(dev, "Fan mode set to mode %u\n", byte);
> +
> +		return AE_OK;
> +	case LG_ADDRESS_SPACE_CPU_TEMP_ADR:
> +		dev_dbg(dev, "CPU temperature is %u °C\n", byte);
> +		return AE_OK;
> +	case LG_ADDRESS_SPACE_CPU_TRIP_LOW_ADR:
> +		dev_dbg(dev, "CPU lower trip point set to %u °C\n", byte);
> +		return AE_OK;
> +	case LG_ADDRESS_SPACE_CPU_TRIP_HIGH_ADR:
> +		dev_dbg(dev, "CPU higher trip point set to %u °C\n", byte);
> +		return AE_OK;
> +	case LG_ADDRESS_SPACE_MB_TEMP_ADR:
> +		dev_dbg(dev, "Motherboard temperature is %u °C\n", byte);
> +		return AE_OK;
> +	case LG_ADDRESS_SPACE_MB_TRIP_LOW_ADR:
> +		dev_dbg(dev, "Motherboard lower trip point set to %u °C\n", byte);
> +		return AE_OK;
> +	case LG_ADDRESS_SPACE_MB_TRIP_HIGH_ADR:
> +		dev_dbg(dev, "Motherboard higher trip point set to %u °C\n", byte);
> +		return AE_OK;
> +	default:
> +		dev_notice_ratelimited(dev, "Ignoring write to unknown opregion address %llu\n",
> +				       address);
> +		return AE_OK;
> +	}
> +}
> +
> +static acpi_status lg_laptop_address_space_read(struct device *dev, acpi_physical_address address,
> +						size_t size, u64 *value)
> +{
> +	if (size != 1)
> +		return AE_BAD_PARAMETER;
> +
> +	switch (address) {
> +	case LG_ADDRESS_SPACE_DEBUG_FLAG_ADR:
> +		/* Debug messages are already printed using the standard ACPI Debug object */
> +		*value = 0x00;
> +		return AE_OK;
> +	case LG_ADDRESS_SPACE_DTTM_FLAG_ADR:
> +		*value = fw_debug;
> +		return AE_OK;
> +	default:
> +		dev_notice_ratelimited(dev, "Attempt to read unknown opregion address %llu\n",
> +				       address);
> +		return AE_BAD_PARAMETER;
> +	}
> +}
> +
> +static acpi_status lg_laptop_address_space_handler(u32 function, acpi_physical_address address,
> +						   u32 bits, u64 *value, void *handler_context,
> +						   void *region_context)
> +{
> +	struct device *dev = handler_context;
> +	size_t size;
> +
> +	if (bits % BITS_PER_BYTE)
> +		return AE_BAD_PARAMETER;
> +
> +	size = bits / BITS_PER_BYTE;
> +
> +	switch (function) {
> +	case ACPI_READ:
> +		return lg_laptop_address_space_read(dev, address, size, value);
> +	case ACPI_WRITE:
> +		return lg_laptop_address_space_write(dev, address, size, *value);
> +	default:
> +		return AE_BAD_PARAMETER;
> +	}
> +}
> +
> +static void lg_laptop_remove_address_space_handler(void *data)
> +{
> +	struct acpi_device *device = data;
> +
> +	acpi_remove_address_space_handler(device->handle, LG_ADDRESS_SPACE_ID,
> +					  &lg_laptop_address_space_handler);
> +}
> +
>  static int acpi_add(struct acpi_device *device)
>  {
>  	struct platform_device_info pdev_info = {
> @@ -653,6 +777,7 @@ static int acpi_add(struct acpi_device *device)
>  		.name = PLATFORM_NAME,
>  		.id = PLATFORM_DEVID_NONE,
>  	};
> +	acpi_status status;
>  	int ret;
>  	const char *product;
>  	int year = 2017;
> @@ -660,6 +785,17 @@ static int acpi_add(struct acpi_device *device)
>  	if (pf_device)
>  		return 0;
> 
> +	status = acpi_install_address_space_handler(device->handle, LG_ADDRESS_SPACE_ID,
> +						    &lg_laptop_address_space_handler,
> +						    NULL, &device->dev);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	ret = devm_add_action_or_reset(&device->dev, lg_laptop_remove_address_space_handler,
> +				       device);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = platform_driver_register(&pf_driver);
>  	if (ret)
>  		return ret;
> --
> 2.39.2
> 


