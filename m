Return-Path: <linux-kernel+bounces-328714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FE69787B3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39DEB22991
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F3D12C474;
	Fri, 13 Sep 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHWlAC08"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C11EEE0
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251518; cv=none; b=jH3P8It/baSsqWvLmVNb9tkBxkpqji+rildXCbVdS91h2/HGKSulvOAbzjLqjzBHIlwyIz46eRan44YcgBy/YBXX2TJlZf0tKXshgoqlTvNtKGMC2K8K60P8BHGERleOJChEoxVlQfoHJ3m9OoT6bh/Y5Vv7jgucDHBZM/wYq+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251518; c=relaxed/simple;
	bh=HbiNcPk5QOKYwQlU2DOcnIYYD6j9FJIwflxJ5rbaxnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fw5eYg3xlHnAlxNNsrk2Aw/kX3INdStFn4XCTOYFEHoAxAkpCsRlVuFovZKi4BZccPZqXOz/PLIzc1xEDuYp/7Z+O/WD1cYITa7BC29T+SmDIWRWpxGpSo8FoZ0lMEIbnDfrJEtAb/mJIaoRwtROhbvcZORmOv9HHR9eMVVRuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHWlAC08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC182C4CEC0;
	Fri, 13 Sep 2024 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726251517;
	bh=HbiNcPk5QOKYwQlU2DOcnIYYD6j9FJIwflxJ5rbaxnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHWlAC08xQHiGnVx9lq3sIuhGq9uK5g4RFqACFDpRNaLjDxFzPuGZ7Fz/NczpdgOQ
	 5j1Eqp4Gz/De5X5hHoJYr4LbG0bYZefSRYUcx53B7LSlvMlRVMy+If8THEqhqSS+Tm
	 fh3jJ5X/lwq0Ss+EjtV7+68hYVzMSibORbBDmUAWr8yBdrfHNofurRV+/qxu6yAp5+
	 2FZ1AVM5gZ+KIzmWJzRvhEN/gohLEIBF0sfNH0sG9fgx1L01QfYC5QPNDAyJumwMHv
	 gWatB51LAbQiDNdbWDPdssbYD+ZwssYyZxPL/ndA57IKiMiwFATDJxfedLY49ndIFt
	 7a22vcyzcjokA==
Date: Fri, 13 Sep 2024 20:18:29 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
	Asahi Lina <lina@asahilina.net>, Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Danilo Krummrich <dakr@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sched: Fix dynamic job-flow control race
Message-ID: <ZuSB9UzlHLKEnag3@pollux>
References: <20240913165326.8856-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913165326.8856-1-robdclark@gmail.com>

On Fri, Sep 13, 2024 at 09:53:25AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Fixes a race condition reported here: https://github.com/AsahiLinux/linux/issues/309#issuecomment-2238968609

Good catch! Please add a 'Closes' tag with this link.

> 
> The whole premise of lockless access to a single-producer-single-
> consumer queue is that there is just a single producer and single
> consumer.  That means we can't call drm_sched_can_queue() (which is
> about queueing more work to the hw, not to the spsc queue) from
> anywhere other than the consumer (wq).
> 
> This call in the producer is just an optimization to avoid scheduling
> the consuming worker if it cannot yet queue more work to the hw.  It
> is safe to drop this optimization to avoid the race condition.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Fixes: a78422e9dff3 ("drm/sched: implement dynamic job-flow control")

You may want to explicitly CC stable.

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index ab53ab486fe6..1af1dbe757d5 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1020,8 +1020,7 @@ EXPORT_SYMBOL(drm_sched_job_cleanup);
>  void drm_sched_wakeup(struct drm_gpu_scheduler *sched,
>  		      struct drm_sched_entity *entity)

Please also remove the entity parameter. For the other refactoring, I agree it
should be in a different patch.

With that,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

Thanks for fixing this.

- Danilo

>  {
> -	if (drm_sched_can_queue(sched, entity))
> -		drm_sched_run_job_queue(sched);
> +	drm_sched_run_job_queue(sched);
>  }
>  
>  /**
> -- 
> 2.46.0
> 

