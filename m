Return-Path: <linux-kernel+bounces-190472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49508CFEB9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4058F1F22541
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942B13C684;
	Mon, 27 May 2024 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbUepe9a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B313C3D2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808770; cv=none; b=TLfHenijhZSt0CwJoyUmkpZ4FLyq0ea8Tg8AFIv+1HeEubecJ4IBBwozYIHXjBFizQ0d89bfwfTCBNB5KY5ciM0NLVhZ3IVbbTYmcI1iM5u7mFjOEQzxrgmvHuzRHuT+6AOEfS2AW4IBg145YfstBoZh9eWMXQdqvor4JDhcznU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808770; c=relaxed/simple;
	bh=Gif6fa0MsQHzsCJ/VOlaXfVoUhcm3dK+8cBJ/sFaZrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmKptmKRBxXTZ4dROqoiARSTJRkoQJHjr5aj9Vo7PkVlHuGqxHCwp2ULtcgloTdL/fOoFj4uul/WVjBbsAbJfjBH31PiB9ZdV5DBv50JvXs9v+KvrVcba0DxxcuIkZzSvZjX4xwvTwL//teqhyE3kWTsEsp4eOk89dvW5+3ootA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbUepe9a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716808767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdA/b+tw1blJIaO7mJL6nTF1r5QtrHfdOb74Ea/gdaE=;
	b=cbUepe9aFXspqFuRP4b3swvPxuAY4vnBMNGe8l783jfbY59XNgzIbGuU/KnVNjKiIhtMMK
	GGXyUqcAclTQKCjdh1xjPPBQ3VDVGzrqWrDwudql43WEMxPzorQ5y3/hL6BnblB34cl5ZB
	76iL62516swAGJm7oNFqVJa9Z8LkTFg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-NH5T1fw9NqalvodkPtZg9w-1; Mon, 27 May 2024 07:19:25 -0400
X-MC-Unique: NH5T1fw9NqalvodkPtZg9w-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eac412397cso147426039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716808765; x=1717413565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdA/b+tw1blJIaO7mJL6nTF1r5QtrHfdOb74Ea/gdaE=;
        b=Eq8ewbmgwzknJ4ffJvngjFU47zFaTobrVIUrjf0ikvkSq9onMHc5FtIZLTheqLNSuL
         tdaurbFTliS+HAWaBf7inZcL0O9OIb+YkVcQI7MoZ4B/dvqcXU4yTmHu14sFduRa7XR3
         HGsPFBQrL2pQPdMT6mTQXRQRDO5zKBwtm0JLR5ICEr/SgmtRT1PhJjjPw9ZNT/UpTOvl
         YR5wcD3S8ai3ZihwZEqpABee3XbLD3nDbYV7a+4Sm0Iv0pHJJYg5V2FM28rXSjSJqX4O
         aXGEzRVSY5GCeXDbLhpnRN2QRpO6Y5X1zGr8esVjv58zxoHptS1G6/uz3/J96K7ya2Xw
         lHaw==
X-Forwarded-Encrypted: i=1; AJvYcCUq5UJKv7Zhiw9mgxC6UlQ9HJ3TZJAiNQIqOGRxX7yl/OaEt8z5S+8K71d+sLiEFa1LZyL5fftgDU91KVbvmDld52rOntIdGPmjRp2U
X-Gm-Message-State: AOJu0Yxo0WYjTx0YHWTxQsXAuX6LfhEj2Nls8anwVE0nWZDuyNdWFRl7
	00x1ReToJDFey2cBq4zCONw2zIWzJKkl3eIbL5bs/nVcz+neV3YUI9zdNuMHD15NsqyB1y6XVW6
	5Ak4JgvsSSzHG0GeaKttXrDulkMlHpoJLmx+jXBp+u+x7b7tZYlAkGb/gyQEjdQ==
X-Received: by 2002:a5d:8d0a:0:b0:7de:a9d1:1cfa with SMTP id ca18e2360f4ac-7e8c19e4a55mr1233480439f.0.1716808764923;
        Mon, 27 May 2024 04:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLsNtctR1RS5lFQuJN1Gaa8Q2sCs48tsrvPbgptAn9DOO01ligw2osQKxjz5KDGuNhUxVu+A==
X-Received: by 2002:a5d:8d0a:0:b0:7de:a9d1:1cfa with SMTP id ca18e2360f4ac-7e8c19e4a55mr1233477239f.0.1716808764186;
        Mon, 27 May 2024 04:19:24 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03ecd0535sm2053249173.149.2024.05.27.04.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 04:19:23 -0700 (PDT)
Message-ID: <e32fa7ed-be51-44d5-b849-6649da8a8e27@redhat.com>
Date: Mon, 27 May 2024 13:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-smbios: Fix wrong token data in sysfs
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20240518234744.144484-1-W_Armin@gmx.de>
 <23e67b5e-8e24-0fa4-42bb-e20cb1596601@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <23e67b5e-8e24-0fa4-42bb-e20cb1596601@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/27/24 12:25 PM, Ilpo Järvinen wrote:
> On Sun, 19 May 2024, Armin Wolf wrote:
> 
>> When reading token data from sysfs on my Inspiron 3505, the token
>> locations and values are wrong. This happens because match_attribute()
>> blindly assumes that all entries in da_tokens have an associated
>> entry in token_attrs.
>>
>> This however is not true as soon as da_tokens[] contains zeroed
>> token entries. Those entries are being skipped when initialising
>> token_attrs, breaking the core assumption of match_attribute().
>>
>> Fix this by defining an extra struct for each pair of token attributes
>> and use container_of() to retrieve token information.
>>
>> Tested on a Dell Inspiron 3050.
>>
>> Fixes: 33b9ca1e53b4 ("platform/x86: dell-smbios: Add a sysfs interface for SMBIOS tokens")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>  drivers/platform/x86/dell/dell-smbios-base.c | 127 ++++++++-----------
>>  1 file changed, 50 insertions(+), 77 deletions(-)
>>
>> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
>> index e61bfaf8b5c4..bc1bc02820d7 100644
>> --- a/drivers/platform/x86/dell/dell-smbios-base.c
>> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
>> @@ -11,6 +11,7 @@
>>   */
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>
>> +#include <linux/container_of.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/capability.h>
>> @@ -25,11 +26,16 @@ static u32 da_supported_commands;
>>  static int da_num_tokens;
>>  static struct platform_device *platform_device;
>>  static struct calling_interface_token *da_tokens;
>> -static struct device_attribute *token_location_attrs;
>> -static struct device_attribute *token_value_attrs;
>> +static struct token_sysfs_data *token_entries;
>>  static struct attribute **token_attrs;
>>  static DEFINE_MUTEX(smbios_mutex);
>>
>> +struct token_sysfs_data {
>> +	struct device_attribute location_attr;
>> +	struct device_attribute value_attr;
>> +	struct calling_interface_token *token;
>> +};
>> +
>>  struct smbios_device {
>>  	struct list_head list;
>>  	struct device *device;
>> @@ -416,47 +422,24 @@ static void __init find_tokens(const struct dmi_header *dm, void *dummy)
>>  	}
>>  }
>>
>> -static int match_attribute(struct device *dev,
>> -			   struct device_attribute *attr)
>> +static ssize_t location_show(struct device *dev, struct device_attribute *attr, char *buf)
>>  {
>> -	int i;
>> -
>> -	for (i = 0; i < da_num_tokens * 2; i++) {
>> -		if (!token_attrs[i])
>> -			continue;
>> -		if (strcmp(token_attrs[i]->name, attr->attr.name) == 0)
>> -			return i/2;
>> -	}
>> -	dev_dbg(dev, "couldn't match: %s\n", attr->attr.name);
>> -	return -EINVAL;
>> -}
>> -
>> -static ssize_t location_show(struct device *dev,
>> -			     struct device_attribute *attr, char *buf)
> 
> This change is littered with just style fixes which are good but do not 
> belong to this patch, such as here to remove the newline. I think it makes 
> this patch noticeably messier to include those extra style changes so 
> please separate them out of this patch.

I agree with Ilpo's remarks that the style changes should be split out,
either pre or post the patch fixing the actual issue.

After that + addressing Ilpo's other review remarks I can merge this
as a fix for 6.10-rc#

Regards,

Hans



