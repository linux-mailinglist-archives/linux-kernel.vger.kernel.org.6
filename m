Return-Path: <linux-kernel+bounces-354624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF2D994051
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C9C1C265BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EE11F9433;
	Tue,  8 Oct 2024 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdEvGQW9"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB113A88A;
	Tue,  8 Oct 2024 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371179; cv=none; b=Lscpp9EsXy4LVsG5qt3gakiwFgDpAK/NWxAzVUA+a1NTA/EGhwTsnILt3leyP2NEGuDIRvVm3VvF5e5aKTMs62JJOBHR7H191Ph0rWYMkRPG+yFV/VvQe7wgsKYW/pLj6ZfbzLtH1CqVdr/YgdDlFOmPC6gCtgOWSJAKiVq9upw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371179; c=relaxed/simple;
	bh=uXTg1uHnm5XEmDJlhimEj2kwTfW/6/nR+60at7BFp94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2XphtQXaY5SzmJs+EgThHaFI2dHyHKHUQDIBSH9BafK4tUTlAzSCzACY+r1cikOm9J+Y3bKddQKf4OZT+Wey5xFKsXcb6kMQDHSJ5jGkj66TZh0WVHMbeOGDPH0PQT9qc/LEHvRwLVJ1zAFXew2jINo1cnHWFqNE2hgOHIQEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdEvGQW9; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-45efe44eb77so2815591cf.0;
        Tue, 08 Oct 2024 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728371176; x=1728975976; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vsTuDSKkRObHCn42+F4y62pCjIW+t1IXf3lagGIigZQ=;
        b=fdEvGQW9tLUcsswcEEqjcfFWi4Oy/0iQRngiBI0s3uH/mAYdERFWru1HlQRx8ZMnta
         Hu9L7zVoqYWkXflHLGXqk+OzalflmoVmJLN7aYFCT206ILLREXSenuYrY/N5eCzqgxL5
         rdZ/vNe0s0m+fIzMgDuWuskx4KnCGC1QKpNqASDC/Z4DLyVq5e55zFkiOHtjwzV28idP
         NDk0mJ9SKiDy2CHKe/l3y62NR7I4Hf+MzriV3vfIhgeO0szs68u9yR09Z6qHgUARQ2PK
         YH33WV79lEfDXIDxB2F+X2DuDUUKoTq2zPZofdimQHRJq2cQIa0QQftpLLWMBz3iWRi9
         BxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728371176; x=1728975976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsTuDSKkRObHCn42+F4y62pCjIW+t1IXf3lagGIigZQ=;
        b=rbZsPDYyx7MKhXFvaRqpu4sr/q9Pjxc8vkTmeWoIjZ8+72Ila0Co0WxkTmXW7tMq6R
         Xsd8sMsK1kZh/rKq9lZZTpk1Shl4ignfcVHl86NnAINWRnd3do9VAsMYBYJ2wQjKIxd6
         8uxAkCF0KQAs2DRMj1IOg8qHTHqBfdyJy6w8RAeTj/Ab2EEumRx5amdob2ZwKSEO1vWZ
         1l+hYKN4e84vFV01u5PKW8W7v8emVyop2jGg4YwANkYoZ3OWrHf6cGv6qWOfDyPD8u7w
         fJZje3Hr3UkMxGjZ3Z6EpJCqoL9VPzD1h7ZQkSJIV1vLmegR3lP0OpNA2FTZKULwIajb
         +Ykg==
X-Forwarded-Encrypted: i=1; AJvYcCVRCK7Xtx6RpqahIRG+I9pfiaEVbKxFULmEmVYNJDaczgSNgAhZaljV6vmv8TTR72PaBceltJyf7YD6tYkExcg=@vger.kernel.org, AJvYcCX06m2kGrorwi8jEWUiwOGqtKX0GRzjsBoRG9m0BKZJIaBJl+r01Jz7dRH6Zi/XBKXdskodWZfOxRcJS1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWRUwx4DwUOWJcozvNhiDa8roR+Mm9Bjk+v0as44oNbWjmY9E
	HcT7+MnbiQ7d5ERjRddTg+lzigAYNSpKqyayLWrjky+P/jMO8HcO
X-Google-Smtp-Source: AGHT+IEiZQyyBqHDBYjLH1EpSIhHufA4n8BfpH2QxGhhqwh6YWERtmmJxAuA9PcyL+l7bFafKxS1oA==
X-Received: by 2002:a05:622a:30e:b0:454:b417:ac4f with SMTP id d75a77b69052e-45d9baba058mr178263831cf.43.1728371176302;
        Tue, 08 Oct 2024 00:06:16 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da75564f4sm33767581cf.48.2024.10.08.00.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:06:15 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5B5EB1200043;
	Tue,  8 Oct 2024 03:06:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 08 Oct 2024 03:06:15 -0400
