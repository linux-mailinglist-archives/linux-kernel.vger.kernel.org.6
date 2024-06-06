Return-Path: <linux-kernel+bounces-205144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B118FF7FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464DA1F22816
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1EA13DDAA;
	Thu,  6 Jun 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="S/wPepcZ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B313E3EE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715640; cv=none; b=YOaxjxO/7N2p8IsbFXoIwZ6jqS2U+JTNJQBTd8P5T/dk5fav7VYlHPO4+SF1hmrThqDkfBIhe4UDtM+9kzp5YRjD8C5JcRwbQaeeFBQVFpOF4OfuPkGUJCrEe6ur5AXLDEmqzXh3tPfDLCMv+I3u0A2CC5NaYAWow8TQE9v67eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715640; c=relaxed/simple;
	bh=1c1S50xBijbFKp1sGw4abfVbdDDm4cBBN3jXn3+dT9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWxvOiIsVvLqX0NXBTlmrL78xrGYZZPAlWr6IoHoXEba6vusuh0ga+wUX+GvCPby2N9Pq6zK27dSki/YHz1pKJApc/hLdOc49k3m37xmLe0/lchKNkCgxnPi+7RRof5rM/LKmn0+waP3WS2k8CafoRKDmn5lEDHwae7ZTfF7r5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=S/wPepcZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-703f1e39c07so1247199b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717715638; x=1718320438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pFORmSYxBFghq+sxU2O43udLz9imyeDUrV9JdpKSDhY=;
        b=S/wPepcZsFdUP4wZXcgotIEFrI0I27bNpC4xLyqrXjpdCnAhPmBKZ+b7JANlhLu3y3
         WfuSDkNMYUZ0EBQtsvpl5LjitX8jNaTIxHapcmsXgTjmPr8dUI/bjgx+DX1OMH9g2hT2
         nwHDeoLLqgIR1qZ0CurpFkk/sf/M/N3VJD/aQXKCjL7YUUJYAFMh8tupQintCMejRfZ2
         40WCB9Pu++8sdK/GPWin1arTNfZlSeORwfZ8bp9wglmC2PItBFu3C74C+j591ZhN2b+0
         nUwt0P7gwDzciDqqX3YnrzBYyUAagRpKKWcSRfFFHOiORcghWWB0h2ougW+r/B+wzyoN
         dI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715638; x=1718320438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFORmSYxBFghq+sxU2O43udLz9imyeDUrV9JdpKSDhY=;
        b=b+QKeEBXj9HnfZSgAgeLVQBMG9UzQXe+884n1xygwzOX6GHsx7Ijen0f3Y5u+LCJI/
         d/gs3Oq2+1zheH73k5Q7dad2ZQ6BcwSzQr5P/CK0OoWZU7rVhgOrRrD8G2Dq2z+49ppx
         oU+r9/sLRFKpkRzLDpi/Jd3HqM7jxPxsHddeaGrLzrd57kQSv1JYzxKdo8trY00ruNvQ
         /1w5Wfz8oPUHp/vlMGbnmBRql5Mci8o3JsrNPX1ZHwgRnj3/l9vYzYnzo5cvaNfBsmOP
         zkNtxGYoRlYtKyTkrWYAE2BP/KOQ1Hd7+xmS1FM8S/x4cZOJLxuu/RSNBqgeKQtEs3GN
         l2uA==
X-Forwarded-Encrypted: i=1; AJvYcCVtokSpK+FrX6Zt0NmLCahjsdMdygrNMTlexWqV1zzm9nhA/Khc8TDy3Dtjm58lAB/op38peue3fedbSvVBt+HgEuEDtuahHRJfd3ph
X-Gm-Message-State: AOJu0Yxth3rwWa1wn2Yrvs/70i9YC0snQN2DfDm835qT+UqTQiJhZpZE
	P/nJTZbqqQw5xVxZjH9icnW9LJiq8xWIAijJR81VTqaf0CqbWy9i6N1OrywxtSQ=
X-Google-Smtp-Source: AGHT+IFDH+66F4mlC+oUl4nfayFVD+4cGREjkxu6VGNSHGT86pjVghsHzAgq2Aj1qKbnXa/hFLZ2Wg==
X-Received: by 2002:a05:6a00:1496:b0:703:fe48:8857 with SMTP id d2e1a72fcca58-7040c74d81dmr947920b3a.32.1717715637581;
        Thu, 06 Jun 2024 16:13:57 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4d95ebsm1624077b3a.145.2024.06.06.16.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:13:57 -0700 (PDT)
Date: Thu, 6 Jun 2024 16:13:54 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
	Erick Archer <erick.archer@gmx.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] RISC-V: Report vector unaligned accesse speed hwprobe
Message-ID: <ZmJCsgCWoR7WoAdP@ghost>
References: <20240606183215.416829-1-jesse@rivosinc.com>
 <20240606183215.416829-3-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606183215.416829-3-jesse@rivosinc.com>

