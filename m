Return-Path: <linux-kernel+bounces-567215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A9DA68358
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583C419C1845
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D732144D4;
	Wed, 19 Mar 2025 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ9YJ6dM"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BEE17E0;
	Wed, 19 Mar 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352641; cv=none; b=VEf35PdXMwT0C3suzmMmt0K9YhH9I4m35/mVro4Pdex+ZVYw2lBTf7HGhy4M6E6dCcrxacrVnfn27O7HlHlFgLIai7FtcRKUSIuuBP70ld4/ZMXosFxkUJSImHTW85CUMdtw1nKV0yDlpHXmf+enRAdJszUW/syqZ2pNPiujm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352641; c=relaxed/simple;
	bh=LNV20yIwA2vf03iQ8M3dL6fpcmaGqtN4eFmtwC8UiNE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WPjyTg52FUQ5Bk+FCkJSOdFc9TLjr6dWX2tbjnXL1592LG3BH4Mq3O5jGhpG4W+TYRR9lUWCXZvCpjYkKhQlHvj2SNmtONKP8tNM9yuGyCzs15a9Rq/TTCKzUNZGFebHs9UVT0JeOk9t4+Muy1TEojMQXBJRkpwiEy+LHqLR4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ9YJ6dM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2255003f4c6so113710235ad.0;
        Tue, 18 Mar 2025 19:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742352639; x=1742957439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3i4Z5ur+Rrflt73rwbY7ENtGRrg0E27Zbss6mezICVg=;
        b=UQ9YJ6dMlz36E+MmRc9HEA/74cpGC6lBn4dORzDQUuCQdp2HMMPmC1q10ZVyXMpx7d
         eez/GWVIYR9ZbzyGpMLUzbL3dfatR4ELuksZlLwdrra/lWIzMx3Hjm2Iqjyc+eN5Y7g2
         1kxQD/JHnfiYT/XtrAgazMMyYflMYkl5VqHeeELNSh403LwdHU5V7zZ/8V3FpWWz76yW
         MVt2oRTElLwv0vHuPxnsNCD79JAvUl85lTTurFfYl72dLp+6W/krLIArqMo32K0lWByQ
         lGVtnq+nQaKnpZAlSbzNdposDUV1vHtSX1SyeqGhlYPn7ZhtirvSUByHA/3aLfZyvkWB
         Ph4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742352639; x=1742957439;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3i4Z5ur+Rrflt73rwbY7ENtGRrg0E27Zbss6mezICVg=;
        b=u8swIQ2uBw0R6362LpjFrAbt5Uia/+DyAkcN+VdMaqSmsgkRWa9QW9hSeXiCeMzb7g
         t6YDMP2aszTIxdElQH7i5J3HL5hyu+pD/8K20vu7sk3P/E38H/SJqU3DPlbsXegvcCIc
         VDelj+zAd9Ry50V6ghMDs3TVfeCXGL1CELeq6fxAESePuELpSHjTRIyH/pQpG3gQzakb
         /pPkXIkUUKRQaQ69GPHL5Wwe5oO0N4EHFOLoWqGvXJ5AWzvGO1NDBJ5OiXZdwCL1H6vm
         zUBdqPbqY5EoAooAZLwXfyVYshJKfQAr2uOb4d9bUcLFckgCIENE4o6FZ4ZXQd5LREJc
         V/hA==
X-Forwarded-Encrypted: i=1; AJvYcCUN7F1ih3QXXI9GBaIwY/pAC31T1qZBCn1/wycLmwDl22onn2uf1/AkvcM3zDT9OYS4EIezF73aBB3lUVEn@vger.kernel.org, AJvYcCV4RDW9WzL1DIq/p9hspHZ6mFA2KSYHZix4Y0KI6cQCJDMbhiH8GtK3q053fpzIlGUKUWnbmBHefIc=@vger.kernel.org, AJvYcCXVRmkyv6WiDUtZ29gVu4VF6aPGDzdwqfWpbW/vAo7gY/MGJKy4vzgeWOTakhCgmIwA5jDBsNOhKRc5Hfz62p9b+VHknA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjT90CYntoOTizkZdry8bhvnZMoILnQ6XALKlM85xJdC/dxWW/
	LQIwXe5s6oiE4KTXTXv2CQ3LoCUJ1DIDuqKi7xf9c5iec+92dN5a
X-Gm-Gg: ASbGncuulu/bAsuNcHbBdNJciM6/nxTKK1+Fn5x5bsjyRgMw7gldstWJSv2LjVylTMT
	HqYa3g5xOa7Xtl65M8Aj13cug2EIztKePaSpU4XDAasBHXSeVSNSq9V3cN3LvODiGkr1Z3w9Fvq
	HU7Yjow2T6GksEuzckYllckK+dCpZaWSJKZTCgF26ECn/aOhrtfLyjuFo6aOaA3i9MITgSMDpwi
	R6vAVwZMw4LjNJhwKpIkn/hjdtIo7M4t21GBYWYTgeMAS44bMxIU+zuUBTZibTP3xBs64T6R2yf
	aUmt9AlTf1nP2JZ97YDDpF93Tn+kFaoW+MgjtO4wlyZH5LBKxrZN
