Return-Path: <linux-kernel+bounces-253003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77E9931B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F5D1C21BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1A1292CE;
	Mon, 15 Jul 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIBOO7qd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7C215491
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072073; cv=none; b=g14Jg0zL8Rf59381jVAPNay2NJVJJzJ7VR80srURgOBclp9gB7OXwgQBix1BERZReS3RdNGJrI4qn0hVLgLkU7v4vjXb6M9Kj2tlUJDfL4Dfz7wCv+O6s+W8sEtokubYUX0Nls05h/KLPWs4maThirvWBqY7Vd1YRRwIUoyJF2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072073; c=relaxed/simple;
	bh=C8RUPX9LfEut7+xmVjhiOqGNaYtXmgw8P+dKtJhZm8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho/5yG6E7TiD5BBMLOp2hIg+MpM/biPxtC+BY9YKD8VNAWkdW/4MvP6/vJsDmg+JtjoMS1tDjKPVsPDyFgMlNbGtta3aso8JnJXTz7swwcjOCCu9PTU4v+KHPoBThBydbaCIn6WeTP3ahiGBjJbU+xjC17Z8VJkM1TikRq7xBZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIBOO7qd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721072069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KX7IEr2zKnMtYo6NKNA4TARkllCcLg1jqXMkrl6O60=;
	b=FIBOO7qdp/UjZ6RE7sec3/RAaKqOMkrC08yqoaGysp/dXk1RnY0T5hM+sz2WMSNPdzEY4Y
	qMalH0H9NUZBJwhPOum5I0PDL02k3jGAMaEJpgDg72PVFgJ2sWklRX1W0O57FCrKqBIfEP
	15O48wdBbnV8VOgk92ZgMJ78Jnosh60=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-seHeETyFOkWXnSB293hp-Q-1; Mon,
 15 Jul 2024 15:34:28 -0400
X-MC-Unique: seHeETyFOkWXnSB293hp-Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C62E11955D44;
	Mon, 15 Jul 2024 19:34:24 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 184B73000190;
	Mon, 15 Jul 2024 19:34:22 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id E7095400EC901; Mon, 15 Jul 2024 15:38:27 -0300 (-03)
Date: Mon, 15 Jul 2024 15:38:27 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Vlastimil Babka <vbabka@suse.cz>, Thomas Gleixner <tglx@linutronix.de>
Cc: Leonardo Bras <leobras@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Message-ID: <ZpVsow629seGUXRz@tpad>
References: <20240622035815.569665-1-leobras@redhat.com>
 <261612b9-e975-4c02-a493-7b83fa17c607@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <261612b9-e975-4c02-a493-7b83fa17c607@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jun 24, 2024 at 09:31:51AM +0200, Vlastimil Babka wrote:
> Hi,
> 
> you've included tglx, which is great, but there's also LOCKING PRIMITIVES
> section in MAINTAINERS so I've added folks from there in my reply.
> Link to full series:
> https://lore.kernel.org/all/20240622035815.569665-1-leobras@redhat.com/
> 
> On 6/22/24 5:58 AM, Leonardo Bras wrote:
> > The problem:
> > Some places in the kernel implement a parallel programming strategy
> > consisting on local_locks() for most of the work, and some rare remote
> > operations are scheduled on target cpu. This keeps cache bouncing low since
> > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > kernels, even though the very few remote operations will be expensive due
> > to scheduling overhead.
> > 
> > On the other hand, for RT workloads this can represent a problem: getting
> > an important workload scheduled out to deal with remote requests is
> > sure to introduce unexpected deadline misses.
> > 
> > The idea:
> > Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> > In this case, instead of scheduling work on a remote cpu, it should
> > be safe to grab that remote cpu's per-cpu spinlock and run the required
> > work locally. Tha major cost, which is un/locking in every local function,
> > already happens in PREEMPT_RT.
> 
> I've also noticed this a while ago (likely in the context of rewriting SLUB
> to use local_lock) and asked about it on IRC, and IIRC tglx wasn't fond of
> the idea. But I forgot the details about why, so I'll let the the locking
> experts reply...

Thomas?



