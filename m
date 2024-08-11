Return-Path: <linux-kernel+bounces-282210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE9E94E0DF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3581F210FB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D4E3EA83;
	Sun, 11 Aug 2024 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="F1OLDuHA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NLi28gWf"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446528E8;
	Sun, 11 Aug 2024 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723372416; cv=none; b=FpmI9yZsaeSq9UYNqkklGyFh+iwrsC2KYoalYzH0cMyk/JVIXgfXikzYe22LO483aw76VxhUSK+TpYFk04AEwpbc1y2dE/GvJqozhf8t/jQHZzhUSow63FMu+hLVP1qdDWtHd81oK+S460r/9k/GXUhE8E4qvUVL0k62Bxbd/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723372416; c=relaxed/simple;
	bh=j6tldjg1GL/PxZHCMN4aT+R1qQg3cJnMI9gNhKe1gRI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QL7WEwTwnrCvvyjJu6QDJyTEsKtuwuVM+JYELlUB4oQSK9EXSnI/Cl+aJmDmU4+EwPHczoUinalTEZMkVyhi9Ia3JNsePwFaKoaev58s59ueKsGpjnxdC3ZAObOU4wLRqK6/tAshkmex5MUy5Yw0DoRIl3r3xUDmq5ZS3QR2ilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=F1OLDuHA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NLi28gWf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id C3154138FD47;
	Sun, 11 Aug 2024 06:33:32 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute3.internal (MEProxy); Sun, 11 Aug 2024 06:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723372412;
	 x=1723458812; bh=qx1ZshSOQoEU+B3EMjGIGth3xJoP3BwbwSiHinv7L04=; b=
	F1OLDuHA1OZAur/y9KXfPw3Ci9HhS+rOdnazCdgSGztzg1/dn6Ggwf36z5SI9ihp
	qX9uGDPK1Uwoj9ivcTbTKppK9844kuC/LFbTK1TtrxQkF2fxBIvkgaUj/I7W38ZA
	YAVKWNou25A9c+Wjz+FH90yP93HO5s+lpj0/tIyWxWQvHc1bPdJySOXCUf5Au8XU
	3SL+M5uAhnVgTdKrROY2RQlc2KbfW7krZfdX5ieO7jfPQUGgpgNEpMTluterVxKy
	aleSM2zzp+l/lifFeXnJmC4G+i4bbKGENegWyZJqGT07ylmyR0N3O0ap9bKYWOvf
	bS7m8hZZifkb0jDopa5RLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723372412; x=
	1723458812; bh=qx1ZshSOQoEU+B3EMjGIGth3xJoP3BwbwSiHinv7L04=; b=N
	Li28gWfkzISJ2P6azn69HRZmOHCXizercrfhOUKuadpJsgb9Hvsh0j6E0btU/9Ub
	VkVvV5FKQvUzz8Aj5HhTiNTXU7K4uD/ro3vhvqcK+nWatVCQ01NeOcNWlJWNVdcV
	d5jNFk4j+5nXe0c9C0QfuYBuzVlWMRlY1Pa/SDu/sYNeTGebqq5gwmO2u1LfRJgW
	j7momVBx3QuMeRiXnzc/Vr3GZxSOYYsultQ8W4jt+udpO/I2wLApfZxq2gRFdLbx
	DA1J2JkNTFCejbSPDW0fogGh7Y7Tpm3Ah1ApStTqQnXWvNxVWEsj18NPTZQ+7thq
	FLBJpgc1b+cA8h1c1wXKw==
