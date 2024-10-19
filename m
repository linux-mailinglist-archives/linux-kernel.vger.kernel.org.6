Return-Path: <linux-kernel+bounces-372606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F42289A4AE7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 03:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BDA1C219E4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9291CC16D;
	Sat, 19 Oct 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpbC95wx"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332B2D60C;
	Sat, 19 Oct 2024 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729302843; cv=none; b=i10Cd4KFmATAyovBrUXYDQ+7kcLLQIOCr9ck+mc6GPjWk3A4yV1kiBu3+19aT0MLx+cFiRV8u/rMmTKZYCD9c//0eWLbDIbh1UNmlZeQDNCTCLPDJsKbx4KPdCXBymKxFLOvrYY0x5uaGoAgt9HfWF5j2YnVdZa73uTFuJAdqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729302843; c=relaxed/simple;
	bh=EtU7CsnHLcIsuw31cqD2g/BU87qT1c9aRJE7IMeIYZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5ekFoOlOa5uFVYD9zzZgopypyGQ+RBkxnveA1BMvKmHM2R5FFEOFkccrLQTlohwmmFZ0mvW7UbjSEPOKWg1kAFK4Re8qp/CgYQTSQUEVgB3Bi3PvSS9k2VQPhoNRoo3aZ+ge0egcv4RcoX+sDto/huUtnsselNhChOFJE6oKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpbC95wx; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4603f47b2c8so25583091cf.1;
        Fri, 18 Oct 2024 18:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729302840; x=1729907640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHfQp7MLzxGXyhG5Mst9aE+SDHFDQDOumqHjKGFwADE=;
        b=jpbC95wx4kVx1LCiwJArSYee33tpKvxU9kWQmls5JTsaR9wZpOj+9ZYCEf6KscA1Vv
         VY1AY/je3L9KhhP9dr0NcpzKYFyyDhOt7pb53AFr6EIQ1e94TkbVa2yxL+8TMH5QSWlk
         bCLhsfj7PwKF8wyN1+kr9Ht95ZCGfnxe3ls9hvAPgeeh+z/7P/Iovlxs4cmfklC4dfef
         WAs/g4jUXbDZ4Ali2pmy7i5qXqL0+BZFcLpML9IMCQLAdq7rVnexFEXKH3JVuaUWt8Pa
         S05KE7+CQeihOzgjR8ZdLIyFYdtYPnFEGK/EPSsB8RVjwTxJgrjjSn3rjj8tuJltaKpT
         YSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729302840; x=1729907640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHfQp7MLzxGXyhG5Mst9aE+SDHFDQDOumqHjKGFwADE=;
        b=P3XY4C+d10DxAxeCI3nL57w9ekBLVQFSzw1Oi3hIDVcSMSojtxVwC0FlD2qqiKdfzU
         mxChm646lBGVYBJDrKok3FrVeMHEnIU7zEZp/AgzRbNlVT/L6yNyGI5J94seS/MKBXXM
         dR/ITJ5gy87abVH3tACTFUvVUG5Nie7yPw/D5UaSmBHPo1Ix8iQVA34wi7PekAvbPCvs
         8CuUTVou1bfUrX/nyGl8ejUl55DDUQVe0gvzYvLCZp43HDc6bR+pjEIECicXNzPg1QxC
         dVSFRKNjtsvvqkt64m7e1AoiBsmjFy06Tq6gIPA0a+TEe4QUnd/Xe/NvXo0F9AW+uJAz
         z2zg==
X-Forwarded-Encrypted: i=1; AJvYcCWUcfXPNEs+tQa1eqXX4e4vYooWbvqbwWN/IjG77x/D0Udxt51elNB0MSg0M8HWanSPSn8ijldZ3uU9hvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK8o6Anrabi4X+kih1L7zPlqNUsBKMY4ziPMBy06X0S3A1W9Gq
	af6bN0fMc/fbLIPCqoRT9gnwl1JavUpXu80pM7orLCH26whLsYKK
