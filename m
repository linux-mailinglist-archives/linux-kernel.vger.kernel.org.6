Return-Path: <linux-kernel+bounces-292211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7512956C80
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C8B284A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484F016C878;
	Mon, 19 Aug 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYK9kM7c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C616B753
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075993; cv=none; b=kY2eyOnCBEpaeRCG//0wuNNYBDuRNWcjmJUDi6xKEkUd3lmbKylu7wEWDOdnSXKTas9PhPLLJlX1RDtNMFfphreM8K5NKlCIce01qy9H6nWZGVINiVsheL3YTdc8VuhracJpIrjKwftt1Z9Rc4pN/Kk80ZZhadYzrr+jhdbXgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075993; c=relaxed/simple;
	bh=KfYgJtXJjSaB0yOimerKIYmDqDkGvaOKp65QPXz0X2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9YXMepwJFKb2RC2OK+ddHW/nITO8xCNMo9ByF8MPmyovR7rfu9QAA9+MM2bpkqxP51eIUNzQPFPBX7E/bi4airNAGthzt0bEQlffy3xHRZraWWOe7b8QznDgI1lkPvWJwE7aShM6xJlgAi64wvgvy17giV7ShWw2WV1cGwelTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYK9kM7c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724075990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCncNxHsU/RE2qo4OcgQeR3/L5LsCAxS2e3AOKzIOG8=;
	b=DYK9kM7cbLoTShJGnXAkYycS+xozdC2hLzzJ74aLnZ8NiROsEM1eo4Ef91EyvHgVaD40iK
	v3j3FV+1jSwX5T5YUOCa82YcayIq4QwqtDHWiTjE1ApqdIP4oMVYKIDLCmE+hYkWFAxP0H
	u+d4gBAOhgblIHUIu1LjXJFxLbHSaxY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-MwpCfCE8OxSukGGm6Z_8Mg-1; Mon, 19 Aug 2024 09:59:49 -0400
X-MC-Unique: MwpCfCE8OxSukGGm6Z_8Mg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef3157ae4cso44003141fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 06:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724075987; x=1724680787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCncNxHsU/RE2qo4OcgQeR3/L5LsCAxS2e3AOKzIOG8=;
        b=k9NT0BpomgQTDzN2EZ/fu6M8lIv6viwbld4RY7Hx6ABrSs/jn+0/cpwphmenIMVH+j
         QOjxBA8+yhlfe/tgRldZfCzqix91rYk3wrnIsIfnjPHGGt44e3K2Y+aqmy27WQoA7Ksr
         ylGR75Z6JAEmZYRg6QgC3ZXgpILDlnP0IdNkO0YhBVY+Xqre3VnSDSZ7FIzthPaUw5mM
         uGbpEwttuLqkPLGy0IfQ7wvFeCx5MTdE6ko6hWq6aTk99sQ2lJim7c1X48RfKCvRezym
         VBZGTgd8oP+UCYOKsw6WjzC9tEm6oSoJGv9ItBAlnl5MoQd7bjF5LpJbIKMEejJ1GyOE
         +ipg==
X-Forwarded-Encrypted: i=1; AJvYcCW5ogYSGP+z0SF6wSPCdYYifqTdBa3foCI/89X/NMRHluZ6c6UfNH66b8ifNsqg8fZOsIW3msyXA4TILmMHqYS+9edAuTt20H+dn9R7
X-Gm-Message-State: AOJu0YypqPYI1nUl1fev/gsSB7XAzOIUM+xS7aaHFIGROCX4zf0Hmvrm
	wp6j9pJIR8ntWyVLM5SVd+FedDQR0TjMAv0QqgaevxYXgxRVuPIS6MNQMYKwn2gf3kl3y0iBIHY
	zpdxD0HuV1I1BbqcGdHJTRTg1JPLVWsNx4JkTOckeDQn2ha+ABki66FJr52nx8A==
X-Received: by 2002:a05:651c:2059:b0:2f1:5d61:937e with SMTP id 38308e7fff4ca-2f3be5a7745mr73445671fa.29.1724075987289;
        Mon, 19 Aug 2024 06:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEziD8ENLGg19HwtMn4Aw4LvvAx5mAbsGVvdGkikyzXy51qxVc7KpFFWRWVLJBkxun2zuUWow==
X-Received: by 2002:a05:651c:2059:b0:2f1:5d61:937e with SMTP id 38308e7fff4ca-2f3be5a7745mr73445521fa.29.1724075986628;
        Mon, 19 Aug 2024 06:59:46 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838eee50sm642771866b.93.2024.08.19.06.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 06:59:46 -0700 (PDT)
Message-ID: <380016cc-6ccc-463f-8c66-f2989cd6ef42@redhat.com>
Date: Mon, 19 Aug 2024 15:59:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
To: Andres Salomon <dilinger@queued.net>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240815192848.3489d3e1@5400>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240815192848.3489d3e1@5400>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/16/24 1:28 AM, Andres Salomon wrote:
> The Dell BIOS allows you to set custom charging modes, which is useful
> in particular for extending battery life. This adds support for tweaking
> those various settings from Linux via sysfs knobs. One might, for
> example, have their laptop plugged into power at their desk the vast
> majority of the time and choose fairly aggressive battery-saving
> settings (eg, only charging once the battery drops below 50% and only
> charging up to 80%). When leaving for a trip, it would be more useful
> to instead switch to a standard charging mode (top off at 100%, charge
> any time power is available). Rebooting into the BIOS to change the
> charging mode settings is a hassle.
> 
> For the Custom charging type mode, we reuse the common
> charge_control_{start,end}_threshold sysfs power_supply entries. The
> BIOS also has a bunch of other charging modes (with varying levels of
> usefulness), so this also adds a 'charge_type' sysfs entry that maps the
> standard values to Dell-specific ones and documents those mappings in
> sysfs-class-power-dell.
> 
> This work is based on a patch by Perry Yuan <perry_yuan@dell.com> and
> Limonciello Mario <Mario_Limonciello@Dell.com> submitted back in 2020:
> https://lore.kernel.org/all/20200729065424.12851-1-Perry_Yuan@Dell.com/
> Both of their email addresses bounce, so I'm assuming they're no longer
> with the company. I've reworked most of the patch to make it smaller and
> cleaner.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Thank you for your patch, some small comments below. For the next
version please also address Pali's and Ilpo's remarks.

