Return-Path: <linux-kernel+bounces-237090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1CC91EB2C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 00:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECFCB21E7E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03685172769;
	Mon,  1 Jul 2024 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BVyL5m1c"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A540F153835
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719874350; cv=none; b=WzBUgwo2Ya1wpwcRR1fn7E6l/moHOYwsDGWJC+SR666vdhEUazRREjxPNGhvxNpq2k1DYlWc/3la3t3o5Hsy87vRDfuLiDbPYAMvXv7CfzBsDiIHDjRdEhjPYuMDs1bmYoL8lfQnyCaD+nqJ+4wuY/M4Ecebm4t/k7bvLUX7gTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719874350; c=relaxed/simple;
	bh=JvDMFc2c1Km/+hj5gTudVDy/q7iwBpqa3Va5EEAuryk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lf0W4bzyqDmkBkGnou0qvauRoO+3CZMkmdLidvXkwfcTH1sSGJdZ0IQWRw2N5lI19T+7RKou7XSLE3JRqJc+qA9YXsg7GzRrYuEULBXu33VqC8qbhfBKREScC/j2GpEWtFQSW7UQdETFtp8fcRuWdxrnkFmz9HSyF0KYs5HA/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BVyL5m1c; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58b447c519eso260179a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 15:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719874347; x=1720479147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=260ao+hKwOHRT0dRkZGR+ugEkI7Ny5Y6wR02Mt8+Bxw=;
        b=BVyL5m1cLzNRDHjWvVTZPKkA3HbJbK8ksegUnq+lLaA7OWXaTPEb+B7O0Vs1ZW8aKd
         JjqsVy6bAdpWaZSAaDc0IYkAFtqtuaRVzLV07vzZOlqhPt063bnZ5qKc0QyhNR3YJygc
         WMXvEEk1Ti+gXfGn4dKz/ox5gQQFByoWjdiPslkvfGSMRdDf3f9vu4seQ/B7VLgsb3U/
         6P9nGfETSnVSmKQtt1AwNknU83f44oiEZ4epIB44xl017zJtuoUwivlY9QSygMh5Qo6m
         5FQdmWIl9nTG0YKNk+ILmJQA34h1aiOvE95Qp0wPnTtnI8nmbhAwXvHHl7Sc9fPSpqms
         9U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719874347; x=1720479147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=260ao+hKwOHRT0dRkZGR+ugEkI7Ny5Y6wR02Mt8+Bxw=;
        b=L239uai6d0ioX4+3XWcaj4/7rta3AtoCpdOEFZknezmtWm8fbQwwFMVW1m78auSsOf
         yNFJDr8ULl1sBA0B3N1WjOMYr1q9aqH0HHlhV+blOLodaWvpIocKG0HhUWM1Q7P2spXi
         29WZs+sZSTpRspPbfN0SbL3AZrekUtzrdMI3LBHiSlKYlllf7plt+OS/+/znDk27eA0o
         ihKSsom31bASPQ5G2UhNGlkeHfhesthos56Fk4Hlh2ZZmnk5+Jfzc+GSKuR6L8th9uhb
         UIeLXFtU76ixkR+OvQH/6UvpI16P8ySCh8MuPYE/PQIG1+8xVJVnZPOH9UgyNH9X68h4
         N9VA==
X-Forwarded-Encrypted: i=1; AJvYcCWNRpD7CHoBC8wzuVhaXNsh++GFy8tZrEJeCq2R3BsacxyFW8zuw0W41qAHVjk+9apvlWZC7TIsJky7j331k5yFjuEggXB0KaveAJ61
X-Gm-Message-State: AOJu0YzHTMSQp3sWCJWW21se45D2okFnOCroOZ/D60SvxSl/w5pvpBaB
	K6tvQO9t/uLxqYIiGAsVB7YPykQRRwt/Mw5ppAPt93BRCyZCudwZd6K0mEKcTqxuGpbjDuhtglM
	DafY1Va5na502EzVGvC2Sn1CbfuGwSvCPr+lnwA==
X-Google-Smtp-Source: AGHT+IGNT7fADZeYeT9XNU/QYnzlXNWZq62QN0JPAgxSi9DvRC8jYoKYbXWG/B1wiklwlUhY1CrdhszpjOHvLzYm5iY=
X-Received: by 2002:a17:907:84d:b0:a75:29ea:283f with SMTP id
 a640c23a62f3a-a7529ea28d3mr267184466b.66.1719874346836; Mon, 01 Jul 2024
 15:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625005001.37901-1-jesse@rivosinc.com> <20240625005001.37901-8-jesse@rivosinc.com>
