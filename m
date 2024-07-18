Return-Path: <linux-kernel+bounces-256063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF60993487F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD971C219BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA3D7581A;
	Thu, 18 Jul 2024 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM8GYjKI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D64C62E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286252; cv=none; b=J74UHzWw3PVAoD3K+XzK0XkPOSQN4qBhLuvRGHlEs41tNie6eRRz0qsnGH/TaLj/noavFrFpbkXCa5QfxSgT3bWMy9AJLreJ1ELno3niB16ZbCJEtTYmRmTasHnYICtPEhBHmQxMhd+xIVrYPn/bBWQq9n1GYKa6bNghO0vZZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286252; c=relaxed/simple;
	bh=Qy5XXJ89Ktic3Aa1K9odT3n9Ohijkwg0eluVKDn6+pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QuW2VcDAN9QJsL27a4y3bjAR9tnH6LMl1dWuxdlDx9mojLMLTz/MZPAuMmifAbXf5M0PtJKpX3NHWsSbWdiUMveRCzE1lz8OSxmU+F5RxAv8aoOAAT07PjdZJ2862NRfj4djTdUeOixVaNs4PIU5FD2lDjuY7PnobREkGXPGt4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CM8GYjKI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721286250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzJwnsiZ2ke6MzC/8F3MYwH+Ub1DtGJI2z59uDcufYU=;
	b=CM8GYjKI9iKBEsiWBOuHZLz1M8n1L7jcxGPA7GcXwoOJX5ZY1Yzv/4h+o2w+DVHTlU3eVI
	+EY9gYdEZohlIahqZNhsw/IzqnVUwkZDHacUNxA8l6MwOSzEgvQlSY+NJBVbu7JhZ37jQ8
	C/4UDt2nimCX8RgbGU5JrJDEs8nuMhc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Ql7QEc26OnyxK9cJI4Jdsw-1; Thu, 18 Jul 2024 03:04:08 -0400
X-MC-Unique: Ql7QEc26OnyxK9cJI4Jdsw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42490ae735dso4444695e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721286247; x=1721891047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzJwnsiZ2ke6MzC/8F3MYwH+Ub1DtGJI2z59uDcufYU=;
        b=KVIuOQiOETfILs/+n4tTdZ3u04hLtOodiPREYEOllH6x90sDP2927t0ORkD56hzLdv
         W6r60dqsYvEN5ANTuNnO9tg9CCGVktQZrAKimz6x0NiNZx+5jXHYK743OjT5v6EPu68B
         ku/2nYrX+GBZ+PCxY1RR/T30500/EevHIViuQtSoaXxXKq3pFrP+kS4/xf2WvjJMQEzv
         b03ydYCjF9FbjElZkXduUdcHioywvt8dki/qOmo3dHBQan/NMW5VEN7GL+o9L/ynLSwQ
         F9GzAONRHOJMb+ecGOJ487gqm9aqjQcWElBlCdUoB7CWUrh4M13qLotDmDRzKMGlOxGX
         I4/A==
X-Forwarded-Encrypted: i=1; AJvYcCWiVj6U2OYRVa1pD3BBboB8J1k6f+v8kmJwfO8kDNEnghZFFIt1DoDawsVF+RWx90Smk4YR5z5XNz7/W/7KPv/sLOrkXsm0yLxfqlcN
X-Gm-Message-State: AOJu0Yy1DwtLG2Bbn1tOIwSq+BOWq1MVVjMkE7gh4/KmhiE4u06YaR8k
	FjIJz8zxJT17PDl0YMXnibNQOPnBviFC8QFknl7ZE/vWJv8tLXRD1vG2oflOMEcGzj5KqfNGSad
	UmDScqMrzMpDEXYgUaMEeR/z8afRWhCpaVM9QcGt9mvwA8JRffPSTZc2wwyR2wg==