> ---
> Changes in v3:
>     - switch tokenid and class types
>     - be stricter with results from both userspace and BIOS
>     - no longer allow failed BIOS reads
>     - rename/move dell_send_request_by_token_loc, and add helper function
>     - only allow registration for BAT0
>     - rename charge_type modes to match power_supply names
> Changes in v2, based on extensive feedback from Pali Rohár <pali@kernel.org>:
>     - code style changes
>     - change battery write API to use token->value instead of passed value
>     - stop caching current mode, instead querying SMBIOS as needed
>     - drop the separate list of charging modes enum
>     - rework the list of charging mode strings
>     - query SMBIOS for supported charging modes
>     - split dell_battery_custom_set() up
> ---
>  .../ABI/testing/sysfs-class-power-dell        |  33 ++
>  drivers/platform/x86/dell/Kconfig             |   1 +
>  drivers/platform/x86/dell/dell-laptop.c       | 316 ++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios.h       |   7 +
>  4 files changed, 357 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-dell
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-dell b/Documentation/ABI/testing/sysfs-class-power-dell
> new file mode 100644
> index 000000000000..d8c542177558
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-power-dell
> @@ -0,0 +1,33 @@
> +What:		/sys/class/power_supply/<supply_name>/charge_type
> +Date:		August 2024
> +KernelVersion:	6.12
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Select the charging algorithm to use for the (primary)
> +		battery.
> +
> +		Standard:
> +			Fully charge the battery at a moderate rate.
> +		Fast:
> +			Quickly charge the battery using fast-charge
> +			technology. This is harder on the battery than
> +			standard charging and may lower its lifespan.
> +			The Dell BIOS calls this ExpressCharge™.
> +		Trickle:
> +			Users who primarily operate the system while
> +			plugged into an external power source can extend
> +			battery life with this mode. The Dell BIOS calls
> +			this "Primarily AC Use".
> +		Adaptive:
> +			Automatically optimize battery charge rate based
> +			on typical usage pattern.
> +		Custom:
> +			Use the charge_control_* properties to determine
> +			when to start and stop charging. Advanced users
> +			can use this to drastically extend battery life.
> +
> +		Access: Read, Write
> +		Valid values:
> +			      "Standard", "Fast", "Trickle",
> +			      "Adaptive", "Custom"
> +

As the kernel test robot reports:

Warning: /sys/class/power_supply/<supply_name>/charge_type is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-power-dell:0  ./Documentation/ABI/testing/sysfs-class-power:375

So please drop this. What you could do is instead submit (as a separate) patch
an update to Documentation/ABI/testing/sysfs-class-power:375 to use your IMHO
more readable version.

And when doing so I think it would best to replace "The Dell BIOS calls this ..."
with "In vendor tooling this may also be called ...".


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
> index 6552dfe491c6..8cc05f0fab91 100644
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
> +	{ BAT_STANDARD_MODE_TOKEN, "Standard" },
> +	{ BAT_EXPRESS_MODE_TOKEN, "Fast" },
> +	{ BAT_PRI_AC_MODE_TOKEN, "Trickle" },
> +	{ BAT_ADAPTIVE_MODE_TOKEN, "Adaptive" },
> +	{ BAT_CUSTOM_MODE_TOKEN, "Custom" },
> +};

So Ilpo suggested to split this (first declare the struct type and then
declare an array of that type) and Pali suggested to keep this as is.

> +static u32 battery_supported_modes;

I see there also is some disagreement on keeping battery_modes[]
const vs adding a flag for this in the struct.

IMHO in both cases either option is fine, so you (Andres) get
to choose which solution you prefer in either case.

I do see there is some confusion about Ilpo's split suggestion,
to clarify that, what I believe is Ilpo meant doing something
like this:

struct battery_mode_info {
	int token;
	const char *label;
};

static const struct battery_mode_info battery_modes[] = {
	{ BAT_STANDARD_MODE_TOKEN, "Standard" },
	{ BAT_EXPRESS_MODE_TOKEN,  "Fast" },
	{ BAT_PRI_AC_MODE_TOKEN,   "Trickle" },
	{ BAT_ADAPTIVE_MODE_TOKEN, "Adaptive" },
	{ BAT_CUSTOM_MODE_TOKEN,   "Custom" },
};

Also whatever option you chose please align the second column using
spaces as done above.

<snip>

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

You cannot mark this __exit and also call it from the __init
dell_init() function to cleanup on errors, this lead to
the following error reported by the kernel test robot:

WARNING: modpost: drivers/platform/x86/dell/dell-laptop: section mismatch in reference: dell_init+0x637 (section: .init.text) -> dell_battery_exit (section: .exit.text)

to fix this please drop the __exit marking from this function.

Regards,

Hans


