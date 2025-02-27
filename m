Return-Path: <linux-kernel+bounces-536474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4FDA4800D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391AC1882980
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC0623024C;
	Thu, 27 Feb 2025 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="EmSqhOjV"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859842C0B;
	Thu, 27 Feb 2025 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664539; cv=none; b=uxWkGmToA8Q4/MCxWp5CybtpSXjs6r2nLSrKNk48iLwFzXg3ocqIX/Dv/Zup3JeIVMBWQLE3tAgSoJ05j709hR17qpEDp3yNXdA96bKskTAJVuu5W8fjdnudq/L4iPW7RIYzs0T/fcl4oGrigvYa0xAE8wSdMa0xfnARknr7I8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664539; c=relaxed/simple;
	bh=MZ5feQNtisJgpeJy5xLzx0Y8Q+XnSBumrFimAbzZ9CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+Pcq1A6JIUEL7mONV1k9pmiGik195G5LpNNi6a7/t/DF3T8B7vS8Bv2JMBn1bS1FupmHyAMK4OkF00cO1YW09CMsN7oq3L7yuhGCIPy3Ugtjm9qGUhEJJrHq3wfME9f9HhycJjku8a3V8B6Aulc7YQYNoiwX7lSdj9nyt8FDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=EmSqhOjV; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740664527; bh=MZ5feQNtisJgpeJy5xLzx0Y8Q+XnSBumrFimAbzZ9CM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EmSqhOjVTv/5qycUfH0WaMucg+fhJaX+QaLJDaN7j5pv+AO3LHrkfHfhEz78bmFE8
	 5Wmvn1X52+ZGUzV0+Stdk7alPHSvfNRXxNqy1bwepz5dx+8Bn1TEdqm3PBFf7I1NKc
	 4yxnyQjNSmcPnthA3ukUCkq3/7nwB3yR/KSCtRhI=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 62DA02052A91;
	Thu, 27 Feb 2025 14:55:27 +0100 (CET)
Message-ID: <f2c2d7ae-08c1-4122-a131-f5a65e9ed3d2@ralfj.de>
Date: Thu, 27 Feb 2025 14:55:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: David Laight <david.laight.linux@gmail.com>
Cc: Ventura Jack <venturajack85@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>,
 torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
 <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
 <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
 <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
 <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
 <20250226230816.2c7bbc16@pumpkin>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <20250226230816.2c7bbc16@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

> ...
>>> Unions in C, C++ and Rust (not Rust "enum"/tagged union) are
>>> generally sharp. In Rust, it requires unsafe Rust to read from
>>> a union.
>>
>> Definitely sharp. At least in Rust we have a very clear specification though,
>> since we do allow arbitrary type punning -- you "just" reinterpret whatever
>> bytes are stored in the union, at whatever type you are reading things. There is
>> also no "active variant" or anything like that, you can use any variant at any
>> time, as long as the bytes are "valid" for the variant you are using. (So for
>> instance if you are trying to read a value 0x03 at type `bool`, that is UB.)
> 
> That is actually a big f***ing problem.
> The language has to define the exact behaviour when 'bool' doesn't contain
> 0 or 1.

No, it really does not. If you want a variable that can hold all values in 
0..256, use `u8`. The entire point of the `bool` type is to represent values 
that can only ever be `true` or `false`. So the language requires that when you 
do type-unsafe manipulation of raw bytes, and when you then make the choice of 
the `bool` type for that code (which you are not forced to!), then you must 
indeed uphold the guarantees of `bool`: the data must be `0x00` or `0x01`.

> Much the same as the function call interface defines whether it is the caller
> or called code is responsible for masking the high bits of a register that
> contains a 'char' type.
> 
> Now the answer could be that 'and' is (or may be) a bit-wise operation.
> But that isn't UB, just an undefined/unexpected result.
> 
> I've actually no idea if/when current gcc 'sanitises' bool values.
> A very old version used to generate really crap code (and I mean REALLY)
> because it repeatedly sanitised the values.
> But IMHO bool just shouldn't exist, it isn't a hardware type and is actually
> expensive to get right.
> If you use 'int' with zero meaning false there is pretty much no ambiguity.

We have many types in Rust that are not hardware types. Users can even define 
them themselves:

enum MyBool { MyFalse, MyTrue }

This is, in fact, one of the entire points of higher-level languages like Rust: 
to let users define types that represent concepts that are more abstract than 
what exists in hardware. Hardware would also tell us that `&i32` and `*const 
i32` are basically the same thing, and yet of course there's a world of a 
difference between those types in Rust.

Kind regards,
Ralf


