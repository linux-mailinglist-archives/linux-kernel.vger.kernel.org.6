Return-Path: <linux-kernel+bounces-253647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBD7932446
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90565280E09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6617198E70;
	Tue, 16 Jul 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="BIbF7ZIN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bOOgJYDw"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4D2A1AA;
	Tue, 16 Jul 2024 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126500; cv=none; b=azPTK7VtyV7lqmUqh6uzLC6xC9+UBHJhxg8KydyJTZLicLrUjHm63TBk5sEoD+UwxsLS4dnlmIl43PqRYzC93W49iI6rxTAv67u8Y7dHh2ajRTdS8VAFGyeDJdNu4X2koqOvSQvRv0FxzCyhHNin4rAROyDsrX0CiVB/ZZ7qRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126500; c=relaxed/simple;
	bh=X3RJnHzgyOcE3u5x7HOFJwmdqlLt1h+rqsS1Mvf1gZM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=cgSrPFzmZFvQHHeb/p+x4nYIRtOBIOYC8W7lgmicPQ8JDjw926Uil/SO052rijWJ0+mA1RidXRa2LZlNqetSYoFXZiApvdJJS1fqKC/nQveIM+DW+YQFEoGL8IoLbgCL4mbs7TiUGFAtWRo/0tKgXo9krdLPXDhEfECcbrDNxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=BIbF7ZIN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bOOgJYDw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9E4201388EB5;
	Tue, 16 Jul 2024 06:41:35 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Tue, 16 Jul 2024 06:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1721126495;
	 x=1721212895; bh=AFz4WAP9fU/Nnq0+782fl4k9NP7VSLLRXny3UHGfMZQ=; b=
	BIbF7ZINkCFZoy3bK0ooic3BF4tDKYa3XUE6Rv9Kn+X8/EEUrvXDg+m/dpy3LTkt
	yPH+KhRnqMy5LV926+A+fT7CV7rpcgNUuk+wvFWeFOUqewNCNPJqQK8/7UlX8p5X
	l/VfQA7L58icgsDIexuh8Dt1XYsteWyNA2ljKdV6TF9TQQqh+YjL3C4fd2iX2/M+
	XaZjediqOJ38g16/3MadbvK2S9hdqRMKCeTRcQDzgC75omoZrx11hc44JrWgY+ej
	C65fzaF/3V1Iz09+C7S5N5gQHwKUA66yK0t/y5C+gUAx9eCYERio/snbO97MUVVI
	UlEQS5FeXGdtudcCuq6jrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721126495; x=
	1721212895; bh=AFz4WAP9fU/Nnq0+782fl4k9NP7VSLLRXny3UHGfMZQ=; b=b
	OOgJYDwEkAC/RELpnTFp50vAzC+j7kCpvRe92aVNoZR0uiASmvFpipS+ol6nRPY5
	Ye6E22PhL0wcJ0nlhokquFYb6B6ZFE9XqyUphy6/cCx10YtPsIcphZDU4aUFsndY
	y8o0cTrPOvpA0bI7LLkM0KDi9AbORWl6Ruani6PBt/mxrDik5U1EH8XirRI6Itwx
	ZHzVv625aDSLgR0z8G9zJBqrHGdsMCwfVeipa2kun/e8ZVpCOB3gHZYEGwVgIzdk
	839JxYiXjwryiJKpNNLY/2s81UozrujkolpjULTqF9NEOVbPDOJAyy8UxymthwZz
	o61K/Gq+3iK1YDcBRxgRw==
X-ME-Sender: <xms:Xk6WZhvK21kdtxDfeoXXFR20eV_m0KEBJGqGH4yIicugwfVvkXM3AA>
    <xme:Xk6WZqdrA72WWlF1a-dxQoJuXjOf2WBiKZGrsfZKoJx9XTphoDZxvayuaaR4UJhvI
    QT5ymq-rnkaW2uMiK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpeefuefghfdvueefheeiledvgeefffevgeelhedtvdehgeekteeugedtgeeuhedv
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Xk6WZkw4gZTbLicTbXc37mC3DuX51UI8ADAFcJajx9wJej6I9TTvag>
    <xmx:Xk6WZoOsjGaegGykP9trfDhMVBO1iE3G39Vef7fDQpTRmIrRBkg85g>
    <xmx:Xk6WZh_q6uv0alnPH6PHh__j2mZhc9oHyaAXgektADu18wMoyMzhqg>
    <xmx:Xk6WZoUl2LiJtOseH2hkJrLKn49jINC7YDV2BYd9Qr3tduyhplj5LA>
    <xmx:X06WZtb1GzOwijn118EvviSOnm9MdISndlUOlvtqMetT_LEMnSFdCpx0>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 355F32340081; Tue, 16 Jul 2024 06:41:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <65069b59-a5c8-42c5-b0e3-8a097ab14b3e@app.fastmail.com>
In-Reply-To: <951d3dc4-5330-2bbb-0372-8ab2761bf8f3@linux.intel.com>
References: <20240716051612.64842-1-luke@ljones.dev>
 <20240716051612.64842-2-luke@ljones.dev>
 <951d3dc4-5330-2bbb-0372-8ab2761bf8f3@linux.intel.com>
Date: Tue, 16 Jul 2024 22:41:12 +1200
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com,
 "Hans de Goede" <hdegoede@redhat.com>,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] platform/x86 asus-bioscfg: move existing tunings to
 asus-bioscfg module
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jul 2024, at 9:45 PM, Ilpo J=C3=A4rvinen wrote:
> On Tue, 16 Jul 2024, Luke D. Jones wrote:
>=20
> > The fw_attributes_class provides a much cleaner interface to all of =
the
> > attributes introduced to asus-wmi. This patch moves all of these ext=
ra
> > attributes over to fw_attributes_class, and shifts the bulk of these
> > definitions to a new kernel module to reduce the clutter of asus-wmi
> > with the intention of deprecating the asus-wmi attributes in future.
> >=20
> > The work applies only to WMI methods which don't have a clearly defi=
ned
> > place within the sysfs and as a result ended up lumped together in
> > /sys/devices/platform/asus-nb-wmi/ with no standard API.
> >=20
> > Where possible the fw attrs now implement defaults, min, max, scalar,
> > choices, etc. As en example dgpu_disable becomes:
> >=20
> > /sys/class/firmware-attributes/asus-bioscfg/attributes/dgpu_disable/
> > =E2=94=9C=E2=94=80=E2=94=80 current_value
> > =E2=94=9C=E2=94=80=E2=94=80 display_name
> > =E2=94=9C=E2=94=80=E2=94=80 possible_values
> > =E2=94=94=E2=94=80=E2=94=80 type
> >=20
> > as do other attributes.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  drivers/platform/x86/Kconfig               |  14 +
> >  drivers/platform/x86/Makefile              |   1 +
> >  drivers/platform/x86/asus-bioscfg.c        | 666 ++++++++++++++++++=
+++
> >  drivers/platform/x86/asus-bioscfg.h        | 243 ++++++++
> >  drivers/platform/x86/asus-wmi.c            |  18 +-
> >  include/linux/platform_data/x86/asus-wmi.h |  11 +
> >  6 files changed, 952 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/platform/x86/asus-bioscfg.c
> >  create mode 100644 drivers/platform/x86/asus-bioscfg.h
> >=20
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kco=
nfig
> > index 665fa9524986..b4a5a5bec7f3 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -265,6 +265,18 @@ config ASUS_WIRELESS
> >    If you choose to compile this driver as a module the module will =
be
> >    called asus-wireless.
> > =20
> > +config ASUS_BIOS
> > + tristate "ASUS BIOS Driver"
> > + depends on ACPI_WMI
> > + depends on ASUS_WMI
> > + select FW_ATTR_CLASS
> > + help
> > +   Say Y here if you have a WMI aware Asus laptop and would like to=
 use the
