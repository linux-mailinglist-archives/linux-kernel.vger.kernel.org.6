Return-Path: <linux-kernel+bounces-529292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB0A422A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E34919C0913
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55544158536;
	Mon, 24 Feb 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaaiMdOZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63AE14375C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406223; cv=none; b=cRgNyD1LOss6+riYCNjvwHr19ztsyad5uLf+c4pAG4u5fXl/BM2V7/wljqR3PWo7cdaVfUQ8iDu16mUSUPVAObKUiTuLJnH4xtojV8mB+ZN96MXIrsHw4ZKjNuITDTFric3ASAjqIk73WUpNd+KE1lvcOHqWqfi3UfzaPjlpqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406223; c=relaxed/simple;
	bh=Pr7M3BpsldyMW6sp1ypmLtcZxdYyDsUFf0yLZxT+Bc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abHUJvtVAOvImV/HIl+7E8XNODtQ0VdEGPqzbst3W4nDEPePiIn63jMY2UAvTLvmWRCgu1iR6HNzGUIPmVktKVY/ezRtJ0Pkcu7wU/Emujpjyo7upVAOD8zgaXCMelPnRMBU1JrPBkoYLdO/jnEfESMlEyiSchc2LU9MCTBcY9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaaiMdOZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740406220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjyqthWaVvSiwoRGKbEHsF+wRZ17I9y55oJpYMbUUz4=;
	b=VaaiMdOZ2pYMxy6RT+IpA7r8lGX85jlmvNvByvSCR1CUAMKAcSmPvG5U+Nc25Ha7W1O05b
	lnOlXMQyELZ96ff+6sRxPJkbrnaKdE5ChtAfsfNVynZK5hAtURAjfX3HrbdyGwLXh3V/R/
	2hD6QA7WXwJ8AmdtkXKB3SpytjaDbkw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-oV9-IF7EOCW0x4Ke-hbeiA-1; Mon,
 24 Feb 2025 09:10:19 -0500
X-MC-Unique: oV9-IF7EOCW0x4Ke-hbeiA-1
X-Mimecast-MFC-AGG-ID: oV9-IF7EOCW0x4Ke-hbeiA_1740406218
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 645F21800874;
	Mon, 24 Feb 2025 14:10:17 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.65.57])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B34B1800352;
	Mon, 24 Feb 2025 14:10:14 +0000 (UTC)
Date: Mon, 24 Feb 2025 09:10:12 -0500
From: Phil Auld <pauld@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 2/2] sched/fair: Fix premature check of
 WAKEUP_PREEMPTION
Message-ID: <20250224141012.GB145991@pauld.westford.csb>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-3-wuyun.abel@bytedance.com>
 <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
 <6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com>
 <e1cfabab-1326-4cd8-a8a4-4b3fc4c1f7ec@linux.ibm.com>
 <9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com>
 <d1237acd-9e3c-4ab9-8628-31d98fcf7638@linux.ibm.com>
 <83f8b833-af79-4d77-a179-5065aec994dc@bytedance.com>
 <CAKfTPtBL4aPbEDOa8jJ+h2wQ9CLU80=0mQdrc07vfqBVswzAsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBL4aPbEDOa8jJ+h2wQ9CLU80=0mQdrc07vfqBVswzAsg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 24, 2025 at 02:47:13PM +0100 Vincent Guittot wrote:
> On Sun, 23 Feb 2025 at 12:22, Abel Wu <wuyun.abel@bytedance.com> wrote:
> >
> > On 2/23/25 6:25 PM, Madadi Vineeth Reddy Wrote:
> > > On 23/02/25 14:14, Abel Wu wrote:
> > >> Hi Madadi,
> > >>
> > >> On 2/23/25 2:16 AM, Madadi Vineeth Reddy Wrote:
> > >>> On 21/02/25 21:27, Abel Wu wrote:
> > >>>> On 2/21/25 7:49 PM, Vincent Guittot Wrote:
> > >>>>> On Fri, 21 Feb 2025 at 12:12, Abel Wu <wuyun.abel@bytedance.com> wrote:
> > >>>>>>
> > >>>>>> Idle tasks are by definition preempted by non-idle tasks whether feat
> > >>>>>> WAKEUP_PREEMPTION is enabled or not. This isn't true any longer since
> > >>>>>
> > >>>>> I don't think it's true, only "sched_idle never preempts others" is
> > >>>>> always true but sched_feat(WAKEUP_PREEMPTION) is mainly there for
> > >>>>> debug purpose so if WAKEUP_PREEMPTION is false then nobody preempts
> > >>>>> others at wakeup, idle, batch or normal
> > >>>>
> > >>>> Hi Vincent, thanks for your comment!
> > >>>>
> > >>>> The SCHED_IDLE "definition" of being preempted by non-idle tasks comes
> > >>>> from commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
> > >>>> which said:
> > >>>>
> > >>>>       - no SCHED_IDLE buddies
> > >>>>       - never let SCHED_IDLE preempt on wakeup
> > >>>>       - always preempt SCHED_IDLE on wakeup
> > >>>>       - limit SLEEPER fairness for SCHED_IDLE
> > >>>>
> > >>>> and that commit let it be preempted before checking WAKEUP_PREEMPTION.
> > >>>> The rules were introduced in 2009, and to the best of my knowledge there
> > >>>> seemed no behavior change ever since. Please correct me if I missed
> > >>>> anything.
> > >>>
> > >>> As Vincent mentioned, WAKEUP_PREEMPTION is primarily for debugging. Maybe
> > >>> it would help to document that SCHED_IDLE tasks are not preempted by non-idle
> > >>> tasks when WAKEUP_PREEMPTION is disabled. Otherwise, the intent of having no
> > >>> preemptions for debugging would be lost.
> > >>>
> > >>> Thoughts?
> > >>
> > >> I am not sure I really understand the purpose of this debug feature.
> > >> If it wants to provide a way to check whether a performance degrade of
> > >> certain workload is due to overscheduling or not, then do we really
> > >> care about performance of SCHED_IDLE workloads and why?
> > >
> > > It's true that we may not be too concerned about performance with
> > > SCHED_IDLE. The issue is preserve the original SCHED_IDLE definition
> > > versus WAKEUP_PREEMPTION, which applies across all policies. Since by
> >
> > Yes, exactly.
> >
> > > default the feature is true. I am not sure. Either way seems ok to me.
> >
> > Hi Vincent,
> >
> > Since Peter gave the priority to SCHED_IDLE semantics over WAKEUP_PREEMPTION
> > in his commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation"),
> > and the choice is kept unchanged for quite a long time until the recent merged
> > commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
> > which seemed not intend to change it, shall we restore the choice for now and
> > leave the discussion of the scope of WAKEUP_PREEMPTION to the future once any
> > usecase shows up?
> 
> Or we should just remove it. I'm curious to know who used it during
> the last couple of years ? Having in mind that lazy preemption adds
> another level as check_preempt_wakeup_fair()  uses it so sched-idle
> tasks might not always be immediately preempted anyway.
> 

It can be helpful to be able to turn that off when chasing performance
issues. See the DELAY_DEQUEUE thread from a few months back. In that
case we never got to a good answer, but did use NO_WAKEUP_PREEMPTION
during debugging to take out some variables at least. FWIW.


Cheers,
Phil

> 
> >
> > Thanks,
> >         Abel
> >
> 

-- 


