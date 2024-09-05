Return-Path: <linux-kernel+bounces-317144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BF296D9F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A07B21877
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD7619CCF4;
	Thu,  5 Sep 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeS7GXgw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2211CFBC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542047; cv=none; b=HFVpnTccOvwBVRBpD0xUKPDxETz4NsaoygDcO4YRbfIhjHmSmRCSRj/kaSPB1nhWHSJI7VgxMenE8ooR4aYXJEYx4FWFeo7xSFeT7AJE9qGhVvSG4WTm5Ex2m479kiMryx3uiytVOnyuJaZcbY41cWyne/Poe5TFO4FswGdPN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542047; c=relaxed/simple;
	bh=y002o1GolFe+t3PoFFwCOA9zpiAPPJlcNpkL1PyiEek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT8gPniUAZivXDThwlZb2+dGNidLNrsd9EDk3QV8Ek+zomEbYFt9DH2LYttTTNplXGBjG41544wYupmFeoXiDsmwfq0X89g49do5x3dfm+8lqSc9Gs3phXiu4VMFoD2sODjjviD2LR5QWXeZpLeHgqtyBWViIQNVseNy950etpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HeS7GXgw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725542045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NquvSYysNtdGd9hKd6UpwaEX+Sw9sjq4UtD+jIUxdjo=;
	b=HeS7GXgwbTdi28p0uFB10pQfu2Q3F/vwwQnM59NXo+ClsSIcJpr3QbfedHf0HRhRd2NTto
	pvMgyMCOh+vQaUMrIdlgrIupWlmugL/PtyTSb2rt7gOP1urV6gaQCXFtl9yQt+jmGjo0cc
	L8cxxxF2qqy5QupeneNv3rGvh5VIrsI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-xUZjMXVLPziAIAPbglZ5tg-1; Thu,
 05 Sep 2024 09:14:00 -0400
X-MC-Unique: xUZjMXVLPziAIAPbglZ5tg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADB0A1918E45;
	Thu,  5 Sep 2024 13:13:09 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.39.195.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 829CC300023D;
	Thu,  5 Sep 2024 13:12:47 +0000 (UTC)
Date: Thu, 5 Sep 2024 09:12:44 -0400
From: Phil Auld <pauld@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com
Subject: Re: [RFC PATCH] sched: Do not copy user_cpus_ptr when parent is
 reset_on_fork
Message-ID: <20240905131244.GA179482@pauld.westford.csb>
References: <20240905090458.1173-1-xuewen.yan@unisoc.com>
 <a645086d-bffb-41b0-bd70-1ef5edb128f9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a645086d-bffb-41b0-bd70-1ef5edb128f9@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Sep 05, 2024 at 08:42:33AM -0400 Waiman Long wrote:
> On 9/5/24 05:04, Xuewen Yan wrote:
> > Now, the task's user_cpus_ptr would dup from parent's user_cpus_ptr.
> > It is better reset the user_cpus_ptr when parent's reset_on_fork
> > is set.
> 
> According to sched(7):
> 
>        Each thread has a reset-on-fork scheduling flag.  When this flag
>        is set, children created by fork(2) do not inherit privileged
>        scheduling policies.
> 
> It can be argued what are considered privileged scheduling policies. AFAICS,
> a restricted affinity doesn't seem to be a "privileged" scheduling policy.
> That is my own opinion strictly from the definition point of view, I will
> let others weigh in on that and I am OK to go either way.
>

I think that one could argue that clearing a restricted affinity is
increasing the privilege and not preventing inheritence of same.
i.e. it would be the opposite of what reset-on-fork means.

I'd say NAK to this one if I had that power.

Cheers,
Phil

> Cheers,
> Longman
> 
> > 
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >   kernel/sched/core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f3951e4a55e5..2fbae00cd1dc 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2666,7 +2666,7 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
> >   	 * do_set_cpus_allowed().
> >   	 */
> >   	raw_spin_lock_irqsave(&src->pi_lock, flags);
> > -	if (src->user_cpus_ptr) {
> > +	if (src->user_cpus_ptr && !src->sched_reset_on_fork) {
> >   		swap(dst->user_cpus_ptr, user_mask);
> >   		cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
> >   	}
> 
> 

-- 


