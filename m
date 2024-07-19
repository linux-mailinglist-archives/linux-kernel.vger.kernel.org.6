Return-Path: <linux-kernel+bounces-257658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95098937D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 22:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4667A28293C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3A81487DD;
	Fri, 19 Jul 2024 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FSUU0Riy"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A24696
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721419257; cv=none; b=TTp+a7bwZRJQlj/jgJXZYhgHh8/kjYeUNJXs/TatYkm4WNWdx8B/WDX/u4aTg8Fu1JiupDP09nRfav3fSLtarwB34vCUjpcfoyabaRMmv6YiDB5aKLm3GbJFI56cGWbD810uY3OXcJRY7E3pfB6k/PwCAFs2f8Q5+kbrrVSTFOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721419257; c=relaxed/simple;
	bh=fLU250KKk4GDqoHmjHVqm8RZgL8+/qd+wabwcG6ODPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/ZsfL6K1T6TdboSgrmufvpM7VItpXAs2jhMeJYclQpnLdmYuVnDqaNeRsyL5nr892lA0o8otfUQDm1rHYFmcCDRy8LigjX0pBBetavnkgPLKpNiOyAWlWJLZ4PS7BQhUkURsUJYU/mPnUVDbR5Qjtp8WferwDmqqLgQ/HDkX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FSUU0Riy; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e976208f8so1831961e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721419253; x=1722024053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgZveHAFuCGYU1QTMSIXnJkxa50ASbwMT4UwZRXfxNY=;
        b=FSUU0RiyOp62pnb8Iqx5/Dw8Y9ZbQsXwwY2F43U92S0GlNxZNyFMzJR0kl6vhl9Thi
         i2wHyBfviSlXT/ECicdTwMxhDdfr7lcCkvBMOsAhryfLfBtN0jI0RwG0b5W/rNhaiD9n
         H64zePw5fzTDwnL/q4W7as0l47yJm5+YB2gzyGtRfIkP7KnKaEvPcJv7i058zSG/AMbX
         oqx7NVtu5BlIc3Zv7fPIed85c+6+eT66lrNbqwphnIW7sf6Yeu6v89GjqSYlxUtBHXzX
         Wqdw0x8iHOsdZmQcfWQFrTIt9Y8JWi9u2dZwnusV1DOWLQ1zRCoMGSgy7vD1+qkm2oRR
         Qf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721419253; x=1722024053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgZveHAFuCGYU1QTMSIXnJkxa50ASbwMT4UwZRXfxNY=;
        b=UAOQXLkjC1Zy12/3XsfFCDFTRIebf566I77etHxoFNQMWkNcNBJfs1hQFQ4c9tI7Ar
         zlpxzSfJLSDqD0B57hsjdrrfkcPN+TnBgRey3+pibUmBDPTrtxQgr6txc+/XpziFQSOc
         V3l7GzJokhDfS1mnXTeJK4w74yMd/wOpod6jnSaCgyD+Um/EjGwv36slrK4ZAboiYTox
         Wxn5FYgYwt/FUDicHPdch09qpltBYcJxc6vOOv5gHB5UQGbYTfL4kc8c0vV9xh9Jq/Ui
         3gZn6hWWlTsLWG9rEN/DPwFR6E49gJpob00kyvxm9siDiWKb361cugMLB/mvmSaFFmRv
         FcRw==
X-Forwarded-Encrypted: i=1; AJvYcCW6VfSnN7MNxJ2WpAMHytDE5MacUGX9x81CbV3BPsENv9mALPFaO9CpgeexelMtTZKUMUXmz0+CMSwWL2gZk3up3A7myvlVe/YaI08G
X-Gm-Message-State: AOJu0YxMC6pC3mioFb2L3br/JS9shtRlAoTR56H84yMv/Ea4ZRyIxm22
	kMil93TAog1S/zScPVXKaX5Y4VLFbYnRD/4OFm4bIJcPoYaYIApCv+4yq5gKYX0f31XsS12Jhze
	cCPeZmyah7DF6tjCvvXmhW5lrRqG8NLcuin9u9w==
X-Google-Smtp-Source: AGHT+IHzx5vSRfplbcyrLAbw9st5ra8jGQRbdRyLVjqGIQ25xI47wFegvfkx2WDreTsZe5CVV33vrKU0xv6JnDqT+Rc=
X-Received: by 2002:a05:6512:1291:b0:52e:934c:8e76 with SMTP id
 2adb3069b0e04-52ee5411686mr7049093e87.41.1721419252553; Fri, 19 Jul 2024
 13:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717180727.4180475-1-jesse@rivosinc.com> <20240717180727.4180475-7-jesse@rivosinc.com>
In-Reply-To: <20240717180727.4180475-7-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 19 Jul 2024 13:00:16 -0700
Message-ID: <CALs-Hsuph7-1FmTqtH-395k84f5ZzkKu8PbX7VqU5JkshFr_3w@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] RISC-V: Report vector unaligned access speed hwprobe
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

