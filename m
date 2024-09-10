Return-Path: <linux-kernel+bounces-323207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE197395F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284921F269B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E544193418;
	Tue, 10 Sep 2024 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XWakvYFs"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3418FDA5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977270; cv=none; b=rTyiC64ZCyKAnbRJD7zOzBuNmoYOy0u0XGvrRUKcB8tWzGSKaDnKjY8BpRk2mM5eM+LPbiIVoFmUpB7NidOw8Ll0FBqO5SuwVrHrAed4/NlNvJhS92bdFWtBupPHnFELYPVSb1axPtN0w/GO2UBRi6weAM8jG3DkcvX0ac+UuIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977270; c=relaxed/simple;
	bh=GsP7IoiwUDr9UcK6IbeiWdY7W3PiWVr8OPurOzz8pJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC5mKhBU+Qh8sHvR7dz+GP6U2F1J5wDJ0y3Dkb1UnzJjjllvJ90Cn5BXEK32wuPn7PWFCBik8Ose7kSaOBhnQMA/YbyBH/lNpYEFaUg/qwSp99lPrTu6cbQj0dZeofG7e9s1xJbIoTDhbhYvlgMPG4xkhr2Rr6bCoS9S3WkM9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XWakvYFs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qKnsH8PJo0Jfvw18PFXsJrHVQClZIwEJEimjaEeFq7E=; b=XWakvYFs3jsaKFbDtQBSpz94Vq
	3BvXTqpGMGLkVIWPaebl8eAZWxtXaUoKeAy4CvixSF23p+z2OtRl1gkVvQRnVtgrxW+BjEKE+ebil
	W1Ol9YXt6JTmHCU7fTbbL9CSa3ZuCIOeUc6gVouCNWnuBFUjNpxn2QbfHCYbE8iZ8C08IisEU2dq4
	qBW76U116xHK6fma6rll86PaGNTw6oquVqyy6n/Gb7+zx45QQFxl9jU1mImhmpSWZOpihkWRUujfO
	QcIOhgoGU8HXYg6h2NfvuP5kvQo28xImjfEDXHXC/+4QyDstLD/AYcm+HluMxWrOSQMRfMvU70dJz
	tT6q8PGQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1so1Wt-0000000BdGT-23Qh;
	Tue, 10 Sep 2024 14:07:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2126E30047C; Tue, 10 Sep 2024 16:07:39 +0200 (CEST)
Date: Tue, 10 Sep 2024 16:07:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 00/24] Complete EEVDF
Message-ID: <20240910140739.GI4723@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <yt9d4j6nenps.fsf@linux.ibm.com>
 <yt9dzfofd7im.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dzfofd7im.fsf@linux.ibm.com>

On Tue, Sep 10, 2024 at 02:21:05PM +0200, Sven Schnelle wrote:
> Sven Schnelle <svens@linux.ibm.com> writes:
> 
> > Peter Zijlstra <peterz@infradead.org> writes:
> >
> >> Hi all,
> >>
> >> So after much delay this is hopefully the final version of the EEVDF patches.
> >> They've been sitting in my git tree for ever it seems, and people have been
> >> testing it and sending fixes.
> >>
> >> I've spend the last two days testing and fixing cfs-bandwidth, and as far
> >> as I know that was the very last issue holding it back.
> >>
> >> These patches apply on top of queue.git sched/dl-server, which I plan on merging
> >> in tip/sched/core once -rc1 drops.
> >>
> >> I'm hoping to then merge all this (+- the DVFS clock patch) right before -rc2.
> >>
> >>
> >> Aside from a ton of bug fixes -- thanks all! -- new in this version is:
> >>
> >>  - split up the huge delay-dequeue patch
> >>  - tested/fixed cfs-bandwidth
> >>  - PLACE_REL_DEADLINE -- preserve the relative deadline when migrating
> >>  - SCHED_BATCH is equivalent to RESPECT_SLICE
> >>  - propagate min_slice up cgroups
> >>  - CLOCK_THREAD_DVFS_ID
> >
> > I'm seeing crashes/warnings like the following on s390 with linux-next 20240909:
> >
> > Sometimes the system doesn't manage to print a oops, this one is the best i got:
> >
> > [..]
> > This happens when running the strace test suite. The system normaly has
> > 128 CPUs. With this configuration the crash doesn't happen, but when
> > disabling all but four CPUs and running 'make check -j16' in the strace
> > test suite the crash is almost always reproducable.

I noted: Comm: prctl-sched-cor, which is testing core scheduling, right?

Only today I;ve merged a fix for that:

  c662e2b1e8cf ("sched: Fix sched_delayed vs sched_core")

Could you double check if merging tip/sched/core into your next tree
helps anything at all?

