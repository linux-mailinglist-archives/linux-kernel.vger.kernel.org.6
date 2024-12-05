Return-Path: <linux-kernel+bounces-433271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D719E55CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726171883D62
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB33217F44;
	Thu,  5 Dec 2024 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdT8wYEg"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079811C3318;
	Thu,  5 Dec 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402900; cv=none; b=ihSlf3AkEszejgJqDFARZqjjuaAxiajEmMJ0KwGf42nYM9POR+qFVYLpnIBWieEgkWZUCWScugN7bhyiWjGtVmn6ENONPePvulYewBcM28z9gHG4nItFL6Ym5wByakM/3fMyR6JS2FU6AXnAXTKcKeVMKmbYOllDzvDRRIROv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402900; c=relaxed/simple;
	bh=MV6tXUgMEks34vkx7wnanpx62vaTdnDdwRJ/dzzSCI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1QPUDv0K55SXvCh4VILDgAT/Oppe3FdGY7mA8rJ7gQ4GTgenNMze0T0xo0iXFqXsK+6qsXZDnw0Qxn4Xqe7/eV+G37NEM9fyOWx37qIfjcBUaO6rG1MJEWOIBv9tTcJKFW6iMfYAdqUMTb8jjyMkhhLyTTOvlE53VKF6rm7/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdT8wYEg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724d23df764so837511b3a.1;
        Thu, 05 Dec 2024 04:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733402898; x=1734007698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TWfyHWFQyy12+TAYSZm/6zNA/U67iQr5aWINNGF/k5Q=;
        b=RdT8wYEgJdcT3vs77Uk6t4Iqa6y51YWRn53f7Y5dbWq+ofiUvYYICJwFUGXzVdOSYG
         wyA6JX4SuPrZ+XWviDQTc8gk56g7PX1Du4lwI3vogYmDDzwdae+8V/XFxG+KruUSaJyw
         ph7xxD7w84hdorPRGm4C/ej+EeN2/ScDfVQRJ89G/EQEKwj2Iia7ynlDW0x9WdjRqwKI
         84L6bincIVMRxWt4NdCCZLnPzV2Fq1aSBjpLDGSPA3B/SpY4gzmiSiZfqNEQ++W1xGJC
         fhBYc925kB1sfQf43f83sPfOr2Eunm1MGymYyjiDwN504OuTUk47p4TqcKpq5uNQIo4C
         nt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733402898; x=1734007698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWfyHWFQyy12+TAYSZm/6zNA/U67iQr5aWINNGF/k5Q=;
        b=kLkQoxh9PlGdtgOxRS73i/wzsbtTx5uZLLr1SKIsUE94iv+p/IYjjoQQw/itmAysar
         YS2fXuvk7wLXAk4uBupydeTPG2aNyQRzDKq8QNo3D/hi6KySqBnu/z0BqndgBhKH33B4
         sy+ioS17ifQ4OiP5uDi3oi1Yteo0vCsyzWQsfRamUc1uk28n4l+Sej0mXz9ccRl3XHig
         BTaI31vJ60TrxjbRB48vnoV467bp9NUB7VdS9XuYiolIcB2WFuiIMRh76+ZHo9XGctwI
         eYb385Pp5rVNCVRPEE6CKr7Z3LtczhznEelXZHIhUty+UyL21ySUH8pL4SuxceisePAU
         aUmw==
X-Forwarded-Encrypted: i=1; AJvYcCU2NDihQAlgteOJZrsAasDkVLfyqWJ4qc+p2zaABzepUJpbuB/ygaegPuehLrf7qUsXMJU0MKo0o7SGDEM=@vger.kernel.org, AJvYcCVj+qfQ/re+k54wFmPECKMvokOqlRk+zMrcit2+MZYVkfJVVAF5lGQAWKDYCqTN6bBzfGyyISlIDb/fpCjQ+4P+f2TOww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqXEwTvjdTRsR7gk8m1+ch8uq0Ml3gcm0LIL2AZJtT86qK6AG2
	LQeKy+RZtxsn0j7q51DH364AHiaSVX6p6jqIIy9QmSIGYcIf5zQw
