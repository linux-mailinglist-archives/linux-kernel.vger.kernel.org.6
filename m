Return-Path: <linux-kernel+bounces-343235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE4B989870
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A20C1C20EC8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3487C17F4FF;
	Sun, 29 Sep 2024 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ11b4Yq"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D4768E1;
	Sun, 29 Sep 2024 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727653584; cv=none; b=tnjGZEe79AXJr6XVr4+CG3P1RHhSq57OUEpfIlqSbs8PuW9dEc6laVau+cbk63RdkTSxTF9sHly7F0YQuzri2EUiIPPJ+alsQePI4W63d3LIaMEg8XeC013ULbvbgyi5MbzJkae2VHtA+0jGDDmKEwfvsNKCRaPJGLobtjOlQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727653584; c=relaxed/simple;
	bh=BKiVngq6Vjkmbmwa9DQ1PjeofEnOGk4Rky/wtjPh4lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuMWZtnglTH2QzIDbx9GnYEOvoFepb7tCBl8vM5G+KCEb9DUx313pVBzwROX0UdZQ7J38liAmAL1rpTv/pL6YDaE+Qn1JKCuOPMJQD51nt/854Krzf2IfkAEL1YoEDfL+6O9biQP30vArmMjX+pLw/FQ+GkG6zNRG69ReLpQMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ11b4Yq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9a3e731f9so350796585a.0;
        Sun, 29 Sep 2024 16:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727653581; x=1728258381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RmTJjQ3kruUd61iEEdb0STJi77YrtZut175Phz3lm8=;
        b=fZ11b4YqZ981CmWX37ij+DyoTEiuA3vC/yqZ2Bh3XjyUta2j0snaKbBHmYJVzCZM1m
         DxADvLUpS6W6WxDndllXS9yrPKJrr4ApkrVFA/zn+6P5ut5YxnRzp49bqEvTpY2rvuaJ
         /BdAjpmRFhBF0tyUaYufypfgMkaxS/0yhT21XkWk0sH4pajws/3n2m/S+ncyNx6U/9W6
         QIP0CDOmhEn17ZWVBg8kaoomz3SBAP5z7+2V989Raa8E0TDVhJ/7yTSvbOv6kDjnUv8B
         VISz7DHX1XeoRc9GAQ2xp4a7g9bC91hydINUO3531jxMd1cwgFwPSdvnHFBbjrVHZ0F0
         C6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727653581; x=1728258381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RmTJjQ3kruUd61iEEdb0STJi77YrtZut175Phz3lm8=;
        b=hi0NO2r4YK7PfmHdrl/PBuhUS5XAiHePSZ/Gzc606cOXp7N/OW3nlD8XoqpG+X58AB
         DZnr+06MrJmCvq31la0kEl5nygt5DnkeTdxtBNG0NGl4TSZQbuTRjRRCQEx5ORaECGUp
         OLOgDvZJeRh+CxbD+0JLTL7XQKipIpALtKn4CQekXpnQVX7BOVTLTxl1uTYpSdl68TEk
         UFoGGYIbwJ1aF5iQnyqSo1uPICoD1Pz6g8UYyiaDvbQtwxUGkwD465ejtOfw6TUz1gxX
         EWUoFPUg/xQpQ7obB+eF35bQKsEHE44hTjo/3uIm7bj/ycHUuTYSN3MsBmwejS7Blt26
         0jnA==
X-Forwarded-Encrypted: i=1; AJvYcCXytr01RETZYgd2ito1nA7ctZyFojo9PyL6m7PIolJMCp0xBSWA/7+YX3T3bjZWHp/Xd2Xony4EHm84dHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCkTZDZ1y5FtAvk/WmquMGgrt7Nmsz4urqduc1KSiaHIg9mSO
	QAh3GX0tdZBEv0er+MWijjrESKRi3JZRnyLvjOEb/vQ37h6O9pJr
X-Google-Smtp-Source: AGHT+IF233xzZt06bzk3xhfv4YasPuHHODKzkjODTO2zhrFTOE8HxoWovbxa6TLl5Op4rQ92wKcKxQ==
X-Received: by 2002:a05:620a:4102:b0:79f:b3d:bed1 with SMTP id af79cd13be357-7ae378bbfdbmr1445822585a.49.1727653581154;
        Sun, 29 Sep 2024 16:46:21 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3782c745sm362347085a.90.2024.09.29.16.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 16:46:20 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1B3561200043;
	Sun, 29 Sep 2024 19:46:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 29 Sep 2024 19:46:20 -0400
