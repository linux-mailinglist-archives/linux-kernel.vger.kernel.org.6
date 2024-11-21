Return-Path: <linux-kernel+bounces-417200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD7C9D5074
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB642832DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACF8199244;
	Thu, 21 Nov 2024 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/BN9LIO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98A055C29
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205150; cv=none; b=efBXfN+CSD/BJrQ0fgygPc1xu61t5ml3fKPbS28yHNJAjYGwUkJqdNzuGzXMZ9N9YlhswHiL5VlQgYIB+b+XOpVycOf7+CyTNZ+Nyk6ak+3hrTvs1LV7bQGT+qm6oiGcXo6LQ+2U+NPt845gM26Wav3D//hOMm3eu/A8eOfS9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205150; c=relaxed/simple;
	bh=3H2tp+fKlXUNgD/iO0hOaEeqwSEybq+G/6nqNt+qHrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=de5pGWucSobMKj7h2otH4A62yPVH3tM6R/C8uiO0yefi4plyTJoyIVJ5S3kTkS/N94jdBcAaKrfaB0OPi9xDM/Bn0X87VX91y6HaztRrH2KIgpcqmiuiwvTofZfx41CaIoitLWpA1KU37D5R//jkfNdMY41clPE0GHSQu/V3AvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/BN9LIO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-382325b0508so789283f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732205147; x=1732809947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEAaIFollmGbkAyp3AHhRVP5SIOvpa6F1CuzSDWZFfM=;
        b=t/BN9LIOFNJlfVrUbJf3tWlgGOEPiwMEGuD1vl/FbI8ltHfD3xoEhpnfBr7IeGxhII
         3Fckz4w1s9kBS56+RUY+51aps2MWrXcTAtd7ygO1IdRAtBnF5e0ZbyZg1oZntYfPdI/k
         +45CBuQzXzJy5GmqhTEX81Q7Dea0yItNDLXKPqBJ/1iFDsnV6DVqockQ1LxlhmTBxCqe
         Zu+c98WAwPLDDlkrZdjaejdih6F23F5VQLW94i1EiXdejz82jfa3++Bl0urTcj953q/7
         nBqDWZae+MDBy7MeqBkkUGs38I6g0egMkPXrsuEiuqyYjTU4Hm8kmG9h9LVSR78ITrnd
         +VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732205147; x=1732809947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEAaIFollmGbkAyp3AHhRVP5SIOvpa6F1CuzSDWZFfM=;
        b=mVZYUZ88Cg1rn1I5ITtx+0QyBZ+0I7gtc41M9expZ63DgDP8oi93sUFR2dmWplghsj
         C/42w2V2ScY35pCXFeIh9mv5tDvi3N67c5lq9A6TaNY9aklrWJcwzQltMAPzg/BFyRHl
         aEy4D4yrFxcmFil0ab4Lf6cgTlJFLJCLMiRjcNzH3LcrECQsaTvqE+oNd73GElinJ47m
         a7V0g9E4VD5A2Ot0RpZ71NbT4K3+Qsn3jrVZ5mPYS/oWctsyiXrHZagBL35VTgpfLl9B
         eimMxTzEMr+5UVGAmtG7FMQ85z3sIWpQgec2TQ9RFIC6s/WQfa6q4Ti5lHL2H2abus3t
         0Qww==
X-Forwarded-Encrypted: i=1; AJvYcCX+agKfGH85uRQlKlKoolD7F0USW/pufSzZJvAcn5T2RXwxHn2E9ragXoVAuvBRiQEKe6dReRvHIXndrn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3xG/nQ/SER/syj4+bzHRjkF8sDEInaAI85JZyGMe2QL2rVtk
	F9Pul6EmpuS8vCVLBAtvuOfeXaMBMhlOEskPhzFMyRT+fc0SZw7sKyDDcQRpRX6cnwbeUokunEu
	iRXYMJ1lLnoMKGFpuNfFnycuz5CP8o7KD9o7/
