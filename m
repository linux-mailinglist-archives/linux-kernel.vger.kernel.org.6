Return-Path: <linux-kernel+bounces-390274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8230C9B77CA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323921F233D3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3757193427;
	Thu, 31 Oct 2024 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sFOG+idh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030414B092
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367963; cv=none; b=mF6tvaOdS2CJ5Tj0cdOOBo0FXCiUImLq+SX8YVcIich4DOuAJ6yTNu5f/X8vOH+w5PcmKqRHDzEYVakccxtamw9KN1jVUplxjh3med/q97+/bESpfH1ePshkyL8SrqSPnIeX18fu8hy4s1X6ekZMaW+kuFc/NOENqCuCxrWD7PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367963; c=relaxed/simple;
	bh=YH4+zXopf6v9RbC4fd4HXCu1ql50pAXAuYUE1VrEYtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qil5pAXmbj/ktXVhXJfJ5Ox/4u57dqESNYQ6ipP/ajy6GRh9ft23S07y52Z+4M6c2VDVsN5KaYcyUy4j2utZgP4FgpEZvw1x6uCC9PVaZcsgTSMcBDFmnRWPlwyJ8k+yYw/NVtzDudlmzFEuSD6amS1FY6ScxDt4y9ScTwFeaAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sFOG+idh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7KDYcR2EWRkw7tyRb76XkWQQeArKRw2kIE2yXeLOiHs=; b=sFOG+idhqxoAbcciVhEFREAZQJ
	YVqz728H3JSheP6FzP3hfVBQrHJIk8AhNZlUwPIy0dDgZ9Y9yULtWX5mWpmatx56puu1HndXPziZF
	FBxN6bnlBNJaspSgMJ0ZIGtF9YxtZcbIRVbZiEY0AOs0RzZ8mqwQ39Xpzmqi7P6+ZeUu7OgkSsOwd
	rcGEWbTauLbwKzcie2QXhh6Ayct5rX3rYYboewMzfvMBHG1/6rRg0ppnz4xWcK8ewWvTu+DAPaOkn
	w8A/tJTFAjQK0WFs5/dMncjT9/t34/RPequoYVby0dwtL7xzjmZkKq4ZMmkmPg907q1TljgM388a6
	E+U2s1xw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6RkV-0000000EXmg-3PVg;
	Thu, 31 Oct 2024 09:45:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C3C3C300599; Thu, 31 Oct 2024 10:45:51 +0100 (CET)
Date: Thu, 31 Oct 2024 10:45:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Ian Rogers <irogers@google.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH 3/5] perf: Add pmu get/put
Message-ID: <20241031094551.GT14555@noisy.programming.kicks-ass.net>
References: <20241008183501.1354695-1-lucas.demarchi@intel.com>
 <20241008183501.1354695-4-lucas.demarchi@intel.com>
 <20241014173246.GI16066@noisy.programming.kicks-ass.net>
 <lunkl4llip7aafnyctwztggum37wsiznktb7z3ly73batmt6bu@m75kow4b4u6y>
 <20241014192519.GN16066@noisy.programming.kicks-ass.net>
 <20241016120302.GP33184@noisy.programming.kicks-ass.net>
 <qtivtftbdvarukcxdr4yfwstzvnh4z7eipukwxymi4e2x76y54@dxqn3y22u2pw>
 <20241022215210.GA31953@noisy.programming.kicks-ass.net>
 <aj62ufd6pjv74bhxsynyxvir3s5jdncsljczoucdjvibfkglp4@22nc72qnhpa2>
 <kouwyypgqthwklgdlckavoasu3bbjmustsxp3sncztztijmykd@djnbwa4sm4wz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kouwyypgqthwklgdlckavoasu3bbjmustsxp3sncztztijmykd@djnbwa4sm4wz>

On Thu, Oct 31, 2024 at 12:07:42AM -0500, Lucas De Marchi wrote:
> On Wed, Oct 23, 2024 at 12:07:58AM -0500, Lucas De Marchi wrote:
> > On Tue, Oct 22, 2024 at 11:52:10PM +0200, Peter Zijlstra wrote:
> > > On Fri, Oct 18, 2024 at 02:46:31PM -0500, Lucas De Marchi wrote:
> > > 
> > > > I will give this a try with i915 and/or xe.
> > > 
> > > Less horrible version here:
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/pmu-unregister
> > > 
> > > I've just pushed it out to the robots, but it builds, passes perf test
> > > and your dummy_pmu testcase (for me, on my one testbox and .config
> > > etc..)
> > 
> > It passed for me as well with both dummy_pmu and with i915. I have some
> > changes to igt (i915/xe testsuite) that should bring some more coverage.
> > I minimized the pending test changes I had and posted to trigger CI:
> > 
> > https://patchwork.freedesktop.org/series/140355/
> 
> Our CI also didn't trigger that pmu issue and the test could run
> succesfully.

Excellent.

> I did get a report from kernel test robot though:
> 
> https://lore.kernel.org/all/202410281436.8246527d-lkp@intel.com/

Yeah, I think I fixed that one, but the robot gifted me another one that
I still need to find time to address. I'm hoping this weel.

I'll repost properly once I fix it.

Thanks!

