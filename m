Return-Path: <linux-kernel+bounces-334038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7920497D1B8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FD11F2217F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E4442AA9;
	Fri, 20 Sep 2024 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="HS8BGyER";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e7Bb8y/+"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25ED54F8C;
	Fri, 20 Sep 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726817259; cv=none; b=P9sTUeBRLV/68wh/B5mJW1ToxFsv1FI1EJ+NIJ9r8XDoz7avW0xOqTEmhz3iFhgOPf6ja5QZq7lJm3JWv1dP+B64gwtV1AJDOfXWE67YxNC2aGDWPF4tFWQrB7BM9fCIug+msK+yE13Mx2wZuN+HT8hqG44tyjDzHv7kOToDkmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726817259; c=relaxed/simple;
	bh=PyUxeCHPm791cmQ17nugzuuFZsOm5zJkKKBs/8JH+S4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sOqPNTHQHJCB6jDWOlAc2p2pqqaf/W3V625ghVnl/F3RTbaddtFiPmtlkiStN3HSF4WSgbaS6dC70NQSNE4O51VtoymCrlj5dT8u4Ckz6PYxtMxHVhFagK8sFn5V4xKkHWuKGjFGB7j9OfHgUlJmhK0gG3r9GX0K+Y1etYoyygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=HS8BGyER; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e7Bb8y/+; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB0FB1140215;
	Fri, 20 Sep 2024 03:27:33 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Fri, 20 Sep 2024 03:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726817253;
	 x=1726903653; bh=fnCNaXhguZuzMJ1KiF1mip9q4BGpAzZRvxPwI+XTyJQ=; b=
	HS8BGyERn3pVMtAvvqQR8MW+psD51Xq4BqZFGPlDMCuodvt1Eqtu+drAnxX4q8wR
	0BUMp6i/NSA2Imw0Ni5YeMPoJUpQ7D5CfFRYB4tV/6UTOV53vpAwgAxT7kfWp1LF
	N+RbFEqWXonpDdU1XE3YAItvy4cFV/WsB9zBixsh4Atp7/RVr2NU3YX0xk33lno0
	TpezYeHeVCMQMxudmzjVFA1yqXu3/VQEqCqoZJeUf0qbFh2BdyO/QNfuAQVJgy1w
	PFZ1lrsxQMtC6VwBJc8A2vBRakV0ukcl39xc8ScKYqRkw0luuu/pILtiAxlnCmXD
	nDKVhq6/AluT48nbZFbydw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1726817253; x=
	1726903653; bh=fnCNaXhguZuzMJ1KiF1mip9q4BGpAzZRvxPwI+XTyJQ=; b=e
	7Bb8y/+cR4jBLLQ41siF9zr0cqgLH3Xx960SKtEfDV70/E3fXRKgprEoBChCgbmS
	K6tN5XYwN/x5w70egk5G1FycVMn2pOyA9L9naxXqJEY0iKjByZBQD50vdwUOh3QU
	NKE+xqgfOUG6Kz35Whf7/u/Q8uAcA81cdE+ZDtJzCUK/VpjJ9NKBSeAgkU//HmU/
	Kqvl/O0hnkQP01/RUYsUtHQQz0KOkCGPAUavCLINcdVHzUk4BzyoXr/aWWgnRZiP
	jwB/gSwhzBiylfLYzw1GbYCHVkhyeTwS5rXLcWeMb9DqAYM1ROILilkD00QKBAKd
	LwkrcR91VnxT7O6lrne/g==
X-ME-Sender: <xms:5SPtZmGLHVhMZRux6c3V0-c3k2gM70hee0sD9hssGrTO1Q3fGR3ZZQ>
    <xme:5SPtZnWaL_MJjhi3Figvpuf7hO5KaFgJLbJi_l2LzkhUDGbCUDxFfTTWibeIL7s1b
    ILgtjK6WBp0nu9_38k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelvddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfnuhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdrug
    gvvheqnecuggftrfgrthhtvghrnhepheetudfgleegledtveevtdelfffhtefgtdejhfek
    gfdujeefueeufedvjeduuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtih
    gvlhhlohesrghmugdrtghomhdprhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhies
    ghhmrghilhdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuh
    igrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5SPtZgI6RiHD5ztXA7KbmRWgfIFnH6bh8BmKD7FEjplU_emwsEnwTQ>
    <xmx:5SPtZgHrv72n4u-VTGfhmKGo6rGdgOGhx0EBY2AV0q7GEl3v9wi8xA>
    <xmx:5SPtZsW5CfcoY0WvozwodlQ24G2kA_TAkUHhMEZaKIAiiaer5LFB4A>
    <xmx:5SPtZjOzjYQtrDN9keWsH37-rOX5X-AzS8W_JYxQmalgukdPgQ7rLw>
    <xmx:5SPtZqwpBWbvGBXnEVU9PpaqsWFyyLjILkZ7n8lUUX-tH8AIp0Q9l07W>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 68B4C336007C; Fri, 20 Sep 2024 03:27:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Sep 2024 19:27:12 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Mario Limonciello" <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 corentin.chary@gmail.com
Message-Id: <6ef46128-6046-487e-994f-3f7a5774906d@app.fastmail.com>
In-Reply-To: <1f563104-c0f4-4f80-b441-5d4bd67f693e@amd.com>
References: <20240918094250.82430-1-luke@ljones.dev>
 <20240918094250.82430-2-luke@ljones.dev>
 <1f563104-c0f4-4f80-b441-5d4bd67f693e@amd.com>
