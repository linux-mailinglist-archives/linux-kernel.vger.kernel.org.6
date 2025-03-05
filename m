Return-Path: <linux-kernel+bounces-546533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05514A4FBD2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788917A8B65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB8C2063F3;
	Wed,  5 Mar 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2Zr/gg5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FEF205AB0;
	Wed,  5 Mar 2025 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170253; cv=none; b=ut+4taCy6I0HbM0RivIDGCCL/XT5riFBvJzSgKMFD7ars4SVxX48SR6FRIUxomjZ3QDR7Qoep1qTCZTZit9dinN8RYYLSf2Pm2Kbpc1kOlmYeF4E2Z1MD+TNYTEMW6UzbDM5LtL6aNv4Rt86Fr/bkE2mHxKOvH2mh4py8zxj6Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170253; c=relaxed/simple;
	bh=rpJFe0wOfuGvVfafJ6fYA8p3MFl5W10FP6UIBHcWyxc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MR981brjQlakpkBFABuNhDi+CwVpxZWXuvwOTMkIdeVxCJRLVVCb46ug+zTs7NGWp9MPitFrCfAhWoMZA2PoK9aTIlXmL8weWsSpLaWR+7k28JMo4cpuFlHlOrrb+14xpiTRSLf+XH49od8OhozCstheZXRi3HUGWVC4doB1Eo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2Zr/gg5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223959039f4so76284315ad.3;
        Wed, 05 Mar 2025 02:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170251; x=1741775051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlN/L4AefYvDeS0mxE9WdsKwZ74h8HubhxsXCuRQhvs=;
        b=l2Zr/gg5arrVkgL6VcaDMS+So4mTGNPMZAL993eMmGP3TWF4rcU9jzdP1uIGMlofy2
         AXh6IdIng/IWK3/iViIq/MVC9KsX3kWCbnqCtWWCQk9pqlo0mV5sfLwc+ZuEiHu0ZJ0N
         XWHQWyM5GAgkl4RZ5RN5CHFw9XF70tHAhZg3dVOLDqiBHVuNu5D104NaLsHyhm17CuBM
         Rm3gRvtoUuJr7enmNbu0hbxxaJC02Vq3ZBYwoPVLlElknvKj77vrlylAqnYPATcoTQ8n
         /tdGxtSDLQFqpz2VXjjJEL6JsWHpzQiadYvIeJEHhhQWwhdM7cpXGQN0zOisOksFODZd
         X+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170251; x=1741775051;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vlN/L4AefYvDeS0mxE9WdsKwZ74h8HubhxsXCuRQhvs=;
        b=si0u5+xhrVGA5KMCGdCqpDGh2UBDEvT1hE27/vUuJ/KoLFEbGdPhLk8M8T3y7ht09i
         W/czFyFmVj/Nux4w0SqabJqkhPi4g+mKEyuxzFB0SxnKE8oMOFDpIQ52LQ9UY/m7xFVN
         COHbVeN2R8UqGNhUj7qxKWLOvMtTJKpY0nWAed/BdrrzxpwV/f2YJQ2tksQnL1VRDc2O
         4ZTOqHcnBVbvDeJJRqt1hTAqkiYrFsXvGlpaX1ncCD/3hVvVYXmo/s7tDmCvVUMBzSOA
         QXvalFsEz8stMX8ggooE6RoGyFgny/Aw55zlvcCv+k3+2l75D1A+vUjtc5YeFoDWfOgP
         MaEg==
X-Forwarded-Encrypted: i=1; AJvYcCVj1H+YO3LuhRm0N9M748qMT23RjxWlV3ctY3JdHNSYXX4EF5Y5rA8U6EhltcFX7qDeUaWWNatp3Eq6AXqZgYc=@vger.kernel.org, AJvYcCVte1Ni0NE2swFVerwAeXAANolUf2g1HiegYFZOdyndap3CA2gHD6je+pTz4DmknKTkeRWMyzTQCjGPLTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLnNvS4t+llMgbvAx1B45dAVChYuGahn5y3sjvbkl0lQclV6dk
	w5TUGLZ0bC2WAQjeQGg7IIyV96uMjcX+Y4bb6G4RDbsFvBlUiYLx
X-Gm-Gg: ASbGncs3Zow1/KodQ5Q37oxHpsShXIllzJeuEhHES07YjD7Pu7dRe9h8Y2Pes/ZY2vu
	RVo/i5xfF7E3mzr0vXBxPtPa6WZOdzrz9RsTh5lS6+DS3iTIhQqdrJoCPDDfxFAqZS7Kq3ngJUt
	mUiq+VIOnR4fX1Fm8ECqxa4VVoXUHPNC8B8mVbph2ThzI0PNUS+EjQ9PU5gYHP8gsIEOp7lFmQ/
	VUZ4HDomI3Fe/7LLYVsIKovOt54jwE18QYjUhjTGjbjxdlkWW86pYVRDOPCqofZwOOIKAllM3FT
	/F2CLBRzvNeM2CndsD2EVIdttW8VMP/+UiNblEq3zEQ/MBNXY9Vrg1qXvGC8P6AnaTPKq/ZWvM9
	NbqBVVMKpVXu53+oDcxl4gg0gYng=
