Return-Path: <linux-kernel+bounces-181222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA7C8C7928
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB01D1C2095A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CAF14D2A6;
	Thu, 16 May 2024 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GU4NPhW0"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4341E491
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872801; cv=none; b=j/t74u+e1YtkAfxVnqy2KUyGMfExeXH75zy991QzFL6dU+cAEmkv94RkVgTgjdBPKn1BQ/xXXo/wTcoBI9RTO7F6t0/az/yC+El4zCWW6492ongaD/K5rGgCnlalKKzx4yjFeQhCzB7+/9OXK3CRTWv3XiKiUJ5xPSvoG0NqgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872801; c=relaxed/simple;
	bh=g4pCKFHtNv8tWxkrcOunRV36cnVd3ULvVwjtURKk6wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqrJVyg19vT1GjA5xL8ltJFZZ8t1UdHUJr+GwwbfPQnXWByvXPOrRSd1h6LlnJOQxx2kVOEFB9ZOvBAZ0EtzgjBS1H7h/KjCWPhUMM7IAD45yU1MSnFzRdzIKsSCkqmV6wfj3Q9NZdxXn58KA4aKnbcXUuioFkuvAPrgLzL9HeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GU4NPhW0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vfRYymjV7A2ksiA1ifbCkQIzMUN+OUNKRWRmXGE/juQ=; b=GU4NPhW0NSrW3wS9kvVVbr9Ov6
	kVillMd+D/CsiGg8X2K8B71+JW3sGmv6PWZOinBZISE1sr8ZCZQjy2JaBTg8l1H4zgU9I6TYW9PBC
	4xohhmK5bfCpFeY6HZT/3kNatqA+HMqxNlAHP8jHUWQGIQrdEP6OEl0kyBPzfPKlbg2vFWMwhz92+
	zYUeEbMa8P+0p7bcKxAUOoPLhRampjlERPb5Z0QwdphJnTz7sE4IOx2sWPJU+lboJWh992au7xL0W
	HV5eNk0qMnOCJlQledOoGpFiSWpMx10J2UkapoopwLqj7yj3PvEmfM/myZ2rEptV4MR9oSMjbbxEs
	D2EVAlEA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7ctd-00000005Sgs-473N;
	Thu, 16 May 2024 15:19:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4367330068B; Thu, 16 May 2024 17:19:53 +0200 (CEST)
Date: Thu, 16 May 2024 17:19:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Yun Levi <ppbuk5246@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
Message-ID: <20240516151953.GM22557@noisy.programming.kicks-ass.net>
References: <ZkU8lm2tjm_r9FpZ@pavilion.home>
 <20240516075628.GC22557@noisy.programming.kicks-ass.net>
 <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>
 <20240516084911.GF22557@noisy.programming.kicks-ass.net>
 <ZkXtHv+fHUD2+lFJ@lothringen>
 <CAM7-yPTSq0CSmRsTpeXwzhFk77gfwUK_LZKnbgo4NPk5zPCaAg@mail.gmail.com>
 <20240516140003.GJ22557@noisy.programming.kicks-ass.net>
 <ZkYW48dTX2FH5NaD@lothringen>
 <20240516144504.GL22557@noisy.programming.kicks-ass.net>
 <ZkYgG9KYMpUPeJsM@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkYgG9KYMpUPeJsM@lothringen>

On Thu, May 16, 2024 at 05:02:51PM +0200, Frederic Weisbecker wrote:

> > I'm confused, none of that makes sense. If you're part of a
> > load-balancer, you're part of a load-balancer, no ifs buts or other
> > nonsense.
> > 
> > idle load balancer is no different from regular load balancing.
> > 
> > Fundamentally, you can't disable the tick if you're part of a
> > load-balance group, the load-balancer needs the tick.
> > 
> > The only possible way to use nohz_full is to not be part of a
> > load-balancer, and the only way that is so is by having (lots of) single
> > CPU partitions.
> 
> So you're suggesting that nohz_full should just be part of the whole
> ilb machinery by default (that is, not fiddle with ilb internals) and
> then it's up to CPU partitioning (through cpuset or isolcpus) to disable
> ilb naturally. Right?

Yes, but stronger, as long as the CPU is part of a load-balance domain,
it must not disable the tick while running anything.

that is, NOHZ_FULL must not become active unless it's running on a
single CPU partition.