X-Gm-Gg: ASbGncvashraq9YdYLWkBWuQg4lf+1IBjY6lyNAUA4ZmO4QMylGrn5mJKqmQs1p7G16
	GJ+yFUH0qJ5HfjZLLnvypqvLuif4YhvUKFk9fxIh98Qr+VGn8LeoD2U7iNzrhCg==
X-Google-Smtp-Source: AGHT+IGmNqvNXb2DSqa03STb7qfR1tFxwoMJdZnTGvCUv2SFAeidQb5w5dsrd1AhJ92533DrXXthWiLaMUqXQW4DGSk=
X-Received: by 2002:a05:6000:184f:b0:382:45e7:9bb9 with SMTP id
 ffacd0b85a97d-38254b1f2abmr5347282f8f.54.1732205146402; Thu, 21 Nov 2024
 08:05:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115103548.90605-2-pstanner@redhat.com>
In-Reply-To: <20241115103548.90605-2-pstanner@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Nov 2024 17:05:34 +0100
Message-ID: <CAH5fLghFVxYUz0PRKq3_xsvaYpaaCGXBg9AOUnkYfiUpo70dTg@mail.gmail.com>
Subject: Re: [PATCH] drm/sched: Extend and update documentation
To: Philipp Stanner <pstanner@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, Luben Tuikov <ltuikov89@gmail.com>, 
	Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 11:36=E2=80=AFAM Philipp Stanner <pstanner@redhat.c=
