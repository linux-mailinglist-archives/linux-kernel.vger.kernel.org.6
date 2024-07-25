Return-Path: <linux-kernel+bounces-262378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCD293C637
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5763628180F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6186019D890;
	Thu, 25 Jul 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SaS60f1Z"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E2019CCE6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721920510; cv=none; b=aKM8joM/3o1vYBeznVLmzds1rQhRzeesotlp/ImZrEQicokAQNG6xokYKYdx7WxrlsB8IpFmshR5hSzqWn7eGuvKXa0t+W0NCPlqy540dRmM2aUZQ11CPi2niJ9+UEgyymwtU44gllG42oyiaVFJQkYBaSHVvuW021bv+xEpHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721920510; c=relaxed/simple;
	bh=aZW+qcVqbz0DmqDUgj9Sk3vgM7ybguwrIK18bSKjpmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzunBv3LJTdpbrjqf/rizkp1BIvEpbrlBbMuHPvh2FOGNmbRIS//FzMyEQ3fyUoKC1tIHag198/mko29IbB06JOC1fot9sH0xeNg0QVAeINnuVYYM/qYkqmb4j/YgZn1W4j5dx1ByPUzCxf9ziI47zU06PZG/vTddqOK8tXJdZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SaS60f1Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cvghIW/iKatkE8AfzZUKowaIp4B42dtcNe1vrp6Jj+g=; b=SaS60f1Z6SBGdr/TNRL2YRdc7J
	QduHz/8j+ZQtsvZPIS/7Vxodv+HJRQhiUU0fc5pjbLRAmaPy9trHyTiIWEdORzyD+Q8SUBCLTvCSZ
	lX9icTw6363gr0SYv5UHtu8jkqzpy7h2kxdQigaq7rk/U/H+x6/y/kS6+BtP985lx1XZ8pAy3hOIa
	3Q8iQn7ZHeBpj+IBOkDy87dj/g2IAkg1qPAFlGhXSHMLbKhRGJBdRVp1r6vTrSVQNBNSROFGRLeep
	d/WuMBtt4+9QRQ5OkLvrz6nPXleQfbavDO2+l+r1G6SNutwwukWMUafYBwV3KKHE7qfQmD4GK/q3/
	bIrF88UQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX0BH-0000000935x-1eKp;
	Thu, 25 Jul 2024 15:14:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 54D3230037B; Thu, 25 Jul 2024 17:14:58 +0200 (CEST)
Date: Thu, 25 Jul 2024 17:14:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: zhengzucheng <zhengzucheng@huawei.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, oleg@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sched/cputime: Fix mul_u64_u64_div_u64() precision
 for cputime
Message-ID: <20240725151458.GJ13387@noisy.programming.kicks-ass.net>
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <20240725140508.GH13387@noisy.programming.kicks-ass.net>
 <b21d9fa7-45be-8346-db28-4c42847e2e0b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b21d9fa7-45be-8346-db28-4c42847e2e0b@huawei.com>

On Thu, Jul 25, 2024 at 10:49:46PM +0800, zhengzucheng wrote:
> Sorry, I made a mistake here. CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set.
> 
> 在 2024/7/25 22:05, Peter Zijlstra 写道:
> > On Thu, Jul 25, 2024 at 12:03:15PM +0000, Zheng Zucheng wrote:
> > > In extreme test scenarios:
> > > the 14th field utime in /proc/xx/stat is greater than sum_exec_runtime,
> > > utime = 18446744073709518790 ns, rtime = 135989749728000 ns
> > > 
> > > In cputime_adjust() process, stime is greater than rtime due to
> > > mul_u64_u64_div_u64() precision problem.
> > > before call mul_u64_u64_div_u64(),
> > > stime = 175136586720000, rtime = 135989749728000, utime = 1416780000.
> > > after call mul_u64_u64_div_u64(),
> > > stime = 135989949653530
> > > 
> > > unsigned reversion occurs because rtime is less than stime.
> > > utime = rtime - stime = 135989749728000 - 135989949653530
> > > 		      = -199925530
> > > 		      = (u64)18446744073709518790
> > > 
> > > Trigger scenario:
> > > 1. User task run in kernel mode most of time.
> > > 2. The ARM64 architecture && CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y &&
> > >     TICK_CPU_ACCOUNTING=y
> > > 
> > > Fix mul_u64_u64_div_u64() conversion precision by reset stime to rtime
> > > 
> > > Fixes: 3dc167ba5729 ("sched/cputime: Improve cputime_adjust()")
> > > Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
> > > ---
> > >   kernel/sched/cputime.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > > index aa48b2ec879d..365c74e95537 100644
> > > --- a/kernel/sched/cputime.c
> > > +++ b/kernel/sched/cputime.c
> > > @@ -582,6 +582,8 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
> > >   	}
> > >   	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
> > > +	if (unlikely(stime > rtime))
> > > +		stime = rtime;

Ooh,.. I see, this is because the generic fallback for
mul_u64_u64_div_u64() is yuck :/

On x86_64 this is just two instructions and it does a native:

  u64*u64->u128
  u128/u64->u64

And this should never happen. But in the generic case, we appoximate and
urgh.

So yeah, but then perhaps add a comment like:

	/*
	 * Because mul_u64_u64_div_u64() can approximate on some
	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
	 */
	if (unlikely(stime > rtime))
		stime = rtime;

Also, I would look into doing a native arm64 version, I'd be surprised
if it could not do better than the generic variant.

