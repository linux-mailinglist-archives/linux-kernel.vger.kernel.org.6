Return-Path: <linux-kernel+bounces-309248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F9966810
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7DABB23A97
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A657B1BAEFC;
	Fri, 30 Aug 2024 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH+B/WT4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD715C153
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039313; cv=none; b=S+YqReiSUbPk1lEqRH4ZapDDfjQm/zUCmuS1fhM0i54TdcK1eNCdo+tAnLeDQtRRnsqw/KmtPD5JorK0/P9chUvyx6LBc/xyAsDhQ7Q3UrWeM9+teBioy2YRnFQhBqn0DsvQF79UT9RT0FuX7ZymUtB/muO4fgNF2zF4+JBAMMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039313; c=relaxed/simple;
	bh=3LSjrFDteUIY8g+9WvWeYoNtWkjmCzo9hWmOT96XawQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRFMR590/zb/x7XVR64P00gjoPxyZNnBfV0kzSjBjXKqhwtClFB1i5TPz6yixHMfhwtbJJUwQEweCmJ6pAH4g6e2jIpWPHcBOY/APJC8J8tvtITndQJHX+gq00bUAQcBSGs8zOFcs+zyY8vUpapFeJqkmDHwSuNTZMCjA21mFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH+B/WT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55579C4CEC2;
	Fri, 30 Aug 2024 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725039312;
	bh=3LSjrFDteUIY8g+9WvWeYoNtWkjmCzo9hWmOT96XawQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EH+B/WT4AbHgOwpXAs1bzAtfSbdPXglZun2yF7nDFp2NH0++iv/aMMAXQkxYPpkQu
	 Uqpb3F4Hi68pQtSK2T+E45slEQDIQ5sQ3B1f5sNZnEL0z6r3Mq7+Z9c1Byu7hR4Apx
	 t1py4a+YCA3eox3KXUeeWrYLFsUW6Rw6mjWzZyo2Nwt9YymQAGGpGSUOSdFOr3Jrjr
	 Umy75N4E/WGn0c7ktgf72C00t6k5mz9bHTlosL/EnWAo/EIrkPWMotG+aYZ496vgI8
	 irExdnKtnLVxEFx/KFuJrl2quyFERkukAXgTKi+bdoNl0KnJDYJXUxk+WUKk1oC1aT
	 +crUdzqqi9xDQ==
Date: Fri, 30 Aug 2024 07:35:11 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	kernel-team@meta.com
Subject: Re: [PATCH 1/2 sched_ext/for-6.12] sched_ext: Use
 task_can_run_on_remote_rq() test in dispatch_to_local_dsq()
Message-ID: <ZtICz0_-Mc4-7JKX@slm.duckdns.org>
References: <ZtGkPKgoE5BeI7fN@slm.duckdns.org>
 <20240830172207.GC5055@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830172207.GC5055@maniforge>

On Fri, Aug 30, 2024 at 12:22:07PM -0500, David Vernet wrote:
> On Fri, Aug 30, 2024 at 12:51:40AM -1000, Tejun Heo wrote:
> > When deciding whether a task can be migrated to a CPU,
> > dispatch_to_local_dsq() was open-coding p->cpus_allowed and scx_rq_online()
> > tests instead of using task_can_run_on_remote_rq(). This had two problems.
> > 
> > - It was missing is_migration_disabled() check and thus could try to migrate
> >   a task which shouldn't leading to assertion and scheduling failures.
> > 
> > - It was testing p->cpus_ptr directly instead of using task_allowed_on_cpu()
> >   and thus failed to consider ISA compatibility.
> > 
> > Update dispatch_to_local_dsq() to use task_can_run_on_remote_rq():
> > 
> > - Move scx_ops_error() triggering into task_can_run_on_remote_rq().
> > 
> > - When migration isn't allowed, fall back to the global DSQ instead of the
> >   source DSQ by returning DTL_INVALID. This is both simpler and an overall
> >   better behavior.
> 
> Should we also be falling back to the global DSQ if we fail the check
> when called from process_ddsp_deferred_locals()?  This patch doesn't
> change anything given that we'd have the same behavior before if we
> failed the cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr) check, but I'm
> not following why we would need to fall back to global DSQ in
> finish_dispatch(), but not in process_ddsp_deferred_locals().

Yes, this actually happens as a part of the scx_bpf_dispatch_from_dsq()
patchset - 0004-sched_ext-Make-dispatch_to_local_dsq-return-void.patch. I'll
update the title / description of that patchset.

Thanks.

-- 
tejun

