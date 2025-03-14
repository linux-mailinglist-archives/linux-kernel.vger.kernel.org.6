Return-Path: <linux-kernel+bounces-561783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D39A61622
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5EB1896640
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F7202C2F;
	Fri, 14 Mar 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A5PoB90+"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF812B63
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969243; cv=none; b=eZQ4fVIMhy3wmOy7GD61lxgzH3LyGMEQmB1AFquQ1B5Be56e7ujGTdODNE/UJghOVmxvsWOtxO9z8mJY68GzgNtUcWDkKw0/GFPFeyxmxp9g1Zs+ofE3DsZOQ0xYlDrd/DsKyKxQK7gzAxlNfhy76S4Fm8r+nh3EY9x5v4OHkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969243; c=relaxed/simple;
	bh=BFUxfHYOirha3wOpCDfl3B2AssuomRUC6LFUGF27+n4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEoAH3S5jMB1aMbtZIH9Vmr2XktoIFy1SNJhkGVxGSy5xcrkOKSeSfigrCIcuyhFRTzI5CsnQPEobbQFQYCBTaeekxPaQMvMdZAAxwTIKK4fszp8cTCo02tN1uIvnNR5R8YTYnxCVdLBBFPkJ7YDkE1EvZsdpTLIKFMMgjzI7aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=A5PoB90+; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741969243; x=1773505243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7zSE4Jvtn1kS4+S28dT2UG9L2a68CG1TsxHWVtOdl+Q=;
  b=A5PoB90+6x0DvSXgNQz9kT6bMG0LiHuZJzQfYHYZen2ta6YRYEu+i29x
   tO7ViRnXzgkvzS3suDCofA49j9lU7jicjQgKYzLMi5tEb/vZahGa1juQJ
   6cGAPaGI35FnaTKwtt0582zQmJ0lMUqnUgWkGHlcDVbhfsL0CUiGc+o8+
   w=;
X-IronPort-AV: E=Sophos;i="6.14,246,1736812800"; 
   d="scan'208";a="705105855"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 16:20:40 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:26835]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.188:2525] with esmtp (Farcaster)
 id 07347110-700c-41dd-b006-b6775573174e; Fri, 14 Mar 2025 16:20:38 +0000 (UTC)
X-Farcaster-Flow-ID: 07347110-700c-41dd-b006-b6775573174e
Received: from EX19D018EUC004.ant.amazon.com (10.252.51.172) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 16:20:36 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D018EUC004.ant.amazon.com (10.252.51.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 16:20:36 +0000
Received: from email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 16:20:36 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com (Postfix) with ESMTP id 4B995A064F;
	Fri, 14 Mar 2025 16:20:35 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id D27FA20DD4; Fri, 14 Mar 2025 16:20:34 +0000 (UTC)
Date: Fri, 14 Mar 2025 16:20:34 +0000
From: Hagar Hemdan <hagarhem@amazon.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<wuchi.zero@gmail.com>, <abuehaze@amazon.com>, <hagarhem@amazon.com>
Subject: Re: [PATCH] /sched/core: Fix Unixbench spawn test regression
Message-ID: <20250314162034.GA12958@amazon.com>
References: <20250306162635.2614376-1-dietmar.eggemann@arm.com>
 <CAKfTPtCfd_=gm7rsT_qBL8pw5uybEvYH4N2tvxpKndxxi4L7oA@mail.gmail.com>
 <8ddd7bb2-3a18-48b5-85c6-23263134308a@arm.com>
 <CAKfTPtD9DwWquFN6G8BXAii7HH5zJeEXiUjE8ma-eHdEqeHzdw@mail.gmail.com>
 <51d24e59-247d-4b66-9ddb-4b9f0f53497b@arm.com>
 <20250313092107.GA30527@amazon.com>
 <CAKfTPtBixgju0YX=TLbOWO4s9uHNBMSmnV=xcVBJVfU1wqrM4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtBixgju0YX=TLbOWO4s9uHNBMSmnV=xcVBJVfU1wqrM4Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Mar 14, 2025 at 05:06:50PM +0100, Vincent Guittot wrote:
> On Thu, 13 Mar 2025 at 10:21, Hagar Hemdan <hagarhem@amazon.com> wrote:
> >
> > On Wed, Mar 12, 2025 at 03:41:40PM +0100, Dietmar Eggemann wrote:
> > > On 11/03/2025 17:35, Vincent Guittot wrote:
> > > > On Mon, 10 Mar 2025 at 16:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > > >>
> > > >> On 10/03/2025 14:59, Vincent Guittot wrote:
> > > >>> On Thu, 6 Mar 2025 at 17:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > > >>>>
> > > >>>> Hagar reported a 30% drop in UnixBench spawn test with commit
> > > >>>> eff6c8ce8d4d ("sched/core: Reduce cost of sched_move_task when config
> > > >>>> autogroup") on a m6g.xlarge AWS EC2 instance with 4 vCPUs and 16 GiB RAM
> > > >>>> (aarch64) (single level MC sched domain) [1].
> > > >>>>
> > > >>>> There is an early bail from sched_move_task() if p->sched_task_group is
> > > >>>> equal to p's 'cpu cgroup' (sched_get_task_group()). E.g. both are
> > > >>>> pointing to taskgroup '/user.slice/user-1000.slice/session-1.scope'
> > > >>>> (Ubuntu '22.04.5 LTS').
> > > >>>
> > > >>> Isn't this same use case that has been used by commit eff6c8ce8d4d to
> > > >>> show the benefit of adding the test if ((group ==
> > > >>> tsk->sched_task_group) ?
> > > >>> Adding Wuchi who added the condition
> > > >>
> > > >> IMHO, UnixBench spawn reports a performance number according to how many
> > > >> tasks could be spawned whereas, IIUC, commit eff6c8ce8d4d was reporting
> > > >> the time spend in sched_move_task().
> > > >
> > > > But does not your patch revert the benefits shown in the figures of
> > > > commit eff6c8ce8d4d ? It skipped sched_move task in do_exit autogroup
> > > > and you adds it back
> > >
> > > Yeah, we do need the PELT update in sched_change_group()
> > > (task_change_group_fair()) in the do_exit() path to get the 30% score
> > > back in 'UnixBench spawn'. Even that means we need more time due to this
> > > in sched_move_task().
> > >
> > > I retested this and it turns out that 'group == tsk->sched_task_group'
> > > is only true when sched_move_task() is called from exit.
> > >
> > > So to get the score back for 'UnixBench spawn' we should rather revert
> > > commit eff6c8ce8d4d.
> > >
> > > The analysis in my patch still holds though.
> > >
> > > If you guys agree I can send the revert with my analysis in the
> > > patch-header.
> > Agree. The follow up commit fa614b4feb5a ("sched: Simplify sched_move_task()")
> > needs to be reverted as well.
> 
> Why do you think it should be reverted as well ?

I meant the revert of eff6c8ce8d4d7 requires fa614b4feb5a to be
reverted first. Dietmar has already done this in his revert 
https://lore.kernel.org/all/20250314151345.275739-1-dietmar.eggemann@arm.com/,
so it's all good now.

