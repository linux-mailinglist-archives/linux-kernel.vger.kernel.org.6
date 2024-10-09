Return-Path: <linux-kernel+bounces-356481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421B39961AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5061FB259F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D607C17C9A3;
	Wed,  9 Oct 2024 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZRPjnN7k"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E92F46
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460936; cv=none; b=dVVfODElouwTz9LUIRjrIitggokL+cWaYgfwgkYjKJ4KCUjtGc6fivjHhm5jFaTGuZqdODXvhiiOcc/vlSnPqY4AheLLYFrLxXDZJ+3vxlyflrNygPd+ZV1OxLm7mbZKtVfqFZHDFrAULKaGWom34RJJX2AVLnHrA0m3lLsVw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460936; c=relaxed/simple;
	bh=VrY/Jd7B8sTggqIgdbbkGMjXgg5WpsaLcGgxLej1vLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFjlLwyJXkY+jRrVAmdZPeX+8XmBmpGueM/7gFPam8nkJDf38Tn6Bs75dLT1MpJal0WcCm5aQI8xBnGPySANe6p2KsQts+Hg9AypsbKbKzyLZp5winRREQQYvlIDBnclU4IQRZC/YssBrFv2ah5YwIcLaXYY6gFabNsP+aZsCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZRPjnN7k; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=UOQOxqKkYyFwPCX2N75mx1OwQ3qrdDd2PVz62iVt3V4=; b=ZRPjnN7kdKoJlLSoczhkh+LVnN
	3cfwfIqgSiN/u/x78KYy2500kCpG0D9+HlIUl6ps2emIb6qLKZZJN2qHNo8yogANjvOFwQmfqY4gn
	MLmoMPNDexSDpoNFRIm0MxUwfAQQBB5anM6Mx20kNduWea8w7s3XdwjjdIFt/23NqtAMJTyyjw8jx
	BVIWxD/uNkfqq+cn6Vmpisl20k0SxLR4kFNgnVL8AA0HYU1HpOpmghrk3ejCDNFrUOaYvsMz6XVMw
	B1nvs0W1yvpq9RZ7I8IbL2Wm4S/AgRs2Six+WxzsuRubANtP1MjR0zwkFLUvsMQH8C6h5+mQrgHmy
	Ckn46bCw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syRdy-00000004qUm-3lhM;
	Wed, 09 Oct 2024 08:02:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7EDEE3004AF; Wed,  9 Oct 2024 10:02:02 +0200 (CEST)
Date: Wed, 9 Oct 2024 10:02:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, tglx@linutronix.de,
	mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
Message-ID: <20241009080202.GJ17263@noisy.programming.kicks-ass.net>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de>
 <87wmihdh3u.fsf@oracle.com>
 <20241009062019.1FJYnQL1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009062019.1FJYnQL1@linutronix.de>

On Wed, Oct 09, 2024 at 08:20:19AM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-08 21:40:05 [-0700], Ankur Arora wrote:
> > > While comparing this vs what I have:
> > > - need_resched()
> > >   It checked both (tif_need_resched_lazy() || tif_need_resched()) while
> > >   now it only looks at tif_need_resched().
> > >   Also ensured that raw_irqentry_exit_cond_resched() does not trigger on
> > >   lazy.
> > >   I guess you can argue both ways what makes sense, just noting…
> > 
> > I think we want need_resched() to be only tif_need_resched(). That way
> > preemption in lazy mode *only* happens at the user mode boundary.
> 
> There are places such as __clear_extent_bit() or select_collect() where
> need_resched() is checked and if 0 they loop again. For these kind of
> users it would probably make sense to allow them to preempt themself.
> We could also add a new function which checks both and audit all users
> and check what would make sense base on $criteria.

Do we really need this -- wasn't the idea to have thing 'delay' until
the actual NEED_RESCHED bit gets set?


