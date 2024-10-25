Return-Path: <linux-kernel+bounces-381154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7599AFB33
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603D4B22AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58971BA86C;
	Fri, 25 Oct 2024 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K/BcFUrm"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290F1AB6FA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841824; cv=none; b=OGmazMPhXhFR31LCB+MtJ+/hgz5+Jlwb+qUaTjgwiG5QxogWkbI273agB4VaW36RW/Y4lMoFNc5YFhffer//GdCZ+/3Wwm7vxHH9wc85VjSdcrTwYOj5xXGxWYXZy3gz1GdG+oVhntf4TUe+GHnS0BTxpuYX5pNB26IVZAYWJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841824; c=relaxed/simple;
	bh=oXMViWVR2zGOSXYA8cQ11Y0uDBbuJnAnoDaOxTqrzrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/SQwIvz4+laSwQTJ2omCxDlW3cci0bf+GUxX657y/TkpDOq3vfczKNXVOeCsDqkviGmPYuIWDjRqTl5NDufRruK2bWGzdOBi9kuyNeT0kXzS3DU9SUNbM9IfWt1mqTpKQyWzFHfO5rUPUhdqRkuy/KDwxg09sIF5QTYNwujgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K/BcFUrm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3sx0bKB8PN/8GwjhFYU/cKg1j2jh6udnobFhzjxuKZA=; b=K/BcFUrmDQx1VIOOFn12h5PHlW
	ylygGT9JGEJUUD1dl9Jfq5Dls/qwu5e+O46msQ4r3FkRBu+I6msgP0fUn5pXy3bLiGKMDQtKyrUpX
	yX0x0Y2J0+CRLBk4fUwfFR8Q8HahJjfGRasqnYviN/ec3tIedjj805pT9aVsJvhaPcDOToHGb4LHM
	peSTUrdWhnF4PMjvAGYpFI+D1LLe3UQ1xlrA6O5ZbgNHWB7TUemcbnfVr5A7rKQiBcWsMhnNbpyDq
	RPC5e0dFx/x1tjwXTahVkQ+fzNLGUl1Xj7ghpaSZgaNxqxw6ZH/85lvYPd1vO89K4zvXNMoxRfMN3
	aYLbssBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4EsK-00000004yAz-2FqZ;
	Fri, 25 Oct 2024 07:36:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4FABA30083E; Fri, 25 Oct 2024 09:36:48 +0200 (CEST)
Date: Fri, 25 Oct 2024 09:36:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shawn Wang <shawnwang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH] sched/numa: Fix the potential null pointer dereference
 in task_numa_work()
Message-ID: <20241025073648.GA14555@noisy.programming.kicks-ass.net>
References: <20241025022208.125527-1-shawnwang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025022208.125527-1-shawnwang@linux.alibaba.com>

On Fri, Oct 25, 2024 at 10:22:08AM +0800, Shawn Wang wrote:
> When running stress-ng-vm-segv test, we found a null pointer dereference
> error in task_numa_work(). Here is the backtrace:
> 
>   [323676.066985] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
>   ......
>   [323676.067108] CPU: 35 PID: 2694524 Comm: stress-ng-vm-se
>   ......
>   [323676.067113] pstate: 23401009 (nzCv daif +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
>   [323676.067115] pc : vma_migratable+0x1c/0xd0
>   [323676.067122] lr : task_numa_work+0x1ec/0x4e0
>   [323676.067127] sp : ffff8000ada73d20
>   [323676.067128] x29: ffff8000ada73d20 x28: 0000000000000000 x27: 000000003e89f010
>   [323676.067130] x26: 0000000000080000 x25: ffff800081b5c0d8 x24: ffff800081b27000
>   [323676.067133] x23: 0000000000010000 x22: 0000000104d18cc0 x21: ffff0009f7158000
>   [323676.067135] x20: 0000000000000000 x19: 0000000000000000 x18: ffff8000ada73db8
>   [323676.067138] x17: 0001400000000000 x16: ffff800080df40b0 x15: 0000000000000035
>   [323676.067140] x14: ffff8000ada73cc8 x13: 1fffe0017cc72001 x12: ffff8000ada73cc8
>   [323676.067142] x11: ffff80008001160c x10: ffff000be639000c x9 : ffff8000800f4ba4
>   [323676.067145] x8 : ffff000810375000 x7 : ffff8000ada73974 x6 : 0000000000000001
>   [323676.067147] x5 : 0068000b33e26707 x4 : 0000000000000001 x3 : ffff0009f7158000
>   [323676.067149] x2 : 0000000000000041 x1 : 0000000000004400 x0 : 0000000000000000
>   [323676.067152] Call trace:
>   [323676.067153]  vma_migratable+0x1c/0xd0
>   [323676.067155]  task_numa_work+0x1ec/0x4e0
>   [323676.067157]  task_work_run+0x78/0xd8
>   [323676.067161]  do_notify_resume+0x1ec/0x290
>   [323676.067163]  el0_svc+0x150/0x160
>   [323676.067167]  el0t_64_sync_handler+0xf8/0x128
>   [323676.067170]  el0t_64_sync+0x17c/0x180
>   [323676.067173] Code: d2888001 910003fd f9000bf3 aa0003f3 (f9401000)
>   [323676.067177] SMP: stopping secondary CPUs
>   [323676.070184] Starting crashdump kernel...
> 
> stress-ng-vm-segv in stress-ng is used to stress test the SIGSEGV error
> handling function of the system, which tries to cause a SIGSEGV error on
> return from unmapping the whole address space of the child process.
> 
> Normally this program will not cause kernel crashes. But before the
> munmap system call returns to user mode, a potential task_numa_work()
> for numa balancing could be added and executed. In this scenario, since the
> child process has no vma after munmap, the vma_next() in task_numa_work()
> will return a null pointer even if the vma iterator restarts from 0.
> 
> Recheck the vma pointer before dereferencing it in task_numa_work().
> 
> Fixes: 214dbc428137 ("sched: convert to vma iterator")
> Cc: stable@vger.kernel.org # v6.2+

Thanks

