Return-Path: <linux-kernel+bounces-301761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D522895F538
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058421C2119A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8820193092;
	Mon, 26 Aug 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgYmVTS1"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170473C17;
	Mon, 26 Aug 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686507; cv=none; b=sPyZ1jgZwsgQPD7s2Ds13ouHLipVi7t2aNisXZLZARWg2qlAjwe+Fck9luhPgBvVYlHsdjvSC25wCF1w95MMh3E6lQnqDmwBO8xIwUbJswDbC7zrExJbE/vHX1vqctrkV+gvzyF9YQhj0KI1Kkiv6N0PBKig4Bkk+d3IAAXT9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686507; c=relaxed/simple;
	bh=xCkL+NVPujsi1fMWpxFmMtn1PKcz06zD3FT9sXn7hYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay77jDC0Lr4wg+Q8Zrg6h+iMUgwFdQLZFP/wTMAZCJ+orR/FgaI0hyl4Wcj2j2acVu1ISBCEDbNQTXu5h96XG1fKE5+VZEONotv7t0GJRbR38WncSbY0snRmhKeaQkUopHOZZdioFjC39JnDol3PtOVtzRXBxxeRAfJyC+uC+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgYmVTS1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf7a2035d9so51531776d6.1;
        Mon, 26 Aug 2024 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724686505; x=1725291305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNN1N6uaekOp0it7KVskr3r6SRMxa0eFZJz8mz6hKVw=;
        b=QgYmVTS1HkX/LN/iPp6hs9RjGa5m2XcqSBQi7NYwC9nXnpnYPaLTCNOclQ/L98Evaw
         WB360G585Avufu7F2zw1kOx7Mqb+BMM8f4KeedATfB1oMls5nJmXQ/tRLNbEfKvJiUa9
         9qmFMMH8XzbZX8GFqmDgZ0KtghbD7M12VkSEtO/8Mv6kjOZddHoSHTf00Lh5iU5lgguM
         32rA1FFroYHI7yt4vs7JBklrlcvG2MntsqzQNehH9dA/RnxxM0cCBTjzl0Kqh0cztmQy
         2I0LpW3YBfi7YG6Qbn7qq9v256kElxL+M+lKZizYlJyxyQYxbVb4ugZFLOznyeuI3Pqq
         n0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724686505; x=1725291305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNN1N6uaekOp0it7KVskr3r6SRMxa0eFZJz8mz6hKVw=;
        b=ZVHDqiDRtAZE7dGkKKShIlyWrRrk5mcXJuYmRYtDVtXXn65Vvzrk+aRMnrLCtqC1Df
         6TWp6UZIw7eJ0vEl8pPFhk3In4xvmZu+8NPt2B31LtGT1sl9wqqeXwwk9kKvQ/eb0JIP
         ZD13iIP3gZvBQKiCdbmKLiFtnMSdh1vuQPttSMXEY23jz31CU+10TgAdBtdfMAVnDuQU
         KFRmNhicHvbGdw4nBFIAtT5ZMdrQQB1Ki92WooRUlRgqUQHFfdrFqbiJI+7dxeiC4NZg
         mvmEKCAaYj2cvzh9MhtE+PHWLkr9YOp30AApg5lsZF1tiKACWryLHgwFNFXDBCVvhwYT
         LjGw==
X-Forwarded-Encrypted: i=1; AJvYcCU2pRZPBmkaxXXmfQHv7At0km78+IOg6CKfdgnIjVYoMAW6L+DeTiGARE2cU+A6KBhKZjUG3g1Wzg8C+K/GMRs=@vger.kernel.org, AJvYcCUds6X44Kthd5fSHv87VaQ8oU6B7+o1hAb3LMBmRs04gayUu6HCERklsZcYCs91uW5sQodFKf6fLMuZnVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZxieUV2Fv16t0yAHuFOHZ/YLZjhucsNODpqkzbDnoi/Uc0B8
	voO1pnq/ppwq4HNkyDmrSDxWv53UZzS0AZddLJZikw9a4MONf5+6uIiUlQ==
X-Google-Smtp-Source: AGHT+IGIqAmaHeXIV44Lv+GUtdxK7ZRVXVsjoWAid5yUZrXWFMtKElgQtbvUeQMOpmkEyJqkqdxIMA==
X-Received: by 2002:a05:6214:e4a:b0:6b7:923c:e0b7 with SMTP id 6a1803df08f44-6c160cae608mr270408406d6.21.1724686504719;
        Mon, 26 Aug 2024 08:35:04 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcd3afsm47586206d6.111.2024.08.26.08.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 08:35:04 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 914D21200043;
	Mon, 26 Aug 2024 11:35:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 11:35:03 -0400