X-ME-Sender: <xms:fJO4ZoYsv9qthWnijn4033peZ40KXLZOdvihP3eeauoU5PA2YiWmNg>
    <xme:fJO4ZjZ15GxsdIKZbq-0fa10H50Uyv3nNn4E8bfCnFQW9AofKjbWUHX_v3BEwcsIq
    J0AMPJgdEXBcQDzdGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfnuhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvh
    eqnecuggftrfgrthhtvghrnhepkeejgeehtedvveduueffteeltdevhedvkeekgeffleeg
    uddujeduvefgffdutdehnecuffhomhgrihhnpehmrgiiuggvrhhmihhnugdruggvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehl
    jhhonhgvshdruggvvhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheptghorhgvnhhtihhnrdgthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprh
    gtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fJO4Zi_EvHeyd38qUBF8h_WIt3h42zNEhDzBwlg8qoXSGFzPXRC8QA>
    <xmx:fJO4Ziou2XWgep66UVIKc2ihWr2q663uzK-diW7m-ztQxrFjTkSILA>
    <xmx:fJO4Zjoo7oOG2dHWfU2reqxDnejEqWnpH6RFrJSg4YrF_PAvPW8HAg>
    <xmx:fJO4ZgTZ6Qbl-4Zs1ib5RdniPvTbG_z-DjPdkbdtVh74C7-DuzAZfQ>
    <xmx:fJO4ZiXbKuGj0i2hERaHbmIkxIubc73dxT2XZpqxicsq38YRzVvDiTRt>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 23A402340081; Sun, 11 Aug 2024 06:33:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 11 Aug 2024 22:33:03 +1200
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com
Message-Id: <d4993c89-f24f-43dd-a9cf-ccd98fb21172@app.fastmail.com>
In-Reply-To: <b29283ba-22c1-95dc-dbaa-69bd4fc2dd3a@linux.intel.com>
References: <20240806020747.365042-1-luke@ljones.dev>
 <20240806020747.365042-6-luke@ljones.dev>
 <b29283ba-22c1-95dc-dbaa-69bd4fc2dd3a@linux.intel.com>
