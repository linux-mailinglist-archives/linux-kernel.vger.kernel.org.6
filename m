Return-Path: <linux-kernel+bounces-432651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9F9E4E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29B71881D9B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235711AC8A6;
	Thu,  5 Dec 2024 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8BGY9Y8"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5190157A5C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383450; cv=none; b=o556FRDcwPwoewlHXmqyqWPOW4Qi9JE/POlLP8sF20GLJV03ftctoR08NQfnEd7GRVUKxLdhGjaVJR70kCxlYTYOGyiqQSbeFNEY9vcynM6sLLBk3rZoyZ5ZRsdw32AKjpHaDIOebJ01G8ROSqf4oGMGR3rXeelnh1lbTEtw13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383450; c=relaxed/simple;
	bh=tB44b8j0mXl7p0hPwlwNeCka0HVs6dd/wM6/dZvHB6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7P9cCAwv6oNGchcoTke4/HAAAJnN9dHi3UhhBKxy24m6s01HhIqTikeFZloGuQ3Xy7mhw48kckpkNi+K8NpO9Dvg0U8q0nxa4yR5tf7GNthBJHKSiRyX0J4Zw8rM0dTrQqVUR612uCMDQcU5rFVvTn8JJ5eg7YQP0Ldx8vVAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F8BGY9Y8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd1dcbbc08so61915a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733383448; x=1733988248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bDlWK8bqWx//67eu6sf8fvYFFpAy/xltJWhR//lc7i4=;
        b=F8BGY9Y85lazsBz29+p37FTBXK79SRS9DdoPpLFnk7LRduuv6vX2PI1TjkbzoPFjbc
         qq/c+VYkRBsLUg4catwoOOIRISAYOjKsQuaXJ95t5UzkkiBap+LxKxXXBlZEzN49M2rs
         HcX47vFyHjnnCY/VmvwVzQlQ6I6IvPhoZCHQo7OdszZx2BLRG7Okq/qJ+BAZ3Z/DdRTp
         9kV1hn/NcZa/YlEZooeMHN+3J9kTi4WKpLqh+oNu4wOPSTxhvg9Rgfhkq2cNFFp+jT9M
         wUF3W/149DEaQZ6dP22IabY5YxPRfJ7+wE2w43CK1lxdVXVSwQ62XjO9JTs+A9Uwouvu
         opOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383448; x=1733988248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDlWK8bqWx//67eu6sf8fvYFFpAy/xltJWhR//lc7i4=;
        b=wiGsyqAlnULS19N9LCYGWdQXj4FHGyPIE8EVtU+5dHtf+q6Nn2JBwthgyaMHdmoYuy
         pOpmEye0ZT+LW3g4TGCklsoNs2wks31aWwfwQcA/SVIAROeuUyQEZiIai7+3XmaX5NvF
         cM7Jgs+vSd/47IJoCTTOSduAMxzBYPh7TWp3LfY/wiaXhJP5f+QnC4puVNQ8mdkEa8m9
         z8kU6MNgIvOlke3m0EQTpCuPn9XgZqO8dpgDOiiqe0UMlggUwBcWWiijWcbB3FNn5/rj
         gfb8mKkS3VVF9p9iQq6A2uT0lCsJ64IKAEhs9LmJtS1XvmA6swIpaVUqos48ifo82/HE
         hcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsBpLPi3ZWZPTKkK8O6xFzvJsYbFZyF2EiypZJAH22i/pxHzOQIPT9Gd4WzhMHudyqZ2LspYemN+qpuEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfnTecQZ604tHAM3LcDcJyw9Nk1jn4Lo3nIeOuuuizK7lJqt3
	A29kU4sMnTPj5ORRLFEps2t+dzWBzQRD3OIX1n4Ps1LvYtnidGOsrgFKRI/p9qByfahOn8qdZmh
	/Iy9YvqW4rU/5hwrVjlSULCJO64uVMAa70JGHHQ==
X-Gm-Gg: ASbGncu9pFPw6QQepIEwj7pPkPLkVZ4mFyZpnnDSfWQTiiguP+iBKWSPrc9PQAc4jM9
	DxV85P4tyXSz3UqU79xXBZTuVL0/HiG0oOcPwFAzh5KO23ww3Bf4H5RL6YjHn
X-Google-Smtp-Source: AGHT+IGYYCdYRRBIRznlvE3pC7TW4cmru1YchGqhRKfA7haYcbipHC5yDqEpt95ynCxs9jXGZICuceipoKmd5sh2QZ0=
X-Received: by 2002:a05:6a21:6e4b:b0:1d9:2b51:3ccd with SMTP id
 adf61e73a8af0-1e1653a2aadmr12792549637.7.1733383447852; Wed, 04 Dec 2024
 23:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202174606.4074512-1-vincent.guittot@linaro.org> <d36ed494-0143-4afa-8c14-cac7b5d20245@arm.com>
