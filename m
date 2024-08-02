Return-Path: <linux-kernel+bounces-272142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EFE9457BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5F21C229E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DFC29D19;
	Fri,  2 Aug 2024 05:45:49 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49115AC4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577549; cv=none; b=qQTnxoSssPm2j+CmB7zU82PjCc0SDOIiANhLaBfk2F9vX2Lv7mjCNDz+dEiTG06vXhee/2gB80BB/aY1AY5TYCxyeG4s5xIJaj2RfKo1T8iQldTvRuqpuW5Zg4Rc4FKyTVSUxm58ifI/+CMSHk7duLc4V2jxUDzQ3iqXOzlhUl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577549; c=relaxed/simple;
	bh=+MOL3gH25GeUJGo4fHuAbtxjahnLd+b5Ub9B9uvapos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgP5EYvA+af0/lKg0EIim5x7nk6NVDRZ5wnQLBKotEnDQW3FQVd1qaEqnPChW4KDrrFI2yqSHH/UV1Dap5iCnlMtJ1aIjnYWwRzGHx5PDN0GDOgXD/M32U4C3k+XKUBKu/+jo9q9biOM14wQ6su9SAFCtIc+/uJGlOBlpE+5s+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED941C0002;
	Fri,  2 Aug 2024 05:45:38 +0000 (UTC)
Message-ID: <16be871d-a52e-4b1d-b579-71ec03a0c81d@ghiti.fr>
Date: Fri, 2 Aug 2024 07:45:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: support KASAN instrumentation of bitops
Content-Language: en-US
To: Qingfang Deng <dqfext@gmail.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Qingfang Deng <qingfang.deng@siflower.com.cn>
References: <20240802040506.712-1-dqfext@gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240802040506.712-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Qingfang,