X-ME-Sender: <xms:59kEZ61xo1SF2H1QcdEpAaz_O9SWeLVX5CBvbrxB4_h_qin2R8NM1A>
    <xme:59kEZ9HwKvuTginwEUtB_sMPhIt3ECx0jo1w9CHNk-ak-6S0wT-OH_QP1gAcRB0-T
    LDmy-s4RH9GfYk5ow>
X-ME-Received: <xmr:59kEZy6nsLtHJHUoagzwxFTrRP-8dK25W6kpSNMZ5aqnG9Fmcdj3ruFKXgTpqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeftddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfeikeekffejgeegueevffdtgeefudet
    leegjeelvdffteeihfelfeehvdegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrsgguihgv
    lhdrjhgrnhhulhhguhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhushhtqdhfoh
    hrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhr
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopegrihhrlhhivggusehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:59kEZ73utefOwYz62Trgkl67VxNShnwQI1BV-6Lj4PmhlWABg_LqKw>
    <xmx:59kEZ9E4dFUJ9Pr0PlZiXo9HpnUAeF-wfkwqd6ydwDti6NFR4gPovQ>
    <xmx:59kEZ0-TGu2h4sMrCNuHShXbqD2ICh9a5aD4tW499IzfZrGPeTzCBg>
    <xmx:59kEZylEG5Z0f2gTbCmUBlDqs-KXlLmGoPjSYKDSkdgEITUcrbc-bg>
    <xmx:59kEZ1GoVdURJD6HR5ABQYWAkvAHWVO3fiS_iHxwgWKvowFf7Kn-YoY2>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 03:06:14 -0400 (EDT)
Date: Tue, 8 Oct 2024 00:04:54 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, dakr@redhat.com,
	linux-kernel@vger.kernel.org, lyude@redhat.com, airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH 1/3] rust: page: replace the page pointer wrapper with
 Opaque
Message-ID: <ZwTZlqHMhexdkXJ7@boqun-archlinux>
References: <20241007202752.3096472-1-abdiel.janulgue@gmail.com>
 <20241007202752.3096472-2-abdiel.janulgue@gmail.com>
 <CAH5fLggkpELOx2mfz32d2C0xE_aSWs3GQHAkufq5H=30xB3MUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggkpELOx2mfz32d2C0xE_aSWs3GQHAkufq5H=30xB3MUQ@mail.gmail.com>

On Tue, Oct 08, 2024 at 08:58:56AM +0200, Alice Ryhl wrote:
> On Mon, Oct 7, 2024 at 10:28 PM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
> >
> > Replace NonNull with Opaque to make it possible to cast to a Page pointer
> > from a raw struct page pointer.
> >
> > Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> > ---
> >  rust/kernel/page.rs | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> > index 208a006d587c..08ff09a25223 100644
> > --- a/rust/kernel/page.rs
> > +++ b/rust/kernel/page.rs
> > @@ -8,8 +8,9 @@
> >      error::code::*,
> >      error::Result,
> >      uaccess::UserSliceReader,
> > +    types::Opaque,
> >  };
> > -use core::ptr::{self, NonNull};
> > +use core::ptr::{self};
> >
> >  /// A bitwise shift for the page size.
> >  pub const PAGE_SHIFT: usize = bindings::PAGE_SHIFT as usize;
> > @@ -25,8 +26,9 @@
> >  /// # Invariants
> >  ///
> >  /// The pointer is valid, and has ownership over the page.
> > +#[repr(transparent)]
> >  pub struct Page {
> > -    page: NonNull<bindings::page>,
> > +    page: Opaque<bindings::page>,
> >  }
> >
> >  // SAFETY: Pages have no logic that relies on them staying on a given thread, so moving them across
> > @@ -65,15 +67,20 @@ pub fn alloc_page(flags: Flags) -> Result<Self, AllocError> {
> >          // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
> >          // is always safe to call this method.
> >          let page = unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
> > -        let page = NonNull::new(page).ok_or(AllocError)?;
> > +        if page.is_null() {
> > +            return Err(AllocError);
> > +        }
> > +        // CAST: Self` is a `repr(transparent)` wrapper around `bindings::page`.
> > +        let ptr = page.cast::<Self>();
> >          // INVARIANT: We just successfully allocated a page, so we now have ownership of the newly
> >          // allocated page. We transfer that ownership to the new `Page` object.
> > -        Ok(Self { page })
> > +        // SAFETY: According to invariant above ptr is valid.
> > +        Ok(unsafe { ptr::read(ptr) })
> 
> Using `ptr::read` on the page is definitely not okay. That duplicates
> the contents of the `struct page`. You'll need some sort of pointer
> type around `Page` instead.
> 

Agreed. So may I suggest we introduce `Owned` type and `Ownable` trait
[1]? `alloc_page()` can be refactor to return a `Result<Owned<Self>,
AllocError>`.

[1]: https://lore.kernel.org/rust-for-linux/ZnCzLIly3DRK2eab@boqun-archlinux/

Regards,
Boqun

> Alice