X-Gm-Gg: ASbGncvrwSCriMdcCuyvl7m36O5xYwzpxtm+cQeO9GTrUVj7PAKxO1ycax/lIshFlNF
	yXj6EPve8v1cSEO9imVgVZ2X3Gav2fi6UgUmGlmOBV8XDl6Y8fFnsL6mSfq3GLbBwKJAx9CPhn6
	fN1AbyaMfeYz1uaI1C4T/8yn/1rNoqbTOPgACq3annF3yFy7x/xbz7uz25G8UgMpNWnS+ctbWGc
	ve6+wECykcaX3atQ8l3kq0m5jUwYl74RnCFhTkszIdHNYTJxd6IINIhl+pGi+DXudWmX2MIgnIX
	FqPVD4TM
X-Google-Smtp-Source: AGHT+IFb3xPSvRh4to/08fbCpXkaZn6I0zDOFhJ0YE6L6sMzZ/eZfQy/kbePEbJCNDUsvMjYVxrAHw==
X-Received: by 2002:a17:903:22cf:b0:215:6337:25da with SMTP id d9443c01a7336-215bd158554mr153504045ad.39.1733402898013;
        Thu, 05 Dec 2024 04:48:18 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09259sm11739325ad.195.2024.12.05.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:48:17 -0800 (PST)
Date: Thu, 5 Dec 2024 09:48:14 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, platform-driver-x86@vger.kernel.org, 
	w_armin@gmx.de
Subject: Re: [RFC PATCH 05/21] alienware-wmi: Refactor rgb-zones sysfs group
 creation
Message-ID: <fme54i5psnvamh6u7u7o7wlnyzpstiuus6jk73tkjfkoulg2m6@kxicd7efw2rx>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
 <20241205004005.2184945-2-kuurtb@gmail.com>
 <5d0ebcc9-062d-7252-956a-2ad8294d7077@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d0ebcc9-062d-7252-956a-2ad8294d7077@linux.intel.com>

