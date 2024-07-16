Return-Path: <linux-kernel+bounces-253569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF9793232E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6131C22408
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A811619885E;
	Tue, 16 Jul 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="qMWPVyJB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YS6NLckb"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05932195F3B;
	Tue, 16 Jul 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123008; cv=none; b=qZev23YWsdFj42xcU7FZi8Do49JgBL5DuIyjFxOID1o2NloLqSm8tTB6SgxJE1jhD1OEBfo4fZO1R6ayNi9EeiB6qOsaF1RkTRwqrE74raGGAe2H4MPPZuBTopfDXDurc9F5aCaWWNOVtBkdVhj88+yfnhT6L6I8+V2QUidVC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123008; c=relaxed/simple;
	bh=skYLDFtBghJVC6KB62SqjUewVTSr7MQR70nizqJd5PM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=c4m0bbFGjRY7KEY+DVbtj8BojbD+LJnWlfSlcUxF1D/N8hM0IOjr/JfCDgJlKrYpOUPynfPvfrmOGtQLREs+WDMtajW2ZNRH6ZjjHJQFuGDfmaviX4Js7Ob/RmVZJYnTdgHF3f7ojT7gBfaupw4KUCsel6D8xDISQpyaa1Wtt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=qMWPVyJB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YS6NLckb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1A45F114831E;
	Tue, 16 Jul 2024 05:43:25 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Tue, 16 Jul 2024 05:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1721123005; x=1721209405; bh=iLoWkcpaT/
	UAyfiMoq8a2cS0fa2nlyJGia5lNxfcWJA=; b=qMWPVyJBcS3b1RI0/Or7y6o4Pr
	togPSDKBCkYtyTY1h5urfLvYHMPvuScv99eoTlB7PtgMRrb/WU2PSi2f7VFtyIUS
	L3mlY8O2I099P/h6EvbfPFJlX7DNsk2Gt6HON1PCZxzGhChr4/dqgV26Z9wJPYrR
	A4rqRUX+ohonNc1KWHoJtLf81FQLY7pKDkjEXIyl9mjxASwvWrRel32mZVlAfbIv
	XIU9+W/TcoObcKjBRCx7wBu7I8fGf1m9ZBirCpX6yeyc+OcDj8K4DOaa8HaDWfaW
	NEZG6eFlrfbWVq05vf+LZJgjBTTObHseZD5aOYxtPsozjP70VIbpnZqNXh/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721123005; x=1721209405; bh=iLoWkcpaT/UAyfiMoq8a2cS0fa2n
	lyJGia5lNxfcWJA=; b=YS6NLckbEqiW/Puk6EmEkmYVQpkBLNemx62q91TnrgpQ
	yfZZNEopJfGjyu8hW6WqFUntS92XCjI8WZo+H9j3ObTKW5EglNMmQr8Ejipfhtzf
	MvmM1A0k3bZW/zuJypxyp69k1XcmWVt+Gs1gPCXLxUJYE/W0bSnxJ56Ydmzaaq/u
	9wjFdnbxbV781QMFI/I7FBRWZ5SaRAp7/JLakJpj068SJ+fJF4nHlUfOqet0SEc+
	YGVzkaNmxRL82Q5ElofvoO0KTU9LuxLObZ57o+/bY1eJ8iD6IrCBPtnTn+VhornW
	Xargsl0C0ykcb5qeCG9VMVHt6d4u0dj/qNeza9mAcA==
