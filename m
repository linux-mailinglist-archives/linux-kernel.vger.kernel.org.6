Return-Path: <linux-kernel+bounces-442319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B1B9EDADB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4AA28376A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F071F2383;
	Wed, 11 Dec 2024 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cX/GbAS/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA68632B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958360; cv=none; b=Q5oXuoXBcAx5v6CYl/6xldlzkZW36AKFhZ3R6cTQl6sWETaPYO+XuWKd0rh1Ao+Q7BqVC35acLOPnPwnkrYsvf7E0mXx4nIVnNYvSEIgYmuN97JHHTWWabnGvwq4I/iurLGUJVPZy4BhPjcDcnsU27rE7brb0+OlphlPQGj6Vb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958360; c=relaxed/simple;
	bh=D/4OJ69MBqLW9UdEk8TFc5RGulnOPkuAdNPYnSVMIac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Or2KOzikQEsNaHyCqO9OmP9dSkDUQACyhkbSX7yf+EgMvCEsHNCqHWBc7WgmFsHkTJIR57qFpvgk+fOGK8skqxztbDOwS7ZfvP5DHaOWDkXrcZTO1o9XMwUoD6AWWrEZ2LEsSCspz0+5VJUE0Q68eyB3w+v+PI9S2pAbRTO1pa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cX/GbAS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59987C4CEDE;
	Wed, 11 Dec 2024 23:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733958360;
	bh=D/4OJ69MBqLW9UdEk8TFc5RGulnOPkuAdNPYnSVMIac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cX/GbAS/A0B/JfjxH5FQQanmwvd8sFQzySl1gO4A9dHnzzAIP7vuxWBZIAu3YC8Ov
	 /3tl1eUg+5NJfTCey2Md6Iy8htWNy1RAthrQX08OwxNs8p208/nJ8Ql6Vf5vdXzWYM
	 q88EJb8tJQ7vt6+OvchMoa+yd66KP/s/JkQNezAsjlNn+GlkbPu+KzHEBUHwgWKG88
	 aGddGW+kpsmeLohp1ck4II8qz1LLkjP9vDXfm1A2V4iSMNk6ph0wFPfFuR+l7gwUUv
	 hk9rU02Vy784ZQ5vf/PuJ78omc0XF7Mm9WVFYvgj4Kx2JlKRRNMTHeaqLCU3uKer2v
	 TsAZI7I8eoscg==
Date: Wed, 11 Dec 2024 16:05:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Rong Xu <xur@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Yabin Cui <yabinc@google.com>,
	Will Deacon <will@kernel.org>, Han Shen <shenhan@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Propeller: Remove the architecture specific config
Message-ID: <20241211230553.GA3654215@ax162>
References: <20241211222945.1325793-1-xur@google.com>
 <20241211222945.1325793-2-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211222945.1325793-2-xur@google.com>

Hi Rong,

On Wed, Dec 11, 2024 at 02:29:43PM -0800, Rong Xu wrote:
> The CONFIG_PROPELLER_CLANG option currently depends on
> ARCH_SUPPORTS_PROPELLER_CLANG, but this dependency seems unnecessary.
> 
> Remove ARCH_SUPPORTS_PROPELLER_CLANG and allow users to control
> Propeller builds solely through CONFIG_PROPELLER_CLANG. This simplifies
> the kconfig and avoids potential confusion.
> 
> Signed-off-by: Rong Xu <xur@google.com>
> Suggested-by: Will Deacon <will@kernel.org>

In commit d5dc95836147 ("kbuild: Add Propeller configuration for kernel
build"), you added .llvm_bb_addr_map to arch/x86/kernel/vmlinux.lds.S.
Was this to address a orphan section warning from the linker? Is that
same change needed in the linker scripts of the other architectures that
clang supports building in the kernel?

Cheers,
Nathan

> ---
>  arch/Kconfig     | 4 ----
>  arch/x86/Kconfig | 1 -
>  2 files changed, 5 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 0b36d74d47031..83731b858ba65 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -828,12 +828,8 @@ config AUTOFDO_CLANG
>  
>  	  If unsure, say N.
>  
> -config ARCH_SUPPORTS_PROPELLER_CLANG
> -	bool
> -
>  config PROPELLER_CLANG
>  	bool "Enable Clang's Propeller build"
> -	depends on ARCH_SUPPORTS_PROPELLER_CLANG
>  	depends on CC_IS_CLANG && CLANG_VERSION >= 190000
>  	help
>  	  This option enables Clang’s Propeller build. When the Propeller
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9363d9cc9a00a..6c633d93c6390 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -128,7 +128,6 @@ config X86
>  	select ARCH_SUPPORTS_LTO_CLANG
>  	select ARCH_SUPPORTS_LTO_CLANG_THIN
>  	select ARCH_SUPPORTS_RT
> -	select ARCH_SUPPORTS_PROPELLER_CLANG    if X86_64
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
>  	select ARCH_USE_MEMTEST
> -- 
> 2.47.0.338.g60cca15819-goog
> 