X-Google-Smtp-Source: AGHT+IFVxo51ISQa/t7XES+HxC7NLMvIofigdVN7WjKWCzJs/zohUBHxnX2sL+QdPq+6gmlQUZYyUw==
X-Received: by 2002:a05:622a:1b0e:b0:45c:aab1:72ec with SMTP id d75a77b69052e-460aee6ff67mr69885341cf.53.1729302839653;
        Fri, 18 Oct 2024 18:53:59 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460aea459efsm12809161cf.77.2024.10.18.18.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 18:53:59 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 49C7E1200043;
	Fri, 18 Oct 2024 21:53:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 18 Oct 2024 21:53:58 -0400
X-ME-Sender: <xms:NhETZ9dcVu_Uq5JDJP0jhcfx4_HnGeCVAe1QmOfqUWTyvz34ZHueNA>
    <xme:NhETZ7PNWM-mQ0V3-1h63W53EsQgrrizu1UEMfBYdlG1Ewydoqzfs0mB5icZjcz7h
    LbNXazf_uLJNFqyhA>
X-ME-Received: <xmr:NhETZ2i_AuTLd-P9p16Y9PxgL2FkmlvhPcs5jCLwSH9KqCLZ5fRqdWsGxY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhl
    ihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopegrihhrlhhivggusehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgt
    ohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpth
    htohepthhglhigsehlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:NhETZ29b5nUtfpCsNbOCTzXcbRNcdgnhN8TbzQY-sYrdxvcMq_mb1g>
    <xmx:NhETZ5ts0vGkHQ7nB_TcbVs6qRiLLwqBUIBxtT72wqniQ0nOnr1sJQ>
    <xmx:NhETZ1Ec9g0Eoqs1dGnLTm2GMQVM48RF7PdMs8BoyucXyWihc2R0qQ>
    <xmx:NhETZwNmhNr66fnc2_wUucgdfXIO7Z-NhX7DwKeOwBdmKcfcFR8R7g>
    <xmx:NhETZyPueqv29v9jnWNKFHrp7tvxA0v9j42r30dzcJyZmevpRAg8VMY0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 21:53:57 -0400 (EDT)
Date: Fri, 18 Oct 2024 18:53:56 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v8 1/3] rust: Introduce local_irq module
Message-ID: <ZxMRNFouhf30ibVy@Boquns-Mac-mini.local>
References: <20241018232306.476664-1-lyude@redhat.com>
 <20241018232306.476664-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018232306.476664-2-lyude@redhat.com>

On Fri, Oct 18, 2024 at 07:22:25PM -0400, Lyude Paul wrote:
> This introduces a module for adding marker types to indicate the type of
> interrupt context a function is called in. Note that nothing here enables
> or disables interrupts on its own, this is simply for verifying correctness
> at compile-time.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> 
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
> V7:
> * Change name of module to local_irq.rs
> * Remove with_interrupts_disabled()
> * Update documentation wording a bit to make mention of PREEMPT_RT
> 

So with the current approach in your patch, there is no safe way to
enable interrrupts (or restore the interrupt state). Therefore I don't
think there is a safe version of CondVar::wait(), at least it won't be
easy to use at the current API. Right?

Whereas the POC [1] approach does support CondVar::wait() and a guard
interface, and has a relatively simple (and more Rusty) design. To
Thomas' point [2], I think we should look at it (interrupt disabling and
nested interrupt disabling) from Rust perspective and provide a cleaner
API in Rust.

And I think a guard interface (and we can even have a guard interface
for interrupt disabling itself) is what we *want* to provide to the
users, the fact that we cannot provide it currently is something we want
to workaround. Maybe we should focus on providing these better APIs with
acceptable small workarounds if necessary first.

Anyway, just make some of my points. Looking forward to hearing your
feedbacks!

Regards,
Boqun

