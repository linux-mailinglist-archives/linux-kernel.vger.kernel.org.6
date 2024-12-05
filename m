Return-Path: <linux-kernel+bounces-432927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE50C9E51F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26531882763
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADF61D5AC9;
	Thu,  5 Dec 2024 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhRzjWiW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1A18D622;
	Thu,  5 Dec 2024 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393829; cv=none; b=UIkpVHty+fMxLt1y4qRhm++bs5QWYPsXt3M+BfKtUbo5tSf+d4IqMP+U2ocJ0ljbOYdCfotALWq2rwsfUVuTQYKni5djFY5A5CmSnCKlZZL0C1MQ5PaSrDkSaZq6qAoEXqLyHVK3ofepAmhg5vwX2f1o/jEB7QtZp4MoExNwfxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393829; c=relaxed/simple;
	bh=5ahi/YuX8QNvOJ7blol/fgHlvu/NPgcVS03bUQQLLMw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c40/BU0SQk6IJdlqU5o3npdH2TR5x2PQIh9DPR/hVSXdm7zDEce2lVqyqiDFGZe+OElnCEgbRzq3PfWEIhMquGwtpXqO+aF3MUHQp+kJ08+yRe7CYF1PN8cMy9lBghYIqyyp07/8wi1nanWz/d5higHVnfBE/cOKCFwRUO0GyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhRzjWiW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733393828; x=1764929828;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5ahi/YuX8QNvOJ7blol/fgHlvu/NPgcVS03bUQQLLMw=;
  b=HhRzjWiWStFulQFYA7orpaPvNeEtFZjGhsuReNcWLU9jy0pHMjI3LRsm
   tFA/XaluwdGf5xaa56XgQf95CnT4XpV+BiDajwU1n/EjzllIF5uBk1+3F
   td1Iew4B5QUi5+sOZKetN6L5oBcwmgvcYIV4Zia4QXH1qlssYbZrJxJXx
   vSqiqjG6r0AaKN+wDCkD+/TpaSTb2GfCJXrw6KmdeNWodN1e2yypBJ0e2
   HkXDxsdKrLgGiKwdt8Dmtr4LEQKIHymMQXQYOh0+VgzUDExCykeuKrocQ
   bcqgka+ODyZ5lqhJ0O6unr9W1mvHoY5Rz58Gba14nlLP6QpCiuae7odVd
   Q==;
X-CSE-ConnectionGUID: dWZS07+fS6yZMIPu6FezvQ==
X-CSE-MsgGUID: 62J4QGiRQWCrpOvyDEqn+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33833664"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33833664"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 02:17:07 -0800
X-CSE-ConnectionGUID: 5817TUWURj2TwYYt4wH0cA==
X-CSE-MsgGUID: RTDylfuRSCizYFsgmlwzuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="98502944"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 02:17:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 12:17:01 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, 
    platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [RFC PATCH 05/21] alienware-wmi: Refactor rgb-zones sysfs group
 creation
In-Reply-To: <20241205004005.2184945-2-kuurtb@gmail.com>
Message-ID: <5d0ebcc9-062d-7252-956a-2ad8294d7077@linux.intel.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com> <20241205004005.2184945-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Dec 2024, Kurt Borja wrote:

> Define zone_attrs statically with the use of helper macros and
> initialize the zone_attribute_group with driver's .dev_groups.
> 
> This makes match_zone() no longer needed, so drop it.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/dell/alienware-wmi.c | 137 ++++++++++------------
>  1 file changed, 60 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 78bbb4ef4526..fa7bbbb07b86 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -378,7 +378,6 @@ struct color_platform {
>  
>  struct platform_zone {
>  	u8 location;
> -	struct device_attribute *attr;
>  	struct color_platform colors;
>  };
>  
> @@ -411,16 +410,10 @@ struct wmax_u32_args {
>  };
>  
>  static struct platform_device *platform_device;
> -static struct device_attribute *zone_dev_attrs;
> -static struct attribute **zone_attrs;
>  static struct platform_zone *zone_data;
>  static struct platform_profile_handler pp_handler;
>  static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
>  
> -static struct attribute_group zone_attribute_group = {
> -	.name = "rgb_zones",
> -};
> -
>  static u8 interface;
>  static u8 lighting_control_state;
>  static u8 global_brightness;
> @@ -452,20 +445,6 @@ static int parse_rgb(const char *buf, struct color_platform *colors)
>  	return 0;
>  }
>  
> -static struct platform_zone *match_zone(struct device_attribute *attr)
> -{
> -	u8 zone;
> -
> -	for (zone = 0; zone < quirks->num_zones; zone++) {
> -		if ((struct device_attribute *)zone_data[zone].attr == attr) {
> -			pr_debug("alienware-wmi: matched zone location: %d\n",
> -				 zone_data[zone].location);
> -			return &zone_data[zone];
> -		}
> -	}
> -	return NULL;
> -}
> -
>  /*
>   * Individual RGB zone control
>   */
> @@ -510,12 +489,10 @@ static int alienware_update_led(struct platform_zone *zone)
>  }
>  
>  static ssize_t zone_show(struct device *dev, struct device_attribute *attr,
> -			 char *buf)
> +			 char *buf, u8 location)
>  {
>  	struct platform_zone *target_zone;
> -	target_zone = match_zone(attr);
> -	if (target_zone == NULL)
> -		return sprintf(buf, "red: -1, green: -1, blue: -1\n");
> +	target_zone = &zone_data[location];
>  	return sprintf(buf, "red: %d, green: %d, blue: %d\n",
>  		       target_zone->colors.red,
>  		       target_zone->colors.green, target_zone->colors.blue);
> @@ -523,15 +500,11 @@ static ssize_t zone_show(struct device *dev, struct device_attribute *attr,
>  }
>  
>  static ssize_t zone_set(struct device *dev, struct device_attribute *attr,
> -			const char *buf, size_t count)
> +			const char *buf, size_t count, u8 location)
>  {
>  	struct platform_zone *target_zone;
>  	int ret;
> -	target_zone = match_zone(attr);
> -	if (target_zone == NULL) {
> -		pr_err("alienware-wmi: invalid target zone\n");
> -		return 1;
> -	}
> +	target_zone = &zone_data[location];
>  	ret = parse_rgb(buf, &target_zone->colors);
>  	if (ret)
>  		return ret;
> @@ -539,6 +512,32 @@ static ssize_t zone_set(struct device *dev, struct device_attribute *attr,
>  	return ret ? ret : count;
>  }
>  
> +#define ALIENWARE_ZONE_SHOW_FUNC(_num)					\
> +	static ssize_t zone0##_num##_show(struct device *dev,		\
> +					struct device_attribute *attr,	\
> +					char *buf)			\
> +	{								\
> +		return zone_show(dev, attr, buf, _num);			\
> +	}
> +
> +#define ALIENWARE_ZONE_STORE_FUNC(_num)					\
> +	static ssize_t zone0##_num##_store(struct device *dev,		\
> +					struct device_attribute *attr,	\
> +					const char *buf, size_t count)	\
> +	{								\
> +		return zone_set(dev, attr, buf, count, _num);		\
> +	}
> +
> +#define ALIENWARE_ZONE_ATTR(_num)					\
> +	ALIENWARE_ZONE_SHOW_FUNC(_num)					\
> +	ALIENWARE_ZONE_STORE_FUNC(_num)					\
> +	static DEVICE_ATTR_RW(zone0##_num)
> +
> +ALIENWARE_ZONE_ATTR(0);
> +ALIENWARE_ZONE_ATTR(1);
> +ALIENWARE_ZONE_ATTR(2);
> +ALIENWARE_ZONE_ATTR(3);
> +
>  /*
>   * Lighting control state device attribute (Global)
>   */
> @@ -577,6 +576,33 @@ static ssize_t lighting_control_state_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(lighting_control_state);
>  
> +static umode_t zone_attr_visible(struct kobject *kobj,
> +				 struct attribute *attr, int n)
> +{
> +	return n < quirks->num_zones + 1 ? 0644 : 0;
> +}
> +
> +static bool zone_group_visible(struct kobject *kobj)
> +{
> +	return quirks->num_zones > 0;
> +}
> +DEFINE_SYSFS_GROUP_VISIBLE(zone);
> +
> +static struct attribute *zone_attrs[] = {
> +	&dev_attr_lighting_control_state.attr,
> +	&dev_attr_zone00.attr,
> +	&dev_attr_zone01.attr,
> +	&dev_attr_zone02.attr,
> +	&dev_attr_zone03.attr,
> +	NULL
> +};
> +
> +static struct attribute_group zone_attribute_group = {
> +	.name = "rgb_zones",
> +	.is_visible = SYSFS_GROUP_VISIBLE(zone),
> +	.attrs = zone_attrs,
> +};
> +
>  /*
>   * LED Brightness (Global)
>   */
> @@ -624,7 +650,6 @@ static struct led_classdev global_led = {
>  static int alienware_zone_init(struct platform_device *dev)
>  {
>  	u8 zone;
> -	char *name;
>  
>  	if (interface == WMAX) {
>  		lighting_control_state = WMAX_RUNNING;
> @@ -634,65 +659,22 @@ static int alienware_zone_init(struct platform_device *dev)
>  	global_led.max_brightness = 0x0F;
>  	global_brightness = global_led.max_brightness;
>  
> -	/*
> -	 *      - zone_dev_attrs num_zones + 1 is for individual zones and then
> -	 *        null terminated
> -	 *      - zone_attrs num_zones + 2 is for all attrs in zone_dev_attrs +
> -	 *        the lighting control + null terminated
> -	 *      - zone_data num_zones is for the distinct zones
> -	 */
> -	zone_dev_attrs =
> -	    kcalloc(quirks->num_zones + 1, sizeof(struct device_attribute),
> -		    GFP_KERNEL);
> -	if (!zone_dev_attrs)
> -		return -ENOMEM;
> -
> -	zone_attrs =
> -	    kcalloc(quirks->num_zones + 2, sizeof(struct attribute *),
> -		    GFP_KERNEL);
> -	if (!zone_attrs)
> -		return -ENOMEM;
> -
>  	zone_data =
>  	    kcalloc(quirks->num_zones, sizeof(struct platform_zone),
>  		    GFP_KERNEL);
>  	if (!zone_data)
>  		return -ENOMEM;
>  
> -	for (zone = 0; zone < quirks->num_zones; zone++) {
> -		name = kasprintf(GFP_KERNEL, "zone%02hhX", zone);
> -		if (name == NULL)
> -			return 1;
> -		sysfs_attr_init(&zone_dev_attrs[zone].attr);
> -		zone_dev_attrs[zone].attr.name = name;
> -		zone_dev_attrs[zone].attr.mode = 0644;
> -		zone_dev_attrs[zone].show = zone_show;
> -		zone_dev_attrs[zone].store = zone_set;
> +	for (zone = 0; zone < 4; zone++)

You allocate quirks->num_zones entries to zone_data above but use a 
literal here?

-- 
 i.


>  		zone_data[zone].location = zone;
> -		zone_attrs[zone] = &zone_dev_attrs[zone].attr;
> -		zone_data[zone].attr = &zone_dev_attrs[zone];
> -	}
> -	zone_attrs[quirks->num_zones] = &dev_attr_lighting_control_state.attr;
> -	zone_attribute_group.attrs = zone_attrs;
> -
> -	led_classdev_register(&dev->dev, &global_led);
>  
> -	return sysfs_create_group(&dev->dev.kobj, &zone_attribute_group);
> +	return led_classdev_register(&dev->dev, &global_led);
>  }
>  
>  static void alienware_zone_exit(struct platform_device *dev)
>  {
> -	u8 zone;
> -
> -	sysfs_remove_group(&dev->dev.kobj, &zone_attribute_group);
>  	led_classdev_unregister(&global_led);
> -	if (zone_dev_attrs) {
> -		for (zone = 0; zone < quirks->num_zones; zone++)
> -			kfree(zone_dev_attrs[zone].attr.name);
> -	}
> -	kfree(zone_dev_attrs);
>  	kfree(zone_data);
> -	kfree(zone_attrs);
>  }
>  
>  static acpi_status alienware_wmax_command(void *in_args, size_t in_size,
> @@ -1140,6 +1122,7 @@ static void remove_thermal_profile(void)
>   * Platform Driver
>   */
>  static const struct attribute_group *alienfx_groups[] = {
> +	&zone_attribute_group,
>  	&hdmi_attribute_group,
>  	&amplifier_attribute_group,
>  	&deepsleep_attribute_group,
> 

