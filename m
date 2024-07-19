Return-Path: <linux-kernel+bounces-257704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7481B937DD5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95AD3B217F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 22:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C2C149016;
	Fri, 19 Jul 2024 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="l6G8GWjv"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A014885C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721427959; cv=none; b=NlkvIjdAttkgnr9Oq+HtQw5naGHC2gWuu2L8uwpGgPdrTrW11RUWCtM4dJ9rHME3HvA0umhihcW8M52v55QJnRWDkmQbg3egnihlGVRzyoqQCG1pUavueAvKwFOfzBqtoOMkbjGtBBECiebpavMoDffyyRIsLxIOw/Enp85EmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721427959; c=relaxed/simple;
	bh=V+A0QoX/sjgq3hKDLdx0jDhCzlSl3I7HNGE9OamCluM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9fDYbbDcuVn60T1RBFPPdLYLHckS0LtLOCuw8A4putlzXG73vaC/rb0vejnKmzj8KOvBN3ILQueYLveLys9186AF3g/rJ0L7WCYdPqTVdqZ8LGI7uqppiRryCRbYi5eTJexzJ7v+T0/yhPOJIW7nTZNEV68qstgD94AuVi4M+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=l6G8GWjv; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e03caab48a2so1873923276.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721427956; x=1722032756; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S386uNHUa1mDO7HUkcI0rCKHyM1BbL2df0I71SUcBA0=;
        b=l6G8GWjvCYF2hnmC/RywfrxuLEVGMKyzL6vXi2IIz9ZsTsIXkBZKgHz7mv1nzLnzMa
         Qk8P4ToesGKyldyR/n2PPru3LCwR0Fxz5rurn0VyZ2+Xb0immj4TZBX3lUaBWyqPoGq1
         a/Zmd0UIIRAN5m4mxCHllyGKXwVgn/5S/H/JrzvyZfDg/HYGPb7cUSmsjeQ6ZhtKsBgV
         sWl4KV68WCQedowWFtpjemehsTfEjDeVLGqH6tqdbIgJB3/Zox+SICcZ5C9JHxDAAILj
         Ftth+OtZgUHVYw0ECUWsaT+Cb9luS/fxDDiEMBxUWoG+J6BJROcseRYjWIFc5qz1lt3r
         +nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721427956; x=1722032756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S386uNHUa1mDO7HUkcI0rCKHyM1BbL2df0I71SUcBA0=;
        b=UHWMvCcnnNX11R01jUlMRyEX46fEHow/AIM5gJ2wFkPFsvJubMbQzhsrnnVsRnIYdl
         1J1vvoYLcQKfRmPqSmiEj9LljBnLa9I5LYD8lqQB7XaOoh5lI5/eNsY36uUi7sG6eAZC
         h0Pc0wi9qKrz2dqTmcGlUBEbn9n/4dwW0807sRDhLJ9jnY3zJJZJBOZNjcAWpfsgNHoh
         ziCRZ0RZaz0IOsjdPxqERmpLGSNgiICZAZxRqHzRyC2G3OutD5EVzNV308vG65nGwOt8
         +XPOU0uRIMteLsFpIxMayZa6uH20fns/884DGcOt+8SuVqbVDGtOfMHoUi8D7UJ+aOF6
         yCTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7JeHwSxS0dqckIYY6Ncor+oDmgBFRoDlpIQ8wv32tGJWZQr9oCtGKUyIf+WHltMQnKGOC1/wJ5dtIL9aazmiqPqC7as86nAw+wFyt
X-Gm-Message-State: AOJu0YzkXEDvPNBrEnca9fpS1gAlBV9n1e6Ch/ch4JpaqRAtdgZxxlmN
	R+W8J/7BvnbM7UCLUTDXK0lvSZDwAkp66AYKZ+qxfk+RlsRZyOO/SLTFIrKH9rE=
X-Google-Smtp-Source: AGHT+IFJ/Xb7HTvxClUkzKPmIMXRkcAoU0Ag2NvfoFtCiJ60OAXbvUitaY7qqrsTDC3Xsq46oxUHdw==
X-Received: by 2002:a25:6b45:0:b0:e05:f632:3ef3 with SMTP id 3f1490d57ef6-e05ff2e2ac7mr5211912276.23.1721427955741;
        Fri, 19 Jul 2024 15:25:55 -0700 (PDT)
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e086096b428sm699235276.2.2024.07.19.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 15:25:54 -0700 (PDT)
Date: Fri, 19 Jul 2024 15:25:53 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/7] RISC-V: Report vector unaligned access speed
 hwprobe
