Return-Path: <linux-kernel+bounces-247560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A50E92D12F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C072A286DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E931D190053;
	Wed, 10 Jul 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aORXPyqf"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA518FA2D;
	Wed, 10 Jul 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612781; cv=none; b=rrFSA/wJe2GkUuCU36r003T3ahpMV80R1hnekALwrnnTC82o1MKnNkQKX2zdYYw4xgW0QeSuRXjHssC6bDfhnnSvRKls6StwP12iW0C9FbzE2OnAw9NpbRlxCETDSmRw+Xhn5TY++IWFetZnnPdneJ+B1BoErOmEbQL9wWAbopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612781; c=relaxed/simple;
	bh=WVKnzcm/NtngNFWbiRKfyh9T0w1WwExdL6PPrH+BjwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntpkYM4QWVdqoFV8Cjb+oAQFJmWkAV3no+eNg7j0ce99jYHg8CoM7yFUz77Mz3u+BkA28iQqxW7z3VmPmTqgIt67W7oIp3ZlihcAc1HbX5mRKDiw82AUPtjhc1+4B6I/n5RpquDDVBqz9qHnc380a3YVxHbq09NLTqZIIPD2zpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aORXPyqf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UpzBiezjxdVclFwDJVsEbu3tBtzGfTOZYkXqYM2ZIrk=; b=aORXPyqfJTFEMY5N1DIcQ4CsCc
	x42+97zTngIUyKXXaWMwhyXuPAY9IWMegb4XtN8bl0yN88JGnbr2dO3/RpKSoOF/F5/gaL5lwNtSR
	vNEyWQNFigtL4DtBr1b8XLHNMXnrd53SEk5vuEZYU3GeTqtjT9ACk+vd+TfzyxnNGJKEga8qYyTLU
	+0U9tH3mpi1GlUlUzxnmyBlvA4haljBdgn4job9jhUUlcBaO5B/rVgIj4tvDxvLD+LYo/lFtmCoT4
	x/l49QJwcYZN7uSDgJ95CdlhCNm95q/9qiU2Yn9Q2sXgAehQAeGD/RgKU94CyJCz0rHESPktYPxGA
	RiZnapXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRVyv-00000000tru-2PDm;
	Wed, 10 Jul 2024 11:59:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 16CF4300694; Wed, 10 Jul 2024 13:59:33 +0200 (CEST)
Date: Wed, 10 Jul 2024 13:59:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Tejun Heo <tj@kernel.org>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, x86@kernel.org, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [tip:sched/core] [sched/fair]  d329605287:
 stress-ng.resched.ops_per_sec -24.0% regression
Message-ID: <20240710115932.GZ27299@noisy.programming.kicks-ass.net>
References: <202407101139.6e513af5-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407101139.6e513af5-oliver.sang@intel.com>

On Wed, Jul 10, 2024 at 12:51:44PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -24.0% regression of stress-ng.resched.ops_per_sec on:
> 
> 
> commit: d329605287020c3d1c3b0dadc63d8208e7251382 ("sched/fair: set_load_weight() must also call reweight_task() for SCHED_IDLE tasks")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> 
> testcase: stress-ng
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 100%
> 	testtime: 60s
> 	test: resched
> 	cpufreq_governor: performance

Well.... if I read the test source correctly, this seems to test how
fast it can call sched_setscheduler(), rather than test how fast we can
schedule.

And that patch mentioned above makes setting SCHED_IDLE more expensve --
as expensive as SCHED_OTHER and SCHED_BATCH.

I'm thinking this test is rather stupid and doesn't actually measure
anything useful, I don't think I consider sched_setscheduler() a fast
path by any means.

Su yeah, *shrug*.

