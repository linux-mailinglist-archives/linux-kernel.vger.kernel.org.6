Return-Path: <linux-kernel+bounces-287189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755D4952474
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E304B1F22EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238691C8229;
	Wed, 14 Aug 2024 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMSKsBDI"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A671C7B6C;
	Wed, 14 Aug 2024 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669581; cv=none; b=J6vA5nTw1RydAM/GopjhjTQVPZtSEbplIFCuQaoxZcHiydsg6VRojbbnugrPwnDMTkoR1o86vjowuqQTTfuwj2gjSTPYGM9ud1tWEeSUQNTXTW/tcbvd70MuG6SANDFergvHZwmAYdyGqglvdkRrM1Q2iHko6RwcgIYdP7HH2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669581; c=relaxed/simple;
	bh=AINCg7PmGTJMVRBBd5cmj+JX4HcKUUl0FLGtBA0n96s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHcHCnobouLUBm0a2lsjyAOCHYpzTH9kb4i2kaTj8MNdH9wExtD6SkRUfwmih37uLuDuAikKbaEQOB+mJ9fECrzpqEA6LSFsqcfkVKSiivIvmKyLJaWG7/QwDVNjoyQBkkW8FVV62+m3dTHAa6qKAc7R1LQ2PpW0IrCrlPxx9nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMSKsBDI; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so1549386d6.0;
        Wed, 14 Aug 2024 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723669578; x=1724274378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYLAetEAQZjZKqd+n9fHz1LludGiCPIKD9nZ07NlfWY=;
        b=EMSKsBDIzZRg/q5rQ85D/kZ4i1PO6T06/U9VPWPwk8iuzl3Kjtwy3SuM+REKyIeXoD
         FfQGlL7U9XkCHPRTaeFEDDiOXEa2fL3b5ijmwQ7NNtdNDkJoTKIuw4k428rbi1gGxwqa
         GrbrcPJyOVTWgf2G6kB3KWPHA4Ytid5JrH0j/fEXZvNpBlrs8DhlamPo8WMZht+932SP
         41o+/Qe4PGDSqR08+mTSzric1+GDxI9NOeOgUe9+sVLhL1BSPNTfzcozXUf116ct+3ll
         Sl8Cb7MSld2jot6nQeBBDLPaD6/d0yRnC0NcIuzvc0201ihBnTkHIT1WlFhgzcTzoxV+
         zvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669578; x=1724274378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYLAetEAQZjZKqd+n9fHz1LludGiCPIKD9nZ07NlfWY=;
        b=pzjZNoqhXNec8e7XX5XtT+Lws1CNA1pYzC0bMCzmhaiAFcT4O3qahK5u1nWjRc5ne4
         liaEMcC0iRY4jMnOfia6PYXqtRpALHziX1ARPn8aBS7jzyvlEPdpIHtFcs5cfdOuG/Ei
         yqfd075MLeFh+ULL9ywNFmvauDCN5mV9LqldNilspjxWg5npMXuDZNDmTjsId1je4ixe
         Y+nwx0TptWXN+zBBr8lAHDI7A/HjRwLQLRtPCNcs28AP+JSaqYqrO5t12bYS+FHAnxtB
         ga0ucE9GF890Msvh4+7UybYhwGP/irbNVvBh+CufFrDSWxFsz6RI6l+/54XtlFSputq+
         zPiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNUIORShR3KaK3x07aRLlDesETG+nYXjobp71JHG0TDDHIz+3lGZkDrQm0W43nzdScCetQZqSiOXWASDXZrW9Yy1Pw3CA1FtTZIZ3amb9kmZr7+1Pzuqbf4hs6K2c43WKI3TJlBJSz27V2Cus=
X-Gm-Message-State: AOJu0YwidsVL9GjbVTbD4lvxp4rInrff5poKQ231PYwyJ/KW8DN5IJs9
	YcU7IfPKRYMLVHldu2XVqJ1ly2Dp6EOOQ3bQjjhc9baNTG8GyFlV
X-Google-Smtp-Source: AGHT+IGDebjZZDQvDjJA/CwPomFxztz9Urch3ioFcrv3isqjZboh525lba9BHuJbCMp0KQRP0ucCxw==
X-Received: by 2002:a05:6214:451e:b0:6bb:c0ad:8d78 with SMTP id 6a1803df08f44-6bf5d1def86mr51733676d6.34.1723669578249;
        Wed, 14 Aug 2024 14:06:18 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe0db99sm479526d6.36.2024.08.14.14.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:06:17 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E22F4120007A;
	Wed, 14 Aug 2024 16:59:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 14 Aug 2024 16:59:23 -0400
