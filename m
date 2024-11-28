Return-Path: <linux-kernel+bounces-424608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D912F9DB6E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A92161968
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE3619ABAC;
	Thu, 28 Nov 2024 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oSiNpo8G"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B6199FBF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794451; cv=none; b=MF45O7MNfu8K7XecmSELOYeG0hXt67ObNkKM/yX2YYEN+AAZGFHf9gWbUPxbj3O0ImzHdIeb6diaJnAqjbD8drAJ+FQzoLcxMZ7fvHb9pSodrQdnMVn6JwCaRddDU3DnohzkIM3XjdKsLbT08sSn+RpKyffNVxJ5Us5eUb0+Pk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794451; c=relaxed/simple;
	bh=kYZXpqSp5aEsEFi+rwsrxSSHWyOJLakHmZWsAJgoY/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcCygiB8Ut3uzSVEY01rojYxlpe0r7LCFPqSBBlyfsdVpTC9JGmkbJFFjUwmLvHUCXu+8mqOFJz27UDUfDVV6c3qe7W16Y4pW3SQ4pnIZy8bYP2u1rw8/sGGnY/N2q468nCql1Rh5eEGhk6Ubx8jAfHiCFYkGnglJlZ4WoLq+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oSiNpo8G; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IY3B/9shg3NyxBudWelrG6muIppzCwz8DTfsv1fv4VA=; b=oSiNpo8GfpBG80nVazO8Y5clFA
	rAaL8TaDlQoKUsmq32ashFEQz9BTiTJCOwWrFRgfHd1k9AAlWlwy1xexA3tzn4mevF9tx+3sTgzJv
	bWIR0UCOcMd/HpILWESvCJsMX9mt+qlObho9+Xzjde6fzgZUjnWxx9BfZz65/+iqFVtqL5SjehCv4
	WahBxFTaLdMvBS0XIqVh+aFVRjNenBur87t8MYBP2BgQiLalnFgeF19T6aZFXKNlJIXmPfYCNGPZA
	pWwSdxSgXqBActfOOp/I7oOiTWKYN5JWVtUcUNAPe6RwiGDUXDMUZEpX+TwNoBIke1vYIc40k9jll
	uziJepeQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGczS-00000001b5M-3dUQ;
	Thu, 28 Nov 2024 11:47:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 65756300271; Thu, 28 Nov 2024 12:47:22 +0100 (CET)
Date: Thu, 28 Nov 2024 12:47:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH] sched/core: Do not migrate ineligible tasks in
 sched_balance_rq()
Message-ID: <20241128114722.GG24400@noisy.programming.kicks-ass.net>
References: <20241128084858.25220-1-jiahao.kernel@gmail.com>
 <20241128091929.GA35539@noisy.programming.kicks-ass.net>
 <0d28126d-4324-ba19-fe12-4f7a0ec0192f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d28126d-4324-ba19-fe12-4f7a0ec0192f@gmail.com>

On Thu, Nov 28, 2024 at 07:30:37PM +0800, Hao Jia wrote:
> 
> 
> On 2024/11/28 17:19, Peter Zijlstra wrote:
> > On Thu, Nov 28, 2024 at 04:48:58PM +0800, Hao Jia wrote:
> > > From: Hao Jia <jiahao1@lixiang.com>
> > > 
> > > When the PLACE_LAG scheduling feature is enabled, if a task
> > > is ineligible (lag < 0) on the source cpu runqueue, it will
> > > also be ineligible when it is migrated to the destination
> > > cpu runqueue.
> > > 
> > > Because we will keep the original equivalent lag of
> > > the task in place_entity(). So if the task was ineligible
> > > before, it will still be ineligible after migration.
> > 
> > This is not accurate, it will be eleigible, irrespective of lag, if
> > there are no other tasks. I think your patch tries to do this, but I'm
> > fairly sure it got it wrong.
> 
> Thank you for your reply. The expression in my commit message is inaccurate,
> and I will correct it in the patch v2. If I understand correctly, a task
> meeting the following conditions:
> 
>  sched_feat(PLACE_LAG) && cfs_rq->nr_running && !entity_eligible(cfs_rq,
> &p->se),
> 
> will remain ineligible both before and after migration.
> 
> If I am wrong, please correct me. Thank you!

Problem is you're checking the wrong nr_running. 

> > > @@ -9358,13 +9358,14 @@ static inline int migrate_degrades_locality(struct task_struct *p,
> > >   static
> > >   int can_migrate_task(struct task_struct *p, struct lb_env *env)
> > >   {
> > > +	struct cfs_rq *cfs_rq = task_cfs_rq(p);

This is task's current cfs_rq. What you're interested in is destination
cfs_rq. If the destination is empty, then lag is irrelevant.

You want something like:

#if CONFIG_FAIR_GROUP_SCHED
	struct task_group *tg = task_group(p);
	struct cfs_rq *dst_cfs_rq = tg->cfs_rq[env->dst_cpu];
#else
	struct cfs_rq = &env->dst_rq->cfs_rq;
#endif


Also, please add benchmark details that show this actually makes a
difference.

Notably we keep rq->cfs_tasks in MRU order; most recently ran task is
head and balancing takes from the tail, the task longest not ran.

The task longest not ran should have build up eligibility.

