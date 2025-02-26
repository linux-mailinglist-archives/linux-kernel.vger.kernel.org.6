Return-Path: <linux-kernel+bounces-534896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BD0A46C61
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3743AD5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAB62512E2;
	Wed, 26 Feb 2025 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UPw11DU5"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19C236A74
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601552; cv=none; b=sOEgCG0vEUMHhmtp7yLKtb6S2Tuh1OHjiaLgnHo4DGCH13mAK60kG8riSMmcP3sW3gJsHySgtOrtkRpOZgyD8nuQDjITyUh/DMICxBJhyj6puzQfd0NmazvJdPPonmB0GppwpvyTF4nXTreXa2H3BFcSbDAWY75vfpu1LMfaFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601552; c=relaxed/simple;
	bh=Q8sYku9aMCtWhflJLwH91vUGtFPSQw2rleG8nUX/WAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4gJP8Pg/cy13HT91XLt2WoDPqxPbkZ9yyAmBwbCKQAs2vghy36S8qwsP9rFoZ8y/uvvATOJRfPJXNG0nVmYny5u/2VPfclZ8XHVgtZOGSBEAurnAIDdbwl5pS0P4WLFNWf1wORYIVhhWsc/Vh1w4lyHYx/Jefr8AEWd9Fl6nNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UPw11DU5; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 15:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740601538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lQTz2Z60ErneXO5HjXDw3PfvKwLnnAXF84o/4WSH4M8=;
	b=UPw11DU5IPn/iHj10Ngjhcml/9OUHZnnKj9E2cJ4h84crN3jw+5ziDj18Y767dYbhqdkmm
	uGz6qTm72fDQtIetBj4i1vcsAUtKMFS4TPvVQ6CvIw+TcalQpLwEtnXJ9BmOVUSoQOdmVm
	4bfI+ozZUvgBete7FVNLQCQjAURgEFE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ralf Jung <post@ralfj.de>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <amebiomyty3gw7gwgpz3sbztzdac6ce2pslq3jjfe3no4w72dn@sskvzdp6l67w>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 09:59:41AM -0800, Linus Torvalds wrote:
> And just as an example: threading fundamentally introduces a notion of
> "aliasing" because different *threads* can access the same location
> concurrently. And that actually has real effects that a good language
> absolutely needs to deal with, even when there is absolutely *no*
> memory ordering or locking in the source code.
> 
> For example, it means that you cannot ever widen stores unless you
> know that the data you are touching is thread-local. Because the bytes
> *next* to you may not be things that you control.

In Rust, W^X references mean you know that if you're writing to an
object you've got exclusive access - the exception being across an
UnsafeCell boundary, that's where you can't widen stores.

Which means all those old problems with bitfields go away, and the
compiler people finally know what they can safely do - and we have to
properly annotate access from multiple threads.

E.g. if you're doing a ringbuffer with head and tail pointers shared
between multiple threads, you no longer do that with bare integers, you
use atomics (even if you're not actually using any atomic operations on
them).