X-Google-Smtp-Source: AGHT+IE+0MY+E9WZ6LlbdPc4YnR1/pn6seQsBbxdIb9DIXW8Z/1jN3ld4fUIfYXoVsgtK9o4vsaJsA==
X-Received: by 2002:a17:903:41c2:b0:223:2630:6b82 with SMTP id d9443c01a7336-2264981b460mr17657145ad.10.1742352639263;
        Tue, 18 Mar 2025 19:50:39 -0700 (PDT)
Received: from ?IPv6:::1? ([2607:fb90:74e1:402a:ad3:2458:5234:fd64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a404bsm102892055ad.54.2025.03.18.19.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 19:50:38 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:50:36 -1000
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Mario Limonciello <superm1@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Luke Jones <luke@ljones.dev>, Xino Ni <nijs1@lenovo.com>,
 Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Cody T . -H . Chiu" <codyit@gmail.com>, John Martens <johnfanv2@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6 RESEND] platform/x86: Add lenovo-wmi-helpers
User-Agent: Thunderbird for Android
In-Reply-To: <ae61a8ab-f5ae-4369-ac35-49b37fe412fc@kernel.org>
References: <20250317144326.5850-1-derekjohn.clark@gmail.com> <20250317144326.5850-3-derekjohn.clark@gmail.com> <ae61a8ab-f5ae-4369-ac35-49b37fe412fc@kernel.org>
Message-ID: <DE8A6646-43FD-4943-A2DE-DFB02E110B3F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 17, 2025 6:27:34 PM HST, Mario Limonciello <superm1@kernel=2Eorg>=
 wrote:
>On 3/17/25 09:43, Derek J=2E Clark wrote:
>> Adds documentation for all new lenovo-wmi drivers=2E
>
>You seem to have accidentally lost the commit message for this patch from=
 earlier versions and got the exact same commit message as the first patch=
=2E
>
>With that fixed the rest of the patch looks fine=2E  You can add for next=
 version=2E
>
>Reviewed-by: Mario Limonciello <mario=2Elimonciello@amd=2Ecom>
>

Hmm, not sure how that happened but thanks for letting me know=2E I'll get=
 that fixed for the next one=2E
- Derek

>>=20
>> Signed-off-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>> ---
>> v4:
>>   - Changed namespace to LENOVO_WMI_HELPERS from LENOVO_WMI=2E
>>   - Changed filenames to lenovo-wmi-helpers from lenovo-wmi=2E
>>   - Removed structs and functions implemented by other drivers=2E
>> ---
>>   MAINTAINERS                               |  2 +
>>   drivers/platform/x86/Kconfig              |  4 ++
>>   drivers/platform/x86/Makefile             |  1 +
>>   drivers/platform/x86/lenovo-wmi-helpers=2Ec | 64 ++++++++++++++++++++=
+++
>>   drivers/platform/x86/lenovo-wmi-helpers=2Eh | 24 +++++++++
>>   5 files changed, 95 insertions(+)
>>   create mode 100644 drivers/platform/x86/lenovo-wmi-helpers=2Ec
>>   create mode 100644 drivers/platform/x86/lenovo-wmi-helpers=2Eh
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 675f4b26426d=2E=2E3a370a18b806 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13164,6 +13164,8 @@ L:	platform-driver-x86@vger=2Ekernel=2Eorg
>>   S:	Maintained
>>   F:	Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst
>>   F:	Documentation/wmi/devices/lenovo-wmi-other=2Erst
>> +F:	drivers/platform/x86/lenovo-wmi-helpers=2Ec
>> +F:	drivers/platform/x86/lenovo-wmi-helpers=2Eh
>>     LENOVO WMI HOTKEY UTILITIES DRIVER
>>   M:	Jackie Dong <xy-jackie@139=2Ecom>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
>> index 43407e76476b=2E=2Ebece1ba61417 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -459,6 +459,10 @@ config IBM_RTL
>>   	 state =3D 0 (BIOS SMIs on)
>>   	 state =3D 1 (BIOS SMIs off)
>>   +config LENOVO_WMI_HELPERS
>> +	tristate
>> +	depends on ACPI_WMI
>> +
>>   config IDEAPAD_LAPTOP
>>   	tristate "Lenovo IdeaPad Laptop Extras"
>>   	depends on ACPI
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
>> index 650dfbebb6c8=2E=2E5a9f4e94f78b 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -69,6 +69,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+=3D think-lmi=2Eo
>>   obj-$(CONFIG_YOGABOOK)		+=3D lenovo-yogabook=2Eo
>>   obj-$(CONFIG_YT2_1380)		+=3D lenovo-yoga-tab2-pro-1380-fastcharger=2E=
o
>>   obj-$(CONFIG_LENOVO_WMI_CAMERA)	+=3D lenovo-wmi-camera=2Eo
>> +obj-$(CONFIG_LENOVO_WMI_HELPERS)	+=3D lenovo-wmi-helpers=2Eo
>>     # Intel
>>   obj-y				+=3D intel/
>> diff --git a/drivers/platform/x86/lenovo-wmi-helpers=2Ec b/drivers/plat=
form/x86/lenovo-wmi-helpers=2Ec
>> new file mode 100644
>> index 000000000000=2E=2E36d553502223
>> --- /dev/null
>> +++ b/drivers/platform/x86/lenovo-wmi-helpers=2Ec
>> @@ -0,0 +1,64 @@
>> +// SPDX-License-Identifier: GPL-2=2E0-or-later
>> +/*
>> + * Lenovo Legion WMI helpers driver=2E The Lenovo Legion WMI interface=
 is
>> + * broken up into multiple GUID interfaces that require cross-referenc=
es
>> + * between GUID's for some functionality=2E The "Custom Method" interf=
ace is a
>> + * legacy interface for managing and displaying CPU & GPU power and hw=
mon
>> + * settings and readings=2E The "Other Mode" interface is a modern int=
erface
>> + * that replaces or extends the "Custom Method" interface methods=2E T=
he
>> + * "Gamezone" interface adds advanced features such as fan profiles an=
d
>> + * overclocking=2E The "Lighting" interface adds control of various st=
atus
>> + * lights related to different hardware components=2E Each of these dr=
ivers
>> + * uses a common procedure to get data fro the WMI interface, enumerat=
ed here=2E
>> + *
>> + * Copyright(C) 2025 Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>> + *
>> + */
>> +
>> +#include <linux/wmi=2Eh>
>> +#include "lenovo-wmi-helpers=2Eh"
>> +
>> +/*
>> + * lwmi_dev_evaluate_method() - Helper function to call wmidev_evaluat=
e_method
>> + * for Lenovo WMI device method calls that return an ACPI integer=2E
>> + * @wdev: Pointer to the WMI device to be called=2E
>> + * @instance: Instance of the called method=2E
>> + * @method_id: WMI Method ID for the method to be called=2E
>> + * @buf: Buffer of all arguments for the given method_id=2E
>> + * @size: Length of the buffer=2E
>> + * @retval: Pointer for the return value to be assigned=2E
>> + *
>> + * Returns: 0, or an error=2E
>> + */
>> +int lwmi_dev_evaluate_method(struct wmi_device *wdev, u8 instance,
>> +			     u32 method_id, unsigned char *buf, size_t size,
>> +			     u32 *retval)
>> +{
>> +	struct acpi_buffer input =3D { size, buf };
>> +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
>> +	union acpi_object *ret_obj __free(kfree) =3D NULL;
>> +	acpi_status status;
>> +
>> +	status =3D wmidev_evaluate_method(wdev, instance, method_id, &input,
>> +					&output);
>> +
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	if (retval) {
>> +		ret_obj =3D output=2Epointer;
>> +		if (!ret_obj)
>> +			return -ENODATA;
>> +
>> +		if (ret_obj->type !=3D ACPI_TYPE_INTEGER)
>> +			return -ENXIO;
>> +
>> +		*retval =3D (u32)ret_obj->integer=2Evalue;
>> +	}
>> +	return 0;
>> +};
>> +EXPORT_SYMBOL_NS_GPL(lwmi_dev_evaluate_method, "LENOVO_WMI_HELPERS");
>> +
>> +MODULE_AUTHOR("Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>");
>> +MODULE_DESCRIPTION("Lenovo WMI Helpers Driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/platform/x86/lenovo-wmi-helpers=2Eh b/drivers/plat=
form/x86/lenovo-wmi-helpers=2Eh
>> new file mode 100644
>> index 000000000000=2E=2E7e0d7870790e
>> --- /dev/null
>> +++ b/drivers/platform/x86/lenovo-wmi-helpers=2Eh
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2=2E0-or-later
>> + *
>> + * Copyright(C) 2025 Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>> + *
>> + */
>> +#include <linux/notifier=2Eh>
>> +#include <linux/platform_profile=2Eh>
>> +
>> +#ifndef _LENOVO_WMI_HELPERS_H_
>> +#define _LENOVO_WMI_HELPERS_H_
>> +
>> +#include <linux/types=2Eh>
>> +#include <linux/wmi=2Eh>
>> +
>> +struct wmi_method_args_32 {
>> +	u32 arg0;
>> +	u32 arg1;
>> +};
>> +
>> +int lwmi_dev_evaluate_method(struct wmi_device *wdev, u8 instance,
>> +			     u32 method_id, unsigned char *buf, size_t size,
>> +			     u32 *retval);
>> +
>> +#endif /* !_LENOVO_WMI_HELPERS_H_ */
>

- Derek

