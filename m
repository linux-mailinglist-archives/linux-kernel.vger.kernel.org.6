Return-Path: <linux-kernel+bounces-405529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B399C5273
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E723B1F21B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7168F20EA2C;
	Tue, 12 Nov 2024 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2sSF7BX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B720D4E2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405105; cv=none; b=usDtuS85l+mt/XSIT5pHdXbRXmUF7JfOcv7GwuW2fgarQICskt+wC74Cap8zY9U8hRJPBsDa7Y5KXldVmWtvekbjhc+JtZMvUKxuI2gTT8YTG2fLNOKKjf/PKMVITDe81zNKG4qJCg195Y43qp/kIeNBE3msCTLKjT004C203NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405105; c=relaxed/simple;
	bh=ebbbUUyH1fZBSOiQXKlGxzMuNbwax5pFT1tXxYQ5jD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uYHKmRfNx2QwJ6XPWqkzhPiVV7mbLpUUtzK+fJP0cQvDPRixt4Ppqu7DoQYex3HYQQcDHFAt2+Tjv1RMHvtgSH39UEGg0iY7lqyZAD1I1f6lvH0YLE8uQ+OVLO72R/hHT3GHSQUyHAdhU0U0bcbMTwrMvnKWWqQUlcSegOug2bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2sSF7BX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731405102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsXJIOcU1Y8WPOzExqls3FXydBaj0wSBKcVoF/FpkwA=;
	b=F2sSF7BXxL+lTA1sYeSrLXsAVE4uxGi5LDgwU41f/7R/9PFnwzRmL11UCK+Yx6YoVFM7TT
	c4KErX5/cWRb8lMB0FCe61j3JZ8m4dxotZNREwqWCYAkMXW6hz0OS5YsNZwMrtQlEZ7VYD
	Wbwq3op14JpTWrP2TTENMoyTRlbhH6A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-okO3JnqUPRO9HbDbHb4xCw-1; Tue, 12 Nov 2024 04:51:41 -0500
X-MC-Unique: okO3JnqUPRO9HbDbHb4xCw-1
X-Mimecast-MFC-AGG-ID: okO3JnqUPRO9HbDbHb4xCw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d49887a2cso2944503f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731405100; x=1732009900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsXJIOcU1Y8WPOzExqls3FXydBaj0wSBKcVoF/FpkwA=;
        b=VquYphKSMrxMfGuC0r3vs2AFH3/ZOM3Jw0uAfRCYsMo5Q0AIneBxhzoCYXUoUwPmLs
         ZQarjYc1AUyHYACp7YqJQkkQ9uasCoRSkKwXiaCkg2IJdB6DHiXfgJqbmWJQDEaQ9puB
         c5Aq9JsIp2O8/ivqkAJkATcMnT39dJ5795f8usWD2Sk9BbBORR/0rHBabPEx6WY0ROHC
         kxGzH24QnBbXJM7fB2ygHxT1LG36mW+t6PiN0FiU5X5c/mZ3/8iG8/bdEdRvLTiJWbYk
         I/GaldnXpGQ4CtZyal+aPlp5OZ5tFZLBy3x1KUDdH5LYHk7qjCXkVu/jkxoY7+7SnMDB
         9D8A==
X-Forwarded-Encrypted: i=1; AJvYcCV3+cxk+w6ikygRA5/KAM1eQIG0GVCdZE/mc3ilCiIyPEHQbVPwpe5jiUS6C6+umttyDBguFBSJfpfYwiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxRoEY3lJTf+gA/1v6ibA89XAGOC04a5p595b34GKqOgS/7oFw
	WsRP5txzad+erlzm2nNy53rcgAg8I88NeohT62OookwKvMXV41AiLdRv3LkA2TRmpPwJ9yEnKcM
	o81oS/uziK45cBH0rFHUPi0Qzjgfl0qkHttXSM95q20hYvnrDvILjFJoOJEZoOQ==
X-Received: by 2002:a05:6000:1569:b0:37d:4660:c027 with SMTP id ffacd0b85a97d-381f0f87207mr14707299f8f.24.1731405099756;
        Tue, 12 Nov 2024 01:51:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHusiA3w3BhzwfE2GvVnI3Z50uH1qhg1kogLt4IQIs9Vf9VGFuNEyeoDdQGxbFTY2yKrvHbLA==
X-Received: by 2002:a05:6000:1569:b0:37d:4660:c027 with SMTP id ffacd0b85a97d-381f0f87207mr14707266f8f.24.1731405099328;
        Tue, 12 Nov 2024 01:51:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b2d13sm233789855e9.12.2024.11.12.01.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 01:51:38 -0800 (PST)
Message-ID: <86135b98-40cb-4694-971c-3f09263d4236@redhat.com>
Date: Tue, 12 Nov 2024 10:51:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] drm/log: Add integer scaling support
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly <caleb.connolly@linaro.org>,
 Petr Mladek <pmladek@suse.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241108082025.1004653-1-jfalempe@redhat.com>
 <20241108082025.1004653-8-jfalempe@redhat.com>
 <6a1bc758-e66a-4067-80d3-82fe3ba357e5@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <6a1bc758-e66a-4067-80d3-82fe3ba357e5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2024 14:06, Thomas Zimmermann wrote:
> Hi
> 
> 
> Am 08.11.24 um 09:10 schrieb Jocelyn Falempe:
>> Add a module parameter, to increase the font size for HiDPI screen.
>> Even with CONFIG_FONT_TER16x32, it can still be a bit small to read.
>> In this case, adding drm_log.scale=2 to your kernel command line will
>> double the character size.
> 
> Can't we have larger fonts instead?

Yes, that would be nice, but the largest font available currently is 16x32.
Also it's stored as raw bitmap, so bigger fonts will take much more memory.
For the drm_log use case, we don't need pixel-perfect glyph, so integer 
scaling is good enough.

Best regards,

-- 

Jocelyn


> 
> Best regards
> Thomas
> 
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>
>> v5:
>>   * Change scale parameter to unsigned int (Jani Nikula)
>>
>>   drivers/gpu/drm/drm_log.c | 27 ++++++++++++++++++---------
>>   1 file changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_log.c b/drivers/gpu/drm/drm_log.c
>> index e6900c6b96436..4dc7be2288ab7 100644
>> --- a/drivers/gpu/drm/drm_log.c
>> +++ b/drivers/gpu/drm/drm_log.c
>> @@ -25,6 +25,10 @@ MODULE_AUTHOR("Jocelyn Falempe");
>>   MODULE_DESCRIPTION("DRM boot logger");
>>   MODULE_LICENSE("GPL");
>> +static unsigned int scale = 1;
>> +module_param(scale, uint, 0444);
>> +MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, default 
>> is 1");
>> +
>>   /**
>>    * DOC: overview
>>    *
>> @@ -38,6 +42,8 @@ struct drm_log_scanout {
>>       const struct font_desc *font;
>>       u32 rows;
>>       u32 columns;
>> +    u32 scaled_font_h;
>> +    u32 scaled_font_w;
>>       u32 line;
>>       u32 format;
>>       u32 px_width;
>> @@ -66,7 +72,7 @@ static struct drm_log *console_to_drm_log(struct 
>> console *con)
>>   static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
>>                const u8 *src, unsigned int src_pitch,
>> -             u32 height, u32 width, u32 scale, u32 px_width, u32 color)
>> +             u32 height, u32 width, u32 px_width, u32 color)
>>   {
>>       switch (px_width) {
>>       case 2:
>> @@ -86,7 +92,7 @@ static void drm_log_blit(struct iosys_map *dst, 
>> unsigned int dst_pitch,
>>   static void drm_log_clear_line(struct drm_log_scanout *scanout, u32 
>> line)
>>   {
>>       struct drm_framebuffer *fb = scanout->buffer->fb;
>> -    unsigned long height = scanout->font->height;
>> +    unsigned long height = scanout->scaled_font_h;
>>       struct iosys_map map;
>>       struct drm_rect r = DRM_RECT_INIT(0, line * height, fb->width, 
>> height);
>> @@ -106,8 +112,8 @@ static void drm_log_draw_line(struct 
>> drm_log_scanout *scanout, const char *s,
>>       size_t font_pitch = DIV_ROUND_UP(font->width, 8);
>>       const u8 *src;
>>       u32 px_width = fb->format->cpp[0];
>> -    struct drm_rect r = DRM_RECT_INIT(0, scanout->line * font->height,
>> -                      fb->width, (scanout->line + 1) * font->height);
>> +    struct drm_rect r = DRM_RECT_INIT(0, scanout->line * scanout- 
>> >scaled_font_h,
>> +                      fb->width, (scanout->line + 1) * scanout- 
>> >scaled_font_h);
>>       u32 i;
>>       if (drm_client_buffer_vmap_local(scanout->buffer, &map))
>> @@ -117,9 +123,10 @@ static void drm_log_draw_line(struct 
>> drm_log_scanout *scanout, const char *s,
>>       for (i = 0; i < len && i < scanout->columns; i++) {
>>           u32 color = (i < prefix_len) ? scanout->prefix_color : 
>> scanout->front_color;
>>           src = drm_draw_get_char_bitmap(font, s[i], font_pitch);
>> -        drm_log_blit(&map, fb->pitches[0], src, font_pitch, font- 
>> >height, font->width,
>> -                 1, px_width, color);
>> -        iosys_map_incr(&map, font->width * px_width);
>> +        drm_log_blit(&map, fb->pitches[0], src, font_pitch,
>> +                 scanout->scaled_font_h, scanout->scaled_font_w,
>> +                 px_width, color);
>> +        iosys_map_incr(&map, scanout->scaled_font_w * px_width);
>>       }
>>       scanout->line++;
>> @@ -204,8 +211,10 @@ static int drm_log_setup_modeset(struct 
>> drm_client_dev *client,
>>           return -ENOMEM;
>>       }
>>       mode_set->fb = scanout->buffer->fb;
>> -    scanout->rows = height / scanout->font->height;
>> -    scanout->columns = width / scanout->font->width;
>> +    scanout->scaled_font_h = scanout->font->height * scale;
>> +    scanout->scaled_font_w = scanout->font->width * scale;
>> +    scanout->rows = height / scanout->scaled_font_h;
>> +    scanout->columns = width / scanout->scaled_font_w;
>>       scanout->front_color = drm_draw_color_from_xrgb8888(0xffffff, 
>> format);
>>       scanout->prefix_color = drm_draw_color_from_xrgb8888(0x4e9a06, 
>> format);
>>       return 0;
> 


