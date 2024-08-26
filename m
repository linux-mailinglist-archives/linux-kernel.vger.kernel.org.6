Return-Path: <linux-kernel+bounces-301660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3D95F3BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9DA1F21B52
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6EA18BBA3;
	Mon, 26 Aug 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8ynp7oi"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53467188A09
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682189; cv=none; b=uIHxquBC0/UeDm7V+SohZZDr27syAs2q8x0xznr0RZhYwXmqFmoDOwd8HpwjoDjLYX5Q7rVuz+Syn1AwNzNA8fGL+85t0XZenEdEWw/I90AN6cYpQmakVUsoCcd2T8JtxL+MHNLKL9JBTJQDWUNwAMGiTrb3IV2wK4QMdfYPurc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682189; c=relaxed/simple;
	bh=NXrMQ/Y6KJVGoapMFzmEpQQrWKakUWlXDUACSBzX/bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNmgbDvtpydbtDPUkE5kp9t6vkBNWLi8OYqyCoIynNyjdDEVd65FCBSLQdDELnzlrak936IVuKeZ3DIWfgMqY7faIQoYrBTt4WfpDsPnQZDqGaqrrOKkE97zncUn8RylzUWljH+UD5Zf5vQF8nLwSAqmyk/GcwWp93kEGovsYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8ynp7oi; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d439583573so3066871a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724682187; x=1725286987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2utW4FMHDyZpSCUZj+xJI3mr8FO/CAwmDufTeK2CIk=;
        b=P8ynp7oiVojNcF8IlsGNxbdyHb3uN8oI0XJ1qHmFEgRXkh8+rZNbpWr0oy1jmU3Ouy
         orK0U18FAC7PnKPcL9OX4PHm3JNm8zpYiohjzeg4ERYWdk5aKzSHdSllBr4806omdZ5D
         zmIIZ1aLmHUZ3W+S8EoKqDWmHQJ5xarW9/AvFXyqzklbSXIfOlQqXJNDN8+mSSPE0GfG
         g57tuvQyh+5ettCdUfy+/qDgFzD55rmqXy6FouNKXMUxtMwHREnhdW55PNnmoL+G16f/
         s7iv4A/kPNP6NHh3dbZypIQqqPUltRU3oP9XpYkLEcRzAOmEKZEwFkLnL9JT3WqhQU+z
         td/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682187; x=1725286987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2utW4FMHDyZpSCUZj+xJI3mr8FO/CAwmDufTeK2CIk=;
        b=Amqn2Kx/gcCIHyg82cyf0hftT09hWO9TJQl3PpDUzcUwmr0vgRTlB77KOhmq4dI3fj
         v+d1Uu7P9/4wK5gmvIK89DDLjw3qNxfLlz5/9m8SOK9GQ9C+DNvkF2xUbG7NhXv5Pk11
         GuH8IU4kcvGmaTy/r5R36akEafHahD7J0w7jUJzc5Nsq3xCUMos4UZzDkJLCaG8CZ/wc
         tY+xTYFNDBZnqyXFKlek6ODHLMfeseVrrodkFXZgjHnwIpsKUFH8A6UTtndsPipt0BZe
         NbnxxYqQ4Lw9e925HyF7hB1qDHO3k+DWKyRkb5llbUN5AWPL9vy6gJMeTvpIDJepcyUT
         MpiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyTGjuRw15Xp2tnIrHRuXr2h1kYEuEHM6FyezftXEbe1XS0gOyyz1EYAx9wUqpcLGHr48uC6pWeZRboMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Ia5FULYNEch6D9qd69ltKegRxUKC8hPL3QUp4Z4MFzxg6sRT
	mnhkV4S3lIXec7wq0UIFcnwM2OHIOMzNPn2y0vlGw//RbWyVgRaEZnSbwLsVVGIJBifuMtgBV2Q
	wRzWWXhOULOSAh7dxN4JqMIK1Q+k=
X-Google-Smtp-Source: AGHT+IG/Dn/nxIV8yTlxqUE7f8LjK6OewCj2LtaTb2+9FKUHNqJ0iVTLhayt1aCPR/UYr9jW6k6FIt2I+rl0sqv23EY=
X-Received: by 2002:a17:90a:3484:b0:2d3:cd5c:15bb with SMTP id
 98e67ed59e1d1-2d646c04128mr9594862a91.25.1724682187111; Mon, 26 Aug 2024
 07:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825162300.417306-1-sui.jingfeng@linux.dev>
In-Reply-To: <20240825162300.417306-1-sui.jingfeng@linux.dev>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 26 Aug 2024 16:22:55 +0200
Message-ID: <CAH9NwWft0aBQdPUtREK3hLnPFgofFmDRk738k2C-Rxo1DVjOvA@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Use unsigned type to count the number of pages
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> The drm_prime_pages_to_sg() function takes unsigned int argument to store
> length of the page vector, and the type of struct drm_gem_object::size is
> a size_t. The size of the object in CPU pages can not be negative, hence,
> use unsigned variable to store the number of pages, instead of the signed
> type.
>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> index 3524b5811682..6b98200068e4 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> @@ -17,7 +17,7 @@ static struct lock_class_key etnaviv_prime_lock_class;
>  struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj)
>  {
>         struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
> -       int npages = obj->size >> PAGE_SHIFT;
> +       unsigned int npages = obj->size >> PAGE_SHIFT;
>
>         if (WARN_ON(!etnaviv_obj->pages))  /* should have already pinned! */
>                 return ERR_PTR(-EINVAL);
> --
> 2.34.1
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

