Return-Path: <linux-kernel+bounces-564683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B36A65951
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC3C3A5BED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5719E998;
	Mon, 17 Mar 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="cx48pSQj"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CCA1B78F3;
	Mon, 17 Mar 2025 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230369; cv=none; b=qSLhmRtwL1P9pyMoLG+eAyaomxd/UX3ciVCz/KHI/qEOuDm7IrjDwqb4XNl1aMKy/dAxcXhBVpqSEp3AWnzt5PGvA9YUjXE8I69YDvtu/vhOvPjc+woMR6yGfAFOqGJ5sscQ9+AOmHJO+kR262KDObnUfpWx8gWhHoMEkJ4LCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230369; c=relaxed/simple;
	bh=fVSS+5vfnfxLWR5liVCsG79JqU88q1cDYDDlZZTKCWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcefDUaTG3j7CtXX+w+cqtrWE37gui7TJsZ7KdxhFo5QbSKOBo1IraVBXxY1GpIIaIsQecQ1HgjzQlc/cG8nelswP8u2UTzIhgt0nylOtKgPj/ZwXqxPPbQGTgJAXbyA5JZYVNAPUWLSNDn8N66s5La8QSPtaE1QbY2KY2lxisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=cx48pSQj; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5b164989.dip0.t-ipconnect.de [91.22.73.137])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 5EDF02FC0048;
	Mon, 17 Mar 2025 17:52:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1742230363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+WNOMGZIoormhepBTGMVRLhG2Yxz5A8wZxssCGClvA=;
	b=cx48pSQj+QF9anrMVAubq5mlVmCnt7CCdzRNeUm9909S0MdgGN8i/7gG+YgP6qpqhEHI7B
	n1UMlDmoPQr4FF/rYQIA4WwW1i3uFn8+6ogJQG7RwRss+M1CbVPlS3Qns0W/lJg5l4SOtb
	DImeuB4NXLU0ePDbhJ5Ozz1JN09Yqyg=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <680b8108-9479-4d9e-9892-7b4a475d2a57@tuxedocomputers.com>
Date: Mon, 17 Mar 2025 17:52:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] Input: atkbd - Fix TUXEDO NB02 notebook keyboards
 touchpad toggle key
To: Hans de Goede <hdegoede@redhat.com>, ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20250313140458.621438-1-wse@tuxedocomputers.com>
 <20250313140458.621438-2-wse@tuxedocomputers.com>
 <c273bc96-a517-4028-a67f-229a6fa9673e@redhat.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <c273bc96-a517-4028-a67f-229a6fa9673e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Am 17.03.25 um 13:11 schrieb Hans de Goede:
> Hi Werner,
>
> On 13-Mar-25 15:03, Werner Sembach wrote:
>> The TUXEDO NB02 notebook keyboards touchpad toggle key sends the PS/2
>> scancode sequence:
>> 0xe0, 0x5b, // Super down
>> 0x1d,       // Control down
>> 0x76,       // KEY_ZENKAKUHANKAKU down
>> 0xf6,       // KEY_ZENKAKUHANKAKU up
>> 0x9d,       // Control up
>> 0xe0, 0xdb  // Super up
>>
>> This driver listens to the Control + Super + Hangaku/Zenkaku key sequence
>> to suppresses the Hangaku/Zenkaku keypress and sends a F21 keypress
>> afterwards to conform with established userspace defaults. Note that the
>> Hangaku/Zenkaku scancode used here is usually unused, with real
>> Hangaku/Zenkaku keys using the tilde scancode.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> I'm still not a fan of this approach. Your patch to atkbd.c to
> map scancode 0x5f to F24 + a xkeyboard-config change to add:
>
>      key <FK24> { [ F24		]	};
>
> to /usr/share/X11/xkb/symbols/fujitsu_vndr/inet
>
> + teach KDE and GNOME that Ctrl + Super + F24 = touchpad-toggle
>
> should work nicely and renders the whole need for this patch obsolete.

