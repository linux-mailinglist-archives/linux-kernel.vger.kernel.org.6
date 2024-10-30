Return-Path: <linux-kernel+bounces-389568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 450B59B6E86
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9621F21A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9FD21764B;
	Wed, 30 Oct 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQkpD9fb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B7217476
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322755; cv=none; b=k3gqlsDpYcv7/ZGN57Vhxd7/pIYen29pfQmTYoA9wlwWitZ+XbP0sKifZhll1bnxq9oYyWTkumuwAw518I3I0CdnSFfnDShiLvUyg9aJxR1luF/sxvWk32RptJh1XyXwVg0j1IQ4C5EDEvsdxhM49GxvPy6oHV3HYHnJxYlhLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322755; c=relaxed/simple;
	bh=RmZvWVlHf+bNVdydB8Quowek0+yIsOuT3TvXX03ZJXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNWlNjbSiX3SoAURPZqrHb91d11dT/PV2lu8ElchEjFVaUAxjghOWlg+MrkS1NrBTuoZj7d0aiewSywddRG/SElXYGIFwXnBklXVvQU5DDLsFBvutr5UeLYsNa5hnuxtGZaV2dG6Ha6NbfHL2EZhGMptkbMWi2u6axpgNw0rZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQkpD9fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608FEC4CED6;
	Wed, 30 Oct 2024 21:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730322753;
	bh=RmZvWVlHf+bNVdydB8Quowek0+yIsOuT3TvXX03ZJXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQkpD9fbfkfx0TkQ57Y1ivQ8oDC4SPLeOwBFd7xUbthZPymDOMa5YZbFXCPsarI0c
	 /o04mOznteuSjw/BaoJWm1VZkfZi75WMdF+KQ1+P4z2p2hYDw7LwV+cWM0AvO4SLGq
	 UYa99u6f1Q42oDWnj4dnpT98mmWGFWD/USf6UUS6KvIgo6wjWVqtfIm9jOMOGFIqxi
	 Dnv1735UsdQl0RBBGIKOaIHACz0n/fRJ3ojygsGrX6k17KIq6x9k/eIK9tog+mTvhF
	 BomCiYE2lS2+RmN/BzjlQQJyeOYoJT+HZj/WHBX9pd1k3W9+mhGnIXYKazC7799GGV
	 vZXNKYZEH1pVA==
Date: Wed, 30 Oct 2024 11:12:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, void@manifault.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/6] sched: Fold
 sched_class::switch{ing,ed}_{to,from}() into the change pattern
Message-ID: <ZyKhQFuMItKsmsnh@slm.duckdns.org>
References: <20241030151255.300069509@infradead.org>
 <20241030152142.711768679@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030152142.711768679@infradead.org>

On Wed, Oct 30, 2024 at 04:12:59PM +0100, Peter Zijlstra wrote:
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5199,20 +5204,24 @@ static int scx_ops_enable(struct sched_e
>  	percpu_down_write(&scx_fork_rwsem);
>  	scx_task_iter_start(&sti);
>  	while ((p = scx_task_iter_next_locked(&sti))) {
> +		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
>  		const struct sched_class *old_class = p->sched_class;
>  		const struct sched_class *new_class =
>  			__setscheduler_class(p->policy, p->prio);
>  
> +		if (old_class != new_class)
> +			queue_flags |= DEQUEUE_CLASS;
> +
>  		if (old_class != new_class && p->se.sched_delayed)
>  			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
>  
>  		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
                                               ^
					       queue_flags
					       
>  			p->scx.slice = SCX_SLICE_DFL;
>  			p->sched_class = new_class;
> -			check_class_changing(task_rq(p), p, old_class);
>  		}
>  
> -		check_class_changed(task_rq(p), p, old_class, p->prio);
> +		if (!(queue_flags & DEQUEUE_CLASS))
> +			check_prio_changed(task_rq(p), p, p->prio);

Maybe prio_changed can be moved into scoped_guard?

Thanks.

-- 
tejun

