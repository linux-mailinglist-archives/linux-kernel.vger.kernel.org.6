Return-Path: <linux-kernel+bounces-522396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD73A3C9A1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B0F1898474
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2B022F392;
	Wed, 19 Feb 2025 20:24:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362022A818
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996653; cv=none; b=uHfpov73sY7S4yRA6+Kt+9cKJNWgawl2hBMW3NLZBMc3iLvSLFjx6Y7A8c57WmlUQyoVYv5QF3tBhT4sePvE50vipU9nNd/4oHgdsVvbhyWnw/yh2J1oKtY3eknH5OrW50C152YcQ55EypycJrUPhmVuOa62Bo5Q6cb4v6AJrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996653; c=relaxed/simple;
	bh=4uMCSalXchKNFtR3UhNn/rjNPvnV6qnhUVvAAMNs8I4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUs3Lo57ipCNoGJKiRysEHGYi3RJ+8iCXEfmp1fJEZqde/STsM9bZUtpl+6aRZC9N1+JtfqAKagIwNWbVNVzkqKdrbCmCJrsuZIOa88L9N1rDLKgC32eXp0+mUq7HyfMsydDRJk/jcFpblvdC7VOTu39m1GQo4xbImtIiapQuac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA9FC4CED1;
	Wed, 19 Feb 2025 20:24:11 +0000 (UTC)
Date: Wed, 19 Feb 2025 15:24:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <llong@redhat.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Peter Zijlstra
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
Message-ID: <20250219152435.35077ac3@gandalf.local.home>
In-Reply-To: <0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 15:18:57 -0500
Waiman Long <llong@redhat.com> wrote:

> It is tricky to access the mutex_waiter structure which is allocated 
> from stack. So another way to work around this issue is to add a new 
> blocked_on_mutex field in task_struct to directly point to relevant 
> mutex. Yes, that increase the size of task_struct by 8 bytes, but it is 
> a pretty large structure anyway. Using READ_ONCE/WRITE_ONCE() to access 

And it's been on my TODO list for some time to try to make that structure
smaller again :-/

> this field, we don't need to take lock, though taking the wait_lock may 
> still be needed to examine other information inside the mutex.

But perhaps if we add a new config option for this feature, we could just
add the lock that a task is blocked on before it goes to sleep and
reference that instead. That would be easier than trying to play games
getting the lock owner from the blocked_on field.

-- Steve

