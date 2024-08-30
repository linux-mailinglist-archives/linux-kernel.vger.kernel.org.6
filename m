Return-Path: <linux-kernel+bounces-309266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFF7966849
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DF11F23EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA721BBBC1;
	Fri, 30 Aug 2024 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW9a06SY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528691BB6B5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039949; cv=none; b=OUmHGgSc78Okt1OOZKsXyv8GTWPhc+GAPBcO8MtZa9w6W7PPlgpP5ENfxquDlvKFY+DnZ3z5+mUp4qqB7VlbqFkkcHML46rcqj01upE6iaQWwKRjtrzBWSbaPVTkq6jcBI4IqNMpWTbT7ZVVznfFS6TY8tECKev8z2DooC8QY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039949; c=relaxed/simple;
	bh=yhnHcmbJeaX46zMTZ0NbPUznr849r1SdbkkQLrOQD/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ/jKmyQJI5VXb4l8JTP+SIcjRCrsOnv8o5q4m9RkKoiWLzj5HLmyrh7ESwPeUWiEatDBpLv9KSb6UBu44CxKyFVSmZgGbCaq8jGaie9p99XlgRqCSQa7Idz8xmG1DqHxui8IJY1npUXQh2/wBL+NotKuXhPSnwi3O9JavUV+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW9a06SY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BC1C4CEC2;
	Fri, 30 Aug 2024 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725039948;
	bh=yhnHcmbJeaX46zMTZ0NbPUznr849r1SdbkkQLrOQD/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HW9a06SYAfGfmDZFGUHB8AYk8u2VqcGGG8PypaNe/zlrF2vPF6JrmuA6+h97Lxl9+
	 /ad9VBSwk8H4jzXaFRyzZMeu8zJLWizWEH3wOh6u+GesikTg8V5vFEQhWpwuKGo6Me
	 9WigQIW+H6T7LIrbPsZxeQMbd48Omd9yNQQ0WeVTbd0512zsTG+mVEJwVPa+fYA2z7
	 61zegCV3XXEgrMhNXOTc7xy8ophFQBxANBxCRy6wE/vu5vVVgPnlTHou41QAl/gleK
	 /c0rxyYS1vw4/q83OKnS7bffdJQdNHpT58KGgVGfZC3QsQLVfyeJc527+LimI2BqUh
	 RdtzeRfFJ5sGg==
Date: Fri, 30 Aug 2024 07:45:47 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	kernel-team@meta.com
Subject: Re: [PATCH 2/2 sched_ext/for-6.12] sched_ext: Use ktime_get_ns()
 instead of rq_clock_task() in touch_core_sched()
Message-ID: <ZtIFS78LQf9jULTY@slm.duckdns.org>
References: <ZtGkPKgoE5BeI7fN@slm.duckdns.org>
 <ZtGkgCEkgNLzjxUC@slm.duckdns.org>
 <20240830174014.GD5055@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830174014.GD5055@maniforge>

On Fri, Aug 30, 2024 at 12:40:14PM -0500, David Vernet wrote:
> >  	if (!sched_core_disabled())
> > -		p->scx.core_sched_at = rq_clock_task(rq);
> > +		p->scx.core_sched_at = ktime_get_ns();
> 
> Should we just use sched_clock_cpu()? That's what rq->clock is updated
> from, and it's what fair.c does on the balance path when the rq lock is
> unpinned.

That sounds more sensible. Will update.

Thanks.

-- 
tejun

