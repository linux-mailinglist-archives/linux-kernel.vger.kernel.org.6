Return-Path: <linux-kernel+bounces-368753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8384B9A147B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B8A1C23337
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDB41D27B7;
	Wed, 16 Oct 2024 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nX1zh7Af";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g3RIajQT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2B1534E6;
	Wed, 16 Oct 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112434; cv=none; b=IvZcDguZC2RYRT6PpbHmf/vmlj+oVtp5FH2fmkv5TA23SYh0ABQm6ny3mvZIZd6ACF697BxqLjW+K8hgPRhkLt+Kqovdx8rNbXSrAoVqE7k4M0qlP9DEn+3cDEPEl4NOzKxwHkbZzUKMAWaVgKDo8V/FI8LYNsNC87gqKXKOODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112434; c=relaxed/simple;
	bh=1pAsDA7PZOVbb9GLjwzKBWAwHWtXQGNuCBsMyCdPVDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fz1jVwGkiStoa24L/gAAnTjLJEXKLK+hrC09ph3aK2W2l0Ag+ZJy2TyAuYPJnEf9kJ4MOJ/qpRK8p+l0bOXyjFQimGhmdCEtvSorvMw9+ub7p1+J/gR9mF0kFgaQ5rzkOyowqGI/Nl0BEZKojEAzx5JO490gcA2V/vjAfTH3UdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nX1zh7Af; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g3RIajQT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729112431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xoaLcJKvIsnthAJTU0diSgpxqnBbNi4e4pwoTtNpLNw=;
	b=nX1zh7AfxO2eifrROVLWzzxW6Bu1RVj+gIiPqAWAuYVvpG1ucFZ1+6JO37cxZuEldxp3vI
	3a+ReYqh/zIdXRwwsOcAfZY0SGX9abb3Pe9bbDv4dsK/XCuwG2knLv5Xt3vXZpR1BvekQY
	ELDBrCjxmwjRFr/QLYtiXv8DU/DVR/3uMKE08vKB5acLR6O0b3BtgZVJaj1/I+aiVU7QQJ
	Nb9RJM266/NnPx0E355NKMAruKpQsbKTiYgccjmwYYtX5yzAJ6P72JiZCye9Xg4sw8lm7/
	R727jodCP43ftqmKWVxC4zznG3Vs004/jjInE8lVYj9PL6aeOOaOwYqIPBWkgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729112431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xoaLcJKvIsnthAJTU0diSgpxqnBbNi4e4pwoTtNpLNw=;
	b=g3RIajQTjPkOnSr7MIboQCHDizU0oU84eKVHhdaNVFgyr41NSzBVPNqdBS3ShTjaXycUyL
	0TdB+RD2HN5S2ZDg==
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Dirk Behme <dirk.behme@gmail.com>, Lyude Paul <lyude@redhat.com>,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
 airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida
 Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH v6 0/3] rust: Add irq abstraction, SpinLockIrq
In-Reply-To: <Zww-7DO8jeQfnItV@Boquns-Mac-mini.local>
References: <20240916213025.477225-1-lyude@redhat.com>
 <aef35907-b92a-4f56-a330-b4be06f11984@gmail.com> <875xpvhlgm.ffs@tglx>
 <Zww-7DO8jeQfnItV@Boquns-Mac-mini.local>
Date: Wed, 16 Oct 2024 23:00:30 +0200
Message-ID: <87iktrahld.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Oct 13 2024 at 14:43, Boqun Feng wrote:
> On Sun, Oct 13, 2024 at 09:06:01PM +0200, Thomas Gleixner wrote:
> But that makes `cv.wait()` not working, because interrtups would be
> still disabled when schedule() is called.
>
> I'm waiting for Lyude's new version (with lock_first(), and
> unlock_last()) to see how we can resolve this. We may need to redesign
> `CondVar::wait`.

Thinking more about this. I think there is a more general problem here.

Much of the rust effort today is trying to emulate the existing way how
the C implementations work.

I think that's fundamentally wrong because a lot of the programming
patterns in the kernel are fundamentally wrong in C as well. They are
just proliferated technical debt.

What should be done is to look at it from the rust perspective in the
first place: How should this stuff be implemented correctly?

Then you work from there and go the extra mile to create some creative
workarounds at the abstraction level instead of trying to mimic the
existing C nonsense.

Which in turn gives you a way cleaner pattern of implementing stuff in
rust.

Stop worrying about mostly irrelevant low level details which are not
relevant to the primary audience of rust adoption. We can worry about
them when we replace the scheduler and the low level interrupt handling
code ten years down the road.

Please focus on providing a sane and efficient programming environment
to get actual stuff (drivers) into the rust domain.

Thanks,

        tglx