> > +   firmware_attributes API.
> > +
> > +   To compile this driver as a module, choose M here: the module wi=
ll
> > +   be called asus-bios.
> > +
> >  config ASUS_WMI
> >  tristate "ASUS WMI Driver"
> >  depends on ACPI_WMI
> > @@ -276,6 +288,8 @@ config ASUS_WMI
> >  depends on HOTPLUG_PCI
> >  depends on ACPI_VIDEO || ACPI_VIDEO =3D n
> >  depends on SERIO_I8042 || SERIO_I8042 =3D n
> > + select ASUS_BIOS
>=20
> Selecting user visible configs is not a good idea. Also, there=20
> seems to be circular dependency now between ASUS_BIOS & ASUS_WMI ?

Is "selects" the same as "depends"?

I did just remove:
	select ASUS_WMI_BIOS
which should not be there at all.

ASUS_BIOS does need ASUS_WMI. And I'd like ASUS_BIOS to be selected by d=
efualt, is this not the right way to do that?

>=20
> > + select ASUS_WMI_BIOS
> >  select INPUT_SPARSEKMAP
> >  select LEDS_CLASS
> >  select NEW_LEDS
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Ma=
kefile
> > index e1b142947067..d9b5b3f3b241 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_GMUX) +=3D apple-gmux.o
> >  # ASUS
> >  obj-$(CONFIG_ASUS_LAPTOP) +=3D asus-laptop.o
> >  obj-$(CONFIG_ASUS_WIRELESS) +=3D asus-wireless.o
> > +obj-$(CONFIG_ASUS_BIOS) +=3D asus-bios.o
> >  obj-$(CONFIG_ASUS_WMI) +=3D asus-wmi.o
> >  obj-$(CONFIG_ASUS_NB_WMI) +=3D asus-nb-wmi.o
> >  obj-$(CONFIG_ASUS_TF103C_DOCK) +=3D asus-tf103c-dock.o
> > diff --git a/drivers/platform/x86/asus-bioscfg.c b/drivers/platform/=
x86/asus-bioscfg.c
> > new file mode 100644
> > index 000000000000..0b34e727aab4
> > --- /dev/null
> > +++ b/drivers/platform/x86/asus-bioscfg.c
> > @@ -0,0 +1,666 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Asus BIOS attributes driver
> > + *
> > + * Copyright(C) 2010 Intel Corporation.
> > + * Copyright(C) 2024-2024 Luke Jones <luke@ljones.dev>
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/platform_data/x86/asus-wmi.h>
> > +#include <linux/errno.h>
> > +#include <linux/fs.h>
> > +#include <linux/types.h>
> > +#include <linux/dmi.h>
> > +#include <linux/device.h>
> > +#include <linux/kmod.h>
> > +#include <linux/kobject.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/kernel.h>
> > +#include "asus-bios.h"
> > +#include "firmware_attributes_class.h"
> > +
> > +MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
> > +MODULE_DESCRIPTION("ASUS BIOS Configuration Driver");
> > +MODULE_LICENSE("GPL");
>=20
> The usual place for these is at the end of file

Thanks. There is quite a mix of top/bottom for this. As I was going by o=
ther code examples the convention I ended up on is top. I'll move to bot=
tom if that is where they really are supposed to be.

>=20
> > +#define ASUS_NB_WMI_EVENT_GUID "0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1=
C"
> > +
> > +MODULE_ALIAS("wmi:"ASUS_NB_WMI_EVENT_GUID);
>=20
> Ditto.

Ack

>=20
> > +#define ASUS_MINI_LED_MODE_MASK 0x03
> > +/* Standard modes for devices with only on/off */
> > +#define ASUS_MINI_LED_OFF 0x00
> > +#define ASUS_MINI_LED_ON 0x01
> > +/* New mode on some devices, define here to clarify remapping later=
 */
> > +#define ASUS_MINI_LED_STRONG_MODE 0x02
> > +/* New modes for devices with 3 mini-led mode types */
> > +#define ASUS_MINI_LED_2024_WEAK 0x00
> > +#define ASUS_MINI_LED_2024_STRONG 0x01
> > +#define ASUS_MINI_LED_2024_OFF 0x02
> > +
> > +/* Default limits for tunables available on ASUS ROG laptops */
> > +#define PPT_CPU_LIMIT_MIN 5
> > +#define PPT_CPU_LIMIT_MAX 150
> > +#define PPT_CPU_LIMIT_DEFAULT 80
> > +#define PPT_PLATFORM_MIN 5
> > +#define PPT_PLATFORM_MAX 100
> > +#define PPT_PLATFORM_DEFAULT 80
> > +#define NVIDIA_BOOST_MIN 5
> > +#define NVIDIA_BOOST_MAX 25
> > +#define NVIDIA_TEMP_MIN 75
> > +#define NVIDIA_TEMP_MAX 87
> > +
> > +/* Tunables provided by ASUS for gaming laptops */
> > +struct rog_tunables {
> > + u32 cpu_default;
> > + u32 cpu_max;
> > +
> > + u32 platform_default;
> > + u32 platform_max;
> > +
> > + u32 ppt_pl1_spl; // cpu
> > + u32 ppt_pl2_sppt; // cpu
> > + u32 ppt_apu_sppt; // plat
> > + u32 ppt_platform_sppt; // plat
> > + u32 ppt_fppt; // cpu
> > +
> > + u32 nv_boost_default;
> > + u32 nv_boost_max;
> > + u32 nv_dynamic_boost;
> > +
> > + u32 nv_temp_default;
> > + u32 nv_temp_max;
> > + u32 nv_temp_target;
> > +};
> > +
> > +static const struct class *fw_attr_class;
> > +
> > +struct asus_bios_priv {
> > + struct device *fw_attr_dev;
> > + struct kset *fw_attr_kset;
> > +
> > + struct rog_tunables *rog_tunables;
> > + u32 mini_led_dev_id;
> > + u32 gpu_mux_dev_id;
> > + bool dgpu_disable_available;
> > + bool egpu_enable_available;
> > +
> > + struct mutex mutex;
> > +} asus_bioscfg =3D {
> > + .mutex =3D __MUTEX_INITIALIZER(asus_bioscfg.mutex),
>=20
> Don't try to initialize it on the same go like this.
>=20
> You might want static too.

Ack both

>=20
> > +};
> > +
> > +static struct fw_attrs_group {
> > + u32 pending_reboot;
> > +} fw_attrs =3D {
> > + .pending_reboot =3D 0,
> > +};
>=20
> Same here.

