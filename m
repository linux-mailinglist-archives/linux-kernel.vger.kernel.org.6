Return-Path: <linux-kernel+bounces-225237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA786912DED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADA31F217A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8598317B4FE;
	Fri, 21 Jun 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifraVQh4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562B168482
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998447; cv=none; b=YXG9g5S5pTNLbUksklCCtopLurTgND6IPCN3vGwr7I+kU8j6boJsPC51w0QlIBvicWYkWtD62Y3fDSGuP+hxZGs9fz114h0PAD0+sVKIV/pb+woT1cuRubxGji6R0cuzicvDR9C3Wqn8RSzbKMmM/ksuzOmURfNm1X08EgKhubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998447; c=relaxed/simple;
	bh=IR6hXThYDmDCgdqkKA8YX+vJFJpWjz/cBEd5coBfDOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aqmgsxE/aeZK3g2LM5/WDQ+5Efut45Zm7Vq4fHqQfbLu8OLwOhxKdr1BvRahvRLMBwqp1Ag4ME1tcoGHO7Tmirt2nW3qBTYCWLF1WvcxcOHmz5pX3z5Q4KldQIpYGPKLDBhJAQw6USZLWoTC9qoElOlJPWopA1f0Sz8Ax9WL5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifraVQh4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718998445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iP+mWh+oai2lKyD3HjCZKvKZXTzmQCGTy8Y+p6hNoq4=;
	b=ifraVQh4utRcpHPRh6wvr1tBw3OyVrJHyjzdytPr1WJmgonxFc33jsrWnTeXY7ef8T04Xx
	2PWEbPcNSzUh8Pods4R4CjTxnfeNdQpR9g9PS3C2Vk/YRc+VlUB9rrYg5g7ppQf6jKG+8m
	mkOZcwm1SoY6Hi9381Z9nrweTHmBrrA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-SRStz9fRN1ihBSdqYQnWQw-1; Fri, 21 Jun 2024 15:34:03 -0400
X-MC-Unique: SRStz9fRN1ihBSdqYQnWQw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421791c4eadso12621495e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718998442; x=1719603242;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iP+mWh+oai2lKyD3HjCZKvKZXTzmQCGTy8Y+p6hNoq4=;
        b=YYuELbihtGKkGu7D1ALLIvIkfXbwQAb6CMHvjBrxo/wOHo7ev2jp4CtohwcDHtxUut
         DZY3WV/PmawzYzZphhoGjvhxvIH2NypbMdfmhQLEDg8vytn7iTBRbe57kRv6voEmEZIZ
         p8AXcPHJDTnTB9GexWaFTLC3Z8ZiaJuuXo6ph95vYLefWFWAz0Dykbcy1WA9BGQ5gN5e
         rsYx1pJarR9gAQ7exmJlh7Mkk3PMx+Ko3PRcsIMi5E6vgEIEfEMD9HelemvPtgBA0a4Q
         WHMighOZuU3JFD/2WKthJ3y6gjm2M82mR5DeMJctQYs78bAm1t4gm887ez3h6u9Yl/g9
         aUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzxtEh6kMfILpmDnre4bW2E7Cq2Ts/3V6WIdZ0UegHnFUPbqKe0jSrDOY3M75A9RWY7Hj+PDkiWfSCUEjvw0iaNKHfNc/tvgHBOxOI
X-Gm-Message-State: AOJu0YyWncn2lt0VvZtKp+GVwK7uLlHBg9nsF9jIVh1K5XlNDqzbkaDb
	vPZtGAg/s9iQdb3dd7oVf0rGVypLF5YFfaBbUBx0nB5I9adapqKHOYhKdHZbc+mxLAXskwWt+Fy
	VxZy/4fbXPlntPpSdglXyXDbyLwguj1xuL8+MV66gQeaBHKj+FAGzbQEzlD+vhg==
X-Received: by 2002:a05:600c:181c:b0:421:f346:6b06 with SMTP id 5b1f17b1804b1-42475298e68mr68730475e9.28.1718998442301;
        Fri, 21 Jun 2024 12:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUgi1RJw4/XDIAAjAQl+jUyCuY5PEjY+CKK/rd+iuv279adLiMlR3MbhNJooFF7lsCy198mg==
X-Received: by 2002:a05:600c:181c:b0:421:f346:6b06 with SMTP id 5b1f17b1804b1-42475298e68mr68730275e9.28.1718998441707;
        Fri, 21 Jun 2024 12:34:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0beb08sm83051605e9.17.2024.06.21.12.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 12:34:01 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, David
 Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Add drm_panic support
