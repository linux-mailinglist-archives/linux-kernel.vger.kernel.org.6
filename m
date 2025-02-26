Return-Path: <linux-kernel+bounces-534531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E402FA46829
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE021884F73
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17484224B15;
	Wed, 26 Feb 2025 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmhKH2zQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733FF1E1E1A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591276; cv=none; b=kVrGPvaFlYSW2lBjQklbQhrmo3l0+j2woKJ1HST+dGTk/5dLfoN9ZtWpBWKItWQnmpW0yCKa3hv+CoMomlxJvx/n1VK+B2m0kbK1kwsSxhZ9wNO6xywtqB+luiwRLhAIJGL2/3i66Dq7A2L/m1JjWnivLXO39gL9sn4koUU7tfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591276; c=relaxed/simple;
	bh=jCRPNLGSi/oQj3TrKIvzQq1kRoQsVcTmH9HUiymr1As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcwTdDpgC79IZWDIwXKc4zuM13W8YWSoybY2cPr7KkuVbaxHXH9NAGN3HyM/YqvwbhGzXPy/zONeSG62Kg3snaGzaKyRAipZFLNgieIwkwZNRZrI1Yy71kBm7lYmv/aUcJW85hNvFCsMrGtUVs51Ul4M+RhdneDN65UKvPCxqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmhKH2zQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f378498b0so5920732f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740591273; x=1741196073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk9vQF5EfQ/Ok65dcPgc2M8a/3DSVXE8cp20Sffo8xY=;
        b=dmhKH2zQ8E/qZM+O/FXDIw8/2Oc7XxcuoBaFBKZn/mwm2fz67h7ZquzED5N2hnf4+O
         PCFSb9shQWZcv3XtiITsU5xhkuW7Sjh2wDIUt5wRqchcT5K9LG99ti/kuGT/N/OArM0O
         sHSBZEdGujqO93cHARreBJaWlenkgDRMbTgGTfrjFYsQjxt8n2ISFmCXk+eBgrFosVKd
         wkhAaRGa/YDQYPomz0UI1INuMtKQ4rdb4i7IKngTMyK/2R7QXs8VCOz5Uq8yqv1hKXdy
         +ABklcGHUULHR9Q/dsD6cm1Zm34Y66Cvp4YhmWgRY4de+BUkSIRXegHC+NXiRTwFAUlD
         /qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740591273; x=1741196073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk9vQF5EfQ/Ok65dcPgc2M8a/3DSVXE8cp20Sffo8xY=;
        b=AluUUciokqwMgE2wjv8DbSvak5mR0qt8PVwfO9XFkCoQK0VqhuLJg4loBMaoGMEhzc
         OxgDv/UNtaAvefoNutwLap9/ptNqxz8cz4goJwGNlwgxqP2yE84U4WV6upZtfZRhxQZi
         LgX49n+moPq9qWKLibPlWCg/qCyW2GnFMUzsJSgJ2TUj9yIrR7D27ESDBkuLi671SosE
         PQXxDrfjPL6dffCuu9Bp1HgGFQAu8f80Sd0MRWNWXhpLLV9ejp3oxpgIjPC6MscXUdKg
         1i9zV34ZYlRA7CL32BscbzBVWV0f6yyH7OJycjdSoxBQMC8ZHtnL2TZDybJfQl8RT1se
         419w==
X-Forwarded-Encrypted: i=1; AJvYcCUv/wa/8Lb2V+Dl176FrBb/G4SmoOqPln++uAkDDKcojAIrSM2Leu71wQiL7jYqzFQspJaqo18GjSSHFdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPWTnvUmH8JuU+s5Bv4tK6JN2bItalKB+z/p27MXbeyKPy4Uv
	3GDu55waGKK85NyuYkWOTwVP16tCp6Mb8vx7miYTzzO02AWjZlzyrROiSEU9ozUun8W5QORxHbg
	p89NSsRFt0t2yqQy3sB5q0fPCVaM=
X-Gm-Gg: ASbGncs/a8whHxJakxVUp/6DltoHxxFxtx9Y/OtAxa3+WDK5wQWBortIshjUoQxljuw
	dBn448FzUMBWtcGZLcqr/BenlITD2xBBlP1eITlxG16JvDSYdrKLZceI/6M+DeKyBrPaelK5kIV
	pytGEpE84=
