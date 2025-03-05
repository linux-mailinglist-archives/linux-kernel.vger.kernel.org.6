Return-Path: <linux-kernel+bounces-546574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D00A4FC58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF67F16EC31
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF21A20B207;
	Wed,  5 Mar 2025 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0NyxESs"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45213207A37
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170988; cv=none; b=NqX61NrCBlmTEZu83FId/yczmg5DSIXFGomIMNBDJho34JdVjh/GJ8SoGJGx+EbjK0Sjv9DC/Te/S2I6z1kFZygZwA2elW/Xej7DeEFW4/79Oz/ZOU1Z6CbZ1PULbGblAlmtQEYag1mvrDf7x9BgOwNxNJ+esBlVi/Nz3JtDNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170988; c=relaxed/simple;
	bh=IITPjUf5K6GkczqGdtj2h9Gn0v+t6QxnZUdZm9Ju+nA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k1H+gz0tcN7bBMS/EYvCLlXX4h9QDnX2e5PZJOUTNxZHOUAx1MeNDKAjT0jWAKSf0CS6Sx6k5cbXocFwWabp94+22zINMzQJkgtk+zb5cG9jsXyErZOoDX5ab+Ztd4JySOcKgFmRKOn3tf/iM7X9P1UGudjNQe00ADK7cN1+gbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0NyxESs; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bcc04d2ebso13254915e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 02:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741170984; x=1741775784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwAGkOur7FEFFxYryhuBZi0B3fdJNiM+Y5CHrkG/U3c=;
        b=Y0NyxESs/G3nRWAENTKk/t3HpSSagzE1cbXVedZsHisKLetB0xonuhSnBjOcUDKaBs
         yBqrYb8qAKmNPcQT6D18vj92ku12j7Qvepxh1Pd1P4mmS64ZKJowlW17+SwyUwU53BDl
         /0LZMMrOVJAw4fkY2MjVtTUwv4ZzeE2SCak2LIJ/8xW6Rffu0+fhKaHLND38DqS6UfeP
         oWpDKrsDfpOesUCKeL4kkYjiOnGaf3Wqz1oOYnicdPLQvsv/WYiVx0e1yfnWQk+TYfy2
         Mwk9QjEHVBhjz1HOM1k8uCj3VAfTehqCy8rNzkGYKKmoUI2njKE05nyzbEUlihK1H/uQ
         ljWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170984; x=1741775784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwAGkOur7FEFFxYryhuBZi0B3fdJNiM+Y5CHrkG/U3c=;
        b=AWrPKhkPvsPPtGbxsOvE+Yzm3f3RUcYEqXUwpRYZezJYf4i05B7O6H5z1LUp7gUOiH
         hhLLsD5grTOi8nVxXWY3uIJMPV/scCvUCJ2cdVUM2IGXXjFaI9i8Sov3iTO95Cp5yxY0
         g7GHF7OiHJ18hEYoaU60PEx6DpRSUVg1wUHME4GtM7kIUM1YlgcjvNKizWB3tsFkQBHr
         VgfASWfZKvvrirZZNUg1wLtUtCWjMmXviCRpMGmsey5evBTDWJZhCO9lklpq30FVIUlA
         WAxJt/En+PlsukAj5rHpKKIWb2jrTvrN1J1Np8F1LAMj7goE1s4VmQIXdRPh69+e75mX
         ZIaA==
X-Gm-Message-State: AOJu0YyzX+rlZyXSlG3B1O2yiaP9S45I21cHtyHgWGnU76NldpVF/IQj
	NxA/+eMn+Dphny4q8FeGhhQyFwSraGXuKySSoXy9d+V9Elvy35T2yALMutHeE2edfHGhPHrwxfT
	momDkxCY7nNQXwg==
X-Google-Smtp-Source: AGHT+IF4p+WGtfI1ypZ1YJkfslZJU6mygbMMyIKJy0w0qOVB2Gh6dAbB+kwJwMv93DtfV/Rfk/Pmmkxz4x/UHTU=
X-Received: from wmrn38.prod.google.com ([2002:a05:600c:5026:b0:43b:c7b3:c586])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b17:b0:43b:cf12:2ca1 with SMTP id 5b1f17b1804b1-43bd2969470mr21132275e9.10.1741170984586;
 Wed, 05 Mar 2025 02:36:24 -0800 (PST)
Date: Wed, 5 Mar 2025 10:36:22 +0000
In-Reply-To: <20250305.192403.996225631653343672.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213135759.190006-1-fujita.tomonori@gmail.com>
 <20250213135759.190006-6-fujita.tomonori@gmail.com> <Z8gOkeJ8o2pMCwGu@google.com>
 <20250305.192403.996225631653343672.fujita.tomonori@gmail.com>
Message-ID: <Z8gpJsQlkjAQ0EwU@google.com>
Subject: Re: [PATCH v3 5/5] rust: Add warn_on and warn_on_once
From: Alice Ryhl <aliceryhl@google.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	x86@kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, peterz@infradead.org, hpa@zytor.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org, 
	kernel@xen0n.name, tangyouling@loongson.cn, hejinyang@loongson.cn, 
	yangtiezhu@loongson.cn, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 05, 2025 at 07:24:03PM +0900, FUJITA Tomonori wrote:
> On Wed, 5 Mar 2025 08:42:57 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
> > On Thu, Feb 13, 2025 at 10:57:59PM +0900, FUJITA Tomonori wrote:
> >> Add warn_on and warn_on_once macros. Wrapping the C's WARN_* and BUG_*
> >> macros doesn't work so this uses the assembly code exported by the C
> >> side via ARCH_WARN_ASM macro. Like the static branch code, this
> >> generates the assembly code for rust at compile time by using the C
> >> preprocessor.
> >> 
> >> file()! macro doesn't work for the Rust inline assembly in the same
> >> way as __FILE__ for the C inline assembly. So the code to handle a
> >> file name is different from the C assembly code (similar to the
> >> arm64/loongarch assembly).
> > 
> > Nit: Should be file!() not file()!.
> 
> Ops, thanks.
> 
> Actually, the above comment is obsolete. With your solution in the
> previous mail, I can remove the asm code for the file name. I'll
> remove the comment.
> 
> 
> >> diff --git a/rust/kernel/.gitignore b/rust/kernel/.gitignore
> >> index 6ba39a178f30..f1d7f4225332 100644
> >> --- a/rust/kernel/.gitignore
> >> +++ b/rust/kernel/.gitignore
> >> @@ -1,3 +1,5 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  
> >>  /generated_arch_static_branch_asm.rs
> >> +/generated_arch_warn_asm.rs
> >> +/generated_arch_reachable_asm.rs
> >> \ No newline at end of file
> > 
> > There should be a newline.
> 
> Ah, I'll fix.
> 
> >> +++ b/rust/kernel/bug.rs
> >> @@ -0,0 +1,100 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +// Copyright (C) 2024 FUJITA Tomonori
> > 
> > 2025?
> 
> I'll add.
> 
> >> +#[macro_export]
> >> +#[doc(hidden)]
> >> +#[cfg(all(CONFIG_BUG, not(CONFIG_UML)))]
> >> +macro_rules! warn_flags {
> >> +    ($flags:expr) => {
> >> +        const FLAGS: u32 = $crate::bindings::BUGFLAG_WARNING | $flags;
> >> +        // SAFETY: Just an FFI call.
> >> +        #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
> >> +        unsafe {
> >> +            $crate::asm!(concat!(
> >> +                "/* {size} */",
> >> +                ".pushsection .rodata.str1.1, \"aMS\",@progbits, 1\n",
> >> +                "111:\t .string ", "\"", file!(), "\"\n",
> >> +                ".popsection\n",
> >> +                include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm.rs")),
> >> +                include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_reachable_asm.rs")));
> >> +            line = const line!(),
> >> +            flags = const FLAGS,
> >> +            size = const ::core::mem::size_of::<$crate::bindings::bug_entry>(),
> >> +            );
> >> +        }
> >> +        // SAFETY: Just an FFI call.
> >> +        #[cfg(not(CONFIG_DEBUG_BUGVERBOSE))]
> >> +        unsafe {
> >> +            $crate::asm!(
> >> +            concat!(
> >> +                "/* {size} */",
> >> +                include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm.rs")),
> >> +                include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_reachable_asm.rs")));
> >> +            flags = const FLAGS,
> >> +            size = const ::core::mem::size_of::<$crate::bindings::bug_entry>(),
> >> +            );
> >> +        }
> > 
> > I generally prefer to have the cfgs on the macro rather in its
> > expansion. That avoids emitting a lot of code that is not actually used.
> 
> You prefer the following?
> 
> #[cfg(all(CONFIG_BUG, CONFIG_DEBUG_BUGVERBOSE, not(CONFIG_UML)))]
> macro_rules! warn_flags {
> ...
> }
> 
> #[cfg(all(CONFIG_BUG, not(CONFIG_DEBUG_BUGVERBOSE), not(CONFIG_UML)))]
> macro_rules! warn_flags {
> ...
> }

In this case it probably reads better as

#[cfg(all(CONFIG_BUG, not(CONFIG_UML)))]
#[cfg(CONFIG_DEBUG_BUGVERBOSE)]
macro_rules! warn_flags {
...
}

#[cfg(all(CONFIG_BUG, not(CONFIG_UML)))]
#[cfg(not(CONFIG_DEBUG_BUGVERBOSE))]
macro_rules! warn_flags {
...
}

but yes.

> >> +#[doc(hidden)]
> >> +#[macro_export]
> >> +macro_rules! bugflag_taint {
> >> +    ($taint:expr) => {
> >> +        $taint << 8
> >> +    };
> >> +}
> > 
> > This could just be a const fn.
> 
> Yeah, would a const fn be preferable?

Yes, I think a constant or const fn is preferable over a macro whenever
possible.

> >> +/// Report a warning only once.
> >> +#[macro_export]
> >> +macro_rules! warn_on_once {
> >> +    ($cond:expr) => {
> >> +        if $cond {
> >> +            $crate::warn_flags!(
> >> +                $crate::bindings::BUGFLAG_ONCE
> >> +                    | $crate::bugflag_taint!($crate::bindings::TAINT_WARN)
> > 
> > Or maybe a constant?
> > 
> > const WARN_ON_ONCE_FLAGS: u32 = bindings::BUGFLAG_ONCE | (bindings::TAINT_WARN << 8);
> 
> Ok, but you prefer "<< 8" than using const fn bugflag_taint()?

I'm also happy with
const WARN_ON_ONCE_FLAGS: u32 = bindings::BUGFLAG_ONCE | bugflag_taint(bindings::TAINT_WARN);

Up to you.

Alice

