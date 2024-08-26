Return-Path: <linux-kernel+bounces-301658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2991A95F3B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A4C1F2182C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0816F18D654;
	Mon, 26 Aug 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2KXe66D"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A418BC38;
	Mon, 26 Aug 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682133; cv=none; b=ZOCm6qp4vpt3vyRzVsF1BvGHj0ojdMuaq5TSNb+ywWoFWnX4b+Acyp/xNHwfbNg/m/H1UlT0nZMaNcmt/bmRBd6Pli+xF6jpwAv+3936UW2GMmPZI1hXdeloZjYbVRPqNa8rsX6YH5vRzktLKDvmoWHW7f0jpXhr4Czm0Nvjsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682133; c=relaxed/simple;
	bh=QTgZ4WdFW4S5YCjj0Qa/qOI3/hCG6BVFh4uafqO+DNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWsSA4Ghv0TuYZhEQblZPuVFQ35XyYl9ylpjzsaa2037XE3Fb8kFssZFmyEskr01iG2WSREKWDfHnzthLBT17E9xb5C87v7/TPPdbnUfT2Ly14fEsyKRxLNn+cW7coa4iQpbx5wlktnK+sKOcDSCrPBZ5K1I2poPe/0qx0c2C6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2KXe66D; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a7d91354ceso66650885a.1;
        Mon, 26 Aug 2024 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724682130; x=1725286930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAIBTpy+UcM1PODupdYW7vV4ggFaHtIRW2qJr+KL3XM=;
        b=I2KXe66DrfbLAFH5qe4/YNiGzmVP7JRYgdg5Fi9jLg8UXDnxKIhsHMsRX382e2p3Xs
         P6gbXO2u8W2Ha260m3Vp+1+5U/h95wpNIvLerNbg4q1pqlhZRvpukZHKsgOzCtvFkxi4
         FbjbhxlfWf/CU+f3Ei0ZT4LRHyLM7rUSLSDw/0SYz51LSawTIBy7/jviF58QK8sNE7kD
         ywexfA0+qk8WukxKK508WEmcqzWxr+EQS0f4njq5+rPW+lMAk4dhJabHfm2E+IAJCYP7
         TzcpxnU4lQjJg5qco+npL9BJa3Szhvnq0qpXLjH6ILtkm1Oa3litlDWoQa58XVETJH8Q
         Zgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682130; x=1725286930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAIBTpy+UcM1PODupdYW7vV4ggFaHtIRW2qJr+KL3XM=;
        b=uJvI0d5c+EI+k/FKrGRuScGZIATpdZ/Jgmvbc3YSIhpwT8hoRBgWhXnbw3Vl8rWfLb
         q+e+2U4wn7tylr85305jl7qzM1cvj130QOGB2k7E15++F8F6Xwmf8DHfyomBbo6VISHq
         kAYXsJKTRn+v6kmVwH0CPShgDeGWvsuOD/IsiaTSt6eKWhyoMisjoOlf4h6slzOPYklE
         NvtWrHlY/F82C4RbkOabAZzFP6a/6fNUEFndYegFEYAOlqq0DukjZbmPOv94L4uwyrpE
         PsMnOT0Yh9XBx/ID+cMtXLM6bHU0vbWUImvrvmysZGuSmE1JamMq/R8/Pd7KRG4nvSZN
         R4GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw0fY/aljqAP6oatzAbqxJUNbDuv0bXy/2/wYv7gLuT/7YEq6elMWcIZREZac0AHdY1eSd5ewuNPEx78o=@vger.kernel.org, AJvYcCXd5OFxsbshI5tJNlOr31hnDBaJzfIQkPZdu/qQ5qM5f+2ushDOVZhB88bN6BndDca5PSvEh6YenwxNxDzWQ+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDpJNsIeCS4ok1r+VGtzqe/ydgKxBFUkQ9dbMXrNgzbOg8EGPh
	YSUEXaeod/RSJOPecaqpASXJKLap6DauscHA8BuGVOWzLojfy0Xe
