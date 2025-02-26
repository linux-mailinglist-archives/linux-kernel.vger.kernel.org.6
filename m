Return-Path: <linux-kernel+bounces-534028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09812A461BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49623A9A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F52206B3;
	Wed, 26 Feb 2025 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="uJyNltEI"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4B120B1E1;
	Wed, 26 Feb 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578873; cv=none; b=CRAMFdSJ2Thzy4dNWTMP2wFzywxZ40cVNJ4bM66pda1H+q4HDZGY1UrpBc2DFsF9aAq7NyxZZqufcIaSlgg8euZopyD2S1iD+IHIQWdVJo5i8ORUxVyhf5HEhd6ughQIVf4URODbjfnrpryLw6f1d8l/P48+gZf6PDge0MUCvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578873; c=relaxed/simple;
	bh=1RGyt1eH4Ka/VMgXhtB72g/eaGbygk0TK7AcRiMEwl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7wODRXtnaFmxRJfIanmXlEOw+lFdabQsJ4taqVLZ900tpnugf7YjvLpK2WwNgwyYaddT5vZYwNNX0YWSy3LQ4f9Bx4RxgMrE1DxqPnBy6G6wMjT8yF5IV1uS7Fb4BZesnIqLalzeDQaY9D/Nl564Woztu28oZOavbwnSl8hX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=uJyNltEI; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740578870; bh=1RGyt1eH4Ka/VMgXhtB72g/eaGbygk0TK7AcRiMEwl4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uJyNltEIfKJUxsnzBoiT1Utnuz3R9n029HSPfVPfL1PxUg4FdYgiZyFQrp7qbhxu3
	 V+Qel1VciKGsdbkBUhG6V5s+EsA/q6RN557AFlpWbtcDin4iJjiiGY+1+6e9rZWMZJ
	 AXSk3Zggg8TZek+Dv2quoeSZBrgpFXb6B2g1mRNM=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id E0FB72052D08;
	Wed, 26 Feb 2025 15:07:49 +0100 (CET)
Message-ID: <ca0cca13-2e00-419d-88c9-06faff6aaa08@ralfj.de>
Date: Wed, 26 Feb 2025 15:07:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

On 26.02.25 14:53, Miguel Ojeda wrote:
> On Wed, Feb 26, 2025 at 2:03 PM Ventura Jack <venturajack85@gmail.com> wrote:
>>
>> One worry I do have, is that the aliasing rules being officially
>> tied to LLVM instead of having its own separate specification,
>> may make it harder for other compilers like gccrs to implement
>> the same behavior for programs as rustc.
> 
> I don't think they are (or rather, will be) "officially tied to LLVM".

We do link to the LLVM aliasing rules from the reference, as VJ correctly 
pointed out. This is basically a placeholder: we absolutely do *not* want Rust 
to be tied to LLVM's aliasing rules, but we also are not yet ready to commit to 
our own rules. (The ongoing work on Stacked Borrows and Tree Borrows has been 
discussed elsewhere in this thread.)

Maybe we should remove that link from the reference. It just makes us look more 
tied to LLVM than we are.

Kind regards,
Ralf


