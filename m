Return-Path: <linux-kernel+bounces-263312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FAC93D430
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9793D1F2403C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD617BB09;
	Fri, 26 Jul 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pn6ZPILf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE0E57E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000759; cv=none; b=BI6XQr22XbcdMShb+aG1fCBGwTvUSz3eurV1NaU93m/Bz/cZfxvyY9d0xqNJ3Shci8SI0nOLA2H212YthDqRNW5NPYQ/sUu56h8YPWp6783HrtVfXgD+SavR7LSIOZrGN35cAI1RTFhzTXH4+c/3PYiXUyWV5JDnSyo/1kGUfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000759; c=relaxed/simple;
	bh=WH7BoKrUS5CErn+yI/ETho2cpa0hLOaU3ygRndiFh5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orPFZY4HHebiCTpy4wWFXcG/YA5r9wpmN4zPqrUywP9ORaR5u/XTATjYPw1Bjy5uROji+gS4XJzSpFb2S/1KClMp4o65jGMDhIhIJJ7mSwkt/tJ2HAuYHUgW45ctqAyTlESDLcQ9qcdnj4Q9myCKZuW4ORmd6y5CpVtWfJsAS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pn6ZPILf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722000756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WH7BoKrUS5CErn+yI/ETho2cpa0hLOaU3ygRndiFh5Q=;
	b=Pn6ZPILfxVyLE7DnyR/hfIWMKzhyfW7H9enQGvwL91SJd7B9b48jLLDOUzBlClkdjyJlqC
	QR0YHSxoEM+Nz2hNUHeThLlWcZ54wKlt3o0q/mcDbT4Dc3GqnmVH+ulF29G4hifF0gBCyM
	CoSClNTrqiPM0R0zVRXZfOmvEsCKGHc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-PksHtazQO0GoNVRItrHQVQ-1; Fri,
 26 Jul 2024 09:32:33 -0400
X-MC-Unique: PksHtazQO0GoNVRItrHQVQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57204191532E;
	Fri, 26 Jul 2024 13:32:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.83])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DECFA1955D42;
	Fri, 26 Jul 2024 13:32:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 26 Jul 2024 15:30:40 +0200 (CEST)
Date: Fri, 26 Jul 2024 15:30:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Zheng Zucheng <zhengzucheng@huawei.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] sched/cputime: Fix mul_u64_u64_div_u64()
 precision for cputime
Message-ID: <20240726133029.GC21542@redhat.com>
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <20240726023235.217771-1-zhengzucheng@huawei.com>
 <20240726104429.GA21542@redhat.com>
 <20240726130401.GB21542@redhat.com>
 <20240726130829.GN13387@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726130829.GN13387@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 07/26, Peter Zijlstra wrote:
>
> On Fri, Jul 26, 2024 at 03:04:01PM +0200, Oleg Nesterov wrote:
> > On 07/26, Oleg Nesterov wrote:
> > >
> > > On 07/26, Zheng Zucheng wrote:
> > > >
> > > > before call mul_u64_u64_div_u64(),
> > > > stime = 175136586720000, rtime = 135989749728000, utime = 1416780000.
> > >
> > > So stime + utime == 175138003500000
> > >
> > > > after call mul_u64_u64_div_u64(),
> > > > stime = 135989949653530
> > >
> > > Hmm. On x86 mul_u64_u64_div_u64(175136586720000, 135989749728000, 175138003500000)
> > > returns 135989749728000 == rtime, see below.
> >
> > Seriously, can you re-check your numbers? it would be nice to understand why
> > x86_64 differs...
>
> x86_64 has a custom mul_u64_u64_div_u64() implementation.

Yes sure, but my user-space test-case uses the "generic" version,

> > > But perhaps it makes sense to improve the accuracy of mul_u64_u64_div_u64() ?
> > > See the new() function in the code below.
> >
> > Just in case, the usage of ilog2 can be improved, but this is minor.
>
> I meant to go look at this, it seems to loop less than your improved
> version, but I'm chasing crashes atm. Perhaps it provides inspiration.
>
> https://codebrowser.dev/llvm/compiler-rt/lib/builtins/udivmodti4.c.html#__udivmodti4

Thanks... I'll try to take a look tommorrow, but at first glance I will
never understand this (clever) code ;)

Oleg.


