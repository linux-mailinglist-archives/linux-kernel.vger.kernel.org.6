Return-Path: <linux-kernel+bounces-355102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B543994750
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96572B24FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125A21DE3C1;
	Tue,  8 Oct 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMZt4V8q"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B319F1D0BAE;
	Tue,  8 Oct 2024 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387311; cv=none; b=gC1lne7S7nmwtJwfC8Xs7cXUQ8fGS9bR9rZBRD69UEEyf4Ydacl5zCgbkOis9qIh7WGp/45LALaKAcfNAZ3SKn2HE7LSnp4S6bWDMSKuNysEXw19y/1AD8RjUB0w4wQQIDFP+u9jcwxCaIDSNTc5txYoyaj/Hv6n8XjBuQOF0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387311; c=relaxed/simple;
	bh=gaoiDgixPQ9w7USFB40nBWmovp8exu1SnmqRj1Yb5k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLkTc1oTMRO5cAcniA+zQd69AdQjTuhFK7u4OPX0oYpvt6nV4EjRjHjjpNGMWzm7EAz+RMUAQes9+pNyjoEA8XUiQFr+SctFaIFrExQiU1jPPdaJ0aRN2igVhUziyFzhKPQjl2P+1Yr3szwYiUZLi1s0PhzVzBYsgOUBoNE4lvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMZt4V8q; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45d8f781d05so54905511cf.2;
        Tue, 08 Oct 2024 04:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728387308; x=1728992108; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TtrCtcICiy/3l3jlxxq6ANzZEHQkiHmGzbugtk6lpkU=;
        b=ZMZt4V8q+itBle6IAqs/LUX0pD2mvOr5Qqq0DiSRagGJtkvEXCFg3SlT8gZMZkghpF
         wAtJSpG1nOZct77/ncrN9lyunn6fh8KNBwvbgSU6mAmUuYyP1h4y9o5CvJMnj2S5NaxN
         c5rYvz6T+kuLSRnp8JI975Z8gnGesyzHYiG8TJt0kW9A0ZIHnRs0r0DkKVogPvy+d+FK
         IGTPFu2XoUaJ4MYng0aNZozRO2US2FDGux+hr6JZ97RmIabVIWCzV4XHt9U6OGeUTuHZ
         Vna7j36YJBLufEWx1FmEI0cvk6fnit6OhmZkeMndB4yh9KZx4XPToSgO7kJKi7+LFcya
         jaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728387308; x=1728992108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtrCtcICiy/3l3jlxxq6ANzZEHQkiHmGzbugtk6lpkU=;
        b=DOghEWDDxHreYjqV87V/qW1Y62Tsxvw1ghlzXJK0Er1MEglc5Mty2rBgWSCjmCBnce
         QjVydWJW06JNqyzOEEXKTqdP8uamH7YHAc7eSDfqRiSWhPr4MH+ZcQdGNTJviSK4DVyB
         tPXx4zeyQ2sgDZ/eqvkOI2cGy1Qu550EvNi/DE5NPrgZyXuwKnkghdTTD2qefcgqLh1r
         2/88DAoGYTfgjYfYZgzTY8tea83iLknEOGUlMzvTUvUZ61GDr2c5Nj8/6KbViWg99ApU
         LIBfebgF6mGnEpGtfKv8YVKbKS1tIwMMA8XonOKGfqIvFLfhTv4r6XfvJlLGbkAMzQAK
         I9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVRYavURi6ldhavkBY8WBU5k0/AlKvAipv52ZxwSVjhWFaWpGntjKoVSc/6fpVD27FlaMSeoYWN50G64kbRumE=@vger.kernel.org, AJvYcCVk58iRJcZ/TZXxVP9h2p11XbEq0tJnO+PeaIz/Lho3j29kMkkoHk0M2/S+AELeH1eCfiW6pfZboocHivs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt68rNqdCXcIvn9dxBeBXJ2KE8PfzPiTg0yO5lJmI1OjGSba0U
	XippIfFNWopWNQaFWpaUlZwH1KJqY2c8RFULr4YXHRcmFkOpjlRg
X-Google-Smtp-Source: AGHT+IECzwVO3fSa3ZW3jjVgFnl8pX9xYhjxFAxW3M1vqLKGhOlAUptHe8d07hWT1f5Y1/RdHdR9Yg==
X-Received: by 2002:a05:622a:1ba4:b0:458:3751:3df2 with SMTP id d75a77b69052e-45d9ba5e015mr218330481cf.27.1728387308554;
        Tue, 08 Oct 2024 04:35:08 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75615905sm347023985a.11.2024.10.08.04.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 04:35:08 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id A35E01200069;
	Tue,  8 Oct 2024 07:35:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 08 Oct 2024 07:35:07 -0400
X-ME-Sender: <xms:6xgFZ-lAjVKayZrc0DNd1nth2gH7e_XZbZaYrHA5sZLPkhNlBOHGSA>
    <xme:6xgFZ10VODu9QOtM0U5xsyjPWwSyagMv90N5Jdy9SPf_j_l809YIicBBGLGLVJMIs
    aIT0qg_B9pDW1_nUw>
