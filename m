Return-Path: <linux-kernel+bounces-334766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC57597DBE9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 08:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D081DB21C99
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 06:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42B814A0AB;
	Sat, 21 Sep 2024 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="JfpeosUe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="izTsZILO"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E002291E;
	Sat, 21 Sep 2024 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726901850; cv=none; b=XrTkH6hOA12694oeyXDRFDenGj5z5zuZ4Ps7CFsupgS8/kME8Q212icasv8mBVuKJsUVtxIsdn/LG6OsJ1vLuvGz44/plevgJUVDPl/tBk2obYledPT+ocU3KZrAGbLObR0kRLhpmh/MzlCzEBIB6dJfuTfnMYC1NUd9xk3g8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726901850; c=relaxed/simple;
	bh=d6xSqJD57V30PA0cMWGCDbMMo0uutO3xu8BcOJYl0TM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MCM4NKq/ZvJ7Mllc6H4FW5dErcWpnMG43Ie8+VqK0j6eZdQ+z4fuKBp30yJWsjMmCOPIgmg6M9bZo8m+M/Rf7TPjtxr0tKGwVN/6u+nXcu21Mtfl3HWZIe6LBnr+FyyCHWcvuhHP5MyrV0W8YQ+SEGsPSSGRRqL+3iT8LlZwSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=JfpeosUe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=izTsZILO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8189D11402B8;
	Sat, 21 Sep 2024 02:57:27 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Sat, 21 Sep 2024 02:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726901847;
	 x=1726988247; bh=b4PkLrKtdfVeE2qEdGPaGsY65KbMwIpxkeq9VEsa+n4=; b=
	JfpeosUeZSuClXBLIADH42AJ1ZJVkxGLfiSvf7XppM92rn1QG27F79sQo29zIi07
	0vfO2+nmQyKrmdSJA7QWJp2U2vYSSYw3yKWiMtFG7oyzZ7yHbJ2Tnk56VAe4yTmA
	gMHQVORJ9b/yy+upyhF0xmyRK8TZ4DjucoABbZp9ceZBnDOTBR82KtIM4nLi/dsf
	f8YahNUIhE1+VgUtEQdNW6I6Fb5uRXFRnimNWmu4s+VoMdq1B2U7fFle/n4lr43P
	qI99/r5RnKCrdQ9pUbqyNYK78b7kQpoBwqDMgIx5+OKbnpzZ5yu4JGIT64Wh9Kiq
	95PPN7w1ozmR0vMCQXY6gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1726901847; x=
	1726988247; bh=b4PkLrKtdfVeE2qEdGPaGsY65KbMwIpxkeq9VEsa+n4=; b=i
	zTsZILO0MKrBcWdEwSTf5/3MJcEJPahO5LFI3vfakpWQuXBavJgUQjP0RLYRjW+R
	jwouXWtG11BNo3ebvblTcm7E7KppDekpje75PqqoIhrdvBq5g953MBp9ikp84GgB
	S5pzkObQvhs9XoJ0FRIpDlt/UFYmeOsR8hIG5W90IbSN6ANZBCrbku4uL0inEo6G
	3X4TvrRinr66njufAKuOiQyRB2+74E0u0fWTZTbaF4bcr6nT2znK3bmeHKfwHRdH
	wOXRvvoxM4LgxD2HhsqJAjOTqAPiE/HKLsCHd46jzPe56Lil+rv/Ny7AYLOI2QOP
	NQFScRwml3pqUb4Bg7ppA==
X-ME-Sender: <xms:Vm7uZpIkVwHqpwH50Iuw7BUI64RqD5ZYzAyISN46EraltIQFQBJVpg>
    <xme:Vm7uZlLag3eh05anAV569ayVPojCGF3MJpQAwPCN8sqSXRhPtoDHlONQROqP7Sngb
    PN209J9tiBEvUlK-fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelgedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfnuhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdrug
    gvvheqnecuggftrfgrthhtvghrnhepgfeiffehtdfghfettdeiuddtfeekvdejgfevhefh
    ffevtdfhjeelgeefffekvdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtih
    gvlhhlohesrghmugdrtghomhdprhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhies
    ghhmrghilhdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuh
    igrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Vm7uZhv5QbAStYUaMn0JvSJQ_EUrM7P5hR4ltAXZWtx8YMloI_7BQw>
    <xmx:Vm7uZqa-rKX8VOri8bFwLrzlGi-y_JeMGT7PSTCW_7R6O5JycWAk_w>
    <xmx:Vm7uZgYVIq9Z_nRKdL76lu_a3s64vJMq5_IQxufpEAy444Sv7MU5lg>
    <xmx:Vm7uZuDz1EYaf64FZrrCENEp47neOyhxBg84fRzeCYNE513Zi2YDmQ>
    <xmx:V27uZnUN8ZTeXBN89skpZWT-YcdmyJaSz0RUFH95vxIoAW2DvE7LktzN>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7DC85336007C; Sat, 21 Sep 2024 02:57:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Sep 2024 18:57:05 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Mario Limonciello" <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 corentin.chary@gmail.com
Message-Id: <ed329d93-8366-4506-8c96-58d8b328d3df@app.fastmail.com>
In-Reply-To: <bd5155ec-a90e-4f2c-8e56-da7a986fdc13@amd.com>
References: <20240918094250.82430-1-luke@ljones.dev>
 <20240918094250.82430-3-luke@ljones.dev>
 <bd5155ec-a90e-4f2c-8e56-da7a986fdc13@amd.com>
Subject: Re: [PATCH v3 2/5] platform/x86: asus-armoury: add dgpu tgp control
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024, at 3:39 AM, Mario Limonciello wrote:
> On 9/18/2024 04:42, Luke D. Jones wrote:
> > Implement the dgpu TGP control under the asus-armoury module using the
> > fw_attributes class.
> > 
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Ack