X-Google-Smtp-Source: AGHT+IGsFQfHQjvkNE241Y4wnmDmNDBQSHQivxyIM52U3bSLm+KCunMmDVV2E0sVtyiSSMpJSKWLRA==
X-Received: by 2002:a17:902:d2c1:b0:220:fb23:48df with SMTP id d9443c01a7336-223f1cf320amr40589935ad.36.1741170250886;
        Wed, 05 Mar 2025 02:24:10 -0800 (PST)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d4e9fsm110731105ad.28.2025.03.05.02.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:24:10 -0800 (PST)
Date: Wed, 05 Mar 2025 19:24:03 +0900 (JST)
Message-Id: <20250305.192403.996225631653343672.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
 hpa@zytor.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, tangyouling@loongson.cn,
 hejinyang@loongson.cn, yangtiezhu@loongson.cn, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
 tmgross@umich.edu
Subject: Re: [PATCH v3 5/5] rust: Add warn_on and warn_on_once
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Z8gOkeJ8o2pMCwGu@google.com>
References: <20250213135759.190006-1-fujita.tomonori@gmail.com>
	<20250213135759.190006-6-fujita.tomonori@gmail.com>
	<Z8gOkeJ8o2pMCwGu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 08:42:57 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Thu, Feb 13, 2025 at 10:57:59PM +0900, FUJITA Tomonori wrote:
>> Add warn_on and warn_on_once macros. Wrapping the C's WARN_* and BUG_*
>> macros doesn't work so this uses the assembly code exported by the C
>> side via ARCH_WARN_ASM macro. Like the static branch code, this
>> generates the assembly code for rust at compile time by using the C
>> preprocessor.
>> 
>> file()! macro doesn't work for the Rust inline assembly in the same
>> way as __FILE__ for the C inline assembly. So the code to handle a
>> file name is different from the C assembly code (similar to the
>> arm64/loongarch assembly).
> 
> Nit: Should be file!() not file()!.

Ops, thanks.

Actually, the above comment is obsolete. With your solution in the
previous mail, I can remove the asm code for the file name. I'll
remove the comment.


>> diff --git a/rust/kernel/.gitignore b/rust/kernel/.gitignore
>> index 6ba39a178f30..f1d7f4225332 100644
>> --- a/rust/kernel/.gitignore
>> +++ b/rust/kernel/.gitignore
>> @@ -1,3 +1,5 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>>  /generated_arch_static_branch_asm.rs
>> +/generated_arch_warn_asm.rs
>> +/generated_arch_reachable_asm.rs
>> \ No newline at end of file
> 
> There should be a newline.

Ah, I'll fix.

>> +++ b/rust/kernel/bug.rs
>> @@ -0,0 +1,100 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +// Copyright (C) 2024 FUJITA Tomonori
> 
> 2025?

I'll add.

>> +#[macro_export]
>> +#[doc(hidden)]
>> +#[cfg(all(CONFIG_BUG, not(CONFIG_UML)))]
>> +macro_rules! warn_flags {
>> +    ($flags:expr) => {
>> +        const FLAGS: u32 = $crate::bindings::BUGFLAG_WARNING | $flags;
>> +        // SAFETY: Just an FFI call.
>> +        #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
>> +        unsafe {
>> +            $crate::asm!(concat!(
>> +                "/* {size} */",
>> +                ".pushsection .rodata.str1.1, \"aMS\",@progbits, 1\n",
>> +                "111:\t .string ", "\"", file!(), "\"\n",
>> +                ".popsection\n",
>> +                include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm.rs")),
>> +                include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_reachable_asm.rs")));
>> +            line = const line!(),
>> +            flags = const FLAGS,
>> +            size = const ::core::mem::size_of::<$crate::bindings::bug_entry>(),
>> +            );
>> +        }
>> +        // SAFETY: Just an FFI call.
>> +        #[cfg(not(CONFIG_DEBUG_BUGVERBOSE))]
>> +        unsafe {
>> +            $crate::asm!(
>> +            concat!(
>> +                "/* {size} */",
>> +                include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm.rs")),
>> +                include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_reachable_asm.rs")));
>> +            flags = const FLAGS,
>> +            size = const ::core::mem::size_of::<$crate::bindings::bug_entry>(),
>> +            );
>> +        }
> 
> I generally prefer to have the cfgs on the macro rather in its
> expansion. That avoids emitting a lot of code that is not actually used.

You prefer the following?

#[cfg(all(CONFIG_BUG, CONFIG_DEBUG_BUGVERBOSE, not(CONFIG_UML)))]
macro_rules! warn_flags {
...
}

#[cfg(all(CONFIG_BUG, not(CONFIG_DEBUG_BUGVERBOSE), not(CONFIG_UML)))]
macro_rules! warn_flags {
...
}

>> +#[doc(hidden)]
>> +#[macro_export]
>> +macro_rules! bugflag_taint {
>> +    ($taint:expr) => {
>> +        $taint << 8
>> +    };
>> +}
> 
> This could just be a const fn.

Yeah, would a const fn be preferable?

>> +/// Report a warning only once.
>> +#[macro_export]
>> +macro_rules! warn_on_once {
>> +    ($cond:expr) => {
>> +        if $cond {
>> +            $crate::warn_flags!(
>> +                $crate::bindings::BUGFLAG_ONCE
>> +                    | $crate::bugflag_taint!($crate::bindings::TAINT_WARN)
> 
> Or maybe a constant?
> 
> const WARN_ON_ONCE_FLAGS: u32 = bindings::BUGFLAG_ONCE | (bindings::TAINT_WARN << 8);

Ok, but you prefer "<< 8" than using const fn bugflag_taint()?

> $crate::warn_flags!($crate::bug::WARN_ON_ONCE_FLAGS);

