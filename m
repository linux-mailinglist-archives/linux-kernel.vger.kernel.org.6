Return-Path: <linux-kernel+bounces-567120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 663E5A6817F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E28817082E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A3118E25;
	Wed, 19 Mar 2025 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="0SkYdHue";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jq0tdLIZ"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A2A930;
	Wed, 19 Mar 2025 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344241; cv=none; b=CgwqPp8wrIm0+4iSRHrKIxl32sG4y1lsre0Bg5pE6pkYTwOdDzXxOhMQwwsQeNiggOZ6eQtEr75ZTDp2512fjtyPFtWs39Tu/NDHkA46UZEn4J99Ovv5+OM+2Wvx1zV6aS7go0CTSkwJd+I+j+O063LkMwHJ+HznryaGwn6CK1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344241; c=relaxed/simple;
	bh=t0YZm8vRaSy6q/bBsvGmd5xCkFu/PcGdgothwgZtI4s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FA82LT9T//nZU6F8WhpfqkjBPZGlLyJM6XHZ2jPsk6pwfF9BoIEZgE/WA4gJBpQ6WYamHit7rtSHra0S2T0oxLr3Pi8rfX3j8CR06NkVUhe4hYEA12Csnydkv2I5GjqIb5Ma9sNLyW05S6ogZttS+kkBLb+f7++ezPgI/X3c3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=0SkYdHue; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jq0tdLIZ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 21B681140205;
	Tue, 18 Mar 2025 20:30:36 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-02.internal (MEProxy); Tue, 18 Mar 2025 20:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1742344236;
	 x=1742430636; bh=mUatf021EjhNjokYIxkGQdjcw9kIlo5/1Ko94WQjcMk=; b=
	0SkYdHueNgzKg81mJwaTYI1m3rQ+ujpI5BtorvArDmMNiXnU48xVZMHFOFcItDmL
	3ukw/O5i57RZFByFjXXDzrxa94YpDnZzaimmBIgcAZtzWWTxOfUvPUlhXiYVoAe0
	cGVKkoz2mSjh3nIgTTZ+9m0W9hQ2Kdd0MSn2a9SxWj3f5AEEgyVm6BrFEaNyjR5q
	zVzkyhhsXxTPatr8N4TKlEJ3xOmB/tt6dCE8/pxEHgiXtxVIXFm53pXvY12Pi3QI
	jvwHhNffwZVYM0070i1boIZc/VeWF8R/wdXpF/Yukcf34knDVXnwrf9UGKJ5fudj
	5aRn5a+uCo3oCJ+m1/sY3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742344236; x=
	1742430636; bh=mUatf021EjhNjokYIxkGQdjcw9kIlo5/1Ko94WQjcMk=; b=J
	q0tdLIZsowrJzejbrxlQhV96meCnqs2PLNlhfHBm4mVZkRzfoe/JBv7ly/tQV6Ty
	TCccBiT+Fj0hmMwzpO+4VZfwy9u8NRz+Wc/fMa77vnybjdqe5IFbWCR5PAQdwYCq
	YYGIZi3o7lVLs6vr5IUCfTd3I8wpafU6A7pOilnRtnuxPkI1QTzNxrwhjIbCPmEY
	4la6841epp+cLX/Px4ihKEe1qgT6n0FPgY7GZqjCuR+DaHu5BDzM9fGi7ovTPPTR
	+xdrbs62vGNTscArGJFPLZA1WKExG33GHwAXGFlnYUi+Bwt3pOydGeCDe+hHRGiZ
	ICL8IuYmv4PZPa6UT+vug==
X-ME-Sender: <xms:KxDaZxf7zT_qvuglcG7PzfC52iUbH2oZXW-okfnD9L6ahSL-88yKQg>
    <xme:KxDaZ_OudO1h19N6dO6XNpF5Tfg4zJi0IUQreP7KZ9HmHgj8slmK2X9fmFw9d5h9P
    CXBWPl1M5mZBVX-Q1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfnfhukhgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrd
    guvghvqeenucggtffrrghtthgvrhhnpefgieffhedtgffhtedtiedutdefkedvjefgveeh
    hfffvedthfejleegfeffkedvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtphhtthho
    peehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrihhordhlihhmohhntg
    hivghllhhosegrmhgurdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnhes
    lhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekie
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KxDaZ6gnQem8dByIB0GCXJ-_xXcHzMVU5EWfLuLEOakxT9WHgAqOXA>
    <xmx:KxDaZ68-Il4zpsOedoGdqq86T8B-Kw-C6-biDga-OIDwDZ_l9PxSPg>
    <xmx:KxDaZ9uufaCX4_wU627T5V_pB5DPwdFfF0RiS-B5PsNjxDQprQ1gsQ>
    <xmx:KxDaZ5HRZt1t9lxwsAPpV3fBekYIDggb-aqdOB9ICM7beb0qG4MEUA>
    <xmx:LBDaZ1J4B6XG_gxoGCBUt-VY6myOYZ8YrENojX6-hKcZ8rkZaQWaZNlS>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1F6623360079; Tue, 18 Mar 2025 20:30:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0b1809ac0f884a9e
Date: Wed, 19 Mar 2025 13:30:14 +1300
From: "Luke Jones" <luke@ljones.dev>
To: "Mario Limonciello" <mario.limonciello@amd.com>,
 linux-kernel@vger.kernel.org
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Message-Id: <af8d3788-cba1-4591-aa06-c87b017ffa14@app.fastmail.com>
In-Reply-To: <a2362bda-de8b-43c4-ae86-af953b4e1ed8@amd.com>
References: <20250316230724.100165-1-luke@ljones.dev>
 <20250316230724.100165-9-luke@ljones.dev>
 <a2362bda-de8b-43c4-ae86-af953b4e1ed8@amd.com>
