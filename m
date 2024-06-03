Return-Path: <linux-kernel+bounces-198942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7024D8D7F83
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8689B24CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B307E0F1;
	Mon,  3 Jun 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQLNxMDu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C0763E4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408572; cv=none; b=qfJixL0+J9jH6ofMd0QEYlp8rqrMu+ih2usKNYugivUrEVF+54XEQCWoqTQ5jPjTUgEF70TNWPTbNmwJ72SdapngBJUEdVmSH3D9nhj2mSIF6rlRhbVl/oo+nHe1KP0+51f1i34UgCg9MgcE0SyLuqVlL6NLpUExuW5VVHjDtik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408572; c=relaxed/simple;
	bh=PMjK+KLl77YzoHb+FEHFo7PKU5+RwaJIEKLuac1VPwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cy+WM72BLATlHTmxrVIe7xOcqEBd0LNVOUqGRLftwEPMpjRC5gRBEKSqxbusqs3kOdNztPz/Xj20gw8FZ6zxYLYyCSRW9k2MQQ8QLxKnOh8vOv/JQ8j4xiT/7IydUgNUwQzQIzQ+UCEVohBozCEOckfaKJs4JBj7LYzYBerdwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQLNxMDu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717408570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1PCm2xaf5YJmMIBfGCQNf9GhmSy39Dl1iW2ZFEa2jc=;
	b=TQLNxMDucYnRGhf7PUNFSBKIveJBjLSv89ApYwIEmEqKqRDOEiiL7Smg8ZNQsts6G8Br36
	UKSMXLR5Y11awe72fzZUx/TigIuGoP2YuvfdO1Ftq4O7QFZxU/uOqY+CAqLvNV9NxR9R79
	OvxS6/XGQeoz7wniueBpPBJ8LvfoB+o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-sEEhTg5TPX--IIo32ZLuLQ-1; Mon, 03 Jun 2024 05:56:05 -0400
X-MC-Unique: sEEhTg5TPX--IIo32ZLuLQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6917eb045bso32683766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717408564; x=1718013364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1PCm2xaf5YJmMIBfGCQNf9GhmSy39Dl1iW2ZFEa2jc=;
        b=jH/qsp3VAnl1jR8+deDqjsddn+NodosPdSFTJsDP+cQqS9cJxrPcPOfSLJeqL7OCNa
         NtbX5tE/Risgt+M+MT5IWszG4ff2HMXi9ogCMXyhaCtW7jp8VgJuzxx7KAf3vD25J0+p
         Sj1lzJklIHobpqpgbFg1r+xVRMy0oS+Lz/JpSbXl8/NuR8TzMPGtvrqgI8nJPpNe42mc
         UDrtM5pPtgJs323XDLVRaQPHXvlr0W6Mq1UO6kQbKcMFsSQV3tQ6suPvaHuKza9siZKx
         kYwniG1YueNbfylRzeNJNisEhe9OX2W/SCUCkr6WIMyTmhvCAhxySzMrq6eow/5/doln
         R3lg==
X-Forwarded-Encrypted: i=1; AJvYcCUzasp8a/6+OJ6de4rg13WQGN95D9ng2jSHEt/ExWFEMPEPFWQuYPOs0r/jokAdvYOu3Axc5FePn3icPV0f2/SCeBdHLwZ/EtQoZNo7
X-Gm-Message-State: AOJu0YxyPkftn/qjn2Fw6ryS/o0dti3/HT3LNv5x2ZWhDz2LC3ftyCZs
	RXOo4MzC5B//2WgkUXCFuhRwwNbnoGM539KjqubTxoA+uYd8esV0tio4xvRAS6awcNZyiwf1N9M
	Qe6s5QZpE4QDq/6bLFAXRxc67iz72p1D3V8a/YG/ToZR3SLgDN9A3XKRqZRh0iw==
X-Received: by 2002:a17:907:7ea1:b0:a68:ea13:f68 with SMTP id a640c23a62f3a-a68ea131343mr279879566b.54.1717408564302;
        Mon, 03 Jun 2024 02:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWuRFY3ZUBvH5asyPgmDl2PAvt3sfRx7QBGchc3qg3zTbB4WTJ4nudg3EQQfkLme21VB/cuQ==
