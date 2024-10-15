Return-Path: <linux-kernel+bounces-366482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60BB99F5EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739F21F25516
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB42036FB;
	Tue, 15 Oct 2024 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUi8ITBB"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF82036E2;
	Tue, 15 Oct 2024 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017813; cv=none; b=LHkUGeTm25L8uBZ1C7ABxQ43N6cHwI55I45jQG3ZtRaBa9f3n6gXknEocGLvyxRJUL7isxGGqRKM0dLGIou2ZKt4lOlyjRdDqFW6jS1RmTu/1i0PCG8GVzcupsScub6QQsF8OyNEy1QN/0o+shSPFsnCloYQn+BddonpJJaUY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017813; c=relaxed/simple;
	bh=pGKnqPQFVIhxOw91xymPo+0W+k5feBiIIzbNeT2NE7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb73CCuvwYkDU488hUSFtohfLEo1K78HeFtmt03jhMe/2Wl+EP9Ia9JXhAbkbZEw8Yv/o8ktzbRTPmFxKme5MS31elvmCaQjP6yYTFFbLITfoEyVq/o6G011JHgSPJ6M4qQOfxYuqPAb8j2VCQTar8Kh26KZH0dQTSpR4I/fTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUi8ITBB; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbf340fccaso1268076d6.1;
        Tue, 15 Oct 2024 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729017810; x=1729622610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwVw1EPwTuQ2sBmts8qTWcQOE9Xf7gtA+DQB/tQWrJI=;
        b=gUi8ITBBbwU7zAKIFB6j1pIVeZxTOmbR8OveXyAfeSBOvnbKyeeb1TzTV1JIQlCoTq
         YJDIXGoTD+HiEpCC/8L8ZrdtIxM5sjTMbARueD0Ai2WCXfS5jxqthGqw682qn/yKXvQv
         mPFgp4inQ0Qb0z6FO42//Mrt8HUNTN3geKJr/+X+0dYzmbDrFKdcrH09M3gchys1e0Wg
         ci/Imy3S1Xp3AmXh4f7/TbMu/X5jlHAowFQy63oiC+ZFQNcks9qPFM1jryR66RTrGkI+
         5f3qW0LmjqZoNsYuYbUOBnjDyfS8V+yiu1epMADkThoNjlnxmesbQm7DVxSlQdd4mg6+
         tB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729017810; x=1729622610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwVw1EPwTuQ2sBmts8qTWcQOE9Xf7gtA+DQB/tQWrJI=;
        b=KGABtYvxN2gdd4MgdqR34GnKTYEYxs49rG4Wr++DWSLjoawEBOhGXw+UTfdGqxdYs7
         sHnVDi0SBNL6qt9T5zXDFQG6ECq/pMRG6iHMMEoau3tc8j032VMmLNvqW/sm1yfg1JR8
         I7OL9+Id2aPpt4mKac/YfIqxsQUH2GZ+R1lK3syuapg79o0MLVljy7IC/IEgqvsvCtsf
         8Uk5GHHRn99l6LVAwzgtL4shPenDgWHG8gtCeScXzkr+so2xDqxOxZtwmsWWXlWz62wx
         2+HbTtyIrD2g0Vf1foOXtOtwZ0YF8jYEotpNODWr/R4/kt3yPiny2B7rQTVpKHsVYEF6
         6aUA==
X-Forwarded-Encrypted: i=1; AJvYcCVznbFDTtDGuCc1xNo3AenAOvlQCM58OyK3LJOxb4fUXOoHWEff2pm15+O6j3wqGFVpwjVSs1xteuf5j0I=@vger.kernel.org, AJvYcCW31BcOCz6uWzVDgJDe3/BfKwNaUQy6VF4PT4ffAsz27YFxOEfyF4O1a7549c0uzaXoJKMpPSQ/Gl5Rx0qaJbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxERfSbb2y6uJcFa4FdhhLdTy/qFvHCZlWp40TCtlxCkTlMqbhp
	yGikxskQzB3it855ruufDa0zGrWKU4Yr8aFpOoKymiEN/S1QFvLIw+LgXA==