> 
>> -{
>> -	int i;
>> +	struct token_sysfs_data *data = container_of(attr, struct token_sysfs_data, location_attr);
>>
>>  	if (!capable(CAP_SYS_ADMIN))
>>  		return -EPERM;
>>
>> -	i = match_attribute(dev, attr);
>> -	if (i > 0)
>> -		return sysfs_emit(buf, "%08x", da_tokens[i].location);
>> -	return 0;
>> +	return sysfs_emit(buf, "%08x", data->token->location);
>>  }
>>
>> -static ssize_t value_show(struct device *dev,
>> -			  struct device_attribute *attr, char *buf)
>> +static ssize_t value_show(struct device *dev, struct device_attribute *attr, char *buf)
> 
> Another style fix.
> 
>>  {
>> -	int i;
>> +	struct token_sysfs_data *data = container_of(attr, struct token_sysfs_data, value_attr);
>>
>>  	if (!capable(CAP_SYS_ADMIN))
>>  		return -EPERM;
>>
>> -	i = match_attribute(dev, attr);
>> -	if (i > 0)
>> -		return sysfs_emit(buf, "%08x", da_tokens[i].value);
>> -	return 0;
>> +	return sysfs_emit(buf, "%08x", data->token->value);
>>  }
>>
>>  static struct attribute_group smbios_attribute_group = {
>> @@ -473,73 +456,65 @@ static int build_tokens_sysfs(struct platform_device *dev)
>>  {
>>  	char *location_name;
>>  	char *value_name;
>> -	size_t size;
>>  	int ret;
>>  	int i, j;
>>
>> -	/* (number of tokens  + 1 for null terminated */
>> -	size = sizeof(struct device_attribute) * (da_num_tokens + 1);
>> -	token_location_attrs = kzalloc(size, GFP_KERNEL);
>> -	if (!token_location_attrs)
>> +	token_entries = kcalloc(da_num_tokens, sizeof(struct token_sysfs_data), GFP_KERNEL);
> 
> sizeof(*token_entries)
> 
>> +	if (!token_entries)
>>  		return -ENOMEM;
>> -	token_value_attrs = kzalloc(size, GFP_KERNEL);
>> -	if (!token_value_attrs)
>> -		goto out_allocate_value;
>>
>> -	/* need to store both location and value + terminator*/
>> -	size = sizeof(struct attribute *) * ((2 * da_num_tokens) + 1);
>> -	token_attrs = kzalloc(size, GFP_KERNEL);
>> +	/* We need to store both location and value + terminator */
>> +	token_attrs = kcalloc((2 * da_num_tokens) + 1, sizeof(struct attribute *), GFP_KERNEL);
> 
> sizeof(*token_attrs)
> 
>>  	if (!token_attrs)
>>  		goto out_allocate_attrs;
>>
>>  	for (i = 0, j = 0; i < da_num_tokens; i++) {
>> -		/* skip empty */
>> +		/* Skip empty */
> 
> Style change.
> 
>>  		if (da_tokens[i].tokenID == 0)
>>  			continue;
>> -		/* add location */
>> -		location_name = kasprintf(GFP_KERNEL, "%04x_location",
>> -					  da_tokens[i].tokenID);
>> -		if (location_name == NULL)
>> +
>> +		token_entries[i].token = &da_tokens[i];
>> +
> 
>> +		/* Add location */
>> +		location_name = kasprintf(GFP_KERNEL, "%04x_location", da_tokens[i].tokenID);
>> +		if (!location_name)
> 
> Style change x3.
> 
>>  			goto out_unwind_strings;
>> -		sysfs_attr_init(&token_location_attrs[i].attr);
>> -		token_location_attrs[i].attr.name = location_name;
>> -		token_location_attrs[i].attr.mode = 0444;
>> -		token_location_attrs[i].show = location_show;
>> -		token_attrs[j++] = &token_location_attrs[i].attr;
>> +
>> +		sysfs_attr_init(&token_entries[i].location_attr.attr);
>> +		token_entries[i].location_attr.attr.name = location_name;
>> +		token_entries[i].location_attr.attr.mode = 0444;
>> +		token_entries[i].location_attr.show = location_show;
>> +		token_attrs[j++] = &token_entries[i].location_attr.attr;
>>
>>  		/* add value */
>> -		value_name = kasprintf(GFP_KERNEL, "%04x_value",
>> -				       da_tokens[i].tokenID);
>> -		if (value_name == NULL)
>> -			goto loop_fail_create_value;
>> -		sysfs_attr_init(&token_value_attrs[i].attr);
>> -		token_value_attrs[i].attr.name = value_name;
>> -		token_value_attrs[i].attr.mode = 0444;
>> -		token_value_attrs[i].show = value_show;
>> -		token_attrs[j++] = &token_value_attrs[i].attr;
>> -		continue;
>> -
>> -loop_fail_create_value:
>> -		kfree(location_name);
>> -		goto out_unwind_strings;
> 
>> +		value_name = kasprintf(GFP_KERNEL, "%04x_value", da_tokens[i].tokenID);
>> +		if (!value_name) {
> 
> Style change x2.
> 
>> +			kfree(location_name);
>> +			goto out_unwind_strings;
>> +		}
>> +
>> +		sysfs_attr_init(&token_entries[i].value_attr.attr);
>> +		token_entries[i].value_attr.attr.name = value_name;
>> +		token_entries[i].value_attr.attr.mode = 0444;
>> +		token_entries[i].value_attr.show = value_show;
>> +		token_attrs[j++] = &token_entries[i].value_attr.attr;
>>  	}
>>  	smbios_attribute_group.attrs = token_attrs;
>>
>>  	ret = sysfs_create_group(&dev->dev.kobj, &smbios_attribute_group);
>>  	if (ret)
>>  		goto out_unwind_strings;
>> +
> 
> Style change.
> 
>>  	return 0;
>>
>>  out_unwind_strings:
>>  	while (i--) {
>> -		kfree(token_location_attrs[i].attr.name);
>> -		kfree(token_value_attrs[i].attr.name);
>> +		kfree(token_entries[i].location_attr.attr.name);
>> +		kfree(token_entries[i].value_attr.attr.name);
>>  	}
>>  	kfree(token_attrs);
>>  out_allocate_attrs:
>> -	kfree(token_value_attrs);
>> -out_allocate_value:
>> -	kfree(token_location_attrs);
>> +	kfree(token_entries);
>>
>>  	return -ENOMEM;
>>  }
>> @@ -548,15 +523,13 @@ static void free_group(struct platform_device *pdev)
>>  {
>>  	int i;
>>
>> -	sysfs_remove_group(&pdev->dev.kobj,
>> -				&smbios_attribute_group);
>> +	sysfs_remove_group(&pdev->dev.kobj, &smbios_attribute_group);
> 
> Style change.
> 
> 


