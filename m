Return-Path: <linux-kernel+bounces-576749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B058CA713F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D56F1893E87
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A31AF0A7;
	Wed, 26 Mar 2025 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BA2qqilB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65F1ACED3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982172; cv=none; b=iKqJeUdVeIh3yVQHHg7QfIxfpV5lgo+4hSA7S/g1Kkv4Jja5lDVe6w0vRSR8tKW1pYSDs5IpaUJeSZbEKiRR0boF700r3S/1x1HHAT6gDoayOOj81XAPDkK07plQE0YQOH7qww90VdMj3j8WxrW/MuJKOs0giZnOYnSKRgzPwiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982172; c=relaxed/simple;
	bh=0oKN0Fyy7TrhzBzexnKUaq4qDZJ/sXT1MYr7ulG9Qjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH/0CXpSG2jyM2wu64nn5+49Z1+4NimzJxgbu3kYmc/GHXtfboQx6ZWnYO7kPi1+I5SKt+dkBtgOCXNBc6PCTwpJLGsJQZfKI2MWgkYkoJrqnqxeRUit7FSqou/jm0NKFE+RwUYoJM4abbUAcEPFeYpOzVDcHf+C0qxlBCXYAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BA2qqilB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0oKN0Fyy7TrhzBzexnKUaq4qDZJ/sXT1MYr7ulG9Qjk=; b=BA2qqilBfrOQj4gGiCb99bb13t
	3d0vJCd7i6PlCuNE6XBFrx/6lcBxn6PI8y6DM7Ehi9cGQqQCW06ibRngewE7mUkpTEoH8FLXrQJJI
	Q6c87xAT8k7NNNnayPbRmWbm9SkBcRJs/cs2+zCzG/7mwWN4GtbZq7M/3YBz2PyONr96aiMoJLcYE
	Df32hztETts+KYccgPQt8jUSqyyNlkhavKtKsSv+nhasWFzCl1kRFU2T+MZ7MUBcn+ijo2MOK8rpr
	W4T2ZdEtzukWZlmcif4KJgfdkXAs2Jmn6U2T8ZeJQ7gBTA3iA0D9xNZC8vj1L3ZuloeqnSrKw6960
	6opCki0g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNHX-0000000HKsa-1EcS;
	Wed, 26 Mar 2025 09:42:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D88E83004AF; Wed, 26 Mar 2025 10:42:42 +0100 (CET)
Date: Wed, 26 Mar 2025 10:42:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	tim.c.chen@linux.intel.com, tglx@linutronix.de, len.brown@intel.com,
	gautham.shenoy@amd.com, mingo@kernel.org, yu.chen.surf@foxmail.com
Subject: Re: [RFC][PATCH] sched: Cache aware load-balancing
Message-ID: <20250326094242.GD25239@noisy.programming.kicks-ass.net>
References: <20250325120952.GJ36322@noisy.programming.kicks-ass.net>
 <4cd8ba54-8b9e-4563-8fbc-1d6cd6699e81@intel.com>
 <20250325184429.GA31413@noisy.programming.kicks-ass.net>
 <17d0e2be-6130-496f-9a80-49a67a749d01@amd.com>
 <78508c06-e552-4022-8a4e-f777c15c7a90@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78508c06-e552-4022-8a4e-f777c15c7a90@intel.com>

On Wed, Mar 26, 2025 at 05:15:24PM +0800, Chen, Yu C wrote:
> Thanks for running the test. I think hackbenc/schbench would be the good
> benchmarks to start with. I remember that you and Gautham mentioned that
> schbench prefers to be aggregated in a single LLC in LPC2021 or 2022. I ran
> a schbench test using mmtests on a Xeon server which has 4 NUMA nodes. Each
> node has 80 cores (with SMT disabled). The numa=off option was appended to
> the boot commandline, so there are 4 "LLCs" within each node.

We really should look at getting the SnC topology even without SnC being
in use.

The sheer size of these LLCs is untenable.