Subject: Re: [PATCH v7 8/8] platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025, at 4:42 PM, Mario Limonciello wrote:
> On 3/16/2025 18:07, Luke Jones wrote:
>> From: "Luke D. Jones" <luke@ljones.dev>
>> 
>> Adds the ppt_* and nv_* tuning knobs that are available via WMI methods
>> and adds proper min/max levels plus defaults.
>> 
>> The min/max are defined by ASUS and typically gained by looking at what
>> they allow in the ASUS Armoury Crate application - ASUS does not share
>> the values outside of this. It could also be possible to gain the AMD
>> values by use of ryzenadj and testing for the minimum stable value.
>> 
>> The general rule of thumb for adding to the match table is that if the
>> model range has a single CPU used throughout, then the DMI match can
>> omit the last letter of the model number as this is the GPU model.
>> 
>> If a min or max value is not provided it is assumed that the particular
>> setting is not supported. for example ppt_pl2_sppt_min/max is not set.
>> If a <ppt_setting>_def is not set then the default is assumed to be
>> <ppt_setting>_max
>> 
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> ---
>>   drivers/platform/x86/asus-armoury.c        |  217 +++-
>>   drivers/platform/x86/asus-armoury.h        | 1087 +++++++++++++++++++-
>>   include/linux/platform_data/x86/asus-wmi.h |    3 +
>>   3 files changed, 1300 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
>> index 591805f46725..5598da5295b8 100644
>> --- a/drivers/platform/x86/asus-armoury.c
>> +++ b/drivers/platform/x86/asus-armoury.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>>   #include <linux/platform_data/x86/asus-wmi.h>
>> +#include <linux/power_supply.h>
>>   #include <linux/types.h>
>>   #include <linux/acpi.h>
>>   
>> @@ -67,11 +68,25 @@ struct cpu_cores {
>>   	u32 max_power_cores;
>>   };
>>   
>> +struct rog_tunables {
>> +	const struct power_data *tuning_limits;
>> +	u32 ppt_pl1_spl; // cpu
>> +	u32 ppt_pl2_sppt; // cpu
>> +	u32 ppt_pl3_fppt; // cpu
>> +	u32 ppt_apu_sppt; // plat
>> +	u32 ppt_platform_sppt; // plat
>> +
>> +	u32 nv_dynamic_boost;
>> +	u32 nv_temp_target;
>> +	u32 nv_tgp;
>> +};
>> +
>>   static struct asus_armoury_priv {
>>   	struct device *fw_attr_dev;
>>   	struct kset *fw_attr_kset;
>>   
>>   	struct cpu_cores *cpu_cores;
>> +	struct rog_tunables *rog_tunables;
>>   	u32 mini_led_dev_id;
>>   	u32 gpu_mux_dev_id;
>>   	/*
>> @@ -741,6 +756,26 @@ ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency",
>>   		    "Set the max available efficiency cores");
>>   
>>   /* Simple attribute creation */
>> +ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL,
>> +		       "Set the CPU slow package limit");
>> +ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, "ppt_pl2_sppt", ASUS_WMI_DEVID_PPT_PL2_SPPT,
>> +		       "Set the CPU fast package limit");
>> +ATTR_GROUP_ROG_TUNABLE(ppt_pl3_fppt, "ppt_pl3_fppt", ASUS_WMI_DEVID_PPT_FPPT,
>> +		       "Set the CPU fastest package limit");
>> +ATTR_GROUP_ROG_TUNABLE(ppt_apu_sppt, "ppt_apu_sppt", ASUS_WMI_DEVID_PPT_APU_SPPT,
>> +		       "Set the APU package limit");
>> +ATTR_GROUP_ROG_TUNABLE(ppt_platform_sppt, "ppt_platform_sppt", ASUS_WMI_DEVID_PPT_PLAT_SPPT,
>> +		       "Set the platform package limit");
>> +ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_DYN_BOOST,
>> +		       "Set the Nvidia dynamic boost limit");
>> +ATTR_GROUP_ROG_TUNABLE(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
>> +		       "Set the Nvidia max thermal limit");
>> +ATTR_GROUP_ROG_TUNABLE(nv_tgp, "dgpu_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP,
>> +		       "Set the additional TGP on top of the base TGP");
>> +ATTR_GROUP_INT_VALUE_ONLY_RO(nv_base_tgp, "nv_base_tgp", ASUS_WMI_DEVID_DGPU_BASE_TGP,
>> +			     "Read the base TGP value");
>> +
>> +
>>   ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
>>   		       "Show the current mode of charging");
>>   
>> @@ -767,6 +802,16 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>>   	{ &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>>   	{ &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>>   
>> +	{ &ppt_pl1_spl_attr_group, ASUS_WMI_DEVID_PPT_PL1_SPL },
>> +	{ &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_PPT_PL2_SPPT },
>> +	{ &ppt_pl3_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
>> +	{ &ppt_apu_sppt_attr_group, ASUS_WMI_DEVID_PPT_APU_SPPT },
>> +	{ &ppt_platform_sppt_attr_group, ASUS_WMI_DEVID_PPT_PLAT_SPPT },
>> +	{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
>> +	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
>> +	{ &nv_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
>> +	{ &nv_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
>> +
>>   	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>>   	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
>>   	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
>> @@ -774,8 +819,64 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>>   	{ &panel_hd_mode_attr_group, ASUS_WMI_DEVID_PANEL_HD },
>>   };
>>   
>> +/**
>> + * should_create_tunable_attr - Determines if a tunable attribute should be created
>> + * @name: The name of the attribute
>> + * @limits: Pointer to the power_limits structure containing limit values
>> + *
>> + * This function checks if a power-related tunable attribute should be created
>> + * based on whether appropriate limit values are available. It also logs an error
>> + * if the attribute should exist but is missing required limit values.
>> + *
>> + * Return: true if the attribute should be created, false otherwise
>> + */
>> +static bool should_create_tunable_attr(const char *name,
>> +				       const struct power_limits *limits)
>> +{
>> +	bool is_tunable_attr = false;
>> +	bool has_limit = false;
>> +
>> +	if (!limits)
>> +		return false;
>> +
>> +	struct {
>> +		const char *attr_name;
>> +		u32 limit_value;
>> +	} limit_map[] = {
>> +		{ "ppt_pl1_spl", limits->ppt_pl1_spl_max },
>> +		{ "ppt_pl2_sppt", limits->ppt_pl2_sppt_max },
>> +		{ "ppt_pl3_fppt", limits->ppt_pl3_fppt_max },
>> +		{ "ppt_apu_sppt", limits->ppt_apu_sppt_max },
>> +		{ "ppt_platform_sppt", limits->ppt_platform_sppt_max },
>> +		{ "nv_dynamic_boost", limits->nv_dynamic_boost_max },
>> +		{ "nv_temp_target", limits->nv_temp_target_max },
>> +		{ "nv_base_tgp", limits->nv_tgp_max },
>> +		{ "dgpu_tgp", limits->nv_tgp_max },
>> +	};
>> +
>> +	for (int i = 0; i < ARRAY_SIZE(limit_map); i++) {
>> +		if (!strcmp(name, limit_map[i].attr_name)) {
>> +			is_tunable_attr = true;
>> +			has_limit = limit_map[i].limit_value > 0;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!is_tunable_attr)
>> +		return true;
>> +
>> +	if (!has_limit)
>> +		pr_err("Missing max value on %s for tunable: %s\n",
>> +		       dmi_get_system_info(DMI_BOARD_NAME), name);
>
> I'm wondering if this message is really correct.  The reason I say this 
> is what if you have a pure AMD system without an NV GPU?  Should you 
> really expect to have nv_dynamic_boost, nv_temp_target, nv_base_tgp and 
> dgpu_tgp?
>
> IE Maybe this message should be debug.

I hadn't accounted for that no, sorry about that.

I've now split this function in two to clarify things and make it *specific* to the PPT parts. As before I had it returning true if the attribute wasn't PPT. That didn't make a lot of sense..

>
>> +
>> +	return has_limit;
>> +}
>> +
>>   static int asus_fw_attr_add(void)
>>   {
>> +	const struct power_limits *limits;
>> +	bool should_create;
>> +	const char *name;
>>   	int err, i;
>>   
>>   	asus_armoury.fw_attr_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
>> @@ -832,12 +933,25 @@ static int asus_fw_attr_add(void)
>>   		if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
>>   			continue;
>>   
>> -		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
>> -					 armoury_attr_groups[i].attr_group);
>> -		if (err) {
>> -			pr_err("Failed to create sysfs-group for %s\n",
>> -			       armoury_attr_groups[i].attr_group->name);
>> -			goto err_remove_groups;
>> +		/* Always create by default, unless PPT is not present */
>> +		should_create = true;
>> +		name = armoury_attr_groups[i].attr_group->name;
>> +
>> +		/* Check if this is a power-related tunable requiring limits */
>> +		if (asus_armoury.rog_tunables && asus_armoury.rog_tunables->tuning_limits) {
>> +			limits = asus_armoury.rog_tunables->tuning_limits->ac_data;
>> +			should_create = should_create_tunable_attr(name, limits);
>> +		}
>> +
>> +		if (should_create) {
>> +			err = sysfs_create_group(
>> +				&asus_armoury.fw_attr_kset->kobj,
>> +				armoury_attr_groups[i].attr_group);
>> +			if (err) {
>> +				pr_err("Failed to create sysfs-group for %s\n",
>> +				       armoury_attr_groups[i].attr_group->name);
>> +				goto err_remove_groups;
>> +			}
>>   		}
>>   	}
>>   
>> @@ -866,6 +980,87 @@ static int asus_fw_attr_add(void)
>>   
>>   /* Init / exit ****************************************************************/
>>   
>> +/* Set up the min/max and defaults for ROG tunables */
>> +static bool init_rog_tunables(struct rog_tunables *rog)
>> +{
>> +	const struct dmi_system_id *dmi_id;
>> +	const struct power_data *power_data;
>> +	const struct power_limits *limits;
>> +
>> +	/* Match the system against the power_limits table */
>> +	dmi_id = dmi_first_match(power_limits);
>> +	if (!dmi_id) {
>> +		pr_warn("No matching power limits found for this system\n");
>> +		// rog->tuning_limits = &default_power_data;
>
> Presumably you meant to strip this commented line?

Indeed yes.

>
>> +		rog->tuning_limits = NULL;
>> +		return false;
>> +	}
>> +
>> +	/* Get the power data for this system */
>> +	power_data = dmi_id->driver_data;
>> +	if (!power_data) {
>> +		pr_info("No power data available for this system\n");
>> +		return false;
>> +	}
>> +
>> +	/* Store the power limits for later use */
>> +	rog->tuning_limits = power_data;
>> +
>> +	if (power_supply_is_system_supplied()) {
>> +		limits = power_data->ac_data;
>> +		if (!limits) {
>> +			pr_warn("No AC power limits available\n");
>> +			return false;
>> +		}
>> +	} else {
>> +		limits = power_data->dc_data;
>> +		if (!limits) {
>> +			rog->ppt_pl1_spl = 0;
>> +			rog->ppt_pl2_sppt = 0;
>> +			rog->ppt_pl3_fppt = 0;
>> +			rog->ppt_apu_sppt = 0;
>> +			rog->ppt_platform_sppt = 0;
>> +			rog->nv_dynamic_boost = 0;
>> +			rog->nv_temp_target = 0;
>> +			rog->nv_tgp = 0;
>> +
>> +			pr_warn("No DC power limits available, initializing to 0\n");
>> +			return true;
>> +		}
>> +	}
>
> I'm a bit confused by the above logic here.  If you boot the system with 
> the power supply connected and no limits specified you don't get any 
> limit control created at all.
> But if you boot the system without a power supply connected and no 
> limits specified you do get them initialized to 0 and created.
>
> Two things come to mind thinking this through.
>
> 1) Shouldn't you be returning the same thing in both cases?  IE both 
> cases should return false and no attributes created.
> 2) Shouldn't you be checking both AC and DC no matter how you boot?  You 
> want limits for both AC and DC; and if you don't have them for one or 
> the other you should return false.

Yeah the issue is that some laptops have AC adjustment only. It's an annoying ASUS quirk.. The G513I and G513Q laptops specifically, which are only 4-5 years old and still being heavily used.

If on battery then we still need the attributes created if the AC has data. I'll refactor it a bit to make it make more sense - in the DC block I should also check if AC settings are available before zeroing.

Actually instead of zeroing, I will check if the limits are valid at all in the current_value_show() function and return -ENODEV if invalid. All the other macros in this do the same already so I'm not sure why I missed this one. That allows the function to follow through with AC limit initialization in place of DC, but still disallow the DC if there are no DC limits.

**15 minutes later**

Refactored to store both AC and DC settings so that power switch correctly updates the attributes.

>
>> +
>> +	/* Set initial values */
>> +	rog->ppt_pl1_spl = limits->ppt_pl1_spl_def ?
>> +			   limits->ppt_pl1_spl_def :
>> +			   limits->ppt_pl1_spl_max;
>> +
>> +	rog->ppt_pl2_sppt = limits->ppt_pl2_sppt_def ?
>> +			    limits->ppt_pl2_sppt_def :
>> +			    limits->ppt_pl2_sppt_max;
>> +
>> +	rog->ppt_pl3_fppt = limits->ppt_pl3_fppt_def ?
>> +			    limits->ppt_pl3_fppt_def :
>> +			    limits->ppt_pl3_fppt_max;
>> +
>> +	rog->ppt_apu_sppt = limits->ppt_apu_sppt_def ?
>> +			    limits->ppt_apu_sppt_def :
>> +			    limits->ppt_apu_sppt_max;
>> +
>> +	rog->ppt_platform_sppt = limits->ppt_platform_sppt_def ?
>> +				limits->ppt_platform_sppt_def :
>> +				limits->ppt_platform_sppt_max;
>> +
>> +	rog->nv_dynamic_boost = limits->nv_dynamic_boost_max;
>> +	rog->nv_temp_target = limits->nv_temp_target_max;
>> +	rog->nv_tgp = limits->nv_tgp_max;
>> +
>> +	pr_debug("Power limits initialized for %s (%s power)\n",
>> +		 dmi_id->matches[0].substr,
>> +		 power_supply_is_system_supplied() ? "AC" : "DC");
>> +
>> +	return true;
>> +}
>> +
>>   static int __init asus_fw_init(void)
>>   {
>>   	char *wmi_uid;
>> @@ -896,6 +1091,16 @@ static int __init asus_fw_init(void)
>>   		}
>>   	}
>>   
>> +	asus_armoury.rog_tunables = kzalloc(sizeof(struct rog_tunables), GFP_KERNEL);
>> +	if (!asus_armoury.rog_tunables)
>> +		return -ENOMEM;
>> +	/* Init logs warn/error and the driver should still be usable if init fails */
>> +	if (!init_rog_tunables(asus_armoury.rog_tunables)) {
>> +		kfree(asus_armoury.rog_tunables);
>> +		pr_err("Could not initialise PPT tunable control %d\n", err);
>
> Since init_rog_tunables() will emit warnings for every possible problem, 
> why is this err still needed?  I'd say drop this message.

Done. V8 incoming.

Thanks for your review as always, much appreciated.

>> +	}
>> +
>> +	/* Must always be last step to ensure data is available */
>>   	err = asus_fw_attr_add();
>>   	if (err)
>>   		return err;
>> diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
>> index 584a75df113d..e61cf3fdb559 100644
>> --- a/drivers/platform/x86/asus-armoury.h
>> +++ b/drivers/platform/x86/asus-armoury.h
>> @@ -8,6 +8,7 @@
>>   #ifndef _ASUS_ARMOURY_H_
>>   #define _ASUS_ARMOURY_H_
>>   
>> +#include <linux/dmi.h>
>>   #include <linux/types.h>
>>   #include <linux/platform_device.h>
>>   
>> @@ -63,7 +64,6 @@
>>   	static struct kobj_attribute attr_##_attrname##_##_prop =		\
>>   		__ASUS_ATTR_RO(_attrname, _prop)
>>   
>> -
>>   #define __ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _dispname)\
>>   	WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);			\
>>   	static struct kobj_attribute attr_##_attrname##_current_value =		\
>> @@ -190,4 +190,1089 @@
>>   		.name = _fsname, .attrs = _attrname##_attrs		\
>>   	}
>>   
>> +#define ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname)	\
>> +	WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);			\
>> +	static struct kobj_attribute attr_##_attrname##_current_value =		\
>> +		__ASUS_ATTR_RO(_attrname, current_value);			\
>> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
>> +	static struct kobj_attribute attr_##_attrname##_type =			\
>> +		__ASUS_ATTR_RO_AS(type, int_type_show);				\
>> +	static struct attribute *_attrname##_attrs[] = {			\
>> +		&attr_##_attrname##_current_value.attr,				\
>> +		&attr_##_attrname##_display_name.attr,				\
>> +		&attr_##_attrname##_type.attr, NULL				\
>> +	};									\
>> +	static const struct attribute_group _attrname##_attr_group = {		\
>> +		.name = _fsname, .attrs = _attrname##_attrs			\
>> +	}
>> +
>> +/*
>> + * ROG PPT attributes need a little different in setup as they
>> + * require rog_tunables members.
>> + */
>> +
>> + #define __ROG_TUNABLE_SHOW(_prop, _attrname, _val)				\
>> +	static ssize_t _attrname##_##_prop##_show(				\
>> +		struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
>> +	{									\
>> +		const struct power_limits *limits;				\
>> +		limits = power_supply_is_system_supplied() ?			\
>> +			asus_armoury.rog_tunables->tuning_limits->ac_data :	\
>> +			asus_armoury.rog_tunables->tuning_limits->dc_data;	\
>> +		if (!limits)							\
>> +			return -ENODEV;						\
>> +		return sysfs_emit(buf, "%d\n", limits->_val);			\
>> +	}									\
>> +	static struct kobj_attribute attr_##_attrname##_##_prop =		\
>> +		__ASUS_ATTR_RO(_attrname, _prop)
>> +
>> +#define __ROG_TUNABLE_SHOW_DEFAULT(_attrname)					\
>> +	static ssize_t _attrname##_default_value_show(				\
>> +		struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
>> +	{									\
>> +		const struct power_limits *limits;				\
>> +		limits = power_supply_is_system_supplied() ?			\
>> +			asus_armoury.rog_tunables->tuning_limits->ac_data :	\
>> +			asus_armoury.rog_tunables->tuning_limits->dc_data;	\
>> +		if (!limits)							\
>> +			return -ENODEV;						\
>> +		return sysfs_emit(buf, "%d\n",					\
>> +				 limits->_attrname##_def ?			\
>> +				 limits->_attrname##_def :			\
>> +				 limits->_attrname##_max);			\
>> +	}									\
>> +	static struct kobj_attribute attr_##_attrname##_default_value =		\
>> +		__ASUS_ATTR_RO(_attrname, default_value)
>> +
>> +#define __ROG_TUNABLE_RW(_attr, _wmi)						\
>> +	static ssize_t _attr##_current_value_store(				\
>> +		struct kobject *kobj, struct kobj_attribute *attr,		\
>> +		const char *buf, size_t count)					\
>> +	{									\
>> +		const struct power_limits *limits;				\
>> +		limits = power_supply_is_system_supplied() ?			\
>> +			asus_armoury.rog_tunables->tuning_limits->ac_data :	\
>> +			asus_armoury.rog_tunables->tuning_limits->dc_data;	\
>> +		if (!limits)							\
>> +			return -ENODEV;						\
>> +		return attr_uint_store(kobj, attr, buf, count,			\
>> +				      limits->_attr##_min,			\
>> +				      limits->_attr##_max,			\
>> +				      &asus_armoury.rog_tunables->_attr,	\
>> +				      _wmi);					\
>> +	}									\
>> +	static ssize_t _attr##_current_value_show(				\
>> +		struct kobject *kobj, struct kobj_attribute *attr,		\
>> +		char *buf)							\
>> +	{									\
>> +		return sysfs_emit(buf, "%u\n",					\
>> +				  asus_armoury.rog_tunables->_attr);		\
>> +	}									\
>> +	static struct kobj_attribute attr_##_attr##_current_value =		\
>> +		__ASUS_ATTR_RW(_attr, current_value)
>> +
>> +#define ATTR_GROUP_ROG_TUNABLE(_attrname, _fsname, _wmi, _dispname)	\
>> +	__ROG_TUNABLE_RW(_attrname, _wmi);				\
>> +	__ROG_TUNABLE_SHOW_DEFAULT(_attrname);				\
>> +	__ROG_TUNABLE_SHOW(min_value, _attrname, _attrname##_min);	\
>> +	__ROG_TUNABLE_SHOW(max_value, _attrname, _attrname##_max);	\
>> +	__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", 1);	\
>> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
>> +	static struct kobj_attribute attr_##_attrname##_type =		\
>> +		__ASUS_ATTR_RO_AS(type, int_type_show);			\
>> +	static struct attribute *_attrname##_attrs[] = {		\
>> +		&attr_##_attrname##_current_value.attr,			\
>> +		&attr_##_attrname##_default_value.attr,			\
>> +		&attr_##_attrname##_min_value.attr,			\
>> +		&attr_##_attrname##_max_value.attr,			\
>> +		&attr_##_attrname##_scalar_increment.attr,		\
>> +		&attr_##_attrname##_display_name.attr,			\
>> +		&attr_##_attrname##_type.attr,				\
>> +		NULL							\
>> +	};								\
>> +	static const struct attribute_group _attrname##_attr_group = {	\
>> +		.name = _fsname, .attrs = _attrname##_attrs		\
>> +	}
>> +
>> +/* Default is always the maximum value unless *_def is specified */
>> +struct power_limits {
>> +	u8 ppt_pl1_spl_min;
>> +	u8 ppt_pl1_spl_def;
>> +	u8 ppt_pl1_spl_max;
>> +	u8 ppt_pl2_sppt_min;
>> +	u8 ppt_pl2_sppt_def;
>> +	u8 ppt_pl2_sppt_max;
>> +	u8 ppt_pl3_fppt_min;
>> +	u8 ppt_pl3_fppt_def;
>> +	u8 ppt_pl3_fppt_max;
>> +	u8 ppt_apu_sppt_min;
>> +	u8 ppt_apu_sppt_def;
>> +	u8 ppt_apu_sppt_max;
>> +	u8 ppt_platform_sppt_min;
>> +	u8 ppt_platform_sppt_def;
>> +	u8 ppt_platform_sppt_max;
>> +	/* Nvidia GPU specific, default is always max */
>> +	u8 nv_dynamic_boost_def; // unused. exists for macro
>> +	u8 nv_dynamic_boost_min;
>> +	u8 nv_dynamic_boost_max;
>> +	u8 nv_temp_target_def; // unused. exists for macro
>> +	u8 nv_temp_target_min;
>> +	u8 nv_temp_target_max;
>> +	u8 nv_tgp_def; // unused. exists for macro
>> +	u8 nv_tgp_min;
>> +	u8 nv_tgp_max;
>> +};
>> +
>> +struct power_data {
>> +		const struct power_limits *ac_data;
>> +		const struct power_limits *dc_data;
>> +		bool requires_fan_curve;
>> +};
>> +
>> +/*
>> + * For each avilable attribute there must be a min and a max.
>> + * _def is not required and will be assumed to be default == max if missing.
>> + */
>> +static const struct dmi_system_id power_limits[] = {
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "FA401W"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 80,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_max = 80,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 80,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +				.nv_tgp_min = 55,
>> +				.nv_tgp_max = 75,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 30,
>> +				.ppt_pl2_sppt_min = 31,
>> +				.ppt_pl2_sppt_max = 44,
>> +				.ppt_pl3_fppt_min = 45,
>> +				.ppt_pl3_fppt_max = 65,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "FA507N"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 80,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_max = 80,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 80,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_def = 45,
>> +				.ppt_pl1_spl_max = 65,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_def = 54,
>> +				.ppt_pl2_sppt_max = 65,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 65,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "FA507R"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 80,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 80,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 80
>> +			},
>> +			.dc_data = NULL
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "FA507X"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 80,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_max = 80,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 80,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 20,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +				.nv_tgp_min = 55,
>> +				.nv_tgp_max = 85,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_def = 45,
>> +				.ppt_pl1_spl_max = 65,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_def = 54,
>> +				.ppt_pl2_sppt_max = 65,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 65,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "FA507Z"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 28,
>> +				.ppt_pl1_spl_max = 65,
>> +				.ppt_pl2_sppt_min = 28,
>> +				.ppt_pl2_sppt_max = 105,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 15,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +				.nv_tgp_min = 55,
>> +				.nv_tgp_max = 85,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 45,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_max = 60,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "FA607P"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 30,
>> +				.ppt_pl1_spl_def = 100,
>> +				.ppt_pl1_spl_max = 135,
>> +				.ppt_pl2_sppt_min = 30,
>> +				.ppt_pl2_sppt_def = 115,
>> +				.ppt_pl2_sppt_max = 135,
>> +				.ppt_pl3_fppt_min = 30,
>> +				.ppt_pl3_fppt_max = 135,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +				.nv_tgp_min = 55,
>> +				.nv_tgp_max = 115,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_def = 45,
>> +				.ppt_pl1_spl_max = 80,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_def = 60,
>> +				.ppt_pl2_sppt_max = 80,
>> +				.ppt_pl3_fppt_min = 25,
>> +				.ppt_pl3_fppt_max = 80,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "FA617NS"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_apu_sppt_min = 15,
>> +				.ppt_apu_sppt_max = 80,
>> +				.ppt_platform_sppt_min = 30,
>> +				.ppt_platform_sppt_max = 120
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_apu_sppt_min = 25,
>> +				.ppt_apu_sppt_max = 35,
>> +				.ppt_platform_sppt_min = 45,
>> +				.ppt_platform_sppt_max = 100
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "FA617NT"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_apu_sppt_min = 15,
>> +				.ppt_apu_sppt_max = 80,
>> +				.ppt_platform_sppt_min = 30,
>> +				.ppt_platform_sppt_max = 115
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_apu_sppt_min = 15,
>> +				.ppt_apu_sppt_max = 45,
>> +				.ppt_platform_sppt_min = 30,
>> +				.ppt_platform_sppt_max = 50
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "FA617XS"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_apu_sppt_min = 15,
>> +				.ppt_apu_sppt_max = 80,
>> +				.ppt_platform_sppt_min = 30,
>> +				.ppt_platform_sppt_max = 120,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_apu_sppt_min = 25,
>> +				.ppt_apu_sppt_max = 35,
>> +				.ppt_platform_sppt_min = 45,
>> +				.ppt_platform_sppt_max = 100,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "FX507Z"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 28,
>> +				.ppt_pl1_spl_max = 90,
>> +				.ppt_pl2_sppt_min = 28,
>> +				.ppt_pl2_sppt_max = 135,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 15,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 45,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_max = 60,
>> +			},
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GA401Q"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 80,
>> +				.ppt_pl2_sppt_min = 15,
>> +				.ppt_pl2_sppt_max = 80,
>> +			},
>> +			.dc_data = NULL
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			// This model is full AMD. No Nvidia dGPU.
>> +			DMI_MATCH(DMI_BOARD_NAME, "GA402R"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_apu_sppt_min = 15,
>> +				.ppt_apu_sppt_max = 80,
>> +				.ppt_platform_sppt_min = 30,
>> +				.ppt_platform_sppt_max = 115,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_apu_sppt_min = 25,
>> +				.ppt_apu_sppt_def = 30,
>> +				.ppt_apu_sppt_max = 45,
>> +				.ppt_platform_sppt_min = 40,
>> +				.ppt_platform_sppt_max = 60,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GA402X"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_def = 35,
>> +				.ppt_pl1_spl_max = 80,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_def = 65,
>> +				.ppt_pl2_sppt_max = 80,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 80,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 35,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 35,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 65,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GA403U"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 80,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 80,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 80,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +				.nv_tgp_min = 55,
>> +				.nv_tgp_max = 65,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 35,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 35,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 65,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GA503R"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_def = 35,
>> +				.ppt_pl1_spl_max = 80,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_def = 65,
>> +				.ppt_pl2_sppt_max = 80,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 80,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 20,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_def = 25,
>> +				.ppt_pl1_spl_max = 65,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_def = 54,
>> +				.ppt_pl2_sppt_max = 60,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 65
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GA605W"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 80,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_max = 80,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 80,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 20,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +				.nv_tgp_min = 55,
>> +				.nv_tgp_max = 85,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 35,
>> +				.ppt_pl2_sppt_min = 31,
>> +				.ppt_pl2_sppt_max = 44,
>> +				.ppt_pl3_fppt_min = 45,
>> +				.ppt_pl3_fppt_max = 65,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GU603Z"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 60,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 135,
>> +				/* Only allowed in AC mode */
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 20,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 40,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 40,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GU604V"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 65,
>> +				.ppt_pl1_spl_max = 120,
>> +				.ppt_pl2_sppt_min = 65,
>> +				.ppt_pl2_sppt_max = 150,
>> +				/* Only allowed in AC mode */
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 40,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_def = 40,
>> +				.ppt_pl2_sppt_max = 60,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GU605M"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 28,
>> +				.ppt_pl1_spl_max = 90,
>> +				.ppt_pl2_sppt_min = 28,
>> +				.ppt_pl2_sppt_max = 135,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 20,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 35,
>> +				.ppt_pl2_sppt_min = 38,
>> +				.ppt_pl2_sppt_max = 53,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GV301Q"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 45,
>> +				.ppt_pl2_sppt_min = 65,
>> +				.ppt_pl2_sppt_max = 80,
>> +			},
>> +			.dc_data = NULL
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GV301R"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 45,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 54,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 65,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 35,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 35,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 65,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GV601R"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_def = 35,
>> +				.ppt_pl1_spl_max = 90,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_def = 54,
>> +				.ppt_pl2_sppt_max = 100,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_def = 80,
>> +				.ppt_pl3_fppt_max = 125,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_def = 28,
>> +				.ppt_pl1_spl_max = 65,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_def = 54,
>> +				.ppt_pl2_sppt_def = 40,
>> +				.ppt_pl2_sppt_max = 60,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_def = 80,
>> +				.ppt_pl3_fppt_max = 65,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GV601V"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 28,
>> +				.ppt_pl1_spl_def = 100,
>> +				.ppt_pl1_spl_max = 110,
>> +				.ppt_pl2_sppt_min = 28,
>> +				.ppt_pl2_sppt_max = 135,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 20,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 40,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_def = 40,
>> +				.ppt_pl2_sppt_max = 60,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GX650P"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_def = 110,
>> +				.ppt_pl1_spl_max = 130,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_def = 125,
>> +				.ppt_pl2_sppt_max = 130,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_def = 125,
>> +				.ppt_pl3_fppt_max = 135,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_def = 25,
>> +				.ppt_pl1_spl_max = 65,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_def = 35,
>> +				.ppt_pl2_sppt_max = 65,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_def = 42,
>> +				.ppt_pl3_fppt_max = 65,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "G513I"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				/* Yes this laptop is very limited */
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 80,
>> +				.ppt_pl2_sppt_min = 15,
>> +				.ppt_pl2_sppt_max = 80,
>> +			},
>> +			.dc_data = NULL,
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "G513QM"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				/* Yes this laptop is very limited */
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 100,
>> +				.ppt_pl2_sppt_min = 15,
>> +				.ppt_pl2_sppt_max = 190,
>> +			},
>> +			.dc_data = NULL,
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "G513R"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 35,
>> +				.ppt_pl1_spl_max = 90,
>> +				.ppt_pl2_sppt_min = 54,
>> +				.ppt_pl2_sppt_max = 100,
>> +				.ppt_pl3_fppt_min = 54,
>> +				.ppt_pl3_fppt_max = 125,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 28,
>> +				.ppt_pl1_spl_max = 50,
>> +				.ppt_pl2_sppt_min = 28,
>> +				.ppt_pl2_sppt_max = 50,
>> +				.ppt_pl3_fppt_min = 28,
>> +				.ppt_pl3_fppt_max = 65,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "G614J"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 28,
>> +				.ppt_pl1_spl_max = 140,
>> +				.ppt_pl2_sppt_min = 28,
>> +				.ppt_pl2_sppt_max = 175,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 55,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 70,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "G634J"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 28,
>> +				.ppt_pl1_spl_max = 140,
>> +				.ppt_pl2_sppt_min = 28,
>> +				.ppt_pl2_sppt_max = 175,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 55,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 70,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "G733C"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 28,
>> +				.ppt_pl1_spl_max = 170,
>> +				.ppt_pl2_sppt_min = 28,
>> +				.ppt_pl2_sppt_max = 175,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 28,
>> +				.ppt_pl1_spl_max = 35,
>> +				.ppt_pl2_sppt_min = 28,
>> +				.ppt_pl2_sppt_max = 35,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "G733P"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 30,
>> +				.ppt_pl1_spl_def = 100,
>> +				.ppt_pl1_spl_max = 130,
>> +				.ppt_pl2_sppt_min = 65,
>> +				.ppt_pl2_sppt_def = 125,
>> +				.ppt_pl2_sppt_max = 130,
>> +				.ppt_pl3_fppt_min = 65,
>> +				.ppt_pl3_fppt_def = 125,
>> +				.ppt_pl3_fppt_max = 130,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 65,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 65,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 75,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "G814J"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 28,
>> +				.ppt_pl1_spl_max = 140,
>> +				.ppt_pl2_sppt_min = 28,
>> +				.ppt_pl2_sppt_max = 140,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 55,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 70,
>> +			},
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "G834J"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 28,
>> +				.ppt_pl1_spl_max = 140,
>> +				.ppt_pl2_sppt_min = 28,
>> +				.ppt_pl2_sppt_max = 175,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 25,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 55,
>> +				.ppt_pl2_sppt_min = 25,
>> +				.ppt_pl2_sppt_max = 70,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			},
>> +			.requires_fan_curve = true,
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "H7606W"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 15,
>> +				.ppt_pl1_spl_max = 80,
>> +				.ppt_pl2_sppt_min = 35,
>> +				.ppt_pl2_sppt_max = 80,
>> +				.ppt_pl3_fppt_min = 35,
>> +				.ppt_pl3_fppt_max = 80,
>> +				.nv_dynamic_boost_min = 5,
>> +				.nv_dynamic_boost_max = 20,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +				.nv_tgp_min = 55,
>> +				.nv_tgp_max = 85,
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 25,
>> +				.ppt_pl1_spl_max = 35,
>> +				.ppt_pl2_sppt_min = 31,
>> +				.ppt_pl2_sppt_max = 44,
>> +				.ppt_pl3_fppt_min = 45,
>> +				.ppt_pl3_fppt_max = 65,
>> +				.nv_temp_target_min = 75,
>> +				.nv_temp_target_max = 87,
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "RC71"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 7,
>> +				.ppt_pl1_spl_max = 30,
>> +				.ppt_pl2_sppt_min = 15,
>> +				.ppt_pl2_sppt_max = 43,
>> +				.ppt_pl3_fppt_min = 15,
>> +				.ppt_pl3_fppt_max = 53
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 7,
>> +				.ppt_pl1_spl_def = 15,
>> +				.ppt_pl1_spl_max = 25,
>> +				.ppt_pl2_sppt_min = 15,
>> +				.ppt_pl2_sppt_def = 20,
>> +				.ppt_pl2_sppt_max = 30,
>> +				.ppt_pl3_fppt_min = 15,
>> +				.ppt_pl3_fppt_def = 25,
>> +				.ppt_pl3_fppt_max = 35
>> +			}
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "RC72"),
>> +		},
>> +		.driver_data = &(struct power_data) {
>> +			.ac_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 7,
>> +				.ppt_pl1_spl_max = 30,
>> +				.ppt_pl2_sppt_min = 15,
>> +				.ppt_pl2_sppt_max = 43,
>> +				.ppt_pl3_fppt_min = 15,
>> +				.ppt_pl3_fppt_max = 53
>> +			},
>> +			.dc_data = &(struct power_limits) {
>> +				.ppt_pl1_spl_min = 7,
>> +				.ppt_pl1_spl_def = 17,
>> +				.ppt_pl1_spl_max = 25,
>> +				.ppt_pl2_sppt_min = 15,
>> +				.ppt_pl2_sppt_def = 24,
>> +				.ppt_pl2_sppt_max = 30,
>> +				.ppt_pl3_fppt_min = 15,
>> +				.ppt_pl3_fppt_def = 30,
>> +				.ppt_pl3_fppt_max = 35
>> +			}
>> +		},
>> +	},
>> +	{}
>> +};
>> +
>>   #endif /* _ASUS_ARMOURY_H_ */
>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>> index 92fea0710ada..bf53592e2a2f 100644
>> --- a/include/linux/platform_data/x86/asus-wmi.h
>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>> @@ -145,6 +145,9 @@
>>   
>>   #define ASUS_WMI_DEVID_APU_MEM		0x000600C1
>>   
>> +#define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
>> +#define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
>> +
>>   /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>>   #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
>>   #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026

