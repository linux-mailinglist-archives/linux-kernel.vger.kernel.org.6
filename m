Return-Path: <linux-kernel+bounces-392366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038649B9321
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBA52830FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A151B1A0BE5;
	Fri,  1 Nov 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VpIZcw7Y"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216B01BF24
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471221; cv=none; b=b/u1fVB4p0UKx2kwHxxe/KsPcKet/4/F3RAllFPvmMlSf1lmPfiLhOdzlV58LTdz8ZD3WMEvMMvycVZt458vvLU0K1OfQb9YLI+6/Gu7UXX2bPa90pK8r+NStOPVsJJoojqBN8Nj/jxaCUpQhXuyMdSs44e8QAw1JsXp+9CRdz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471221; c=relaxed/simple;
	bh=csDC50QCLQ47lVad1nrBlueOXPGfdjtQnmigKMxgP3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5qzNBG2HAC9Nz2+txUe1UZc/xxEfJ6xTnXwS14dAfU+S18k3iLxTbENo8VN3ZLoDmFyzEh+U9e6UKbsjnQcqbkQy2LP/+cwfm5+TRtEi0IILMW2rncnHwcavsqqSfb1wcsADpMbYoCzBVoI/SiUT2xK9E0F0hLMGCPba6169gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VpIZcw7Y; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HRevB+kZbqm5VGCy9Ywv6yEZT40BCpLMVp4OxdFSLX0=; b=VpIZcw7Y5WkWv6Gs38ATo73wUx
	CA68bVWfRmCoElPC62lBmuZ97qz4qsp7bwLQw+vii87heqEYd3i8XrpUka/J1NZCDIW8P7KqwA0vu
	/yF2+nkdDMuaaE79OspfHNhRcePfmWNa1LJ0fgAneqlPtKeoUTd+U/vS/kKmY9BB/AmXXe4FBo9If
	c86Js4S66eWzQ2NLHHDSqM4oUixeKrLu17kykSWXxAJQxgmaJg0IkoSfQEULESZU2TJo3UJwTlZ48
	z+sh6toAZbfUIkpjeWXvUNRPJ06Gmwoln9RTF6VGftV3gwewmRFgsBQXgmrtZqyCdgQ2EFooPVfSN
	wN3/8lDQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sbx-0000000AkBv-1qnH;
	Fri, 01 Nov 2024 14:26:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 19FD1300599; Fri,  1 Nov 2024 15:26:49 +0100 (CET)
Date: Fri, 1 Nov 2024 15:26:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Phil Auld <pauld@redhat.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241101142649.GX9767@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
 <20241101133822.GC689589@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133822.GC689589@pauld.westford.csb>

On Fri, Nov 01, 2024 at 09:38:22AM -0400, Phil Auld wrote:

> How is delay dequeue causing more preemption? 

The thing delay dequeue does is it keeps !eligible tasks on the runqueue
until they're picked again. Them getting picked means they're eligible.
If at that point they're still not runnable, they're dequeued.

By keeping them around like this, they can earn back their lag.

The result is that the moment they get woken up again, they're going to
be eligible and are considered for preemption.


The whole thinking behind this is that while 'lag' measures the
mount of service difference from the ideal (positive lag will have less
service, while negative lag will have had too much service), this is
only true for the (constantly) competing task.

The moment a task leaves, will it still have had too much service? And
after a few seconds of inactivity?

So by keeping the deactivated tasks (artificially) in the competition
until they're at least at the equal service point, lets them burn off
some of that debt.

It is not dissimilar to how CFS had sleeper bonus, except that was
walltime based, while this is competition based.


Notably, this makes a significant difference for interactive tasks that
only run periodically. If they're not eligible at the point of wakeup,
they'll incur undue latency.


Now, I imagine FIO to have tasks blocking on IO, and while they're
blocked, they'll be earning their eligibility, such that when they're
woken they're good to go, preempting whatever.

Whatever doesn't seem to enjoy this.


Given BATCH makes such a terrible mess of things, I'm thinking FIO as a
whole does like preemption -- so now it's a question of figuring out
what exactly it does and doesn't like. Which is never trivial :/

