Return-Path: <linux-kernel+bounces-375038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB969A9015
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94AA0B22725
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB151C9EB9;
	Mon, 21 Oct 2024 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="bTlg/rmA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9+AX6vi"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B9145FE8;
	Mon, 21 Oct 2024 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539979; cv=none; b=S3sxAyG1QNPnkSEhBYlumo8lbZ2sjzgV00JL0M7uW3nJs0bMuFojpJqwQw7b2eaG/wYcg9haXwW38Rpe3wdSiDZZWWDmODPOr6Zw0bfiKBYRncOQXHUcC1qoJv+mB4kKj5bgagxjkun0yJuwZEqlX3UNTR50wpKUQVmxTIHAJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539979; c=relaxed/simple;
	bh=TtQwBt8ZotMQii1U0Ih3L4Gg92i+ZlrIzrJpbpXIkP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcLh0vJFtlFg5bFKM8HPaEZMdOWHrTHI3pqfZaFvy9SXp84Sp7hJYxoVFqPzel0Qil8iBntv4F/YHgQsH2MDt975Svs9nD4Y+yRHxmyf/SO57a6ZUM6nb8LxdaY2H+ZniXBG5UxRME1eZJqFe2NrdsFdNIoWOz06UgtYo20fakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io; spf=pass smtp.mailfrom=ryhl.io; dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b=bTlg/rmA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L9+AX6vi; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryhl.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6AFA913800EC;
	Mon, 21 Oct 2024 15:46:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 21 Oct 2024 15:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729539976;
	 x=1729626376; bh=nVSNeQ8pRXqtaa1i/ayXGAtU7aaY0oQNDtra/+rIYGU=; b=
	bTlg/rmA94EhLc+ywVQ2CyE3axjRYJPiVitN7erZt/R3HE8E8m/yl5aZXXuMioVa
	09ZigGRkVphyt9F52r1lc/rhknlRqyII8D3H2ZSSJPlugqe6uns8qeS5Se6F5hlR
	fYbyW/QHRHTF8lX91k/ateDnC60wDbNwaGhd1I9VeWEgbz1246cQxjunVtzUAgXd
	lNSqB5eNySW8xICwSaT3HG/SJMrfCsFPehAS0RPL3FVcopYJYLcbIV+psI3xaCAD
	9leTsc8Jp9URjy7u3TH6X6c3FmjWDxFLEYWlC0P9uKQGqAKkome073X/U3Fy2Qa7
	DxlfhYHGs0h2RMzl/Cws9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729539976; x=
	1729626376; bh=nVSNeQ8pRXqtaa1i/ayXGAtU7aaY0oQNDtra/+rIYGU=; b=L
	9+AX6viACEmVROHmvaH+KzT7FP/l49Q7L0FxjF3OiDKR9KaImTDF/XX4fajac5c0
	SpdfSipcIZLmXgFf4wBeixZ8xoFqcO008EE/1nHnaE3FNchu2/uGODD8ov/zhSvz
	8Bjw1oyraYi5VP9h/nuiXtDjg9zguqX/9mYnFsz7IgSpzvuw4hdSC3wdUOEv4g/P
	YGRuIrwTIvX8/JB+v+eCarpoltiqrSNSpQ3KDYK2OZUPTuryBk7dk9oTBNumu63t
	xrkIwqExSN1O8pFIqhKjbBeA6Yj67xqcVaXyx/faOB9lIitgUmtOIQgsOnaRzVNz
	cgbCWidX+Du6PTaP+vVzg==
X-ME-Sender: <xms:iK8WZ6B4luqIxIdx9F03Cvj6vKikBke6DTsE0S0bBGb-VlA6SZQ64A>
    <xme:iK8WZ0g4502IIZmOPdxrADNE8wHggqBVEr__12S3wmGA8dn46IjHsgAze-bBXXuEk
    wsL5FOKfYTpBHGcYA>
X-ME-Received: <xmr:iK8WZ9n-wzEHAfEG_nhh7g-oGFjdOkyiSeDJGXLMdDmCwuTg9jjL9XS0bOqOlV_m8_cCtXjCpkM0_k04GHWJDcetef8yrEi3XS8_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomheptehlihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqne
    cuggftrfgrthhtvghrnhepkefgieeigeehgfdvffeltdevuefgtdfhfeehgfegtddtjeej
    tefhvdfhtdehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghlihgtvgesrhihhhhlrdhiohdpnhgspghrtghpthhtohepudeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjhhhusggsrghrugesnhhvihguihgrrdgtoh
    hmpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrghilhdrtghomhdprh
    gtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmhes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepfihilhhlhiesih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:iK8WZ4zkWaqkSni-SqIWJWalmL6mXsaI02J9nR9dWxEOUT9il90LMg>
    <xmx:iK8WZ_Tb76C75pSRB6rfcwfyPRHkwlPwexqbF8fGhy28GIEQpf5vTQ>
    <xmx:iK8WZzZ7lONmiidj_ZWdNp3XrTdfWqDghrxmopKmV5L_Qqn534iigA>
    <xmx:iK8WZ4SLUCmdD26qwRM2A_WqgnhGEFLHBUU32WdOuJEVp2kXy6j4-A>
    <xmx:iK8WZwCtrqXTYvlpIO1zF9EZAOw3kh4ma2OP8N_BKSVczKh_oNxAU2dW>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 15:46:13 -0400 (EDT)
