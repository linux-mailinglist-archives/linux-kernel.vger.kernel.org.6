Return-Path: <linux-kernel+bounces-564141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75831A64E55
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58DA3A96D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C71B238D22;
	Mon, 17 Mar 2025 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSK9eBTo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0F237702
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213521; cv=none; b=F49Jg5srMDrGCFLb3F/jjDgGkMBqUtXGjH+FTaSyAW08DknYh81Jv7EJWEkc0ZasfUbPYlMk7vsmkTazR2jEMJFMpoxd7bY/cY9BXMEELW/zesugu2OM9oqgyL62LxsyZSnQq5dsskKZ350DGZfJlSgsqUrXXHrbB9Z/0SP44ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213521; c=relaxed/simple;
	bh=jj7q41qpMlLqrHVAuqRVsU+SI7d292ZMUc1Spl7aocc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRc4NJm4AKcW2S/cKmy+RcDK3wP8BZYgesMMbnlweYqNunjnMLJSOerL5HbZsULMbKdfGUWc2llgMoark9yPmPpOcwnwk/Qjcr0IzLlSxbx2LT5AlHZGWCU/I2ocxmbO4U7bjvy2cmuFmBeQBCoUIznCve1r1m5Q3ADtqNZjGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSK9eBTo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742213518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2fSQoXwaoSpq21VyKem5Q8rm+cvDaD43gnaYL7G73k=;
	b=cSK9eBTotw6OOpklLxKpXQV3f+lhwE211hwfTNDZZiM3m3l6p16xPqpZK/ceZggr1AJ4xT
	QjXyJ2oPwQW+CMCDRnWVZYJqBlOg+E4RN91Gk6/XkVULTFl5CdR0Tl69DJQTBBZ+seaqN6
	MJ4uGjLOKDYd027Qfs/8qlva7bGwgRI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-5liiSlklOVCz_vnRIB033w-1; Mon, 17 Mar 2025 08:11:57 -0400
X-MC-Unique: 5liiSlklOVCz_vnRIB033w-1
X-Mimecast-MFC-AGG-ID: 5liiSlklOVCz_vnRIB033w_1742213516
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac31adc55e4so389543066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213516; x=1742818316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2fSQoXwaoSpq21VyKem5Q8rm+cvDaD43gnaYL7G73k=;
        b=X1irPJ2LlYxmW/fmO72zKZ22gP6AY+8V2H+5TJTTF8rUOiuWUsl+fo1KocRZjxjq1e
         NTXh2yhReOOdx+bb9jHp4ZAU9c+Q7pyslniTOCLRHlCLxSkvwv6TEP0rPpB1P/KtFFVO
         kR6yV2r7D+Ez9yXkXLKAReeJy/nzXFKqGoX+nmECxpbN0/HCJ/IzJonstkZqDnrsF2xe
         luP29Ypb0RGZskCBBdTH2M4sjuYnOdd08vJyej/n/WrYY1iCtHHYsPWkYs55NgvUU0oy
         A/3g8w8tAO3GhYJKCWlUe40BsGeNiQ71forJ4MyYpURlihQ1HGrqSMkK9l9pV/lnGO7X
         yADg==
X-Gm-Message-State: AOJu0YwuE2g0QyjA/abBziOBaWx4EgaxaeoaV6BLAm52RLE9kCnqK1bb
	BtfXcAE5NtTk+h5AYbijVodaFFg3aA8FgBMxoWAuRcLCkOpVgrRN0l2yh0NkILXnyVPZYl7Hksv
	9LSrMKLh+TyAzBlVmQ4kSX/DqsYIw6lPkyJcIALkEEs3D7AY1dre6zm6y3kf6ow==
X-Gm-Gg: ASbGncv20Qx5mjSQAtvr7/ZS4AGuc7hSigUZmARdfvQ/VkDAwgqmzpULVoFZuCGwbLw
	ij0iiJaItNgjRMj2xnm7rRwwSpDUXrml7DJLiu0djQfBvK4PXdLJrE3MfME/yAk7exfJI3zbsZY
	fXExYlNFHPB8PHJcFou1i3gd74ehG9MWUxHCV/ku7lETIqDWxnS5RBjBvZyDJ7upB5zdRDeQfOq
	pwx8NDBN56lcmJQ+KG+Vyz437DmbNC1IXWdtQ/+FWnPoi1a904Eq+2pQ9UdoZdjef2N1Jc/Z6jU
	ehDxuv1mlQwcVaYUZWU=
