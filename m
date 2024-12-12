Return-Path: <linux-kernel+bounces-443037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6887D9EE603
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA653285E17
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B002147FE;
	Thu, 12 Dec 2024 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ZNOtM1KG"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7832288E5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004490; cv=none; b=ufp9lH9qWHm0qM2O21vO7HNBuXbpT4+IN3ekg/Fms3rdL6osedG3yZX6WypEK/MqJbjQlbaZT/bSZBWEiQI2vqo9iUVNtqsUnWbhTaCPoyncJEmYv+mRxq30KGWwf+LFPSEgKvRzr+tc8sXbFwA0SDXnQ5PHLpjN6/J1f8EQjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004490; c=relaxed/simple;
	bh=1XJH+j4IJIIke0IBSeywdnhf4g+AbrpLY8ypOEZSdxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIY7I+YtCsnpHp6LK01uMHs0ZIHzKZVWzoDbU+KwyOHHnhoWF18qwOivPbC9m1BlCHGF6R2YnWAvKqD9i9nj1Vk42EwhmiG63bQGwybcOKx22QsTKZ1WrA+WZuzpLwvi8a3zSmmOPwDGv2bZVLHm3HVVlalCTmw0w4/7hlqqDnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ZNOtM1KG; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e396c98af22so320333276.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1734004486; x=1734609286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QO/kWUsb4uL9LlTqLCCAldTNWq3Gj6otKLX1s/PNWac=;
        b=ZNOtM1KGpBHNIPErn/tHjPmkZsfFRyDJ7xvTzo65/X6rGUk1zqk9Th9/DMLZNCrNZ2
         LNoXXqcy/kgMgsSxE8MDRlGr2IiwQwcggjaMKeOPg5lQiNQYLtYe/uOIxAp6v7q+rlZB
         +9e3oHtghPq7OFgsofw7XH8cFUpsBv7EjmKWLIK9MAGu1E68EoalPfRrsIp2afADs0eD
         rcUtd0q2n+AtUIel0OBKmm76Bb3bZSIwURFkXIVNcbkaCK13qJvZEGPC/pdLgX73cCQf
         11PvPfwmCsqzvdu8fkE4R7lXckYgsjTBZdKMU7ONh7D3tO6vWbkaKHuJchous+uLbar5
         +VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734004486; x=1734609286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QO/kWUsb4uL9LlTqLCCAldTNWq3Gj6otKLX1s/PNWac=;
        b=VLpYaWqjWClras+Z+EAB0vqRZ2ljMrdXIsBi6RF4tp4xJfF5ohJ2HeJTueicJgLz0I
         8omYHqeQ1hqrQhUedrswUA3IMGSj6XlU/fwN4/kdbff/qS9QHxqEo+YFrTiF8cQKPG/C
         hhyHJ4IrERmSGzfYufakrGOyLrbOuk6IxwCshP09bwybRSe+lfIsl0Vobv0RIyb0suLv
         4rSeTK8g/5xwe2gD/dk2TRGvVlyReUusZ+6Lv9qrZrLq7k/R3RuPRdU+EPZ6w3mcB+JU
         PHrFzIgQkF6tcO2aWgcbYHyKWq+rAei+/9N/9n0vLvPkMX5UJ/Ssp65FrAvtNki0cRZn
         mQWg==
X-Forwarded-Encrypted: i=1; AJvYcCWIGb8WV8/v8GP+a2Im1YVj2lmooRumoIEU2ZhFf5Dppolw+PzwYVfXPVBHy/LMB+5LBd0qlTDAGYi3WHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyykkJ37UJtF1kc6C+FjKGPu4aTr4UuWfXeMc1Wa5ECMtnvD5d3
	vV2zTYaqf/XhJLeuF+VX6XPofGB/sKVsE2eXpzCNvMt1mo8et4it7JS/6VQTxb0u+IThFpKhqD/
	J8C109Ql/o7WkOviUesYoExuMiNW3G35ZNPTfiQ==
X-Gm-Gg: ASbGncv+Uss/0NVhQ1EyJuDrWZX4VU3yYX8ZNGs4Sawmm8wvY/a+ULT67yORP9sGo9a
	ArR014FwTInPuLBJYCgmnGbEYIcZ8G7GO6D4ZfQ==
X-Google-Smtp-Source: AGHT+IEZF99x3Z73R94L+ljBCygUUX+Knk3vSPh2S8Sa4SUHrFwCAM7NZhFFUD6/0ncFI/p+axz2uwCX+vrS2ZOL06w=
X-Received: by 2002:a05:6902:2701:b0:e38:87bf:8e65 with SMTP id
 3f1490d57ef6-e41b8dd9f38mr127426276.0.1734004486531; Thu, 12 Dec 2024
 03:54:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <02c87d9c-76b8-4d93-b0da-0e4f7d4952ae@stanley.mountain>
In-Reply-To: <02c87d9c-76b8-4d93-b0da-0e4f7d4952ae@stanley.mountain>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 12 Dec 2024 11:54:28 +0000
Message-ID: <CAPY8ntD9XzrzrhX=1XojjcZmRm60KLc39HZq0bJ9cEq0J7nQ9g@mail.gmail.com>
Subject: Re: [PATCH next] drm/vc4: unlock on error in vc4_hvs_get_fifo_frame_count()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan

Thanks for the patch.

On Thu, 12 Dec 2024 at 11:31, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Presumably the default path is never used.  However, if it were used for
> some reason then call drm_dev_exit() before returning.

Correct - the default path would mean something badly wrong.
Without it though, if you add an extra enum value it throws a compiler
warning of an unhandled case.

> Fixes: 8f2fc64773be ("drm/vc4: Fix reading of frame count on GEN5 / Pi4")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index b42027636c71..4f524ec126e7 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -522,7 +522,7 @@ u8 vc4_hvs_get_fifo_frame_count(struct vc4_hvs *hvs, unsigned int fifo)
>                 break;
>         default:
>                 drm_err(drm, "Unknown VC4 generation: %d", vc4->gen);
> -               return 0;
> +               field = 0;

field is initialised to 0 anyway to handle the cases where fifo is out of range.

Personally I'd like to see a break in there to ensure we don't
accidentally end up with a fall-through situation if another case got
added at the end. I don't know how others feel.

  Dave

>         }
>
>         drm_dev_exit(idx);
> --
> 2.45.2
>

