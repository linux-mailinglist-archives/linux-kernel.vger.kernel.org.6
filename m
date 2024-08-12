Return-Path: <linux-kernel+bounces-283236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F00694EEF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E82D1F211D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDF617CA1B;
	Mon, 12 Aug 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nwz5Z4cg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293017C230
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470874; cv=none; b=rTFo3orMW4cW/sjVoBAJ1hiNptwsvaf6OztwaFCxFqwcP7sDn6eGYGtsltM9QRRRmCV+Se27Ihbmmc2h4Z7PSeDpulkIYezKkKQDdnXlbXBLAmjoaQYoYln5O8R9xfd5vhXeUhTiox+QkPNvpc2BeiX/UKhrYL1+L2M6avAdtcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470874; c=relaxed/simple;
	bh=NfI2cZVQJs2lPLmv9E1HDiH5ze7bCYFBBtjXDWEK6Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3nTa/MBN/KPvmxNqzbw8/8n/JWTcHCr0nE6LZkLPv3vTtxuVKupHtpu9gEDV0/VCEkehTJ+zWCQBs6ZEETTF5R0U7yev0hMdzl+V87Bw3QU1+sLVTa1NF6i0eVRlv1oIdCvlOBJmT5RrEzlKtKJFo8H3ONoxt0LvN3IHc1tnds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nwz5Z4cg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723470871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxn6Ub9UghdUFqSVBosRd1unvPDxGVy6TppuFiN7yzo=;
	b=Nwz5Z4cgEQHrREKBXno9Epc0dSG5YYDpFZQlQNDrWS91R7bGS1YXPC2RTOeNvyrJ13nsXB
	T1cz+3B5Y3SY1BOicT2XppJLUv1aJ66z5VfgSb4Ko0iQsWQFxKmnZ8y068Zlps3nUyJz4r
	WNgbOdGkfWJ7H3seUkZhEqIEuDP/9co=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-NcdvEqVENQ6DrlHiWbV0Nw-1; Mon, 12 Aug 2024 09:54:29 -0400
X-MC-Unique: NcdvEqVENQ6DrlHiWbV0Nw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52fceed3473so4089213e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723470868; x=1724075668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxn6Ub9UghdUFqSVBosRd1unvPDxGVy6TppuFiN7yzo=;
        b=pVgw4Myx3aGddnqf73neKdTnIjDQc15q9vrsxUXRpHONRmdbEJA1risK9Z0aGPQ2IW
         nOhosmtGQm0aA8G0lY4u23f/HVZqETS2lI8CSTvjqj7LUoM4obclcdl19j5VUg6mLaLW
         sZR7+J/1EMLynosTrVhsTsYUB+Cnv6bXtVLt4BFfmQRKM5GhAQBIxZ24o6hd9soArqnO
         z7mCWgOw/mrRpjSVM2JJ3MVJ7C/Ba5fm6H7UrGOR0iN5C2SRD3LIqIN4D+hL0JhIaCEA
         kRjAaJlH6Tkm0+iHB0AYh4/fNMQB3yv1WWfXXfqahb/TuvXFGHz/0+rgoQSTh6etYsvT
         WVEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVduEUyX3D08QkFM6V16N1Aigqb3Dz0LL5kUwIUcCrudlC3EuS+kKl9FFVPXxaxfl68Ztf3YRDcX61mGPh0jUZEej9sfBWzar7Dn5Q2
X-Gm-Message-State: AOJu0YxZIxn0fyIIF26gpYADUpg6Yr7kQSbIkUwB4/lzMOvbmSzXfGPi
	TGUZaJIpPA0cUK8aBynGiMM5rJdSzonABRC7mgW9mGKpEOdDkqO4+NKn5x67rWkW0GrmvELjcOv
	oJLZe6TueF3FQpTFp2JDyUVw9K2mREm4vm3HP+rcjyLnKvt+hWaTivKM+Vktfk0QGaKKYkQ==
