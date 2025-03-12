Return-Path: <linux-kernel+bounces-558215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68692A5E2DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7F016C03D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143C71D799D;
	Wed, 12 Mar 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="JAlcuijU"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABC1156C62;
	Wed, 12 Mar 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800916; cv=none; b=YGHex+zSTCfcDoum5WS26uvBIBWD0byUbxsD9xVNlVNQzgWvZmvCygdzWZnkc45wXq3ZT6GrZF/e9SPHyh237odXFemF7zhYLgYQIEAea/aqHaz8QU9CF9wP5qAfHYC38fKRmaCftY3Gq4jzr/jCD4XEtb+d6yuHlD1EXpaydEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800916; c=relaxed/simple;
	bh=psS74YTD8K+Up5+y4eC2ooiITedLGgs3EJ1lFpkifX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cM3uj0poWiS/3W0NLYfU79zDhaMbEKCmdyCN6eLyrN6Wh1lNF/3M0GhL5J54IYLG5LpyW/5aTPXZn3xdxRSj8Alk5O8FicMqSMcmgQ/bJTdmzPnYSnUNbsgzMXPGTKsSd1qN+OAx+YBuP8akoUyMwaeN/sBFVSofuvECYF/znEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=JAlcuijU; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5b164989.dip0.t-ipconnect.de [91.22.73.137])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id DAA8B2FC0189;
	Wed, 12 Mar 2025 18:35:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741800904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Z2Ve9+3e5RtEgAxNJi0WFl2KCkYir9ObMahBx9JbYg=;
	b=JAlcuijUe7FsPcLvLTlY8vPfNDjgDCMyN1UxJJK3ynjaIw1H7SgyVeZ9tEGQxkcnQpUow7
	YHDCj0Z3NxymOWQbu/g5NV+UyP9XkS8JZGWW2gQwFpAyYf7vFRDKQXNN+CJKzsX6P38HHR
	/l/JBXqweZT6nuDclvrydZsYkIvpH2A=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <9fe8ec27-caf1-402e-842a-2efa936cb155@tuxedocomputers.com>
Date: Wed, 12 Mar 2025 18:35:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Input: atkbd - Fix TUXEDO NB02 notebook keyboards
 touchpad toggle key
