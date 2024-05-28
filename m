Return-Path: <linux-kernel+bounces-193100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE2F8D26CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48691F218A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5636B17B4EB;
	Tue, 28 May 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="U7ORo8WJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h0azVv8S"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B551802DB;
	Tue, 28 May 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930495; cv=none; b=GwkzzOVAC39HsPygBCG1Ht78czRXFFQ9RDZOHtvTjFG70PRH4zfPwE3kbYQuxNhifk/9mY0Fbsm3QFUlA4D6smBSDiymEizfe0uNMFVCNYnyRI41l/yoFVsXmn5JQos9Z0optBG2X6pMY+ixSdAtRRmmKy4LClkxIkvuYUZ5kUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930495; c=relaxed/simple;
	bh=WwlSHp73GWxFCSZh32w7K5y9ojQ9lghuxJzr9X2rk1k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=W8e66b0vMeeVYfF9E5zrt/miqJRUiDTXA+//n9J+IafBnN9ncoq/dDqguISFBQQL5P1IbqSv0XIWumkWQWjrzoGV6/3rP4DqqlpgyBCdATsHkaVvl2pPiVC/GHmniVreyBFvIqOc2WFyBsh06nbjAMm6KmZnSLcydCOMVTBdFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=U7ORo8WJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h0azVv8S; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 4234A1C0012A;
	Tue, 28 May 2024 17:08:12 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Tue, 28 May 2024 17:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1716930491; x=1717016891; bh=Tw0Md652eL
	cdfBVfRxR5aYzBHh4vFiLjMRfFI3sLkTM=; b=U7ORo8WJPslFbXdpcew/hpDeUN
	tUambX69+49DVpPQweAvvUEnpRFjL698YN4Dn6r00IVbz5bVUtUd5ysVsg6hONn9
	jx24MdmV+I1WsIGy/cfI2pCz+mU9D4NjjI4fsYjB2P7OnQMLhFp3ZLmwZEaCmYN3
	A2qAs6eeCqvxf25CZre75A7/+C6rIbzafgID83eKdEtQSzt+tUZC4HJuE7j/Y8yL
	FYTCwe7HiiAllAzUZNqvIIifXQvOewk7VMF8ukgRxjddAbA12jUpOPVkY69Cdi7Z
	Sf2xjv6Rej7eXKgW+BQ1fdVbbD6T929li9669p7jUkzZpezdsjZYgBlA4XAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716930491; x=1717016891; bh=Tw0Md652eLcdfBVfRxR5aYzBHh4v
	FiLjMRfFI3sLkTM=; b=h0azVv8SWmDtSZ6e2gvPTSTsiRinEDpClLCb7C2FBUU1
	YHofTJI+3m9Bcs39GoA13GYxjWo+cO5zHabaUu20V2oGSJgEpEu6s/HEOULXtmXx
	m2N1dC4a6iZoEd9euSoGPgtikFwBsOuQAA0KMcG2ajJinzpAsrsv4C26r7GSd8BJ
	yPIzFhICn0cHEziiUUwjvjtdbxt6nxI2s5mT80AoSlQ/hnMNQZGUo/5zLD4re6MW
	PNP9oCBvvyug6c9ZoI7RGHsrnOMBZIAU+kk4BhGvTH5AKrPucsr9lWC62T2mpSlW
	o7UF+82sbKARH8gkIZnyjYw3OZsWZyDoyGiIpGqi8Q==
X-ME-Sender: <xms:u0dWZlCHU3usqf_x-oj8ZMacc3kOiryySqil_INRt-6VIicw1K-VxA>
    <xme:u0dWZjiZ2PNvFKB9nIBB66aGV4upS1GPXlxsKODyAm4YBcPjivCcsD18rwBmyElOc
    skyb8iQPbRv4Ky5Ans>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepuddtlefgvdegkeeuueetveffleefudekieetudfgvddtuedtteejudduuedv
    gefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:u0dWZgnl4TOHVVz54FphdQwHQalDz5re2iAgVMBPPmN-KyI3swn_kg>
    <xmx:u0dWZvwGJEIVAoAs0G3GlLrOaZuGumPfjT4OKB_Hp6qHulxEpePF3w>
    <xmx:u0dWZqQlMbzzkQPltE4ASA2mbP1gEQK-K3Vpb5Q2UuPgTaEHSn2nMQ>
    <xmx:u0dWZib71LR4d5PkSJhUcH50Q9aCLQz2cUlpepn2tjEACRx6f5e9ug>
    <xmx:u0dWZgOWTmL5PlVEza4_avBtZTJBojW9jLmnp20fxE9CUlAvdPJxlAmg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5B4F92340080; Tue, 28 May 2024 17:08:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ac597520-fb5b-40e5-ae1f-de825450d2db@app.fastmail.com>