Subject: Re: [PATCH v3 1/5] platform/x86: asus-armoury: move existing tunings to
 asus-armoury module
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Sep 2024, at 3:37 AM, Mario Limonciello wrote:
> On 9/18/2024 04:42, Luke D. Jones wrote:
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
> > /sys/class/firmware-attributes/asus-armoury/attributes/dgpu_disable/
> > =E2=94=9C=E2=94=80=E2=94=80 current_value
> > =E2=94=9C=E2=94=80=E2=94=80 display_name
> > =E2=94=9C=E2=94=80=E2=94=80 possible_values
> > =E2=94=94=E2=94=80=E2=94=80 type
> >=20
> > as do other attributes.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >   drivers/platform/x86/Kconfig               |  14 +
> >   drivers/platform/x86/Makefile              |   1 +
> >   drivers/platform/x86/asus-armoury.c        | 702 +++++++++++++++++=
++++
> >   drivers/platform/x86/asus-armoury.h        | 209 ++++++
> >   drivers/platform/x86/asus-wmi.c            |  69 +-
> >   drivers/platform/x86/asus-wmi.h            |  14 +
> >   include/linux/platform_data/x86/asus-wmi.h |  11 +
> >   7 files changed, 1001 insertions(+), 19 deletions(-)
> >   create mode 100644 drivers/platform/x86/asus-armoury.c
> >   create mode 100644 drivers/platform/x86/asus-armoury.h
>=20
> This is kinda a big patch that I feel might have done some justice to=20
> split into smaller logical pieces.  These are much easier to review.
>=20
> For example:
>=20
> 1) You've clearly got 3 "groups" of attributes, maybe those should com=
e=20
> in a separate series each.
> 2) Some of the helper functions that are exported should be exported i=
n=20
> their own patches (for example asus_wmi_get_devstate_dsts)
> 3) panel_hd_mode is a new attribute not leveraged from asus-wmi AFAICT=
,=20
> with a new define.  It probably could have been it's own patch to "add=20
> panel_hd_mode".

Good points yeah. I've split things in to smaller more easily digestible=
 chunks now.

>=20
> More comments inline below.
>=20
> >=20
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kco=
nfig
> > index ddfccc226751..d13c4085c228 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -265,6 +265,19 @@ config ASUS_WIRELESS
> >     If you choose to compile this driver as a module the module will=
 be
> >     called asus-wireless.
> >  =20
> > +config ASUS_ARMOURY
> > + tristate "ASUS Armoury (firmware) Driver"
>=20
> This is a confusing title to me.  What does it convey that just "Asus=20
> Armoury driver" wouldn't?

Nothing much I guess. Changed now.

> > + depends on ACPI_WMI
> > + depends on ASUS_WMI
> > + select FW_ATTR_CLASS
> > + help
> > +   Say Y here if you have a WMI aware Asus laptop and would like to=
 use the
>=20
> Doesn't it also cover handhelds?  I'd probably just say "asus machine".

Indeed yes, changed.

> > +   firmware_attributes API to control various settings typically ex=
posed in
> > +   the ASUS Armoury Crate application available on Windows.
> > +
> > +   To compile this driver as a module, choose M here: the module wi=
ll
> > +   be called asus-armoury.
> > +
> >   config ASUS_WMI
> >   tristate "ASUS WMI Driver"
> >   depends on ACPI_WMI
> > @@ -276,6 +289,7 @@ config ASUS_WMI
> >   depends on HOTPLUG_PCI
> >   depends on ACPI_VIDEO || ACPI_VIDEO =3D n
> >   depends on SERIO_I8042 || SERIO_I8042 =3D n
> > + select ASUS_ARMOURY
>=20
> Two problems:
> 1. Seems to be a circular depedency.
> 2. Selects can't have extra depends or selects (FW_ATTR_CLASS stands o=
ut).
>=20
> I feel this select should just be droped.

Dropped. I wasn't entirely clear on how to use the "select" and "depends=
 on". I think I much better understand how now especially given that I p=
reviously didn't know "select" does not honor the "depends on" of what i=
t has selected.

> >   select INPUT_SPARSEKMAP
> >   select LEDS_CLASS
> >   select NEW_LEDS
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Ma=
kefile
> > index e1b142947067..fe3e7e7dede8 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_GMUX) +=3D apple-gmux.o
> >   # ASUS
> >   obj-$(CONFIG_ASUS_LAPTOP) +=3D asus-laptop.o
> >   obj-$(CONFIG_ASUS_WIRELESS) +=3D asus-wireless.o
> > +obj-$(CONFIG_ASUS_ARMOURY) +=3D asus-armoury.o
> >   obj-$(CONFIG_ASUS_WMI) +=3D asus-wmi.o
> >   obj-$(CONFIG_ASUS_NB_WMI) +=3D asus-nb-wmi.o
> >   obj-$(CONFIG_ASUS_TF103C_DOCK) +=3D asus-tf103c-dock.o
> > diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/=
x86/asus-armoury.c
> > new file mode 100644
> > index 000000000000..6e4507be0f05
> > --- /dev/null
> > +++ b/drivers/platform/x86/asus-armoury.c
> > @@ -0,0 +1,702 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Asus Armoury (WMI) attributes driver. This driver uses the fw_at=
tributes
> > + * class to expose the various WMI functions that many gaming and s=
ome
> > + * non-gaming ASUS laptops have available.
> > + * These typically don't fit anywhere else in the sysfs such as und=
er LED class,
> > + * hwmon or other, and are set in Windows using the ASUS Armoury Cr=
ate tool.
> > + *
> > + * Copyright(C) 2010 Intel Corporation.
> > + * Copyright(C) 2024-2024 Luke Jones <luke@ljones.dev>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/device.h>
> > +#include <linux/dmi.h>
> > +#include <linux/errno.h>
> > +#include <linux/fs.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kmod.h>
> > +#include <linux/kobject.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_data/x86/asus-wmi.h>
> > +#include <linux/types.h>
> > +
> > +#include "asus-armoury.h"
> > +#include "firmware_attributes_class.h"
> > +#include "asus-wmi.h"
> > +
> > +#define ASUS_NB_WMI_EVENT_GUID "0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1=
C"
> > +
> > +#define ASUS_MINI_LED_MODE_MASK 0x03
> > +/* Standard modes for devices with only on/off */
> > +#define ASUS_MINI_LED_OFF 0x00
> > +#define ASUS_MINI_LED_ON 0x01
> > +/* New mode on some devices, define here to clarify remapping later=
 */
>=20
> The word "new" ages poorly, especially in comments.

