Return-Path: <linux-kernel+bounces-522731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D90AA3CDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD29E7A8B25
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502ED262D27;
	Wed, 19 Feb 2025 23:55:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC12726217F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009310; cv=none; b=hADRqCYCri6Z5vNweYGKjYv0MftXDdFYuReYBUdm5iVyCx+Bcxg8QBRijPL9dZbLUJHKBFFtNmDLEoWxH6lqOpHSwIhAYGAt72YEjzqLZBN+ElSwVsSdwDaMK0gdmWgTHNiL/KzKDcEQsrfKGvfLxIvw0aMdtV80TpsszsZaD1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009310; c=relaxed/simple;
	bh=4yLJDUFTiT7bQqR1wQ8gA11Mf6WLKsZceGzFHbTGGxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWpjp3NiB/899KAQBgfyhM+5jw3e/tHQCLdjk9PoEasCf2jWJBNKnQ/AQN202cI0OzsHuexP14r1Y0cfB/SzNlgrL2dubKOd0AQM2l0jDm+DpcXhzCnw3va+zIFwtgi5929/sdpO/PfEE9COlEXfv896T7ubUySeCIdHW2FPrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3781C4CED1;
	Wed, 19 Feb 2025 23:55:06 +0000 (UTC)
Date: Wed, 19 Feb 2025 18:55:31 -0500
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
Message-ID: <20250219185531.1140c3c4@gandalf.local.home>
In-Reply-To: <20250220075639.298616eb494248d390417977@kernel.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
	<db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
	<20250220075639.298616eb494248d390417977@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 07:56:39 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > >> this field, we don't need to take lock, though taking the wait_lock may
> > >> still be needed to examine other information inside the mutex.  
> 
> Do we need to take it just for accessing owner, which is in an atomic?

Updating the task_struct would be in the same location as the blocked_on is
anyway. I would make it into a wrapper function that is a nop when disabled.

> 
> > > But perhaps if we add a new config option for this feature, we could just
> > > add the lock that a task is blocked on before it goes to sleep and
> > > reference that instead. That would be easier than trying to play games
> > > getting the lock owner from the blocked_on field.  
> > 
> > Yes, it could be a new config option. This will be a useful feature that 
> > I believe most distros will turn it on. Or we may just include that in 
> > the core code without any option.  
> 
> Do we need another option? or just extend DETECT_HUNG_TASK?

DETECT_HUNG_TASK is just that, for detecting hung tasks. This adds more
information to that, which increases the size of the task_struct not to
mention adds code in the mutex/rwsem handlers.

I would definitely make it a separate config that may depend on
DETECT_HUNG_TASK.

-- Steve

