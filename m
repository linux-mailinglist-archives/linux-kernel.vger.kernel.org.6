Return-Path: <linux-kernel+bounces-315073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C57C96BD8B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60DABB27A14
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210FD1D79B4;
	Wed,  4 Sep 2024 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDxlaMvS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB793145FE8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454947; cv=none; b=VScJlElfdg1u8X30eh2Ls/uQ7u0weHSJJ1P2G7y2J4KPuZEcegKouPfLf5Sbn2NdU9eQse/pw8ddPT1ZZA3rCvPA171p8dWMEKdEhnePiKxFQunF3mJ5eknBlV0Uh8Qyqn3NAeysf0P/m2p3ugvsGDrUbRYif34+TuVLtMc9CmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454947; c=relaxed/simple;
	bh=yfAlLUPdYgkWlydetgsD7S8oeIlwwHCDxJ0Ma/5DWnw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J1oUxAVUsrHh27akl0WzZC7Cnl/Riys8/YmbGKq2gEOTHXRpntfXPYcnmwNxGl6ERRki8wX5BFL/N7KBzEDhEJ8re1Jzlq8DuqMMNPPAhXu9a5/69XKkcx4DkME62p9h8O9PeMYghVHXY7OaBqLFevSS4/6qx9wpiK0z6LH2oEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDxlaMvS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725454943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rquqH2GpYKVUboHuydKsrQdy/LdupuH0w1VMXQA70h8=;
	b=gDxlaMvSmu+C3GRo70I5FscP+mZ2c9D7853E4K6UyO03Otg9q+hdF8YQy0ZENYDy7Vokrx
	6xKfs05ny2A1fg3kiWZ/0feeJi8fo2JJm0rwSfIyYxHVij1C5U5A7vIbgT9/PVs9TvbfFe
	Fc7Uo3Xw3iPSchRFYs80UANigYESCcc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Ov7_h3WsN2SiZoHqSVTNgQ-1; Wed, 04 Sep 2024 09:02:22 -0400
X-MC-Unique: Ov7_h3WsN2SiZoHqSVTNgQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f3fc9d8c00so65084531fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725454941; x=1726059741;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rquqH2GpYKVUboHuydKsrQdy/LdupuH0w1VMXQA70h8=;
        b=mh4/8TFXytRnG3IZ29yMaTGX0xYMzXD79M23PN9hj+rvRqOEfTcSCvb3ox+y4WdNZS
         9AcZRdLUxy/IBH8oTynVynEtegSDv2HxVyZehbSaid7VNdFFhvde1UvPTcJyR5jvoyp0
         yi4xR3Y2/dT4h73l6Xezcxx/8LU+vVeZO98GuZxZIRhgz+fg9EcwCTOGXKi4Ah1vj8Y1
         g6aQPJUI2fC/B/q0Ib4LE72o1KHAZNhR8VQ0EZwYTwKIxjkIPuKOf9ZrMNxVJysWO6tO
         zBlZE5os0senN0eBrSDdxVkE3EGvPIaeV0ITZ+MMCumKUJ04gtA3FXL8/57YupsThrtF
         hKGA==
X-Forwarded-Encrypted: i=1; AJvYcCXXgy0xyGpcBiMUB9fPdSQp+4+Po22db1FQE/EDtaUtcgTC77iU2hk1Ka9bTHbJ3XGxun50aOujaoQBElM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytVhxKuLfH1QDrWkO50dYWQ0tEaInzoQi0zw6jqCd3yPa3uYQi
	f6EMD+cFcdrq7R0GKych/mupiqyUXWRKq7j44evdaevWQolvF0NW0egkniRDDPuszBQn4yj8SvE
	iUS6nG3Xsg/KOrwCfuiJM9tJstV4IAQRnGEjdX2/GfAoZB/XfyDzyOdgUz70OtQ==