It was probably done like this in code I read as a reference. I'll shift=
 to the module init function.

>=20
> > +
> > +/* WMI helper methods */
> > +static bool asus_wmi_is_present(u32 dev_id)
> > +{
> > + int status =3D asus_wmi_get_devstate_dsts(dev_id, &retval);
> > + u32 retval;
> > +
> > + pr_debug("%s called (0x%08x), retval: 0x%08x\n", __func__, dev_id,=
 retval);
> > +
> > + return status =3D=3D 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
> > +}
> > +
> > +static void asus_set_reboot_and_signal_event(void)
> > +{
> > + fw_attrs.pending_reboot =3D 1;
> > + kobject_uevent(&asus_bioscfg.fw_attr_dev->kobj, KOBJ_CHANGE);
> > +}
> > +
> > +static ssize_t pending_reboot_show(struct kobject *kobj,
> > +    struct kobj_attribute *attr,
> > +    char *buf)
> > +{
> > + return sysfs_emit(buf, "%d\n", fw_attrs.pending_reboot);
>=20
> %u

Ack

> > +}
> > +
> > +static struct kobj_attribute pending_reboot =3D __ATTR_RO(pending_r=
eboot);
> > +
> > +static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
> > +{
> > + return !strcmp(attr->attr.name, "gpu_mux_mode");
> > + !strcmp(attr->attr.name, "panel_hd_mode");
>=20
> ???
>=20
> Semicolon and && confusion here?

Yeah i know, bad rebase I didn't catch.

> > +}
> > +
> > +/*
> > + * Generic store function for use with many ROG tunables
> > + */
> > +static ssize_t attr_int_store(struct kobject *kobj,
> > + struct kobj_attribute *attr,
> > + const char *buf, size_t count,
> > + u32 min, u32 max, u32 *store_value, u32 wmi_dev)
> > +{
> > + int result, value;
> > +
> > + result =3D kstrtoint(buf, 10, &value);
>=20
> Is signed value needed, if not, use unsigned variant of kstrto*?

Since the min,max,default can only ever be u32.. Yeah. I'll change that.

>=20
> > + if (result)
> > + return result;
> > +
> > + if (value < min || value > max)
> > + return -EINVAL;
> > +
> > + asus_wmi_set_devstate(wmi_dev, value, &result);
>=20
> Type confusion, u32 * vs int pointer being passed.

I miss rust...

>=20
> > + if (result) {
> > + pr_err("Failed to set %s: %d\n", attr->attr.name, result);
> > + return result;
> > + }
> > +
> > + if (result > 1) {
>=20
> What's this supposed to mean given you've the type confusion to begin=20
> with and return on the earlier line if result is non-zero?
>=20
> Did you mean to capture the return value of asus_wmi_set_devstate() an=
d=20
> test that in the first if ()?

Yep.. this whole bit is a mess. I've fixed the type mess, and added a co=
mment to clarify the "if (result > 1) {"
(WMI methods return 0 =3D fail, 1 =3D success, anything else is error)

> If you make a previously internal function such as asus_wmi_set_devsta=
te()=20
> EXPORTed, you should document it with kerneldoc so the interface is cl=
ear.

I'm not sure how to do this, I'll read up. Also didn't know about it so =
thanks for the pointer.

> > + pr_err("Failed to set %s (result): 0x%x\n", attr->attr.name, resul=
t);
> > + return -EIO;
> > + }
> > +
> > + if (store_value !=3D NULL)
> > + *store_value =3D value;
> > + sysfs_notify(kobj, NULL, attr->attr.name);
> > +
> > + if (asus_bios_requires_reboot(attr))
> > + asus_set_reboot_and_signal_event();
> > +
> > + return count;
> > +}
> > +
> > +/* Mini-LED mode **************************************************=
************/
> > +static ssize_t mini_led_mode_current_value_show(struct kobject *kob=
j,
> > + struct kobj_attribute *attr, char *buf)
> > +{
> > + u32 value;
> > + int err;
> > +
> > + err =3D asus_wmi_get_devstate_dsts(asus_bioscfg.mini_led_dev_id, &=
value);
> > + if (err)
> > + return err;
> > +
> > + value =3D value & ASUS_MINI_LED_MODE_MASK;
> > +
> > + /*
> > + * Remap the mode values to match previous generation mini-led. The=
 last gen
> > + * WMI 0 =3D=3D off, while on this version WMI 2 =3D=3Doff (flipped=
).
> > + */
> > + if (asus_bioscfg.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MO=
DE2) {
> > + switch (value) {
> > + case ASUS_MINI_LED_2024_WEAK:
> > + value =3D ASUS_MINI_LED_ON;
> > + break;
> > + case ASUS_MINI_LED_2024_STRONG:
> > + value =3D ASUS_MINI_LED_STRONG_MODE;
> > + break;
> > + case ASUS_MINI_LED_2024_OFF:
> > + value =3D ASUS_MINI_LED_OFF;
> > + break;
> > + }
> > + }
> > +
> > + return sysfs_emit(buf, "%d\n", value);
>=20
> %u

Ack

>=20
> > +}
> > +
> > +static ssize_t mini_led_mode_current_value_store(struct kobject *ko=
bj,
> > + struct kobj_attribute *attr,
> > + const char *buf, size_t count)
> > +{
> > + int result, err;
> > + u32 mode;
> > +
> > + result =3D kstrtou32(buf, 10, &mode);
> > + if (result)
> > + return result;
> > +
> > + if (asus_bioscfg.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MO=
DE &&
> > +     mode > ASUS_MINI_LED_ON)
> > + return -EINVAL;
> > + if (asus_bioscfg.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MO=
DE2 &&
> > +     mode > ASUS_MINI_LED_STRONG_MODE)
> > + return -EINVAL;
> > +
> > + /*
> > + * Remap the mode values so expected behaviour is the same as the l=
ast
> > + * generation of mini-LED with 0 =3D=3D off, 1 =3D=3D on.
> > + */
> > + if (asus_bioscfg.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MO=
DE2) {
> > + switch (mode) {
> > + case ASUS_MINI_LED_OFF:
> > + mode =3D ASUS_MINI_LED_2024_OFF;
> > + break;
> > + case ASUS_MINI_LED_ON:
> > + mode =3D ASUS_MINI_LED_2024_WEAK;
> > + break;
> > + case ASUS_MINI_LED_STRONG_MODE:
> > + mode =3D ASUS_MINI_LED_2024_STRONG;
> > + break;
> > + }
> > + }
> > +
> > + err =3D asus_wmi_set_devstate(asus_bioscfg.mini_led_dev_id, mode, =
&result);
> > + if (err) {
> > + pr_warn("Failed to set mini-LED: %d\n", err);
> > + return err;
> > + }
> > +
> > + if (result > 1) {
> > + pr_warn("Failed to set mini-LED mode (result): 0x%x\n", result);
> > + return -EIO;
> > + }
> > +
> > + sysfs_notify(kobj, NULL, attr->attr.name);
> > +
> > + return count;
> > +}
> > +
> > +static ssize_t mini_led_mode_possible_values_show(struct kobject *k=
obj,
> > + struct kobj_attribute *attr, char *buf)
> > +{
> > + switch (asus_bioscfg.mini_led_dev_id) {
> > + case ASUS_WMI_DEVID_MINI_LED_MODE:
> > + return sysfs_emit(buf, "0;1\n");
> > + case ASUS_WMI_DEVID_MINI_LED_MODE2:
> > + return sysfs_emit(buf, "0;1;2\n");
> > + }
> > +
> > + return sysfs_emit(buf, "0\n");
> > +}
> > +
> > +ATTR_GROUP_ENUM_CUSTOM(mini_led_mode, "mini_led_mode", "Set the min=
i-LED backlight mode");
> > +
> > +static ssize_t gpu_mux_mode_current_value_store(struct kobject *kob=
j,
> > + struct kobj_attribute *attr,
> > + const char *buf, size_t count)
> > +{
> > + int result, err;
> > + u32 optimus;
> > +
> > + err =3D kstrtou32(buf, 10, &optimus);
> > + if (err)
> > + return err;
> > +
> > + if (optimus > 1)
> > + return -EINVAL;
> > +
> > + if (asus_bioscfg.dgpu_disable_available) {
> > + err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_DGPU, &result);
> > + if (err)
> > + return err;
> > + if (err && !optimus) {
>=20
> How can err be non-zero at this point??? Did you mean result like belo=
w?

Yes. Thank you.

> > + err =3D -ENODEV;
> > + pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled: %d=
\n", err);
> > + return err;
> > + }
> > + }
> > +
> > + if (asus_bioscfg.egpu_enable_available) {
> > + err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU, &result);
> > + if (err)
> > + return err;
> > + if (result && !optimus) {
> > + err =3D -ENODEV;
> > + pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled: %d\=
n", err);
> > + return err;
> > + }
> > + }
> > +
> > + err =3D asus_wmi_set_devstate(asus_bioscfg.gpu_mux_dev_id, optimus=
, &result);
> > + if (err) {
> > + pr_err("%s Failed to set GPU MUX mode: %d\nn", __func__, err);
>=20
> Never use __func__ for messages shown to normal user.

Must have been a holdover from debug. Also wasn't aware of that rule, th=
anks.

> > + return err;
> > + }
> > + /* !1 is considered a fail by ASUS */
>=20
> If the interface is documented with kerneldoc, this is unnecessary=20
> comment. Is 0 also a failure (this differs from >1 checks elsewhere)?

