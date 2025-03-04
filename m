Return-Path: <linux-kernel+bounces-545310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 501FCA4EB87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51296188964D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CAE259C8D;
	Tue,  4 Mar 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="OAg29k7P"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833F2E3398;
	Tue,  4 Mar 2025 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111957; cv=none; b=rpO/cX5iDYWbYjvLFeIpngBfYcqPsJv8fHaZ+QGz2UrnHgj/umXBMQGrFJxp05/WSlcklmI0yj5pZTeGgoqnMyqzL5/oIrSVfAjxxBtvMuXugGmiEa89XPGX1Gd5FM5qpXNXsNBlU3nad6IQAkkeh1ScQH5rsUJE2A+0WCt8O40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111957; c=relaxed/simple;
	bh=gaEfcjNd02VLKamKTdYI4yoLbx/SJYRinm1vvENmyuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+jFuyBcNxRuMbRnW9xu8/Siy6We7Qdvf3JrXFD7AQK/OtCL5Xu65pjsxevFfPJzmYSRVXTynU2rvkJe6cgcbovRWi99Vw2nP5lVsJXV8S/FiFMq8u9QAHx4SiIe6xkFiN0MPaCriTPdIjlgd1DcxtxQ5HsHxZonALSRi8TJfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=OAg29k7P; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1741111947; bh=gaEfcjNd02VLKamKTdYI4yoLbx/SJYRinm1vvENmyuc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OAg29k7PJ0rLM9Ey8dTuOSv4q8U4Oy3jDAWREZhTVQcUSs1shR6Ea/9ZD8/IYbvg8
	 znaT89MvfrLIUt4wpztvkpliMyJtjGEM3pac9lzDUnPZS0iuYqfv++dlzvB2Hy78vM
	 u5E1QPXvz5D4oUKTLBi2jSaHK16sU/rS5GHWC1ow=
Received: from [IPV6:2001:67c:10ec:5784:8000::12e7] (2001-67c-10ec-5784-8000--12e7.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::12e7])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 52F292052D09;
	Tue,  4 Mar 2025 19:12:27 +0100 (CET)
Message-ID: <60c5acd2-df86-4eda-9479-17da7efe13fc@ralfj.de>
Date: Tue, 4 Mar 2025 19:12:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: David Laight <david.laight.linux@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Martin Uecker <uecker@tugraz.at>, "Paul E. McKenney" <paulmck@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>,
 Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
References: <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <20250226162655.65ba4b51@gandalf.local.home>
 <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
 <20250226165619.64998576@gandalf.local.home>
 <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
 <20250226173534.44b42190@gandalf.local.home>
 <20250227204722.653ce86b@pumpkin>
 <07acc636-75d9-4e4b-9e99-9a784d88e188@ralfj.de>
 <fbwwitktndx6vpkyhp5znkxmdfpforylvcmimyewel6mett2cw@i5yxaracpso2>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <fbwwitktndx6vpkyhp5znkxmdfpforylvcmimyewel6mett2cw@i5yxaracpso2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

>> Whether the compiler is permitted to do that depends heavily on what exactly
>> the code looks like, so it's hard to discuss this in the abstract.
>> If inside some function, *all* writes to a given location are atomic (I
>> think that's what you call WRITE_ONCE?), then the compiler is *not* allowed
>> to invent any new writes to that memory. The compiler has to assume that
>> there might be concurrent reads from other threads, whose behavior could
>> change from the extra compiler-introduced writes. The spec (in C, C++, and
>> Rust) already works like that.
>>
>> OTOH, the moment you do a single non-atomic write (i.e., a regular "*ptr =
>> val;" or memcpy or so), that is a signal to the compiler that there cannot
>> be any concurrent accesses happening at the moment, and therefore it can
>> (and likely will) introduce extra writes to that memory.
> 
> Is that how it really works?
> 
> I'd expect the atomic writes to have what we call "compiler barriers"
> before and after; IOW, the compiler can do whatever it wants with non
> atomic writes, provided it doesn't cross those barriers.

If you do a non-atomic write, and then an atomic release write, that release 
write marks communication with another thread. When I said "concurrent accesses 
[...] at the moment" above, the details of what exactly that means matter a lot: 
by doing an atomic release write, the "moment" has passed, as now other threads 
could be observing what happened.

One can get quite far thinking about these things in terms of "barriers" that 
block the compiler from reordering operations, but that is not actually what 
happens. The underlying model is based on describing the set of behaviors that a 
program can have when using particular atomicity orderings (such as release, 
acquire, relaxed); the compiler is responsible for ensuring that the resulting 
program only exhibits those behaviors. An approach based on "barriers" is one, 
but not the only, approach to achieve that: at least in special cases, compilers 
can and do perform more optimizations. The only thing that matters is that the 
resulting program still behaves as-if it was executed according to the rules of 
the language, i.e., the program execution must be captured by the set of 
behaviors that the atomicity memory model permits. This set of behaviors is, 
btw, completely portable; this is truly an abstract semantics and not tied to 
what any particular hardware does.

Now, that's the case for general C++ or Rust. The Linux kernel is special in 
that its concurrency support predates the official model, so it is written in a 
different style, commonly referred to as LKMM. I'm not aware of a formal study 
of that model to the same level of rigor as the C++ model, so for me as a 
theoretician it is much harder to properly understand what happens there, 
unfortunately. My understanding is that many LKMM operations can be mapped to 
equivalent C++ operations (i.e., WRITE_ONCE and READ_ONCE correspond to atomic 
relaxed loads and stores). However, the LKMM also makes use of dependencies 
(address and/or data dependencies? I am not sure), and unfortunately those 
fundamentally clash with even basic compiler optimizations such as GVN/CSE or 
algebraic simplifications, so it's not at all clear how they can even be used in 
an optimizing compiler in a formally sound way (i.e., "we could, in principle, 
mathematically prove that this is correct"). Finding a rigorous way to equip an 
optimized language such as C, C++, or Rust with concurrency primitives that emit 
the same efficient assembly code as what the LKMM can produce is, I think, an 
open problem. Meanwhile, the LKMM seems to work in practice despite those 
concerns, and that should apply to both C (when compiled with clang) and Rust in 
the same way -- but when things go wrong, the lack of a rigorous contract will 
make it harder to determine whether the bug is in the compiler or the kernel. 
But again, Rust should behave exactly like clang here, so this should not be a 
new concern. :)

Kind regards,
Ralf


