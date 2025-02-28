Return-Path: <linux-kernel+bounces-537919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B51A4927B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECFA87A4179
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD72CCC0;
	Fri, 28 Feb 2025 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="TmzHf/je"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC09276D12;
	Fri, 28 Feb 2025 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729195; cv=none; b=W1PPEyGC+/cagUrWeJgfQoJdcwiGT1oWDn1HH/wVtMGYdKn+w81Nc/l+r6Y3kRSM8IKd4245MVvPGYcKkDWI0hqnVVdiW58uVKHG4+PJ33chwdB7dQ7sMfYhNClmXdYr5fAruUnj434rNOAhTxgswpzxWTZPnvl/n2nA1+u+G9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729195; c=relaxed/simple;
	bh=PUtZpIADiI6Ujj2mPs39lwBthjJFOnSo983vSigK3gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2FLzUTTpcuY/b8hyTgTBL15F82kpM2u+au/MlIyqgehHcIkebmSckWYkPpU76sCqAaIRTPROOrKEaKcPmUf8YXBF7AJdmbiqC6NzD+KCDk5cGgr/64EjqZpypKPGBpUaD4vRDOsjwXwzhxzgqtNrhS8TPXmytzqW8prz1pJMOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=TmzHf/je; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740729192; bh=PUtZpIADiI6Ujj2mPs39lwBthjJFOnSo983vSigK3gw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TmzHf/jeSbNeL86dRLzSU79EbpCJtZwt7IMkXWI0zRBF0NyjDo++w0SppZyOE35J9
	 zaV7Gxe/vLTRc0oillVnzeoyov0DwEpi4x4A1y6aHstGVRFrwcar9frkLfAFCvlp9N
	 25/5TrRB1bPA56OzzQ0mXUpHfaIRxnw5czd/cc4k=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 0C2712052A86;
	Fri, 28 Feb 2025 08:53:12 +0100 (CET)
Message-ID: <2949f6dc-51fe-4a28-b44d-5a38796303e8@ralfj.de>
Date: Fri, 28 Feb 2025 08:53:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Martin Uecker <uecker@tugraz.at>, "Paul E. McKenney" <paulmck@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>,
 Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com,
 david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
 rust-for-linux@vger.kernel.org
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
 <0f3bc0e8-5111-4e2f-83b5-36b3aec0cbbd@ralfj.de>
 <CAHk-=wj37zT4Fy+mBFVRKPy=NMKcB6xBzqOuFrW0jOTv8LKozg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAHk-=wj37zT4Fy+mBFVRKPy=NMKcB6xBzqOuFrW0jOTv8LKozg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 27.02.25 20:15, Linus Torvalds wrote:
> On Thu, 27 Feb 2025 at 10:33, Ralf Jung <post@ralfj.de> wrote:
>>
>> The way you do global flags in Rust is like this:
> 
> Note that I was really talking mainly about the unsafe cases, an din
> particular when interfacing with C code.

When Rust code and C code share memory that is concurrently accessed, all 
accesses to that from the Rust side must be explicitly marked as atomic. A 
pointer to such a memory should look like `&AtomicBool` in Rust, not `*mut 
bool`. To my knowledge, the kernel already has appropriate APIs for that. That 
will then ensure things behave like the AtomicBool example.

Kind regards,
Ralf

> 
> Also, honestly:
> 
>> FLAG.store(true, Ordering::SeqCst); // or release/acquire/relaxed
> 
> I suspect in reality it would be hidden as accessor functions, or
> people just continue to write things in C.
> 
> Yes, I know all about the C++ memory ordering. It's not only a
> standards mess, it's all very illegible code too.
> 
>               Linus