I've changed the other checks to match. But I'll also try and do a deepe=
r analysis of those particular WMI functions to see if I can find the ac=
tual causes for other returns and their significance (0 and 2). 1 is mos=
t definitely success though.

>=20
> > + if (result !=3D 1) {
> > + pr_warn("%s Failed to set GPU MUX mode (result): 0x%x\n", __func__=
, result);
>=20
> Ditto.

Ack

>=20
> > + return -EIO;
> > + }
> > +
> > + sysfs_notify(kobj, NULL, attr->attr.name);
> > +
> > + return count;
> > +}
> > +WMI_SHOW_INT(gpu_mux_mode_current_value, "%d\n", asus_bioscfg.gpu_m=
ux_dev_id);
> > +ATTR_GROUP_BOOL_CUSTOM(gpu_mux_mode, "gpu_mux_mode", "Set the GPU d=
isplay MUX mode");
> > +
> > +/*
> > + * A user may be required to store the value twice, typcial store f=
irst, then
> > + * rescan PCI bus to activate power, then store a second time to sa=
ve correctly.
> > + * The reason for this is that an extra code path in the ACPI is en=
abled when
> > + * the device and bus are powered.
> > + */
> > +static ssize_t dgpu_disable_current_value_store(struct kobject *kob=
j,
> > + struct kobj_attribute *attr,
> > + const char *buf, size_t count)
> > +{
> > + int result, err;
> > + u32 disable;
> > +
> > + result =3D kstrtou32(buf, 10, &disable);
> > + if (result)
> > + return result;
>=20
> You're likely shooting yourself into your foot by not having consisten=
cy=20
> in variable naming. Here you store the return value into "result", whe=
reas=20
> you used "err" in the previous function. Try to maintain consistency=20
> across the entire driver.

Brain afk. I better read everything when i'm refreshed.

>=20
> > +
> > + if (disable > 1)
> > + return -EINVAL;
> > +
> > + if (asus_bioscfg.gpu_mux_dev_id) {
> > + err =3D asus_wmi_get_devstate_dsts(asus_bioscfg.gpu_mux_dev_id, &r=
esult);
> > + if (err)
> > + return err;
> > + if (!result && disable) {
> > + err =3D -ENODEV;
> > + pr_warn("Can not disable dGPU when the MUX is in dGPU mode: %d\n",=
 err);
> > + return err;
> > + }
> > + }
> > +
> > + err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, disable, &resul=
t);
> > + if (err) {
> > + pr_warn("Failed to set dgpu disable: %d\n", err);
> > + return err;
> > + }
> > +
> > + if (result > 1) {
> > + pr_warn("Failed to set dgpu disable (result): 0x%x\n", result);
> > + return -EIO;
> > + }
> > +
> > + sysfs_notify(kobj, NULL, attr->attr.name);
> > +
> > + return count;
> > +}
> > +WMI_SHOW_INT(dgpu_disable_current_value, "%d\n", ASUS_WMI_DEVID_DGP=
U);
> > +ATTR_GROUP_BOOL_CUSTOM(dgpu_disable, "dgpu_disable", "Disable the d=
GPU");
> > +
> > +/* The ACPI call to enable the eGPU also disables the internal dGPU=
 */
> > +static ssize_t egpu_enable_current_value_store(struct kobject *kobj,
> > + struct kobj_attribute *attr,
> > + const char *buf, size_t count)
> > +{
> > + int result, err;
> > + u32 enable;
> > +
> > + err =3D kstrtou32(buf, 10, &enable);
> > + if (err)
> > + return err;
> > +
> > + if (enable > 1)
> > + return -EINVAL;
> > +
> > + err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU_CONNECTED, =
&result);
> > + if (err) {
> > + pr_warn("Failed to get egpu connection status: %d\n", err);
> > + return err;
> > + }
> > +
> > + if (asus_bioscfg.gpu_mux_dev_id) {
> > + err =3D asus_wmi_get_devstate_dsts(asus_bioscfg.gpu_mux_dev_id, &r=
esult);
> > + if (err) {
> > + pr_warn("Failed to get gpu mux status: %d\n", result);
> > + return result;
> > + }
> > + if (!result && enable) {
> > + err =3D -ENODEV;
> > + pr_warn("Can not enable eGPU when the MUX is in dGPU mode: %d\n", =
err);
> > + return err;
> > + }
> > + }
> > +
> > + err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result=
);
> > + if (err) {
> > + pr_warn("Failed to set egpu state: %d\n", err);
> > + return err;
> > + }
> > +
> > + if (result > 1) {
> > + pr_warn("Failed to set egpu state (retval): 0x%x\n", result);
> > + return -EIO;
> > + }
> > +
> > + sysfs_notify(kobj, NULL, attr->attr.name);
> > +
> > + return count;
> > +}
> > +WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU=
);
> > +ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU=
 (also disables dGPU)");
