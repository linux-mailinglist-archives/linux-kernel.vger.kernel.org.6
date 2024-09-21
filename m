Return-Path: <linux-kernel+bounces-334767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C69397DBEB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99B81C20E0B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 07:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C314A627;
	Sat, 21 Sep 2024 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="YR8djK6V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jXu9cjPd"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5BC38F9C;
	Sat, 21 Sep 2024 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726902376; cv=none; b=AW0UfTDKvP1xUAB2L2pLmQq/FGm7Hi9PuP+6syFA9a1S9rgz5dJ7gqh5119lroRP8t6BGCnY8xolV/0tdTLihTV9J/e2hBqtpOJIcPAxFV8U/NwdBDYZrTCeqUsf22qFUi9IHek3OOdgcggKX1WWNhSFV7guqvWAOof0OfH85Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726902376; c=relaxed/simple;
	bh=ramb2qhLrohLzq60UAKObQ0PTdx2HPjIjoHZkhJQXus=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K31KuzNJ/Zt9RhrnbRGdFtngE3DH7O92VtdVXJ0EJfPDrbmtjUuLGmkDh4SOdpBrpOyuwj9/lw7eTOqinPt0Y/i9+BSvy2P6X1A+cY4P/ybX0xmOjYfPn2XIl9FOyb9R9rjgemAEHmDEToCATTMcQWT7nVPbxhRfdwrGGDEcz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=YR8djK6V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jXu9cjPd; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97639114023E;
	Sat, 21 Sep 2024 03:06:13 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Sat, 21 Sep 2024 03:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726902373;
	 x=1726988773; bh=iJq7jOMqB2xcllhohZepBUoFk070OqFqslKd8FqcMnE=; b=
	YR8djK6VjjIokpb3WajrDvj7CcyK8vuAPo8tnzyt0rQ46mrY9MULtcbGw8/mNihx
	yWH0Uo+qeFkFNXOdcxRtiLOtK9xYAyxsM55mHp3Df2UPzTKe+xXsQHTnST2p/3M4
	z24QKTwtzlh2//a7eNVxUsCqOrsK42EmZZHDHDgOVjoojzP4516NNiy1Qube54dJ
	V2kdhBy4kI6Nh7aicsWPkl37HGZPNWJWPpe0hc2z6XaC1YzGiNtwnaMJ67IUkzqt
	hSraY4QvYik+nDVaTWMIIJD9zE6UUW12dChAj0S02igo+MqiXQS6CuLpNHpqvyL7
	oTJ/nl9LLfOwmxq4mKV+nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1726902373; x=
	1726988773; bh=iJq7jOMqB2xcllhohZepBUoFk070OqFqslKd8FqcMnE=; b=j
	Xu9cjPdzYq/IfD5+DtJ8ogqoJ3aVisW1Sm9iCoiRI6u1CwTO+5TERV6rOdfHpBLD
	u4LKHUkulWx4rWC7HMvOw+9ylkU/jFfO9tg2Lg5wlOLrzZvl8V+LhQhSS/oxg7Sq
	rtKg4AkQa7VTw2xUsDcwEhVJB5wBsMjsAqpm36crldShmNyX+ILe9G86sM8RtD3x
	YlWesp9zp4G6oW6gyTrvR0tJvR319vNBUJrSGAZ/MGWXKZt/7arezshs7c4f/StF
	MZmBE2MZQ9HhnID1GPEtZti6SbTx40esJtBAMANqtCuVhG5PCz+APvGq/sbe79aJ
	4hG5HeMO+NuKKNidTy6BQ==
X-ME-Sender: <xms:ZXDuZtdNwlCLAXcR8dPayPgK8Jsm8UaoCMet0FhftpzGDH0w9WgTng>
    <xme:ZXDuZrNq1HBHHLFm2J-ROsMNYnBuLqhQ1FdZpjqO-SZYbpZkSeXP98hU0rhxMOaRw
    alQd2He5Gk_iYmJxO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelgedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfnuhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdrug
    gvvheqnecuggftrfgrthhtvghrnhepveefueefffdugfegtedtgeevledvfffhteeuvdel
    gffhheeffeffteetfedugfdtnecuffhomhgrihhnpehgihhthhhusgdrtghomhdprghsuh
    hsrggtphhirdgtshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhho
    segrmhgurdgtohhmpdhrtghpthhtoheptghorhgvnhhtihhnrdgthhgrrhihsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhn
    thgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZXDuZmiYsnCfzRQ_ipyELewPwXjn1Ru3DA_LmAV2w-qN8yw0HGwnIw>
    <xmx:ZXDuZm_Au2Wdu3c0swKqZ_mnqq_K4j2AkoU6GGJ3hkzxcwkf1vOoRg>
    <xmx:ZXDuZpttbOR-Qfe3633wAsg5a-8kMwf0aNYbaGKfzQzn9fdZIagXIA>
    <xmx:ZXDuZlGJbqJqvPo3OAbEmV-8H7QLU0DwPgWwbfG8jS603NPW-KP5FA>
    <xmx:ZXDuZjIbxpxNlgY6N8qdwXndgRkbdhKLGwXy1j7X6VNoxVEZEtamfqr5>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2E5B7336007C; Sat, 21 Sep 2024 03:06:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Sep 2024 19:05:52 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Mario Limonciello" <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 corentin.chary@gmail.com