X-Google-Smtp-Source: AGHT+IHv78SlBVrJnqZc1wfB0Dm1rMWidmm78JH5ipxyqSTd1JOH7deq52Yh/Ml3OCKNcPg/n9t2JzU84r3WW8Bg1zg=
X-Received: by 2002:a05:6000:156c:b0:390:dfec:259e with SMTP id
 ffacd0b85a97d-390dfec2748mr1127923f8f.28.1740591272442; Wed, 26 Feb 2025
 09:34:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117164536.3918949-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20250117164536.3918949-1-Mr.Bossman075@gmail.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Wed, 26 Feb 2025 12:33:55 -0500
X-Gm-Features: AQ5f1Jq3UvHVqA2QSiPG2s2N6c54tqzunb7-m3q7gugH9eFkG2wEagm1mHr3iXU
Message-ID: <CAJFTR8Q0rruNDSC0_biPhHQqnHobTaZc=6so2kAuw5jbJcs-9g@mail.gmail.com>
Subject: Re: [PATCH v5] clocksource/drivers/timer-clint: Add T-Head C9xx clint
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, 
	Conor Dooley <conor@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, Jisheng Zhang <jszhang@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 11:45=E2=80=AFAM Jesse Taube <mr.bossman075@gmail.c=
om> wrote:
>
> From: Jisheng Zhang <jszhang@kernel.org>
>
> To use the T-HEAD C9xx clint in RISCV-M NOMMU env, we need to take
> care two points:
>
> 1.The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
> implement such support.
>
> 2. As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer:
> add a quirk for lacking mtime register") of opensbi:
>
> "T-Head developers surely have a different understanding of time CSR and
> CLINT's mtime register with SiFive ones, that they did not implement
> the mtime register at all -- as shown in openC906 source code, their
> time CSR value is just exposed at the top of their processor IP block
> and expects an external continous counter, which makes it not
> overrideable, and thus mtime register is not implemented, even not for
> reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
> extended CSR, these systems still rely on the mtimecmp registers to
> generate timer interrupts. This makes it necessary to implement T-Head
> C9xx CLINT support in OpenSBI MTIMER driver, which skips implementing
> reading mtime register and falls back to default code that reads time
> CSR."
>
> So, we need to fall back to read time CSR instead of mtime register.
> Add riscv_csr_time_available static key for this purpose.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> Treat this as a completely new patch, as it is mostly rewritten.
> Original:
> https://lore.kernel.org/all/20240410142347.964-3-jszhang@kernel.org/
> V3 -> V4:
>  - Add riscv,csr-clint
>  - Allow using of CSRs in S mode
>  - Change if return else return to if return return
>  - Change static_branch_likely to static_branch_unlikely
>  - Fix 32-bit clint_get_cycles64 csr_available check being inverted
>  - Fix is_c900_clint being uninitialized
> V4 -> V5:
>  - Remove riscv,csr-clint
>  - Remove riscv_csr_time_available
>  - Replace all static_branch_unlikely(&riscv_csr_time_available) with
>     riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR)
> ---
>  arch/riscv/include/asm/timex.h    | 12 +++++++-
>  drivers/clocksource/timer-clint.c | 50 +++++++++++++++++++++++++++----
>  2 files changed, 56 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/time=
x.h
> index a06697846e69..d78075351bf4 100644
> --- a/arch/riscv/include/asm/timex.h
> +++ b/arch/riscv/include/asm/timex.h
> @@ -17,17 +17,26 @@ typedef unsigned long cycles_t;
>  #ifdef CONFIG_64BIT
>  static inline cycles_t get_cycles(void)
>  {
> +       if (riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR))
> +               return csr_read(CSR_TIME);
> +
>         return readq_relaxed(clint_time_val);
>  }
>  #else /* !CONFIG_64BIT */
>  static inline u32 get_cycles(void)
>  {
> +       if (riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR))
> +               return csr_read(CSR_TIME);
> +
>         return readl_relaxed(((u32 *)clint_time_val));
>  }
>  #define get_cycles get_cycles
>
>  static inline u32 get_cycles_hi(void)
>  {
> +       if (riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR))
> +               return csr_read(CSR_TIMEH);
> +
>         return readl_relaxed(((u32 *)clint_time_val) + 1);
>  }
>  #define get_cycles_hi get_cycles_hi
> @@ -40,7 +49,8 @@ static inline u32 get_cycles_hi(void)
>   */
>  static inline unsigned long random_get_entropy(void)
>  {
> -       if (unlikely(clint_time_val =3D=3D NULL))
> +       if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR) &&
> +          (unlikely(clint_time_val =3D=3D NULL)))
>                 return random_get_entropy_fallback();
>         return get_cycles();
>  }
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/time=
r-clint.c
> index 0bdd9d7ec545..cdf8b33d2dd2 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -39,6 +39,7 @@ static u64 __iomem *clint_timer_cmp;
>  static u64 __iomem *clint_timer_val;
>  static unsigned long clint_timer_freq;
>  static unsigned int clint_timer_irq;
> +static bool is_c900_clint;
>
>  #ifdef CONFIG_RISCV_M_MODE
>  u64 __iomem *clint_time_val;
> @@ -79,6 +80,9 @@ static void clint_ipi_interrupt(struct irq_desc *desc)
>  #ifdef CONFIG_64BIT
>  static u64 notrace clint_get_cycles64(void)
>  {
> +       if (riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR))
> +               return csr_read(CSR_TIME);
> +
>         return clint_get_cycles();
>  }
>  #else /* CONFIG_64BIT */
> @@ -86,10 +90,17 @@ static u64 notrace clint_get_cycles64(void)
>  {
>         u32 hi, lo;
>
> -       do {
> -               hi =3D clint_get_cycles_hi();
> -               lo =3D clint_get_cycles();
> -       } while (hi !=3D clint_get_cycles_hi());
> +       if (riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR)) {
> +               do {
> +                       hi =3D csr_read(CSR_TIMEH);
> +                       lo =3D csr_read(CSR_TIME);
> +               } while (hi !=3D csr_read(CSR_TIMEH));
> +       } else {
> +               do {
> +                       hi =3D clint_get_cycles_hi();
> +                       lo =3D clint_get_cycles();
> +               } while (hi !=3D clint_get_cycles_hi());
> +       }
>
>         return ((u64)hi << 32) | lo;
>  }
> @@ -119,6 +130,19 @@ static int clint_clock_next_event(unsigned long delt=
a,
>         return 0;
>  }
>
> +static int c900_clint_clock_next_event(unsigned long delta,
> +                                      struct clock_event_device *ce)
> +{
> +       void __iomem *r =3D clint_timer_cmp +
> +                         cpuid_to_hartid_map(smp_processor_id());
> +       u64 val =3D clint_get_cycles64() + delta;
> +
> +       csr_set(CSR_IE, IE_TIE);
> +       writel_relaxed(val, r);
> +       writel_relaxed(val >> 32, r + 4);
> +       return 0;
> +}
> +
>  static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) =3D =
{
>         .name           =3D "clint_clockevent",
>         .features       =3D CLOCK_EVT_FEAT_ONESHOT,
> @@ -130,6 +154,9 @@ static int clint_timer_starting_cpu(unsigned int cpu)
>  {
>         struct clock_event_device *ce =3D per_cpu_ptr(&clint_clock_event,=
 cpu);
>
> +       if (is_c900_clint)
> +               ce->set_next_event =3D c900_clint_clock_next_event;
> +
>         ce->cpumask =3D cpumask_of(cpu);
>         clockevents_config_and_register(ce, clint_timer_freq, 100, ULONG_=
MAX);
>
> @@ -161,7 +188,7 @@ static irqreturn_t clint_timer_interrupt(int irq, voi=
d *dev_id)
>         return IRQ_HANDLED;
>  }
>
> -static int __init clint_timer_init_dt(struct device_node *np)
> +static int __init clint_timer_init(struct device_node *np)
>  {
>         int rc;
>         u32 i, nr_irqs;
> @@ -273,5 +300,18 @@ static int __init clint_timer_init_dt(struct device_=
node *np)
>         return rc;
>  }
>
> +static int __init clint_timer_init_dt(struct device_node *np)
> +{
> +       is_c900_clint =3D false;
> +       return clint_timer_init(np);
> +}
> +
> +static int __init c900_clint_timer_init_dt(struct device_node *np)
> +{
> +       is_c900_clint =3D true;
> +       return clint_timer_init(np);
> +}
> +
>  TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
>  TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
> +TIMER_OF_DECLARE(clint_timer2, "thead,c900-clint", c900_clint_timer_init=
_dt);
> --
> 2.45.2
>

Any updates on this palmer?
It seems to be marked as handled elsewhere on patchwork, but i'm not
sure where and iirc i didn't mark it as that.
https://patchwork.kernel.org/project/linux-riscv/patch/20250117164536.39189=
49-1-Mr.Bossman075@gmail.com/

Thanks,
Jesse Taube

