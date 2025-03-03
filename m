Return-Path: <linux-kernel+bounces-542418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD5A4C927
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 150F47A29B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E222CBF6;
	Mon,  3 Mar 2025 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="TDOsB2Vv"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA4D84A3E;
	Mon,  3 Mar 2025 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021722; cv=none; b=bAgLACN3jTAXYemA9lb9Ulyz+dTiIfJJ9uCpoCHbo+RuDVEaPhficpLmK7vMuWY2McZevLyiyzOkb1VvMOeEdhoxbzRBoExpxK1+AM32jc3uNJtYr9qRx3S+EETgheWe+684RCAtdz9GTa03K1z4IDWoQY37RAVq9g0ZPdC8PpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021722; c=relaxed/simple;
	bh=JYE1xhFKKd/5c4jb4Keu0UaYC7On9wH9tg5GmCG8k1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TphVuxS3KBKzTYIGq1K3uhyDOE6g4xl/CLlCmxc3TZFVyQkky45+/1Vbfg0GJUMnLkfQy7Z9iME3V7QWCOkEVY0OLgdmP9I3iwHW5u5p2l79wEb995zrIKmayE4OlLHlNqYtL8GfxIiq+uOcb76j+bnoojB4I9zzZxc+Q/ykuqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=TDOsB2Vv; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e59f4f.dip0.t-ipconnect.de [217.229.159.79])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 6287A2FC004A;
	Mon,  3 Mar 2025 18:08:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741021716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+aFrlynqBCI6EAy7aY4YpYPMDWism/F0c6RZQzcRAg=;
	b=TDOsB2VvBZ8kTxA4mxpTjr4fiGNnA16Ip4gU4C3Yh/Lo3PnBQIpERBdyx+AVkVFN8elUKk
	PfQF1KbOdzulGgW9lexiDdq7kihnSZGurdxNcS9qs1SiYR0nVNAY9pzWcAFDrLbaICC1/G
	WykxdigjP8suPztaaft9QBIelAbvrHs=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <3140a369-7877-41ee-b4e8-b42789d99d45@tuxedocomputers.com>
Date: Mon, 3 Mar 2025 18:08:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Input: atkbd - Fix TUXEDO NB02 notebook keyboards
 FN-keys
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20250303161228.437604-1-wse@tuxedocomputers.com>
 <20250303161228.437604-2-wse@tuxedocomputers.com>
 <939e3b28-f11f-48ed-98b9-b5b5ef77eb0e@amd.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <939e3b28-f11f-48ed-98b9-b5b5ef77eb0e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 03.03.25 um 17:46 schrieb Mario Limonciello:
> On 3/3/2025 10:11, Werner Sembach wrote:
>> This small driver does 2 things:
>>
>> It remaps the touchpad toggle key from Control + Super + Hangaku/Zenkaku to
>> F21 to conform with established userspace defaults. Note that the
>> Hangaku/Zenkaku scancode used here is usually unused, with real
>> Hangaku/Zenkaku keys using the tilde scancode.
>>
>> It suppresses the reserved scancode produced by pressing the FN-key on its
>> own, which fixes a warning spamming the dmesg log otherwise.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> ---
>>   MAINTAINERS                                 |  6 ++
>>   drivers/platform/x86/Kconfig                |  2 +
>>   drivers/platform/x86/Makefile               |  3 +
>>   drivers/platform/x86/tuxedo/Kbuild          |  6 ++
>>   drivers/platform/x86/tuxedo/Kconfig         |  6 ++
>>   drivers/platform/x86/tuxedo/nb02/Kbuild     |  7 ++
>>   drivers/platform/x86/tuxedo/nb02/Kconfig    | 15 ++++
>>   drivers/platform/x86/tuxedo/nb02/platform.c | 79 +++++++++++++++++++++
>>   8 files changed, 124 insertions(+)
>>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>>   create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kbuild
>>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kconfig
>>   create mode 100644 drivers/platform/x86/tuxedo/nb02/platform.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4ff26fa94895d..d3fbbcef813b0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -24178,6 +24178,12 @@ T:    git 
>> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>>   F:    tools/power/x86/turbostat/
>>   F:    tools/testing/selftests/turbostat/
>>   +TUXEDO DRIVERS
>> +M:    Werner Sembach <wse@tuxedocomputers.com>
>> +L:    platform-driver-x86@vger.kernel.org
>> +S:    Supported
>> +F:    drivers/platform/x86/tuxedo/
>> +
>>   TW5864 VIDEO4LINUX DRIVER
>>   M:    Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>>   M:    Andrey Utkin <andrey.utkin@corp.bluecherry.net>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 0258dd879d64b..9b78a1255c08e 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -1199,3 +1199,5 @@ config P2SB
>>         The main purpose of this library is to unhide P2SB device in case
>>         firmware kept it hidden on some platforms in order to access devices
>>         behind it.
>> +
>> +source "drivers/platform/x86/tuxedo/Kconfig"
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index e1b1429470674..1562dcd7ad9a5 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)        += 
>> winmate-fm07-keys.o
>>     # SEL
>>   obj-$(CONFIG_SEL3350_PLATFORM)        += sel3350-platform.o
>> +
>> +# TUXEDO
>> +obj-y                    += tuxedo/
>> diff --git a/drivers/platform/x86/tuxedo/Kbuild 
>> b/drivers/platform/x86/tuxedo/Kbuild
>> new file mode 100644
>> index 0000000000000..e9c4243d438ba
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/Kbuild
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +obj-y    += nb02/
>> diff --git a/drivers/platform/x86/tuxedo/Kconfig 
>> b/drivers/platform/x86/tuxedo/Kconfig
>> new file mode 100644
>> index 0000000000000..e463f92135780
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/Kconfig
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +source "drivers/platform/x86/tuxedo/nb02/Kconfig"
>> diff --git a/drivers/platform/x86/tuxedo/nb02/Kbuild 
>> b/drivers/platform/x86/tuxedo/nb02/Kbuild
>> new file mode 100644
>> index 0000000000000..8624a012cd683
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nb02/Kbuild
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +tuxedo_nb02_platform-y            := platform.o
>> +obj-$(CONFIG_TUXEDO_NB02_PLATFORM)    += tuxedo_nb02_platform.o
>> diff --git a/drivers/platform/x86/tuxedo/nb02/Kconfig 
>> b/drivers/platform/x86/tuxedo/nb02/Kconfig
>> new file mode 100644
>> index 0000000000000..848ab61164404
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nb02/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +menuconfig TUXEDO_NB02_PLATFORM
>> +    tristate "TUXEDO NB02 Platform Driver"
>> +    default m
>
> Don't most platform/x86 drivers default to 'n'?  It's up to distros and users 
> to turn on I thought.
Didn't give much tough to this particularly, will look into it
>
>> +    help
>> +      This driver implements miscellaneous things found on TUXEDO Notebooks
>> +      with board vendor NB02. For the time being this is only remapping the
>> +      touchpad toggle key to something supported by most Linux distros
>> +      out-of-the-box and supressing an unsupported scancode from the FN-key.
>
> suppressing
thanks for spotting
>
>> +
>> +      When compiled as a module it will be called tuxedo_nb02_platform.
>> diff --git a/drivers/platform/x86/tuxedo/nb02/platform.c 
>> b/drivers/platform/x86/tuxedo/nb02/platform.c
>> new file mode 100644
>> index 0000000000000..a6137c8b2d4aa
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nb02/platform.c
>> @@ -0,0 +1,79 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
>> + */
>> +
>> +#include <linux/i8042.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/serio.h>
>> +
>> +static u8 tux_nb02_touchp_toggle_seq[] = {
>> +    0xe0, 0x5b, // Super down
>> +    0x1d,       // Control down
>> +    0x76,       // Zenkaku/Hankaku down
>> +    0xf6,       // Zenkaku/Hankaku up
>> +    0x9d,       // Control up
>> +    0xe0, 0xdb  // Super up
>> +};
>> +
>> +static bool tux_nb02_i8042_filter(unsigned char data,
>> +                  unsigned char str,
>> +                  struct serio *port,
>> +                  __always_unused void *context)
>> +{
>> +    static u8 seq_pos;
>> +
>> +    if (unlikely(str & I8042_STR_AUXDATA))
>> +        return false;
>> +
>> +    pr_info("%#04x\n", data);
>
> A bit too noisy for a filter, no?
Yes, missed it when removing the debugging statements.
>
>> +
>> +    // Replace touchpad toggle key sequence with a singular press of the
>> +    // F21-key.
>
> Multi-line comments are supposed to be /* */
will fix
>
>> +    if (unlikely(data == tux_nb02_touchp_toggle_seq[seq_pos])) {
>> +        ++seq_pos;
>> +        if (seq_pos == ARRAY_SIZE(tux_nb02_touchp_toggle_seq)) {
>> +            seq_pos = 0;
>> +            serio_interrupt(port, 0x6c, 0); // F21 down
>> +            serio_interrupt(port, 0xec, 0); // F21 up
>> +        }
>> +        return true;
>> +    }
>> +
>> +    // Ignore bogus scancode produced by the FN-key. Reuse seq_pos as first
>> +    // byte of that is just the "extended"-byte.
>
> Multi-line comments are supposed to be /* */
will fix
>
>> +    if (unlikely(seq_pos == 1 && (data == 0x78 || data == 0xf8))) {
>> +        seq_pos = 0;
>> +        return true;
>> +    }
>> +
>> +    // Replay skipped sequence bytes if it did not finish and it was not a
>> +    // FN-key press.
>
> Multi-line comments are supposed to be /* */
will fix
>
>> +    if (unlikely(seq_pos)) {
>> +        for (u8 i; i < seq_pos; ++i)
>> +            serio_interrupt(port, tux_nb02_touchp_toggle_seq[i], 0);
>> +        seq_pos = 0;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +static int __init tux_nb02_plat_init(void)
>> +{
>> +    return i8042_install_filter(tux_nb02_i8042_filter, NULL);
>
> The driver is tri-state.  If it was 'm' it wouldn't load on anything but the 
> matching hardware.
>
> But think about what happens if a user compiled a kernel with this 'y'.
>
> The tux_nb02_plat_init() would install a filter even though they didn't have 
> matching hardware.
>
> I think you need some sort of assertion this driver matches the hardware and 
> return -ENODEV if it doesn't.
Ok
>
>> +}
>> +
>> +static void __exit tux_nb02_plat_exit(void)
>> +{
>> +    i8042_remove_filter(tux_nb02_i8042_filter);
>> +}
>> +
>> +module_init(tux_nb02_plat_init);
>> +module_exit(tux_nb02_plat_exit);
>> +
>> +MODULE_ALIAS("dmi:*:svnTUXEDO:*:rvnNB02:*");
>> +
>> +MODULE_DESCRIPTION("TUXEDO NB02 Platform");
>> +MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
>> +MODULE_LICENSE("GPL");
>

