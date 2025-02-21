Return-Path: <linux-kernel+bounces-526566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C24FA4005E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057683B6E15
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A19A250BF6;
	Fri, 21 Feb 2025 20:06:25 +0000 (UTC)
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C9252909;
	Fri, 21 Feb 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168384; cv=none; b=GN5vw9bmzYK+oQVS7zbSzQjE2AwjrBgVClzsa05NQmmM7p4uuhvTWrRrIru+bBWXVYqmyEsoLSsY1f7zQdi+rq54rkYKZ/bREfakoCv/vigsiiXih40ypCyf+SH5qXrwpl1PocFosWKA6g7mgIFJg+s8nXrdV6b0f8UrTWFE1gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168384; c=relaxed/simple;
	bh=Bz/CAy2MJIX56MZmp5WzaPMfPF3mqjkLstosHAlZl9g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ErvVnlXlrltg3MYvFJapoOUuA6mkjisxVl4dnD2XYSL41XXnkpv5Swn/vcLIsaJwTL90wZJq2YdWvSDQHjz6iZT7BclWFlNax4O0MClFA4m8gR3B/EpOpP3GTQ0pjTjykAOd+5WUV2lldh7diDDvehhIh6oqLqb7aBi6EXa7YI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=fail smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 0C14E1003E1299; Fri, 21 Feb 2025 21:06:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 0A332110075443;
	Fri, 21 Feb 2025 21:06:14 +0100 (CET)
Date: Fri, 21 Feb 2025 21:06:14 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: David Laight <david.laight.linux@gmail.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, Greg KH <gregkh@linuxfoundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, 
    Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
    Christoph Hellwig <hch@infradead.org>, 
    rust-for-linux <rust-for-linux@vger.kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, 
    ksummit@lists.linux.dev
Subject: Re: C aggregate passing (Rust kernel policy)
In-Reply-To: <20250221183437.1e2b5b94@pumpkin>
Message-ID: <p7946077-rn30-n3p3-ppp0-80o9n9p07718@vanv.qr>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com> <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com> <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com> <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home> <2025021954-flaccid-pucker-f7d9@gregkh> <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr> <2025022052-ferment-vice-a30b@gregkh>
 <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com> <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr> <20250221183437.1e2b5b94@pumpkin>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Friday 2025-02-21 19:34, David Laight wrote:
>> 
>> Returning aggregates in C++ is often implemented with a secret extra
>> pointer argument passed to the function. The C backend does not
>> perform that kind of transformation automatically. I surmise ABI reasons.
>
>Have you really looked at the generated code?
>For anything non-trivial if gets truly horrid.
>
>To pass a class by value the compiler has to call the C++ copy-operator to
>generate a deep copy prior to the call, and then call the destructor after
>the function returns - compare against passing a pointer to an existing
>item (and not letting it be written to).

And that is why people generally don't pass aggregates by value,
irrespective of the programming language.

>Returning a class member is probably worse and leads to nasty bugs.
>In general the called code will have to do a deep copy from the item
>being returned

People have thought of that already and you can just
`return std::move(a.b);`.

>Then you get code like:
>	const char *foo = data.func().c_str();
>very easily written looks fine, but foo points to garbage.

Because foo is non-owning, and the only owner has gone out of scope.
You have to be wary of that.

>You can return a reference - that doesn't go out of scope.

That depends on the refererred item.
	string &f() { string z; return z; }
is going to explode (despite returning a reference).

>(Apart from the fact that c++ makes it hard to ensure all the non-class
>members are initialised.)

	struct stat x{};
	struct stat x = {};

all of x's members (which are scalar and thus non-class) are
initialized. The second line even works in C.

