Return-Path: <linux-kernel+bounces-533916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4E9A4603F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796A116774F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C2F13EFE3;
	Wed, 26 Feb 2025 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISuXGoRK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E12CAB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575299; cv=none; b=FT5Dt2RWLb77rHJGtD7GlyMC8kXXHDKb7vO2Rxms0EFRt3+8mxkIUNfStSpcvjO5mQiCMJseixkD1Zk2TXLt1lm5G/3qBG7HPfySAdLtKMU7l5HcHdNSY6iJRhweH7ZRIzdUHh8wasrSEXpR58OjwD/PpPmxXaT8o8gT2AC1oIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575299; c=relaxed/simple;
	bh=+lDNZSh5/g0UuIvW6+MzzvY4pblefx4oiEA2yz76nNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJCPmaPZVw/ReAJK1yM8FnGHjnKDxZj7wbQE0nxAnkIAfrWq1bGbTH1sukHpFV9AI/fVbd8hnAgUprBNMnkAU2BzLUrGJG3M8ar7kh4Ed7W8nv2UVlg2Qi7kSHjZzpNK6J18yAaXmVI50o1lwt+jvEUb09qneW9KfP03Fb50Ll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISuXGoRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FD3C4CED6;
	Wed, 26 Feb 2025 13:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740575298;
	bh=+lDNZSh5/g0UuIvW6+MzzvY4pblefx4oiEA2yz76nNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISuXGoRKBmgvVQMdaL1vNTHWgzOAPE9zeoXhw9y1sGGlr9F5NAWhqb0fAhk92UVep
	 6Y3PVMgTeXz8hTdAiYsdpiPwhS+7hAiE0RrhNYx8eQ8xtRgT4myMsl3yVnwM5X/SbW
	 ct/5PI9MCvQyDHzLvxv1wq5PLXp8wTsOXQKnHuQcDaWY6eyKfj0M2t6rZvmKiy8/XF
	 lWNjsLOJ8kZj89dfw8XgRXiwwHKFIrj/MrsSEDYuRZbxohYv5LkIQN0cQYEMxcz9qJ
	 1LrWaKh8uR+W61hogphP3Fyt2wOW1KLNR4/vxw3sEQXCIQFW23A35X/ij985BLalHu
	 KeqIP2nlPfeqg==
Date: Wed, 26 Feb 2025 14:08:15 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] task_work: Consume only item at a time while invoking
 the callbacks.
Message-ID: <Z78SPz7VaVZpDOYg@localhost.localdomain>
References: <20250221170530.L3yMvO0i@linutronix.de>
 <20250226125048.GC8995@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226125048.GC8995@redhat.com>

Le Wed, Feb 26, 2025 at 01:50:48PM +0100, Oleg Nesterov a écrit :
> On 02/21, Sebastian Andrzej Siewior wrote:
> >
> > Yi and syzbot managed to hang the task within task_run().
> >
> > The problem is
> >  task_work_run() -> __fput() -> perf_release() ->
> >  perf_event_release_kernel() -> _free_event() ->
> >  perf_pending_task_sync() -> task_work_cancel() failed ->
> >  rcuwait_wait_event().
> >
> > Once task_work_run() is running, the list of callbacks removed from the
> > task_struct and from this point on task_work_cancel() can't remove any
> > pending and not yet started work items.
> 
> But can this patch really solve the problem?
> 
> Suppose we have two tasks, T1 and T2.
> 
> T1 does fd = perf_event_open(pid => T2->pid);
> T2 does fd = perf_event_open(pid => T1->pid);
> 
> Now, both T1 and T2 do close(fd), call task_work_run(), dequeue the
> ____fput work, and finally call __fput(). Now suppose that both perf
> events fire before T1/T2 call perf_event_release_kernel/_free_event.
> 
> Now, T1 and T2 will hang forever in perf_pending_task_sync() waiting
> for each other. task_work_cancel(current) can't succeed with or without
> this patch.
> 
> No?

Duh!

So indeed, the wait/wake based solution is too fragile. Are we back to the
old serialized workqueue days flavour of deadlocks with task work?

Anyway the perf_pending_task()'s put_event() based solution thing should fix
that scenario too.

Thanks.