X-ME-Sender: <xms:p6DMZrfBo7ARnFUDdqf8JfwKEPoJGa3hRScVYr7YKjCFRZw3cOLnKg>
    <xme:p6DMZhMBbuSYBvGeap34LIrHbTC_4eo7MHNg-4C-9YugOPg1jPu7WdLDMKTXUQytx
    StDydCq5FwYQapeVg>
X-ME-Received: <xmr:p6DMZkjfsYaS1lormavU5-2wYM-Q3ThnVGeFuwoUykz7sj4VJ1nbYDTfLUtDlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopeguihhrkhdrsggvhhhmvgesghhmrghilhdrtg
    homhdprhgtphhtthhopeguihhrkhdrsggvhhhmvgesuggvrdgsohhstghhrdgtohhmpdhr
    tghpthhtoheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhushhtqd
    hfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepug
    grkhhrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrihhrlhhivggusehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtth
    hopeifihhllheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:p6DMZs8tmrPLDTmvMUro96pawmFuZaGegY0vdiCp7Te3HDfAfdLEmA>
    <xmx:p6DMZns_5faGEn8E2fx_BCuGt4P0mHN7X7nzbcDmspPkKKIqYRp8zA>
    <xmx:p6DMZrEl78aKKVYh3s7dyZthQDM4yyrsTwX9iQWvc-bDhRdmZ9qnEA>
    <xmx:p6DMZuOjeT-XBhBNZdercifYd-tFHgijtxR6lGSaOsqd6SoIBC-BXQ>
    <xmx:p6DMZoOG_Ucgy0B11xWv-9uyEjY5MvYg6p-kcOjQ18vAwC4xcDjjklVO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 11:35:02 -0400 (EDT)
Date: Mon, 26 Aug 2024 08:34:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Lyude Paul <lyude@redhat.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Aakash Sen Sharma <aakashsensharma@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v3 1/3] rust: Introduce irq module
Message-ID: <Zsygkunml0DHWIX7@boqun-archlinux>
References: <20240802001452.464985-1-lyude@redhat.com>
 <20240802001452.464985-2-lyude@redhat.com>
 <3f6a5c86-8dc4-4a62-8308-5ca25f9e4aec@de.bosch.com>
 <ZsyPezklN_tANFtQ@boqun-archlinux>
 <afa6d33a-c933-4996-8cdf-e1677772d63e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afa6d33a-c933-4996-8cdf-e1677772d63e@gmail.com>

