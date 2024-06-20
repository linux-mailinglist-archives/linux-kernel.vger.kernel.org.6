Return-Path: <linux-kernel+bounces-223346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D96C911174
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A42285BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308AD1BA072;
	Thu, 20 Jun 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HptS0N/6"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1E1B9ACB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909536; cv=none; b=gq5Q8sY5T1UJfzesJDREtHwBN35lNSQvnAt/0tJW8gQXBVyjMeLiwQgYv8MXv219NN9ew7u+r3rI8R7aSKOmBqZfmYVFXV5m9y/2e+d1oFWilCRA0GkWsBJybBcI7n5N5cxs57/3RPJ7Ndaq+4a2DWLMz7O0X4wvdb+hyMnzbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909536; c=relaxed/simple;
	bh=T8lwaev952HrxdFysFWaM56sfQ9i+l6DBWtzuPxca7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBCQbTyH4K+9tfPT8SEx7qS+LV5yEcKqsn7pl8sQHLWi3ylYxmEOjagdxg7coh+kLpybQNpuZx+PCDJ5Cl/DdqyrL7z4MnfkCqprORU306/RvmYkDvdQEBVOurJicqVGdhoysfb8/s1+siysg3T0XklH79NaHkVqT8zjpZ7OPQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HptS0N/6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f7720e6e8so149920266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718909531; x=1719514331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YMvWI192tIfvDRoALC459hpYR3zXCnDemuYZr9JSWw=;
        b=HptS0N/6X3F6g/x4/SIj2FEo/QIe9eG3yBVTJzfKYJR7wqRSyJyvUoQmbl6kzMs5Ll
         I1qf3Fw5IFIznnuZ0ZOUjDR+UBzdO0V0wCDu54tVcPI4eTMFKDP71bzKgmCMVvDj2AFq
         CXNFM0L7Y0FHZhY4zZLkJ+KFe+J/0RhQIBVy46zHHyOmASwdOTn5g1OWez5wbuD8w2rg
         FUZ+cHH5V5w+yLqLmUm5EEUYOAdFCTFOLCASUZmOIlH5EmMmG7WMhQjl4H7S/UyTuLNg
         ayNHuX4L1mkaJZPZMTgTIo3QisUYucE0ZxgVe93tors2ugRcVjh5l1c0vZWGhepltqvF
         a6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909531; x=1719514331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YMvWI192tIfvDRoALC459hpYR3zXCnDemuYZr9JSWw=;
        b=as3R9v6pROSITPSSgiuePC9luZmq0aGXxbRchoIrpzfpbhgspR6Codvtk+J0EQFet+
         udPMwCVk9qDz7PxWXxQ6Svp4pCwA80DkZtUU+l2RgO67U+x+L5DDxNBF6npNLTBbUIMt
         eWDuNx3q7/mbyZ/VfLlx4Kz/KbdoJl/7dDu0YcgtVq7SOah4nkuIjjrAgV/4ztR7zrUV
         Xx9ghzi9xGMGu6ONQrTsnkOmGh7RW0FsHTIAB23C1T3Iff5uJITxSswH/6WHxlZt2o/M
         vsWP4cwAoWbKmPjReAgAD8iUiu18N0jq/5sym8ZW7IdrXCpJE6nwRvcXXDxqh259/C0X
         MuLA==
X-Forwarded-Encrypted: i=1; AJvYcCWdxi29rSU6jaC3T/+47ujzp9el6TOx18aNDp+OqZyv3ZWT2c8xi7ePMQia3wK3QCS7CrxEs2qFijVlLZ9T82PAZStx9QZAWqZskfUb
X-Gm-Message-State: AOJu0YxFaIMvx7+B2b1/cMu7ngaq/AywQbH66ZjTofFhIEYM4AAPEzB+
	a6UL9QeXH9+8mUxcj1mU0V/ohyGZxgcYYGh6eNXeD9KZbdzICIVFgpWC4uQwhu6B4gl+Hzc8KoZ
	q6Yf81KIxhkZKukFIZkqRlCnpRHkqRIxyCSaQyQ==
