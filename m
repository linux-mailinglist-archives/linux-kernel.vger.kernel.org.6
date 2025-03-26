Return-Path: <linux-kernel+bounces-576845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F9EA71517
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746AD3B5B65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3581C8601;
	Wed, 26 Mar 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IuLIAG44"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85A1AE876
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986008; cv=none; b=h0I5EeOpxfES4DfTeT4tqZkmMaDYt/2dZ/nZcIYzdN227JcKt4tdYpA+rYZ/GHJQago6RXR2zrKLTRAIF/UnRfdOE3n1ohbwzl7Jj0jg+KE6Hgnxin0RHRWLTLG419bqVLsa1+sp6Zm+iftRSMVM1NtpmS2U8Ke/FywdHIZKYvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986008; c=relaxed/simple;
	bh=WX4cqTlZEbs9Hwg4nddBqQtyhY2nnkhpxJz/QIbatfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP1mX+ZVm1aZrpG+cyPA4e8/hNcQ2ArHmjJ7I844+opHywT4QZRdsnUVeVht3tZp6HqQHzfzy6hSk5ak7RxLWzev4v0FCzqqa1AzzykGayza0SCRKxjmJ+jWLGQhe4iTWTlLgj3kV1YLXRoUfdoPhfHF8RPJKYGrglcBzMtWPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IuLIAG44; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=64NlIFTX6igdIKyqbO9/7Y2I1xjU9JuHdqRdG30MxD0=; b=IuLIAG44znVPcN+VS/AZf2GTqR
	kBcUc8USFFgteOfJCzQCRuZTgjFhq2INL0pr5K3ccjqtQqp4KdagsH8ZfZWgyUMn3vCMWxZ7ROU2U
	HBylHiq0+86vWymdu3Lm37RpNyRLroS0GAFjYrDUBkCAh4e0w99IhHUTOyVplp4z59H0KZLPV/h+q
	5MeqAnYg9VE9cZmWfBoysoLoYw3ztDxikzlrEQLVtPXiIIuphWlb/54s2pJhtoqFBgExMbS0ytuo6
	L4tnrq8DvPk0ZUU9KCi0zl7esiS5d1//FxpGMH8QtSOR/gyfqYddDHzYnI6/Rnml0c+TyaYE/mZRV
	5f80Lcpg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txOHD-0000000HPVh-45ZY;
	Wed, 26 Mar 2025 10:46:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4247F3003C4; Wed, 26 Mar 2025 11:46:27 +0100 (CET)
Date: Wed, 26 Mar 2025 11:46:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	tim.c.chen@linux.intel.com, tglx@linutronix.de, len.brown@intel.com,
	gautham.shenoy@amd.com, mingo@kernel.org, kprateek.nayak@amd.com,
	yu.chen.surf@foxmail.com
Subject: Re: [RFC][PATCH] sched: Cache aware load-balancing
Message-ID: <20250326104627.GC12071@noisy.programming.kicks-ass.net>
References: <20250325120952.GJ36322@noisy.programming.kicks-ass.net>
 <4cd8ba54-8b9e-4563-8fbc-1d6cd6699e81@intel.com>
 <20250326093841.GC25239@noisy.programming.kicks-ass.net>
 <20250326102553.GA12071@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326102553.GA12071@noisy.programming.kicks-ass.net>

On Wed, Mar 26, 2025 at 11:25:53AM +0100, Peter Zijlstra wrote:
> On Wed, Mar 26, 2025 at 10:38:41AM +0100, Peter Zijlstra wrote:
> 
> > Nah, the saner thing to do is to preserve the topology averages and look
> > at those instead of the per-cpu values.
> > 
> > Eg. have task_cache_work() compute and store averages in the
> > sched_domain structure and then use those.
> 
> A little something like so perhaps ?

Oh urgh, ignore all that, I'm an idiot.

The numbers are per process, can't stick them in global structures.

I remember going through all this before :-/ Its just so very tempting
since its the right structure and everything, but we need it per
process :-(

