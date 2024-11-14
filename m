Return-Path: <linux-kernel+bounces-409207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8169C88E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291001F22A72
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D3B1F8EF8;
	Thu, 14 Nov 2024 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcRA3IYU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B6192D9D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583749; cv=none; b=cO0bR4e5Ok1yGpxH5aPKrY9ukG/cW3fxxnay5NnVMbn+/QHIkYpABB094/9nqm96kJbiiQxYHatgwUzMg0TQKCdFmfQ5sX8Rh9tSeO1RphY6nWn0OJQFP/DEVeoXpKl8/Txbu0pDrarfmUCFeyVBq4oiPvHIb7PiMck660iB8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583749; c=relaxed/simple;
	bh=F29QDUHQhUOOHhy0Wso9d2I6XGuPm/CmKdobtDcaDIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1ta3tIhkOxZk28RdxAC3ACckn+GinP+h9ta9b4ADbQHS/b/JgSC40Xb+2HyV9Hl+l5kwL4pmzhd87wyEUUf7DV5+LNAPecQw3w3sIbQ6JK+2IYvr1vhnZwkxXdNR+ylIq/ApxVfb2qzvIfkp5IQl1c9kMLqL1hgoiJEF+sYwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcRA3IYU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731583746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9pOT17k5yWZUArzCUqdxEOfNlu7sSoAqFGS7LBHDck=;
	b=bcRA3IYUojzSRxm/dfhYZmYiEDH6sci5bC4wpGd+C+o01hJ5H6URTMvg0mkI8CJU5uvmq4
	Tt8Ub4Z2SgXyzJL+kvjqI6KXvnXlPMeAXLOz2bnLpX/O+Xg30sDBwbFarYd1nczi7jDOcg
	lLROPaGvIEX+agHe3K4Q4slGEJPy40A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-bRvFmeXONHuyIiWnI6h_yA-1; Thu,
 14 Nov 2024 06:29:02 -0500
X-MC-Unique: bRvFmeXONHuyIiWnI6h_yA-1
X-Mimecast-MFC-AGG-ID: bRvFmeXONHuyIiWnI6h_yA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F123E195608C;
	Thu, 14 Nov 2024 11:29:00 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.110])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D7CB30000DF;
	Thu, 14 Nov 2024 11:28:57 +0000 (UTC)
Date: Thu, 14 Nov 2024 06:28:54 -0500
From: Phil Auld <pauld@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: Dequeue sched_delayed tasks when waking to a
 busy CPU
Message-ID: <20241114112854.GA471026@pauld.westford.csb>
References: <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
 <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
 <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
 <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
 <20241112124117.GA336451@pauld.westford.csb>
 <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
 <20241112154140.GC336451@pauld.westford.csb>
 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Nov 14, 2024 at 12:07:03PM +0100 Mike Galbraith wrote:
> On Tue, 2024-11-12 at 17:15 +0100, Mike Galbraith wrote:
> > On Tue, 2024-11-12 at 10:41 -0500, Phil Auld wrote:
> > > On Tue, Nov 12, 2024 at 03:23:38PM +0100 Mike Galbraith wrote:
> > >
> > > >
> > > > We don't however have to let sched_delayed block SIS though.  Rendering
> > > > them transparent in idle_cpu() did NOT wreck the progression, so
> > > > maaaybe could help your regression.
> > > >
> > >
> > > You mean something like:
> > >
> > > if (rq->nr_running > rq->h_nr_delayed)
> > >        return 0;
> > >
> > > in idle_cpu() instead of the straight rq->nr_running check?
> >
> > Yeah, close enough.
> 
> The below is all you need.
> 
> Watching blockage rate during part of a netperf scaling run without, a
> bit over 2/sec was the highest it got, but with, that drops to the same
> zero as turning off the feature, so... relevance highly unlikely but
> not quite impossible?
>

I'll give this a try on my issue. This'll be simpler than the other way.

Thanks!



Cheers,
Phil


> ---
>  kernel/sched/fair.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9454,11 +9454,15 @@ int can_migrate_task(struct task_struct
> 
>  	/*
>  	 * We do not migrate tasks that are:
> +	 * 0) not runnable (not useful here/now, but are annoying), or
>  	 * 1) throttled_lb_pair, or
>  	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
>  	 * 3) running (obviously), or
>  	 * 4) are cache-hot on their current CPU.
>  	 */
> +	if (p->se.sched_delayed)
> +		return 0;
> +
>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>  		return 0;
> 
> 

-- 


