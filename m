Return-Path: <linux-kernel+bounces-284990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B39507C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE22A1C21F09
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3319DFBF;
	Tue, 13 Aug 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNpbyv8T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E23519D8B4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559673; cv=none; b=L2A03kLtSLC7tGf/gRRoez4Y/oC+8X1njaForcnob6wtNR78iFy7nOA7A1KqiMhKZRuRYUr0l5BIUzzblKoHG+poVxELWeCL8Qw/FBUepGKj4rPTOUlVgSx5C3b7mqk/sj9C150tnK9OmYtCo3TWic0pQi0Df8S3AUbRZ7a3CXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559673; c=relaxed/simple;
	bh=kvteX7/5/pd+fMe1MAIAeAD4bp2EgbvOCa0PiA9R+cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ETc9KNbr/1rTBy23Iu0PmVpcuy+uhW/ANtZLz/u+tB6mryn6mN5tgZdB6zfNDgBLxgl56pLKJPjB1Vk7PEiTtnvCZlqy/c/BJcAgNFY08F9KheT/Df/zuxKv3QlQt5eaS0NXMfOH6oCL0uqmtabGm/9A8hYFheh9/WazZXKbegU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNpbyv8T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723559671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78IsUJKw9IqeoT5lC9OSKM4PAO7hFbDugoVudFsVevs=;
	b=cNpbyv8THQzuqaawjFJXG8OgRHlLz9Ce0ODWxwKWP1mWMF573Dh8d75BdcXyJuMidSu4fO
	vHd9rEKjS5jtnAGFFksCU70iBJyptFMNrJRjnc2MjiYl/VgQHF5R/BSv7k2o7eF6OEBh6I
	TKczKV/Z7yFaQAtisueK9Aic+UcEReE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-At2sGQMmMnWGTFs3EytTBQ-1; Tue, 13 Aug 2024 10:34:29 -0400
X-MC-Unique: At2sGQMmMnWGTFs3EytTBQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428fc34f41bso42958495e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559668; x=1724164468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78IsUJKw9IqeoT5lC9OSKM4PAO7hFbDugoVudFsVevs=;
        b=sgIOkRJsOInPjRTzO3KHgL542uzN/D3ONbFARqlOYirHdb6I6VMItRWleLwaARxKo5
         BDuoR0uQ1+5wahxXBHdhkG6eLVlEP864Fv0MSdw4kw7ELobWozSFMClvADC27fO62lso
         JwXv7WjcUu5XwalFbKoJF/AXfcEhYulCI+HKqB3GYXHvieR5D+5R/LECCyWX76N0RSl8
         d0L1C6L5C8tHlBgDtbAKgEnRiMVG7S2AbwoDpIsfMF/Syg9jNGY+RW5q7g+iN8JJRJXW
         VeWYmabmLPV86b33/M9xbI+Lk4w792dBxlkYNLlEHurq5V5ObqGCyxreDxvMUhMXRckY
         s7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUwqpff3cqT22OM1/Lv8DQEd5MtVkXZu4RS1YWSOIdQH8ycH46pbYAfJ6SBmGn1ZWNUiaO/tSSnfp2AXr1RepnXPcqkFWtES/nUPWvV
X-Gm-Message-State: AOJu0Yxae1a6Nt5oghsBWjGLJ2uP0nc1B7Bp31YtlWW9ttqh9DRVfweo
	4pbM0/AbDc0LoOr/49T/UruhLKsq40lGIsP5sjGdnoKxiu3NxDp/+ZEvfgEL/ZiFbiZPN3/PJ8Y
	qHDPziGPKLvdzZT6/qkd5ySY5D9ysmoJh7JtFpE+4hRwvMSLe0k/ladhSGbGtGg==
X-Received: by 2002:a05:600c:548b:b0:427:fa39:b0db with SMTP id 5b1f17b1804b1-429d487347dmr30344045e9.27.1723559668286;
        Tue, 13 Aug 2024 07:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9S1VIbZLOEd8TYuQEWYafYxx7AV0xbNqaDFtZ2nyxoqmDI3atbQHIXjCKmWBf0/FxeiUD2w==
X-Received: by 2002:a05:600c:548b:b0:427:fa39:b0db with SMTP id 5b1f17b1804b1-429d487347dmr30343785e9.27.1723559667737;
        Tue, 13 Aug 2024 07:34:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c938045sm10585470f8f.43.2024.08.13.07.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 07:34:27 -0700 (PDT)
Message-ID: <bbbd7a97-6d40-4fd8-b70d-17e02481ba3c@redhat.com>
Date: Tue, 13 Aug 2024 16:34:26 +0200
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
 <60e55a9d-70bb-45d1-ac97-e4f6f6ffa9a9@redhat.com> <87frr924nj.fsf@intel.com>
 <87mslgzf52.fsf@intel.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <87mslgzf52.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2024 16:11, Jani Nikula wrote:
> On Mon, 12 Aug 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> On Mon, 12 Aug 2024, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>> On 12/08/2024 15:49, Jani Nikula wrote:
>>>> On Mon, 12 Aug 2024, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>>>> Check if two rectangles overlap.
>>>>> It's a bit similar to drm_rect_intersect() but this won't modify
>>>>> the rectangle.
>>>>> Simplifies a bit drm_panic.
>>>>
>>>> Based on the name, I'd expect drm_rect_overlap() to return true for
>>>> *any* overlap, while this one seems to mean if one rectangle is
>>>> completely within another, with no adjacent borders.
>>>
>>> It's what I intended, but I may have messed up the formula.
>>
>> Hmm, then I may have messed up the review. :)
> 
> Yeah, my bad, sorry for the noise.
> 
> I think I was thrown off by the comparisons mixing r1 and r2 as the
> first operand. Something like this might have been easier for *me* to
> parse, but not sure if it's worth changing anything:
> 
> return (a->x1 < b->x2 && a->x2 > b->x1 &&
>          a->y1 < b->y2 && a->y2 > b->y1);

You're right, I've used r1 and r2 for consistency with other functions, 
but for this case it's confusing, I prefer the a/b.

If I send a v7 I will do this change.

I can also rename when pushing, but I was already bitten by doing this.

Best regards,

-- 

Jocelyn

> 
> 
> BR,
> Jani.
> 
> 
>>
>> Gotta run now, but I'll get back.
>>
>> BR,
>> Jani.
>>
>>
>>
>>>>
>>>> I'd expect a drm_rect_overlap() to return true for this:
>>>>
>>>>    +-------+
>>>>    |   +---+---+
>>>>    |   |       |
>>>>    +---+       |
>>>>        |       |
>>>>        +-------+
>>>
>>> if r1 is the top left rectangle, you've got:
>>>
>>> r1->x2 > r2->x1   => true
>>> r2->x2 > r1->x1   => true
>>> r1->y2 > r2->y1   => true
>>> r2->y2 > r1->y1   => true
>>>
>>> So they count as overlap.
>>>
>>> Checking in stackoverflow, they use the same formula:
>>> https://stackoverflow.com/questions/306316/determine-if-two-rectangles-overlap-each-other
>>>
>>>>
>>>> While this seems to be required instead:
>>>>
>>>>    +-------+
>>>>    | +---+ |
>>>>    | |   | |
>>>>    | +---+ |
>>>>    +-------+
>>>>
>>>>
>>>> IOW, I find the name misleading.
>>>>
>>>> BR,
>>>> Jani.
>>>>
>>>>
>>>>>
>>>>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>>>>> ---
>>>>>    drivers/gpu/drm/drm_panic.c |  3 +--
>>>>>    include/drm/drm_rect.h      | 15 +++++++++++++++
>>>>>    2 files changed, 16 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
>>>>> index 0a047152f88b8..59fba23e5fd7a 100644
>>>>> --- a/drivers/gpu/drm/drm_panic.c
>>>>> +++ b/drivers/gpu/drm/drm_panic.c
>>>>> @@ -529,8 +529,7 @@ static void draw_panic_static_user(struct drm_scanout_buffer *sb)
>>>>>    	/* Fill with the background color, and draw text on top */
>>>>>    	drm_panic_fill(sb, &r_screen, bg_color);
>>>>>    
>>>>> -	if ((r_msg.x1 >= logo_width || r_msg.y1 >= logo_height) &&
>>>>> -	    logo_width <= sb->width && logo_height <= sb->height) {
>>>>> +	if (!drm_rect_overlap(&r_logo, &r_msg)) {
>>>>>    		if (logo_mono)
>>>>>    			drm_panic_blit(sb, &r_logo, logo_mono->data, DIV_ROUND_UP(logo_width, 8),
>>>>>    				       fg_color);
>>>>> diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
>>>>> index 73fcb899a01da..7bafde747d560 100644
>>>>> --- a/include/drm/drm_rect.h
>>>>> +++ b/include/drm/drm_rect.h
>>>>> @@ -238,6 +238,21 @@ static inline void drm_rect_fp_to_int(struct drm_rect *dst,
>>>>>    		      drm_rect_height(src) >> 16);
>>>>>    }
>>>>>    
>>>>> +/**
>>>>> + * drm_rect_overlap - Check if two rectangles overlap
>>>>> + * @r1: first rectangle
>>>>> + * @r2: second rectangle
>>>>> + *
>>>>> + * RETURNS:
>>>>> + * %true if the rectangles overlap, %false otherwise.
>>>>> + */
>>>>> +static inline bool drm_rect_overlap(const struct drm_rect *r1,
>>>>> +				    const struct drm_rect *r2)
>>>>> +{
>>>>> +	return (r1->x2 > r2->x1 && r2->x2 > r1->x1 &&
>>>>> +		r1->y2 > r2->y1 && r2->y2 > r1->y1);
>>>>> +}
>>>>> +
>>>>>    bool drm_rect_intersect(struct drm_rect *r, const struct drm_rect *clip);
>>>>>    bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
>>>>>    			  const struct drm_rect *clip);
>>>>
>>>
> 


