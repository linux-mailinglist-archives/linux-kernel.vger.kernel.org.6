Return-Path: <linux-kernel+bounces-225010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94261912A85
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD7CB2AE29
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B34155313;
	Fri, 21 Jun 2024 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeWo22ks"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2021534ED
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984581; cv=none; b=jAAw52VuguC3Dd0fhcctEm8DBMzX8/mrGG6e1ww8DfE0G/uJSOf1A7MhtGrkkgIhJewatayExHLmzHjzuRL0kinZvtMkKC87Fy0O2X2VLc96VwQujE/IKfoBr1PetXKwC+2Fn0dYdjioAlTwLyAaZR2jt0SRnXDKNdY9xp4yZlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984581; c=relaxed/simple;
	bh=gCC64W7ORXL0L0ectsYOplnILeWtSh6BU978rTWjcuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FFViWF+hqisLgT73Y3O6DrQQnZuQoXnenehr9r9bcbcVMDCre29m+BAh3Y6faGKFKrWsReiv6eGO6DlBrghq075qAb3f9pLxBtpHGFsRsqjr4SpivTebhwAoU2PmZYPXrRVSSSuAR7lqY4eT4l92HjK290zt7uhaWfLG8UCS4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EeWo22ks; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718984578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8padAC2vgZoYm5gMWgM5Jxwrly13NFf+7Nho49URbpE=;
	b=EeWo22ksrY0Kr4l7bU0s0MyBhylNxIdimT17s2Z9gZSzjND/RQsJ0v1HOyq4M+SR8Cr41Q
	kBMOND6iRhx9AiKmyOZGeNlIUzgnfmlrxVkGj3vlYTW10tiDfIBqtoE+SKwxYWJobtld8c
	JUDNYmIczRxm9Optej07oA1LdfC8Emw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-jyskglFcO4KGbibDYzqrmA-1; Fri, 21 Jun 2024 11:42:57 -0400
X-MC-Unique: jyskglFcO4KGbibDYzqrmA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ec4df4e2e8so7212781fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984575; x=1719589375;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8padAC2vgZoYm5gMWgM5Jxwrly13NFf+7Nho49URbpE=;
        b=sIhElTM7bYy2McdE/sym2qKeOAmKIhpuTDA4k4Jq7G+fJzMmoeBELxPlt6O7ddpEse
         32ciFDz4hyYEzHzFd+rYGhOmzAXftzNsHroZedFtlER8IU8bIuf1hHwYMAseZd9ULQeN
         /lBBrfKjzc4XdAeOdW6pW862BenArq7cbTfJdHOQz4b0f9PATYdMDL8bN2joDYgrsgEE
         b9ivm49lbPvLVeV1VNlN/2I9kl2gA9mdzcAdkgIWaMUEG8w3IiqBclG39+oGSPCgkD0P
         GNcDvwRrL6HssnJBW31Dib2IGOmG/54TG4nJlBnt/nWP6X7lw5rgX8PPbnCge8A8zikb
         CLfA==
X-Forwarded-Encrypted: i=1; AJvYcCWgKmW5dNW2EF2cIBEkAWe1fEdzxYNfFAOv6VIa1b+1FkNjAJWX4pkVJyAqff21hEK7aTwcLA00Gb3iJgb/8EzH19Q55uN+ngBJ9/e2
X-Gm-Message-State: AOJu0YwaQ4/Y38urkJPEatmKyxe0EzLV9n4MYsR2BpUReIbw2ne9go83
	VozWdiOiaz6ypC+Wrhp27Ywnw5nc0muHXvgr5oZFGUZR1aPPDbNt/Xe0r00E1Dzkl+qEpM25nJM
	3LWS0yw6lgsmA78VQB3n70K0yAKuhZo3EnMnWTQTuohmDt7n/el4JX78aaEgFIg==
X-Received: by 2002:a2e:87c2:0:b0:2ec:50dc:af8d with SMTP id 38308e7fff4ca-2ec50dcb1c0mr10844061fa.12.1718984575415;
        Fri, 21 Jun 2024 08:42:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcL/uAmvTw3Xz4SGTKYWK4KNhLBx9ctCWYZtT7LlItr1HRHTMUIIoIfC6SGU42CcZuFEWfeQ==
X-Received: by 2002:a2e:87c2:0:b0:2ec:50dc:af8d with SMTP id 38308e7fff4ca-2ec50dcb1c0mr10843901fa.12.1718984574941;
        Fri, 21 Jun 2024 08:42:54 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a9f11sm31899275e9.18.2024.06.21.08.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:42:54 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Add drm_panic support
In-Reply-To: <87h6dmjry6.fsf@minerva.mail-host-address-is-not-set>
References: <20240620222222.155933-1-javierm@redhat.com>
 <24205cdf-a3c6-475e-ba8a-a52d039a402d@redhat.com>
 <87h6dmjry6.fsf@minerva.mail-host-address-is-not-set>
Date: Fri, 21 Jun 2024 17:42:53 +0200
Message-ID: <87ed8qjo8y.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Javier Martinez Canillas <javierm@redhat.com> writes:

> Jocelyn Falempe <jfalempe@redhat.com> writes:
>
> Hello Jocelyn, thanks for your feedback!
>
>> On 21/06/2024 00:22, Javier Martinez Canillas wrote:
>>> Add support for the drm_panic infrastructure, which allows to display
>>> a user friendly message on the screen when a Linux kernel panic occurs.
>>> 
>>> The display controller doesn't scanout the framebuffer, but instead the
>>> pixels are sent to the device using a transport bus. For this reason, a
>>> .panic_flush handler is needed to flush the panic image to the display.
>>
>> Thanks for this patch, that's really cool that drm_panic can work on 
>> this device too.
>>
>
> Indeed, that's why I did it. Just to see if it could work :)
>
> [...]
>
>>> +static void ssd130x_primary_plane_helper_panic_flush(struct drm_plane *plane)
>>> +{
>>> +	struct drm_plane_state *plane_state = plane->state;
>>> +	struct ssd130x_plane_state *ssd130x_plane_state = to_ssd130x_plane_state(plane_state);
>>> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>>> +	struct drm_crtc *crtc = plane_state->crtc;
>>> +	struct ssd130x_crtc_state *ssd130x_crtc_state = to_ssd130x_crtc_state(crtc->state);
>>> +
>>> +	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &plane_state->dst,
>>> +			     ssd130x_plane_state->buffer, ssd130x_crtc_state->data_array,
>>> +			     &shadow_plane_state->fmtcnv_state);
>>
>> ssd130x_fb_blit_rect() will call regmap->write(), which involve mutex 
>> and might sleep. And if the mutex is taken when the panic occurs, it 
>> might deadlock the panic handling.
>
> That's a good point and I something haven't considered...
>
>> One solution would be to configure the regmap with config->fast_io and 
>> config->use_raw_spinlock, and check that the lock is available with 
>> try_lock(map->raw_spin_lock)
>> But that means it will waste cpu cycle with busy waiting for normal 
>> operation, which is not good.
>>
>
> Yeah, I would prefer to not change the driver for normal operation.
>

Another option, that I believe makes more sense, is to just disable the
regmap locking (using struct regmap_config.disable_locking field [0]).

Since this regmap is not shared with other drivers and so any concurrent
access should already be prevented by the DRM core locking scheme.

Is my understanding correct?

[0]: https://elixir.bootlin.com/linux/v6.10-rc1/source/include/linux/regmap.h#L326

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