> > +
> > +/* Simple attribute creation */
> > +ATTR_GROUP_ENUM_INT_RW(thermal_policy, "thermal_policy", ASUS_WMI_D=
EVID_THROTTLE_THERMAL_POLICY,
> > + 0, 3, "0;1;2", "Set the thermal profile: 0=3Dnormal, 1=3Dperforman=
ce, 2=3Dquiet");
> > +ATTR_GROUP_PPT_RW(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL=
1_SPL,
> > + cpu_default, 5, cpu_max, 1, "Set the CPU slow package limit");
> > +ATTR_GROUP_PPT_RW(ppt_pl2_sppt, "ppt_pl2_sppt", ASUS_WMI_DEVID_PPT_=
PL2_SPPT,
> > + cpu_default, 5, cpu_max, 1, "Set the CPU fast package limit");
> > +ATTR_GROUP_PPT_RW(ppt_apu_sppt, "ppt_apu_sppt", ASUS_WMI_DEVID_PPT_=
APU_SPPT,
> > + platform_default, 5, platform_max, 1, "Set the CPU slow package li=
mit");
> > +ATTR_GROUP_PPT_RW(ppt_platform_sppt, "ppt_platform_sppt", ASUS_WMI_=
DEVID_PPT_PLAT_SPPT,
> > + platform_default, 5, platform_max, 1, "Set the CPU slow package li=
mit");
> > +ATTR_GROUP_PPT_RW(ppt_fppt, "ppt_fppt", ASUS_WMI_DEVID_PPT_FPPT,
> > + cpu_default, 5, cpu_max, 1, "Set the CPU slow package limit");
> > +
> > +ATTR_GROUP_PPT_RW(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DE=
VID_NV_DYN_BOOST,
> > + nv_boost_default, 5, nv_boost_max, 1, "Set the Nvidia dynamic boos=
t limit");
> > +ATTR_GROUP_PPT_RW(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_=
NV_THERM_TARGET,
> > + nv_temp_default, 75, nv_temp_max, 1, "Set the Nvidia max thermal l=
imit");
> > +
> > +ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_C=
HARGE_MODE,
> > + "0;1;2", "Show the current mode of charging");
> > +ATTR_GROUP_BOOL_RW(boot_sound, "boot_sound", ASUS_WMI_DEVID_BOOT_SO=
UND,
> > + "Set the boot POST sound");
> > +ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_M=
CU_POWERSAVE,
> > + "Set MCU powersaving mode");
> > +ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANE=
L_OD,
> > + "Set the panel refresh overdrive");
> > +ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_P=
ANEL_HD,
> > + "Set the panel HD mode to UHD<0> or FHD<1>");
> > +ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID=
_EGPU_CONNECTED,
> > + "Show the eGPU connection status");
> > +
> > +static int asus_fw_attr_add(void)
> > +{
> > + int ret;
> > +
> > + ret =3D fw_attributes_class_get(&fw_attr_class);
> > + if (ret)
> > + goto fail_class_created;
> > + else
>=20
> Unnecessary else since you goto in the if block.

Ack

>=20
> > + asus_bioscfg.fw_attr_dev =3D device_create(fw_attr_class, NULL,
> > + MKDEV(0, 0), NULL, "%s", DRIVER_NAME);
> > +
> > + if (IS_ERR(asus_bioscfg.fw_attr_dev)) {
> > + ret =3D PTR_ERR(asus_bioscfg.fw_attr_dev);
> > + goto fail_class_created;
> > + }
> > +
> > + asus_bioscfg.fw_attr_kset =3D kset_create_and_add("attributes", NU=
LL,
> > + &asus_bioscfg.fw_attr_dev->kobj);
> > + if (!asus_bioscfg.fw_attr_dev) {
> > + ret =3D -ENOMEM;
> > + pr_debug("Failed to create and add attributes\n");
> > + goto err_destroy_classdev;
> > + }
> > +
> > + /* Add any firmware_attributes required */
>=20
> Unnecessary comment.

Ack

>=20
> > + ret =3D sysfs_create_file(&asus_bioscfg.fw_attr_kset->kobj, &pendi=
ng_reboot.attr);
> > + if (ret) {
> > + pr_warn("Failed to create sysfs level attributes\n");
> > + goto fail_class_created;
> > + }
> > +
> > + // TODO: logging
>=20
> ?? Logging of what if you intend to keep this message around.

Shouldn't have been there.

> > + asus_bioscfg.mini_led_dev_id =3D 0;
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE)) {
> > + asus_bioscfg.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE;
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &mini_led_mod=
e_attr_group);
> > + } else if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE2)) {
> > + asus_bioscfg.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE2;
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &mini_led_mod=
e_attr_group);
> > + }
> > +
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX)) {
> > + asus_bioscfg.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX;
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &gpu_mux_mode=
_attr_group);
> > + } else if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX_VIVO)) {
> > + asus_bioscfg.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX_VIVO;
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &gpu_mux_mode=
_attr_group);
> > + }
> > +
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU)) {
> > + asus_bioscfg.dgpu_disable_available =3D true;
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &dgpu_disable=
_attr_group);
> > + }
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU)) {
> > + asus_bioscfg.egpu_enable_available =3D true;
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &egpu_enable_=
attr_group);
> > + }
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU_CONNECTED))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &egpu_connect=
ed_attr_group);
> > +
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &thermal_poli=
cy_attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PL1_SPL))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_pl1_spl_=
attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PL2_SPPT))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_pl2_sppt=
_attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_APU_SPPT))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_apu_sppt=
_attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PLAT_SPPT))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_platform=
_sppt_attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_FPPT))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_fppt_att=
r_group);
> > +
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_NV_DYN_BOOST))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &nv_dynamic_b=
oost_attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_NV_THERM_TARGET))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &nv_temp_targ=
et_attr_group);
> > +
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_CHARGE_MODE))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &charge_mode_=
attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_BOOT_SOUND))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &boot_sound_a=
ttr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_MCU_POWERSAVE))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &mcu_powersav=
e_attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PANEL_OD))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &panel_od_att=
r_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PANEL_HD))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &panel_hd_mod=
e_attr_group);
> > +
> > + return 0;
> > +
> > +err_destroy_classdev:
> > + device_destroy(fw_attr_class, MKDEV(0, 0));
> > +
> > +fail_class_created:
> > + fw_attributes_class_put();
> > + return ret;
> > +}
> > +
> > +/* Init / exit ****************************************************=
************/
> > +
> > +/* Set up the min/max and defaults for ROG tunables */
> > +static void init_rog_tunables(struct rog_tunables *rog)
> > +{
> > + const char *product;
> > + u32 max_boost =3D NVIDIA_BOOST_MAX;
> > + u32 cpu_default =3D PPT_CPU_LIMIT_DEFAULT;
> > + u32 cpu_max =3D PPT_CPU_LIMIT_MAX;
> > + u32 platform_default =3D PPT_PLATFORM_DEFAULT;
> > + u32 platform_max =3D PPT_PLATFORM_MAX;
> > +
> > + /*
> > + * ASUS product_name contains everything required, e.g,
> > + * "ROG Flow X16 GV601VV_GV601VV_00185149B"
> > + */
> > + product =3D dmi_get_system_info(DMI_PRODUCT_NAME);
> > +
> > + if (strstr(product, "GA402R")) {
> > + cpu_default =3D 125;
> > + } else if (strstr(product, "13QY")) {
> > + cpu_max =3D 250;
> > + } else if (strstr(product, "X13")) {
> > + cpu_max =3D 75;
> > + cpu_default =3D 50;
> > + } else if (strstr(product, "RC71")) {
> > + cpu_max =3D 50;
> > + cpu_default =3D 30;
> > + } else if (strstr(product, "G814")
> > + || strstr(product, "G614")
> > + || strstr(product, "G834")
> > + || strstr(product, "G634")) {
> > + cpu_max =3D 175;
> > + } else if (strstr(product, "GA402X")
> > + || strstr(product, "GA403")
> > + || strstr(product, "FA507N")
> > + || strstr(product, "FA507X")
> > + || strstr(product, "FA707N")
> > + || strstr(product, "FA707X")) {
> > + cpu_max =3D 90;
> > + }
> > +
> > + if (strstr(product, "GZ301ZE"))
> > + max_boost =3D 5;
> > + else if (strstr(product, "FX507ZC4"))
> > + max_boost =3D 15;
> > + else if (strstr(product, "GU605"))
> > + max_boost =3D 20;
> > +
> > + /* ensure defaults for tunables */
> > + rog->cpu_default =3D cpu_default;
> > + rog->cpu_max =3D cpu_max;
> > +
> > + rog->platform_default =3D platform_default;
> > + rog->platform_max =3D platform_max;
> > +
> > + rog->ppt_pl1_spl =3D cpu_default;
> > + rog->ppt_pl2_sppt =3D cpu_default;
> > + rog->ppt_apu_sppt =3D cpu_default;
> > +
> > + rog->ppt_platform_sppt =3D platform_default;
> > + rog->ppt_fppt =3D platform_default;
> > +
> > + rog->nv_boost_default =3D NVIDIA_BOOST_MAX;
> > + rog->nv_boost_max =3D max_boost;
> > + rog->nv_dynamic_boost =3D NVIDIA_BOOST_MIN;
> > +
> > + rog->nv_temp_default =3D NVIDIA_TEMP_MAX;
> > + rog->nv_temp_max =3D NVIDIA_TEMP_MAX;
> > + rog->nv_temp_target =3D NVIDIA_TEMP_MIN;
> > +
> > +}
> > +
> > +static int __init asus_fw_init(void)
> > +{
> > + int err;
> > +
> > + mutex_lock(&asus_bioscfg.mutex);
> > +
> > + asus_bioscfg.rog_tunables =3D kzalloc(sizeof(struct rog_tunables),=
 GFP_KERNEL);
> > + if (!asus_bioscfg.rog_tunables) {
> > + mutex_unlock(&asus_bioscfg.mutex);
> > + return -ENOMEM;
> > + }
> > + init_rog_tunables(asus_bioscfg.rog_tunables);
> > +
> > + err =3D asus_fw_attr_add();
> > + mutex_unlock(&asus_bioscfg.mutex);
> > + if (err)
> > + return err;
> > +
> > + return 0;
> > +}
> > +
> > +static void __exit asus_fw_exit(void)
> > +{
> > + mutex_lock(&asus_bioscfg.mutex);
> > +
> > + sysfs_remove_file(&asus_bioscfg.fw_attr_kset->kobj, &pending_reboo=
t.attr);
> > + kset_unregister(asus_bioscfg.fw_attr_kset);
> > + device_destroy(fw_attr_class, MKDEV(0, 0));
> > + fw_attributes_class_put();
> > +
> > + mutex_unlock(&asus_bioscfg.mutex);
> > +}
> > +
> > +module_init(asus_fw_init);
> > +module_exit(asus_fw_exit);
> > diff --git a/drivers/platform/x86/asus-bioscfg.h b/drivers/platform/=
x86/asus-bioscfg.h
> > new file mode 100644
> > index 000000000000..403563c25f53
> > --- /dev/null
> > +++ b/drivers/platform/x86/asus-bioscfg.h
> > @@ -0,0 +1,243 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Definitions for kernel modules using asus-bios driver
> > + *
> > + *  Copyright (c) 2024 Luke Jones <luke@ljones.dev>
> > + */
> > +
> > +#ifndef _ASUS_BIOSCFG_H_
> > +#define _ASUS_BIOSCFG_H_
> > +
> > +#include "firmware_attributes_class.h"
> > +#include <linux/types.h>
> > +
> > +#define DRIVER_NAME "asus-bioscfg"
> > +
> > +static ssize_t attr_int_store(struct kobject *kobj, struct kobj_att=
ribute *attr,
> > + const char *buf, size_t count,
> > + u32 min, u32 max, u32 *store_value, u32 wmi_dev);
> > +
> > +
> > +static ssize_t int_type_show(struct kobject *kobj, struct kobj_attr=
ibute *attr,
> > + char *buf)
> > +{
> > + return sysfs_emit(buf, "integer\n");
> > +}
> > +
> > +static ssize_t enum_type_show(struct kobject *kobj, struct kobj_att=
ribute *attr,
> > + char *buf)
> > +{
> > + return sysfs_emit(buf, "enumeration\n");
> > +}
> > +
> > +#define __ASUS_ATTR_RO(_func, _name) { \
> > + .attr =3D { .name =3D __stringify(_name), .mode =3D 0444 }, \
> > + .show =3D _func##_##_name##_show, \
> > +}
> > +
> > +#define __ASUS_ATTR_RO_AS(_name, _show) { \
> > + .attr =3D { .name =3D __stringify(_name), .mode =3D 0444 }, \
> > + .show =3D _show, \
> > +}
> > +
> > +#define __ASUS_ATTR_RW(_func, _name) __ATTR(_name, 0644, \
> > + _func##_##_name##_show, _func##_##_name##_store)
> > +
> > +#define __WMI_STORE_INT(_attr, _min, _max, _wmi) \
> > +static ssize_t _attr##_store(struct kobject *kobj, \
> > + struct kobj_attribute *attr, \
> > + const char *buf, size_t count) \
> > +{ \
> > + return attr_int_store(kobj, attr, buf, count, _min, _max, NULL, _w=
mi); \
> > +}
> > +
> > +#define WMI_SHOW_INT(_attr, _fmt, _wmi) \
> > +static ssize_t _attr##_show(struct kobject *kobj, \
> > + struct kobj_attribute *attr, char *buf) \
> > +{ \
> > + u32 result; \
> > + int err; \
> > + err =3D asus_wmi_get_devstate_dsts(_wmi, &result); \
> > + if (err) \
> > + return err; \
> > + return sysfs_emit(buf, _fmt, \
> > + result & ~ASUS_WMI_DSTS_PRESENCE_BIT); \
> > +}
> > +
> > +/* Create functions and attributes for use in other macros or on th=
eir own */
> > +
> > +#define __ROG_TUNABLE_RW(_attr, _min, _max, _wmi) \
> > +static ssize_t _attr##_current_value_store(struct kobject *kobj, \
> > + struct kobj_attribute *attr, \
> > + const char *buf, size_t count) \
> > +{ \
> > + return attr_int_store(kobj, attr, buf, count, \
> > + _min, asus_bioscfg.rog_tunables->_max, \
> > + &asus_bioscfg.rog_tunables->_attr, _wmi); \
> > +} \
> > +static ssize_t _attr##_current_value_show(struct kobject *kobj, \
> > + struct kobj_attribute *attr, char *buf) \
> > +{ \
> > + return sysfs_emit(buf, "%u\n", asus_bioscfg.rog_tunables->_attr);\
> > +} \
> > +static struct kobj_attribute attr_##_attr##_current_value =3D \
> > + __ASUS_ATTR_RW(_attr, current_value)
> > +
> > +#define __ROG_TUNABLE_SHOW(_prop, _attrname, _val) \
> > +static ssize_t _attrname##_##_prop##_show(struct kobject *kobj, \
> > + struct kobj_attribute *attr, char *buf) \
> > +{ \
> > + return sysfs_emit(buf, "%d\n", asus_bioscfg.rog_tunables->_val);\
> > +} \
> > +static struct kobj_attribute attr_##_attrname##_##_prop =3D \
> > + __ASUS_ATTR_RO(_attrname, _prop)
> > +
> > +#define __ATTR_CURRENT_INT_RO(_attr, _wmi) \
> > +WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi); \
> > +static struct kobj_attribute attr_##_attr##_current_value =3D \
> > + __ASUS_ATTR_RO(_attr, current_value)
> > +
> > +#define __ATTR_CURRENT_INT_RW(_attr, _minv, _maxv, _wmi) \
> > +__WMI_STORE_INT(_attr##_current_value, _minv, _maxv, _wmi); \
> > +WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi); \
> > +static struct kobj_attribute attr_##_attr##_current_value =3D \
> > + __ASUS_ATTR_RW(_attr, current_value)
> > +
> > +/* Shows a formatted static variable */
> > +#define __ATTR_SHOW_FMT(_prop, _attrname, _fmt, _val) \
> > +static ssize_t _attrname##_##_prop##_show(struct kobject *kobj, \
> > + struct kobj_attribute *attr, char *buf) \
> > +{ \
> > + return sysfs_emit(buf, _fmt, _val); \
> > +} \
> > +static struct kobj_attribute attr_##_attrname##_##_prop =3D \
> > + __ASUS_ATTR_RO(_attrname, _prop)
> > +
> > +/* Int style min/max range, base macro. Requires current_value show=
&|store */
> > +#define __ATTR_GROUP_INT(_attrname, _fsname, _default, \
> > + _min, _max, _incstep, _dispname)\
> > +__ATTR_SHOW_FMT(default_value, _attrname, "%d\n", _default); \
> > +__ATTR_SHOW_FMT(min_value, _attrname, "%d\n", _min); \
> > +__ATTR_SHOW_FMT(max_value, _attrname, "%d\n", _max); \
> > +__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", _incstep); \
> > +__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname); \
> > +static struct kobj_attribute attr_##_attrname##_type =3D \
> > + __ASUS_ATTR_RO_AS(type, int_type_show); \
> > +static struct attribute *_attrname##_attrs[] =3D { \
> > + &attr_##_attrname##_current_value.attr, \
> > + &attr_##_attrname##_default_value.attr, \
> > + &attr_##_attrname##_min_value.attr, \
> > + &attr_##_attrname##_max_value.attr, \
> > + &attr_##_attrname##_scalar_increment.attr, \
> > + &attr_##_attrname##_display_name.attr, \
> > + &attr_##_attrname##_type.attr, \
> > + NULL \
> > +}; \
> > +static const struct attribute_group _attrname##_attr_group =3D { \
> > + .name =3D _fsname, \
> > + .attrs =3D _attrname##_attrs \
> > +}
> > +
> > +/* Boolean style enumeration, base macro. Requires adding show/stor=
e */
> > +#define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)=
 \