Ack. Was a copy/paste from old asus_wmi code.

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
> > + u32 cpu_min;
> > + u32 cpu_max;
> > +
> > + u32 platform_default;
> > + u32 platform_min;
> > + u32 platform_max;
> > +
> > + u32 ppt_pl1_spl; // cpu
> > + u32 ppt_pl2_sppt; // cpu
> > + u32 ppt_apu_sppt; // plat
> > + u32 ppt_platform_sppt; // plat
> > + u32 ppt_fppt; // cpu
> > +
> > + u32 nv_boost_default;
> > + u32 nv_boost_min;
> > + u32 nv_boost_max;
> > + u32 nv_dynamic_boost;
> > +
> > + u32 nv_temp_default;
> > + u32 nv_temp_min;
> > + u32 nv_temp_max;
> > + u32 nv_temp_target;
> > +};
> > +
> > +static const struct class *fw_attr_class;
> > +
> > +struct asus_armoury_priv {
> > + struct device *fw_attr_dev;
> > + struct kset *fw_attr_kset;
> > +
> > + struct rog_tunables *rog_tunables;
> > + u32 mini_led_dev_id;
> > + u32 gpu_mux_dev_id;
> > +
> > + struct mutex mutex;
> > +};
> > +
> > +static struct asus_armoury_priv asus_armoury =3D { .mutex =3D __MUT=
EX_INITIALIZER(
> > + asus_armoury.mutex) };
> > +
> > +struct fw_attrs_group {
> > + bool pending_reboot;
> > +};
> > +
> > +static struct fw_attrs_group fw_attrs =3D {
> > + .pending_reboot =3D false,
> > +};
> > +
> > +struct asus_attr_group {
> > + const struct attribute_group *attr_group;
> > + u32 wmi_devid;
> > +};
> > +
> > +static bool asus_wmi_is_present(u32 dev_id)
> > +{
> > + u32 retval;
> > + int status;
> > +
> > + status =3D asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id=
, 0, &retval);
> > + pr_debug("%s called (0x%08x), retval: 0x%08x\n", __func__, dev_id,=
 retval);
