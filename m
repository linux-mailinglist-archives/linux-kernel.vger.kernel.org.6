Return-Path: <linux-kernel+bounces-249319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E5492E9F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E09C1F23C81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151BC160883;
	Thu, 11 Jul 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBffDW30"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258B15F40A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706033; cv=none; b=cM9pllK1b0NWazy0KJGxecOryYuRQmxQOGjcdOL+gWwD9v8VM8tCd0irr2Dv+BMnss4eMdtLSLZ9PZr3j7wjmQYIj5lU7f2QdO3/PLO5xVztZJc+Am7vxttrm59wZjQnvvidbJqzTK0AcVaK7QPYo3IG8FTyuWTKN26d0N+FGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706033; c=relaxed/simple;
	bh=d7eUnvpmqA007vMePeAhiRZGhhclqfU3sA2rSd2dSGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5K187Cp9lMPIiA49p9lbU+5Zwz8Nu9MIW3F9cie61JNyzuabPSTpvRqVM8IdPQbkQ0paZhhSHhjzxDoLHM84Z0M1GO+JvkEaaRCqbqfE9zGPrZ63ohwSTNobPxSY97zDBHEFWYu6dptj3epKr36sw9UQq8W46P09pcrKpnaRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBffDW30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23420C116B1;
	Thu, 11 Jul 2024 13:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720706032;
	bh=d7eUnvpmqA007vMePeAhiRZGhhclqfU3sA2rSd2dSGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kBffDW30SyBlZCqOGULzop3FoMuyN+QQ5auURLJHQ5kfGcoTU9L9BiiUyfwL0TSaQ
	 9FyJbO7q3Taqqe/b01urzCCS7eNXube/zETixa6xqPWAxNw0y2W8zPBksMpugkp3Xh
	 LqCNUaKK+sijkltj6+6l3z/RDT8/JrIY4cY7mpsMXX8m9k3JFDhWxB7BPzXudK9MYL
	 QXuBppwEKWmEaJnzivH29zNXl9lYQi4m0+phrN2TkuSEQAdR6LufjZtHVNOyNZhskw
	 5T/LmEct54eHM00gSnnslvBpv1DEFb/gsyCCQQ8a23/HuBXF3K3hL+AVQeIDVE8YMR
	 J6BbIo9b7etPA==
Date: Thu, 11 Jul 2024 15:53:43 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, James Morse <james.morse@arm.com>, Robin
 Murphy <robin.murphy@arm.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH v12 1/6] uaccess: add generic fallback version of
 copy_mc_to_user()
Message-ID: <20240711155343.3729bc30@foz.lan>
In-Reply-To: <20240528085915.1955987-2-tongtiangen@huawei.com>
References: <20240528085915.1955987-1-tongtiangen@huawei.com>
	<20240528085915.1955987-2-tongtiangen@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 28 May 2024 16:59:10 +0800
Tong Tiangen <tongtiangen@huawei.com> escreveu:

> x86/powerpc has it's implementation of copy_mc_to_user(), we add generic
> fallback in include/linux/uaccess.h prepare for other architechures to
> enable CONFIG_ARCH_HAS_COPY_MC.
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/uaccess.h | 1 +
>  arch/x86/include/asm/uaccess.h     | 1 +
>  include/linux/uaccess.h            | 8 ++++++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index de10437fd206..df42e6ad647f 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -381,6 +381,7 @@ copy_mc_to_user(void __user *to, const void *from, unsigned long n)
>  
>  	return n;
>  }
> +#define copy_mc_to_user copy_mc_to_user

Such define looks weird on my eyes. What to do you want to do here?

>  #endif
>  
>  extern long __copy_from_user_flushcache(void *dst, const void __user *src,
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 0f9bab92a43d..309f2439327e 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -497,6 +497,7 @@ copy_mc_to_kernel(void *to, const void *from, unsigned len);
>  
>  unsigned long __must_check
>  copy_mc_to_user(void __user *to, const void *from, unsigned len);
> +#define copy_mc_to_user copy_mc_to_user

Same here.

>  #endif
>  
>  /*
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 3064314f4832..0dfa9241b6ee 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -205,6 +205,14 @@ copy_mc_to_kernel(void *dst, const void *src, size_t cnt)
>  }
>  #endif
>  
> +#ifndef copy_mc_to_user
> +static inline unsigned long __must_check
> +copy_mc_to_user(void *dst, const void *src, size_t cnt)
> +{
> +	return copy_to_user(dst, src, cnt);
> +}
> +#endif
> +
>  static __always_inline void pagefault_disabled_inc(void)
>  {
>  	current->pagefault_disabled++;



Thanks,
Mauro

