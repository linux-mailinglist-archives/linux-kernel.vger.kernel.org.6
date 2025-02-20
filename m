Return-Path: <linux-kernel+bounces-523282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D05A3D4B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E704E1891322
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D509D1EE7DF;
	Thu, 20 Feb 2025 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiyPKG8b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA82FC23
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043772; cv=none; b=SiQ7EkBQhJg9wUbWv+RHKJEl6KX3V+/ghzq729bD72SaY9l5f/Bx571Rrool14sr4bTO2MPc7D2E8KFa5JL9LlA4qp6uU7AfXWKFTGlx9NRiDJABsoY4VC/oqGrf2aaBBlUZh0JixGOzNIrGdI1tjc1j8gL5KvafxLOj4QlP4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043772; c=relaxed/simple;
	bh=DpD8mweF0mlsSyJ1C8ZOC6x0nRyu9qCwYiQBLyd5+GA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=orrGxjlcbBLMvzgyljKFI9MfZ3DqYkXFesDN8myyDahFYj3fnOPuRTMIpF44mbUDkhHIhCfh/SBrtm5Y1sP+53xzcHmZps8G+vpxXP6gSmnQG+AGjWdudNsSUOWOScjmNNOzlm/J4i13pLLiVRMs7nLjLd24wf7WZqmeJHokHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiyPKG8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2863C4CED1;
	Thu, 20 Feb 2025 09:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740043770;
	bh=DpD8mweF0mlsSyJ1C8ZOC6x0nRyu9qCwYiQBLyd5+GA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iiyPKG8bAKS7WFCBv8j8T3JdfNZx6qO+c3/S9+HIWUySilPQmtpJgDpPjBLbjsiQw
	 bCuSmuJnZi/Mzm/jjBh5vOoeAW0HNN6JXbMbtKoSrFSO4AjDdO9IhRK8B95RWBi+Qp
	 PDQapsuf3h3eO3S0bB9WTQWgX/tQPvFHdawhE7Ri9cYxfflu29+NtHgCn4TB5WW2hC
	 fQOxYinI3KZu7ZByOd2YrcamxdCMMbWA9Zrr+exT0Sp4/EQKjcut8pJH4u6WkLNiFc
	 VdgNBkjkLeugVeMmhk8Z5aQhRVqHrMJxaZAYpXPzPq5FQE6IuLWF8dFgLhmp9LUuoV
	 HbNAKd7MV6Syw==
Date: Thu, 20 Feb 2025 18:29:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>, Anna
 Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, Linux
 Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-Id: <20250220182927.258e394c6ba5d76d4c57324b@kernel.org>
In-Reply-To: <bb5886cc-a512-4a59-98c7-f21128ab6194@redhat.com>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
	<db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
	<20250220075639.298616eb494248d390417977@kernel.org>
	<d8c01f69-34c0-45cf-a532-83544a3a3efd@redhat.com>
	<20250219204153.65ed1f5e@gandalf.local.home>
	<9f9150b4-1cf5-4380-b431-419f70775a7d@redhat.com>
	<20250220115904.051e0cc55a9cb88302582ef4@kernel.org>
	<bb5886cc-a512-4a59-98c7-f21128ab6194@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 19 Feb 2025 22:37:04 -0500
Waiman Long <llong@redhat.com> wrote:

> On 2/19/25 9:59 PM, Masami Hiramatsu (Google) wrote:
> > On Wed, 19 Feb 2025 21:15:08 -0500
> > Waiman Long <llong@redhat.com> wrote:
> >
> >> On 2/19/25 8:41 PM, Steven Rostedt wrote:
> >>> On Wed, 19 Feb 2025 20:36:13 -0500
> >>> Waiman Long <llong@redhat.com> wrote:
> >>>
> >>>    
> >>>>>>>> this field, we don't need to take lock, though taking the wait_lock may
> >>>>>>>> still be needed to examine other information inside the mutex.
> >>>>> Do we need to take it just for accessing owner, which is in an atomic?
> >>>> Right. I forgot it is an atomic_long_t. In that case, no lock should be
> >>>> needed.
> >>> Now if we have a two fields to read:
> >>>
> >>> 	block_flags (for the type of lock) and blocked_on (for the lock)
> >>>
> >>> We need a way to synchronize the two. What happens if we read the type, and
> >>> the task wakes up and and then blocks on a different type of lock?
> >>>
> >>> Then the lock read from blocked_on could be a different type of lock than
> >>> what is expected.
> >> That is different from reading the owner. In this case, we need to use
> >> smp_rmb()/wmb() to sequence the read and write operations unless it is
> >> guaranteed that they are in the same cacheline. One possible way is as
> >> follows:
> >>
> >> Writer - setting them:
> >>
> >>       WRITE_ONCE(lock)
> >>       smp_wmb()
> >>       WRITE_ONCE(type)
> >>
> >> Clearing them:
> >>
> >>       WRITE_ONCE(type, 0)
> >>       smp_wmb()
> >>       WRITE_ONCE(lock, NULL)
> >>
> >> Reader:
> >>
> >>       READ_ONCE(type)
> >> again:
> >>       smp_rmb()
> >>       READ_ONCE(lock)
> >>       smp_rmb()
> >>       if (READ_ONCE(type) != type)
> >>           goto again
> > What about mutex-rwsem-mutex case?
> >
> > mutex_lock(&lock1);
> > down_read(&lock2);
> > mutex_lock(&lock3);
> >
> > The worst scenario is;
> >
> > WRITE_ONCE(lock, &lock1)
> > smp_wmb()
> > WRITE_ONCE(type, MUTEX)     READ_ONCE(type) -> MUTEX
> > WRITE_ONCE(type, 0)
> > smp_wmb()
> > WRITE_ONCE(lock, NULL)
> > WRITE_ONCE(lock, &lock2)    READ_ONCE(lock) -> &lock2
> > smp_wmb()
> > WRITE_ONCE(type, RWSEM)
> > WRITE_ONCE(type, 0)
> > smp_wmb()
> > WRITE_ONCE(lock, NULL)
> > WRITE_ONCE(lock, &lock3)
> > smp_wmb()
> > WRITE_ONCE(type, MUTEX)     READ_ONCE(type) -> MUTEX == MUTEX
> > WRITE_ONCE(type, 0)
> > smp_wmb()
> > WRITE_ONCE(lock, NULL)
> >
> >                              "OK, lock2 is a MUTEX!"
> >
> > So unless stopping the blocker task, we can not ensure this works.
> > But unless decode the lock, we don't know the blocker task.
> 
> That could only happen if the reader can get interrupted/preempted for a 
> long time. In that case, we may need to reread the lock again to be sure 
> that they are stable.

Hm, actually read side should run under rcu read locked, so only interrupt
matters. So I think this rarely happens.

BTW, we don't need the lock address itself, but we need to know who is the
owner. Maybe we can point the address of atomic_long_t?

struct task_struct {
	atomic_long_t *blocked_on_owner;
};

The problem is that mutex and rwsem are OK, but rt_mutex uses task_struct *.
Maybe we can use atomic_long_t in rt_mutex too if the new Kconfig is enabled.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