X-Received: by 2002:a05:600c:1f89:b0:425:64c5:5780 with SMTP id 5b1f17b1804b1-427c2cad7d5mr36509545e9.1.1721286247225;
        Thu, 18 Jul 2024 00:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/KUVPhRm2HpDoAZJMxonN2aOgQWPFNeB5yzFSNwGye7MxC3l02lsOkLZOMlNf7V+jEkpGEg==
X-Received: by 2002:a05:600c:1f89:b0:425:64c5:5780 with SMTP id 5b1f17b1804b1-427c2cad7d5mr36509225e9.1.1721286246782;
        Thu, 18 Jul 2024 00:04:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77d810dsm23762885e9.26.2024.07.18.00.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 00:04:06 -0700 (PDT)
Message-ID: <34305c58-38a6-4b5a-9777-69833aefa003@redhat.com>
Date: Thu, 18 Jul 2024 09:04:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/panic: Add drm_panic_is_enabled()
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
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <ZpfeiMj48JQTQcOE@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2024 17:08, Daniel Vetter wrote:
> On Wed, Jul 17, 2024 at 10:48:39AM +0200, Jocelyn Falempe wrote:
>> It allows to check if the drm device supports drm_panic.
>> Prepare the work to have better integration with fbcon and vtconsole.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_panic.c | 20 ++++++++++++++++++++
>>   include/drm/drm_panic.h     |  2 ++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
>> index 948aed00595e..d9a25c2d0a65 100644
>> --- a/drivers/gpu/drm/drm_panic.c
>> +++ b/drivers/gpu/drm/drm_panic.c
>> @@ -703,6 +703,26 @@ static void debugfs_register_plane(struct drm_plane *plane, int index)
>>   static void debugfs_register_plane(struct drm_plane *plane, int index) {}
>>   #endif /* CONFIG_DRM_PANIC_DEBUG */
>>   
>> +/**
>> + * drm_panic_is_enabled
>> + * @dev: the drm device that may supports drm_panic
>> + *
>> + * returns true if the drm device supports drm_panic
>> + */
>> +bool drm_panic_is_enabled(struct drm_device *dev)
>> +{
>> +	struct drm_plane *plane;
>> +
>> +	if (!dev->mode_config.num_total_plane)
>> +		return false;
>> +
>> +	drm_for_each_plane(plane, dev)
>> +		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
>> +			return true;
>> +	return false;
>> +}
>> +EXPORT_SYMBOL(drm_panic_is_enabled);
> 
> This feels like overkill since you currently only have one user in the
> fbdev emulation code, but maybe useful in some other places ...
> 
>> +
>>   /**
>>    * drm_panic_register() - Initialize DRM panic for a device
>>    * @dev: the drm device on which the panic screen will be displayed.
>> diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
>> index 73bb3f3d9ed9..c3a358dc3e27 100644
>> --- a/include/drm/drm_panic.h
>> +++ b/include/drm/drm_panic.h
>> @@ -148,11 +148,13 @@ struct drm_scanout_buffer {
>>   
>>   #ifdef CONFIG_DRM_PANIC
>>   
>> +bool drm_panic_is_enabled(struct drm_device *dev);
> 
> Since it's internal only, this should be in
> drivers/gpu/drm/drm_crtc_internal.h and not int he include for drivers.

Yes, that makes sense, drivers won't need that API.

> With that:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
>>   void drm_panic_register(struct drm_device *dev);
>>   void drm_panic_unregister(struct drm_device *dev);
> 
> These two are only used in drm.ko. Can you please move them to
> drm_crtc_internal.h too and drop the EXPORT_SYMBOL in a follow-up patch?
> We're trying to limit the exported interface and official headers to
> really only the pieces drivers actually need.

Sure, I'll add this to my next drm_panic series.

> 
> Thanks, Sima
> 
>>   
>>   #else
>>   
>> +bool drm_panic_is_enabled(struct drm_device *dev) {return false; }
>>   static inline void drm_panic_register(struct drm_device *dev) {}
>>   static inline void drm_panic_unregister(struct drm_device *dev) {}
>>   
>> -- 
>> 2.45.2
>>
> 

Best regards,

-- 

Jocelyn


