Return-Path: <linux-kernel+bounces-316514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76D96D08D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61692877B9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDC919340B;
	Thu,  5 Sep 2024 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POypR8f2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A218A94F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521889; cv=none; b=YfovnuU4SMOfWW1xaOyOQvihZQeJeIvF/ZacbKgz+Hww/RIIeTtPDUMxVz31wicfr7JYQUBpd5y5YRTw1nshi29534t8/pR5t94kzb4y49GNVDVjqkE8U6i5zvrVuvY1KMfctig4f6wdRgkw6QF4xaDh+0S+yaMpb/yP3v5/U1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521889; c=relaxed/simple;
	bh=uecPjXmod0L1fRhy3mQRsKyik1AlQaAKAz7JbkPMwXQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDCkjRUpGn8Tm3DW6BO+QJXUN5LN2xfcQ1dfvUu1+sZEcsWwQlHNGD4xzyCtTPV5fHMD6C8KuVdgTd2NP2Uyyzml9upzr+xqOxCWyt7Er9IYK90XU6vm0DNvmzLdJ8/plq9w6gt+nmFhbVe7Zb7yos+51fJ8dw4Py8mmAH1v1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POypR8f2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725521886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQPlr8sUNNPI7lsNhVIiK3zyFyq7qxKHpLTVoZPDjoY=;
	b=POypR8f2YYNTdRwY1J68uK53kri6gDlXGwT9ae4jq+3U+kIZZKIxeQTVEAHOylqKNFTL6B
	CGlibUIFsgKULUY1LslR2SAeuYQlTOzvdmZ3ii/GSCEvYuz81E5vb6OkXMe59dcDGXOmhX
	D1VuqKmDwCrqmqMlA/u2/hW/qzNnWx4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-ui2oM7yTMO-zSb9D5sW9Jg-1; Thu, 05 Sep 2024 03:38:05 -0400
X-MC-Unique: ui2oM7yTMO-zSb9D5sW9Jg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-45684591127so7702731cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725521885; x=1726126685;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tQPlr8sUNNPI7lsNhVIiK3zyFyq7qxKHpLTVoZPDjoY=;
        b=UvrrRqkzDgytRCgsSe3gR9SgzzBx5mPNK5elehgwROzaqcHYrNTx4DWImTQlB29LFh
         DpMqiHmRPvH1YHJln5Q196ev0HhADi3qOBHnMoU4F1BuKetuBxvwoJgQxHtyTyEeMT4K
         BCbEizDcFHw36gOXTlDn0uwrVoilMjhXTH+HTOzdM1m9JDjS9Epi+4nDl59RMIu19+eU
         EkhZ/zfFQoo2YySvSyL6RjbOo/McRH/4oFgIcEBqrk9DnY7sgT3H+0njsSu7tJeb/Rql
         fs8rvV0THQr94hMrzvk6mdVWh8C3eI9jQwZ1OsOV2j0MtfRVyKLtIujlHEKIXtfsWKpu
         ROfw==
X-Forwarded-Encrypted: i=1; AJvYcCUVrwqwlC14qRQ6lzsbR/ytmRYY7S/DKzq7jSzC3FIEEHII72RoOGJbcuOISdTEbopIz8LBmuV5bRNTczo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqi+TMA3dPfyL69XwCqRSsDKiIHtQBdnOAFM+iffu+9lNcUI2b
	6eDkHPTR9MWaKZueB/soaqkrCPs1vyUq1oSCOZ/wr4Cy9IEtmfJ7fAU+fHDPZLqZkZoc3HfZHUb
	ed78bJi1Bb579HJIGRaxCEGfhBMaTey+ijMiAyKWInNAsndqF6eFJYou22K3VXQ==
X-Received: by 2002:a05:6214:54c6:b0:6c3:584c:c4b with SMTP id 6a1803df08f44-6c3584c2960mr161288216d6.30.1725521885001;
        Thu, 05 Sep 2024 00:38:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZTwDclU9sr2qoDoa9l2BVgHPH2YYWQstkUeeVWS4+5rpgfb18cdTFNKgGLPjzRJNAyy1Xqg==
X-Received: by 2002:a05:6214:54c6:b0:6c3:584c:c4b with SMTP id 6a1803df08f44-6c3584c2960mr161288046d6.30.1725521884501;
        Thu, 05 Sep 2024 00:38:04 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b572besm5131261cf.58.2024.09.05.00.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:38:04 -0700 (PDT)
Message-ID: <ccbf75a939b90fe9a41734fab038bc35f0963878.camel@redhat.com>
Subject: Re: [RFC PATCH] drm/sched: Fix teardown leaks with waitqueue
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost
 <matthew.brost@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Danilo
 Krummrich <dakr@redhat.com>