In-Reply-To: <20240625005001.37901-8-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Mon, 1 Jul 2024 15:51:50 -0700
Message-ID: <CALs-HssQdKqNGZPUE8b+J57NTQyarYbk=DHR10-+YizZE1uQ+w@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] RISC-V: Report vector unaligned access speed hwprobe
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Eric Biggers <ebiggers@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 5:52=E2=80=AFPM Jesse Taube <jesse@rivosinc.com> wr=
ote:
>
> Detect if vector misaligned accesses are faster or slower than
> equivalent vector byte accesses. This is useful for usermode to know
> whether vector byte accesses or vector misaligned accesses have a better
> bandwidth for operations like memcpy.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> V1 -> V2:
>  - Add Kconfig options
>  - Add WORD_EEW to vec-copy-unaligned.S
> V2 -> V3:
>  - Remove unnecessary comment
>  - Remove local_irq_enable
> ---
>  arch/riscv/Kconfig                         |  18 +++
>  arch/riscv/kernel/Makefile                 |   3 +-
>  arch/riscv/kernel/copy-unaligned.h         |   5 +
>  arch/riscv/kernel/sys_hwprobe.c            |   6 +
>  arch/riscv/kernel/unaligned_access_speed.c | 132 ++++++++++++++++++++-
>  arch/riscv/kernel/vec-copy-unaligned.S     |  58 +++++++++
>  6 files changed, 219 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ffbe0fdd7fb3..6f9fd3748916 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -807,6 +807,24 @@ config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
>           will dynamically determine the speed of vector unaligned access=
es on
>           the underlying system if they are supported.
>
> +config RISCV_SLOW_VEC_UNALIGNED_ACCESS
> +       bool "Assume the system supports slow vector unaligned memory acc=
esses"
> +       depends on NONPORTABLE
> +       help
> +         Assume that the system supports slow vector unaligned memory ac=
cesses. The
> +         kernel and userspace programs may not be able to run at all on =
systems
> +         that do not support unaligned memory accesses.
> +
> +config RISCV_EFFICIENT_VEC_UNALIGNED_ACCESS
> +       bool "Assume the system supports fast vector unaligned memory acc=
esses"
> +       depends on NONPORTABLE
> +       help
> +         Assume that the system supports fast vector unaligned memory ac=
cesses. When
> +         enabled, this option improves the performance of the kernel on =
such
> +         systems. However, the kernel and userspace programs will run mu=
ch more
> +         slowly, or will not be able to run at all, on systems that do n=
ot
> +         support efficient unaligned memory accesses.
> +
>  endchoice
>
>  endmenu # "Platform type"
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 5b243d46f4b1..291935a084d5 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -64,7 +64,8 @@ obj-$(CONFIG_MMU) +=3D vdso.o vdso/
>
>  obj-$(CONFIG_RISCV_MISALIGNED) +=3D traps_misaligned.o
>  obj-$(CONFIG_RISCV_MISALIGNED) +=3D unaligned_access_speed.o
> -obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)     +=3D copy-unaligned.o
> +obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)             +=3D copy-unalign=
ed.o
> +obj-$(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)      +=3D vec-copy-una=
ligned.o
>
>  obj-$(CONFIG_FPU)              +=3D fpu.o
>  obj-$(CONFIG_FPU)              +=3D kernel_mode_fpu.o
> diff --git a/arch/riscv/kernel/copy-unaligned.h b/arch/riscv/kernel/copy-=
unaligned.h
> index e3d70d35b708..85d4d11450cb 100644
> --- a/arch/riscv/kernel/copy-unaligned.h
> +++ b/arch/riscv/kernel/copy-unaligned.h
> @@ -10,4 +10,9 @@
>  void __riscv_copy_words_unaligned(void *dst, const void *src, size_t siz=
e);
>  void __riscv_copy_bytes_unaligned(void *dst, const void *src, size_t siz=
e);
>
> +#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> +void __riscv_copy_vec_words_unaligned(void *dst, const void *src, size_t=
 size);
> +void __riscv_copy_vec_bytes_unaligned(void *dst, const void *src, size_t=
 size);
