Return-Path: <linux-kernel+bounces-291723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E61E9565E8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACD81F24EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FC215B54F;
	Mon, 19 Aug 2024 08:46:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B7415B140
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057163; cv=none; b=Pxtd2LQsHutgEzFeypXhhORVUfN9Q7sOzuluf7DJLAoY/0vQ2+3G9NjG0mMEn3yun3RI7QDj1UEgEx4WaRwh42Yre1LYi0tBTnzCfpNOfmPIGB/jU/Bcn5j1W3M+MA8uaWnsCQCuGJVuJRFXtiU1PbccaN+qcnKpXFT0fWzfGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057163; c=relaxed/simple;
	bh=oG3jcXluIRTj6zTJzQGWLMQyx/rQr1Wwjjq0VRofjoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKfifvEKS/wZ0lj7d0ilYAhwqvzTVxG574o8rfCsPEUbjiMSk5xAq0ZCPVEhZhErtCIFTLkzIIA2pEgkQsqbtOT1rq2ErhT7H8Hpf0Rll4uFC2AAhuSRzd4EqXLIKmrIzwysb/KaV9IlXZaXk0naSh1aA8Bzd3933iFejLxhZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9D881063;
	Mon, 19 Aug 2024 01:46:26 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F365E3F641;
	Mon, 19 Aug 2024 01:45:58 -0700 (PDT)
Date: Mon, 19 Aug 2024 09:45:56 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: cl@gentwo.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC] Avoid memory barrier in read_seqcount() through load
 acquire
Message-ID: <ZsMGRIec1y8hdKRG@J2N7QTR9R3.cambridge.arm.com>
References: <20240813-seq_optimize-v1-1-84d57182e6a7@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-seq_optimize-v1-1-84d57182e6a7@gentwo.org>

On Tue, Aug 13, 2024 at 11:26:17AM -0700, Christoph Lameter via B4 Relay wrote:
> From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
> 
> Some architectures support load acquire which can save us a memory
> barrier and save some cycles.
> 
> A typical sequence
> 
> 	do {
> 		seq = read_seqcount_begin(&s);
> 		<something>
> 	} while (read_seqcount_retry(&s, seq);
> 
> requires 13 cycles on ARM64 for an empty loop. Two read memory barriers are
> needed. One for each of the seqcount_* functions.
> 
> We can replace the first read barrier with a load acquire of
> the seqcount which saves us one barrier.
> 
> On ARM64 doing so reduces the cycle count from 13 to 8.

The patch itself looks reasonable to me, but in the commit message could
you please replace "ARM64" with the specific micro-architecture you're
testing on? There are tens of contemporary micro-architectures, and for
future reference it'd be good to know what specifically you've tested
on.

If you cannot disclose that for some reason, just say "on my ARM64 test
machine" or something like that, so that we're not implying that this is
true for all ARM64 implementations.

Mark.

> 
> Signed-off-by: Christoph Lameter (Ampere) <cl@gentwo.org>
> ---
>  arch/Kconfig            |  5 +++++
>  arch/arm64/Kconfig      |  1 +
>  include/linux/seqlock.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 975dd22a2dbd..3f8867110a57 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1600,6 +1600,11 @@ config ARCH_HAS_KERNEL_FPU_SUPPORT
>  	  Architectures that select this option can run floating-point code in
>  	  the kernel, as described in Documentation/core-api/floating-point.rst.
>  
> +config ARCH_HAS_ACQUIRE_RELEASE
> +	bool
> +	help
> +	  Architectures that support acquire / release can avoid memory fences
> +
>  source "kernel/gcov/Kconfig"
>  
>  source "scripts/gcc-plugins/Kconfig"
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a2f8ff354ca6..19e34fff145f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -39,6 +39,7 @@ config ARM64
>  	select ARCH_HAS_PTE_DEVMAP
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_HW_PTE_YOUNG
> +	select ARCH_HAS_ACQUIRE_RELEASE
>  	select ARCH_HAS_SETUP_DMA_OPS
>  	select ARCH_HAS_SET_DIRECT_MAP
>  	select ARCH_HAS_SET_MEMORY
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index d90d8ee29d81..353fcf32b800 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -176,6 +176,28 @@ __seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
>  	return seq;							\
>  }									\
>  									\
> +static __always_inline unsigned						\
> +__seqprop_##lockname##_sequence_acquire(const seqcount_##lockname##_t *s) \
> +{									\
> +	unsigned seq = smp_load_acquire(&s->seqcount.sequence);		\
> +									\
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
> +		return seq;						\
> +									\
> +	if (preemptible && unlikely(seq & 1)) {				\
> +		__SEQ_LOCK(lockbase##_lock(s->lock));			\
> +		__SEQ_LOCK(lockbase##_unlock(s->lock));			\
> +									\
> +		/*							\
> +		 * Re-read the sequence counter since the (possibly	\
> +		 * preempted) writer made progress.			\
> +		 */							\
> +		seq = smp_load_acquire(&s->seqcount.sequence);		\
> +	}								\
> +									\
> +	return seq;							\
> +}									\
> +									\
>  static __always_inline bool						\
>  __seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
>  {									\
> @@ -211,6 +233,11 @@ static inline unsigned __seqprop_sequence(const seqcount_t *s)
>  	return READ_ONCE(s->sequence);
>  }
>  
> +static inline unsigned __seqprop_sequence_acquire(const seqcount_t *s)
> +{
> +	return smp_load_acquire(&s->sequence);
> +}
> +
>  static inline bool __seqprop_preemptible(const seqcount_t *s)
>  {
>  	return false;
> @@ -259,6 +286,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
>  #define seqprop_ptr(s)			__seqprop(s, ptr)(s)
>  #define seqprop_const_ptr(s)		__seqprop(s, const_ptr)(s)
>  #define seqprop_sequence(s)		__seqprop(s, sequence)(s)
> +#define seqprop_sequence_acquire(s)	__seqprop(s, sequence_acquire)(s)
>  #define seqprop_preemptible(s)		__seqprop(s, preemptible)(s)
>  #define seqprop_assert(s)		__seqprop(s, assert)(s)
>  
> @@ -293,6 +321,18 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
>   *
>   * Return: count to be passed to read_seqcount_retry()
>   */
> +#ifdef CONFIG_ARCH_HAS_ACQUIRE_RELEASE
> +#define raw_read_seqcount_begin(s)					\
> +({									\
> +	unsigned _seq;							\
> +									\
> +	while ((_seq = seqprop_sequence_acquire(s)) & 1)		\
> +		cpu_relax();						\
> +									\
> +	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
> +	_seq;								\
> +})
> +#else
>  #define raw_read_seqcount_begin(s)					\
>  ({									\
>  	unsigned _seq = __read_seqcount_begin(s);			\
> @@ -300,6 +340,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
>  	smp_rmb();							\
>  	_seq;								\
>  })
> +#endif
>  
>  /**
>   * read_seqcount_begin() - begin a seqcount_t read critical section
> 
> ---
> base-commit: 6b4aa469f04999c3f244515fa7491b4d093c5167
> change-id: 20240813-seq_optimize-68c48696c798
> 
> Best regards,
> -- 
> Christoph Lameter <cl@gentwo.org>
> 
> 
> 