Message-Id: <0bfdad31-943f-4398-825a-a9db8463d81d@app.fastmail.com>
In-Reply-To: <aaee2e99-d19b-466b-92fb-837093e574b0@amd.com>
References: <20240918094250.82430-1-luke@ljones.dev>
 <20240918094250.82430-4-luke@ljones.dev>
 <aaee2e99-d19b-466b-92fb-837093e574b0@amd.com>
Subject: Re: [PATCH v3 3/5] platform/x86: asus-armoury: add apu-mem control support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024, at 3:44 AM, Mario Limonciello wrote:
> On 9/18/2024 04:42, Luke D. Jones wrote:
> > Implement the APU memory size control under the asus-armoury module using
> > the fw_attributes class.
> > 
> > This allows the APU allocated memory size to be adjusted depending on
> > the users priority. A reboot is required after change.
> > 
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >   drivers/platform/x86/asus-armoury.c        | 114 +++++++++++++++++++++
> >   include/linux/platform_data/x86/asus-wmi.h |   1 +
> >   2 files changed, 115 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> > index 176ab5f105dd..b276c42f98d8 100644
> > --- a/drivers/platform/x86/asus-armoury.c
> > +++ b/drivers/platform/x86/asus-armoury.c
> > @@ -456,6 +456,119 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj
> >   WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
> >   ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
> >   
> > +/* Device memory available to APU */
> > +
> > +static ssize_t apu_mem_current_value_show(struct kobject *kobj, struct kobj_attribute *attr,
> > +   char *buf)
> > +{
> > + int err;
> > + u32 mem;
> > +
> > + err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_APU_MEM, &mem);
> > + if (err)
> > + return err;
> > +
> > + switch (mem) {
> > + case 256:
> > + mem = 0;
> > + break;
> > + case 258:
> > + mem = 1;
> > + break;
> > + case 259:
> > + mem = 2;
> > + break;
> > + case 260:
> > + mem = 3;
> > + break;
> > + case 261:
> > + mem = 4;
> > + break;
> > + case 262:
> > + /* This is out of order and looks wrong but is correct */
> > + mem = 8;
> > + break;
> > + case 263:
> > + mem = 5;
> > + break;
> > + case 264:
> > + mem = 6;
> > + break;
> > + case 265:
> > + mem = 7;
> > + break;
> > + default:
> > + mem = 4;
> > + break;
> > + }
> > +
> > + return sysfs_emit(buf, "%u\n", mem);
> > +}
> > +
> > +static ssize_t apu_mem_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
> > +    const char *buf, size_t count)
> > +{
> > + int result, err;
> > + u32 requested, mem;
> > +
> > + result = kstrtou32(buf, 10, &requested);
> > + if (result)
> > + return result;
> > +
> > + switch (requested) {
> > + case 0:
> > + mem = 0;
> > + break;
> > + case 1:
> > + mem = 258;
> > + break;
> > + case 2:
> > + mem = 259;
> > + break;
> > + case 3:
> > + mem = 260;
> > + break;
> > + case 4:
> > + mem = 261;
> > + break;
> > + case 5:
> > + mem = 263;
> > + break;
> > + case 6:
> > + mem = 264;
> > + break;
> > + case 7:
> > + mem = 265;
> > + break;
> > + case 8:
> > + /* This is out of order and looks wrong but is correct */
> > + mem = 262;
> > + break;
> > + default:
> > + return -EIO;
> > + }
> > +
> > + err = asus_wmi_set_devstate(ASUS_WMI_DEVID_APU_MEM, mem, &result);
> > + if (err) {
> > + pr_warn("Failed to set apu_mem: %d\n", err);
> > + return err;
> > + }
> > +
> > + pr_info("APU memory changed to %uGB, reboot required\n", requested);
> 
> This doesn't seem right.  If you requested "0", you just set APU memory 
> to 0GB?

Yep.. I know it seems wrong but it's true. GHelper on windows does the same thing https://github.com/seerge/g-helper/blob/ab08bd8ab45774b3e1961ddff69b6281a2f6e733/app/AsusACPI.cs#L666

> > + sysfs_notify(kobj, NULL, attr->attr.name);
> > +
> > + asus_set_reboot_and_signal_event();
> > +
> > + return count;
> > +}
> > +
> > +static ssize_t apu_mem_possible_values_show(struct kobject *kobj, struct kobj_attribute *attr,
> > +     char *buf)
> > +{
> > + return sysfs_emit(buf, "0;1;2;3;4;5;6;7;8\n");
> 
> What exactly is the unit for 0-8?  It's obviously not a a multiple of 
> base memory, is it a multiple of an adder?
> 
> Is this changing the VRAM allocation?  Like does 0 mean 256MB, 1 is 512 etc?

There is a log entry above that clarifying it but I thought I'd done the same here. Fixed now.
 
> > +}
> > +ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set the available system memory for the APU to use");
> > +
> >   /* Simple attribute creation */
> >   ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL, cpu_default,
> >          cpu_min, cpu_max, 1, "Set the CPU slow package limit");
> > @@ -511,6 +624,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
> >   { &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
> >   { &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
> >   { &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
> > + { &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
> >   
> >   { &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
> >   { &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> > index 86629e621c61..e1aeafdf05d5 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -136,6 +136,7 @@
> >   
> >   #define ASUS_WMI_DEVID_DGPU_BASE_TGP 0x00120099
> >   #define ASUS_WMI_DEVID_DGPU_SET_TGP 0x00120098
> > +#define ASUS_WMI_DEVID_APU_MEM 0x000600C1
> >   
> >   /* gpu mux switch, 0 = dGPU, 1 = Optimus */
> >   #define ASUS_WMI_DEVID_GPU_MUX 0x00090016
> 
> 