X-Received: by 2002:a17:907:7ea1:b0:a68:ea13:f68 with SMTP id a640c23a62f3a-a68ea131343mr279878266b.54.1717408563792;
        Mon, 03 Jun 2024 02:56:03 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a691bde21e2sm80180666b.104.2024.06.03.02.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 02:56:03 -0700 (PDT)
Message-ID: <138380cf-465a-4d0a-a4bc-657bfd83237e@redhat.com>
Date: Mon, 3 Jun 2024 11:56:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] platform/x86: dell-smbios: Fix wrong token data in
 sysfs
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240528204903.445546-1-W_Armin@gmx.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240528204903.445546-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/28/24 10:49 PM, Armin Wolf wrote:
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
> Changes since v1:
> - remove style changes
> - improve sizeof() usage with pointer targets

Thank you for your patch-series, I've applied this series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> ---
>  drivers/platform/x86/dell/dell-smbios-base.c | 92 ++++++++------------
>  1 file changed, 36 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> index e61bfaf8b5c4..86b95206cb1b 100644
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
> @@ -416,47 +422,26 @@ static void __init find_tokens(const struct dmi_header *dm, void *dummy)
>  	}
>  }
> 
> -static int match_attribute(struct device *dev,
> -			   struct device_attribute *attr)
> -{
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
>  static ssize_t location_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
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
>  static ssize_t value_show(struct device *dev,
>  			  struct device_attribute *attr, char *buf)
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
> @@ -473,22 +458,15 @@ static int build_tokens_sysfs(struct platform_device *dev)
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
> +	token_entries = kcalloc(da_num_tokens, sizeof(*token_entries), GFP_KERNEL);
> +	if (!token_entries)
>  		return -ENOMEM;
> -	token_value_attrs = kzalloc(size, GFP_KERNEL);
> -	if (!token_value_attrs)
> -		goto out_allocate_value;
> 
>  	/* need to store both location and value + terminator*/
> -	size = sizeof(struct attribute *) * ((2 * da_num_tokens) + 1);
> -	token_attrs = kzalloc(size, GFP_KERNEL);
> +	token_attrs = kcalloc((2 * da_num_tokens) + 1, sizeof(*token_attrs), GFP_KERNEL);
>  	if (!token_attrs)
>  		goto out_allocate_attrs;
> 
> @@ -496,27 +474,32 @@ static int build_tokens_sysfs(struct platform_device *dev)
>  		/* skip empty */
>  		if (da_tokens[i].tokenID == 0)
>  			continue;
> +
> +		token_entries[i].token = &da_tokens[i];
> +
>  		/* add location */
>  		location_name = kasprintf(GFP_KERNEL, "%04x_location",
>  					  da_tokens[i].tokenID);
>  		if (location_name == NULL)
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
>  		value_name = kasprintf(GFP_KERNEL, "%04x_value",
>  				       da_tokens[i].tokenID);
>  		if (value_name == NULL)
>  			goto loop_fail_create_value;
> -		sysfs_attr_init(&token_value_attrs[i].attr);
> -		token_value_attrs[i].attr.name = value_name;
> -		token_value_attrs[i].attr.mode = 0444;
> -		token_value_attrs[i].show = value_show;
> -		token_attrs[j++] = &token_value_attrs[i].attr;
> +
> +		sysfs_attr_init(&token_entries[i].value_attr.attr);
> +		token_entries[i].value_attr.attr.name = value_name;
> +		token_entries[i].value_attr.attr.mode = 0444;
> +		token_entries[i].value_attr.show = value_show;
> +		token_attrs[j++] = &token_entries[i].value_attr.attr;
>  		continue;
> 
>  loop_fail_create_value:
> @@ -532,14 +515,12 @@ static int build_tokens_sysfs(struct platform_device *dev)
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
> @@ -551,12 +532,11 @@ static void free_group(struct platform_device *pdev)
>  	sysfs_remove_group(&pdev->dev.kobj,
>  				&smbios_attribute_group);
>  	for (i = 0; i < da_num_tokens; i++) {
> -		kfree(token_location_attrs[i].attr.name);
> -		kfree(token_value_attrs[i].attr.name);
> +		kfree(token_entries[i].location_attr.attr.name);
> +		kfree(token_entries[i].value_attr.attr.name);
>  	}
>  	kfree(token_attrs);
> -	kfree(token_value_attrs);
> -	kfree(token_location_attrs);
> +	kfree(token_entries);
>  }
> 
>  static int __init dell_smbios_init(void)
> --
> 2.39.2
> 


