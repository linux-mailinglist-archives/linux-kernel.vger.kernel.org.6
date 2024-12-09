Return-Path: <linux-kernel+bounces-437184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A759E9015
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD989162690
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89005216E27;
	Mon,  9 Dec 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olaINdmd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55582165E2;
	Mon,  9 Dec 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739943; cv=none; b=PnJtLEyF+1RT0eimtsNjslKkIZ3/A+Nnu33trx5+7DFm1SUpS0WmYX/q8oEBZMcLKooQz87pDNwP5y4lqdPVa9YU0GIcQkmJFwg09YvzyhuKWlxWWjPUsF/H3q+JS1rjyaPvmlzw24OLbtDWLcCK/kFcZvibxi6+41ax+b8F/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739943; c=relaxed/simple;
	bh=Zac91wHIWu5I5fVoSqr4mhSSxozctAkrU6nEfurb/FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gT3/O0g1RgIK2wOlKrkNIa5HjWMvc9Hts28VV+n9x8wl4yhXTHp48kqSiHIGGwwxzBw3rNzYskmUP3Io91vU2UCGRDTn+TTOSSCChukxq+B9m0xbXVVt2RQlLdZXkcVfDGo7f0qIqm9bWGcfOr4Teu7WWps6adfRoIMVucYTkwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olaINdmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBF0C4CED1;
	Mon,  9 Dec 2024 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733739942;
	bh=Zac91wHIWu5I5fVoSqr4mhSSxozctAkrU6nEfurb/FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=olaINdmdg3SukWAmCa0FJm3x3Hggl44iy+XmhYtH6tVuLl4MVKpfLz8p1QrnhoPCr
	 JtrOARYh9r/BkPyXM3Yv3XAvTt4Hpa/RSF8DQmCTAaI3buf31452D6vGkVIriW6uTe
	 i7OAedooY4XjKfghVM4s+DxLuaNwZansBc1ki2D6YSLjRScPUFGoTSMmhxVnlKE3FP
	 5ZnN9xpyIKn7tNvtxQVGmGn6eAokBU1ls7dHHRJzt900/Jy0u3YU04UDe5wvUnLuQe
	 PmNl6VwKJyvLUWrSEKbK4idszT0hbr94IdUm5pEFyvOFzq92TouyyxWeQskVjAEQf+
	 tgfXFm4G3CZOg==
Date: Mon, 9 Dec 2024 11:25:35 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/14] rust: alloc: add `Box::into_pin`
Message-ID: <Z1bFn1uvu5M-2H9l@pollux.localdomain>
References: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
 <20241206-hrtimer-v3-v6-12-rc2-v4-10-6cb8c3673682@kernel.org>
 <BAT3INRKXEYrKMKrPQO7CCEMcwAUeqxMVpEXTwr0bSEtnG28BQbBs3q8gwhSkpJPFO2yGCqUflc7cCxOfSFsmA==@protonmail.internalid>
 <Z1Nb0dQvO0GKlMmb@pollux>
 <87ser0ec7l.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ser0ec7l.fsf@kernel.org>

On Fri, Dec 06, 2024 at 10:25:02PM +0100, Andreas Hindborg wrote:
> "Danilo Krummrich" <dakr@kernel.org> writes:
> 
> > On Fri, Dec 06, 2024 at 08:33:02PM +0100, Andreas Hindborg wrote:
> >> Add an associated function to convert a `Box<T>` into a `Pin<Box<T>>`.
> >
> > What do you need this function for?
> >
> > There is an `impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>` already.
> >
> 
> I didn't realize, but that could work as well. I was rebasing this
> series from before we did our own `Box`, and rust `Box` has this method,
> which I was using.
> 
> At any rate, I think it would make sense to have `into_pin` as well as
> the `From` impl, to match the standard library. We could always
> implement one in terms of the other.

I'm not against that -- one of my earlier allocator series actually even had
this function. However, the feedback was to rather not have it at the time.

As mentioned, I'm still fine with including this function though.

Please implement `ìnto_pin` using the existing `From` trait for the next
iteration.

- Danilo

> 
> 
> Best regards,
> Andreas Hindborg
> 
> 

