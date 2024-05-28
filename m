Return-Path: <linux-kernel+bounces-191929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9428D1636
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7C1B227B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFF313C8F0;
	Tue, 28 May 2024 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+8mJr+5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0313C3E6
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884781; cv=none; b=IYFARAb6HcjO5eO4kxHAE6Hk5D+KZ6XbH3Vz38fQxn7hYcaQ0tl5MlPkYrC8KLnU7g9x9Wpruj17kCn32yhi0IKwySPBWQ0BZQMnso7fqSFNnZJv3Bl0Kbf+Zjq90jD/hpO1g42AhpE7/etMi95iygP5ravtP/wfg+S9S8MHkQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884781; c=relaxed/simple;
	bh=4X1w2Z4sXtDos1E7KsuOTl8b2Ag/TAWDOHN0yGMtuKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ED/4swIjOsVFvT+M3JeuddCL2MnemiEa9ydJUemcssHaj+0hE3yXyfrNMCNMCaK5lwSFMyb0X92xfF5jBNLuyHIUfat2FWP43jCNmgzRR+6SsZuRZeFBti7C346TztaXCUyoyUxBahuvubo+re4AtLNWuzSwNgVEt0bxxvjY92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+8mJr+5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716884778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ywwFqFKE+W7hqEwp1bV+PdXb6Hq1Lf2enfltgy19l4=;
	b=J+8mJr+53EqPA0QtDZ6NQGqaHMqbzS8G58AKgKAgQO+z6PmMBOLKbDW/5juPFxfWKkDZGw
	NcS8MRBqL25732bSQJXhnSK72D0t+G0d1xBFTmQyzDwwqF7pBgUKd4otZLlBqIBluZ6AdG
	BJtUdMsptgfYPYefnxonJvBnagWZI8c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-m_MJ3G_KOHSlFgrbzwU66A-1; Tue, 28 May 2024 04:26:15 -0400
X-MC-Unique: m_MJ3G_KOHSlFgrbzwU66A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6270b93d0dso34474666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716884774; x=1717489574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ywwFqFKE+W7hqEwp1bV+PdXb6Hq1Lf2enfltgy19l4=;
        b=RtTqJbP3a5M8bAEk26C0yu0wcaSrxNfTcWtQns01sDnY5suSso/YuNB9Wdm9ssJFhf
         M2vDeQ8pfSluC9cj6xXLzCJwbxaflNQFBuDM7C3E/qYOLdMNmB9RQbwOHHd2fToBF2sa
         yUOY9DTmYh3DI7Muqdq7AOeUlb7rLC/lj6TA4bQ8idDGSenPr/XdNdkzDOtS4EuTRltg
         mR21dxaWJru5fu+bkRO5p/+9WWJIEJNhmz/Lzj/45YlwR+ytBA6xcx/t3V71wMSFx9c7
         cGrDlpZkcpBK8Gm835H0znlpuNf9fOZPStELeBd5k0kO/nhG5iqjy/xhB0hiImcPEEDM
         /K6A==
X-Forwarded-Encrypted: i=1; AJvYcCXuXSdr2ZtH3K4b8MbocaLjQFxeHWedTYY7HT1Pf2BtLUp8ITpPJOqC3Zxo2LyNEw6FwarcPmADUols4pMctjVe4jr7jAUHOOgJPVUc
X-Gm-Message-State: AOJu0YwBY4INVnwSvAjp6jmMOd9qyAQI6rA0WHzxCP1jRqMc7sHjxK8Y
	yfY9RVJNTSUfuIhwtUbzv5LD+jb2COliyynY5xMRe0ZDOQYXw9/F0fbip1sbmyc8fXFYR7st+jZ
	Ope9Q/Koe4Bg1FIYZggN1X7mcw+2taS1X/zlAWwnTmCeMUfTLBuY43RmO7Oqhpg==
X-Received: by 2002:a17:906:a450:b0:a59:cd00:dafb with SMTP id a640c23a62f3a-a626501c67fmr777532666b.64.1716884774080;
        Tue, 28 May 2024 01:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqtvSVXjyl+IG8JOfqayUWxkmZwin4to2IpgheMjpXnwe8JvfGOoeWVd7R451ZNw+qPP0Hdg==
X-Received: by 2002:a17:906:a450:b0:a59:cd00:dafb with SMTP id a640c23a62f3a-a626501c67fmr777530466b.64.1716884773533;
        Tue, 28 May 2024 01:26:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817afcsm586947266b.22.2024.05.28.01.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 01:26:13 -0700 (PDT)
Message-ID: <49d3ed29-b542-483b-969c-6b674a8ab0ca@redhat.com>
Date: Tue, 28 May 2024 10:26:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hid-asus: use hid for brightness control on keyboard
To: "Luke D. Jones" <luke@ljones.dev>, jikos@kernel.org
Cc: ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, bentiss@kernel.org
References: <20240528013959.14661-1-luke@ljones.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240528013959.14661-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Luke,

Thank you for the patch.

On 5/28/24 3:39 AM, Luke D. Jones wrote:
> On almost all ASUS ROG series laptops the MCU used for the USB keyboard
> also has a HID packet used for setting the brightness. This is usually
> the same as the WMI method. But in some laptops the WMI method either
> is missing or doesn't work, so we should default to the HID control.

It looks like you are doing 2 different things in 1 patch here,
please split this into 2 patches:

1. Use a different report_id for HID kbd backlight brightness control
on some models.

2. Skip registering the HID kbd backlight LED class device on some
models.

2 more remarks inline (below):

> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/hid/hid-asus.c                     | 19 ++++++++++++-
>  drivers/platform/x86/asus-wmi.c            |  3 ++-
>  include/linux/platform_data/x86/asus-wmi.h | 31 ++++++++++++++++++++++
>  3 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 02de2bf4f790..9389a3e733e3 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -101,6 +101,7 @@ struct asus_kbd_leds {
>  	unsigned int brightness;
>  	spinlock_t lock;
>  	bool removed;
> +	int report_id;
>  };
>  
>  struct asus_touchpad_info {
> @@ -473,7 +474,7 @@ static enum led_brightness asus_kbd_backlight_get(struct led_classdev *led_cdev)
>  static void asus_kbd_backlight_work(struct work_struct *work)
>  {
>  	struct asus_kbd_leds *led = container_of(work, struct asus_kbd_leds, work);
> -	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4, 0x00 };
> +	u8 buf[] = { led->report_id, 0xba, 0xc5, 0xc4, 0x00 };
>  	int ret;
>  	unsigned long flags;
>  
> @@ -492,12 +493,18 @@ static void asus_kbd_backlight_work(struct work_struct *work)
>   */
>  static bool asus_kbd_wmi_led_control_present(struct hid_device *hdev)
>  {
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
>  	u32 value;
>  	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_ASUS_WMI))
>  		return false;
>  
> +	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD && asus_use_hidraw_led()) {
> +		hid_info(hdev, "using hidraw for asus::kbd_backlight\n");
> +		return false;
> +	}
> +

You call the helper for this asus_use_hidraw_led() but to me that suggests
that when the function returns true then userspace will control the brightness
to /dev/hidraw# where as what you mean is that the in kernel HID driver will
control the brightness. So please rename the helper to asus_use_hid_led()
and for the message use:

		hid_info(hdev, "using HID for asus::kbd_backlight\n");


>  	ret = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS,
>  				       ASUS_WMI_DEVID_KBD_BACKLIGHT, 0, &value);
>  	hid_dbg(hdev, "WMI backlight check: rc %d value %x", ret, value);
> @@ -507,6 +514,12 @@ static bool asus_kbd_wmi_led_control_present(struct hid_device *hdev)
>  	return !!(value & ASUS_WMI_DSTS_PRESENCE_BIT);
>  }
>  
> +static bool asus_kbd_is_input_led(void)
> +{
> +	return dmi_match(DMI_PRODUCT_NAME, "GU605")
> +	    || dmi_match(DMI_PRODUCT_NAME, "GA403");
> +}
> +
>  static int asus_kbd_register_leds(struct hid_device *hdev)
>  {
>  	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> @@ -549,6 +562,10 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
>  	if (!drvdata->kbd_backlight)
>  		return -ENOMEM;
>  
> +	drvdata->kbd_backlight->report_id = FEATURE_KBD_REPORT_ID;
> +	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD && asus_kbd_is_input_led())
> +		drvdata->kbd_backlight->report_id = FEATURE_KBD_LED_REPORT_ID1;
> +
>  	drvdata->kbd_backlight->removed = false;
>  	drvdata->kbd_backlight->brightness = 0;
>  	drvdata->kbd_backlight->hdev = hdev;
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3f9b6285c9a6..a58df18a70ad 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1681,7 +1681,8 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>  			goto error;
>  	}
>  
> -	if (!kbd_led_read(asus, &led_val, NULL)) {
> +	if (!kbd_led_read(asus, &led_val, NULL) && !asus_use_hidraw_led()) {
> +		pr_info("using asus-wmi for asus::kbd_backlight\n");
>  		asus->kbd_led_wk = led_val;
>  		asus->kbd_led.name = "asus::kbd_backlight";
>  		asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 3eb5cd6773ad..79a50102440d 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -160,4 +160,35 @@ static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1,
>  }
>  #endif
>  
> +/* To be used by both hid-asus and asus-wmi to determine which controls kbd_brightness */
> +#if IS_REACHABLE(CONFIG_ASUS_WMI)

This should be IS_ENABLED() otherwise if hid-asus is builtin and
asus-wmi is a module then this will go to the #else when included
from hid-asus.c and thus always return true causing hid-asus to
always register the kbd_backlight LED class device.

> +static bool asus_use_hidraw_led(void)
> +{
> +	const char *product, *board;
> +
> +	product = dmi_get_system_info(DMI_PRODUCT_FAMILY);
> +	if (!product)
> +		return false;
> +
> +	/* These product ranges should all be using HID for keyboard LED */
> +	if (strstr(product, "ROG Zephyrus")
> +	|| strstr(product, "ROG Strix")
> +	|| strstr(product, "ROG Flow")
> +	|| strstr(product, "GA403")
> +	|| strstr(product, "GU605"))
> +		return true;
> +
> +	board = dmi_get_system_info(DMI_BOARD_NAME);
> +	if (!board)
> +		return false;
> +
> +	return strstr(board, "RC71L"); /* ROG Ally specific */
> +}
> +#else
> +static inline bool asus_use_hidraw_led(void)
> +{
> +	return true;
> +}
> +#endif
> +
>  #endif	/* __PLATFORM_DATA_X86_ASUS_WMI_H */

Regards,

Hans



