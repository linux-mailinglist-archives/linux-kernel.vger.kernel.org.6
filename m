Return-Path: <linux-kernel+bounces-311013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8D69683E9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACBE4B22C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57521D363D;
	Mon,  2 Sep 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IswkE108"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C80187847
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271164; cv=none; b=jrkez/qX2d1vhLeoIZEFS+hH3V3Pjc5uPbL/oRBpiwknJAOzJXfLXBcRp0YZhMoGdVqF472lbI2rDnGQV/k29osa/xNyUknBjspDRARaozWoRubuv7x6dpAXccV999xP+L6a1uwtVHdIHrc2i6D0uGlpaByOQsUEY75CDB8C7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271164; c=relaxed/simple;
	bh=hnq9H7DibZbVqQdGQHBG53i3ao96Sy2t0ZjKR/T0Kjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdqRkb7XyAngHVVNm59mQDAdRH5JLAl2i/UFXz0s5l8Kvoua9WxR/09GA5AcfwZ+HskVYmXu/mom3oSusxo6gjuZl7RB05UfkQtT5Uwul4by2pPimhBOYLQiqE0d7GlmEtrkuCV3gxClxUK/IKcscyTn6v7tpY/Hn6TEbas1BvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IswkE108; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cyDVp9aHEgfgAflJKuO8N4CCgQNkhBJr92+WMNNlHAs=; b=IswkE108iwbRn6RJqaSDEyIFu7
	OlCvJ1RFN3K8YpSQ1E6Lc9Bl9G9y4dOD2e+b3hsjqunKDi2xJhvLn+E7f2PYqZkokWM477OjqyIBh
	ObjK9JNroQ+zfE0m9FQ5MTf/oWJUcgmeuK8bjQ/6MM7+O02JIUYSilIoB1rR0zeKjFMBOGUqwTlZz
	3g+NOk0c+xQruj56tvVM0k7IPdWD34MI2JI1c70I8g7Z3YmEbuyP/qYAZghW+lTOvI+yb7ODB0Zny
	Ujlk+wvEI2e3fvOAObeylBRODAQb8B17S9l508hqqbhMjuaBw0yC3Jcn9IIiK91vCFpqdJ9CHe3EH
	ySSmb5tA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sl3qB-00000006Pvy-0dM9;
	Mon, 02 Sep 2024 09:59:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 65783300642; Mon,  2 Sep 2024 11:59:18 +0200 (CEST)
Date: Mon, 2 Sep 2024 11:59:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Vernet <void@manifault.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 2/2 sched_ext/for-6.12] sched_ext: Use ktime_get_ns()
 instead of rq_clock_task() in touch_core_sched()
Message-ID: <20240902095918.GE4723@noisy.programming.kicks-ass.net>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240830174014.GD5055@maniforge>

On Fri, Aug 30, 2024 at 12:40:14PM -0500, David Vernet wrote:
> On Fri, Aug 30, 2024 at 12:52:48AM -1000, Tejun Heo wrote:
> > Since sched_ext: Unpin and repin rq lock from balance_scx(), sched_ext's
> > balance path terminates rq_pin in the outermost function. This is simpl=
er
> > and in line with what other balance functions are doing but it loses co=
ntrol
> > over rq->clock_update_flags which makes assert_clock_udpated() trigger =
if
> > other CPUs pins the rq lock.
> >=20
> > The only place this matters is touch_core_sched() which uses the timest=
amp
> > to order tasks from sibling rq's. For now, switch to ktime_get_ns(). La=
ter,
> > it'd be better to use per-core dispatch sequence number.
> >=20
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Fixes: 3cf78c5d01d6 ("sched_ext: Unpin and repin rq lock from balance_s=
cx()")
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > ---
> >  kernel/sched/ext.c |   10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -1453,13 +1453,20 @@ static void schedule_deferred(struct rq
> >   */
> >  static void touch_core_sched(struct rq *rq, struct task_struct *p)
> >  {
> > +	lockdep_assert_rq_held(rq);
> > +
> >  #ifdef CONFIG_SCHED_CORE
> >  	/*
> >  	 * It's okay to update the timestamp spuriously. Use
> >  	 * sched_core_disabled() which is cheaper than enabled().
> > +	 *
> > +	 * TODO: ktime_get_ns() is used because rq_clock_task() can't be used=
 as
> > +	 * SCX balance path doesn't pin the rq. As this is used to determine
> > +	 * ordering between tasks of sibling CPUs, it'd be better to use
> > +	 * per-core dispatch sequence instead.
> >  	 */
> >  	if (!sched_core_disabled())
> > -		p->scx.core_sched_at =3D rq_clock_task(rq);
> > +		p->scx.core_sched_at =3D ktime_get_ns();
>=20
> Should we just use sched_clock_cpu()? That's what rq->clock is updated
> from, and it's what fair.c does on the balance path when the rq lock is
> unpinned.

Right, so on x86 with wobbly TSC (still possible in this day and age)
ktime *must* use the HPET, while sched_clock_cpu() makes an 'educated'
guess using TSC and tick based HPET stamps and windows.

IOW, on same machines it doesn't matter much, but for the HPET case the
sched_clock() thing is a lot faster.

