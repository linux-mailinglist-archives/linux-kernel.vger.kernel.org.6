Return-Path: <linux-kernel+bounces-540681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65690A4B3AF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3308E7A21ED
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1D31EB1A8;
	Sun,  2 Mar 2025 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljKHUN3E"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678375661;
	Sun,  2 Mar 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740935268; cv=none; b=fbWUmtrVJzRhcJJ/AWX/Q6BVx0apqS/hfPYHa7ai5zHO7SVAPlISB7Bl3VWXhjDwLWlPjcLiu5p6qCDMwK2BeNQmGdig+7AkmgoqvTf3RmsfRl1lcy+stf597swKCcb6OWxgm9U8Hg6IhPSeJ8HqO/Fd9xABxp7+9x0mu7xK+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740935268; c=relaxed/simple;
	bh=9ZK9nEE+88bbn8BxWZJCEqofWkZwAIwcSU3NiUZjeRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khKRSwAgX50AQZTx0poLt7dgZyLEZe+f4zrekIMjCH2phyPr8Tel2kmFpQho4WdUZ3hUsZTqrinNO+8FMgY82+1HjQmsvzCAIW/UQN3ZwpnTaGCDA9H1F7sU1eIbz9aw0hYFMcKb6Wrly4yLzLVilrI+g+mAPmnFAbcoBhESonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljKHUN3E; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaec111762bso678974866b.2;
        Sun, 02 Mar 2025 09:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740935265; x=1741540065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hclPygd79ZpX9T3xc/SleAjV4UonSIgrdhTmCTiVktk=;
        b=ljKHUN3EQnHpPY/RNPAbK+tGlxnAI0cuh3pqQngIG4o21EFqTF2XMJUQnz8f5Rl4ce
         rZnVbCAhZ3abdpb9ij11x6REsruyCAhxueHVQqEwnrguQujPe3DAhsTEFAkESLRSIlQG
         D6fbRFh0OQfxNNHlan8aGiJJhoCwtyEUixykpDDA/zpocZhFJMZ1Vep0MygpO1b+ZPoL
         8XYXh3hf+5ok8nUfIEY7JixzfTaFfY6DUw/UfSi2tikfPOa5TMvcHBjr4w/QMt/6/qrI
         vCkWg8Lse80NBrsp70SgG1FD0xPP0YaTxCq+Hgh5+RiJQE6W0FCge8IZXLRiWcLcIfSL
         ZcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740935265; x=1741540065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hclPygd79ZpX9T3xc/SleAjV4UonSIgrdhTmCTiVktk=;
        b=MU239nXGjveTGwGcjZZAcN8Epttfzot/6zkmyrnOfykFf4eCtGzh4rO9V1pv0+lkoa
         tg/KOcf6Qo71oGWwz9U6eSXwoLUElrW3xE/SbQQ/tBYyaJbP+Ncywblv2AxFAEARkpps
         T2Or5hJOgMBPkm41NTIQwFqu2afwABmMiUTLNpaB2xhlciM7HYNsfsptfE7xrFbPPGRJ
         vdxoYSRoZci2H1W/6fsMHzkZdNGpF65zjOXynJyU8MFF6Rr7xrB244K1m0u5SZYZJoz0
         uB++6ctMXSTq2wHswOSyZijJ+ddSnfEyLTz16DzqJ/FnZQp3KDrBMktK77dZP9ndrIbm
         kftA==
X-Forwarded-Encrypted: i=1; AJvYcCVN+uVIz0zLHvwfIIODTph5TO1YvvaX3p8nTKSh6srkchskVROQ8aRcZETUqG82gq07/iL3ZsAcbSvwmE3+w8Q=@vger.kernel.org, AJvYcCWG3Jyup/LU+l6Y/5QCzbyrGNz5+oxIhVRGuN8buKr25KFciVOncE4p9By4FdZxsG2OVBlUAivzEgQOPCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgtUDXBmPBaQVxM+gdpmsuR+d3z5ITdhte2kj+UjQfbbDDUwB
	X208pqoeI0eVqV35LLLD/YZhykd+1+u+1gtApS/SY4tI1ql1fJOH
X-Gm-Gg: ASbGncvQtwkT2IPUbn96s2a7NcqSHGJ96EkYkRdzAFewxcL1KoGDA0yTgsaCbYyMTd5
	yWdlD8grUYZhzBYNIbZQRIjzB/CpLGPskkDLjT9FNxkQkN79JobwuVydJn4Yhm1jJcXuFm6ASXt
	O3iGTt0lE9uHlIwKbQJAZRjCJXZiuXhT6HmopJq9DbCPRseD8dezGFGkkq/Gf8nlOI1kR0/wgxZ
	giOcS6UAFfsLVbzFamQckInJyFZoijOXuGiZ4vFILctGoiRUFzxJVhixvZY6Lsaninb2FM4EEDV
	GTo8JhMjWfOO3bu0UGW64JBiKONun0gztsy8LbhF6NX4RHnbgDjtO3b9MJznE9wvKjl7TAmxZBf
	MMTNpYSqet8umbY9Zd0ScfgQqci3uXXnbRSVhWK6iZMsc61/TzGPD5aW/PaTTT3SX6xUfh8+tyF
	74
X-Google-Smtp-Source: AGHT+IEmEEaztzHiGUWqOpzzlr3OvI0JM85UImed4RrFbsBSCjZx3aGNuOMfvcpxfqFXpmAORLA0nw==
X-Received: by 2002:a17:907:3fa4:b0:ab6:d7c5:124 with SMTP id a640c23a62f3a-abf265e8ed2mr1056722666b.43.1740935264569;
        Sun, 02 Mar 2025 09:07:44 -0800 (PST)