> > ---
> >   drivers/platform/x86/asus-armoury.c        | 21 +++++++++++++++++++++
> >   drivers/platform/x86/asus-armoury.h        | 18 ++++++++++++++++++
> >   include/linux/platform_data/x86/asus-wmi.h |  3 +++
> >   3 files changed, 42 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> > index 6e4507be0f05..176ab5f105dd 100644
> > --- a/drivers/platform/x86/asus-armoury.c
> > +++ b/drivers/platform/x86/asus-armoury.c
> > @@ -51,6 +51,9 @@
> >   #define NVIDIA_BOOST_MAX 25
> >   #define NVIDIA_TEMP_MIN 75
> >   #define NVIDIA_TEMP_MAX 87
> > +#define NVIDIA_POWER_MIN 0
> > +#define NVIDIA_POWER_MAX 70
> > +#define NVIDIA_POWER_DEFAULT 70
> >   
> >   /* Tunables provided by ASUS for gaming laptops */
> >   struct rog_tunables {
> > @@ -77,6 +80,11 @@ struct rog_tunables {
> >   u32 nv_temp_min;
> >   u32 nv_temp_max;
> >   u32 nv_temp_target;
> > +
> > + u32 dgpu_tgp_default;
> > + u32 dgpu_tgp_min;
> > + u32 dgpu_tgp_max;
> > + u32 dgpu_tgp;
> >   };
> >   
> >   static const struct class *fw_attr_class;
> > @@ -467,6 +475,12 @@ ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_D
> >   ATTR_GROUP_ROG_TUNABLE(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
> >          nv_temp_default, nv_boost_min, nv_temp_max, 1,
> >          "Set the Nvidia max thermal limit");
> > +ATTR_GROUP_ROG_TUNABLE(dgpu_tgp, "dgpu_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP, dgpu_tgp_default,
> > +        dgpu_tgp_min, dgpu_tgp_max, 1,
> > +        "Set the additional TGP on top of the base TGP");
> > +
> > +ATTR_GROUP_INT_VALUE_ONLY_RO(dgpu_base_tgp, "dgpu_base_tgp", ASUS_WMI_DEVID_DGPU_BASE_TGP,
> > +      "Read the base TGP value");
> >   
> >   ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
> >          "Show the current mode of charging");
> > @@ -495,6 +509,8 @@ static const struct asus_attr_group armoury_attr_groups[] = {
> >   { &ppt_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
> >   { &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
> >   { &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
> > + { &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
> > + { &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
> >   
> >   { &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
> >   { &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> > @@ -659,6 +675,11 @@ static void init_rog_tunables(struct rog_tunables *rog)
> >   rog->nv_temp_max = NVIDIA_TEMP_MIN;
> >   rog->nv_temp_max = NVIDIA_TEMP_MAX;
> >   rog->nv_temp_target = NVIDIA_TEMP_MIN;
> > +
> > + rog->dgpu_tgp_default = NVIDIA_POWER_DEFAULT;
> > + rog->dgpu_tgp_min = NVIDIA_POWER_MIN;
> > + rog->dgpu_tgp_max = NVIDIA_POWER_MAX;
> > + rog->dgpu_tgp = NVIDIA_POWER_MAX;
> >   }
> >   
> >   static int __init asus_fw_init(void)
> > diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
> > index 8bb75cf88305..95f4b6d8ab6b 100644
> > --- a/drivers/platform/x86/asus-armoury.h
> > +++ b/drivers/platform/x86/asus-armoury.h
> > @@ -89,6 +89,20 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
> >   static struct kobj_attribute attr_##_attrname##_##_prop =             \
> >   __ASUS_ATTR_RO(_attrname, _prop)
> >   
> > +/* Requires current_value_show */
> > +#define __ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname)     \
> > + __ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);   \
> > + static struct kobj_attribute attr_##_attrname##_type =         \
> > + __ASUS_ATTR_RO_AS(type, int_type_show);                \
> > + static struct attribute *_attrname##_attrs[] = {               \
> > + &attr_##_attrname##_current_value.attr,                \
> > + &attr_##_attrname##_display_name.attr,                 \
> > + &attr_##_attrname##_type.attr, NULL                    \
> > + };                                                             \
> > + static const struct attribute_group _attrname##_attr_group = { \
> > + .name = _fsname, .attrs = _attrname##_attrs            \
> > + }
> > +
> >   /* Boolean style enumeration, base macro. Requires adding show/store */
> >   #define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)     \
> >   __ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);    \
> > @@ -105,6 +119,10 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
> >   .name = _fsname, .attrs = _attrname##_attrs             \
> >   }
> >   
> > +#define ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname) \
> > + __ATTR_CURRENT_INT_RO(_attrname, _wmi);                           \
> > + __ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname)
> > +
> >   #define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname) \
> >   __ATTR_CURRENT_INT_RO(_attrname, _wmi);                 \
> >   __ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> > index 7caf2c7ed8c9..86629e621c61 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -134,6 +134,9 @@
> >   /* dgpu on/off */
> >   #define ASUS_WMI_DEVID_DGPU 0x00090020
> >   
> > +#define ASUS_WMI_DEVID_DGPU_BASE_TGP 0x00120099
> > +#define ASUS_WMI_DEVID_DGPU_SET_TGP 0x00120098
> > +
> >   /* gpu mux switch, 0 = dGPU, 1 = Optimus */
> >   #define ASUS_WMI_DEVID_GPU_MUX 0x00090016
> >   #define ASUS_WMI_DEVID_GPU_MUX_VIVO 0x00090026
> 
> 

