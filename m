Return-Path: <linux-kernel+bounces-535200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E6A47012
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3215A3ADC06
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B144683;
	Thu, 27 Feb 2025 00:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jJoiMy2r"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4FA47
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615453; cv=none; b=ZQ5ip+fI0gtoyIZKxAuJvd3IICXwOk2wVr1tVUrDEJ7nkJqvuP8T/k1OPrzTmfTTCDZDrk5V4EFCiZ4HrmuJbygKFJKzvcc72CLbo50RbozIioVLeIsNHlYjcHtAwDexY7jvQq3X31pDduemCkrX5dY1apuc6dE2y2MTc021tB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615453; c=relaxed/simple;
	bh=+RVBmqBICAhVTryOkzY3ASztLaq7t1vt3iA4DgSH6t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xnn2jFVtI/DwkMtY9xN+Ta/pMPl0O0kqVRZDIXKYqlQFwbIDmc2J4wlEaADOAG9E+wVg4t0RrH0lN2FQepXs79MRSG8fXhi5scytWTiCICJMG15fmPUB5VxldQbC9Ir4aQGdyF1ZZPfTpdntEo2ydlsUAcvQblvtisjNsxOtszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jJoiMy2r; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 19:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740615439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ek32SScbGTV6VZRjh61x2eTCTSaZEiFzRBWPVoTydw=;
	b=jJoiMy2rkmkAy+dTTKfslGn6cV834/WUf+mGAH+86yi5lwV0gqBVqXOlDlNLfyQ00B/3ta
	29/znFSNkgXFR9s9bF2Lu3UdOOXDfIQ/6aWBV8NlUeAPb7s+mCcL2pdlgrTLAVZS4tP+e+
	ruMnx1TMfmtBgWGbei1wHf5FxDQmxV8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Uecker <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <3jxec6iys7tvzo23okmtesahbvhsk62r73zwmpa75dfh5pvdyc@t2q7kg6vzxx7>
References: <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <m4cbniqfsr5xpb2m7k53e7plc6he5ioyl2efiiftdmzod56usd@htwdppje6re5>
 <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 03:16:54PM -0800, Linus Torvalds wrote:
> On Wed, 26 Feb 2025 at 14:27, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > This is another one that's entirely eliminated due to W^X references.
> 
> Are you saying rust cannot have global flags?
> 
> That seems unlikely. And broken if so.

No, certainly not - but you _do_ have to denote the access rules, and
because of that they'll also need accessor functions.

e.g. in bcachefs, I've got a 'filesystem options' object. It's read
unsynchronized all over the place, and I don't care because the various
options don't have interdependencies - I don't care about ordering - and
they're all naturally aligned integers.

If/when that gets converted to Rust, it won't be a bare object anymore,
it'll be something that requires a .get() - and it has to be, because
this is something with interior mutability.

I couldn't tell you yet what container object we'd use for telling the
compiler "yes this is just bare unstructured integers, just wrap it for
me (and probably assert that we're not using anything to store more
complicated)" - but I can say that it'll be something with a getter that
uses UnsafeCell underneath.

I'd also have to dig around in the nomicon to say whether the compiler
barriers come from the UnsafeCell directly or whether it's the wrapper
object that does the unsafe {} bits that specifies them - or perhaps
someone in the thread will say, but somewhere underneath the getter will
be the compiler barrier you want.

