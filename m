Return-Path: <linux-kernel+bounces-377590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4269AC0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2317AB25872
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D954156641;
	Wed, 23 Oct 2024 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cm8QoREx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC5156883
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670650; cv=none; b=iGQF4Ek6469czBQMH1PWZdxATyyS2e3gH+T/tk88MUnqEWg5+V/JaCKaNRtUxO7jPDobDh8PSOPLemVM1Lom2skYfGgkYay4lUT17nwP14Wob8H684/AQRxiI3VFkX34Mgn7wVHrDw9BwnkKoKd7bDL7JTa8j4+XU4ye2YPw2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670650; c=relaxed/simple;
	bh=IF6aXsLxdWji6MMeujcJjCJobRyU7+rf13KAi63l6G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SL6gyug+of4W4WxCdHuq6fPS3/SjNe7YpjtMQcSBMhoeNQOGvVr10GFrHogw3cINiHpMhG6IRJ8NGzProoQALLh4O1lklpZNNZBHnFM6XX0a1JNeAv9VAGC12/S7vWY5MIR8rKx4csqF5oJlQiPc/dFqOPMb13qRdrlAXnXYd+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cm8QoREx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729670647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HJeCjnMIw12TEWY04xj2y1qbuaADV67keXH+V6fBEY=;
	b=cm8QoRExGv68lufHktfTBQiVtmI9vSlm8309GBPQKfYJGoIWoTgaYtaUyncn8z2fsGK4Rp
	JmjIRf0Wj02EMqGpljCx96n5cShuct4E52G4WWj8BrqVPbjuHOsGgRIA+/OLyclBcpj2PG
	cvbspreX3ovOfWY7KZbeioD/uQ41gOQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-6u5vn4wgPD2HkKapZoHdhg-1; Wed, 23 Oct 2024 04:04:06 -0400
X-MC-Unique: 6u5vn4wgPD2HkKapZoHdhg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43163a40ee0so39943335e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729670645; x=1730275445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HJeCjnMIw12TEWY04xj2y1qbuaADV67keXH+V6fBEY=;
        b=QBZUOcX32bZsXEcAq+YE++WsMRup5KPJXifxQB8814OV4KCy2iBq5U24Sfd3wv3LgK
         2zduD9IjMKY5aPeDJEbAj+vrtNtW1R9pNe6vFJwPLhBF4TLLCVssTVW1QyBHuKm3jk/N
         2EddfV7yMyBr5eTNVK4oAqxEy/hewgJqh/f91sbg2IO9bdqeTTFLgWbzpklzrs1ztDSA
         4lquueuDmuNq3qVWRgNhHsMjxGP2VvbZpp/riERO+Pq3I0MnbwwX5UnLjXV5a956v0PW
         Y/Q9us4DUxuwA6zoY6pobQ1ieS0IjdwAhsdlEaqFxVWLR6w2JVmnu6K3qTnZoUWCGWob
         MnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp4QPw8CffrVqNDRfuzkMqFFcl/9mVvzEo3BOCvh3DZq3z98MRK6jx1UT6H2DhzNT0VlMrbMf3nWrMbKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+hfU/AJue4zTzFTGAodiE9vUe8S8KF248a8aR++mBouoxSqI
	XrkaMzIE85VQYyCs2/2HNOOTesOrDurtr/ED1Eg5RKZmIRvQVvdKykZV8Pk7er9dFVV8/Qw7iqa
	XQMXs2EKlmJDvinNzv+YcV6X4V0IHEADny0uFPlwm7ac7kJqkcNSxWmAor2xEHA==
X-Received: by 2002:a05:600c:1e28:b0:426:627e:37af with SMTP id 5b1f17b1804b1-4318412fd23mr15814785e9.3.1729670644880;
        Wed, 23 Oct 2024 01:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxvfVsE8Z/Bj4nM5IJVIdgM3fqMDZ+BQkr47XiNieWjM3E3mpsBv2Zmc+c3HsbEOTIR8ZDBA==
X-Received: by 2002:a05:600c:1e28:b0:426:627e:37af with SMTP id 5b1f17b1804b1-4318412fd23mr15814545e9.3.1729670644357;
        Wed, 23 Oct 2024 01:04:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a365e5sm8357499f8f.21.2024.10.23.01.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 01:04:03 -0700 (PDT)
