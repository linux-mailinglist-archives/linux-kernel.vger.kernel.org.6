Return-Path: <linux-kernel+bounces-377034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0479AB906
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C55B22023
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3321CC170;
	Tue, 22 Oct 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pwLNbUVP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48DE136E21
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729633949; cv=none; b=Bf88sWtZ0EY6oCtTOwWtrmfEfo+vJ0mNTW6jFvOJ3lcY4tVKaCgxEk+Kpt4iCLgKyLrgpZInzL8kdQIXsvBVd5ICsv4RQNIIIj4IWXK9gIH4TNDLFnEvjZ8Q/+qMLFINChW7SUBwli6qktuCsZ1kVGQIXXlambulFDHhvM/kEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729633949; c=relaxed/simple;
	bh=sx67XtoqX7DYUfE5EgXVY291TTwxiRJDjsZNR2whL6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8OfVQm6H0M1ZhXWGCFHyqpFtOf9+084nL0XbM5ulN0uDgJ18uTEmCiUlO/GmjbZLfGvEJw9MbyxhgxWcsvv9tENsWsivmwZ5oShEeehKncVkavVzT/rfaPmx06SDxLQij/21o3QpS6w2PQeOnWvLQFbvF97963SUWtD5QXk6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pwLNbUVP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hZaaZxezYJoPjgvUIQ46ARJxZfsSw3SrOrxGEnlPJV4=; b=pwLNbUVPP/BuC0hUfq5oCm5rm3
	NrhmhwwsjsH1NT3DeO8npLVkd5zH7P6lwik62WRkFztWgcJWYLjz3enRDtAjBaOHqwPPVn4lSrWPj
	GIkfnuEsmtd7a/31DfPj0gElM/iSGGzHcPedLrL0RjzJbRCY/GiVzMLzzwv2weIVJuLkNEfUxHAso
	8+VHiDPrdef0oiQPaCbrHAgDJ02vufYpHj1IFOJNqobZr1mLUKPcdmns8uzAj1BZsuZrE9k3jW8wT
	8o1nw0nzni2TIFtfxAyi5c9gGw2Hrr8AIgSCJpCyqBCg0oGBWF66kwiUhIhpSODi7u8yr4e1VY3yE
	nfdlwUoQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3MnT-000000024qp-0OXY;
	Tue, 22 Oct 2024 21:52:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CB76130073F; Tue, 22 Oct 2024 23:52:10 +0200 (CEST)
Date: Tue, 22 Oct 2024 23:52:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Ian Rogers <irogers@google.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH 3/5] perf: Add pmu get/put
Message-ID: <20241022215210.GA31953@noisy.programming.kicks-ass.net>
References: <20241008183501.1354695-1-lucas.demarchi@intel.com>
 <20241008183501.1354695-4-lucas.demarchi@intel.com>
 <20241014173246.GI16066@noisy.programming.kicks-ass.net>
 <lunkl4llip7aafnyctwztggum37wsiznktb7z3ly73batmt6bu@m75kow4b4u6y>
 <20241014192519.GN16066@noisy.programming.kicks-ass.net>
 <20241016120302.GP33184@noisy.programming.kicks-ass.net>
 <qtivtftbdvarukcxdr4yfwstzvnh4z7eipukwxymi4e2x76y54@dxqn3y22u2pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qtivtftbdvarukcxdr4yfwstzvnh4z7eipukwxymi4e2x76y54@dxqn3y22u2pw>

On Fri, Oct 18, 2024 at 02:46:31PM -0500, Lucas De Marchi wrote:

> I will give this a try with i915 and/or xe.

Less horrible version here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/pmu-unregister

I've just pushed it out to the robots, but it builds, passes perf test
and your dummy_pmu testcase (for me, on my one testbox and .config
etc..)

I'll let it sit with the robots for a few days and if they don't
complain I'll post it.

Thanks!

