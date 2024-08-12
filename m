Return-Path: <linux-kernel+bounces-283179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D318A94EE3E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F641C21F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C66017C7C3;
	Mon, 12 Aug 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1dhUITP"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85517BB3A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469594; cv=none; b=CCs9jiArl5ujFkfwfPibpqhQct+b0pHbPizfAackf0BJsF+9dTxBqEsF+RdY5bFexfyJMpLtci3QjH/p/TKWYB0wdN02kX8xEMzMAilFq8CxrQYNS+HNv+SURNp+wXCE42ef7P9KjdiKigEOfQQ5qllsU3PwwT3h8J6ef2c2JJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469594; c=relaxed/simple;
	bh=yQGH4wTqdj6UgcbMWJ/OlXYfokf0rrWK3E7OaiXkuCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqVI0mnQdygBB807dlA8iHiNMiPphDBztbTJh5RGvXfcWF5S1jocjr+zJdh4GneUpObLb1GJSL6i/xoyecGY+9BJcZdDkuy1Dpl9cdJU61yMPPsw6SXGArx05FgoWmYCrYWj3WBDeFkInjZGE2GHIhKlrNO4v0dXf9iB01GmOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1dhUITP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso33458085e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723469592; x=1724074392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQGH4wTqdj6UgcbMWJ/OlXYfokf0rrWK3E7OaiXkuCI=;
        b=r1dhUITPF2KaKWUHuGt9L0UVrLIpXu1j3oDeBfzMj3qb/7xnIdSOHJDaeFjXBqA+/j
         3L4JhAgndp58gnheOPPVWwym12IrrbyovNAOIukmUPJkzw40p82jTbrHsBdLdJJDIkXT
         yj5IuHlkvpw86z0YdjKB2jF3trnGfBzhrtVAK6eJBsUSD6g3YNRfa9xYcIjNXKDLmbzS
         feQ9Xs0YAVbSGJkCoZB/Od1A72G27YYP2gmE8kOgLuqPpdzZ5foyrWmnakaXyjoEboiB
         g7WUnHfQqro1LEPUKcMOJr9vmW6vu7UsUsVgv6629ko65W6WYwQjbnWmfWt5oUZhavck
         5U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469592; x=1724074392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQGH4wTqdj6UgcbMWJ/OlXYfokf0rrWK3E7OaiXkuCI=;
        b=V89ZEwJQx4Y8uXGdyKQDoU+Bcs+M18FeVmSLZisS9HoibRu4yDMxuwkck7E5/4gtEL
         ii9dQ2ADuZptkCU2Z+PLK8zs8JHEnahscKf/nRA1DJHO0nABpDwJ7wBq6GtksKBHt0oy
         c3eEmW828iJ9J23FnSR9cQnzzEY2Zx6MwaGfvCqsiPWtAhoFhfegBHeaQ1HW0rTSsG+Y
         QBeyAWidq1WIhYQKkKFIdxaLblkh6NW3rMpVe4VUIsFFXOTMrYc+7yhARPo0FmLlZxHu
         m3CXCqaqaKKipzfYAOXmQ6YnR3dWUkJPQrXa3PYR6sEShxqeh5PDlPU5TH+MqdQnXk/O
         kb+w==
X-Forwarded-Encrypted: i=1; AJvYcCU9PNDbh5smTBHEcQB94JJK1nCzLMpG19eny2R3bjxIQwnylqAOJecACwvPvErLGCWxEgkZNedtpZstrnSSWt8pY3DgI9fHW71nBnYZ
X-Gm-Message-State: AOJu0Yy8AznNadC3dz0abKwYs+N0A4HiG6Awk+qOZ0/2hvdwTCdnHlzL
	TQSNnwHRScg85bzqBeRdas4tikNF9sF/ypvGzUDFg+ax42B/ArEjaTWVoJs0LsjEub3Yy/pMvDF
	ebyr73cmtM4q+NAGsUtLFq0soqNGJ69EvtQHr
X-Google-Smtp-Source: AGHT+IHW60xClnCiQEYYTC8Z9PZ33xaYy4WZgALT6Q+LMP95jazFgPNu9OZ8W3SxyYi1G4TpTJOyz0WQCdXu9YQVFvk=
X-Received: by 2002:a05:6000:b42:b0:363:d980:9a9e with SMTP id
 ffacd0b85a97d-3716cd267abmr226021f8f.55.1723469591316; Mon, 12 Aug 2024
 06:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-tracepoint-v6-0-a23f800f1189@google.com> <20240808-tracepoint-v6-4-a23f800f1189@google.com>
In-Reply-To: <20240808-tracepoint-v6-4-a23f800f1189@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 12 Aug 2024 15:32:59 +0200
Message-ID: <CAH5fLggC_73YQGLLjUsGnsUjAr9vOS-ebG0=-dWGqS7euzzf4Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] jump_label: adjust inline asm to be consistent
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
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

On Thu, Aug 8, 2024 at 7:23=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> To avoid duplication of inline asm between C and Rust, we need to
> import the inline asm from the relevant `jump_label.h` header into Rust.
> To make that easier, this patch updates the header files to expose the
> inline asm via a new ARCH_STATIC_BRANCH_ASM macro.
>
> The header files are all updated to define a ARCH_STATIC_BRANCH_ASM that
> takes the same arguments in a consistent order so that Rust can use the
> same logic for every architecture.
>
> Link: https://lore.kernel.org/r/20240725183325.122827-7-ojeda@kernel.org =
[1]

This link is in the wrong place. It's supposed to be mentioned as a
dependency for this series. Also, I intended to have the same tags
here as I did on the last patch.

Alice

