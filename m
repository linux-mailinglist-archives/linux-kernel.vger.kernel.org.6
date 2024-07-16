Return-Path: <linux-kernel+bounces-253531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DD593228B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BC91C20C61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCA0195809;
	Tue, 16 Jul 2024 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zu5fXsWT"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161945FEE6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121364; cv=none; b=HKze4sLcsLgtLgo5nSt20bSNmAkDDPIgrVdLGeapxZWdAhWlJyupfV8y/+e6MkkALqQOuWedeh4R1rOnTZH5zafhu4UdVKsS8+qa4EbExbHzd7JuusGuRh8u174LY3IFXQCUjaHiKLVKMZNyrRmM3HBMlKI0pfz3CzpgcrWFxXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121364; c=relaxed/simple;
	bh=e8iFjNfvrxEkXjmJP+YjMNkZDn01MYh3JHV6ibrJ9dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7ytVWg7GVccvRPK+gJpibCPz6NLJjf2LnrAe7FkKbb5aZeBbxboIZQLHlx/in5q25WIwXj/bNv/Ubk9zM7OsZDLkqfCk1k8zP+h3uH43gAsImM5of5wkmnR3b0HhUtepy6yu6hAAeCbivhQoLeVkdjUXxhSkSzIjt6TVPoJMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zu5fXsWT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GEwpaoehCI0j6nRH/0cjgWVJhYybY2M+BVtOwm2SbPw=; b=Zu5fXsWTVvA4WQvQ6xnp4nSBT0
	HEtpYMejsOtMHctzONU8bWSSO9JFAIc6hy0J3eGzSgeCzX2yCry2HqIkmkgqSks5AYvLJ4KRqAMOh
	3E064cFtWvkdWn7INFTX++jVtnNAEvDeRpt3e0cf4tLh6jM86mNRerWZs+5NCX0ga8G+FUaIuGfIM
	l0r7HNEbUDvetcDp4HpNBHAW1EAFy2lB0TgiVlMJqO0Oj+hsfAHwwM7c502HQMphNhB4g4Gz+1LQy
	h/BSAI+E6IOQ3D9hAMTkx+58/RoN+8kHlT/qRndTRRitXMaqDBvGOwjAG/8rqFUBe0+vNOVZpN7qY
	7ViPqWRg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTeHn-000000020ly-1kzD;
	Tue, 16 Jul 2024 09:15:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0EDDA3003FF; Tue, 16 Jul 2024 11:15:51 +0200 (CEST)
Date: Tue, 16 Jul 2024 11:15:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Initialize the vruntime of a new task when it
 is first enqueued
Message-ID: <20240716091550.GA26750@noisy.programming.kicks-ass.net>
References: <20240627133359.1370598-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627133359.1370598-1-zhangqiao22@huawei.com>

On Thu, Jun 27, 2024 at 09:33:59PM +0800, Zhang Qiao wrote:
> When creating a new task, we initialize vruntime of the newly task at
> sched_cgroup_fork(). However, the timing of executing this action is too
> early and may not be accurate.
> 
> Because it uses current CPU to init the vruntime, but the new task
> actually runs on the cpu which be assigned at wake_up_new_task().
> 
> To optimize this case, we pass ENQUEUE_INITIAL flag to activate_task()
> in wake_up_new_task(), in this way, when place_entity is called in
> enqueue_entity(), the vruntime of the new task will be initialized.
> 
> In addition, place_entity() in task_fork_fair() was introduced for two
> reasons:
> 1. Previously, the __enqueue_entity() was in task_new_fair(),
> in order to provide vruntime for enqueueing the newly task, the
> vruntime assignment equation "se->vruntime = cfs_rq->min_vruntime" was
> introduced by commit e9acbff6484d ("sched: introduce se->vruntime").
> This is the initial state of place_entity().
> 
> 2. commit 4d78e7b656aa ("sched: new task placement for vruntime") added
> child_runs_first task placement feature which based on vruntime, this
> also requires the new task's vruntime value.
> 
> After removing the child_runs_first and enqueue_entity() from
> task_fork_fair(), this place_entity() no longer makes sense, so remove
> it also.
> 
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

Thanks, I'll queue this for sched/urgent once -rc1 rolls around.

