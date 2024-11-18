Return-Path: <linux-kernel+bounces-412911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95859D1115
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B22C2823F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7022C1991BB;
	Mon, 18 Nov 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4X3l/0j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384B190468;
	Mon, 18 Nov 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934710; cv=none; b=gtpUzvZTH+WMYlRhG/YpLtINqmhEQA4l9C7DkMrr3ICZEDq2mqFtuCJL72RMi3p4tdog6M+INymca0cvZW/CvPH2n1em645kt0rYlXYA5QVKhrI6kDXCJVe9d/DyTBF+Nzsnu612o3xNdDH22XiMGOjQU5Eop8DRgXBK90zI58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934710; c=relaxed/simple;
	bh=wQ7blzisUUdEIw0OcWxuhv/gqro8DbcVsUVkLHD+lEc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TN3D5LrcaWGGqc2CwKogCJeeGqhgX20TvuIzvXaHJPI/Z8hVgnrmHJPy96+ekuXzZwzvbFLvOOA7uXnWCWfburfmAjzhLro2KZrySyeZf/OpKDY2eBrUnbzJ41vPv3FMDwSmr9p87frnwKEmaA3kZ1ipBxWpdFGcn/vRJNBKcmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4X3l/0j; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731934708; x=1763470708;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=wQ7blzisUUdEIw0OcWxuhv/gqro8DbcVsUVkLHD+lEc=;
  b=D4X3l/0jUFgwOeoboTy2fogT6p1GeeuH/Y3LjZjwp2os0/VdS1zqQ2z8
   Cgc2Eay12P0G33tJRz+tGHYKai5pMi+Z/8ULFIe+tkAWDDSKZ3Z5m5oiT
   fxB3CJIc4bsdcHjuYRusayQeapfnifUj1RZ0/UOlMZ5Z5kJaDsWPoXKvv
   Il8mVRN04if5Mvp6i+/9pb43Z2uB6Va3+BbSZCk3e01KePxTyHbKKqbfF
   Rq7T+qekRrFlTpcGs5DB1Nb+2+/x58w8f/ZEwk7tJTHgFlg5+HCq677y6
   hyxJewUNYzcqLQnCrbf03n3wraNZcuUfFK+tbslNuQCAW/WIEMaGmcwYC
   A==;
X-CSE-ConnectionGUID: EZ6odbiSTD+WnW8YBH9qaA==
X-CSE-MsgGUID: e/wAouQ5RCqjvEz9ldBSAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="49426965"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="49426965"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:58:27 -0800
X-CSE-ConnectionGUID: 93OEPUv3SYqBb4SlYyIr/Q==
X-CSE-MsgGUID: KNmqpzdWTZ2ZfEoDmB9GMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="112513692"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.193])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:58:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 18 Nov 2024 14:58:20 +0200 (EET)
To: zhixin zhang <jonmail@163.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, zhixin zhang <zhangzx36@lenovo.com>
Subject: Re: [PATCH] Lenovo Legion Go WMI Control
In-Reply-To: <20241118100503.14228-1-jonmail@163.com>
Message-ID: <04470c4c-c1cb-c1e4-72b8-8cdbe383f5b1@linux.intel.com>
References: <20241118100503.14228-1-jonmail@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1241815719-1731933881=:933"
Content-ID: <0dcb9df1-938d-6098-91a7-a4dd686f9e4c@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1241815719-1731933881=:933
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e256d9bd-395c-b3ea-d226-929a057ed012@linux.intel.com>

On Mon, 18 Nov 2024, zhixin zhang wrote:

