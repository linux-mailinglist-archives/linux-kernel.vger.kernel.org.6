Return-Path: <linux-kernel+bounces-271088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61708944956
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC651F24688
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B586616F8FE;
	Thu,  1 Aug 2024 10:32:02 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B13BBE5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508322; cv=none; b=N1BKB7f+Lq/8Qf+ApwU8mOmS5zB1Z/qYNDeeHIUYiehXS8r0FGMpdC5VLqGgKTfXM0kFw4+L5WWQNM5C8XKxEkl3tr2bROtwMDACmrnim580/H89cVIDFA2DpdSZ9My4nq3HCq9Lii4RXOwsp39cPnBRWm2vKsq67PAGNRGybAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508322; c=relaxed/simple;
	bh=I5zdceJP75vnDpixq4NTkrI1Pc6lZ6R0lEMRQT8eIWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHfHxOuP+UjAioZwCUrEHsA+idAH4revINblzrgjrCLMyVFjImQMQdKdXlrsb8lQJThQzgChn9r8Qth+Dz1/ccv5mz6EFG6EnPyeyYS31ZEnBXmIwTsgxt/aUZKH1e1nVXgL14T4BfF+wq4c/NF9ehzsIrPw7kIPxhNyTbULzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B9C760003;
	Thu,  1 Aug 2024 10:31:56 +0000 (UTC)
Message-ID: <0473d5ad-1d52-43e0-ade6-34c94212a220@ghiti.fr>
Date: Thu, 1 Aug 2024 12:31:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: Enable bitops instrumentation
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
Cc: Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org
References: <20240801033725.28816-1-samuel.holland@sifive.com>
 <20240801033725.28816-3-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240801033725.28816-3-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 01/08/2024 05:37, Samuel Holland wrote:
> Instead of implementing the bitops functions directly in assembly,
> provide the arch_-prefixed versions and use the wrappers from
> asm-generic to add instrumentation. This improves KASAN coverage and
> fixes the kasan_bitops_generic() unit test.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>   arch/riscv/include/asm/bitops.h | 43 ++++++++++++++++++---------------
>   1 file changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index 71af9ecfcfcb..fae152ea0508 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -222,44 +222,44 @@ static __always_inline int variable_fls(unsigned int x)
>   #define __NOT(x)	(~(x))
>   
>   /**
> - * test_and_set_bit - Set a bit and return its old value
> + * arch_test_and_set_bit - Set a bit and return its old value
>    * @nr: Bit to set
>    * @addr: Address to count from
>    *
>    * This operation may be reordered on other architectures than x86.
>    */
> -static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
> +static inline int arch_test_and_set_bit(int nr, volatile unsigned long *addr)
>   {
>   	return __test_and_op_bit(or, __NOP, nr, addr);
>   }
>   
>   /**
> - * test_and_clear_bit - Clear a bit and return its old value
> + * arch_test_and_clear_bit - Clear a bit and return its old value
>    * @nr: Bit to clear
>    * @addr: Address to count from
>    *
>    * This operation can be reordered on other architectures other than x86.
>    */
> -static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
> +static inline int arch_test_and_clear_bit(int nr, volatile unsigned long *addr)
>   {
>   	return __test_and_op_bit(and, __NOT, nr, addr);
>   }
>   
>   /**
> - * test_and_change_bit - Change a bit and return its old value
> + * arch_test_and_change_bit - Change a bit and return its old value
>    * @nr: Bit to change
>    * @addr: Address to count from
>    *
>    * This operation is atomic and cannot be reordered.
>    * It also implies a memory barrier.
>    */
> -static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
> +static inline int arch_test_and_change_bit(int nr, volatile unsigned long *addr)
>   {
>   	return __test_and_op_bit(xor, __NOP, nr, addr);
>   }
>   
>   /**
> - * set_bit - Atomically set a bit in memory
> + * arch_set_bit - Atomically set a bit in memory
>    * @nr: the bit to set
>    * @addr: the address to start counting from
>    *
> @@ -270,13 +270,13 @@ static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
>    * Note that @nr may be almost arbitrarily large; this function is not
>    * restricted to acting on a single-word quantity.
>    */
> -static inline void set_bit(int nr, volatile unsigned long *addr)
> +static inline void arch_set_bit(int nr, volatile unsigned long *addr)
>   {
>   	__op_bit(or, __NOP, nr, addr);
>   }
>   
>   /**
> - * clear_bit - Clears a bit in memory
> + * arch_clear_bit - Clears a bit in memory
>    * @nr: Bit to clear
>    * @addr: Address to start counting from
>    *
> @@ -284,13 +284,13 @@ static inline void set_bit(int nr, volatile unsigned long *addr)
>    * on non x86 architectures, so if you are writing portable code,
>    * make sure not to rely on its reordering guarantees.
>    */
> -static inline void clear_bit(int nr, volatile unsigned long *addr)
> +static inline void arch_clear_bit(int nr, volatile unsigned long *addr)
>   {
>   	__op_bit(and, __NOT, nr, addr);
>   }
>   
>   /**
> - * change_bit - Toggle a bit in memory
> + * arch_change_bit - Toggle a bit in memory
>    * @nr: Bit to change
>    * @addr: Address to start counting from
>    *
> @@ -298,40 +298,40 @@ static inline void clear_bit(int nr, volatile unsigned long *addr)
>    * Note that @nr may be almost arbitrarily large; this function is not
>    * restricted to acting on a single-word quantity.
>    */
> -static inline void change_bit(int nr, volatile unsigned long *addr)
> +static inline void arch_change_bit(int nr, volatile unsigned long *addr)
>   {
>   	__op_bit(xor, __NOP, nr, addr);
>   }
>   
>   /**
> - * test_and_set_bit_lock - Set a bit and return its old value, for lock
> + * arch_test_and_set_bit_lock - Set a bit and return its old value, for lock
>    * @nr: Bit to set
>    * @addr: Address to count from
>    *
>    * This operation is atomic and provides acquire barrier semantics.
>    * It can be used to implement bit locks.
>    */
> -static inline int test_and_set_bit_lock(
> +static inline int arch_test_and_set_bit_lock(
>   	unsigned long nr, volatile unsigned long *addr)
>   {
>   	return __test_and_op_bit_ord(or, __NOP, nr, addr, .aq);
>   }
>   
>   /**
> - * clear_bit_unlock - Clear a bit in memory, for unlock
> + * arch_clear_bit_unlock - Clear a bit in memory, for unlock
>    * @nr: the bit to set
>    * @addr: the address to start counting from
>    *
>    * This operation is atomic and provides release barrier semantics.
>    */
> -static inline void clear_bit_unlock(
> +static inline void arch_clear_bit_unlock(
>   	unsigned long nr, volatile unsigned long *addr)
>   {
>   	__op_bit_ord(and, __NOT, nr, addr, .rl);
>   }
>   
>   /**
> - * __clear_bit_unlock - Clear a bit in memory, for unlock
> + * arch___clear_bit_unlock - Clear a bit in memory, for unlock
>    * @nr: the bit to set
>    * @addr: the address to start counting from
>    *


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


> @@ -345,13 +345,13 @@ static inline void clear_bit_unlock(
>    * non-atomic property here: it's a lot more instructions and we still have to
>    * provide release semantics anyway.
>    */
> -static inline void __clear_bit_unlock(
> +static inline void arch___clear_bit_unlock(
>   	unsigned long nr, volatile unsigned long *addr)
>   {
> -	clear_bit_unlock(nr, addr);
> +	arch_clear_bit_unlock(nr, addr);
>   }
>   
> -static inline bool xor_unlock_is_negative_byte(unsigned long mask,
> +static inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
>   		volatile unsigned long *addr)
>   {
>   	unsigned long res;
> @@ -369,6 +369,9 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
>   #undef __NOT
>   #undef __AMO
>   
> +#include <asm-generic/bitops/instrumented-atomic.h>
> +#include <asm-generic/bitops/instrumented-lock.h>
> +
>   #include <asm-generic/bitops/non-atomic.h>
>   #include <asm-generic/bitops/le.h>
>   #include <asm-generic/bitops/ext2-atomic.h>

