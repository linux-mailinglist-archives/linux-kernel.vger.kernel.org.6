Return-Path: <linux-kernel+bounces-357822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D599768A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E6F1F23ABD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0351E1C1A;
	Wed,  9 Oct 2024 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCDArt1g"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080B13E3EF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506342; cv=none; b=joy0SHZ9st0Ggu33xezW7InnFkIoudrbDnbvOKatoVas5rI3wWP41JvUTfDCYZoMqyXPTAJ2e/MIAxVSR7zG3eR6jH/2VjBAFmp+7/vI+viHMxnbE3kjQY5bLe4mUgy2T8ttF1+bGp6kCmK34Ax4fD4ZnRg37CQ6D4N7LoUFHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506342; c=relaxed/simple;
	bh=24Xd853aY+jZmDOmHNFCjh+uRbzjFYJ47FGiLvmCXR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJr4qw6ohxUMd+36t2pY3SkQ0P6HpTLw0VznzYiM+NjrRcUkS1oB+O30Z8uqfHQxHzNVtIauKkEPLjM0ObxM4VB2+tZlS+Z3eFyY3TBw+IJbJ4b/FK09eZDRiHZSrV6ZvY082OtbE/BgGxdV42AY5BeydkbLDQUcqUQqzfMaNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCDArt1g; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43111d23e29so18585e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728506339; x=1729111139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24Xd853aY+jZmDOmHNFCjh+uRbzjFYJ47FGiLvmCXR8=;
        b=oCDArt1gYNdV9a13vQa4HCQvgjLwCAZtALRtUxbCwvki+cdhb//23R0lhygfUq1NVq
         tV5F99K8lj4D9SAcok9Xcb/GLA4rPLlpcjXQuOO4pxIU/r7m7PO78LfSQvpdMKe9qmQE
         alURkcTS0h6qiOfCyOndg56oVNRTOWJhVQKpk7KoJDFYCDy3G7LMAggKfxJV7D/kvoGx
         IsgdDtt9nKPJ1hqBc1Onf8YMqMegvcztWfM2mmgd/tJnDSqraXURLxjBiJ0ufHyXq9BH
         3bwmDyYlOtK+kR9NlpI1zovCe/aoFjO9BIS/hluT54pF0vJMFDJNJrkl4S9195HwcnnM
         oOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728506339; x=1729111139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24Xd853aY+jZmDOmHNFCjh+uRbzjFYJ47FGiLvmCXR8=;
        b=frvwguT2zHquNRLLjgJsE5yj4MZ2dQHXLkAMXWIsewaaWDk+aBWJHqKvZkKNZhB3QY
         AweYP8b4jbfBS1YYDQENP/mHeLap6kAQ+aH5lYVYj+jNPkqvaPXINTvhMquC3N5APlad
         CriKVtFcFnDKcKa0BwJwhRKGjQQe4oeojUs2dL9QhPsovdWGpQU+V5ST1W3QvSHaqh8B
         x/3M1xqd7rx9c/M9jP869nRjBvlaQECla7mMDThYyRhgf7OB9e1Vui3QROga0bFTIHib
         S0fDh+xX/ErHHhzRXw67LhRkSnf6O9bqlqWUEPTY2J4RhdRbARxN/7MT4RXBbsgXreNH
         8Krg==
X-Forwarded-Encrypted: i=1; AJvYcCVzOLo4dYbvk1UWP19xd2Qfqbr4emYaAQmEwI6bhIT5tn8r5TcTGGDSpuEOWsuh5kCsSNqPz5AgwueJO3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxilKrpbpj5Sn9YssVe3l1m9du9ExZDgqIlzZg0HtKIRXx1IjZ
	GVEnSH6UBw21sqFMMvmdjK+IOqCHX02JqjISizVc7VqIvxqkQ9zhmpmM0DC4Y91jmMpHdHwBciN
	FtXut9/q0xvnAmkMX7UdPWFaeM85POwhmLFnk
X-Google-Smtp-Source: AGHT+IFiRd5NPa6dhEU9INiaG4WU73asf6yDY1jtn0ePw13BGT5/hDMDuiIJqIgot6nffuJ3u+aDVN478IHVTZPKgBg=
X-Received: by 2002:a05:600c:4e56:b0:428:e6eb:1340 with SMTP id
 5b1f17b1804b1-431161a075bmr994475e9.4.1728506339017; Wed, 09 Oct 2024
 13:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
 <ZwbAvEnrzu6UUgGl@J2N7QTR9R3> <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
