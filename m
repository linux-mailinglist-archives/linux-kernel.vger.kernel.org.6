Return-Path: <linux-kernel+bounces-522858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87718A3CF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC681895B81
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F1614A629;
	Thu, 20 Feb 2025 02:22:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA61EEB1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018161; cv=none; b=kmbscxNyLB6lEtEFzASzRuRjc/NDuI53MtG8wEdnxFYj0V8t2v6+xozI/jo7DFhrr9kx3Dy8bESyfpd1oM26oxallHUJz1Vx0rJTUtHIkS/JjOeA9F8y5i1tUD5gCAJ5zxMakwjN2yihayTN6x8qI4vdsLGY91k/pH39aywriB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018161; c=relaxed/simple;
	bh=Si1mu4YyFEJR6YYE0Vfun5+KmBhUaDe9rCzk+Fksos0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bw8AyG+OJJP0I2KYVrMq6WBMBni29LROxqdpMxdIjLpxlpolk0Kvfn8lc9ck8cAsHyG41OG9bEp5BbVOv05K5Q/UB4iLY2uCSkvGK5iUlackAJLDzzpWmbAlOe39NCCIjLxOeg3yHQPP8zN2k3J+6DOfXCdmKjiuT5to2U6oTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D92C4CED1;
	Thu, 20 Feb 2025 02:22:38 +0000 (UTC)
Date: Wed, 19 Feb 2025 21:23:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Waiman Long <llong@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, Joel
 Granados <joel.granados@kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, Linux
 Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <20250219212303.6a49c011@gandalf.local.home>
In-Reply-To: <20250220110707.a314d394ccf68575047e75cb@kernel.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
	<db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
	<20250220075639.298616eb494248d390417977@kernel.org>
	<20250219185531.1140c3c4@gandalf.local.home>
	<20250220110707.a314d394ccf68575047e75cb@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 11:07:07 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 19 Feb 2025 18:55:31 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 20 Feb 2025 07:56:39 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >   
> > > > >> this field, we don't need to take lock, though taking the wait_lock may
> > > > >> still be needed to examine other information inside the mutex.    
> > > 
> > > Do we need to take it just for accessing owner, which is in an atomic?  
> > 
> > Updating the task_struct would be in the same location as the blocked_on is
> > anyway. I would make it into a wrapper function that is a nop when disabled.  
> 
> Should we make it depends on DEBUG_MUTEXES too? I think no. We can introduce
> a different kconfig and wrapper function which calls debug_mutex_*().

No it should only depend on HUNG_TASKS.

> 
> >   
> > >   
> > > > > But perhaps if we add a new config option for this feature, we could just
> > > > > add the lock that a task is blocked on before it goes to sleep and
> > > > > reference that instead. That would be easier than trying to play games
> > > > > getting the lock owner from the blocked_on field.    
> > > > 
> > > > Yes, it could be a new config option. This will be a useful feature that 
> > > > I believe most distros will turn it on. Or we may just include that in 
> > > > the core code without any option.    
> > > 
> > > Do we need another option? or just extend DETECT_HUNG_TASK?  
> > 
> > DETECT_HUNG_TASK is just that, for detecting hung tasks. This adds more
> > information to that, which increases the size of the task_struct not to
> > mention adds code in the mutex/rwsem handlers.
> > 
> > I would definitely make it a separate config that may depend on
> > DETECT_HUNG_TASK.  
> 
> OK, what about CONFIG_TASK_BLOCKER?

I'm fine with whatever color you would like the bikeshed to be ;-)

-- Steve

