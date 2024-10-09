Return-Path: <linux-kernel+bounces-357675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3EA9973F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0551C24B91
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C0F1DFE2B;
	Wed,  9 Oct 2024 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YhvFChua"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463A15CD78
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496968; cv=none; b=nStryjfz+13PjGJxdrxftQtIuwOHcQZvEP81f5J9x2wud8icSC7FHqQgJJm8gWCqPd9EjLQquRpuwsxDNq4rQrYeuNo+hM08sGNepQ4rbACj4VVHWUN8wHf4g+xU40LXAx0oUoIPyqNCvJnLzWJKGniMSKLY25VEKIaZxVd+NWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496968; c=relaxed/simple;
	bh=uufaGhPfBKH4bXGbC8VnH4pc/tiVno7fbyMj/UIEXw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL2X+5YZdYdEsK0ZGsouRLaCnH/FyCIMao/9OfDp5IbGCjLP9vm7oaJnhlv8FuNJBQ70YurQbTu5Xs6Aoo/1e1BvlnsQ8Gg1g8TwjJ3G0XQYY+C2XH9/xx9iZ9BgpacSZ9uo2hf3sicIEUGH0xA0WTu8ni7JW9FKsx7jpw7FMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YhvFChua; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YsGlJliD121LwIDrCts0ht88D8qw94VJ0R5KaHarO/8=; b=YhvFChuaSXWl/3Hc1nokNul48U
	SWCL3F11Ef781QoYu4KH18j9o1vS4J7SGCtUkFYKkKS7cw15IF1kYmyyXGtIuPLhS90whylsOhhcB
	0IKqY8si6SFARHheXj2CAnk5GgAf5eDaNiu6BXHeYC2IxbhOiHFLNoLFJ069tnNd0vo39DMRIeXu4
	Dg9P5FfmV9IRSUZ/KJ2oiUY8bjvdQSAN+snEmX6aAvYrqyhy6jUl35t24/6nRZXn7YJ3Dn1tQuDce
	6c4tzSYVJZbDVGccfJ6mQNqD00l9cWtP+qhU9sD2eThDCQ7P6FnD+4drqZUADPUJSkuKfUCWeFnnI
	qP3eMuOw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syb16-00000005ShI-14Jp;
	Wed, 09 Oct 2024 18:02:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5E1AA30057A; Wed,  9 Oct 2024 20:02:32 +0200 (CEST)
Date: Wed, 9 Oct 2024 20:02:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, paulmck@kernel.org,
	mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 5/7] rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
Message-ID: <20241009180232.GT17263@noisy.programming.kicks-ass.net>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-6-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009165411.3426937-6-ankur.a.arora@oracle.com>

On Wed, Oct 09, 2024 at 09:54:09AM -0700, Ankur Arora wrote:

> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 1bfe7016724f..cd3148fb566a 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -91,7 +91,7 @@ config NEED_TASKS_RCU
>  
>  config TASKS_RCU
>  	bool
> -	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
> +	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_LAZY)
>  	select IRQ_WORK

PREEMPT_LAZY implies PREEMPTION