Message-ID: <Zprn8ctubWJxZjpX@ghost>
References: <20240717180727.4180475-1-jesse@rivosinc.com>
 <20240717180727.4180475-7-jesse@rivosinc.com>
 <CALs-Hsuph7-1FmTqtH-395k84f5ZzkKu8PbX7VqU5JkshFr_3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-Hsuph7-1FmTqtH-395k84f5ZzkKu8PbX7VqU5JkshFr_3w@mail.gmail.com>

On Fri, Jul 19, 2024 at 01:00:16PM -0700, Evan Green wrote:
> On Wed, Jul 17, 2024 at 11:08 AM Jesse Taube <jesse@rivosinc.com> wrote:
> >
> > Detect if vector misaligned accesses are faster or slower than
> > equivalent vector byte accesses. This is useful for usermode to know
> > whether vector byte accesses or vector misaligned accesses have a better
> > bandwidth for operations like memcpy.
> >
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > V1 -> V2:
> >  - Add Kconfig options
> >  - Add WORD_EEW to vec-copy-unaligned.S
> > V2 -> V3:
> >  - Remove unnecessary comment
> >  - Remove local_irq_enable
> > V3 -> V4:
> >  - Add preempt_disable/enable
> >  - Alphabetize includes in vec-copy-unaligned.S and unaligned_access_speed.c
> >  - Add duplicate comments above mb() to please checkpatch
> >  - change all_cpus_vec_supported to all_cpus_vec_unsupported
> >     so speed is tested if any cpus support unaligned vector accesses
> >  - Spell out _VECTOR_ in macros
> > V4 -> V5:
> >  - Change void *unused to void *unused __always_unused
> > ---
> >  arch/riscv/Kconfig                         |  18 +++
> >  arch/riscv/kernel/Makefile                 |   3 +-
> >  arch/riscv/kernel/copy-unaligned.h         |   5 +
> >  arch/riscv/kernel/sys_hwprobe.c            |   6 +
> >  arch/riscv/kernel/unaligned_access_speed.c | 134 ++++++++++++++++++++-
> >  arch/riscv/kernel/vec-copy-unaligned.S     |  58 +++++++++
> >  6 files changed, 221 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index ffbe0fdd7fb3..e98139340c1c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -807,6 +807,24 @@ config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> >           will dynamically determine the speed of vector unaligned accesses on
> >           the underlying system if they are supported.
> >
> > +config RISCV_SLOW_VECTOR_UNALIGNED_ACCESS
> > +       bool "Assume the system supports slow vector unaligned memory accesses"
> > +       depends on NONPORTABLE
> > +       help
> > +         Assume that the system supports slow vector unaligned memory accesses. The
> > +         kernel and userspace programs may not be able to run at all on systems
> > +         that do not support unaligned memory accesses.
> > +
> > +config RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
> > +       bool "Assume the system supports fast vector unaligned memory accesses"
> > +       depends on NONPORTABLE
> > +       help
> > +         Assume that the system supports fast vector unaligned memory accesses. When
> > +         enabled, this option improves the performance of the kernel on such
> > +         systems. However, the kernel and userspace programs will run much more
> > +         slowly, or will not be able to run at all, on systems that do not
> > +         support efficient unaligned memory accesses.
> > +
> >  endchoice
> >
> >  endmenu # "Platform type"
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 5b243d46f4b1..291935a084d5 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -64,7 +64,8 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
> >
> >  obj-$(CONFIG_RISCV_MISALIGNED) += traps_misaligned.o
> >  obj-$(CONFIG_RISCV_MISALIGNED) += unaligned_access_speed.o
> > -obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)     += copy-unaligned.o
> > +obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)             += copy-unaligned.o
> > +obj-$(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)      += vec-copy-unaligned.o
> >
> >  obj-$(CONFIG_FPU)              += fpu.o
> >  obj-$(CONFIG_FPU)              += kernel_mode_fpu.o
> > diff --git a/arch/riscv/kernel/copy-unaligned.h b/arch/riscv/kernel/copy-unaligned.h
> > index e3d70d35b708..85d4d11450cb 100644
> > --- a/arch/riscv/kernel/copy-unaligned.h
> > +++ b/arch/riscv/kernel/copy-unaligned.h
> > @@ -10,4 +10,9 @@
> >  void __riscv_copy_words_unaligned(void *dst, const void *src, size_t size);
> >  void __riscv_copy_bytes_unaligned(void *dst, const void *src, size_t size);
> >
> > +#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> > +void __riscv_copy_vec_words_unaligned(void *dst, const void *src, size_t size);
> > +void __riscv_copy_vec_bytes_unaligned(void *dst, const void *src, size_t size);
> > +#endif
> > +
> >  #endif /* __RISCV_KERNEL_COPY_UNALIGNED_H */
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > index 2e3e324bad38..99d3e63d0444 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -221,6 +221,12 @@ static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> >  #else
> >  static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> >  {
> > +       if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS))
> > +               return RISCV_HWPROBE_VECTOR_MISALIGNED_FAST;
> > +
> > +       if (IS_ENABLED(CONFIG_RISCV_SLOW_VECTOR_UNALIGNED_ACCESS))
> > +               return RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW;
> > +
> >         return RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> >  }
> >  #endif
> > diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> > index 24b8883a23f0..532e9151685b 100644
> > --- a/arch/riscv/kernel/unaligned_access_speed.c
> > +++ b/arch/riscv/kernel/unaligned_access_speed.c
> > @@ -6,11 +6,13 @@
> >  #include <linux/cpu.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/jump_label.h>
> > +#include <linux/kthread.h>
> >  #include <linux/mm.h>
> >  #include <linux/smp.h>
> >  #include <linux/types.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/hwprobe.h>
> > +#include <asm/vector.h>
> >
> >  #include "copy-unaligned.h"
> >
> > @@ -267,12 +269,140 @@ static int check_unaligned_access_speed_all_cpus(void)
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> > +static void check_vector_unaligned_access(struct work_struct *work __always_unused)
> > +{
> > +       int cpu = smp_processor_id();
> > +       u64 start_cycles, end_cycles;
> > +       u64 word_cycles;
> > +       u64 byte_cycles;
> > +       int ratio;
> > +       unsigned long start_jiffies, now;
> > +       struct page *page;
> > +       void *dst;
> > +       void *src;
> > +       long speed = RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW;
> > +
> > +       if (per_cpu(vector_misaligned_access, cpu) != RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW)
> > +               return;
> > +
> > +       page = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> > +       if (!page) {
> > +               pr_warn("Allocation failure, not measuring vector misaligned performance\n");
> > +               return;
> > +       }
> > +
> > +       /* Make an unaligned destination buffer. */
> > +       dst = (void *)((unsigned long)page_address(page) | 0x1);
> > +       /* Unalign src as well, but differently (off by 1 + 2 = 3). */
> > +       src = dst + (MISALIGNED_BUFFER_SIZE / 2);
> > +       src += 2;
> > +       word_cycles = -1ULL;
> > +
> > +       /* Do a warmup. */
> > +       kernel_vector_begin();
> > +       __riscv_copy_vec_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > +
> > +       start_jiffies = jiffies;
> > +       while ((now = jiffies) == start_jiffies)
> > +               cpu_relax();
> > +
> > +       /*
> > +        * For a fixed amount of time, repeatedly try the function, and take
> > +        * the best time in cycles as the measurement.
> > +        */
> > +       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> > +               start_cycles = get_cycles64();
> > +               /* Ensure the CSR read can't reorder WRT to the copy. */
> > +               mb();
> > +               __riscv_copy_vec_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > +               /* Ensure the copy ends before the end time is snapped. */
> > +               mb();
> > +               end_cycles = get_cycles64();
> > +               if ((end_cycles - start_cycles) < word_cycles)
> > +                       word_cycles = end_cycles - start_cycles;
> > +       }
> > +
> > +       byte_cycles = -1ULL;
> > +       __riscv_copy_vec_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > +       start_jiffies = jiffies;
> > +       while ((now = jiffies) == start_jiffies)
> > +               cpu_relax();
> > +
> > +       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> > +               start_cycles = get_cycles64();
> > +               /* Ensure the CSR read can't reorder WRT to the copy. */
> > +               mb();
> > +               __riscv_copy_vec_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > +               /* Ensure the copy ends before the end time is snapped. */
> > +               mb();
> > +               end_cycles = get_cycles64();
> > +               if ((end_cycles - start_cycles) < byte_cycles)
> > +                       byte_cycles = end_cycles - start_cycles;
> > +       }
> > +
> > +       kernel_vector_end();
> > +
> > +       /* Don't divide by zero. */
> > +       if (!word_cycles || !byte_cycles) {
> > +               pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned vector access speed\n",
> > +                       cpu);
> > +
> > +               return;
> > +       }
> > +
> > +       if (word_cycles < byte_cycles)
> > +               speed = RISCV_HWPROBE_VECTOR_MISALIGNED_FAST;
> > +
> > +       ratio = div_u64((byte_cycles * 100), word_cycles);
> > +       pr_info("cpu%d: Ratio of vector byte access time to vector unaligned word access is %d.%02d, unaligned accesses are %s\n",
> > +               cpu,
> > +               ratio / 100,
> > +               ratio % 100,
> > +               (speed ==  RISCV_HWPROBE_VECTOR_MISALIGNED_FAST) ? "fast" : "slow");
> > +
> > +       per_cpu(vector_misaligned_access, cpu) = speed;
> > +}
> > +
> > +static int riscv_online_cpu_vec(unsigned int cpu)
> > +{
> > +       check_vector_unaligned_access(NULL);
> 
> Maybe I missed the call site in another patch, but are you calling
> check_vector_unaligned_access_emulated() anywhere in the hotplug path?
> Without this, for a CPU that wasn't present at boot, it seems like the
> per-cpu variable would be set to its initialized value of UNSUPPORTED,
> and then you'd bail early out of check_vector_unaligned_access() at
> the "!= SLOW" conditional.
> 
> IMO it would be better if the values truly meant what they said. So we
> initialize it to UNKNOWN, unconditionally change to UNSUPPORTED if we
> discover it's emulated or there is no vector support, and only set to
> SLOW or FAST as a result of probe measurement or Kconfig override.
> It's the "SLOW means slow or don't know" from the previous patch
> that's bugging me. This creates downstream effects like this "!= SLOW"
> conditional (by which you really mean "!= UNKNOWN") that are
> challenging to reason about and maintain.
> 
> I have this vague sense that you did this in response to feedback in
> an earlier series, but I can't find it now.

Yes there has been a lot of back and forth on this. Here is the original
discussion: https://lore.kernel.org/lkml/ZmN8gER4RnyoyQT4@ghost/. I
originally agreed with Conor that SLOW would be reasonable because it
prevented programs from receiving an UNKNOWN which they may be unsure
how to handle. The idea here is that programs that rely on misaligned
access speed should avoid using misaligned accesses if the speed is
UNKNOWN. Reporting SLOW instead of UNKNOWN takes the decision out of the
hands of the program, so they don't have to worry about UNKNOWN. However
over the course of this series I too have been increasingly unconvinced
by this reasoning. It doesn't seem like the kernel's place to make this
decision for userspace and should just provide the correct information.

The more concrete issue is with CPU hotplug. When a CPU is hotplugged
into a new CPU index, it will default to UNSUPPORTED. When the CPU
enters check_vector_unaligned_access(), its speed will not be SLOW so
the code assumes it has already been probed -- even though it hasn't.
The default should be UNKNOWN (instead of UNSUPPORTED) and this code
should check for UNKNOWN to determine if the cpu has already been
probed.

We can test this by booting Linux with the argument "maxcpus=1" and
after it boots run:

# echo 1 > /sys/devices/system/cpu/cpu1/online
[   40.481153] cpu1: Ratio of byte access time to unaligned word access is 9.05, unaligned accesses are fast
#

Only the scalar misaligned access speed checker ran. I also verified
that check_vector_unaligned_access() sees that the speed is UNKNOWN
which is not SLOW so exits.

- Charlie

> 
> 
> -Evan
> 
> 
> > +       return 0;
> > +}
> > +
> > +/* Measure unaligned access speed on all CPUs present at boot in parallel. */
> > +static int vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
> > +{
> > +       schedule_on_each_cpu(check_vector_unaligned_access);
> > +
> > +       /*
> > +        * Setup hotplug callbacks for any new CPUs that come online or go
> > +        * offline.
> > +        */
> > +       cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> > +                                 riscv_online_cpu_vec, NULL);
> > +
> > +       return 0;
> > +}
> > +#else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
> > +static int vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> >  static int check_unaligned_access_all_cpus(void)
> >  {
> > -       bool all_cpus_emulated;
> > +       bool all_cpus_emulated, all_cpus_vec_unsupported;
> >
> >         all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
> > -       check_vector_unaligned_access_emulated_all_cpus();
> > +       all_cpus_vec_unsupported = check_vector_unaligned_access_emulated_all_cpus();
> > +
> > +       if (!all_cpus_vec_unsupported &&
> > +           IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
> > +               kthread_run(vec_check_unaligned_access_speed_all_cpus,
> > +                           NULL, "vec_check_unaligned_access_speed_all_cpus");
> > +       }
> >
> >         if (!all_cpus_emulated)
> >                 return check_unaligned_access_speed_all_cpus();
> > diff --git a/arch/riscv/kernel/vec-copy-unaligned.S b/arch/riscv/kernel/vec-copy-unaligned.S
> > new file mode 100644
> > index 000000000000..d16f19f1b3b6
> > --- /dev/null
> > +++ b/arch/riscv/kernel/vec-copy-unaligned.S
> > @@ -0,0 +1,58 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (C) 2024 Rivos Inc. */
> > +
> > +#include <linux/args.h>
> > +#include <linux/linkage.h>
> > +#include <asm/asm.h>
> > +
> > +       .text
> > +
> > +#define WORD_EEW 32
> > +
> > +#define WORD_SEW CONCATENATE(e, WORD_EEW)
> > +#define VEC_L CONCATENATE(vle, WORD_EEW).v
> > +#define VEC_S CONCATENATE(vle, WORD_EEW).v
> > +
> > +/* void __riscv_copy_vec_words_unaligned(void *, const void *, size_t) */
> > +/* Performs a memcpy without aligning buffers, using word loads and stores. */
> > +/* Note: The size is truncated to a multiple of WORD_EEW */
> > +SYM_FUNC_START(__riscv_copy_vec_words_unaligned)
> > +       andi  a4, a2, ~(WORD_EEW-1)
> > +       beqz  a4, 2f
> > +       add   a3, a1, a4
> > +       .option push
> > +       .option arch, +zve32x
> > +1:
> > +       vsetivli t0, 8, WORD_SEW, m8, ta, ma
> > +       VEC_L v0, (a1)
> > +       VEC_S v0, (a0)
> > +       addi  a0, a0, WORD_EEW
> > +       addi  a1, a1, WORD_EEW
> > +       bltu  a1, a3, 1b
> > +
> > +2:
> > +       .option pop
> > +       ret
> > +SYM_FUNC_END(__riscv_copy_vec_words_unaligned)
> > +
> > +/* void __riscv_copy_vec_bytes_unaligned(void *, const void *, size_t) */
> > +/* Performs a memcpy without aligning buffers, using only byte accesses. */
> > +/* Note: The size is truncated to a multiple of 8 */
> > +SYM_FUNC_START(__riscv_copy_vec_bytes_unaligned)
> > +       andi a4, a2, ~(8-1)
> > +       beqz a4, 2f
> > +       add  a3, a1, a4
> > +       .option push
> > +       .option arch, +zve32x
> > +1:
> > +       vsetivli t0, 8, e8, m8, ta, ma
> > +       vle8.v v0, (a1)
> > +       vse8.v v0, (a0)
> > +       addi a0, a0, 8
> > +       addi a1, a1, 8
> > +       bltu a1, a3, 1b
> > +
> > +2:
> > +       .option pop
> > +       ret
> > +SYM_FUNC_END(__riscv_copy_vec_bytes_unaligned)
> > --
> > 2.45.2
> >

