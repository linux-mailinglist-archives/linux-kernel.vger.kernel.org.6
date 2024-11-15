Return-Path: <linux-kernel+bounces-410809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA949CE133
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835791F21ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67D1CEE92;
	Fri, 15 Nov 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oxw77Znn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE61B218E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680832; cv=none; b=ZTrZUzJEQ08ugtGYMG44AFp0ffz9NsjQiv4EJvxCoAAQVQAXbcEfxt8tWgbS9Kcv2FvJok0AdFNzTlycdSuhsMmyRFF55X1ygPpOMOHyUeC0tHoZyFHxw5yZRN+gl7q/bln00a3ygIPTd8AYU7A1jOUi4Y189TCgwgsOmeAYX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680832; c=relaxed/simple;
	bh=LL6e8koBfdB350VWA48ob1YDU4XHkv0EpXuoO5xuYJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oeq1yy3tBJgcLb99whnb+ZIOvT5iRppdqUWjt70JI+0i3m3yjntLOPjVzKO9qM+l+d56Y9zvjtu/Y3yEiPHJbBWavN8/mh596dgybnUooGZqD7OiK9gS1xK9sJhDR1jYM5EY/lEy6WuAgHLCZQFGSunQxEDg+uBFoZio6ZMOQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oxw77Znn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731680829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygXmFpLrnXabffCUO0507o0UCrzrZWdtrjeT4sbEyTc=;
	b=Oxw77ZnnU9oEWnWtv5jB0gP2rnr6ETAGSiTsNQW88ZpPj3w8ug3T0QtdjR4p55OwUS/kX5
	rLFbvOANdrvhtET0Aps5qt6M7Kcyk6xLjD31cS1HXp8lTXdhgNfc7nVCUE6Uf3nmrWqovx
	gWuYy8XzGQ2+5CLXppQD0cbyegkgbLQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-RHB4zn-VPT-0zdMAiSPBlw-1; Fri,
 15 Nov 2024 09:27:05 -0500
X-MC-Unique: RHB4zn-VPT-0zdMAiSPBlw-1
X-Mimecast-MFC-AGG-ID: RHB4zn-VPT-0zdMAiSPBlw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E497195609E;
	Fri, 15 Nov 2024 14:27:04 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.129])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2704B1953883;
	Fri, 15 Nov 2024 14:27:00 +0000 (UTC)
Date: Fri, 15 Nov 2024 09:26:58 -0500
From: Phil Auld <pauld@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jon Kohler <jon@nutanix.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: hoist ASSERT_EXCLUSIVE_WRITER(p->on_rq) above
 WRITE_ONCE
Message-ID: <20241115142658.GA837020@pauld.westford.csb>
References: <20241114165352.1824956-1-jon@nutanix.com>
 <20241114185755.GG471026@pauld.westford.csb>
 <0C4B7BAD-04EA-4F60-B6D2-A7B2C14E52B7@nutanix.com>
 <20241114192056.GI471026@pauld.westford.csb>
 <20241115095847.GV22801@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115095847.GV22801@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Nov 15, 2024 at 10:58:47AM +0100 Peter Zijlstra wrote:
> On Thu, Nov 14, 2024 at 02:20:56PM -0500, Phil Auld wrote:
> 
> > I don't know. I don't think it matters much since the assert is really
> > independent of the actual write. Like I said it makes sense to have it
> > first to me but others may see it as just moving code around for no strong
> > reason.  Peter may or may not decide to pick this one up. Other "mis-ordered"
> > uses are in code maintained by different folks.
> > 
> > You can see if anyone else weighs in...
> 
> So I'm not entirely about this patch... :-)
>

I'm not entirely either :)


> Per commit b55945c500c5 ("sched: Fix pick_next_task_fair() vs try_to_wake_up() race")
> we can see that this placement is not equivalent.
>

Subtle. That kind of thing (someone else acting on the write) was my
hesitation but I couldn't quite wrap my head around it.

That's why we have other people weigh in ...

Thanks!

> Placing it before the store means that nobody else will store to it
> until you've done your store.
> 
> Placing it after means that nobody else will attempt the store,
> irrespective of the store you just did.

Presumably until some barrier or release at least, right?

I've got to dig into the kcsan stuff a bit more. It looks really
interesting.


Cheers,
Phil

> 
> That is, the ASSERT after the store is a stronger assert.
> 
> In case of activate_task(), we mark the task as on_rq, and this state is
> protected by rq->lock (which we hold), so there must not be any stores
> for as long as we hold that lock. So after is the right place.
> 
> In case of deactivate_task(), this is a hand-off, but the handoff
> doesn't happen until after dequeue_task() and set_task_cpu(). So at this
> point, again, nobody should be modifying it.
> 
> 

-- 


