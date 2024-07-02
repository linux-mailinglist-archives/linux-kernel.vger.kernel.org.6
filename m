Return-Path: <linux-kernel+bounces-237774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7598B923DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E18288B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC0F16C6A5;
	Tue,  2 Jul 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAS+20eI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B62816B748
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923679; cv=none; b=oL4vBv01Y4u6XrvzWIF8uoAMntFhbVt4m+Zz+sc97m2BlOu2nSRZ7lqCWYs/13rJCWUbb2K+P+dzMjaN2J+hQ3EacENaQ+EFT7mDZK3t4ME/fV2HGKzT1dl2PC4+rjMQ2R464uqBXvArDGqHuR7aKdyuKliiyUt7LHtXcsXXFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923679; c=relaxed/simple;
	bh=JL5qIavQaoAaG/gmZoRicxABH1aGBETvW5jK0CfOzjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i6Prs623tuz371MC90XBQ/+RWzDq4bdCZfgt98sKJqWm6rwzcF6V/3bvD4yE3QjDYtnaYCkBCOlChvzv9KFTe07OoBg50rK82qPk+Q1B5Zq0IDefW62VlTLVJdq6rugWOziSmLFA8z6sH6iDuPo0oZIoPXpzKDdlGVfWhopWUU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAS+20eI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719923676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJJl1XdsZbN/nrhzL8kDmExeBA4K2F968qXwb+izwJ0=;
	b=HAS+20eITHvUyfN8lUnEUYgMr9gHwbKgyr3MgbyMTSL6SypnH8cluVRvOdqILmNVHAb2zk
	VRRW/gyyoa+9M6xNcPS6hLePkGJZ5iTrITGMWHI/7umku0U8hd2Er8BweTQS000yx10w1y
	cSxO0CfdScwr0eQIW47f4SOb/yf/ePA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-VPrUEIuCPQeG5BcflP0FRQ-1; Tue, 02 Jul 2024 08:34:34 -0400
X-MC-Unique: VPrUEIuCPQeG5BcflP0FRQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36740a84ad8so3608596f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 05:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923674; x=1720528474;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJJl1XdsZbN/nrhzL8kDmExeBA4K2F968qXwb+izwJ0=;
        b=reFgxz5tZxJvBsq9+QWwZbYVuEPSgrM557J6poEq6snbus8fNEvBMxeeuLnxJn6dEw
         /x8e1tn6lGQQVPzb6Smxy7ExXINfhafo2Ykb5P+U4zHb4toOBft7zrybHjt3hMPQ7hZZ
         WpByMo11to7u/f9TYkldt7OR0ybmZ7ILqSC1Iq99KqO5kuwEr5vp/FBoAEV1cUkle9pk
         zzTDmQsAmWOTcJ4jU0nFsWqPyxhhBBCxlrU2wnf1tnScxLK+4vtHAmn4xqEX0c7l2VA7
         P9+Xe4vGq7dtB9LXSEXaTZDj6LVoQKucOBxp2eyWL4BLGHtngvLBz1AsPUuiecpAu9Ty
         IJRw==
X-Gm-Message-State: AOJu0YzOvxJiNsgIYw5AcrtIGW+JgzJQFPstCAyv3J608VI9S8fW2j3H
	fk/97TTmBTBhRdaVThYwK7O5XFUBIuunPloH+3uz6rJii7AsGMAGB12dcy23Xvki+vc6ds3FELq
	hUuD8fv514Ox0F+fVlRPcY7/nFJkxSfNaQEkoJckVaIzApEOqZmL4NJ9TZlWRqQ==
X-Received: by 2002:a05:6000:401f:b0:364:ee85:e6e4 with SMTP id ffacd0b85a97d-36775724906mr7434290f8f.53.1719923673871;
        Tue, 02 Jul 2024 05:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA+M0i7qjFWDaCOkZBrFAY0zMWbhrnTGVMNJwTg7YQzPp1pRXF9LAHlA3zU/fuNw0+XU4dLw==
X-Received: by 2002:a05:6000:401f:b0:364:ee85:e6e4 with SMTP id ffacd0b85a97d-36775724906mr7434270f8f.53.1719923673534;
        Tue, 02 Jul 2024 05:34:33 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678c379cc6sm786301f8f.49.2024.07.02.05.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:34:33 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Huth <thuth@redhat.com>, dri-devel@lists.freedesktop.org, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Geert
 Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] drm/fbdev-dma: Fix framebuffer mode for big endian devices
In-Reply-To: <20240702121737.522878-1-thuth@redhat.com>
References: <20240702121737.522878-1-thuth@redhat.com>
Date: Tue, 02 Jul 2024 14:34:32 +0200
Message-ID: <87bk3gm0pz.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Huth <thuth@redhat.com> writes:

Hello Thomas,

> The drm_mode_legacy_fb_format() function only generates formats suitable
> for little endian devices. switch to drm_driver_legacy_fb_format() here
> instead to take the device endianness into consideration, too.
>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: Patch has only been compile-tested since I lack an environment
>        for testing it. But it's the same fix as I required for the
>        drm_mode_legacy_fb_format() in drm_fbdev_generic.c / drm_fbdev_ttm.c
>        so I think this should be fine.
>
>  drivers/gpu/drm/drm_fbdev_dma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
> index 97ef6300d47e..fdef4a2f883f 100644
> --- a/drivers/gpu/drm/drm_fbdev_dma.c
> +++ b/drivers/gpu/drm/drm_fbdev_dma.c
> @@ -101,7 +101,8 @@ static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
>  		    sizes->surface_width, sizes->surface_height,
>  		    sizes->surface_bpp);
>  
> -	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
> +	format = drm_driver_legacy_fb_format(dev, sizes->surface_bpp,
> +					     sizes->surface_depth);
>  	buffer = drm_client_framebuffer_create(client, sizes->surface_width,
>  					       sizes->surface_height, format);
>  	if (IS_ERR(buffer))

Makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


