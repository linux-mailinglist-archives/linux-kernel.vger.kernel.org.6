Return-Path: <linux-kernel+bounces-534126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F65A46310
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329A816907F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16A02222CF;
	Wed, 26 Feb 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="GH5vf1BC"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813D2222B7;
	Wed, 26 Feb 2025 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580657; cv=none; b=kdt4ihI4d6/9k8o0zYtyQnxD16CMTZsgXqAyq+Uz8hS6uR6I36oPJ0j85Jynj+RPVIMR6sQAqeq83jhjl9RqGPejJVvPX5DHkYGWDnCiZHFhc60To/G59sSYhCL9SMLzJ2vAsBPrSvhc1qUyYmWllgys/OG6kgUApZDi8/QOX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580657; c=relaxed/simple;
	bh=0MLGL0Ho8ncjPovldYhbohlEnmj/Azb3Aqd9VsDSLcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZwjeQSm2q2Ajp2Q4eOM8ihpgMBG2NgcpIlN2IGibxsN36Xb9viJeVuxCN7C/IwL6/AdMQh07RQWVdDUGga5Awpz0Y2LdOq52RG7GW4c8JbFjaAyg4jl6OUhMszy9IMrdvdTRuh6rZF0A6XgiP8hh+10n+Tk7vYvRAdLXJom6TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=GH5vf1BC; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740580653; bh=0MLGL0Ho8ncjPovldYhbohlEnmj/Azb3Aqd9VsDSLcw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GH5vf1BC9HkGSX9L5LowKDsarbTfPCNKL6B1ekgpcPAIRkZ+frnF/14JW8v8IhH6y
	 BR2Yz+qMjj4AZuo+7/CUrkUMhURvfbHtSyQD3ilpiowJrbKYN5e+pQZbzh6ctZfDRD
	 5XC0TJlNf7GSukKOYWmD4EGZlIBREiysvEE15+X8=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 8CF832052D08;
	Wed, 26 Feb 2025 15:37:33 +0100 (CET)
Message-ID: <7bbe958c-0d25-4c68-b562-1c296b7311b7@ralfj.de>
Date: Wed, 26 Feb 2025 15:37:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Ventura Jack <venturajack85@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 "H. Peter Anvin" <hpa@zytor.com>, Alice Ryhl <aliceryhl@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <5E3FEDC4-DBE3-45C7-A331-DAADD3E7EB42@zytor.com>
 <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
 <CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
 <CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
 <f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26.02.25 15:26, James Bottomley wrote:
> On Wed, 2025-02-26 at 14:53 +0100, Miguel Ojeda wrote:
>> On Wed, Feb 26, 2025 at 2:03 PM Ventura Jack
>> <venturajack85@gmail.com> wrote:
> [...]
>>> Exception/unwind safety may be another subject that increases
>>> the difficulty of writing unsafe Rust.
>>
>> Note that Rust panics in the kernel do not unwind.
> 
> I presume someone is working on this, right?  While rust isn't
> pervasive enough yet for this to cause a problem, dumping a backtrace
> is one of the key things we need to diagnose how something went wrong,
> particularly for user bug reports where they can't seem to bisect.

Rust panics typically print a backtrace even if they don't unwind. This works 
just fine in userland, but I don't know the state in the kernel.

Kind regards,
Ralf


