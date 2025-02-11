Return-Path: <linux-kernel+bounces-510089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70D0A317F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263131644F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE331268FEF;
	Tue, 11 Feb 2025 21:39:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B597268FFF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309990; cv=none; b=iXIV9oZSj6Bb9QzSfPK8kJgoUp25GogT6vajgvSi3OPWRAr0sTiZcyF/JVvYwpY/7UmxnCauBWf73zAYRdPPvoqrtQA/QSCwSTTAxPVCyR9yB49fzlCX0SjkYOsMZyxE1c8eu60LCtJ2DbBxB0YTnLaQkSi3420vqzprFNg2kLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309990; c=relaxed/simple;
	bh=3/uJj1qtUmL9FRSmIW/mbJUroml0MChtZS52Kr+yt8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdL3EU52LO9ItUyeNBfCYrPgHdr9UoognY3443InJPcofyFNrj0TwKvl8tujCUWjY6y+EX5RK+X5DRh46EHFGwAG7xyKhRdinLYzd3nkIZDsG/8qLJqnXrW4BXMZBktczm3IlqDQn03hRM6THBxw0obkwR8GPYNK7lN/fn8FJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5725FC4CEDD;
	Tue, 11 Feb 2025 21:39:48 +0000 (UTC)
Date: Tue, 11 Feb 2025 16:39:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Jon Kohler <jon@nutanix.com>, Gauri
 Patwardhan <gauri.patwardhan@nutanix.com>, Rahul Chunduru
 <rahul.chunduru@nutanix.com>, Will Ton <william.ton@nutanix.com>
Subject: Re: [PATCH] sched/rt: Fix race in push_rt_task
Message-ID: <20250211163952.7e3a82a1@gandalf.local.home>
In-Reply-To: <10861916-F001-4AF7-B512-9FFD0D883941@nutanix.com>
References: <20250211054646.23987-1-harshit@nutanix.com>
	<20250211101137.5824285d@gandalf.local.home>
	<10861916-F001-4AF7-B512-9FFD0D883941@nutanix.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Feb 2025 21:08:22 +0000
Harshit Agarwal <harshit@nutanix.com> wrote:

> Thanks Steve for taking a look. Yes we should ideally remove any conditio=
ns that are=20
> subsumed by task !=3D pick_next_pushable_task condition, however I am not=
 sure if anyone (say ttwu())
> will try to modify p=E2=80=99s state without removing it from the pushabl=
e tasks list first. In such a case
> pick_next_pushable_task will still pick p again and then it will match an=
d will proceed to do the migration
> while ttwu() is trying to wake it up. Most likely, some asserts like !tas=
k_on_rq_queued etc will be hit in
> pick_next_pushable_task as soon as p is picked. If we can be sure that p=
=E2=80=99s state is modified by others
> only after it being removed from pushable tasks list of this CPU then it =
should be safe to remove it
> else not.=20

Note that all tasks on the pick_next_pushable list is in the running state.
Nothing should be trying to wake it up while its on that list. That is, if
p is still on the pushable tasks then everything should be still fine.
Especially now that the rq locks are still held again.

I think that is the only check we need. The is_migration_disabled() check
should probably be checked earlier, as the only way it could be set is if
the current task preempted it. If it had migrated, and migrated back, it
couldn't have that set on this current CPU otherwise it would not have
migrated.

Here's the current checks again:

	if (unlikely(task_rq(task) !=3D rq ||
		     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
		     task_on_cpu(rq, task) ||
		     !rt_task(task) ||
		     is_migration_disabled(task) ||
		     !task_on_rq_queued(task))) {


Let's look at pick_next_pushable_task():

	p =3D plist_first_entry(&rq->rt.pushable_tasks,
			      struct task_struct, pushable_tasks);

	BUG_ON(rq->cpu !=3D task_cpu(p));
	BUG_ON(task_current(rq, p));
	BUG_ON(task_current_donor(rq, p));
	BUG_ON(p->nr_cpus_allowed <=3D 1);

	BUG_ON(!task_on_rq_queued(p));
	BUG_ON(!rt_task(p));

If task_rq(task) !=3D rq is true, then BUG_ON(rq->cpu !=3D task_cpu(p)) wou=
ld trigger.

  !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask

We still need that check, to make sure the CPU we picked is in the task's a=
ffinity.

If task_on_cpu(rq, task) is true, then BUG_ON(task_current(rq, p)) would tr=
igger.

If !rt_task(task) is true then BUG_ON(!rt_task(p)) would trigger.

   is_migration_disabled(task)

Is still needed, but could possibly be moved up? (unrelated change though)

If !task_on_rq_queued(task) is true then BUG_ON(!task_on_rq_queued(p)) woul=
d trigger.

Thus, I think we can change that condition to just:

	if (is_migration_disabled(task) ||
	    !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
	    task !=3D pick_next_pushable_task(rq)) {

I moved the is_migration_disabled() up as that's the quickest check. If
that's true, no need to test the other conditions.

-- Steve

