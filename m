Return-Path: <linux-kernel+bounces-374950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7839A725A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E49F1F223AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F251FAC46;
	Mon, 21 Oct 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="rOV7SWwB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NJjdcg90"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC641F942D;
	Mon, 21 Oct 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535353; cv=none; b=LqTpWZlokU59szIxtIE1LjRl99mZUoPfieHYW8l7Bo/wUOr1hFx3ixean3dihkKhFpDkL22w0ZZi6lIh9y1DV4YEcjVcaVa9l2EVoWB+/DnEOvzFNOW4BinSkyeP3wCGlvcjSmt3xiiqD7jndcHvpYwx5ifkLPoUoGREUlOGAzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535353; c=relaxed/simple;
	bh=wGf56HOWPEAJ4DCDdsL3K6DHH1vg5bhFGfsMNNo+ktI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7cWlBk4QOf3F9hvkPMGL6F00r94+GhFzUbDJFw0tjmgcZ1YV9s0MgeD6cHPi/QVf++gIvQIiHSjZRZN0V4yXi0N2YePacDQOPUv7Gfnq9fk/YtASBt1qNVjuYRafq2kfvzL/IpDeDIZxtfSS9W6xYKKvSQzvAP3c/JEKYSnT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io; spf=pass smtp.mailfrom=ryhl.io; dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b=rOV7SWwB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NJjdcg90; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryhl.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E3F821380211;
	Mon, 21 Oct 2024 14:29:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Oct 2024 14:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729535349;
	 x=1729621749; bh=lfMv/gEB7Fyh2WyXq+JcQ/WoYPqo5T4/tBmvvpdRhJA=; b=
	rOV7SWwBsrFdn/qJriNNPluYBAnFHA7xrFZNYPZO9w0ApdMlkRE/ggcWuReQoofH
	wNx6c88VuofHtZX8Dn7PO/3E1zQOAQAsn0MZYZsTipH1XxbVhLBIU+U322DaO1zf
	gvv4fv6lFz7lmjbeMM2LEFLT0Pt0CjC0tqVye9M2VRCEIb2yPc3mAfoXLnwsC03D
	Zpab4Zw+ZiOsAXCt2GOEDxscsQg8WIox9jooP1y5os8svt0U7cVaIF4MQ+FPzq9O
	7u9eJyamlBV9bWj106g7NLgzXy8kJVPOh+Cg6yj/vdnyNYhkAvEaMIm46Pe7OPIq
	c89qz/IO1qseUPa4+UPffw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729535349; x=
	1729621749; bh=lfMv/gEB7Fyh2WyXq+JcQ/WoYPqo5T4/tBmvvpdRhJA=; b=N
	Jjdcg90unnsZwAiQtEjrllg2dHY5NvgV5fv/g53R61XbEqQZ0Fz6/w6NaiD/N7mg
	hsuDJtitLqsoIibx8WSP5zQU1lu+0ebYDhKaIBGnSXVHyK3zBwyRLE6lFfmKHfMC
	ujTgEkuiv/Ht8zOxrNbtvUhuBNzLQWx7TzsaLfUUTgwSIyKziOQUzdunn5MaoAho
	/lbLRSqwNyqdNyouoAiiTwAKKwUjdZrOdkuRxoon6hxc3ZlYqToHs3l4k3vGd+IG
	OhYtEVlQbQBfp+2jyozSu++YhFWwe9L7WtP7xV+rvs1TljkYaY4fbZyn0FsYhMLm
	XaMT8gU+ubgiSZK51K56w==
X-ME-Sender: <xms:dZ0WZyd4qz17f9PXyTuPLDMr76lLVXBLM3ywl9QcbEjQgxxoj-pnQw>
    <xme:dZ0WZ8NO3y24dQjZdFmtRJBjkOl4zCNLllboc45om9bn2cY0kMCjxvkS8BlpZiuVU
    UoQxXlr7ndXyYG2AA>
X-ME-Received: <xmr:dZ0WZzgT_NUt-vI0l2kLfsoC-ivNl0xtxOsXiZbeo0xEGZza_U0d6JvftP-F_pMc1w2GX-gCUdkEwDpIVnYi6MdwyaRJjNeZDP0N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomheptehlihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqne
    cuggftrfgrthhtvghrnhepgfduleegleehieelhefgjeegleeffeeliefgtdfgteeflefg
    fedvgefgvdetjeetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvsehrhihhlhdr
    ihhopdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjhhhuhgssggrrhgusehnvhhiughirgdrtghomhdprhgtphhtthhopehojhgvuggrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpg
    hghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhs
    ihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:dZ0WZ__qGyKzsnoBIj8TDhjBW-Yo3OQhnJNlgp0ig9muq0po0qG2CQ>
    <xmx:dZ0WZ-vsW5zEnRXZEj-iPUp7IZdr-BQnBJH68yy90j_NwYIHPP1E2A>
    <xmx:dZ0WZ2Geid23f1MgKGVpVRYfHhwC1AUgJ65zk_uwU9QEKDMHXGTuyg>
    <xmx:dZ0WZ9Mm7Yn7gDpSL-RD3OsR2_5ILLRMTFdzIoLJBNLP6yi0xmD34A>
    <xmx:dZ0WZ6O0GK03kktAbJxHNRFIN0WBd4rN97WXRZVi_FZ0Jmu7AZuX1qbh>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 14:29:06 -0400 (EDT)
Message-ID: <56169ee4-321c-4546-bb89-2f9530adb01c@ryhl.io>
Date: Mon, 21 Oct 2024 20:32:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: John Hubbard <jhubbard@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
 <81e9b289-b95c-4671-b442-1a0ac3dae466@nvidia.com>
Content-Language: en-US, da
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <81e9b289-b95c-4671-b442-1a0ac3dae466@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/24 8:20 PM, John Hubbard wrote:
> On 10/16/24 4:34 AM, Alice Ryhl wrote:
>> This is a useful for helper for working with indices into buffers that
>> consist of several pages. I forgot to include it when I added PAGE_SIZE
>> and PAGE_MASK for the same purpose in commit fc6e66f4696b ("rust: add
>> abstraction for `struct page`").
>>
>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> ---
>> Changes in v2:
>> - Make the function const.
>> - Address integer overflow in docs.
>> - Link to v1: https://lore.kernel.org/r/20241015-page-align- 
>> v1-1-68fbd8b6d10c@google.com
>> ---
>>   rust/kernel/page.rs | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
>> index 208a006d587c..9ef01929e7d0 100644
>> --- a/rust/kernel/page.rs
>> +++ b/rust/kernel/page.rs
>> @@ -20,6 +20,15 @@
>>   /// A bitmask that gives the page containing a given address.
>>   pub const PAGE_MASK: usize = !(PAGE_SIZE - 1);
>> +/// Round up the given number to the next multiple of `PAGE_SIZE`.
>> +///
>> +/// It is incorrect to pass an address where the next multiple of 
>> `PAGE_SIZE` doesn't fit in a
>> +/// `usize`.
>> +pub const fn page_align(addr: usize) -> usize {
>> +    // Brackets around PAGE_SIZE-1 to avoid triggering overflow 
>> sanitizers in the wrong cases.
> 
> Silly nit, but I did start looking for brackets that aren't there, so:
> 
> s/Brackets/parentheses/
This isn't a distinction that exists in my vocabulary, shrug.

Miguel, feel free to reword when you pick this.

Alice

