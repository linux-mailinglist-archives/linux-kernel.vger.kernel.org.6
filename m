Return-Path: <linux-kernel+bounces-392244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC649B9166
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703DB1C21BFC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B719E826;
	Fri,  1 Nov 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gb/pO6j3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8519CC3D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465834; cv=none; b=QWcmJQdOCKHuZWGzu5xRaNNBKAcX6w6oHpd1exJpHNh1iQr8yE42hnSkNZdHwMM3iXedxah8vmnf30apzlHIdOM835SVG2RfHMKYLnFwEt2YeXIGqdCzsUy4KczKuqMznGSouGKCdf/YEg8UgAlkNPmzARs/Y+bfiQ50YTIpZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465834; c=relaxed/simple;
	bh=1xgmAYR8gOJhNz5+vsmXGkOTW+5Z1pXG1kucwiBhuD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSsYk7DoFGijNvXuY9sGkJLVJ4FueBkJIPAOMlDWx7MsOjT/flJBwcgTufXWy1jyn3ftiPHLFZfI70s/wdBxo85ylLZZ3KLBG+io5d1kax31Q+4F716c16orw+3Ty/W14VVoNTrdoDMbGy51uNM0IMq3Bz6iQXumLjTN4wA/dNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gb/pO6j3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BJ3x7dwMTyYsrCAAfzTilxpM34ub+Eoo3YNGVgtXFQY=; b=Gb/pO6j3MgUp8mEYF9HNqPFBZ3
	fRQQsJf2Fabt6+DCEMlC6gwedwNZC59R09aUrkOklddz1JmLR1bQ24v116sY2IB25bEKIIAJvxaeH
	IMz3i4yjG1XaeTLHIJQE4ijzfYFVTBnX4DhZHdPTbviKjf06KOichq5oPzY9Ka0fJw1mgmzkFXJp0
	OQvJYEDN41GXUk7nlVHX9Dm+X98R1g9jxYdTOPL2MT7XufqDkx+QXfB6M7u1cVH7zD5lnvMmN4sK3
	4nGQMGVGt2HlMNuop31Sg1oR6qhOJI+1Qb6PEJURgcGK1aW9OICkaMwaTikmVuKsxl6EJkCZNFg+h
	HtZ2OiVA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6rD2-0000000FrQK-0jHJ;
	Fri, 01 Nov 2024 12:57:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CB772300599; Fri,  1 Nov 2024 13:56:59 +0100 (CET)
Date: Fri, 1 Nov 2024 13:56:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Phil Auld <pauld@redhat.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241101125659.GY14555@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101124715.GA689589@pauld.westford.csb>

On Fri, Nov 01, 2024 at 08:47:15AM -0400, Phil Auld wrote:

> This one is causing a 10-20% performance hit on our filesystem tests.
> 
> On 6.12-rc5 (so with the latest follow ons) we get:
> 
> with DELAY_DEQUEUE the bandwidth is 510 MB/s
> with NO_DELAY_DEQUEUE the bandwidth is 590 MB/s
> 
> The test is fio, something like this:
> 
> taskset -c 1,2,3,4,5,6,7,8 fio --rw randwrite --bs 4k --runtime 1m --fsync 0 --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --nrfiles 1 --loops 1 --name default --randrepeat 1 --time_based --group_reporting --directory /testfs
> 
> In this case it's ext4, but I'm not sure it will be FS specific.
> 
> I should have the machine and setup next week to poke further but I wanted
> to mention it now just in case any one has an "aha" moment.
> 
> It seems to only effect these FS loads. Other perf tests are not showing any
> issues that I am aware of.

There's a number of reports -- mostly it seems to be a case of excessive
preemption hurting things.

What happens if you use:

  schedtool -B -a 1-8 -e fio ....