Date: Thu, 05 Sep 2024 09:38:01 +0200
In-Reply-To: <ZtidJ8S9THvzkQ-6@phenom.ffwll.local>
References: <20240903094446.29797-2-pstanner@redhat.com>
	 <ZtidJ8S9THvzkQ-6@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 19:47 +0200, Simona Vetter wrote:
> On Tue, Sep 03, 2024 at 11:44:47AM +0200, Philipp Stanner wrote:
> > The GPU scheduler currently does not ensure that its pending_list
> > is
> > empty before performing various other teardown tasks in
> > drm_sched_fini().
> >=20
> > If there are still jobs in the pending_list, this is problematic
> > because
> > after scheduler teardown, no one will call backend_ops.free_job()
> > anymore. This would, consequently, result in memory leaks.
> >=20
> > One way to solves this is to implement a waitqueue that
> > drm_sched_fini()
> > blocks on until the pending_list has become empty.
> >=20
> > Add a waitqueue to struct drm_gpu_scheduler. Wake up waiters once
> > the
> > pending_list becomes empty. Wait in drm_sched_fini() for that to
> > happen.
> >=20
> > Suggested-by: Danilo Krummrich <dakr@redhat.com>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > Hi all,
> >=20
> > since the scheduler has many stake holders, I want this solution
> > discussed as an RFC first.
> >=20
> > This version here has IMO the advantage (and disadvantage...) that
> > it
> > blocks infinitly if the driver messed up the clean up, so problems
> > might become more visible than the refcount solution I proposed in
> > parallel.
>=20
> Very quick comment because I'm heading out for the r4l conference,
> but
> maybe I can discuss this there with Danilo a bit.
>=20
> Maybe we should do step 0 first, and document the current rules? The
> kerneldoc isn't absolute zero anymore, but it's very, very bare-
> bones.
> Then get that acked and merged, which is a very good way to make sure
> we're actually standing on common ground.

Yes, documentation is definitely also on my TODO list. I wanted to send
out something clarifying the objects' lifetimes (based on Christian's
previous series [1]) quite soon.

>=20
> Then maybe step 0.5 would be to add runtime asserts to enforce the
> rules,
> like if you tear down the scheduler and there's stuff in flight, you
> splat
> on a WARN_ON.
>=20
> With that foundation there should be a lot clearer basis to discuss
> whether there is an issue, and what a better design could look like.

I mean, I'm quite sure that there are teardown issues. But we could
indeed make them visible first through documentation (and a FIXME tag)
and after establishing consensus through merging that go on as you
suggested.