X-Google-Smtp-Source: AGHT+IFmWcnxj8tDjLC9b/JdTt0G8QZdoG34kmCKLndFQ3uxrWfwhQsgZUcNEtZ1+sBSIGu1o2pZeoqlHs/R9lf9d8k=
X-Received: by 2002:a17:906:a2da:b0:a6e:fb3c:4b59 with SMTP id
 a640c23a62f3a-a6fab7d6d19mr339755866b.77.1718909531317; Thu, 20 Jun 2024
 11:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613191616.2101821-1-jesse@rivosinc.com> <20240613191616.2101821-6-jesse@rivosinc.com>
In-Reply-To: <20240613191616.2101821-6-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Thu, 20 Jun 2024 11:51:35 -0700
Message-ID: <CALs-HstXyDJ5HfrOwVQ6pR1E2BjSTRtw5w0x8a5dZxBPv6G8rQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] RISC-V: Report vector unaligned access speed hwprobe
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

On Thu, Jun 13, 2024 at 12:17=E2=80=AFPM Jesse Taube <jesse@rivosinc.com> w=
rote:
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
> ---
>  arch/riscv/Kconfig                         |  18 +++
>  arch/riscv/kernel/Makefile                 |   3 +-
>  arch/riscv/kernel/copy-unaligned.h         |   5 +
>  arch/riscv/kernel/sys_hwprobe.c            |   6 +
>  arch/riscv/kernel/unaligned_access_speed.c | 130 ++++++++++++++++++++-
>  arch/riscv/kernel/vec-copy-unaligned.S     |  58 +++++++++
>  6 files changed, 217 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f12df0ca6c18..b181b35f37ca 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -813,6 +813,24 @@ config CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED
>           The kernel and userspace programs may run them successfully on =
systems
>           that do support vector unaligned memory accesses.
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
> index 62ac19c029f1..c4d6f54705a4 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -64,7 +64,8 @@ obj-$(CONFIG_MMU) +=3D vdso.o vdso/
>
>  obj-y  +=3D traps_misaligned.o
>  obj-y  +=3D unaligned_access_speed.o
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
> index c40df314058b..1679db4fe360 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -203,6 +203,12 @@ static u64 hwprobe_vec_misaligned(const struct cpuma=
sk *cpus)
>         if (IS_ENABLED(CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED))
>                 return RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
>
> +       if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_VEC_UNALIGNED_ACCESS))
> +               return RISCV_HWPROBE_VEC_MISALIGNED_FAST;
> +
> +       if (IS_ENABLED(CONFIG_RISCV_SLOW_VEC_UNALIGNED_ACCESS))
> +               return RISCV_HWPROBE_VEC_MISALIGNED_SLOW;
> +
>         /* Return if supported or not even if speed wasn't probed */
>         for_each_cpu(cpu, cpus) {
>                 int this_perf =3D per_cpu(vector_misaligned_access, cpu);
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kern=
el/unaligned_access_speed.c
> index c6106bd4a25a..ddc49cce54e3 100644
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
> @@ -262,9 +264,126 @@ static int check_unaligned_access_speed_all_cpus(vo=
id)
>  }
>  #endif /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
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
> +       local_irq_enable();

Another one here, discussed in the previous patch.

> +       kernel_vector_begin();
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
> +       /* Schecudles work que*/

Tpyos!


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
> +#endif /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
> +
>  static int check_unaligned_access_all_cpus(void)
>  {
> -       bool all_cpus_emulated;
> +       bool all_cpus_emulated, all_cpus_vec_supported;
>         int cpu;
>
>         if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
> @@ -280,7 +399,14 @@ static int check_unaligned_access_all_cpus(void)
>         }
>
>         all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus();
> -       check_vector_unaligned_access_emulated_all_cpus();
> +       all_cpus_vec_supported =3D check_vector_unaligned_access_emulated=
_all_cpus();
> +
> +#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> +       if (all_cpus_vec_supported) {
> +               kthread_run(vec_check_unaligned_access_speed_all_cpus,
> +                           NULL, "vec_check_unaligned_access_speed_all_c=
pus");
> +       }
> +#endif
>
>  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>         if (!all_cpus_emulated)
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
> 2.43.0
>

