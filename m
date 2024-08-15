Return-Path: <linux-kernel+bounces-287529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BF99528CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95791C21D14
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973F65B1E0;
	Thu, 15 Aug 2024 05:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXlraNA5"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18541C64;
	Thu, 15 Aug 2024 05:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698677; cv=none; b=SL8+mHQesX3Tb+C/pxv7gz127UvXkD8SGbkEF3ro5eS94KDsSxM2e5qFeGcVqTzF+M/9TR/F/cIEpK+eD2M8+oem6xA8UrBnAM8nmDBzebqtIOM42Zmn1WDuEJbCLy1Qj96S5acxOBeWNg+gdosNm2NJKvLx4woUnKl7L0v6WMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698677; c=relaxed/simple;
	bh=LZJ4HbYNj+VHiNicco8tF1isJt+JvXxpk02O0EybYhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUYxC+EgybpvaHB7sFEC1EiH9aanTbxpyMyJs7WmPD62FGTU1OfLmjjotW4j5KOc5CtTmLNcYk3rDzMmuqdlYpKBObwYK0UxJZBTy2FfDn+WQfVr5D3vu6TjI053zweZyVk2lfUgA5bE0nZ8dMFeurZfLd31RCECxb1Mv+junwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXlraNA5; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf6ea1d34aso2836576d6.1;
        Wed, 14 Aug 2024 22:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723698675; x=1724303475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBtb0r4gOwACTlyW1Gnb7RW6BPv9G75Hxfxq9beo+Oo=;
        b=IXlraNA5SwPuaC7TrqiZfEyNVkkL1UVUPnxKDGVB+ylHymx62mC1GHWGl9A6xutPAk
         GjVC0fMDEQiIhiUJBqinqohlEn6BgSEvriWUuJcZJDOan8/aCf1yoQ21OzMt6R/rRhxj
         nTlEq5+Jfq6rCLU7cO5L+fQoHqFfIJbXz8BjEnaOV5uWCYP6oQlWrQoSaKBIEBNurDdU
         TqDMGTx2/FHv0oQGVSM2+9L2nH651R5BXUbiitvDT7KPkG+SYpxxQG4p+SBfRVrcmBth
         G/Gcphw1vhkZKYPstUXy3TAcWLM+vp4MorJhm885LEzBifp1Bnok/Z0xqa0HNEPeMOXI
         MAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723698675; x=1724303475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBtb0r4gOwACTlyW1Gnb7RW6BPv9G75Hxfxq9beo+Oo=;
        b=T3PKh4Hhp56hZ4bWc49+/p8vXfBLtTcShrfyemWY7ZF7AV3NhmMept5gdV07kcoHos
         4+6xenFGXf+aTrDiabskn5UTN8to6qko01BFIS7pX7u3X7C5CIlixNWZ9mxpl4eLUKoM
         HpCz+dIPsuOsrGrUEegC1ccejspmY9QEeq9UbY7h7/8+TjMaGDmew56UUGgXx84bk3am
         aCOmtLeONyCuqGQVBOskHHgdfstKMMzPE9GBuQiEbmPRHu7AIgypt/bhPlAK3U7N++0S
         wp+wZQZTa3Pn2fgsR+cvITGiZWqk5kedMzYwR6yP5YoGKHToie0okAdf7KUoZbvCDFZN
         3QBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZN9Cn80VrbSPgpXqZhZZDEN3BeJIxAPTaGgLQvQkEtHdSZf+XVjKy4NO7lEf+CA/6IpfIbkFCWEVnA58DGD5N8xECHf6A+LnWnsnK3XoJ0owgSsR1uxgOGh83ukxs0e3DeBdDyoO0SOPdWe8=
X-Gm-Message-State: AOJu0YwA6bTJOUoaWKRbB8r6Ud8PdB9nLwNpWxgwCYqJVcGiePI0xGg2
	bIngmrfnNM1IIjylCxwH+Nzk4hgkwfbQKN7QTnYMSzTaeIURwj2e