X-ME-Sender: <xms:qxq9Zn3A9LEVG0V1rBmWNXezv_tKBC2tgaowOLF4KRDiGijuxxaIZw>
    <xme:qxq9ZmFfWMu5YUj8C59cn4dABNosrAD-ABqR__AUuNDlqmhiSR1z9sAkk_lfToP4_
    hZPGy-eX_gPzBSrIA>
X-ME-Received: <xmr:qxq9Zn4aHv39yl6cwlP08DO_BmN7Ge-LnaS5U88XAADlOCVpEfPsbEAi0cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhoth
    honhdrmhgvpdhrtghpthhtoheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpthht
    oheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepuggrkhhrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrihhrlhhivg
    gusehrvgguhhgrthdrtghomhdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonh
    hgmhgrnhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:qxq9Zs3nqcaZgN3AdTp6nnLANBYSxiQi3Ey7hGx95eYiD0mZo7dRQQ>
    <xmx:qxq9ZqGk2e-ENVBlePEt15eijUuzVLUhtbcsBaBAvvxfbxpX9bCHPQ>
    <xmx:qxq9Zt9a5oxvFngrKRiahn4j6KDMqLl59AccRMi7-MOV3bo-SA3o-g>
    <xmx:qxq9Znmc6o1uLOL1YGDp2wdpzRK7tDHxbK1H3o7pcAv-D9pkpqPz6w>
    <xmx:qxq9ZmEitmu2ot3_6k3M86S43TKueN7mHq2E4RSwVSKsdvW8RGCcv43I>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 16:59:23 -0400 (EDT)
Date: Wed, 14 Aug 2024 13:57:55 -0700
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
Message-ID: <Zr0aUwTqJXOxE-ju@boqun-archlinux>
References: <20240802001452.464985-1-lyude@redhat.com>
 <20240802001452.464985-2-lyude@redhat.com>
 <Zrzq8su-LhUIoavm@boqun-archlinux>
 <1bcae676ec4751ae137782c4ced8aad505ec1bb9.camel@redhat.com>
 <Zr0QyN8sQ6W2hPoJ@boqun-archlinux>
 <9855f198-858d-4e3f-9259-cd9111900c0c@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9855f198-858d-4e3f-9259-cd9111900c0c@proton.me>

