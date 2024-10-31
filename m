Return-Path: <linux-kernel+bounces-390221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB929B7729
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329FC1F22ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF97194AEF;
	Thu, 31 Oct 2024 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aOezHW/H"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6629E193427
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366083; cv=none; b=OToi6PYy/sMCKjT8ZSKvM4Qck1hNC3db/QsWSZ5Ca5REROWwgWfUcED/U48bCNd/2Hfmb5wMAgLk7iBTGWDOZuO/kc0lvFHHCGfqTaCuQ7yhVQurEYjh7nqUwZ1IFrmHo98HxjJjrrqBdUMCgxM1m5+S7EukdTTqLdn4lMTUqno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366083; c=relaxed/simple;
	bh=Q8/fe+mI1p8S+lNZHFrd2oKw5+dTxee/3cHk+KF2zo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKTAUtElC/RFEsYuf70nuIdNZJh11BbERpH0feSjSaL/mRGYe7Ggv29zoRB54ukTR9eBEGLzNZpoe1r+GCZ9BK22Zej8JaK+bP2jZRsjSOMIcAuf6QFbq9RAF/D8yVZ8uDR/IkVhTYFj+tXXpojJ0RpTae7Fk8DtxTvLWhZLdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aOezHW/H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5SSyFa+5fRE7r71i50SZ7aNSuBFW0EYeDmfmLllFtgs=; b=aOezHW/HP59MjiM+2qWYPYbhzC
	Vx2TAIOeJs8CGI0SobFP6OQn1K32HO0PW/XF1ywRe0Fv0ZkGtVhUiGXd8aHMj2hd2zAO7W7ELOnyN
	JjxtvaeaqJZLCs4PmAOXdu7prtAQKx+tQhswxOOPxgb4cVmW1323Fi4//k4TociEXtqhijyty2aei
	VPssiToVIL+vNpMKjPy3stoEpW6zouGLZOixC8SmFfF7dGLZCF9lvQU5iYxfIkqUxKFovbqD07rz1
	7MIwCHxzK1VXL+RhGLxlHUlS+BFtLsDqDFhgr+Hrf6uUNj4bg3BLoBJfLYbMqcsJj9AjBaN3vfTON
	gxMDnjWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6RGG-0000000EWJe-3FXE;
	Thu, 31 Oct 2024 09:14:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 11A24300599; Thu, 31 Oct 2024 10:14:37 +0100 (CET)
Date: Thu, 31 Oct 2024 10:14:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] kcsan, seqlock: Support seqcount_latch_t
Message-ID: <20241031091437.GV9767@noisy.programming.kicks-ass.net>
References: <20241029083658.1096492-1-elver@google.com>
 <20241029114937.GT14555@noisy.programming.kicks-ass.net>
 <CANpmjNPyXGRTWHhycVuEXdDfe7MoN19MeztdQaSOJkzqhCD69Q@mail.gmail.com>
 <20241029134641.GR9767@noisy.programming.kicks-ass.net>
 <ZyFKUU1LpFfLrVXb@elver.google.com>
 <20241030204815.GQ14555@noisy.programming.kicks-ass.net>
 <CANpmjNNsDG7J=ZsuA40opV1b3xKMF0P8P3yCsufowJCRegGa7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNsDG7J=ZsuA40opV1b3xKMF0P8P3yCsufowJCRegGa7w@mail.gmail.com>

On Thu, Oct 31, 2024 at 08:00:00AM +0100, Marco Elver wrote:
> Looks good.
> 
> Let me try to assemble the pieces into a patch. (Your SOB will be
> needed - either now or later.)

Feel free to add:

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

