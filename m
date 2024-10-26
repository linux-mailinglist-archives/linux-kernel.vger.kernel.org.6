Return-Path: <linux-kernel+bounces-383062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6749B16EB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F541C215A6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C51D26E6;
	Sat, 26 Oct 2024 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhsvJeVg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB4C1D12EA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729937285; cv=none; b=nBq2vci02XhNv236unkk9Z1Ig1b4LF1Pd0N/eHbF7oXTYI93ibu2WUDfRh1JB6M7T+N6Hud5hWvoSYda1foXG3tbHrf0FHnfe+pQR6soVdzznT/zBIT37nReoPbB2Ta653vQ+PpNH6HoDHT0wEdKe+pgrroasxnODWhdF0/M3Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729937285; c=relaxed/simple;
	bh=Yb6DOUVWC+z9obuDOwL6cE/4OjSiYuaJwipK+3utPsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3sWzijXe4bav0LgJvNSeeAb98S7XwFrzS0xkYL5QvDDsDmcXQDwOGML2znSKP4sNoLTzDNAS8kpGnwZ7IMwU4haau+1l8kzf9v93RK0PwFnUO6AQIdhtOcGbtm31gma4lw73A0ny0IIcg51gqiTRV50F2gpkbv6kaA578syLhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhsvJeVg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729937283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8CuTmz6iHM4b1Xovver+IewcVa6XPw+HHrC5CvOxZ8=;
	b=MhsvJeVg0jwV2CgOOsW2UifR7Xaa64HG2P8SQRR4cjxnOr2G6T5Cjl0AyCEfbavdnOpVjX
	M44JyrkCkJkYW63TSSLnQitPzNhfIyY5md2rMiHXBkTmSXRoHsIyB99Vm+foRHciQ31m7h
	0xb4ix7Bxn9MmCX4RlPSSJwRhQuTj98=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-04f6sYlaPIGZ3Nc0z67vew-1; Sat, 26 Oct 2024 06:08:01 -0400
X-MC-Unique: 04f6sYlaPIGZ3Nc0z67vew-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99efc7d881so201761866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729937280; x=1730542080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8CuTmz6iHM4b1Xovver+IewcVa6XPw+HHrC5CvOxZ8=;
        b=jvt+xTR+WvmDVmrCx3viXJ813dxYv64WCzpLEhcgMYds8M2tNZL6mTiWMuu2lrqVly
         kj6LDvccOHd7caNr51eaqaZBbeFkKXNuDMygZ8AKRXKwRwXyX4ywjr6p/2/1lhZfptob
         EPs4dCMNRBjAubsc9WuDjU+Km9bOjvx52wEl+X+bU8pucVLK3lhy/8GB3HozhlHUHDVp
         VKbD1j7L50hEQcN/vrLVKr05Zhpb3eMd0W1do8N3WRQb9bBaDv8JPEPsPCWY4PCFAGOV
         XF7KuWLtqlR7fO9djP/YDiPl/wpqJVKY3gzg0QrScziG2gDBhlF7kFUrvLkqgJtTXdoC
         nWpw==
X-Forwarded-Encrypted: i=1; AJvYcCV3sTCHVrgNEkLUDC2urfHajFaXw3cGzCnOHHQs1Emb8rxQZL1zK066t9VH7KQT9hX6ZIYxJL4/62fj0Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZawsdWogeNOA1BZnhfxIFp6gsSUvbDvZfLmLsMQo3WyestGa9
	a+7d6hTcwCml5FzLirQgluoABFsj6BIXmm53xbGo0iIRFmZCrOZaa3bL1N+rD2mcMqs4741p/TU
	s6ppGa8wZw+q846nFy5vSwwYgXo5osIJD584ixYVXxmvN+isSi3MzeMt+s8YEVg==
X-Received: by 2002:a17:907:3f99:b0:a9a:222f:45d1 with SMTP id a640c23a62f3a-a9de5ce1d86mr152761166b.20.1729937279787;
        Sat, 26 Oct 2024 03:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyVbPOLF9L610dafH2YTf7Fbi2HCJ+cVQCxg+j2BUi0oNI0UU57ulAhkGPndhJ495oTGCV7g==
X-Received: by 2002:a17:907:3f99:b0:a9a:222f:45d1 with SMTP id a640c23a62f3a-a9de5ce1d86mr152757366b.20.1729937279283;
        Sat, 26 Oct 2024 03:07:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a08a70fsm158793966b.224.2024.10.26.03.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:07:58 -0700 (PDT)
Message-ID: <157637ca-beaa-4b02-9938-d23b8af3c9d8@redhat.com>
Date: Sat, 26 Oct 2024 12:07:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] ACPI: platform_profile: Only remove group when no
 more handler registered
To: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-7-mario.limonciello@amd.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241025193055.2235-7-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Oct-24 9:30 PM, Mario Limonciello wrote:
> As multiple handlers may register for ACPI platform profile handler,
> only remove the sysfs group when the last one unregisters.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/acpi/platform_profile.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 81928adccfade..091ca6941a925 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -23,6 +23,15 @@ static const char * const profile_names[] = {
>  };
>  static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>  
> +static bool platform_profile_is_registered(void)
> +{
> +	struct list_head *pos;
> +	int count = 0;
> +	list_for_each(pos, &platform_profile_handler_list)
> +		count++;
> +	return count > 0;
> +}
> +
>  static ssize_t platform_profile_choices_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -206,8 +215,10 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
>  
>  	list_del(&pprof->list);
>  
> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>  	cur_profile = NULL;
> +	if (!platform_profile_is_registered())
> +		sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);


