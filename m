Return-Path: <linux-kernel+bounces-565135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD5AA66190
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17533163D14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C1B204C39;
	Mon, 17 Mar 2025 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbL5OsIY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25865202C40
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250493; cv=none; b=RuvKCynRVTv/Bac5VPXZsUDkSEqeUWoEpz13PwYJpleEUODhSvYBx9WOH38blweDWmOrdMaOgpG+HD15i9KdkqoUprq7GoAJDYLxUU+yWkwdgq1jYvfqGzhkr5JRvxDCnbgWPgsMNsEBCA4ZoTfSK478dxozaf+LgDAMY2yidYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250493; c=relaxed/simple;
	bh=ou0YO3E2F3tdNihnm4RXMTn7Yh8Z4EGu4+dqDWq0tQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiSV3uV55s0dXvu7/ghVvb9E/HniqJB/CmIAEqcg6MjYfaBxBq3UbBPi44K2/XpckE8kyrkxthb66hCJbRUjkHNkQNin2YP7oSExdFdtEhH/ImMafnWIn+elW8v9KxcNxXmiYGI+6zq1GG55ueDrjhlT1rl9+K77vD5WfnY+qO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbL5OsIY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742250489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtS0xC6d6/Z4dPQaNbjh8+f87r9fcJOvc836eiaJ0L4=;
	b=IbL5OsIYdo5+2xGroNV1w3wKixsuVh7qULr3/XJCtBM1+PsJqa1EM5YoOawz5N8vLCI1wE
	jgekUAEsNilzFBjCbj6LlDdCvoD6ldY7uyas6BT22AkTIEsEaqAe0ebAtHUSP/WLouze4b
	gVlvw6gBnV3dXBkfLsPSB08ztSQdtr0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-RriWp0oUP0aAeVWOi5-cyA-1; Mon, 17 Mar 2025 18:28:08 -0400
X-MC-Unique: RriWp0oUP0aAeVWOi5-cyA-1
X-Mimecast-MFC-AGG-ID: RriWp0oUP0aAeVWOi5-cyA_1742250487
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac218738618so424579566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250487; x=1742855287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtS0xC6d6/Z4dPQaNbjh8+f87r9fcJOvc836eiaJ0L4=;
        b=lGw2xb8ILlX0zRqoqToFBtG0+Fm/2weeajyFVhrlgoRvBGcYSVbevzeOvvJYG+4DH+
         ftCtqFmn7Fz+2S9IOmHRzU3u/+Rc1hISfXy7mCSTgHvTEWPBYJNhBMBkOSV/cjt8We39
         St1fcslgm8AMa86gM+z+9UfGu9oSBaQu4MnPyy3nxOAkZW7bQWSR/6sFISCaLowN1pkE
         7JxQ6A7ebYjNDBUBYogNi6skeIKse0k+MupL2N835/TkP1vGlX+CpfMp7eMv2rF1SDg1
         2EXxkHC/d7LpNPSbjTzgDHWwmO52tvrd5Yg3Gg4JlPVIZzmCaST4ug6+R4xeEzW9Kily
         LSjg==
X-Gm-Message-State: AOJu0YyhilPF6fjC62RJbFWheVe2MOZscsWxuF+Gr5W6VUzjq8orJ7CH
	9pl87ly/kJpv3xNRpL9p0C7wt4TtTJ7zMkap2/smdHRSfSPLF20pfgOOvdmFsohz9ndQzJogxKQ
	Fd48sKn5nxcaosdTp1iJqQle0Iyy898kRdcS3OACt/3HSSJ9aJwf0TgatBOjPSQ==
X-Gm-Gg: ASbGncsAx8oPKyYSF4J+vuQ8c7x1STGU8UH/FK5hlsdRTIIJxbETqDx2CGmgLzQLEmS
	52M2nX0VenVfkgSWPmDqvwU5puiOEJ7119iCpwfOXh4pWAVC4x58FUPSdyksAm6DpYm+CycELTF
	7153bQwGnUV7iVDpgp409HhHJYNXXZP1hYsKzXchKPc7FsqKLhoVzAzYauoCkhDPw++OWLgMUfI
	9EsMWl876uQ7jhswNLuMAFY4h86GSTCw9zq4JploD5ZOOb+ZyZ/E5OQcSzZzNjumj/ATKx2lXBV
	gN3ZvPP89gs7LMg7MsXUoQIMDAofc5tfQ6nLPoguX/Vp0tnQN816oeJ3QZDv7iemF+u1xFjLFIt
	67HNMeDsb/mZ34u9IaejWLt0+ZEiSGbCYzCVmczzEcVACCQ0uza9ucVKxBGYAQ2TImA==
