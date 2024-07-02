Return-Path: <linux-kernel+bounces-237809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2505923E68
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001491C21F3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B04219D8AA;
	Tue,  2 Jul 2024 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TUM0P8V3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40919CCFF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925756; cv=none; b=nLm3KxQznOKJXiY5kK7tvT19RoImT3z2XIZKj9Z7U+rmaoaDeB7BNfsNueHk0zPxwh/tQN6O2k3b0nXp5zcfs6dfhO1wGfjyf2LACHW6T/n1q1Gsi9P3sKsKxxe4yRJTf52nj6uWOuZeukZf6lP8lqATDMyrYIgZnf4k3oh0f9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925756; c=relaxed/simple;
	bh=I7aNRo+sve/BZvbTVmJbcCR9t4DkOqGj0zOcNQmFlrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCdMgi5jWppjSP35Vag1p4AJzX1t6C2EU3g+Imcvzr40GFdRSu4BUC4zcQzq9nKtwUgU2d2oRNQCFkJzVW6ylLxRE3zxsl+EIbKbrgi5KxgpWnA/S84wY2foYASOmsJBFPOuFtFPSSVdz1IZGLE9q+j9sPkFxxmFDyZWeGfbYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TUM0P8V3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qwc169O9ryOr+Zwl4OTGypcihMe4v8eMeZPJXKyjQKQ=; b=TUM0P8V3efqF00LMj3W3CB56L4
	ZjEIV1R2SUW2iT0pl39R44/r+DhUcUSAsLQDeiu1CVMSB4/KZwN4sCLaoC12pArsutzJ6n/TPYMSl
	5v94MxmGKZYI2s03BVRicer4N99kjVbETMXYuGXG1OOuUefO/ozKRwxKmMZK6UEkKgUmZiwc42Bc8
	p45Ed92mT82BLB6kxrh2z0/VRc+/4ucnWTfVoI/ur7OBr6mk6AsCpuiu64C++aYe9neg1uMtRw2ET
	u5KRhoFWs5z25+NoohwAvIp+E6pcMUMLQb0pCdTFuwgTPBoWMF3mH463mesH7j38ZY7VEZdYXVlK9
	fb/Tl/Tw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOdFe-00000000nTO-2GZW;
	Tue, 02 Jul 2024 13:08:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1A367300694; Tue,  2 Jul 2024 15:08:53 +0200 (CEST)
Date: Tue, 2 Jul 2024 15:08:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Libo Chen <libo.chen@oracle.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"bristot@redhat.com" <bristot@redhat.com>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"wuyun.abel@bytedance.com" <wuyun.abel@bytedance.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"efault@gmx.de" <efault@gmx.de>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240702130852.GI11386@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <CA44DAC1-B01A-4208-B9A0-D824E8178974@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA44DAC1-B01A-4208-B9A0-D824E8178974@oracle.com>

On Tue, Jul 02, 2024 at 02:56:51AM +0000, Libo Chen wrote:

> Hi Peter,
> 
> We are observing massive hackbench regressions with this patchset as
> well as the newer version from your queue.  I don’t know if you are
> still working on complete EEVDF, just want to bring this
> issue to your attention if it’s still in play.

Yeha, I'm still (slowly) poking at this. I was planning to post a new
set in a week or so.

> The test system is a two-socket Zen4 EYPC with total of 192C/384T,
> intel does suffer too but to a lesser degree.  Kernel is v6.10 based
> off the latest schedule/core. From 48 groups to 296 groups,
> process/threads via socket degrades <= 60%, process/threads via pipe
> can have regression at whopping 110% or more.
> 
> It turns out in deactivate_task(), this patchset changes the order of
> dequeue_task() and setting p->on_rq such that p->on_rq is set after
> dequeue_task() gets called. 

Bah, I knew I had to double check that,.. but then I never did :/

> My understanding is TASK_ON_RQ_MIGRATING
> allows src rq lock to be released to other tasks since
> soon-to-be-dequeued task is migrating anyway, so holding two rq locks
> while dequeuing seems to be a quite horrible thing to do. The RFC
> patch is a bit tricky to get the order back, but a fix can be easily
> done to your newer version specifically to “sched: Split DEQUEUE_SLEEP
> from deactivate_task()” like below:
> 
>  void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
>  {
> -       dequeue_task(rq, p, flags);
> -
>         WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
>         ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> +
> +       dequeue_task(rq, p, flags);
>  }

Thanks, I'll fold that in and try and put your name somewhere.

