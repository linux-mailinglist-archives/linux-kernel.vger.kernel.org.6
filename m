Return-Path: <linux-kernel+bounces-190422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731518CFE0B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9518A1C21871
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C7A13B285;
	Mon, 27 May 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3V5xJIh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC4C1327E5;
	Mon, 27 May 2024 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805534; cv=none; b=AbEX5vdcXKb8abikuH5mhKUPFu4E9b9NU5LGE5MMb5OlfwTsWd7ubKi+H7sug/Z0pl9lkiLSh2Ojv/TIZDSbO+1s1PaZJmBSatjRAwut4OZFru/RDzuKFc0/6DTpHH95qpxMn/XTLb6jazufDAGMpQbtFJOtNC95or1n2VyiQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805534; c=relaxed/simple;
	bh=qCdtKxdZiJ2YQrwk0d49YXlZTA831xWuYlQwJ/olq4w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gHapmIyjHLVS590vJdWqP5ktNrtiHe9SsefQSfg1x2tN6JcSF+lVij+barWjdPrq0jsBD+pRW6eTmhX42xJXMziZqXCA/+OKZ65XgX6Sx8yOhMW7TzH1Nx/MeMgLBz0gYyCijsmBmJORX0dRJJFaGq+JCJ3dZG1C90CQQqmaUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3V5xJIh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716805532; x=1748341532;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qCdtKxdZiJ2YQrwk0d49YXlZTA831xWuYlQwJ/olq4w=;
  b=c3V5xJIhXV8VA0YvOHDGDqwqVvNpFFLPrlKMDdn5D811jwhs7HwDR4cG
   6F7/yk5AQo+jzad0IMg8HsFfiCUfv0kWkxcIA/c/YiZFBdMBUeKw7pKP2
   qnbndsPLvoXjva7koCc5Mf9Pma8suB91tHRYg8Rv7jIs/VbrOezzpwxwK
   hEIP0mnH6B9pmqKWG/di8DpLjS+2t/5p58hO/59vkixbrLXv1UVd1DKbe
   LkZzkS9he5PSHDvBKEYAKCw1Fdj0qmLvmZA8IRJqLEV0dBTot45QQ8akT
   BPnfpXaDIa9a+8Qs4URhzgJaRi7x87DWyaNhP8LdaV8Qi3oB54mVK21yh
   A==;
X-CSE-ConnectionGUID: h0JvnSh9Q2m4TJtj82q7sQ==
X-CSE-MsgGUID: MGdogBO9QIyqQIYSkDlyjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13290400"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13290400"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:25:32 -0700
X-CSE-ConnectionGUID: xosg9IiWQxm2GeoOUnHvLQ==
X-CSE-MsgGUID: HXYFp2FwReiJuY82nHChtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="35217002"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.138])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:25:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 May 2024 13:25:27 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: dell-smbios: Fix wrong token data in
 sysfs
In-Reply-To: <20240518234744.144484-1-W_Armin@gmx.de>
Message-ID: <23e67b5e-8e24-0fa4-42bb-e20cb1596601@linux.intel.com>
References: <20240518234744.144484-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 19 May 2024, Armin Wolf wrote:

> When reading token data from sysfs on my Inspiron 3505, the token
> locations and values are wrong. This happens because match_attribute()
> blindly assumes that all entries in da_tokens have an associated
> entry in token_attrs.
> 
> This however is not true as soon as da_tokens[] contains zeroed
> token entries. Those entries are being skipped when initialising
> token_attrs, breaking the core assumption of match_attribute().
> 
> Fix this by defining an extra struct for each pair of token attributes
> and use container_of() to retrieve token information.
> 
> Tested on a Dell Inspiron 3050.
> 
> Fixes: 33b9ca1e53b4 ("platform/x86: dell-smbios: Add a sysfs interface for SMBIOS tokens")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/dell/dell-smbios-base.c | 127 ++++++++-----------
>  1 file changed, 50 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> index e61bfaf8b5c4..bc1bc02820d7 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -11,6 +11,7 @@
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> +#include <linux/container_of.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/capability.h>
> @@ -25,11 +26,16 @@ static u32 da_supported_commands;
>  static int da_num_tokens;
>  static struct platform_device *platform_device;
>  static struct calling_interface_token *da_tokens;
> -static struct device_attribute *token_location_attrs;
> -static struct device_attribute *token_value_attrs;
> +static struct token_sysfs_data *token_entries;
>  static struct attribute **token_attrs;
>  static DEFINE_MUTEX(smbios_mutex);
> 
> +struct token_sysfs_data {
> +	struct device_attribute location_attr;
> +	struct device_attribute value_attr;
> +	struct calling_interface_token *token;
> +};
> +
>  struct smbios_device {
>  	struct list_head list;
>  	struct device *device;
> @@ -416,47 +422,24 @@ static void __init find_tokens(const struct dmi_header *dm, void *dummy)
>  	}
>  }
> 
> -static int match_attribute(struct device *dev,
> -			   struct device_attribute *attr)
> +static ssize_t location_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	int i;
> -
> -	for (i = 0; i < da_num_tokens * 2; i++) {
> -		if (!token_attrs[i])
> -			continue;
> -		if (strcmp(token_attrs[i]->name, attr->attr.name) == 0)
> -			return i/2;
> -	}
> -	dev_dbg(dev, "couldn't match: %s\n", attr->attr.name);
> -	return -EINVAL;
> -}
> -
> -static ssize_t location_show(struct device *dev,
> -			     struct device_attribute *attr, char *buf)

This change is littered with just style fixes which are good but do not 
belong to this patch, such as here to remove the newline. I think it makes 
this patch noticeably messier to include those extra style changes so 
please separate them out of this patch.

> -{
> -	int i;
> +	struct token_sysfs_data *data = container_of(attr, struct token_sysfs_data, location_attr);
> 
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> 
> -	i = match_attribute(dev, attr);
> -	if (i > 0)
> -		return sysfs_emit(buf, "%08x", da_tokens[i].location);
> -	return 0;
> +	return sysfs_emit(buf, "%08x", data->token->location);
>  }
> 
> -static ssize_t value_show(struct device *dev,
> -			  struct device_attribute *attr, char *buf)
> +static ssize_t value_show(struct device *dev, struct device_attribute *attr, char *buf)

Another style fix.

