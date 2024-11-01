Return-Path: <linux-kernel+bounces-392308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0199A9B922B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B82B21D7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F401A01BD;
	Fri,  1 Nov 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbscoFiV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1D15B984
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468318; cv=none; b=A4cPqcQoq+KxMOieQMsKfvk0S8KUdS7gkHCjf9xvqfp9iU/JXQlki+l0ryHRjL904Fhnxgi2V1vZduEwdllcZQzdg/FOaRDt8Lt21bWFLx3OOz7UMEdUy3Lcbhdit2rdXfB9O76RbwCVMi0sjRmBNQtHXOGyGGofJmJ/6QvlO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468318; c=relaxed/simple;
	bh=ycoAsqZVHffhc5pNKcBQmKpX30uD6afuVkS1vuRz85g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuSpzwjZJQIoEeeIj9fRFFfZ3C1XKupr0A29eeeQNyz6iduGPeaXUmQVXUGhhn3hirZuM7tGkGAFqp2qZCjBpr4FkzUzZMcVHIbUlnmdXs7tVFsYtEIxrSKwG9RcmmOmC+P0J0NBE1ypO9WqXKUoRJcYk2e0U5wfyvIEPnkmjT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WbscoFiV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730468314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y64aHZy69ep5hVsahGbzKlLI8oisSib5YyOyQcQnNoE=;
	b=WbscoFiV/I9PM3cxlrINX5o0lqxSpSCd/jDoyENnXVLtFDF2iAH5JlZy5KKElcQ9MXoIKG
	Ykb8PdK54XOtHfboA9vtq44Q7jE52zlVDsnFqOF7pQM7+nUDPUKmLLecKpSN7wmmqI1YzV
	Kx5eibF1787HHozYFiF+S9cP43sd2eQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-3_Ccjih3O4WDLo5Yh1mu5A-1; Fri,
 01 Nov 2024 09:38:31 -0400
X-MC-Unique: 3_Ccjih3O4WDLo5Yh1mu5A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEEC519560BE;
	Fri,  1 Nov 2024 13:38:28 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEDC7195605A;
	Fri,  1 Nov 2024 13:38:24 +0000 (UTC)
Date: Fri, 1 Nov 2024 09:38:22 -0400
From: Phil Auld <pauld@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241101133822.GC689589@pauld.westford.csb>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101125659.GY14555@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Nov 01, 2024 at 01:56:59PM +0100 Peter Zijlstra wrote:
> On Fri, Nov 01, 2024 at 08:47:15AM -0400, Phil Auld wrote:
> 
> > This one is causing a 10-20% performance hit on our filesystem tests.
> > 
> > On 6.12-rc5 (so with the latest follow ons) we get:
> > 
> > with DELAY_DEQUEUE the bandwidth is 510 MB/s
> > with NO_DELAY_DEQUEUE the bandwidth is 590 MB/s
> > 
> > The test is fio, something like this:
> > 
> > taskset -c 1,2,3,4,5,6,7,8 fio --rw randwrite --bs 4k --runtime 1m --fsync 0 --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --nrfiles 1 --loops 1 --name default --randrepeat 1 --time_based --group_reporting --directory /testfs
> > 
> > In this case it's ext4, but I'm not sure it will be FS specific.
> > 
> > I should have the machine and setup next week to poke further but I wanted
> > to mention it now just in case any one has an "aha" moment.
> > 
> > It seems to only effect these FS loads. Other perf tests are not showing any
> > issues that I am aware of.
> 
> There's a number of reports -- mostly it seems to be a case of excessive
> preemption hurting things.
> 
> What happens if you use:
> 
>   schedtool -B -a 1-8 -e fio ....
> 
>

Thanks for taking a look. 

That makes the overall performance way worse:

DELAY_DEQUEUE - 146 MB/s
NO_DELAY_DEQUEUE - 156 MB/s

I guess that does make the difference between delay and nodelay
about half. 

How is delay dequeue causing more preemption? Or is that more
for eevdf in general?  We aren't seeing any issues there except
for the delay dequeue thing.



Cheers,
Phil

-- 


