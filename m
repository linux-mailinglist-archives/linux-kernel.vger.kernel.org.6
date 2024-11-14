Return-Path: <linux-kernel+bounces-409838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36969C924F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9879E28628D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592BB1A01B9;
	Thu, 14 Nov 2024 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsVGpuYN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DE91A00D2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611675; cv=none; b=fo0sr3ObFll3nhpwNPKFENmGKhQEen7L86jVqMMID/nyRS9t7UoDtOgK7OvBfPmj+nIxIp+OzcSpBvm0YSoIkbOV8bG17mT8664i4uH5ucQ+WEnHn+h+ts4yUSlEyAGGOluvDnJX9ePwzSPF3+ZOm0XPoQrOMs+ZlBzyC/le6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611675; c=relaxed/simple;
	bh=x/C8MRpTPDfB31cd15J/ISoxs2xcBWcjP3V1qaS7ubc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbJLv+bofyvZfem0RxECY2rgPG6H5qchIXsim1mNza6pHfNxUleucNXd1T/nYCS47yskhPUage5lqD6ngWkJZ7oUUnY3E4FAYeH2ibP0cPDubGcZRtW3vvyFfwlrhf9rDwf04f/EYl9cVS2J4FgddcxCa9sqNSYOwD9IuR14Im4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsVGpuYN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731611672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZvWLe70UhmQ5nFB7WIiKxp+RIIykuie6TmdPR9ki4Q=;
	b=bsVGpuYNJqL1iCe6BdVJOtxZTcW06UUWsKHFD2Z+N7m7YOb9HJPkpkkWISr1IOPWb4tTaH
	3Qhg4il6y814Bs4IlVdXC92Fed8pU/3VHz6THPdh4WyPb+qD4ClgESTlXB6LWxKCjgTyfA
	3gjIULCmhfEeJkLAcaozIbIQbuVOlVQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-YYfcPbRMMIer_vUEa5scDw-1; Thu,
 14 Nov 2024 14:14:27 -0500
X-MC-Unique: YYfcPbRMMIer_vUEa5scDw-1
X-Mimecast-MFC-AGG-ID: YYfcPbRMMIer_vUEa5scDw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DF79195395B;
	Thu, 14 Nov 2024 19:14:25 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.110])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CDED3003B71;
	Thu, 14 Nov 2024 19:14:22 +0000 (UTC)
Date: Thu, 14 Nov 2024 14:14:19 -0500
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
Subject: Re: [PATCH] sched: add READ_ONCE to task_on_rq_queued
Message-ID: <20241114191419.GH471026@pauld.westford.csb>
References: <20241114162128.1818680-1-jon@nutanix.com>
 <20241114185215.GF471026@pauld.westford.csb>
 <6A546A91-A80E-4D4C-9898-5EB792E19635@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6A546A91-A80E-4D4C-9898-5EB792E19635@nutanix.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Nov 14, 2024 at 06:59:14PM +0000 Jon Kohler wrote:
> 
> 
> > On Nov 14, 2024, at 1:52 PM, Phil Auld <pauld@redhat.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Thu, Nov 14, 2024 at 09:21:28AM -0700 Jon Kohler wrote:
> >> task_on_rq_queued read p->on_rq without READ_ONCE, though p->on_rq is
> >> set with WRITE_ONCE in {activate|deactivate}_task and smp_store_release
> >> in __block_task, and also read with READ_ONCE in task_on_rq_migrating.
> >> 
> >> Make all of these accesses pair together by adding READ_ONCE in the
> >> task_on_rq_queued.
> >> 
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> ---
> >> kernel/sched/sched.h | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >> index c03b3d7b320e..dbbe5ce0dd96 100644
> >> --- a/kernel/sched/sched.h
> >> +++ b/kernel/sched/sched.h
> >> @@ -2277,7 +2277,7 @@ static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
> >> 
> >> static inline int task_on_rq_queued(struct task_struct *p)
> >> {
> >> - return p->on_rq == TASK_ON_RQ_QUEUED;
> >> + return READ_ONCE(p->on_rq) == TASK_ON_RQ_QUEUED;
> >> }
> >> 
> >> static inline int task_on_rq_migrating(struct task_struct *p)
> >> -- 
> >> 2.43.0
> >> 
> >> 
> > 
> > That looks right especially when seen with task_on_rq_migrating()
> > right below it, as you said.
> > 
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > 
> 
> Thanks Phil - note, I’ve got a v2 coming shortly as I’ve bungled the
> author and codeveloped tag from our internal version of this patch.
> 
> I’ll get that out, but it will be the exact same code.
>

You can just put my reviewed by on that one when you send it then.


Cheers,
Phil



> > 
> > Cheers,
> > Phil
> > -- 
> > 
> 

-- 


