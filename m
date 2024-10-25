Return-Path: <linux-kernel+bounces-382415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E049B0D49
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6817B222AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02F220D4FD;
	Fri, 25 Oct 2024 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bnLHMFMs"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB9189F45;
	Fri, 25 Oct 2024 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880928; cv=none; b=cuYya4DzBR0K9M6X6MpCxeT539RpOiph29BuT4455ymzZ90jVpKTMMNZiFPi6C+UnSgAvGFMlwBFqiIEdUlXhOocH6cwqUkT5nftE8XeyK5zci5rSCyeVXTK35Xjb5rG5ELFDzYj5nmadRZpEJ5VhkbqhIzh+S1yK0koGypRfgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880928; c=relaxed/simple;
	bh=/aDlb0UwpoGJmp7MrRgdzgAr9m+W4eTXUR96iB2yEnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWwu542cVr1uEkDrDvXbUpHVNKPL/s80dpvDikqwh943CTfTebcFctqwYmA17l7gb7BfAJ9CPkjugzBiRpzcxOP0qNUBtiT/cisX/CdhTBBi9JjYjTV6JNo9QiF2k0By2APVimGVLB7UZazUedPsbor8OdlDqwitvcaDtTsgIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bnLHMFMs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Iqv+nUZGjuwSdtEpE3hQFxjYLll6GHjszBuIDOIhGKw=; b=bnLHMFMsDJUw2JGzRFgM5oAO8y
	lDtJafm6iBfr03HMl6X+BSoGupb+N7pBbGEohS5rQPlOQsyqIF9I7mmic5kkoZixo73nhATBG2NSm
	NT6y0SWkSWLNpFEFtRcOivh6Ajh/l+C1H3nwwui3hhhAg9lV5kVKbxKWmfhCpLF2NMUjCHuZWjwi+
	Vu5AC8SdSat6ACZat2+JAm6NPdqSCbcYhRRpCwATwc334MC4QDPpxMvt38Zl+6I7Sl0EpVZYq3oOM
	Ik6txZUELLOs23COptuMN5cPa4Ie7/V4iX3qAqNmaDe23z5qw9tIuxGMU6/8f4fRWWJEc3/KgNLsp
	AEyiOGyg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4P31-00000005VMd-0J0Y;
	Fri, 25 Oct 2024 18:28:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E015030083E; Fri, 25 Oct 2024 20:28:30 +0200 (CEST)
Date: Fri, 25 Oct 2024 20:28:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Dirk Behme <dirk.behme@gmail.com>,
	Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>, will@kernel.org,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>, aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [POC 1/6] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <20241025182830.GO14555@noisy.programming.kicks-ass.net>
References: <20241018055125.2784186-2-boqun.feng@gmail.com>
 <87a5eu7gvw.ffs@tglx>
 <20241023195152.GE11151@noisy.programming.kicks-ass.net>
 <877c9y7dwx.ffs@tglx>
 <20241024100538.GE9767@noisy.programming.kicks-ass.net>
 <87bjz95sc4.ffs@tglx>
 <ZxrCrlg1XvaTtJ1I@boqun-archlinux>
 <87y12c4428.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y12c4428.ffs@tglx>

On Fri, Oct 25, 2024 at 05:04:15PM +0200, Thomas Gleixner wrote:
> On Thu, Oct 24 2024 at 14:57, Boqun Feng wrote:
> > On Thu, Oct 24, 2024 at 07:22:19PM +0200, Thomas Gleixner wrote:
> >> On Thu, Oct 24 2024 at 12:05, Peter Zijlstra wrote:
> >> > That is my only concern -- making insane code crash hard is good, making
> >> > it silently mostly work but cause random weirdness is not.
> >> 
> >> I wish we could come up with a lightweight check for that.
> >> 
> > Since the preempt part takes exactly one byte in the preempt counter,
> > maybe we could use a "incb + jo"?

probably something like:

	incb
	jno 1f
	ud2
1:

is best, something about forward branches being preferred or somesuch.
Anyway, if we want to use the same thing for the interrupt disable
depth, we need another byte, meaning we need to compress the
NEED_RESCHED, NMI and HARDIRQ masks into a single byte.

Might just be possible I suppose.

