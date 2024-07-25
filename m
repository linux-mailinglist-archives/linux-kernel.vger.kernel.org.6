Return-Path: <linux-kernel+bounces-262437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C4793C718
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21060283225
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FF019DF6D;
	Thu, 25 Jul 2024 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfXaCLbo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078F19922A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924652; cv=none; b=E7f35h2VivhKDWnXMtlXGX/q80xzb/ivjrMAZEnoK+Pd/XAv9oKw6rbroLWmE6fMyXj7HUslSMoQnCk6nvXeoEvcnUMZKtU3ZdniWOHt8n5/Oqhsic8tqsV3EQKXxyeu5HSFT/ILs27ArYFsgG2byijomdgRAthHWtJ2AoQY/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924652; c=relaxed/simple;
	bh=EguKKLiIW1WUB4BliD8FxyHvUqTzUIfGbWJnuXzLGqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmLtdaQ4uMSeD/ueUymgVVJsFkbwLtTeHKHDmKqtOtcxd5S+6zR66t55jldzY1DDRP5pD3to3/g7iVX3RBSl8OK6y58x/3ksmWuScL7A+4tUDgoNq8hv5Mh7Xi6HVEZrAOWezACJZveUUzF+b6trfiZqext4g3+noe1nRuJtSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfXaCLbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7787CC32782;
	Thu, 25 Jul 2024 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721924652;
	bh=EguKKLiIW1WUB4BliD8FxyHvUqTzUIfGbWJnuXzLGqk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MfXaCLbohhjz5Z2MVC9a6Ian7a35JHsuZpnv7xwYkRxb0Gsv5AuCv/DOcFjkzcshb
	 IM1mmkR9jB9RcQapkKbodfGofrY9+BBbqcFP5e6nWcgATU13Ub4joxIzy8Yovc3u7o
	 Nq2pyB+5VJGa9+tC7uz2ATx/5ReTBPb5vjfFN/RL0l93ULOARko/jKGoX89ZoQDiIe
	 b7Ji7w/Nbx0TWSPYrQbQYAFL1/QdSoy+JORvWrA6MvVIihNHvW81A7N+5+YR1yFaCx
	 xB42qvsDPO666FQtudGZyHhceq2G37tmzXTDTd27pUdPXSI5WgaOO07lO7xQjg+6lL
	 as2lxLqmbH27Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 13F7BCE0ECD; Thu, 25 Jul 2024 09:24:12 -0700 (PDT)
Date: Thu, 25 Jul 2024 09:24:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, brauner@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, clm@fb.com,
	riel@surriel.com, ffledgling@meta.com
Subject: Re: [PATCH RFC exit] Sleep at TASK_IDLE when waiting for application
 core dump
Message-ID: <21406a91-8801-453a-9833-a4e24c7e90ca@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1936bd18-775b-43e3-bfd5-2cd343565f06@paulmck-laptop>
 <20240725132849.GA6602@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725132849.GA6602@redhat.com>

On Thu, Jul 25, 2024 at 03:29:35PM +0200, Oleg Nesterov wrote:
> On 07/24, Paul E. McKenney wrote:
> >
> > Currently, the coredump_task_exit() function sets the task state to
> > TASK_UNINTERRUPTIBLE|TASK_FREEZABLE, which usually works well.  But a
> > combination of large memory and slow (and/or highly contended) mass
> > storage can cause application core dumps to take more than two minutes,
> > which can triggers "task blocked" splats.
> 
> Do you mean check_hung_uninterruptible_tasks() ?

Yes, from its call to check_hung_task().  Good point, I will add that
to the commit log.

> In any case,
> 
> > Therefore, change that TASK_UNINTERRUPTIBLE to TASK_IDLE.
> ...
> > @@ -429,7 +429,7 @@ static void coredump_task_exit(struct task_struct *tsk)
> >  			complete(&core_state->startup);
> >
> >  		for (;;) {
> > -			set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
> > +			set_current_state(TASK_IDLE|TASK_FREEZABLE);
> 
> To me this change makes sense regardless...
> 
> To some degree TASK_UNINTERRUPTIBLE is misleading, in that the task which
> sleeps in coredump_task_exit() is _KILLABLE, although not "directly".
> 
> A SIGKILL sent to the coredumping process will interrupt the coredumping thread
> (see the signal->core_state check in prepare_signal() and fatal_signal_pending()
> check in dump_interrupted()) and then this thread will wakeup the threads sleeping
> in coredump_task_exit(), see coredump_finish().

Very good, I will add this to the commit log with attribution.

> Acked-by: Oleg Nesterov <oleg@redhat.com>

Thank you for the thorough review!  How does the updated patch shown
below look to you?

							Thanx, Paul

------------------------------------------------------------------------

commit a6c7779283d67a409b81616a5b485ac21637d7e7
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jul 24 16:51:52 2024 -0700

    exit: Sleep at TASK_IDLE when waiting for application core dump
    
    Currently, the coredump_task_exit() function sets the task state
    to TASK_UNINTERRUPTIBLE|TASK_FREEZABLE, which usually works well.
    But a combination of large memory and slow (and/or highly contended)
    mass storage can cause application core dumps to take more than
    two minutes, which can cause check_hung_task(), which is invoked by
    check_hung_uninterruptible_tasks(), to produce task-blocked splats.
    There does not seem to be any reasonable benefit to getting these splats.
    
    Furthermore, as Oleg Nesterov points out, TASK_UNINTERRUPTIBLE could
    be misleading because the task sleeping in coredump_task_exit() really
    is killable, albeit indirectly.  See the check of signal->core_state
    in prepare_signal() and the check of fatal_signal_pending()
    in dump_interrupted(), which bypass the normal unkillability of
    TASK_UNINTERRUPTIBLE, resulting in coredump_finish() invoking
    wake_up_process() on any threads sleeping in coredump_task_exit().
    
    Therefore, change that TASK_UNINTERRUPTIBLE to TASK_IDLE.
    
    Reported-by: Anhad Jai Singh <ffledgling@meta.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Acked-by: Oleg Nesterov <oleg@redhat.com>
    Cc: Jens Axboe <axboe@kernel.dk>
    Cc: Christian Brauner <brauner@kernel.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
    Cc: Chris Mason <clm@fb.com>
    Cc: Rik van Riel <riel@surriel.com>

diff --git a/kernel/exit.c b/kernel/exit.c
index f95a2c1338a8..b0d18f7b6d15 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -429,7 +429,7 @@ static void coredump_task_exit(struct task_struct *tsk)
 			complete(&core_state->startup);
 
 		for (;;) {
-			set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
+			set_current_state(TASK_IDLE|TASK_FREEZABLE);
 			if (!self.task) /* see coredump_finish() */
 				break;
 			schedule();