Message-ID: <44141638-4d8f-4e11-9ede-51cdb51d3a28@redhat.com>
Date: Wed, 23 Oct 2024 10:04:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/client: Remove unused
 drm_client_framebuffer_flush
To: Thomas Zimmermann <tzimmermann@suse.de>, linux@treblig.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241022232934.238124-1-linux@treblig.org>
 <20241022232934.238124-5-linux@treblig.org>
 <a56b486c-9341-41aa-a3ab-090f7ffd56d6@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <a56b486c-9341-41aa-a3ab-090f7ffd56d6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/10/2024 08:46, Thomas Zimmermann wrote:
> Hi
> 
> Am 23.10.24 um 01:29 schrieb linux@treblig.org:
>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>
>> drm_client_framebuffer_flush() was explicitly added in 2020
>> by
>> commit c9c03e3cf072 ("drm/client: Add drm_client_framebuffer_flush()")
>> but has never been used.
>>
>> Remove it.
> 
> I had a patchset to use this helper for fbdev emulation. It just needs 
> preparation in a number of drivers.

It is used by drm_log, which is under review.
Please don't remove it.

https://patchwork.freedesktop.org/series/136789/

-- 

Jocelyn


> 
> Best regards
> Thomas
> 
>>
>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>> ---
>>   drivers/gpu/drm/drm_client.c | 33 ---------------------------------
>>   include/drm/drm_client.h     |  1 -
>>   2 files changed, 34 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
>> index bfedcbf516db..5d10ad3c2ca5 100644
>> --- a/drivers/gpu/drm/drm_client.c
>> +++ b/drivers/gpu/drm/drm_client.c
>> @@ -552,39 +552,6 @@ void drm_client_framebuffer_delete(struct 
>> drm_client_buffer *buffer)
>>   }
>>   EXPORT_SYMBOL(drm_client_framebuffer_delete);
>> -/**
>> - * drm_client_framebuffer_flush - Manually flush client framebuffer
>> - * @buffer: DRM client buffer (can be NULL)
>> - * @rect: Damage rectangle (if NULL flushes all)
>> - *
>> - * This calls &drm_framebuffer_funcs->dirty (if present) to flush 
>> buffer changes
>> - * for drivers that need it.
>> - *
>> - * Returns:
>> - * Zero on success or negative error code on failure.
>> - */
>> -int drm_client_framebuffer_flush(struct drm_client_buffer *buffer, 
>> struct drm_rect *rect)
>> -{
>> -    if (!buffer || !buffer->fb || !buffer->fb->funcs->dirty)
>> -        return 0;
>> -
>> -    if (rect) {
>> -        struct drm_clip_rect clip = {
>> -            .x1 = rect->x1,
>> -            .y1 = rect->y1,
>> -            .x2 = rect->x2,
>> -            .y2 = rect->y2,
>> -        };
>> -
>> -        return buffer->fb->funcs->dirty(buffer->fb, buffer->client- 
>> >file,
>> -                        0, 0, &clip, 1);
>> -    }
>> -
>> -    return buffer->fb->funcs->dirty(buffer->fb, buffer->client->file,
>> -                    0, 0, NULL, 0);
>> -}
>> -EXPORT_SYMBOL(drm_client_framebuffer_flush);
>> -
>>   #ifdef CONFIG_DEBUG_FS
>>   static int drm_client_debugfs_internal_clients(struct seq_file *m, 
>> void *data)
>>   {
>> diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
>> index bc0e66f9c425..560aae47e06d 100644
>> --- a/include/drm/drm_client.h
>> +++ b/include/drm/drm_client.h
>> @@ -165,7 +165,6 @@ struct drm_client_buffer {
>>   struct drm_client_buffer *
>>   drm_client_framebuffer_create(struct drm_client_dev *client, u32 
>> width, u32 height, u32 format);
>>   void drm_client_framebuffer_delete(struct drm_client_buffer *buffer);
>> -int drm_client_framebuffer_flush(struct drm_client_buffer *buffer, 
>> struct drm_rect *rect);
>>   int drm_client_buffer_vmap_local(struct drm_client_buffer *buffer,
>>                    struct iosys_map *map_copy);
>>   void drm_client_buffer_vunmap_local(struct drm_client_buffer *buffer);
> 