X-Google-Smtp-Source: AGHT+IHsqiOk5oFV8IByAddeDvddAit+J2da09Nm/CPvhVrUrmqFmGoNqWod7AVp6bZwbsYQtiNiFw==
X-Received: by 2002:a05:6214:5549:b0:6bf:6c16:6696 with SMTP id 6a1803df08f44-6bf6c1668c0mr28897286d6.30.1723698674680;
        Wed, 14 Aug 2024 22:11:14 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec61fbsm3519716d6.103.2024.08.14.22.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 22:11:14 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8EF84120006B;
	Thu, 15 Aug 2024 00:54:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 15 Aug 2024 00:54:32 -0400
X-ME-Sender: <xms:CIq9ZiJFDbz-rYh-zINScnuAkYWaxzHbmHOrdCLvPPJDzF19MWyJlg>
    <xme:CIq9ZqIXEX0DQO6PwJVxu1hWDaRC0eCo996WfRA-U6e25i1KCssSNwz8LrC4Nh9xT
    3PEVZdvoR0tZ5yo1g>
X-ME-Received: <xmr:CIq9Ziv0OtgIumnElST3-7AsPL8ln4CslbfSf73CBDRFt0vTJx8Bss8YSGtiqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtoh
    hnrdhmvgdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghkrhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghirhhlihgvug
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhngh
    hmrghnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:CIq9ZnYEAK8L_sBHlMvpskU_KdViop-ua227mzFNhV9Ji6TqPO6QQw>
    <xmx:CIq9ZpauDzTJc1iSpKHbp8I3xNoz3sD0wx7dD6QV3uRwEyQ_8KShfw>
    <xmx:CIq9ZjC2tsgzBhfwECsqpSDcjII1DNnaRqkLvd3zftlEnB4K554R7g>
    <xmx:CIq9ZvZDWKTKBGRqHmlYx4ACGb8qzGGIDxECGOCmRBgfAY_SxXi1XA>
    <xmx:CIq9ZprAHEoReBlNskFdBl7Zp9wdIwDbJ0bRRa-BaQjRXepTgF4Mdtzk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 00:54:32 -0400 (EDT)
Date: Wed, 14 Aug 2024 21:53:03 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Aakash Sen Sharma <aakashsensharma@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/3] rust: Introduce irq module
Message-ID: <Zr2JryyeoZPn3JGC@boqun-archlinux>
References: <20240802001452.464985-1-lyude@redhat.com>
 <20240802001452.464985-2-lyude@redhat.com>
 <Zrzq8su-LhUIoavm@boqun-archlinux>
 <1bcae676ec4751ae137782c4ced8aad505ec1bb9.camel@redhat.com>
 <Zr0QyN8sQ6W2hPoJ@boqun-archlinux>
 <9855f198-858d-4e3f-9259-cd9111900c0c@proton.me>
 <Zr0aUwTqJXOxE-ju@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr0aUwTqJXOxE-ju@boqun-archlinux>

