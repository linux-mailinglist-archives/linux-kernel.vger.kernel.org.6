Return-Path: <linux-kernel+bounces-529667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5899A4297F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5DB188B413
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346B5264F99;
	Mon, 24 Feb 2025 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tcnUKDoS"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A1262D07
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417875; cv=none; b=ZrOi5fvaZ93nLyvSe66h5tadHNl3elhZNO9xdDrkXsiMupPngH3P/I1YoZUIW3ignAJYF12c8sxu2KTMtXgIFkhNIm++PWZ3+8odSO+v1sGz1nAX2lqyqx6A7zmN9QMyUQv6hStEaystczH18S7vAg7N0NYQudr4pNZtjGpVr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417875; c=relaxed/simple;
	bh=VYM8yVRItIuMduZwBffZeSAKQxqZUBVKRYC8TNCa/uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZsKgUxn0MCGgmcOi/1jt1kvQacBSsQrTWQxUhU607rCMz8el2Ud1P3FTYl4yC8gzE+PfqnI0l37DFw3CMoANYm5FUXlnVO54/iSmX+E/H4AGwt2FYfZIqLYNa+CAaEeOTCYNz76dNBRJ+mboJCB92ySfNkqJ0STx18OXkpfqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tcnUKDoS; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Feb 2025 12:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740417870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VYM8yVRItIuMduZwBffZeSAKQxqZUBVKRYC8TNCa/uQ=;
	b=tcnUKDoSra3uvYyGRmdRLXW0zPNX8tpyhGMBXBl4uk3wQXfFEsI0jesrD7S2KMtmW4BrJb
	OppTxxbj77ARX5Pm22weGSaFYLndKUSkcFLyWX7/su4oXUhI19ihcMzCgj39A4+56btaHg
	toP7smwDkf2nPaFhJH9WBSMtWQ93LNc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Ventura Jack <venturajack85@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <xm5i4ojrwxubao7sj4w7o564aox73no4v5u5pioofamllvnvwt@444xi7c73qdj>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <20250224125805.GA5729@mit.edu>
 <CANiq72kMQW6a991e9TgR39pmG5hVd-NcoeJANum4ap-6n=Mhhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kMQW6a991e9TgR39pmG5hVd-NcoeJANum4ap-6n=Mhhw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 24, 2025 at 04:43:46PM +0100, Miguel Ojeda wrote:
> We also got the question about future subsystems a few times -- could
> they be implemented in Rust without wrapping C? That would simplify
> greatly some matters and reduce the amount of unsafe code. However, if
> the code is supposed to be used by everybody, then that would make
> some architectures second-class citizens, even if they do not have
> users depending on that feature today, and thus it may be better to
> wait until GCC gets to the right point before attempting something
> like that.

If gccrs solves the archictecture issues, this would be nice - because
from what I've seen the FFI issues look easier and less error prone when
Rust is the one underneath.

There are some subtle gotchas w.r.t. lifetimes at FFI boundaries that
the compiler can't warn about - because that's where you translate to
raw untracked pointers.

