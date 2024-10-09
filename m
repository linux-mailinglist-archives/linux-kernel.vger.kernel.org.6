Return-Path: <linux-kernel+bounces-357185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8461996D1D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834FD28745D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762D1C2DB8;
	Wed,  9 Oct 2024 14:01:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F819B5B2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482490; cv=none; b=Wo4elXNWJeUWNO8Pr7N1XVhGM2yuJqIXwWXvTyYyHF8eYX4qV4X/pih0kHov9N6sFQxLj7A7IqCsFVFa3MfpO1RBZ2HownfMH8z+fA9BoaPkCM2QpR5xaPZyuX0Y2cR8sRzhP+8G3yhxdVRuAYtKlpqqY/UvSqlZDpmgqmWBUEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482490; c=relaxed/simple;
	bh=cwiTO2w05zDu5O/3uj0E5fTWx6bHbQk6S8OR+kLvpEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzfj0sFyaIoFNpldAungK3fagkmZWIgiO7Nt6EvutWWVjR2uRiExxXC1yYDR7xuhcM2nq7xn1p6VIPl++CUSib3aufn+8jeb+bIfRxR0A6JJKHObVwh1y8ncizhWoLU/BQIR159WXUgZ/j96M5vK2TtMiheDDESIYd0hsxC/crw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AEBC4CEC5;
	Wed,  9 Oct 2024 14:01:28 +0000 (UTC)
Date: Wed, 9 Oct 2024 10:01:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ankur Arora
 <ankur.a.arora@oracle.com>, tglx@linutronix.de, mingo@kernel.org,
 linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
Message-ID: <20241009100133.2569e2a7@gandalf.local.home>
In-Reply-To: <20241009080202.GJ17263@noisy.programming.kicks-ass.net>
References: <20241007074609.447006177@infradead.org>
	<20241008153232.YwZfzF0r@linutronix.de>
	<87wmihdh3u.fsf@oracle.com>
	<20241009062019.1FJYnQL1@linutronix.de>
	<20241009080202.GJ17263@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Oct 2024 10:02:02 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 09, 2024 at 08:20:19AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2024-10-08 21:40:05 [-0700], Ankur Arora wrote: =20
> > > > While comparing this vs what I have:
> > > > - need_resched()
> > > >   It checked both (tif_need_resched_lazy() || tif_need_resched()) w=
hile
> > > >   now it only looks at tif_need_resched().
> > > >   Also ensured that raw_irqentry_exit_cond_resched() does not trigg=
er on
> > > >   lazy.
> > > >   I guess you can argue both ways what makes sense, just noting=E2=
=80=A6 =20
> > >=20
> > > I think we want need_resched() to be only tif_need_resched(). That way
> > > preemption in lazy mode *only* happens at the user mode boundary. =20
> >=20
> > There are places such as __clear_extent_bit() or select_collect() where
> > need_resched() is checked and if 0 they loop again. For these kind of
> > users it would probably make sense to allow them to preempt themself.
> > We could also add a new function which checks both and audit all users
> > and check what would make sense base on $criteria. =20
>=20
> Do we really need this -- wasn't the idea to have thing 'delay' until
> the actual NEED_RESCHED bit gets set?

If we think about it as what would happen with the current PREEMPT_NONE,
wouldn't need_resched() return true as soon as NEED_RESCHED is set? That
means, with PREEMPT_AUTO, it should return true if LAZY_NEED_RESCHED is
set, right? That would make it act the same in both cases.

-- Steve

