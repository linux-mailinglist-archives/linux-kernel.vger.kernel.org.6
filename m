Return-Path: <linux-kernel+bounces-524031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1797BA3DE2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6983A169A25
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857871FE479;
	Thu, 20 Feb 2025 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsigZWNO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4CF1FDA89
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064690; cv=none; b=ku8uUdQ8J0SkXsFcTsXojiUqju92UbeuVBWtOHURpm7bj1fq7HVrdIs7LHJ3O13t8ZaBAsAWkPAqgxomCf1Xy4XkY20A09pXzQWsauTZUg9pYz7nnL9UA0pwPQYD/HKDM7k44q4xiVp3gZAA6J5CfToxfrzT8CoUDzUiVbmnMTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064690; c=relaxed/simple;
	bh=ztgeP+4qBRV/ha7wobiMt9LPylTukg+cP4w+EOtXaYk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dun2vpOf/vKgyxNSOgzNPjhCT3++B4j61lzanFVkuxJ0qDUn98JTCzga1wT55+bWLkeuw1bo4z2aYgiW7BOYOJtv38oc3XLu1CShdRrZj7gvLB2d+rqNNOhHlQYtlTwRwzi6wRIu9J5JBjfqfXHO3LZsdZUSHvuwUyEgqBhOrpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsigZWNO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740064687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJKKQXezkb4XbcyeMDKBvpFa8aXavg2f3XNPpB9D6Fs=;
	b=fsigZWNO33qUd2b4Y1qGV45PyDtHfgaBSIceRq4aC8XUi9GrJgupRlNGThlQUeMgMYw792
	kPOf/yxMKDZ48cqmtJJhCOMSgBESNLY59GrUY8q297AEV75N7tcJ7Rz8GO6FmtnTLAZ1sF
	JbLcsi6LkzLv1TMAnhmMuyXlERhq6TM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-g5ETHmadPQqaarrWH9UIZA-1; Thu, 20 Feb 2025 10:18:06 -0500
X-MC-Unique: g5ETHmadPQqaarrWH9UIZA-1
X-Mimecast-MFC-AGG-ID: g5ETHmadPQqaarrWH9UIZA_1740064685
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f36f03312so547457f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064685; x=1740669485;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJKKQXezkb4XbcyeMDKBvpFa8aXavg2f3XNPpB9D6Fs=;
        b=tTlaspRUakxg2JQb3EfFkaq8q8Yn+LXJfZv8HuBk8rkGw4JWwJYh30Ai+lddQpTDhI
         dtkWx9ts1Ayjlgat6nF9cAdcozvmEpgPurYJEJnlUU3wVwUlrfX89pa/vjzXWLv3z9Q8
         k6JFVMcwgsv7zZ3mBsNm6+eUVEG4RPqHsQGyaYt7Zb7Yv2E+JzvZZD9gWHIxCDFQokyI
         B76vShlYaddLNOqmdi2MxImczgC9QnCJfjBW988fPQ6ZiMjJ0kOND7XWCtEoaBCTZ1pF
         CYGJmlTwKc8bAZ9iydwOhj9Ydg36uqN9+AIk0/7VPJbu2zFjO6potS8joLGIS0OCjxDh
         rW6w==
X-Forwarded-Encrypted: i=1; AJvYcCVDF/wHFHORMnObq9Ueqyz5KqVrhr+kiiEcoLCt9I2i194TiIZ0Bh/iVtsO2/SIrxV9IyFB4mAvieUUwXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwERdErBTNGbVC/57CP2J7tqndMgKcgqUrCXWYmRuNPLFMdeiKZ
	sX1gvc43xpsOZPNPNxOpkHh2RgdD/mgscfpDbmnJkLJtywfxwwYSQb35KWjx7s5o9yTMrbIxZQi
	CRBwGtBwNh3zLBvksI2uS5WLdd+3/nOQ9OMrbxKnaSffOIqT6lCjwSR+bY1YEiA==
