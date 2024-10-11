Return-Path: <linux-kernel+bounces-361075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2C599A313
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FC11F24081
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4183E216A0E;
	Fri, 11 Oct 2024 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISBAr2tT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089202AE7F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647908; cv=none; b=nMuLd2CTTbhjtqvLoO3hzbxc2p+emuEgh66mJOebAKMWCnxMp1CJ9PRANwH0LvDfk32fzdTziFNhd0EIzAMU5v8FxOtnk8aGkUVCbi0lcAFG+5dZQd6aeEjTDzIghLgphLC0F8mNlz3FQPJpoYkrAeIZkLM3K7kT7HPoGHdxMZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647908; c=relaxed/simple;
	bh=4SsSkUBBXITtvznj3NEc4RrhYpDDCZOT9emzOvwFjms=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bWnlUHKeEJO8KxXP8fO7cCZaFRborB1zV5jn8dvTl9dmDyyMTJQqkvlI5WaIoRUfOoJE02c4QVNy7IOlPgJ6wyD09t7aZa0iYu3OmydMnoJ2EwS6OuD/vIFQFb0C+GmTVlZNFotAh+TvCHAUOvgKOOVfNlEckByn50xoQ4wJKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISBAr2tT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728647904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqtqYDJ5gmPb+okepgVdSWbzK6v/2AzBf5S5iY5omHQ=;
	b=ISBAr2tT+gflsmWTaV/aaAXi8Kqg1HbDoKmD6brHmRnXC/bliLmZnPhugYImaNgwY9J6B6
	ZDlFvh0OE1vMof2UW1I6E+Q9kOzKe/dNuK4HNyisX7GSGmDJa48Crde71oia4k9TKKwwQA
	+N+1371Fg+qDeHG/73raSjpr50VvtMY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-bf3_uq7ZOpW2gYjKKYSbdA-1; Fri, 11 Oct 2024 07:58:23 -0400
X-MC-Unique: bf3_uq7ZOpW2gYjKKYSbdA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-430581bd920so12098045e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728647902; x=1729252702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HqtqYDJ5gmPb+okepgVdSWbzK6v/2AzBf5S5iY5omHQ=;
        b=XaLUigQqZWIkwlwZ1MAgf5LG2KmwqZwJmZ8Vxirs5qoiD8DgC4I6oyNN3gNLQrimTv
         XSSNiJPqY6HNGX0qnOMh3ZJa9g+Ts/jAnoRDuZ2lzpgi/dJo9uJq4j3ZXVLNOsgV5G+e
         5tW9OlglrdziLPB8s/fqr0vg0TtfCU5Oi8F4qrrJjjevUCKjh7fGY6NP8UEyLORdr+RR
         sMxvWMzEaCks/sxfuTqFEFoDRKHF1xME7bRH+G8F6wYbB6zYjD7m+Eid+W0i1mKZDJ04
         nTqHOCN0+0CLH/XIN1xubSf3/8BD82kckTNLMY3OdOfRISeg2cr4FuTFROKCgtO69w02
         /rLw==
X-Forwarded-Encrypted: i=1; AJvYcCWkPPciHqglK1wmzr2URhhb2knDo+phgsuluqB5yTAOdYj1xOlKQDAihZyS1IfRYAP2JgzUV7aKzrTaUbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtzUDm+HXFFzlcqZR6ghd63j+u7ULq+hytedVnQ9uzjJ+AhcG
	3mn67oeNubVgsXJI7fbnEiyRXuroIQy41ncJrMnT/JuAbw+o3bERzy0kt6ZrT9eAoe5Vtsmj/c8
	/OXZf5X+hH4QRXcSFWiYVUR0Z0Dpvx5Viohs46kNxGWjeeJeb43RsANMTMfb+KA==
X-Received: by 2002:a05:600c:45ce:b0:42e:93eb:ca26 with SMTP id 5b1f17b1804b1-4311ded374cmr18850595e9.11.1728647902591;
        Fri, 11 Oct 2024 04:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdbupGZvOA1PH+zsyYzVgQX2lgglDGG00ph3V2nJxTXUb/SfavUodcnAmRNSFjnDd2BtjITg==
X-Received: by 2002:a05:600c:45ce:b0:42e:93eb:ca26 with SMTP id 5b1f17b1804b1-4311ded374cmr18850385e9.11.1728647902118;
        Fri, 11 Oct 2024 04:58:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4462sm73029795e9.30.2024.10.11.04.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 04:58:21 -0700 (PDT)
Message-ID: <fab4dac7-e332-452a-8c73-f275c0c76f34@redhat.com>
Date: Fri, 11 Oct 2024 13:58:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] drm/log: Add integer scaling support
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly <caleb.connolly@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241011105526.615812-1-jfalempe@redhat.com>
 <20241011105526.615812-8-jfalempe@redhat.com> <8734l26g66.fsf@intel.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <8734l26g66.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2024 13:18, Jani Nikula wrote:
> On Fri, 11 Oct 2024, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> Add a module parameter, to increase the font size for HiDPI screen.
>> Even with CONFIG_FONT_TER16x32, it can still be a bit small to read.
>> In this case, adding drm_log.scale=2 to your kernel command line will
>> double the character size.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_log.c | 27 ++++++++++++++++++---------
>>   1 file changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_log.c b/drivers/gpu/drm/drm_log.c
>> index 07d151300146..e44c10819bd0 100644
>> --- a/drivers/gpu/drm/drm_log.c
>> +++ b/drivers/gpu/drm/drm_log.c
>> @@ -25,6 +25,10 @@ MODULE_AUTHOR("Jocelyn Falempe");
>>   MODULE_DESCRIPTION("DRM boot logger");
>>   MODULE_LICENSE("GPL");
>>   
>> +static uint scale = 1;
> 
> Drive-by nit, please use regular types instead of sysv "uint".

ok, you're right. It looks like the most common pattern is to use 
unsigned int for the variable but still call module_param() with uint.
I will fix that for v5.

Thanks,

-- 

Jocelyn
> 
> BR,
> Jani.
> 
>> +module_param(scale, uint, 0444);
>> +MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, default is 1");
>> +
>>   /**
>>    * DOC: overview
>>    *
>> @@ -38,6 +42,8 @@ struct drm_log_scanout {
>>   	const struct font_desc *font;
>>   	u32 rows;
>>   	u32 columns;
>> +	u32 scaled_font_h;
>> +	u32 scaled_font_w;
>>   	u32 line;
>>   	u32 format;
>>   	u32 px_width;
>> @@ -67,7 +73,7 @@ static struct drm_log *console_to_drm_log(struct console *con)
>>   
>>   static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
>>   			 const u8 *src, unsigned int src_pitch,
>> -			 u32 height, u32 width, u32 scale, u32 px_width, u32 color)
>> +			 u32 height, u32 width, u32 px_width, u32 color)
>>   {
>>   	switch (px_width) {
>>   	case 2:
>> @@ -87,7 +93,7 @@ static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
>>   static void drm_log_clear_line(struct drm_log_scanout *scanout, u32 line)
>>   {
>>   	struct drm_framebuffer *fb = scanout->buffer->fb;
>> -	unsigned long height = scanout->font->height;
>> +	unsigned long height = scanout->scaled_font_h;
>>   	struct iosys_map map;
>>   	struct drm_rect r = DRM_RECT_INIT(0, line * height, fb->width, height);
>>   
>> @@ -107,8 +113,8 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
>>   	size_t font_pitch = DIV_ROUND_UP(font->width, 8);
>>   	const u8 *src;
>>   	u32 px_width = fb->format->cpp[0];
>> -	struct drm_rect r = DRM_RECT_INIT(0, scanout->line * font->height,
>> -					  fb->width, (scanout->line + 1) * font->height);
>> +	struct drm_rect r = DRM_RECT_INIT(0, scanout->line * scanout->scaled_font_h,
>> +					  fb->width, (scanout->line + 1) * scanout->scaled_font_h);
>>   	u32 i;
>>   
>>   	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
>> @@ -118,9 +124,10 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
>>   	for (i = 0; i < len && i < scanout->columns; i++) {
>>   		u32 color = (i < prefix_len) ? scanout->prefix_color : scanout->front_color;
>>   		src = drm_draw_get_char_bitmap(font, s[i], font_pitch);
>> -		drm_log_blit(&map, fb->pitches[0], src, font_pitch, font->height, font->width,
>> -			     1, px_width, color);
>> -		iosys_map_incr(&map, font->width * px_width);
>> +		drm_log_blit(&map, fb->pitches[0], src, font_pitch,
>> +			     scanout->scaled_font_h, scanout->scaled_font_w,
>> +			     px_width, color);
>> +		iosys_map_incr(&map, scanout->scaled_font_w * px_width);
>>   	}
>>   
>>   	scanout->line++;
>> @@ -205,8 +212,10 @@ static int drm_log_setup_modeset(struct drm_client_dev *client,
>>   		return -ENOMEM;
>>   	}
>>   	mode_set->fb = scanout->buffer->fb;
>> -	scanout->rows = height / scanout->font->height;
>> -	scanout->columns = width / scanout->font->width;
>> +	scanout->scaled_font_h = scanout->font->height * scale;
>> +	scanout->scaled_font_w = scanout->font->width * scale;
>> +	scanout->rows = height / scanout->scaled_font_h;
>> +	scanout->columns = width / scanout->scaled_font_w;
>>   	scanout->front_color = drm_draw_color_from_xrgb8888(0xffffff, format);
>>   	scanout->prefix_color = drm_draw_color_from_xrgb8888(0x4e9a06, format);
>>   	return 0;
> 


