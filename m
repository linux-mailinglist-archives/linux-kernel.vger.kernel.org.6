Return-Path: <linux-kernel+bounces-522666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A32BA3CD10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FAFB189A59F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F325A334;
	Wed, 19 Feb 2025 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcCM8VYD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB2D2144C8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006555; cv=none; b=CT7BAZ/M9QxaxK0sHTIWbcw5Zj08Zxk5Gx/aBetaCJU7WNgWyoZmwWVcJwhxeOLjKg8v1ON+f2k6pB/+4Zt04x2wm33/6FFBVRePDPMsYFCeIyTWkxSFPQjp6iX4qsYAiyGLchAs/i7IgrkoJOX5d5qf6WmLbqqxbYf7w/Qh1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006555; c=relaxed/simple;
	bh=BHPfA7scL6aD43lk+kfJBreSZvIUi3wef4nJQKhdl0c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rle5FjCZq1JRzUEJAC0/2HRps2gRHN1rP/xpAVl35HyojDdTLe2jVOSh4hey6k+Bm6gCHmwhupkbTYFNpN3vzhZL+I0L0tg1osH+4xqXgpO+n8sARcqdejd1pfQanQrA+I22XYtzNPwDgofG3c8qJVEVwoyhBtxkwbmmZk2odmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcCM8VYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28399C4CED1;
	Wed, 19 Feb 2025 23:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006555;
	bh=BHPfA7scL6aD43lk+kfJBreSZvIUi3wef4nJQKhdl0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XcCM8VYDLETEgpvPPyUIEOzjM8w3ME4xDI7qQLjM1hqv9brigLN2obDgLIM3HYyK6
	 6nR4MJQxd1GvSt6l57Y4y+dgXd3EbIQZHLR6cKaA8Bh1PiAbBgdvGqaB/utblKRq1Z
	 1n4dChu/YZJQGYxagPSGi3+UNUYx09H5f3ALSMVK7WkT4UiWEclLXye5nnMzKh8f/j
	 YXEalfhXjn6tH3lQxemYyj8sAqCsRgr2sOgMDWbIbRTd1gd911kCJWNFSs+oUNhunS
	 zPeAQI2Q7uWFOSoy1XOg5HlJ57vMjkctopiaUn4Nl5KplzZgyM42bLCztfyTvEwbF/
	 a6GElo3wxD8/A==
Date: Thu, 20 Feb 2025 08:09:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Waiman Long <llong@redhat.com>, "Masami Hiramatsu (Google)"
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
Message-Id: <20250220080908.fc1494f0f7c611b48fbe0f8b@kernel.org>
In-Reply-To: <20250219152435.35077ac3@gandalf.local.home>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 15:24:35 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 19 Feb 2025 15:18:57 -0500
> Waiman Long <llong@redhat.com> wrote:
> 
> > It is tricky to access the mutex_waiter structure which is allocated 
> > from stack. So another way to work around this issue is to add a new 
> > blocked_on_mutex field in task_struct to directly point to relevant 
> > mutex. Yes, that increase the size of task_struct by 8 bytes, but it is 
> > a pretty large structure anyway. Using READ_ONCE/WRITE_ONCE() to access 
> 
> And it's been on my TODO list for some time to try to make that structure
> smaller again :-/
> 
> > this field, we don't need to take lock, though taking the wait_lock may 
> > still be needed to examine other information inside the mutex.
> 
> But perhaps if we add a new config option for this feature, we could just
> add the lock that a task is blocked on before it goes to sleep and
> reference that instead. That would be easier than trying to play games
> getting the lock owner from the blocked_on field.

So something like this?

unsigned int	block_flags;
union {
	struct mutex	*mutex;
	struct rwsem	+rwsem;
	struct rtmutex	*rtmutex;
} blocked_on;

enum {
	BLOCKED_ON_MUTEX;
	BLOCKED_ON_RWSEM;
	BLOCKED_ON_RTMUTEX;
	BLOCKED_ON_IO;
} block_reason;

For the safety, we may anyway lock the task anyway, but that is the
same as stacktrace.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