X-Received: by 2002:a2e:3216:0:b0:2f2:9df8:e64e with SMTP id 38308e7fff4ca-2f2b714e6aamr3179931fa.11.1723470867794;
        Mon, 12 Aug 2024 06:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvE3GHSY0vWl+x8pZDaXjEfu0nbV0xo/kJhZvJKuHkWe5GvW7FGgKOvwEh5ge5+7u5R27lmg==
X-Received: by 2002:a2e:3216:0:b0:2f2:9df8:e64e with SMTP id 38308e7fff4ca-2f2b714e6aamr3179551fa.11.1723470867090;
        Mon, 12 Aug 2024 06:54:27 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e4af1sm233565766b.86.2024.08.12.06.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 06:54:26 -0700 (PDT)
Message-ID: <770e2abc-7a68-448c-91ee-0dc71b9c91bf@redhat.com>
Date: Mon, 12 Aug 2024 15:54:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
To: Andres Salomon <dilinger@queued.net>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240723220502.77cb0401@5400>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240723220502.77cb0401@5400>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andres

On 7/24/24 4:05 AM, Andres Salomon wrote:
> 
> The Dell BIOS allows you to set custom charging modes, which is useful
> in particular for extending battery life. This adds support for tweaking
> those various settings from Linux via sysfs knobs. One might, for
> example, have their laptop plugged into power at their desk the vast
> majority of the time and choose fairly aggressive battery-saving
> settings (only charging once the battery drops to 50% and only charging
> up to 80%). When leaving for a trip, they might want to switch those
> settings to charge to 100% and charge any time power is available;
> rebooting into the BIOS to change those settings is a hassle.
> 
> For the Custom charging type mode, we reuse the common
> charge_control_{start,end}_threshold sysfs power_supply entries. The
> BIOS also has a bunch of other charging modes (with varying levels of
> usefulness), so this adds a new Dell-specific sysfs entry called
> 'charge_type' that's documented in sysfs-class-power-dell (and looks a
> lot like sysfs-class-power-wilco).
> 
> This work is based on a patch by Perry Yuan <perry_yuan@dell.com> and
> Limonciello Mario <Mario_Limonciello@Dell.com> submitted back in 2020:
> https://lore.kernel.org/all/20200729065424.12851-1-Perry_Yuan@Dell.com/
> Both of their email addresses bounce, so I'm assuming they're no longer
> with the company. I've reworked most of the patch to make it smaller and
> cleaner.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
> Changes in v2, based on extensive feedback from Pali Rohár <pali@kernel.org>:
>     - code style changes
>     - change battery write API to use token->value instead of passed value
>     - stop caching current mode, instead querying SMBIOS as needed
>     - drop the separate list of charging modes enum
>     - rework the list of charging mode strings
>     - query SMBIOS for supported charging modes
>     - split dell_battery_custom_set() up

Thank you for your contribution, it will be great to have charge threshold
support on Dell laptops available to end users.

I see that there are some review-comments on this first patch of
the series. Please submit a v3 addressing those and then this will
hopefully be ready for merging.

Regards,

Hans