> > +__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname); \
> > +__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible); \
> > +static struct kobj_attribute attr_##_attrname##_type =3D \
> > + __ASUS_ATTR_RO_AS(type, enum_type_show); \
> > +static struct attribute *_attrname##_attrs[] =3D { \
> > + &attr_##_attrname##_current_value.attr, \
> > + &attr_##_attrname##_display_name.attr, \
> > + &attr_##_attrname##_possible_values.attr, \
> > + &attr_##_attrname##_type.attr, \
> > + NULL \
> > +}; \
> > +static const struct attribute_group _attrname##_attr_group =3D { \
> > + .name =3D _fsname, \
> > + .attrs =3D _attrname##_attrs \
> > +}
> > +
> > +#define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname) \
> > +do { \
> > + __ATTR_CURRENT_INT_RO(_attrname, _wmi); \
> > + __ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname);\
> > +} while (0)
> > +
> > +#define ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname) \
> > +do { \
> > + __ATTR_CURRENT_INT_RW(_attrname, 0, 1, _wmi); \
> > + __ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname);\
> > +} while (0)
> > +
> > +/*
> > + * Requires <name>_current_value_show(), <name>_current_value_show()
> > + */
> > +#define ATTR_GROUP_BOOL_CUSTOM(_attrname, _fsname, _dispname) \
> > +static struct kobj_attribute attr_##_attrname##_current_value =3D \
> > + __ASUS_ATTR_RW(_attrname, current_value); \
> > +__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> > +
> > +#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi, \
> > + _possible, _dispname) \
> > +do { \
> > + __ATTR_CURRENT_INT_RO(_attrname, _wmi); \
> > + __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname); \
> > +} while (0)
> > +
> > +#define ATTR_GROUP_ENUM_INT_RW(_attrname, _fsname, _wmi, _min, \
> > + _max, _possible, _dispname) \
> > +do { \
> > + __ATTR_CURRENT_INT_RW(_attrname, _min, _max, _wmi); \
> > + __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname); \
> > +} while (0)
> > +
> > +/*
> > + * Requires <name>_current_value_show(), <name>_current_value_show()
> > + * and <name>_possible_values_show()
> > + */
> > +#define ATTR_GROUP_ENUM_CUSTOM(_attrname, _fsname, _dispname) \
> > +__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname); \
> > +static struct kobj_attribute attr_##_attrname##_current_value =3D \
> > + __ASUS_ATTR_RW(_attrname, current_value); \
> > +static struct kobj_attribute attr_##_attrname##_possible_values =3D=
 \
