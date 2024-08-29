Return-Path: <linux-kernel+bounces-306140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F37F09639D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248791C21AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2746B149005;
	Thu, 29 Aug 2024 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="P/YQ/aUB"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097E148FFC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724908735; cv=none; b=jn3iFQR45HXXun5DNw2pgXzgiF/fdRxwy+o1cehTGK9+xeT3wpFUigwQVqe4FzZam+lRdVNvG1cTqLiajp6j6J5pX1PeBBc7Ok7XA2IbW6L//EDvzeVGIjdkYo9H4DqZMSELRvldvaV5Itj1x8leFUCfgZ3gC716apuKDU9JrTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724908735; c=relaxed/simple;
	bh=fpDL+0iQpSY0M89Gx8z/O74o8zRNybUVdR1eVGEjXso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEekDgyD8h4Ws1qWYn36ciLmmlhhW/lVbjaZVzICqDg4d4i1aLZ61l1vJe+WZFOv4uCGx8K/Ckps5+36/z1EpovT7INyAA3yp88cqi0ZhUqwpQtaCCh/+ZG6HAWLHr4qys5gQUj6lJbDNZ/Y3tx6ZZ1wGTI02sSIfWmGr+ooW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=P/YQ/aUB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5334a8a1af7so209557e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724908732; x=1725513532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADd1pz5qb8GZVaGnMeyK+BMDRUUvVX49wNmIVUmxoso=;
        b=P/YQ/aUBHk2m6EMrXR+x5/KXJ9RzvaiVPHM2HlxlzppWAlKRKFzt0ALRwpwvPOQ8MC
         aDxNpOD2KHXjPYJ1yJMQgKbtyqACFYxBH9RdPsKpVSgT/ihSjnomCpard//TDDwLa6RS
         ciIR3Ec2XvOxUwWWHPy2kmg08p1k7enMfKt2v5gkcWuz4NuV6vHxCB0KEkhWiodLzm0H
         CdZuRPrR1eZxjagj/E4n5zm/KunfW+Ia6jlv7zjwzDKCg1J69lhY2OzjuJWIrZP7dKGN
         kIfKAX03b+HR1rnBTs9mkmth4iF14f3bxCpMyQYM1dBZlmf59LNkDQl/h8OnESNVkP7Z
         1PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724908732; x=1725513532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADd1pz5qb8GZVaGnMeyK+BMDRUUvVX49wNmIVUmxoso=;
        b=tgGgSNO/0f5Q+cBOcQsDvM7HnGNjjiYHpLs0ynMUBRylz6P691yBjTmWxLL/N7a1Gb
         cACeLzAx6E84rxdoQ6ZV9hrsIU915BdNqa6QFMEmXZuEneKvUc+EXEd63xnQeage1d2S
         rnXGOUH/1qqdfFWbnDPWhXnUbryQ5MxlFwQDfyeoBW7fgC8uX2kuNnwvgGpok/0RuEO0
         vBBPLuUAQQ7XH3jAPIRfPmnNUp3FNAW6hvEcTJ50JsDv3cq369sH55KcX+DxQLMTvcRt
         KPZynNIHSw57jAmssD+zJrir4tK0xSaJnKZxugPD4XyzTlrEyYPciYAh+ru4+luzAT03
         eFIw==
X-Forwarded-Encrypted: i=1; AJvYcCXuNZxp/QF4g4GhQtgfXjK+xW+ezxKNeicsXl+b+53FFGOLmbOyBqiAST114JbbcwUCEo661NmUE/lbh/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49D5Foqwxh9Mqt4ztydBoy2W96O2ZAezWoIBfXoGBW1Vf3/bE
	Ri+DJ6FHujSllzvU9Af4CMX2z5ENT+Z3T+N0wiT/RW3pqR+ews4PRqMxHQ/fk8Mzk6DyM9sY2Hv
	hS2XoW4LYuQjF+KdbcW3vndZlyZxWoOIO+EbCJw==
X-Google-Smtp-Source: AGHT+IFRqTsQ8ZecaWgM2Dv+1zg5sGgzkhwWVX9acELeYxsUIxzlJDrqJ7iynAbrAbJ7Rf0HT/LZsQk0wrd27CzsnIQ=
X-Received: by 2002:a05:6512:12d1:b0:533:7ce:20e0 with SMTP id
 2adb3069b0e04-5353e548573mr869523e87.8.1724908731314; Wed, 28 Aug 2024
 22:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829033904.477200-1-nick.hu@sifive.com> <20240829033904.477200-3-nick.hu@sifive.com>
In-Reply-To: <20240829033904.477200-3-nick.hu@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 29 Aug 2024 10:48:40 +0530
Message-ID: <CAK9=C2Xui8c0b55WrZxCZYqK=AFmiPT+nG8d_E0d7SpamwvO-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] time-riscv: Stop stimecmp when cpu hotplug
To: Nick Hu <nick.hu@sifive.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:10=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote:
>
> Stop the stimecmp when the cpu is going to be off otherwise the timer
> interrupt may pending while performing power down operation.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> ---
>  drivers/clocksource/timer-riscv.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index 48ce50c5f5e6..9a6acaa8dfb0 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -32,15 +32,19 @@
>  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
>  static bool riscv_timer_cannot_wake_cpu;
>
> +static void riscv_clock_stop_stimecmp(void)
> +{
> +       csr_write(CSR_STIMECMP, ULONG_MAX);
> +       if (IS_ENABLED(CONFIG_32BIT))
> +               csr_write(CSR_STIMECMPH, ULONG_MAX);
> +}
> +
>  static void riscv_clock_event_stop(void)
>  {
> -       if (static_branch_likely(&riscv_sstc_available)) {
> -               csr_write(CSR_STIMECMP, ULONG_MAX);
> -               if (IS_ENABLED(CONFIG_32BIT))
> -                       csr_write(CSR_STIMECMPH, ULONG_MAX);
> -       } else {
> +       if (static_branch_likely(&riscv_sstc_available))
> +               riscv_clock_stop_stimecmp();
> +       else
>                 sbi_set_timer(U64_MAX);
> -       }
>  }
>
>  static int riscv_clock_next_event(unsigned long delta,
> @@ -126,7 +130,11 @@ static int riscv_timer_starting_cpu(unsigned int cpu=
)
>
>  static int riscv_timer_dying_cpu(unsigned int cpu)
>  {
> -       disable_percpu_irq(riscv_clock_event_irq);
> +       if (static_branch_likely(&riscv_sstc_available))
> +               riscv_clock_stop_stimecmp();
> +       else
> +               disable_percpu_irq(riscv_clock_event_irq);
> +

Not disabling riscv_clock_event_irq here for Sstc would now
cause riscv_timer_starting_cpu() to unnecessarily enable it
when the CPU is powered-up.

I think the below change is sufficient for this patch:

diff --git a/drivers/clocksource/timer-riscv.c
b/drivers/clocksource/timer-riscv.c
index 48ce50c5f5e6..546fd248f4ff 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -127,6 +127,11 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 static int riscv_timer_dying_cpu(unsigned int cpu)
 {
        disable_percpu_irq(riscv_clock_event_irq);
+       /*
+        * Stop the timer when the cpu is going to be offline otherwise
+        * the timer interrupt may be pending while performing power-down.
+        */
+       riscv_clock_event_stop();
        return 0;
 }

Regards,
Anup

