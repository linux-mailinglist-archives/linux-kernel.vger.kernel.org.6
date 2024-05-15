Return-Path: <linux-kernel+bounces-180209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E017F8C6B77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730001F24264
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E120E45014;
	Wed, 15 May 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5zv+li1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D57828680
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794169; cv=none; b=U1HQ5yJ2BgzACLLZXShFGZuYc3xf22FTE5Sk9N+NO6GDufe7LVNDL2jZ4UHogaw39N4M1bLmZmVtZeYzi5hSXTbk7c3hIWyIHU52rvD0E+SzNv7m6odzhcGh35tNtOL1NI3dR53l/SBKIVqANcXXJ0rOI11fYNGsaZLSVNBUprw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794169; c=relaxed/simple;
	bh=f/iuzZMlmH508xLuK+c3POd1uCl01loh39/9JbXRo/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6XwZpwDCS0VauSxrEls5MK3s8IPuq5SciKkD3SHnFWc1gudeIZnoFTQPdgwF59h9TFKVU7WHVNTSSz/G2uK3czUjtH9TndIlIbE6dW8RG+x4q6tms6whwQTuSEpN45PiZIc8ZYdvt680RjBJ5Zu9A4QWXnZf8v6DF0OT7izTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5zv+li1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715794166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RAfbkl7wDlhHLUu1WDwZPQgfI6VIwQuAvbx4geCCHEk=;
	b=h5zv+li16MTDYQXgdMGuE3zbOJZgb0orcqftQ77EZ076eYkgeaOY2xsC49/6EKhVBlfJqj
	zSnyhs5RdGSoHOu86tQ70DqDicgsN2kVxKee5IkStWL1DuQSabS/ua2OVv0OG1A2gTt+qy
	5MVImTSJTX/NjE3tQdPC4TEy1FvsgHI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-3sWVtM0-O3msrkVUxV6Hvw-1; Wed, 15 May 2024 13:29:19 -0400
X-MC-Unique: 3sWVtM0-O3msrkVUxV6Hvw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-522362e8317so5027529e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715794158; x=1716398958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAfbkl7wDlhHLUu1WDwZPQgfI6VIwQuAvbx4geCCHEk=;
        b=fW2BTNiE1inTpglu7LW0wIdJNczbtohMKl2uV3VJid7x4L+xMJzAujxS2KTxqVAdqJ
         0ltYYtY6KWmxtKB+xqE+uomq0bI4jgNVnMJ57tFJR0htI10+qR4uHs80TGboQlZZoMCf
         A0G4hkS7IKds5xRSIbJfT2mKNAFM2wE6jD5yOMLY9geQaMBbY+TQ6Wxju959ufXypDxl
         ztp3e1OeRY7ZEx2IHIvPacgl9hFWXxv3voYdHr7tXpdEUsrIGkBxuv8aWsbdFyn7Xge9
         J1VHAm1Olz4Y965lrjUeiG4udoDxkpud4OKn4MUz+B4MrcYGayq27m36AZfksURVrxrW
         xkHg==
X-Forwarded-Encrypted: i=1; AJvYcCWmej6FdiyNdlMuIfSpwjqErMRGTRgFcxm+2lle5G8IiA+bw1dZ6ws63/bdbD+WWf7hk2ewwjdbGDwZAVFjsH+ODpAw1kIeOAQ+a/Pt
X-Gm-Message-State: AOJu0YyBasOvk2bntXcn1uMtnGuJEhqrDdFoErY7dWYi1B+q9B+16jOk
	rD0PAThxnznNjIGmG9TbpEYfDGNSRHUAjh0dvHFMose+c0xVLYkUU/gYvLBGI71/oODS3ThONny
	XqlC8+923w70HslMfHQrOL+l2B3QjEJB+QSdu80s3vwboxAmDqw2I/fWJzELfCQ==
X-Received: by 2002:ac2:4e11:0:b0:516:d232:2516 with SMTP id 2adb3069b0e04-5220fc7c59amr15507432e87.6.1715794158268;
        Wed, 15 May 2024 10:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDrCwDGj4XtoQfDTNZCsTDx1LFrxlRKr0DQD3VjW8RoHfkTcT7e3ifieXQ/Csi1JyJ3zpPXg==
X-Received: by 2002:ac2:4e11:0:b0:516:d232:2516 with SMTP id 2adb3069b0e04-5220fc7c59amr15507407e87.6.1715794157745;
        Wed, 15 May 2024 10:29:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17844sm879836966b.190.2024.05.15.10.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 10:29:17 -0700 (PDT)
Message-ID: <04271fb5-cca3-4bca-b98e-3fab8a78c724@redhat.com>
Date: Wed, 15 May 2024 19:29:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Use vendor backlight on Lenovo X1 Carbon.
To: dengxiang <dengxiang@nfschina.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 prime.zeng@hisilicon.com, rafael@kernel.org, tony.luck@intel.com,
 wanghuiqiang@huawei.com
