Return-Path: <linux-kernel+bounces-513137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDF3A341E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D7F7A053D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F8281363;
	Thu, 13 Feb 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSoQWpO2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379428134B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456823; cv=none; b=aFTeJs6T3e+wBCCcnCTeYjYkRmmJqI5lcdQStdM6X85DR3UOwuuW3OniFv+mG1cwXTRRHFw5vZzWHrbXEOjJNYDptfGiBmHSsXOYTdC7fcBAo0+ItCP7lh4eeboVqi0hhGiDek6k2nntGAM95NYYcf8mAnsq9ZiHFNGMN17AQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456823; c=relaxed/simple;
	bh=v0pVMRWyfNok94km3PUJewnEQHKGogIqu2YvHtUVVMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGIHv7PxmehUdJdnVEKSi89lKeRPFEU26M/jhn2mg82LnRoXdF2+I7BK7GgVvrTNSFMouUVV4Ha/FzAG6yynAOu7Vf9F+O4zR58CVWPtE1oarsXgfc7LRQ5hzGpc1OqzSd4//xAAjyNXswDDX5IdVJ/2oekW0N2tAc24Ft7K+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSoQWpO2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739456820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6M1gDTvPuGgue2fyEVIE80fdtT2TCPvdR21VlIze2TE=;
	b=aSoQWpO28xS7NzW5hVWkKJikNUdtAUTru/scwQXbPr634BC2sxQwZHNlK5zsbTFmUcp+w6
	qyaSCAMlB8I1AiwH6vIXKJw/aBMF0NX+gKbb0SUUBtw+p/JNVhYyDCkhh/PiJWJy+cNL5U
	SsuPLBjp5YTKYcUJm97152OdSbVDHuU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-Hk1TlQ9bNBO4dF1ASiHtQA-1; Thu,
 13 Feb 2025 09:26:59 -0500
X-MC-Unique: Hk1TlQ9bNBO4dF1ASiHtQA-1
X-Mimecast-MFC-AGG-ID: Hk1TlQ9bNBO4dF1ASiHtQA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 174EE18D95DE;
	Thu, 13 Feb 2025 14:26:58 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.188])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06806180034D;
	Thu, 13 Feb 2025 14:26:55 +0000 (UTC)
Date: Thu, 13 Feb 2025 09:26:53 -0500
From: Phil Auld <pauld@redhat.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [CHANGE 1/2] sched/isolation: Make use of more than one
 housekeeping cpu
Message-ID: <20250213142653.GA472203@pauld.westford.csb>
References: <20250211140104.420739-1-pauld@redhat.com>
 <4a8d54e7-fa29-4ce4-9023-3cdffa0807e6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a8d54e7-fa29-4ce4-9023-3cdffa0807e6@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Feb 13, 2025 at 10:14:04AM +0530 Madadi Vineeth Reddy wrote:
> Hi Phil Auld,
> 
> On 11/02/25 19:31, Phil Auld wrote:
> > The exising code uses housekeeping_any_cpu() to select a cpu for
> > a given housekeeping task. However, this often ends up calling
> > cpumask_any_and() which is defined as cpumask_first_and() which has
> > the effect of alyways using the first cpu among those available.
> > 
> > The same applies when multiple NUMA nodes are involved. In that
> > case the first cpu in the local node is chosen which does provide
> > a bit of spreading but with multiple HK cpus per node the same
> > issues arise.
> > 
> > Spread the HK work out by having housekeeping_any_cpu() and
> > sched_numa_find_closest() use cpumask_any_and_distribute()
> > instead of cpumask_any_and().
> > 
> 
> Got the overall intent of the patch for better load distribution on
> housekeeping tasks. However, one potential drawback could be that by
> spreading HK work across multiple CPUs might reduce the time that
> some cores can spend in deeper idle states which can be beneficial for
> power-sensitive systems.
> 
> Thoughts?

NOHZ_full setups are not generally used in power sensitive systems I think.
They aren't in our use cases at least. 

In cases with many cpus a single housekeeping cpu can not keep up. Having
other HK cpus in deep idle states while the one in use is overloaded is
not a win. 

If your single HK cpu can keep up then only configure that one HK cpu.
The others will go idle and stay there.  And since they are nohz_full
might get to stay idle even longer.

I do have a patch that has this controlled by a sched feature if that
is of interest. Then it could be disabled if you don't want it. 

Cheers,
Phil

> 
> Thanks,
> Madadi Vineeth Reddy
> 
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/sched/isolation.c | 2 +-
> >  kernel/sched/topology.c  | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index 81bc8b329ef1..93b038d48900 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -40,7 +40,7 @@ int housekeeping_any_cpu(enum hk_type type)
> >  			if (cpu < nr_cpu_ids)
> >  				return cpu;
> >  
> > -			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> > +			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
> >  			if (likely(cpu < nr_cpu_ids))
> >  				return cpu;
> >  			/*
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index c49aea8c1025..94133f843485 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2101,7 +2101,7 @@ int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
> >  	for (i = 0; i < sched_domains_numa_levels; i++) {
> >  		if (!masks[i][j])
> >  			break;
> > -		cpu = cpumask_any_and(cpus, masks[i][j]);
> > +		cpu = cpumask_any_and_distribute(cpus, masks[i][j]);
> >  		if (cpu < nr_cpu_ids) {
> >  			found = cpu;
> >  			break;
> 

-- 