> From: zhixin zhang <zhangzx36@lenovo.com>
>=20
> This driver provides support for modifying the performance mode
> function of Lenovo's Legion Go series.
>=20
> Signed-off-by: zhixin zhang <zhangzx36@lenovo.com>
> ---
>  drivers/platform/x86/Kconfig         |   9 +
>  drivers/platform/x86/Makefile        |   1 +
>  drivers/platform/x86/legion-go-wmi.c | 552 +++++++++++++++++++++++++++
>  3 files changed, 562 insertions(+)
>  create mode 100644 drivers/platform/x86/legion-go-wmi.c
>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 3875abba5a79..d04018f69dc6 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -483,6 +483,15 @@ config LENOVO_YMC
>  =09  This driver maps the Tablet Mode Control switch to SW_TABLET_MODE i=
nput
>  =09  events for Lenovo Yoga notebooks.
> =20
> +config LEGION_GO_WMI
> +=09tristate "Lenovo Legion Go WMI Control"
> +=09depends on ACPI_WMI
> +=09depends on INPUT
> +=09help
> +=09  This driver provides support for modifying the performance mode
> +=09  function of Lenovo's Legion Go series, as well as the ability to
> +=09  set CPU power consumption in custom mode.
> +
>  config SENSORS_HDAPS
>  =09tristate "Thinkpad Hard Drive Active Protection System (hdaps)"
>  =09depends on INPUT
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index e1b142947067..74b1f107084f 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_THINKPAD_LMI)=09+=3D think-lmi.o
>  obj-$(CONFIG_YOGABOOK)=09=09+=3D lenovo-yogabook.o
>  obj-$(CONFIG_YT2_1380)=09=09+=3D lenovo-yoga-tab2-pro-1380-fastcharger.o
>  obj-$(CONFIG_LENOVO_WMI_CAMERA)=09+=3D lenovo-wmi-camera.o
> +obj-$(CONFIG_LEGION_GO_WMI)=09+=3D legion-go-wmi.o
> =20
>  # Intel
>  obj-y=09=09=09=09+=3D intel/
> diff --git a/drivers/platform/x86/legion-go-wmi.c b/drivers/platform/x86/=
legion-go-wmi.c
> new file mode 100644
> index 000000000000..e319219c3ace
> --- /dev/null
> +++ b/drivers/platform/x86/legion-go-wmi.c
> @@ -0,0 +1,552 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * legion-go-wmi.c - Lenovo Legion Go WMI Control
> + *
> + * Copyright =A9 2024 zhixin zhang <zhangzx36@lenovo.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include <linux/printk.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/proc_fs.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/version.h>

Order alphabetically.

> +
> +//extern struct proc_dir_entry *acpi_root_dir;

???

> +struct proc_dir_entry *acpi_root_dir;
> +
> +#define BUFFER_SIZE 256
> +
> +#define LEGION_GO_WMI_GAMEZONE_GUID=09=09=09"887B54E3-DDDC-4B2C-8B88-68A=
26A8835D0"
> +#define LEGION_GO_WMI_OTHER_GUID=09=09=09"dc2a8805-3a8c-41ba-a6f7-092e00=
89cd3b"
> +
> +//wmi_device_id context string
> +#define LEGION_GO_WMI_GAMEZONE_CONTEXT=09"GameZone"
> +#define LEGION_GO_WMI_OTHER_CONTEXT=09=09"Other"
> +
> +//funciton name

function

All your comments seem to miss space.

> +#define CMD_SET_SPL=09=09=09=09"SetSPL"
> +#define CMD_GET_SPL=09=09=09=09"GetSPL"
> +#define CMD_SET_SPPT=09=09=09"SetSPPT"
> +#define CMD_GET_SPPT=09=09=09"GetSPPT"
> +#define CMD_SET_FPPT=09=09=09"SetFPPT"
> +#define CMD_GET_FPPT=09=09=09"GetFPPT"
> +#define CMD_SET_SMART_FAN_MODE=09"SetSmartFanMode"
> +#define CMD_GET_SMART_FAN_MODE=09"GetSmartFanMode"
> +
> +//function arg for ids
> +enum legion_go_wmi_ids{
> +=09ARG_SPL_CUSTOM_MODE =3D 0x0102FF00,
> +=09ARG_SPL_GET_VALUE =3D 0x0102FF00,
> +
> +=09ARG_SPPT_CUSTOM_MODE =3D 0x0101FF00,
> +=09ARG_SPPT_GET_VALUE =3D 0x0101FF00,
> +
> +=09ARG_FPPT_CUSTOM_MODE =3D 0x0103FF00,
> +=09ARG_FPPT_GET_VALUE =3D 0x0103FF00,
> +
> +=09ARG_SMART_FAN_QUIENT_MODE =3D 0x1,
> +=09ARG_SMART_FAN_BALANCE_MODE =3D 0x2,
> +=09ARG_SMART_FAN_PERFORMANCE_MODE =3D 0x3,
> +=09ARG_SMART_FAN_CUSTOM_MODE =3D 0xFF,

Align values.

Are these groups actually independent? If yes, they don't belong into same=
=20
enum.

> +};
> +
> +static const struct wmi_device_id legion_go_wmi_id_table[] =3D {
> +=09{ LEGION_GO_WMI_GAMEZONE_GUID, LEGION_GO_WMI_GAMEZONE_CONTEXT },
> +=09{ LEGION_GO_WMI_OTHER_GUID, LEGION_GO_WMI_OTHER_CONTEXT },
> +=09{ }
> +};
> +
> +

