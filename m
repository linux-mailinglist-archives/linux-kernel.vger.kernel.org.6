Return-Path: <linux-kernel+bounces-301662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4C995F3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AEC1C21A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A1218D627;
	Mon, 26 Aug 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/r1MwpV"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCF188CA5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682219; cv=none; b=FpELFjng6ZeJkPX6ajsTn5gbKFKknKyQyw/hW55jkAeppFJlIq/xrcgHmdysoWZPs/bDORYkdOWzEJU0XgUWOTkHIjxbotJYL0exgO6IrlrhM86UAmikT7kOmH5Ih0x7mzMQ696Mg6v+7Knh2G8yG0nCggQjOcto2jQWsTXAGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682219; c=relaxed/simple;
	bh=q1SzN0B7xqURMFmhcIjbrVK1va/5b28hD37etbIS1oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3tXmAAOlBlkzlMLaraZA5urW1Pw844p9/Vp5kGUjhDWDGwiV15HxYBqk5uEXRiyaX4IkisVPj5kRu3kPYwP8f2QoBuXzN8GcbM9AgNorkL/B0qWCpCjpMPKe+9cn4QSbY3tmA3//WcT5HyF5hI07LAGalMQx6ZRbtyCMDoda64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/r1MwpV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cda0453766so1329290a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724682217; x=1725287017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Fz2LLvQTYlEOsUpiHug0Zo0dLswBmU+LLedYnqHt04=;
        b=C/r1MwpVTJdzrctDIeN997874lnZQ4Ikygf+rzdUk292l6mY/vIYVlk2ukI99CFF15
         AkW0XST6CCTgXK0ha5vLEDUjyhrVRLI9MfNMFjLkigx1Yuer+NkGy9RMx9k+SCiROSMN
         4eLSL3tFj2Afwuc3LGhUL+nNiq0JotBAgMEDVL0SGvW0ECJPWKi0SS+vrTA/Kfw77N5t
         HnV5wlzRPODn1SazxV04EhS7P2l+1UbC1D1AKGBEbD+EEMJ7irZh6BPEkvslpKVuTWpY
         u6jiAnyYPUcmg2EA7qFoCT1o3lE6OBaWtwea9Aah+kG7uL1enHR4QDdI9JHQDbOrESuv
         Orog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682217; x=1725287017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Fz2LLvQTYlEOsUpiHug0Zo0dLswBmU+LLedYnqHt04=;
        b=U5Gp99iEZ7jrEvEdVNV93Lb6GpXuqGbjcQiiybdtfYInGRachDt5/OJiESmT5AdYxt
         /gU4b7s0JdykxZavWlHK+CzpyoM0D7mYU/zoaJCqHc/AXGaceIcsflF/0e8a80pZa0Ze
         r6Jgbze0fcKjCVAHiBUN8YnT5tLXuVIR2t+qt9B7CJ0TDqIBYtJQJpKl6wyuKsLFF+nA
         +w3ufOEZ9rbHNtCPPFoXWsvZ18WVre3XAQ8joTGYd/J3inICRyHe55u2fsPymoCf7eqx
         0lQA6k3M1VUQKlcVq975OPdz1eW+Z1quEt0+PyARCLxZugAmsD8fbTiou6PxfhwvBYyH
         7yNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI8Oq9gWCo5+nEWHU4UNydgKI9cz/ln9L6tQD7EGdwfqML2eG0VM7WCcgTApVRtSb9wSZrp3eKp1kPuqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw5ISj68u1f3qYDi5PO7jZ8jzAdMpRSRAG4pangtZrQzkAaW7T
	fnXlKiKzif9qgBzcB6teFxUuoAg6LxpLI443inIL3Ojs3lw9reGv+k0N5NgLqvCxzcHTHptcm/q
	77iNSTI2tvnQkD+LIBpDT4XCVWAI=
X-Google-Smtp-Source: AGHT+IGmmcvpWkvHXDq0cyYNprm+1dAOPoQUI8Pf8pqeqVMWP0gYwF0AFm0EPNBk25rmIxaGPD40kue34U//HVWJy8Q=
X-Received: by 2002:a17:90a:ff17:b0:2c9:7219:1db0 with SMTP id
 98e67ed59e1d1-2d646bccfafmr12498489a91.3.1724682217421; Mon, 26 Aug 2024
 07:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825174128.474100-1-sui.jingfeng@linux.dev>
In-Reply-To: <20240825174128.474100-1-sui.jingfeng@linux.dev>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 26 Aug 2024 16:23:26 +0200
Message-ID: <CAH9NwWeVFtOuQ=6dpXotrR-BGMjYAo3-fR6CHgcHbOxiZ87xCA@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Use unsigned type to count the number of
 userspace pages
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> The unpin_user_pages() function takes an unsigned long argument to store
> length of the number of user space pages, and struct drm_gem_object::size
> is a size_t type. The number of pages can not be negative, hence, use an
> unsigned variable to store the number of pages.
>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index ce9c9233c4a6..fa0d193cec26 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -695,7 +695,7 @@ static void etnaviv_gem_userptr_release(struct etnaviv_gem_object *etnaviv_obj)
>                 kfree(etnaviv_obj->sgt);
>         }
>         if (etnaviv_obj->pages) {
> -               int npages = etnaviv_obj->base.size >> PAGE_SHIFT;
> +               unsigned int npages = etnaviv_obj->base.size >> PAGE_SHIFT;
>
>                 unpin_user_pages(etnaviv_obj->pages, npages);
>                 kvfree(etnaviv_obj->pages);
> --
> 2.34.1
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