X-Received: by 2002:a17:907:2dac:b0:ac2:7a3b:31ef with SMTP id a640c23a62f3a-ac33037158bmr1516674066b.41.1742213515735;
        Mon, 17 Mar 2025 05:11:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsQN7zs1Tcc87224L1PYevYiC9okyVtGcGh0azH/f11J0jGroAui+n8ZIcS6PDp18yoZO7zg==
X-Received: by 2002:a17:907:2dac:b0:ac2:7a3b:31ef with SMTP id a640c23a62f3a-ac33037158bmr1516665966b.41.1742213515155;
        Mon, 17 Mar 2025 05:11:55 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a47f0bsm650741666b.157.2025.03.17.05.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 05:11:54 -0700 (PDT)
Message-ID: <c273bc96-a517-4028-a67f-229a6fa9673e@redhat.com>
Date: Mon, 17 Mar 2025 13:11:53 +0100
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
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250313140458.621438-2-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Werner,

On 13-Mar-25 15:03, Werner Sembach wrote:
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

I'm still not a fan of this approach. Your patch to atkbd.c to
map scancode 0x5f to F24 + a xkeyboard-config change to add:

    key <FK24> { [ F24		]	};

to /usr/share/X11/xkb/symbols/fujitsu_vndr/inet

+ teach KDE and GNOME that Ctrl + Super + F24 = touchpad-toggle

should work nicely and renders the whole need for this patch obsolete.

Regards,

Hans




> ---
>  MAINTAINERS                                 |   6 ++
>  drivers/platform/x86/Kconfig                |   2 +
>  drivers/platform/x86/Makefile               |   3 +
>  drivers/platform/x86/tuxedo/Kbuild          |   8 ++
>  drivers/platform/x86/tuxedo/Kconfig         |   8 ++
>  drivers/platform/x86/tuxedo/nb02/Kbuild     |   9 ++
>  drivers/platform/x86/tuxedo/nb02/Kconfig    |  17 ++++
>  drivers/platform/x86/tuxedo/nb02/platform.c | 107 ++++++++++++++++++++
>  8 files changed, 160 insertions(+)
>  create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>  create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>  create mode 100644 drivers/platform/x86/tuxedo/nb02/Kbuild
>  create mode 100644 drivers/platform/x86/tuxedo/nb02/Kconfig
>  create mode 100644 drivers/platform/x86/tuxedo/nb02/platform.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0736dc2ee0e..7139c32e96dc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24190,6 +24190,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>  F:	tools/power/x86/turbostat/
>  F:	tools/testing/selftests/turbostat/
>  
> +TUXEDO DRIVERS
> +M:	Werner Sembach <wse@tuxedocomputers.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Supported
> +F:	drivers/platform/x86/tuxedo/
> +
>  TW5864 VIDEO4LINUX DRIVER
>  M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>  M:	Andrey Utkin <andrey.utkin@corp.bluecherry.net>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64b..9b78a1255c08e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1199,3 +1199,5 @@ config P2SB
>  	  The main purpose of this library is to unhide P2SB device in case
>  	  firmware kept it hidden on some platforms in order to access devices
>  	  behind it.
> +
> +source "drivers/platform/x86/tuxedo/Kconfig"
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index e1b1429470674..1562dcd7ad9a5 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
>  
>  # SEL
>  obj-$(CONFIG_SEL3350_PLATFORM)		+= sel3350-platform.o
> +
> +# TUXEDO
> +obj-y					+= tuxedo/
> diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/tuxedo/Kbuild
> new file mode 100644
> index 0000000000000..1c79b80744d1b
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kbuild
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +obj-y	+= nb02/
> diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/tuxedo/Kconfig
> new file mode 100644
> index 0000000000000..13b484999e333
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +source "drivers/platform/x86/tuxedo/nb02/Kconfig"
> diff --git a/drivers/platform/x86/tuxedo/nb02/Kbuild b/drivers/platform/x86/tuxedo/nb02/Kbuild
> new file mode 100644
> index 0000000000000..f56629c8b9dd8
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/Kbuild
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +tuxedo_nb02_platform-y			:= platform.o
> +obj-$(CONFIG_TUXEDO_NB02_PLATFORM)	+= tuxedo_nb02_platform.o
> diff --git a/drivers/platform/x86/tuxedo/nb02/Kconfig b/drivers/platform/x86/tuxedo/nb02/Kconfig
> new file mode 100644
> index 0000000000000..38cd60c9d4f03
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
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


