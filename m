Return-Path: <linux-kernel+bounces-358808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BEB998414
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37651F25264
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945731BF818;
	Thu, 10 Oct 2024 10:45:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F3418DF62;
	Thu, 10 Oct 2024 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557119; cv=none; b=JCq8efy5UCiFt4lq1/GhJJhk8C34RI+fOdX3hc6h1TXtK2+HSfySvCZMQfKICbHw/lMI24eMnWvgkDH+tDZbkyvVZMWw+gF1XhttgihRaU/XUi5CruprrYC9Fjj0zj0kqeZxDZOnVUelfSMcxRrJetMwF7Fk5cQI7pY3wOcWXMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557119; c=relaxed/simple;
	bh=JcYGggWCVH3dTIk5TqTj9id32NOF4sFLETCNsN9i/v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDRFBxKlmvlbQ8zqguYBPOYolTMRjgsepRpIl5IRtHlcOPTTbbD8MUTYsWmLluw9MEJewQCAYpxHTSXhmLOgtfviUCOGwbFsNvf2mbOS4H3O/vB2omLxHL5de/CHbq0lJ3rtEP1zbW0jtxSpzKdo4MC2Uk5BwLFuk30RkqrUQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31F8B497;
	Thu, 10 Oct 2024 03:45:46 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1225C3F58B;
	Thu, 10 Oct 2024 03:45:11 -0700 (PDT)
Date: Thu, 10 Oct 2024 11:45:07 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Matthew Maurer <mmaurer@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all
 architectures
Message-ID: <ZwewMw8jBh6OU-L_@J2N7QTR9R3>
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
 <ZwbAvEnrzu6UUgGl@J2N7QTR9R3>
 <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>

On Wed, Oct 09, 2024 at 10:15:35PM +0200, Alice Ryhl wrote:
> On Wed, Oct 9, 2024 at 7:43 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Hi Alice,
> >
> > On Tue, Oct 08, 2024 at 05:37:16PM +0000, Alice Ryhl wrote:
> > > The KCFI sanitizer stores the CFI tag of a function just before its
> > > machine code. However, the patchable-function-entry flag can be used to
> > > introduce additional nop instructions before the machine code, taking up
> > > the space that normally holds the CFI tag.
> >
> > To clarify, when you say "before the machine code", do you mean when
> > NOPs are placed before the function entry point? e.g. if we compiled
> > with -fpatchable-function-entry=M,N where N > 0? I'll refer tho this as
> > "pre-function NOPs" below.
> >
> > There's an existing incompatibility between CFI and pre-function NOPs
> > for C code, because we override -fpatchable-function-entry on a
> > per-function basis (e.g. for noinstr and notrace), and we don't
> > currently have a mechanism to ensure the CFI tag is in the same place
> > regardless. This is why arm64 has CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> > depend on !CFI.
> >
> > For C code at least, just using regular -fpatchable-function-entry=M or
> > -fpatchable-function-entry=M,0 shouldn't change the location of the CFI
> > tag relative to the function entrypoint, and so should have no adverse
> > effect on CFI.
> >
> > Is Rust any different here?
> 
> Ah, no it shouldn't be. Sami can you confirm?
> 
> > > In this case, a backwards offset is applied to the CFI tag to move
> > > them out of the way of the nop instructions. To ensure that C and Rust
> > > agree on the offset used by CFI tags, pass the
> > > -Zpatchable-function-entry to rustc whenever it is passed to the C
> > > compiler.
> >
> > As above, I suspect this isn't necessary to make CFI work, for any case
> > that works with C today, due to -fpatchable-funtion-entry being
> > overridden on a per-function basis. Are you seeing a problem in
> > practice, or was this found by inspection?
> >
> > However IIUC this will allow rust to be traced via ftrace (assuming rust
> > records the instrumented locations as gcc and clang do); is that the
> > case? Assuming so, is there any ABI difference that might bite us? On
> > arm64 we require that anything marked instrumented with
> > patchable-function-entry strictly follows the AAPCS64 calling convention
> > and our ftrace trampolines save/restore the minimal set of necessary
> > registers, and I don't know how rust whether rust will behave the same
> > or e.g. use specialized calling conventions internally.
> 
> Well, I was told that it's a problem and was able to trigger a failure
> on x86. I didn't manage to trigger one on arm64, but I wasn't sure
> whether that was me doing something wrong, or whether the problem only
> exists on x86. We already have the flag on x86 for FINEIBT, 

I believe that hte problem only exists on x86, becaause they use 
patchable-function-entry for their FINEIBT patching (and use -mfentry
for ftrace), whereas everyone else uses patchable-function-entry for
ftrace.

> but I thought on the off chance that it's not a problem in practice on
> arm, it still doesn't hurt to add the flag.

It won't adversely affect CFI, but it will open up rust code for ftrace,
so I'm not sure that "it doesn't hurt".

AFAICT at the moment this isn't necessary for CFI, so can we drop this
patch for now?

If we want to pass these flags for !x86, the justification should be to
enable ftrace for rust code, and we should test that actually works
(e.g. by testing ftrace with rust code).

What happens on x86 for ftrace and rust?

> Regarding the AAPCS64 calling convention thing ... rustc uses the Rust
> calling convention for functions internally in Rust code and I don't
> know whether that changes anything relevant for what you mention.
> Matthew/Sami do you know?

From their replies it sounds like that happens to be true in practice
today, but as above I think we should go test this actually works.

Mark.

