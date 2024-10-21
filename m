Return-Path: <linux-kernel+bounces-374975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BC9A72B2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47DAA1C21276
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0E01FBC9F;
	Mon, 21 Oct 2024 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="m8bsw8TU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F6s09tF7"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB701FB3D6;
	Mon, 21 Oct 2024 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536976; cv=none; b=UwRIrnO3/RXuK2N/5H7ZANOmpHa5/RO2cnvuaKq0+SnHFDSigXD/WmCTHuL59N1ox0qFHrFQDkrUfFO6n6SdpzjpTuLJaq4d8/fx3+1Z4AHIRcM3bF++r9IKG15Uk1HLAlt7/rRTB535K82ah/lJhDF5mG4fbWsZ1MU6rE9783Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536976; c=relaxed/simple;
	bh=/IPROGTA0htPr53cWP8DGFpla2+xGW/oBPBfV2xWNIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NapW/6rFLJaZhBOO8+BCZRSO1a/4aiEc+OC8uWDfx1pUtVFy36+PiNYIp1HqFLH2LKunOaKEv4WNpGRzZLDC43R9bj/+fnJLgOElBdKgUKkyF5Gk+z61YwmnGq7miUxbpWBqu8fkjg9zBwmdFQh1dJH9Jbm9p0x+JGBo3SUlsCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io; spf=pass smtp.mailfrom=ryhl.io; dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b=m8bsw8TU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F6s09tF7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryhl.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC7D611402A2;
	Mon, 21 Oct 2024 14:56:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 14:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729536971;
	 x=1729623371; bh=8/knyt373KHC7O1bo9D61lcsLQGqkBmLhK7MvjS+qWY=; b=
	m8bsw8TUaAs3RBjgYzy1fe/EZrQXxBXzToL6+H5Iv99VmdZxfjrDXYp1dYebkc5I
	ZjmB1Hl9hcyVq+vKMQARserywIkRHfNwnlQwZbvez7la6I4ulMx4iUa86HCFPbk6
	ArK0dCoeQYb3rzWY3xvgqWujXWqHjjwYvNaA1dui/SKBBDbQvXkXHrGzRhYiDsS7
	9JZIgx1Pe1uLf5cPAyuNNIcgIYRSEJS+UVQJVktxarapphL/Ii9iXEC4h00C7A3q
	TYsMFrB7YBD7wcPB0Nz5WcOxQ5EtzamAvuhA2zsc4PpFYsgeUyS3lrOQisBrHWUc
	Igt7vK52dHxJLb1plcTPuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729536971; x=
	1729623371; bh=8/knyt373KHC7O1bo9D61lcsLQGqkBmLhK7MvjS+qWY=; b=F
	6s09tF729gSFKsF09r8Ko81NvHFQxLyFaqcDxBEF3z2/Q6Hg908Ee2IHJTXxxFTS
	k7csOX+HDMb4TFXsDle+1rNNOyvoYuTh7zpad9rl6l7dtsFAhjclrzsTLLa4/P22
	vWi7HWRGhm3rVnayoK9gVTeFo03EvuytUVof7U5F0e6P7NR5bdWwpnWilIMvMI2L
	BNJsn8d+98+TqmwXbR7nh9KFpIiZmGdurba7qYQJ/HajND3N/Sv5OY1X0xwHp3nH
	NUWaJLIHBmgCqdp+h3dOW4NV3vSspFbfrYQHqmB51BXaypirxyaJ7Q/R91Q7m6vC
	C4r8URhh05YoGQ1gD9CxA==
X-ME-Sender: <xms:y6MWZ5pUbuqYDpdMelJvlEq2pSYaEL1vnmaJv1-6Xx_iwd7HFFWtwg>
    <xme:y6MWZ7p96sKSI9QhklxGyYaIKCd69sPwvmrlG8e21tKMxZroVBBO8SFf97tHA6wK8
    UiMWzBaRB6ZVafdIA>
X-ME-Received: <xmr:y6MWZ2P8pNVDfELTcLEq1EZCtlhml79O0xuQD5WszRjOQj-nETAgzj4NMqiqmi9L6xy9TdqlyvaGsRiWzkhCgKYR1LU7A15VU3YR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomheptehlihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqne
    cuggftrfgrthhtvghrnhepkefgieeigeehgfdvffeltdevuefgtdfhfeehgfegtddtjeej
    tefhvdfhtdehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghlihgtvgesrhihhhhlrdhiohdpnhgspghrtghpthhtohepudeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjhhhusggsrghrugesnhhvihguihgrrdgtoh
    hmpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrghi
    lhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmhes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepfihilhhlhiesih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:y6MWZ07UJ_zFWnUmj4_UrqPCKa3I9RDc-fnQegaVetjItfW9gXHfjg>
    <xmx:y6MWZ449372GYJCqRmuTC5_h-Mr5qT39kz-d_7_Z6TqcmY7qr-nGdQ>
    <xmx:y6MWZ8hlKc1wwqesNJYLfd25dpR_itWd_MaKl6xU2U7B_WH4JfVIsg>
    <xmx:y6MWZ66XD0OGOWww8R-jMj2CpKf98mc7uz_GrUBqZvLbubipFw9dGw>
    <xmx:y6MWZ0rYRDtsYGYsNUt33pw1qrpJ-SuBNQIPf806lPO0htLVbQstKCK6>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 14:56:09 -0400 (EDT)
Message-ID: <afc139fe-ac03-43e7-a5c0-22410f1acea3@ryhl.io>
Date: Mon, 21 Oct 2024 20:59:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: John Hubbard <jhubbard@nvidia.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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
Content-Language: en-US, da
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <b93805c1-28a6-4ad9-b0d2-5116ef4b0d83@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/24 8:41 PM, John Hubbard wrote:
> On 10/21/24 11:37 AM, Miguel Ojeda wrote:
>> On Mon, Oct 21, 2024 at 8:35 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>>
>>> Is this another case of C and Rust using different words for things??
>>> Wow. OK...
>>
>> I am not sure what you mean -- by BE I meant British English.
>>
>> See my other reply as well -- I just changed it anyway because Rust
>> apparently uses "parentheses".
>>
> 
> Right. For spoken languages, that's simply preference, and I would not
> try to impose anything on anyone there.
> 
> But in this case, at least for C (and, from reading my Rust book(s), I
> thought for Rust also), "parentheses" is a technical specification, and
> we should prefer to be accurate:
> 
>      parentheses: ()
>      brackets:    []
> 
> Yes?
What word would you use to collectively talk about (), [], {}? In my 
native language they're all a kind of parenthesis.

Alice

