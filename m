Return-Path: <linux-kernel+bounces-283290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F8E94EFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B8F1C20D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8DD180A81;
	Mon, 12 Aug 2024 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MewLXGph"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691F17DE36
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473176; cv=none; b=dOtAlBi5hPXhr+EbHnt2oYmKlEa9O03msvAcZE2R2ao9MfwvI7enPnwOy7TElRyV0aXh6Z1uQAbuhhcYEO56zhCSneP1MqlwFT4mI2qOCsfjb4EbnBwrw8II9XVJVB4DgRlbqVoTPCxJWmTLoqoJYWJq4efyUnnEWGieHkJ78ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473176; c=relaxed/simple;
	bh=PlanaOpMb2SRMqKdq5D8pste4LaJ8DlH07fq1hh+P0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PikTc0jcB7J1Z6bZH/EalCT2xPT17VRqquDvkuy6tYxr8RqbFAqBM5HApN3bVFfkIsbYeDT4YEALQvuSpfPQR5asoNEnj4of3B8r7YeVBvrJgsfER4YE1/V4pG9IvMMtf95oFl+tW2xfwqdn1UomQ/Emt7s0UzdVggxEwKxiw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MewLXGph; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723473174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7z/bDQPBfzLS8uye3nnDjLzeFXDO1SAM9YfCaOIrT0Q=;
	b=MewLXGphcZryGmeDoEBkgVsuMXTjsh3jbkyLYM8SnefSKgcFLxfHHXCw9CrhZJwmwhk+Ih
	r520kk39HW3eKbeD/BQghgX/iOOgkVawfkcTZTnK5mSKX2D+mvAe5QTNujsDi4x+PYwQDM
	hIPSh1J1Tbrs8yMlvtFlMzv9W1HOEwM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-jgU5AdL1MIu3GQTfn-Nf7g-1; Mon, 12 Aug 2024 10:32:53 -0400
X-MC-Unique: jgU5AdL1MIu3GQTfn-Nf7g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a80c12dede1so251284366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723473171; x=1724077971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7z/bDQPBfzLS8uye3nnDjLzeFXDO1SAM9YfCaOIrT0Q=;
        b=WLOG+FMXWKHoeFV3nvmUUGUt/uUHdLPLvF0q0Wx+58ysL968k1mI69QBgzgT4esRkb
         XoVf1CbLUhplGXSVsYl+B8RQ9D/IQYl0rOeMwQq15XMvEpqmAisyPsvEnGVyhiJIY8Qm
         rdVe66+ILEdNn2J7jI3tXRLvna43F9MEEHWHkT7DJOz/vibodOR/7p+MoOG1K0BzWDMP
         oV2kix5nZMZvdjKpikk0m6/ejAvEFR8wDXwqXYbZuUMvagbgLHKO8t5NigqO5MwXTHu9
         x7YLc0W7NX58my8AsaoUV7jkV9p1s7QumicHytvP2936EVb09njG2CRDiFyPgKgGY9bS
         Oe2A==
X-Forwarded-Encrypted: i=1; AJvYcCWXKU9fuMKj0ngtHJBB17fqoQX/aRfIpRbWeQvQuXpBxc5y3SRu9DrUtwdzXoI6CHFQUGBY5GXruLx783JP4mhouFPUUZAM4UZ7/Ikf
X-Gm-Message-State: AOJu0Yzurl6ZjlPyGUIytwMB3E5Hnrg3u1wF181BvvCOX9pJX77fP1Bf
	A9Yof0puPuSuxFBl4hnv7PHnk1dmHcmeU1PylBdhgjp1cEzU1N3hQZbB6k/q5+OLWuICP35qyb+
	sNuqAI3Z0yQVD1QT9h06M4tljep+XS4XoO5nLWVPumekQAEZRXq9/UW/DKKJUE6UPui/w9A==
