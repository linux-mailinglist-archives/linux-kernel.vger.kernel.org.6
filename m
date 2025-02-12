Return-Path: <linux-kernel+bounces-511658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43CFA32DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDBB3A54AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453E25D520;
	Wed, 12 Feb 2025 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWa+OM52"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA23D256C70;
	Wed, 12 Feb 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382625; cv=none; b=gLRcqFUvSoJxdiH3/Lkr6KHAplnwckZ1auUhFDATofXDUCa1rAjVRhr0xJAGuSgxSqlVFCXWw7kZWlDUuOMwTw+98Eb4YzvUlcW9CVBVxiLI7Gj4fj5XiNYo00WCm1JFAAejkG68OUp7lI62E+zuzhSP0wclbofs+E9I6Tfto4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382625; c=relaxed/simple;
	bh=xZvmmxew4CnhVqjM32U7p1D3znh9FIGOmHRpkoJl+O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oey58aCzr9Y2oOU6t5AVymnNRThDn2I3N1JkBv4zgk+jBoY+v/YHRKSYjbAJ1dovwYlvgND4G8h+dQJOt/B4kOtmz6WLsVq7ZTg7TxfOQndi7WBHmiVhWKt5YRIeiOCsCBkenCUPeGn1XQMa/SMV+kYf7bVkIIwhvsLLgzzshYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWa+OM52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323D4C4CEDF;
	Wed, 12 Feb 2025 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739382625;
	bh=xZvmmxew4CnhVqjM32U7p1D3znh9FIGOmHRpkoJl+O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWa+OM52DiG+6GoAzl1LIYXjxX/CLkKVjY6vHemgp0d4lV5GJxy/g8VgMFLYWzLyt
	 eHRpejIBOXOXD5o35m7QidDjGM4BQrUAScmMDVilQJtP0YkRij6WEdgapWB9l72OMU
	 nga9wS8mQLfiQqG3566va5z+TV3He/FKXMokoTf2kJNxW83jA44FLo2cHYyaioeyfL
	 gkatAg9EYsf8SD8DBxkRGPF133MyNrvPvpvKPAfKt8rVffm2dVIcB8PNnTAPUFMSIz
	 v3vVIzKwRLg+46JuJgANUHlIAKvUvqv+W4a4/qa5ZCmmRwd/cJRGt1k4ePNfQFZ/z7
	 sj8uqZXxsxohA==
Date: Wed, 12 Feb 2025 09:50:23 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH] compiler.h: Specify correct attribute for
 .rodata..c_jump_table
Message-ID: <20250212175023.rsxsw7pno57gsxps@jpoimboe>
References: <20240924062710.1243-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924062710.1243-1-yangtiezhu@loongson.cn>

On Tue, Sep 24, 2024 at 02:27:10PM +0800, Tiezhu Yang wrote:
> Currently, there is an assembler message when generating kernel/bpf/core.o
> under CONFIG_OBJTOOL with LoongArch compiler toolchain:
> 
>   Warning: setting incorrect section attributes for .rodata..c_jump_table
> 
> This is because the section ".rodata..c_jump_table" should be readonly,
> but there is a "W" (writable) part of the flags:
> 
>   $ readelf -S kernel/bpf/core.o | grep -A 1 "rodata..c"
>   [34] .rodata..c_j[...] PROGBITS         0000000000000000  0000d2e0
>        0000000000000800  0000000000000000  WA       0     0     8
> 
> There is no above issue on x86 due to the generated section flag is only
> "A" (allocatable). In order to silence the warning on LoongArch, specify
> the attribute like ".rodata..c_jump_table,\"a\",@progbits #" explicitly,
> then the section attribute of ".rodata..c_jump_table" must be readonly
> in the kernel/bpf/core.o file.
> 
> Before:
> 
>   $ objdump -h kernel/bpf/core.o | grep -A 1 "rodata..c"
>    21 .rodata..c_jump_table 00000800  0000000000000000  0000000000000000  0000d2e0  2**3
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
> 
> After:
> 
>   $ objdump -h kernel/bpf/core.o | grep -A 1 "rodata..c"
>    21 .rodata..c_jump_table 00000800  0000000000000000  0000000000000000  0000d2e0  2**3
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
> 
> By the way, AFAICT, maybe the root cause is related with the different
> compiler behavior of various archs, so to some extent this change is a
> workaround for LoongArch, and also there is no effect for x86 which is
> the only port supported by objtool before LoongArch with this patch.

Right, this sounds like a bug in the GNU assembler.  It should default
to the same section flags regardless of arch.

> 
> Cc: stable@vger.kernel.org # 6.9+
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index ec55bcce4146..4d4e23b6e3e7 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -133,7 +133,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  #define annotate_unreachable() __annotate_unreachable(__COUNTER__)
>  
>  /* Annotate a C jump table to allow objtool to follow the code flow */
> -#define __annotate_jump_table __section(".rodata..c_jump_table")
> +#define __annotate_jump_table __section(".rodata..c_jump_table,\"a\",@progbits #")

This caused a regression, this hack apparently doesn't work with Clang:

  $ readelf -WS kernel/bpf/core.o | grep c_jump_table
    [43] .rodata..c_jump_table,"a",@progbits # PROGBITS        0000000000000000 00d610 000800 00   A  0   0 16

Notice the section name is literally:

  .rodata..c_jump_table,"a",@progbits #

-- 
Josh

