Return-Path: <linux-kernel+bounces-559091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04738A5EF70
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFB01897D81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34209263F36;
	Thu, 13 Mar 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c5Kbhe6s"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E722C80
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857675; cv=none; b=XfQrkooI7jdmhmuUQsA4jDBQptkWPyJMRIP90C84WV7SZQggZmXwtg3kzouMDgHkOcwCcE+sw8uu/EWTZQCdwLv2MLFBd3m0MJhifNwNz9r+MfSfgLhpGjuO+e06bMoGuJ8+u9rwDm1WGKYNQLiztfMEkA9oiKiQkGcXo6ZRSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857675; c=relaxed/simple;
	bh=jYelqFqrz8yWDeGxZPC7eFPF6Li8AI+xraD4fW4VbUc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxIjmLLPbeo9wC4zBXULu8NCWjmdR3LfNmnzXvkiSXetY9HrG86BobISB7ANxMgcp+iAN10CbLkkXxXmQgOLGm6NBbUnAUmUt1ifvpIKUUGhbKZsYrH+MWOXGB8H/pJ+7yVjU8lQdLInD38QwGxP9cCQe36qfiTWATsM47kmhnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=c5Kbhe6s; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741857673; x=1773393673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V79qnuZr00/9Cxbf7zsTxIJStpQ+zna9/iQ2fmQuMaE=;
  b=c5Kbhe6spb/YEPZ5zid0envxY5XyJX9x06CGU+CPHjTMXlDBMm0cCt4h
   DbEMXMqd/WtEoAeaUAgMvTXjq3iOW3regh964MSEj3vqt7VOayzPZ6+6l
   g/iKXWql0RmldyfjOvq0QXkFqtvXyR4pgonIIJsOf4ucglvgBDDlHw1Fb
   0=;
X-IronPort-AV: E=Sophos;i="6.14,244,1736812800"; 
   d="scan'208";a="480050407"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:21:10 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:51423]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.251:2525] with esmtp (Farcaster)
 id 75c96dbf-4db0-43df-aa48-4d3835685f6f; Thu, 13 Mar 2025 09:21:09 +0000 (UTC)
X-Farcaster-Flow-ID: 75c96dbf-4db0-43df-aa48-4d3835685f6f
Received: from EX19D018EUA001.ant.amazon.com (10.252.50.145) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 09:21:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D018EUA001.ant.amazon.com (10.252.50.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 09:21:08 +0000
Received: from email-imr-corp-prod-iad-all-1b-8410187a.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 09:21:08 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-iad-all-1b-8410187a.us-east-1.amazon.com (Postfix) with ESMTP id D5E184040D;
	Thu, 13 Mar 2025 09:21:07 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 94B7420DE2; Thu, 13 Mar 2025 09:21:07 +0000 (UTC)
Date: Thu, 13 Mar 2025 09:21:07 +0000
From: Hagar Hemdan <hagarhem@amazon.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<wuchi.zero@gmail.com>, <abuehaze@amazon.com>
Subject: Re: [PATCH] /sched/core: Fix Unixbench spawn test regression
Message-ID: <20250313092107.GA30527@amazon.com>
References: <20250306162635.2614376-1-dietmar.eggemann@arm.com>
 <CAKfTPtCfd_=gm7rsT_qBL8pw5uybEvYH4N2tvxpKndxxi4L7oA@mail.gmail.com>
 <8ddd7bb2-3a18-48b5-85c6-23263134308a@arm.com>
 <CAKfTPtD9DwWquFN6G8BXAii7HH5zJeEXiUjE8ma-eHdEqeHzdw@mail.gmail.com>
 <51d24e59-247d-4b66-9ddb-4b9f0f53497b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <51d24e59-247d-4b66-9ddb-4b9f0f53497b@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Mar 12, 2025 at 03:41:40PM +0100, Dietmar Eggemann wrote:
> On 11/03/2025 17:35, Vincent Guittot wrote:
> > On Mon, 10 Mar 2025 at 16:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 10/03/2025 14:59, Vincent Guittot wrote:
> >>> On Thu, 6 Mar 2025 at 17:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>>>
> >>>> Hagar reported a 30% drop in UnixBench spawn test with commit
> >>>> eff6c8ce8d4d ("sched/core: Reduce cost of sched_move_task when config
> >>>> autogroup") on a m6g.xlarge AWS EC2 instance with 4 vCPUs and 16 GiB RAM
> >>>> (aarch64) (single level MC sched domain) [1].
> >>>>
> >>>> There is an early bail from sched_move_task() if p->sched_task_group is
> >>>> equal to p's 'cpu cgroup' (sched_get_task_group()). E.g. both are
> >>>> pointing to taskgroup '/user.slice/user-1000.slice/session-1.scope'
> >>>> (Ubuntu '22.04.5 LTS').
> >>>
> >>> Isn't this same use case that has been used by commit eff6c8ce8d4d to
> >>> show the benefit of adding the test if ((group ==
> >>> tsk->sched_task_group) ?
> >>> Adding Wuchi who added the condition
> >>
> >> IMHO, UnixBench spawn reports a performance number according to how many
> >> tasks could be spawned whereas, IIUC, commit eff6c8ce8d4d was reporting
> >> the time spend in sched_move_task().
> > 
> > But does not your patch revert the benefits shown in the figures of
> > commit eff6c8ce8d4d ? It skipped sched_move task in do_exit autogroup
> > and you adds it back
> 
> Yeah, we do need the PELT update in sched_change_group()
> (task_change_group_fair()) in the do_exit() path to get the 30% score
> back in 'UnixBench spawn'. Even that means we need more time due to this
> in sched_move_task().
> 
> I retested this and it turns out that 'group == tsk->sched_task_group'
> is only true when sched_move_task() is called from exit.
> 
> So to get the score back for 'UnixBench spawn' we should rather revert
> commit eff6c8ce8d4d.
> 
> The analysis in my patch still holds though.
> 
> If you guys agree I can send the revert with my analysis in the
> patch-header.
Agree. The follow up commit fa614b4feb5a ("sched: Simplify sched_move_task()")
needs to be reverted as well.

