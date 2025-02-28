Return-Path: <linux-kernel+bounces-539282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240B3A4A2D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2586816BC6E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90E1F874A;
	Fri, 28 Feb 2025 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FE7toQsd"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B81C175A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740771592; cv=none; b=txgfLMY3mltBk56yDahNNe415CKIZfCH21PctD7NX2/B0d7WEp04TbPqiAvgekmJBAt04iDRT8idIFt6k2rW6TBGxr/+r/Hk+V9F5uvDO3P5duZe1O9hVJRHH4O9UU+wo4bxkGuj77Pjsl4h93JWj67tu3epGQlmMwDME/KiiyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740771592; c=relaxed/simple;
	bh=/UOfKmwze99xzzl7zkwBAY4COUU/jORm9gDBLqX4KCQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGLxURS+sRurXYGndTv1sNJFlnB4UxPe3o+yM74hpXU3jiIHgTAJJhxVyCLiMhPJuu/CP07GJtrk2iNyMgJB1pkBSX0ioCoq/ByjN1zaFReFi/n2PGsfp2q2X469Ow5qDgx2DnBNxcVlGcrArGz1jOzDBzaDJf3Zp177p95/U20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FE7toQsd; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740771591; x=1772307591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MtE8zDeXqGZh/CNdabRmggId/ji0IhYytrzHnmuWt94=;
  b=FE7toQsdO+0Eq91sTjUEWX90wWJHeTOAaW4Dgmn5Ra3saoQ9vzRFStMN
   YYIxn/Kbaz8ODlwSKlxRACBOJ/ARInKCvxi7irRZkcuSgvWjcjYzrlkMC
   d6XqXTiWHxXglZ2RDLgwsN8PFiS5xnJHY7wIpSqSj6t6wKbWZDU4Na7Nw
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,323,1732579200"; 
   d="scan'208";a="701164283"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 19:39:48 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:45939]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.142:2525] with esmtp (Farcaster)
 id b76f4039-460d-4c89-a5ae-3ec57c061ea3; Fri, 28 Feb 2025 19:39:46 +0000 (UTC)
