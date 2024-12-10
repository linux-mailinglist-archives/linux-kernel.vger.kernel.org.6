Return-Path: <linux-kernel+bounces-439552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC52B9EB0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA64F16A676
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CAC1A2C11;
	Tue, 10 Dec 2024 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aHE6lsUg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587523DE98
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834139; cv=none; b=BqVf8dZh0YUPSFCDAQWfpwAH4U5/JaSR+i1jL6ORtwD+GzRG1sHNIOr6p7zY9aObF58r8ZkpyOZhk60RBibeX0BVzSDTabP5x7uGdJqMA/g3DhxNAY6oqwNEJLtaLF5z3klGPZIsUKN3qzs8G0HGFRInL/xkrlwnTTySxK2TavU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834139; c=relaxed/simple;
	bh=ncWhNdT23h4BZB7r2dCD0sWFbOJgD9ZDMZB6zOQ0l34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSf8YIecS4+rWgFKXHP2pE75RRxqD+Bx4HXngE8D9U6I/jvtcjSFCA4A4UTOAOXsWHy4Q8OlDDJ3iyIs9tXERTIcyfKgFERivLLAqfw0KDnE/vxmPIInz2t1V+fVrpwTdzcSYMavVn985HKKUwM6PRrgw8XRDgNnxMKQKMLQrhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aHE6lsUg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ncWhNdT23h4BZB7r2dCD0sWFbOJgD9ZDMZB6zOQ0l34=; b=aHE6lsUgVm45ornywatzVk6O4o
	uNS9a1vhbakQ3wm8q+E20mktT38HG5iff44bClu/h1dRUeJOVDHu8U+AypsSxaG4aPttB6Tjx0QVc
	TiZ+GfmTB2equN0GXN1avFN5OHW9fOW38hsqNyPn7DGIZzVZnkil0NWUQyfmxUVDr3xNBdXCMtTJm
	opphwPBk9P4rZR29WVzUyGJofo4o1tkw2TT0Lfg3RV+RCFHVGTb9XnSbzfAoKf/YrXSLHfxmg2qDT
	C+VNo+E9nnxP4gYQF/WE2jVWQbkHxEyrOJZ3yhZI334XWTVQCRDqVuRji+AYzCWU26sDcHZgtz7V/
	EdazKacQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKzSP-00000009GaQ-2q5h;
	Tue, 10 Dec 2024 12:35:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E5C54300402; Tue, 10 Dec 2024 13:35:16 +0100 (CET)
Date: Tue, 10 Dec 2024 13:35:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Atharva Tiwari <evepolonium@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>,
	Feng Tang <feng.tang@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 tsc: avoid system instability in hibernation
Message-ID: <20241210123516.GP8562@noisy.programming.kicks-ass.net>
References: <20241210062446.2413-1-evepolonium@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210062446.2413-1-evepolonium@gmail.com>

On Tue, Dec 10, 2024 at 11:54:18AM +0530, Atharva Tiwari wrote:
> System instability are seen during resume from hibernation when system
> is under heavy CPU load. This is due to the lack of update of sched
> clock data, and the scheduler would then think that heavy CPU hog
> tasks need more time in CPU, causing the system to freeze
> during the unfreezing of tasks.

Please tell me more.. what crazy things are happening?