On 02/08/2024 06:05, Qingfang Deng wrote:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
>
> The arch-specific bitops are not being picked up by the KASAN test
> suite.
>
> Instrumentation is done via the bitops/instrumented-{atomic,lock}.h
> headers. They require that arch-specific versions of bitop functions
> are renamed to arch_*. Do this renaming.
>
> As most comments are identical to the ones in the instrumented headers,
> remove them.
>
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
>   arch/riscv/include/asm/bitops.h | 100 +++++---------------------------
>   1 file changed, 15 insertions(+), 85 deletions(-)
>
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index 71af9ecfcfcb..44ff3114c112 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -221,134 +221,62 @@ static __always_inline int variable_fls(unsigned int x)
>   #define __NOP(x)	(x)
>   #define __NOT(x)	(~(x))
>   
> -/**
> - * test_and_set_bit - Set a bit and return its old value
> - * @nr: Bit to set
> - * @addr: Address to count from
> - *
> - * This operation may be reordered on other architectures than x86.
> - */
> -static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
> +static inline int arch_test_and_set_bit(int nr, volatile unsigned long *addr)
>   {
>   	return __test_and_op_bit(or, __NOP, nr, addr);
>   }
>   
> -/**
> - * test_and_clear_bit - Clear a bit and return its old value
> - * @nr: Bit to clear
> - * @addr: Address to count from
> - *
> - * This operation can be reordered on other architectures other than x86.
> - */
> -static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
> +static inline int arch_test_and_clear_bit(int nr, volatile unsigned long *addr)
>   {
>   	return __test_and_op_bit(and, __NOT, nr, addr);
>   }
>   
> -/**
> - * test_and_change_bit - Change a bit and return its old value
> - * @nr: Bit to change
> - * @addr: Address to count from
> - *
> - * This operation is atomic and cannot be reordered.
> - * It also implies a memory barrier.
> - */
> -static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
> +static inline int arch_test_and_change_bit(int nr, volatile unsigned long *addr)
>   {
>   	return __test_and_op_bit(xor, __NOP, nr, addr);
>   }
>   
> -/**
> - * set_bit - Atomically set a bit in memory
> - * @nr: the bit to set
> - * @addr: the address to start counting from
> - *
> - * Note: there are no guarantees that this function will not be reordered
> - * on non x86 architectures, so if you are writing portable code,
> - * make sure not to rely on its reordering guarantees.
> - *
> - * Note that @nr may be almost arbitrarily large; this function is not
> - * restricted to acting on a single-word quantity.
> - */
> -static inline void set_bit(int nr, volatile unsigned long *addr)
> +static inline void arch_set_bit(int nr, volatile unsigned long *addr)
>   {
>   	__op_bit(or, __NOP, nr, addr);
>   }
>   
> -/**
> - * clear_bit - Clears a bit in memory
> - * @nr: Bit to clear
> - * @addr: Address to start counting from
> - *
> - * Note: there are no guarantees that this function will not be reordered
> - * on non x86 architectures, so if you are writing portable code,
> - * make sure not to rely on its reordering guarantees.
> - */
> -static inline void clear_bit(int nr, volatile unsigned long *addr)
> +static inline void arch_clear_bit(int nr, volatile unsigned long *addr)
>   {
>   	__op_bit(and, __NOT, nr, addr);
>   }
>   
> -/**
> - * change_bit - Toggle a bit in memory
> - * @nr: Bit to change
> - * @addr: Address to start counting from
> - *
> - * change_bit()  may be reordered on other architectures than x86.
> - * Note that @nr may be almost arbitrarily large; this function is not
> - * restricted to acting on a single-word quantity.
> - */
> -static inline void change_bit(int nr, volatile unsigned long *addr)
> +static inline void arch_change_bit(int nr, volatile unsigned long *addr)
>   {
>   	__op_bit(xor, __NOP, nr, addr);
>   }
>   
> -/**
> - * test_and_set_bit_lock - Set a bit and return its old value, for lock
> - * @nr: Bit to set
> - * @addr: Address to count from
> - *
> - * This operation is atomic and provides acquire barrier semantics.
> - * It can be used to implement bit locks.
> - */
> -static inline int test_and_set_bit_lock(
> +static inline int arch_test_and_set_bit_lock(
>   	unsigned long nr, volatile unsigned long *addr)
>   {
>   	return __test_and_op_bit_ord(or, __NOP, nr, addr, .aq);
>   }
>   
> -/**
> - * clear_bit_unlock - Clear a bit in memory, for unlock
> - * @nr: the bit to set
> - * @addr: the address to start counting from
> - *
> - * This operation is atomic and provides release barrier semantics.
> - */
> -static inline void clear_bit_unlock(
> +static inline void arch_clear_bit_unlock(
>   	unsigned long nr, volatile unsigned long *addr)
>   {
>   	__op_bit_ord(and, __NOT, nr, addr, .rl);
>   }
>   
>   /**
> - * __clear_bit_unlock - Clear a bit in memory, for unlock
> - * @nr: the bit to set
> - * @addr: the address to start counting from
> + * arch___clear_bit_unlock - Clear a bit in memory, for unlock
>    *
> - * This operation is like clear_bit_unlock, however it is not atomic.
> - * It does provide release barrier semantics so it can be used to unlock
> - * a bit lock, however it would only be used if no other CPU can modify
> - * any bits in the memory until the lock is released (a good example is
> - * if the bit lock itself protects access to the other bits in the word).
> + * This should not be used directly, use the instrumented __clear_bit_unlock
> + * instead. See asm-generic/bitops/instrumented-lock.h
>    *
>    * On RISC-V systems there seems to be no benefit to taking advantage of the
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
>   static inline bool xor_unlock_is_negative_byte(unsigned long mask,
> @@ -369,6 +297,8 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
>   #undef __NOT
>   #undef __AMO
>   
> +#include <asm-generic/bitops/instrumented-atomic.h>
> +#include <asm-generic/bitops/instrumented-lock.h>
>   #include <asm-generic/bitops/non-atomic.h>
>   #include <asm-generic/bitops/le.h>
>   #include <asm-generic/bitops/ext2-atomic.h>


Samuel has just posted a similar patch here 
https://lore.kernel.org/linux-riscv/20240801033725.28816-1-samuel.holland@sifive.com/T/#t

Thanks,

Alex