X-ME-Received: <xmr:6xgFZ8r-LukvBnfOrbqjBpzFh8JDy_9bsQ9uykJWysmV8QmBPf14iipvnUehsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepjefhieekkeffjeeggeeuvefftdegfeduteel
    geejledvffetiefhleefhedvgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprggsughivghlrdhjrghnuhhlghhuvgesghhmrghilhdrtghomhdprhgtphhtthhopegr
    lhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehruhhsthdqfhhorh
    dqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrhes
    rhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhihuhguvgesrhgvughhrghtrdgtohhm
    pdhrtghpthhtoheprghirhhlihgvugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmh
    highhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrghilhdrtghomhdprhgtphht
    thhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:6xgFZylkB9W5eXcS3M-NNpqBSdJoxKAmJu0ix-9LiLAxpecvwWjMHg>
    <xmx:6xgFZ80_MnjtOR8ioYdkqvJrVt_fs6DbYOSydUWKagC9l1gsOfE0Lw>
    <xmx:6xgFZ5v0mWrIPoGLKLA3SHUDd9yHg3rJkdKNkYILuOaAGbQQVC2Ygg>
    <xmx:6xgFZ4X50RBxFwzNuMqJtTH3A0Lly93iDZnIJjmMcjeyDbsq-ZoX2Q>
    <xmx:6xgFZ32I4TT1PjnyduqgeR6YOv6jW7LZfdHd3UugjN0ud30nEwwrZhUP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 07:35:07 -0400 (EDT)
Date: Tue, 8 Oct 2024 04:33:46 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	dakr@redhat.com, linux-kernel@vger.kernel.org, lyude@redhat.com,
	airlied@redhat.com, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH 1/3] rust: page: replace the page pointer wrapper with
 Opaque
Message-ID: <ZwUYmunVpzpexGV8@boqun-archlinux>
References: <20241007202752.3096472-1-abdiel.janulgue@gmail.com>
 <20241007202752.3096472-2-abdiel.janulgue@gmail.com>
 <CAH5fLggkpELOx2mfz32d2C0xE_aSWs3GQHAkufq5H=30xB3MUQ@mail.gmail.com>
 <ZwTZlqHMhexdkXJ7@boqun-archlinux>
 <2b56118d-a0f1-470e-9e36-65811a87a177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b56118d-a0f1-470e-9e36-65811a87a177@gmail.com>

On Tue, Oct 08, 2024 at 02:29:47PM +0300, Abdiel Janulgue wrote:
> 
> 
> On 08/10/2024 10:04, Boqun Feng wrote:
> > On Tue, Oct 08, 2024 at 08:58:56AM +0200, Alice Ryhl wrote:
> > > On Mon, Oct 7, 2024 at 10:28 PM Abdiel Janulgue
> > > <abdiel.janulgue@gmail.com> wrote:
> > > > 
> > > > Replace NonNull with Opaque to make it possible to cast to a Page pointer
> > > > from a raw struct page pointer.
> > > > 
> > > > Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> > > > ---
> > > >   rust/kernel/page.rs | 19 +++++++++++++------
> > > >   1 file changed, 13 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> > > > index 208a006d587c..08ff09a25223 100644
> > > > --- a/rust/kernel/page.rs
> > > > +++ b/rust/kernel/page.rs
> > > > @@ -8,8 +8,9 @@
> > > >       error::code::*,
> > > >       error::Result,
> > > >       uaccess::UserSliceReader,
> > > > +    types::Opaque,
> > > >   };
> > > > -use core::ptr::{self, NonNull};
> > > > +use core::ptr::{self};
> > > > 
> > > >   /// A bitwise shift for the page size.
> > > >   pub const PAGE_SHIFT: usize = bindings::PAGE_SHIFT as usize;
> > > > @@ -25,8 +26,9 @@
> > > >   /// # Invariants
> > > >   ///
> > > >   /// The pointer is valid, and has ownership over the page.
> > > > +#[repr(transparent)]
> > > >   pub struct Page {
> > > > -    page: NonNull<bindings::page>,
> > > > +    page: Opaque<bindings::page>,
> > > >   }
> > > > 
> > > >   // SAFETY: Pages have no logic that relies on them staying on a given thread, so moving them across
> > > > @@ -65,15 +67,20 @@ pub fn alloc_page(flags: Flags) -> Result<Self, AllocError> {
> > > >           // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
> > > >           // is always safe to call this method.
> > > >           let page = unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
> > > > -        let page = NonNull::new(page).ok_or(AllocError)?;
> > > > +        if page.is_null() {
> > > > +            return Err(AllocError);
> > > > +        }
> > > > +        // CAST: Self` is a `repr(transparent)` wrapper around `bindings::page`.
> > > > +        let ptr = page.cast::<Self>();
> > > >           // INVARIANT: We just successfully allocated a page, so we now have ownership of the newly
> > > >           // allocated page. We transfer that ownership to the new `Page` object.
> > > > -        Ok(Self { page })
> > > > +        // SAFETY: According to invariant above ptr is valid.
> > > > +        Ok(unsafe { ptr::read(ptr) })
> > > 
> > > Using `ptr::read` on the page is definitely not okay. That duplicates
> > > the contents of the `struct page`. You'll need some sort of pointer
> > > type around `Page` instead.
> > > 
> > 
> > Agreed. So may I suggest we introduce `Owned` type and `Ownable` trait
> > [1]? `alloc_page()` can be refactor to return a `Result<Owned<Self>,
> > AllocError>`.
> > 
> > [1]: https://lore.kernel.org/rust-for-linux/ZnCzLIly3DRK2eab@boqun-archlinux/
> 
> Thanks for the feedback. How do you propose we move forward, do I take a
> stab at implementing `Owned` type and `Ownable` trait?

If you're interested, go ahead ;-)

Regards,
Boqun

> 
> Regards,
> Abdiel
> 
> 
> > 
> > Regards,
> > Boqun
> > 
> > > Alice
> > 

