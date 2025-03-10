Return-Path: <linux-kernel+bounces-553781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8F7A58EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C906416C4CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BB8224245;
	Mon, 10 Mar 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u82gspSR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9195380
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597051; cv=none; b=os31QaLNNpmIgYonZZgmF9Me7ytQXIWmquQYC1HZxUckbPEq/6sRgyQMTUHs/qr7NgbkKxPyUvM/CofC2ZPsQjtecbWTOgm4JHC94zvCkG+652V25lT1E6m7eC6V0FCI8BZgBSRGe4lSnbkHFg9qt+4F7WtpCEJVO2m5OptVxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597051; c=relaxed/simple;
	bh=R7EUyZOykki3qdvpNmPyLE3LC+qA9halArLzXMkHi+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaYBTtGK5mXpI0WpGVNF6SW1QSud10yKlwrUtZaxdZUsZMO4g2UFqZ+6dqNOKrUoPAVZexyofVPg6Xf3ZSJmpTBflNo25kU97nXsBs+d6DSZdVMzK0jAyR31YahrkQ+UgF9cCKY+0dvSw/UyUHqZqh4u8KZYduaiNeD0vIqGQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u82gspSR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=u+K4CY82aZx13SqQBPivh4ARaQxq35SXMkA9kjIcnhw=; b=u82gspSRFFkdCRlw2DhT1LXVQC
	wg5dFxnqEO3xZWmx7KWyUWkGLDs0kEqvSfXQqi8chJStj0DTiKty+A4kE1RcL3hldIjRA84FtL46/
	mnOygDvdCNTR/THrzVAiWgoyjuUE36965Wx4T90YaPCwjZufI11ksLnxtR2dh/Mmd/LFHg548Lrke
	JSYRb2HypLR7RXAy29Cb7rpuyLlLt88MduAQW2Eh3g5dhj31h5l2jNKhG13iwWkMiPHMe1VoeS+Yr
	Kf29LXikbA/PQfeC0GRgsD7sCiQh3prJJ3Cd2uukqx1yS1RDQnSOK9r74Mcjpc5swLxQeD2CRU0eQ
	X2CC8GZA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trYws-00000002lc4-1dCA;
	Mon, 10 Mar 2025 08:57:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E14DB300269; Mon, 10 Mar 2025 09:57:21 +0100 (CET)
Date: Mon, 10 Mar 2025 09:57:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Yafang Shao <laoar.shao@gmail.com>, paulmck@kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com, sboyd@kernel.org,
	christian@heusel.eu, kernel-team@meta.com,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] clocksource: Defer marking clocksources unstable to
 kthread
Message-ID: <20250310085721.GP16878@noisy.programming.kicks-ass.net>
References: <11d36fdd-55c2-4f3b-96b1-dd442f759ba0@paulmck-laptop>
 <87plir32as.ffs@tglx>
 <CALOAHbDhKzaj93PcQReEGk-omw7s5xXVj_X=+by1r6c0G4aV3A@mail.gmail.com>
 <87ecz62nn4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ecz62nn4.ffs@tglx>

On Sun, Mar 09, 2025 at 05:07:43PM +0100, Thomas Gleixner wrote:
> On Sun, Mar 09 2025 at 19:36, Yafang Shao wrote:
> > On Sun, Mar 9, 2025 at 12:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> So as this got introduced in the 6.14 merge window, the proper fix is to
> >> revert commit 8722903cbb8f and send it back to the drawing board. It was
> >> clearly never tested with the various possibilities which invoke
> >> mark_tsc*_unstable().
> >
> > Hello Thomas,
> >
> > It has been reverted by the following commit
> > b9f2b29b9494 ("sched: Don't define sched_clock_irqtime as static key")
> 
> That does not help much because the commit is in the sched/core branch,
> which is scheduled for the next merge window. But this wants to be fixed
> in Linus tree before 6.14 final. Peter?

Bah, sometimes I get confused by what's where.

I suppose I can pick that one commit into sched/urgent, hmm?

