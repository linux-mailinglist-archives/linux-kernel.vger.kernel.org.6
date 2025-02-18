Return-Path: <linux-kernel+bounces-519739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC484A3A13D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E27E7A36DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07152698B9;
	Tue, 18 Feb 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bn4GlOK2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84203184540
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892649; cv=none; b=earRQBro+AwJz+eaR55pmf0l0Qhpl5K6XuSY4ECYlywvRyRwzboVpvvnTLzby6vCgj7vkffoCAdczep7mRZ3Xyk4vphGnIAclWVHsS6pGZa2Eh38kVN67Zxy8f0LHKCx02SSwNrVqT5/BLVtVCDXYaW8vvg4NGVh0YiGR28IEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892649; c=relaxed/simple;
	bh=nxBrbwjri3cqV9XGSKQo7soJOnW7riNcAguwV+I8KpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWDu8m6/qBvov4+rQQpD4BiTNWXOpQvH2U97UxmobWx5eUFHN6bJOD+Sg8QgSCwpmmN2KWz9nidgJ/L01EXWNUKGJq5+8PNCyajpRusmjJIbBWSPBpHLfZ7NbCZA1VUZLSEVsA2e275aq2HKcdnqgNN90crYa5ILoh1HRhu9bf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bn4GlOK2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739892646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UfOukCgz2FlU+RlDSbK4eKrjF3sFq4YwqIDDe9+QQ4=;
	b=Bn4GlOK2AqvV116EH405f3SV++Xlu9nT7d3DsBKZGDsrKA+GaKKqSoGdi5LGULDhFFiKiK
	VZieO/H/EEq4tAS2+aJupDFK0C1nz8RL0nDHudtdgAwGXMnpOd5jUdu15URrtjZ5Wn6QSL
	GfqfQngmJ5swtrohReyhWefQvVm46Mk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-HFY92sswNCGnGDhbWHN25A-1; Tue,
 18 Feb 2025 10:30:45 -0500
X-MC-Unique: HFY92sswNCGnGDhbWHN25A-1
X-Mimecast-MFC-AGG-ID: HFY92sswNCGnGDhbWHN25A_1739892643
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0BBE18D95F3;
	Tue, 18 Feb 2025 15:30:43 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.89.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AECE3180034D;
	Tue, 18 Feb 2025 15:30:41 +0000 (UTC)
Date: Tue, 18 Feb 2025 10:30:39 -0500
From: Phil Auld <pauld@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [CHANGE 1/2] sched/isolation: Make use of more than one
 housekeeping cpu
Message-ID: <20250218153039.GD547103@pauld.westford.csb>
References: <20250211140104.420739-1-pauld@redhat.com>
 <4a8d54e7-fa29-4ce4-9023-3cdffa0807e6@linux.ibm.com>
 <20250213142653.GA472203@pauld.westford.csb>
 <Z67Wy9Jjn0BZa01A@linux.ibm.com>
 <20250218150059.GC547103@pauld.westford.csb>
 <12775fc3-1575-4bdd-8d1e-056915d95e3d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12775fc3-1575-4bdd-8d1e-056915d95e3d@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Feb 18, 2025 at 10:23:50AM -0500 Waiman Long wrote:
> 
> On 2/18/25 10:00 AM, Phil Auld wrote:
> > Hi Vishal.
> > 
> > On Fri, Feb 14, 2025 at 11:08:19AM +0530 Vishal Chourasia wrote:
> > > Hi Phil, Vineeth
> > > 
> > > On Thu, Feb 13, 2025 at 09:26:53AM -0500, Phil Auld wrote:
> > > > On Thu, Feb 13, 2025 at 10:14:04AM +0530 Madadi Vineeth Reddy wrote:
> > > > > Hi Phil Auld,
> > > > > 
> > > > > On 11/02/25 19:31, Phil Auld wrote:
> > > > > > The exising code uses housekeeping_any_cpu() to select a cpu for
> > > > > > a given housekeeping task. However, this often ends up calling
> > > > > > cpumask_any_and() which is defined as cpumask_first_and() which has
> > > > > > the effect of alyways using the first cpu among those available.
> > > > > > 
> > > > > > The same applies when multiple NUMA nodes are involved. In that
> > > > > > case the first cpu in the local node is chosen which does provide
> > > > > > a bit of spreading but with multiple HK cpus per node the same
> > > > > > issues arise.
> > > > > > 
> > > > > > Spread the HK work out by having housekeeping_any_cpu() and
> > > > > > sched_numa_find_closest() use cpumask_any_and_distribute()
> > > > > > instead of cpumask_any_and().
> > > > > > 
> > > > > Got the overall intent of the patch for better load distribution on
> > > > > housekeeping tasks. However, one potential drawback could be that by
> > > > > spreading HK work across multiple CPUs might reduce the time that
> > > > > some cores can spend in deeper idle states which can be beneficial for
> > > > > power-sensitive systems.
> > > > > 
> > > > > Thoughts?
> > > > NOHZ_full setups are not generally used in power sensitive systems I think.
> > > > They aren't in our use cases at least.
> > > > 
> > > > In cases with many cpus a single housekeeping cpu can not keep up. Having
> > > > other HK cpus in deep idle states while the one in use is overloaded is
> > > > not a win.
> > > To me, an overloaded CPU sounds like where more than one tasks are ready
> > > to run, and a HK CPU is one receiving periodic scheduling clock
> > > ticks, so HP CPU is bound to comes out of any power-saving state it is in.
> > If the overload is caused by HK and interrupts there is nothing in the
> > system to help. Tasks, sure, can get load balanced.
> > 
> > And as you say, the HK cpus will have generally ticks happening anyway.
> > 
> > > > If your single HK cpu can keep up then only configure that one HK cpu.
> > > > The others will go idle and stay there.  And since they are nohz_full
> > > > might get to stay idle even longer.
> > > While it is good to distribute the load across each HK CPU in the HK
> > > cpumask (queuing jobs on different CPUs each time), this can cause
> > > jitter in virtualized environments. Unnecessaryily evicting other
> > > tenants, when it's better to overload a VP than to wake up other VPs of a
> > > tenant.
> > > 
> > Sorry I'm not sure I understand your setup. Are your running virtual
> > tenants on the HK cpus?  nohz_full in the guests? Maybe you only need
> > on HK then it won't matter.
> > 
> > My concern is that currently there is no point in having more than
> > one HK cpu (per node in a NUMA case). The code as currently implemented
> > is just not doing what it needs to.
> > 
> > We have numerous cases where a single HK cpu just cannot keep up and
> > the remote_tick warning fires. It also can lead to the other things
> > (orchastration sw, HA keepalives etc) on the HK cpus getting starved
> > which leads to other issues.  In these cases we recommend increasing
> > the number of HK cpus.  But... that only helps the userspace tasks
> > somewhat. It does not help the actual housekeeping part.
> 
> That is the part that should go into the commit log as well as it is the
> rationale behind your patch.
>

Sure, I can add that piece and resend.


Cheers,
Phil


> Cheers,
> Longman
> 

-- 


