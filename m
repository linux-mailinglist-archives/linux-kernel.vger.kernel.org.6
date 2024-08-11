Return-Path: <linux-kernel+bounces-282199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AE594E0C0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B59281AE4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903A138F83;
	Sun, 11 Aug 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="kLIU7V8V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A35zXmMD"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227BEAC5;
	Sun, 11 Aug 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723370727; cv=none; b=EE5giDQCrvkccPIutFtkG6fttCV/YHZjIrofAkE//rlMyyoeJ6BLGG6cjQ3xVmJMTuz8dKHEgZpFT3/mI8fQ9n4nK1dnTf2O85aDh8++MVZjc8bKGGAswOIS70CsnHxnAn7t5mqZNtjEq4xEj2kGpU8bZdaxp9unkd5zgLXA9OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723370727; c=relaxed/simple;
	bh=mnz5Q70LOlhR0/1ZLloKHuqLfXk0Hif2LBCr1neXKN0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FGRw6cL3Q9bkIDY7QI3YWJgNwpYhopW3BQrOrbRYfPjvuoQklBxhAfTGpagqxKhHzuub202IwRPQXA3TtnOu5hhwpvRcN17Fu+GyqxnuGYLDMUwxwujSF7SqcMULB490UQuJo50i0x93S74dOxf7DIKF2Ij+yFaNRIA4eD+u5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=kLIU7V8V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A35zXmMD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 85433138E2D9;
	Sun, 11 Aug 2024 06:05:23 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute3.internal (MEProxy); Sun, 11 Aug 2024 06:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723370723;
	 x=1723457123; bh=0mVZIZhoar6E7782MeC6bItbYRK/jNx8nzQ2jH4NWbY=; b=
	kLIU7V8V227jWmu1nKcHHJcoBXeLXg5oqbE4V93bk/kbikgPHWwNPxWvYgUnlwFD
	X55b+imieACvaT/BmgitDocFH7Lf/lPTBXJ6c/E18w/R0EIWamvZ6aOQ9kO+4j/R
	NBsdhu29mmjh7wrASML97HeRB9aaIv6KOLflQaLj/kLxC/bGXo3qowjfskTC4/pz
	cGREnnX8aijPzBQY+LeoymMTgFG08v3YYJE2j+VQ+RJR2NwZozwDRMJIWBtT0zNc
	ixcy0+9V7e9w+6VRYPJ+7lcr42VHd5KxfWsl8kOpskdxpGb8gmdhhbRO2G1ikjVm
	qU7yLbab+FlhS3WZuMqLoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723370723; x=
	1723457123; bh=0mVZIZhoar6E7782MeC6bItbYRK/jNx8nzQ2jH4NWbY=; b=A
	35zXmMDlCc7yXxnpIbW5FfcD9wdYDiSQAZRb8z+jmyzc9lRbBFCOYAEVXoNhrYsP
	vzyD1xvKlyv8BL8g3ZwJGS4XdVBcPSnLKLOfSGHDOGcbfaSVeN5b1mS2VpL3pBQa
	la4APfGR4o+nEVkjsp9qbFCtdx2BI8Y1UDxzAYmqQWj5NA8fYM4fIGQZbt2z8UNK
	sxDeLIOd2X4IGAvkmL6ZUNTlopOL6qt1tUbYAv4d4cGaFxmDQd8hu8bbelzQQMV3
	1bVrS9Yzje49+ZcHHFVS77mNViEaA+Zn2tcVJLLxdmXR6nGN4aIk1RQsBbnlJTCJ
	Eezl7ReiKyD4t/Xar62oQ==
X-ME-Sender: <xms:44y4Zra3LzUr2V0pHOQ9XcyUOQJCxSeDPHAi0mD3dciAFJIvhDt_JA>
    <xme:44y4ZqbYHPzk6ITtWCH6EPBfTaU703glhqxrweI1lqsFHpLpWxtdogggYl6BMuaKq
    EjBM-Fw8yHzbHFMDV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleekgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfnuhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvh
    eqnecuggftrfgrthhtvghrnhepudfhudekteffleejgfffledvteelgeekfeefgeekiedt
    feevvdekffehgeffudetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhn
    vghsrdguvghvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdrtghomhdprhgtphhtthho
    pehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehplhgrth
    hfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:44y4Zt-6VecH5W3d8nbf4qpSCePe2o5WVc9rwHfIDGGLZufV9rowWA>
    <xmx:44y4ZhpX3HE5BKTnm_lgOlYDx_TT_xhNr5rRZTGdLkK6si943CwtPg>
    <xmx:44y4Zmo2ToUQJTS4cFZImjh1c8IbBiOpFNDLFJN1exDU8Cyn0HQldQ>
    <xmx:44y4ZnQDz53Sqxak0yfiz7mu3k_A_TGrFgK3c_uhqdj0-C0E3v90IA>
    <xmx:44y4ZpXjQFwniqmMRXD0mIltsT01GCh1eEGRkBxobGsn2yFGgQ622gkp>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 504682340082; Sun, 11 Aug 2024 06:05:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 11 Aug 2024 22:05:03 +1200
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com
Message-Id: <d3577748-14b6-4aa4-9f51-069ae9ccff49@app.fastmail.com>
In-Reply-To: <c7080912-7772-96df-0ae0-07903edbba1a@linux.intel.com>
References: <20240806020747.365042-1-luke@ljones.dev>
 <20240806020747.365042-5-luke@ljones.dev>
 <c7080912-7772-96df-0ae0-07903edbba1a@linux.intel.com>
