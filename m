Return-Path: <linux-kernel+bounces-392388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA999B9380
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCB0283375
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2891A76C4;
	Fri,  1 Nov 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrkmE4s8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614741A7271
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472162; cv=none; b=F7LnnEPn3FSC/+DUggRxQLyR8WwBixrK2Y8nK3RIUiYgY6TsI7L8h0E6mR4804ef1L+1STkNMqjWdJcb038Tl0LFMgfQ8QbFpqQexzyU1I5+kWn2xVIlwkkr+4fg//hcuDchSeIQvBuuYqTfMdx01adlBUjPhT74rmjxpy0k8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472162; c=relaxed/simple;
	bh=/+trJElFKmQl3MJSkrbco7r3VpgVFnslUyiac16a7bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL52lLgXBBaBnA6kR0E5KYznbO7f6QYGErptAhVDt4mMH5vDFdaWfR5HFlQeHEnn2prNQk6o/5GOks5d8fssDX0APqoNfXe9oUzPcW4d+iwNG+qY1SuRhe99DXmPHmd8AOdExhxATba30/vFH9zxUmE6HOoHgKzT/6TfQzEdhKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrkmE4s8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730472158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0B0g6xSvQ72F38uB7t1lGT7rS+vQAQmDXsEDQC5GYw=;
	b=GrkmE4s8i0gEATva9ibxe+yk7mVTQN3c9zZgMH+2FkfJP3obarRplBMoO1IRc+fnbk/N7h
	B126Fgp1nRQk7KxV0ubajDcD5VTrZnEvJn6n+MxpiLw0+2D5nG1ECdQ6XyJPz1YabKGEPq
	TN6b8ND9wXNF5uaCvJv5a+h5wYSD/6s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-IzjzbB3GNxuPKZr_1vwo3A-1; Fri,
 01 Nov 2024 10:42:34 -0400
X-MC-Unique: IzjzbB3GNxuPKZr_1vwo3A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3E5F1956096;
	Fri,  1 Nov 2024 14:42:32 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73EEA300018D;
	Fri,  1 Nov 2024 14:42:28 +0000 (UTC)
Date: Fri, 1 Nov 2024 10:42:25 -0400
From: Phil Auld <pauld@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241101144225.GD689589@pauld.westford.csb>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
 <20241101133822.GC689589@pauld.westford.csb>
 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101142649.GX9767@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Nov 01, 2024 at 03:26:49PM +0100 Peter Zijlstra wrote:
> On Fri, Nov 01, 2024 at 09:38:22AM -0400, Phil Auld wrote:
> 
> > How is delay dequeue causing more preemption? 
> 
> The thing delay dequeue does is it keeps !eligible tasks on the runqueue
> until they're picked again. Them getting picked means they're eligible.
> If at that point they're still not runnable, they're dequeued.
> 
> By keeping them around like this, they can earn back their lag.
> 
> The result is that the moment they get woken up again, they're going to
> be eligible and are considered for preemption.
> 
> 
> The whole thinking behind this is that while 'lag' measures the
> mount of service difference from the ideal (positive lag will have less
> service, while negative lag will have had too much service), this is
> only true for the (constantly) competing task.
> 
> The moment a task leaves, will it still have had too much service? And
> after a few seconds of inactivity?
> 
> So by keeping the deactivated tasks (artificially) in the competition
> until they're at least at the equal service point, lets them burn off
> some of that debt.
> 
> It is not dissimilar to how CFS had sleeper bonus, except that was
> walltime based, while this is competition based.
> 
> 
> Notably, this makes a significant difference for interactive tasks that
> only run periodically. If they're not eligible at the point of wakeup,
> they'll incur undue latency.
> 
> 
> Now, I imagine FIO to have tasks blocking on IO, and while they're
> blocked, they'll be earning their eligibility, such that when they're
> woken they're good to go, preempting whatever.
> 
> Whatever doesn't seem to enjoy this.
> 
> 
> Given BATCH makes such a terrible mess of things, I'm thinking FIO as a
> whole does like preemption -- so now it's a question of figuring out
> what exactly it does and doesn't like. Which is never trivial :/
> 

Thanks for that detailed explanation.

I can confirm that FIO does like the preemption

NO_WAKEUP_P and DELAY    - 427 MB/s
NO_WAKEUP_P and NO_DELAY - 498 MB/s
WAKEUP_P and DELAY       - 519 MB/s
WAKEUP_P and NO_DELAY    - 590 MB/s

Something in the delay itself
(extra tasks in the queue? not migrating the delayed task? ...) 

I'll start looking at tracing next week.


Thanks,
Phil


-- 


