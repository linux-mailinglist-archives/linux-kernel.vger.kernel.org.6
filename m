Return-Path: <linux-kernel+bounces-538946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A91A49F19
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C55577A4488
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32877272904;
	Fri, 28 Feb 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxWvXmyI"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1439274253;
	Fri, 28 Feb 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760819; cv=none; b=Wr7IgQSHI5quG0X/L7D+eqCZLIZLA//UmRGpkORmA0/Aywr2AOJvtrdezhHyakwI49RQOSz2KekYCYN6cjzCw3ciiPvmTwTMUb3t4jls1vM6SS2P2oae9pvFi5srt6X0FtC2NzipZxKviYjaR3HJKCLhgKrpVPrB5u288KuGYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760819; c=relaxed/simple;
	bh=C+GRHKfQzkR44uS0nUAAm2rw9e0Wv36RSwQoLo8gkJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhpIN10aP6aIyqnlAJoiBvZUzC+yx9X3uMPhjjg6Zw8FI41Q4Yf6R5xI+Bu4zdIR/+kYLTLZ3V9AhlzGADX3i2nIv3oulsGdJYHl+jn1bQoiixX+xotWGV3XxNUAgjnVCUjWYu+MwRySD9mUtT5Tv2ll8Z6U7CIb2bxcUcw81pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxWvXmyI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c22ac6d856so211970685a.1;
        Fri, 28 Feb 2025 08:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740760816; x=1741365616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE5jn44WjqWeuZdDL/OCizR5LJ3g9XZyj5hAVjTMQfY=;
        b=DxWvXmyIWoxxDRcmCi0LQR3wAP3nbCAFOV4zb67Cqe2RobLSTio0VRc2hfLVpslVp6
         py5RX4kPlFOt03LpwUqh6y8rx0O4WsdYPu/az08dl3HjtPih7PkZwua7we6qN13nhNsp
         ZVrJ/xdHOuw6B1GsO7Z7nwx0ObswlLKUg/pLzhcF3ZccPQ4iE53DH8INAJ5UjhGXPgzS
         +i9rhUpcRLg3w51a7RQ9iNFHBtwF46fZzWnlyAdM+X8wxSuVRtQcNFDhl6AMgGjDRlDK
         7trxLHxWFVjisK3hF1vMUrszEqXKu/4g1AwMA3qCAQbdQm7Nh8DgKzRcSwznOe4qbNcc
         KWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760816; x=1741365616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SE5jn44WjqWeuZdDL/OCizR5LJ3g9XZyj5hAVjTMQfY=;
        b=Bw8ZB6pSb0wuo06qzidqTIn7I29eqb/mx+2lzsGIFi6TwjUM8YuyvOWIUhFDCI8poS
         enjeYn1Qoaap5KSfrAFzffwb6+nWLJ6ZSd+j+IaxbTdNZ54jSCbu+1yt4d6QlF4wL8Ld
         /t01gUxzlLlhlorlfhX3RQ4+DTMqg/Jk6yKhU8e8PXL9VCCVT4grYkr/mQejan5ArtGA
         UZoP4Yp0tTBuVkHW/mkWwFxzGdGxP7jX1Mz5BddP4a3N59V6cYG6RijAJ9cHrd0R/Id6
         XrKbE4UrHk1I9FX/VjS24Y1ITV/9+KUbJzZtaOSEcCA6dJS1TC1tPYzoHH0xs3P/VNrW
         ZoDw==
X-Forwarded-Encrypted: i=1; AJvYcCWDW0Z5WYzE45gyTmKGX3Z/dBWzaotRKUOM0W3LFQXjDp+6d9fUPCm9swQ4XQR2ylLXX4RVNIqabFvKgXWq5/s=@vger.kernel.org, AJvYcCWvd9HKz1jSMza3gpDbCwV60ecjP9cycf2T4b+PhFDU2/PiKTnkWCB+6XRFZ8d73buUFbW7gzs7RZexeDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOqwCV9zpMJWUXFxHyv4XnFztIIjWiVF4MkTrGd6/TNNP1Sfk1
	8q4GkN0SptS2PlDgqFX05oEoK6eKjLTjiTClGJSjTNiy3gBKzqkV
