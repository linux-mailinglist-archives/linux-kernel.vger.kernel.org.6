Return-Path: <linux-kernel+bounces-263726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0793D9C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71712832AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F9E143C6C;
	Fri, 26 Jul 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fezxLCxZ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD721F5E6;
	Fri, 26 Jul 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025596; cv=none; b=tJx89Q2PKCK1anRGmMx5AO6jXSrlQXuXruYts+sz5KMMIhPLRY9hdwMp30yBTWgCRdv4HOn8i8M7cbH8Z1WGgtJ50fJF9tgUrlujU3Kuksou25agaOlJBLt5oL6I+DtidmOSOcQeyFey6k8D4V3tPYs2x8QMl/kF8WArWbOUmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025596; c=relaxed/simple;
	bh=6jcBRzEFQkDwSQdjr3UM7bYQy8uUY6mj2Mlfv2VOvRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4UtKL7ZeUa/5C6hwOsvXTRbjb6An6b+5zrp2jIcuhSSjbL5a6YHCO/wzSUaZnIrCT/CFe2QNbMdj9yJdfi11cIMObErGSlUboV/Zs13dJGG2gBhXN8CoUt0MYdcnKHFCyGAdFBENcL2n/Q3CddsP1tXQjzJkqJQgUEhYf41W2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fezxLCxZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6hnOTDAIEETmkCuxLtX8Ni4bnzSbDQoK8gy+nVOrZQM=; b=fezxLCxZAH0MrLZTLKSNAszjyh
	6Rp1K2ITSlIrPdrBaWTYJZ9042FNq8RlvBt/v8niC4QjXKjprXpAaihKlvX443Xr1FV9UyyQj8rc/
	BLM/CZXx529dzL7xj1XdaN5jDgt5KBE1eA7/VZ8eq7VfEXi7o9TDKdUC2vb/5Wp73l6NNFFm7ichl
	IvNGGuvq7153qleWd0zvAzlR0nZgTpD+d00CuYBwZX3rCxR6iX0jOrje2C7iw0fbomxx6UWXZOFQo
	JL012TXd+U99wtXqnXBeHZxxDat4iP4LxLBChHqJv0GR5I1ap/k7jwlWpzSeZdQIBkhSKBpEq8y+C
	SvJiAgJg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXRVz-00000004IM4-3ZAu;
	Fri, 26 Jul 2024 20:26:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A54B130068B; Fri, 26 Jul 2024 22:26:10 +0200 (CEST)
Date: Fri, 26 Jul 2024 22:26:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: sync: Add IrqSpinLock
Message-ID: <20240726202610.GU26599@noisy.programming.kicks-ass.net>
References: <20240725222822.1784931-1-lyude@redhat.com>
 <20240725222822.1784931-4-lyude@redhat.com>
 <20240726074845.GM13387@noisy.programming.kicks-ass.net>
 <018a49c380568a817f57cfa47a3f7504d03519e9.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018a49c380568a817f57cfa47a3f7504d03519e9.camel@redhat.com>

On Fri, Jul 26, 2024 at 04:21:09PM -0400, Lyude Paul wrote:
> On Fri, 2024-07-26 at 09:48 +0200, Peter Zijlstra wrote:
> > On Thu, Jul 25, 2024 at 06:27:52PM -0400, Lyude Paul wrote:
> > > A variant of SpinLock that is expected to be used in noirq contexts, and
> > > thus requires that the user provide an kernel::irq::IrqDisabled to prove
> > > they are in such a context upon lock acquisition. This is the rust
> > > equivalent of spin_lock_irqsave()/spin_lock_irqrestore().
> > 
> > So aside from the horrendous camel-case thing, why are you naming this
> 
> Also - sorry I didn't notice this comment before, but I wanted to respond
> since it seems like you may not be aware: camel case is mandated as part of
> the rust standard:
> 
> https://rust-lang.github.io/api-guidelines/naming.html
> 
> Of course the kernel has its own coding standards that we need to conform to
> within reason! But if we tried to ignore camel casing for rust code we'd end
> up with rust code where everything would be mixed between types from core
> being camel cased and types from kernel crates not being camel cased.

Yeah, I'm aware, it is one of the very many reasons I find it very very
hard to like Rust :/

