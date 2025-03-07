Return-Path: <linux-kernel+bounces-551749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FB4A57048
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF4817229F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4517C24167C;
	Fri,  7 Mar 2025 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uau6aD9F"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEADE19ABC2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371456; cv=none; b=oQLIlFnLxtKc8kuagYksvEjAUS1MTOAVkRc/4u7wk7JPsgIgWNY7wZdz+JeipwWLWY+x1df6eoyEpTDLYIpPwzBDVdkfwBWyqMxUpharxz49RxokHNEmNEoI/UQjtSwsYYfb4c1ag1gsDwQja39P+2U7H1ort0FpNU//tRgmMM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371456; c=relaxed/simple;
	bh=MatKrKNTR2gPdUt+suaxqEvst/dIy9TByYy3WWLXDdE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nh10S6GWGYGeYGBOF/0vw3QZOB68CrFq/IXXTWHkao7lsomD0F6dazQDToS8BgpJiwQgNfWpbqdNbPfu+B5FoCcAhfra6q3qVxr8E93C5SwliaLXhgI/hCeglbvfxXkb2iufV7K11RmlBgc+G4mooeMgAeIwvJWz6uEEevuW9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uau6aD9F; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z8ZJL2792z9srd;
	Fri,  7 Mar 2025 19:17:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741371442; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IePPmOmMn8KJIitOVOV3s2iLtbd6ZgsJKHOeXdSwiwA=;
	b=uau6aD9F5+oh2NMxob2D6Gg5hf7asidDx3re/t8GC03fE7MJ6xr7E6CNCVndrHg6yan9jB
	6Z4Z2cYt9jvLWqP7I9vDl0GImOyzG8sfOY63gWKw/tJZDSQnrrNcA/82iWhN0GKW3ohZrt
	BzypSAkmHB5X7pRivubR1ZQR+bsBG18p2fDMFLZ3F4+aEk/XREQQsjkZEdXDuKxx1LkuE6
	4j/5MvKIYe5HaXjlc+mUssHSqt+2m7V/jRy7djeVu7T/lLvpUhqxRF0+FTmWKgvIb8NryD
	ALf9sDzqJNyXuJIEta/X3qMO7HZzwMO5FUAL+zejXC50CmOtVs683e9q5VHy8A==
Message-ID: <81065d3cdf24c3d972e46b39eff1b744c93c7ccc.camel@mailbox.org>
Subject: Re: [PATCH v7 1/3] drm/sched: Adjust outdated docu for run_job()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Philipp Stanner
 <phasta@kernel.org>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Fri, 07 Mar 2025 19:17:18 +0100
In-Reply-To: <7502a793-4e92-4bfc-9c87-66bd7fdd88ce@igalia.com>
References: <20250305130551.136682-2-phasta@kernel.org>
	 <20250305130551.136682-3-phasta@kernel.org>
	 <7502a793-4e92-4bfc-9c87-66bd7fdd88ce@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: bzczxdz9wd1pabtuc3yzuexj5eefyemq
X-MBO-RS-ID: 44e0341c584da62060b

On Fri, 2025-03-07 at 15:09 -0300, Ma=C3=ADra Canal wrote:
> Hi Philipp,
>=20
> On 05/03/25 10:05, Philipp Stanner wrote:
> > The documentation for drm_sched_backend_ops.run_job() mentions a
> > certain
> > function called drm_sched_job_recovery(). This function does not
> > exist.
> > What's actually meant is drm_sched_resubmit_jobs(), which is by now
> > also
> > deprecated.
> >=20
> > Furthermore, the scheduler expects to "inherit" a reference on the
> > fence
> > from the run_job() callback. This, so far, is also not documented.
> >=20
> > Remove the mention of the removed function.
> >=20
> > Discourage the behavior of drm_sched_backend_ops.run_job() being
> > called
> > multiple times for the same job.
> >=20
> > Document the necessity of incrementing the refcount in run_job().
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0 include/drm/gpu_scheduler.h | 34 ++++++++++++++++++++++++++++++-=
-
> > --
> > =C2=A0 1 file changed, 30 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/drm/gpu_scheduler.h
> > b/include/drm/gpu_scheduler.h
> > index 50928a7ae98e..6381baae8024 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -410,10 +410,36 @@ struct drm_sched_backend_ops {
> > =C2=A0=C2=A0					 struct drm_sched_entity
> > *s_entity);
> > =C2=A0=20
> > =C2=A0=C2=A0	/**
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @run_job: Called to=
 execute the job once all of the
> > dependencies
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * have been resolved.=
=C2=A0 This may be called multiple times,
> > if
> > -	 * timedout_job() has happened and
> > drm_sched_job_recovery()
> > -	 * decides to try it again.
> > +	 * @run_job: Called to execute the job once all of the
> > dependencies
> > +	 * have been resolved.
> > +	 *
> > +	 * @sched_job: the job to run
> > +	 *
> > +	 * The deprecated drm_sched_resubmit_jobs() (called by
> > &struct
> > +	 * drm_sched_backend_ops.timedout_job) can invoke this
> > again with the
> > +	 * same parameters. Using this is discouraged because it
> > violates
> > +	 * dma_fence rules, notably dma_fence_init() has to be
> > called on
> > +	 * already initialized fences for a second time. Moreover,
> > this is
> > +	 * dangerous because attempts to allocate memory might
> > deadlock with
> > +	 * memory management code waiting for the reset to
> > complete.
>=20
> Thanks for adding this paragraph!

You're welcome


>  Also, thanks Christian for providing
> this explanation in v5. It really helped clarify the reasoning behind
> deprecating drm_sched_resubmit_jobs().

I thought a bit more about it the last days and think that you are
right and we definitely have to tell drivers with hardware scheduler
how they can achieve that without using drm_sched_resubmit_jobs().

Unfortunately, I discovered that this is quite complicated and
certainly difficult to do right.

So I'd only feel comfortable writing more docu about that once we got
more input from Christian or someone else who's got a hardware
scheduler about how they're currently doing it


Cheers
P.

>=20
> Best Regards,
> - Ma=C3=ADra
>=20
> > +	 *
> > +	 * TODO: Document what drivers should do / use instead.
> > +	 *
> > +	 * This method is called in a workqueue context - either
> > from the
> > +	 * submit_wq the driver passed through drm_sched_init(),
> > or, if the
> > +	 * driver passed NULL, a separate, ordered workqueue the
> > scheduler
> > +	 * allocated.
> > +	 *
> > +	 * Note that the scheduler expects to 'inherit' its own
> > reference to
> > +	 * this fence from the callback. It does not invoke an
> > extra
> > +	 * dma_fence_get() on it. Consequently, this callback must
> > take a
> > +	 * reference for the scheduler, and additional ones for
> > the driver's
> > +	 * respective needs.
> > +	 *
> > +	 * Return:
> > +	 * * On success: dma_fence the driver must signal once the
> > hardware has
> > +	 * completed the job ("hardware fence").
> > +	 * * On failure: NULL or an ERR_PTR.
> > =C2=A0=C2=A0	 */
> > =C2=A0=C2=A0	struct dma_fence *(*run_job)(struct drm_sched_job
> > *sched_job);
> > =C2=A0=20
>=20


