Return-Path: <linux-kernel+bounces-423862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950549DAD94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6490E168D50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391DB202F67;
	Wed, 27 Nov 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD3PcH9U"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3720125C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734375; cv=none; b=j1S0t3JDhIZIKanfPOUfPTHfFgxjMM9pLKJSpRZZA4etWKgqx+u1DUY+F5LvyLV9lZrRKLk+q+79zz/WdM6N0g1TLuMFJwzKkvpWEkIZ3JsOCxAYiUoa87chBfpZVI/nSSeAzPeMoN5j/pO8NP5nJe0yFU77s0D2qAEH+Cil2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734375; c=relaxed/simple;
	bh=R1AfY708jXdHmbfLByxg5ZttNT2kjrD7QHd6g5PwSEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsbcqJ7KN8H55cHfqVGJkJL2VlyWmdtHE5/mzZgLVWwBUJRixgqy5NeVZDV7nVqy+OzH+LBTJsn+PKS313MS8v8BmQxScGOe3PYdZse6AmkHRvQBOMdvkODqLNvFkUgqTnwKg7rhVTNCrCs+XttuClig+j/0Kzt56RE4ieJC4hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD3PcH9U; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fbd76941ccso3731095a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732734373; x=1733339173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgXnDYjeious6Mn9ABnjIVdAyLz/oUf564mThG/grAY=;
        b=TD3PcH9UCceHHleHtGPq83dqo8PRXTjnmtXCwj9IMqPpsM2iv5TPnaFdBkndRrPZaX
         OqME7mtEJH+PZ7Y7k4TU/U8s2KoqTZtJHcvE+0yAP+jwiSxjo7PzptOaLcVQ241m3cXA
         CZco3rdl5luIBaoDX8Ar0QjagdwbhCuzy37TZN/9Wl1rYpqz8iD1AKSddXNkFgMLOg2g
         cAFTNS6u7biu0hvxN1MKqt2bpckswww6gTBLLiZJXtPRmMt49uL9wUsjWrk+OwT96kRX
         qZwW8YZ5YoH7e7rk0hFG9uCnYz/cOo70HRazlDIsmrO9u6Q1fnwaj5JCGEi12JIPSQp4
         xE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732734373; x=1733339173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgXnDYjeious6Mn9ABnjIVdAyLz/oUf564mThG/grAY=;
        b=YBrAmRIMgskUAJfcgWB3IiP4PdO+7u88hsiKGmNUHlvSAFzQuuMDOx++fTSPJJix/g
         nNYTB+u0lKMTUjRT+jfyWBC1BO6jbKX/BP8RHFN/P9qUDgEJJWg8th64gklkAl2/yC3c
         rYM11UyvLKpztbJPcpdV6C0hiAvO1tMD+apj7SuQLaP1xCQhdnbPaY2yelkRYLuO4Ie9
         hEYM3iIqYv37fOs7af48MzkuWo6XR2GJVh1mt7P88vkNEDr3Lsn83IJpdRtI0UQk/UCI
         8dv8s5ohE7lXjAL9IAVqBfvwf7XjWrqsrB/i5r94KCaPPuVczcCjWVaI0BfeX4anTbBz
         ip9A==
X-Forwarded-Encrypted: i=1; AJvYcCUD57j9V7tLi+hOQjc9FgvqWBQvqygEzXnz8ajpIeglzBxUXbzTYc8wMovus5ufnF0rg7KC9M9Uop0d8F4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1byUAXvik4NbuZG8L5lTiK/qc1gZci8MNSou1mLQeGzgo46T
	H3RSx9F76tXe+0/GCE0skkb1dA0jmsGRD8STdO9owLN/34JN4ojB
X-Gm-Gg: ASbGnct9FinGLI3tWwLUoGjq9AmqHilQDsMhicDJyX4eSB3EA0W0RIPEVMaAYq4GvQb
	+6KY0NHIQC0TzbJvbr4KVkDpHMlfNtF9IDVJQpPjmzBYrMGFRmh4U2AK0/w85+0wa5pIJF6MyJ9
	LvQK8iqjnRp4Q9wrvrSoLdOEX76qjMtWx2X1eCAP1Orkq2246kblimXawrAf3vzOJRFdUM8eQ8X
	DDCDE66UfnWm6bySKC9Rvs8tleiHVa5ufQndkAkxJ51KQY3fg==
X-Google-Smtp-Source: AGHT+IEXoQP6bH9Kzyt4UUpfN2R0wNZnbQ/Gg5zUP2GZDnuGrLc0kFHcLCx0kZmRMXyA8zVMS069QQ==
X-Received: by 2002:a17:90b:1dc7:b0:2ea:853b:276d with SMTP id 98e67ed59e1d1-2ee08fca57fmr6226817a91.17.1732734372920;
        Wed, 27 Nov 2024 11:06:12 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fad03f2sm1936721a91.36.2024.11.27.11.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 11:06:12 -0800 (PST)
Date: Wed, 27 Nov 2024 11:06:10 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] riscv: Always inline bitops
Message-ID: <Z0dtohAlZqad841q@yury-ThinkPad>
References: <20241123-riscv-always-inline-bitops-v1-1-00e8262ab1cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123-riscv-always-inline-bitops-v1-1-00e8262ab1cf@kernel.org>

