Return-Path: <linux-kernel+bounces-203841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D7F8FE117
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1B51F22CB9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195513C91A;
	Thu,  6 Jun 2024 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="BvO86Caj"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44413C812
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662944; cv=none; b=SLmKTd0RuG5iUiXxtBZh1r7YSrnBtFW2mnVlLbA98DEOYAAnkvxRg2UWDlbaI9YbLcTUaiR8Hs851NW+MXKUddfKXnjC+arTo7fr/goupMDEtWkxhXDESbavrS2XQvAgrLlKsmXqr8pAn4kwOzvMAu/IzHdvfS7jLBHneujRhus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662944; c=relaxed/simple;
	bh=TEa8HshL8R6beVCZZICGFhOgG9ZinqXY4f/S/jqkPwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4adaYNLFHlBX4x4Qr856/9VCCmQoH2FnyI0EOTO2DWv9I4PEf0CmBXAdZmHxxE0Mzlld+WkTYa/xMUNL2y5cXWfXcOGYIybXTvYnCID4IStvaMqRgwI/X71WbCSHCT9jMd6ezGu/JaUyIf8FIknuvk4K1TlA1K1XfD7tWv4nN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=BvO86Caj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35e0f4e1821so521948f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1717662941; x=1718267741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCwIYRedAV5Z8YBxgB7muTkW1BWHNjBVC+U5ONE1IoM=;
        b=BvO86CajaKzB/GaDjcqA+gt59SWrAMxWmvNWpGztKUkCv9KkJ0Nw0S/VeRoFy7Of1l
         fn8S/r78HxdKkekBFNu/GVc+Z4xkguxcHXMImn3AUqLF1vQ72YqMkolk0eN31Qoh3fui
         IpzLLNLR9COEF7C1vsyReui0bFzmBLbwypqKtDznXGZsn0CplhcDJN7fUj6dvu/tFXiU
         swt8QuI0Rg5gJU0g1D9rUYDoXiu0rpqhgH4bSfsEI4oYL+ydDSHJYJw2A2qYp7ret27D
         awsd+9/vvpziza9pPHA+gwPL5stL1XZg+aun3N86IIn5D+3U7HwCxNoYZqXtl6X7a9/h
         CFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662941; x=1718267741;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCwIYRedAV5Z8YBxgB7muTkW1BWHNjBVC+U5ONE1IoM=;
        b=GlhIocf179iPHfAUFsptumMkRSE8RA0BOQliry/mJofWTQbaaroadedsANL8zjwIBx
         FaWI/RiisdnmbjW0HQguDJIqrOjnGgnLk/aril6FgVwNfyurTAY/gRTIBUb9uedPsQKb
         x0NZxBcZRkCkkhWGmm5arczP0SH03hJ+z3lC+4rTu7sc9iMDXyFk0kQiJLbC4zRjUC48
         ed+n0ZiiUSqpJMgUbLxQ08mrquQ071JyjqjOFknm/nJgJKS0W3YuLbV3Ha74rKT36GdV
         MEeBbTxqsauwD1oQHHKPEJWk2a1DadKPkjYzrIGN0o6g0LkTASHnBdgZSHg0890TcOv6
         M69A==
X-Forwarded-Encrypted: i=1; AJvYcCXchWmicNcyiiI/zdgVUHyJbKqYwVumZmkCRKiuq+VUt1yqwUtax0mTz6BszDMcgR1Zq0n304du753qstpAxWkLeSYP0Wjy7+o1vFMp
X-Gm-Message-State: AOJu0YwC2qP55SwG93JViTxDBRSxnjQU34LXx85jEdBKl7C0RLt2jC3y
	SvCnFDz+bYOtTZkUANJOxzXIDEqHMLLPy29RZW5P98is2u2aR5qtXmzEzRJfPuM=
X-Google-Smtp-Source: AGHT+IHs+uu+sCK+3QGcW2yHZE69rF6zH5KkgsyOFeQlqam69zVQG+kaq1EKZ7ucxK1IOfaJpqTrgw==
X-Received: by 2002:a5d:6504:0:b0:35e:f374:33b4 with SMTP id ffacd0b85a97d-35ef37435b8mr1172473f8f.65.1717662940656;
        Thu, 06 Jun 2024 01:35:40 -0700 (PDT)