To: hdegoede@redhat.com, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20250311172402.1095506-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20250311172402.1095506-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 11.03.25 um 18:23 schrieb Werner Sembach:
> The TUXEDO NB02 notebook keyboards touchpad toggle key sends the PS/2
> scancode sequence:
> 0xe0, 0x5b, // Super down
> 0x1d,       // Control down
> 0x76,       // KEY_ZENKAKUHANKAKU down
> 0xf6,       // KEY_ZENKAKUHANKAKU up
> 0x9d,       // Control up
> 0xe0, 0xdb  // Super up
>
> This driver listens to the Control + Super + Hangaku/Zenkaku key sequence
> to suppresses the Hangaku/Zenkaku keypress and sends a F21 keypress
> afterwards to conform with established userspace defaults. Note that the
> Hangaku/Zenkaku scancode used here is usually unused, with real
> Hangaku/Zenkaku keys using the tilde scancode.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>   MAINTAINERS                                 |   6 ++
>   drivers/platform/x86/Kconfig                |   2 +
>   drivers/platform/x86/Makefile               |   3 +
>   drivers/platform/x86/tuxedo/Kbuild          |   6 ++
>   drivers/platform/x86/tuxedo/Kconfig         |   6 ++
>   drivers/platform/x86/tuxedo/nb02/Kbuild     |   7 ++
>   drivers/platform/x86/tuxedo/nb02/Kconfig    |  15 +++
>   drivers/platform/x86/tuxedo/nb02/platform.c | 107 ++++++++++++++++++++
>   8 files changed, 152 insertions(+)
>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kconfig
>   create mode 100644 drivers/platform/x86/tuxedo/nb02/platform.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0736dc2ee0e..7139c32e96dc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24190,6 +24190,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>   F:	tools/power/x86/turbostat/
>   F:	tools/testing/selftests/turbostat/
>   
> +TUXEDO DRIVERS
> +M:	Werner Sembach <wse@tuxedocomputers.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Supported
> +F:	drivers/platform/x86/tuxedo/
> +
>   TW5864 VIDEO4LINUX DRIVER
>   M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>   M:	Andrey Utkin <andrey.utkin@corp.bluecherry.net>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64b..9b78a1255c08e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1199,3 +1199,5 @@ config P2SB
>   	  The main purpose of this library is to unhide P2SB device in case
>   	  firmware kept it hidden on some platforms in order to access devices
>   	  behind it.
> +
> +source "drivers/platform/x86/tuxedo/Kconfig"
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index e1b1429470674..1562dcd7ad9a5 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
>   
>   # SEL
>   obj-$(CONFIG_SEL3350_PLATFORM)		+= sel3350-platform.o
> +
> +# TUXEDO
> +obj-y					+= tuxedo/
> diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/tuxedo/Kbuild
> new file mode 100644
> index 0000000000000..e9c4243d438ba
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kbuild
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +obj-y	+= nb02/
> diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/tuxedo/Kconfig
> new file mode 100644
> index 0000000000000..e463f92135780
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
Just realized that I mixed GPL-2.0-or-later and GPL-2.0-only (intent was 
GPL-2.0-or-later as the code itself), will fix in an eventual v4 when this whole 
patch receives positive feedback.
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +source "drivers/platform/x86/tuxedo/nb02/Kconfig"
> diff --git a/drivers/platform/x86/tuxedo/nb02/Kbuild b/drivers/platform/x86/tuxedo/nb02/Kbuild
> new file mode 100644
> index 0000000000000..8624a012cd683
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/Kbuild
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +tuxedo_nb02_platform-y			:= platform.o
> +obj-$(CONFIG_TUXEDO_NB02_PLATFORM)	+= tuxedo_nb02_platform.o
> diff --git a/drivers/platform/x86/tuxedo/nb02/Kconfig b/drivers/platform/x86/tuxedo/nb02/Kconfig
> new file mode 100644
> index 0000000000000..bed56276b9b36
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +menuconfig TUXEDO_NB02_PLATFORM
> +	tristate "TUXEDO NB02 Platform Driver"
> +	help
> +	  This driver implements miscellaneous things found on TUXEDO Notebooks
> +	  with board vendor NB02. For the time being this is only remapping the
> +	  touchpad toggle key to something supported by most Linux distros
> +	  out-of-the-box and suppressing an unsupported scancode from the
> +	  FN-key.
> +
> +	  When compiled as a module it will be called tuxedo_nb02_platform.
> diff --git a/drivers/platform/x86/tuxedo/nb02/platform.c b/drivers/platform/x86/tuxedo/nb02/platform.c
> new file mode 100644
> index 0000000000000..da67a91a4a129
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/platform.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/container_of.h>
> +#include <linux/dmi.h>
> +#include <linux/i8042.h>
> +#include <linux/input.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/serio.h>
> +
> +struct input_dev *idev;
> +
> +static void tux_nb02_f21(struct work_struct *work __always_unused)
> +{
> +	input_report_key(idev, KEY_F21, 1);
> +	input_report_key(idev, KEY_F21, 0);
> +	input_sync(idev);
> +}
> +DECLARE_WORK(tux_nb02_f21_work, tux_nb02_f21);
> +
> +static const u8 tux_nb02_touchp_toggle_seq[] = {
> +	0xe0, 0x5b, // Super down
> +	0x1d,       // Control down
> +	0x76,       // KEY_ZENKAKUHANKAKU down
> +	0xf6,       // KEY_ZENKAKUHANKAKU up
> +	0x9d,       // Control up
> +	0xe0, 0xdb  // Super up
> +};
> +
> +static bool tux_nb02_i8042_filter(unsigned char data,
> +				  unsigned char str,
> +				  struct serio *port __always_unused,
> +				  void *context __always_unused)
> +{
> +	static u8 seq_pos;
> +
> +	if (unlikely(str & I8042_STR_AUXDATA))
> +		return false;
> +
> +	if (unlikely(data == tux_nb02_touchp_toggle_seq[seq_pos])) {
> +		++seq_pos;
> +		if (unlikely(data == 0x76 || data == 0xf6)) {
> +			return true;
> +		} else if (unlikely(seq_pos == ARRAY_SIZE(tux_nb02_touchp_toggle_seq))) {
> +			schedule_work(&tux_nb02_f21_work);
> +			seq_pos = 0;
> +		}
> +		return false;
> +	}
> +
> +	seq_pos = 0;
> +	return false;
> +}
> +
> +static const struct dmi_system_id tux_nb02_dmi_string_match[] __initconst = {
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "NB02"),
> +		},
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(dmi, tux_nb02_dmi_string_match);
> +
> +static int __init tux_nb02_plat_init(void)
> +{
> +	int ret;
> +
> +	if (!dmi_check_system(tux_nb02_dmi_string_match))
> +		return -ENODEV;
> +
> +	idev = input_allocate_device();
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	idev->name = "TUXEDO NB02 Platform Keyboard";
> +	set_bit(EV_KEY, idev->evbit);
> +	set_bit(KEY_F21, idev->keybit);
> +
> +	ret = input_register_device(idev);
> +	if (ret) {
> +		input_free_device(idev);
> +		return ret;
> +	}
> +
> +	i8042_install_filter(tux_nb02_i8042_filter, NULL);
> +
> +	return 0;
> +}
> +
> +static void __exit tux_nb02_plat_exit(void)
> +{
> +	i8042_remove_filter(tux_nb02_i8042_filter);
> +	input_unregister_device(idev);
> +}
> +
> +module_init(tux_nb02_plat_init);
> +module_exit(tux_nb02_plat_exit);
> +
> +MODULE_DESCRIPTION("Keyboard fix for TUXEDO NB02 devices");
> +MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
> +MODULE_LICENSE("GPL");