Subject: Re: [PATCH v2 4/6] platform/x86: asus-armoury: add apu-mem control support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Aug 2024, at 10:20 PM, Ilpo J=C3=A4rvinen wrote:
> On Tue, 6 Aug 2024, Luke D. Jones wrote:
>=20
> > Implement the APU memory size control under the asus-armoury module =
using
> > the fw_attributes class.
> >=20
> > This allows the APU allocated memory size to be adjusted depending on
> > the users priority. A reboot is required after change.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  drivers/platform/x86/asus-armoury.c        | 115 ++++++++++++++++++=
+++
> >  include/linux/platform_data/x86/asus-wmi.h |   1 +
> >  2 files changed, 116 insertions(+)
> >=20
> > diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/=
x86/asus-armoury.c
> > index 31dbdacd8978..412e75c652a4 100644
> > --- a/drivers/platform/x86/asus-armoury.c
> > +++ b/drivers/platform/x86/asus-armoury.c
> > @@ -462,6 +462,120 @@ static ssize_t egpu_enable_current_value_store=
(struct kobject *kobj,
> >  WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU=
);
> >  ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU=
 (also disables dGPU)");
> > =20
> > +/* Device memory available to APU */
> > +
> > +static ssize_t apu_mem_current_value_show(struct kobject *kobj,
> > + struct kobj_attribute *attr, char *buf)
> > +{
> > + int err;
> > + u32 mem;
> > +
> > + err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_APU_MEM, &mem);
> > + if (err)
> > + return err;
> > +
> > + switch (mem) {
> > + case 256:
> > + mem =3D 0;
> > + break;
> > + case 258:
> > + mem =3D 1;
> > + break;
> > + case 259:
> > + mem =3D 2;
> > + break;
> > + case 260:
> > + mem =3D 3;
> > + break;
> > + case 261:
> > + mem =3D 4;
> > + break;
> > + case 262:
> > + /* This is out of order and looks wrong but is correct */
> > + mem =3D 8;
> > + break;
> > + case 263:
> > + mem =3D 5;
> > + break;
> > + case 264:
> > + mem =3D 6;
> > + break;
> > + case 265:
> > + mem =3D 7;
> > + break;
> > + default:
> > + mem =3D 4;
> > + break;
> > + }
> > +
> > + return sysfs_emit(buf, "%d\n", mem);
>=20
> %u
>=20
> > +}
> > +
> > +static ssize_t apu_mem_current_value_store(struct kobject *kobj,
> > + struct kobj_attribute *attr,
> > + const char *buf, size_t count)
> > +{
> > + int result, err;
> > + u32 requested, mem;
> > +
> > + result =3D kstrtou32(buf, 10, &requested);
> > + if (result)
> > + return result;
> > +
> > + switch (requested) {
> > + case 0:
> > + mem =3D 0;
> > + break;
> > + case 1:
> > + mem =3D 258;
> > + break;
> > + case 2:
> > + mem =3D 259;
> > + break;
> > + case 3:
> > + mem =3D 260;
> > + break;
> > + case 4:
> > + mem =3D 261;
> > + break;
> > + case 5:
> > + mem =3D 263;
> > + break;
> > + case 6:
> > + mem =3D 264;
> > + break;
> > + case 7:
> > + mem =3D 265;
> > + break;
> > + case 8:
> > + /* This is outof order and looks wrong but is correct */
>=20
> outof -> out of
>=20
> > + mem =3D 262;
> > + break;
> > + default:
> > + return -EIO;
> > + }
> > +
> > + err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_APU_MEM, mem, &result=
);
> > + if (err) {
> > + pr_warn("Failed to set apu_mem: %d\n", err);
> > + return err;
> > + }
> > +
> > + pr_info("APU memory changed to %dGB, reboot required\n", requested=
);
>=20
> %u
>=20
> > + sysfs_notify(kobj, NULL, attr->attr.name);
> > +
> > + asus_set_reboot_and_signal_event();
> > +
> > + return count;
> > +}
> > +
> > +static ssize_t apu_mem_possible_values_show(struct kobject *kobj,
> > + struct kobj_attribute *attr, char *buf)
> > +{
> > + return sysfs_emit(buf, "0;1;2;3;4;5;6;7;8\n");

Ack all

> IIRC, space or newline is the usual separator for possible values sysf=
s=20
> files. I don't think I've ever seen ; used.

The docs specify this format. https://github.com/torvalds/linux/blob/518=
9dafa4cf950e675f02ee04b577dfbbad0d9b1/Documentation/ABI/testing/sysfs-cl=
ass-firmware-attributes#L56

Thanks,
Luke.

> --=20
> i.
>=20
> > +}
> > +ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set the available syste=
m memory for the APU to use");
> > +
> >  /* Simple attribute creation */
> >  ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_P=
PT_PL1_SPL, cpu_default,
> >         cpu_min, cpu_max, 1, "Set the CPU slow package limit");
> > @@ -516,6 +630,7 @@ static const struct asus_attr_group armoury_attr=
_groups[] =3D {
> >  { &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
> >  { &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
> >  { &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
> > + { &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
> > =20
> >  { &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
> >  { &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/li=
nux/platform_data/x86/asus-wmi.h
> > index 3ce0c63be4c1..287206a03763 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -135,6 +135,7 @@
> > =20
> >  #define ASUS_WMI_DEVID_DGPU_BASE_TGP 0x00120099
> >  #define ASUS_WMI_DEVID_DGPU_SET_TGP 0x00120098
> > +#define ASUS_WMI_DEVID_APU_MEM 0x000600C1
> > =20
> >  /* gpu mux switch, 0 =3D dGPU, 1 =3D Optimus */
> >  #define ASUS_WMI_DEVID_GPU_MUX 0x00090016
> >=20
>=20