Ok, but see my suggestion of doing it in xkeyboard-config only in the other 
mail-thread: [PATCH v2 2/2] Input: atkbd - Correctly map F13 - F24

Also, seeing how fast xkb-c and KDE accepted the patches, that is also a faster 
way probably.

Best regards,

Werner

>
> Regards,
>
> Hans
>
>
>
>
>> ---
>>   MAINTAINERS                                 |   6 ++
>>   drivers/platform/x86/Kconfig                |   2 +
>>   drivers/platform/x86/Makefile               |   3 +
>>   drivers/platform/x86/tuxedo/Kbuild          |   8 ++
>>   drivers/platform/x86/tuxedo/Kconfig         |   8 ++
>>   drivers/platform/x86/tuxedo/nb02/Kbuild     |   9 ++
>>   drivers/platform/x86/tuxedo/nb02/Kconfig    |  17 ++++
>>   drivers/platform/x86/tuxedo/nb02/platform.c | 107 ++++++++++++++++++++
>>   8 files changed, 160 insertions(+)
>>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>>   create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kbuild
>>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kconfig
>>   create mode 100644 drivers/platform/x86/tuxedo/nb02/platform.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8e0736dc2ee0e..7139c32e96dc7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -24190,6 +24190,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>>   F:	tools/power/x86/turbostat/
>>   F:	tools/testing/selftests/turbostat/
>>   
>> +TUXEDO DRIVERS
>> +M:	Werner Sembach <wse@tuxedocomputers.com>
>> +L:	platform-driver-x86@vger.kernel.org
>> +S:	Supported
>> +F:	drivers/platform/x86/tuxedo/
>> +
>>   TW5864 VIDEO4LINUX DRIVER
>>   M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>>   M:	Andrey Utkin <andrey.utkin@corp.bluecherry.net>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 0258dd879d64b..9b78a1255c08e 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -1199,3 +1199,5 @@ config P2SB
>>   	  The main purpose of this library is to unhide P2SB device in case
>>   	  firmware kept it hidden on some platforms in order to access devices
>>   	  behind it.
>> +
>> +source "drivers/platform/x86/tuxedo/Kconfig"
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index e1b1429470674..1562dcd7ad9a5 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
>>   
>>   # SEL
>>   obj-$(CONFIG_SEL3350_PLATFORM)		+= sel3350-platform.o
>> +
>> +# TUXEDO
>> +obj-y					+= tuxedo/
>> diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/tuxedo/Kbuild
>> new file mode 100644
>> index 0000000000000..1c79b80744d1b
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/Kbuild
>> @@ -0,0 +1,8 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +obj-y	+= nb02/
>> diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/tuxedo/Kconfig
>> new file mode 100644
>> index 0000000000000..13b484999e333
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/Kconfig
>> @@ -0,0 +1,8 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +source "drivers/platform/x86/tuxedo/nb02/Kconfig"
>> diff --git a/drivers/platform/x86/tuxedo/nb02/Kbuild b/drivers/platform/x86/tuxedo/nb02/Kbuild
>> new file mode 100644
>> index 0000000000000..f56629c8b9dd8
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nb02/Kbuild
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +tuxedo_nb02_platform-y			:= platform.o
>> +obj-$(CONFIG_TUXEDO_NB02_PLATFORM)	+= tuxedo_nb02_platform.o
>> diff --git a/drivers/platform/x86/tuxedo/nb02/Kconfig b/drivers/platform/x86/tuxedo/nb02/Kconfig
>> new file mode 100644
>> index 0000000000000..38cd60c9d4f03
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nb02/Kconfig
>> @@ -0,0 +1,17 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +menuconfig TUXEDO_NB02_PLATFORM
>> +	tristate "TUXEDO NB02 Platform Driver"
>> +	help
>> +	  This driver implements miscellaneous things found on TUXEDO Notebooks
>> +	  with board vendor NB02. For the time being this is only remapping the
>> +	  touchpad toggle key to something supported by most Linux distros
>> +	  out-of-the-box and suppressing an unsupported scancode from the
>> +	  FN-key.
>> +
>> +	  When compiled as a module it will be called tuxedo_nb02_platform.
>> diff --git a/drivers/platform/x86/tuxedo/nb02/platform.c b/drivers/platform/x86/tuxedo/nb02/platform.c
>> new file mode 100644
>> index 0000000000000..da67a91a4a129
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nb02/platform.c
>> @@ -0,0 +1,107 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
>> + */
>> +
>> +#include <linux/cleanup.h>
>> +#include <linux/container_of.h>
>> +#include <linux/dmi.h>
>> +#include <linux/i8042.h>
>> +#include <linux/input.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/serio.h>
>> +
>> +struct input_dev *idev;
>> +
>> +static void tux_nb02_f21(struct work_struct *work __always_unused)
>> +{
>> +	input_report_key(idev, KEY_F21, 1);
>> +	input_report_key(idev, KEY_F21, 0);
>> +	input_sync(idev);
>> +}
>> +DECLARE_WORK(tux_nb02_f21_work, tux_nb02_f21);
>> +
>> +static const u8 tux_nb02_touchp_toggle_seq[] = {
>> +	0xe0, 0x5b, // Super down
>> +	0x1d,       // Control down
>> +	0x76,       // KEY_ZENKAKUHANKAKU down
>> +	0xf6,       // KEY_ZENKAKUHANKAKU up
>> +	0x9d,       // Control up
>> +	0xe0, 0xdb  // Super up
>> +};
>> +
>> +static bool tux_nb02_i8042_filter(unsigned char data,
>> +				  unsigned char str,
>> +				  struct serio *port __always_unused,
>> +				  void *context __always_unused)
>> +{
>> +	static u8 seq_pos;
>> +
>> +	if (unlikely(str & I8042_STR_AUXDATA))
>> +		return false;
>> +
>> +	if (unlikely(data == tux_nb02_touchp_toggle_seq[seq_pos])) {
>> +		++seq_pos;
>> +		if (unlikely(data == 0x76 || data == 0xf6)) {
>> +			return true;
>> +		} else if (unlikely(seq_pos == ARRAY_SIZE(tux_nb02_touchp_toggle_seq))) {
>> +			schedule_work(&tux_nb02_f21_work);
>> +			seq_pos = 0;
>> +		}
>> +		return false;
>> +	}
>> +
>> +	seq_pos = 0;
>> +	return false;
>> +}
>> +
>> +static const struct dmi_system_id tux_nb02_dmi_string_match[] __initconst = {
>> +	{
>> +		.matches = {
>> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
>> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "NB02"),
>> +		},
>> +	},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(dmi, tux_nb02_dmi_string_match);
>> +
>> +static int __init tux_nb02_plat_init(void)
>> +{
>> +	int ret;
>> +
>> +	if (!dmi_check_system(tux_nb02_dmi_string_match))
>> +		return -ENODEV;
>> +
>> +	idev = input_allocate_device();
>> +	if (!idev)
>> +		return -ENOMEM;
>> +
>> +	idev->name = "TUXEDO NB02 Platform Keyboard";
>> +	set_bit(EV_KEY, idev->evbit);
>> +	set_bit(KEY_F21, idev->keybit);
>> +
>> +	ret = input_register_device(idev);
>> +	if (ret) {
>> +		input_free_device(idev);
>> +		return ret;
>> +	}
>> +
>> +	i8042_install_filter(tux_nb02_i8042_filter, NULL);
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit tux_nb02_plat_exit(void)
>> +{
>> +	i8042_remove_filter(tux_nb02_i8042_filter);
>> +	input_unregister_device(idev);
>> +}
>> +
>> +module_init(tux_nb02_plat_init);
>> +module_exit(tux_nb02_plat_exit);
>> +
>> +MODULE_DESCRIPTION("Keyboard fix for TUXEDO NB02 devices");
>> +MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
>> +MODULE_LICENSE("GPL");