X-Google-Smtp-Source: AGHT+IGCs+yhpaU8za04NkW4MKiAaZPtHLGSbuWzzq/WaUXxBcdJ8L5oWAoEhZVlNu3g39Rt0PsaGA==
X-Received: by 2002:a05:6214:4904:b0:6bf:796a:23ef with SMTP id 6a1803df08f44-6c16deb9a9cmr109220326d6.56.1724682130005;
        Mon, 26 Aug 2024 07:22:10 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db09a7sm46842946d6.95.2024.08.26.07.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:22:09 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 9FF8E1200094;
	Mon, 26 Aug 2024 10:22:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 26 Aug 2024 10:22:08 -0400
X-ME-Sender: <xms:kI_MZiRHJXhEMDR7R5qDpj0CRuO0M5hIG6opndzmmTsqUVFtC-GfNg>
    <xme:kI_MZny-77pusQAnidNKprNOneoIZwNkrvngxKfnB5xdcJ2W3EBEfonXWSRg0s-YU
    9Plz98yFkSjtMuBcQ>
X-ME-Received: <xmr:kI_MZv3a5xbMeZLHCOBl8DcUJF0huYV291eqISAwdfBzC5J1gzKLfGwXmWqZ6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopeguihhrkhdrsggvhhhmvgesuggvrdgsohhstg
    hhrdgtohhmpdhrtghpthhtoheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpthht
    oheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepuggrkhhrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrihhrlhhivg
    gusehrvgguhhgrthdrtghomhdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonh
    hgmhgrnhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:kI_MZuD3lpuuOfMKbnwgbJo-XlvLXF7t3avx1uJA6rrWYn6PKMEIRg>
    <xmx:kI_MZriOvuDMhajaP0EjJNHYKxtnLc0l8VlXevTPAyMxf09ZcA-S-g>
    <xmx:kI_MZqqw4ocRGUotl4fW9uik_GTKoem-dB6A10rHRwv8LVOpKMcLsQ>
    <xmx:kI_MZuiFk0EOfx9wjG7opjno3DEJ9MgHklbB3wkZG4S5paAIAsoggg>
    <xmx:kI_MZqRAryAuTt5W9The6xLqig_gClzq0POEFLwNEb9yz9RsesMQnPLn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 10:22:08 -0400 (EDT)
Date: Mon, 26 Aug 2024 07:21:47 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
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
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Aakash Sen Sharma <aakashsensharma@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v3 1/3] rust: Introduce irq module
Message-ID: <ZsyPezklN_tANFtQ@boqun-archlinux>
References: <20240802001452.464985-1-lyude@redhat.com>
 <20240802001452.464985-2-lyude@redhat.com>
 <3f6a5c86-8dc4-4a62-8308-5ca25f9e4aec@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f6a5c86-8dc4-4a62-8308-5ca25f9e4aec@de.bosch.com>