On Wed, Aug 14, 2024 at 08:44:15PM +0000, Benno Lossin wrote:
> On 14.08.24 22:17, Boqun Feng wrote:
> > On Wed, Aug 14, 2024 at 03:38:47PM -0400, Lyude Paul wrote:
> >> On Wed, 2024-08-14 at 10:35 -0700, Boqun Feng wrote:
> >>> On Thu, Aug 01, 2024 at 08:10:00PM -0400, Lyude Paul wrote:
> >>> [...]
> >>>> +/// Run the closure `cb` with interrupts disabled on the local CPU.
> >>>> +///
> >>>> +/// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
> >>>> +/// without interrupts.
> >>>> +///
> >>>> +/// # Examples
> >>>> +///
> >>>> +/// Using [`with_irqs_disabled`] to call a function that can only be called with interrupts
> >>>> +/// disabled:
> >>>> +///
> >>>> +/// ```
> >>>> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
> >>>> +///
> >>>> +/// // Requiring interrupts be disabled to call a function
> >>>> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
> >>>> +///     /* When this token is available, IRQs are known to be disabled. Actions that rely on this
> >>>> +///      * can be safely performed
> >>>> +///      */
> >>>> +/// }
> >>>> +///
> >>>> +/// // Disabling interrupts. They'll be re-enabled once this closure completes.
> >>>> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
> >>>> +/// ```
> >>>> +#[inline]
> >>>> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) -> T) -> T {
> >>>
> >>> Given the current signature, can `cb` return with interrupts enabled (if
> >>> it re-enables interrupt itself)? For example:
> >>>
> >>> 	with_irqs_disabled(|irq_disabled| {
> >>>
> >>> 	    // maybe a unsafe function.
> >>> 	    reenable_irq(irq_disabled);
> >>
> >> JFYI: this wouldn't be unsafe, it would be broken code in all circumstances
> >> Simply put: `with_irqs_disabled()` does not provide the guarantee that
> >> interrupts were enabled previously, only that they're disabled now. And it is
> >> never a sound operation in C or Rust to ever enable interrupts without a
> >> matching disable in the same scope because that immediately risks a deadlock
> >> or other undefined behavior. There's no usecase for this, I'd consider any
> >> kind of function that returns with a different interrupt state then it had
> >> upon being called to simply be broken.
> >>
> >> Also - like we previously mentioned, `IrqDisabled` is just a marker type. It
> >> doesn't enable or disable anything itself, the most it does is run a debug
> > 
> > Yes, I know, but my question is more that should `cb` return a
> > `IrqDisabled` to prove the interrupt is still in the disabled state?
> > I.e. no matter what `cb` does, the interrupt remains disabled.
> 
> What does this help with? I don't think this will add value (at least
> with how `IrqDisabled` is designed at the moment).
> 

I was trying to make sure that user shouldn't mess up with interrupt
state in the callback function, but as you mention below, type system
cannot help here.

> >> assertion to ensure interrupts are disabled upon creation. So dropping it
> >> doesn't change interrupt state. I think this actually does make sense
> >> semantically: even if IrqDisabled wasn't a no-op in a world where we could
> > 
> > Just to be clear, I'm not suggesting making IrqDisable not a no-op.
> > 
> >> somehow implement that without running into the drop order issue - there still
> >> would not be a guarantee that dropping `IrqDisabled` would enable interrupts
> >> simply because it could be a nested disable. And there's no way we could make
> >> interrupt enabled sections explicit without either klint, or carrying around a
> >> `IrqEnabled` (which we would have to do for every function that could sleep,
> >> so I don't think that's ideal). So without a token like this all code can do
> >> is assume it doesn't know the interrupt state, and rely on solutions like
> >> lockdep to complain if code within an interrupt context tries to perform an
> >> operation that would be unsound there like sleeping.
> >>
> >> This being said - I would be totally alright with us making it so that we
> >> assert that interrupts are still disabled upon dropping the token. But
> 
> We can't implement `Drop`, since it already implements `Copy`. But we
> could add a debug assert before we call `local_irq_restore`. I think
> it's a good idea to add a debug assert.
> 
> >> interrupts have to disabled throughout the entire closure regardless of the
> >> presence of IrqDisabled. The same rules apply to C code using
> >> local_irq_save()/local_irq_restore() - between those two function calls, it is
> >> always a bug to re-enable interrupts even if they get turned back off. Unsafe
> > 
> > Do you mean the particular local_irq_save() and local_irq_restore(), or
> > do you mean any interrupt disable critical sections? Note that we have
> > wait_event_interruptible_locked_irq() which does exactly re-enabling
> > interrupt in the middle to sleep and I'm pretty sure we have other cases
> > where interrupts are re-enabled. So I'm not sure when you say "the same
> > rules apply to C code ..."
> > 
> >> functions are no exceptions, nor are C bindings, and should simply be
> >> considered broken (not unsafe) if they violate this. I suppose that's
> >> something else we could document if people think it's necessary.
> >>
> >>
> >>> 	})
> >>>
> >>> note that `cb` is a `-> T` function, other than `-> (IrqDisabled<'a>,
> >>> T)`, so semantically, it doesn't require IRQ still disabled after
> >>> return.
> >>
> >> This was the reason I originally had us pass IrqDisabled as a reference and
> >> not a value - specifically since it seemed to make more sense to treat
> >> IrqDisabled as an object which exists throughout the lifetime of the closure
> >> regardless of whether we drop our reference to it or not - since it's a no-op.
> >>
> > 
> > I haven't found a problem with `&IrqDisabled` as the closure parameter,
> > but I may miss something.
> 
> We could also use `&'a IrqDisabled` instead of `IrqDisabled<'a>` (note
> the first one doesn't have a lifetime). But there is no behavioral
> difference between the two. Originally the intended API was to use `&'a
> IrqDisabled<'a>` as the closure parameter and `IrqDisabled<'a>` in
> functions that require irqs being disabled. As long as we decide on a
> consistent type, I don't mind either (since then we can avoid
> reborrowing).
> 
> > So the key ask from me is: it looks like we are on the same page that
> > when `cb` returns, the IRQ should be in the same disabled state as when
> > it gets called. So how do we express this "requirement" then? Type
> > sytem, comments, safety comments?
> 
> I don't think that expressing this in the type system makes sense, since
> the type that we select (`&'a IrqDisabled` or `IrqDisabled<'a>`) will be
> `Copy`. And thus you can just produce as many of those as you want.
> 

You're right, we then probably need a doc part of the function saying
the `cb` cannot return with interrupt enabled.

Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> 

