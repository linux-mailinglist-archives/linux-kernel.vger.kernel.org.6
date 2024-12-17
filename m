Return-Path: <linux-kernel+bounces-449129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F19F4A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E96C7A5A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7831F03F4;
	Tue, 17 Dec 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P9y+rdi1"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95571E885A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436088; cv=none; b=nD3ZeqdRq1I5H0KIVGzbVcNDcUPVUKyfN9h4PujiW9LGMbUyTFz4mGCncvtH4/XrL4NkDvcH+DC7jD7pPPvXqkTj/SW432e9aFhns3+tb1/krTSwkd1PVfexVIFih1bJnvPDHlB9lVrMBIy6XOMf2Cdv7ebrwwfAyZIuzR/djQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436088; c=relaxed/simple;
	bh=V5UEA3MzUGeoi0SI/yCRE1EzVSr7elCKDaneHVGQdgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7nvRRJ9jacL+TZkNE0hJFS0Rp4VzZ5JUzP+nJfm90AHobXv7ZenFLphYSnj1swsCVu7IC++N2vlmSgukv3HdLD7JyfrPMuaFgSHw9LR96Z4QykutT90Imun8EmDe4MCg0GjDqjvq7ZnhOihETMCkgy3kEFj6J4RKf3b4uVddVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P9y+rdi1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wuzQZ1+bjHYEMnC29SliYY5nb4ADAY9D5z3rSyGxSDw=; b=P9y+rdi1I9EVyMnGk89f9S1Y+b
	T4GljzowXImHV6Fic1Vjpbn7kAHmAWFFAKzlJgrMqTyO5Mbgv4aQGpfx5YNVe60Pwws6d1CvbCVZo
	RgvUSNdVQcgplxVfWLk1bimkiBmyumJDpDX0n7Wf4NpLojXJWCAxz8GxHcfX6VT+vddtTuQb58Tp8
	Xana0cBJ5g2XLbsH5ODZwDN2oEo1Z/X6nK8YgWqqzK6UYJs80jYh40dc8lV3iDsoHJq+a+3GYw6BI
	/ujt94DnqmTn6GkQNoYa19V7cV6fCM1mQqnzxEgBHowC0uwf+5+qj9i4yLcpuEuNtE4CaO+L1LWgS
	uuFWNbOA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNW3R-000000054RP-21hL;
	Tue, 17 Dec 2024 11:47:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 98B8D30015F; Tue, 17 Dec 2024 12:47:56 +0100 (CET)
Date: Tue, 17 Dec 2024 12:47:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: avoid false-positive objtool warning in
 page_fault_oops()
Message-ID: <20241217114756.GE11133@noisy.programming.kicks-ass.net>
References: <20241217083059.1124426-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217083059.1124426-1-arnd@kernel.org>

On Tue, Dec 17, 2024 at 09:30:41AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When printing the oops for a VMAP_STACK overflow, the final call
> frompage_fault_oops() does not return to the original stack, which
> confuses gcc, and the unreachable() annotation leads to the end
> of the function just continuing on in the next one:
> 
> arch/x86/mm/fault.o: warning: objtool: page_fault_oops() falls through to next function kernelmode_fixup_or_oops.constprop.0()
> 
> To work around the warning, add an explicit endless loop here that
> objtool can detect.
> 
> Fixes: 6271cfdfc0e4 ("x86/mm: Improve stack-overflow #PF handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm not sure about this one, maybe there is a way for objtool to
> detect this and not warn?
> ---
>  arch/x86/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index e6c469b323cc..0ef6e3cc54d2 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -678,7 +678,7 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
>  			      ASM_CALL_ARG3,
>  			      , [arg1] "r" (regs), [arg2] "r" (address), [arg3] "r" (&info));
>  
> -		unreachable();
> +		do { } while (1); /* unreachable */

Ah, I have one that puts a BUG() there, like 2190966fbc14 ("x86: Convert
unreachable() to BUG()").

For some reason this hunk went missing from that patch.

