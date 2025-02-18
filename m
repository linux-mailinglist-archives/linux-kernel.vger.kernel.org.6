Return-Path: <linux-kernel+bounces-519003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D46A396FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319C41896945
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B7122FDE0;
	Tue, 18 Feb 2025 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJlsbuGi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B022DF8C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870579; cv=none; b=ZeV8s6P8O+VlDilQTQ2+pJf/Icb1AHJLaVlfUln0DgW5JnC/WwQrPGaH007zX4TcY4umIlUfDBxGGKepvtn3Kvl6kp6MRYPerBTd4sVcSnyNbBZsMgMXjlPMALjD3AnrmywBep2diWPJ5VXknlRFh3LPdAAZTv+b91ll3Jgh5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870579; c=relaxed/simple;
	bh=GrCoSmEOxWq7xZxvA0t4jFnZKfhWflsx3jCMkmytcCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXnNBPq+I2BrNCDGNI3sr07ZfbgmtaQGBvnicePgDnnWcZc/szWwXHd5HUvVy6A6lHsEvxvnHnLIlX0e1XqgG5gO9THbuP5gs66QZe7lnQylCV5o53Y7KVN0tJB3xvqeFwrc+jD1Rm/MBwJ/4SKGVTvC6SSf07SnGeZaS/JB+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJlsbuGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C515C4CEE2;
	Tue, 18 Feb 2025 09:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739870578;
	bh=GrCoSmEOxWq7xZxvA0t4jFnZKfhWflsx3jCMkmytcCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJlsbuGiBHjcVjlW0coki4A5BM+1Y5At1FDP9e60r4ZK1sGCkVWFHaRyv2hRLB0rW
	 v30ilXRQLRw+J+7UW/js1fxLYXC2vOA8IYAY10CqrV5fyIiuDcUx0JBkp3TkpQLGOp
	 7vJSW3G021wG68AqVh2e7/G0+TEkpbhNXFfAbAkCeiwv1SX/w6kRmfD6Mc6PuY9dSF
	 K0kVSjHLktJuGBQODFZAFnvgKuNCjXbinfExBO/7gH5szPw2yqnAQ9lKXD7F/16j6f
	 u2EqMpKAJgNtCzmBHZkooFAA2Q/72XHambjX3FvJSTbkaopcVwrOFQJ866haAjfqh7
	 PPx9SV/PYl+DQ==
Date: Tue, 18 Feb 2025 10:22:47 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
Message-ID: <Z7RRZ0jdqsrADMm0@gmail.com>
References: <20250123190747.745588-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123190747.745588-1-brgerst@gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> Currently, x86-64 uses an unusual percpu layout, where the percpu section
> is linked at absolute address 0.  The reason behind this is that older GCC
> versions placed the stack protector (if enabled) at a fixed offset from the
> GS segment base.  Since the GS segement is also used for percpu variables,
> this forced the current layout.
> 
> GCC since version 8.1 supports a configurable location for the stack
> protector value, which allows removal of the restriction on how the percpu
> section is linked.  This allows the percpu section to be linked normally,
> like other architectures.  In turn, this allows removal of code that was
> needed to support the zero-based percpu section.
> 
> v6:
> - Rebased to current tip tree
> - Dropped patches already applied
> - Fixed typos in commit messages
> - Added Reviewed-by tags
> 
> Ard Biesheuvel (1):
>   x86/module: Deal with GOT based stack cookie load on Clang < 17
> 
> Brian Gerst (14):
>   x86: Raise minimum GCC version to 8.1
>   x86/stackprotector: Remove stack protector test scripts
>   x86/boot: Disable stack protector for early boot code
>   x86/pvh: Use fixed_percpu_data for early boot GSBASE
>   x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
>   x86/stackprotector/64: Convert to normal percpu variable
>   x86/percpu/64: Use relative percpu offsets
>   x86/percpu/64: Remove fixed_percpu_data
>   x86/boot/64: Remove inverse relocations
>   x86/percpu/64: Remove INIT_PER_CPU macros
>   percpu: Remove PER_CPU_FIRST_SECTION
>   percpu: Remove PERCPU_VADDR()
>   percpu: Remove __per_cpu_load
>   kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU

>  33 files changed, 100 insertions(+), 475 deletions(-)
>  delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
>  delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

Thank you for doing this series - it all looks pretty good from my side 
and I've applied it experimentally to tip:x86/asm. I fixed up the trivial 
details other reviewers and me noticed.

Note that the merge is tentative, it might still need a rebase if some 
fundamental problem comes up - but let's see how testing goes in -next.

Thanks,

	Ingo

