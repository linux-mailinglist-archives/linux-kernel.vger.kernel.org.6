Return-Path: <linux-kernel+bounces-535057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB06A46E43
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4903AC564
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3563E26E14B;
	Wed, 26 Feb 2025 22:12:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04DE26B968;
	Wed, 26 Feb 2025 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607962; cv=none; b=u1zgnpEw0I8saw9kOW1eRp+4EwocNSzUUlHlpITUgkci9gwldkFliJt36j7XBJ3CQIXqWFbmb3dY52fIZTmcKPTqC2RxK/80IxmM3f+2EBU32FxpXAA7CI5LzaRryX/7BI6G9Bg5o/1CR5Gq7XRn4kki9G4T2gTiZP761OfZrKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607962; c=relaxed/simple;
	bh=b9p2oinWw2oCx1q5fKm/fozu+hAAAf97Q6gyM8373gY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWZUiIXocSNbcWUn3XJw1vqO6erOo9Va+L5pAU0fZ9TXZ9bUVHb2pN+t3ER9v8qu0t5S1jLBWjLvTlSkh+8tDk7x1tIcuXug2Rtq0h1y5ALDq2ZehiPoSB6gBWWPfs8qNoFBfh2K/09qj7axgk1BdJR2QzBxGTtLN7DUQOXPhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4498DC4CED6;
	Wed, 26 Feb 2025 22:12:40 +0000 (UTC)
Date: Wed, 26 Feb 2025 17:13:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Uecker <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>, "Paul E.
 McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Ventura
 Jack <venturajack85@gmail.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250226171321.714f3b75@gandalf.local.home>
In-Reply-To: <20250226165619.64998576@gandalf.local.home>
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
	<20250226162655.65ba4b51@gandalf.local.home>
	<CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
	<20250226165619.64998576@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 16:56:19 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 	r = *p;
> 	if (r > 1000)
> 		goto out;
> 	x = r;
> 
> to:
> 
> 	if (*p > 1000)
> 		goto out;
> 	x = *p;

And you could replace *p with any variable that is visible outside the
function. As that's where I have to remember to use READ_ONCE() all the
time. When I need to access a variable that may change, but the old value
may still be fine to use as long as it is consistent.

I take this is what you meant by following what the code does.

	r = global;
	if (r > 1000)
		goto out;
	x = r;

Is the code saying to read "global" once. But today the compiler may not do
that and we have to use READ_ONCE() to prevent it.

But if I used:

	if (global > 1000)
		goto out;
	x = global;

Then the code itself is saying it is fine to re-read global or not, and the
compiler is fine with converting that to:

	r = global;
	if (r > 1000)
		goto out;
	x = r;

I guess this is where you say "volatile" is too strong, as this isn't an
issue and is an optimization the compiler can do. Where as the former
(reading global twice) is a bug because the code did not explicitly state
to do that.


-- Steve