X-ME-Sender: <xms:y-b5ZpDRzZb56Zg-OvPiMwe8Rwa8FBMOMVQI-cLOI6T0VUnelKqmow>
    <xme:y-b5Zni2n3g7JXVxWvqFuwQxeQGXaFXfybDT51S439DZrZ7_Ucrk_eWL6eTBK35eA
    jmdAaGSfzhY09airw>
X-ME-Received: <xmr:y-b5ZknZ8BeWE2WoGbepDPuFxvcSrgfkYU1PujuOZ3t2LIFRq3SisnyO9c0eVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeuvefhieefueevueettdefieelledugeeugeeg
    leejhfejvddvueefgeekieegteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegurghkrhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghirhhlihgvuges
    rhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhm
    rghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:y-b5ZjyG83Zd2ayDUTagIzoqzV2mxhapFH-P0JmQDXd_syCpYlLRvg>
    <xmx:zOb5ZuTT3XNSJvqsbHBXXqe7xhsAf3uACae6Mk84dIiKI_K-zCFxHA>
    <xmx:zOb5Zmas6DBLAae4Tb-kq4A5-qGaoQrGWXF9Rf3CssGLsiexWapgfA>
    <xmx:zOb5ZvScmrJEwGuaaub8bP-LAvXH-I5wGdVHASXREv4SQOUM_9NkxA>
    <xmx:zOb5ZsDYeEYeAQfZjQ4qvIrLvSgvvisxdD_1bb3uq_I8K4b2VsaQQrvZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Sep 2024 19:46:19 -0400 (EDT)
Date: Sun, 29 Sep 2024 16:45:23 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Benno Lossin <benno.lossin@proton.me>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v6 1/3] rust: Introduce irq module
Message-ID: <ZvnmkwRjxRTDACZD@boqun-archlinux>
References: <20240916213025.477225-1-lyude@redhat.com>
 <20240916213025.477225-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916213025.477225-2-lyude@redhat.com>

