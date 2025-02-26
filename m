Return-Path: <linux-kernel+bounces-534021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0835A46192
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9060171128
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443FC21D3E7;
	Wed, 26 Feb 2025 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="4nwKJttn"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72A178372;
	Wed, 26 Feb 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578501; cv=none; b=qQvRjTLQbj4bVemnaq6g55gOjc9FqjPn9jRg9oLBoajf6GyOoVb8iHwbg4ehKTfZivhrAEUrisjlrkm5C/cU48iuw21F/FeWYyI9obPlz2LoIUUz9YthH0aoizlGzIg+DmCQVGgOjDVSE7irF53f4rgNX4QHDMkqCNmVTbjiIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578501; c=relaxed/simple;
	bh=C6T6y2VPwiS4NutYlB6fzvkoRVEmILwql/V6Jy+Nz+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqrhjdvaQlrQzOZ1muWNJJo7gvo305RMEk876bnGnBtf6syMRYH3NOtf/3AvRHFwdeD3f5eUWhbmcf1SRRVrl4U+4ivJHilF3+XY8ABa5caQVvbfd3LzDctuB/GEzWT8qEQGgicK0xfIo6L5R3qIuI9h3wTUUjzQK21NgLi+Mos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=4nwKJttn; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740578497; bh=C6T6y2VPwiS4NutYlB6fzvkoRVEmILwql/V6Jy+Nz+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=4nwKJttnZHo4VuQvR9nHx0Ib0D+sS113oe8qv8PSBghGoME2J9o5Ym0PhYsMbDj16
	 O9rlOWhd100KpgNmZDR4Z31HQm8PvgpWserABy5YED/m/HlSq14hvTZ3y7ZklA1VP/
	 1iSA7D6Df6vRvWHQl9FAVOlsJ27t2FKqxnYmlDio=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 4D2DD2052D08;
	Wed, 26 Feb 2025 15:01:37 +0100 (CET)
Message-ID: <04d1cf43-9efe-4597-a6a9-8f2b801ec049@ralfj.de>
Date: Wed, 26 Feb 2025 15:01:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>,
 Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com,
 david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6>
 <CANiq72kd2eTaPMcYSiQ61tZ2nX0jLM9SgsnbPEEbdNx+JQYFdg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CANiq72kd2eTaPMcYSiQ61tZ2nX0jLM9SgsnbPEEbdNx+JQYFdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

>> I think the one thing that's missing w.r.t. aliasing that Rust could
>> maybe use is a kasan-style sanitizer, I think with treeborrows and "now
>> we have an actual model for aliasing optimizations" it should be possible
>> to write such a sanitizer. But the amount of code doing complicated
>> enough stuff with unsafe should really be quite small, so - shouldn't be
> 
> Miri implements those models and can check code for conformance. It
> can be used easily in the Rust playground (top-right corner -> Tools
> -> Miri):
> 
>      https://play.rust-lang.org
> 
> However, it does not work when you involved C FFI, though, but you can
> play there. For more advanced usage, e.g. testing a particular model
> like Tree Borrows, I think you need to use it locally, since I am not
> sure if flags can be passed yet.
 >
> I would like to get it, plus other tools, into Compiler Explorer, see
> e.g. https://github.com/compiler-explorer/compiler-explorer/issues/2563.

By default (and on the playground), Miri will check Stacked Borrows rules. Those 
are almost always *more strict* than Tree Borrows rules.

Unfortunately playground does not let you pass your own flags, so yeah getting 
Miri on godbolt would be great. :D

Kind regards,
Ralf


