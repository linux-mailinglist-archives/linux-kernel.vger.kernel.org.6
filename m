Return-Path: <linux-kernel+bounces-328758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D0C97885F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF9E1F284EC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CDD4A2C;
	Fri, 13 Sep 2024 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7XlTsIB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203813C8EA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254096; cv=none; b=kxBKQ56EPaUAc3qLiurtCykH1PFYDL+OEaUfPvIelIPp9RbZTl3wA3iYV2uBhhXITGdESZtWS6KteYbLNcJYx8CwptUh2uEhuxlEK3iTTGC6mwBbCo08shsX4gbiBoPTWGbp+xn5/v0LgRsC4JKRQw4jkK65jonM9t3lMJU252c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254096; c=relaxed/simple;
	bh=t7VhkvLXibw3ixPa5G4bQdOz2MuylOZhl3wA/pLMDmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb2SvT+jkG91MNNycKX4vakWl3l5s4fVK1t1BLJjkybJKtrx6x3e94kKaVfZL5iFa2CFBOztplZw4MXq8lEl7qpoGO3aN3xZ0pn9wyeaeeXou0jEMy0T0prSQxyORxbCabIiBxJAaByA8JFrgkw+oCMg4gnFFqI4JbpD05048D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7XlTsIB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726254093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5WUawk6UeQz1fgAqAjCjADByI3bac24dG1c8uUPGGkU=;
	b=E7XlTsIBZWr4y1cHJzbuGJBEJNcOwj9OMOCGva/mM5Uliv/vbyMm0s+ZpQgAPD26FYM3lY
	IspL25kvvPghS0i5+U+wG01tp2ijFoF2konPmNJ3POkgFOijpbbQwaTci5m1ZIwmkSxJOk
	M/CyYGg6rRVr7kYY+WmNlz2eLqxkSN4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-hceF7FbvMV6F0nIyfMopfw-1; Fri,
 13 Sep 2024 15:01:32 -0400
X-MC-Unique: hceF7FbvMV6F0nIyfMopfw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36B081955F2C;
	Fri, 13 Sep 2024 19:01:31 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C2EA1956088;
	Fri, 13 Sep 2024 19:01:30 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 610B7400E52F5; Wed, 11 Sep 2024 00:04:46 -0300 (-03)
Date: Wed, 11 Sep 2024 00:04:46 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Leonardo Bras <leobras@redhat.com>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Message-ID: <ZuEIzngSx36Gx8l/@tpad>
References: <Zp/k+rJuVV+EcXqL@tpad>
 <20240905221908.1960-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905221908.1960-1-hdanton@sina.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Sep 06, 2024 at 06:19:08AM +0800, Hillf Danton wrote:
> On Tue, 23 Jul 2024 14:14:34 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> > On Sat, Jun 22, 2024 at 12:58:08AM -0300, Leonardo Bras wrote:
> > > The problem:
> > > Some places in the kernel implement a parallel programming strategy
> > > consisting on local_locks() for most of the work, and some rare remote
> > > operations are scheduled on target cpu. This keeps cache bouncing low since
> > > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > > kernels, even though the very few remote operations will be expensive due
> > > to scheduling overhead.
> > > 
> > > On the other hand, for RT workloads this can represent a problem: getting
> > > an important workload scheduled out to deal with remote requests is
> > > sure to introduce unexpected deadline misses.
> > 
> > Another hang with a busy polling workload (kernel update hangs on
> > grub2-probe):
> > 
> > [342431.665417] INFO: task grub2-probe:24484 blocked for more than 622 seconds.
> > [342431.665458]       Tainted: G        W      X  -------  ---  5.14.0-438.el9s.x86_64+rt #1
> > [342431.665488] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [342431.665515] task:grub2-probe     state:D stack:0     pid:24484 ppid:24455  flags:0x00004002
> > [342431.665523] Call Trace:
> > [342431.665525]  <TASK>
> > [342431.665527]  __schedule+0x22a/0x580
> > [342431.665537]  schedule+0x30/0x80
> > [342431.665539]  schedule_timeout+0x153/0x190
> > [342431.665543]  ? preempt_schedule_thunk+0x16/0x30
> > [342431.665548]  ? preempt_count_add+0x70/0xa0
> > [342431.665554]  __wait_for_common+0x8b/0x1c0
> > [342431.665557]  ? __pfx_schedule_timeout+0x10/0x10
> > [342431.665560]  __flush_work.isra.0+0x15b/0x220
> 
> The fresh new flush_percpu_work() is nop with CONFIG_PREEMPT_RT enabled, why
> are you testing it with 5.14.0-438.el9s.x86_64+rt instead of mainline? Or what
> are you testing?

I am demonstrating a type of bug that can happen without Leo's patch.

> BTW the hang fails to show the unexpected deadline misses.

Yes, because in this case the realtime app with FIFO priority never
stops running, therefore grub2-probe hangs and is unable to execute:

> > [342431.665417] INFO: task grub2-probe:24484 blocked for more than 622 seconds
> 
> > [342431.665565]  ? __pfx_wq_barrier_func+0x10/0x10
> > [342431.665570]  __lru_add_drain_all+0x17d/0x220
> > [342431.665576]  invalidate_bdev+0x28/0x40
> > [342431.665583]  blkdev_common_ioctl+0x714/0xa30
> > [342431.665588]  ? bucket_table_alloc.isra.0+0x1/0x150
> > [342431.665593]  ? cp_new_stat+0xbb/0x180
> > [342431.665599]  blkdev_ioctl+0x112/0x270
> > [342431.665603]  ? security_file_ioctl+0x2f/0x50
> > [342431.665609]  __x64_sys_ioctl+0x87/0xc0

Does that make sense now?

Thanks!