Message-ID: <d9b79f25-ae52-4cda-86d0-d4cde9338644@ryhl.io>
Date: Mon, 21 Oct 2024 21:49:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
 <81e9b289-b95c-4671-b442-1a0ac3dae466@nvidia.com>
 <CANiq72mW8seB=938XZM7bwdSU43z0eePXinE5QPYyybvNfbUeA@mail.gmail.com>
 <dc5e7653-8d6d-4822-9c29-702ece830717@nvidia.com>
 <CANiq72kuQ-fNTYw33czgN3_DYjixzk01+hahFhR4QSkENeDBkw@mail.gmail.com>
 <b93805c1-28a6-4ad9-b0d2-5116ef4b0d83@nvidia.com>
 <afc139fe-ac03-43e7-a5c0-22410f1acea3@ryhl.io>
 <682c97a0-9877-4e31-b180-c1e38d3bc883@nvidia.com>
 <CAH5fLghMiNbyD-As40Rz+eRzxMVdX9TXwesxN7cbu-iW2bZJpQ@mail.gmail.com>
 <7d708e79-1a94-499e-a0e8-c3431aeaea3d@nvidia.com>
Content-Language: en-US, da
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <7d708e79-1a94-499e-a0e8-c3431aeaea3d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/24 9:34 PM, John Hubbard wrote:
> On 10/21/24 12:26 PM, Alice Ryhl wrote:
>> On Mon, Oct 21, 2024 at 9:09 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>>
>>> On 10/21/24 11:59 AM, Alice Ryhl wrote:
>>>> On 10/21/24 8:41 PM, John Hubbard wrote:
>>>>> On 10/21/24 11:37 AM, Miguel Ojeda wrote:
>>>>>> On Mon, Oct 21, 2024 at 8:35 PM John Hubbard <jhubbard@nvidia.com> 
>>>>>> wrote:
>>>>>>>
>>>>>>> Is this another case of C and Rust using different words for 
>>>>>>> things??
>>>>>>> Wow. OK...
>>>>>>
>>>>>> I am not sure what you mean -- by BE I meant British English.
>>>>>>
>>>>>> See my other reply as well -- I just changed it anyway because Rust
>>>>>> apparently uses "parentheses".
>>>>>>
>>>>>
>>>>> Right. For spoken languages, that's simply preference, and I would not
>>>>> try to impose anything on anyone there.
>>>>>
>>>>> But in this case, at least for C (and, from reading my Rust book(s), I
>>>>> thought for Rust also), "parentheses" is a technical specification, 
>>>>> and
>>>>> we should prefer to be accurate:
>>>>>
>>>>>       parentheses: ()
>>>>>       brackets:    []
>>>>>
>>>>> Yes?
>>>> What word would you use to collectively talk about (), [], {}? In my 
>>>> native language they're all a kind of parenthesis.
>>>>
>>>
>>> Good question. I've never attempted that when discussing programming
>>> language details, because it hasn't come up, because it would be a
>>> programming error in C to use one in place of the other. And it is
>>> rare to refer to both cases in C.
>>>
>>> Rust so far seems to have the same distinction, although I am standing
>>> by to be corrected as necessary, there! :)
>>>
>>> At a higher level of abstraction, though, perhaps "grouping" is a good
>>> word.
>>
>> Rust macros can use different types of brackets. For example, the
>> `assert!(1 < 2)` macro uses round parenthesises, the `vec![1,2,3]`
>> macro uses square parenthesises, and the `thread_local! { ... }` macro
>> uses curly parenthesies. The round and square brackets are used for
>> expression-like things, and the curlies are used for things that
>> expand to top-level items such as global variables or functions.
>>
>> Macros cannot use any other delimiter than those three. So e.g. <>
>> wouldn't work.
> 
> That answers my implicit "are there any cases in which you would
> want to collectively refer to all three types of...bracket?", yes.
> 
> For the original point, though, we are not in a Rust macro. Is it
> actually allowable to use [] or {} here:
> 
> +    // Brackets around PAGE_SIZE-1 to avoid triggering overflow 
> sanitizers in the wrong cases.
> +    (addr + (PAGE_SIZE - 1)) & PAGE_MASK
> 
> ? Is that why you were not seeing a difference between saying "brackets"
> vs. "parentheses" there? If so, this would be yet another case of my
> Rust newbie-ness being inflicted on you. :)
You can use both () and {}, but you can only use brackets if you're 
European. ;)

Using {} to create a block works because a block evaluates to the value 
of the last expression in the block. It would be super weird to define a 
block here, though.

Alice

