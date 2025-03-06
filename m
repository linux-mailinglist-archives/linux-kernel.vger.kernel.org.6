Return-Path: <linux-kernel+bounces-548619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C006EA54720
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FDC3A8539
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FDD20B210;
	Thu,  6 Mar 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffjkQmJu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAEE20AF69
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255075; cv=none; b=HigtySCGkgU7nYrfJ3zOVUErL4Erv2ePkxi0Egl7mcitm8RoUFhzcTLUNQ4C85jMwLXQPQkPz/O7A/WQZz07rHw9X0YbDtc0rkzMRLSA8qgaFWie8xFame7PBFdaoXSrmmzJIR+GXGjM91uBQInvz1d3BnXB1jziJ+berW9y2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255075; c=relaxed/simple;
	bh=Ao19rpVVji7s5n35VmpbbTgcnwYhjv4subEZAwg1LOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrIqVcDjhRDkfguY6sW/lwrpHxk6RTEzryn1dI6YvI82MFXkRL4nSHh+JyWr2kp88ol3/316qpWE9cC2Jnq78VDHJ24fbGMDwtZUgNSScT/MJ9kwiJ7cJss4jqasxVDMaJQZdwvg4WqY7rstjos+EMlNw+LKJGrBjg5XEFHVN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffjkQmJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E71C4CEE2;
	Thu,  6 Mar 2025 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741255074;
	bh=Ao19rpVVji7s5n35VmpbbTgcnwYhjv4subEZAwg1LOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffjkQmJuIYIQPi9YQBxWzCIPS+FkgqyBj8qGeikJ3QcACPRAm/Uveq7qX27octhp1
	 qBshRrMGuj9iz78AHyCoObXfJoDX3Y0GbmGlHnWVjWOlQr0ZyW5BcqdXgCwfTyTRWM
	 4mZVzWTbH2x9B9uib9NVhRgZW36vxUi+p22oFxv00JVTmLL8FbCam6uq9jSLnwx/fT
	 pKnTe3Y3Cz+Ujum7DRFTPRb/22WT48mA19sMka02RipucqxfUjILexmeRnVmbIcqnI
	 4jGDWRbpQOHz8Y/ow3h02o6Adav1pDebWeWz7Kmp1EvhOB5/hmoVnXGSn14QaIv1tR
	 +z7bxChXS8UXA==
Date: Thu, 6 Mar 2025 10:57:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <Z8lxmPmnJhBmPRvl@gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228123825.2729925-1-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> According to:
> 
>   https://gcc.gnu.org/onlinedocs/gcc/Size-of-an-asm.html
> 
> the usage of asm pseudo directives in the asm template can confuse
> the compiler to wrongly estimate the size of the generated
> code.
> 
> The LOCK_PREFIX macro expands to several asm pseudo directives, so
> its usage in atomic locking insns causes instruction length estimate
> to fail significantly (the specially instrumented compiler reports
> the estimated length of these asm templates to be 6 instructions long).
> 
> This incorrect estimate further causes unoptimal inlining decisions,
> unoptimal instruction scheduling and unoptimal code block alignments
> for functions that use these locking primitives.
> 
> Use asm_inline instead:
> 
>   https://gcc.gnu.org/pipermail/gcc-patches/2018-December/512349.html
> 
> which is a feature that makes GCC pretend some inline assembler code
> is tiny (while it would think it is huge), instead of just asm.
> 
> For code size estimation, the size of the asm is then taken as
> the minimum size of one instruction, ignoring how many instructions
> compiler thinks it is.
> 
> The code size of the resulting x86_64 defconfig object file increases
> for 33.264 kbytes, representing 1.2% code size increase:
> 
>    text    data     bss     dec     hex filename
> 27450107        4633332  814148 32897587        1f5fa33 vmlinux-old.o
> 27483371        4633784  814148 32931303        1f67de7 vmlinux-new.o
> 
> mainly due to different inlining decisions of -O2 build.

So my request here would be not more benchmark figures (I don't think 
it's a realistic expectation for contributors to be able to measure 
much of an effect with such a type of change, let alone be certain
what a macro or micro-benchmark measures is causally connected with
the patch), but I'd like to ask for some qualitative analysis on the
code generation side:

 - +1.2% code size increase is a lot, especially if it's under the 
   default build flags of the kernel. Where does the extra code come 
   from?

 - Is there any effect on Clang? Are its inlining decisions around 
   these asm() statements comparable, worse/better?

A couple of concrete examples would go a long way:

 - "Function XXX was inlined 3 times before the patch, and it was 
    inlined 30 times after the patch. I have reviewed two such inlining 
    locations, and they have added more code to unlikely or 
    failure-handling branches collected near the function epilogue, 
    while the fast-path of the function was more optimal."

Or you might end up finding:

 - "Function YYY was inlined 3x more frequently after the patch, but 
    the inlining decision increased register pressure and created less 
    optimal code in the fast-path, increasing both code size and likely 
    decreasing fast-path performance."

Obviously we'd be sad about the second case, but it's well within the 
spectrum of possibilities when we look at "+1.2% object code size 
increase".

What we cannot do is to throw up our hands and claim "-O2 trades 
performance for size, and thus this patch improves performance".
We don't know that for sure and 30 years of kernel development
created a love-and-hate relationship and a fair level of distrust
between kernel developers and compiler inlining decisions,
especially around x86 asm() statements ...

So these are roughly the high level requirements around such patches.
Does this make sense?

Thanks,

	Ingo