On Sat, Nov 23, 2024 at 07:30:19PM -0700, Nathan Chancellor wrote:
> When building allmodconfig + ThinLTO with certain versions of clang,
> arch_set_bit() may not be inlined, resulting in a modpost warning:
> 
>   WARNING: modpost: vmlinux: section mismatch in reference: arch_set_bit+0x58 (section: .text.arch_set_bit) -> numa_nodes_parsed (section: .init.data)
> 
> acpi_numa_rintc_affinity_init() calls arch_set_bit() via __node_set()
> with numa_nodes_parsed, which is marked as __initdata. If arch_set_bit()
> is not inlined, modpost will flag that it is being called with data that
> will be freed after init.
> 
> As acpi_numa_rintc_affinity_init() is marked as __init, there is not
> actually a functional issue here. However, the bitop functions should be
> marked as __always_inline, so that they work consistently for init and
> non-init code, which the comment in include/linux/nodemask.h alludes to.
> This matches s390 and x86's implementations.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied, thanks!

So we have generic, x86 and riscv bitops inlined, and powerpc and s390
non-inlined. We need to align them all, I think.

Thanks,
Yury

> ---
>  arch/riscv/include/asm/bitops.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index fae152ea0508d2e1ea490fffd645eab99cf387bf..c6bd3d8354a96b4e7bbef0e98a201da412301b57 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -228,7 +228,7 @@ static __always_inline int variable_fls(unsigned int x)
>   *
>   * This operation may be reordered on other architectures than x86.
>   */
> -static inline int arch_test_and_set_bit(int nr, volatile unsigned long *addr)
> +static __always_inline int arch_test_and_set_bit(int nr, volatile unsigned long *addr)
>  {
>  	return __test_and_op_bit(or, __NOP, nr, addr);
>  }
> @@ -240,7 +240,7 @@ static inline int arch_test_and_set_bit(int nr, volatile unsigned long *addr)
>   *
>   * This operation can be reordered on other architectures other than x86.
>   */
> -static inline int arch_test_and_clear_bit(int nr, volatile unsigned long *addr)
> +static __always_inline int arch_test_and_clear_bit(int nr, volatile unsigned long *addr)
>  {
>  	return __test_and_op_bit(and, __NOT, nr, addr);
>  }
> @@ -253,7 +253,7 @@ static inline int arch_test_and_clear_bit(int nr, volatile unsigned long *addr)
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static inline int arch_test_and_change_bit(int nr, volatile unsigned long *addr)
> +static __always_inline int arch_test_and_change_bit(int nr, volatile unsigned long *addr)
>  {
>  	return __test_and_op_bit(xor, __NOP, nr, addr);
>  }
> @@ -270,7 +270,7 @@ static inline int arch_test_and_change_bit(int nr, volatile unsigned long *addr)
>   * Note that @nr may be almost arbitrarily large; this function is not
>   * restricted to acting on a single-word quantity.
>   */
> -static inline void arch_set_bit(int nr, volatile unsigned long *addr)
> +static __always_inline void arch_set_bit(int nr, volatile unsigned long *addr)
>  {
>  	__op_bit(or, __NOP, nr, addr);
>  }
> @@ -284,7 +284,7 @@ static inline void arch_set_bit(int nr, volatile unsigned long *addr)
>   * on non x86 architectures, so if you are writing portable code,
>   * make sure not to rely on its reordering guarantees.
>   */
> -static inline void arch_clear_bit(int nr, volatile unsigned long *addr)
> +static __always_inline void arch_clear_bit(int nr, volatile unsigned long *addr)
>  {
>  	__op_bit(and, __NOT, nr, addr);
>  }
> @@ -298,7 +298,7 @@ static inline void arch_clear_bit(int nr, volatile unsigned long *addr)
>   * Note that @nr may be almost arbitrarily large; this function is not
>   * restricted to acting on a single-word quantity.
>   */
> -static inline void arch_change_bit(int nr, volatile unsigned long *addr)
> +static __always_inline void arch_change_bit(int nr, volatile unsigned long *addr)
>  {
>  	__op_bit(xor, __NOP, nr, addr);
>  }
> @@ -311,7 +311,7 @@ static inline void arch_change_bit(int nr, volatile unsigned long *addr)
>   * This operation is atomic and provides acquire barrier semantics.
>   * It can be used to implement bit locks.
>   */
> -static inline int arch_test_and_set_bit_lock(
> +static __always_inline int arch_test_and_set_bit_lock(
>  	unsigned long nr, volatile unsigned long *addr)
>  {
>  	return __test_and_op_bit_ord(or, __NOP, nr, addr, .aq);
> @@ -324,7 +324,7 @@ static inline int arch_test_and_set_bit_lock(
>   *
>   * This operation is atomic and provides release barrier semantics.
>   */
> -static inline void arch_clear_bit_unlock(
> +static __always_inline void arch_clear_bit_unlock(
>  	unsigned long nr, volatile unsigned long *addr)
>  {
>  	__op_bit_ord(and, __NOT, nr, addr, .rl);
> @@ -345,13 +345,13 @@ static inline void arch_clear_bit_unlock(
>   * non-atomic property here: it's a lot more instructions and we still have to
>   * provide release semantics anyway.
>   */
> -static inline void arch___clear_bit_unlock(
> +static __always_inline void arch___clear_bit_unlock(
>  	unsigned long nr, volatile unsigned long *addr)
>  {
>  	arch_clear_bit_unlock(nr, addr);
>  }
>  
> -static inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
> +static __always_inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
>  		volatile unsigned long *addr)
>  {
>  	unsigned long res;
> 
> ---
> base-commit: 0eb512779d642b21ced83778287a0f7a3ca8f2a1
> change-id: 20241123-riscv-always-inline-bitops-0021c4dae36b
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>

