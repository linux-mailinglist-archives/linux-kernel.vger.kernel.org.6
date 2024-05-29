Return-Path: <linux-kernel+bounces-193722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A6E8D3119
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8930D1C237F6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBCE169AFE;
	Wed, 29 May 2024 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTyTFzHP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE7168C37
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970924; cv=none; b=Vh8MriZug5mLnVzX4JD50HEeBI0+a41wCKTnoSI2OANwdN9bm7sZ5GxqZeGhO3twvk5QV2EBcK2TzCaOGCnW+1BHJyf5OC9BtW3JSNa4Omxol7IC07ELszWiVVGLw8+WZW3lGgAcoFJkT2DbA+MciQJtfjm/KtJXJ+BRQHmtOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970924; c=relaxed/simple;
	bh=JvJ/znY5aAJUH6CBtu3z63ozlDO6l7q/FWJId5WW5u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIw/yRRAMfdoYFIcGavPh2i7s1/4nE+TS01O2aF9Gc11YdVmUF9eNMQQC3+/0BZSC4XvJQGQFO419WcZlC+rB/kwDlSgdeaBJBU1QVUx1rsz1LlRoKje2o3cGEDeH570GBF5vUFsCiZ1DpOAiSt+S6DooVKHPF+0T8E/mpMDCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTyTFzHP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716970922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saeEBWoWqmMbGp2rBntpWc8gNzVhRyq6SnG448wWm2U=;
	b=VTyTFzHPZRos2RLOSBaFFYfjwCCvhOzyGo1YBSWSm6iZ6u+nYuNcF51R18W/kPdeUQfCYQ
	TVOFlV/wdlR7WBOn3Ct/t0T4Db9jmAsE0iFcUpEe+yBeFFF3GoItraDYDjLV3I//+XVbMf
	VOqs05CUvWOG74pVCzzU+sqU2gHUhsg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-GhGWA2WxNgKulB6T5jZW5g-1; Wed, 29 May 2024 04:22:00 -0400
X-MC-Unique: GhGWA2WxNgKulB6T5jZW5g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6265d3cb78so103803266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970919; x=1717575719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=saeEBWoWqmMbGp2rBntpWc8gNzVhRyq6SnG448wWm2U=;
        b=Bex4JrEamTsWy+njpfFDon8WP6G7EH6aAQD9Q8QTcMbFjOzjrZS/QUX8jPmI9miSig
         1K54snNi4VHLxBs4PlWDp5DBOyNAT9uS6zQ4xe1pc7k60hjfAWSMysfT8BFTb06W49tZ
         Ep9JF9v9Tsu0BQdVxPwoBzyOlfYni2A1jTpcUZUC+pFbb+lSdYlZAXkGMy+qx9tfiMPk
         ZhBF7GPM6vNc1okUMsY7/PoqZGb0BeaqyQ1VK3tlv/HMbJl/Nu5yS3QTrw2Vb8FEu4na
         p2OL1KpVVyFVnRgqP/zQuVMM5lp75RqOeQN/qnlFrn1mCMGtcevNLrEb96CB6QlZTUXW
         mQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCU0adLwl0dFFLUcG4PPaAEAslDl9KjPX+BZSVvDWWD1FgC3NEi0xLwO7+4djNqNhiAnYfCB/GTtG1Ua7su6RHa33bwZC4TyKJAhTQ9e
X-Gm-Message-State: AOJu0Yz8POzxsKwsrK4JbupT+DzoTVw1iNsJ07nIjlgfF2tH2OnixDun
	6lKDnyHJFEBqCSEka4uoaeYOvBsaRY2DQ7L6T7yj5zM4RBjCpL0AY0Yu7geSRrmdkru7Nu6cuIe
	xJp3G5vRvKwCyOZMB4EW2AqLEW/s0mQ14ApFh4BxKK1a5pZTGzQ5Dm3pSU0DlAQ==
X-Received: by 2002:a17:906:63ca:b0:a59:a9c5:e73b with SMTP id a640c23a62f3a-a62647ce012mr862583366b.46.1716970919181;
        Wed, 29 May 2024 01:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWk3/1wjwfIXsCmZeoXQBLcPsIitG9Fxniw+cXvQl5pRhA/ibqHffOsf0ZrQrhKZTXW5UaYw==
X-Received: by 2002:a17:906:63ca:b0:a59:a9c5:e73b with SMTP id a640c23a62f3a-a62647ce012mr862581266b.46.1716970918430;
        Wed, 29 May 2024 01:21:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8a742sm686508566b.153.2024.05.29.01.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 01:21:57 -0700 (PDT)
