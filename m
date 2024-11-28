Return-Path: <linux-kernel+bounces-424547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6569DB5AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E20281EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D92157E6B;
	Thu, 28 Nov 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YV6VGZEH"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16418BC3F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789668; cv=none; b=gsau/NWbIG9hn7I0y2gs2kXT5qAhmnLznzwhyiDzmZFpJFbv/FMnEcVir1YIglItf5izTu73dmUpRDp/cWqGJxrssyws77GErSp6y0fE5He9HJCJAWPgI6kQbLhzYGHmrCVy2F1KXj8dHgGWXHXuSEMRhFj/+aB+gA5xab/nM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789668; c=relaxed/simple;
	bh=IX+ABZnxuWg5/5MfYCqMnRYZ3t1nEKWl2xwFirGSMjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYEECyfWB7oqMJv86InKnTxtkihmK5aWIyGhW3kplpVQ/BOIbGh/X8rpJmFGequ7sMGgDTXNkIPaHRSauH/O6S5oRR+Zb5jMWk1L2fC/ENO/H/uSbYFW/Q46ijYBQiXNR/yiF6Nr3haK3TGhQx/Kv0Kd9gG9AWcULANqWD+LLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YV6VGZEH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9wgCZp8GiJSzuDzWak9MVQInwDaP2c2a6zQGgKpAt8c=; b=YV6VGZEHpM2Xj5K/MfVzaSMKUN
	1m9bgwWWSL1VdOrR5SbeovxcFVmC5YOmUPqTA53A5WyAFz+FLR5n4nRCYwTHBUeK9pNU4bD8Y+R9H
	49gg6M98drwx3Yed7On9oKAdOFRsB9DxmqDurZGuFo7aAdDEF3wzQrTcwS9yej9omvGLawLdYW1/4
	E6uUL9OK+eDWYPGzMfonPqlJOhioYjRBMd7604oby7N8Nw5gjS3KSd9Dv091lv/eonWbMlTQK0yki
	yFlkoHhnCUAcosxva/jxkevm2checP8WpKNiUCHc6NsgTIlXfy/lXCHcs4CU8h2TS9QmoST9r0rqC
	jJK7fL9A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGbkM-00000001aQk-2dfW;
	Thu, 28 Nov 2024 10:27:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1C6EC300271; Thu, 28 Nov 2024 11:27:42 +0100 (CET)
Date: Thu, 28 Nov 2024 11:27:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, pauld@redhat.com, efault@gmx.de,
	luis.machado@arm.com
Subject: Re: [PATCH 2/9] sched/fair: Add new cfs_rq.h_nr_enqueued
Message-ID: <20241128102741.GE24400@noisy.programming.kicks-ass.net>
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
 <20241128092750.2541735-3-vincent.guittot@linaro.org>
 <20241128095643.GB24400@noisy.programming.kicks-ass.net>
 <CAKfTPtDKy+Qv63G+o8A4-izJYOExPaa4Z7FAFevBJRaaewbX4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDKy+Qv63G+o8A4-izJYOExPaa4Z7FAFevBJRaaewbX4A@mail.gmail.com>

On Thu, Nov 28, 2024 at 11:24:45AM +0100, Vincent Guittot wrote:
> On Thu, 28 Nov 2024 at 10:56, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Nov 28, 2024 at 10:27:43AM +0100, Vincent Guittot wrote:
> > > With delayed dequeued feature, a sleeping sched_entity remains enqueued
> > > in the rq until its lag has elapsed. As a result, it stays also visible
> > > in the statistics that are used to balance the system and in particular
> > > the field h_nr_running when the sched_entity is associated to a task.
> > >
> > > Create a new h_nr_enqueued that tracks all enqueued tasks and restore the
> > > behavior of h_nr_running i.e. tracking the number of fair tasks that want
> > > to run.
> >
> > Isn't h_nr_enqueued := h_nr_running - h_nr_delayed ? Does it really make
> > sense to have another variable that is so trivially computable?
> 
> I changed h_nr_running to track only running tasks and not delayed dequeue

Yes, that was hidden so well, I couldn't even find it on the second
reading :/