On Wed, Jul 17, 2024 at 11:08=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> Detect if vector misaligned accesses are faster or slower than
> equivalent vector byte accesses. This is useful for usermode to know
> whether vector byte accesses or vector misaligned accesses have a better
> bandwidth for operations like memcpy.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> V1 -> V2:
>  - Add Kconfig options
>  - Add WORD_EEW to vec-copy-unaligned.S
> V2 -> V3:
>  - Remove unnecessary comment
>  - Remove local_irq_enable
> V3 -> V4:
>  - Add preempt_disable/enable
>  - Alphabetize includes in vec-copy-unaligned.S and unaligned_access_spee=
d.c
>  - Add duplicate comments above mb() to please checkpatch
>  - change all_cpus_vec_supported to all_cpus_vec_unsupported
>     so speed is tested if any cpus support unaligned vector accesses
>  - Spell out _VECTOR_ in macros
> V4 -> V5:
>  - Change void *unused to void *unused __always_unused
> ---
>  arch/riscv/Kconfig                         |  18 +++
>  arch/riscv/kernel/Makefile                 |   3 +-
>  arch/riscv/kernel/copy-unaligned.h         |   5 +
>  arch/riscv/kernel/sys_hwprobe.c            |   6 +
>  arch/riscv/kernel/unaligned_access_speed.c | 134 ++++++++++++++++++++-
>  arch/riscv/kernel/vec-copy-unaligned.S     |  58 +++++++++
>  6 files changed, 221 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ffbe0fdd7fb3..e98139340c1c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -807,6 +807,24 @@ config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
>           will dynamically determine the speed of vector unaligned access=
es on
>           the underlying system if they are supported.
>
> +config RISCV_SLOW_VECTOR_UNALIGNED_ACCESS
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
> +config RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
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
> index 2e3e324bad38..99d3e63d0444 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -221,6 +221,12 @@ static u64 hwprobe_vec_misaligned(const struct cpuma=
sk *cpus)
>  #else
>  static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>  {
> +       if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS))
> +               return RISCV_HWPROBE_VECTOR_MISALIGNED_FAST;
> +
> +       if (IS_ENABLED(CONFIG_RISCV_SLOW_VECTOR_UNALIGNED_ACCESS))
> +               return RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW;
> +
>         return RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
>  }
>  #endif
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kern=
el/unaligned_access_speed.c
> index 24b8883a23f0..532e9151685b 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -6,11 +6,13 @@
>  #include <linux/cpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/jump_label.h>
> +#include <linux/kthread.h>
>  #include <linux/mm.h>
>  #include <linux/smp.h>
>  #include <linux/types.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwprobe.h>
> +#include <asm/vector.h>
>
>  #include "copy-unaligned.h"
>
> @@ -267,12 +269,140 @@ static int check_unaligned_access_speed_all_cpus(v=
oid)
>  }
>  #endif
>
> +#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> +static void check_vector_unaligned_access(struct work_struct *work __alw=
ays_unused)
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
> +       long speed =3D RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW;
> +
> +       if (per_cpu(vector_misaligned_access, cpu) !=3D RISCV_HWPROBE_VEC=
TOR_MISALIGNED_SLOW)
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
> +               /* Ensure the CSR read can't reorder WRT to the copy. */
> +               mb();
> +               __riscv_copy_vec_bytes_unaligned(dst, src, MISALIGNED_COP=
Y_SIZE);
> +               /* Ensure the copy ends before the end time is snapped. *=
/
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
> +               speed =3D RISCV_HWPROBE_VECTOR_MISALIGNED_FAST;
> +
> +       ratio =3D div_u64((byte_cycles * 100), word_cycles);
> +       pr_info("cpu%d: Ratio of vector byte access time to vector unalig=
ned word access is %d.%02d, unaligned accesses are %s\n",
> +               cpu,
> +               ratio / 100,
> +               ratio % 100,
> +               (speed =3D=3D  RISCV_HWPROBE_VECTOR_MISALIGNED_FAST) ? "f=
ast" : "slow");
> +
> +       per_cpu(vector_misaligned_access, cpu) =3D speed;
> +}
> +
> +static int riscv_online_cpu_vec(unsigned int cpu)
> +{
> +       check_vector_unaligned_access(NULL);

Maybe I missed the call site in another patch, but are you calling
check_vector_unaligned_access_emulated() anywhere in the hotplug path?
Without this, for a CPU that wasn't present at boot, it seems like the
per-cpu variable would be set to its initialized value of UNSUPPORTED,
and then you'd bail early out of check_vector_unaligned_access() at
the "!=3D SLOW" conditional.

IMO it would be better if the values truly meant what they said. So we
initialize it to UNKNOWN, unconditionally change to UNSUPPORTED if we
discover it's emulated or there is no vector support, and only set to
SLOW or FAST as a result of probe measurement or Kconfig override.
It's the "SLOW means slow or don't know" from the previous patch
that's bugging me. This creates downstream effects like this "!=3D SLOW"
conditional (by which you really mean "!=3D UNKNOWN") that are
challenging to reason about and maintain.

I have this vague sense that you did this in response to feedback in
an earlier series, but I can't find it now.


-Evan


> +       return 0;
> +}
> +
> +/* Measure unaligned access speed on all CPUs present at boot in paralle=
l. */
> +static int vec_check_unaligned_access_speed_all_cpus(void *unused __alwa=
ys_unused)
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
> +static int vec_check_unaligned_access_speed_all_cpus(void *unused __alwa=
ys_unused)
> +{
> +       return 0;
> +}
> +#endif
> +
>  static int check_unaligned_access_all_cpus(void)
>  {
> -       bool all_cpus_emulated;
> +       bool all_cpus_emulated, all_cpus_vec_unsupported;
>
>         all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus();
> -       check_vector_unaligned_access_emulated_all_cpus();
> +       all_cpus_vec_unsupported =3D check_vector_unaligned_access_emulat=
ed_all_cpus();
> +
> +       if (!all_cpus_vec_unsupported &&
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
> index 000000000000..d16f19f1b3b6
> --- /dev/null
> +++ b/arch/riscv/kernel/vec-copy-unaligned.S
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2024 Rivos Inc. */
> +
> +#include <linux/args.h>
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
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