Subject: Re: [PATCH v2 5/6] platform/x86: asus-armoury: add core count control
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Aug 2024, at 10:32 PM, Ilpo J=C3=A4rvinen wrote:
> On Tue, 6 Aug 2024, Luke D. Jones wrote:
>=20
> > Implement Intel core enablement under the asus-armoury module using =
the
> > fw_attributes class.
> >=20
> > This allows users to enable or disable preformance or efficiency cor=
es
> > depending on their requirements. After change a reboot is required.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  drivers/platform/x86/asus-armoury.c        | 208 ++++++++++++++++++=
++-
> >  drivers/platform/x86/asus-armoury.h        |  29 +++
> >  include/linux/platform_data/x86/asus-wmi.h |   4 +
> >  3 files changed, 240 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/=
x86/asus-armoury.c
> > index 412e75c652a4..592ebea35ad5 100644
> > --- a/drivers/platform/x86/asus-armoury.c
> > +++ b/drivers/platform/x86/asus-armoury.c
> > @@ -39,6 +39,18 @@
> >  #define ASUS_MINI_LED_2024_STRONG 0x01
> >  #define ASUS_MINI_LED_2024_OFF 0x02
> > =20
> > +enum cpu_core_type {
> > + CPU_CORE_PERF =3D 0,
> > + CPU_CORE_POWER,
> > +};
> > +
> > +enum cpu_core_value {
> > + CPU_CORE_DEFAULT =3D 0,
> > + CPU_CORE_MIN,
> > + CPU_CORE_MAX,
> > + CPU_CORE_CURRENT,
> > +};
> > +
> >  /* Default limits for tunables available on ASUS ROG laptops */
> >  #define PPT_CPU_LIMIT_MIN 5
> >  #define PPT_CPU_LIMIT_MAX 150
> > @@ -84,6 +96,10 @@ struct rog_tunables {
> >  u32 dgpu_tgp_min;
> >  u32 dgpu_tgp_max;
> >  u32 dgpu_tgp;
> > +
> > + u32 min_perf_cores;
> > + u32 max_perf_cores;
> > + u32 max_power_cores;
> >  };
> > =20
> >  static const struct class *fw_attr_class;
> > @@ -148,7 +164,9 @@ static struct kobj_attribute pending_reboot =3D =
__ATTR_RO(pending_reboot);
> >  static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
> >  {
> >  return !strcmp(attr->attr.name, "gpu_mux_mode") ||
> > -        !strcmp(attr->attr.name, "panel_hd_mode");
> > + !strcmp(attr->attr.name, "cores_performance") ||
> > + !strcmp(attr->attr.name, "cores_efficiency") ||
> > + !strcmp(attr->attr.name, "panel_hd_mode");
> >  }
> > =20
> >  /**
> > @@ -576,6 +594,191 @@ static ssize_t apu_mem_possible_values_show(st=
ruct kobject *kobj,
> >  }
> >  ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set the available syste=
m memory for the APU to use");
> > =20
> > +static int init_max_cpu_cores(void)
> > +{
> > + u32 cores;
> > + int err;
> > +
> > + asus_armoury.rog_tunables->min_perf_cores =3D 4;
> > + asus_armoury.rog_tunables->max_perf_cores =3D 4;
> > + asus_armoury.rog_tunables->max_power_cores =3D 8;
> > +
> > + err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES_MAX, &core=
s);
> > + if (err)
> > + return err;
> > +
> > + cores &=3D ~ASUS_WMI_DSTS_PRESENCE_BIT;
> > + asus_armoury.rog_tunables->max_power_cores =3D (cores & 0xff00) >>=
 8;
> > + asus_armoury.rog_tunables->max_perf_cores =3D cores & 0xff;
>=20
> Define names for the fields returned in 'cores' using GENMASK() and us=
e=20
> FIELD_GET() here to extract them.

Wasn't aware of this. Also had to look at this https://mazdermind.de/gen=
mask/ as the documentation for these things is... lacking.

> > +
> > + return 0;
> > +}
> > +
> > +static ssize_t cores_value_show(struct kobject *kobj,
> > + struct kobj_attribute *attr, char *buf,
> > + enum cpu_core_type core_type,
> > + enum cpu_core_value core_value)
> > +{
> > + u32 cores;
> > + int err;
> > +
> > + switch (core_value) {
> > + case CPU_CORE_DEFAULT:
> > + case CPU_CORE_MAX:
> > + if (core_type =3D=3D CPU_CORE_PERF)
> > + return sysfs_emit(buf, "%d\n", asus_armoury.rog_tunables->max_perf=
_cores);
>=20
> %u for u32, please check all %d, I won't mark the rest.

Got it. Sorry.

>=20
> > + else
> > + return sysfs_emit(buf, "%d\n", asus_armoury.rog_tunables->max_powe=
r_cores);
> > + case CPU_CORE_MIN:
> > + if (core_type =3D=3D CPU_CORE_PERF)
> > + return sysfs_emit(buf, "%d\n", asus_armoury.rog_tunables->min_perf=
_cores);
> > + else
> > + return sysfs_emit(buf, "%d\n", 0);
> > + default:
> > + break;
>=20
> Misindented.

Ack

>=20
> > + }
> > +
> > + err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES, &cores);
> > + if (err)
> > + return err;
> > +
> > + cores &=3D ~ASUS_WMI_DSTS_PRESENCE_BIT;
> > + if (core_type =3D=3D CPU_CORE_PERF)
> > + cores &=3D 0xff;
> > + else
> > + cores =3D (cores & 0xff00) >> 8;
>=20
> Perhaps create a helper which takes two pointers for core types as thi=
s=20
> code is similar to the one in init_max_cpu_cores().

Maybe. I'll try work something out.

> > + return sysfs_emit(buf, "%d\n", cores);
> > +}
> > +
> > +static ssize_t cores_current_value_store(struct kobject *kobj,
> > + struct kobj_attribute *attr, const char *buf,
> > + enum cpu_core_type core_type)
> > +{
> > + int result, err;
> > + u32 cores, currentv, min, max;
> > +
> > + result =3D kstrtou32(buf, 10, &cores);
> > + if (result)
> > + return result;
> > +
> > + if (core_type =3D=3D CPU_CORE_PERF) {
> > + min =3D asus_armoury.rog_tunables->min_perf_cores;
> > + max =3D asus_armoury.rog_tunables->max_perf_cores;
> > + } else {
> > + min =3D 0;
> > + max =3D asus_armoury.rog_tunables->max_power_cores;
> > + }
> > + if (cores < min || cores > max)
> > + return -EINVAL;
> > +
> > + err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES, &currentv=
);
> > + if (err)
> > + return err;
> > +
> > + if (core_type =3D=3D CPU_CORE_PERF)
> > + cores |=3D (currentv & 0xff00);
> > + else
> > + cores |=3D currentv & 0xff;
>=20
> Use normal pattern to alter a field:
> xx &=3D ~YY;
> xx |=3D FIELD_PREP(YY, cores);
>=20
> Alternatively you could just recalculate it fully since you've cached =
the=20
> values?
>=20
> > +
> > + if (cores =3D=3D currentv)
> > + return 0;
> > +
> > + err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_CORES, cores, &result=
);
> > + if (err) {
> > + pr_warn("Failed to set CPU core count: %d\n", err);
> > + return err;
> > + }
> > +
> > + if (result > 1) {
> > + pr_warn("Failed to set CPU core count (result): 0x%x\n", result);
> > + return -EIO;
> > + }
> > +
> > + pr_info("CPU core count changed, reboot required\n");
> > + sysfs_notify(kobj, NULL, attr->attr.name);
> > + asus_set_reboot_and_signal_event();
>=20
> What prevents two change requests racing with each other?

Ah.. That's why I added a mutex I never used.

Thnak you for your patience and reviews.

Cheers,
Luke.

>=20
> --=20
> i.
>=20
> > + return 0;
> > +}
> > +
> > +static ssize_t cores_performance_min_value_show(struct kobject *kob=
j,
> > + struct kobj_attribute *attr, char *buf)
> > +{
> > + return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_M=
IN);
> > +}
> > +
> > +static ssize_t cores_performance_max_value_show(struct kobject *kob=
j,
> > + struct kobj_attribute *attr, char *buf)
> > +{
> > + return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_M=
AX);
> > +}
> > +
> > +static ssize_t cores_performance_default_value_show(struct kobject =
*kobj,
> > + struct kobj_attribute *attr, char *buf)
> > +{
> > + return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_D=
EFAULT);
> > +}
> > +
> > +static ssize_t cores_performance_current_value_show(struct kobject =
*kobj,
> > + struct kobj_attribute *attr, char *buf)
> > +{
> > + return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_C=
URRENT);
> > +}
> > +
> > +static ssize_t cores_performance_current_value_store(struct kobject=
 *kobj,
> > + struct kobj_attribute *attr,
> > + const char *buf, size_t count)
> > +{
> > + int err;
> > +
> > + err =3D cores_current_value_store(kobj, attr, buf, CPU_CORE_PERF);
> > + if (err)
> > + return err;
> > +
> > + return count;
> > +}
> > +ATTR_GROUP_CORES_RW(cores_performance, "cores_performance",
> > + "Set the max available performance cores");
> > +
> > +static ssize_t cores_efficiency_min_value_show(struct kobject *kobj,
> > + struct kobj_attribute *attr, char *buf)
> > +{
> > + return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_=
MIN);
> > +}
> > +
> > +static ssize_t cores_efficiency_max_value_show(struct kobject *kobj,
> > + struct kobj_attribute *attr, char *buf)
> > +{
> > + return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_=
MAX);
> > +}
> > +
> > +static ssize_t cores_efficiency_default_value_show(struct kobject *=
kobj,
> > + struct kobj_attribute *attr, char *buf)
> > +{
> > + return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_=
DEFAULT);
> > +}
> > +
> > +static ssize_t cores_efficiency_current_value_show(struct kobject *=
kobj,
> > + struct kobj_attribute *attr, char *buf)
> > +{
> > + return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_=
CURRENT);
> > +}
> > +
> > +static ssize_t cores_efficiency_current_value_store(struct kobject =
*kobj,
> > + struct kobj_attribute *attr,
> > + const char *buf, size_t count)
> > +{
> > + int err;
> > +
> > + err =3D cores_current_value_store(kobj, attr, buf, CPU_CORE_POWER);
> > + if (err)
> > + return err;
> > +
> > + return count;
> > +}
> > +ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency",
> > + "Set the max available efficiency cores");
> > +
> >  /* Simple attribute creation */
> >  ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_P=
PT_PL1_SPL, cpu_default,
> >         cpu_min, cpu_max, 1, "Set the CPU slow package limit");
> > @@ -631,6 +834,8 @@ static const struct asus_attr_group armoury_attr=
_groups[] =3D {
> >  { &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
> >  { &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
> >  { &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
> > + { &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
> > + { &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
> > =20
> >  { &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
> >  { &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> > @@ -811,6 +1016,7 @@ static int __init asus_fw_init(void)
> >  return -ENOMEM;
> >  }
> >  init_rog_tunables(asus_armoury.rog_tunables);
> > + init_max_cpu_cores();
> > =20
> >  err =3D asus_fw_attr_add();
> >  mutex_unlock(&asus_armoury.mutex);
> > diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/=
x86/asus-armoury.h
> > index 96d991383b8a..da585a180125 100644
> > --- a/drivers/platform/x86/asus-armoury.h
> > +++ b/drivers/platform/x86/asus-armoury.h
> > @@ -154,6 +154,35 @@ static ssize_t enum_type_show(struct kobject *k=
obj, struct kobj_attribute *attr,
> >  .name =3D _fsname, .attrs =3D _attrname##_attrs                    =
                \
> >  }
> > =20
> > +/* CPU core attributes need a little different in setup */
> > +#define ATTR_GROUP_CORES_RW(_attrname, _fsname, _dispname) \
> > +__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", 1); \
> > +__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname); \
> > +static struct kobj_attribute attr_##_attrname##_current_value =3D \
> > + __ASUS_ATTR_RW(_attrname, current_value); \
> > +static struct kobj_attribute attr_##_attrname##_default_value =3D \
> > + __ASUS_ATTR_RO(_attrname, default_value); \
> > +static struct kobj_attribute attr_##_attrname##_min_value =3D \
> > + __ASUS_ATTR_RO(_attrname, min_value); \
> > +static struct kobj_attribute attr_##_attrname##_max_value =3D \
> > + __ASUS_ATTR_RO(_attrname, max_value); \
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
> >  /*
> >   * ROG PPT attributes need a little different in setup as they
> >   * require rog_tunables members.
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/li=
nux/platform_data/x86/asus-wmi.h
> > index 287206a03763..2e7509ab5be0 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -133,6 +133,10 @@
> >  /* dgpu on/off */
> >  #define ASUS_WMI_DEVID_DGPU 0x00090020
> > =20
> > +/* Intel E-core and P-core configuration in a format 0x0[E]0[P] */
> > +#define ASUS_WMI_DEVID_CORES 0x001200D2
> > + /* Maximum Intel E-core and P-core availability */
> > +#define ASUS_WMI_DEVID_CORES_MAX 0x001200D3
> >  #define ASUS_WMI_DEVID_DGPU_BASE_TGP 0x00120099
> >  #define ASUS_WMI_DEVID_DGPU_SET_TGP 0x00120098
> >  #define ASUS_WMI_DEVID_APU_MEM 0x000600C1
> >=20
>=20

