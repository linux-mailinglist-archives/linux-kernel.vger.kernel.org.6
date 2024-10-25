Return-Path: <linux-kernel+bounces-381979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADE69B0734
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C961F22583
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054C63DABE6;
	Fri, 25 Oct 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ekoWd9D8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8Kw+wD3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945621620D;
	Fri, 25 Oct 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868661; cv=none; b=DdoAlNTxHLUjsuTOSgQ8H8ePnP+Yogh1IFa1IkO2jPf2R21Vc8lyp44oQuFUEBEEEpPGHDKSgP//1Af3XsfHVLBr7fgF5ZX2jroM8mszBEs2AoKVW0jslMcLDgyX+Dc0y3E3vQ5XQOzxb93P4Sdx3dyFaClmOs/ynl+aGxNyEJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868661; c=relaxed/simple;
	bh=mlmnQ4/sFK58UR6568F7XShCLS7ImvZOowlmC0vXTM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RmA/sZfI1tmgKte7IDPt47XIGqP9FQ/jqLzYbmCy572Jh98+YGZhMCZVMiFoJxW5ILgSDlcOFBb6eYKjx+RSsK16zQO3+4Ejt+5XIPesVJOQZiIA1ev7t6ga2mlSXmbMRZB4oErdkmgLr/XfZFKg+dQcjU41RjRgr/lBIDerIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ekoWd9D8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8Kw+wD3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUko+tsFDdkgoEEBhKPnLKM59O9aqLgte2dS9dVnswo=;
	b=ekoWd9D8j2IsU28xfOgnqNeAFgKQuKzvo4rwH0dHCXdyf2jG62AfvlKla48pyeHz6NyXtR
	D6I16/T/euzXq4RvP/gkVfGBphj/iLCDVpC2WKwxAd2i9svC86h8B3VsCIcNvHrP63sCpB
	y2NYIZDCvnNHGokDIOb4T5XoxvQhc9dzyijVs+Us5dMN3omPOqKgtDZHJBMUUj4XrPAg3U
	6rvs2Syg+au851D3Rf+dJmkWTC3V6EgjfY7K34o31MYFpEOt0Iu2Nx9f5e7Dh72PH2BCNQ
	s8GE6F9SnX+Qbwd1HvouhyDYWzfbunlsy1n53q8Lwj/b6Sl0S9Z+6QBTb3g1Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUko+tsFDdkgoEEBhKPnLKM59O9aqLgte2dS9dVnswo=;
	b=t8Kw+wD3yZYwxssG1/UFNv5CbC7NDQAQ24m4BCp9dNV5lVh7eB4xTTAw6h7wLzyk2TWvSl
	EUffb3m5cd3o/MBw==
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dirk Behme
 <dirk.behme@gmail.com>, Lyude Paul <lyude@redhat.com>,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
 airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, will@kernel.org,
 Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 wedsonaf@gmail.com, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, aliceryhl@google.com, Trevor Gross
 <tmgross@umich.edu>
Subject: Re: [POC 1/6] irq & spin_lock: Add counted interrupt
 disabling/enabling
In-Reply-To: <ZxrCrlg1XvaTtJ1I@boqun-archlinux>
References: <20241018055125.2784186-2-boqun.feng@gmail.com>
 <87a5eu7gvw.ffs@tglx>
 <20241023195152.GE11151@noisy.programming.kicks-ass.net>
 <877c9y7dwx.ffs@tglx>
 <20241024100538.GE9767@noisy.programming.kicks-ass.net>
 <87bjz95sc4.ffs@tglx> <ZxrCrlg1XvaTtJ1I@boqun-archlinux>
Date: Fri, 25 Oct 2024 17:04:15 +0200
Message-ID: <87y12c4428.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 24 2024 at 14:57, Boqun Feng wrote:
> On Thu, Oct 24, 2024 at 07:22:19PM +0200, Thomas Gleixner wrote:
>> On Thu, Oct 24 2024 at 12:05, Peter Zijlstra wrote:
>> > That is my only concern -- making insane code crash hard is good, making
>> > it silently mostly work but cause random weirdness is not.
>> 
>> I wish we could come up with a lightweight check for that.
>> 
> Since the preempt part takes exactly one byte in the preempt counter,
> maybe we could use a "incb + jo"?
>
> For example as below, note that since I used OF here, so it will try the
> byte as s8 therefore overflow at 128, so 127 is the max level of
> nesting.
>
> Would this be a relatively lightweight check?

That's definitely an interesting thought, though it adds a conditional
into preempt_disable(). We should try and see whether it's significant.

Thanks,

        tglx