> The
> little pondering I've done I've come up with a few more ideas along
> similar lines.
>=20
> One comment below, kinda unrelated.
>=20
> >=20
> > Cheers,
> > P.
> > ---
> > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 40
> > ++++++++++++++++++++++++++
> > =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++
> > =C2=A02 files changed, 44 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > b/drivers/gpu/drm/scheduler/sched_main.c
> > index 7e90c9f95611..200fa932f289 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -564,6 +564,13 @@ static void drm_sched_job_timedout(struct
> > work_struct *work)
> > =C2=A0		 * is parked at which point it's safe.
> > =C2=A0		 */
> > =C2=A0		list_del_init(&job->list);
> > +
> > +		/*
> > +		 * Inform tasks blocking in drm_sched_fini() that
> > it's now safe to proceed.
> > +		 */
> > +		if (list_empty(&sched->pending_list))
> > +			wake_up(&sched->job_list_waitque);
> > +
> > =C2=A0		spin_unlock(&sched->job_list_lock);
> > =C2=A0
> > =C2=A0		status =3D job->sched->ops->timedout_job(job);
> > @@ -584,6 +591,15 @@ static void drm_sched_job_timedout(struct
> > work_struct *work)
> > =C2=A0		drm_sched_start_timeout_unlocked(sched);
> > =C2=A0}
> > =C2=A0
> > +static bool drm_sched_no_jobs_pending(struct drm_gpu_scheduler
> > *sched)
> > +{
> > +	/*
> > +	 * For list_empty() to work without a lock.
> > +	 */
>=20
> So this is pretty far from the gold standard for documenting memory
> barrier semantics in lockless code. Ideally we have a comment for
> both
> sides of the barrier (you always need two, or there's no function
> barrier), pointing at each another, and explaining exactly what's
> being
> synchronized against what and how.
>=20
> I did years ago add a few missing barriers with that approach, see
> b0a5303d4e14 ("drm/sched: Barriers are needed for
> entity->last_scheduled"). Reading that patch again it feels a bit on
> the
> terse side of things (plus I noticed spelling issues now too, oops).

ACK, will do that properly once we role out the actual patch.


P.

>=20
> Cheers, Sima
>=20
> > +	rmb();
> > +	return list_empty(&sched->pending_list);
> > +}
> > +
> > =C2=A0/**
> > =C2=A0 * drm_sched_stop - stop the scheduler
> > =C2=A0 *
> > @@ -659,6 +675,12 @@ void drm_sched_stop(struct drm_gpu_scheduler
> > *sched, struct drm_sched_job *bad)
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > +	/*
> > +	 * Inform tasks blocking in drm_sched_fini() that it's now
> > safe to proceed.
> > +	 */
> > +	if (drm_sched_no_jobs_pending(sched))
> > +		wake_up(&sched->job_list_waitque);
> > +
> > =C2=A0	/*
> > =C2=A0	 * Stop pending timer in flight as we rearm it in=C2=A0
> > drm_sched_start. This
> > =C2=A0	 * avoids the pending timeout work in progress to fire
> > right away after
> > @@ -1085,6 +1107,12 @@ drm_sched_get_finished_job(struct
> > drm_gpu_scheduler *sched)
> > =C2=A0		/* remove job from pending_list */
> > =C2=A0		list_del_init(&job->list);
> > =C2=A0
> > +		/*
> > +		 * Inform tasks blocking in drm_sched_fini() that
> > it's now safe to proceed.
> > +		 */
> > +		if (list_empty(&sched->pending_list))
> > +			wake_up(&sched->job_list_waitque);
> > +
> > =C2=A0		/* cancel this job's TO timer */
> > =C2=A0		cancel_delayed_work(&sched->work_tdr);
> > =C2=A0		/* make the scheduled timestamp more accurate */
> > @@ -1303,6 +1331,7 @@ int drm_sched_init(struct drm_gpu_scheduler
> > *sched,
> > =C2=A0	init_waitqueue_head(&sched->job_scheduled);
> > =C2=A0	INIT_LIST_HEAD(&sched->pending_list);
> > =C2=A0	spin_lock_init(&sched->job_list_lock);
> > +	init_waitqueue_head(&sched->job_list_waitque);
> > =C2=A0	atomic_set(&sched->credit_count, 0);
> > =C2=A0	INIT_DELAYED_WORK(&sched->work_tdr,
> > drm_sched_job_timedout);
> > =C2=A0	INIT_WORK(&sched->work_run_job, drm_sched_run_job_work);
> > @@ -1333,12 +1362,23 @@ EXPORT_SYMBOL(drm_sched_init);
> > =C2=A0 * @sched: scheduler instance
> > =C2=A0 *
> > =C2=A0 * Tears down and cleans up the scheduler.
> > + *
> > + * Note that this function blocks until the fences returned by
> > + * backend_ops.run_job() have been signalled.
> > =C2=A0 */
> > =C2=A0void drm_sched_fini(struct drm_gpu_scheduler *sched)
> > =C2=A0{
> > =C2=A0	struct drm_sched_entity *s_entity;
> > =C2=A0	int i;
> > =C2=A0
> > +	/*
> > +	 * Jobs that have neither been scheduled or which have
> > timed out are
> > +	 * gone by now, but jobs that have been submitted through
> > +	 * backend_ops.run_job() and have not yet terminated are
> > still pending.
> > +	 *
> > +	 * Wait for the pending_list to become empty to avoid
> > leaking those jobs.
> > +	 */
> > +	wait_event(sched->job_list_waitque,
> > drm_sched_no_jobs_pending(sched));
> > =C2=A0	drm_sched_wqueue_stop(sched);
> > =C2=A0
> > =C2=A0	for (i =3D DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs;
> > i++) {
> > diff --git a/include/drm/gpu_scheduler.h
> > b/include/drm/gpu_scheduler.h
> > index 5acc64954a88..bff092784405 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -29,6 +29,7 @@
> > =C2=A0#include <linux/completion.h>
> > =C2=A0#include <linux/xarray.h>
> > =C2=A0#include <linux/workqueue.h>
> > +#include <linux/wait.h>
> > =C2=A0
> > =C2=A0#define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
> > =C2=A0
> > @@ -503,6 +504,8 @@ struct drm_sched_backend_ops {
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 timeout interval is over.
> > =C2=A0 * @pending_list: the list of jobs which are currently in the job
> > queue.
> > =C2=A0 * @job_list_lock: lock to protect the pending_list.
> > + * @job_list_waitque: a waitqueue for drm_sched_fini() to block on
> > until all
> > + *		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pending jobs have been finished.
> > =C2=A0 * @hang_limit: once the hangs by a job crosses this limit then i=
t
> > is marked
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 guilty and it will no longer be considered for
> > scheduling.
> > =C2=A0 * @score: score to help loadbalancer pick a idle sched
> > @@ -532,6 +535,7 @@ struct drm_gpu_scheduler {
> > =C2=A0	struct delayed_work		work_tdr;
> > =C2=A0	struct list_head		pending_list;
> > =C2=A0	spinlock_t			job_list_lock;
> > +	wait_queue_head_t		job_list_waitque;
> > =C2=A0	int				hang_limit;
> > =C2=A0	atomic_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 *score;
> > =C2=A0	atomic_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 _score;
> > --=20
> > 2.46.0
> >=20
>=20