X-ME-Sender: <xms:u0CWZm8L8psmNr9xO5FWBcMQpc9MMib8Z_jyf-hFs9iwlOrv16kQxw>
    <xme:u0CWZmu0nvBdy3Cw34m7Wm1WcwvNR4JTNCrpG1Tcb92q5qmfvpWC32xsGj2tvtgQs
    9zSfix9z-knZvJ-X50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfnuhhk
    vgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvg
    hrnhepuddtlefgvdegkeeuueetveffleefudekieetudfgvddtuedtteejudduuedvgefg
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheplhhukh
    gvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:vECWZsBLrx3YZjWOQ247GxN8Xm4l1dlm5rYLTAf_8mW4J4BH2_JJ-w>
    <xmx:vECWZucslbte6dJvP4IP3sK3Sje6zbLPCXkwFbEZ2JB9md_tbuUWyA>
    <xmx:vECWZrNsE9g5HgopsKae5LIQKl86vkA2S8TPbElJ05dGydubPiVP8g>
    <xmx:vECWZom22GNlqgnmGXGLPaLrXIGgrDFgxk7KyRhiP5_nkRcPfaRMgg>
    <xmx:vUCWZgrvG4ZR6twznle5yTy4zLRZurG9mzKBvnoLB5jx4oEIQqXApyWi>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E07B52340080; Tue, 16 Jul 2024 05:43:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c301ba1a-99f9-41b4-9742-1eb52288bf61@app.fastmail.com>
In-Reply-To: <5052fc56-211b-455b-81fb-255b02da356c@app.fastmail.com>
References: <20240716051612.64842-1-luke@ljones.dev>
 <20240716051612.64842-5-luke@ljones.dev>
 <078a4a2d-c8ff-4039-b84f-b014055a4368@redhat.com>
 <5052fc56-211b-455b-81fb-255b02da356c@app.fastmail.com>
Date: Tue, 16 Jul 2024 21:43:03 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Hans de Goede" <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Mario Limonciello" <mario.limonciello@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] platform/x86: asus-bios: add core count control
Content-Type: text/plain



On Tue, 16 Jul 2024, at 9:41 PM, Luke Jones wrote:
> 
> 
> On Tue, 16 Jul 2024, at 9:25 PM, Hans de Goede wrote:
> > Hi,
> > 
> > On 7/16/24 7:16 AM, Luke D. Jones wrote:
> > > Implement Intel core enablement under the asus-bioscfg module using the
> > > fw_attributes class.
> > > 
> > > This allows users to enable or disable preformance or efficiency cores
> > > depending on their requirements. After change a reboot is required.
> > 
> > Not a full revieew, just a quick remark. You say this this
> > requires a reboot, but this patch does not update asus_bios_requires_reboot()
> > 
> 
> Thanks for catching that!

Huh.. Okay looks like asus_bios_requires_reboot() got screwed up with the rebase editing I've done. The return statement is followed by a line that will never ge run too.

