Return-Path: <linux-kernel+bounces-512591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C83BA33B48
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E143A28FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7683020CCEF;
	Thu, 13 Feb 2025 09:33:04 +0000 (UTC)
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00FC2063E1;
	Thu, 13 Feb 2025 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439183; cv=none; b=HJaUqRfOrouT1jB5Vlo7i8rkdCiO4inU8VOJ2gpn7+WnP9xwRKUzKx1q4IQfGuIX51rQyzUwiO3SK69HuoqDlaoIrCJLxwsJ6FsxcXNmP9bGfWSAYniS+Z87XWPEtSmppwzBzPUWJyqIEaovR3i8KBOUELUVO3q7vl0n0tQF2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439183; c=relaxed/simple;
	bh=bp+oi3WMgZPp+ksNcbSEcNDGxzLp5wDS+tuiXvMbhvw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nd9owuoM3FA4ObkAOpFWdEXM/Qk50pRr7yNSQgzyhIkoqIANtBp1O6SoiDf3yPh1Y3C1kMWNcyp4S6HtTwjcV64CjbzaOwlHM6C3dPcF8DV5zoHVHAmcxreYb/V29yMpzKfcOewooQnI6tYDczUlZqWrNaZVeAhLUF7LAFeeWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from [10.103.132.232] (unknown[123.114.236.252])
	by rmsmtp-lg-appmail-40-12054 (RichMail) with SMTP id 2f1667adbc3e348-478aa;
	Thu, 13 Feb 2025 17:32:49 +0800 (CST)
X-RM-TRANSID:2f1667adbc3e348-478aa
Message-ID: <edc9efc7-e96b-44cc-98c6-48eabb53b83c@139.com>
Date: Thu, 13 Feb 2025 17:32:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jackie Dong <xy-jackie@139.com>
Subject: Re: [PATCH v5] platform/x86: lenovo-super-hotkey-wmi.c: Support
 formic and audio mute LEDs
To: Kurt Borja <kuurtb@gmail.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dongeg1@lenovo.com, Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20250212070154.5333-1-xy-jackie@139.com>
 <D7QNJ79F513X.FYQCGSC9M3KG@gmail.com>
Content-Language: en-US
In-Reply-To: <D7QNJ79F513X.FYQCGSC9M3KG@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kurt,
    Thanks for your careful review and new comments which are helpful 
for me to understand maintainers ideas, pls review my comments as below.
    I'll submit a new revison of the patch after get your feedback.