X-Received: by 2002:a17:907:9712:b0:aae:e52f:3d36 with SMTP id a640c23a62f3a-ac3301e4c08mr1438040966b.6.1742250486627;
        Mon, 17 Mar 2025 15:28:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqJ8U/higgo2eF6WadzMagacQ2HWoOJcqFuMZG4IVWuf1AAB4/n+i1EFhPopxyoEMn1+C3fQ==
X-Received: by 2002:a17:907:9712:b0:aae:e52f:3d36 with SMTP id a640c23a62f3a-ac3301e4c08mr1438038966b.6.1742250486150;
        Mon, 17 Mar 2025 15:28:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aec15sm731010166b.34.2025.03.17.15.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 15:28:05 -0700 (PDT)
Message-ID: <a72199cb-8726-4221-8b79-f86216304ee8@redhat.com>
Date: Mon, 17 Mar 2025 23:28:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] Input: atkbd - Fix TUXEDO NB02 notebook keyboards
 touchpad toggle key
To: Werner Sembach <wse@tuxedocomputers.com>, ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20250313140458.621438-1-wse@tuxedocomputers.com>
 <20250313140458.621438-2-wse@tuxedocomputers.com>
 <c273bc96-a517-4028-a67f-229a6fa9673e@redhat.com>
 <680b8108-9479-4d9e-9892-7b4a475d2a57@tuxedocomputers.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <680b8108-9479-4d9e-9892-7b4a475d2a57@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi

On 17-Mar-25 5:52 PM, Werner Sembach wrote:
> Hi,
> 
> Am 17.03.25 um 13:11 schrieb Hans de Goede:
>> Hi Werner,
>>
>> On 13-Mar-25 15:03, Werner Sembach wrote:
>>> The TUXEDO NB02 notebook keyboards touchpad toggle key sends the PS/2
>>> scancode sequence:
>>> 0xe0, 0x5b, // Super down
>>> 0x1d,       // Control down
>>> 0x76,       // KEY_ZENKAKUHANKAKU down
>>> 0xf6,       // KEY_ZENKAKUHANKAKU up
>>> 0x9d,       // Control up
>>> 0xe0, 0xdb  // Super up
>>>
>>> This driver listens to the Control + Super + Hangaku/Zenkaku key sequence
>>> to suppresses the Hangaku/Zenkaku keypress and sends a F21 keypress
>>> afterwards to conform with established userspace defaults. Note that the
>>> Hangaku/Zenkaku scancode used here is usually unused, with real
>>> Hangaku/Zenkaku keys using the tilde scancode.
>>>
>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> I'm still not a fan of this approach. Your patch to atkbd.c to
>> map scancode 0x5f to F24 + a xkeyboard-config change to add:
>>
>>      key <FK24> { [ F24        ]    };
>>
>> to /usr/share/X11/xkb/symbols/fujitsu_vndr/inet
>>
>> + teach KDE and GNOME that Ctrl + Super + F24 = touchpad-toggle
>>
>> should work nicely and renders the whole need for this patch obsolete.
> 
> Ok, but see my suggestion of doing it in xkeyboard-config only in the other mail-thread: [PATCH v2 2/2] Input: atkbd - Correctly map F13 - F24

Yes I just notices that, as I mentioned in the other thread,
the xkeyboard-config only fix sounds like a good fix to me.

Regards,

Hans





