Return-Path: <linux-kernel+bounces-358799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5732C9983FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CD2281AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC201BFE0E;
	Thu, 10 Oct 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VnkQN21E"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08891BBBE5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556773; cv=none; b=o1HNXa4kH/5ZEGWZJjSuHZD/zkQoCoPIDVck7SB+GkvJ3z1RlFvpYbZmojPUsY549GnYuJFS1yLhLbyg5QX8Q13Zrl/JjKreXX33/4cALtpbq5+lSrSjKmDEnZnB8jhOkgfi0ADFm1T6BVnyPqUjSjDoxph2EPMstREZAmqHyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556773; c=relaxed/simple;
	bh=YFyxu7cbFv7b+4OEqrYpCc4DsCGgzwgTOlX0AT7XbDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAcXfFoXOx3OAiNdV+0IpVypfjA8StxRV4UbtzEVXbdFW6KVA1hDaGGucTmB3+jI0W0BDpnFMEvtafSRpz4lHvx3YXC3sBTgBAkMWp1FSjFOOWfxvPMFEBLivCDNzTb1CsQ9AGSchWquPBu/aiByIC3BWJ6yhjasrNlmbU2Tj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VnkQN21E; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rsTU2pvlmrMY35YXdLMqCuS2aHcDBAtxiQd0kVRv+us=; b=VnkQN21EDDuvCwXtIVZfJrRRAG
	SuyE6FWZRkDPGJuHDXyEz1JTXQRSk6bOlGL9qeiDk+9MfwIamBUJazg+jwdkHA+j51sUtXVXeTlgD
	kBBrlSAqaOueHIOxFgp7Cj5utGTKLt/QiqyXz/7AUCaZYmXKuVKcNIyYf9gSL9ylkiEKbmcKJJAtR
	EqwflgPF2l28IVU2yb9gmMf1a7HI9qnywEkBmpgPRC6leccPcBj0XYpGh9JV+ei8q4f1HeamCgCBw
	a1kevzft5+xLV9DI+gg6seXY4Tb6/x7m0PetzmjfCR+QCjljINGZLmQNJ31w2HSs4P0HIaVOBIXyl
	mtnyu/dQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syqZm-00000005LTY-3FSd;
	Thu, 10 Oct 2024 10:39:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D2A030088D; Thu, 10 Oct 2024 12:39:22 +0200 (CEST)
Date: Thu, 10 Oct 2024 12:39:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: Hariom Panthi <hariom1.p@samsung.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rohit Thapliyal <r.thapliyal@samsung.com>
Subject: Re: [PATCH 1/1] sched.h: silent false ATOMIC_SLEEP warning from
 cond_resched
Message-ID: <20241010103921.GI14587@noisy.programming.kicks-ass.net>
References: <20241010092249.GD17263@noisy.programming.kicks-ass.net>
 <20241010032653.1922214-1-hariom1.p@samsung.com>
 <CGME20241010032751epcas5p1154533995a184be3fea39325c4d33740@epcms5p2>
 <20241010100940epcms5p2f7463014f1e1cb1b27a8da300b804e08@epcms5p2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010100940epcms5p2f7463014f1e1cb1b27a8da300b804e08@epcms5p2>

On Thu, Oct 10, 2024 at 03:39:40PM +0530, Maninder Singh wrote:
> Hi,
> 
> > On Thu, Oct 10, 2024 at 08:56:53AM +0530, Hariom Panthi wrote:
> > > In case of (CONFIG_PREEMPTION && !CONFIG_PREEMPT_DYNAMIC),
> > > cond_reched() is not sleeping.
> > > 
> > > Thus remove __might_resched in that cases.
> > 
> > *why* ? It's still a valid site to do the atomic_sleep testing, no?
> 
> In our case there was a call to vunmap_pmd_range from __do_softirq,
> and vunmap_pmd_range is not actually sleeping call, but because of
> cond_resched it was giving warning with DEBUG_ATOMIC_SLEEP.
> 
> and cond_resched in case of CONFIG_PREEMPTION is empty function with below change:

By still having that warning we helpfully tell you your code is broken
for that other .config. Code should be good irrespective of the .config
used, right?