Extra newline, but can you also place the array close to where it's used.

> +enum legion_go_wmi_gamezone_method {
> +=09legion_go_wmi_gamezone_method=09=3D 0xAA,=09// WMAA, DSDT
> +=09LEGION_GO_WMI_OTHER_METHOD=09=09=3D 0xAE,=09// WMAA, DSDT
> +};
> +
> +//wmi command
> +enum legion_go_wmi_command {
> +=09// smart fan mode
> +=09LEGION_GO_WMI_GAMEZONE_SET_SMARTFANMODE=09=3D 0x2C,
> +=09LEGION_GO_WMI_GAMEZONE_GET_SMARTFANMODE=09=3D 0x2D,
> +=09// set bois feature
> +=09LEGION_GO_WMI_OTHER_SET_FEATURE_VALUE=09=3D 0x12,
> +=09LEGION_GO_WMI_OTHER_GET_FEATURE_VALUE=09=3D 0x11,
> +};
> +
> +//wmi call function
> +enum legion_go_call_function {
> +=09LEGION_GO_FUNC_NONE,
> +=09LEGION_GO_FUNC_SET_SPL,
> +=09LEGION_GO_FUNC_GET_SPL,
> +=09LEGION_GO_FUNC_SET_SPPT,
> +=09LEGION_GO_FUNC_GET_SPPT,
> +=09LEGION_GO_FUNC_SET_FPPT,
> +=09LEGION_GO_FUNC_GET_FPPT,
> +=09LEGION_GO_FUNC_SET_SMART_FAN_MODE,
> +=09LEGION_GO_FUNC_GET_SMART_FAN_MODE
> +};
> +
> +struct legion_go_wmi_args_3i {
> +=09u32 arg1;
> +=09u32 arg2;
> +=09u32 arg3;
> +};
> +
> +struct legion_go_wmi_args_2i {
> +=09u32 arg1;
> +=09u32 arg2;
> +};
> +
> +struct legion_go_wmi_args_1i {
> +=09u32 arg1;
> +};
> +
> +struct legion_go_global {
> +=09struct wmi_device *legion_device[2]; //0:"GameZone"  1:"Other"
> +=09enum legion_go_call_function last_call_function;
> +=09bool first_read;
> +=09struct proc_dir_entry *acpi_entry;
> +=09char result_buffer[BUFFER_SIZE];
> +};
> +
> +static struct legion_go_global g_Legion_Go_Global =3D {
> +=09.legion_device =3D {NULL, NULL},
> +=09.last_call_function =3D LEGION_GO_FUNC_NONE,
> +=09.first_read =3D true,
> +=09.acpi_entry =3D NULL,
> +};
> +
> +static acpi_status legion_go_wmi_perform_query(struct wmi_device *wdev,
> +=09=09enum legion_go_wmi_gamezone_method method_id,
> +=09=09const struct acpi_buffer *in,
> +=09=09struct acpi_buffer *out)
> +{
> +=09acpi_status ret =3D wmidev_evaluate_method(wdev, 0x0, method_id, in, =
out);
> +
> +=09if (ACPI_FAILURE(ret)) {
> +=09=09dev_warn(&wdev->dev, "LEGION GO WMI: WMI query failed with error: =
%d\n", ret);
> +=09=09return -EIO;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static acpi_status legion_go_wmi_query_integer(struct wmi_device *wdev,
> +=09=09enum legion_go_wmi_gamezone_method method_id,
> +=09=09const struct acpi_buffer *in,
> +=09=09u32 *res)

Does this query "integer" or u32 as per the res parameter? If the latter,=
=20
rename accordingly please. (And integer could be "int" too but I suspect=20
you want _u32 in the name instead)

> +{
> +=09union acpi_object *obj;
> +=09struct acpi_buffer result =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09acpi_status ret;

Reverse xmas-tree order.

> +
> +=09ret =3D legion_go_wmi_perform_query(wdev, method_id, in, &result);
> +=09if (ret) {
> +=09=09return ret;
> +=09}

Unnecessary braces.

> +
> +=09obj =3D result.pointer;
> +=09if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
> +=09=09*res =3D obj->integer.value;
> +=09}
> +=09else {

} else {

But then braces are unnecessary for one line blocks.

> +=09=09ret =3D -EIO;
> +=09}
> +
> +=09kfree(result.pointer);
> +=09return ret;
> +}
> +
> +
> +/**
> + * procfs write callback. Called when writing into /proc/acpi/call.

Not formatted according to kerneldoc, either make it kerneldoc compliant=20
or change /** -> /*

> +*/
> +static ssize_t acpi_proc_write(struct file *filp,
> +=09=09const char __user *buff,
> +=09=09size_t len,
> +=09=09loff_t *data)

Misaligned. Try to use less lines.

> +{
> +    char input[2 * BUFFER_SIZE] =3D { '\0' };

Don't place large arrays into stack.

=3D {}; is enough to initialize.

> +    union acpi_object *args;
> +    int nargs, i;
> +    char *method;

Use tabs for indentation.

> +
> +=09u32 prod_id;
> +=09acpi_status ret;
> +
> +    if (len > sizeof(input) - 1) {
> +        printk(KERN_ERR "LEGION GO WMI: Input too long! (%lu)\n", len);

Use dev_err() and don't provide prefix yourself. Although I'm not sure if=
=20
this is useful on KERN_ERR level...

> +        return -ENOSPC;

-EINVAL

> +    }
> +
> +    if (copy_from_user( input, buff, len )) {

No spaces next to function opening and closing parenthesis.

> +        return -EFAULT;
> +    }
> +
> +    input[len] =3D '\0';
> +    if (input[len-1] =3D=3D '\n')
> +        input[len-1] =3D '\0';
> +
> +=09printk("LEGION GO WMI: procfs write is %s\n", input);
> +
> +=09char cmd[2 * BUFFER_SIZE] =3D { '\0' };
> +=09char arg1[2 * BUFFER_SIZE] =3D { '\0' };

Not from stack.

> +=09int arg1Num =3D 0;
> +=09int retNum =3D 0;

Wrong variable naming style.

> +
> +=09int pos =3D -1;
> +=09for(int i=3D0;i<2 * BUFFER_SIZE;i++) {

Wrong spacing.

> +=09=09if(input[i]=3D=3D ',') {

Missing spaces.

Is the input guaranteed to have only single comma?

> +=09=09=09memcpy(cmd,input,i*sizeof(char));

Why you need to duplicate it again?

> +=09=09=09pos =3D i+1;

Missing spaces.

> +=09=09}
> +=09=09else if(input[i]=3D=3D'\0' && pos !=3D -1) {
> +=09=09=09memcpy(arg1,input+pos,(i-pos)*sizeof(char));
> +=09=09=09pos =3D i+1;
> +=09=09=09break;
> +=09=09}
> +=09}
> +=09if(pos =3D=3D -1) {
> +=09=09memcpy(cmd,input,len*sizeof(char));
> +=09}
> +=09else {
> +=09=09printk(KERN_ERR "LEGION GO WMI: cmd =3D %s, arg1 : %s\n", cmd,arg1=
);

Are these your debug prints or what?

> +=09=09retNum =3D kstrtoint(arg1,10,&arg1Num);

Parse in place, there's no need to do a memcpy because of parsing int.

> +=09=09if(retNum !=3D 0)
> +=09=09{
> +=09=09=09printk(KERN_ERR "LEGION GO WMI: arg1 =3D %s param error!\n",arg=
1);
> +=09=09=09return -ENOSPC;

-EINVAL? If given input is wrong/invalid, we return -EINVAL.

> +=09=09}
> +=09}
> +
> +=09if(ret =3D=3D 0) {

Not initialized!??!

> +=09=09if(strcmp(cmd,CMD_SET_SPL)=3D=3D0) {

So you memcpy earlier to just run strcmp(), why memcpy?

> +=09=09=09struct legion_go_wmi_args_2i args =3D {
> +=09=09=09=09.arg1 =3D ARG_SPL_CUSTOM_MODE,
> +=09=09=09=09.arg2 =3D arg1Num,
> +=09=09=09};
> +=09=09=09const struct acpi_buffer in =3D {
> +=09=09=09=09.length =3D sizeof(args),
> +=09=09=09=09.pointer =3D &args,
> +=09=09=09};
> +
> +=09=09=09g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_SET_SP=
L;
> +
> +=09=09=09ret =3D legion_go_wmi_query_integer(g_Legion_Go_Global.legion_d=
evice[1],=20
> +=09=09=09=09=09LEGION_GO_WMI_OTHER_SET_FEATURE_VALUE, &in, &prod_id);
> +=09=09=09if (ret =3D=3D 0) {
> +=09=09=09=09dev_info(&g_Legion_Go_Global.legion_device[1]->dev,=20

Your variable name is perhaps a bit on the long side :-). Please try to=20
make it a bit shorter. Also no CAPS in variable names.

> +=09=09=09=09=09=09"LEGION GO WMI: SetSPL result is %d\n", prod_id);

Don't print info level message on success. You might not need to print=20
anything here as this kind of looks like something that was useful during=
=20
development or so.

> +=09=09=09}
> +=09=09=09else {
> +=09=09=09=09dev_warn(&g_Legion_Go_Global.legion_device[1]->dev,
> +=09=09=09=09=09=09"LEGION GO WMI: SetSPL query failed with err: %d\n", r=
et);

return error?

> +=09=09=09}
> +=09=09}
> +=09=09else if(strcmp(cmd,CMD_GET_SPL)=3D=3D0) {
> +=09=09=09g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_GET_SP=
L;
> +=09=09}
> +=09=09else if(strcmp(cmd,CMD_SET_SPPT)=3D=3D0) {
> +=09=09=09struct legion_go_wmi_args_2i args =3D {
> +=09=09=09=09.arg1 =3D ARG_SPPT_CUSTOM_MODE,
> +=09=09=09=09.arg2 =3D arg1Num,
> +=09=09=09};
> +=09=09=09const struct acpi_buffer in =3D {
> +=09=09=09=09.length =3D sizeof(args),
> +=09=09=09=09.pointer =3D &args,
> +=09=09=09};
> +
> +=09=09=09g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_SET_SP=
PT;
> +
> +=09=09=09ret =3D legion_go_wmi_query_integer(g_Legion_Go_Global.legion_d=
evice[1],
> +=09=09=09=09=09LEGION_GO_WMI_OTHER_SET_FEATURE_VALUE,
> +=09=09=09=09=09&in,
> +=09=09=09=09=09&prod_id);
> +=09=09=09if (ret =3D=3D 0) {
> +=09=09=09=09dev_info(&g_Legion_Go_Global.legion_device[1]->dev,
> +=09=09=09=09=09=09"LEGION GO WMI: SetSPPT result is %d\n", prod_id);
> +=09=09=09}
> +=09=09=09else {
> +=09=09=09=09dev_warn(&g_Legion_Go_Global.legion_device[1]->dev,
> +=09=09=09=09=09=09"LEGION GO WMI: SetSPPT query failed with err: %d\n", =
ret);
> +=09=09=09}
> +=09=09}
> +=09=09else if(strcmp(cmd,CMD_GET_SPPT)=3D=3D0) {
> +=09=09=09g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_GET_SP=
PT;
> +=09=09}
> +=09=09else if(strcmp(cmd,CMD_SET_FPPT)=3D=3D0) {
> +=09=09=09struct legion_go_wmi_args_2i args =3D {
> +=09=09=09=09.arg1 =3D ARG_FPPT_CUSTOM_MODE,
> +=09=09=09=09.arg2 =3D arg1Num,
> +=09=09=09};
> +=09=09=09const struct acpi_buffer in =3D {
> +=09=09=09=09.length =3D sizeof(args),
> +=09=09=09=09.pointer =3D &args,
> +=09=09=09};
> +
> +=09=09=09g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_SET_FP=
PT;
> +
> +=09=09=09ret =3D legion_go_wmi_query_integer(g_Legion_Go_Global.legion_d=
evice[1],
> +=09=09=09=09=09LEGION_GO_WMI_OTHER_SET_FEATURE_VALUE,
> +=09=09=09=09=09&in,
> +=09=09=09=09=09&prod_id);
> +=09=09=09if (ret =3D=3D 0) {
> +=09=09=09=09dev_info(&g_Legion_Go_Global.legion_device[1]->dev,
> +=09=09=09=09=09=09"LEGION GO WMI: SetFPPT result is %d\n", prod_id);
> +=09=09=09}
> +=09=09=09else {
> +=09=09=09=09dev_warn(&g_Legion_Go_Global.legion_device[1]->dev,
> +=09=09=09=09=09=09"LEGION GO WMI: SetFPPT query failed with err: %d\n", =
ret);
> +=09=09=09}
> +=09=09}
> +=09=09else if(strcmp(cmd,CMD_GET_FPPT)=3D=3D0) {
> +=09=09=09g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_GET_FP=
PT;
> +=09=09}
> +=09=09else if(strcmp(cmd,CMD_SET_SMART_FAN_MODE)=3D=3D0) {
> +=09=09=09if(arg1Num !=3D 1 && arg1Num !=3D 2 && arg1Num !=3D 3 && arg1Nu=
m !=3D 0xFF) {
> +=09=09=09=09printk(KERN_ERR "LEGION GO WMI: %s arg1 =3D %s param error!\=
n",
> +=09=09=09=09=09=09CMD_SET_SMART_FAN_MODE,arg1);
> +=09=09=09=09return -ENOSPC;
> +=09=09=09}
> +
> +=09=09=09struct legion_go_wmi_args_1i args =3D {
> +=09=09=09=09.arg1 =3D arg1Num,
> +=09=09=09};
> +=09=09=09const struct acpi_buffer in =3D {
> +=09=09=09=09.length =3D sizeof(args),
> +=09=09=09=09.pointer =3D &args,
> +=09=09=09};
> +=09=09=09g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_SET_SM=
ART_FAN_MODE;
> +=09=09=09ret =3D legion_go_wmi_query_integer(g_Legion_Go_Global.legion_d=
evice[0],
> +=09=09=09=09=09LEGION_GO_WMI_GAMEZONE_SET_SMARTFANMODE,
> +=09=09=09=09=09&in,
> +=09=09=09=09=09&prod_id);
> +
> +=09=09=09if (ret =3D=3D 0) {
> +=09=09=09=09dev_info(&g_Legion_Go_Global.legion_device[0]->dev,
> +=09=09=09=09=09"LEGION GO WMI: SetSmartFanMode query result is %d\n", pr=
od_id);
> +=09=09=09}=20
> +=09=09=09else {
> +=09=09=09=09dev_warn(&g_Legion_Go_Global.legion_device[0]->dev,
> +=09=09=09=09"LEGION GO WMI: SetSmartFanMode query failed with err: %d\n"=
, ret);
> +=09=09=09}
> +=09=09}
> +=09=09else if(strcmp(cmd,CMD_GET_SMART_FAN_MODE)=3D=3D0) {
> +=09=09=09g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_GET_SM=
ART_FAN_MODE;
> +=09=09}
> +=09}
> +
> +    return len;
> +}
> +
> +//read other mothod

No new information given by this comment. If you have nothing else to=20
stay, just comments like this as the function name tells the same=20
information already.

> +acpi_status acpi_proc_read_other(struct wmi_device *wdev,
> +=09=09enum legion_go_wmi_command cmd,
> +=09=09struct legion_go_wmi_args_1i* args,
> +=09=09char* funciton_name)

function

> +{
> +=09u32 prod_id =3D 0;
> +=09const struct acpi_buffer in =3D {
> +=09=09.length =3D sizeof(*args),
> +=09=09.pointer =3D args,
> +=09};
> +=09acpi_status ret =3D legion_go_wmi_query_integer(wdev, cmd,  &in, &pro=
d_id);
> +=09if (ret =3D=3D 0) {

=09acpi_status ret;

=09ret =3D legion_go_wmi_query_integer(wdev, cmd,  &in, &prod_id);
=09if (...) {

> +=09=09dev_info(&wdev->dev, "LEGION GO WMI: Integer query result is %d\n"=
, prod_id);
> +=09=09snprintf(g_Legion_Go_Global.result_buffer,BUFFER_SIZE,"%s,%u",func=
iton_name,prod_id);
> +=09}=20
> +=09else {
> +=09=09dev_warn(&wdev->dev, "LEGION GO WMI: Integer query failed with err=
: %d\n", ret);
> +=09=09snprintf(g_Legion_Go_Global.result_buffer,BUFFER_SIZE,"%s,error",f=
unciton_name);
> +=09}
> +=09return ret;
> +}
> +
> +static ssize_t acpi_proc_read(struct file *filp, char __user *buff, size=
_t count, loff_t *off)
> +{
> +=09u32 prod_id;
> +=09acpi_status ret;
> +=09int len =3D strlen(g_Legion_Go_Global.result_buffer);
> +
> +=09memset(g_Legion_Go_Global.result_buffer,'\0',len);

Is the use of result_buffer race free?

> +
> +=09if(g_Legion_Go_Global.last_call_function =3D=3D LEGION_GO_FUNC_NONE) =
{

Why isn't this inside switch/case?

> +=09=09ssize_t result =3D simple_read_from_buffer(buff,

Define variable separately.

> +=09=09=09=09count,
> +=09=09=09=09off,
> +=09=09=09=09g_Legion_Go_Global.result_buffer,
> +=09=09=09=09len + 1);

Badly misaligned.

> +=09=09return result;
> +=09=09//return -EIO;

Remove all commented out code fragments.

> +=09}
> +
> +
> +=09switch(g_Legion_Go_Global.last_call_function) {
> +=09=09case LEGION_GO_FUNC_SET_SPL:
> +=09=09case LEGION_GO_FUNC_GET_SPL:
> +=09=09{
> +=09=09=09struct legion_go_wmi_args_1i args =3D {
> +=09=09=09=09.arg1 =3D ARG_SPL_GET_VALUE,
> +=09=09=09};
> +=09=09=09ret =3D acpi_proc_read_other(g_Legion_Go_Global.legion_device[1=
],
> +=09=09=09=09LEGION_GO_WMI_OTHER_GET_FEATURE_VALUE,
> +=09=09=09=09&args,
> +=09=09=09=09CMD_GET_SPL);
> +
> +=09=09=09break;
> +=09=09}
> +=09=09case LEGION_GO_FUNC_SET_SPPT:
> +=09=09case LEGION_GO_FUNC_GET_SPPT:
> +=09=09{
> +=09=09=09struct legion_go_wmi_args_1i args =3D {
> +=09=09=09=09.arg1 =3D ARG_SPPT_GET_VALUE,
> +=09=09=09};
> +=09=09=09ret =3D acpi_proc_read_other(g_Legion_Go_Global.legion_device[1=
],
> +=09=09=09=09=09LEGION_GO_WMI_OTHER_GET_FEATURE_VALUE,
> +=09=09=09=09=09&args,
> +=09=09=09=09=09CMD_GET_SPPT);
> +
> +=09=09=09break;
> +=09=09}
> +=09=09case LEGION_GO_FUNC_SET_FPPT:
> +=09=09case LEGION_GO_FUNC_GET_FPPT:
> +=09=09{
> +=09=09=09struct legion_go_wmi_args_1i args =3D {
> +=09=09=09=09.arg1 =3D ARG_FPPT_GET_VALUE,
> +=09=09=09};
> +=09=09=09ret =3D acpi_proc_read_other(g_Legion_Go_Global.legion_device[1=
],
> +=09=09=09=09=09LEGION_GO_WMI_OTHER_GET_FEATURE_VALUE,
> +=09=09=09=09=09&args,
> +=09=09=09=09=09CMD_GET_FPPT);
> +
> +=09=09=09break;
> +=09=09}
> +=09=09case LEGION_GO_FUNC_SET_SMART_FAN_MODE:
> +=09=09case LEGION_GO_FUNC_GET_SMART_FAN_MODE:
> +=09=09{
> +=09=09=09struct legion_go_wmi_args_1i args =3D {
> +=09=09=09=09.arg1 =3D 255,
> +=09=09=09};
> +=09=09=09const struct acpi_buffer in =3D {
> +=09=09=09=09.length =3D sizeof(args),
> +=09=09=09=09.pointer =3D &args,
> +=09=09=09};
> +
> +=09=09=09ret =3D legion_go_wmi_query_integer(g_Legion_Go_Global.legion_d=
evice[0],
> +=09=09=09=09=09LEGION_GO_WMI_GAMEZONE_GET_SMARTFANMODE,
> +=09=09=09=09=09&in,
> +=09=09=09=09=09&prod_id);
> +=09=09=09if (ret =3D=3D 0) {
> +=09=09=09=09dev_info(&g_Legion_Go_Global.legion_device[0]->dev,
> +=09=09=09=09=09=09"LEGION GO WMI: Integer query result is %d\n", prod_id=
);
> +=09=09=09=09snprintf(g_Legion_Go_Global.result_buffer,BUFFER_SIZE,"%s,%u=
",
> +=09=09=09=09=09=09CMD_GET_SMART_FAN_MODE,prod_id);
> +=09=09=09}
> +=09=09=09else {
> +=09=09=09=09dev_warn(&g_Legion_Go_Global.legion_device[0]->dev,
> +=09=09=09=09=09=09"LEGION GO WMI: Integer query failed with err: %d\n", =
ret);
> +=09=09=09=09snprintf(g_Legion_Go_Global.result_buffer,BUFFER_SIZE,"%s,er=
ror",
> +=09=09=09=09=09=09CMD_GET_SMART_FAN_MODE);
> +=09=09=09}
> +=09=09=09break;
> +=09=09}
> +=09=09default:
> +=09=09{
> +=09=09=09strcpy(g_Legion_Go_Global.result_buffer,"LEGION GO WMI: nothing=
 to write");
> +=09=09}
> +=09}
> +
> +=09if(g_Legion_Go_Global.first_read =3D=3D true) {
> +=09=09char temp[BUFFER_SIZE] =3D {'\0'};
> +=09=09strcpy(temp, g_Legion_Go_Global.result_buffer);
> +=09=09strcpy(g_Legion_Go_Global.result_buffer+1, temp);
> +=09=09g_Legion_Go_Global.first_read =3D false;
> +=09}
> +=09// output the current result buffer
> +=09ssize_t result =3D simple_read_from_buffer(buff,
> +=09=09=09count,
> +=09=09=09off,
> +=09=09=09g_Legion_Go_Global.result_buffer,
> +=09=09=09len + 1);
> +
> +    return result;

In general, you should produce the string only as the last step before=20
return instead of all the copying you've going on.

> +}
> +
> +static const struct proc_ops proc_acpi_operations =3D {
> +        .proc_read     =3D acpi_proc_read,
> +        .proc_write    =3D acpi_proc_write,
> +};
> +
> +static int legion_go_wmi_probe(struct wmi_device *wdev, const void *cont=
ext)
> +{
> +=09dev_info(&wdev->dev, "LEGION GO WMI: Probe is starting.\n");

Don't print anything on success.

> +=09if (!wmi_has_guid(LEGION_GO_WMI_OTHER_GUID)) {
> +=09=09dev_warn(&wdev->dev, "LEGION GO WMI: No known OTHER WMI GUID found=
\n");
> +=09=09return -ENODEV;
> +=09}
> +
> +=09if (!wmi_has_guid(LEGION_GO_WMI_GAMEZONE_GUID)) {
> +=09=09dev_warn(&wdev->dev, "LEGION GO WMI: No known GAMEZONE WMI GUID fo=
und\n");

You shouldn't need to add the prefix on every line. Use dev_fmt() instead.

> +=09=09return -ENODEV;
> +=09}
> +
> +=09if (g_Legion_Go_Global.acpi_entry =3D=3D NULL) {
> +=09=09g_Legion_Go_Global.acpi_entry =3D proc_create("legion_go_call",=20
> +=09=09=09=090660,
> +=09=09=09=09acpi_root_dir,
> +=09=09=09=09&proc_acpi_operations);
> +=09}

Perhaps procfs is not right place for what you're trying to do (I'm a=20
bit loss what exactly because your code is quite hard to follow because=20
of various style issues and nested layers that seem to serve no real=20
purpose).

> +    if (g_Legion_Go_Global.acpi_entry =3D=3D NULL)
> +=09{
> +      dev_warn(&wdev->dev, "LEGION GO WMI: Couldn't create procfs entry\=
n");
> +      return -ENOMEM;
> +    }
> +
> +    dev_info(&wdev->dev, "LEGION GO WMI: procfs entry at /proc/acpi/legi=
on_go_call created.\n");
> +
> +=09dev_info(&wdev->dev, "LEGION GO WMI: Probe is exiting.\n");
> +
> +=09if(strcmp(context, LEGION_GO_WMI_GAMEZONE_CONTEXT)=3D=3D 0) {
> +=09=09g_Legion_Go_Global.legion_device[0] =3D wdev;
> +=09}
> +=09else {
> +=09=09g_Legion_Go_Global.legion_device[1] =3D wdev;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static void legion_go_wmi_remove(struct wmi_device *wdev)
> +{
> +=09g_Legion_Go_Global.legion_device[0] =3D NULL;
> +=09g_Legion_Go_Global.legion_device[1] =3D NULL;
> +
> +    remove_proc_entry("legion_go_call", acpi_root_dir);
> +
> +    dev_info(&wdev->dev, "LEGION GO WMI: procfs entry removed\n");
> +}
> +
> +static struct wmi_driver legion_go_wmi_driver =3D {
> +=09.driver =3D {
> +=09=09.name =3D "legion-go-wmi",
> +=09},
> +=09.id_table =3D legion_go_wmi_id_table,
> +=09.probe =3D legion_go_wmi_probe,
> +=09.remove =3D legion_go_wmi_remove
> +};
> +
> +module_wmi_driver(legion_go_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, legion_go_wmi_id_table);
> +
> +MODULE_DESCRIPTION("Lenovo Legion Go WMI Driver");
> +MODULE_AUTHOR("zhixin zhang<zhangzx36@lenovo.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0.0.0");

Drop MODULE_VERSION().


There were many repeated style issues in this submission. Please follow=20
what is outlined in Documentation/process/coding-style.rst. As somebody=20
already mentioned, checkpatch can help you find most of such issues but=20
perhaps not all.

--=20
 i.
--8323328-1241815719-1731933881=:933--