X-Gm-Gg: ASbGncvqyG3Ra6/208R1f5o6XiRVBwuch6k9MhplG1dIralZGiUSt2R4dWIs5CeNNul
	lJYy4w4fT66xk57jws6bG3RGFiUnNF/zWqf72/7QjbNVxDHnPdfr1aQGLMlHEKbkgfRLXHTek92
	mFkEH56CiqcQjJX1wsyfKEEOKHzheY2nkYOI3W7r4ned/p/f77itgGJgAA+m/84qypk4//qcSU5
	Ipjje12zb6fX8mu1WF4sWFobgcn797kAgxfakFbzHhex+pnp/txocblkrAxkTJf3UAFFmrBxf0x
	q/pvEu32RYx8hlCos5R2Oe26XcxsFVlmZ3BrroMPhDB2394bZQkilIfABsW44D2j0ZQhhUfNe1p
	DItubpXW81nsjys6d
X-Google-Smtp-Source: AGHT+IEaO1TQCjY8DFpnRf8SEUJHs5/dn6RzssKMPsxjIOhlGjRs/kUzHD/Hv3qAUYZzZCqljqXnVw==
X-Received: by 2002:a05:620a:8286:b0:7c3:9d46:3f31 with SMTP id af79cd13be357-7c39d463f87mr358027285a.5.1740760816403;
        Fri, 28 Feb 2025 08:40:16 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cccb0sm23813856d6.71.2025.02.28.08.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:40:15 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 36C1B1200070;
	Fri, 28 Feb 2025 11:40:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 28 Feb 2025 11:40:15 -0500
X-ME-Sender: <xms:7-bBZwRFqOXPQWjxQzFCuBxTQw1XjIy2_OY6CUb2C3ZpX85vH1JpDg>
    <xme:7-bBZ9wWTVb_E5g0bW0DZJZB4d5NbLH7a1FSIZuFHlSZNtana-fSW5v6eLepHhCwE
    vbaKTPawXBv4-4DrA>
X-ME-Received: <xmr:7-bBZ927jNOpUYgEfK2bqMu5V19_wpSpsEvbcnOtN89PeLsbHGpCc6zeBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepffdtiefhieegtddvueeuffeiteevtdegjeeu
    hffhgfdugfefgefgfedtieeghedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehkvghnthdrohhvvghrshhtrhgvvghtsehlihhnuhigrdguvghvpdhrtghpthhtohep
    phhoshhtsehrrghlfhhjrdguvgdprhgtphhtthhopegurghvihgurdhlrghighhhthdrlh
    hinhhugiesghhmrghilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughm
    ihhsrdhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehuvggtkhgvrhesthhughhrrgiirdgrthdprhgt
    phhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitg
    gvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehvvghnthhurhgrjhgrtghk
    keehsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7-bBZ0D3U54kKzCEWiPzoIexvect_geKeQc8jQiTq6NB-IebEYrBgg>
    <xmx:7-bBZ5iKJ4XACsTsJX2fNigsxPEGZMjrhfXhM5axtLkkPoLeYEZIFQ>
    <xmx:7-bBZwovYU0HAnXUnLMEfEMrFEoWaML0jmNC1tdsDnahH4hUjjsbjA>
    <xmx:7-bBZ8iUeb504khlvXJEJ6HffL09c-4gdrpSPgb3KautgpaG0uqYkQ>
    <xmx:7-bBZwTWgPZHaSnmSERlEwFUtMG3DtZRmZ5VB7QErBOUC-RZja4LX0IA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 11:40:14 -0500 (EST)
Date: Fri, 28 Feb 2025 08:40:13 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Ralf Jung <post@ralfj.de>, David Laight <david.laight.linux@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Uecker <uecker@tugraz.at>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>,
	airlied@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <Z8Hm7ROXFwQ5ER76@Mac.home>
References: <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
 <20250226173534.44b42190@gandalf.local.home>
 <20250227204722.653ce86b@pumpkin>
 <07acc636-75d9-4e4b-9e99-9a784d88e188@ralfj.de>
 <fbwwitktndx6vpkyhp5znkxmdfpforylvcmimyewel6mett2cw@i5yxaracpso2>
 <Z8HaT4X4ikQzAghu@Mac.home>
 <vvtxa4jjk2wy7q6wnnxxgidopfd3pzxgntuehsu4skex24x5ml@yejfkrtg5dqc>
 <Z8HglTh3EKO63lmu@Mac.home>
 <p4bawegz52nu3v2l25gnj5gh34patcxeggcdbom327wh3dhxyq@cp735olb55ps>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p4bawegz52nu3v2l25gnj5gh34patcxeggcdbom327wh3dhxyq@cp735olb55ps>