Received: from [10.0.21.32] (210.red-80-36-22.staticip.rima-tde.net. [80.36.22.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d4bcd6sm932216f8f.45.2024.06.06.01.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:35:40 -0700 (PDT)
Message-ID: <1c40ea3a-ac58-4fa9-a7e5-3af880effb0e@ursulin.net>
Date: Thu, 6 Jun 2024 10:35:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] drm/drm_file: add display of driver's internal
 memory size
Content-Language: en-GB
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
References: <20240606005416.1172431-1-adrian.larumbe@collabora.com>
 <20240606005416.1172431-7-adrian.larumbe@collabora.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240606005416.1172431-7-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 06/06/2024 02:49, Adrián Larumbe wrote:

> Some drivers must allocate a considerable amount of memory for bookkeeping
> structures and GPU's MCU-kernel shared communication regions. These are
> often created as a result of the invocation of the driver's ioctl()
> interface functions, so it is sensible to consider them as being owned by
> the render context associated with an open drm file.
>
> However, at the moment drm_show_memory_stats only traverses the UM-exposed
> drm objects for which a handle exists. Private driver objects and memory
> regions, though connected to a render context, are unaccounted for in their
> fdinfo numbers.
>
> Add a new drm_memory_stats 'internal' memory category.
>
> Because deciding what constitutes an 'internal' object and where to find
> these are driver-dependent, calculation of this size must be done through a
> driver-provided function pointer, which becomes the third argument of
> drm_show_memory_stats. Drivers which have no interest in exposing the size
> of internal memory objects can keep passing NULL for unaltered behaviour.
>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Please Cc people who were previously involved in defining 
drm-usage-stats.rst. I added Rob, but I am not sure if I forgot someone 
from the top of my head.

Internal as a category sounds potentially useful. One reservation I have 
though is itdoes not necessarily fit with the others but is something 
semantically different from them.

In i915 I had the similar desire to account for internal objects and 
have approached it by similarly tracking them outside the DRM idr but 
counting them under the existing respective categories and memory 
regions. Ie. internal objects can also be purgeable or not, etc, and can 
be backed by either system memory or device local memory.

Advantage is it is more accurate in those aspect and does not require 
adding a new category.

Downside of this is that 'internal' is bunched with the explicit 
userspace objects so perhaps less accurate in this other aspect.

Regards,

Tvrtko

> ---
>   Documentation/gpu/drm-usage-stats.rst   | 4 ++++
>   drivers/gpu/drm/drm_file.c              | 9 +++++++--
>   drivers/gpu/drm/msm/msm_drv.c           | 2 +-
>   drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
>   include/drm/drm_file.h                  | 7 ++++++-
>   5 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index 6dc299343b48..0da5ebecd232 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -157,6 +157,10 @@ The total size of buffers that are purgeable.
>   
>   The total size of buffers that are active on one or more engines.
>   
> +- drm-internal-<region>: <uint> [KiB|MiB]
> +
> +The total size of GEM objects that aren't exposed to user space.
> +
>   Implementation Details
>   ======================
>   
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 638ffa4444f5..d1c13eed8d34 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -874,9 +874,10 @@ void drm_print_memory_stats(struct drm_printer *p,
>   			    enum drm_gem_object_status supported_status,
>   			    const char *region)
>   {
> -	print_size(p, "total", region, stats->private + stats->shared);
> +	print_size(p, "total", region, stats->private + stats->shared + stats->internal);
>   	print_size(p, "shared", region, stats->shared);
>   	print_size(p, "active", region, stats->active);
> +	print_size(p, "internal", region, stats->internal);
>   
>   	if (supported_status & DRM_GEM_OBJECT_RESIDENT)
>   		print_size(p, "resident", region, stats->resident);
> @@ -890,11 +891,12 @@ EXPORT_SYMBOL(drm_print_memory_stats);
>    * drm_show_memory_stats - Helper to collect and show standard fdinfo memory stats
>    * @p: the printer to print output to
>    * @file: the DRM file
> + * @func: driver-specific function pointer to count the size of internal objects
>    *
>    * Helper to iterate over GEM objects with a handle allocated in the specified
>    * file.
>    */
> -void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
> +void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file, internal_bos func)
>   {
>   	struct drm_gem_object *obj;
>   	struct drm_memory_stats status = {};
> @@ -940,6 +942,9 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
>   	}
>   	spin_unlock(&file->table_lock);
>   
> +	if (func)
> +		func(&status, file);
> +
>   	drm_print_memory_stats(p, &status, supported_status, "memory");
>   }
>   EXPORT_SYMBOL(drm_show_memory_stats);
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 9c33f4e3f822..f97d3cdc4f50 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -880,7 +880,7 @@ static void msm_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   
>   	msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, p);
>   
> -	drm_show_memory_stats(p, file);
> +	drm_show_memory_stats(p, file, NULL);
>   }
>   
>   static const struct file_operations fops = {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index ef9f6c0716d5..53640ac44e42 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -570,7 +570,7 @@ static void panfrost_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   
>   	panfrost_gpu_show_fdinfo(pfdev, file->driver_priv, p);
>   
> -	drm_show_memory_stats(p, file);
> +	drm_show_memory_stats(p, file, NULL);
>   }
>   
>   static const struct file_operations panfrost_drm_driver_fops = {
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index ab230d3af138..d71a5ac50ea9 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -464,6 +464,7 @@ void drm_send_event_timestamp_locked(struct drm_device *dev,
>    * @resident: Total size of GEM objects backing pages
>    * @purgeable: Total size of GEM objects that can be purged (resident and not active)
>    * @active: Total size of GEM objects active on one or more engines
> + * @internal: Total size of GEM objects that aren't exposed to user space
>    *
>    * Used by drm_print_memory_stats()
>    */
> @@ -473,16 +474,20 @@ struct drm_memory_stats {
>   	u64 resident;
>   	u64 purgeable;
>   	u64 active;
> +	u64 internal;
>   };
>   
>   enum drm_gem_object_status;
>   
> +typedef void (*internal_bos)(struct drm_memory_stats *status,
> +			     struct drm_file *file);
> +
>   void drm_print_memory_stats(struct drm_printer *p,
>   			    const struct drm_memory_stats *stats,
>   			    enum drm_gem_object_status supported_status,
>   			    const char *region);
>   
> -void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file);
> +void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file, internal_bos func);
>   void drm_show_fdinfo(struct seq_file *m, struct file *f);
>   
>   struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flags);

