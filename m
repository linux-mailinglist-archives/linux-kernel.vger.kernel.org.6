Return-Path: <linux-kernel+bounces-359210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AAA9988C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D901F25753
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C301CB510;
	Thu, 10 Oct 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YvmR5ZxO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055F1CB323
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569133; cv=none; b=GBATCKSKar8CbmNACzk58UQoekCiK3VbHtoTAW+Y412EimhY+QTiTHkwgbTJ1e6JoPZkqhviXAFXJnOLcMJpzpw9TVGLTn55BcRjETMI+HnMBx85h8ity7x2RIldkF6OSghHtyjhGHlUHPvcBIjCxZ1OSDlxbxy07gSu/HdnySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569133; c=relaxed/simple;
	bh=6/RpoWFIVzdGO1ZXmdL4ihrgrieD31/pgww4ZZRgVvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlBlte/5/Nvc3TRMct6ggSTu9oWKQrZfAeM+amaIQK/9/jYVaU6F2aqYmRG0UdVOdXy1Fi7bp5Zkbep0WXJC2/Gvckve54jaVcmgx8pnF+zc0dgrOz1fnsPu8Vvh8t3YzfFWk7cBv2tejfxapehTOg5oJILzwmo8wyuvTtp26o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YvmR5ZxO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z3LxugzGjm3ua3Lyz81PyPiPu9NIfx6+I5T5xWD5HFs=; b=YvmR5ZxO6gEyjrgn69d090F0sn
	l8dfclwqyhB7EpxED3CjEwQyjVd1ekWmIyXG4sfqvHxJS3GhTGEU9pu/jB0ISNpgzh1zbrYyUOaxV
	04RztPoS3Ni0qgzaIldJrpsCdFecd6sbccHjZ1grDzrEYtEcHi4OOjCf2dQbU3wVzUDRWbaK8UpRo
	xCUY95Ref95HXuKczQjgfbChFRyZSFRRWlC7Xp1wwsKQ7ud88+8FOlMEa1oPQJMgkwQKdp7WVfdDL
	EJpKTx6pf90IHIlMUq96VKXmZ7W7gblnPbaHl8G8LZOZP4rZHnFrAvNdRWnuO+n9wVF4UX5QMFRvU
	gJcR70XQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sytn0-00000007mCp-49oN;
	Thu, 10 Oct 2024 14:05:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D957230088D; Thu, 10 Oct 2024 16:05:14 +0200 (CEST)
Date: Thu, 10 Oct 2024 16:05:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [RESEND x3][PATCH v12 2/7] locking/mutex: Make mutex::wait_lock
 irq safe
Message-ID: <20241010140514.GJ17263@noisy.programming.kicks-ass.net>
References: <20241009235352.1614323-1-jstultz@google.com>
 <20241009235352.1614323-3-jstultz@google.com>
 <20241010100045.321ca4de@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010100045.321ca4de@gandalf.local.home>

On Thu, Oct 10, 2024 at 10:00:45AM -0400, Steven Rostedt wrote:
> On Wed,  9 Oct 2024 16:53:35 -0700
> John Stultz <jstultz@google.com> wrote:
> 
> > From: Juri Lelli <juri.lelli@redhat.com>
> > 
> > mutex::wait_lock might be nested under rq->lock.
> > 
> > Make it irq safe then.
> 
> Can you expand on this please?
> 
> If the mutex:wait_lock might be taken under an rq->lock, doesn't that mean
> a mutex was taken under rq->lock? Or is it something internal?

Very similar to what we do for rt_mutex during PI; we'll want to look at
mutex_owner during the block chain walk, and holding wait_lock ensures
objects persistence.


