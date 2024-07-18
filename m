Return-Path: <linux-kernel+bounces-256220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940AB934AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A081C2149D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2B37D3EF;
	Thu, 18 Jul 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTFcveIE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73A8002E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721295014; cv=none; b=lPZkN7vshESwKe9JdpUFMvp9KfZrJWH8ko8h5bLLGkAJmKqscqQnyLWAX4hAPmhQPAlvvRxRiQcio+5E11htwrFlpCjHLbRSl8yOnhOPcPEek7TBX4ZS4rXEzLWIWHLOotZDKC2+o+yRcyRh9vLvmz4d3B4gvlA4q+YWlWcfQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721295014; c=relaxed/simple;
	bh=jaPjAHgp3deTV1Hq8fkYFnQEa60iTiIYvv2Kc0Wj2KQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=KUUNmv7DzoToV4z8BIW3ghemCfaKSVXtTrRizz9JxonD6xrN1onyUe7V5S8FKtFa8DbNv6liAhZE0vaG3sVc7iWAThBkINQRA/XOa0isP4pfS++PqQr9RKfPXMTq5ci9j6U/OTK1LJ86v+r2uu2kIyDXAEwI7HYj4oTeltCL3ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTFcveIE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721295011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9q9HLC7V8MLZ80zJXfERHHxdoqrkWdriaq68Cy7rAuA=;
	b=hTFcveIE2UJM/N1l+u2lJ7OGRbfBHK9QNCVLI1kMeF/kbP0Hl2INszc9uvLMGN+6thPvnx
	jfPxh3OV98M/qvwdGNhpPBfJjJWymem5VJVcSbkXYX3mBsOLLR/Kw6utkTTnJHbnUKdV6w
	cZnSt+qLE9BTLiocBSs0bvPY1UkZc4Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-R9CAqvucPWq1rZTNWTMi3w-1; Thu, 18 Jul 2024 05:30:08 -0400
X-MC-Unique: R9CAqvucPWq1rZTNWTMi3w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4265464ddc9so584455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721295007; x=1721899807;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9q9HLC7V8MLZ80zJXfERHHxdoqrkWdriaq68Cy7rAuA=;
        b=qNcrto+xYARN/a+LBDeOUMWU4gjzDekOt7E9SP0tcXUYQ7OjlRqxCuzKo/Epfq45LS
         H9BEx6RZaw/P9qBggM6OFKLZaVIu48QuU33Z9oPb3Q27c5lWXlVthgYsHTEhYK6Bvzdl
         SDXdeli/OySPvkJ+nJDazKjkfbJThoPzcAc+7/aPV/NgOnKnXHg3eJmK9wce0PlnsIDD
         ZOzate3t5/LWzaGAC4PpmTSKmTFa736pZ5h1FDSUzboU1KtLmsO/9bdnmakX58t7aO1y
         rKl0TAwiHpuXBSs64k5peNE+sBp1O6DMGZQOdTm/Ob5j6wQVBsrA5oeRUU06IuEGqFrt
         aUwA==
X-Forwarded-Encrypted: i=1; AJvYcCXQlie06opJsxc8jPSzmopAYfvbzIeXUfBmhgIHKuOf99X70Zy7lbHx021RfXnIDnEVmg99kpDsKT3a2G2NushUSxNJgaEfYk/vu5KT
X-Gm-Message-State: AOJu0Yxg19Es34gohq7o5C6XP6CdsWL1LxwG10YgllK77qmRHO5RCCOL
	YqA7Ks4WlLIzIZAxf0fLAh1AYTYFzhbxzbClzvRm11Yz4GmaY34fiLIznvS+tr4m9LDMc0i3Lx0
	qVNhB7LEuHOK0YcrxDL97OIaNTrryYU6A/6qCdnrhNlFj65FHbsGbJ0SBiObwsQ==
X-Received: by 2002:a05:600c:1c9d:b0:426:711c:6591 with SMTP id 5b1f17b1804b1-427d2a85815mr2795415e9.4.1721295007407;
        Thu, 18 Jul 2024 02:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+8ttf1s3egHR+h5cLkePronykxkc0Zd3hb0OjoNA8amSZdiUzePN3sl9hakq1rcMyxyqpXw==
X-Received: by 2002:a05:600c:1c9d:b0:426:711c:6591 with SMTP id 5b1f17b1804b1-427d2a85815mr2795035e9.4.1721295006929;
        Thu, 18 Jul 2024 02:30:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b1f1e1sm3094685e9.30.2024.07.18.02.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:30:06 -0700 (PDT)