X-Received: by 2002:a17:907:3ea8:b0:a7d:89ac:9539 with SMTP id a640c23a62f3a-a80edb9ac13mr34388966b.7.1723473171645;
        Mon, 12 Aug 2024 07:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVPdC1ynHcq2VxBs3JRJDWgWf0x+tZptDP+tcUHNCYqDT7Ou4szzQPY6Sh5vDhFLMnAX5j+g==
X-Received: by 2002:a17:907:3ea8:b0:a7d:89ac:9539 with SMTP id a640c23a62f3a-a80edb9ac13mr34386666b.7.1723473171131;
        Mon, 12 Aug 2024 07:32:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e54a9sm233418366b.81.2024.08.12.07.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 07:32:50 -0700 (PDT)
Message-ID: <d0eefb6e-d3ef-4bae-9b8d-07c71e0d8bce@redhat.com>
Date: Mon, 12 Aug 2024 16:32:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: ISST: Simplify isst_misc_reg() and
 isst_misc_unreg()
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731184256.1852840-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240731184256.1852840-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/31/24 8:42 PM, Srinivas Pandruvada wrote:
> After commit '1630dc626c87 ("platform/x86: ISST: Add model specific
> loading for common module")' isst_misc_reg() and isst_misc_unreg() can be
> simplified. Since these functions are only called during module_init()
> and module_exit() respectively, there is no contention while calling
> misc_register()/misc_deregister or isst_if_cpu_info_init()/
> isst_if_cpu_info_exit().
> 
> Hence remove mutex and reference counting.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  .../intel/speed_select_if/isst_if_common.c    | 42 +++++--------------
>  1 file changed, 11 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index 3065f149e721..febfd5eeceb4 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -651,10 +651,6 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
>  
>  /* Lock to prevent module registration when already opened by user space */
>  static DEFINE_MUTEX(punit_misc_dev_open_lock);
> -/* Lock to allow one shared misc device for all ISST interfaces */
> -static DEFINE_MUTEX(punit_misc_dev_reg_lock);
> -static int misc_usage_count;
> -static int misc_device_ret;
>  static int misc_device_open;
>  
>  static int isst_if_open(struct inode *inode, struct file *file)
> @@ -720,39 +716,23 @@ static struct miscdevice isst_if_char_driver = {
>  
>  static int isst_misc_reg(void)
>  {
> -	mutex_lock(&punit_misc_dev_reg_lock);
> -	if (misc_device_ret)
> -		goto unlock_exit;
> -
> -	if (!misc_usage_count) {
> -		misc_device_ret = isst_if_cpu_info_init();
> -		if (misc_device_ret)
> -			goto unlock_exit;
> -
> -		misc_device_ret = misc_register(&isst_if_char_driver);
> -		if (misc_device_ret) {
> -			isst_if_cpu_info_exit();
> -			goto unlock_exit;
> -		}
> -	}
> -	misc_usage_count++;
> +	int ret;
>  
> -unlock_exit:
> -	mutex_unlock(&punit_misc_dev_reg_lock);
> +	ret = isst_if_cpu_info_init();
> +	if (ret)
> +		return ret;
>  
> -	return misc_device_ret;
> +	ret = misc_register(&isst_if_char_driver);
> +	if (ret)
> +		isst_if_cpu_info_exit();
> +
> +	return ret;
>  }
>  
>  static void isst_misc_unreg(void)
>  {
> -	mutex_lock(&punit_misc_dev_reg_lock);
> -	if (misc_usage_count)
> -		misc_usage_count--;
> -	if (!misc_usage_count && !misc_device_ret) {
> -		misc_deregister(&isst_if_char_driver);
> -		isst_if_cpu_info_exit();
> -	}
> -	mutex_unlock(&punit_misc_dev_reg_lock);
> +	misc_deregister(&isst_if_char_driver);
> +	isst_if_cpu_info_exit();
>  }
>  
>  /**