On Mon, Aug 26, 2024 at 01:21:17PM +0200, Dirk Behme wrote:
> Hi Lyude,
> 
> On 02.08.2024 02:10, Lyude Paul wrote:
> > This introduces a module for dealing with interrupt-disabled contexts,
> > including the ability to enable and disable interrupts
> > (with_irqs_disabled()) - along with the ability to annotate functions as
> > expecting that IRQs are already disabled on the local CPU.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> ...
> > diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> > new file mode 100644
> > index 0000000000000..b52f8073e5cd0
> > --- /dev/null
> > +++ b/rust/kernel/irq.rs
> > @@ -0,0 +1,84 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Interrupt controls
> > +//!
> > +//! This module allows Rust code to control processor interrupts. [`with_irqs_disabled()`] may be
> > +//! used for nested disables of interrupts, whereas [`IrqDisabled`] can be used for annotating code
> > +//! that requires interrupts to be disabled.
> > +
> > +use bindings;
> > +use core::marker::*;
> > +
> > +/// A token that is only available in contexts where IRQs are disabled.
> > +///
> > +/// [`IrqDisabled`] is marker made available when interrupts are not active. Certain functions take
> > +/// an [`IrqDisabled`] in order to indicate that they may only be run in IRQ-free contexts.
> > +///
> > +/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that
> > +/// interrupts are disabled where required.
> > +///
> > +/// This token can be created by [`with_irqs_disabled`]. See [`with_irqs_disabled`] for examples and
> > +/// further information.
> > +#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
> > +pub struct IrqDisabled<'a>(PhantomData<(&'a (), *mut ())>);
> > +
> > +impl IrqDisabled<'_> {
> > +    /// Create a new [`IrqDisabled`] without disabling interrupts.
> > +    ///
> > +    /// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
> > +    /// without interrupts. If debug assertions are enabled, this function will assert that
> > +    /// interrupts are disabled upon creation. Otherwise, it has no size or cost at runtime.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// If debug assertions are enabled, this function will panic if interrupts are not disabled
> > +    /// upon creation.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// This function must only be called in contexts where it is already known that interrupts have
> > +    /// been disabled for the current CPU, as the user is making a promise that they will remain
> > +    /// disabled at least until this [`IrqDisabled`] is dropped.
> > +    pub unsafe fn new() -> Self {
> > +        // SAFETY: FFI call with no special requirements
> > +        debug_assert!(unsafe { bindings::irqs_disabled() });
> > +
> > +        Self(PhantomData)
> > +    }
> > +}
> 
> I have some (understanding) questions for this IrqDisabled::new():
> 
> 1. It looks to me that both examples, below in this file irq.rs nor the
> with_irqs_disabled() example in spinlock.rs in the 3rd patch seem to use
> IrqDisabled::new()? At least some debug pr_info() added here doesn't print
> anything.
> 
> What's the intended use case of IrqDisabled::new()? Do we have any example?
> 
> I 'simulated' an interrupt handler where we know the interrupts are
> disabled:
> 
> let flags = unsafe { bindings::local_irq_save() }; // Simulate IRQ disable
> of an interrupt handler
> let mut g = foo.lock_with(unsafe {IrqDisabled::new() });
> g.val = 42;
> unsafe { bindings::local_irq_restore(flags) }; // Simulate IRQ re-enable of
> an interrupt handler
> 
> Is this the intended use case?
> 
> 
> 2. If the example above is what is intended here, is it intended that this
> has to be called unsafe{}?
> 
> foo.lock_with(unsafe {IrqDisabled::new() });
> 
> 
> 3. I somehow feel slightly uncomfortable with the debug_assert!().
> 
> I understood that this is intended to be not in production code and only
> enabled with RUST_DEBUG_ASSERTIONS for performance reasons? But I have some
> doubts how many people have RUST_DEBUG_ASSERTIONS enabled? And disable it
> for the production build?
> 
> Wouldn't it be better to be on the safe side and have this check, always?

No, for example in your code example above, the IRQ is known being
disabled, so actually there's no point to check. The checking of course
makes sense in a function where there is no IRQ	disable code, and you
want to make sure it's only called when IRQ disabled. But that's
something you want to make sure at development time rather than in the
production.

> Wouldn't a permanent if statement checking this be safer for all cases?

I don't think so, it's just a checking, even if we enable this in the
production, the best it could do is just telling us the code is
incorrect. If one realy wants to make sure a function works in both IRQ
disabled and enabled cases, he/she should check the irq status and
handle it accordingly e.g.

	if (irqs_disabled()) {
		// irq is disabled, we can call it directly
		do_sth();
	} else {
		// Disable IRQ on our own.
		local_irq_disable();
		do_sth();
		local_irq_enabled();
	}

> Compare e.g. BUG_ON() or WARN_ONCE() or similar in the kernel's C code?
> 
> Or could we invent anything more clever?
> 

I'm open to any new idea, but for the time being, I think the
debug_assert!() makes more sense.

Regards,
Boqun

> 
[...]