> > +
> > + return status =3D=3D 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
> > +}
> > +
> > +static void asus_set_reboot_and_signal_event(void)
> > +{
> > + fw_attrs.pending_reboot =3D true;
> > + kobject_uevent(&asus_armoury.fw_attr_dev->kobj, KOBJ_CHANGE);
> > +}
> > +
> > +static ssize_t pending_reboot_show(struct kobject *kobj, struct kob=
j_attribute *attr, char *buf)
> > +{
> > + return sysfs_emit(buf, "%d\n", fw_attrs.pending_reboot);
> > +}
> > +
> > +static struct kobj_attribute pending_reboot =3D __ATTR_RO(pending_r=
eboot);
> > +
> > +static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
> > +{
> > + return !strcmp(attr->attr.name, "gpu_mux_mode") ||
> > +        !strcmp(attr->attr.name, "panel_hd_mode");
> > +}
> > +
> > +/**
> > + * attr_int_store() - Generic store function for use with most WMI =
functions.
> > + * @kobj: Pointer to the driver object.
> > + * @kobj_attribute: Pointer to the attribute calling this function.
> > + * @buf: The buffer to read from, this is parsed to `int` type.
> > + * @count:
> > + * @min: Minimum accepted value. Below this returns -EINVAL.
> > + * @max: Maximum accepted value. Above this returns -EINVAL.
> > + * @store_value: Pointer to where the parsed value should be stored.
> > + * @wmi_dev: The WMI function ID to use.
> > + *
> > + * The WMI functions available on most ASUS laptops return a 1 as "=
success", and
> > + * a 0 as failed. However some functions can return n > 1 for addit=
ional errors.
> > + * attr_int_store() currently treats all values which are not 1 as =
errors, ignoring
> > + * the possible differences in WMI error returns.
> > + *
> > + * Returns: Either count, or an error.
> > + */
> > +static ssize_t attr_int_store(struct kobject *kobj, struct kobj_att=
ribute *attr, const char *buf,
> > +       size_t count, u32 min, u32 max, u32 *store_value, u32 wmi_de=
v)
> > +{
> > + u32 result, value;
> > + int err;
> > +
> > + err =3D kstrtouint(buf, 10, &value);
> > + if (err)
> > + return err;
> > +
> > + if (value < min || value > max)
> > + return -EINVAL;
> > +
> > + err =3D asus_wmi_set_devstate(wmi_dev, value, &result);
> > + if (err) {
> > + pr_err("Failed to set %s: %d\n", attr->attr.name, err);
> > + return err;
> > + }
> > +
> > + if (result !=3D 1) {
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
> > + err =3D asus_wmi_get_devstate_dsts(asus_armoury.mini_led_dev_id, &=
value);
> > + if (err)
> > + return err;
> > +
> > + value &=3D ASUS_MINI_LED_MODE_MASK;
> > +
> > + /*
> > + * Remap the mode values to match previous generation mini-LED. The=
 last gen
> > + * WMI 0 =3D=3D off, while on this version WMI 2 =3D=3D off (flippe=
d).
> > + */
> > + if (asus_armoury.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MO=
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
> > + return sysfs_emit(buf, "%u\n", value);
> > +}
> > +
> > +static ssize_t mini_led_mode_current_value_store(struct kobject *ko=
bj,
> > + struct kobj_attribute *attr, const char *buf,
> > + size_t count)
> > +{
> > + int result, err;
> > + u32 mode;
> > +
> > + err =3D kstrtou32(buf, 10, &mode);
> > + if (err)
> > + return err;
> > +
> > + if (asus_armoury.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MO=
DE &&
> > +     mode > ASUS_MINI_LED_ON)
> > + return -EINVAL;
> > + if (asus_armoury.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MO=
DE2 &&
> > +     mode > ASUS_MINI_LED_STRONG_MODE)
> > + return -EINVAL;
> > +
> > + /*
> > + * Remap the mode values so expected behaviour is the same as the l=
ast
> > + * generation of mini-LED with 0 =3D=3D off, 1 =3D=3D on.
> > + */
> > + if (asus_armoury.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MO=
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
> > + err =3D asus_wmi_set_devstate(asus_armoury.mini_led_dev_id, mode, =
&result);
> > + if (err) {
> > + pr_warn("Failed to set mini-LED: %d\n", err);
> > + return err;
> > + }
> > +
> > + if (result !=3D 1) {
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
> > +   struct kobj_attribute *attr, char *buf)
> > +{
> > + switch (asus_armoury.mini_led_dev_id) {
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
> > + struct kobj_attribute *attr, const char *buf,
> > + size_t count)
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
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU)) {
> > + err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_DGPU, &result);
> > + if (err)
> > + return err;
> > + if (result && !optimus) {
> > + err =3D -ENODEV;
> > + pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled: %0=
2X %02X %d\n",
> > + result, optimus, err);
> > + return err;
> > + }
> > + }
> > +
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU)) {
> > + err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU, &result);
> > + if (err)
> > + return err;
> > + if (result && !optimus) {
> > + err =3D -ENODEV;
> > + pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled: %d\=
n",
> > + err);
> > + return err;
> > + }
> > + }
> > +
> > + err =3D asus_wmi_set_devstate(asus_armoury.gpu_mux_dev_id, optimus=
, &result);
> > + if (err) {
> > + pr_err("Failed to set GPU MUX mode: %d\n", err);
> > + return err;
> > + }
> > + /* !1 is considered a fail by ASUS */
> > + if (result !=3D 1) {
> > + pr_warn("Failed to set GPU MUX mode (result): 0x%x\n", result);
> > + return -EIO;
> > + }
> > +
> > + sysfs_notify(kobj, NULL, attr->attr.name);
> > + asus_set_reboot_and_signal_event();
> > +
> > + return count;
> > +}
> > +WMI_SHOW_INT(gpu_mux_mode_current_value, "%d\n", asus_armoury.gpu_m=
ux_dev_id);
> > +ATTR_GROUP_BOOL_CUSTOM(gpu_mux_mode, "gpu_mux_mode", "Set the GPU d=
isplay MUX mode");
> > +
> > +/*
> > + * A user may be required to store the value twice, typical store f=
irst, then
> > + * rescan PCI bus to activate power, then store a second time to sa=
ve correctly.
> > + * The reason for this is that an extra code path in the ACPI is en=
abled when
> > + * the device and bus are powered.
> > + */
> > +static ssize_t dgpu_disable_current_value_store(struct kobject *kob=
j,
> > + struct kobj_attribute *attr, const char *buf,
> > + size_t count)
> > +{
> > + int result, err;
> > + u32 disable;
> > +
> > + err =3D kstrtou32(buf, 10, &disable);
> > + if (err)
> > + return err;
> > +
> > + if (disable > 1)
> > + return -EINVAL;
> > +
> > + if (asus_armoury.gpu_mux_dev_id) {
> > + err =3D asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &r=
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
> > + pr_warn("Failed to set dGPU disable: %d\n", err);
> > + return err;
> > + }
> > +
> > + if (result !=3D 1) {
> > + pr_warn("Failed to set dGPU disable (result): 0x%x\n", result);
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
> > +static ssize_t egpu_enable_current_value_store(struct kobject *kobj=
, struct kobj_attribute *attr,
> > +        const char *buf, size_t count)
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
> > + pr_warn("Failed to get eGPU connection status: %d\n", err);
> > + return err;
> > + }
> > +
> > + if (asus_armoury.gpu_mux_dev_id) {
> > + err =3D asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &r=
esult);
> > + if (err) {
> > + pr_warn("Failed to get GPU MUX status: %d\n", result);
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
> > + pr_warn("Failed to set eGPU state: %d\n", err);
> > + return err;
> > + }
> > +
> > + if (result !=3D 1) {
> > + pr_warn("Failed to set eGPU state (retval): 0x%x\n", result);
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
> > +ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_P=
PT_PL1_SPL, cpu_default,
> > +        cpu_min, cpu_max, 1, "Set the CPU slow package limit");
> > +ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, "ppt_pl2_sppt", ASUS_WMI_DEVID=
_PPT_PL2_SPPT, cpu_default,
> > +        cpu_min, cpu_max, 1, "Set the CPU fast package limit");
> > +ATTR_GROUP_ROG_TUNABLE(ppt_apu_sppt, "ppt_apu_sppt", ASUS_WMI_DEVID=
_PPT_APU_SPPT,
> > +        platform_default, platform_min, platform_max, 1,
> > +        "Set the CPU slow package limit");
> > +ATTR_GROUP_ROG_TUNABLE(ppt_platform_sppt, "ppt_platform_sppt", ASUS=
_WMI_DEVID_PPT_PLAT_SPPT,
> > +        platform_default, platform_min, platform_max, 1,
> > +        "Set the CPU slow package limit");
> > +ATTR_GROUP_ROG_TUNABLE(ppt_fppt, "ppt_fppt", ASUS_WMI_DEVID_PPT_FPP=
T, cpu_default, cpu_min,
> > +        cpu_max, 1, "Set the CPU slow package limit");
>=20
> I go back and forth on the existence of tuning knobs for all these=20
> values.  As a tinkerer it's of course nice to see so many knobs.
>=20
> However thinking about how this would be exposed to userspace and what=20
> users will drag for a "slider" for performance it's really confusing.=20
> Which knob is tuned?  What's different for CPU vs platform?  What's sl=
ow=20
> vs fast?

I fully understand the concern here and share it. But one thing I think =
that should be considered is that *most* users won't be going directly t=
o the attributes, or even be aware of them. Those that do I would hope a=
t least know what they are or the name/desc is enough to provide hints t=
o find more info.

And then a usersapce app exposing these should explain what they are, an=
d be much more usable. A tangible benefit of fw_attr class is that it ma=
kes userspace apps easier to do.

> As a result, I think I would rather see these (specifically) relegated=20
> to debugfs attributes and instead export an ACPI platform profile.  Th=
e=20
> ACPI platform profile can then give users a clearer set of expectation=
s; IE:
>=20
> "power-saver", "balanced", "performance"
>=20
> Bifurcating it this way will enable both audiences.  The people who wa=
nt=20
> to drag a slider in a UI to save power or consume power can do so, and=20
> those that know what all these mean and want to spend more time=20
> tinkering can go to debugfs to do so.
>=20
> But with this idea there would essentially be two sets of knobs that=20
> change the same thing.  So I think that if the debugfs knobs were tune=
d=20
> away from the defaults the platform profile needs to be reset to an er=
ror.

This would at least address that changing these values deviates from the=
 platform_profile, and also the system fan profile - so it puts the onus=
 on the user to ensure the settings they use are safe to use.

My main concern is perhaps that I lose the easy to use fw_attr class. Bu=
t I suppose I can also recreate the minimum of /path/attr_name/{min/max/=
default/current} without too much hassle.

Moving to debugfs:
pros:
- setting unsafe values moves responsibility to user
- simplifies things a little
- hides a possible danger from users

cons:
- setting unsafe values moves responsibility to user
- a userspace app then also takes on that responsibility
- loses the fw_attr class API
- makes it harder to access

For now these are moved to a new patch to make it easier to review as we=
ll as change.

> > +ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, "nv_dynamic_boost", ASUS_W=
MI_DEVID_NV_DYN_BOOST,
> > +        nv_boost_default, nv_boost_min, nv_boost_max, 1,
> > +        "Set the Nvidia dynamic boost limit");
> > +ATTR_GROUP_ROG_TUNABLE(nv_temp_target, "nv_temp_target", ASUS_WMI_D=
EVID_NV_THERM_TARGET,
> > +        nv_temp_default, nv_boost_min, nv_temp_max, 1,
> > +        "Set the Nvidia max thermal limit");
> > +
> > +ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_C=
HARGE_MODE, "0;1;2",
> > +        "Show the current mode of charging");
> > +
> > +ATTR_GROUP_BOOL_RW(boot_sound, "boot_sound", ASUS_WMI_DEVID_BOOT_SO=
UND,
> > +    "Set the boot POST sound");
> > +ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_M=
CU_POWERSAVE,
> > +    "Set MCU powersaving mode");
> > +ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANE=
L_OD,
> > +    "Set the panel refresh overdrive");
> > +ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_P=
ANEL_HD,
> > +    "Set the panel HD mode to UHD<0> or FHD<1>");
> > +ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID=
_EGPU_CONNECTED,
> > +    "Show the eGPU connection status");
> > +
> > +/* If an attribute does not require any special case handling add i=
t here */
> > +static const struct asus_attr_group armoury_attr_groups[] =3D {
> > + { &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
> > + { &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
> > + { &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
> > +
> > + { &ppt_pl1_spl_attr_group, ASUS_WMI_DEVID_PPT_PL1_SPL },
> > + { &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_PPT_PL2_SPPT },
> > + { &ppt_apu_sppt_attr_group, ASUS_WMI_DEVID_PPT_APU_SPPT },
> > + { &ppt_platform_sppt_attr_group, ASUS_WMI_DEVID_PPT_PLAT_SPPT },
> > + { &ppt_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
> > + { &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
> > + { &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
> > +
> > + { &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
> > + { &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> > + { &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
> > + { &panel_od_attr_group, ASUS_WMI_DEVID_PANEL_OD },
> > + { &panel_hd_mode_attr_group, ASUS_WMI_DEVID_PANEL_HD },
> > +};
> > +
> > +static int asus_fw_attr_add(void)
> > +{
> > + int err;
> > +
> > + err =3D fw_attributes_class_get(&fw_attr_class);
> > + if (err)
> > + goto fail_class_created;
> > +
> > + asus_armoury.fw_attr_dev =3D
> > + device_create(fw_attr_class, NULL, MKDEV(0, 0), NULL, "%s", DRIVER=
_NAME);
> > +
> > + if (IS_ERR(asus_armoury.fw_attr_dev)) {
> > + err =3D PTR_ERR(asus_armoury.fw_attr_dev);
> > + goto fail_class_created;
> > + }
> > +
> > + asus_armoury.fw_attr_kset =3D
> > + kset_create_and_add("attributes", NULL, &asus_armoury.fw_attr_dev-=
>kobj);
> > + if (!asus_armoury.fw_attr_dev) {
> > + err =3D -ENOMEM;
> > + pr_debug("Failed to create and add attributes\n");
> > + goto err_destroy_classdev;
> > + }
> > +
> > + err =3D sysfs_create_file(&asus_armoury.fw_attr_kset->kobj, &pendi=
ng_reboot.attr);
> > + if (err) {
> > + pr_warn("Failed to create sysfs level attributes\n");
> > + goto fail_class_created;
> > + }
> > +
> > + err =3D 0;
> > + asus_armoury.mini_led_dev_id =3D 0;
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE)) {
> > + asus_armoury.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE;
> > + err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> > + &mini_led_mode_attr_group);
> > + } else if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE2)) {
> > + asus_armoury.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE2;
> > + err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> > + &mini_led_mode_attr_group);
> > + }
> > + if (err)
> > + pr_warn("Failed to create sysfs-group for mini_led\n");
> > +
> > + err =3D 0;
> > + asus_armoury.gpu_mux_dev_id =3D 0;
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX)) {
> > + asus_armoury.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX;
> > + err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> > + &gpu_mux_mode_attr_group);
> > + } else if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX_VIVO)) {
> > + asus_armoury.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX_VIVO;
> > + err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> > + &gpu_mux_mode_attr_group);
> > + }
> > + if (err)
> > + pr_warn("Failed to create sysfs-group for gpu_mux\n");
> > +
> > + for (int i =3D 0; i < ARRAY_SIZE(armoury_attr_groups); i++) {
> > + /* Do not show for the Ally devices as powersave is entirely unrel=
iable on it */
> > + if (armoury_attr_groups[i].wmi_devid =3D=3D ASUS_WMI_DEVID_MCU_POW=
ERSAVE &&
> > +     dmi_check_system(asus_rog_ally_device))
> > + continue;
> > +
> > + if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
> > + continue;
> > +
> > + err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> > + armoury_attr_groups[i].attr_group);
> > + if (err)
> > + pr_warn("Failed to create sysfs-group for %s\n",
> > + armoury_attr_groups[i].attr_group->name);
> > + else
> > + pr_debug("Created sysfs-group for %s\n",
> > + armoury_attr_groups[i].attr_group->name);
> > + }
> > +
> > + return 0;
> > +
> > +err_destroy_classdev:
> > + device_destroy(fw_attr_class, MKDEV(0, 0));
> > +
> > +fail_class_created:
> > + fw_attributes_class_put();
> > + return err;
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
> > + } else if (strstr(product, "RC71") || strstr(product, "RC72")) {
> > + cpu_max =3D 50;
> > + cpu_default =3D 30;
> > + } else if (strstr(product, "G814") || strstr(product, "G614") ||
> > +    strstr(product, "G834") || strstr(product, "G634")) {
> > + cpu_max =3D 175;
> > + } else if (strstr(product, "GA402X") || strstr(product, "GA403") ||
> > +    strstr(product, "FA507N") || strstr(product, "FA507X") ||
> > +    strstr(product, "FA707N") || strstr(product, "FA707X")) {
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
> > + rog->cpu_min =3D PPT_CPU_LIMIT_MIN;
> > + rog->cpu_max =3D cpu_max;
> > +
> > + rog->platform_default =3D platform_default;
> > + rog->platform_max =3D PPT_PLATFORM_MIN;
> > + rog->platform_max =3D platform_max;
> > +
> > + rog->ppt_pl1_spl =3D cpu_default;
> > + rog->ppt_pl2_sppt =3D cpu_default;
> > + rog->ppt_apu_sppt =3D cpu_default;
> > +
> > + rog->ppt_platform_sppt =3D platform_default;
> > + rog->ppt_fppt =3D cpu_default;
> > +
> > + rog->nv_boost_default =3D NVIDIA_BOOST_MAX;
> > + rog->nv_boost_max =3D NVIDIA_BOOST_MIN;
> > + rog->nv_boost_max =3D max_boost;
> > + rog->nv_dynamic_boost =3D NVIDIA_BOOST_MIN;
> > +
> > + rog->nv_temp_default =3D NVIDIA_TEMP_MAX;
> > + rog->nv_temp_max =3D NVIDIA_TEMP_MIN;
> > + rog->nv_temp_max =3D NVIDIA_TEMP_MAX;
> > + rog->nv_temp_target =3D NVIDIA_TEMP_MIN;
> > +}
> > +
> > +static int __init asus_fw_init(void)
> > +{
> > + int err;
> > +
> > + fw_attrs.pending_reboot =3D false;
> > +
> > + asus_armoury.rog_tunables =3D kzalloc(sizeof(struct rog_tunables),=
 GFP_KERNEL);
> > + if (!asus_armoury.rog_tunables)
> > + return -ENOMEM;
> > +
> > + init_rog_tunables(asus_armoury.rog_tunables);
> > +
> > + err =3D asus_fw_attr_add();
> > + if (err)
> > + return err;
> > +
> > + return 0;
> > +}
> > +
> > +static void __exit asus_fw_exit(void)
> > +{
> > + mutex_lock(&asus_armoury.mutex);
> > +
> > + sysfs_remove_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboo=
t.attr);
> > + kset_unregister(asus_armoury.fw_attr_kset);
> > + device_destroy(fw_attr_class, MKDEV(0, 0));
> > + fw_attributes_class_put();
> > +
> > + mutex_unlock(&asus_armoury.mutex);
> > +}
> > +
> > +module_init(asus_fw_init);
> > +module_exit(asus_fw_exit);
> > +
> > +MODULE_IMPORT_NS(ASUS_WMI);
> > +MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
> > +MODULE_DESCRIPTION("ASUS BIOS Configuration Driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("wmi:" ASUS_NB_WMI_EVENT_GUID);
> > diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/=
x86/asus-armoury.h
> > new file mode 100644
> > index 000000000000..8bb75cf88305
> > --- /dev/null
> > +++ b/drivers/platform/x86/asus-armoury.h
> > @@ -0,0 +1,209 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Definitions for kernel modules using asus-armoury driver
> > + *
> > + *  Copyright (c) 2024 Luke Jones <luke@ljones.dev>
> > + */
> > +
> > +#ifndef _ASUS_BIOSCFG_H_
> > +#define _ASUS_BIOSCFG_H_
> > +
> > +#include <linux/types.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define DRIVER_NAME "asus-armoury"
> > +
> > +static ssize_t attr_int_store(struct kobject *kobj, struct kobj_att=
ribute *attr,
> > +       const char *buf, size_t count, u32 min, u32 max,
> > +       u32 *store_value, u32 wmi_dev);
> > +
> > +static ssize_t int_type_show(struct kobject *kobj, struct kobj_attr=
ibute *attr,
> > +      char *buf)
> > +{
> > + return sysfs_emit(buf, "integer\n");
> > +}
> > +
> > +static ssize_t enum_type_show(struct kobject *kobj, struct kobj_att=
ribute *attr,
> > +       char *buf)
> > +{
> > + return sysfs_emit(buf, "enumeration\n");
> > +}
> > +
> > +#define __ASUS_ATTR_RO(_func, _name)                               =
   \
> > + {                                                             \
> > + .attr =3D { .name =3D __stringify(_name), .mode =3D 0444 }, \
> > + .show =3D _func##_##_name##_show,                       \
> > + }
> > +
> > +#define __ASUS_ATTR_RO_AS(_name, _show)                            =
   \
> > + {                                                             \
> > + .attr =3D { .name =3D __stringify(_name), .mode =3D 0444 }, \
> > + .show =3D _show,                                        \
> > + }
> > +
> > +#define __ASUS_ATTR_RW(_func, _name) \
> > + __ATTR(_name, 0644, _func##_##_name##_show, _func##_##_name##_stor=
e)
> > +
> > +#define __WMI_STORE_INT(_attr, _min, _max, _wmi)                   =
       \
> > + static ssize_t _attr##_store(struct kobject *kobj,                \
> > +      struct kobj_attribute *attr,         \
> > +      const char *buf, size_t count)       \
> > + {                                                                 \
> > + return attr_int_store(kobj, attr, buf, count, _min, _max, \
> > +       NULL, _wmi);                        \
> > + }
> > +
> > +#define WMI_SHOW_INT(_attr, _fmt, _wmi)                            =
         \
