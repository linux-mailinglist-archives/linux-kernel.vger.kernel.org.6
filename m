Return-Path: <linux-kernel+bounces-534968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E584A46D60
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7FB3A7862
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0F425A32B;
	Wed, 26 Feb 2025 21:26:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37163223321;
	Wed, 26 Feb 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605178; cv=none; b=d1tPnyu63/a85bEAbiRAZV3J4dDO8uXVN1J2tr9FmuHfMWfrXCCogCPiEYO1rgww6EY8eghJDfSuDRE+TBd6Ck8704xkto11ITE/JjSV/3FbFTNAVaKsDUqaw8lM5RmwppKdIfdVTeKRBWz9iuiBxtsMSd2sftNyDq/HTWSAaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605178; c=relaxed/simple;
	bh=Yp/mMIwMpxDeFoFPJUGlW9naor6FAFBdrMt76B+P2rU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBGwYIL4VL2bRZnFjJBx1m05PhiXWR44O/FNBExfTm4ycxbBkaQNbhZw31kW5X3w7hfzGeCOXhb+QCb0GPztGANkD3qIbJrmel1lqda+tzJCo50Vi+5xuJPABsGh7ZLYAQmeNKjw2c5QE9s/GLZQJgD2w1PHrCB9WhSEPlHUYUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE6BC4CED6;
	Wed, 26 Feb 2025 21:26:14 +0000 (UTC)
Date: Wed, 26 Feb 2025 16:26:55 -0500
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
Message-ID: <20250226162655.65ba4b51@gandalf.local.home>
In-Reply-To: <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
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
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 13:14:30 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Similarly, if the source code has a single read, the compiler had
> better not turn that into two reads (because of some register pressure
> issue). That would *ALSO* be a bug, because of the whole TOCTOU issue
> (ie the source code may have had one single access, done sanity
> testing on the value before using it, and if the compiler turned it
> all into "read+sanity test" and "read+use", the compiler is
> introducing behavioral differences).

As a bystander here, I just want to ask, do you mean basically to treat all
reads as READ_ONCE() and all writes as WRITE_ONCE()?

-- Steve

