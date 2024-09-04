Return-Path: <linux-kernel+bounces-315224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3668796BF7F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D908F1F2452F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B61DA2F7;
	Wed,  4 Sep 2024 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X5Z93DQQ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01E4400
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458541; cv=none; b=GA/27SQOqcscTRgj4TZYOmDoDJGpiaTyZRHPXKM8nD+ORmnrKe6k2Ruq+lG5tUhs0MIMqYLqFitjRNgWgVqnP+rShGagoJuI1Aj6hfYcS3Arcmm2EHtH7v8y4GqeCiOf4IZYCnZ4TcH+ToGn+/n1IXMPNNZxwKKNRmNDGXyTtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458541; c=relaxed/simple;
	bh=UhwfhjmEIwfyrOt+eVdm6YsUWpdK6zDRlyoJSoqeNTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJnt55oXiiMh0wVbH4CTRN7Bz9S3Xh3zJGWuP0zlNYn7TlYMrOJYHzMkjmaA1ujE50Nvsgu19VChGIrDGSkUdRM8Eykp7AqpTv+JC3oSfkpMNbV6W1ECenk3lia365kEw3B9lnMMPr4wqOh0/Xzmg9WYY7gzwKPWBmewVuGXL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X5Z93DQQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CZEi/jgdlEuh+YoqzZDjVAlHDyia1w9HPAhShC3zubc=; b=X5Z93DQQ9zeaVNGXoK+9OanCIx
	lr2iSWQLvrImTdO59nExoAAfCbAIUJffyC3tzyQzz15lhkw1vvI3PRWG7JVQ2NGPIUzx7eOLYVJ7V
	xu8b6utm7I+iE9H1V+kFH9Fl//zN/BMrxvPcVjf2C9/QK9yxXIzlq5UVdCQ4lD322ekrMYnJDXIAC
	sE8eKjxhQV3dN/yk01qQ6YNJ5/faVexv7MoBR64o9xeGIVBSOvDxTd2l9V1KrULsvsge+DRgFVOMR
	JYya7LKG2aB8Q/B4dkxBldk7u4ImLCs8AqBETpZ3Zga/9vu2mxWVRsMBoV8FjdCrmGS4UwB4IwjnJ
	FyYgZYDA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1slqaJ-00000000EgQ-1rpv;
	Wed, 04 Sep 2024 14:02:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7F5BD300642; Wed,  4 Sep 2024 16:02:10 +0200 (CEST)
Date: Wed, 4 Sep 2024 16:02:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Phil Auld <pauld@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/isolation: Add HK_FLAG_SCHED to nohz_full
Message-ID: <20240904140210.GK4723@noisy.programming.kicks-ass.net>
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-2-longman@redhat.com>
 <ZtcK3aF_d3BUhiVz@localhost.localdomain>
 <7fa3dbd5-7c2e-4614-a5f4-258546cb090b@redhat.com>
 <ZteAfUXZd1TgIwiL@pavilion.home>
 <4822d111-b02d-469a-a457-46392c35021f@redhat.com>
 <ZthWKgK9B_AUqSs1@localhost.localdomain>
 <20240904130445.GI4723@noisy.programming.kicks-ass.net>
 <20240904134427.GA136544@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904134427.GA136544@pauld.westford.csb>

On Wed, Sep 04, 2024 at 09:44:27AM -0400, Phil Auld wrote:

> > You can create single CPU partitions using cpusets dynamically.
> >
> 
> This is somewhat new though...   Although you could turn off load balancing with
> groups v1, in v2 you could not. 

I can't remember, but I think I stalled cpuset-v2 until this was
adressed -- that is, AFAIR any v2 can actually do this too. You create
many 1 cpu partitions. It is more cumbersome that v1, but it is very
much doable.



