Return-Path: <linux-kernel+bounces-394538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44619BB0B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7241F212E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F841B0F19;
	Mon,  4 Nov 2024 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JBdTG2CD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64DA1B0F02
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715251; cv=none; b=hOFX5p1brI/+Kdphvmx6AFh7dwSGhvj07wQ8N7C8zTKvyDX+vm8plE/GHQR3b1ySuueeBgcn4JUyLJ7RjimWVJAPY+74nDzhxkOmYMLLlowFgw3rMDzFjXjEnusDIiLxfpRY6c+pW8Za6t/pOOSTmqY5EzL9JYshy3gW9uC0kdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715251; c=relaxed/simple;
	bh=1ZD8l+C1EuzgucsrrDGFXbeA8HL3duQOdkk9LUjOOuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZDI924aMUingp8ogFrFNy0UfkvqVrdjkIb/kIeNUCocEXMGD8urrMIC8TGemsSHjLWJnkQH98c6U6F4HSY5I4cEO5NR22l21D5dqeN3ybKand0TTzLE4dGhX6FL18Qwtx2RQUG/LC34fP+INSYXZ6iKrd4dXmjxyOo0OFPKijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JBdTG2CD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e7e73740so1468611e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730715246; x=1731320046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c7jIDPXYCos97zH52V3Rx0a/Pe9j9klHJ/m3x5c878=;
        b=JBdTG2CDsTk3bs7k7oFyMLdFf3h6mEPrlfvF8A+EXatQWii5XOEqByNOKFyzpNXT7A
         gUc9w104s2pnumvfOHiGIz75TL/gkko1HsQT1BM/+uKKoIThYAg3eezlW7C4aqmgm+5O
         YvqUaxNq5wTbcdLXVT3Cg0TKrZtZqnNyO+04V+TuwFLDr451GZ1xtm9MP6IpwWnXsqZq
         I5cnC26we+v3aXyQ2613FQEoPfnMlBtwjnnZGAl/OGSjD8jdN19wuyYqeeWJ4dGKU+x/
         eEpTHJNfuq+tTdJ3gUf2gqg/BG6AgbNanpmapup9zElD/2Doz3bbECi2eT0x1jo+nOKY
         1usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730715246; x=1731320046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4c7jIDPXYCos97zH52V3Rx0a/Pe9j9klHJ/m3x5c878=;
        b=gRGLsmr+uZTjP9hMTmeYX/AVP9JGb0zCsyplUVWQ8VrDHT/3dtbP9MmD5pdzI9xtg9
         v3BgtdTyWZPYHWyAycUHuNfChmTQoCz8zZdbZv+pGgYj5YC8u4Fc3TRYZXdPAU2OOnG2
         TUhFXZK2PI26JP/CgJt3EzppJlI725AibUgaiwBXHTsWrXv0idkJSZi5Pyf/LM0uMwMm
         FalVF1SWa51a0hjpl9HKsERRQ2DRW+5alYJnJpyIPBPRAxxqa6VSD+OcW8EPAtzASt6b
         Qu31SC4McGsGY87vKsMwz0br9KuI6do3GWnEbevIInSBm5hsaBBdX6oMUu5/JmOXgt7Z
         FoTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHYDjL8rgQbpTpfVqtoio6vHWNshiX39CYoD7N1h79ePuUnyKDPmbQLbAMKs9UJ2hpO9X2A5gAhghA7KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIVAAY3TDKm7ZilnYrIvaZV17jBGz/6CQX+nqBrj1VkHLFEJ4
	+IwqkO3WflC4mr5bqFZRaM9JC5tqPs9vUTVj4zHXeIUGyTyfByDN+RfDzuBbVtNq5Z26uXEDVJC
	dq935ZIYpl9B6OlGpR+3KgXWDZf//va9sLvGj
X-Google-Smtp-Source: AGHT+IF3YrSYDNpUh7K6DP1BrHft72F43XaFavJhNPR1z+HcVXMbGOoX4JuofOBYs8pgr4OQ7WmvjdXbt+mvTRqeQfM=
X-Received: by 2002:a05:6512:3041:b0:539:e6bf:ca97 with SMTP id
 2adb3069b0e04-53b7ecf28d7mr10644101e87.32.1730715245823; Mon, 04 Nov 2024
 02:14:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-tracepoint-v12-3-eec7f0f8ad22@google.com> <202411021421.jZ0FSDq6-lkp@intel.com>
In-Reply-To: <202411021421.jZ0FSDq6-lkp@intel.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 4 Nov 2024 11:13:53 +0100
Message-ID: <CAH5fLgjOxfKR+HE9KZRCuBGVW26adM=r4AxSCJ2B-G2eG_4FzA@mail.gmail.com>
Subject: Re: [PATCH v12 3/5] rust: samples: add tracepoint to Rust sample
To: kernel test robot <lkp@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 8:08=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Alice,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on eb887c4567d1b0e7684c026fe7df44afa96589e6]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Alice-Ryhl/rust-ad=
d-static_branch_unlikely-for-static_key_false/20241031-000709
> base:   eb887c4567d1b0e7684c026fe7df44afa96589e6
> patch link:    https://lore.kernel.org/r/20241030-tracepoint-v12-3-eec7f0=
f8ad22%40google.com
> patch subject: [PATCH v12 3/5] rust: samples: add tracepoint to Rust samp=
le
> config: x86_64-randconfig-103-20241101 (https://download.01.org/0day-ci/a=
rchive/20241102/202411021421.jZ0FSDq6-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51=
eccf88f5321e7c60591c5546b254b6afab99)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241102/202411021421.jZ0FSDq6-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411021421.jZ0FSDq6-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> error[E0425]: cannot find value `__tracepoint_rust_sample_loaded` in c=
rate `$crate::bindings`
>    --> samples/rust/rust_print.rs:87:5
>    |
>    87 | /     kernel::declare_trace! {
>    88 | |         /// # Safety
>    89 | |         ///
>    90 | |         /// Always safe to call.
>    91 | |         unsafe fn rust_sample_loaded(magic: c_int);
>    92 | |     }
>    | |_____^ not found in `$crate::bindings`
>    |
>    =3D note: this error originates in the macro `kernel::declare_trace` (=
in Nightly builds, run with -Z macro-backtrace for more info)
> --
> >> error[E0425]: cannot find function `rust_do_trace_rust_sample_loaded` =
in crate `$crate::bindings`
>    --> samples/rust/rust_print.rs:87:5
>    |
>    87 | /     kernel::declare_trace! {
>    88 | |         /// # Safety
>    89 | |         ///
>    90 | |         /// Always safe to call.
>    91 | |         unsafe fn rust_sample_loaded(magic: c_int);
>    92 | |     }
>    | |_____^ not found in `$crate::bindings`
>    |
>    =3D note: this error originates in the macro `kernel::declare_trace` (=
in Nightly builds, run with -Z macro-backtrace for more info)

This bot is using a buggy bindgen. Please see
https://lore.kernel.org/all/20241030-bindgen-libclang-warn-v1-1-3a7ba9fedcf=
e@google.com/
which was also mentioned in the cover letter.

Alice