> > + static ssize_t _attr##_show(struct kobject *kobj,                 =
  \
> > +     struct kobj_attribute *attr, char *buf) \
> > + {                                                                 =
  \
> > + u32 result;                                                 \
> > + int err;                                                    \
> > + err =3D asus_wmi_get_devstate_dsts(_wmi, &result);            \
> > + if (err)                                                    \
> > + return err;                                         \
> > + return sysfs_emit(buf, _fmt,                                \
> > +   result & ~ASUS_WMI_DSTS_PRESENCE_BIT);    \
> > + }
> > +
> > +/* Create functions and attributes for use in other macros or on th=
eir own */
> > +
> > +#define __ATTR_CURRENT_INT_RO(_attr, _wmi)                         =
 \
> > + WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi);          \
> > + static struct kobj_attribute attr_##_attr##_current_value =3D \
> > + __ASUS_ATTR_RO(_attr, current_value)
> > +
> > +#define __ATTR_CURRENT_INT_RW(_attr, _minv, _maxv, _wmi)           =
 \
> > + __WMI_STORE_INT(_attr##_current_value, _minv, _maxv, _wmi); \
> > + WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi);          \
> > + static struct kobj_attribute attr_##_attr##_current_value =3D \
> > + __ASUS_ATTR_RW(_attr, current_value)
> > +
> > +/* Shows a formatted static variable */
> > +#define __ATTR_SHOW_FMT(_prop, _attrname, _fmt, _val)              =
           \