> 
> > 
> > 
> > > 
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > ---
> > >  drivers/platform/x86/asus-bioscfg.c        | 206 +++++++++++++++++++++
> > >  drivers/platform/x86/asus-bioscfg.h        |  29 +++
> > >  include/linux/platform_data/x86/asus-wmi.h |   4 +
> > >  3 files changed, 239 insertions(+)
> > > 
> > > diff --git a/drivers/platform/x86/asus-bioscfg.c b/drivers/platform/x86/asus-bioscfg.c
> > > index 57efe50e0d19..6d39e45591e8 100644
> > > --- a/drivers/platform/x86/asus-bioscfg.c
> > > +++ b/drivers/platform/x86/asus-bioscfg.c
> > > @@ -41,6 +41,18 @@ MODULE_ALIAS("wmi:"ASUS_NB_WMI_EVENT_GUID);
> > >  #define ASUS_MINI_LED_2024_STRONG 0x01
> > >  #define ASUS_MINI_LED_2024_OFF 0x02
> > >  
> > > +enum cpu_core_type {
> > > + CPU_CORE_PERF = 0,
> > > + CPU_CORE_POWER,
> > > +};
> > > +
> > > +enum cpu_core_value {
> > > + CPU_CORE_DEFAULT = 0,
> > > + CPU_CORE_MIN,
> > > + CPU_CORE_MAX,
> > > + CPU_CORE_CURRENT,
> > > +};
> > > +
> > >  /* Default limits for tunables available on ASUS ROG laptops */
> > >  #define PPT_CPU_LIMIT_MIN 5
> > >  #define PPT_CPU_LIMIT_MAX 150
> > > @@ -75,6 +87,10 @@ struct rog_tunables {
> > >  u32 nv_temp_default;
> > >  u32 nv_temp_max;
> > >  u32 nv_temp_target;
> > > +
> > > + u32 min_perf_cores;
> > > + u32 max_perf_cores;
> > > + u32 max_power_cores;
> > >  };
> > >  
> > >  static const struct class *fw_attr_class;
> > > @@ -540,6 +556,191 @@ static ssize_t apu_mem_possible_values_show(struct kobject *kobj,
> > >  }
> > >  ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set the available system memory for the APU to use");
> > >  
> > > +static int asus_bios_set_max_cores(void)
> > > +{
> > > + u32 cores;
> > > + int err;
> > > +
> > > + asus_bios.rog_tunables->min_perf_cores = 4;
> > > + asus_bios.rog_tunables->max_perf_cores = 4;
> > > + asus_bios.rog_tunables->max_power_cores = 8;
> > > +
> > > + err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES_MAX, &cores);
> > > + if (err)
> > > + return err;
> > > +
> > > + cores &= ~ASUS_WMI_DSTS_PRESENCE_BIT;
> > > + asus_bios.rog_tunables->max_power_cores = (cores & 0xff00) >> 8;
> > > + asus_bios.rog_tunables->max_perf_cores = cores & 0xff;
> > > +
> > > + return 0;
> > > +}
> > > +
> > > +static ssize_t cores_value_show(struct kobject *kobj,
> > > + struct kobj_attribute *attr, char *buf,
> > > + enum cpu_core_type core_type,
> > > + enum cpu_core_value core_value)
> > > +{
> > > + u32 cores;
> > > + int err;
> > > +
> > > + switch (core_value) {
> > > + case CPU_CORE_DEFAULT:
> > > + case CPU_CORE_MAX:
> > > + if (core_type == CPU_CORE_PERF)
> > > + return sysfs_emit(buf, "%d\n", asus_bios.rog_tunables->max_perf_cores);
> > > + else
> > > + return sysfs_emit(buf, "%d\n", asus_bios.rog_tunables->max_power_cores);
> > > + case CPU_CORE_MIN:
> > > + if (core_type == CPU_CORE_PERF)
> > > + return sysfs_emit(buf, "%d\n", asus_bios.rog_tunables->min_perf_cores);
> > > + else
> > > + return sysfs_emit(buf, "%d\n", 0);
> > > + default:
> > > + break;
> > > + }
> > > +
> > > + err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES, &cores);
> > > + if (err)
> > > + return err;
> > > +
> > > + cores &= ~ASUS_WMI_DSTS_PRESENCE_BIT;
> > > + if (core_type == CPU_CORE_PERF)
> > > + cores &= 0xff;
> > > + else
> > > + cores = (cores & 0xff00) >> 8;
> > > + return sysfs_emit(buf, "%d\n", cores);
> > > +}
> > > +
> > > +static ssize_t cores_current_value_store(struct kobject *kobj,
> > > + struct kobj_attribute *attr, const char *buf,
> > > + enum cpu_core_type core_type)
> > > +{
> > > + int result, err;
> > > + u32 cores, currentv, min, max;
> > > +
> > > + result = kstrtou32(buf, 10, &cores);
> > > + if (result)
> > > + return result;
> > > +
> > > + if (core_type == CPU_CORE_PERF) {
> > > + min = asus_bios.rog_tunables->min_perf_cores;
> > > + max = asus_bios.rog_tunables->max_perf_cores;
> > > + } else {
> > > + min = 0;
> > > + max = asus_bios.rog_tunables->max_power_cores;
> > > + }
> > > + if (cores < min || cores > max)
> > > + return -EINVAL;
> > > +
> > > + err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES, &currentv);
> > > + if (err)
> > > + return err;
> > > +
> > > + if (core_type == CPU_CORE_PERF)
> > > + cores |= (currentv & 0xff00);
> > > + else
> > > + cores |= currentv & 0xff;
> > > +
> > > + if (cores == currentv)
> > > + return 0;
> > > +
> > > + err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CORES, cores, &result);
> > > + if (err) {
> > > + pr_warn("Failed to set perfromance core count: %d\n", err);
> > > + return err;
> > > + }
> > > +
> > > + if (result > 1) {
> > > + pr_warn("Failed to set performance core count (result): 0x%x\n", result);
> > > + return -EIO;
> > > + }
> > > +
> > > + pr_info("CPU core count changed, reboot required\n");
> > > + sysfs_notify(kobj, NULL, attr->attr.name);
> > > + asus_set_reboot_and_signal_event();
> > > +
> > > + return 0;
> > > +}
> > > +
> > > +static ssize_t cores_performance_min_value_show(struct kobject *kobj,
> > > + struct kobj_attribute *attr, char *buf)
> > > +{
> > > + return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_MIN);
> > > +}
> > > +
> > > +static ssize_t cores_performance_max_value_show(struct kobject *kobj,
> > > + struct kobj_attribute *attr, char *buf)
> > > +{
> > > + return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_MAX);
> > > +}
> > > +
> > > +static ssize_t cores_performance_default_value_show(struct kobject *kobj,
> > > + struct kobj_attribute *attr, char *buf)
> > > +{
> > > + return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_DEFAULT);
> > > +}
> > > +
> > > +static ssize_t cores_performance_current_value_show(struct kobject *kobj,
> > > + struct kobj_attribute *attr, char *buf)
> > > +{
> > > + return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_CURRENT);
> > > +}
> > > +
> > > +static ssize_t cores_performance_current_value_store(struct kobject *kobj,
> > > + struct kobj_attribute *attr,
> > > + const char *buf, size_t count)
> > > +{
> > > + int err;
> > > +
> > > + err = cores_current_value_store(kobj, attr, buf, CPU_CORE_PERF);
> > > + if (err)
> > > + return err;
> > > +
> > > + return count;
> > > +}
> > > +ATTR_GROUP_CORES_RW(cores_performance, "cores_performance", ASUS_WMI_DEVID_CORES,
> > > + "Set the max available performance cores");
> > > +
> > > +static ssize_t cores_efficiency_min_value_show(struct kobject *kobj,
> > > + struct kobj_attribute *attr, char *buf)
> > > +{
> > > + return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_MIN);
> > > +}
> > > +
> > > +static ssize_t cores_efficiency_max_value_show(struct kobject *kobj,
> > > + struct kobj_attribute *attr, char *buf)
> > > +{
> > > + return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_MAX);
> > > +}
> > > +
> > > +static ssize_t cores_efficiency_default_value_show(struct kobject *kobj,
> > > + struct kobj_attribute *attr, char *buf)
> > > +{
> > > + return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_DEFAULT);
> > > +}
> > > +
> > > +static ssize_t cores_efficiency_current_value_show(struct kobject *kobj,
> > > + struct kobj_attribute *attr, char *buf)
> > > +{
> > > + return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_CURRENT);
> > > +}
> > > +
> > > +static ssize_t cores_efficiency_current_value_store(struct kobject *kobj,
> > > + struct kobj_attribute *attr,
> > > + const char *buf, size_t count)
> > > +{
> > > + int err;
> > > +
> > > + err = cores_current_value_store(kobj, attr, buf, CPU_CORE_POWER);
> > > + if (err)
> > > + return err;
> > > +
> > > + return count;
> > > +}
> > > +ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency", ASUS_WMI_DEVID_CORES,
> > > + "Set the max available efficiency cores");
> > > +
> > >  /* Simple attribute creation */
> > >  ATTR_GROUP_ENUM_INT_RW(thermal_policy, "thermal_policy", ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> > >  0, 3, "0;1;2", "Set the thermal profile: 0=normal, 1=performance, 2=quiet");
> > > @@ -636,6 +837,11 @@ static int asus_fw_attr_add(void)
> > >  if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU_CONNECTED))
> > >  sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &egpu_connected_attr_group);
> > >  
> > > + if (asus_wmi_is_present(ASUS_WMI_DEVID_CORES_MAX) && !asus_bios_set_max_cores()) {
> > > + sysfs_create_group(&asus_bios.fw_attr_kset->kobj, &cores_performance_attr_group);
> > > + sysfs_create_group(&asus_bios.fw_attr_kset->kobj, &cores_efficiency_attr_group);
> > > + }
> > > +
> > >  if (asus_wmi_is_present(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
> > >  sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &thermal_policy_attr_group);
> > >  if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PL1_SPL))
> > > diff --git a/drivers/platform/x86/asus-bioscfg.h b/drivers/platform/x86/asus-bioscfg.h
> > > index 2da55a91ff0b..bae1976eda3f 100644
> > > --- a/drivers/platform/x86/asus-bioscfg.h
> > > +++ b/drivers/platform/x86/asus-bioscfg.h
> > > @@ -244,6 +244,35 @@ static const struct attribute_group _attrname##_attr_group = { \
> > >  .attrs = _attrname##_attrs \
> > >  }
> > >  
> > > +/* CPU core attributes need a little different in setup */
> > > +#define ATTR_GROUP_CORES_RW(_attrname, _fsname, _dispname) \
> > > +__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", 1); \
> > > +__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname); \
> > > +static struct kobj_attribute attr_##_attrname##_current_value = \
> > > + __ASUS_ATTR_RW(_attrname, current_value); \
> > > +static struct kobj_attribute attr_##_attrname##_default_value = \
> > > + __ASUS_ATTR_RO(_attrname, default_value); \
> > > +static struct kobj_attribute attr_##_attrname##_min_value = \
> > > + __ASUS_ATTR_RO(_attrname, min_value); \
> > > +static struct kobj_attribute attr_##_attrname##_max_value = \
> > > + __ASUS_ATTR_RO(_attrname, max_value); \
> > > +static struct kobj_attribute attr_##_attrname##_type = \
> > > + __ASUS_ATTR_RO_AS(type, int_type_show); \
> > > +static struct attribute *_attrname##_attrs[] = { \
> > > + &attr_##_attrname##_current_value.attr, \
> > > + &attr_##_attrname##_default_value.attr, \
> > > + &attr_##_attrname##_min_value.attr, \
> > > + &attr_##_attrname##_max_value.attr, \
> > > + &attr_##_attrname##_scalar_increment.attr, \
> > > + &attr_##_attrname##_display_name.attr, \
> > > + &attr_##_attrname##_type.attr, \
> > > + NULL \
> > > +}; \
> > > +static const struct attribute_group _attrname##_attr_group = { \
> > > + .name = _fsname, \
> > > + .attrs = _attrname##_attrs \
> > > +}
> > > +
> > >  /* ROG PPT attributes need a little different in setup */
> > >  #define ATTR_GROUP_PPT_RW(_attrname, _fsname, _wmi, _default, \
> > >  _min, _max, _incstep, _dispname) \
> > > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> > > index e3d511918416..d8f713ed3ea3 100644
> > > --- a/include/linux/platform_data/x86/asus-wmi.h
> > > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > > @@ -128,6 +128,10 @@
> > >  /* dgpu on/off */
> > >  #define ASUS_WMI_DEVID_DGPU 0x00090020
> > >  
> > > +/* Intel E-core and P-core configuration in a format 0x0[E]0[P] */
> > > +#define ASUS_WMI_DEVID_CORES 0x001200D2
> > > + /* Maximum Intel E-core and P-core availability */
> > > +#define ASUS_WMI_DEVID_CORES_MAX 0x001200D3
> > >  #define ASUS_WMI_DEVID_DGPU_BASE_TGP 0x00120099
> > >  #define ASUS_WMI_DEVID_DGPU_SET_TGP 0x00120098
> > >  #define ASUS_WMI_DEVID_APU_MEM 0x000600C1
> > 
> > 

