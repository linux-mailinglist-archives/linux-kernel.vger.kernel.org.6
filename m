Return-Path: <linux-kernel+bounces-317232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E16196DB33
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77BB1F284A1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405419E7E4;
	Thu,  5 Sep 2024 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0VohcB+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76819DF4D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545361; cv=none; b=nhQXetNYi+hVk90fw2+DrT7t1EP4tTuEOFxZsf6xuYfFvgfITmfwu0wCGjd1VX8bahXvErnE0xvZO60mAUBwyNxR3YgBMiT5lFC5Asu6/fJpSjtdw2EkHg6206H8wNUteD+FWa0QfATAp+c+Lcy9GrkQzXkMumMqoXc09plZMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545361; c=relaxed/simple;
	bh=Q6nWeBU37wmAot8cg7kzJQLhx6z2mRPUaLYCXMXaBvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLsBtYjZmTC8pST+dmuRL3Tkfi58KtCP+KPCeb4kTJ5OC5g6iHMRZIS0F+xaD1K55EtfTIvc872mpFNrYhsOVEfnwowpnGrWYrQbgcqsk4MGCb+RnxmguvGlpko5zZiCKDLMDjild7QvhUDqoFz9UfHDvo6cY2Sa97J7JFCfhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0VohcB+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725545359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3nlL5tWICWxYZUircz1H/qUNW2To9dsWCu6HNAp6L0=;
	b=g0VohcB+oU6F12vV5t5voIJS9dSlVbFJ2LqI3/Fw4OPycWipMxoZ3+ZoNIUq5UqMAwwbRj
	ywCl0oYDMf0e48MVMo+7oPerTMi9a8G+ez1D7qxo/MUvMrD6BA/Q7m5OFuIOJY3hUPwtgW
	YaGVJnqcJm2leHq6Xr/vjEFU/yUgqD4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-UrvdJzZhMY2MfE9mywBzNw-1; Thu,
 05 Sep 2024 10:09:17 -0400
X-MC-Unique: UrvdJzZhMY2MfE9mywBzNw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D2C21956057;
	Thu,  5 Sep 2024 14:09:14 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.39.195.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2A0119560AA;
	Thu,  5 Sep 2024 14:09:06 +0000 (UTC)
Date: Thu, 5 Sep 2024 10:09:02 -0400
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
Message-ID: <20240905140902.GB179482@pauld.westford.csb>
References: <20240905090458.1173-1-xuewen.yan@unisoc.com>
 <a645086d-bffb-41b0-bd70-1ef5edb128f9@redhat.com>
 <20240905131244.GA179482@pauld.westford.csb>
 <66d8a8c9-f03b-49de-b67f-0623a796191e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66d8a8c9-f03b-49de-b67f-0623a796191e@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Sep 05, 2024 at 10:00:36AM -0400 Waiman Long wrote:
> 
> On 9/5/24 09:12, Phil Auld wrote:
> > On Thu, Sep 05, 2024 at 08:42:33AM -0400 Waiman Long wrote:
> > > On 9/5/24 05:04, Xuewen Yan wrote:
> > > > Now, the task's user_cpus_ptr would dup from parent's user_cpus_ptr.
> > > > It is better reset the user_cpus_ptr when parent's reset_on_fork
> > > > is set.
> > > According to sched(7):
> > > 
> > >         Each thread has a reset-on-fork scheduling flag.  When this flag
> > >         is set, children created by fork(2) do not inherit privileged
> > >         scheduling policies.
> > > 
> > > It can be argued what are considered privileged scheduling policies. AFAICS,
> > > a restricted affinity doesn't seem to be a "privileged" scheduling policy.
> > > That is my own opinion strictly from the definition point of view, I will
> > > let others weigh in on that and I am OK to go either way.
> > > 
> > I think that one could argue that clearing a restricted affinity is
> > increasing the privilege and not preventing inheritence of same.
> > i.e. it would be the opposite of what reset-on-fork means.
> > 
> > I'd say NAK to this one if I had that power.
> 
> Maybe I am not clear enough in my previous mail. My position is the same as
> yours. I think this patch is not necessary. More reasons should be provided
> as to why it is right to not inherited the restricted affinity when
> reset-on-fork flag is reset.
>

No, you were clear. I was just providing my opinion, weighing in :)  

Cheers,
Phil

> Cheers,
> Longman
> 

-- 


