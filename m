Return-Path: <linux-kernel+bounces-523278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F99A3D4AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE8F3B974E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712F1EEA56;
	Thu, 20 Feb 2025 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHfDlng0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B71EEA23
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043536; cv=none; b=lxaJFQaIE7SBT5HmfF7mm0ihb/Rr5XnB6q8ceJWYmGQ4GWr0HDawW/DEroJelgNNhiRtqOcQjkVI73fH4M11aix0yol3JwjHJNIRPr47X+MF7A2VJK8qkEKtz4/08LDQG5bPlXijjxvYff2KsLxVgzhrs9jE3yESe0eHIOmT3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043536; c=relaxed/simple;
	bh=YuJNXtZCXILioP9EXJtk+zQDJ5xX29DwjrkwVkabOuk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZrSczUecoKnohXyQoSL6qj33DeLxe3K4jPln/UDbOs5W+TBzyPetDnUyw8ThgHtlnU/74U/nWu3eKY583wpffn6vBk1sIBUBK6UgHFCHS/buI8r1OG/XTwOoZTGxQ/Xjs5vvKAv8FI/iDrqXLGEKo9r/WQ1/GQ0wJeAeaXqeS8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHfDlng0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88813C4CEDD;
	Thu, 20 Feb 2025 09:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740043535;
	bh=YuJNXtZCXILioP9EXJtk+zQDJ5xX29DwjrkwVkabOuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eHfDlng0v8Yg0eXT66mUNrKorrRhMYZnG/RFBqsPgOxSDJmURY8ClwYt0U8VMgLmx
	 /lHxc1hOIAAOClTuCD9Zq9ALAt7BkIfD3q78BKq51Q6CGnd1w9tAchJNOK2AbUzj0B
	 Z+fq1rMydQJo+Hyw1ma9dmQ5GqC88sS9TuR93CjqYqmYnYpk1etAbxNCqb1u9i+Fmw
	 8XyHQjSlLx2BAWXbqwK+LREuxPGMRwpvkxgfOcH4TQACbrTvESbEs9q1tRaCNd3s7e
	 bo/Vf1+a8kxNWPCRNPqyfLjLPSDPRjmitdLgtGwL+yRhgsdA8VGsUeS9kRv+gnYl4g
	 bpouRf+0qr3BQ==
Date: Thu, 20 Feb 2025 18:25:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Waiman Long <llong@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>, Anna
 Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>,
 linux-kernel@vger.kernel.org, Linux Memory Management List
 <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-Id: <20250220182532.fe70e64c79670c70d0af58ec@kernel.org>
In-Reply-To: <20250220-112040-neomutt-senozhatsky@chromium.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
	<20250220080908.fc1494f0f7c611b48fbe0f8b@kernel.org>
	<20250220-112040-neomutt-senozhatsky@chromium.org>
	<524bd2b9-5322-4012-b1d0-b76edb84ec4f@redhat.com>
	<20250220-112040-neomutt-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 13:19:46 +0900
Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> On (25/02/19 22:49), Waiman Long wrote:
> > On 2/19/25 9:45 PM, Sergey Senozhatsky wrote:
> > > On (25/02/20 08:09), Masami Hiramatsu wrote:
> > > > So something like this?
> > > > 
> > > > unsigned int	block_flags;
> > > > union {
> > > > 	struct mutex	*mutex;
> > > > 	struct rwsem	+rwsem;
> > > > 	struct rtmutex	*rtmutex;
> > > > } blocked_on;
> > > > 
> > > > enum {
> > > > 	BLOCKED_ON_MUTEX;
> > > > 	BLOCKED_ON_RWSEM;
> > > > 	BLOCKED_ON_RTMUTEX;
> > > > 	BLOCKED_ON_IO;
> > > > } block_reason;
> > > I totally like this and always wanted to have something simlar,
> > > something for all "sleepable" synchronization primitives, lightweight
> > > enough (memory and CPU usage wise) to run on consumer devices.  I was
> > > thinking of a rhashtable where each entry represents "sleepable"
> > > primitive with a "owner" pointer and a list of "blocked on" tasks.
> > > But I'm sure you'll have a better idea.
> > > 
> > > If I may add a couple of "wishes", can we also add:
> > > - completions (so that things like wait_for_completion and
> > >    synchronize srcu get covered)
> > > - wait on bit (so that things like lock_buffer and so on get covered)
> > 
> > Bit lock doesn't have a owner field to track the owning task.
> 
> Right, so that's why I was thinking about keeping it outside in
> a hashtable.  A list of owners plus a list of blocked_on per "lock",
> be it a rwsem, or a mutex, or a bit.

Hmm, how can we sync the accesses of the hashtable? We may need
spinlocks for the hashtable or use RCU list. If we use the RCU,
we may need to allocate RCU object for each time when a lock
contention happens (and use kfree_rcu() for each object).
Maybe it is better using a spinlock for each hashtable entry but
it still introduce overhead (need to check).

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

