Return-Path: <linux-kernel+bounces-360442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC30999B02
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A0728450C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98F1F473B;
	Fri, 11 Oct 2024 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FDj/Ff1p"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC831F4720
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616293; cv=none; b=tgqmJPBhxEzH637SX1B/1axjvYfYzM1roBO3GmcZfHVWtlVqtbSQkt9WhXQEwHIVMwqhasHUHDMm6i7+zxJ1ZuIime4lejV+EbD1DihTa8MkTZnJ8xcQwtJn6fSJm6BncHth/K9y+hXbtHqIIkRCO0HbgHnDUT+MkckkUAAxfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616293; c=relaxed/simple;
	bh=02kGS9DQTwXuo5+ZXhIx5N9nDnjlQIqe2emiYQLLths=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntI45yn+iTOW6U5CVSEbQzdTk0RjCreA0EGIzkz4zZbJtQA+mJYGgwAVy9+FCzTnSbSigM9UVKEtbH/TlBg1FThsMbWAQrXKNltKXRS3qnusRkw9UO6uXK6kCFy1GijluVV2aIhIwjc8q82Az4xFiCwmY/AAWYwM8jYS1n741NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FDj/Ff1p; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e29218d34f8so98368276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728616290; x=1729221090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yfg3IT3RP0Jj2YAEw7pMI16TcSZXqOO49FYHCoqTWD0=;
        b=FDj/Ff1pirMAL/UO+G2R0T3bYnM7LDnta9t1gQD8innRju59HzUXNzI91f8zjkA5XP
         bIg+REfOGYvQCHWia0N4HhvEC07ZnLT02ZCnip8mIQricyN7cqpHvXfgtvKOQawdAF4p
         8mz2PP0AjKz1RGQMSYNAGEKJVUqlwP/63widk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728616290; x=1729221090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yfg3IT3RP0Jj2YAEw7pMI16TcSZXqOO49FYHCoqTWD0=;
        b=go9RjTMg4dDOUv3AB9bcJj6e1RPyBG39Jr3D0z1BAZEvmV2NjyRz4/NxYraQ/3n5Yk
         1b4a5t/PnnWCqJiWTWMkxo4yllktse51o8dnlaqsbLg2aeJvhtJi5JHeF8IV+MgJiWEN
         dovxOTmGpathppdLUf7VIrD2OvGKPJaCEaY8h3AC7N0o1tlOnR6ybfqR3d5npKwkwAfl
         SkBT3q7/wYLCahP2m8kQ4aI0M4nCi7xEa5Fcr6DB9H156yHsEGWb29iXpQaUYIkXfdGr
         9As1vw6uLn98w4AGNao4T8UbydQWOpZkeKjMjm6N7YmwHpgFNnmihgc7aczwB5kPwgmT
         5Wlg==
X-Forwarded-Encrypted: i=1; AJvYcCXjw6TAT1k5Url/WkCsy4vU65MMM41Uvq1TR9gzOJ6AWnYgRQ79oyfQGfQXHHiqWiIvGCX9k/gCCZJ/yOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIbVGpV/aULwW71K9ikjuv51CERhn4IZsE2p27V4y0KuHOlGaA
	TedtIbs5I38PO6zeqCqc7If4KaJGhHBoUWS08zUAYu50LUzvmO632t5meDm5ULPw+zv+Eh28cGS
	che5OgW9MkVTsReN04HJlP48tkWQIwj01DB8z
X-Google-Smtp-Source: AGHT+IGKQvRqFgFQgz5sVkkkF+gNST5d53tOFeDyfCOSYPBwKNzEG6F1tBZI5gfWRc+y9JbypuiGU/gb8sDi758pHPw=
X-Received: by 2002:a05:6902:2742:b0:e29:e15:25da with SMTP id
 3f1490d57ef6-e2918412aa8mr1131559276.23.1728616290371; Thu, 10 Oct 2024
 20:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007115131.1811-3-thorsten.blum@linux.dev>
In-Reply-To: <20241007115131.1811-3-thorsten.blum@linux.dev>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 10 Oct 2024 23:11:19 -0400
Message-ID: <CABQX2QP5HdCkfffiLGHUm16OT3_c_5LOzwfNv-gxs0ZxZVyGmQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] drm/vmwgfx: Remove unnecessary NULL checks before kvfree()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 7:52=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.d=
ev> wrote:
>
> Since kvfree() already checks if its argument is NULL, an additional
> check before calling kvfree() is unnecessary and can be removed.
>
> Remove both and the following Coccinelle/coccicheck warnings reported by
> ifnullfree.cocci:
>
>   WARNING: NULL check before some freeing functions is not needed
>   WARNING: NULL check before some freeing functions is not needed
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_blit.c
> index 890a66a2361f..64bd7d74854e 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> @@ -635,10 +635,8 @@ int vmw_bo_cpu_blit(struct vmw_bo *vmw_dst,
>                 kunmap_atomic(d.src_addr);
>         if (d.dst_addr)
>                 kunmap_atomic(d.dst_addr);
> -       if (src_pages)
> -               kvfree(src_pages);
> -       if (dst_pages)
> -               kvfree(dst_pages);
> +       kvfree(src_pages);
> +       kvfree(dst_pages);
>
>         return ret;
>  }
> --
> 2.46.2
>

Thank you. Looks good. I went ahead and pushed it to drm-misc-fixes.

z

