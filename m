Return-Path: <linux-kernel+bounces-366479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFA599F5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254671F25380
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC42036FA;
	Tue, 15 Oct 2024 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="t3s9ivZs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EcotUn04"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9BC2036E9;
	Tue, 15 Oct 2024 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017682; cv=none; b=acA/kN7xVQXxktWKvpWsd2mGLO5HwvEynfD/oUONYTkGghoSv0Z3nYUMvDS2pw5IDPyP2jer51ehvZraH/6Gk94aSYNbljJAHUjVUsGqHh4PLvFtVMiCYRhb49LlpsTtaLUYsiUGVGUocmKBnvN68mhzdJKw5i0PdMk3jKq98DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017682; c=relaxed/simple;
	bh=2eZIjvihWEM5geU5ik4AfAwmWoRbMdJ3lZPi7M/Kwk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mO0r2PvPAUMu+hSXJjlF+lye35DhsHb1YhB4Ldw1pcRT9N1IflyugAkfWVQneFIDuMps8sjcK10t8pvTcZ/k6Tg866KllMsHnJlqA86dh2MSApIIh2WSebjZvydkN91uCfuhwerdk5KlKdMi9eaIKBAvJdnWaFxr2Z9IERtus+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io; spf=pass smtp.mailfrom=ryhl.io; dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b=t3s9ivZs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EcotUn04; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryhl.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5AC2813801DB;
	Tue, 15 Oct 2024 14:41:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 15 Oct 2024 14:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729017679;
	 x=1729104079; bh=/M9sEvglFwYFFRw+Fxs1ReLqO49t1fQGy/y6rplIerA=; b=
	t3s9ivZsiYqISS2XILFZASY3G0nReuuEv7LmVx8h8WJBFXwKBAaJZDXSH0iD/W4Q
	ajt2wFpnIlO7cykF81SjPvyFtQfboWfbftoGNyHicFUzn/xRxojca9Et4RwMReU2
	dxw7CLTRdXhC8y2nawBnFAaa6r1PqMakQMlbtdJVVpcy1SO3o9CuDwieqi1Lf2IM
	xYgcWNbUtYLIKdoDVaJ1MK6OiBXCuUHnpySfcBZCUNha3a4BG6uW/3KED6jEnBDR
	2IChk+KsQM5qeAc16B+maZlsjOEyoZp5WCiIFhkePKH2um3yNyhtA+VeQNNRv6uW
	CfGU5ImoJu5hDHBXkqWniw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729017679; x=
	1729104079; bh=/M9sEvglFwYFFRw+Fxs1ReLqO49t1fQGy/y6rplIerA=; b=E
	cotUn04J+aguvlmt+Ezr7Xh8bpoyRsppFhEYEKR6slfCVbMYnrsEHOyC8s38JdTO
	/JgniILf5vEA3NObjLsT2C1D4eR2bZ/goG0ifxhx6ylNLbPXKK45CcZDWwRCusXf
	zEhzJoOtVIFT4DJ4OIZt8AbscZvezlZQWTCIgUmEb2vLhTbqpEYYH9KLPu/hu6OE
	ykKesoJPiYm8fXPIl/7BVR4+6+gwK8qw5KiKkPAu5T20uDSrIPNtX6akCyNgsdAT
	2uztvdZpdaxq3vA8ol+opnkwEZxjtZexwZfCabzytepIDcOgpiqfR88KNNHTP9OS
	s3Iqwzk4iZbjgVC+W7Rqw==
X-ME-Sender: <xms:TrcOZ7edsSFugR-YENAMiFjwMkFAgmNYBqTQQksh7ecZzDVtMTrazg>
    <xme:TrcOZxOt_Eq4QAu8urV1n9M5S9cIlIytNJBikGJDX-2sVZr9OV0q3MG4NI1d8_Z06
    Sgpb92yVrOql8nt9A>
X-ME-Received: <xmr:TrcOZ0gb-e8tPOeH27fZmdpK9GVQpDPBl0JVVBHT0Zv6qZUkKpstP-ijoFnlU6tmZ6ItkpoQaGidgKobLGnHBv9lTABAfh6qQC8q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomheptehlihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqne
    cuggftrfgrthhtvghrnhepfefguefgtdeghfeuieduffejhfevueehueehkedvteefgfeh
    hedtffdutdfgudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghlihgtvgesrhihhhhlrdhiohdpnhgspghrtghpthhtohepudegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinh
    hugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohep
    sghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnh
    hnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:TrcOZ8-51tbgJ7XTO7n_ZLdNmeVXXto8uJdXuRERmVJUMJOr1HadMw>
    <xmx:TrcOZ3vbdG0Mieaff5ojfCLxbwS0wjY5xLqz3aYoGKhF5oYMLYumcg>
    <xmx:TrcOZ7GRPBhKUZuJdvCCt4vSNEpDdK8lCJBCTU3OuRHBLooUasnJnw>
    <xmx:TrcOZ-OfePzKhjghqj0GDrqz3vORcQknTGADUAE2gvD5i_VEXv00mw>
    <xmx:T7cOZ3HlSM3-EyjFMqCVPjNZmNlt2Rf-z67N9j5exX8IvcJyoVMt2qrv>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 14:41:16 -0400 (EDT)
Message-ID: <3ea20eb4-2a88-40bd-a453-bf2ff5d52d03@ryhl.io>
Date: Tue, 15 Oct 2024 20:44:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: page: add Rust version of PAGE_ALIGN
To: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241015-page-align-v1-1-68fbd8b6d10c@google.com>
 <Zw61edSZrAb8pH1X@boqun-archlinux>
Content-Language: en-US, da
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <Zw61edSZrAb8pH1X@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 8:33 PM, Boqun Feng wrote:
> On Tue, Oct 15, 2024 at 02:28:28PM +0000, Alice Ryhl wrote:
>> This is a useful for helper for working with indices into buffers that
>> consist of several pages. I forgot to include it when I added PAGE_SIZE
>> and PAGE_MASK for the same purpose in commit fc6e66f4696b ("rust: add
>> abstraction for `struct page`").
>>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> ---
>>   rust/kernel/page.rs | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
>> index 208a006d587c..90846e3fe829 100644
>> --- a/rust/kernel/page.rs
>> +++ b/rust/kernel/page.rs
>> @@ -20,6 +20,11 @@
>>   /// A bitmask that gives the page containing a given address.
>>   pub const PAGE_MASK: usize = !(PAGE_SIZE - 1);
>>   
>> +/// Round up the given number to a multiple of `PAGE_SIZE`.
>> +pub fn page_align(addr: usize) -> usize {
> 
> Make it a `const` function? For example, there is a VMBUS_RING_SIZE()
> macro in C that calculates a const number for a vmbus ringbuffer size,
> so it will be useful.

Good idea.

>> +    (addr + (PAGE_SIZE - 1)) & PAGE_MASK
> 
> I guess overflows are unexpected, i.e. the users should not pass a
> `addr` that `> usize::MAX - PAGE_SIZE + 1`?
Correct. If this wraps around to zero, that's incorrect. Note that the 
minus one is in brackets to only trigger overflow detection in the right 
cases.

I can mention this in the docs.

Alice

