Return-Path: <linux-kernel+bounces-422498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C049D9A58
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680B916545B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF61D61A1;
	Tue, 26 Nov 2024 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L95CPZIz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922C17591;
	Tue, 26 Nov 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634533; cv=none; b=dc5EAsMCfEgEHgjEhMxmnY45SQ56akEk/HYJe3+lIZvX62cwIFVsVIwH5e0CXNAn1oGAebkurvzkD/+jVZfITg1ABjhCfDFzFiMkFzQd5SfcRwrgP+xFA5VtDFST19HYRPzDnmxZDo6fPffY3KZjIegPmiqUfPUQLmneyRCuZmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634533; c=relaxed/simple;
	bh=cgH3zHue5Ei61rco8WHSD0R0509emBdq4BJb3Iq9v/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma/Bufe1KR5Z8HfkLeeA9UYTlb9JkN4OTDQg1q5Jxz61QwKRh+m7BgAZFZFrwMjWOgr63iuCXV9lpTAA/xyTn0dWYpmGXrP3vkZKS2EPqGSm1iw4J1TLT88vDmQ9//zWMwz/PxoHNxLkJVlySVGQtY+qrzWv5j8aHQcm0txhFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L95CPZIz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FSNZIGuhn3IkgzfUAm1ax9+Yyt5gadPutcbSFnNddbo=; b=L95CPZIz8gV5+As7zYvWO6+jHs
	rliwoJq26+SX+1qMfuONqDoP2s2VFWGLPiY6VS1oV5FDFtiGnCHhpWYD8yJvri3Xka6MOyGowKaQQ
	semTU11JZBqKoP4Us5FVk6wiwhsypb1jfMt0b7OJbwL9SiqG+NJNnthqEv8q/dublUwW1pAY1DdYf
	XFQwJdTo2oJ31bC4LqSDdwyIKPL3daRPUnZ8aAN8fKAAqMOi2E4QogT5U8kP+mx8E80qhAPlQ4RKB
	G4ZLgccglsZYOeDwJSyI0vnfTLPG/iqc3tsPj3gQpkqfv9CR8zyBl+oS9N5dBBu8qP/nYUjJow7Ce
	ONeTzfAg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFxOA-000000007J8-3cC1;
	Tue, 26 Nov 2024 15:22:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6274F3002A2; Tue, 26 Nov 2024 16:22:07 +0100 (CET)
Date: Tue, 26 Nov 2024 16:22:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] objtool: Handle special cases of dead end insn
Message-ID: <20241126152207.GR38972@noisy.programming.kicks-ass.net>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-3-yangtiezhu@loongson.cn>
 <20241126064513.bf6yq56eklyo4xvt@jpoimboe>
 <bb36374e-aca2-92e1-209d-1524e31147ab@loongson.cn>
 <20241126143243.GN38837@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126143243.GN38837@noisy.programming.kicks-ass.net>


> I was poking at the reachable annotations and ended up with this:

Also see here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core

Once the robots agree it all compiles, I'll post.

> --- a/arch/loongarch/include/asm/bug.h
> +++ b/arch/loongarch/include/asm/bug.h
> @@ -4,6 +4,7 @@
>  
>  #include <asm/break.h>
>  #include <linux/stringify.h>
> +#include <linux/objtool.h>
>  
>  #ifndef CONFIG_DEBUG_BUGVERBOSE
>  #define _BUGVERBOSE_LOCATION(file, line)
> @@ -37,21 +38,21 @@
>  
>  #define ASM_BUG()	ASM_BUG_FLAGS(0)
>  
> -#define __BUG_FLAGS(flags)					\
> -	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags)));
> +#define __BUG_FLAGS(flags, extra)					\
> +	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags))		\
> +			     extra);
>  
>  #define __WARN_FLAGS(flags)					\
>  do {								\
>  	instrumentation_begin();				\
> -	__BUG_FLAGS(BUGFLAG_WARNING|(flags));			\
> -	annotate_reachable();					\
> +	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ASM_REACHABLE);	\
>  	instrumentation_end();					\
>  } while (0)
>  
>  #define BUG()							\
>  do {								\
>  	instrumentation_begin();				\
> -	__BUG_FLAGS(0);						\
> +	__BUG_FLAGS(0, "");					\
>  	unreachable();						\
>  } while (0)
>  