In-Reply-To: <d36ed494-0143-4afa-8c14-cac7b5d20245@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 5 Dec 2024 08:23:56 +0100
Message-ID: <CAKfTPtD9ZPW3nj9Npf16ynMckKNteiGwn1Xcc_xtQ=vMCpGD7Q@mail.gmail.com>
Subject: Re: [PATCH 0/11 v3] sched/fair: Fix statistics with delayed dequeue
To: Luis Machado <luis.machado@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	kprateek.nayak@amd.com, pauld@redhat.com, efault@gmx.de, tj@kernel.org, 
	void@manifault.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 20:10, Luis Machado <luis.machado@arm.com> wrote:
>
> On 12/2/24 17:45, Vincent Guittot wrote:
> > Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until its
> > lag has elapsed. As a result, it stays also visible in the statistics that
> > are used to balance the system and in particular the field h_nr_running.
> >
> > This serie fixes those metrics by creating a new h_nr_runnable that tracks
> > only tasks that want to run. It renames h_nr_running into h_nr_runnable.
> >
> > h_nr_runnable is used in several places to make decision on load balance:
> >   - PELT runnable_avg
> >   - deciding if a group is overloaded or has spare capacity
> >   - numa stats
> >   - reduced capacity management
> >   - load balance between groups
> >
> > While fixing h_nr_running, some fields have been renamed to follow the
> > same pattern. We now have:
> >   - cfs.h_nr_runnable : running tasks in the hierarchy
> >   - cfs.h_nr_queued : enqueued tasks in the hierarchy either running or
> >       delayed dequeue
> >   - cfs.h_nr_idle : enqueued sched idle tasks in the hierarchy
> >
> > cfs.nr_running has been rename cfs.nr_queued because it includes the
> > delayed dequeued entities
> >
> > The unused cfs.idle_nr_running has been removed
> >
> > Load balance compares the number of running tasks when selecting the
> > busiest group or runqueue and tries to migrate a runnable task and not a
> > sleeping delayed dequeue one. delayed dequeue tasks are considered only
> > when migrating load as they continue to impact it.
> >
> > It should be noticed that this serie doesn't fix the problem of delayed
> > dequeued tasks that can't migrate at wakeup.
> >
> > Some additional cleanups have been added:
> >   - move variable declaration at the beginning of pick_next_entity()
> >     and dequeue_entity()
> >   - sched_can_stop_tick() should use cfs.h_nr_queued instead of
> >     cfs.nr_queued (previously cfs.nr_running) to know how many tasks
> >     are running in the whole hierarchy instead of how many entities at
> >     root level
> >
> > Changes since v2:
> > - Fix h_nr_runnable after removing h_nr_delayed (reported by Mike and Prateek)
> > - Move "sched/fair: Fix sched_can_stop_tick() for fair tasks" at the
> >   beginning of the series so it can be easily backported (asked by Prateek)
> > - Split "sched/fair: Add new cfs_rq.h_nr_runnable" in 2 patches. One
> >   for the creation of h_nr_runnable and one for its use (asked by Peter)
> > - Fix more variable declarations (reported Prateek)
> >
> >
> > Changes since v1:
> > - reorder the patches
> > - rename fields into:
> >   - h_nr_queued for all tasks queued both runnable and delayed dequeue
> >   - h_nr_runnable for all runnable tasks
> >   - h_nr_idle for all tasks with sched_idle policy
> > - Cleanup how h_nr_runnable is updated in enqueue_task_fair() and
> >   dequeue_entities
> >
> > Peter Zijlstra (1):
> >   sched/eevdf: More PELT vs DELAYED_DEQUEUE
> >
> > Vincent Guittot (10):
> >   sched/fair: Fix sched_can_stop_tick() for fair tasks
> >   sched/fair: Rename h_nr_running into h_nr_queued
> >   sched/fair: Add new cfs_rq.h_nr_runnable
> >   sched/fair: Use the new cfs_rq.h_nr_runnable
> >   sched/fair: Removed unsued cfs_rq.h_nr_delayed
> >   sched/fair: Rename cfs_rq.idle_h_nr_running into h_nr_idle
> >   sched/fair: Remove unused cfs_rq.idle_nr_running
> >   sched/fair: Rename cfs_rq.nr_running into nr_queued
> >   sched/fair: Do not try to migrate delayed dequeue task
> >   sched/fair: Fix variable declaration position
> >
> >  kernel/sched/core.c  |   4 +-
> >  kernel/sched/debug.c |  14 ++-
> >  kernel/sched/fair.c  | 240 ++++++++++++++++++++++++-------------------
> >  kernel/sched/pelt.c  |   4 +-
> >  kernel/sched/sched.h |  12 +--
> >  5 files changed, 153 insertions(+), 121 deletions(-)
> >
>
> Sorry, it took me a bit to work the backports for 6.8/Android. I gave this series a try
> on the Pixel 6 with a couple workloads (Speedometer and a UI-based one) and I didn't
> spot any significant performance/frame metric differences or power metric differences compared
> to a 6.8 kernel with this series applied.
>
> Also, checking the statistics for the cores didn't show any numbers that are obviously wrong.
>
> Though the kernel version is a bit behind mainline, I hope that's useful.
>
> Tested-By: Luis Machado <luis.machado@arm.com>

Thanks