Message-ID: <fc082b9e-b6f7-457c-b9e5-6797a0285bc3@redhat.com>
Date: Wed, 29 May 2024 10:21:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] hid-asus: use hid for brightness control on
 keyboard
To: "Luke D. Jones" <luke@ljones.dev>, jikos@kernel.org
Cc: ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, bentiss@kernel.org
References: <20240529012827.146005-1-luke@ljones.dev>
 <20240529012827.146005-2-luke@ljones.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240529012827.146005-2-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Luke,

Thank you for the new version, much better.

On 5/29/24 3:28 AM, Luke D. Jones wrote:
> On almost all ASUS ROG series laptops the MCU used for the USB keyboard
> also has a HID packet used for setting the brightness. This is usually
> the same as the WMI method. But in some laptops the WMI method either
> is missing or doesn't work, so we should default to the HID control.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/hid/hid-asus.c                     |  6 ++++
>  drivers/platform/x86/asus-wmi.c            | 35 +++++++++++++++++++++-
>  include/linux/platform_data/x86/asus-wmi.h | 10 +++++++
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 02de2bf4f790..4cba8e143031 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -492,12 +492,18 @@ static void asus_kbd_backlight_work(struct work_struct *work)
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
> +	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD && asus_use_hid_led()) {
> +		hid_info(hdev, "using HID for asus::kbd_backlight\n");
> +		return false;
> +	}
> +
>  	ret = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS,
>  				       ASUS_WMI_DEVID_KBD_BACKLIGHT, 0, &value);
>  	hid_dbg(hdev, "WMI backlight check: rc %d value %x", ret, value);
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3f9b6285c9a6..54cb07c79fcf 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -144,6 +144,15 @@ module_param(fnlock_default, bool, 0444);
>  
>  static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
>  
> +static const char * const use_hid_led_matches[] = {
> +	"ROG Zephyrus",
> +	"ROG Strix",
> +	"ROG Flow",
> +	"GA403",
> +	"GU605",
> +	"RC71L",
> +};
> +
>  static int throttle_thermal_policy_write(struct asus_wmi *);
>  
>  static bool ashs_present(void)
> @@ -1642,6 +1651,29 @@ static int micmute_led_set(struct led_classdev *led_cdev,
>  	return err < 0 ? err : 0;
>  }
>  
> +bool asus_use_hid_led(void)
> +{
> +	const char *product, *board;
> +	int i;
> +
> +	product = dmi_get_system_info(DMI_PRODUCT_FAMILY);
> +	if (!product)
> +		return false;
> +
> +	board = dmi_get_system_info(DMI_BOARD_NAME);
> +	if (!board)
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(use_hid_led_matches); i++) {
> +		if (strstr(product, use_hid_led_matches[i]))
> +			return true;
> +		if (strstr(board, use_hid_led_matches[i]))
> +			return true;
> +	}
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(asus_use_hid_led);
> +

With the new helper in this form you are pretty much re-inventing
dmi_check_system().

So IMHO you should just replace use_hid_led_matches[] with
a dmi_system_id array and simplify asus_use_hid_led() to just
a single "dmi_check_system(asus_use_hid_led_dmi_ids)" call.

Using dmi_system_id-s also allows you to specify if the string
which is being matched should be matched against DMI_PRODUCT_FAMILY
or DMI_BOARD_NAME. Note the normal DMI_MATCH() macro to fill in
dmi_system_id array entries does non exact matching using strstr()
just like you do above.

Note you need to terminate the dmi_system_id array with an empty
{} entry.



>  static void asus_wmi_led_exit(struct asus_wmi *asus)
>  {
>  	led_classdev_unregister(&asus->kbd_led);
> @@ -1681,7 +1713,8 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>  			goto error;
>  	}
>  
> -	if (!kbd_led_read(asus, &led_val, NULL)) {
> +	if (!kbd_led_read(asus, &led_val, NULL) && !asus_use_hid_led()) {
> +		pr_info("using asus-wmi for asus::kbd_backlight\n");
>  		asus->kbd_led_wk = led_val;
>  		asus->kbd_led.name = "asus::kbd_backlight";
>  		asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 3eb5cd6773ad..6833035f7006 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -160,4 +160,14 @@ static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1,
>  }
>  #endif
>  
> +/* To be used by both hid-asus and asus-wmi to determine which controls kbd_brightness */
> +#if IS_ENABLED(CONFIG_ASUS_WMI)
> +bool asus_use_hid_led(void);
> +#else
> +static inline bool asus_use_hid_led(void)
> +{
> +	return true;
> +}
> +#endif
> +
>  #endif	/* __PLATFORM_DATA_X86_ASUS_WMI_H */

Regards,

Hans



