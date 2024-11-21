Return-Path: <linux-kernel+bounces-416952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63F19D4CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEC828367B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270561D2B13;
	Thu, 21 Nov 2024 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxngL843"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609E16F288
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192347; cv=none; b=dhcYs/l6VWWdu8fqpg8lA5R3jO0moDPXBmaPnPL2FvOZYYNK2+nQsuNhAq4pDGpmRTRHyYK++BghODC877USJ6ciEZVGt4TsCWMzB7eQDWJJd/IqwXyd8wUp2DibcKM/THMme69WNTdYx0nQNJ9jndhqJrzKfjnBAr9d3DrdXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192347; c=relaxed/simple;
	bh=QwZdl4lGg0mEF50f83leK+b8rgaWY7VFme1mK70Es38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2i6tbCJe4aaiRZ7Bbe40yN+JAGVYQEZqdES1FX4/q1Akp4hWptELWvSGyjVkR/jvw8jBTwmAzckcGe0PAbBWk56P4wPmL81GIL+nEKdLdzUFK2Mw/qKiPlL6iP147+2mpzVFcW99JvUeG68mHPb6f5W8u9f7bvJ2/ual408jks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxngL843; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732192344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxfyKUiZJ1KBeMytmHKG09V4n3aOdLmHKG61uu7Jj/4=;
	b=QxngL843ME7KkV6YpIbDe4DhM9bAlQu4Clrm9pPwxhhBSLaADIYYFQ3ym3zGWiknaJx1TY
	PkHq1rI8BFNIRJ7zk4f7XaYJG6Kkw0PwaQ8HS3nb1DBq5k1CkVsIp+2HWZPl3Y6kOABHuN
	twODJI/d+/QNFJE6YhYNLpFg8akABqE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-SGvLdEpQMcCcx4dwCgxWyQ-1; Thu, 21 Nov 2024 07:32:23 -0500
X-MC-Unique: SGvLdEpQMcCcx4dwCgxWyQ-1
X-Mimecast-MFC-AGG-ID: SGvLdEpQMcCcx4dwCgxWyQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a2a81ab82so71698666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732192342; x=1732797142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxfyKUiZJ1KBeMytmHKG09V4n3aOdLmHKG61uu7Jj/4=;
        b=fhCGssxf5ybyp+678Z3CLu24ZV0z4dh7Omt4apMvXwsM6yIn4mjCdaOhNoWnhLo6iM
         1AjIoJtamSv0rAYgGZu7HqDi//EuuuHyXBLhWiMZ2tqJRgAD191OjVITCikpu/J4ug0u
         Bli2zoP9+yrcfMevFHrk/p7DJYN7p6g6V2sTVUPakwro0EvFYweHHTPqSKUM7pg1kXA1
         D3wawLyoqu2oaQBXqkhUviQny1DVqmNBooAWmcZ/SQymRxlNTkMhFPO7z9i12OgXtXPK
         /bS9qDEHM7XnRrXAGJxt2mUBpybE07WeReNWUGvBgnTIGihZ8OQqCfIouu/a/0sfB2PN
         4kiQ==
X-Forwarded-Encrypted: i=1; AJvYcCULg7jWkY3oJjDLMzjurWl+XEMydyyaeKMElKCZLLJ+kt/gcagfGbcbffzsnmOYr0Umho8jEz9MgTI7c/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5IQptn8GcZwIz/MzcFPAdxnz5mo1pd7sWqteW12ApjFXd9G33
	PykM5EeTVzkBH+TkK1iAOp5m6pQ0dDvtiGf/7tLYhf/9dRnyZld+OAjtyV+mOXqHLCQBXz5kNTU
	f4d+/EBo5VIQjY+Wel5cGvgjyHHUYF7wCsJtR4zrhuufBL4cpT0m0Vjd78amGZH+eaGXMTw==
X-Gm-Gg: ASbGncv1/BAGBFFkZNaG9SD/JDtODyUh/lJk1zv/viiWRCO7Z4uToVEqIG+XQnqIbUW
	4qt7U7+DaXg/LLo2UGazYkrDUf4eV2shxDZPUgz/EjrZHb/E2YJytQCfv2H47wwKteL/LOez9U+
	Kf03UbSl1A8l6e5Yq3LFVm6ETP7GEjxARhTKbYKGWrc+HvyhhEiLNRZfZyNq5WMJBucWbXiS/Gl
	UMBAxEXF/l1fRQ8yfMiWIuSg5/RdDyUA0ySez3embfAfwpRCBpK5FWUiLTRd+sDilA0gSsusa/1
	cTspX56Ekj4NrKawKXSQ3fsoOOmRCl93f3I85+K0w+jQcvw26CkGSWCMz4kYHmWZwA8nk0spShy
	y9ufMkJFhQjIod35nNnRd6uq6
X-Received: by 2002:a17:907:3f86:b0:aa4:c721:fac0 with SMTP id a640c23a62f3a-aa4dd70a23bmr576556766b.40.1732192342082;
        Thu, 21 Nov 2024 04:32:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh1VyObGO8bboXNJYexUhCB0NWAlGuUkabDTjrSZWwxnNUX+JXmWIlviX9WQrffuLClyMCkQ==
X-Received: by 2002:a17:907:3f86:b0:aa4:c721:fac0 with SMTP id a640c23a62f3a-aa4dd70a23bmr576554066b.40.1732192341714;
        Thu, 21 Nov 2024 04:32:21 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4180201sm77296866b.67.2024.11.21.04.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 04:32:21 -0800 (PST)
Message-ID: <fd19d849-de80-4806-9757-b74bb373ad0e@redhat.com>
Date: Thu, 21 Nov 2024 13:32:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: x86-android-tablets: make platform data be
 static
To: Pei Xiao <xiaopei01@kylinos.cn>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
References: <202410160432.oJAPbrW9-lkp@intel.co>
 <daafd1371e7e9946217712ce8720e29cd5c52f7a.1732161310.git.xiaopei01@kylinos.cn>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <daafd1371e7e9946217712ce8720e29cd5c52f7a.1732161310.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 21-Nov-24 4:55 AM, Pei Xiao wrote:
> make lenovo_yoga_tab2_1380_bq24190_pdata and lenovo_yoga_tab2_1380_modules
> to be static
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410160432.oJAPbrW9-lkp@intel.com/
> Fixes: 3eee73ad42c3 ("platform/x86: x86-android-tablets: Add Lenovo Yoga Tablet 2 Pro 1380F/L data")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/platform/x86/x86-android-tablets/lenovo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
> index ae087f1471c1..a60efbaf4817 100644
> --- a/drivers/platform/x86/x86-android-tablets/lenovo.c
> +++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
> @@ -601,7 +601,7 @@ static const struct regulator_init_data lenovo_yoga_tab2_1380_bq24190_vbus_init_
>  	.num_consumer_supplies = 1,
>  };
>  
> -struct bq24190_platform_data lenovo_yoga_tab2_1380_bq24190_pdata = {
> +static struct bq24190_platform_data lenovo_yoga_tab2_1380_bq24190_pdata = {
>  	.regulator_init_data = &lenovo_yoga_tab2_1380_bq24190_vbus_init_data,
>  };
>  
> @@ -726,7 +726,7 @@ static const struct platform_device_info lenovo_yoga_tab2_1380_pdevs[] __initcon
>  	},
>  };
>  
> -const char * const lenovo_yoga_tab2_1380_modules[] __initconst = {
> +static const char * const lenovo_yoga_tab2_1380_modules[] __initconst = {
>  	"bq24190_charger",            /* For the Vbus regulator for lc824206xa */
>  	NULL
>  };


