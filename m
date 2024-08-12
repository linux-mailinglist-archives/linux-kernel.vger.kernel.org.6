Return-Path: <linux-kernel+bounces-283269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C0C94EF5D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E775D1C21881
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11A17E8E5;
	Mon, 12 Aug 2024 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUpbPw4e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3B17D375
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472349; cv=none; b=N0KRvwtU0xzT1Z/Uqo3pXTu+JyL7iuOUyO2N71+Dsp61KZ7LqiVx7CCy5YULvKYB1bb863gbxIKe3SYUaM0QMN2WXVSu5/iRYaIQgh3oXr+iXIup9Me4PxEjd/F9QeCrG6mmgqwFLDbSXKJpaCw4yNRIUnw3wKqOmhQci3FzybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472349; c=relaxed/simple;
	bh=20M6iFSz3FZJrXZ15/AGYEgPToHoPbcKY/YpnkCUJII=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AxngGtJcvHPyAYukpQ95em81WUavt48xurTQyrxtT8HRVbTVPYTeRS3Jvhd4IdtBl76zARgOb2PUoYq2ixgbHRAiqa5/AuK0XyrxOs38RTpMGUvRe/Gbcd+Y5KL4YvomwWiVxkbgIoUye7lWzQ8j3xSNqANh+U90vQUzlOzkzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUpbPw4e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723472346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsZ0n/uAaYy4BF0ruktYY8YrFP/mFKdzXlqcXk7zn70=;
	b=SUpbPw4ecSB4Hx4Osjmdld+KUd4FtGt7ykEBPnxMQ3lZeCjoZY5RGzcO/Ky9GtkWM6Bamj
	4cQQnanXg6QUjH+hhUX3Kfr7vJhBBQjdbG3KMbbbwtghWzZNzBrdFmobtv0PgsuT6YLtHX
	bPT3+VIlEAQTAyCzRJ5PRmf9wMjxROU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-wez2VC8zM8yNQvSOo6M-Cw-1; Mon, 12 Aug 2024 10:19:05 -0400
X-MC-Unique: wez2VC8zM8yNQvSOo6M-Cw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280f233115so30150575e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723472344; x=1724077144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DsZ0n/uAaYy4BF0ruktYY8YrFP/mFKdzXlqcXk7zn70=;
        b=vGtJZzg+8WtsstesEgr6EW2cWdDIcTH8y+bsD/x1tUO/LItiJz2QeuSgTKSTBGtyFo
         UUj1bzfy+TSIzjQBZhRmz8f1qIoi0x/bKbL4foNTwJq49gvZyZ2QHCVdmW7hWq3HKcTv
         Ofhu/5blvJXQkBn22s6YzRaVkFNq6+X/So/eNq8/bspkrWwONZpf3MsVfrsjlWQSfrek
         lS7Ykec/B2X88UnZUK97ooZuqFBw1sTmHj5t6QOvX7cgND3cmFLWB0RKr/j4bNOukcsx
         ZH/qEUNVOh5TjAkU3I2gF+obky0IwPc0TpJTmcbV9XkFotpC3UAaiWgC/jy23vzdiaac
         XPgg==
X-Forwarded-Encrypted: i=1; AJvYcCXGPB38rfBJHM2YxGSMICHYRvZVhfneN9x7vZbN7AbutBkx9DULdTpwm9SNciph3bC9rKnczV8dHbdGWdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBDEQw4QWMpRqojWpXZj2Twr3Vhnr9VyjzWdSTjUWM5DXgnlwD
	tS+9920zWvzJZ85Inqg/LC7PVdGsz8e7v7NNJkb0FY5imCI+aARzrjp+CVsHFymzxBBWNTw4aoM
	k5ERidoQKZ2AE+hPC7c6s1tth39+ZH0NdUD1hr1GMFxaro5MroZCjGMoyY7TZCQ==
X-Received: by 2002:a05:600c:5489:b0:427:d8f7:b718 with SMTP id 5b1f17b1804b1-429d488047fmr4483255e9.24.1723472343950;
        Mon, 12 Aug 2024 07:19:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMYqABa//mMcdpuf59X1dzQmjPKUZRUSfrn2rTiz4JEfPCW7tnP/wiYu6/J9T05f0sM7ifPw==