om> wrote:
>
> The various objects defined and used by the GPU scheduler are currently
> not fully documented. Furthermore, there is no documentation yet
> informing drivers about how they should handle timeouts.
>
> Add documentation describing the scheduler's objects and timeout
> procedure. Consistently, update drm_sched_backend_ops.timedout_job()'s
> documentation.
>
> Co-developed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> I shamelessly stole- ahm, borrowed this documentation patch that
> Christian had submitted a year ago:
>
> https://lore.kernel.org/dri-devel/20231116141547.206695-1-christian.koeni=
g@amd.com/
>
> I took feedback from last year into account where applicable, but it's
> probably a good idea if you all take a close look again.
>
> P.
> ---
>  Documentation/gpu/drm-mm.rst           |  36 +++++
>  drivers/gpu/drm/scheduler/sched_main.c | 200 ++++++++++++++++++++++---
>  include/drm/gpu_scheduler.h            |  16 +-
>  3 files changed, 225 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
> index d55751cad67c..95ee95fd987a 100644
> --- a/Documentation/gpu/drm-mm.rst
> +++ b/Documentation/gpu/drm-mm.rst
> @@ -556,12 +556,48 @@ Overview
>  .. kernel-doc:: drivers/gpu/drm/scheduler/sched_main.c
>     :doc: Overview
>
> +Job Object
> +----------
> +
> +.. kernel-doc:: drivers/gpu/drm/scheduler/sched_main.c
> +   :doc: Job Object
> +
> +Entity Object
> +-------------
> +
> +.. kernel-doc:: drivers/gpu/drm/scheduler/sched_main.c
> +   :doc: Entity Object
> +
> +Hardware Fence Object
> +---------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/scheduler/sched_main.c
> +   :doc: Hardware Fence Object
> +
> +Scheduler Fence Object
> +----------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/scheduler/sched_main.c
> +   :doc: Scheduler Fence Object
> +
> +Scheduler and Run Queue Objects
> +-------------------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/scheduler/sched_main.c
> +   :doc: Scheduler and Run Queue Objects
> +
>  Flow Control
>  ------------
>
>  .. kernel-doc:: drivers/gpu/drm/scheduler/sched_main.c
>     :doc: Flow Control
>
> +Error and Timeout handling
> +--------------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/scheduler/sched_main.c
> +   :doc: Error and Timeout handling
> +
>  Scheduler Function References
>  -----------------------------
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index e97c6c60bc96..76eb46281985 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -24,28 +24,155 @@
>  /**
>   * DOC: Overview
>   *
> - * The GPU scheduler provides entities which allow userspace to push job=
s
> - * into software queues which are then scheduled on a hardware run queue=
.
> - * The software queues have a priority among them. The scheduler selects=
 the entities
> - * from the run queue using a FIFO. The scheduler provides dependency ha=
ndling
> - * features among jobs. The driver is supposed to provide callback funct=
ions for
> - * backend operations to the scheduler like submitting a job to hardware=
 run queue,
> - * returning the dependencies of a job etc.
> + * The GPU scheduler is shared infrastructure intended to help drivers m=
anaging
> + * command submission to their hardware.
>   *
> - * The organisation of the scheduler is the following:
> + * To do so, it offers a set of scheduling facilities that interact with=
 the
> + * driver through callbacks which the latter can register.
>   *
> - * 1. Each hw run queue has one scheduler
> - * 2. Each scheduler has multiple run queues with different priorities
> - *    (e.g., HIGH_HW,HIGH_SW, KERNEL, NORMAL)
> - * 3. Each scheduler run queue has a queue of entities to schedule
> - * 4. Entities themselves maintain a queue of jobs that will be schedule=
d on
> - *    the hardware.
> + * In particular, the scheduler takes care of:
> + *   - Ordering command submissions
> + *   - Signalling DMA fences, e.g., for finished commands
> + *   - Taking dependencies between command submissions into account
> + *   - Handling timeouts for command submissions

For the signalling case, you say "e.g.". Does that mean it also
signals DMA fences in other cases?

> - * The jobs in a entity are always scheduled in the order that they were=
 pushed.
> + * All callbacks the driver needs to implement are restricted by DMA-fen=
ce
> + * signaling rules to guarantee deadlock free forward progress. This esp=
ecially
> + * means that for normal operation no memory can be allocated in a callb=
ack.
> + * All memory which is needed for pushing the job to the hardware must b=
e
> + * allocated before arming a job. It also means that no locks can be tak=
en
> + * under which memory might be allocated as well.
>   *
> - * Note that once a job was taken from the entities queue and pushed to =
the
> - * hardware, i.e. the pending queue, the entity must not be referenced a=
nymore
> - * through the jobs entity pointer.
> + * Memory which is optional to allocate, for example for device core dum=
ping or
> + * debugging, *must* be allocated with GFP_NOWAIT and appropriate error
> + * handling if that allocation fails. GFP_ATOMIC should only be used if
> + * absolutely necessary since dipping into the special atomic reserves i=
s
> + * usually not justified for a GPU driver.
> + *
> + * Note especially the following about the scheduler's historic backgrou=
nd that
> + * lead to sort of a double role it plays today:
> + *
> + * In classic setups N entities share one scheduler, and the scheduler d=
ecides
> + * which job to pick from which entity and move it to the hardware ring =
next
> + * (that is: "scheduling").
> + *
> + * Many (especially newer) GPUs, however, can have an almost arbitrary n=
umber
> + * of hardware rings and it's a firmware scheduler which actually decide=
s which
> + * job will run next. In such setups, the GPU scheduler is still used (e=
.g., in
> + * Nouveau) but does not "schedule" jobs in the classical sense anymore.=
 It
> + * merely serves to queue and dequeue jobs and resolve dependencies. In =
such a
> + * scenario, it is recommended to have one scheduler per entity.
> + */
> +
> +/**
> + * DOC: Job Object
> + *
> + * The base job object (drm_sched_job) contains submission dependencies =
in the
> + * form of DMA-fence objects. Drivers can also implement an optional
> + * prepare_job callback which returns additional dependencies as DMA-fen=
ce
> + * objects. It's important to note that this callback can't allocate mem=
ory or
> + * grab locks under which memory is allocated.
> + *
> + * Drivers should use this as base class for an object which contains th=
e
> + * necessary state to push the command submission to the hardware.
> + *
> + * The lifetime of the job object needs to last at least from submitting=
 it to
> + * the scheduler (through drm_sched_job_arm()) until the scheduler has i=
nvoked
> + * drm_sched_backend_ops.free_job() and, thereby, has indicated that it =
does
> + * not need the job anymore. Drivers can of course keep their job object=
 alive
> + * for longer than that, but that's outside of the scope of the schedule=
r
> + * component.
> + *
> + * Job initialization is split into two stages:
> + *   1. drm_sched_job_init() which serves for basic preparation of a job=
.
> + *      Drivers don't have to be mindful of this function's consequences=
 and
> + *      its effects can be reverted through drm_sched_job_cleanup().
> + *   2. drm_sched_job_arm() which irrevokably arms a job for execution. =
This
> + *      activates the job's fence, i.e., it registers the callbacks. Thu=
s,
> + *      inevitably, the callbacks will access the job and its memory at =
some
> + *      point in the future. This means that once drm_sched_job_arm() ha=
s been
> + *      called, the job structure has to be valid until the scheduler in=
voked
> + *      drm_sched_backend_ops.free_job().

This is written as-if there could be multiple callbacks in a single
job. Is that the case?

Also typo: "invoked" -> "invokes".

> + * It's important to note that after arming a job drivers must follow th=
e
> + * DMA-fence rules and can't easily allocate memory or takes locks under=
 which
> + * memory is allocated.

comma? "job, drivers"
typo: "or takes" -> "or take"

> +
> +/**
> + * DOC: Entity Object
> + *
> + * The entity object (drm_sched_entity) which is a container for jobs wh=
ich
> + * should execute sequentially. Drivers should create an entity for each
> + * individual context they maintain for command submissions which can ru=
n in
> + * parallel.

This is a bit awkward, how about: "The entity object is a container
for jobs that should execute sequentially."

> + * The lifetime of the entity *should not* exceed the lifetime of the
> + * userspace process it was created for and drivers should call the
> + * drm_sched_entity_flush() function from their file_operations.flush()
> + * callback. It is possible that an entity object is not alive anymore
> + * while jobs previously fetched from it are still running on the hardwa=
re.

To be clear ... this is about not letting processes run code after
dying, and not because something you're using gets freed after
flush(), correct?

> + * This is done because all results of a command submission should becom=
e
> + * visible externally even after a process exits. This is normal POSIX
> + * behavior for I/O operations.
> + *
> + * The problem with this approach is that GPU submissions contain execut=
able
> + * shaders enabling processes to evade their termination by offloading w=
ork to
> + * the GPU. So when a process is terminated with a SIGKILL the entity ob=
ject
> + * makes sure that jobs are freed without running them while still maint=
aining
> + * correct sequential order for signaling fences.
> + */
> +
> +/**
> + * DOC: Hardware Fence Object
> + *
> + * The hardware fence object is a DMA-fence provided by the driver as re=
sult of
> + * running jobs. Drivers need to make sure that the normal DMA-fence sem=
antics
> + * are followed for this object. It's important to note that the memory =
for
> + * this object can *not* be allocated in drm_sched_backend_ops.run_job()=
 since
> + * that would violate the requirements for the DMA-fence implementation.=
 The
> + * scheduler maintains a timeout handler which triggers if this fence do=
esn't
> + * signal within a configurable amount of time.
> + *
> + * The lifetime of this object follows DMA-fence refcounting rules. The
> + * scheduler takes ownership of the reference returned by the driver and
> + * drops it when it's not needed any more.
> + */
> +
> +/**
> + * DOC: Scheduler Fence Object
> + *
> + * The scheduler fence object (drm_sched_fence) which encapsulates the w=
hole
> + * time from pushing the job into the scheduler until the hardware has f=
inished
> + * processing it. This is internally managed by the scheduler, but drive=
rs can
> + * grab additional reference to it after arming a job. The implementatio=
n
> + * provides DMA-fence interfaces for signaling both scheduling of a comm=
and
> + * submission as well as finishing of processing.

typo: "an additional reference" or "additional references"

> + * The lifetime of this object also follows normal DMA-fence refcounting=
 rules.
> + * The finished fence is the one normally exposed to the outside world, =
but the
> + * driver can grab references to both the scheduled as well as the finis=
hed
> + * fence when needed for pipelining optimizations.

When you refer to the "scheduled fence" and the "finished fence",
these are referring to "a fence indicating when the job was scheduled
/ finished", rather than "a fence which was scheduled for execution
and has now become finished", correct? I think the wording could be a
bit clearer here.

Alice

