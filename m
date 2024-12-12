Return-Path: <linux-kernel+bounces-442501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B62939EDD85
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 03:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1F61888CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA49313BADF;
	Thu, 12 Dec 2024 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/Vuszc5"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674F7DA8C;
	Thu, 12 Dec 2024 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969924; cv=none; b=TBIS/CpWyCXk+BmX5PeAX0lX/OkQyae3DCfRVIu2ME5QKsgN4v9A63ZbNGcNrro6VOu9gjjd1J/NNNbm/gXDndrUfgcyqS+JYgK+ZeRjU+1oqPsRwv9R5CGcrYauMeZ2UyP82o0f18sEtHDEI9oHmfDG0id/dYV5+/eR/LXJIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969924; c=relaxed/simple;
	bh=1cTM3LwGI+0flNcl0+4rI+EB1o9GyLuExi3gE7uPYYw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ix776GBv5YmDbK046X3vw/eFs/0VZNbxe5sO/vty9Mjw+Bj9NjZGFOU8n3PwgAMiqUQwLaQPdg2kkRMHRVs+L2pp4+Ba53pIBYic1QVKqIV9J7hq+ey6BdBAOwvoTYCGhQDg80WMU23JKazWK0MVMsDsRjL7wNQkJvzywvTVmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/Vuszc5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725dac69699so104342b3a.0;
        Wed, 11 Dec 2024 18:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733969922; x=1734574722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQvLLQO2Dcgk3hcePdj0knsnbyn081D+yRxJJ0jbm94=;
        b=i/Vuszc5D3VEM9vVuTWHDb9kd1R/P3SF2uZ94RE0K2gSD8kTmpJsuF+xz1AQTDT22P
         p2S5Q44ViIjX+5n9eH/ehip81cT65SPeBF3Pci/go4SiS4gzkiN6/HH7hJCg39gMdeXs
         H8YUQ77KLGoIB5YTtUq3EVcQqPnKCx4WOiRq2BgFisOsmNfrWONWf+BKoJSEYt1zka4c
         nvNuP5Uedy6A06qvfbXTuYJ7gK4yiMPPtZ0Xbc4C0g6DrFS79ODVXUU5jXEduVGpIzwd
         J6JssuMFe++VhBN7z3yyAlgVjKBIfKZ+JZjJo4mjWpP2wbzLGeo89VxlLwrTXHs8BcoU
         HCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733969922; x=1734574722;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQvLLQO2Dcgk3hcePdj0knsnbyn081D+yRxJJ0jbm94=;
        b=ckRdodVg85JLboepKWoe03BmdFt+SHUdJzeCkitRy9TTGlWhVZH4R/IxSFGhj5BVQ8
         rApOHwkT4n+R/nZ4+2Z86gwKYx1ucrb/uYjBodcyx3UHiH/Olwf9wDMwlootGcoxP+B1
         wUxo1Ql/f/RtsrLdxEygsVt/8yfbbq8Eii4LFNQphqMHk3HjFwGNayteOfBZKFbO9ew4
         p81r/72sKG1AhZc4riGkZf2PLpcRKGJrO7YZYy317ZfOwR3F63z8x25g/9acJcqDYLx5
         X5xnkKLpdo6r7gOwSBXZNGWc3xLuAli5mgBPpIyE4oZ+mPu6yrz+Tw14wIEcl3KvKLCF
         tlUA==
X-Forwarded-Encrypted: i=1; AJvYcCW+PfAIHR/0qBygWTfj7s+Mm+e2oUAhW9B8FJNCsYjurEVOrKKAdPx/GZPUEuyiWQBb8IZYm+BeL0WcgUG/Z3o=@vger.kernel.org, AJvYcCXRZZQB7GvFaty4MR0sIp/oLLs2u4Y3f+do9FdZGVTWkIeGsv1jHVFcTvmBhGLE5aBI+WPzTQCd+lW/71Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxclGs0dGZ3uIKax9J9OBnoYB4WN+sbqi1c3BpyrROR67Qb6fkx
	igOrHhv86QSvydSqksphHrcSqYS4BgmapGzwVgH43ju6KErAeK1+
X-Gm-Gg: ASbGncvBPiUypnvzwUJRgrEJuFORbDOTtwLbT+zX1qfYTuRRM1//i/nSu6PWmDPhCzK
	8YN5W0bds1r2mR06m2kVvJwR9GPysft/xTFj07nZMqYINEKfXwHrzjXjoP0dJ0NV+HDcI2lTEvv
	OPw14k5IWCgqf/UoXSLyzrgozK3DeSZdbgtJ/cmLSVi54VZF9ghOQBoL/m+is+wYM+sCFy/pQRl
	FWxcUTO8cnSGvTp2Lev3+6lS/7xInglsyf6S8PIr80jMU0s0Kt5SOYHI8ugr6Khh8j7RP5NEiRc
	qVXre/iHqRRma9b0Q9qH8Pgh23cobVFFs3/n
