Return-Path: <linux-kernel+bounces-526478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDB5A3FF30
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C14705A38
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFECF2512FE;
	Fri, 21 Feb 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m5DvZg8x"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A452512C9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164396; cv=none; b=JzR7W+HjFz+6uLqsN+S+RCZ8fJmXxrBY6bzCpOhyryu2d9KhbqEGtrV1Os1AUWBNRklDsAN6C7nW7Jr6H7235m+XrQgOVew1qAFguh7KdlSLxEtWuf/+C8agKNmmOCrpXNFeyP6e982hGf7RcX4iXqN52zWVQ9I9H8lyeEABwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164396; c=relaxed/simple;
	bh=HdrInORfDmvKP4Z2e+V7+C8mmuSwoC7hUP9PJW7ohmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzwxTQ1TWjEsDbM8o2J23NiKCiW2u11EMRcdo7vj3q8zBbL7X7UHwLbLHIxMYHPDiONmyhkarCTdFtE+UuqHgGiZl+3KaK5mdr95uAq6QzNYEEGQ6yRV3LuboGLJDfJi8Za5nByKYbh0QWntR+qa4Iq6C9qYMXyyqS9S539FHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m5DvZg8x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z1MtoYDG1zcQwaOLnh7F9sOQTf3i3zTBeRHI377w+Nk=; b=m5DvZg8xcpMMYYqaKfMc5hFa9w
	6bngqh1bBMiOhEKRn61hWBcqPHr75Z5UI90YTGDq8k3ttH0L5PMRnoMwluQ1IzhLfuosP2UPxUaWN
	8SOb4+zkoYwJtX329C9pvePK+E7uuYi4rsdQ4BsHBf9Xt/boTZXgJVGltt8S5bTzlWRGX1PTyoRs/
	7T+Xj7zP0a67eDSUYaPtTEs9fSHdb4I6CpJubd3M+zGFH2wH8cZ5jVSyeyzEIDbcgP8/mbdwRMh2A
	Vrn+8Bfc9R8bUFjwP6jfhMhO8jolwwu8LGHiN3l1fTudFkiQdDceRZumsVFtpEHcQeJuXXwEOOq/P
	cR3DQ2rg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tlYFP-0000000EmSy-3hA0;
	Fri, 21 Feb 2025 18:59:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2FA0B30066A; Fri, 21 Feb 2025 19:59:39 +0100 (CET)
Date: Fri, 21 Feb 2025 19:59:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Joel Granados <joel.granados@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Lance Yang <ioworker0@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Yongliang Gao <leonylgao@tencent.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <20250221185939.GB7373@noisy.programming.kicks-ass.net>
References: <174014819072.967666.10146255401631551816.stgit@mhiramat.tok.corp.google.com>
 <174014820133.967666.5855819828684207404.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174014820133.967666.5855819828684207404.stgit@mhiramat.tok.corp.google.com>

On Fri, Feb 21, 2025 at 11:30:01PM +0900, Masami Hiramatsu (Google) wrote:
> +static void debug_show_blocker(struct task_struct *task)
> +{
> +	struct task_struct *g, *t;
> +	unsigned long owner;
> +	struct mutex *lock;
> +
> +	lock = READ_ONCE(task->blocker_mutex);
> +	if (!lock)
> +		return;
> +
> +	owner = mutex_get_owner(lock);
> +	if (likely(owner)) {
> +		/* Ensure the owner information is correct. */
> +		for_each_process_thread(g, t)
> +			if ((unsigned long)t == owner) {
> +				pr_err("INFO: task %s:%d is blocked on a mutex owned by task %s:%d.\n",
> +					task->comm, task->pid, t->comm, t->pid);
> +				sched_show_task(t);
> +				return;
> +			}

 - that for_each_process_thread() scope needs { }

 - that for_each_process_thread() loop needs RCU or tasklist_lock

 - there is no saying that the owner you read with mutex_get_owner() is
   still the owner by the time you do the compare, there can have been
   owner changes.

> +	}
> +	pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
> +		task->comm, task->pid);
> +}