In-Reply-To: <ZnWsQ36q44l4CmOJ@phenom.ffwll.local>
References: <20240620222222.155933-1-javierm@redhat.com>
 <24205cdf-a3c6-475e-ba8a-a52d039a402d@redhat.com>
 <87h6dmjry6.fsf@minerva.mail-host-address-is-not-set>
 <87ed8qjo8y.fsf@minerva.mail-host-address-is-not-set>
 <ZnWsQ36q44l4CmOJ@phenom.ffwll.local>
Date: Fri, 21 Jun 2024 21:34:00 +0200
Message-ID: <87bk3ujdjr.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Vetter <daniel@ffwll.ch> writes:

Hello Sima,

Thanks for your comment and explanations.

> On Fri, Jun 21, 2024 at 05:42:53PM +0200, Javier Martinez Canillas wrote:
>> Javier Martinez Canillas <javierm@redhat.com> writes:
>> 
>> > Jocelyn Falempe <jfalempe@redhat.com> writes:
>> >
>> > Hello Jocelyn, thanks for your feedback!
>> >
>> >> On 21/06/2024 00:22, Javier Martinez Canillas wrote:
>> >>> Add support for the drm_panic infrastructure, which allows to display
>> >>> a user friendly message on the screen when a Linux kernel panic occurs.
>> >>> 
>> >>> The display controller doesn't scanout the framebuffer, but instead the
>> >>> pixels are sent to the device using a transport bus. For this reason, a
>> >>> .panic_flush handler is needed to flush the panic image to the display.
>> >>
>> >> Thanks for this patch, that's really cool that drm_panic can work on 
>> >> this device too.
>> >>
>> >
>> > Indeed, that's why I did it. Just to see if it could work :)
>> >
>> > [...]
>> >
>> >>> +static void ssd130x_primary_plane_helper_panic_flush(struct drm_plane *plane)
>> >>> +{
>> >>> +	struct drm_plane_state *plane_state = plane->state;
>> >>> +	struct ssd130x_plane_state *ssd130x_plane_state = to_ssd130x_plane_state(plane_state);
>> >>> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>> >>> +	struct drm_crtc *crtc = plane_state->crtc;
>> >>> +	struct ssd130x_crtc_state *ssd130x_crtc_state = to_ssd130x_crtc_state(crtc->state);
>> >>> +
>> >>> +	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &plane_state->dst,
>> >>> +			     ssd130x_plane_state->buffer, ssd130x_crtc_state->data_array,
>> >>> +			     &shadow_plane_state->fmtcnv_state);
>> >>
>> >> ssd130x_fb_blit_rect() will call regmap->write(), which involve mutex 
>> >> and might sleep. And if the mutex is taken when the panic occurs, it 
>> >> might deadlock the panic handling.
>> >
>> > That's a good point and I something haven't considered...
>> >
>> >> One solution would be to configure the regmap with config->fast_io and 
>> >> config->use_raw_spinlock, and check that the lock is available with 
>> >> try_lock(map->raw_spin_lock)
>> >> But that means it will waste cpu cycle with busy waiting for normal 
>> >> operation, which is not good.
>> >>
>> >
>> > Yeah, I would prefer to not change the driver for normal operation.
>> >
>> 
>> Another option, that I believe makes more sense, is to just disable the
>> regmap locking (using struct regmap_config.disable_locking field [0]).
>> 
>> Since this regmap is not shared with other drivers and so any concurrent
>> access should already be prevented by the DRM core locking scheme.
>> 
>> Is my understanding correct?
>
> Quick irc discussion summary: Since these are panels that sit on i2c/spi
> buses, you need to put the raw spinlock panic locking into these
> subsystems. Which is going to be extreme amounts of fun, becuase:
>
> - You need to protect innermost register access with a raw spinlock, but
>   enough so that every access is still consistent.
>
> - You need separate panic paths which avoid all the existing subsystem
>   locking (i2c/spi have userspace apis, so they need mutexes) and only
>   rely on the caller having done the raw spinlock trylocking.
>
> - Bonus points: Who even owns that raw spinlock ...
>
> I'm afraid, this is going to be a tough nut to crack :-/
>

Yeah, not worth the effort then. I'll just drop this patch.

> Cheers, Sima
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


