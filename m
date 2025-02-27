Return-Path: <linux-kernel+bounces-537080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E7A487DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D07018865E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F71E8355;
	Thu, 27 Feb 2025 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="2ioeKNBd"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E93482EF;
	Thu, 27 Feb 2025 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681191; cv=none; b=fR2caRVLO+wWMTAUkMe9czEqbbD219M8kk2PMbL3+A48S0kjmhNxNNJejC2Y7PptThC0iIQfHD0lhXUzzCLkBh+3+pnyVdZH/5THqRbVFx6ig1G62kuNO4t8FU1KDpJxgn4yjEMHs5uL0esVJVmpJIYVl8tissiEBS4/h2k7wyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681191; c=relaxed/simple;
	bh=Qg2hTQXyOPi46wn0RplEcoz1yo9Al144uQ6GPuvSJjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfllS/xgl4/n8Mhykj5DhE4hrS2PsuptHs8XV28ZC+9wDPURrtZqGgII5GnL5olzpBBGvuVi53CEJqtdacwDEcj9je6/NT+9jcyP6XmbTRaF4nEaVHLT+QD7GaaSIAVyEVfuFr/zySx4dtYtYCd9gDO+ZKHo1V3Iq8bKQ0H7Nc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=2ioeKNBd; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740681187; bh=Qg2hTQXyOPi46wn0RplEcoz1yo9Al144uQ6GPuvSJjQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2ioeKNBdiHR+wK18hrjRnoRMkNP5WVIW2Em4/06QjN8/GHpZE+cWmonKn6nyOAR7a
	 CEYae1Y3bCU1jUJ7ma59X7mtJH0g7I1en3P6tFrVL5GiVtQ6y9qFJK75tOngbNJLzK
	 4DH5NHQhSI6OJtLZZ/xDALFNQg9iWTu3i/aHGcT4=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 97CB92052A91;
	Thu, 27 Feb 2025 19:33:07 +0100 (CET)
Message-ID: <0f3bc0e8-5111-4e2f-83b5-36b3aec0cbbd@ralfj.de>
Date: Thu, 27 Feb 2025 19:33:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: Martin Uecker <uecker@tugraz.at>, "Paul E. McKenney"
 <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
References: <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <m4cbniqfsr5xpb2m7k53e7plc6he5ioyl2efiiftdmzod56usd@htwdppje6re5>
 <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

On 27.02.25 00:16, Linus Torvalds wrote:
> On Wed, 26 Feb 2025 at 14:27, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>>
>> This is another one that's entirely eliminated due to W^X references.
> 
> Are you saying rust cannot have global flags?

The way you do global flags in Rust is like this:

static FLAG: AtomicBool = AtomicBool::new(false);

// Thread A
FLAG.store(true, Ordering::SeqCst); // or release/acquire/relaxed

// Thread B
let val = FLAG.load(Ordering::SeqCst);
if val { // or release/acquire/relaxed
   // ...
}
println!("{}", val);

If you do this, the TOCTOU issues you mention all disappear. The compiler is 
indeed *not* allowed to re-load `FLAG` a second time for the `println`.

If you try do to do this without atomics, the program has a data race, and that 
is considered UB in Rust just like in C and C++. So, you cannot do concurrency 
with "*ptr = val;" or "ptr2.copy_from(ptr1)" or anything like that. You can only 
do concurrency with atomics. That's how compilers reconcile "optimize sequential 
code where there's no concurrency concerns" with "give programmers the ability 
to reliably program concurrent systems": the programmer has to tell the compiler 
whenever concurrency concerns are in play. This may sound terribly hard, but the 
Rust type system is pretty good at tracking this, so in practice it is generally 
not a big problem to keep track of which data can be accessed concurrently and 
which cannot.

Just to be clear, since I know you don't like "atomic objects": Rust does not 
have atomic objects. The AtomicBool type is primarily a convenience so that you 
don't accidentally cause a data race by doing concurrent non-atomic accesses. 
But ultimately, the underlying model is based on the properties of individual 
memory accesses (non-atomic, atomic-seqcst, atomic-relaxed, ...).

By using the C++ memory model (in an access-based way, which is possible -- the 
"object-based" view is not fundamental to the model), we can have reliable 
concurrent programming (no TOCTOU introduced by the compiler) while also still 
considering (non-volatile) memory accesses to be entirely "not observable" as 
far as compiler guarantees go. The load and store in the example above are not 
"observable" in that sense. After all, it's not the loads and stores that 
matter, it's what the program does with the values it loads. However, the 
abstract description of the possible behaviors of the source program above 
*does* guarantee that `val` has the same value everywhere it is used, and 
therefore everything you do with `val` that you can actually see (like printing, 
or using it to cause MMIO accesses, or whatever) has to behave in a consistent 
way. That may sound round-about, but it does square the circle successfully, if 
one is willing to accept "the programmer has to tell the compiler whenever 
concurrency concerns are in play". As far as I understand, the kernel already 
effectively does this with a suite of macros, so this should not be a 
fundamentally new constraint.

Kind regards,
Ralf


> 
> That seems unlikely. And broken if so.
> 
>> IOW: if you're writing code where rematerializing reads is even a
>> _concern_ in Rust, then you had to drop to unsafe {} to do it - and your
>> code is broken, and yes it will have UB.
> 
> If you need to drop to unsafe mode just to read a global flag that may
> be set concurrently, you're doing something wrong as a language
> designer.
> 
> And if your language then rematerializes reads, the language is shit.
> 
> Really.
> 
>               Linus


