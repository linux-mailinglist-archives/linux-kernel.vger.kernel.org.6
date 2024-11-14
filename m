Return-Path: <linux-kernel+bounces-409839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8609C9253
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920911F2244C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020FC197549;
	Thu, 14 Nov 2024 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8GbG7hv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3414AD2D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731612070; cv=none; b=Fe3vI4Q4ZfZwV5ExvqwEGNuKLtaCs1bEVKNpOOwsdN/Rgsn+wilX10JtEzFCLSSGuqWni2IN2IoaCMANJ72ReAXB7GZWVsIXsPjSzO04YUDywL9BQoFtHZPbZPzT4ZU5wr/AHQp1bktG/OpMuOxgMPb0oL7uZhj22e7zzYB2loQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731612070; c=relaxed/simple;
	bh=m+J+RQB3JdKT0NuF2DuOLET4RVQRfc9rhea//vm481U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEo8llz08EYsg8aWvReauTOOQAUIfn16U3ekXywaSsMJUEPXWH2ttwv5vdxDVa7ZH97zxV6CeW1ZGW5lerP/pOHzWXLZ4jz9RUmmajcPyjrT+1HZCRbO//4Nu03+5bezYKXVvhfN8Xms/az2anYpcoga2jOiz5Qu55xB/qMT2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8GbG7hv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731612066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9i/UyL0erQIsZkcgx4oaGrBWOAmN4a8Y07zzFhkUEA=;
	b=Q8GbG7hvm4OEE6HUxldrL3Ds4qqB8FjL33Icc2SEDN1ohPIfqA6T1wiGnwtaVvzpd9Q7ID
	RHA3PBOkQHIJ9g2/dOL91ekKX5Ek/dSLLYqd4Zr43U5Z9lY5aSU82ox1v6iWjTezNFDUXV
	0uFRdyXocNTXPbyRlx/+NyispG41TAw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-hLleVvBqPYq8Ufn6boxVoQ-1; Thu,
 14 Nov 2024 14:21:04 -0500
X-MC-Unique: hLleVvBqPYq8Ufn6boxVoQ-1
X-Mimecast-MFC-AGG-ID: hLleVvBqPYq8Ufn6boxVoQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 142651954B03;
	Thu, 14 Nov 2024 19:21:02 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.110])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFB111955F43;
	Thu, 14 Nov 2024 19:20:58 +0000 (UTC)
Date: Thu, 14 Nov 2024 14:20:56 -0500
From: Phil Auld <pauld@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: hoist ASSERT_EXCLUSIVE_WRITER(p->on_rq) above
 WRITE_ONCE
Message-ID: <20241114192056.GI471026@pauld.westford.csb>
References: <20241114165352.1824956-1-jon@nutanix.com>
 <20241114185755.GG471026@pauld.westford.csb>
 <0C4B7BAD-04EA-4F60-B6D2-A7B2C14E52B7@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0C4B7BAD-04EA-4F60-B6D2-A7B2C14E52B7@nutanix.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Nov 14, 2024 at 07:01:13PM +0000 Jon Kohler wrote:
> 
> 
> > On Nov 14, 2024, at 1:57 PM, Phil Auld <pauld@redhat.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Thu, Nov 14, 2024 at 09:53:52AM -0700 Jon Kohler wrote:
> >> In {activate|deactivate}_task(), hoist ASSERT_EXCLUSIVE_WRITER() to be
> >> above WRITE_ONCE(p->on_rq), which matches the ordering listed in the
> >> KCSAN documentation, kcsan-checks.h code comments, and the usage
> >> pattern we already have in __block_task().
> >> 
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> ---
> >> kernel/sched/core.c | 4 ++--
> >> 1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index a1c353a62c56..80a04c36b495 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -2066,16 +2066,16 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
> >> 
> >> enqueue_task(rq, p, flags);
> >> 
> >> - WRITE_ONCE(p->on_rq, TASK_ON_RQ_QUEUED);
> >> ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> >> + WRITE_ONCE(p->on_rq, TASK_ON_RQ_QUEUED);
> >> }
> >> 
> >> void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
> >> {
> >> SCHED_WARN_ON(flags & DEQUEUE_SLEEP);
> >> 
> >> - WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
> >> ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> >> + WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
> >> 
> >> /*
> >> * Code explicitly relies on TASK_ON_RQ_MIGRATING begin set *before*
> >> -- 
> >> 2.43.0
> >> 
> >> 
> > 
> > This looks fine to me and it makes sense to have the assert before the
> > write.  A quick grep showed that this is by no means a universal pattern
> > at the moment.
> > 
> 
> I’d have to imaging having the assert before must be the right way to
> do this, just from a logic control flow perspective. I’m happy to fix ’the
> others', or do you think I should let them sit there?
>

I don't know. I don't think it matters much since the assert is really
independent of the actual write. Like I said it makes sense to have it
first to me but others may see it as just moving code around for no strong
reason.  Peter may or may not decide to pick this one up. Other "mis-ordered"
uses are in code maintained by different folks.

You can see if anyone else weighs in...

Cheers,
Phil

> > 
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > 
> > 
> > Cheers,
> > Phil
> > 
> > -- 
> > 
> 

-- 