Message-ID: <60419d31-f467-4277-97da-23c9573af2bf@redhat.com>
Date: Thu, 18 Jul 2024 11:30:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/panic: Add drm_panic_is_enabled()
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-2-jfalempe@redhat.com>
 <ZpfeiMj48JQTQcOE@phenom.ffwll.local>
 <34305c58-38a6-4b5a-9777-69833aefa003@redhat.com>
Content-Language: en-US, fr
In-Reply-To: <34305c58-38a6-4b5a-9777-69833aefa003@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/07/2024 09:04, Jocelyn Falempe wrote:
> 
> 
> On 17/07/2024 17:08, Daniel Vetter wrote:
>> On Wed, Jul 17, 2024 at 10:48:39AM +0200, Jocelyn Falempe wrote:
>>> It allows to check if the drm device supports drm_panic.
>>> Prepare the work to have better integration with fbcon and vtconsole.
>>>
>>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>>> ---
>>>   drivers/gpu/drm/drm_panic.c | 20 ++++++++++++++++++++
>>>   include/drm/drm_panic.h     |  2 ++
>>>   2 files changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
>>> index 948aed00595e..d9a25c2d0a65 100644
>>> --- a/drivers/gpu/drm/drm_panic.c
>>> +++ b/drivers/gpu/drm/drm_panic.c
>>> @@ -703,6 +703,26 @@ static void debugfs_register_plane(struct 
>>> drm_plane *plane, int index)
>>>   static void debugfs_register_plane(struct drm_plane *plane, int 
>>> index) {}
>>>   #endif /* CONFIG_DRM_PANIC_DEBUG */
>>> +/**
>>> + * drm_panic_is_enabled
>>> + * @dev: the drm device that may supports drm_panic
>>> + *
>>> + * returns true if the drm device supports drm_panic
>>> + */
>>> +bool drm_panic_is_enabled(struct drm_device *dev)
>>> +{
>>> +    struct drm_plane *plane;
>>> +
>>> +    if (!dev->mode_config.num_total_plane)
>>> +        return false;
>>> +
>>> +    drm_for_each_plane(plane, dev)
>>> +        if (plane->helper_private && 
>>> plane->helper_private->get_scanout_buffer)
>>> +            return true;
>>> +    return false;
>>> +}
>>> +EXPORT_SYMBOL(drm_panic_is_enabled);
>>
>> This feels like overkill since you currently only have one user in the
>> fbdev emulation code, but maybe useful in some other places ...
>>
>>> +
>>>   /**
>>>    * drm_panic_register() - Initialize DRM panic for a device
>>>    * @dev: the drm device on which the panic screen will be displayed.
>>> diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
>>> index 73bb3f3d9ed9..c3a358dc3e27 100644
>>> --- a/include/drm/drm_panic.h
>>> +++ b/include/drm/drm_panic.h
>>> @@ -148,11 +148,13 @@ struct drm_scanout_buffer {
>>>   #ifdef CONFIG_DRM_PANIC
>>> +bool drm_panic_is_enabled(struct drm_device *dev);
>>
>> Since it's internal only, this should be in
>> drivers/gpu/drm/drm_crtc_internal.h and not int he include for drivers.
> 
> Yes, that makes sense, drivers won't need that API.
> 
>> With that:
>>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>>>   void drm_panic_register(struct drm_device *dev);
>>>   void drm_panic_unregister(struct drm_device *dev);
>>
>> These two are only used in drm.ko. Can you please move them to
>> drm_crtc_internal.h too and drop the EXPORT_SYMBOL in a follow-up patch?
>> We're trying to limit the exported interface and official headers to
>> really only the pieces drivers actually need.
> 
> Sure, I'll add this to my next drm_panic series.

I think this also applies to drm_panic_init() and drm_panic_exit(), that 
I introduce in my QR code series:
https://patchwork.freedesktop.org/patch/604890/?series=135944&rev=2
I will move them to drm_crtc_internal.h

> 
>>
>> Thanks, Sima
>>
>>>   #else
>>> +bool drm_panic_is_enabled(struct drm_device *dev) {return false; }
>>>   static inline void drm_panic_register(struct drm_device *dev) {}
>>>   static inline void drm_panic_unregister(struct drm_device *dev) {}
>>> -- 
>>> 2.45.2
>>>
>>
> 
> Best regards,
> 