On Wed, Aug 14, 2024 at 01:57:55PM -0700, Boqun Feng wrote:
> On Wed, Aug 14, 2024 at 08:44:15PM +0000, Benno Lossin wrote:
> > On 14.08.24 22:17, Boqun Feng wrote:
> > > On Wed, Aug 14, 2024 at 03:38:47PM -0400, Lyude Paul wrote:
> > >> On Wed, 2024-08-14 at 10:35 -0700, Boqun Feng wrote:
> > >>> On Thu, Aug 01, 2024 at 08:10:00PM -0400, Lyude Paul wrote:
> > >>> [...]
> > >>>> +/// Run the closure `cb` with interrupts disabled on the local CPU.
> > >>>> +///
> > >>>> +/// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
> > >>>> +/// without interrupts.
> > >>>> +///
> > >>>> +/// # Examples
> > >>>> +///
> > >>>> +/// Using [`with_irqs_disabled`] to call a function that can only be called with interrupts
> > >>>> +/// disabled:
> > >>>> +///
> > >>>> +/// ```
> > >>>> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
> > >>>> +///
> > >>>> +/// // Requiring interrupts be disabled to call a function
> > >>>> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
> > >>>> +///     /* When this token is available, IRQs are known to be disabled. Actions that rely on this
> > >>>> +///      * can be safely performed
> > >>>> +///      */
> > >>>> +/// }
> > >>>> +///
> > >>>> +/// // Disabling interrupts. They'll be re-enabled once this closure completes.
> > >>>> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
> > >>>> +/// ```
> > >>>> +#[inline]
> > >>>> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) -> T) -> T {
> > >>>
> > >>> Given the current signature, can `cb` return with interrupts enabled (if
> > >>> it re-enables interrupt itself)? For example:
> > >>>
> > >>> 	with_irqs_disabled(|irq_disabled| {
> > >>>
> > >>> 	    // maybe a unsafe function.
> > >>> 	    reenable_irq(irq_disabled);
> > >>
> > >> JFYI: this wouldn't be unsafe, it would be broken code in all circumstances
> > >> Simply put: `with_irqs_disabled()` does not provide the guarantee that
> > >> interrupts were enabled previously, only that they're disabled now. And it is
> > >> never a sound operation in C or Rust to ever enable interrupts without a
> > >> matching disable in the same scope because that immediately risks a deadlock
> > >> or other undefined behavior. There's no usecase for this, I'd consider any
> > >> kind of function that returns with a different interrupt state then it had
> > >> upon being called to simply be broken.
> > >>
> > >> Also - like we previously mentioned, `IrqDisabled` is just a marker type. It
> > >> doesn't enable or disable anything itself, the most it does is run a debug
> > > 
> > > Yes, I know, but my question is more that should `cb` return a
> > > `IrqDisabled` to prove the interrupt is still in the disabled state?
> > > I.e. no matter what `cb` does, the interrupt remains disabled.
> > 
> > What does this help with? I don't think this will add value (at least
> > with how `IrqDisabled` is designed at the moment).
> > 
> 
> I was trying to make sure that user shouldn't mess up with interrupt
> state in the callback function, but as you mention below, type system
> cannot help here.
> 
[...]
> > > 
> > > I haven't found a problem with `&IrqDisabled` as the closure parameter,
> > > but I may miss something.
> > 
> > We could also use `&'a IrqDisabled` instead of `IrqDisabled<'a>` (note
> > the first one doesn't have a lifetime). But there is no behavioral
> > difference between the two. Originally the intended API was to use `&'a
> > IrqDisabled<'a>` as the closure parameter and `IrqDisabled<'a>` in
> > functions that require irqs being disabled. As long as we decide on a
> > consistent type, I don't mind either (since then we can avoid
> > reborrowing).
> > 
> > > So the key ask from me is: it looks like we are on the same page that
> > > when `cb` returns, the IRQ should be in the same disabled state as when
> > > it gets called. So how do we express this "requirement" then? Type
> > > sytem, comments, safety comments?
> > 
> > I don't think that expressing this in the type system makes sense, since
> > the type that we select (`&'a IrqDisabled` or `IrqDisabled<'a>`) will be
> > `Copy`. And thus you can just produce as many of those as you want.
> > 

Hmm.. on a second thought, `Copy` doesn't affect what I'm proposing
here, yes one could have as many `IrqDisabled<'a>` as one wants, but
making `cb` returns a `(IrqDisabled<'a>, T)` means the `cb` has to prove
at least one of the `IrqDisabled<'a>` exists, i.e. it must prove the irq
is still disabled, which the requirement of `with_irqs_disabled`, right?
Or you're saying there could exist an `IrqDisabled<'a>` but the
interrupts are enabled?

Regards,
Boqun

> 
> You're right, we then probably need a doc part of the function saying
> the `cb` cannot return with interrupt enabled.
> 
> Regards,
> Boqun
> 
> > ---
> > Cheers,
> > Benno
> > 
> > 