> > + static ssize_t _attrname##_##_prop##_show(                        =
    \
> > + struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
> > + {                                                                 =
    \
> > + return sysfs_emit(buf, _fmt, _val);                           \
> > + }                                                                 =
    \
> > + static struct kobj_attribute attr_##_attrname##_##_prop =3D       =
      \
> > + __ASUS_ATTR_RO(_attrname, _prop)
> > +
> > +/* Boolean style enumeration, base macro. Requires adding show/stor=
e */
> > +#define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)=
     \
> > + __ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);    \
> > + __ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible); \
> > + static struct kobj_attribute attr_##_attrname##_type =3D          \
> > + __ASUS_ATTR_RO_AS(type, enum_type_show);                \
> > + static struct attribute *_attrname##_attrs[] =3D {                \
> > + &attr_##_attrname##_current_value.attr,                 \
> > + &attr_##_attrname##_display_name.attr,                  \
> > + &attr_##_attrname##_possible_values.attr,               \
> > + &attr_##_attrname##_type.attr, NULL                     \
> > + };                                                              \
> > + static const struct attribute_group _attrname##_attr_group =3D {  \
> > + .name =3D _fsname, .attrs =3D _attrname##_attrs             \
> > + }
> > +
> > +#define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname) \
> > + __ATTR_CURRENT_INT_RO(_attrname, _wmi);                 \
> > + __ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> > +
> > +#define ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname) \
> > + __ATTR_CURRENT_INT_RW(_attrname, 0, 1, _wmi);           \
> > + __ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> > +
> > +/*
> > + * Requires <name>_current_value_show(), <name>_current_value_show()
> > + */
> > +#define ATTR_GROUP_BOOL_CUSTOM(_attrname, _fsname, _dispname)      =
     \
