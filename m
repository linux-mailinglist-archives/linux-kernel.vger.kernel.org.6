Return-Path: <linux-kernel+bounces-224845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8D5912791
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764A028C1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F720DC8;
	Fri, 21 Jun 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agXfzdad"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995A1C6BD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979784; cv=none; b=MmzbUQjFgb1DQidrYrLfXtqDK7G/kxMCHkGslW8auM0dcIvXOKpEvYDijzst9YXVijo4XuSR7sH+rQ90jiZiqQSTRfyFQeHZaw0jxLLFV06lZvlAgWhy7YP7GHLkUYfnSVbjMZYbxBWUt5me1Anqmrsib8Kwz4sT/Z+4LAhUVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979784; c=relaxed/simple;
	bh=dtD5FZtqo+wNEOZYQrefbfY6liBnv6eMThh82Nzq/Cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XaaHv6eCp08KE45ZLlEzh74iCBxcI/EmIYsSbiCEWVtfCamJ6/vaw5IcLEiXekdpDTMCkz0D5AvizBWwXZnTVvLNEWqqnb/C/vIjWxwZHS2ph6qvbx0kg2ox434VI3nQJKubJDbXqAj53aYTO29pP+PBe8FFn/0xnFRaHUjS/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agXfzdad; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718979782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qV90C7UJlVmCFYl+NUkqoGghcuANzyZHieaRfwTm4mo=;
	b=agXfzdadxZwaTq/G+3ceyztNXRfGOJZm5c4IsP/YBdaZUmyKsuFiGa0lulmHDym4nyNVio
	1PyP/armlmqVhyjA8lB5QWkdIr5zv4akKX8Pg32tDQc53PkF3XGr09QFl6akk2AH5kZiSH
	GViQUEzysWWMW5cal1VXSamU09A7RO4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-1wYxKo-uOxeoepLiC2x2YQ-1; Fri, 21 Jun 2024 10:23:00 -0400
X-MC-Unique: 1wYxKo-uOxeoepLiC2x2YQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52c84d02b7fso1541179e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718979779; x=1719584579;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qV90C7UJlVmCFYl+NUkqoGghcuANzyZHieaRfwTm4mo=;
        b=ooDIbpjyBpAvewHMVJuU05XQehiNXZNJizLWdpoGVEklpBE6WqjsYcxsFmnSVHK0cA
         FMCGHCw+a28WYHVvQSlZpGF3avvbfw5AVyGzDVjFKlZ4TqyVW+rXDJ49WXNlX5+dhp0t
         sRR9nwjjOcwReqC0OTufMx0myDegcSe1DBHIxR+e0/frhYrSEhkKbsINWeVn78yRtSaO
         4P8Xk/mGnr0fdnSEFHncvNpNn/l9yOqNEoI0KQzSc0puaKSbGgYpA9Qh7B5CBYvHZwq1
         jObImK42rNslL9gcJo2o256etRYMvYjuseZCb2VBxiChRRyx3v0e89prmAZDVlDnkFyL
         WLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjgYtaLwHYIQgEgSYEN/Hksqoq0ukFCdtuCKvMXFJIDuXLvAnAatwkvHHEE6SPhvEDCjEp59p1zfpLPdFIbQQ28QTax6ZoZ4BEN99i
X-Gm-Message-State: AOJu0YzGbHTr33Nh64khx+ICHuL4bxwzGWZG02wG5SoNrgXNKgH1Co+X
	D6nD1CxYAh/oyJtdTV2VOrvEjh+Ccd0cnUKoOE5hsd4xvxVFdsnXwQgCuBP6YimxJk/CEtY9vNJ
	TtqOkhEJUNpCHoyZmIaYCegVRpD/xDQHO/abXJTCF6TD9UTWoWHRuED8yTkn8pA==
X-Received: by 2002:a05:6512:1242:b0:52c:8837:718a with SMTP id 2adb3069b0e04-52ccaa918b4mr7215876e87.43.1718979779025;
        Fri, 21 Jun 2024 07:22:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzAV6+Rl/xfj+isJfV3mrm2ePVS6gx8oMmzBUO+GxqHw6XoMk3+zLYkOix/dNQI0VJ7gDQ9Q==
X-Received: by 2002:a05:6512:1242:b0:52c:8837:718a with SMTP id 2adb3069b0e04-52ccaa918b4mr7215852e87.43.1718979778456;
        Fri, 21 Jun 2024 07:22:58 -0700 (PDT)
Received: from localhost ([185.124.31.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b88easm1884384f8f.39.2024.06.21.07.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:22:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Add drm_panic support
In-Reply-To: <24205cdf-a3c6-475e-ba8a-a52d039a402d@redhat.com>
References: <20240620222222.155933-1-javierm@redhat.com>
 <24205cdf-a3c6-475e-ba8a-a52d039a402d@redhat.com>
Date: Fri, 21 Jun 2024 16:22:57 +0200
Message-ID: <87h6dmjry6.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

Hello Jocelyn, thanks for your feedback!

> On 21/06/2024 00:22, Javier Martinez Canillas wrote:
>> Add support for the drm_panic infrastructure, which allows to display
>> a user friendly message on the screen when a Linux kernel panic occurs.
>> 
>> The display controller doesn't scanout the framebuffer, but instead the
>> pixels are sent to the device using a transport bus. For this reason, a
>> .panic_flush handler is needed to flush the panic image to the display.
>
> Thanks for this patch, that's really cool that drm_panic can work on 
> this device too.
>

Indeed, that's why I did it. Just to see if it could work :)

[...]

>> +static void ssd130x_primary_plane_helper_panic_flush(struct drm_plane *plane)
>> +{
>> +	struct drm_plane_state *plane_state = plane->state;
>> +	struct ssd130x_plane_state *ssd130x_plane_state = to_ssd130x_plane_state(plane_state);
>> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>> +	struct drm_crtc *crtc = plane_state->crtc;
>> +	struct ssd130x_crtc_state *ssd130x_crtc_state = to_ssd130x_crtc_state(crtc->state);
>> +
>> +	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &plane_state->dst,
>> +			     ssd130x_plane_state->buffer, ssd130x_crtc_state->data_array,
>> +			     &shadow_plane_state->fmtcnv_state);
>
> ssd130x_fb_blit_rect() will call regmap->write(), which involve mutex 
> and might sleep. And if the mutex is taken when the panic occurs, it 
> might deadlock the panic handling.

That's a good point and I something haven't considered...

> One solution would be to configure the regmap with config->fast_io and 
> config->use_raw_spinlock, and check that the lock is available with 
> try_lock(map->raw_spin_lock)
> But that means it will waste cpu cycle with busy waiting for normal 
> operation, which is not good.
>

Yeah, I would prefer to not change the driver for normal operation.

> So for this particular device, I think it's ok, because it's unlikely 
> you'll run kdump or other kernel panic handlers.
> But I would like to know what others think about it, and if it's 
> acceptable or not.
>

I don't know either. I guess that after a panic everything is best effort
anyways so it may be acceptable? But let's see what others think about it.

> -- 
>
> Jocelyn

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


