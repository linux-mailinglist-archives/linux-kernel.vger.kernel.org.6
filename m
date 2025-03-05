Return-Path: <linux-kernel+bounces-546026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7194A4F554
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83701888F66
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F471632E4;
	Wed,  5 Mar 2025 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0/4pCLM"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D2A95C;
	Wed,  5 Mar 2025 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741145060; cv=none; b=Y7uoJZJn4/WAAv47f4vbj3C212hP3+fz7LykBwMYmpJUh4+tUFXwPxdOC3C8FT2dO53jkmFao9Tymww1CtEnhPzXPC4/5fmWCSuTQrwctK0D7qmfYqkJaZGqtT+kWS6t9QCJEuMGPpdVbhGGWvYb2ZGrt1AaoN1A/8Jn0uiaGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741145060; c=relaxed/simple;
	bh=IalM6GcSrc2FXSX/2tWDq59g6jT4l3qYVHbrQtNGqOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFkLeGEldDjdGw+0S28hZWnu6UkukH+Wt6f3zyGNjzJUudq5Gdzw3lBgnxUpgKBIE43yL2EHHqfF5IOK1HVZZKRuzgEVtDQ4vKe5jZxZyWijy7ydbgmSixxrH7TUaT0W6WID3mIX3EiQl0u/iLVjYckC4KJcZGiuejFG3EsrN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0/4pCLM; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c3b4c4b409so498723785a.3;
        Tue, 04 Mar 2025 19:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741145055; x=1741749855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VCYzw7AYHEWhjh2pCKxrHo8DdwWDp+puWkHCQL3OAfM=;
        b=A0/4pCLMtqKeHHt/gzhCZRLLBnfaIq4gqTgnmvz/L0zI6WTj87LCD8jv/DeX3HFoNk
         DF8BTqYuwyZ/j/znebjlzFNiBs5dYwVoqFtAQ0K+Ix46mf5VvuefMWwTGletm4IyR2zE
         HctXgAKXiYJgGgQHQ82NfiukIq0H3tOj5w3c5Ez1JA6DetZ3FheCef8jU6h9ePbiJaOk
         drgmC1r+v6kDPFYMIsXHs+FI1IBO5sO1zoiBo6DkczfSttIOTeYUMvsPOL9pUAk3/lKk
         p1pvMNqSa7nXKiZmYbW6rc0pNspEwu3m7GSvt8OR2XYthxB+WVQcax5xpTfgsm0rg0Fc
         hnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741145055; x=1741749855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCYzw7AYHEWhjh2pCKxrHo8DdwWDp+puWkHCQL3OAfM=;
        b=VGiq4I1mEkVLFL4cF54zFEgBmHGNYey0D5fqK1Z4sjvDlNyIMjF7z4dgVPZCKdV5Xm
         n6NQ06bKDZ5sPTfZvGNI4S/0wP4vWwEmG32nRy7xzguh6j1JaWXzkDOqcZw5jXxjPggu
         z1dDgVHty6xO7KfBA36MCnhRydMLE4it5/JuAsLSGt4jdKhDzuqpyxWHC/96hbEWUnch
         uDa3a2dE6bFvfXhxXpbk/s7xeTB++m7a4OA6xicIGhDT/OPs++Q4dLGDPlitSXQE9lE4
         xfRYmivojoY7lPl8YypQI3mjJp5NQ5mj0rLaAtDD+Cerz/mT/bvlI+c8Q95pjxlIA/k7
         eg/A==
X-Forwarded-Encrypted: i=1; AJvYcCVF9cdAcVDK+YjWefbSulf0Msdq7iCQrpzfWGHABbt8GJcf+kPSi2sa5g0171k3O0gifmPluyCXYkqattQ=@vger.kernel.org, AJvYcCXYAJD4T/f0iZn11dT3G3QFK86S3ikHzi2kIwG0wpFeUhmbpSybj5zi01i2y2g8dbuWhpMM/elWXrswLFqHGTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyclXd+nrhd1eYpRCiNUd8ES34V8NLfKv86p0sK/fuhAih4CqTr
	c1nEt5yFmIcP5udLJPvSECsB4dgN/pTBBopaYCRl7QjjmLhQ9meR
X-Gm-Gg: ASbGncv3/o4Ome8eVaEa3qqZ9S6hzTunYIv/vStVlwxLOo8jWLYlIbMYZ85rYBt6Xsc
	OvdckIQg1yFSZ3pGSGXlpPy47p0gWvaZpSQ9+Jtcecolm3EpxJ+EDJ1ah2AMObh7VZtEkC9iv0O
	P/e+cWfJo1uP8nitffaRQ4JP3HgraFPZTjeVcF3YG2vFjYoZYMCxQ8mXabdv0ECS/jVSjAjID5/
	uMqvPQ8zRiVTSyYJsI7XZpI63UfW2iPzPpQFzZainomq5WZqNS8Q8VffH2ET4jV39tK66JCWXmm
	jyR+gGuoHB3k/PrnByiMAMQHuY8W/2HzL3ZojHGbdQsTSyPR05TvgDpW7wdNpC/Ei62v3M7Iw2j
	Wh2J9js5HLfxSULEJ+pZSZOaO0BkIZxClP5U=
X-Google-Smtp-Source: AGHT+IFkyQ73hd8BMJx+FC6q+VcIyRCQMDhKffer4K2eUcYMOGHylCr7hZHPBGmpGtT4iP9zVL947g==
X-Received: by 2002:a05:620a:6087:b0:7c0:97d7:27dd with SMTP id af79cd13be357-7c3d8ec7ebdmr335437485a.48.1741145055135;
        Tue, 04 Mar 2025 19:24:15 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c3edff13sm291499985a.69.2025.03.04.19.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:24:14 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0DC551200074;
	Tue,  4 Mar 2025 22:24:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 04 Mar 2025 22:24:14 -0500