In-Reply-To: <5f4799b1-0606-46a9-a347-5a03738db341@amd.com>
References: <20240528013626.14066-1-luke@ljones.dev>
 <20240528013626.14066-9-luke@ljones.dev>
 <6f4bc109-00d0-47b0-a581-b96a6152545c@amd.com>
 <4d6b9171-7248-4937-87de-7e921ed8e507@app.fastmail.com>
 <5f4799b1-0606-46a9-a347-5a03738db341@amd.com>
Date: Wed, 29 May 2024 09:04:11 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Mario Limonciello" <mario.limonciello@amd.com>,
 "Hans de Goede" <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] platform/x86: asus-wmi: add apu_mem setting
Content-Type: text/plain



On Wed, 29 May 2024, at 1:27 AM, Mario Limonciello wrote:
> >>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> >>> index f62a36dfcd4b..4b5fbae8c563 100644
> >>> --- a/drivers/platform/x86/asus-wmi.c
> >>> +++ b/drivers/platform/x86/asus-wmi.c
> >>> @@ -855,6 +855,112 @@ static DEVICE_ATTR_RW(cores_enabled);
> >>>    WMI_SIMPLE_SHOW(cores_max, "0x%x\n", ASUS_WMI_DEVID_CORES_MAX);
> >>>    static DEVICE_ATTR_RO(cores_max);
> >>>    
> >>> +/* Device memory available to APU */
> >>> +
> >>> +static ssize_t apu_mem_show(struct device *dev,
> >>> + struct device_attribute *attr, char *buf)
> >>> +{
> >>> + struct asus_wmi *asus = dev_get_drvdata(dev);
> >>> + int err;
> >>> + u32 mem;
> >>> +
> >>> + err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_APU_MEM, &mem);
> >>> + if (err < 0)
> >>> + return err;
> >>> +
> >>> + switch (mem) {
> >>> + case 256:
> >>> + mem = 0;
> >>> + break;
> >>> + case 258:
> >>> + mem = 1;
> >>> + break;
> >>> + case 259:
> >>> + mem = 2;
> >>> + break;
> >>> + case 260:
> >>> + mem = 3;
> >>> + break;
> >>> + case 261:
> >>> + mem = 4;
> >>> + break;
> >>> + case 262:
> >>> + mem = 8;
> >>> + break;
> >>> + case 263:
> >>> + mem = 5;
> >>> + break;
> >>> + case 264:
> >>> + mem = 6;
> >>> + break;
> >>> + case 265:
> >>> + mem = 7;
> >>> + break;
> >>> + default:
> >>> + mem = 4;
> >>> + break;
> >>> + }
> >>> +
> >>> + return sysfs_emit(buf, "%d\n", mem);
> >>> +}
> >>> +
> >>> +static ssize_t apu_mem_store(struct device *dev,
> >>> +     struct device_attribute *attr,
> >>> +     const char *buf, size_t count)
> >>> +{
> >>> + struct asus_wmi *asus = dev_get_drvdata(dev);
> >>> + int result, err;
> >>> + u32 mem;
> >>> +
> >>> + result = kstrtou32(buf, 10, &mem);
> >>> + if (result)
> >>> + return result;
> >>> +
> >>> + switch (mem) {
> >>> + case 0:
> >>> + mem = 0;
> >>> + break;
> >>> + case 1:
> >>> + mem = 258;
> >>> + break;
> >>> + case 2:
> >>> + mem = 259;
> >>> + break;
> >>> + case 3:
> >>> + mem = 260;
> >>> + break;
> >>> + case 4:
> >>> + mem = 261;
> >>> + break;
> >>> + case 5:
> >>> + mem = 263;
> >>> + break;
> >>> + case 6:
> >>> + mem = 264;
> >>> + break;
> >>> + case 7:
> >>> + mem = 265;
> >>> + break;
> >>> + case 8:
> >>> + mem = 262;
> >>
> >> Is case 8 a mistake, or intentionally out of order?
> > 
> > Do you mean the `mem = <val>`? Those aren't in order, and I thought it was easier to read if the switch was ordered.
> > 
> 
> I'm wondering if case 5 should be 262, case 6 263, case 7 264 and case 8 
> 265.  It just stood out to me.

Yeah it's weird but that is what it is. Also verified in ghelper which calls the same WMI interfaces in Windows.

> 
> If that's all intended then no concerns and I agree sorting the case is 
> better.
> 
> >>
> >>> + break;
> >>> + default:
> >>> + return -EIO;
> >>> + }
> >>> +
> >>> + err = asus_wmi_set_devstate(ASUS_WMI_DEVID_APU_MEM, mem, &result);
> >>> + if (err) {
> >>> + pr_warn("Failed to set apu_mem: %d\n", err);
> >>> + return err;
> >>> + }
> >>> +
> >>> + pr_info("APU memory changed, reboot required\n");
> >>
> >> If you're logging something into the logs for this, I'd say make it more
> >> useful.
> >>
> >> "APU memory changed to %d MB"
> > 
> > Agreed. There's probably a few other spots I can do this also.
> > 
> >>
> >>> + sysfs_notify(&asus->platform_device->dev.kobj, NULL, "apu_mem");
> >>
> >> So this is a case that the BIOS attributes API I mentioned before would
> >> be REALLY useful.  There is a pending_reboot sysfs file that userspace
> >> can query to know if a given setting requires a reboot or not.
> >>
> >> Fwupd also uses this attribute to know to delay BIOS updates until the
> >> system has been rebooted.
> > 
> > Oh! Yes I'll queue that as an additional patch. There's at least 2 or 3 other spots where that would be good to have.
> > 
> 
> For any "new" attributes it's better to put them in that API than code 
> duplication of the BIOS attributes API as well as a random sysfs file 
> API that you can never discard.

Do you mean the firmware_attributes API? If so, I'm not opposed to adding all the existing ROG attributes to it also.

If I'm understanding the docs correctly, for example this apu_mem attr would then become:
- /sys/class/firmware-attributes/asus-bios/attributes/apu_mem/type
- /sys/class/firmware-attributes/*/attributes/apu_mem/current_value
- /sys/class/firmware-attributes/*/attributes/apu_mem/default_value
- /sys/class/firmware-attributes/*/attributes/apu_mem/display_name
- /sys/class/firmware-attributes/*/attributes/apu_mem/possible_values
- ..etc

That's absolutely much better than what I've been doing and I wish I'd known about it sooner.

So if I go ahead and convert all the new attr to this are there any issues with also converting much of the previous attr? And I'm aware of "don't break userspace" so really I'm a bit unsure how best to manage that (would a new module be better here also? "asus-bios.c" perhaps).

What I don't want is a split between platform and firmware_attributes.

> 
> >>> +
> >>> + return count;
> >>> +}
> >>> +static DEVICE_ATTR_RW(apu_mem);
> >>> +
> >>>    /* Tablet mode ****************************************************************/
> >>>    
> >>>    static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
> >>> @@ -4100,6 +4206,7 @@ static struct attribute *platform_attributes[] = {
> >>>    &dev_attr_panel_fhd.attr,
> >>>    &dev_attr_cores_enabled.attr,
> >>>    &dev_attr_cores_max.attr,
> >>> + &dev_attr_apu_mem.attr,
> >>>    &dev_attr_mini_led_mode.attr,
> >>>    &dev_attr_available_mini_led_mode.attr,
> >>>    NULL
> >>> @@ -4176,6 +4283,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
> >>>    else if (attr == &dev_attr_cores_enabled.attr
> >>>    || attr == &dev_attr_cores_max.attr)
> >>>    ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CORES_SET);
> >>> + else if (attr == &dev_attr_apu_mem.attr)
> >>> + ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_APU_MEM);
> >>>    else if (attr == &dev_attr_mini_led_mode.attr)
> >>>    ok = asus->mini_led_dev_id != 0;
> >>>    else if (attr == &dev_attr_available_mini_led_mode.attr)
> >>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> >>> index 5a56e7e97785..efe608861e55 100644
> >>> --- a/include/linux/platform_data/x86/asus-wmi.h
> >>> +++ b/include/linux/platform_data/x86/asus-wmi.h
> >>> @@ -121,6 +121,9 @@
> >>>     /* Maximum Intel E-core and P-core availability */
> >>>    #define ASUS_WMI_DEVID_CORES_MAX 0x001200D3
> >>>    
> >>> +/* Set the memory available to the APU */
> >>> +#define ASUS_WMI_DEVID_APU_MEM 0x000600C1
> >>> +
> >>>    /* MCU powersave mode */
> >>>    #define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
> >>>    
> >>
> 
> 

