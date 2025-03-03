Return-Path: <linux-kernel+bounces-542565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6371CA4CB24
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDC217419B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80D922DFB6;
	Mon,  3 Mar 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HFR5Nxab"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F920F09D;
	Mon,  3 Mar 2025 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027369; cv=none; b=BosaqVngDb/E74CyKrgc0g2MoRLmhEMege1w0uIOxn/bp36/zHmiwsaRTg10CPNaCuOPpfDEMRqPplemx/+JcRHaTFPBP4IvtNBWgtkTVUndwmASD8FL7T2tXnIP2ts0K2Rgqne54wTIFRGbmTkqvG5K+UIFpq5nljQC44elA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027369; c=relaxed/simple;
	bh=K1AkAgN7ZRf8Mrg47kNl3fz4g4KHlXhzpSUh/NBiP9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUsLnGKhpnS80SEFzTuosyCbZH4X3c/lObMz/j6kaLXkSqziDT2BUhAehvOugkqxshuje1ApdmevsHbQlnZLJBos17GfTM9HRNHxoJE6btVGRzWWEzJLOO+Xz+nWa5fZKwVGUozyVpVBDeaSuAhZv53+oZrOrp+xFB6YUXYkULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HFR5Nxab; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PqPGO8jyp+1cRsyxsj1BJJQydzk97c227dyWjDsQP/U=; b=HFR5NxabM0k6SlgmT3D1RQEbie
	ic8XOnsYMvkUl0bEPKYBpHWiyD9oFYcBWbNSW5UcIaz16MV8Rh6RFNuJe0zY9DvKb2+sJeFITa7YK
	7oz29Dt0AIfpR51X5OqUki/Cn+CQY8Z/SbHFMKFvNG+JBJwDb63E0STn7crKjYqZKFPwcmwVOXAdu
	Rm9eLleG+pJEJrhuourdejOOQIlx8NwJzkVIOBKmauJl95ojbRdd7qxSdobz1EjlntZhLqmJ4/gwD
	PBezC4RNU8+Y/ZNrvnMk7JqPqgznIwULjc/ofJcsnvO0KUV/xIG5Rm6mSGVRf6wCGJxvIympW1jU4
	7jCjnJ0w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tpAkT-00000004bPX-1I2S;
	Mon, 03 Mar 2025 18:42:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8D40030049D; Mon,  3 Mar 2025 19:42:40 +0100 (CET)
Date: Mon, 3 Mar 2025 19:42:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: mingo@redhat.com, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: Re: [GIT PULL] LOCKDEP and Rust locking changes for v6.15
Message-ID: <20250303184240.GB15322@noisy.programming.kicks-ass.net>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z76Uk1d4SHPwVD6n@Mac.home>

On Tue, Feb 25, 2025 at 08:12:03PM -0800, Boqun Feng wrote:

> Alice Ryhl (2):
>       rust: sync: Add accessor for the lock behind a given guard
>       rust: sync: condvar: Add wait_interruptible_freezable()
> 
> Boqun Feng (1):
>       rust: sync: lock: Add an example for Guard::lock_ref()
> 
> Mitchell Levy (2):
>       rust: lockdep: Remove support for dynamically allocated LockClassKeys
>       rust: lockdep: Use Pin for all LockClassKey usages
> 
> Randy Dunlap (1):
>       locking/rtmutex: Use struct keyword in kernel-doc comment
> 
> Ryo Takakura (1):
>       lockdep: Fix wait context check on softirq for PREEMPT_RT
> 
> Waiman Long (5):
>       locking/semaphore: Use wake_q to wake up processes outside lock critical section
>       locking/lock_events: Add locking events for rtmutex slow paths
>       locking/lock_events: Add locking events for lockdep
>       locking/lockdep: Disable KASAN instrumentation of lockdep.c
>       locking/lockdep: Add kasan_check_byte() check in lock_acquire()

OK, done!

Thanks, and sorry for being tardy, somehow time got away from me :/