> > + static struct kobj_attribute attr_##_attrname##_current_value =3D \
> > + __ASUS_ATTR_RW(_attrname, current_value);               \
> > + __ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> > +
> > +#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi, _possible,=
 _dispname) \
> > + __ATTR_CURRENT_INT_RO(_attrname, _wmi);                           =
     \
> > + __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)
> > +
> > +/*
> > + * Requires <name>_current_value_show(), <name>_current_value_show()
> > + * and <name>_possible_values_show()
> > + */
> > +#define ATTR_GROUP_ENUM_CUSTOM(_attrname, _fsname, _dispname)      =
       \
> > + __ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);      \
> > + static struct kobj_attribute attr_##_attrname##_current_value =3D =
  \
> > + __ASUS_ATTR_RW(_attrname, current_value);                 \
> > + static struct kobj_attribute attr_##_attrname##_possible_values =3D=
 \
> > + __ASUS_ATTR_RO(_attrname, possible_values);               \
> > + static struct kobj_attribute attr_##_attrname##_type =3D          =
  \
> > + __ASUS_ATTR_RO_AS(type, enum_type_show);                  \
> > + static struct attribute *_attrname##_attrs[] =3D {                =
  \
> > + &attr_##_attrname##_current_value.attr,                   \
> > + &attr_##_attrname##_display_name.attr,                    \
> > + &attr_##_attrname##_possible_values.attr,                 \
> > + &attr_##_attrname##_type.attr, NULL                       \
> > + };                                                                \
> > + static const struct attribute_group _attrname##_attr_group =3D {  =
  \
> > + .name =3D _fsname, .attrs =3D _attrname##_attrs               \
> > + }
> > +
> > +/*
> > + * ROG PPT attributes need a little different in setup as they
> > + * require rog_tunables members.
> > + */
> > +
> > +#define __ROG_TUNABLE_RW(_attr, _min, _max, _wmi)                  =
           \
> > + static ssize_t _attr##_current_value_store(                       =
    \
> > + struct kobject *kobj, struct kobj_attribute *attr,            \
> > + const char *buf, size_t count)                                \
> > + {                                                                 =
    \
> > + return attr_int_store(kobj, attr, buf, count,                 \
> > +       asus_armoury.rog_tunables->_min,        \
> > +       asus_armoury.rog_tunables->_max,        \
> > +       &asus_armoury.rog_tunables->_attr,      \
> > +       _wmi);                                  \
> > + }                                                                 =
    \
> > + static ssize_t _attr##_current_value_show(                        =
    \
> > + struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
> > + {                                                                 =
    \
> > + return sysfs_emit(buf, "%u\n",                                \
> > +   asus_armoury.rog_tunables->_attr);          \
> > + }                                                                 =
    \
> > + static struct kobj_attribute attr_##_attr##_current_value =3D     =
      \
> > + __ASUS_ATTR_RW(_attr, current_value)
> > +
> > +#define __ROG_TUNABLE_SHOW(_prop, _attrname, _val)                 =
           \
> > + static ssize_t _attrname##_##_prop##_show(                        =
    \
> > + struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
> > + {                                                                 =
    \
> > + return sysfs_emit(buf, "%d\n",                                \
> > +   asus_armoury.rog_tunables->_val);           \
> > + }                                                                 =
    \
> > + static struct kobj_attribute attr_##_attrname##_##_prop =3D       =
      \
> > + __ASUS_ATTR_RO(_attrname, _prop)
> > +
> > +#define ATTR_GROUP_ROG_TUNABLE(_attrname, _fsname, _wmi, _default, =
_min, _max, \
> > +        _incstep, _dispname)                            \
> > + __ROG_TUNABLE_SHOW(default_value, _attrname, _default);           =
     \
> > + __ROG_TUNABLE_RW(_attrname, _min, _max, _wmi);                    =
     \
> > + __ROG_TUNABLE_SHOW(min_value, _attrname, _min);                   =
     \
> > + __ROG_TUNABLE_SHOW(max_value, _attrname, _max);                   =
     \
> > + __ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", _incstep);   =
     \
> > + __ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);      =
     \
> > + static struct kobj_attribute attr_##_attrname##_type =3D          =
       \
> > + __ASUS_ATTR_RO_AS(type, int_type_show);                        \
> > + static struct attribute *_attrname##_attrs[] =3D {                =
       \
> > + &attr_##_attrname##_current_value.attr,                        \
> > + &attr_##_attrname##_default_value.attr,                        \
> > + &attr_##_attrname##_min_value.attr,                            \
> > + &attr_##_attrname##_max_value.attr,                            \
> > + &attr_##_attrname##_scalar_increment.attr,                     \
> > + &attr_##_attrname##_display_name.attr,                         \
> > + &attr_##_attrname##_type.attr,                                 \
> > + NULL                                                           \
> > + };                                                                =
     \
> > + static const struct attribute_group _attrname##_attr_group =3D {  =
       \
> > + .name =3D _fsname, .attrs =3D _attrname##_attrs                   =
 \