> +#endif
> +
>  #endif /* __RISCV_KERNEL_COPY_UNALIGNED_H */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index 5b78ea5a84d1..46de3f145154 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -221,6 +221,12 @@ static u64 hwprobe_vec_misaligned(const struct cpuma=
sk *cpus)
>  #else
>  static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>  {
> +       if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_VEC_UNALIGNED_ACCESS))
> +               return RISCV_HWPROBE_VEC_MISALIGNED_FAST;
> +
> +       if (IS_ENABLED(CONFIG_RISCV_SLOW_VEC_UNALIGNED_ACCESS))
> +               return RISCV_HWPROBE_VEC_MISALIGNED_SLOW;
> +
>         return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>  }
>  #endif
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kern=
el/unaligned_access_speed.c
> index 8489e012cf23..a2a8f948500b 100644
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
> @@ -267,9 +269,129 @@ static int check_unaligned_access_speed_all_cpus(vo=
id)
>  }
>  #endif
>
> +#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> +static void check_vector_unaligned_access(struct work_struct *unused)
> +{
> +       int cpu =3D smp_processor_id();
> +       u64 start_cycles, end_cycles;
> +       u64 word_cycles;
> +       u64 byte_cycles;
> +       int ratio;
> +       unsigned long start_jiffies, now;
> +       struct page *page;
> +       void *dst;
> +       void *src;
> +       long speed =3D RISCV_HWPROBE_VEC_MISALIGNED_SLOW;
> +
> +       if (per_cpu(vector_misaligned_access, cpu) !=3D RISCV_HWPROBE_VEC=
_MISALIGNED_SLOW)
> +               return;
> +
> +       page =3D alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> +       if (!page) {
> +               pr_warn("Allocation failure, not measuring vector misalig=
ned performance\n");
> +               return;
> +       }
> +
> +       /* Make an unaligned destination buffer. */
> +       dst =3D (void *)((unsigned long)page_address(page) | 0x1);
> +       /* Unalign src as well, but differently (off by 1 + 2 =3D 3). */
> +       src =3D dst + (MISALIGNED_BUFFER_SIZE / 2);
> +       src +=3D 2;
> +       word_cycles =3D -1ULL;
> +
> +       /* Do a warmup. */
> +       kernel_vector_begin();

Should there be a preempt_disable() in here too, or is that implied
already by schedule_on_each_cpu? Mainly we want to minimize the amount
of things that might soak up our jiffy and steal iterations from the
loop.

> +       __riscv_copy_vec_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +
> +       start_jiffies =3D jiffies;
> +       while ((now =3D jiffies) =3D=3D start_jiffies)
> +               cpu_relax();
> +
> +       /*
> +        * For a fixed amount of time, repeatedly try the function, and t=
ake
> +        * the best time in cycles as the measurement.
> +        */
> +       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES=
_LG2))) {
> +               start_cycles =3D get_cycles64();
> +               /* Ensure the CSR read can't reorder WRT to the copy. */
> +               mb();
> +               __riscv_copy_vec_words_unaligned(dst, src, MISALIGNED_COP=
Y_SIZE);
> +               /* Ensure the copy ends before the end time is snapped. *=
/
> +               mb();
> +               end_cycles =3D get_cycles64();
> +               if ((end_cycles - start_cycles) < word_cycles)
> +                       word_cycles =3D end_cycles - start_cycles;
> +       }
> +
> +       byte_cycles =3D -1ULL;
> +       __riscv_copy_vec_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +       start_jiffies =3D jiffies;
> +       while ((now =3D jiffies) =3D=3D start_jiffies)
> +               cpu_relax();
> +
> +       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES=
_LG2))) {
> +               start_cycles =3D get_cycles64();
> +               mb();
> +               __riscv_copy_vec_bytes_unaligned(dst, src, MISALIGNED_COP=
Y_SIZE);
> +               mb();
> +               end_cycles =3D get_cycles64();
> +               if ((end_cycles - start_cycles) < byte_cycles)
> +                       byte_cycles =3D end_cycles - start_cycles;
> +       }
> +
> +       kernel_vector_end();
> +
> +       /* Don't divide by zero. */
> +       if (!word_cycles || !byte_cycles) {
> +               pr_warn("cpu%d: rdtime lacks granularity needed to measur=
e unaligned vector access speed\n",
> +                       cpu);
> +
> +               return;
> +       }
> +
> +       if (word_cycles < byte_cycles)
> +               speed =3D RISCV_HWPROBE_VEC_MISALIGNED_FAST;
> +
> +       ratio =3D div_u64((byte_cycles * 100), word_cycles);
> +       pr_info("cpu%d: Ratio of vector byte access time to vector unalig=
ned word access is %d.%02d, unaligned accesses are %s\n",
> +               cpu,
> +               ratio / 100,
> +               ratio % 100,
> +               (speed =3D=3D  RISCV_HWPROBE_VEC_MISALIGNED_FAST) ? "fast=
" : "slow");
> +
> +       per_cpu(vector_misaligned_access, cpu) =3D speed;
> +}
> +
> +static int riscv_online_cpu_vec(unsigned int cpu)
> +{
> +       check_vector_unaligned_access(NULL);
> +       return 0;
> +}
> +
> +/* Measure unaligned access speed on all CPUs present at boot in paralle=
l. */
> +static int vec_check_unaligned_access_speed_all_cpus(void *unused)
> +{
> +       schedule_on_each_cpu(check_vector_unaligned_access);
> +
> +       /*
> +        * Setup hotplug callbacks for any new CPUs that come online or g=
o
> +        * offline.
> +        */
> +       cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> +                                 riscv_online_cpu_vec, NULL);
> +
> +       return 0;
> +}
> +#else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
> +static int vec_check_unaligned_access_speed_all_cpus(void *unused)
> +{
> +       return 0;
> +}
> +#endif
> +
>  static int check_unaligned_access_all_cpus(void)
>  {
> -       bool all_cpus_emulated;
> +       bool all_cpus_emulated, all_cpus_vec_supported;
>         int cpu;
>
>         if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
> @@ -285,7 +407,13 @@ static int check_unaligned_access_all_cpus(void)
>         }
>
>         all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus();
> -       check_vector_unaligned_access_emulated_all_cpus();
> +       all_cpus_vec_supported =3D check_vector_unaligned_access_emulated=
_all_cpus();
> +
> +       if (all_cpus_vec_supported &&

Note that with this here, if a heterogeneous system ever shows up with
a mix of supported/unsupported, the supported cpus will end up with a
misaligned vector speed of UNKNOWN. It might be nicer to change the
semantics of that return value from all_cpus_vec_supported (aka
entirely_supported) to entirely_unsupported. Then you'd only fire up
the thread if (!entirely_unsupported). If you did that, you'd also
need to bail early in the check on any CPUs that already had their
value set to UNSUPPORTED. That way we can still avoid firing up this
thread for machines that don't have misaligned V (or V at all), but
not leave the question UNKNOWN in some cases.

> +           IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
> +               kthread_run(vec_check_unaligned_access_speed_all_cpus,
> +                           NULL, "vec_check_unaligned_access_speed_all_c=
pus");
> +       }
>
>         if (!all_cpus_emulated)
>                 return check_unaligned_access_speed_all_cpus();
> diff --git a/arch/riscv/kernel/vec-copy-unaligned.S b/arch/riscv/kernel/v=
ec-copy-unaligned.S
> new file mode 100644
> index 000000000000..e5bc94917e60
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
> +       .text
> +
> +#define WORD_EEW 32
> +
> +#define WORD_SEW CONCATENATE(e, WORD_EEW)
> +#define VEC_L CONCATENATE(vle, WORD_EEW).v
> +#define VEC_S CONCATENATE(vle, WORD_EEW).v
> +
> +/* void __riscv_copy_vec_words_unaligned(void *, const void *, size_t) *=
/
> +/* Performs a memcpy without aligning buffers, using word loads and stor=
es. */
> +/* Note: The size is truncated to a multiple of WORD_EEW */
> +SYM_FUNC_START(__riscv_copy_vec_words_unaligned)
> +       andi  a4, a2, ~(WORD_EEW-1)
> +       beqz  a4, 2f
> +       add   a3, a1, a4
> +       .option push
> +       .option arch, +zve32x
> +1:
> +       vsetivli t0, 8, WORD_SEW, m8, ta, ma
> +       VEC_L v0, (a1)
> +       VEC_S v0, (a0)
> +       addi  a0, a0, WORD_EEW
> +       addi  a1, a1, WORD_EEW
> +       bltu  a1, a3, 1b
> +
> +2:
> +       .option pop
> +       ret
> +SYM_FUNC_END(__riscv_copy_vec_words_unaligned)
> +
> +/* void __riscv_copy_vec_bytes_unaligned(void *, const void *, size_t) *=
/
> +/* Performs a memcpy without aligning buffers, using only byte accesses.=
 */
> +/* Note: The size is truncated to a multiple of 8 */
> +SYM_FUNC_START(__riscv_copy_vec_bytes_unaligned)
> +       andi a4, a2, ~(8-1)
> +       beqz a4, 2f
> +       add  a3, a1, a4
> +       .option push
> +       .option arch, +zve32x
> +1:
> +       vsetivli t0, 8, e8, m8, ta, ma
> +       vle8.v v0, (a1)
> +       vse8.v v0, (a0)
> +       addi a0, a0, 8
> +       addi a1, a1, 8
> +       bltu a1, a3, 1b
> +
> +2:
> +       .option pop
> +       ret
> +SYM_FUNC_END(__riscv_copy_vec_bytes_unaligned)
> --
> 2.45.2
>