> ---
>  .../ABI/testing/sysfs-class-power-dell        |  31 ++
>  drivers/platform/x86/dell/Kconfig             |   1 +
>  drivers/platform/x86/dell/dell-laptop.c       | 288 ++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios.h       |   7 +
>  4 files changed, 327 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-dell
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-dell b/Documentation/ABI/testing/sysfs-class-power-dell
> new file mode 100644
> index 000000000000..ef72c5f797ce
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-power-dell
> @@ -0,0 +1,31 @@
> +What:		/sys/class/power_supply/<supply_name>/charge_type
> +Date:		July 2024
> +KernelVersion:	6.11
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Select the charging algorithm to use for the (primary)
> +		battery.
> +
> +		Standard:
> +			Fully charge the battery at a moderate rate.
> +		ExpressCharge™:
> +			Quickly charge the battery using fast-charge
> +			technology. This is harder on the battery than
> +			standard charging and may lower its lifespan.
> +		Primarily AC Use:
> +			Users who primarily operate the system while
> +			plugged into an external power source can extend
> +			battery life with this mode.
> +		Adaptive:
> +			Automatically optimize battery charge rate based
> +			on typical usage.
> +		Custom:
> +			Use the charge_control_* properties to determine
> +			when to start and stop charging. Advanced users
> +			can use this to drastically extend battery life.
> +
> +		Access: Read, Write
> +		Valid values:
> +			      "standard", "express", "primarily_ac",
> +			      "adaptive", "custom"
> +
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index 85a78ef91182..02405793163c 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -49,6 +49,7 @@ config DELL_LAPTOP
>  	default m
>  	depends on DMI
>  	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on ACPI_BATTERY
>  	depends on ACPI_VIDEO || ACPI_VIDEO = n
>  	depends on RFKILL || RFKILL = n
>  	depends on DELL_WMI || DELL_WMI = n
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 6552dfe491c6..aae9a95fb188 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -22,11 +22,13 @@
>  #include <linux/io.h>
>  #include <linux/rfkill.h>
>  #include <linux/power_supply.h>
> +#include <linux/sysfs.h>
>  #include <linux/acpi.h>
>  #include <linux/mm.h>
>  #include <linux/i8042.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> +#include <acpi/battery.h>
>  #include <acpi/video.h>
>  #include "dell-rbtn.h"
>  #include "dell-smbios.h"
> @@ -99,6 +101,18 @@ static bool force_rfkill;
>  static bool micmute_led_registered;
>  static bool mute_led_registered;
>  
> +static const struct {
> +	int token;
> +	const char *label;
> +} battery_modes[] = {
> +	{ BAT_STANDARD_MODE_TOKEN, "standard" },
> +	{ BAT_EXPRESS_MODE_TOKEN, "express" },
> +	{ BAT_PRI_AC_MODE_TOKEN, "primarily_ac" },
> +	{ BAT_ADAPTIVE_MODE_TOKEN, "adaptive" },
> +	{ BAT_CUSTOM_MODE_TOKEN, "custom" },
> +};
> +static u32 battery_supported_modes;
> +
>  module_param(force_rfkill, bool, 0444);
>  MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
>  
> @@ -2183,6 +2197,277 @@ static struct led_classdev mute_led_cdev = {
>  	.default_trigger = "audio-mute",
>  };
>  
> +static int dell_send_request_by_token_loc(struct calling_interface_buffer *buffer,
> +					  u16 class, u16 select, int type,
> +					  u32 val)
> +{
> +	struct calling_interface_token *token;
> +
> +	token = dell_smbios_find_token(type);
> +	if (!token)
> +		return -ENODEV;
> +
> +	/* -1 is a sentinel value, telling us to use token->value */
> +	if (val == (u32)-1)
> +		val = token->value;
> +
> +	dell_fill_request(buffer, token->location, val, 0, 0);
> +	return dell_send_request(buffer, class, select);
> +}
> +
> +static int dell_battery_set_mode(const int type)
> +{
> +	struct calling_interface_buffer buffer;
> +
> +	/* -1 means use the value from the token */
> +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> +			SELECT_TOKEN_STD, type, -1);
> +}
> +
> +static int dell_battery_read(const int type)
> +{
> +	struct calling_interface_buffer buffer;
> +	int err;
> +
> +	err = dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_READ,
> +			SELECT_TOKEN_STD, type, 0);
> +	if (err)
> +		return err;
> +
> +	return buffer.output[1];
> +}
> +
> +static bool dell_battery_mode_is_active(const int type)
> +{
> +	struct calling_interface_token *token;
> +
> +	token = dell_smbios_find_token(type);
> +	if (!token)
> +		return false;
> +
> +	return token->value == dell_battery_read(type);
> +}
> +
> +/* The rules: the minimum start charging value is 50%. The maximum
> + * start charging value is 95%. The minimum end charging value is
> + * 55%. The maximum end charging value is 100%. And finally, there
> + * has to be at least a 5% difference between start & end values.
> + */
> +#define CHARGE_START_MIN	50
> +#define CHARGE_START_MAX	95
> +#define CHARGE_END_MIN		55
> +#define CHARGE_END_MAX		100
> +#define CHARGE_MIN_DIFF		5
> +
> +static int dell_battery_set_custom_charge_start(int start)
> +{
> +	struct calling_interface_buffer buffer;
> +	int end;
> +
> +	if (start < CHARGE_START_MIN)
> +		start = CHARGE_START_MIN;
> +	else if (start > CHARGE_START_MAX)
> +		start = CHARGE_START_MAX;
> +
> +	end = dell_battery_read(BAT_CUSTOM_CHARGE_END);
> +	/* a failed read is okay */
> +	if (end < 0)
> +		end = CHARGE_END_MAX;
> +	if ((end - start) < CHARGE_MIN_DIFF)
> +		start = end - CHARGE_MIN_DIFF;
> +
> +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> +			SELECT_TOKEN_STD, BAT_CUSTOM_CHARGE_START, start);
> +}
> +
> +static int dell_battery_set_custom_charge_end(int end)
> +{
> +	struct calling_interface_buffer buffer;
> +	int start;
> +
> +	if (end < CHARGE_END_MIN)
> +		end = CHARGE_END_MIN;
> +	else if (end > CHARGE_END_MAX)
> +		end = CHARGE_END_MAX;
> +
> +	start = dell_battery_read(BAT_CUSTOM_CHARGE_START);
> +	/* a failed read is okay */
> +	if (start < 0)
> +		start = CHARGE_START_MIN;
> +	if ((end - start) < CHARGE_MIN_DIFF)
> +		end = start + CHARGE_MIN_DIFF;
> +
> +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> +			SELECT_TOKEN_STD, BAT_CUSTOM_CHARGE_END, end);
> +}
> +
> +static ssize_t charge_type_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	ssize_t count = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> +		bool active;
> +
> +		if (!(battery_supported_modes & BIT(i)))
> +			continue;
> +
> +		active = dell_battery_mode_is_active(battery_modes[i].token);
> +		count += sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
> +				battery_modes[i].label);
> +	}
> +
> +	/* convert the last space to a newline */
> +	if (count > 0)
> +		count--;
> +	count += sysfs_emit_at(buf, count, "\n");
> +
> +	return count;
> +}
> +
> +static ssize_t charge_type_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t size)
> +{
> +	bool matched = false;
> +	int err, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> +		if (sysfs_streq(battery_modes[i].label, buf)) {
> +			matched = true;
> +			break;
> +		}
> +	}
> +	if (!matched || !(battery_supported_modes & BIT(i)))
> +		return -EINVAL;
> +
> +	err = dell_battery_set_mode(battery_modes[i].token);
> +	if (err)
> +		return err;
> +
> +	return size;
> +}
> +
> +static ssize_t charge_control_start_threshold_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	int start;
> +
> +	start = dell_battery_read(BAT_CUSTOM_CHARGE_START);
> +	if (start < 0)
> +		return start;
> +
> +	return sysfs_emit(buf, "%d\n", start);
> +}
> +
> +static ssize_t charge_control_start_threshold_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t size)
> +{
> +	int ret, start;
> +
> +	ret = kstrtoint(buf, 10, &start);
> +	if (ret)
> +		return ret;
> +
> +	ret = dell_battery_set_custom_charge_start(start);
> +	if (ret)
> +		return ret;
> +
> +	return size;
> +}
> +
> +static ssize_t charge_control_end_threshold_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	int end;
> +
> +	end = dell_battery_read(BAT_CUSTOM_CHARGE_END);
> +	if (end < 0)
> +		return end;
> +
> +	return sysfs_emit(buf, "%d\n", end);
> +}
> +
> +static ssize_t charge_control_end_threshold_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t size)
> +{
> +	int ret, end;
> +
> +	ret = kstrtouint(buf, 10, &end);
> +	if (ret)
> +		return ret;
> +
> +	ret = dell_battery_set_custom_charge_end(end);
> +	if (ret)
> +		return ret;
> +
> +	return size;
> +}
> +
> +static DEVICE_ATTR_RW(charge_control_start_threshold);
> +static DEVICE_ATTR_RW(charge_control_end_threshold);
> +static DEVICE_ATTR_RW(charge_type);
> +
> +static struct attribute *dell_battery_attrs[] = {
> +	&dev_attr_charge_control_start_threshold.attr,
> +	&dev_attr_charge_control_end_threshold.attr,
> +	&dev_attr_charge_type.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(dell_battery);
> +
> +static int dell_battery_add(struct power_supply *battery,
> +		struct acpi_battery_hook *hook)
> +{
> +	return device_add_groups(&battery->dev, dell_battery_groups);
> +}
> +
> +static int dell_battery_remove(struct power_supply *battery,
> +		struct acpi_battery_hook *hook)
> +{
> +	device_remove_groups(&battery->dev, dell_battery_groups);
> +	return 0;
> +}
> +
> +static struct acpi_battery_hook dell_battery_hook = {
> +	.add_battery = dell_battery_add,
> +	.remove_battery = dell_battery_remove,
> +	.name = "Dell Primary Battery Extension",
> +};
> +
> +static u32 __init battery_get_supported_modes(void)
> +{
> +	u32 modes = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> +		if (dell_smbios_find_token(battery_modes[i].token))
> +			modes |= BIT(i);
> +	}
> +
> +	return modes;
> +}
> +
> +static void __init dell_battery_init(struct device *dev)
> +{
> +	battery_supported_modes = battery_get_supported_modes();
> +
> +	if (battery_supported_modes != 0)
> +		battery_hook_register(&dell_battery_hook);
> +}
> +
> +static void __exit dell_battery_exit(void)
> +{
> +	if (battery_supported_modes != 0)
> +		battery_hook_unregister(&dell_battery_hook);
> +}
> +
>  static int __init dell_init(void)
>  {
>  	struct calling_interface_token *token;
> @@ -2219,6 +2504,7 @@ static int __init dell_init(void)
>  		touchpad_led_init(&platform_device->dev);
>  
>  	kbd_led_init(&platform_device->dev);
> +	dell_battery_init(&platform_device->dev);
>  
>  	dell_laptop_dir = debugfs_create_dir("dell_laptop", NULL);
>  	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> @@ -2293,6 +2579,7 @@ static int __init dell_init(void)
>  	if (mute_led_registered)
>  		led_classdev_unregister(&mute_led_cdev);
>  fail_led:
> +	dell_battery_exit();
>  	dell_cleanup_rfkill();
>  fail_rfkill:
>  	platform_device_del(platform_device);
> @@ -2311,6 +2598,7 @@ static void __exit dell_exit(void)
>  	if (quirks && quirks->touchpad_led)
>  		touchpad_led_exit();
>  	kbd_led_exit();
> +	dell_battery_exit();
>  	backlight_device_unregister(dell_backlight_device);
>  	if (micmute_led_registered)
>  		led_classdev_unregister(&micmute_led_cdev);
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
> index ea0cc38642a2..77baa15eb523 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -33,6 +33,13 @@
>  #define KBD_LED_AUTO_50_TOKEN	0x02EB
>  #define KBD_LED_AUTO_75_TOKEN	0x02EC
>  #define KBD_LED_AUTO_100_TOKEN	0x02F6
> +#define BAT_PRI_AC_MODE_TOKEN	0x0341
> +#define BAT_ADAPTIVE_MODE_TOKEN	0x0342
> +#define BAT_CUSTOM_MODE_TOKEN	0x0343
> +#define BAT_STANDARD_MODE_TOKEN	0x0346
> +#define BAT_EXPRESS_MODE_TOKEN	0x0347
> +#define BAT_CUSTOM_CHARGE_START	0x0349
> +#define BAT_CUSTOM_CHARGE_END	0x034A
>  #define GLOBAL_MIC_MUTE_ENABLE	0x0364
>  #define GLOBAL_MIC_MUTE_DISABLE	0x0365
>  #define GLOBAL_MUTE_ENABLE	0x058C


