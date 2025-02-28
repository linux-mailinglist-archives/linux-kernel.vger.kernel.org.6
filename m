Return-Path: <linux-kernel+bounces-537910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250F1A4925D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11FA16E09D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B891C3BE8;
	Fri, 28 Feb 2025 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="AGXlS+9T"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF501C5F35;
	Fri, 28 Feb 2025 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728702; cv=none; b=klDo7LtS8YGNjeFPPxYYIXjsGb7Io5IXfvrEZj57EUPfX6HZh5YzwYc5VRqI4Ela3JZKeFIdYc5d/9I/cJApuGxtrIJ6hB+6KDbbN6vplaZeYSVM6n1OGODO9BR+NeSJUGkby6GCe9U8vtyx8A1jq74/ESqEuM76TpjxFSTnrIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728702; c=relaxed/simple;
	bh=Cqdlf4yoq30t+BX3DuWtax33mta4DCN20XIqO0aqf/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYnwwXGwTdeDCUmsA9wN70zAGBlOo415Ga8vYJjYVz2U2JE+ouQ467gVZ5n4wlAHbDEwmuJH7zT1mxNlDV0h74u1p7ooOxKK7ui61x816pVJv10fqvUUKWLdLvITtgc3Tjlm428K6qZDH3A66WEITXxmovGlCakhv+75SkNmi5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=AGXlS+9T; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740728699; bh=Cqdlf4yoq30t+BX3DuWtax33mta4DCN20XIqO0aqf/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AGXlS+9T2hBJetL2PAoO0+xMCbtPC32Keir+LaWJTyi4EhG4TiVncrKvf9M5nlfHL
	 5/3LgEorqAyePLoDqQ+a3gKrVxTnW33X9FgW6zypyap562lYgq9uhTXH1vUBKSITXL
	 NzWgh1x9iiJerDfoT2Nd8b+h5BcYFEQdJ/KjJa7M=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 024BD2052A86;
	Fri, 28 Feb 2025 08:44:58 +0100 (CET)
Message-ID: <07acc636-75d9-4e4b-9e99-9a784d88e188@ralfj.de>
Date: Fri, 28 Feb 2025 08:44:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: David Laight <david.laight.linux@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Martin Uecker <uecker@tugraz.at>, "Paul E. McKenney" <paulmck@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, ej@inai.de,
 gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
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
 <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
 <20250226173534.44b42190@gandalf.local.home>
 <20250227204722.653ce86b@pumpkin>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <20250227204722.653ce86b@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>> I guess you can sum this up to:
>>
>>    The compiler should never assume it's safe to read a global more than the
>>    code specifies, but if the code reads a global more than once, it's fine
>>    to cache the multiple reads.
>>
>> Same for writes, but I find WRITE_ONCE() used less often than READ_ONCE().
>> And when I do use it, it is more to prevent write tearing as you mentioned.
> 
> Except that (IIRC) it is actually valid for the compiler to write something
> entirely unrelated to a memory location before writing the expected value.
> (eg use it instead of stack for a register spill+reload.)
> Not gcc doesn't do that - but the standard lets it do it.

Whether the compiler is permitted to do that depends heavily on what exactly the 
code looks like, so it's hard to discuss this in the abstract.
If inside some function, *all* writes to a given location are atomic (I think 
that's what you call WRITE_ONCE?), then the compiler is *not* allowed to invent 
any new writes to that memory. The compiler has to assume that there might be 
concurrent reads from other threads, whose behavior could change from the extra 
compiler-introduced writes. The spec (in C, C++, and Rust) already works like that.

OTOH, the moment you do a single non-atomic write (i.e., a regular "*ptr = val;" 
or memcpy or so), that is a signal to the compiler that there cannot be any 
concurrent accesses happening at the moment, and therefore it can (and likely 
will) introduce extra writes to that memory.

Kind regards,
Ralf