>  {
> -	int i;
> +	struct token_sysfs_data *data = container_of(attr, struct token_sysfs_data, value_attr);
> 
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> 
> -	i = match_attribute(dev, attr);
> -	if (i > 0)
> -		return sysfs_emit(buf, "%08x", da_tokens[i].value);
> -	return 0;
> +	return sysfs_emit(buf, "%08x", data->token->value);
>  }
> 
>  static struct attribute_group smbios_attribute_group = {
> @@ -473,73 +456,65 @@ static int build_tokens_sysfs(struct platform_device *dev)
>  {
>  	char *location_name;
>  	char *value_name;
> -	size_t size;
>  	int ret;
>  	int i, j;
> 
> -	/* (number of tokens  + 1 for null terminated */
> -	size = sizeof(struct device_attribute) * (da_num_tokens + 1);
> -	token_location_attrs = kzalloc(size, GFP_KERNEL);
> -	if (!token_location_attrs)
> +	token_entries = kcalloc(da_num_tokens, sizeof(struct token_sysfs_data), GFP_KERNEL);

sizeof(*token_entries)

> +	if (!token_entries)
>  		return -ENOMEM;
> -	token_value_attrs = kzalloc(size, GFP_KERNEL);
> -	if (!token_value_attrs)
> -		goto out_allocate_value;
> 
> -	/* need to store both location and value + terminator*/
> -	size = sizeof(struct attribute *) * ((2 * da_num_tokens) + 1);
> -	token_attrs = kzalloc(size, GFP_KERNEL);
> +	/* We need to store both location and value + terminator */
> +	token_attrs = kcalloc((2 * da_num_tokens) + 1, sizeof(struct attribute *), GFP_KERNEL);

sizeof(*token_attrs)

>  	if (!token_attrs)
>  		goto out_allocate_attrs;
> 
>  	for (i = 0, j = 0; i < da_num_tokens; i++) {
> -		/* skip empty */
> +		/* Skip empty */

Style change.

>  		if (da_tokens[i].tokenID == 0)
>  			continue;
> -		/* add location */
> -		location_name = kasprintf(GFP_KERNEL, "%04x_location",
> -					  da_tokens[i].tokenID);
> -		if (location_name == NULL)
> +
> +		token_entries[i].token = &da_tokens[i];
> +

> +		/* Add location */
> +		location_name = kasprintf(GFP_KERNEL, "%04x_location", da_tokens[i].tokenID);
> +		if (!location_name)

Style change x3.

>  			goto out_unwind_strings;
> -		sysfs_attr_init(&token_location_attrs[i].attr);
> -		token_location_attrs[i].attr.name = location_name;
> -		token_location_attrs[i].attr.mode = 0444;
> -		token_location_attrs[i].show = location_show;
> -		token_attrs[j++] = &token_location_attrs[i].attr;
> +
> +		sysfs_attr_init(&token_entries[i].location_attr.attr);
> +		token_entries[i].location_attr.attr.name = location_name;
> +		token_entries[i].location_attr.attr.mode = 0444;
> +		token_entries[i].location_attr.show = location_show;
> +		token_attrs[j++] = &token_entries[i].location_attr.attr;
> 
>  		/* add value */
> -		value_name = kasprintf(GFP_KERNEL, "%04x_value",
> -				       da_tokens[i].tokenID);
> -		if (value_name == NULL)
> -			goto loop_fail_create_value;
> -		sysfs_attr_init(&token_value_attrs[i].attr);
> -		token_value_attrs[i].attr.name = value_name;
> -		token_value_attrs[i].attr.mode = 0444;
> -		token_value_attrs[i].show = value_show;
> -		token_attrs[j++] = &token_value_attrs[i].attr;
> -		continue;
> -
> -loop_fail_create_value:
> -		kfree(location_name);
> -		goto out_unwind_strings;

> +		value_name = kasprintf(GFP_KERNEL, "%04x_value", da_tokens[i].tokenID);
> +		if (!value_name) {

Style change x2.

> +			kfree(location_name);
> +			goto out_unwind_strings;
> +		}
> +
> +		sysfs_attr_init(&token_entries[i].value_attr.attr);
> +		token_entries[i].value_attr.attr.name = value_name;
> +		token_entries[i].value_attr.attr.mode = 0444;
> +		token_entries[i].value_attr.show = value_show;
> +		token_attrs[j++] = &token_entries[i].value_attr.attr;
>  	}
>  	smbios_attribute_group.attrs = token_attrs;
> 
>  	ret = sysfs_create_group(&dev->dev.kobj, &smbios_attribute_group);
>  	if (ret)
>  		goto out_unwind_strings;
> +

Style change.

>  	return 0;
> 
>  out_unwind_strings:
>  	while (i--) {
> -		kfree(token_location_attrs[i].attr.name);
> -		kfree(token_value_attrs[i].attr.name);
> +		kfree(token_entries[i].location_attr.attr.name);
> +		kfree(token_entries[i].value_attr.attr.name);
>  	}
>  	kfree(token_attrs);
>  out_allocate_attrs:
> -	kfree(token_value_attrs);
> -out_allocate_value:
> -	kfree(token_location_attrs);
> +	kfree(token_entries);
> 
>  	return -ENOMEM;
>  }
> @@ -548,15 +523,13 @@ static void free_group(struct platform_device *pdev)
>  {
>  	int i;
> 
> -	sysfs_remove_group(&pdev->dev.kobj,
> -				&smbios_attribute_group);
> +	sysfs_remove_group(&pdev->dev.kobj, &smbios_attribute_group);

Style change.


-- 
 i.


