Return-Path: <linux-kernel+bounces-522647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848D2A3CCD2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401553ABCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7F325C6E9;
	Wed, 19 Feb 2025 22:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbJIMMzA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6625B673
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005805; cv=none; b=XumKC7gikQO5wIa5bJZeCKPNMQeLX4yBEZJCuKKab7HzqZSZBLMGtCMTK/69o1b2QnaoCZY6p/SAeC5QkZwk4458FzsT1sB7aK8SlP7VbNaUkfmF6R9GWTvD+JxczC1jNNwz+23xtLUvc/NciZOOhtcWm/5HhW4alXb4uX9sXLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005805; c=relaxed/simple;
	bh=9+dCkrzDahzj3n/nd8JKW8rfXG8Sz4C12rCQ3S9pCFM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NjUbjY45NJ6OwwJ28trvl6fMPkCej661cx5Cctw4yMZoRmEKIDQ/6GwJ/tqihupOl6/kNb+K0W+Agly7xNJWh5MmWY7Tbd/UzBMPYW9fuyAzUkbbtF/xcXzy0EpkIkpIKjGO8A8joPcxYuRGy6hiAncvNowH0GPUIjyTNj4J4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbJIMMzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E6FC4CED1;
	Wed, 19 Feb 2025 22:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740005805;
	bh=9+dCkrzDahzj3n/nd8JKW8rfXG8Sz4C12rCQ3S9pCFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CbJIMMzAGd+v10VrUFoSmfCEYyYyCdkJ4wMnu+jURmNerNPdsYr8lLEGTQB8zzp4X
	 Cpo+7fZLEngEOC1TdB1JnL5Lnnt5xB7rSEu6C+I9amEpHLeXx1FHnNwi7qgZXJx1Gt
	 KLR9tn1q7bmM2iZvms0ZuBKCjmlozGyYmuGcH5kOmO0uumJd1yVnDvQzkSf6OLybpl
	 pw0biRmwkrpWsROWybWbdqILsVkJ2MNSkDhSHHIRf+zCeI5xqJ04YGDOI0tTxuPY01
	 AL6UMRff9NiRWBlhk/hLbKsMA3R3I9E1/Vn6vdNd4bAhaIcDe1Ap0W5y8AN8s3RgNi
	 mt88lCNKwFYUA==
Date: Thu, 20 Feb 2025 07:56:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, Joel
 Granados <joel.granados@kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, Linux
 Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-Id: <20250220075639.298616eb494248d390417977@kernel.org>
In-Reply-To: <db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
	<db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 17:44:11 -0500
Waiman Long <llong@redhat.com> wrote:

> 
> On 2/19/25 3:24 PM, Steven Rostedt wrote:
> > On Wed, 19 Feb 2025 15:18:57 -0500
> > Waiman Long <llong@redhat.com> wrote:
> >
> >> It is tricky to access the mutex_waiter structure which is allocated
> >> from stack. So another way to work around this issue is to add a new
> >> blocked_on_mutex field in task_struct to directly point to relevant
> >> mutex. Yes, that increase the size of task_struct by 8 bytes, but it is
> >> a pretty large structure anyway. Using READ_ONCE/WRITE_ONCE() to access
> > And it's been on my TODO list for some time to try to make that structure
> > smaller again :-/

I agree to add the field, actually it was my first prototype :)

> >
> >> this field, we don't need to take lock, though taking the wait_lock may
> >> still be needed to examine other information inside the mutex.

Do we need to take it just for accessing owner, which is in an atomic?

> > But perhaps if we add a new config option for this feature, we could just
> > add the lock that a task is blocked on before it goes to sleep and
> > reference that instead. That would be easier than trying to play games
> > getting the lock owner from the blocked_on field.
> 
> Yes, it could be a new config option. This will be a useful feature that 
> I believe most distros will turn it on. Or we may just include that in 
> the core code without any option.

Do we need another option? or just extend DETECT_HUNG_TASK?

Thanks,

> 
> BTW, this field can also be shared by other sleeping locks like rwsem 
> and rt_mutex as a task can only be blocked on one of them. We do need 
> another type field to identify the type of the blocked lock.
> 
> Cheers,
> Longman
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

