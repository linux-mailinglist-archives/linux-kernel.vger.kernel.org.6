Return-Path: <linux-kernel+bounces-277750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7061494A5C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEDE1F232FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E164F1DD3B3;
	Wed,  7 Aug 2024 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MSKJY/J4"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8991DD3B7
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027160; cv=none; b=kENRiRUxudW2mFBSIkasgaZQkQya8UXMHWbB9Dz5FNg4J4RGc7jYKV8OfsV2I61HJwXObdnoTENQovDf9atZfJt+H6c62sNv0FWTacpTf5bobKfkoxHAERROTHfTMAJsm3TG0mrLXu8ds4AMlO4c7ZCOIJWsgQWjQoexMDDj7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027160; c=relaxed/simple;
	bh=ZKitO714lu9CKNW4DLq2oKxNA9CXFV/1xGHNdbkyfBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHjYEkCWlHlU/p18t9vcnO5m6H2+2mus57aEohfcLqJxffysi89yH5seFd8VEyPdIRkkeXzPtrp0ehS3ejS+g7XEFESpF0R8wDlfT0wFmk7T+x6Lba/GneEYsOXWg4k9a6oxoRWLZMLn/F6FbQEMAovE4egWG6ph3cAlmcDlkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MSKJY/J4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SUCekAmG9HzEGJjlLQM1iQQQrs2gzu8lpz8xzqLGNiM=; b=MSKJY/J4dDdsGS2EwjC6t/zEXa
	SeehV8ff6jFgge9McGDZpzwLuDanf7w2LXRl4IlSw/KiJ7Vmf5eaGN1lRyc9IimmtOovgDeocKWO8
	ixFrIm7r/QR+dLRKzx13TGMgGzDStXUXP47Xjsl47I4V4b7Ghpt3P7oYMzi6M8rAi6ukw2NUspe9w
	T8SCIna2vd/OgP6ml6PSb2LKs3kOg1pIYk0HWopoWGewvirjsRU9DngAeRVMAbkQNNYM77n05op+G
	+RXn3yy6mSgr4if9ZqACRgbfv4I7U8AWEljxoYx16sIkXjMeQLZ8sWq4j4Jivm09ZqR/oYaT+sElP
	ka2QdLBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbe4N-00000006bd7-3Zyn;
	Wed, 07 Aug 2024 10:39:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7915230033D; Wed,  7 Aug 2024 12:39:02 +0200 (CEST)
Date: Wed, 7 Aug 2024 12:39:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] sched/fair: avoid integer overflow warning for
 fair_server_period_max;
Message-ID: <20240807103902.GU39708@noisy.programming.kicks-ass.net>
References: <20240807080032.2302853-1-arnd@kernel.org>
 <CAKfTPtDs-Y5_puGU2QYd_NatB7RQzgGQPuwfaCWXrq_8Vqw2dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDs-Y5_puGU2QYd_NatB7RQzgGQPuwfaCWXrq_8Vqw2dw@mail.gmail.com>

On Wed, Aug 07, 2024 at 12:00:35PM +0200, Vincent Guittot wrote:
> Hi Arnd
> 
> On Wed, 7 Aug 2024 at 10:00, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The clalculation of fair_server_period_max includes an integer overflow:
> >
> > In file included from kernel/sched/build_utility.c:72:
> > kernel/sched/debug.c:341:57: error: integer overflow in expression of type 'long int' results in '-100663296' [-Werror=overflow]
> >   341 | static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
> >
> > Avoids this by using an unsigned constant to start with.
> 
> Dan sent something similar
> https://lore.kernel.org/lkml/a936b991-e464-4bdf-94ab-08e25d364986@stanley.mountain/

Right, tglx also pointed me at a report for this. Let me go queue Dan's
patch.

> >
> > Fixes: d741f297bcea ("sched/fair: Fair server interface")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  kernel/sched/debug.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index 0148bc65d39c..242e7f264a0b 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -338,7 +338,7 @@ enum dl_param {
> >         DL_PERIOD,
> >  };
> >
> > -static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
> > +static unsigned long fair_server_period_max = (1u << 22) * NSEC_PER_USEC; /* ~4 seconds */
> >  static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
> >
> >  static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
> > --
> > 2.39.2
> >