X-Received: by 2002:a05:6512:b8c:b0:52e:be84:225c with SMTP id 2adb3069b0e04-53546b41b40mr12769239e87.33.1725454940410;
        Wed, 04 Sep 2024 06:02:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbCYi4zgq2wawAyqwkl3DXCvDi6USN/EuWuYy5QXj7ikNxn6YSAVbT/8ZN4zFnAUHVo8/Zpw==
X-Received: by 2002:a05:6512:b8c:b0:52e:be84:225c with SMTP id 2adb3069b0e04-53546b41b40mr12769062e87.33.1725454938785;
        Wed, 04 Sep 2024 06:02:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196bc4sm805630066b.125.2024.09.04.06.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:02:17 -0700 (PDT)
Message-ID: <595fe328-b226-4db5-a424-bf07ad1890b4@redhat.com>
Date: Wed, 4 Sep 2024 15:02:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/platform/geode: switch GPIO buttons and LEDs to
 software properties
From: Hans de Goede <hdegoede@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mark Gross <mgross@linux.intel.com>, Linus Walleij
 <linus.walleij@linaro.org>, Borislav Petkov <bp@alien8.de>
Cc: linux-geode@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <ZsV6MNS_tUPPSffJ@google.com>
 <a2366dcc-908e-41e9-875e-529610682dc1@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <a2366dcc-908e-41e9-875e-529610682dc1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/21/24 12:15 PM, Hans de Goede wrote:
> Hi Dmitry,
> 
> On 8/21/24 7:25 AM, Dmitry Torokhov wrote:
>> Convert GPIO-connected buttons and LEDs in Geode boards to software
>> nodes/properties, so that support for platform data can be removed from
>> gpio-keys driver (which will rely purely on generic device properties
>> for configuration).
>>
>> To avoid repeating the same data structures over and over and over
>> factor them out into a new geode-common.c file.
>>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Question has this been tested on at least 1 affected device ?

Since no one has stepped up to test this I was thinking I might
just as well merge it.

But I just noticed that these files are under arch/x86/platform
rather then under drivers/platform/x86 ...

So I guess this should be picked up by the x86/tip folks.

Or I can merge it through platform-drivers-x86.git/for-next
with an ack from one of the x86 maintainers.

Regards,
 
Hans