On Thu, Jun 06, 2024 at 02:32:15PM -0400, Jesse Taube wrote:
> Detect if vector misaligned accesses are faster or slower than
> equivalent vector byte accesses. This is useful for usermode to know
> whether vector byte accesses or vector misaligned accesses have a better
> bandwidth for operations like memcpy.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  arch/riscv/kernel/Makefile                 |   3 +
>  arch/riscv/kernel/copy-unaligned.h         |   5 +
>  arch/riscv/kernel/unaligned_access_speed.c | 127 ++++++++++++++++++++-
>  arch/riscv/kernel/vec-copy-unaligned.S     |  58 ++++++++++
>  4 files changed, 192 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 81d94a8ee10f..61cec0688559 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -65,6 +65,9 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
>  obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
>  obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
>  obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
> +ifeq ($(CONFIG_RISCV_ISA_V), y)
> +obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= vec-copy-unaligned.o
> +endif
>  
>  obj-$(CONFIG_FPU)		+= fpu.o
>  obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
> diff --git a/arch/riscv/kernel/copy-unaligned.h b/arch/riscv/kernel/copy-unaligned.h
> index e3d70d35b708..88be070085cb 100644
> --- a/arch/riscv/kernel/copy-unaligned.h
> +++ b/arch/riscv/kernel/copy-unaligned.h
> @@ -10,4 +10,9 @@
>  void __riscv_copy_words_unaligned(void *dst, const void *src, size_t size);
>  void __riscv_copy_bytes_unaligned(void *dst, const void *src, size_t size);
>  
> +#ifdef CONFIG_RISCV_ISA_V
> +void __riscv_copy_vec_words_unaligned(void *dst, const void *src, size_t size);
> +void __riscv_copy_vec_bytes_unaligned(void *dst, const void *src, size_t size);
> +#endif
> +
>  #endif /* __RISCV_KERNEL_COPY_UNALIGNED_H */
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index 92a84239beaa..4e6f753b659a 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -8,9 +8,11 @@
>  #include <linux/jump_label.h>
>  #include <linux/mm.h>
>  #include <linux/smp.h>
> +#include <linux/kthread.h>
>  #include <linux/types.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwprobe.h>
> +#include <asm/vector.h>
>  
>  #include "copy-unaligned.h"
>  
> @@ -128,6 +130,107 @@ static void check_unaligned_access_nonboot_cpu(void *param)
>  		check_unaligned_access(pages[cpu]);
>  }
>  
> +#ifdef CONFIG_RISCV_ISA_V
> +static void check_vector_unaligned_access(struct work_struct *unused)
> +{
> +	int cpu = smp_processor_id();
> +	u64 start_cycles, end_cycles;
> +	u64 word_cycles;
> +	u64 byte_cycles;
> +	int ratio;
> +	unsigned long start_jiffies, now;
> +	struct page *page;
> +	void *dst;
> +	void *src;
> +	long speed = RISCV_HWPROBE_VEC_MISALIGNED_SLOW;
> +
> +	if (per_cpu(vector_misaligned_access, cpu) != RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED)
> +		return;
> +
> +	page = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> +	if (!page) {
> +		pr_warn("Allocation failure, not measuring vector misaligned performance\n");
> +		return;
> +	}
> +
> +	/* Make an unaligned destination buffer. */
> +	dst = (void *)((unsigned long)page_address(page) | 0x1);
> +	/* Unalign src as well, but differently (off by 1 + 2 = 3). */
> +	src = dst + (MISALIGNED_BUFFER_SIZE / 2);
> +	src += 2;
> +	word_cycles = -1ULL;
> +
> +	/* Do a warmup. */
> +	local_irq_enable();
> +	kernel_vector_begin();
> +	__riscv_copy_vec_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +
> +	start_jiffies = jiffies;
> +	while ((now = jiffies) == start_jiffies)
> +		cpu_relax();
> +
> +	/*
> +	 * For a fixed amount of time, repeatedly try the function, and take
> +	 * the best time in cycles as the measurement.
> +	 */
> +	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> +		start_cycles = get_cycles64();
> +		/* Ensure the CSR read can't reorder WRT to the copy. */
> +		mb();
> +		__riscv_copy_vec_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +		/* Ensure the copy ends before the end time is snapped. */
> +		mb();
> +		end_cycles = get_cycles64();
> +		if ((end_cycles - start_cycles) < word_cycles)
> +			word_cycles = end_cycles - start_cycles;
> +	}
> +
> +	byte_cycles = -1ULL;
> +	__riscv_copy_vec_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +	start_jiffies = jiffies;
> +	while ((now = jiffies) == start_jiffies)
> +		cpu_relax();
> +
> +	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> +		start_cycles = get_cycles64();
> +		mb();
> +		__riscv_copy_vec_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +		mb();
> +		end_cycles = get_cycles64();
> +		if ((end_cycles - start_cycles) < byte_cycles)
> +			byte_cycles = end_cycles - start_cycles;
> +	}
> +
> +	kernel_vector_end();
> +
> +	/* Don't divide by zero. */
> +	if (!word_cycles || !byte_cycles) {
> +		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned vector access speed\n",
> +			cpu);
> +
> +		return;
> +	}
> +
> +	if (word_cycles < byte_cycles)
> +		speed = RISCV_HWPROBE_VEC_MISALIGNED_FAST;
> +
> +	ratio = div_u64((byte_cycles * 100), word_cycles);
> +	pr_info("cpu%d: Ratio of vector byte access time to vector unaligned word access is %d.%02d, unaligned accesses are %s\n",
> +		cpu,
> +		ratio / 100,
> +		ratio % 100,
> +		(speed ==  RISCV_HWPROBE_VEC_MISALIGNED_FAST) ? "fast" : "slow");
> +
> +	per_cpu(vector_misaligned_access, cpu) = speed;
> +}
> +
> +static int riscv_online_cpu_vec(unsigned int cpu)
> +{
> +	check_vector_unaligned_access(NULL);
> +	return 0;
> +}
> +#endif
> +
>  DEFINE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
>  
>  static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
> @@ -261,11 +364,33 @@ static int check_unaligned_access_speed_all_cpus(void)
>  	return 0;
>  }
>  
> +/* Measure unaligned access speed on all CPUs present at boot in parallel. */
> +static int vec_check_unaligned_access_speed_all_cpus(void *unused)
> +{
> +	schedule_on_each_cpu(check_vector_unaligned_access);
> +
> +	/*
> +	 * Setup hotplug callbacks for any new CPUs that come online or go
> +	 * offline.
> +	 */
> +	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> +				  riscv_online_cpu_vec, NULL);
> +
> +	return 0;
> +}
> +
>  static int check_unaligned_access_all_cpus(void)
>  {
>  	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
>  
> -	check_vector_unaligned_access_all_cpus();
> +#ifdef CONFIG_RISCV_ISA_V
> +	bool all_cpus_vec_supported = check_vector_unaligned_access_all_cpus();
> +
> +	if (all_cpus_vec_supported) {
> +		kthread_run(vec_check_unaligned_access_speed_all_cpus,

I think it might be better if this is combined with
check_unaligned_access_speed_all_cpus() by leveraging the function
check_unaligned_access_nonboot_cpu(). The idea behind that is that right
now we have both the vector unaligned accesses and the scalar unaligned
access tests being kicked off onto each cpu separately which requires 2
IPIs per hart, but if we run them back to back on a given hart the IPI
only needs to happen once per hart. Having the methods of checking
vector unaligned access and scalar unaligned access be standardized
would be nice as well.

The scalar misaligned access also keeps one cpu back to keep consistency
in timing so I would imagine that would be important to do here as well.

- Charlie

> +			    NULL, "thebestthread");
> +	}
> +#endif
>  
>  	if (!all_cpus_emulated)
>  		return check_unaligned_access_speed_all_cpus();
> diff --git a/arch/riscv/kernel/vec-copy-unaligned.S b/arch/riscv/kernel/vec-copy-unaligned.S
> new file mode 100644
> index 000000000000..11522ec8f0a8
> --- /dev/null
> +++ b/arch/riscv/kernel/vec-copy-unaligned.S
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2024 Rivos Inc. */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +#include <linux/args.h>
> +
> +	.text
> +
> +#define WORD_EEW 64
> +
> +#define WORD_SEW CONCATENATE(e, WORD_EEW)
> +#define VEC_L CONCATENATE(vle, WORD_EEW).v
> +#define VEC_S CONCATENATE(vle, WORD_EEW).v
> +
> +/* void __riscv_copy_vec_words_unaligned(void *, const void *, size_t) */
> +/* Performs a memcpy without aligning buffers, using word loads and stores. */
> +/* Note: The size is truncated to a multiple of WORD_EEW */
> +SYM_FUNC_START(__riscv_copy_vec_words_unaligned)
> +	andi  a4, a2, ~(WORD_EEW-1)
> +	beqz  a4, 2f
> +	add   a3, a1, a4
> +	.option push
> +	.option arch, +v
> +1:
> +	vsetivli t0, 8, WORD_SEW, m8, ta, ma
> +	VEC_L v0, (a1)
> +	VEC_S v0, (a0)
> +	addi  a0, a0, WORD_EEW
> +	addi  a1, a1, WORD_EEW
> +	bltu  a1, a3, 1b
> +
> +2:
> +	.option pop
> +	ret
> +SYM_FUNC_END(__riscv_copy_vec_words_unaligned)
> +
> +/* void __riscv_copy_vec_bytes_unaligned(void *, const void *, size_t) */
> +/* Performs a memcpy without aligning buffers, using only byte accesses. */
> +/* Note: The size is truncated to a multiple of 8 */
> +SYM_FUNC_START(__riscv_copy_vec_bytes_unaligned)
> +	andi a4, a2, ~(8-1)
> +	beqz a4, 2f
> +	add  a3, a1, a4
> +	.option push
> +	.option arch, +v
> +1:
> +	vsetivli t0, 8, e8, m8, ta, ma
> +	vle8.v v0, (a1)
> +	vse8.v v0, (a0)
> +	addi a0, a0, 8
> +	addi a1, a1, 8
> +	bltu a1, a3, 1b
> +
> +2:
> +	.option pop
> +	ret
> +SYM_FUNC_END(__riscv_copy_vec_bytes_unaligned)
> -- 
> 2.43.0
> 