On Mon, Aug 26, 2024 at 04:59:45PM +0200, Dirk Behme wrote:
> Am 26.08.24 um 16:21 schrieb Boqun Feng:
> > On Mon, Aug 26, 2024 at 01:21:17PM +0200, Dirk Behme wrote:
> > > Hi Lyude,
> > > 
> > > On 02.08.2024 02:10, Lyude Paul wrote:
> > > > This introduces a module for dealing with interrupt-disabled contexts,
> > > > including the ability to enable and disable interrupts
> > > > (with_irqs_disabled()) - along with the ability to annotate functions as
> > > > expecting that IRQs are already disabled on the local CPU.
> > > > 
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > ...
> > > > diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> > > > new file mode 100644
> > > > index 0000000000000..b52f8073e5cd0
> > > > --- /dev/null
> > > > +++ b/rust/kernel/irq.rs
> > > > @@ -0,0 +1,84 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +//! Interrupt controls
> > > > +//!
> > > > +//! This module allows Rust code to control processor interrupts. [`with_irqs_disabled()`] may be
> > > > +//! used for nested disables of interrupts, whereas [`IrqDisabled`] can be used for annotating code
> > > > +//! that requires interrupts to be disabled.
> > > > +
> > > > +use bindings;
> > > > +use core::marker::*;
> > > > +
> > > > +/// A token that is only available in contexts where IRQs are disabled.
> > > > +///
> > > > +/// [`IrqDisabled`] is marker made available when interrupts are not active. Certain functions take
> > > > +/// an [`IrqDisabled`] in order to indicate that they may only be run in IRQ-free contexts.
> > > > +///
> > > > +/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that
> > > > +/// interrupts are disabled where required.
> > > > +///
> > > > +/// This token can be created by [`with_irqs_disabled`]. See [`with_irqs_disabled`] for examples and
> > > > +/// further information.
> > > > +#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
> > > > +pub struct IrqDisabled<'a>(PhantomData<(&'a (), *mut ())>);
> > > > +
> > > > +impl IrqDisabled<'_> {
> > > > +    /// Create a new [`IrqDisabled`] without disabling interrupts.
> > > > +    ///
> > > > +    /// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
> > > > +    /// without interrupts. If debug assertions are enabled, this function will assert that
> > > > +    /// interrupts are disabled upon creation. Otherwise, it has no size or cost at runtime.
> > > > +    ///
> > > > +    /// # Panics
> > > > +    ///
> > > > +    /// If debug assertions are enabled, this function will panic if interrupts are not disabled
> > > > +    /// upon creation.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// This function must only be called in contexts where it is already known that interrupts have
> > > > +    /// been disabled for the current CPU, as the user is making a promise that they will remain
> > > > +    /// disabled at least until this [`IrqDisabled`] is dropped.
> > > > +    pub unsafe fn new() -> Self {
> > > > +        // SAFETY: FFI call with no special requirements
> > > > +        debug_assert!(unsafe { bindings::irqs_disabled() });
> > > > +
> > > > +        Self(PhantomData)
> > > > +    }
> > > > +}
> > > 
> > > I have some (understanding) questions for this IrqDisabled::new():
> > > 
> > > 1. It looks to me that both examples, below in this file irq.rs nor the
> > > with_irqs_disabled() example in spinlock.rs in the 3rd patch seem to use
> > > IrqDisabled::new()? At least some debug pr_info() added here doesn't print
> > > anything.
> > > 
> > > What's the intended use case of IrqDisabled::new()? Do we have any example?
> > > 
> > > I 'simulated' an interrupt handler where we know the interrupts are
> > > disabled:
> > > 
> > > let flags = unsafe { bindings::local_irq_save() }; // Simulate IRQ disable
> > > of an interrupt handler
> > > let mut g = foo.lock_with(unsafe {IrqDisabled::new() });
> > > g.val = 42;
> > > unsafe { bindings::local_irq_restore(flags) }; // Simulate IRQ re-enable of
> > > an interrupt handler
> > > 
> > > Is this the intended use case?
> > > 
> > > 
> > > 2. If the example above is what is intended here, is it intended that this
> > > has to be called unsafe{}?
> > > 
> > > foo.lock_with(unsafe {IrqDisabled::new() });
> > > 
> > > 
> > > 3. I somehow feel slightly uncomfortable with the debug_assert!().
> > > 
> > > I understood that this is intended to be not in production code and only
> > > enabled with RUST_DEBUG_ASSERTIONS for performance reasons? But I have some
> > > doubts how many people have RUST_DEBUG_ASSERTIONS enabled? And disable it
> > > for the production build?
> > > 
> > > Wouldn't it be better to be on the safe side and have this check, always?
> > 
> > No, for example in your code example above, the IRQ is knon being
> > disabled, so actually there's no point to check. The checking of course
> > makes sense in a function where there is no IRQ	disable code, and you
> > want to make sure it's only called when IRQ disabled. But that's
> > something you want to make sure at development time rather than in the
> > production.
> 
> I think I'm thinking the other way around ;)
> 
> Make sure I get a warning if I'm (as the developer) have done anything wrong
> in my assumption about the interrupt state my code is running with.
> 
> So cover the human failure case.
> 

Again, if a developer wants to find whether the code is correct or now,
that falls into the debugging catagory. If you want to know that, you
just enable the debug_assert!().

> 
> > > Wouldn't a permanent if statement checking this be safer for all cases?
> > 
> > I don't think so, it's just a checking, even if we enable this in the
> > production, the best it could do is just telling us the code is
> > incorrect.
> 
> Yes, exactly, this is what I'm looking for. Isn't this what the C's
> WARN_ONCE() & friends are about? Let the machine tell us that the programmer
> has done something wrong :)
> 

Not really, sometimes they are used to tell users that there are
hardware issues. But moreover, they are used to catch unexpected cases,
which as I mention above, not all the IRQ-disabled usages need this.

Regards,
Boqun

> 
> > If one realy wants to make sure a function works in both IRQ
> > disabled and enabled cases, he/she should check the irq status and
> > handle it accordingly
> 
> No, this is not what I'm looking for. I'm just about noticing the
> programming error case.
> 
> Best regards
> 
> Dirk
> 
> 
> > e.g.
> > 
> > 	if (irqs_disabled()) {
> > 		// irq is disabled, we can call it directly
> > 		do_sth();
> > 	} else {
> > 		// Disable IRQ on our own.
> > 		local_irq_disable();
> > 		do_sth();
> > 		local_irq_enabled();
> > 	}
> > 
> > > Compare e.g. BUG_ON() or WARN_ONCE() or similar in the kernel's C code?
> > > 
> > > Or could we invent anything more clever?
> > > 
> > 
> > I'm open to any new idea, but for the time being, I think the
> > debug_assert!() makes more sense.
> > 
> > Regards,
> > Boqun
> > 
> > > 
> > [...]
> > 
> 

