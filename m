Return-Path: <linux-kernel+bounces-443218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81D29EE8EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344212835B7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0DF2153E4;
	Thu, 12 Dec 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="qJFFmuYS"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3C21423F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014034; cv=none; b=bNkors40lARORpPo6O+5lbp+PFroyCRSC6cNhjU2gWmU62pTEearo1AWuqFyEJzcKFXzBxtJtF6XxUlBxYdzq8wdBEcZTMTCBErR1iQpXZmgzGM27zavZJ5KuX9BYjYrax1M6ad8zRlG90LG+DDPWzSODLQb8TgR6ZrDmV7l1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014034; c=relaxed/simple;
	bh=TUSHR09MWIWScyPuNYIlwYC+tS8CQ8KKfqKuUWMBs0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNekCC+XxWSUPpg8de4YVpmgYigMgE+Q2ID4SF7z96tUFXKqQeteVigxadIO6NQyGOUGOggUFYeA32Il2Ep0b+Q/SRXEBSs49GOoip7I02XSBedSZJYi+7eaqdkYapN1GAlCBQPpk1PjZhZo4dVo44ClMKC3PlIGfynI57HPFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=qJFFmuYS; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e39f43344c5so479492276.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1734014031; x=1734618831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oixWL2nrZMsUYl4DXg/df5eSVmWCM6y/4WgYjFxHm8U=;
        b=qJFFmuYSXeeh1wE0JiaGEgc4QEzLmn1PWUEPJYBk4c7w2awheWT9GAuLR5aZcXuYGV
         f+E83pOww8bVa/ZSDbi2YbZRcdJPRO0826TLa2wtVbJf28P4y2JtPztEoo8VNv3O4Tmt
         T78Xo/UTMSfWnuQdYHMp64P2hkEU5tYlxJdEq9ydhemb+QjNPRyp1TvQHpY1G3LX1fn3
         +hrio+aQRzyPFt3kKb5a+cf88R3/IJ7VCYetGWLkf38OfsFhlAi5AoLYSxtiwLOBp0Rw
         6CMWafrpN2+YwJxyM87xYhC5trA4V+PNm4uzbJ/xWkQjZuTMbMhVDUYdddFtSV+YSRx/
         3z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734014031; x=1734618831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oixWL2nrZMsUYl4DXg/df5eSVmWCM6y/4WgYjFxHm8U=;
        b=UyK7vQhSIJZpZ2T82hrNnj9B6lGt8Qx05RSPET9GqjVt/LG7DZehBVg5KiCRyx7bKl
         tQ7wPd5nOGzq9Kc6aK1lJw771rmUHvz2Q74XR/qPfQNmJ+LaMDfR6Lf3mrWQxALUvxGK
         Xy7dcGNxVLgS9EvWWZGkvswpbAiNIp7vtLgOiT1GzqtkpFX95YPYvksMKiqkeUrBlKKS
         vOu8BjeFrro/By37A0krbGi0aitLwCDNjmPC1WVMAuI6IoYYr8HdyKTT42Ws9eC/q0bF
         yAxVZvHZVZs1PVi98SNeWEm55VfTks4mc2Zsd+u/pJCtMQ+4f6a/fZH3h/0v6x4yB8lT
         Y8lA==
X-Forwarded-Encrypted: i=1; AJvYcCW/712ZhRZd8Y1pWlMkjkcDgl6mrdWefvSnEMtXP8UFn5l+MBoM3rPVyZNMRJL7N4tBpHJ3SDtokowD/04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBd5nx2wUjep7Nah3f/UpIPRgfp2EsudD1xZip+qQmrOXMQej
	FhWGg5Y6kq7vPKO4Ga7L+XEIVXo8OxeNqz4ATXPcmxQQXno+0NDhtRpu20uuo+IGyapfU1XG8xk
	uGHqcerO34vgTlyYS1eycW31pcw0QECJ78T8ltQ==
X-Gm-Gg: ASbGncvw5tkyDoJnYCLsuDzFJOkHhotLPUc+ibqNHEEhMAMi3MutivkORrZ7vOP23GP
	8nTXDZL/WFv0XxoF9wpCriFjnCTIE8wMNiVAKMg==
X-Google-Smtp-Source: AGHT+IGDLkQcBMnIFEczxKe7BF1CvAuA2ofNG6CIH7QxnJ28sfgBPj/eIhdCC4W8Y62+oAcJWg9iNMMiz9hdeyHHgTE=
X-Received: by 2002:a05:6902:72f:b0:e39:86a0:aeba with SMTP id
 3f1490d57ef6-e41c7b58a86mr526641276.34.1734014031430; Thu, 12 Dec 2024
 06:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b61a81b2-0101-43bd-a4f6-09cf3a016484@stanley.mountain>
In-Reply-To: <b61a81b2-0101-43bd-a4f6-09cf3a016484@stanley.mountain>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 12 Dec 2024 14:33:33 +0000
Message-ID: <CAPY8ntBkQ9PrNx51g+W6TPTLhFjQrTC1vitbV6TVCwq8GUOLwA@mail.gmail.com>
Subject: Re: [PATCH v2 next] drm/vc4: unlock on error in vc4_hvs_get_fifo_frame_count()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 12:47, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The default statement is never used in real life.  However, if it were
> used for some reason then call drm_dev_exit() before returning.
>
> Fixes: 8f2fc64773be ("drm/vc4: Fix reading of frame count on GEN5 / Pi4")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Thanks for the update.
  Dave

> ---
> v2: style fixes
>
>  drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index b42027636c71..4811d794001f 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -522,7 +522,7 @@ u8 vc4_hvs_get_fifo_frame_count(struct vc4_hvs *hvs, unsigned int fifo)
>                 break;
>         default:
>                 drm_err(drm, "Unknown VC4 generation: %d", vc4->gen);
> -               return 0;
> +               break;
>         }
>
>         drm_dev_exit(idx);
> --
> 2.45.2
>