X-Gm-Gg: ASbGncuuV3Fvk7X3mdrxH/K/Qe222LbwPM6IvzwDsHIR8cEu5r4uATyvWSlBBCrA9lg
	XJtErjs8xyGesBZAwVMbmtaDR6xUQpnLDXPyTUceb0wE8h+p9fLZtPVDsXTsJzMtgzm6NrhSze+
	tkq4bFGqsvkinnKILRbCaSwPAYhU1RqLOZ6Rp2gwPasFL4/8Vqr/DiUVzesHvGzk3Jy4/NHxrEY
	V4ExQZkouPczhWUC3s/6vWGduU7yas0mfvlIGds8lthl9FK3cA3udg0ToiBLbISY1q5aQbyhRpG
	0EToSwICqW066xyr/k9nQJvowMkTeA==
X-Received: by 2002:adf:f60f:0:b0:38d:dc4d:3476 with SMTP id ffacd0b85a97d-38f33f58da4mr18298513f8f.52.1740064685142;
        Thu, 20 Feb 2025 07:18:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGw0Np0iMPXyqskhwR/np+dPCkpfyMTYSiEwYQz6MNjvB6fw9+OMARKMG+dc7NsWkoJpGyZ3w==
X-Received: by 2002:adf:f60f:0:b0:38d:dc4d:3476 with SMTP id ffacd0b85a97d-38f33f58da4mr18298474f8f.52.1740064684659;
        Thu, 20 Feb 2025 07:18:04 -0800 (PST)
Received: from [10.32.64.16] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259fdce7sm21109971f8f.96.2025.02.20.07.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:18:04 -0800 (PST)
Message-ID: <376c7d96559f2bf5a464ac2c51bdc69fbf940c45.camel@redhat.com>
Subject: Re: [PATCH v5 3/3] drm/sched: Update timedout_job()'s documentation
From: Philipp Stanner <pstanner@redhat.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Philipp Stanner
 <phasta@kernel.org>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2025 16:18:03 +0100
In-Reply-To: <6ec16915-d7ae-4b1f-b156-80892d98e119@igalia.com>
References: <20250220112813.87992-2-phasta@kernel.org>
	 <20250220112813.87992-5-phasta@kernel.org>
	 <6ec16915-d7ae-4b1f-b156-80892d98e119@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 10:42 -0300, Ma=C3=ADra Canal wrote:
> Hi Philipp,
>=20
> On 20/02/25 08:28, Philipp Stanner wrote:
> > drm_sched_backend_ops.timedout_job()'s documentation is outdated.
> > It
> > mentions the deprecated function drm_sched_resubmit_job().
> > Furthermore,
> > it does not point out the important distinction between hardware
> > and
> > firmware schedulers.
> >=20
> > Since firmware schedulers tyipically only use one entity per
> > scheduler,
> > timeout handling is significantly more simple because the entity
> > the
> > faulted job came from can just be killed without affecting innocent
> > processes.
> >=20
> > Update the documentation with that distinction and other details.
> >=20
> > Reformat the docstring to work to a unified style with the other
> > handles.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0 include/drm/gpu_scheduler.h | 83 +++++++++++++++++++++++--------=
-
> > -----
> > =C2=A0 1 file changed, 52 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/include/drm/gpu_scheduler.h
> > b/include/drm/gpu_scheduler.h
> > index 29e5bda91806..18cdeacf8651 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -393,8 +393,15 @@ static inline bool
> > drm_sched_invalidate_job(struct drm_sched_job *s_job,
> > =C2=A0=C2=A0	return s_job && atomic_inc_return(&s_job->karma) >
> > threshold;
> > =C2=A0 }
> > =C2=A0=20
> > +/**
> > + * enum drm_gpu_sched_stat - the scheduler's status
> > + *
> > + * @DRM_GPU_SCHED_STAT_NONE: Reserved. Do not use.
> > + * @DRM_GPU_SCHED_STAT_NOMINAL: Operation succeeded.
> > + * @DRM_GPU_SCHED_STAT_ENODEV: Error: Device is not available
> > anymore.
> > + */
> > =C2=A0 enum drm_gpu_sched_stat {
> > -	DRM_GPU_SCHED_STAT_NONE, /* Reserve 0 */
> > +	DRM_GPU_SCHED_STAT_NONE,
> > =C2=A0=C2=A0	DRM_GPU_SCHED_STAT_NOMINAL,
> > =C2=A0=C2=A0	DRM_GPU_SCHED_STAT_ENODEV,
> > =C2=A0 };
> > @@ -430,6 +437,11 @@ struct drm_sched_backend_ops {
> > =C2=A0=C2=A0	 *
> > =C2=A0=C2=A0	 * TODO: Document which fence rules above.
> > =C2=A0=C2=A0	 *
> > +	 * This method is called in a workqueue context - either
> > from the
> > +	 * submit_wq the driver passed through &drm_sched_init(),
> > or, if the
> > +	 * driver passed NULL, a separate, ordered workqueue the
> > scheduler
> > +	 * allocated.
> > +	 *
>=20
> The commit message mentions "Update timedout_job()'s documentation".
> As
> this hunk is related to `run_job()`, maybe it would be a better fit
> to
> patch 2/3.
>=20
> > =C2=A0=C2=A0	 * @sched_job: the job to run
> > =C2=A0=C2=A0	 *
> > =C2=A0=C2=A0	 * Note that the scheduler expects to 'inherit' its own
> > reference to
> > @@ -449,43 +461,52 @@ struct drm_sched_backend_ops {
> > =C2=A0=C2=A0	 * @timedout_job: Called when a job has taken too long to
> > execute,
> > =C2=A0=C2=A0	 * to trigger GPU recovery.
> > =C2=A0=C2=A0	 *
> > -	 * This method is called in a workqueue context.
> > +	 * @sched_job: The job that has timed out
> > =C2=A0=C2=A0	 *
> > -	 * Drivers typically issue a reset to recover from GPU
> > hangs, and this
> > -	 * procedure usually follows the following workflow:
> > +	 * Drivers typically issue a reset to recover from GPU
> > hangs.
> > +	 * This procedure looks very different depending on
> > whether a firmware
> > +	 * or a hardware scheduler is being used.
> > =C2=A0=C2=A0	 *
> > -	 * 1. Stop the scheduler using drm_sched_stop(). This will
> > park the
> > -	 *=C2=A0=C2=A0=C2=A0 scheduler thread and cancel the timeout work,
> > guaranteeing that
> > -	 *=C2=A0=C2=A0=C2=A0 nothing is queued while we reset the hardware qu=
eue
> > -	 * 2. Try to gracefully stop non-faulty jobs (optional)
> > -	 * 3. Issue a GPU reset (driver-specific)
> > -	 * 4. Re-submit jobs using drm_sched_resubmit_jobs()
> > -	 * 5. Restart the scheduler using drm_sched_start(). At
> > that point, new
> > -	 *=C2=A0=C2=A0=C2=A0 jobs can be queued, and the scheduler thread is
> > unblocked
> > +	 * For a FIRMWARE SCHEDULER, each ring has one scheduler,
> > and each
> > +	 * scheduler has one entity. Hence, the steps taken
> > typically look as
> > +	 * follows:
> > +	 *
> > +	 * 1. Stop the scheduler using drm_sched_stop(). This will
> > pause the
> > +	 *=C2=A0=C2=A0=C2=A0 scheduler workqueues and cancel the timeout work=
,
> > guaranteeing
> > +	 *=C2=A0=C2=A0=C2=A0 that nothing is queued while the ring is being
> > removed.
> > +	 * 2. Remove the ring. The firmware will make sure that
> > the
> > +	 *=C2=A0=C2=A0=C2=A0 corresponding parts of the hardware are resetted=
,
> > and that other
> > +	 *=C2=A0=C2=A0=C2=A0 rings are not impacted.
> > +	 * 3. Kill the entity and the associated scheduler.
> > +	 *
> > +	 *
> > +	 * For a HARDWARE SCHEDULER, a scheduler instance
> > schedules jobs from
> > +	 * one or more entities to one ring. This implies that all
> > entities
> > +	 * associated with the affected scheduler cannot be torn
> > down, because
> > +	 * this would effectively also affect innocent userspace
> > processes which
> > +	 * did not submit faulty jobs (for example).
> > +	 *
> > +	 * Consequently, the procedure to recover with a hardware
> > scheduler
> > +	 * should look like this:
> > +	 *
> > +	 * 1. Stop all schedulers impacted by the reset using
> > drm_sched_stop().
> > +	 * 2. Kill the entity the faulty job stems from.
> > +	 * 3. Issue a GPU reset on all faulty rings (driver-
> > specific).
> > +	 * 4. Re-submit jobs on all schedulers impacted by re-
> > submitting them to
> > +	 *=C2=A0=C2=A0=C2=A0 the entities which are still alive.
>=20
> I believe that a mention to `drm_sched_resubmit_jobs()` still worth
> it,
> even mentioning that it is a deprecated option and it shouldn't be
> used
> in new code. It is deprecated indeed, but we still have five users.

I see no reason to mention a deprecated function. What would that be
good for? Why should I direct someone to something that he must not
use?

The drivers which already use it don't need that documentation, since
they're more or less functioning already. And even they shouldn't be
encouraged to keep using it; the list above basically is a list
exclusively about how to do things right.

And the new drivers should best not even know that this function
exists.

Furthermore, additional mentions of the function just increases the
probability that the comment / docu will be forgotten when the
deprecated function is finally removed.
(We have multiple such places within the scheduler. Some comments still
refer to a "thread", despite the scheduler now being based on
workqueues)

So NACK to that idea.

Regarding your other review ideas, I'll look into them

Thx
P.


>=20
> Best Regards,
> - Ma=C3=ADra
>=20
> > +	 * 5. Restart all schedulers that were stopped in step #1
> > using
> > +	 *=C2=A0=C2=A0=C2=A0 drm_sched_start().
> > =C2=A0=C2=A0	 *
> > =C2=A0=C2=A0	 * Note that some GPUs have distinct hardware queues but
> > need to reset
> > =C2=A0=C2=A0	 * the GPU globally, which requires extra synchronization
> > between the
> > -	 * timeout handler of the different &drm_gpu_scheduler.
> > One way to
> > -	 * achieve this synchronization is to create an ordered
> > workqueue
> > -	 * (using alloc_ordered_workqueue()) at the driver level,
> > and pass this
> > -	 * queue to drm_sched_init(), to guarantee that timeout
> > handlers are
> > -	 * executed sequentially. The above workflow needs to be
> > slightly
> > -	 * adjusted in that case:
> > +	 * timeout handlers of different schedulers. One way to
> > achieve this
> > +	 * synchronization is to create an ordered workqueue
> > (using
> > +	 * alloc_ordered_workqueue()) at the driver level, and
> > pass this queue
> > +	 * as drm_sched_init()'s @timeout_wq parameter. This will
> > guarantee
> > +	 * that timeout handlers are executed sequentially.
> > =C2=A0=C2=A0	 *
> > -	 * 1. Stop all schedulers impacted by the reset using
> > drm_sched_stop()
> > -	 * 2. Try to gracefully stop non-faulty jobs on all queues
> > impacted by
> > -	 *=C2=A0=C2=A0=C2=A0 the reset (optional)
> > -	 * 3. Issue a GPU reset on all faulty queues (driver-
> > specific)
> > -	 * 4. Re-submit jobs on all schedulers impacted by the
> > reset using
> > -	 *=C2=A0=C2=A0=C2=A0 drm_sched_resubmit_jobs()
> > -	 * 5. Restart all schedulers that were stopped in step #1
> > using
> > -	 *=C2=A0=C2=A0=C2=A0 drm_sched_start()
> > +	 * Return: The scheduler's status, defined by
> > &drm_gpu_sched_stat
> > =C2=A0=C2=A0	 *
> > -	 * Return DRM_GPU_SCHED_STAT_NOMINAL, when all is normal,
> > -	 * and the underlying driver has started or completed
> > recovery.
> > -	 *
> > -	 * Return DRM_GPU_SCHED_STAT_ENODEV, if the device is no
> > longer
> > -	 * available, i.e. has been unplugged.
> > =C2=A0=C2=A0	 */
> > =C2=A0=C2=A0	enum drm_gpu_sched_stat (*timedout_job)(struct
> > drm_sched_job *sched_job);
> > =C2=A0=20
>=20


