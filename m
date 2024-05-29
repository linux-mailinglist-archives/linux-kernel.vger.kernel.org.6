Return-Path: <linux-kernel+bounces-193733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2173D8D3143
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38C11F22A25
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C3716936E;
	Wed, 29 May 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QkRXAPMF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7F33CFC
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971144; cv=none; b=T/nnwUSc5EI4Tnpk9N1a33rQzdaMAzaVYGwIJbBhTazviaeWOhuAj+S+lZaJwBJoofAFYtxeKeuCpIzPQH8YamudZ59jZ9SS5EpBKNMTQ1TkQRUYIlklo/PkRoEruwPVdWSuwhW3i9GFdeVnE6I9VIX+yi35JT24t6NE407bioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971144; c=relaxed/simple;
	bh=Z56n3pknVfrdXrYQxZGakMySYcLNvBhOCiTixUpe2BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUEBy/BG/JvPWNjc+j0RRky3JJd6VmYd088Psl82GXHizKKdNJ0Zrl5weJhp+0AkV1GtNwp5fKw1+qoYmSWGphKNPkSNdTg/WEBmkJvctFK4t8noVWGHKSInaMtkpCGEjjBh82KFEUn2Tw0gChDbHkNGVYLD5/n/gEp+DOV+kIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QkRXAPMF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KedQfEOQGeFOWrHJKw+wmkld2KwmplKUWUwSLw2frR0=; b=QkRXAPMFWCH8tpmeWVx5ll+tyl
	Y7tOijGOQF2hr5zB0I4JweymOLwa2cTwa93rixzwb73HGFf6ZnX/rZ0uQyaiZmhvNobGE2HWkKfrH
	Zw8uCOT91n9lnOPmZDNZLm4VCS/RL8h9q694IxKviy0OaUyKTai8m0K8yvUhlPT6BMC3E7utmPatr
	BxBZYbME8/yQ+fV/BymLX16fFuGsbrtuCp2LMffeirC+p+Men7pYAHgb8JSnr+F89YEnXzPhJVEWE
	wWkud4Fau1Ud4kQz/SSN/c2W395KONMY7LAcnNP7U0EJdHb9iXc3y1XAVwWy1dtj01kZ8qh+lFJq3
	XBS1G5ow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEcm-0000000DT4e-3wsZ;
	Wed, 29 May 2024 08:25:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 238E930073F; Wed, 29 May 2024 10:25:30 +0200 (CEST)
Date: Wed, 29 May 2024 10:25:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 07/35] sched: define *_tsk_need_resched_lazy() helpers
Message-ID: <20240529082530.GJ26599@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-8-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528003521.979836-8-ankur.a.arora@oracle.com>

On Mon, May 27, 2024 at 05:34:53PM -0700, Ankur Arora wrote:

>  static inline void clear_tsk_need_resched(struct task_struct *tsk)
>  {
> -	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
> +	clear_tsk_thread_flag(tsk, tif_resched(RESCHED_NOW));
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
> +		clear_tsk_thread_flag(tsk, tif_resched(RESCHED_LAZY));
> +}

(using tif_resched() here is really uncalled for)

So this will generate rather sub-optimal code, namely 2 atomics that
really should be one.

Ideally we'd write this something like:

	unsigned long mask = _TIF_NEED_RESCHED;
	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
		mask |= _TIF_NEED_RESCHED_LAZY;

	atomic_long_andnot(mask, (atomic_long_t *)task_thread_info(tsk)->flags);

Which will clear both bits with a single atomic.

