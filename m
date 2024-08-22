Return-Path: <linux-kernel+bounces-297316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E787C95B61E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8622853FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559F1C9EC4;
	Thu, 22 Aug 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBjjjx2L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A826AC1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332338; cv=none; b=D0mBdaVal5EzsqHyRoBBev84i9dzqNMfal9cH4/Pe76jTqjJ1CpLbClPeoY4qfcUxwsvt+PPoBJczHHPThGS+TP/F2aFps5QrM1WWoLq5ZZRVcEvbLqOYyH6uRr/NtZx28QYgLs3D7jQiCclcH48kKxJxIY4KeXfRAq3PN9SphI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332338; c=relaxed/simple;
	bh=g04QUxDGFljTIVUlKt74J/ahXEP8Lgu6xBvNQasLdsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U8HosUxEZ8G9E63/uwNTj1fa2lXEoXCk0TLkphMO8bGsHjdqkqWJhFSvP2fRpRoqw1kBPGtHV6YQ6dMHAmLDCQ+WsUHip/Q7w4RB4zAP/IsVJpArdz2x8RIGapippFWLnJcl/rtrD8NHAPua7gtNxex9oHmBGdpX/OpUIMpz1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBjjjx2L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724332335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEF+0DDPl7ZNGl0E7zRKH64urw9RSLetJWerpVByaAw=;
	b=EBjjjx2LEDh4A7ihxXnIcDG7ymce8g2Ug9cYYs+LdYt1Hn4djO+iQzlVR1mOlhgCgw1Vjb
	iZrstWMZHbfdIrSW6mjYwDmdaHlkgMxOyXYmyxmjrUE7BNJT6fqYEkLLSZX22jWSjgxtLx
	J1ibEcumCzp+lT3CpGj/vonjacxm0oI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-QJzomOgLMZOU7uZz4xuS4A-1; Thu, 22 Aug 2024 09:12:13 -0400
X-MC-Unique: QJzomOgLMZOU7uZz4xuS4A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3719cee43abso329410f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724332332; x=1724937132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEF+0DDPl7ZNGl0E7zRKH64urw9RSLetJWerpVByaAw=;
        b=MePlMTbNafeQsAv7kh5Hqwz3JDLCVY50zgXRAcrtQfa/5489TUHFwUMoPCGRHP7Tvx
         +KpSF2H7uzMUMe8izJbNi+7QPo1pEWfaUmJOxOFLV4PeOPTIHAd0lTljP6MhMSsJaFOd
         yzKI6eOGBJtUvVjwnOE1iyC+oD82kM8nza1a8nXDtms/FRNZ6+Y7ajVByfJ9Q6Kz9Ywo
         AErYM5/nIwetIILnonGdGo4KQa4o0mko13MnK91h9unK8rZjo/S+VrM+3fSP6s6IJvN6
         bVoZ+AXky+cIMiBjd3nJex+1+evTeloQ53QOmHh62FO9UslXb0jZgNGWyNzoVZKXS7H1
         MU1g==
X-Forwarded-Encrypted: i=1; AJvYcCVErqP8AzIzOm2FTUdDwhIj0VyOoktPNgnDVgKNXGYgN83gnJOKWelBmguBbzgcwE/pbdiEcZPoLZwM7xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdawd++8u2ppm1CvqZBZRXIqq6IlVa8zKA0BI05XnRtlzuB+n
	qGpWvVBxnJcsOZ0OQW9UZvT8/z92H5sa0bnTGC9RoJFhgwEZDFTGhIB6hIdePEX//ryjKJJ8jiW
	CEr1+U51JM+cTRqRYr7zQgcR7bStnqAGx4Nwx0uQKYQG2viYxEC4CacQIi39bpw==
X-Received: by 2002:a5d:5e11:0:b0:373:b3b:9f62 with SMTP id ffacd0b85a97d-3730b3ba074mr953662f8f.38.1724332331851;
        Thu, 22 Aug 2024 06:12:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCDq2m7q4T8mvCQJ8ZlmkCjIjVWzVYAgF/3CVbiXdiB6c5TercGvJ578lxX8JpG5tDymv72A==
