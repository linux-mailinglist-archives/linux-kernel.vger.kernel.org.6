Return-Path: <linux-kernel+bounces-315898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BAF96C850
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1DC1F25D69
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FB11482ED;
	Wed,  4 Sep 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgUhdTt1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3D1EBFEC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481440; cv=none; b=MUh12zPmqU1hZWF15RCYV+4V6vzwofGeC7U4XRXEhnMLTVRHKK/UHkOxC3fUSAjHTLqf3AwFftBxpJr8spE4/mkqKXkmms/r6WA9e2rL7pO14dowaQ/24zuMzzatnwsz0LNeJECMDNBVv/HJEh/+kf78UKOUQKck3lck8bp8L4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481440; c=relaxed/simple;
	bh=Lx6Vzm6pepB4F/I5A/aaK0S2IkVSMvteVv3i8IjO3UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4TGMeANxJWFMOCyau3hjz7wc7NcmMvLWsGioxQjFfkycDBSqJGuCZpFZeIzkHnWSoOg0BkIh0rpnMxxSTi+FRASiAX1EdIxJESFFNAsKt0CR9LBjlI+bLczaxAigD6sWABzoajg2KtIQ2c1uRT88VLGJohLIOSdXH2ptqKYVyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgUhdTt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B42CC4CEC2;
	Wed,  4 Sep 2024 20:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725481440;
	bh=Lx6Vzm6pepB4F/I5A/aaK0S2IkVSMvteVv3i8IjO3UI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgUhdTt19BGQ6FzsyIvkEh9yhXru1AaUa2o9b5p6QREDYbZ/F+JbD8WctLYhkUpM6
	 ezWto42MhB6tA6mPPUSJLwE5FRkNEaTrEslknMV+Ai0Fyd9dTIlQVDhyXWDGI+4EFG
	 nKbmsoAFkUG5Qgq7Ec3yYcSlrdASVZaDPEZOrGTFtaGG9KvK2n+oP60FFsvl88l2TE
	 BpEPD88ospktNREGSs6gG7Duyjqgx6W/aVpLnrVXym2Q1VPOswzvxOpITVJq4QGhFK
	 GwtBApWBe/m5URGrzxzON58mJlTSUPXeHCt2W890nFALm/fy8+7COZOYJig0BQKhkP
	 L2Gu80Ht59g+g==
Date: Wed, 4 Sep 2024 10:23:59 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: TASK_DEAD tasks must be
 switched into SCX on ops_enable
Message-ID: <ZtjB35bd6YKZriNU@slm.duckdns.org>
References: <ZtLOGi4bf4YeRCFr@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtLOGi4bf4YeRCFr@slm.duckdns.org>

On Fri, Aug 30, 2024 at 10:02:34PM -1000, Tejun Heo wrote:
> During scx_ops_enable(), SCX needs to invoke the sleepable ops.init_task()
> on every task. To do this, it does get_task_struct() on each iterated task,
> drop the lock and then call ops.init_task().
> 
> However, a TASK_DEAD task may already have lost all its usage count and be
> waiting for RCU grace period to be freed. If get_task_struct() is called on
> such task, use-after-free can happen. To avoid such situations,
> scx_ops_enable() skips initialization of TASK_DEAD tasks, which seems safe
> as they are never going to be scheduled again.
> 
> Unfortunately, a racing sched_setscheduler(2) can grab the task before the
> task is unhashed and then continue to e.g. move the task from RT to SCX
> after TASK_DEAD is set and ops_enable skipped the task. As the task hasn't
> gone through scx_ops_init_task(), scx_ops_enable_task() called from
> switching_to_scx() triggers the following warning:
> 
>   sched_ext: Invalid task state transition 0 -> 3 for stress-ng-race-[2872]
>   WARNING: CPU: 6 PID: 2367 at kernel/sched/ext.c:3327 scx_ops_enable_task+0x18f/0x1f0
>   ...
>   RIP: 0010:scx_ops_enable_task+0x18f/0x1f0
>   ...
>    switching_to_scx+0x13/0xa0
>    __sched_setscheduler+0x84e/0xa50
>    do_sched_setscheduler+0x104/0x1c0
>    __x64_sys_sched_setscheduler+0x18/0x30
>    do_syscall_64+0x7b/0x140
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> As in the ops_disable path, it just doesn't seem like a good idea to leave
> any task in an inconsistent state, even when the task is dead. The root
> cause is ops_enable not being able to tell reliably whether a task is truly
> dead (no one else is looking at it and it's about to be freed) and was
> testing TASK_DEAD instead. Fix it by testing the task's usage count
> directly.
> 
> - ops_init no longer ignores TASK_DEAD tasks. As now all users iterate all
>   tasks, @include_dead is removed from scx_task_iter_next_locked() along
>   with dead task filtering.
> 
> - tryget_task_struct() is added. Tasks are skipped iff tryget_task_struct()
>   fails.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Peter Zijlstra <peterz@infradead.org>

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