X-Farcaster-Flow-ID: b76f4039-460d-4c89-a5ae-3ec57c061ea3
Received: from EX19D018EUC004.ant.amazon.com (10.252.51.172) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 19:39:46 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D018EUC004.ant.amazon.com (10.252.51.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 19:39:46 +0000
Received: from email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 19:39:45 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com (Postfix) with ESMTP id A0F8C404C8;
	Fri, 28 Feb 2025 19:39:45 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 5E0E920D90; Fri, 28 Feb 2025 19:39:45 +0000 (UTC)
Date: Fri, 28 Feb 2025 19:39:45 +0000
From: Hagar Hemdan <hagarhem@amazon.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: <abuehaze@amazon.com>, <linux-kernel@vger.kernel.org>,
	<hagarhem@amazon.com>, <wuchi.zero@gmail.com>
Subject: Re: BUG Report: Fork benchmark drop by 30% on aarch64
Message-ID: <20250228193945.GA13237@amazon.com>
References: <20250205151026.13061-1-hagarhem@amazon.com>
 <4a9cc5ab-c538-4427-8a7c-99cb317a283f@arm.com>
 <20250207110754.GA10452@amazon.com>
 <1ca758c7-b6ab-4880-9cc7-217093a30bbb@arm.com>
 <20250210213155.GA649@amazon.com>
 <4b48fd24-6cd5-474c-bed8-3faac096fd58@arm.com>
 <20250211214019.GA15530@amazon.com>
 <75503128-c898-4da7-ab99-55f4ef6e2add@arm.com>
 <5f92761b-c7d4-4b96-9398-183a5bf7556a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f92761b-c7d4-4b96-9398-183a5bf7556a@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Feb 17, 2025 at 11:51:45PM +0100, Dietmar Eggemann wrote:
> On 13/02/2025 19:55, Dietmar Eggemann wrote:
> > On 11/02/2025 22:40, Hagar Hemdan wrote:
> >> On Tue, Feb 11, 2025 at 05:27:47PM +0100, Dietmar Eggemann wrote:
> >>> On 10/02/2025 22:31, Hagar Hemdan wrote:
> >>>> On Mon, Feb 10, 2025 at 11:38:51AM +0100, Dietmar Eggemann wrote:
> >>>>> On 07/02/2025 12:07, Hagar Hemdan wrote:
> >>>>>> On Fri, Feb 07, 2025 at 10:14:54AM +0100, Dietmar Eggemann wrote:
> >>>>>>> Hi Hagar,
> >>>>>>>
> >>>>>>> On 05/02/2025 16:10, Hagar Hemdan wrote:
> >>>
> >>> [...]
> >>>
> >>>>> The 'spawn' tasks in sched_move_task() are 'running' and 'queued' so we
> >>>>> call dequeue_task(), put_prev_task(), enqueue_task() and
> >>>>> set_next_task().
> >>>>>
> >>>>> I guess what we need here is the cfs_rq->avg.load_avg (cpu_load() in
> >>>>> case of root tg) update in:
> >>>>>
> >>>>>   task_change_group_fair() -> detach_task_cfs_rq() -> ...,
> >>>>>   attach_task_cfs_rq() -> ...
> >>>>>
> >>>>> since this is used for WF_FORK, WF_EXEC handling in wakeup:
> >>>>>
> >>>>>   select_task_rq_fair() -> sched_balance_find_dst_cpu() ->
> >>>>>   sched_balance_find_dst_group_cpu()
> >>>>>
> >>>>> in form of 'least_loaded_cpu' and 'load = cpu_load(cpu_rq(i)'.
> >>>>>
> >>>>> You mentioned AutoGroups (AG). I don't see this issue on my Debian 12
> >>>>> Juno-r0 Arm64 board. When I run w/ AG, 'group' is '/' and
> >>>>> 'tsk->sched_task_group' is '/autogroup-x' so the condition 'if (group ==
> >>>>> tsk->sched_task_group)' isn't true in sched_move_task(). If I disable AG
> >>>>> then they match "/" == "/".
> >>>>>
> >>>>> I assume you run Ubuntu on your AWS instances? What kind of
> >>>>> 'cgroup/taskgroup' related setup are you using?
> >>>>
> >>>> I'm running AL2023 and use Vanilla kernel 6.13.1 on m6g.xlarge AWS instance.
> >>>> AL2023 uses cgroupv2 by default.
> >>>>>
> >>>>> Can you run w/ this debug snippet w/ and w/o AG enabled?
> >>>>
> >>>> I have run that and have attached the trace files to this email.
> >>>
> >>> Thanks!
> >>>
> >>> So w/ AG you see that 'group' and 'tsk->sched_task_group' are both
> >>> '/user.slice/user-1000.slice/session-1.scope' so we bail for those tasks
> >>> w/o doing the 'cfs_rq->avg.load_avg' update I described above.
> >>
> >> yes, both groups are identical so it returns from sched_move_task()
> >> without {de|en}queue and without call task_change_group_fair().
> > 
> > OK.
> > 
> >>> You said that there is no issue w/o AG. 
> >>
> >> To clarify, I meant by there's no regression when autogroup is disabled,
> >> that the fork results w/o AG remain consistent with or without the commit 
> >> "sched/core: Reduce cost of sched_move_task when config autogroup". However,
> >> the fork results are consistently lower when AG disabled compared to when
> >> it's enabled (without commit applied). This is illustrated in the tables
> >> provided in the report.
> > 
> > OK, but I don't quite get yet why w/o AG the results are lower even w/o
> > eff6c8ce8d4d? Have to dig further I guess. Maybe there is more than this
> > p->se.avg.load_avg update when we go via task_change_group_fair()?
> 
> './Run -c 4 spawn' on AWS instance (m7gd.16xlarge) with v6.13, 'mem=16G
> maxcpus=4 nr_cpus=4' and Ubuntu '22.04.5 LTS':
> 
> CFG_SCHED_AUTOGROUP | sched_ag_enabled | eff6c8ce8d4d | Fork (lps)
> 
>    	y	             1		   y            21005 (27120 **)
> 	y		     0		   y            21059 (27012 **)
> 	n		     -		   y            21299
> 	y		     1		   n	        27745 *
> 	y		     0		   n	        27493 *
> 	n		     -		   n	        20928
> 
> (*) So here the higher numbers are only achieved when
> 'sched_autogroup_exit_task() -> sched_move_task() ->
> sched_change_group() is called for the 'spawn' tasks.
> 
> (**) When I apply the fix from
> https://lkml.kernel.org/r/4a9cc5ab-c538-4427-8a7c-99cb317a283f@arm.com.

This is currently impacting our kernel, do you
have any concerns to submit this fix upstream?
Thanks,
Hagar
> 
> These results support the story that we need:
> 
>   task_change_group_fair() -> detach_task_cfs_rq() -> ...,
>   attach_task_cfs_rq() -> ...
> 
> i.e. the related 'cfs_rq->avg.load_avg' update during do_exit() so that
> WF_FORK handling in wakeup:
> 
>   select_task_rq_fair() -> sched_balance_find_dst_cpu() ->
>   sched_balance_find_dst_group_cpu()
> 
> can use more recent 'load = cpu_load(cpu_rq(i)' values to get a better
> 'least_loaded_cpu'.
> 
> The AWS instance runs systemd so shell and test run in a taskgroup other
> than root which trumps autogroups:
> 
>   task_wants_autogroup()
> 
>      if (tg != &root_task_group)
>        return false;
> 
>      ...
> 
> That's why 'group == tsk->sched_task_group' in sched_move_task() is
> true, which is different on my Juno: the shell from which I launch the
> tests runs in '/' so that the test ends up in an autogroup, i.e. 'group
> != tsk->sched_task_group'.
> 
> [...]

