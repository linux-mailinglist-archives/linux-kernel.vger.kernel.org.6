Return-Path: <linux-kernel+bounces-303833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766F2961592
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D50B21603
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C52374CB;
	Tue, 27 Aug 2024 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NLjf37VZ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465731C7B92
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780126; cv=none; b=cT7cr3RjxMhxCefJ2EjKBKREHiMA3hCeQDvr3ToJ2J+Qie/vPu86hxuvgscXERO/Wo1dmmteYyB1BrzPoeVsUo4C1ij71+72izzuoAIVyRLNg0L2NxlnS45+w0+J36/eCXN7eHyxUPO+Yck7Gi6QJGm5UqI/LFlR+VSqLMw8WsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780126; c=relaxed/simple;
	bh=nZFaCyLafRdzrODiB2XlPprQiGEBuxKLGfRi0AoWNyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWtW1fLxaV36MaNQ+w0JNXebQi+CGx+PrUOIOMNsrcRuXtcWZmEgjzLtNnL+uWfjXnjCbCK+Q/jagADHemKqz4nHXpHrTkyz8pc8TMKA0v2hXBERHqRnhE6EyRZHKFVrdQrCRbMYUqZqz0zxQzPkpjk/0NkRfRYB13p8/Uk++hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=NLjf37VZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280bca3960so49721275e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1724780124; x=1725384924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZZ6Ajj14IHLte0g5ioHFoms2pJpNTRFXHc7NQuqRFQ=;
        b=NLjf37VZ9TgrwALFoUJTeuoA1rTP3ed9DP2gpcGhhzM1WQGizYQKUrj73yjA2rdvY5
         fQujFbwJKFZq7ce/DOU0d1OhEeDpcte81UwCjt7bXJwvRoYpvIWeXabmrG+fVYdpn/O3
         EsJEiDueS0gbVltAeeo17Jk9GiVZi2YEgmnY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724780124; x=1725384924;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZZ6Ajj14IHLte0g5ioHFoms2pJpNTRFXHc7NQuqRFQ=;
        b=NxiEcBDUreYkkPNQFvvm+gKeDMeh5moHNbzjMyrI+DxpAvPSQZ2C3NvY9CrQSK8RFy
         AN/uT37lfCkCulU2iQ78OvrfBRJc8LcXAJnung0sNJQ5WCfToGV2FwQBCDh8rJbEJf7Z
         Ov7SY7UrO9UjuEw1M5+krguh+VurBxLHlSwQq/9fCff0EAYnscNJwv7vdeP3xkwj+Tyl
         sCkKDEGzDIRqNpBfwrkV0BLNs+ly3UMeYNamvIvw6lV+DECHlgnUvkWbctPWxpozCJTo
         QNChU3lAXqKKMnM/8Pkc/WD7DxgID/w0vmYYUBdW7yUs276WT5VSVuPnGmypcWstcyAm
         v/lA==
X-Forwarded-Encrypted: i=1; AJvYcCUC2tyPeLpBd77qzGzE5jb8aVJemfkv4K2V0PbX3KCTMIE7RZjDu88SS30qYJdhT4xkjF2EHsvBVZaaa0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRf9m0H2+g/4/yfsCvOcIHgvW4xGDh1FZpL+jXPZY0RARnLExC
	cyGST0a++W6jwQs1fnrXj7Nd3MDiK7Sg1n5hIeOWpB5oGFZESECfd3+LE5kMQmE=
X-Google-Smtp-Source: AGHT+IGi0Fo9OsBSJJC05p6AtEJSAshONRM7u4ZqsPBBDGXSPsJtXdpFBsXO0qz+YxybLrTH6d5U8Q==
X-Received: by 2002:a05:600c:691a:b0:429:a0d:b710 with SMTP id 5b1f17b1804b1-42b8926b105mr87354665e9.12.1724780123242;
        Tue, 27 Aug 2024 10:35:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c0dcsm13655429f8f.37.2024.08.27.10.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 10:35:22 -0700 (PDT)
Date: Tue, 27 Aug 2024 19:35:20 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sched: Document drm_sched_job_arm()'s effect on
 fences
Message-ID: <Zs4OWLkl1ZgBL1HU@phenom.ffwll.local>
Mail-Followup-To: Philipp Stanner <pstanner@redhat.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
References: <20240826093916.29065-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826093916.29065-2-pstanner@redhat.com>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Mon, Aug 26, 2024 at 11:39:17AM +0200, Philipp Stanner wrote:
> The GPU Scheduler's job initialization is split into two steps,
> drm_sched_job_init() and drm_sched_job_arm(). One reason for this is
> that actually arming a job results in the job's fences getting
> initialized (armed).
> 
> Currently, the documentation does not explicitly state what
> drm_sched_job_arm() does in this regard and which rules the API-User has
> to follow once the function has been called.
> 
> Add a section to drm_sched_job_arm()'s docstring which details the
> function's consequences regarding the job's fences.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 7e90c9f95611..e563eff4887c 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -831,6 +831,12 @@ EXPORT_SYMBOL(drm_sched_job_init);
>   * Refer to drm_sched_entity_push_job() documentation for locking
>   * considerations.
>   *
> + * drm_sched_job_cleanup() can be used to disarm the job again - but only
> + * _before_ the job's fences have been published. Once a drm_sched_fence was
> + * published, the associated job needs to be submitted to and processed by the
> + * scheduler to avoid potential deadlocks on the DMA fences encapsulated by
> + * drm_sched_fence.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> + *
>   * This can only be called if drm_sched_job_init() succeeded.
>   */
>  void drm_sched_job_arm(struct drm_sched_job *job)
> -- 
> 2.46.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

