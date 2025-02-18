Return-Path: <linux-kernel+bounces-520322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D03A3A883
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C881F188E449
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA73121B9E9;
	Tue, 18 Feb 2025 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgpYb+iP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138521A3178
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739909884; cv=none; b=ZgBaI3x7cDBJEPqeTAzuVW32p1tVWkSWyyB4Ppy9coXdSil+aS9PdoJxcEcjinCnpDxXrAYyMLUNJeaPi4E3gPeY6m2C0cc2L6aMzm+x5yaU34NLb31bMCSSqhT0+ZAYjO6sOytEWwwqeTtIFWeRC7BhfijGWF54QzR2tELxUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739909884; c=relaxed/simple;
	bh=esEQm5GjanM0aBfcL/4kqOtaLLCrQdivVby0ndFA7pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qV9jFjB9kPZ95tjyNxYg5Sx8adR7dMxU75zcd8sNAdG4Xee3BIn1moVU2/ZLglf4Co1St3JeOqTxZU74IzEin/uBWi0VNFCsK3iyQGgSSQR8o/dFpb7jocr6t7PJBn9yQ8tYubTpnc7iMdvWoPhcuJKo3YdQjKuFvseu7n133DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgpYb+iP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3249FC4CEE2;
	Tue, 18 Feb 2025 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739909883;
	bh=esEQm5GjanM0aBfcL/4kqOtaLLCrQdivVby0ndFA7pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgpYb+iP/fhoOhaw9xxVB/3dliz1Zhd1R+3emkNQgdgu39grYM9OTqZNi2xHq2rj1
	 QQXJc9+jLSL2lbp2MoKDQ+YLNRR+D5ZWdIv9gSe9aV+XjLFxCnyx/pzRU8ssjV8H5f
	 AglHRJkpBeyneTLD84zhfNkf0hC7l9I+5pS9c5ae6QtcLptLRJnaQxNH27lyOuMQM3
	 mZfy1BVJaHiKBtVWuvaCvNSQP9A3suAwkX5boY4uETTMVLTQOlVSyeRCYE5QB0zDac
	 wNZrpUMaBy6WjhIORXhhDDgWvSUCe+D6KA7pwJn0h0zf0Rw4VfiVe814E9cW3FAe0u
	 7rUKPg6dKMuOw==
Date: Tue, 18 Feb 2025 12:18:01 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] objtool: Use idiomatic section name for relocatable
 rodata under PIE
Message-ID: <20250218201801.hh3cjvj2zfqb2qt3@jpoimboe>
References: <20250218092538.1903204-2-ardb+git@google.com>
 <20250218173827.vk4gplulq3pjdnn6@jpoimboe>
 <CAMj1kXHqS=fTOa13LHqs1bqxy-EeD0xNUGxJA4xK=bKya+XBwA@mail.gmail.com>
 <20250218183108.anuqoojsgkjxwfai@jpoimboe>
 <CAMj1kXFa==KmSseWD1WK=uHW9BOTF0fDOUX0txsMKZzHqCfE+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFa==KmSseWD1WK=uHW9BOTF0fDOUX0txsMKZzHqCfE+g@mail.gmail.com>

On Tue, Feb 18, 2025 at 08:36:42PM +0100, Ard Biesheuvel wrote:
> > > > If so, it feels like this needs to be its own patch, described as a fix.
> > > >
> > >
> > > Fair enough. But better to drop the previous patch from the objtool tree then.
> >
> > I think we can do that... Peter?
> >
> > And just to be clear, you'll have two fixes, right?
> >
> >   1) Make loongarch .data.rel.ro.* actually read-only
> >   2) Fix objtool C jump table annotations for clang
> >
> 
> One fix is to emit .data.rel.ro input sections into .rodata, and fix
> objtool accordingly so it also looks for jump tables there.

Hm, I don't think so...  I think at least one of us is confused :-)

Objtool reads object files (including vmlinux.o) before the final
vmlinux link.  So a linker script change isn't visible to objtool.

And switch statment jump tables are always compiled in .rodata.*.
Right?

> The other is to emit the BPF jump table into .data.rel.ro.c_jump_table
> so that the linker does not complain about conflicting permissions.
> 
> Does that sound about right?

I could be completely confused, but my understanding is we need the
following two fixes:

1) Map .data.rel.ro.* into .rodata for vmlinux to so that it actually
   becomes read-only at runtime.  This has nothing to do with objtool
   AFAIK.

2) Fix the __annotate_jump_table macro for Clang, which takes:

     __section(".rodata..c_jump_table,\"a\",@progbits #")

   quite literally.  So we need a new section name that works for GCC,
   Clang, and GCC -fPIE.  And it should be mapped in vmlinux .rodata.

-- 
Josh

