Return-Path: <linux-kernel+bounces-444896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FD69F0E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138D328129F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7BA1E0B62;
	Fri, 13 Dec 2024 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHMWjb49"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB23C1E049F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098381; cv=none; b=SwbGZaFIHMjoTAivojmKH+Sw41VZm6s7a0sIsd6bNZ1Y7on6ZpWVKeMN//HYDQ7FLGVVKdkUl4XYAFWJv09o1i9R/584IlnplaKcU98BDdZxSfH1WmnwG2qYPTyuf1LUVvQvKNSB7ZTqWY4vVmIyevOWLnfqmKr31BwRgpTeo+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098381; c=relaxed/simple;
	bh=Xfjzlw+9SSmPrE+JqUAS8Ske9kX2tIaiBAqz05lk6BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwtASV6GZendbrMzV1hFg1lpK9kYTcmoC3YHQ5Wi1et/359WYQfyhRwRNGcxqdhF+nCCkv61xqGzZxoN8xxOzAeUVot9gwtvVk4kuK+5YbBCi1nMHI9cYAn9kf+61sslQOG3+ekTCp53O1aRmCUXBNTmXwiyoimvIShEuZ4ifQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHMWjb49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75DBC4CED0;
	Fri, 13 Dec 2024 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734098380;
	bh=Xfjzlw+9SSmPrE+JqUAS8Ske9kX2tIaiBAqz05lk6BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gHMWjb492acas73LA1fT9FNIC30Amps109tUCHYUlge2oYSu3NiqKIsfigDhXTTfu
	 niuA/YpeH/2J2PvgeHLhZHRTEgHU4pXKxKYECanW33S5zhJbsDofo/bp/iESyWyQjA
	 Ackeb+82rZHISP6m5HZ7ldqJzm6RvhOpa8FYHm1JFPvhIWzseAn8wzREPpkcATKP05
	 dAU8jQpMLUb1NQ7QxK6Gpg1z2fnZTI/LBIyWuRqb7B34RJNXVplpma8dHZZrkHmbko
	 0cxkBdEbNB/SutlBMjeGNbE8Osu0VCN9rCXVId9Ks0YcX0Zri64ACfzBM9gZ6iA8/M
	 d4JYncZNCVp7A==
Date: Fri, 13 Dec 2024 14:59:37 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 5/7] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
Message-ID: <Z1w9ydTN90Sl8qda@localhost.localdomain>
References: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
 <20241213040658.2282640-6-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241213040658.2282640-6-ankur.a.arora@oracle.com>

Le Thu, Dec 12, 2024 at 08:06:56PM -0800, Ankur Arora a écrit :
> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
> states for read-side critical sections via rcu_all_qs().
> One reason why this was needed: lacking preempt-count, the tick
> handler has no way of knowing whether it is executing in a
> read-side critical section or not.
> 
> With (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), we get (PREEMPT_COUNT=y,
> PREEMPT_RCU=n). In this configuration cond_resched() is a stub and
> does not provide quiescent states via rcu_all_qs().
> (PREEMPT_RCU=y provides this information via rcu_read_unlock() and
> its nesting counter.)
> 
> So, use the availability of preempt_count() to report quiescent states
> in rcu_flavor_sched_clock_irq().
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