X-ME-Sender: <xms:3cPHZxPDh_XhD3GBFoAYAvygkcvXFCcn57YSjIdiUZx01UJKNk2W2Q>
    <xme:3cPHZz89ixupj5JKX_bBZoIIAORmtaivv-bxCC4OTSp8w8cJNttQUh656XAn3IITF
    x6vtyrDjIXGafZhrw>
X-ME-Received: <xmr:3cPHZwQGxOJe9SmxeS21xY5OBvZZ3Zik0482r-TSjEtzNvcs5hPEC9aATA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhephfekvddvtdekgedvgefgveduhfeihfej
    heffkeefveehffehhfehkeetheeileejnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrd
    horhhgpdhkvghrnhgvlhdrohhrghdplhhlvhhmrdhorhhgpdhgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtohhmvgigkhesghhmrghilhdrtghomhdprhgtphhtthhopehpohhsthesrhgrlh
    hfjhdruggvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    gurghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthho
    pegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrsgguih
    gvlhdrjhgrnhhulhhguhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrkhhrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhiesrghrmhdrtg
    homh
X-ME-Proxy: <xmx:3cPHZ9uTcfObnarRoojUAy1B_6gP4rES_VkXm8sJwlr1UboBuD-JSQ>
    <xmx:3sPHZ5d6WiZvDs9uXESVzy4wnfv3ZEHD2c1vVWrS9vx80O3ecyIZiw>
    <xmx:3sPHZ514xBSASLkKzslb0SuhJGoVZCT8EOi3vDjXTV0-oht4gz3jJA>
    <xmx:3sPHZ1_6XSVlJL4v7FeTINqX_Csf78PYDrJ2m-IDjBRJLfcR26ud_g>
    <xmx:3sPHZ0_BOZIPQUysHVDA8plP6TjC8p2sFvHD77OMAoU1956cqb_cnRtZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:24:12 -0500 (EST)
Date: Tue, 4 Mar 2025 19:24:11 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: comex <comexk@gmail.com>
Cc: Ralf Jung <post@ralfj.de>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Benno Lossin <benno.lossin@proton.me>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org, 
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, iommu@lists.linux.dev, lkmm@lists.linux.dev
Subject: Re: Allow data races on some read/write operations
Message-ID: <hkhgihg4fjkg7zleqnumuj65dfvmxa5rzawkiafrf4kn5ss6nw@o7kc6xe2bmuj>
References: <87bjuil15w.fsf@kernel.org>
 <t4HxdvR7WBX_861hiTXo72jqC9F9oRpIzgA_dD2yhcSuLISEkC-shMfSgllrFPpnkSZXGfRcc47keudMooNiIQ==@protonmail.internalid>
 <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
 <87ikoqjg1n.fsf@kernel.org>
 <KpWTCfIlcLYFBpSvWPfALJ9VQn5a99_RAvxgMBc1aCrSalPB-qaW9IhXyaDG7HM1AcFPX5chj_Yr7IQp3F7UqA==@protonmail.internalid>
 <CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
 <87mse2hrd8.fsf@kernel.org>
 <Z8YMTiKS4T9wC4t_@boqun-archlinux>
 <ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
 <88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>

On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
> 
> > On Mar 4, 2025, at 11:03 AM, Ralf Jung <post@ralfj.de> wrote:
> > 
> > Those already exist in Rust, albeit only unstably:
> > <https://doc.rust-lang.org/nightly/std/intrinsics/fn.volatile_copy_memory.html>.
> > However, I am not sure how you'd even generate such a call in C? The
> > standard memcpy function is not doing volatile accesses, to my
> > knowledge.
> 
> The actual memcpy symbol that exists at runtime is written in
> assembly, and should be valid to treat as performing volatile
> accesses.
> 
> But both GCC and Clang special-case the memcpy function.  For example,
> if you call memcpy with a small constant as the size, the optimizer
> will transform the call into one or more regular loads/stores, which
> can then be optimized mostly like any other loads/stores (except for
> opting out of alignment and type-based aliasing assumptions).  Even if
> the call isn’t transformed, the optimizer will still make assumptions.
> LLVM will automatically mark memcpy `nosync`, which makes it undefined
> behavior if the function “communicate[s] (synchronize[s]) with another
> thread”, including through “volatile accesses”. [1]
> 
> However, these optimizations should rarely trigger misbehavior in
> practice, so I wouldn’t be surprised if Linux had some code that
> expected memcpy to act volatile…
> 

Also in this particular case we are discussing [1], it's a memcpy (from
or to) a DMA buffer, which means the device can also read or write the
memory, therefore the content of the memory may be altered outside the
program (the kernel), so we cannot use copy_nonoverlapping() I believe.

[1]: https://lore.kernel.org/rust-for-linux/87bjuil15w.fsf@kernel.org/

Regards,
Boqun

> But I’m not familiar enough with the codebase to know whether such
> code actually exists, or where.
> 
> (Incidentally, there is a compiler flag to turn the memcpy
> special-casing off, -fno-builtin.  I pretty much expected that Linux
> used it.  But I just checked, and it doesn’t.)
> 
> For Rust, I don’t know why we haven’t exposed volatile_copy_memory
> yet.  All I can find are some years-old discussions with no obvious
> blockers.  I guess nobody has cared enough.  There is also a somewhat
> stagnant RFC for *atomic* memcpy. [2]
> 
> [1] https://llvm.org/docs/LangRef.html, search for 'nosync'
> [2] https://github.com/rust-lang/rfcs/pull/3301
> 

