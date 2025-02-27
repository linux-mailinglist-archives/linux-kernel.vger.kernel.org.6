Return-Path: <linux-kernel+bounces-536589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88E3A48173
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14947A9A45
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F7C235BE8;
	Thu, 27 Feb 2025 14:29:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB923315F;
	Thu, 27 Feb 2025 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666551; cv=none; b=LwI4ibp6GpNv4/RwdWXtdPUI4eNo24pc+59b6HHJbLvKbk18XYeeHNimH4ZPzedOhWkW6Yi4SX1bl8ZUxCmunfVfiJMZRySRPcdudz3RS9jzdmmH4R2Zax+sMUxOAs8zQDBGCTvq0A/rmjvUZ7EgN1pM8sBblpFd0IjcvXKuwEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666551; c=relaxed/simple;
	bh=SR4n4RWYTAfQnMYeY0Z6B8JFxcbPm5d7iAbrsJxtYZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chPcg6UmWnHdhW2grI97q5vJGgKiszO+ca8LOsf8o1ej21SkvrpkUPa8ogaL2KHMg936Mz+32VMcLTAl7DQvRRw9vSR4VpRtv+zLCW7dxqteQ+ITrVIl4aeUXc3mn3T4zk8wgq749BWKzo26zxz7Hf+3NM04CZaIGIFxlcy+cpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9650DC4CEDD;
	Thu, 27 Feb 2025 14:29:07 +0000 (UTC)
Date: Thu, 27 Feb 2025 09:29:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ralf Jung
 <post@ralfj.de>, "Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250227092949.137a39e9@gandalf.local.home>
In-Reply-To: <2f5a537b895250c40676d122a08d31e23a575b81.camel@tugraz.at>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	<20250222141521.1fe24871@eugeo>
	<CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
	<6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
	<CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	<CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
	<CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
	<CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
	<5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
	<CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
	<ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
	<CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
	<09e282a9c02fb07ba4fc248f14c0173d9b19179a.camel@tugraz.at>
	<CAHk-=wjqmHD-3QQ_9o4hrkhH57pTs3c1zuU0EdXYW23Vo0KTmQ@mail.gmail.com>
	<2f5a537b895250c40676d122a08d31e23a575b81.camel@tugraz.at>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Feb 2025 07:56:47 +0100
Martin Uecker <uecker@tugraz.at> wrote:

> Observable is I/O and volatile accesses.  These are things considered
> observable from the outside of a process and the only things an
> optimizer has to preserve. =C2=A0
>=20
> Visibility is related to when stores are visible to other threads of
> the same process. But this is just an internal concept to give
> evaluation of expressions semantics in a multi-threaded=C2=A0
> program when objects are accessed from different threads. But=C2=A0
> the compiler is free to change any aspect of it, as=C2=A0 long as the=C2=
=A0
> observable behavior stays the same.
>=20
> In practice the difference is not so big for a traditional
> optimizer that only has a limited local view and where
> "another thread" is basically part of the "outside world".

So basically you are saying that if the compiler has access to the entire
program (sees the use cases for variables in all threads) that it can
determine what is visible to other threads and what is not, and optimize
accordingly?

Like LTO in the kernel?

-- Steve