On 2/13/25 01:43, Kurt Borja wrote:
> Hi Jackie,
> 
> I left some style recommendations below and a couple questions. I
> apologize for not including this in the last review.
> 
> On Wed Feb 12, 2025 at 2:01 AM -05, Jackie Dong wrote:
>> Implement Lenovo utility data WMI calls needed to make LEDs
>> work on Ideapads that support this GUID.
>> This enables the mic and audio LEDs to be updated correctly.
>>
>> Tested on below samples.
>> ThinkBook 13X Gen4 IMH
>> ThinkBook 14 G6 ABP
>> ThinkBook 16p Gen4-21J8
>> ThinkBook 16 G8 IRL
>> ThinkBook 16 G7+ ASP
>>
>> Signed-off-by: Jackie Dong <xy-jackie@139.com>
>> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>> Changes in v5:
>>   - Take out union acpi_object *obj __free(kfree) = output.pointer from
>>     if-else block
>>   - Remove lsk_wmi_context_lud_keys related source code
>>
>> Changes in v4:
>>   - Add related head files include cleanup.h, dev_printk.h, device.h,
>>     module.h
>>   - Replaced kfree() by __free()
>>   - Remove double free for obj
>>   - Remove wpriv->cdev[led_type].dev = dev
>>   - Remove *wpriv = *(const struct lenovo_super_hotkey_wmi_private *)context
>>   - Remove wpriv->event == LSH_WMI_EVENT_LUD_KEYS
>>   - Remove lenovo_super_hotkey_wmi_remove() for unnecessary
>>
>> Changes in v3:
>>   - Changed the name of the Kconfig entry to LENOVO_SUPER_HOTKEY_WMI
>>   - Renamed everything in this driver which contains the name "ideapad"
>>     to instead contain the name of this driver.
>>   - Moved struct wmi_device *led_wdev in lenovo_super_hotkey_wmi_private,
>>     and use container_of() to the led_wdev pointer.
>>   - Replaced sizeof(struct wmi_led_args) by sizeof(led_arg)
>>   - Added condtions checking for obj && obj->type == ACPI_TYPE_INTEGER
>>     and free the ACPI object after get the required value.
>>   - Removed led_classdev_unregister() after led_reg_failed label, but
>>     add lenovo_super_hotkey_wmi_remove(struct wmi_device *wdev) to free
>>     resource.
>>   - Removed IDEAPAD_WMI_EVENT_FN_KEYS/IDEAPAD_WMI_EVENT_LUD_KEYS related
>>     source codes and only keep LUD_WMI_METHOD_GUID.
>>
>> Changes in v2:
>>   - Update code layout and formatting as recommended in review
>>   - Improved error handling in ideapad_wmi_led_init
>>   - Separated a WMI driver named lenovo-super-hotkey-wmi.c from
>>     ideapad-lap.c, it's only for Lenovo Super Hotkey WMI devices.
>>
>>   drivers/platform/x86/Kconfig                  |   9 +
>>   drivers/platform/x86/Makefile                 |   1 +
>>   .../platform/x86/lenovo-super-hotkey-wmi.c    | 222 ++++++++++++++++++
>>   3 files changed, 232 insertions(+)
>>   create mode 100644 drivers/platform/x86/lenovo-super-hotkey-wmi.c
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 0258dd879d64..c1792e8f04e1 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -475,6 +475,15 @@ config IDEAPAD_LAPTOP
>>   	  This is a driver for Lenovo IdeaPad netbooks contains drivers for
>>   	  rfkill switch, hotkey, fan control and backlight control.
>>   
>> +config LENOVO_SUPER_HOTKEY_WMI
>> +	tristate "Lenovo Super Hotkey Utility WMI extras driver"
>> +	depends on ACPI_WMI
>> +	depends on IDEAPAD_LAPTOP
> 
> Does this still depend on IDEAPAD_LAPTOP? Also add:
> 	select NEW_LEDS
> 	select LEDS_CLASS
> 
In my view, keep depend on IDEAPAD, because that mic-mute LED function 
doesn't work without ideapad_laptop.ko. Due to KEY_MICMUTE event is 
handled in ideapad_laptop. And this file only turn on/off MIC mute LED 
after the KEY_MICMUTE pressed. For Audio mute LED, audio mute key is 
common handled by keyboard driver, but MIC mute key is special and 
handled in ideapad_laptop.ko for Lenovo non-ThinkPad products. Audio 
mute and MIC mute function can work when user press related hotkey in 
past, only it's mute LED doesn't turn on/off.
For ThinkPad products, MIC mute key is handled in thinkpad_acpi.

{ KE_KEY,       0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } }, in 
ideapad_keymap[].

This LENOVO_SUPER_HOTKEY_WMI depends on IDEAPAD_LAPTOP which included 
led moudles(NEW_LEDS/LEDS_CLASS) as below. Maybe it shoud be enough.

config IDEAPAD_LAPTOP
         tristate "Lenovo IdeaPad Laptop Extras"
         depends on ACPI
         depends on RFKILL && INPUT
         depends on SERIO_I8042
         depends on BACKLIGHT_CLASS_DEVICE
         depends on ACPI_VIDEO || ACPI_VIDEO = n
         depends on ACPI_WMI || ACPI_WMI = n
         select ACPI_PLATFORM_PROFILE
         select INPUT_SPARSEKMAP
         select NEW_LEDS
         select LEDS_CLASS
         help
           This is a driver for Lenovo IdeaPad netbooks contains drivers for
           rfkill switch, hotkey, fan control and backlight control.

>> +	help
>> +	  This driver provides WMI support for Lenovo customized hotkeys function
>> +	  of Lenovo NoteBooks which are for Consumer and SMB customers, such as
>> +	  Ideapad/YOGA/XiaoXin/Gaming/ThinkBook and so on.
> 
> This driver deals with mute key leds. Is this description right?
In fact, this driver should handle all lenovo super hotkey functions 
which are implemeteled by wmi. Audio mute LED and Mic mute LED are just 
the two functions of them. The driver will be extented for all lenovo 
super hotkey in future. I have to say that different products are with 
different hotkey, not all products support all hotkeys function, such as 
many ThinkBook products without MIC mute LED. Currently,