> > + __ASUS_ATTR_RO(_attrname, possible_values); \
> > +static struct kobj_attribute attr_##_attrname##_type =3D \
> > + __ASUS_ATTR_RO_AS(type, enum_type_show); \
> > +static struct attribute *_attrname##_attrs[] =3D { \
> > + &attr_##_attrname##_current_value.attr, \
> > + &attr_##_attrname##_display_name.attr, \
> > + &attr_##_attrname##_possible_values.attr, \
> > + &attr_##_attrname##_type.attr, \
> > + NULL \
> > +}; \
> > +static const struct attribute_group _attrname##_attr_group =3D { \
> > + .name =3D _fsname, \
> > + .attrs =3D _attrname##_attrs \
> > +}
> > +
> > +/* ROG PPT attributes need a little different in setup */
> > +#define ATTR_GROUP_PPT_RW(_attrname, _fsname, _wmi, _default, \
> > + _min, _max, _incstep, _dispname) \
> > +__ROG_TUNABLE_RW(_attrname, _min, _max, _wmi); \
> > +__ROG_TUNABLE_SHOW(default_value, _attrname, _default); \
> > +__ATTR_SHOW_FMT(min_value, _attrname, "%d\n", _min); \
> > +__ROG_TUNABLE_SHOW(max_value, _attrname, _max); \
> > +__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", _incstep); \
> > +__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname); \
> > +static struct kobj_attribute attr_##_attrname##_type =3D \
> > + __ASUS_ATTR_RO_AS(type, int_type_show); \
> > +static struct attribute *_attrname##_attrs[] =3D { \
> > + &attr_##_attrname##_current_value.attr, \
> > + &attr_##_attrname##_default_value.attr, \
> > + &attr_##_attrname##_min_value.attr, \
> > + &attr_##_attrname##_max_value.attr, \
> > + &attr_##_attrname##_scalar_increment.attr, \
> > + &attr_##_attrname##_display_name.attr, \
> > + &attr_##_attrname##_type.attr, \
> > + NULL \
> > +}; \
> > +static const struct attribute_group _attrname##_attr_group =3D { \
> > + .name =3D _fsname, \
> > + .attrs =3D _attrname##_attrs \
> > +}
> > +
> > +#endif /* _ASUS_BIOSCFG_H_ */
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index 2b968003cb9b..3f1998638fea 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -529,12 +529,28 @@ static int asus_wmi_get_devstate(struct asus_w=
mi *asus, u32 dev_id, u32 *retval)
> >  return 0;
> >  }
> > =20
> > -static int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
> > +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
> > +{
> > + int err;
> > +
> > + err =3D asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0=
, retval);
> > + if (err)
> > + return err;
> > +
> > + if (*retval =3D=3D ~0)
> > + return -ENODEV;
> > +
> > + return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(asus_wmi_get_devstate_dsts);
> > +
> > +int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
> >  u32 *retval)
>=20
> Should fit to one line just fine.