On Mon, Sep 16, 2024 at 05:28:04PM -0400, Lyude Paul wrote:
> This introduces a module for dealing with interrupt-disabled contexts,
> including the ability to enable and disable interrupts
> (with_irqs_disabled()) - along with the ability to annotate functions as
> expecting that IRQs are already disabled on the local CPU.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> 

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
> 
> V2:
> * Actually make it so that we check whether or not we have interrupts
>   disabled with debug assertions
> * Fix issues in the documentation (added suggestions, missing periods, made
>   sure that all rustdoc examples compile properly)
> * Pass IrqDisabled by value, not reference
> * Ensure that IrqDisabled is !Send and !Sync using
>   PhantomData<(&'a (), *mut ())>
> * Add all of the suggested derives from Benno Lossin
> 
> V3:
> * Use `impl` for FnOnce bounds in with_irqs_disabled()
> * Use higher-ranked trait bounds for the lifetime of with_irqs_disabled()
> * Wording changes in the documentation for the module itself
> 
> V4:
> * Use the actual unsafe constructor for IrqDisabled in
>   with_irqs_disabled()
> * Fix comment style in with_irqs_disabled example
> * Check before calling local_irq_restore() in with_irqs_disabled that
>   interrupts are still disabled. It would have been nice to do this from a
>   Drop implementation like I hoped, but I realized rust doesn't allow that
>   for types that implement Copy.
> * Document that interrupts can't be re-enabled within the `cb` provided to
>   `with_irqs_disabled`, and link to the github issue I just filed about
>   this that describes the solution for this.
> 
> V5:
> * Rebase against rust-next for the helpers split
> * Fix typo (enabled -> disabled) - Dirk
> 
> V6:
> * s/indicate/require/ in IrqDisabled docs
> * Reword comment above with_irqs_disabled in code example requested by
>   Benno
> * Add paragraph to with_irqs_disabled docs requested by Benno
> * Apply the comments from Boqun's review for V4 that I missed
> * Document type invariants of `IrqDisabled`
> 
> This patch depends on
> https://lore.kernel.org/rust-for-linux/ZuKNszXSw-LbgW1e@boqun-archlinux/
> 
> ---
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/irq.c     | 22 ++++++++++
>  rust/kernel/irq.rs     | 96 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |  1 +
>  4 files changed, 120 insertions(+)
>  create mode 100644 rust/helpers/irq.c
>  create mode 100644 rust/kernel/irq.rs
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 30f40149f3a96..0bb48df454bd8 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -12,6 +12,7 @@
>  #include "build_assert.c"
>  #include "build_bug.c"
>  #include "err.c"
> +#include "irq.c"
>  #include "kunit.c"
>  #include "mutex.c"
>  #include "page.c"
> diff --git a/rust/helpers/irq.c b/rust/helpers/irq.c
> new file mode 100644
> index 0000000000000..ec1e8d700a220
> --- /dev/null
> +++ b/rust/helpers/irq.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/irqflags.h>
> +
> +unsigned long rust_helper_local_irq_save(void)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +
> +	return flags;
> +}
> +
> +void rust_helper_local_irq_restore(unsigned long flags)
> +{
> +	local_irq_restore(flags);
> +}
> +
> +bool rust_helper_irqs_disabled(void)
> +{
> +	return irqs_disabled();
> +}
> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> new file mode 100644
> index 0000000000000..ee3a4549aa389
> --- /dev/null
> +++ b/rust/kernel/irq.rs
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Interrupt controls
> +//!
> +//! This module allows Rust code to control processor interrupts. [`with_irqs_disabled()`] may be
> +//! used for nested disables of interrupts, whereas [`IrqDisabled`] can be used for annotating code
> +//! that requires interrupts to be disabled.
> +
> +use bindings;
> +use core::marker::*;
> +use crate::types::NotThreadSafe;
> +
> +/// A token that is only available in contexts where IRQs are disabled.
> +///
> +/// [`IrqDisabled`] is marker made available when interrupts are not active. Certain functions take
> +/// an [`IrqDisabled`] in order to require that they may only be run in IRQ-free contexts.
> +///
> +/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that
> +/// interrupts are disabled where required.
> +///
> +/// This token can be created by [`with_irqs_disabled`]. See [`with_irqs_disabled`] for examples and
> +/// further information.
> +///
> +/// # Invariants
> +///
> +/// IRQs are disabled when an object of this type exists.
> +#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
> +pub struct IrqDisabled<'a>(PhantomData<(&'a (), NotThreadSafe)>);
> +
> +impl IrqDisabled<'_> {
> +    /// Create a new [`IrqDisabled`] token in an interrupt disabled context.
> +    ///
> +    /// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
> +    /// without interrupts. If debug assertions are enabled, this function will assert that
> +    /// interrupts are disabled upon creation. Otherwise, it has no size or cost at runtime.
> +    ///
> +    /// # Panics
> +    ///
> +    /// If debug assertions are enabled, this function will panic if interrupts are not disabled
> +    /// upon creation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must only be called in contexts where it is already known that interrupts have
> +    /// been disabled for the current CPU, and the user is making a promise that they will remain
> +    /// disabled at least until this [`IrqDisabled`] is dropped.
> +    pub unsafe fn new() -> Self {
> +        // SAFETY: FFI call with no special requirements
> +        debug_assert!(unsafe { bindings::irqs_disabled() });
> +
> +        // INVARIANT: The safety requirements of this function ensure that IRQs are disabled.
> +        Self(PhantomData)
> +    }
> +}
> +
> +/// Run the closure `cb` with interrupts disabled on the local CPU.
> +///
> +/// This disables interrupts, creates an [`IrqDisabled`] token and passes it to `cb`. The previous
> +/// interrupt state will be restored once the closure completes. Note that interrupts must be
> +/// disabled for the entire duration of `cb`, they cannot be re-enabled. In the future, this may be
> +/// expanded on [as documented here](https://github.com/Rust-for-Linux/linux/issues/1115).
> +///
> +/// # Examples
> +///
> +/// Using [`with_irqs_disabled`] to call a function that can only be called with interrupts
> +/// disabled:
> +///
> +/// ```
> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
> +///
> +/// // Requiring interrupts be disabled to call a function
> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
> +///     // When this token is available, IRQs are known to be disabled. Actions that rely on this
> +///     // can be safely performed
> +/// }
> +///
> +/// // Disables interrupts, their previous state will be restored once the closure completes.
> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
> +/// ```
> +#[inline]
> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) -> T) -> T {
> +    // SAFETY: FFI call with no special requirements
> +    let flags = unsafe { bindings::local_irq_save() };
> +
> +    // SAFETY: We just disabled IRQs using `local_irq_save()`
> +    let ret = cb(unsafe { IrqDisabled::new() });
> +
> +    // Confirm that IRQs are still disabled now that the callback has finished
> +    // SAFETY: FFI call with no special requirements
> +    debug_assert!(unsafe { bindings::irqs_disabled() });
> +
> +    // SAFETY: `flags` comes from our previous call to local_irq_save
> +    unsafe { bindings::local_irq_restore(flags) };
> +
> +    ret
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f10b06a78b9d5..df10c58e95c19 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -36,6 +36,7 @@
>  pub mod firmware;
>  pub mod init;
>  pub mod ioctl;
> +pub mod irq;
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
>  pub mod list;
> -- 
> 2.46.0
> 

