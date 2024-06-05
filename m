Return-Path: <linux-kernel+bounces-202068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 409288FC774
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6713D1C23694
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A060418FC79;
	Wed,  5 Jun 2024 09:15:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFA22E64C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578950; cv=none; b=H9I1uvp6NH35yym8FCXbiDfyyQnz1tGs92K/LDFbGLncD9oN+0qn/K6vDgK8D8AJXniWe9BhmimK9WPaXGhTOswW29EvqdGszu+FByD56bWv0C6TbnEbb4PRYwoOws0YJHJQsVuoYgQ2hPOXK+tbtHRpLXjWWKz6OtvgWK0ifD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578950; c=relaxed/simple;
	bh=5TAjuBCGjVExyQXh1O4nP9HxoQH9NcOk31CKCl4Uf9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJDZQsitcNI3ZjZZEYSlh6Gre8kd+wItdc3wEKWvu643OIn5UpROIoxxQmrwXjGkopWi/gCmaoH+eMS3yigWmmkKAWFkvK2bfIRgnUSEeu5Z9NYg0TUT/0QnI1I7SpzQ1z/kIPMlJxzjh4+H/cqGdxpOnuoi6AEnmNTyN7mMGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F8CDA7;
	Wed,  5 Jun 2024 02:16:11 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02EE33F792;
	Wed,  5 Jun 2024 02:15:44 -0700 (PDT)
Date: Wed, 5 Jun 2024 10:15:38 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] [v3] arm64/io: add constant-argument check
Message-ID: <ZmAsutGzL5_Kx8Pn@J2N7QTR9R3>
References: <20240604210006.668912-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604210006.668912-1-arnd@kernel.org>

On Tue, Jun 04, 2024 at 10:59:57PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In some configurations __const_iowrite32_copy() does not get inlined
> and gcc runs into the BUILD_BUG():
> 
> In file included from <command-line>:
> In function '__const_memcpy_toio_aligned32',
>     inlined from '__const_iowrite32_copy' at arch/arm64/include/asm/io.h:203:3,
>     inlined from '__const_iowrite32_copy' at arch/arm64/include/asm/io.h:199:20:
> include/linux/compiler_types.h:487:45: error: call to '__compiletime_assert_538' declared with attribute error: BUILD_BUG failed
>   487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                             ^
> include/linux/compiler_types.h:468:25: note: in definition of macro '__compiletime_assert'
>   468 |                         prefix ## suffix();                             \
>       |                         ^~~~~~
> include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
>   487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^~~~~~~~~~~~~~~~
> arch/arm64/include/asm/io.h:193:17: note: in expansion of macro 'BUILD_BUG'
>   193 |                 BUILD_BUG();
>       |                 ^~~~~~~~~
> 
> Move the check for constant arguments into the inline function to ensure
> it is still constant if the compiler decides against inlining it, and
> mark them as __always_inline to override the logic that sometimes leads
> to the compiler not producing the simplified output.
> 
> Note that either the __always_inline annotation or the check for a
> constant value are sufficient here, but combining the two looks cleaner
> as it also avoids the macro. With clang-8 and older, the macro was still
> needed, but all versions of gcc and clang can reliably perform constant
> folding here.
> 
> Fixes: ead79118dae6 ("arm64/io: Provide a WC friendly __iowriteXX_copy()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have a trivial nit below, but either way this looks good to me, so
regardless of that:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

> +static __always_inline void
> +__iowrite32_copy(void __iomem *to, const void *from, size_t count)
>  {
> -	if (count == 8 || count == 4 || count == 2 || count == 1) {
> +	if (__builtin_constant_p(count) &&
> +	    (count == 8 || count == 4 || count == 2 || count == 1)) {
>  		__const_memcpy_toio_aligned32(to, from, count);
>  		dgh();
>  	} else {
>  		__iowrite32_copy_full(to, from, count);
>  	}
>  }
> +#define __iowrite32_copy(to, from, count) __iowrite32_copy(to, from, count)

Normally we'd make this:

#define __iowrite32_copy __iowrite32_copy

... so that it's clear it's just providing the preprocessor symbol, and
doesn't have to be updated if the prototype changes.

[...]

> +#define __iowrite64_copy(to, from, count) __iowrite64_copy(to, from, count)

Likewise here.

Mark.

