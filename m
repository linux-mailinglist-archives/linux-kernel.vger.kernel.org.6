Return-Path: <linux-kernel+bounces-281381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB2E94D63F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A852FB2185D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA28155CB3;
	Fri,  9 Aug 2024 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJcmtJDO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB814F124
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227688; cv=none; b=oRllPOeo3B+UgqQRBKhY/UmdNqn98y9hSbcJe2xALv5Efbr3vyn2e2Qxh38ZuDToV3zTuEUilVDJLdI/wY9J1BV2e+Ru/IBrMzjk10bgdD24BT9tJVAxIXcrkL1Tav/IbaiDwEGWqU27tw6qD14a2H1K/HLz9yATqm+UU5yeiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227688; c=relaxed/simple;
	bh=yrIcLQX/cGReHkkuFz6o+An8j150bAv3nUdA7o3gDL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkZ+hfu6nrwEFdADrmO+VmIOlTy1u/0N+t00WOmLVdJFLOKQqWVpzjGGyA/U0mocmvais6Yh72oaDgbvDei7OEGU1nfLFVERKVx7A8SCMHvcyIeNOTEdygCL/OsSFrXcRpv6wAFSyUiPSLGi3mhcDvjE25dinoP+kXDx3YGwWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJcmtJDO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428119da952so16096455e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723227683; x=1723832483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5aSgr88/PRGVfxdX8pAdBy1fV+mFF55FgD+2QlLqzo=;
        b=sJcmtJDO6IcdSHbFJHJFTerN1lwcpGV1kzIY54hTYTt9b8jdx4PlyzAAo8AD2J1giG
         Yxd0irUSMQn31741vmkZvTDLKMiQKO3RNvrvDGhCuzNSiGNmWscnjex4l0o+rD0ZZ0Xf
         iCZ+HCqfj/ZvtWYTXNQLSvBJx9K5W1lE3EE8++/1rlwoKW//YFlhku3AcY4I8zhA5Yp6
         0sKf2a/J9AUbun0fdVxbf2iAXb8xZp/uJbREx/g/D+FpT/XaHoR3uRU2+MUAd5HGVnXM
         HVDA/cRQtCbEy14Lg0STVLMTRCHZG+Glxc7HMivTAToE5jnCU3WEjsAfIWZNP4psaRFD
         Qitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723227683; x=1723832483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5aSgr88/PRGVfxdX8pAdBy1fV+mFF55FgD+2QlLqzo=;
        b=s/1RIQ4pPtVYVvRHXbTzPBIXzb4PQc8nmuUjVEu8RfVak0Ho9MjOhtnjPHHqNDLV7n
         iVZcYXhqjDSQud6KjinposSzZQvMFYF8CADsWvtASjL+NVoxQDPPULgd5iKmGgbKQ6dy
         RiCaq57tfE1CEqlSVn0mjkfEpo2ETSD0lUUBvLTF36IKoMe+Pwc4KQxNaqLL/S1duvnW
         7BaqvBhdPq2eebnlwCVh+XrrPF4qz+Bl6QBY2oMUbfhR78SYyGVHVfROQsdvNKg7X9qD
         b95hrsbOQyXLkH/+WeK39kYdBfJMx8LBJfSnHACj57QMqoiLTuo4+2DZABMYrOrcaFFJ
         bboA==
X-Forwarded-Encrypted: i=1; AJvYcCU7ssdbPCx1cmQ6EwuRrauw5upMFgXGSwDzOJ4idGPP8Rpdfrw3ApO5UYl84jLYCI5C8sSGJtigOwXVSq2C+6cp4Q8KQ30zQ5/kBtns
X-Gm-Message-State: AOJu0YwNr4IdjOckJlp3oO573er0jLYb7uMwjbl0GFcH2unCALs1Fzha
	dLOrRC1wGgi2WkVZyGCT7GAf5tl72mwTbglv8XhlO3nxWAPvwEWJiwo+DDzDsFPxH3UdQk4ReLi
	qfoEn8T4xjK9BhsLcMSNd4g8jvy3VweNLhnhE
X-Google-Smtp-Source: AGHT+IH5Ep/88bbCWZXRUVBPEQ+tzupqROr5HmyaRJfMyZWiEj8it63tIiOzqdgNyDMpwvhyZfPAAiV2XhcMqLgvZrs=
X-Received: by 2002:a5d:4642:0:b0:362:8201:fa3 with SMTP id
 ffacd0b85a97d-36d5ff6f35bmr1589390f8f.34.1723227683079; Fri, 09 Aug 2024
 11:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
 <20240808-tracepoint-v6-1-a23f800f1189@google.com> <20240809191601.3d15e3af.gary@garyguo.net>
In-Reply-To: <20240809191601.3d15e3af.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Aug 2024 20:21:10 +0200
Message-ID: <CAH5fLgi7dy9PV+YfCJuVoH98M0z2FUnOAjBoFKkqyG8P9iPSEQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] rust: add generic static_key_false
To: Gary Guo <gary@garyguo.net>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
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

On Fri, Aug 9, 2024 at 8:16=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Thu, 08 Aug 2024 17:23:37 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > Add just enough support for static key so that we can use it from
> > tracepoints. Tracepoints rely on `static_key_false` even though it is
> > deprecated, so we add the same functionality to Rust.
> >
> > This patch only provides a generic implementation without code patching
> > (matching the one used when CONFIG_JUMP_LABEL is disabled). Later
> > patches add support for inline asm implementations that use runtime
> > patching.
> >
> > When CONFIG_JUMP_LABEL is unset, `static_key_count` is a static inline
> > function, so a Rust helper is defined for `static_key_count` in this
> > case. If Rust is compiled with LTO, this call should get inlined. The
> > helper can be eliminated once we have the necessary inline asm to make
> > atomic operations from Rust.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/bindings/bindings_helper.h       |  1 +
> >  rust/helpers.c                        |  9 +++++++++
> >  rust/kernel/arch_static_branch_asm.rs |  1 +
> >  rust/kernel/jump_label.rs             | 29 +++++++++++++++++++++++++++=
++
> >  rust/kernel/lib.rs                    |  1 +
> >  5 files changed, 41 insertions(+)
> >
> > diff --git a/rust/kernel/arch_static_branch_asm.rs b/rust/kernel/arch_s=
tatic_branch_asm.rs
> > new file mode 100644
> > index 000000000000..958f1f130455
> > --- /dev/null
> > +++ b/rust/kernel/arch_static_branch_asm.rs
> > @@ -0,0 +1 @@
> > +::kernel::concat_literals!("1: jmp " "{l_yes}" " # objtool NOPs this \=
n\t" ".pushsection __jump_table,  \"aw\" \n\t" " " ".balign 8" " " "\n\t" "=
.long 1b - . \n\t" ".long " "{l_yes}" "- . \n\t" " " ".quad" " " " " "{symb=
} + {off} + {branch}" " - . \n\t" ".popsection \n\t")
>
>
> I believe this file is included by mistake, given it's added to
> gitignore in patch 5.

We may have to rethink the file extension used here. You have no idea
how many times I've deleted that file from this commit.

Alice