Not sure why it wasn't. Might have been a longer function name to start =
with.

> As general feel of the readiness of this code, I suspect there were ma=
ny=20
> more problems which I failed to notice :-(.

I'd put money on it (sorry). I definitely should have cleaned up better =
than I did so you weren't pointing out silly little things, but I was ne=
ver expecting to get over the line on the first try and desperately need=
ed some insight for the overall patch series to see if what I was doing =
was actually going to be acceptable or not.

As always, thanks so much for your time and review.

Regards,
Luke.

>=20
> --=20
> i.
>=20
> >  {
> >  return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
> >  ctrl_param, retval);
> >  }
> > +EXPORT_SYMBOL_GPL(asus_wmi_set_devstate);
> > =20
> >  /* Helper for special devices with magic return codes */
> >  static int asus_wmi_get_devstate_bits(struct asus_wmi *asus,
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/li=
nux/platform_data/x86/asus-wmi.h
> > index 74b32e1d6735..889336a932fb 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -67,6 +67,7 @@
> >  #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
> > =20
> >  /* Misc */
> > +#define ASUS_WMI_DEVID_PANEL_HD 0x0005001C
> >  #define ASUS_WMI_DEVID_PANEL_OD 0x00050019
> >  #define ASUS_WMI_DEVID_CAMERA 0x00060013
> >  #define ASUS_WMI_DEVID_LID_FLIP 0x00060062
> > @@ -152,8 +153,18 @@
> >  #define ASUS_WMI_DSTS_LIGHTBAR_MASK 0x0000000F
> > =20
> >  #if IS_REACHABLE(CONFIG_ASUS_WMI)
> > +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval);
> > +int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval);
> >  int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32=
 *retval);
> >  #else
> > +static int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
> > +{
> > + return -ENODEV;
> > +}
> > +static int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *r=
etval)
> > +{
> > + return -ENODEV;
> > +}
> >  static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0,=
 u32 arg1,
> >     u32 *retval)
> >  {
> >=20