>> ---
>>  arch/x86/Kconfig                       |   6 +
>>  arch/x86/platform/geode/Makefile       |   1 +
>>  arch/x86/platform/geode/alix.c         |  82 ++---------
>>  arch/x86/platform/geode/geode-common.c | 180 +++++++++++++++++++++++++
>>  arch/x86/platform/geode/geode-common.h |  21 +++
>>  arch/x86/platform/geode/geos.c         |  80 +----------
>>  arch/x86/platform/geode/net5501.c      |  69 +---------
>>  7 files changed, 230 insertions(+), 209 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 09f8fbcfe000..96b02e813332 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -3073,9 +3073,13 @@ config OLPC_XO15_SCI
>>  	   - AC adapter status updates
>>  	   - Battery status updates
>>  
>> +config GEODE_COMMON
>> +	bool
>> +
>>  config ALIX
>>  	bool "PCEngines ALIX System Support (LED setup)"
>>  	select GPIOLIB
>> +	select GEODE_COMMON
>>  	help
>>  	  This option enables system support for the PCEngines ALIX.
>>  	  At present this just sets up LEDs for GPIO control on
>> @@ -3090,12 +3094,14 @@ config ALIX
>>  config NET5501
>>  	bool "Soekris Engineering net5501 System Support (LEDS, GPIO, etc)"
>>  	select GPIOLIB
>> +	select GEODE_COMMON
>>  	help
>>  	  This option enables system support for the Soekris Engineering net5501.
>>  
>>  config GEOS
>>  	bool "Traverse Technologies GEOS System Support (LEDS, GPIO, etc)"
>>  	select GPIOLIB
>> +	select GEODE_COMMON
>>  	depends on DMI
>>  	help
>>  	  This option enables system support for the Traverse Technologies GEOS.
>> diff --git a/arch/x86/platform/geode/Makefile b/arch/x86/platform/geode/Makefile
>> index a8a6b1dedb01..34b53e97a0ad 100644
>> --- a/arch/x86/platform/geode/Makefile
>> +++ b/arch/x86/platform/geode/Makefile
>> @@ -1,4 +1,5 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>> +obj-$(CONFIG_GEODE_COMMON)	+= geode-common.o
>>  obj-$(CONFIG_ALIX)		+= alix.o
>>  obj-$(CONFIG_NET5501)		+= net5501.o
>>  obj-$(CONFIG_GEOS)		+= geos.o
>> diff --git a/arch/x86/platform/geode/alix.c b/arch/x86/platform/geode/alix.c
>> index b39bf3b5e108..be65cd704e21 100644
>> --- a/arch/x86/platform/geode/alix.c
>> +++ b/arch/x86/platform/geode/alix.c
>> @@ -18,15 +18,12 @@
>>  #include <linux/io.h>
>>  #include <linux/string.h>
>>  #include <linux/moduleparam.h>
>> -#include <linux/leds.h>
>> -#include <linux/platform_device.h>
>> -#include <linux/input.h>
>> -#include <linux/gpio_keys.h>
>> -#include <linux/gpio/machine.h>
>>  #include <linux/dmi.h>
>>  
>>  #include <asm/geode.h>
>>  
>> +#include "geode-common.h"
>> +
>>  #define BIOS_SIGNATURE_TINYBIOS		0xf0000
>>  #define BIOS_SIGNATURE_COREBOOT		0x500
>>  #define BIOS_REGION_SIZE		0x10000
>> @@ -41,79 +38,16 @@ module_param(force, bool, 0444);
>>  /* FIXME: Award bios is not automatically detected as Alix platform */
>>  MODULE_PARM_DESC(force, "Force detection as ALIX.2/ALIX.3 platform");
>>  
>> -static struct gpio_keys_button alix_gpio_buttons[] = {
>> -	{
>> -		.code			= KEY_RESTART,
>> -		.gpio			= 24,
>> -		.active_low		= 1,
>> -		.desc			= "Reset button",
>> -		.type			= EV_KEY,
>> -		.wakeup			= 0,
>> -		.debounce_interval	= 100,
>> -		.can_disable		= 0,
>> -	}
>> -};
>> -static struct gpio_keys_platform_data alix_buttons_data = {
>> -	.buttons			= alix_gpio_buttons,
>> -	.nbuttons			= ARRAY_SIZE(alix_gpio_buttons),
>> -	.poll_interval			= 20,
>> -};
>> -
>> -static struct platform_device alix_buttons_dev = {
>> -	.name				= "gpio-keys-polled",
>> -	.id				= 1,
>> -	.dev = {
>> -		.platform_data		= &alix_buttons_data,
>> -	}
>> -};
>> -
>> -static struct gpio_led alix_leds[] = {
>> -	{
>> -		.name = "alix:1",
>> -		.default_trigger = "default-on",
>> -	},
>> -	{
>> -		.name = "alix:2",
>> -		.default_trigger = "default-off",
>> -	},
>> -	{
>> -		.name = "alix:3",
>> -		.default_trigger = "default-off",
>> -	},
>> -};
>> -
>> -static struct gpio_led_platform_data alix_leds_data = {
>> -	.num_leds = ARRAY_SIZE(alix_leds),
>> -	.leds = alix_leds,
>> -};
>> -
>> -static struct gpiod_lookup_table alix_leds_gpio_table = {
>> -	.dev_id = "leds-gpio",
>> -	.table = {
>> -		/* The Geode GPIOs should be on the CS5535 companion chip */
>> -		GPIO_LOOKUP_IDX("cs5535-gpio", 6, NULL, 0, GPIO_ACTIVE_LOW),
>> -		GPIO_LOOKUP_IDX("cs5535-gpio", 25, NULL, 1, GPIO_ACTIVE_LOW),
>> -		GPIO_LOOKUP_IDX("cs5535-gpio", 27, NULL, 2, GPIO_ACTIVE_LOW),
>> -		{ }
>> -	},
>> -};
>> -
>> -static struct platform_device alix_leds_dev = {
>> -	.name = "leds-gpio",
>> -	.id = -1,
>> -	.dev.platform_data = &alix_leds_data,
>> -};
>> -
>> -static struct platform_device *alix_devs[] __initdata = {
>> -	&alix_buttons_dev,
>> -	&alix_leds_dev,
>> +static const struct geode_led alix_leds[] __initconst = {
>> +	{ 6, true },
>> +	{ 25, false },
>> +	{ 27, false },
>>  };
>>  
>>  static void __init register_alix(void)
>>  {
>> -	/* Setup LED control through leds-gpio driver */
>> -	gpiod_add_lookup_table(&alix_leds_gpio_table);
>> -	platform_add_devices(alix_devs, ARRAY_SIZE(alix_devs));
>> +	geode_create_restart_key(24);
>> +	geode_create_leds("alix", alix_leds, ARRAY_SIZE(alix_leds));
>>  }
>>  
>>  static bool __init alix_present(unsigned long bios_phys,
>> diff --git a/arch/x86/platform/geode/geode-common.c b/arch/x86/platform/geode/geode-common.c
>> new file mode 100644
>> index 000000000000..8f365388cfbb
>> --- /dev/null
>> +++ b/arch/x86/platform/geode/geode-common.c
>> @@ -0,0 +1,180 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Shared helpers to register GPIO-connected buttons and LEDs
>> + * on AMD Geode boards.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/gpio/machine.h>
>> +#include <linux/gpio/property.h>
>> +#include <linux/input.h>
>> +#include <linux/leds.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#include "geode-common.h"
>> +
>> +const struct software_node geode_gpiochip_node = {
>> +	.name = "cs5535-gpio",
>> +};
>> +
>> +static const struct property_entry geode_gpio_keys_props[] = {
>> +	PROPERTY_ENTRY_U32("poll-interval", 20),
>> +	{ }
>> +};
>> +
>> +static const struct software_node geode_gpio_keys_node = {
>> +	.name = "geode-gpio-keys",
>> +	.properties = geode_gpio_keys_props,
>> +};
>> +
>> +static struct property_entry geode_restart_key_props[] = {
>> +	{ /* Placeholder for GPIO property */ },
>> +	PROPERTY_ENTRY_U32("linux,code", KEY_RESTART),
>> +	PROPERTY_ENTRY_STRING("label", "Reset button"),
>> +	PROPERTY_ENTRY_U32("debounce-interval", 100),
>> +	{ }
>> +};
>> +
>> +static const struct software_node geode_restart_key_node = {
>> +	.parent = &geode_gpio_keys_node,
>> +	.properties = geode_restart_key_props,
>> +};
>> +
>> +static const struct software_node *geode_gpio_keys_swnodes[] __initconst = {
>> +	&geode_gpiochip_node,
>> +	&geode_gpio_keys_node,
>> +	&geode_restart_key_node,
>> +	NULL
>> +};
>> +
>> +/*
>> + * Creates gpio-keys-polled device for the restart key.
>> + *
>> + * Note that it needs to be called first, before geode_create_leds(),
>> + * because it registers gpiochip software node used by both gpio-keys and
>> + * leds-gpio devices.
>> + */
>> +int __init geode_create_restart_key(unsigned int pin)
>> +{
>> +	struct platform_device_info keys_info = {
>> +		.name	= "gpio-keys-polled",
>> +		.id	= 1,
>> +	};
>> +	struct platform_device *pd;
>> +	int err;
>> +
>> +	geode_restart_key_props[0] = PROPERTY_ENTRY_GPIO("gpios",
>> +							 &geode_gpiochip_node,
>> +							 pin, GPIO_ACTIVE_LOW);
>> +
>> +	err = software_node_register_node_group(geode_gpio_keys_swnodes);
>> +	if (err) {
>> +		pr_err("failed to register gpio-keys software nodes: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	keys_info.fwnode = software_node_fwnode(&geode_gpio_keys_node);
>> +
>> +	pd = platform_device_register_full(&keys_info);
>> +	err = PTR_ERR_OR_ZERO(pd);
>> +	if (err) {
>> +		pr_err("failed to create gpio-keys device: %d\n", err);
>> +		software_node_unregister_node_group(geode_gpio_keys_swnodes);
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct software_node geode_gpio_leds_node = {
>> +	.name = "geode-leds",
>> +};
>> +
>> +#define MAX_LEDS	3
>> +
>> +int __init geode_create_leds(const char *label, const struct geode_led *leds,
>> +			      unsigned int n_leds)
>> +{
>> +	const struct software_node *group[MAX_LEDS + 2] = { 0 };
>> +	struct software_node *swnodes;
>> +	struct property_entry *props;
>> +	struct platform_device_info led_info = {
>> +		.name	= "leds-gpio",
>> +		.id	= PLATFORM_DEVID_NONE,
>> +	};
>> +	struct platform_device *led_dev;
>> +	const char *node_name;
>> +	int err;
>> +	int i;
>> +
>> +	if (n_leds > MAX_LEDS) {
>> +		pr_err("%s: too many LEDs\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	swnodes = kcalloc(n_leds, sizeof(*swnodes), GFP_KERNEL);
>> +	if (!swnodes)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Each LED is represented by 3 properties: "gpios",
>> +	 * "linux,default-trigger", and am empty terminator.
>> +	 */
>> +	props = kcalloc(n_leds * 3, sizeof(*props), GFP_KERNEL);
>> +	if (!props) {
>> +		err = -ENOMEM;
>> +		goto err_free_swnodes;
>> +	}
>> +
>> +	group[0] = &geode_gpio_leds_node;
>> +	for (i = 0; i < n_leds; i++) {
>> +		node_name = kasprintf(GFP_KERNEL, "%s:%d", label, i);
>> +		if (!node_name) {
>> +			err = -ENOMEM;
>> +			goto err_free_names;
>> +		}
>> +
>> +		props[i * 3 + 0] =
>> +			PROPERTY_ENTRY_GPIO("gpios", &geode_gpiochip_node,
>> +					    leds[i].pin, GPIO_ACTIVE_LOW);
>> +		props[i * 3 + 1] =
>> +			PROPERTY_ENTRY_STRING("linux,default-trigger",
>> +					      leds[i].default_on ?
>> +					      "default-on" : "default-off");
>> +		/* props[i * 3 + 2] is an empty terminator */
>> +
>> +		swnodes[i] = SOFTWARE_NODE(node_name, &props[i * 3],
>> +					   &geode_gpio_leds_node);
>> +		group[i + 1] = &swnodes[i];
>> +	}
>> +
>> +	err = software_node_register_node_group(group);
>> +	if (err) {
>> +		pr_err("failed to register LED software nodes: %d\n", err);
>> +		goto err_free_names;
>> +	}
>> +
>> +	led_info.fwnode = software_node_fwnode(&geode_gpio_leds_node);
>> +
>> +	led_dev = platform_device_register_full(&led_info);
>> +	err = PTR_ERR_OR_ZERO(led_dev);
>> +	if (err) {
>> +		pr_err("failed to create LED device: %d\n", err);
>> +		goto err_unregister_group;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_unregister_group:
>> +	software_node_unregister_node_group(group);
>> +err_free_names:
>> +	while (--i >= 0)
>> +		kfree(swnodes[i].name);
>> +	kfree(props);
>> +err_free_swnodes:
>> +	kfree(swnodes);
>> +	return err;
>> +}
>> +
>> +
>> diff --git a/arch/x86/platform/geode/geode-common.h b/arch/x86/platform/geode/geode-common.h
>> new file mode 100644
>> index 000000000000..9e0afd34bfad
>> --- /dev/null
>> +++ b/arch/x86/platform/geode/geode-common.h
>> @@ -0,0 +1,21 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Shared helpers to register GPIO-connected buttons and LEDs
>> + * on AMD Geode boards.
>> + */
>> +
>> +#ifndef __PLATFORM_GEODE_COMMON_H
>> +#define __PLATFORM_GEODE_COMMON_H
>> +
>> +#include <linux/property.h>
>> +
>> +struct geode_led {
>> +	unsigned int pin;
>> +	bool default_on;
>> +};
>> +
>> +int geode_create_restart_key(unsigned int pin);
>> +int geode_create_leds(const char *label, const struct geode_led *leds,
>> +		      unsigned int n_leds);
>> +
>> +#endif /* __PLATFORM_GEODE_COMMON_H */
>> diff --git a/arch/x86/platform/geode/geos.c b/arch/x86/platform/geode/geos.c
>> index d263528c90bb..98027fb1ec32 100644
>> --- a/arch/x86/platform/geode/geos.c
>> +++ b/arch/x86/platform/geode/geos.c
>> @@ -16,88 +16,22 @@
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>>  #include <linux/string.h>
>> -#include <linux/leds.h>
>> -#include <linux/platform_device.h>
>> -#include <linux/input.h>
>> -#include <linux/gpio_keys.h>
>> -#include <linux/gpio/machine.h>
>>  #include <linux/dmi.h>
>>  
>>  #include <asm/geode.h>
>>  
>> -static struct gpio_keys_button geos_gpio_buttons[] = {
>> -	{
>> -		.code = KEY_RESTART,
>> -		.gpio = 3,
>> -		.active_low = 1,
>> -		.desc = "Reset button",
>> -		.type = EV_KEY,
>> -		.wakeup = 0,
>> -		.debounce_interval = 100,
>> -		.can_disable = 0,
>> -	}
>> -};
>> -static struct gpio_keys_platform_data geos_buttons_data = {
>> -	.buttons = geos_gpio_buttons,
>> -	.nbuttons = ARRAY_SIZE(geos_gpio_buttons),
>> -	.poll_interval = 20,
>> -};
>> -
>> -static struct platform_device geos_buttons_dev = {
>> -	.name = "gpio-keys-polled",
>> -	.id = 1,
>> -	.dev = {
>> -		.platform_data = &geos_buttons_data,
>> -	}
>> -};
>> -
>> -static struct gpio_led geos_leds[] = {
>> -	{
>> -		.name = "geos:1",
>> -		.default_trigger = "default-on",
>> -	},
>> -	{
>> -		.name = "geos:2",
>> -		.default_trigger = "default-off",
>> -	},
>> -	{
>> -		.name = "geos:3",
>> -		.default_trigger = "default-off",
>> -	},
>> -};
>> -
>> -static struct gpio_led_platform_data geos_leds_data = {
>> -	.num_leds = ARRAY_SIZE(geos_leds),
>> -	.leds = geos_leds,
>> -};
>> -
>> -static struct gpiod_lookup_table geos_leds_gpio_table = {
>> -	.dev_id = "leds-gpio",
>> -	.table = {
>> -		/* The Geode GPIOs should be on the CS5535 companion chip */
>> -		GPIO_LOOKUP_IDX("cs5535-gpio", 6, NULL, 0, GPIO_ACTIVE_LOW),
>> -		GPIO_LOOKUP_IDX("cs5535-gpio", 25, NULL, 1, GPIO_ACTIVE_LOW),
>> -		GPIO_LOOKUP_IDX("cs5535-gpio", 27, NULL, 2, GPIO_ACTIVE_LOW),
>> -		{ }
>> -	},
>> -};
>> -
>> -static struct platform_device geos_leds_dev = {
>> -	.name = "leds-gpio",
>> -	.id = -1,
>> -	.dev.platform_data = &geos_leds_data,
>> -};
>> +#include "geode-common.h"
>>  
>> -static struct platform_device *geos_devs[] __initdata = {
>> -	&geos_buttons_dev,
>> -	&geos_leds_dev,
>> +static const struct geode_led geos_leds[] __initconst = {
>> +	{ 6, true },
>> +	{ 25, false },
>> +	{ 27, false },
>>  };
>>  
>>  static void __init register_geos(void)
>>  {
>> -	/* Setup LED control through leds-gpio driver */
>> -	gpiod_add_lookup_table(&geos_leds_gpio_table);
>> -	platform_add_devices(geos_devs, ARRAY_SIZE(geos_devs));
>> +	geode_create_restart_key(3);
>> +	geode_create_leds("geos", geos_leds, ARRAY_SIZE(geos_leds));
>>  }
>>  
>>  static int __init geos_init(void)
>> diff --git a/arch/x86/platform/geode/net5501.c b/arch/x86/platform/geode/net5501.c
>> index 558384acd777..c9cee7dea99b 100644
>> --- a/arch/x86/platform/geode/net5501.c
>> +++ b/arch/x86/platform/geode/net5501.c
>> @@ -16,80 +16,25 @@
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>>  #include <linux/string.h>
>> -#include <linux/leds.h>
>> -#include <linux/platform_device.h>
>>  #include <linux/input.h>
>> -#include <linux/gpio_keys.h>
>>  #include <linux/gpio/machine.h>
>> +#include <linux/gpio/property.h>
>>  
>>  #include <asm/geode.h>
>>  
>> +#include "geode-common.h"
>> +
>>  #define BIOS_REGION_BASE		0xffff0000
>>  #define BIOS_REGION_SIZE		0x00010000
>>  
>> -static struct gpio_keys_button net5501_gpio_buttons[] = {
>> -	{
>> -		.code = KEY_RESTART,
>> -		.gpio = 24,
>> -		.active_low = 1,
>> -		.desc = "Reset button",
>> -		.type = EV_KEY,
>> -		.wakeup = 0,
>> -		.debounce_interval = 100,
>> -		.can_disable = 0,
>> -	}
>> -};
>> -static struct gpio_keys_platform_data net5501_buttons_data = {
>> -	.buttons = net5501_gpio_buttons,
>> -	.nbuttons = ARRAY_SIZE(net5501_gpio_buttons),
>> -	.poll_interval = 20,
>> -};
>> -
>> -static struct platform_device net5501_buttons_dev = {
>> -	.name = "gpio-keys-polled",
>> -	.id = 1,
>> -	.dev = {
>> -		.platform_data = &net5501_buttons_data,
>> -	}
>> -};
>> -
>> -static struct gpio_led net5501_leds[] = {
>> -	{
>> -		.name = "net5501:1",
>> -		.default_trigger = "default-on",
>> -	},
>> -};
>> -
>> -static struct gpio_led_platform_data net5501_leds_data = {
>> -	.num_leds = ARRAY_SIZE(net5501_leds),
>> -	.leds = net5501_leds,
>> -};
>> -
>> -static struct gpiod_lookup_table net5501_leds_gpio_table = {
>> -	.dev_id = "leds-gpio",
>> -	.table = {
>> -		/* The Geode GPIOs should be on the CS5535 companion chip */
>> -		GPIO_LOOKUP_IDX("cs5535-gpio", 6, NULL, 0, GPIO_ACTIVE_HIGH),
>> -		{ }
>> -	},
>> -};
>> -
>> -static struct platform_device net5501_leds_dev = {
>> -	.name = "leds-gpio",
>> -	.id = -1,
>> -	.dev.platform_data = &net5501_leds_data,
>> -};
>> -
>> -static struct platform_device *net5501_devs[] __initdata = {
>> -	&net5501_buttons_dev,
>> -	&net5501_leds_dev,
>> +static const struct geode_led net5501_leds[] __initconst = {
>> +	{ 6, true },
>>  };
>>  
>>  static void __init register_net5501(void)
>>  {
>> -	/* Setup LED control through leds-gpio driver */
>> -	gpiod_add_lookup_table(&net5501_leds_gpio_table);
>> -	platform_add_devices(net5501_devs, ARRAY_SIZE(net5501_devs));
>> +	geode_create_restart_key(24);
>> +	geode_create_leds("net5501", net5501_leds, ARRAY_SIZE(net5501_leds));
>>  }
>>  
>>  struct net5501_board {
> 


