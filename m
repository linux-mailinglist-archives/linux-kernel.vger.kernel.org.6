Return-Path: <linux-kernel+bounces-301668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D01095F3CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC99281B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B213818BC02;
	Mon, 26 Aug 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/LOFEhL"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB077BB15
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682386; cv=none; b=R9r31nK8wW3fDaGAfdxWEwarlj7V/pMBUmeOa65FfXuQ8LKf8ABNf78+qMEswVGdxi5xRtp0DRTWpF/i0uEZGRT3gPJbLqewSf8+YTR3dqcHElv4ZNVdGwEkAk7XUZHJjGWHOQwPe8PUjNfN3a2fSC5LXwtmUM5tXXlE2mXtUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682386; c=relaxed/simple;
	bh=c9BrOSkUxd3p4WPT/VTZwKpt+vEqLpAhMUIOKltupZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tq0oxlvuS2MvluOJ+GHyPX5UJhhR+rLEUu6ObMHimkOHoPuBbp9dA1lsfXCkoEjz6ga7SMkE52Us+jaL/4aYX5In7WZm7eGoI9STNQgifgBwaeLcsM5d98uqZKXC80GbAlur0LPjxJr4e+LSVw2Oj7raDY888gBLsZbvGTMZ8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/LOFEhL; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7c3d9a5e050so2659995a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724682384; x=1725287184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YdLY9QhmDzCprCkwoHukU0jOTa/bz8bz/KrVX8TRxYM=;
        b=c/LOFEhLSavugFGInY7286V2ckrDi+6al7mrfz3uEIeS6rNWJfjTYTOtA7NdwufU8F
         ipvzi+IBEKmmGtavh5qoqnsG05rDTcv3uxaOdvc2jDXhY5Z6MOf/6NPXuNpZTqM3xUD4
         HrWBaNg4wigulHeRKJSH2CS/luSThf73WAGBsnghk+LElyOnzldTus3o2Rluuqc6MJ7R
         x95a0R7hLXzWhvzYKyzoYv98zKWVqRhmTRyKhlA6jLYV4IqJkcMzziRN8hsBjdFGbXI3
         5GpMUVO7BAli4sMWcLHomta3JbHeuDrUiAQ8WqyBjngSeFKdaZq7TgdIh0W7Q5sb39QO
         rkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682384; x=1725287184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdLY9QhmDzCprCkwoHukU0jOTa/bz8bz/KrVX8TRxYM=;
        b=fYM9uhD7Al0RnP5Hy/DXbrin6/fIOTiX1s3003NNp4v/ARMFo7g/sBvmv8T6iAov9l
         kqMKkqkhF2E7tXJY2C+1P4fVPMNezTf3AiLDHvpWR+b7eq1SfKfGRCI6szADpJTY42Vp
         4QRdwggl6o8L8RXIDVDJ/ZyYgfYk1eMecSgYAd8csUCFuQYS1EwjTUbZnEuRf9hdopA9
         D2lvuv7OKZsq/VLDuBrO4D8c5ZJqA6NuNxtfQ34Zbcv3jsE2ETdkYljvBkaG8CHo3Nxv
         jxLzBlQFsoJ25X+0JC/LY6BqJqjHcbqM1+auO2u2JmZauH9fxkpMvJsplt4R425XNdSD
         GRQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmK0GaO0wwBr06CUUM5sonNfVJBns3e7F0B2Hv/YBcATNLZxhukeKHF++sJqLirq8uK2/S076UAZEttSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKeZCRuXFiQMxJ3+4IAevv+YfOcICoWXOjntWGzEjcxPUrSKs
	WE33bp8macEXWFzl+DBKUfSG5TI9qe2jnkzp7liH5QJgcESyOVmXbySccxhMbJr5v9TvOYEoUCc
	qHQ8KQKw+hmXKzEgBt2HtyBT/jNQ=
X-Google-Smtp-Source: AGHT+IHh38t51U/dqWq2rh/6+5IlLz2T5OcR3xHCSi08x49UkVo+DUuATspS9Z6R0RwiB7q3QcDpti9GRasRKedZ1jc=
X-Received: by 2002:a17:90a:ce11:b0:2c9:7d09:1e7b with SMTP id
 98e67ed59e1d1-2d646cecbf1mr9437250a91.27.1724682383721; Mon, 26 Aug 2024
 07:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825160538.404005-1-sui.jingfeng@linux.dev>
In-Reply-To: <20240825160538.404005-1-sui.jingfeng@linux.dev>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 26 Aug 2024 16:26:12 +0200
Message-ID: <CAH9NwWf-kUw9e9wBbvDe+hXsfYdiNXOX-X1_6_VC_0F5qta1eg@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Drop the <linux/pm_runtime.h> header
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Currently, the etnaviv_gem_submit.c isn't call any runtime power management
> functions. So drop it, we can re-include it when the header really get used
> though.
>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> index 3d0f8d182506..3c0a5c3e0e3d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> @@ -6,7 +6,6 @@
>  #include <drm/drm_file.h>
>  #include <linux/dma-fence-array.h>
>  #include <linux/file.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/dma-resv.h>
>  #include <linux/sync_file.h>
>  #include <linux/uaccess.h>
> --
> 2.34.1
>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