On Thu, Dec 05, 2024 at 12:17:01PM +0200, Ilpo Järvinen wrote:
> On Wed, 4 Dec 2024, Kurt Borja wrote:
> 
> > Define zone_attrs statically with the use of helper macros and
> > initialize the zone_attribute_group with driver's .dev_groups.
> > 
> > This makes match_zone() no longer needed, so drop it.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  drivers/platform/x86/dell/alienware-wmi.c | 137 ++++++++++------------
> >  1 file changed, 60 insertions(+), 77 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index 78bbb4ef4526..fa7bbbb07b86 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -378,7 +378,6 @@ struct color_platform {
> >  
> >  struct platform_zone {
> >  	u8 location;
> > -	struct device_attribute *attr;
> >  	struct color_platform colors;
> >  };
> >  
> > @@ -411,16 +410,10 @@ struct wmax_u32_args {
> >  };
> >  
> >  static struct platform_device *platform_device;
> > -static struct device_attribute *zone_dev_attrs;
> > -static struct attribute **zone_attrs;
> >  static struct platform_zone *zone_data;
> >  static struct platform_profile_handler pp_handler;
> >  static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
> >  
> > -static struct attribute_group zone_attribute_group = {
> > -	.name = "rgb_zones",
> > -};
> > -
> >  static u8 interface;
> >  static u8 lighting_control_state;
> >  static u8 global_brightness;
> > @@ -452,20 +445,6 @@ static int parse_rgb(const char *buf, struct color_platform *colors)
> >  	return 0;
> >  }
> >  
> > -static struct platform_zone *match_zone(struct device_attribute *attr)
> > -{
> > -	u8 zone;
> > -
> > -	for (zone = 0; zone < quirks->num_zones; zone++) {
> > -		if ((struct device_attribute *)zone_data[zone].attr == attr) {
> > -			pr_debug("alienware-wmi: matched zone location: %d\n",
> > -				 zone_data[zone].location);
> > -			return &zone_data[zone];
> > -		}
> > -	}
> > -	return NULL;
> > -}
> > -
> >  /*
> >   * Individual RGB zone control
> >   */
> > @@ -510,12 +489,10 @@ static int alienware_update_led(struct platform_zone *zone)
> >  }
> >  
> >  static ssize_t zone_show(struct device *dev, struct device_attribute *attr,
> > -			 char *buf)
> > +			 char *buf, u8 location)
> >  {
> >  	struct platform_zone *target_zone;
> > -	target_zone = match_zone(attr);
> > -	if (target_zone == NULL)
> > -		return sprintf(buf, "red: -1, green: -1, blue: -1\n");
> > +	target_zone = &zone_data[location];
> >  	return sprintf(buf, "red: %d, green: %d, blue: %d\n",
> >  		       target_zone->colors.red,
> >  		       target_zone->colors.green, target_zone->colors.blue);
> > @@ -523,15 +500,11 @@ static ssize_t zone_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  
> >  static ssize_t zone_set(struct device *dev, struct device_attribute *attr,
> > -			const char *buf, size_t count)
> > +			const char *buf, size_t count, u8 location)
> >  {
> >  	struct platform_zone *target_zone;
> >  	int ret;
> > -	target_zone = match_zone(attr);
> > -	if (target_zone == NULL) {
> > -		pr_err("alienware-wmi: invalid target zone\n");
> > -		return 1;
> > -	}
> > +	target_zone = &zone_data[location];
> >  	ret = parse_rgb(buf, &target_zone->colors);
> >  	if (ret)
> >  		return ret;
> > @@ -539,6 +512,32 @@ static ssize_t zone_set(struct device *dev, struct device_attribute *attr,
> >  	return ret ? ret : count;
> >  }
> >  
> > +#define ALIENWARE_ZONE_SHOW_FUNC(_num)					\
> > +	static ssize_t zone0##_num##_show(struct device *dev,		\
> > +					struct device_attribute *attr,	\
> > +					char *buf)			\
> > +	{								\
> > +		return zone_show(dev, attr, buf, _num);			\
> > +	}
> > +
> > +#define ALIENWARE_ZONE_STORE_FUNC(_num)					\
> > +	static ssize_t zone0##_num##_store(struct device *dev,		\
> > +					struct device_attribute *attr,	\
> > +					const char *buf, size_t count)	\
> > +	{								\
> > +		return zone_set(dev, attr, buf, count, _num);		\
> > +	}
> > +
> > +#define ALIENWARE_ZONE_ATTR(_num)					\
> > +	ALIENWARE_ZONE_SHOW_FUNC(_num)					\
> > +	ALIENWARE_ZONE_STORE_FUNC(_num)					\
> > +	static DEVICE_ATTR_RW(zone0##_num)
> > +
> > +ALIENWARE_ZONE_ATTR(0);
> > +ALIENWARE_ZONE_ATTR(1);
> > +ALIENWARE_ZONE_ATTR(2);
> > +ALIENWARE_ZONE_ATTR(3);
> > +
> >  /*
> >   * Lighting control state device attribute (Global)
> >   */
> > @@ -577,6 +576,33 @@ static ssize_t lighting_control_state_store(struct device *dev,
> >  
> >  static DEVICE_ATTR_RW(lighting_control_state);
> >  
> > +static umode_t zone_attr_visible(struct kobject *kobj,
> > +				 struct attribute *attr, int n)
> > +{
> > +	return n < quirks->num_zones + 1 ? 0644 : 0;
> > +}
> > +
> > +static bool zone_group_visible(struct kobject *kobj)
> > +{
> > +	return quirks->num_zones > 0;
> > +}
> > +DEFINE_SYSFS_GROUP_VISIBLE(zone);
> > +
> > +static struct attribute *zone_attrs[] = {
> > +	&dev_attr_lighting_control_state.attr,
> > +	&dev_attr_zone00.attr,
> > +	&dev_attr_zone01.attr,
> > +	&dev_attr_zone02.attr,
> > +	&dev_attr_zone03.attr,
> > +	NULL
> > +};
> > +
> > +static struct attribute_group zone_attribute_group = {
> > +	.name = "rgb_zones",
> > +	.is_visible = SYSFS_GROUP_VISIBLE(zone),
> > +	.attrs = zone_attrs,
> > +};
> > +
> >  /*
> >   * LED Brightness (Global)
> >   */
> > @@ -624,7 +650,6 @@ static struct led_classdev global_led = {
> >  static int alienware_zone_init(struct platform_device *dev)
> >  {
> >  	u8 zone;
> > -	char *name;
> >  
> >  	if (interface == WMAX) {
> >  		lighting_control_state = WMAX_RUNNING;
> > @@ -634,65 +659,22 @@ static int alienware_zone_init(struct platform_device *dev)
> >  	global_led.max_brightness = 0x0F;
> >  	global_brightness = global_led.max_brightness;
> >  
> > -	/*
> > -	 *      - zone_dev_attrs num_zones + 1 is for individual zones and then
> > -	 *        null terminated
> > -	 *      - zone_attrs num_zones + 2 is for all attrs in zone_dev_attrs +
> > -	 *        the lighting control + null terminated
> > -	 *      - zone_data num_zones is for the distinct zones
> > -	 */
> > -	zone_dev_attrs =
> > -	    kcalloc(quirks->num_zones + 1, sizeof(struct device_attribute),
> > -		    GFP_KERNEL);
> > -	if (!zone_dev_attrs)
> > -		return -ENOMEM;
> > -
> > -	zone_attrs =
> > -	    kcalloc(quirks->num_zones + 2, sizeof(struct attribute *),
> > -		    GFP_KERNEL);
> > -	if (!zone_attrs)
> > -		return -ENOMEM;
> > -
> >  	zone_data =
> >  	    kcalloc(quirks->num_zones, sizeof(struct platform_zone),
> >  		    GFP_KERNEL);
> >  	if (!zone_data)
> >  		return -ENOMEM;
> >  
> > -	for (zone = 0; zone < quirks->num_zones; zone++) {
> > -		name = kasprintf(GFP_KERNEL, "zone%02hhX", zone);
> > -		if (name == NULL)
> > -			return 1;
> > -		sysfs_attr_init(&zone_dev_attrs[zone].attr);
> > -		zone_dev_attrs[zone].attr.name = name;
> > -		zone_dev_attrs[zone].attr.mode = 0644;
> > -		zone_dev_attrs[zone].show = zone_show;
> > -		zone_dev_attrs[zone].store = zone_set;
> > +	for (zone = 0; zone < 4; zone++)
> 
> You allocate quirks->num_zones entries to zone_data above but use a 
> literal here?

I did this because quirks->num_zones controlls only visibility now. I
didn't feel comfortable leaving an out of bounds access on zone_show()
and zone_set() when they do `zone_data[location]`.

Still those out of bounds accesses are hidden from user-space (right?) and
alienware_wmi_init() is getting dropped anyway so I should just leave it
as zone < quirks->num_zones.

> 
> -- 
>  i.
> 
> 
> >  		zone_data[zone].location = zone;
> > -		zone_attrs[zone] = &zone_dev_attrs[zone].attr;
> > -		zone_data[zone].attr = &zone_dev_attrs[zone];
> > -	}
> > -	zone_attrs[quirks->num_zones] = &dev_attr_lighting_control_state.attr;
> > -	zone_attribute_group.attrs = zone_attrs;
> > -
> > -	led_classdev_register(&dev->dev, &global_led);
> >  
> > -	return sysfs_create_group(&dev->dev.kobj, &zone_attribute_group);
> > +	return led_classdev_register(&dev->dev, &global_led);
> >  }
> >  
> >  static void alienware_zone_exit(struct platform_device *dev)
> >  {
> > -	u8 zone;
> > -
> > -	sysfs_remove_group(&dev->dev.kobj, &zone_attribute_group);
> >  	led_classdev_unregister(&global_led);
> > -	if (zone_dev_attrs) {
> > -		for (zone = 0; zone < quirks->num_zones; zone++)
> > -			kfree(zone_dev_attrs[zone].attr.name);
> > -	}
> > -	kfree(zone_dev_attrs);
> >  	kfree(zone_data);
> > -	kfree(zone_attrs);
> >  }
> >  
> >  static acpi_status alienware_wmax_command(void *in_args, size_t in_size,
> > @@ -1140,6 +1122,7 @@ static void remove_thermal_profile(void)
> >   * Platform Driver
> >   */
> >  static const struct attribute_group *alienfx_groups[] = {
> > +	&zone_attribute_group,
> >  	&hdmi_attribute_group,
> >  	&amplifier_attribute_group,
> >  	&deepsleep_attribute_group,
> > 