X-Google-Smtp-Source: AGHT+IGZbwuLBjXASZPibFhGLGJG7cajkpWLsR5RDRJ+xwbynfB6B9HK8IIuBtNdFreyTAaUTycqxQ==
X-Received: by 2002:a05:6a20:1594:b0:1e1:a434:295e with SMTP id adf61e73a8af0-1e1cec4579fmr2405581637.43.1733969920834;
        Wed, 11 Dec 2024 18:18:40 -0800 (PST)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d16e7132sm8390441b3a.152.2024.12.11.18.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:18:40 -0800 (PST)
Date: Thu, 12 Dec 2024 11:18:22 +0900 (JST)
Message-Id: <20241212.111822.2107715832201318415.fujita.tomonori@gmail.com>
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
Subject: Re: [PATCH v1 5/5] rust: Add warn_on and warn_on_once
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgj9rBOrcQa193RpuA708CFK1ojMqhmiNWF7dbyNFPJcJA@mail.gmail.com>
References: <CAH5fLgiShKMGo6AYWM-4S8JK+iDA+tUfz9uxkns82g0nLW--NQ@mail.gmail.com>
	<20241211.094054.1429837669366274024.fujita.tomonori@gmail.com>
	<CAH5fLgj9rBOrcQa193RpuA708CFK1ojMqhmiNWF7dbyNFPJcJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 10:48:27 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

>> >> +#[macro_export]
>> >> +#[doc(hidden)]
>> >> +#[cfg(all(CONFIG_BUG, not(CONFIG_UML)))]
>> >> +#[cfg(any(target_arch = "x86_64", target_arch = "riscv64"))]
>> >
>> >> +#[macro_export]
>> >> +#[doc(hidden)]
>> >> +#[cfg(all(CONFIG_BUG, not(CONFIG_UML)))]
>> >> +#[cfg(any(target_arch = "aarch64", target_arch = "loongarch64"))]
>> >
>> > What's the reason for this arch-specific code? The file!()/line!()
>> > invocations? Could they be passed as an argument to the asm instead so
>> > that we don't need target_arch cfgs? I understand that they don't work
>> > exactly the same way, but maybe it could still work?
>>
>> Because of "error: named argument never used" in Rust inline assembly:
>>
>> All the archs define ARCH_WARN_ASM macro in the same way:
>>
>> #define ARCH_WARN_ASM(file, line, flags, size)
>>
>> However, only x86 and risc-v asm code use the size argument. Without
>> the cfgs, I'll get the following on arm64/loongarch:
>>
>> error: named argument never used
>>   --> /home/fujita/git/linux-rust/drivers/block/rnull.rs:54:9
>>    |
>> 54 |         warn_on!(true);
>>    |         ^^^^^^^^^^^^^^ named argument never used
>>    |
>>    = help: if this argument is intentionally unused, consider using it in an asm comment: `"/* {size} */"`
>>    = note: this error originates in the macro `$crate::warn_flags` which comes from the expansion of the macro `warn_on` (in Nightly builds, run with -Z macro-backtrace for more info)
>>
>>
>> Any way to make the compiler to ignore this?
> 
> The error message suggests adding an asm comment. Does that not work?

Ah, works! I didn't understand what "an asm comment" is..

> You could even add the comment unconditionally on the Rust side. It's
> not like the comment hurts on the platforms that *do* use the size
> parameter.

Yeah, I confirmed that this also works for the architectures that
do use the size.

I'll remove the target_arch cfg in v2. Thanks!

>> >> +#[macro_export]
>> >> +#[doc(hidden)]
>> >> +#[cfg(all(CONFIG_BUG, CONFIG_UML))]
>> >> +macro_rules! warn_flags {
>> >> +    ($flags:expr) => {
>> >> +        // SAFETY: Just an FFI call.
>> >> +        unsafe {
>> >> +            $crate::bindings::warn_slowpath_fmt(
>> >> +                $crate::c_str!(::core::file!()).as_ptr() as *const ::core::ffi::c_char,
>> >> +                line!() as i32,
>> >> +                $flags as u32,
>> >> +                ::core::ptr::null() as *const ::core::ffi::c_char,
>> >
>> > I wonder if this could be written to utilize Location::caller()
>> > instead so that `#[track_caller]` works?
>>
>> You meant that we could make warn_flags() function instead of macro
>> with Location::caller()?
>>
>> If so, we need to add cfgs to warn_on and warn_on_once because both macro
>> and function of warn_flags are necessary?
> 
> Well, I'm not sure! I don't know if it's feasible at all, since using
> Location::caller() would mean that the file/line is not a compile-time
> constant. But if we can, then I think #[track_caller] support would be
> nice.

I think that using Location::caller() makes the code complicated
(needs more cfgs for UML). All the callers (warn_* and bug_*) of
warn_flags and warn_flags itself must be macro for all the archs
execpt for UML. We don't want to have the UML version of all the
callers.