> > + }
> > +
> > +#endif /* _ASUS_BIOSCFG_H_ */
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index 08861792bddd..d265ef0d7aba 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -152,20 +152,6 @@ static const char * const ashs_ids[] =3D { "ATK=
4001", "ATK4002", NULL };
> >  =20
> >   static int throttle_thermal_policy_write(struct asus_wmi *);
> >  =20
> > -static const struct dmi_system_id asus_ally_mcu_quirk[] =3D {
> > - {
> > - .matches =3D {
> > - DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> > - },
> > - },
> > - {
> > - .matches =3D {
> > - DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> > - },
> > - },
> > - { },
> > -};
> > -
> >   static bool ashs_present(void)
> >   {
> >   int i =3D 0;
> > @@ -386,7 +372,7 @@ int asus_wmi_evaluate_method(u32 method_id, u32 =
arg0, u32 arg1, u32 *retval)
> >   {
> >   return asus_wmi_evaluate_method3(method_id, arg0, arg1, 0, retval);
> >   }
> > -EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
> > +EXPORT_SYMBOL_NS_GPL(asus_wmi_evaluate_method, ASUS_WMI);
> >  =20
> >   static int asus_wmi_evaluate_method5(u32 method_id,
> >   u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
> > @@ -550,12 +536,58 @@ static int asus_wmi_get_devstate(struct asus_w=
mi *asus, u32 dev_id, u32 *retval)
> >   return 0;
> >   }
> >  =20
> > -static int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
> > - u32 *retval)
> > +/**
> > + * asus_wmi_get_devstate_dsts() - Get the WMI function state.
> > + * @dev_id: The WMI function to call.
> > + * @retval: A pointer to where to store the value returned from WMI.
> > + *
> > + * The returned WMI function state can also be used to determine if=
 the WMI
> > + * function is supported by checking if the asus_wmi_get_devstate_d=
sts()
> > + * returns an error.
> > + *
> > + * On success the return value is 0, and the retval is a valid valu=
e returned
> > + * by the successful WMI function call. An error value is returned =
only if the
> > + * WMI function failed, or if it returns "unsupported" which is typ=
ically a 0
> > + * (no return, and no 'supported' bit set), or a 0xFFFFFFFE (~1) wh=
ich if not
> > + * caught here can result in unexpected behaviour later.
> > + */
> > +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
> > +{
> > + int err;
> > +
> > + err =3D asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0=
, retval);
> > + *retval &=3D ~ASUS_WMI_DSTS_PRESENCE_BIT;
>=20
> Shouldn't you only update this if no error?  IE move to the end of the=20
> function before return 0.

Yes, fixed.

> > +
> > + if (err)
> > + return err;
> > + /* Be explicit about retval */
> > + if (*retval =3D=3D ASUS_WMI_UNSUPPORTED_METHOD)
> > + return -ENODEV;
> > +
> > + return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(asus_wmi_get_devstate_dsts, ASUS_WMI);
> > +
> > +/**
> > + * asus_wmi_set_devstate() - Set the WMI function state.
> > + * @dev_id: The WMI function to call.
> > + * @ctrl_param: The argument to be used for this WMI function.
> > + * @retval: A pointer to where to store the value returned from WMI.
> > + *
> > + * The returned WMI function state if not checked here for error as
> > + * asus_wmi_set_devstate() is not called unless first paired with a=
 call to
> > + * asus_wmi_get_devstate_dsts() to check that the WMI function is s=
upported.
> > + *
> > + * On success the return value is 0, and the retval is a valid valu=
e returned
> > + * by the successful WMI function call. An error value is returned =
only if the
> > + * WMI function failed.
> > + */
> > +int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
> >   {
> >   return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
> >   ctrl_param, retval);
> >   }
> > +EXPORT_SYMBOL_NS_GPL(asus_wmi_set_devstate, ASUS_WMI);
> >  =20
> >   /* Helper for special devices with magic return codes */
> >   static int asus_wmi_get_devstate_bits(struct asus_wmi *asus,
> > @@ -4774,8 +4806,7 @@ static int asus_wmi_add(struct platform_device=
 *pdev)
> >   asus->egpu_enable_available =3D asus_wmi_dev_is_present(asus, ASUS=
_WMI_DEVID_EGPU);
> >   asus->dgpu_disable_available =3D asus_wmi_dev_is_present(asus, ASU=
S_WMI_DEVID_DGPU);
> >   asus->kbd_rgb_state_available =3D asus_wmi_dev_is_present(asus, AS=
US_WMI_DEVID_TUF_RGB_STATE);
> > - asus->ally_mcu_usb_switch =3D acpi_has_method(NULL, ASUS_USB0_PWR_=
EC0_CSEE)
> > - && dmi_check_system(asus_ally_mcu_quirk);
> > + asus->ally_mcu_usb_switch =3D acpi_has_method(NULL, ASUS_USB0_PWR_=
EC0_CSEE);
> >  =20
> >   if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
> >   asus->mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE;
> > diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/=
asus-wmi.h
> > index d02f15fd3482..c66e970b3674 100644
> > --- a/drivers/platform/x86/asus-wmi.h
> > +++ b/drivers/platform/x86/asus-wmi.h
> > @@ -86,4 +86,18 @@ struct asus_wmi_driver {
> >   int asus_wmi_register_driver(struct asus_wmi_driver *driver);
> >   void asus_wmi_unregister_driver(struct asus_wmi_driver *driver);
> >  =20
> > +static const struct dmi_system_id asus_rog_ally_device[] =3D {
> > + {
> > + .matches =3D {
> > + DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> > + },
> > + },
> > + {
> > + .matches =3D {
> > + DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> > + },
> > + },
> > + { },
> > +};
> > +
> >   #endif /* !_ASUS_WMI_H_ */
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/li=
nux/platform_data/x86/asus-wmi.h
> > index 365e119bebaa..7caf2c7ed8c9 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -73,6 +73,7 @@
> >   #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
> >  =20
> >   /* Misc */
> > +#define ASUS_WMI_DEVID_PANEL_HD 0x0005001C
> >   #define ASUS_WMI_DEVID_PANEL_OD 0x00050019
> >   #define ASUS_WMI_DEVID_CAMERA 0x00060013
> >   #define ASUS_WMI_DEVID_LID_FLIP 0x00060062
> > @@ -158,8 +159,18 @@
> >   #define ASUS_WMI_DSTS_LIGHTBAR_MASK 0x0000000F
> >  =20
> >   #if IS_REACHABLE(CONFIG_ASUS_WMI)
> > +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval);
> > +int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval);
> >   int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u3=
2 *retval);
> >   #else
> > +static inline int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retva=
l)
> > +{
> > + return -ENODEV;
> > +}
> > +static inline int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,=
 u32 *retval)
> > +{
> > + return -ENODEV;
> > +}
> >   static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0=
, u32 arg1,
> >      u32 *retval)
> >   {
>=20
>=20

