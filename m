Return-Path: <linux-kernel+bounces-330429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE7979E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D46F1C22CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72414A62E;
	Mon, 16 Sep 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJLwPH20"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B927132122
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478920; cv=none; b=U3gZPJq7U+AWhh/x5OhOh57X4Z7IRWDpFlpbm/9xxMFnJrJDhCplkN7Nt6V/FN0w0mQX6GeZja7Da8kSVcn/rchl/UeGSuQ1u0FcSbVEimyCw8iN4+DQzk3MsDbCxiXuks+fvJCoUgZF9zMR/CDefVtVV4dD5t0BOFdWaEcTvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478920; c=relaxed/simple;
	bh=Qqv7OznoNkt1G9ZzgEs2gGZncCosETZuzNJcKhJHpYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufsJs1psouecoxw78YpDpL5NBtBv95i9YD1H3Dn2uNQnC2rDCpS1czojjn52v2LZ8tYhZV+SQQAE3dvzmxqFoMMmzjZ6UXi4tjaV5vaYTrrK5Gvr+cXG96UYGibbHGfViX2CGrLYRX65iRWivNpcV9mmyG2tXJKgbasL+LlbQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJLwPH20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A6BC4CEC4;
	Mon, 16 Sep 2024 09:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726478920;
	bh=Qqv7OznoNkt1G9ZzgEs2gGZncCosETZuzNJcKhJHpYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJLwPH20HPRnO3KcxyLuBi6BJI69a7fFTmVA3hCptxSamN02SOCwCcSpICUbuohwQ
	 PMOxEyaZ6fvRmCaxJnsY2iAJOQMY3LYXJMjONCSo7sv+gMj1cYMfV3bDAhy3NfSnbf
	 gRo0v7dq9QUscCz6OH1s2+LtO39GRy3lMf9xu9r/CETE0J4gosqtWH8CFSFtqf0aSi
	 JzZJnZqJaTQ7q0zmRMssRv742hRFh+D1p5ke0AZjm+AOYg0TCSJxYvtDvuA7lb0UHf
	 B/IAgC7daRy+nqP8/oN8fCjtYIUb15XQhwOQgNo7Xm9TTVMXNaxOSJrBA46plLQEn7
	 x+X7rOjLVET9Q==
Date: Mon, 16 Sep 2024 11:28:33 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>, Asahi Lina <lina@asahilina.net>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sched: Fix dynamic job-flow control race
Message-ID: <Zuf6QfZSH8nNKaNI@pollux>
References: <20240913165326.8856-1-robdclark@gmail.com>
 <2cdde083ae0c3a84eee435968155d9b2b8f91f91.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cdde083ae0c3a84eee435968155d9b2b8f91f91.camel@redhat.com>

On Mon, Sep 16, 2024 at 10:21:21AM +0200, Philipp Stanner wrote:
> On Fri, 2024-09-13 at 09:53 -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > Fixes a race condition reported here:
> > https://github.com/AsahiLinux/linux/issues/309#issuecomment-2238968609
> 
> As Danilo suggested before, I'd put this in a Fixes: section at the

I think you mean 'Closes'.

Please note that there's a v2 [1] already, which does that.

[1] https://lore.kernel.org/dri-devel/20240913202301.16772-1-robdclark@gmail.com/

> bottom and instead have a sentence here detailing what the race
> consists of, i.e., who is racing with whom.

That's written right below, isn't it?

> 
> P.
> 
> > 
> > The whole premise of lockless access to a single-producer-single-
> > consumer queue is that there is just a single producer and single
> > consumer.  That means we can't call drm_sched_can_queue() (which is
> > about queueing more work to the hw, not to the spsc queue) from
> > anywhere other than the consumer (wq).
> > 
> > This call in the producer is just an optimization to avoid scheduling
> > the consuming worker if it cannot yet queue more work to the hw.  It
> > is safe to drop this optimization to avoid the race condition.
> > 
> > Suggested-by: Asahi Lina <lina@asahilina.net>
> > Fixes: a78422e9dff3 ("drm/sched: implement dynamic job-flow control")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/scheduler/sched_main.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > b/drivers/gpu/drm/scheduler/sched_main.c
> > index ab53ab486fe6..1af1dbe757d5 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -1020,8 +1020,7 @@ EXPORT_SYMBOL(drm_sched_job_cleanup);
> >  void drm_sched_wakeup(struct drm_gpu_scheduler *sched,
> >  		      struct drm_sched_entity *entity)
> >  {
> > -	if (drm_sched_can_queue(sched, entity))
> > -		drm_sched_run_job_queue(sched);
> > +	drm_sched_run_job_queue(sched);
> >  }
> >  
> >  /**
> 