Some links are FYR.
How to use Lenovo Hotkeys on keyboard?
https://tt-hardware.com/en/pc/how-to-use-lenovo-hotkeys-on-keyboard/
Lenovo Hotkeys
https://apps.microsoft.com/detail/9pcmmnb260tx?hl=en-us&gl=US

For these Lenovo Hotkeys, ThinkPad series are impelemented by acpi, but 
some hotkeys of non-ThinkPad products are impelemented by wmi, special 
for latest non-ThinkPad products. This is why I write this driver.
> 
>> +
>>   config LENOVO_YMC
>>   	tristate "Lenovo Yoga Tablet Mode Control"
>>   	depends on ACPI_WMI
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index e1b142947067..598335da9f55 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -61,6 +61,7 @@ obj-$(CONFIG_UV_SYSFS)       += uv_sysfs.o
>>   # IBM Thinkpad and Lenovo
>>   obj-$(CONFIG_IBM_RTL)		+= ibm_rtl.o
>>   obj-$(CONFIG_IDEAPAD_LAPTOP)	+= ideapad-laptop.o
>> +obj-$(CONFIG_LENOVO_SUPER_HOTKEY_WMI)	+= lenovo-super-hotkey-wmi.o
>>   obj-$(CONFIG_LENOVO_YMC)	+= lenovo-ymc.o
>>   obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
>>   obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
>> diff --git a/drivers/platform/x86/lenovo-super-hotkey-wmi.c b/drivers/platform/x86/lenovo-super-hotkey-wmi.c
> 
> This name doesn't tell me a lot about the features of this driver. Is
> this the internal name of the WMI device?
Reference previous comment.
If you have a better proposal, let me know.
> 
>> new file mode 100644
>> index 000000000000..86c3dc2009b8
>> --- /dev/null
>> +++ b/drivers/platform/x86/lenovo-super-hotkey-wmi.c
>> @@ -0,0 +1,222 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Lenovo Super Hotkey Utility WMI extras driver for Ideapad laptop
>> + *
>> + *  Copyright (C) 2025	Lenovo
>> + */
>> +
>> +#include <linux/cleanup.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/device.h>
>> +#include <linux/leds.h>
>> +#include <linux/module.h>
>> +#include <linux/wmi.h>
>> +
>> +/* Lenovo Super Hotkey WMI GUIDs */
>> +#define LUD_WMI_METHOD_GUID	"CE6C0974-0407-4F50-88BA-4FC3B6559AD8"
>> +
>> +/* Lenovo Utility Data WMI method_id */
>> +#define WMI_LUD_GET_SUPPORT 1
>> +#define WMI_LUD_SET_FEATURE 2
>> +
>> +#define WMI_LUD_GET_MICMUTE_LED_VER   20
>> +#define WMI_LUD_GET_AUDIOMUTE_LED_VER 26
>> +
>> +#define WMI_LUD_SUPPORT_MICMUTE_LED_VER   25
>> +#define WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER 27
>> +
>> +/* Input parameters to mute/unmute audio LED and Mic LED */
>> +struct wmi_led_args {
>> +	u8 id;
>> +	u8 subid;
>> +	u16 value;
>> +};
>> +
>> +/* Values of input parameters to SetFeature of audio LED and Mic LED */
>> +enum hotkey_set_feature {
>> +	MIC_MUTE_LED_ON = 1,
>> +	MIC_MUTE_LED_OFF,
>> +	AUDIO_MUTE_LED_ON = 4,
> 
> Please align this values.
For this comment, I understand it should be as below. If my 
understanding is insufficient,pls give me a sample to update it.

+enum hotkey_set_feature {
+       MIC_MUTE_LED_ON   = 1,
+       MIC_MUTE_LED_OFF,
+       AUDIO_MUTE_LED_ON = 4,
+       AUDIO_MUTE_LED_OFF,


> 
>> +	AUDIO_MUTE_LED_OFF,
>> +};
>> +
>> +#define LSH_ACPI_LED_MAX 2
>> +
>> +struct lenovo_super_hotkey_wmi_private {
>> +	struct led_classdev cdev[LSH_ACPI_LED_MAX];
>> +	struct wmi_device *led_wdev;
>> +};
>> +
>> +enum mute_led_type {
>> +	MIC_MUTE,
>> +	AUDIO_MUTE,
>> +};
>> +
>> +static int lsh_wmi_mute_led_set(enum mute_led_type led_type, struct led_classdev *led_cdev,
>> +				enum led_brightness brightness)
>> +
>> +{
>> +	struct lenovo_super_hotkey_wmi_private *wpriv = container_of(led_cdev,
>> +			struct lenovo_super_hotkey_wmi_private, cdev[led_type]);
>> +	struct wmi_led_args led_arg = {0, 0, 0};
>> +	struct acpi_buffer input;
>> +	acpi_status status;
>> +
>> +	switch (led_type) {
>> +	case MIC_MUTE:
>> +		led_arg.id = brightness == LED_ON ? MIC_MUTE_LED_ON : MIC_MUTE_LED_OFF;
>> +		break;
>> +	case AUDIO_MUTE:
>> +		led_arg.id = brightness == LED_ON ? AUDIO_MUTE_LED_ON : AUDIO_MUTE_LED_OFF;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	input.length = sizeof(led_arg);
>> +	input.pointer = &led_arg;
>> +	status = wmidev_evaluate_method(wpriv->led_wdev, 0, WMI_LUD_SET_FEATURE, &input, NULL);
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	return 0;
>> +}
>> +
>> +static int lsh_wmi_audiomute_led_set(struct led_classdev *led_cdev,
>> +				     enum led_brightness brightness)
>> +
>> +{
>> +	return lsh_wmi_mute_led_set(AUDIO_MUTE, led_cdev, brightness);
>> +}
>> +
>> +static int lsh_wmi_micmute_led_set(struct led_classdev *led_cdev,
>> +				   enum led_brightness brightness)
>> +{
>> +	return lsh_wmi_mute_led_set(MIC_MUTE, led_cdev, brightness);
>> +}
>> +
>> +static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type, struct device *dev)
>> +{
>> +	struct lenovo_super_hotkey_wmi_private *wpriv = dev_get_drvdata(dev);
>> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	struct acpi_buffer input;
>> +	int led_version, err = 0;
>> +	unsigned int wmiarg;
>> +	acpi_status status;
>> +
>> +	switch (led_type) {
>> +	case MIC_MUTE:
>> +		wmiarg = WMI_LUD_GET_MICMUTE_LED_VER;
>> +		break;
>> +	case AUDIO_MUTE:
>> +		wmiarg = WMI_LUD_GET_AUDIOMUTE_LED_VER;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	input.length = sizeof(wmiarg);
>> +	input.pointer = &wmiarg;
>> +	status = wmidev_evaluate_method(wpriv->led_wdev, 0, WMI_LUD_GET_SUPPORT, &input, &output);
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	union acpi_object *obj __free(kfree) = output.pointer;
>> +	if (obj && obj->type == ACPI_TYPE_INTEGER) {
>> +		led_version = obj->integer.value;
>> +	} else {
>> +		err = -EIO;
>> +		return err;
> 
> Return -EIO directly here and drop the braces on both branches.
> 
OK, will update it next revision.
>> +	}
>> +
>> +	wpriv->cdev[led_type].max_brightness = LED_ON;
>> +	wpriv->cdev[led_type].flags = LED_CORE_SUSPENDRESUME;
>> +
>> +	switch (led_type) {
>> +	case MIC_MUTE:
>> +		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER) {
>> +			err = -EIO;
>> +			goto led_error;
> 
> Return -EIO and drop brances.
> 
OK, will update it next revision.
>> +		}
>> +		wpriv->cdev[led_type].name = "platform::micmute";
>> +		wpriv->cdev[led_type].brightness_set_blocking = &lsh_wmi_micmute_led_set;
>> +		wpriv->cdev[led_type].default_trigger = "audio-micmute";
>> +
>> +		err = devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
>> +		if (err < 0)
>> +			goto led_reg_failed;
>> +
>> +		break;
>> +	case AUDIO_MUTE:
>> +		if (led_version != WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER) {
>> +			err = -EIO;
>> +			goto led_error;
> 
> Return -EIO and drop brances.
> 
OK, will update it next revision.
>> +		}
>> +		wpriv->cdev[led_type].name = "platform::mute";
>> +		wpriv->cdev[led_type].brightness_set_blocking = &lsh_wmi_audiomute_led_set;
>> +		wpriv->cdev[led_type].default_trigger = "audio-mute";
>> +
>> +		err = devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
>> +		if (err < 0)
>> +			goto led_reg_failed;
>> +
>> +		break;
>> +	default:
>> +		err = -EINVAL;
>> +		dev_err(dev, "Unknown LED type %d\n", led_type);
>> +		goto led_error;
> 
> Return -EINVAL directly.
> 
OK, will update it next revision.
>> +	}
>> +
>> +	return 0;
>> +
>> +led_reg_failed:
>> +	dev_err(dev, "Could not register mute LED %d : %d\n", led_type, err);
>> +
>> +led_error:
>> +	return err;
>> +}
>> +
>> +static void lenovo_super_hotkey_wmi_leds_setup(struct device *dev)
>> +{
>> +	lenovo_super_hotkey_wmi_led_init(MIC_MUTE, dev);
>> +	lenovo_super_hotkey_wmi_led_init(AUDIO_MUTE, dev);
> 
> I wonder why you decided not to propagate errors of this calls. Maybe
> you are expecting one to fail but not the other?
> 
> If this both fail this module would remain loaded for no reason, so
> maybe propagate some error in that case.
> 
Oh, it's my fault. I'll update related source code as below.

static int lenovo_super_hotkey_wmi_leds_setup(struct device *dev)
{
         int err;
         err = lenovo_super_hotkey_wmi_led_init(MIC_MUTE, dev);
         if (err)
                 return err;

         err = lenovo_super_hotkey_wmi_led_init(AUDIO_MUTE, dev);
         if (err)
                 return err;

         return 0;
}

>> +}
>> +
>> +static int lenovo_super_hotkey_wmi_probe(struct wmi_device *wdev, const void *context)
>> +{
>> +	struct lenovo_super_hotkey_wmi_private *wpriv;
>> +
>> +	wpriv = devm_kzalloc(&wdev->dev, sizeof(*wpriv), GFP_KERNEL);
>> +	if (!wpriv)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(&wdev->dev, wpriv);
>> +	wpriv->led_wdev = wdev;
>> +	lenovo_super_hotkey_wmi_leds_setup(&wdev->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct wmi_device_id lenovo_super_hotkey_wmi_id_table[] = {
>> +	{ LUD_WMI_METHOD_GUID, NULL }, /* Utility data */
> 
> Maybe drop this comment.
> 
 From Lenovo Keyboard WMI Specification V3.6, there're 3 WMI GUIDs at 
least now. I hope to keep the comment which should be helpful for new 
developer of this driver.

[WMI,
Dynamic,
Provider("WmiProv"),
Locale("MS\\0x409"),
Description("Lenovo Utility Key Press Event"),
guid("{8fc0de0c-b4e4-43fd-b0f3-8871711c1294}")
]
class LENOVO_UTILITY_EVENT: WMIEvent
...
[WMI,
Dynamic,
Provider("WmiProv"),
Locale("MS\\0x409"),
Description("LENOVO_UTILITY_DATA class"),
guid("{ce6c0974-0407-4f50-88ba-4fc3b6559ad8}")
]
class LENOVO_UTILITY_DATA
...
LENOVO_INTERNAL_PANEL_REFRESH_RATE_DATA can
get panel refresh rate)
Namespace:L"root\\wmi"
Class LENOVO_INTERNAL_PANEL_REFRESH_RATE_DATA
GUID guid("{6260ecad-0d7d-4201-a8bd-2552e812501f}"

> Additionally, please CC me and previous reviewers the next revision.
> 
OK, will do next revision.
> --
>   ~ Kurt
>
>> +	{ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(wmi, lenovo_super_hotkey_wmi_id_table);
>> +
>> +static struct wmi_driver lenovo_super_hotkey_wmi_driver = {
>> +	 .driver = {
>> +		 .name = "lenovo_super_hotkey_wmi",
>> +		 .probe_type = PROBE_PREFER_ASYNCHRONOUS
>> +	 },
>> +	 .id_table = lenovo_super_hotkey_wmi_id_table,
>> +	 .probe = lenovo_super_hotkey_wmi_probe,
>> +	 .no_singleton = true,
>> +};
>> +
>> +module_wmi_driver(lenovo_super_hotkey_wmi_driver);
>> +
>> +MODULE_INFO(depends, "wmi,ideapad-laptop"); MODULE_AUTHOR("Jackie
>> +Dong <dongeg1@lenovo.com>"); MODULE_DESCRIPTION("Lenovo Super Hotkey
>> +Utility WMI extras driver"); MODULE_LICENSE("GPL");
>