On Fri, Feb 28, 2025 at 11:21:47AM -0500, Kent Overstreet wrote:
> On Fri, Feb 28, 2025 at 08:13:09AM -0800, Boqun Feng wrote:
> > On Fri, Feb 28, 2025 at 11:04:28AM -0500, Kent Overstreet wrote:
> > > On Fri, Feb 28, 2025 at 07:46:23AM -0800, Boqun Feng wrote:
> > > > On Fri, Feb 28, 2025 at 10:41:12AM -0500, Kent Overstreet wrote:
> > > > > On Fri, Feb 28, 2025 at 08:44:58AM +0100, Ralf Jung wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > > > I guess you can sum this up to:
> > > > > > > > 
> > > > > > > >    The compiler should never assume it's safe to read a global more than the
> > > > > > > >    code specifies, but if the code reads a global more than once, it's fine
> > > > > > > >    to cache the multiple reads.
> > > > > > > > 
> > > > > > > > Same for writes, but I find WRITE_ONCE() used less often than READ_ONCE().
> > > > > > > > And when I do use it, it is more to prevent write tearing as you mentioned.
> > > > > > > 
> > > > > > > Except that (IIRC) it is actually valid for the compiler to write something
> > > > > > > entirely unrelated to a memory location before writing the expected value.
> > > > > > > (eg use it instead of stack for a register spill+reload.)
> > > > > > > Not gcc doesn't do that - but the standard lets it do it.
> > > > > > 
> > > > > > Whether the compiler is permitted to do that depends heavily on what exactly
> > > > > > the code looks like, so it's hard to discuss this in the abstract.
> > > > > > If inside some function, *all* writes to a given location are atomic (I
> > > > > > think that's what you call WRITE_ONCE?), then the compiler is *not* allowed
> > > > > > to invent any new writes to that memory. The compiler has to assume that
> > > > > > there might be concurrent reads from other threads, whose behavior could
> > > > > > change from the extra compiler-introduced writes. The spec (in C, C++, and
> > > > > > Rust) already works like that.
> > > > > > 
> > > > > > OTOH, the moment you do a single non-atomic write (i.e., a regular "*ptr =
> > > > > > val;" or memcpy or so), that is a signal to the compiler that there cannot
> > > > > > be any concurrent accesses happening at the moment, and therefore it can
> > > > > > (and likely will) introduce extra writes to that memory.
> > > > > 
> > > > > Is that how it really works?
> > > > > 
> > > > > I'd expect the atomic writes to have what we call "compiler barriers"
> > > > > before and after; IOW, the compiler can do whatever it wants with non
> > > > 
> > > > If the atomic writes are relaxed, they shouldn't have "compiler
> > > > barriers" before or after, e.g. our kernel atomics don't have such
> > > > compiler barriers. And WRITE_ONCE() is basically relaxed atomic writes.
> > > 
> > > Then perhaps we need a better definition of ATOMIC_RELAXED?
> > > 
> > > I've always taken ATOMIC_RELAXED to mean "may be reordered with accesses
> > > to other memory locations". What you're describing seems likely to cause
> > 
> > You lost me on this one. if RELAXED means "reordering are allowed", then
> > why the compiler barriers implied from it?
> 
> yes, compiler barrier is the wrong language here
> 
> > > e.g. if you allocate a struct, memset() it to zero it out, then publish
> > > it, then do a WRITE_ONCE()...
> > 
> > How do you publish it? If you mean:
> > 
> > 	// assume gp == NULL initially.
> > 
> > 	*x = 0;
> > 	smp_store_release(gp, x);
> > 
> > 	WRITE_ONCE(*x, 1);
> > 
> > and the other thread does
> > 
> > 	x = smp_load_acquire(gp);
> > 	if (p) {
> > 		r1 = READ_ONCE(*x);
> > 	}
> > 
> > r1 can be either 0 or 1.
> 
> So if the compiler does obey the store_release barrier, then we're ok.
> 
> IOW, that has to override the "compiler sees the non-atomic store as a
> hint..." - but the thing is, since we're moving more to type system

This might be a bad example, but I think that means if you add another
*x = 2 after WRITE_ONCE(*x, 1):

 	*x = 0;
 	smp_store_release(gp, x);
 
 	WRITE_ONCE(*x, 1);
	*x = 2;

then compilers in-theory can do anything they seems fit. I.e. r1 can be
anything. Because it's a data race.

> described concurrency than helpers, I wonder if that will actually be
> the case.
> 
> Also, what's the situation with reads? Can we end up in a situation
> where a non-atomic read causes the compiler do erronious things with an
> atomic_load(..., relaxed)?

For LKMM, no, because our data races requires at least one access
being write[1], this applies to both C and Rust. For Rust native memory
model, no, because Ralf fixed it:

	https://github.com/rust-lang/rust/pull/128778

[1]: "PLAIN ACCESSES AND DATA RACES" in tools/memory-model/Documentation/explanation.txt

Regards,
Boqun