X-Received: by 2002:a05:600c:5489:b0:427:d8f7:b718 with SMTP id 5b1f17b1804b1-429d488047fmr4483015e9.24.1723472343486;
        Mon, 12 Aug 2024 07:19:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c79f345sm187090885e9.39.2024.08.12.07.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 07:19:03 -0700 (PDT)
Message-ID: <60e55a9d-70bb-45d1-ac97-e4f6f6ffa9a9@redhat.com>
Date: Mon, 12 Aug 2024 16:19:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] drm/rect: Add drm_rect_overlap()
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@redhat.com>
References: <20240812123147.81356-1-jfalempe@redhat.com>
 <20240812123147.81356-3-jfalempe@redhat.com> <87sev926na.fsf@intel.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <87sev926na.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/08/2024 15:49, Jani Nikula wrote:
> On Mon, 12 Aug 2024, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> Check if two rectangles overlap.
>> It's a bit similar to drm_rect_intersect() but this won't modify
>> the rectangle.
>> Simplifies a bit drm_panic.
> 
> Based on the name, I'd expect drm_rect_overlap() to return true for
> *any* overlap, while this one seems to mean if one rectangle is
> completely within another, with no adjacent borders.

It's what I intended, but I may have messed up the formula.
> 
> I'd expect a drm_rect_overlap() to return true for this:
> 
>   +-------+
>   |   +---+---+
>   |   |       |
>   +---+       |
>       |       |
>       +-------+

if r1 is the top left rectangle, you've got:

r1->x2 > r2->x1   => true
r2->x2 > r1->x1   => true
r1->y2 > r2->y1   => true
r2->y2 > r1->y1   => true

So they count as overlap.

Checking in stackoverflow, they use the same formula:
https://stackoverflow.com/questions/306316/determine-if-two-rectangles-overlap-each-other

> 
> While this seems to be required instead:
> 
>   +-------+
>   | +---+ |
>   | |   | |
>   | +---+ |
>   +-------+
> 
> 
> IOW, I find the name misleading.
> 
> BR,
> Jani.
> 
> 
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_panic.c |  3 +--
>>   include/drm/drm_rect.h      | 15 +++++++++++++++
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
>> index 0a047152f88b8..59fba23e5fd7a 100644
>> --- a/drivers/gpu/drm/drm_panic.c
>> +++ b/drivers/gpu/drm/drm_panic.c
>> @@ -529,8 +529,7 @@ static void draw_panic_static_user(struct drm_scanout_buffer *sb)
>>   	/* Fill with the background color, and draw text on top */
>>   	drm_panic_fill(sb, &r_screen, bg_color);
>>   
>> -	if ((r_msg.x1 >= logo_width || r_msg.y1 >= logo_height) &&
>> -	    logo_width <= sb->width && logo_height <= sb->height) {
>> +	if (!drm_rect_overlap(&r_logo, &r_msg)) {
>>   		if (logo_mono)
>>   			drm_panic_blit(sb, &r_logo, logo_mono->data, DIV_ROUND_UP(logo_width, 8),
>>   				       fg_color);
>> diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
>> index 73fcb899a01da..7bafde747d560 100644
>> --- a/include/drm/drm_rect.h
>> +++ b/include/drm/drm_rect.h
>> @@ -238,6 +238,21 @@ static inline void drm_rect_fp_to_int(struct drm_rect *dst,
>>   		      drm_rect_height(src) >> 16);
>>   }
>>   
>> +/**
>> + * drm_rect_overlap - Check if two rectangles overlap
>> + * @r1: first rectangle
>> + * @r2: second rectangle
>> + *
>> + * RETURNS:
>> + * %true if the rectangles overlap, %false otherwise.
>> + */
>> +static inline bool drm_rect_overlap(const struct drm_rect *r1,
>> +				    const struct drm_rect *r2)
>> +{
>> +	return (r1->x2 > r2->x1 && r2->x2 > r1->x1 &&
>> +		r1->y2 > r2->y1 && r2->y2 > r1->y1);
>> +}
>> +
>>   bool drm_rect_intersect(struct drm_rect *r, const struct drm_rect *clip);
>>   bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
>>   			  const struct drm_rect *clip);
> 