Received: from ?IPV6:2003:df:bf03:a200:eeb1:4cf6:acf1:a130? (p200300dfbf03a200eeb14cf6acf1a130.dip0.t-ipconnect.de. [2003:df:bf03:a200:eeb1:4cf6:acf1:a130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf75481eb4sm94031366b.83.2025.03.02.09.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 09:07:44 -0800 (PST)
Message-ID: <7026deb6-6e35-47f6-9462-0880a5b47509@gmail.com>
Date: Sun, 2 Mar 2025 18:07:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/9] rust: sync: Add SpinLockIrq
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20250227221924.265259-1-lyude@redhat.com>
 <20250227221924.265259-7-lyude@redhat.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20250227221924.265259-7-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.02.25 23:10, Lyude Paul wrote:
> A variant of SpinLock that is expected to be used in noirq contexts, so
> lock() will disable interrupts and unlock() (i.e. `Guard::drop()` will
> undo the interrupt disable.
> 
> [Boqun: Port to use spin_lock_irq_disable() and
> spin_unlock_irq_enable()]
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Co-Developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync.rs               |   4 +-
>  rust/kernel/sync/lock/spinlock.rs | 141 ++++++++++++++++++++++++++++++
>  2 files changed, 144 insertions(+), 1 deletion(-)
> 
...
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index ab2f8d0753116..ac66493f681ce 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -139,3 +139,144 @@ unsafe fn assert_is_held(ptr: *mut Self::State) {
>          unsafe { bindings::spin_assert_is_held(ptr) }
>      }
>  }
> +
> +/// Creates a [`SpinLockIrq`] initialiser with the given name and a newly-created lock class.
> +///
> +/// It uses the name if one is given, otherwise it generates one based on the file name and line
> +/// number.
> +#[macro_export]
> +macro_rules! new_spinlock_irq {
> +    ($inner:expr $(, $name:literal)? $(,)?) => {
> +        $crate::sync::SpinLockIrq::new(
> +            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
> +    };
> +}
> +pub use new_spinlock_irq;
> +
> +/// A spinlock that may be acquired when local processor interrupts are disabled.
> +///
> +/// This is a version of [`SpinLock`] that can only be used in contexts where interrupts for the
> +/// local CPU are disabled. It can be acquired in two ways:
> +///
> +/// - Using [`lock()`] like any other type of lock, in which case the bindings will ensure that
> +///   interrupts remain disabled for at least as long as the [`SpinLockIrqGuard`] exists.

The [`lock_with()`] below states "interrupt state will not be
touched". Should the [`lock()`] part above mention that the interrupt
state *is* touched, then? Like in the comment in the example below
("... e.c.lock();  // interrupts are disabled now")? For example:

... the bindings will ensure that interrupts are disabled and remain
disabled ...

?

Dirk


> +/// - Using [`lock_with()`] in contexts where a [`LocalInterruptDisabled`] token is present and
> +///   local processor interrupts are already known to be disabled, in which case the local interrupt
> +///   state will not be touched. This method should be preferred if a [`LocalInterruptDisabled`]
> +///   token is present in the scope.
> +///
> +/// For more info on spinlocks, see [`SpinLock`]. For more information on interrupts,
> +/// [see the interrupt module](kernel::interrupt).
> +///
> +/// # Examples
> +///
> +/// The following example shows how to declare, allocate initialise and access a struct (`Example`)
> +/// that contains an inner struct (`Inner`) that is protected by a spinlock that requires local
> +/// processor interrupts to be disabled.
> +///
> +/// ```
> +/// use kernel::sync::{new_spinlock_irq, SpinLockIrq};
> +///
> +/// struct Inner {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// #[pin_data]
> +/// struct Example {
> +///     #[pin]
> +///     c: SpinLockIrq<Inner>,
> +///     #[pin]
> +///     d: SpinLockIrq<Inner>,
> +/// }
> +///
> +/// impl Example {
> +///     fn new() -> impl PinInit<Self> {
> +///         pin_init!(Self {
> +///             c <- new_spinlock_irq!(Inner { a: 0, b: 10 }),
> +///             d <- new_spinlock_irq!(Inner { a: 20, b: 30 }),
> +///         })
> +///     }
> +/// }
> +///
> +/// // Allocate a boxed `Example`
> +/// let e = KBox::pin_init(Example::new(), GFP_KERNEL)?;
> +///
> +/// // Accessing an `Example` from a context where interrupts may not be disabled already.
> +/// let c_guard = e.c.lock(); // interrupts are disabled now, +1 interrupt disable refcount
> +/// let d_guard = e.d.lock(); // no interrupt state change, +1 interrupt disable refcount
> +///
> +/// assert_eq!(c_guard.a, 0);
> +/// assert_eq!(c_guard.b, 10);
> +/// assert_eq!(d_guard.a, 20);
> +/// assert_eq!(d_guard.b, 30);
> +///
> +/// drop(c_guard); // Dropping c_guard will not re-enable interrupts just yet, since d_guard is
> +///                // still in scope.
> +/// drop(d_guard); // Last interrupt disable reference dropped here, so interrupts are re-enabled
> +///                // now
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// [`lock()`]: SpinLockIrq::lock
> +/// [`lock_with()`]: SpinLockIrq::lock_with
> +pub type SpinLockIrq<T> = super::Lock<T, SpinLockIrqBackend>;