>>> ---
>>>   MAINTAINERS                                 |   6 ++
>>>   drivers/platform/x86/Kconfig                |   2 +
>>>   drivers/platform/x86/Makefile               |   3 +
>>>   drivers/platform/x86/tuxedo/Kbuild          |   8 ++
>>>   drivers/platform/x86/tuxedo/Kconfig         |   8 ++
>>>   drivers/platform/x86/tuxedo/nb02/Kbuild     |   9 ++
>>>   drivers/platform/x86/tuxedo/nb02/Kconfig    |  17 ++++
>>>   drivers/platform/x86/tuxedo/nb02/platform.c | 107 ++++++++++++++++++++
>>>   8 files changed, 160 insertions(+)
>>>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>>>   create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>>>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kbuild
>>>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kconfig
>>>   create mode 100644 drivers/platform/x86/tuxedo/nb02/platform.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 8e0736dc2ee0e..7139c32e96dc7 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -24190,6 +24190,12 @@ T:    git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>>>   F:    tools/power/x86/turbostat/
>>>   F:    tools/testing/selftests/turbostat/
>>>   +TUXEDO DRIVERS
>>> +M:    Werner Sembach <wse@tuxedocomputers.com>
>>> +L:    platform-driver-x86@vger.kernel.org
>>> +S:    Supported
>>> +F:    drivers/platform/x86/tuxedo/
>>> +
>>>   TW5864 VIDEO4LINUX DRIVER
>>>   M:    Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>>>   M:    Andrey Utkin <andrey.utkin@corp.bluecherry.net>
>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>>> index 0258dd879d64b..9b78a1255c08e 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -1199,3 +1199,5 @@ config P2SB
>>>         The main purpose of this library is to unhide P2SB device in case
>>>         firmware kept it hidden on some platforms in order to access devices
>>>         behind it.
>>> +
>>> +source "drivers/platform/x86/tuxedo/Kconfig"
>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>>> index e1b1429470674..1562dcd7ad9a5 100644
>>> --- a/drivers/platform/x86/Makefile
>>> +++ b/drivers/platform/x86/Makefile
>>> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)        += winmate-fm07-keys.o
>>>     # SEL
>>>   obj-$(CONFIG_SEL3350_PLATFORM)        += sel3350-platform.o
>>> +
>>> +# TUXEDO
>>> +obj-y                    += tuxedo/
>>> diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/tuxedo/Kbuild
>>> new file mode 100644
>>> index 0000000000000..1c79b80744d1b
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/tuxedo/Kbuild
>>> @@ -0,0 +1,8 @@
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +#
>>> +# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
>>> +#
>>> +# TUXEDO X86 Platform Specific Drivers
>>> +#
>>> +
>>> +obj-y    += nb02/
>>> diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/tuxedo/Kconfig
>>> new file mode 100644
>>> index 0000000000000..13b484999e333
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/tuxedo/Kconfig
>>> @@ -0,0 +1,8 @@
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +#
>>> +# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
>>> +#
>>> +# TUXEDO X86 Platform Specific Drivers
>>> +#
>>> +
>>> +source "drivers/platform/x86/tuxedo/nb02/Kconfig"
>>> diff --git a/drivers/platform/x86/tuxedo/nb02/Kbuild b/drivers/platform/x86/tuxedo/nb02/Kbuild
>>> new file mode 100644
>>> index 0000000000000..f56629c8b9dd8
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/tuxedo/nb02/Kbuild
>>> @@ -0,0 +1,9 @@
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +#
>>> +# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
>>> +#
>>> +# TUXEDO X86 Platform Specific Drivers
>>> +#
>>> +
>>> +tuxedo_nb02_platform-y            := platform.o
>>> +obj-$(CONFIG_TUXEDO_NB02_PLATFORM)    += tuxedo_nb02_platform.o
>>> diff --git a/drivers/platform/x86/tuxedo/nb02/Kconfig b/drivers/platform/x86/tuxedo/nb02/Kconfig
>>> new file mode 100644
>>> index 0000000000000..38cd60c9d4f03
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/tuxedo/nb02/Kconfig
>>> @@ -0,0 +1,17 @@
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +#
>>> +# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
>>> +#
>>> +# TUXEDO X86 Platform Specific Drivers
>>> +#
>>> +
>>> +menuconfig TUXEDO_NB02_PLATFORM
>>> +    tristate "TUXEDO NB02 Platform Driver"
>>> +    help
>>> +      This driver implements miscellaneous things found on TUXEDO Notebooks
>>> +      with board vendor NB02. For the time being this is only remapping the
>>> +      touchpad toggle key to something supported by most Linux distros
>>> +      out-of-the-box and suppressing an unsupported scancode from the
>>> +      FN-key.
>>> +
>>> +      When compiled as a module it will be called tuxedo_nb02_platform.
>>> diff --git a/drivers/platform/x86/tuxedo/nb02/platform.c b/drivers/platform/x86/tuxedo/nb02/platform.c
>>> new file mode 100644
>>> index 0000000000000..da67a91a4a129
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/tuxedo/nb02/platform.c
>>> @@ -0,0 +1,107 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
>>> + */
>>> +
>>> +#include <linux/cleanup.h>
>>> +#include <linux/container_of.h>
>>> +#include <linux/dmi.h>
>>> +#include <linux/i8042.h>
>>> +#include <linux/input.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/serio.h>
>>> +
>>> +struct input_dev *idev;
>>> +
>>> +static void tux_nb02_f21(struct work_struct *work __always_unused)
>>> +{
>>> +    input_report_key(idev, KEY_F21, 1);
>>> +    input_report_key(idev, KEY_F21, 0);
>>> +    input_sync(idev);
>>> +}
>>> +DECLARE_WORK(tux_nb02_f21_work, tux_nb02_f21);
>>> +
>>> +static const u8 tux_nb02_touchp_toggle_seq[] = {
>>> +    0xe0, 0x5b, // Super down
>>> +    0x1d,       // Control down
>>> +    0x76,       // KEY_ZENKAKUHANKAKU down
>>> +    0xf6,       // KEY_ZENKAKUHANKAKU up
>>> +    0x9d,       // Control up
>>> +    0xe0, 0xdb  // Super up
>>> +};
>>> +
>>> +static bool tux_nb02_i8042_filter(unsigned char data,
>>> +                  unsigned char str,
>>> +                  struct serio *port __always_unused,
>>> +                  void *context __always_unused)
>>> +{
>>> +    static u8 seq_pos;
>>> +
>>> +    if (unlikely(str & I8042_STR_AUXDATA))
>>> +        return false;
>>> +
>>> +    if (unlikely(data == tux_nb02_touchp_toggle_seq[seq_pos])) {
>>> +        ++seq_pos;
>>> +        if (unlikely(data == 0x76 || data == 0xf6)) {
>>> +            return true;
>>> +        } else if (unlikely(seq_pos == ARRAY_SIZE(tux_nb02_touchp_toggle_seq))) {
>>> +            schedule_work(&tux_nb02_f21_work);
>>> +            seq_pos = 0;
>>> +        }
>>> +        return false;
>>> +    }
>>> +
>>> +    seq_pos = 0;
>>> +    return false;
>>> +}
>>> +
>>> +static const struct dmi_system_id tux_nb02_dmi_string_match[] __initconst = {
>>> +    {
>>> +        .matches = {
>>> +            DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
>>> +            DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "NB02"),
>>> +        },
>>> +    },
>>> +    { }
>>> +};
>>> +MODULE_DEVICE_TABLE(dmi, tux_nb02_dmi_string_match);
>>> +
>>> +static int __init tux_nb02_plat_init(void)
>>> +{
>>> +    int ret;
>>> +
>>> +    if (!dmi_check_system(tux_nb02_dmi_string_match))
>>> +        return -ENODEV;
>>> +
>>> +    idev = input_allocate_device();
>>> +    if (!idev)
>>> +        return -ENOMEM;
>>> +
>>> +    idev->name = "TUXEDO NB02 Platform Keyboard";
>>> +    set_bit(EV_KEY, idev->evbit);
>>> +    set_bit(KEY_F21, idev->keybit);
>>> +
>>> +    ret = input_register_device(idev);
>>> +    if (ret) {
>>> +        input_free_device(idev);
>>> +        return ret;
>>> +    }
>>> +
>>> +    i8042_install_filter(tux_nb02_i8042_filter, NULL);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void __exit tux_nb02_plat_exit(void)
>>> +{
>>> +    i8042_remove_filter(tux_nb02_i8042_filter);
>>> +    input_unregister_device(idev);
>>> +}
>>> +
>>> +module_init(tux_nb02_plat_init);
>>> +module_exit(tux_nb02_plat_exit);
>>> +
>>> +MODULE_DESCRIPTION("Keyboard fix for TUXEDO NB02 devices");
>>> +MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
>>> +MODULE_LICENSE("GPL");
> 


