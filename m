Return-Path: <linux-kernel+bounces-555024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8218A5A497
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961791893492
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CCF1DED5B;
	Mon, 10 Mar 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jni+Y87a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2F1DE8A2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637789; cv=none; b=jgn+zd52D6t7LZ9ff1E3adXa0EERgzY+EP+BsCUQDivwyhOeW/7VbTVTBaUfoHKud3PD6ifrsb3+Hs+j/2Ak+ejPO/xxzmDpgDvGAWQzKB9Gl5ZE1LAJoHmm5Fs3qEfrYfxgZ0svjDH75hoTCVLGZ118NVUIIJjnyyQSQyeHN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637789; c=relaxed/simple;
	bh=QXKN+STnvPECiS5iSygJA9/80qk5XPNoEq1eIiHOerw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFSEYhJscC1RjOGFRY/Pi9WKKq6pM7tzmdmygvzr1Q+4xX5XvJiceZGip8RZvE3lNZ4A1XdyZI8vsZzTu+701fDWnCYcpewnVl6fuhsUgoxTZc3rtpbD6yWu+c28esVXX+pxeZ+IOaAQQ+vsNNfeTWf5JIrIQNdVFHERhuPMcKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jni+Y87a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28529C4CEF1;
	Mon, 10 Mar 2025 20:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741637789;
	bh=QXKN+STnvPECiS5iSygJA9/80qk5XPNoEq1eIiHOerw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jni+Y87awWIYyJPLQeX9KrGXkrwAytZxqAZKkUWj/xWflK5zrn/ZCHxJkRbeSkezG
	 7F22DAgmlQe0kpiT2KOoYXbrdrqbILWelfgqtOVbDktd9II8pO7bolYS5vAu02mlYv
	 fZbJFoMnmlluBPf9t7OskfyTBoLDEN3gYTbm+7bXfzMN0KR0dnhIRwlBYwZ97gQNgA
	 0tYCh2E7YQS9XprZUbECfbJTlmnIYepn83GGzFXimy6RCEXr2JAE7EAPAGRPq9+s6F
	 bFBgJedQOxkjj5YB1Faj9YRv5g0S3wb+bTeaZcm85Wziy+IRIl+fbEXaO+Qq3wFtkV
	 4+igLnYyo1Mzg==
Date: Mon, 10 Mar 2025 21:16:24 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/hweight: Fix and improve __arch_hweight{32,64}()
 assembly
Message-ID: <Z89ImJlHFLJUDhFM@gmail.com>
References: <20250310200817.33581-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310200817.33581-1-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> instruction from being scheduled before the frame pointer gets set
> up by the containing function, causing objtool to print a "call
> without frame pointer save/setup" warning.
> 
> b) Use asm_inline to instruct the compiler that the size of asm()
> is the minimum size of one instruction, ignoring how many instructions
> the compiler thinks it is. ALTERNATIVE macro that expands to several
> pseudo directives causes instruction length estimate to count
> more than 20 instructions.
> 
> c) Use named operands in inline asm.
> 
> More inlining causes slight increase in the code size:
> 
>    text    data     bss     dec     hex filename
> 27261832        4640296  814660 32716788        1f337f4 vmlinux-new.o
> 27261222        4640320  814660 32716202        1f335aa vmlinux-old.o

What is the per call/inlining-instance change in code size, measured in 
fast-path instruction bytes? Also, exception code or cold branches near 
the epilogue of the function after the main RET don't fully count as a 
size increase.

This kind of normalization and filtering of changes to relevant 
generated instructions is a better metric than some rather meaningless 
'+610 bytes of code' figure.

Also, please always specify the kind of config you used for building 
the vmlinux.

Thanks,

	Ingo