X-Received: by 2002:a5d:5e11:0:b0:373:b3b:9f62 with SMTP id ffacd0b85a97d-3730b3ba074mr953629f8f.38.1724332331294;
        Thu, 22 Aug 2024 06:12:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730821ab05sm1641474f8f.98.2024.08.22.06.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 06:12:10 -0700 (PDT)
Message-ID: <d5de80ed-adc2-4307-bb57-27fc4e611100@redhat.com>
Date: Thu, 22 Aug 2024 15:12:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] drm/rect: Add drm_rect_overlap()
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@redhat.com>
References: <20240822073852.562286-1-jfalempe@redhat.com>
 <20240822073852.562286-3-jfalempe@redhat.com>
 <4b5c6ba2-e16c-4884-a067-8d9ab7ad35f8@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <4b5c6ba2-e16c-4884-a067-8d9ab7ad35f8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/2024 14:58, Thomas Zimmermann wrote:
> 
> 
> Am 22.08.24 um 09:33 schrieb Jocelyn Falempe:
>> Check if two rectangles overlap.
>> It's a bit similar to drm_rect_intersect() but this won't modify
>> the rectangle.
>> Simplifies a bit drm_panic.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> There's an optional comment further below.
> 
>> ---
>>
>> v7:
>>   * rename r1/r2 to a/b in drm_rect_overlap() (Jani Nikula)
>>
>>   drivers/gpu/drm/drm_panic.c |  3 +--
>>   include/drm/drm_rect.h      | 15 +++++++++++++++
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
>> index 0a047152f88b8..59fba23e5fd7a 100644
>> --- a/drivers/gpu/drm/drm_panic.c
>> +++ b/drivers/gpu/drm/drm_panic.c
>> @@ -529,8 +529,7 @@ static void draw_panic_static_user(struct 
>> drm_scanout_buffer *sb)
>>       /* Fill with the background color, and draw text on top */
>>       drm_panic_fill(sb, &r_screen, bg_color);
>> -    if ((r_msg.x1 >= logo_width || r_msg.y1 >= logo_height) &&
>> -        logo_width <= sb->width && logo_height <= sb->height) {
>> +    if (!drm_rect_overlap(&r_logo, &r_msg)) {
>>           if (logo_mono)
>>               drm_panic_blit(sb, &r_logo, logo_mono->data, 
>> DIV_ROUND_UP(logo_width, 8),
>>                          fg_color);
>> diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
>> index 73fcb899a01da..46f09cf68458c 100644
>> --- a/include/drm/drm_rect.h
>> +++ b/include/drm/drm_rect.h
>> @@ -238,6 +238,21 @@ static inline void drm_rect_fp_to_int(struct 
>> drm_rect *dst,
>>                 drm_rect_height(src) >> 16);
>>   }
>> +/**
>> + * drm_rect_overlap - Check if two rectangles overlap
>> + * @a: first rectangle
>> + * @b: second rectangle
>> + *
>> + * RETURNS:
>> + * %true if the rectangles overlap, %false otherwise.
>> + */
>> +static inline bool drm_rect_overlap(const struct drm_rect *a,
>> +                    const struct drm_rect *b)
>> +{
>> +    return (a->x2 > b->x1 && b->x2 > a->x1 &&
>> +        a->y2 > b->y1 && b->y2 > a->y1);
> 
> I found this hard to understand. You may want to use the existing 
> _intersect helper
> 
> bool overlap(a, b)
> {
>    struct drm_rect tmp = *a
> 
>    return intersect(tmp, b);
> }

I considered this, but it creates an unused rect, and compute the 
intersection rectangle, which we are not interested in.
Even if the compiler may optimize and throw all this away, I prefer the 
more straightforward version.

Thanks for the review,

-- 

Jocelyn
> 
> Up to you.
> 
> Best regards
> Thomas
> 
>> +}
>> +
>>   bool drm_rect_intersect(struct drm_rect *r, const struct drm_rect 
>> *clip);
>>   bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
>>                 const struct drm_rect *clip);
> 


