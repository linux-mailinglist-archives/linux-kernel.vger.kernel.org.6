Return-Path: <linux-kernel+bounces-563671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDC9A64674
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575871893CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B4021B9E2;
	Mon, 17 Mar 2025 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T59YP1aF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1C2E3373
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202078; cv=none; b=Gf8X3SDCcXzXd84EeWWTDIVOmfOzCqXnDpl+TPnhCHEY2NtfvhoHXZ1tqvwwJFcrJ2tUCWXCnnsOc+L+HUpZ+rVkKM+UtOtO7I3rLllH+rRJ/MEFQ+oyrdhJNP/dQj+TPi+ls4qwyFOLN/AjvDC7SlpuRRfRKdeM2Vkv7qmygvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202078; c=relaxed/simple;
	bh=pbajq5xRwv39EgJDJWaG9rD/vd/ESA5/w3PRxNpg0OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM440CH6Po+6WeNGVlO9ZALo0cJbp2hWe7mvRZDf5BB5V7vYeqn/CTjWguFQIcRz01tm7+IH6DG5UtcKZNLFr65Cr0KyPOl3B32Xz0lpgEQt7+J7dt54kSn7h8Xtmj3MfJopp5qYOHZXT/BbBhtXRB2QA4NPBZLGiNRDsyybBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T59YP1aF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5194AC4CEEF;
	Mon, 17 Mar 2025 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742202077;
	bh=pbajq5xRwv39EgJDJWaG9rD/vd/ESA5/w3PRxNpg0OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T59YP1aFdj0777b/zNMlZJ4nRYfFwIKAb6OA8Znex87gMq5UObpggv34Fx1o1+yHv
	 IqpC7xfvpIRmd9jtAOBemd0xXdq1re9QJ2QI1GvSpGakiG+0Rm2wPy0jr60S5Ef/JV
	 tPS1Y2LRyxTubmuGm7Ygvb1pIwQmHc9gtmJLQ/XnZ6J4W7B48hN71LQpBTFMI5V0px
	 qC0NL6OoWeSqqHowkfLUdDcz1vk/2vrB5lk5o0GTzbqOOjSCRqKzLzE8essgE9+I3N
	 BOe/niJPiAkPRK+5STJkIGmnZZHOB3tJyBx48SWXJNYp73kJ6q3XLmU+21VjIrTK58
	 RqyNyqtMcSsjw==
Date: Mon, 17 Mar 2025 10:01:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in
 __untagged_addr()
Message-ID: <Z9fk2NMBRHB9Eu5h@gmail.com>
References: <20250314093111.654359-1-ubizjak@gmail.com>
 <20250314112504.GBZ9QSEL1hgjp376ey@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314112504.GBZ9QSEL1hgjp376ey@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Mar 14, 2025 at 10:30:55AM +0100, Uros Bizjak wrote:
> > Use asm_inline() to instruct the compiler that the size of asm()
> > is the minimum size of one instruction, ignoring how many instructions
> > the compiler thinks it is. ALTERNATIVE macro that expands to several
> > pseudo directives causes instruction length estimate to count
> > more than 20 instructions.
> > 
> > bloat-o-meter reports minimal code size increase
> 
> If you see an increase and *no* *other* *palpable* improvement, you 
> don't send it. It is that simple.

Sorry, but you wouldn't be saying that eliminating function calls is 
not a 'palpable improvement', had you ever profiled a recent kernel on 
a real system, on modern CPUs ... :-/

The sad reality is that the top profile is dominated by function call + 
return overhead due to CPU bug mitigation workarounds that create per 
function call overhead:

 Overhead  Shared Object               Symbol
   4.57%  [kernel]                    [k] retbleed_return_thunk <============= !!!!!!!!
   4.40%  [kernel]                    [k] unmap_page_range
   4.31%  [kernel]                    [k] _copy_to_iter
   2.46%  [kernel]                    [k] memset_orig
   2.31%  libc.so.6                   [.] __cxa_finalize

That retbleed_return_thunk overhead gets avoided every time we inline a 
simple enough function.

But GCC cannot always do proper inlining decisions due to our 
complicated ALTERNATIVE macro constructs confusing the GCC inliner:

  > > ALTERNATIVE macro that expands to several pseudo directives causes 
  > > instruction length estimate to count more than 20 instructions.
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Note how the asm_inline() compiler feature was added by GCC at the 
kernel community's request to address such issues. (!)

So for those reasons, in my book, eliminating a function call for 
really simple single instruction inlines is an unconditional 
improvement that doesn't require futile performance measurements - it 
'only' requires assembly level code generation analysis in the 
changelog.

The reason is that requiring measurable effects for really small 
inlining changes is pretty much impossible in practice. I know, because 
I tried, and I'm good at measuring such things and I have the hardware 
to do it. Yet the per function call overhead demonstrated above in the 
profile is very much real and should not be handwaved away.

Note that this policy doesn't apply to other inlining decisions, only 
to single-instruction inline functions.

Also, having said all that, for this particular patch I'd still like to 
see a bit more GCC code generation analysis in this particular 
changelog: could you please cite a single relevant, representative 
example before/after assembly code section that demonstrates the 
effects of the inlined asm versus function call version, including the 
function that gets called?

I'm asking for that because sometimes single instructions can still 
have a halo of half a dozen of instructions that set them up or 
transform their results, so sometimes having a function call is the 
better option. Not all single-instruction asm() statements are 'simple' 
in praxis - but looking at the code generation will very much tell us 
whether it is.

Thanks,

	Ingo