X-Google-Smtp-Source: AGHT+IFOckJamnPCkjqdVGTmtiA+796cSZzcBTRR1nV41h+hZEqxRBxd+i25THwMcOnkpxbBsyN3ig==
X-Received: by 2002:a05:6214:338a:b0:6cb:ef36:5fbe with SMTP id 6a1803df08f44-6cbefa741cemr265310866d6.3.1729017810275;
        Tue, 15 Oct 2024 11:43:30 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b119f59sm9611601cf.47.2024.10.15.11.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:43:29 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 721CF1200076;
	Tue, 15 Oct 2024 14:43:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 15 Oct 2024 14:43:29 -0400
X-ME-Sender: <xms:0bcOZypBPizfA5gMO3llRGOSYp59-hsuENynU67pYFB3YfLjgM4NCw>
    <xme:0bcOZwqXu4vQa4voW0gYTFzyuIIAEI7ESwWx2ujBsfb0fPsjiGI2xSBJtFz823KjE
    Vg-D9UUWnlaVmz_KA>
X-ME-Received: <xmr:0bcOZ3OjKungq74vKwMwJqtvmMaU8hjkTe7QsinM7v1A7Qz8aVyy7Yt1Dl-Xnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvgesrhihhhhlrdhiohdprhgtph
    htthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehojhgv
    uggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouh
    hnuggrthhiohhnrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhef
    pghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhosh
    hsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:0bcOZx5W6EKOqY13OIzegRE9ic81YQwKvS10J4qT634BaPVNMqgSoA>
    <xmx:0bcOZx5jN95upEWwqValBJr536en8lZC_Fc_mCoAQttJz72rkbYQ0Q>
    <xmx:0bcOZxjEMEV7FlP0wat0wGWb0UEUJ6hq-ADQLKT5-nqnYsRgBiThYg>
    <xmx:0bcOZ76frk4dYStfASEyfyhbShvxjsrQH6VTutyHAcbCPB_FcFmlgw>
    <xmx:0bcOZ8KEt3MTVE42CkUpp9h6QCXwuYEgO2T_4qrfOjX7BMaV8YxjBOYH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 14:43:28 -0400 (EDT)
Date: Tue, 15 Oct 2024 11:43:08 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <alice@ryhl.io>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: page: add Rust version of PAGE_ALIGN
Message-ID: <Zw63vD879qeHUA_b@boqun-archlinux>
References: <20241015-page-align-v1-1-68fbd8b6d10c@google.com>
 <Zw61edSZrAb8pH1X@boqun-archlinux>
 <3ea20eb4-2a88-40bd-a453-bf2ff5d52d03@ryhl.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea20eb4-2a88-40bd-a453-bf2ff5d52d03@ryhl.io>

On Tue, Oct 15, 2024 at 08:44:22PM +0200, Alice Ryhl wrote:
> On 10/15/24 8:33 PM, Boqun Feng wrote:
> > On Tue, Oct 15, 2024 at 02:28:28PM +0000, Alice Ryhl wrote:
> > > This is a useful for helper for working with indices into buffers that
> > > consist of several pages. I forgot to include it when I added PAGE_SIZE
> > > and PAGE_MASK for the same purpose in commit fc6e66f4696b ("rust: add
> > > abstraction for `struct page`").
> > > 
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > >   rust/kernel/page.rs | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> > > index 208a006d587c..90846e3fe829 100644
> > > --- a/rust/kernel/page.rs
> > > +++ b/rust/kernel/page.rs
> > > @@ -20,6 +20,11 @@
> > >   /// A bitmask that gives the page containing a given address.
> > >   pub const PAGE_MASK: usize = !(PAGE_SIZE - 1);
> > > +/// Round up the given number to a multiple of `PAGE_SIZE`.
> > > +pub fn page_align(addr: usize) -> usize {
> > 
> > Make it a `const` function? For example, there is a VMBUS_RING_SIZE()
> > macro in C that calculates a const number for a vmbus ringbuffer size,
> > so it will be useful.
> 
> Good idea.
> 
> > > +    (addr + (PAGE_SIZE - 1)) & PAGE_MASK
> > 
> > I guess overflows are unexpected, i.e. the users should not pass a
> > `addr` that `> usize::MAX - PAGE_SIZE + 1`?
> Correct. If this wraps around to zero, that's incorrect. Note that the minus
> one is in brackets to only trigger overflow detection in the right cases.
> 

Make senses, with the const change and some docs on the overflow case,
feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> I can mention this in the docs.
> 
> Alice

