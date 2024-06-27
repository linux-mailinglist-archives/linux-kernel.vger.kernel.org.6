Return-Path: <linux-kernel+bounces-232018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A38891A195
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D392828199D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FB380031;
	Thu, 27 Jun 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBKHC1G3"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66552F6F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477295; cv=none; b=a1jvfhtturruaJP9zDkV7We+W8X13NYDZCKN8wCHVTBOuohL83d1h1PMYUzfnXRDQk3+wSE8/CSj8u433BQIZ7bqslCE3pR9eRuUWNutww6idB8YpVklVCO44dPGgOkgAD5cY3qrN375I245LyBGRLs7XzPZDRdRRnb1meGzDcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477295; c=relaxed/simple;
	bh=jaHYq9qHI0Bww45jO0JOW2KKMuvYkD8u1X20gL+6tFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8pBsxn0O+Naq/4Wg57rmfB2iVUb7rqKyr2KkVckWs6sakaTaVJp/BkGTEF3GeDSDgeKJfXRivo94kZ56AEWQRJrLvgJc/Z89bjGDbNrgeOiAbIzk4PrnpC2/6PepPfyIX5jnfXWG5MEP55VCQu/eNgKvg5jtnUlXhqKOeMaO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBKHC1G3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cd6784aa4so7181150e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719477292; x=1720082092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaHYq9qHI0Bww45jO0JOW2KKMuvYkD8u1X20gL+6tFY=;
        b=sBKHC1G38EbA059ElZrKTQeMlO191hpU47ANsgBmKqq9qONr1eB0gqDDW2vRQP5pJk
         Guzj6LYgeKtMUSnlV4Y+gELko9XiyVOSLtxRgTCXrqKkfJIT8Pj6LJz3lrdxygHx5f3A
         luJtMdb/JxG3gJ0zxILNjbjvmy0MSDJQoDKH30unsHJn+Dy2XoVCCThmTNWcsdiYeXfr
         4EDiW1CSdHW41iCApoWEv/75giSjRty763c2q4sG9/xuMctqkeiGnLNvVJm7puAB0SoT
         OqnOLnBd+Oe0B5uzz+jjmzzuYgm/QJG5iK4Wwg71XanGZttaRqc+STbeBI+ao1myOVhV
         SHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719477292; x=1720082092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaHYq9qHI0Bww45jO0JOW2KKMuvYkD8u1X20gL+6tFY=;
        b=B8DuXDDv6VAmqaQC8MLlvJey+F41rKEDY8Bl4P6GPiqoZTG81L9LwmVNuxXdO/WYkh
         2juPPLFUx9SilFHDEsTYDtexWSriImb0ze9dONDE3L/gHCyc2As6VS6hT3NyWQnXHxc3
         EPwg7q2O1RA3n3wjBhRQYRsM4RMFLp3H/KE7nTW8E2F+tYfvJ4YwSwBBN4tcMyT7JeOS
         XHp1N+74T30LZ3Vnn4z7/xQRIqTYpGhxN3E/hLPDSgY1+UASMfZIdy+b2mB3kkt+wGOV
         mpSY8P8qXQW7mxJY6j1KSVSW1UD+8vUH1Yk0E848XnYaasjz8yeP8yueNOC2nBRNjXp9
         BVSw==
X-Forwarded-Encrypted: i=1; AJvYcCXXHRovJU3fdpeQeefzZisY142YezpgydvvuD7Bk8cwYfkailDjEkdLpUQxW6e+2BVUUSmDPbITxxpzexEPWbjXWgo0UlrljoMghZ0u
X-Gm-Message-State: AOJu0YzxXXRaJZTxLkpJN/kuKYxewS6dhebyafD+etarlzFHfOqmBO90
	yF2z95kU+X/geKwPn1c4KKNTSQ/98NXoi9XDGtoIyyXvEu5ad6quJHgEQQBwcbS+45Y2LsMmo3c
	yTh8OqLj6IzUbxrYO+2CYfdEZRWT3GTDav6QF
X-Google-Smtp-Source: AGHT+IHlfk5WkDZhxtSr6xoYbVkipq/AGMIGI9Dxm9ats0II6c5lJlSMjq4hKwrgepsNKkozKV3mIVOymMLBYvUkPo4=
X-Received: by 2002:a05:6512:203b:b0:52c:df55:e112 with SMTP id
 2adb3069b0e04-52ce1832119mr6963173e87.6.1719477291466; Thu, 27 Jun 2024
 01:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com>
 <20240621-tracepoint-v3-1-9e44eeea2b85@google.com> <ZnrtuaUByT70tJY5@boqun-archlinux>
In-Reply-To: <ZnrtuaUByT70tJY5@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 27 Jun 2024 10:34:39 +0200
Message-ID: <CAH5fLgjCAbz39-8EzBxxrWFXFg6VK=ts98BBvpEk8=RZoMuBSA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rust: add static_key_false
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradaed.org>, 
	Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 6:18=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Hi Alice,
>
> On Fri, Jun 21, 2024 at 10:35:26AM +0000, Alice Ryhl wrote:
> > Add just enough support for static key so that we can use it from
> > tracepoints. Tracepoints rely on `static_key_false` even though it is
> > deprecated, so we add the same functionality to Rust.
> >
> > It is not possible to use the existing C implementation of
> > arch_static_branch because it passes the argument `key` to inline
> > assembly as an 'i' parameter, so any attempt to add a C helper for this
> > function will fail to compile because the value of `key` must be known
> > at compile-time.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> [Add linux-arch, and related arch maintainers Cced]
>
> Since inline asms are touched here, please consider copying linux-arch
> and arch maintainers next time ;-)

Will do.

> For x86_64 and arm64 bits:
>
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
>
> One thing though, we should split the arch-specific impls into different
> files, for example: rust/kernel/arch/arm64.rs or rust/arch/arm64.rs.
> That'll be easier for arch maintainers to watch the Rust changes related
> to a particular architecture.

Is that how you would prefer to name these files? You don't want
static_key somewhere in the filename?

> Another thought is that, could you implement an arch_static_branch!()
> (instead of _static_key_false!()) and use it for static_key_false!()
> similar to what we have in C? The benefit is that at least for myself
> it'll be easier to compare the implementation between C and Rust.

I can try to include that.

Alice