[1]: https://lore.kernel.org/rust-for-linux/ce05b149-63ca-46c9-8eb3-67ff3dc5b2c5@gmail.com/
[2]: https://lore.kernel.org/rust-for-linux/87iktrahld.ffs@tglx/
[3]: https://lore.kernel.org/rust-for-linux/20241018055125.2784186-2-boqun.feng@gmail.com/

> This patch depends on
> https://lore.kernel.org/rust-for-linux/20240808-alice-file-v9-1-2cb7b934e0e1@google.com/
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/helpers/helpers.c   |  1 +
>  rust/helpers/irq.c       |  8 ++++++
>  rust/kernel/lib.rs       |  1 +
>  rust/kernel/local_irq.rs | 56 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+)
>  create mode 100644 rust/helpers/irq.c
>  create mode 100644 rust/kernel/local_irq.rs
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 20a0c69d5cc7b..fd70afe5069ca 100644
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
> index 0000000000000..d129094cc1940
> --- /dev/null
> +++ b/rust/helpers/irq.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/irqflags.h>
> +
> +bool rust_helper_irqs_disabled(void)
> +{
> +	return irqs_disabled();
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 620de74d128f9..b7e604bc968ce 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -40,6 +40,7 @@
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
>  pub mod list;
> +pub mod local_irq;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
>  pub mod page;
> diff --git a/rust/kernel/local_irq.rs b/rust/kernel/local_irq.rs
> new file mode 100644
> index 0000000000000..e9e82347392c7
> --- /dev/null
> +++ b/rust/kernel/local_irq.rs
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Interrupt controls
> +//!
> +//! This module allows Rust code to annotate functions which can only be called in contexts where
> +//! local interrupts on the CPU may be disabled.
> +
> +use crate::types::NotThreadSafe;
> +use bindings;
> +use core::marker::*;
> +
> +/// A token that is only available in contexts where interrupts are disabled on non-PREEMPT_RT
> +/// kernels.
> +///
> +/// [`IrqDisabled`] is marker made available when local processor interrupts are disabled on
> +/// non-PREEMPT_RT kernels. A function may require a [`IrqDisabled`] to ensure that functions may
> +/// only be run with processor interrupts disabled on such kernels.
> +///
> +/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that
> +/// interrupts are disabled where required.
> +///
> +/// # Invariants
> +///
> +/// On kernels where `CONFIG_PREEMPT_RT=n` is set in the kernel config, local processor interrupts
> +/// are disabled whenever an object of this type exists.
> +#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
> +pub struct IrqDisabled<'a>(PhantomData<(&'a (), NotThreadSafe)>);
> +
> +impl IrqDisabled<'_> {
> +    /// Create a new [`IrqDisabled`] token in an interrupt disabled context.
> +    ///
> +    /// This creates a [`IrqDisabled`] token, which can be passed to functions that must
> +    /// be run without interrupts on kernels where `CONFIG_PREEMPT_RT=n`. If debug assertions are
> +    /// enabled, this function will assert that interrupts match the expected state. Otherwise, it
> +    /// has no size or cost at runtime.
> +    ///
> +    /// # Panics
> +    ///
> +    /// If debug assertions are enabled, then this function will assert on non-PREEMPT_RT kernels
> +    /// that local processor interrupts are disabled upon creation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must only be called in contexts where it is known that on a non-PREEMPT_RT
> +    /// kernel, local interrupts have been disabled for the current CPU. The user is making a
> +    /// promise that they will remain disabled at least until this [`IrqDisabled`] is
> +    /// dropped.
> +    pub unsafe fn new() -> Self {
> +        // SAFETY: FFI call with no special requirements
> +        debug_assert!(unsafe { bindings::irqs_disabled() });
> +
> +        // INVARIANT: The safety requirements of this function ensure that IRQs are disabled on
> +        // non-PREEMPT_RT kernels.
> +        Self(PhantomData)
> +    }
> +}
> -- 
> 2.47.0
> 

