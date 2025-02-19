Return-Path: <linux-kernel+bounces-522369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C051FA3C93D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D82C7A72BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D4D22CBF3;
	Wed, 19 Feb 2025 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBTNa/sg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1E1ADC86;
	Wed, 19 Feb 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739995194; cv=none; b=O/Sas2Daq3kXBXH2JgswKUDfWckqwLwkTdD12I3pwBfiFj8aTWzlZEK3cinQLMx+v4QNN2lqfsygOikXGFhh7Hr6JLV1ILO4Orm32is7aIUhymrMOiQ8L5wOGz5v/RzlCbdQ2DValfjJR/7hxpNTT8cQqt9fvbvKiuXCAkbsrMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739995194; c=relaxed/simple;
	bh=PwPcZQF/rIBsEMFgDA+9vFHYmp1V9SB2sbkUVVp7/C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sITzWWyl8rRUU2UTK4wtuZp225tyn8HBBf2jG1tGWpbHjuq7WeHmbnK0edlhrrXqym1gBo5mfMtiPSMroknkezh1YnpWKiq4q3Hd3qesAA4FSdvQuOCwQZMlfKlp5EGpcQlsNV8oDs0/yMEF4OvU3XDqAZIUBFT3D54vrwOhglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBTNa/sg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671A8C4CED1;
	Wed, 19 Feb 2025 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739995193;
	bh=PwPcZQF/rIBsEMFgDA+9vFHYmp1V9SB2sbkUVVp7/C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBTNa/sgXYM6YjrU9USwMpRibd7GG/3zqHtVNXGdWWDYJG2kxzcj8WmV+UvfDKzY5
	 ZbotGmI6oxay4yta3j5WhR1dkUvryntxT4peWzYwYiPfnk7ytggJHCvHJAo2ZtYEuN
	 5W4skWIhbZ4BrVrnzJdgvjo0A/ofj7CUMaXfdU+vNwtFSQlI6mzlNixt/t59ukuXRt
	 XXk3j/8dMdVhYIbDKdzS3/ITWVdq5Noau1BOtvR7Ok29cCpdjezKUSFFHq0JjcRpVp
	 CZlyt8lVvnxZtxMwbgX0PICdFlCm8r7Us0Ut/OqAQS3Wge+y8c0Fy++tGvR+a+Up7j
	 qMxcKTnWXVl6w==
Date: Wed, 19 Feb 2025 12:59:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v6 07/15] x86/stackprotector/64: Convert to normal percpu
 variable
Message-ID: <20250219195948.GA3075960@ax162>
References: <20250123190747.745588-1-brgerst@gmail.com>
 <20250123190747.745588-8-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123190747.745588-8-brgerst@gmail.com>

On Thu, Jan 23, 2025 at 02:07:39PM -0500, Brian Gerst wrote:
> Older versions of GCC fixed the location of the stack protector canary
> at %gs:40.  This constraint forced the percpu section to be linked at
> absolute address 0 so that the canary could be the first data object in
> the percpu section.  Supporting the zero-based percpu section requires
> additional code to handle relocations for RIP-relative references to
> percpu data, extra complexity to kallsyms, and workarounds for linker
> bugs due to the use of absolute symbols.
> 
> GCC 8.1 supports redefining where the canary is located, allowng it to
> become a normal percpu variable instead of at a fixed location.  This
> removes the contraint that the percpu section must be zero-based.
> 
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
...
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 5b773b34768d..88a1705366f9 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -140,14 +140,7 @@ ifeq ($(CONFIG_X86_32),y)
>          # temporary until string.h is fixed
>          KBUILD_CFLAGS += -ffreestanding
>  
> -    ifeq ($(CONFIG_STACKPROTECTOR),y)
> -        ifeq ($(CONFIG_SMP),y)
> -            KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
> -                             -mstack-protector-guard-symbol=__ref_stack_chk_guard
> -        else
> -            KBUILD_CFLAGS += -mstack-protector-guard=global
> -        endif
> -    endif
> +        percpu_seg := fs
>  else
>          BITS := 64
>          UTS_MACHINE := x86_64
> @@ -197,6 +190,17 @@ else
>          KBUILD_CFLAGS += -mcmodel=kernel
>          KBUILD_RUSTFLAGS += -Cno-redzone=y
>          KBUILD_RUSTFLAGS += -Ccode-model=kernel
> +
> +        percpu_seg := gs
> +endif
> +
> +ifeq ($(CONFIG_STACKPROTECTOR),y)
> +    ifeq ($(CONFIG_SMP),y)
> +	KBUILD_CFLAGS += -mstack-protector-guard-reg=$(percpu_seg)
> +	KBUILD_CFLAGS += -mstack-protector-guard-symbol=__ref_stack_chk_guard
> +    else
> +	KBUILD_CFLAGS += -mstack-protector-guard=global
> +    endif
>  endif

-mstack-protector-guard-symbol was only added in clang-15, so it looks
like min-tool-version.sh will need an adjustment like GCC did, should I
send a patch?

https://github.com/llvm/llvm-project/commit/efbaad1c4a526e91b034e56386e98a9268cd87b2

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 06c4e410ecab..787868183b84 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -26,7 +26,7 @@ gcc)
 	fi
 	;;
 llvm)
-	if [ "$SRCARCH" = s390 ]; then
+	if [ "$SRCARCH" = s390 -o "$SRCARCH" = x86 ]; then
 		echo 15.0.0
 	elif [ "$SRCARCH" = loongarch ]; then
 		echo 18.0.0