In-Reply-To: <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 9 Oct 2024 13:38:47 -0700
Message-ID: <CAGSQo03eez8pFOu54a5tW=VcL+e5VW1OVyceoh5kqQ_JBAK9Pw@mail.gmail.com>
Subject: Re: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all architectures
To: Alice Ryhl <aliceryhl@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:15=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Wed, Oct 9, 2024 at 7:43=E2=80=AFPM Mark Rutland <mark.rutland@arm.com=
> wrote:
> >
> > Hi Alice,
> >
> > On Tue, Oct 08, 2024 at 05:37:16PM +0000, Alice Ryhl wrote:
> > > The KCFI sanitizer stores the CFI tag of a function just before its
> > > machine code. However, the patchable-function-entry flag can be used =
to
> > > introduce additional nop instructions before the machine code, taking=
 up
> > > the space that normally holds the CFI tag.
> >
> > To clarify, when you say "before the machine code", do you mean when
> > NOPs are placed before the function entry point? e.g. if we compiled
> > with -fpatchable-function-entry=3DM,N where N > 0? I'll refer tho this =
as
> > "pre-function NOPs" below.
> >
> > There's an existing incompatibility between CFI and pre-function NOPs
> > for C code, because we override -fpatchable-function-entry on a
> > per-function basis (e.g. for noinstr and notrace), and we don't
> > currently have a mechanism to ensure the CFI tag is in the same place
> > regardless. This is why arm64 has CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> > depend on !CFI.
> >
> > For C code at least, just using regular -fpatchable-function-entry=3DM =
or
> > -fpatchable-function-entry=3DM,0 shouldn't change the location of the C=
FI
> > tag relative to the function entrypoint, and so should have no adverse
> > effect on CFI.
> >
> > Is Rust any different here?
>
> Ah, no it shouldn't be. Sami can you confirm?
>
> > > In this case, a backwards offset is applied to the CFI tag to move
> > > them out of the way of the nop instructions. To ensure that C and Rus=
t
> > > agree on the offset used by CFI tags, pass the
> > > -Zpatchable-function-entry to rustc whenever it is passed to the C
> > > compiler.
> >
> > As above, I suspect this isn't necessary to make CFI work, for any case
> > that works with C today, due to -fpatchable-funtion-entry being
> > overridden on a per-function basis. Are you seeing a problem in
> > practice, or was this found by inspection?
> >
> > However IIUC this will allow rust to be traced via ftrace (assuming rus=
t
> > records the instrumented locations as gcc and clang do); is that the
> > case? Assuming so, is there any ABI difference that might bite us? On
> > arm64 we require that anything marked instrumented with
> > patchable-function-entry strictly follows the AAPCS64 calling conventio=
n
> > and our ftrace trampolines save/restore the minimal set of necessary
> > registers, and I don't know how rust whether rust will behave the same
> > or e.g. use specialized calling conventions internally.
>
> Well, I was told that it's a problem and was able to trigger a failure
> on x86. I didn't manage to trigger one on arm64, but I wasn't sure
> whether that was me doing something wrong, or whether the problem only
> exists on x86. We already have the flag on x86 for FINEIBT, but I
> thought on the off chance that it's not a problem in practice on arm,
> it still doesn't hurt to add the flag.
>
> Regarding the AAPCS64 calling convention thing ... rustc uses the Rust
> calling convention for functions internally in Rust code and I don't
> know whether that changes anything relevant for what you mention.
> Matthew/Sami do you know?

tl;dr: Rust uses AAPCS64 on aarch64. It's not likely to change.

The "rust" calling convention only modifies typed argument lowering
today, not which registers are available. How typed values are lowered
onto these registers may change (has in the past and likely will in
the near future), but the actual register-set has not. It will use the
register calling convention that is default for the architecture,
which for aarch64 is AAPCS64. Technically, upstream does not make a
hard promise that "rust" calling convention functions will adhere to
this, but in practice the compiler structure, desire to work with
third party tools (debuggers/unwinders), and a history of never
changing this makes it very unlikely that they would change this.

>
> Alice

