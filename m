Return-Path: <linux-kernel+bounces-241336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7A69279E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244651F25910
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB1A1B1401;
	Thu,  4 Jul 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fu1hIWQC"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD0F1B0122
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106431; cv=none; b=INJynP8ObR4zLb83iQZBiGZwtQ29mxAv28ap+cbhIFBOD/ogDKlVCpIqOiM6FUgfabZYIpdPIDaLfbC8PlPIBiMdIe88TZ8PySXKnxb2XPuG/U4dFU9uVuy0VhsnMtt5gZsa0sFHS2srfm7G+vt3GOxzPDgBe/CSvQJtg0vXg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106431; c=relaxed/simple;
	bh=/PizTQVDlkIyNELY350ZONH8Gfc08NYf27/JwjBxgRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ8YUdQHCL0LcKvX7OrUE9euaSWCWRJNXmwFeT7bEYvEUNKOvWKY/1PMSQ7OvAHI8V1bbpytirz7CnCAJnEARpKLvko4S60yMB5S6nd1+ROX6hBWcSIRc4Wi85nc4tf4rjxQB6kCrWJAEpEq5blSaBpCTbTwyEIVu0kx+ZZpTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fu1hIWQC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1faad2f1967so13899695ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720106429; x=1720711229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMtQ8G7gYG0PtXSm+9oSte5ras/tptARhMk8vAyTBpM=;
        b=Fu1hIWQC/Sh/lpNuKEDxDoKokku3Y7aOEw1EuiIfNAFF3DTgfpsDw0pYkpgzopT6Xt
         7UECkjZaO5+TPym0K8iv7eoNWcZrmT9O5jfpKVGSkISRGVKggSoes7aGcev7nTsp9gA8
         fPXKDpkUfOp7Txy04cbUv9T5KDpQ6JLfrObHuQYnVGXn5kpt3jiphDkj0hnbapEDZFpr
         6ncJvtDOLQAtaBAZhDLGfZmSg0jeGVZD4R3WFlFeJwXmbQtYWUfYHfN8G7RG2/KTM16i
         Fh8SjLY45v6AX/qx64phLWH/9KLyYu1+/8RZwyMDiRV+Z9dffxfFgA+787OpAisg5HaL
         k1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106429; x=1720711229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMtQ8G7gYG0PtXSm+9oSte5ras/tptARhMk8vAyTBpM=;
        b=ItY7oMcfCtr0kqONMjcWJdbn7X6eSgmw4E+OCckWD+F75E4exSYVEEdCTLtIfIpXuE
         O+M7yw1wPQea5IlMIOZveQqNJLmPxGMngT6hiNLLFziNxRlQaxyv7BZpG4tZqQTSEWvW
         XYY1LDm4NE4lV1KZzii8lwGWJtFJVw45EExoax1x4sEQ+jfY4ZxMU2OfJyUQ7Nhm02oc
         aEXqraMOTGqhmPjM+2tsewwiEELuoJp0cu88BN0XPgTbhW3cDhuQ9gVolJBUlkoz4hOH
         ydAgXZB7xErHaUaWoitQhL/4bJFJKnwdyz9TugdV2h2OjD6/h9acg/P3apoQy8EnkYKR
         wvFg==
X-Forwarded-Encrypted: i=1; AJvYcCV7/GnLXo59SWPGwcjfar3ltzqTnrbweHMQb2ECq3yWzNIBkD3Ge8+zS34VNbi7UDy0ryPxQ4u7EFwjyewwK9kA+hzPlDVZs4tBAP1K
X-Gm-Message-State: AOJu0YyLOxxSn1smVSve+9+dWnqnzjUC6F0Wab+Q9KvxZ0UxYfT1/woB
	vSkjilIjTEEAwGF9hh6pDXnYR0qONcvxubmQ8WUEkTgh7gyxkoa290tQn32gcw==
X-Google-Smtp-Source: AGHT+IGCoEg+2iwgq2yFecGonukG4K9qxoer7A69funkZsv0Vc/pIw4JkTQQWYN93RAWKE9BO0pBlQ==
X-Received: by 2002:a17:902:dacd:b0:1fa:1a78:b5a9 with SMTP id d9443c01a7336-1fb3700ccffmr27138855ad.3.1720106429108;
        Thu, 04 Jul 2024 08:20:29 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15388bdsm124081885ad.168.2024.07.04.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:20:28 -0700 (PDT)
Date: Thu, 4 Jul 2024 15:20:24 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradaed.org>,
	Sean Christopherson <seanjc@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 2/2] rust: add tracepoint support
Message-ID: <Zoa9uMODCjTfM741@google.com>
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
 <20240628-tracepoint-v4-2-353d523a9c15@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628-tracepoint-v4-2-353d523a9c15@google.com>

On Fri, Jun 28, 2024 at 01:23:32PM +0000, Alice Ryhl wrote:
> Make it possible to have Rust code call into tracepoints defined by C
> code. It is still required that the tracepoint is declared in a C
> header, and that this header is included in the input to bindgen.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  include/linux/tracepoint.h      | 18 +++++++++++++++-
>  include/trace/define_trace.h    | 12 +++++++++++
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/tracepoint.rs       | 47 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 689b6d71590e..d82af4d77c9f 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -238,6 +238,20 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  #define __DECLARE_TRACE_RCU(name, proto, args, cond)
>  #endif
>  
> +/*
> + * Declare an exported function that Rust code can call to trigger this
> + * tracepoint. This function does not include the static branch; that is done
> + * in Rust to avoid a function call when the tracepoint is disabled.
> + */
> +#define DEFINE_RUST_DO_TRACE(name, proto, args)
> +#define DEFINE_RUST_DO_TRACE_REAL(name, proto, args)			\
nit: IMO using a __* prefix would be a better option to describe the
internal use of the macro instead of the _REAL suffix.

Other than that, this patch looks good to me:

Reviewed-by: Carlos Llamas <cmllamas@google.com>

