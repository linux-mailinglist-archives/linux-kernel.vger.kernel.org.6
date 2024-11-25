Return-Path: <linux-kernel+bounces-420681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E55A9D821A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D90E1625F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75EF18FDC2;
	Mon, 25 Nov 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egsdHaO9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380F1531E8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526494; cv=none; b=cjWfK3Xi44VbR2fcLhQdxTsnUimS7zNYpahpoi9ntbIuXKX4LylvfBWfgIKnNYlc41OJWcIXCqBx0zPr/E/IzsQ/kXZhdXlUbhusv0UG3PsZw+q9wbK5i+OVyAi6BKozGAXvD2aTiFhymnd/F+e1HWHrEDzlsUB7RxsyZuIRIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526494; c=relaxed/simple;
	bh=41tMkIJtT7b3R8KkSORNC7wCoYnqYUvK888UHmzzwMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pq4OIBlcRAL4rjWIs1zXr3uRNC299Burysec4RL1VyIw3Naghg/B/mJLzDGVFaUle1y+YMRcQdw3rPio6LYFxGJBGqJyPjO3J0fgki7iH8gq5sc53FOMoUMMBSHPo5W4rD3Q/i1EUlnuA24jPEK1cvnwhB2zcJjWcVn/4hl1bXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egsdHaO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0721C4CECE;
	Mon, 25 Nov 2024 09:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732526493;
	bh=41tMkIJtT7b3R8KkSORNC7wCoYnqYUvK888UHmzzwMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egsdHaO9hZDI3pmBuKqMoQhZINxlIXxL39nYSriz94LFkWtkgA1I+jBuVfvPRPmGr
	 0Dexh+04FduuOEehqPdKm/lqXYtyv5eme18jVGcmgnNNq8VbWrPIOCtOex4RB04kLo
	 YDZCo0G4Vnu5WW1oofSmYkeaqhqLol2rOsXVQb+cQaVrBPH+g/AUmqKQqq3N30t+Wv
	 h4ZHTs+uNqEBTunWBhdKoaVYoYTJSEEdtZ5gSzClHmMp/W0emJbBvrNJfaDyEHWGDw
	 2y9mned0Z6oj7U6bhMj5qw7bkkY48CYJ/x5P42oMQl1z+x11BDRKlaQE7EzStoeyyQ
	 j9OZIhjJ3rg/Q==
Date: Mon, 25 Nov 2024 10:21:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 16/16] [DO NOT MERGE] x86/kexec: enable DEBUG
Message-ID: <Z0RBl6pzNf5irop9@gmail.com>
References: <20241122224715.171751-1-dwmw2@infradead.org>
 <20241122224715.171751-17-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122224715.171751-17-dwmw2@infradead.org>


* David Woodhouse <dwmw2@infradead.org> wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 67f6853c7abe..ebbd76c9a3e9 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -14,6 +14,8 @@
>  #include <asm/nospec-branch.h>
>  #include <asm/unwind_hints.h>
>  
> +#define DEBUG
> +
>  /*
>   * Must be relocatable PIC code callable as a C function, in particular
>   * there must be a plain RET and not jump to return thunk.
> @@ -191,6 +193,8 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	pushw	$0xff
>  	lidt	(%rsp)
>  	addq	$10, %rsp
> +
> +	int3
>  #endif /* DEBUG */

That's a really nice piece of debugging code written in assembly, 
combined with the exception handling feature that generates debug 
output to begin with. Epic effort. :-)

Just curious: did you write this code to debug the series, or was there 
some original hair-tearing regression that motivated you? Is there's an 
upstream fix to marvel at and be horrified about in equal measure?

I'd argue that this debugging code probably needs a default-off Kconfig 
option, even with the obvious hard-coded environmental limitations & 
assumptions it has. Could be useful to very early debugging & would 
preserve your effort without it bitrotting too obviously.

Thanks,

	Ingo