References: <20240515034501.12772-1-dengxiang@nfschina.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240515034501.12772-1-dengxiang@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi dengxian,

On 5/15/24 5:45 AM, dengxiang wrote:
> Hi Hans,
> 
>> A couple of remarks / questions:
> 
>> 1. Looking at the strings you match on this is not for a Lenovo X1 Carbon,
>> but rather for a Lenovo Kaitan model ?  So it seems that the commit message
>> and the comment for the quirk need some work.
> 
> ok, I will add DMI_PRODUCT_VERSION & DMI_BOARD_NAME to make a distinction between  X1 Carbon and other kaitian models.
> 
>> 2. I have never heard of a zx_backlight interface before and there certainly
>> is no upstream driver providing this. I believe you need to explain what
>> is going on in a bit more detail here and then we can see if this really is
>> the best way to fix this. It seems that these Lenovo Kaitan laptops are
>> using Zhaoxin Kaixian x86 processors with integrate graphics. I would expect
>> the zx_backlight interface to be provided by the driver for the Zhaoxin Kaixian
>> integrated graphics in this case. And if that is the case then the integrated
>> graphics driver should use BACKLIGHT_RAW (aka native) for the backlight type
>> and with that change this quirk should not be necessary .
> 
> Yes, zx_backlight interface has been provided by the driver for the Zhaoxin Kaixian integrated graphics. Also use backlight_device_register("zx_backlight",...).
> Strangely enough, X1 Carbon laptops will generate two native acpi_video as belows:
>  
> lrwxrwxrwx 1 root root 0  5月 14 16:20 acpi_video0 -> ../../devices/pci0000:00/0000:00:01.0/backlight/acpi_video0
> lrwxrwxrwx 1 root root 0  5月 14 16:20 acpi_video1 -> ../../devices/pci0000:00/0000:00:01.0/backlight/acpi_video1
> 
> As you see, it will conflict with the same pci bus, then zx_blacklight interface can't be shown on the path /sys/class/backlight/.
> That is to say, zhaoxin driver contain key code as belows:
> #if DRM_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
>     if(acpi_video_get_backlight_type() != acpi_backlight_vendor)
>     {
>         return ret;
>     }
> #endif
> 
> If i remove the key code, this laptops will generate two native acpi_video and zx_backlight on the sys backlight patch. Once add acpi_backlight=vendor parameter into kernel cmdline, 
> just zx_backlight interface has been left on the sys path, which mean that both acpi_video0 and acpi_video1 interface can not be found.

Ok, so the way this is supposed to work is as follows, there is a single
acpi_video_get_backlight_type() function which all backlight drivers are
supposed to use (and all in tree drivers do use).

This looks like this (simplified a bit, see drivers/acpi/video_detect.c):

enum acpi_backlight_type __acpi_video_get_backlight_type(bool native, bool *auto_detect)
{
	...

        /* Use ACPI video if available, except when native should be preferred. */
        if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
             !(native_available && prefer_native_over_acpi_video()))
                return acpi_backlight_video;

        /* Use native if available */
        if (native_available)
                return acpi_backlight_native;

	/* ... long comment explaining this ... */
        if (acpi_osi_is_win8())
                return acpi_backlight_none;

        /* No ACPI video/native (old hw), use vendor specific fw methods. */
        return acpi_backlight_vendor;
}

as you can see here acpi_backlight_video is only returned if available
(which it is in this case) *and* there is no native GPU backlight
driver or prefer_native_over_acpi_video() returns false.

Since there is no way for this function to know a native GPU driver
is supported it uses the native parameter passed to it for this,
so native backlight drivers, like the Zhaoxin Kaixian integrated graphics
driver must call a special helper, which internally calls the above
function with native=true. I think not calling that special helper
is why you see the acpi_video backlight devices, assuming you are
using a recent mainline kernel.

So that:

#if DRM_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
    if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
    {
        return ret;
    }
#endif

block you quoted should look like this when using recent upstream
kernels:

    if (!acpi_video_backlight_use_native())
    {
        return ret;
    }

Although that return ret looks weird, maybe hardcode 0 for success
(not registering is on purpose, so success ?)

Or to keep things compatible with multiple kernel versions use:

#if LINUX_VERSION_CODE >= KERNEL_VERSION(6, 1, 0)
    if (!acpi_video_backlight_use_native())
    {
        return ret;
    }
#elif DRM_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
    if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
    {
        return ret;
    }
#endif

Please give this a try, I believe you will not need a quirk
when the Zhaoxin Kaixian integrated graphics driver does
the right thing.

Regards,

Hans



