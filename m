Return-Path: <linux-kernel+bounces-239414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BD7925F6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A621C223A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39808178CF5;
	Wed,  3 Jul 2024 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="OPy4XGQm"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E56171E70
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007919; cv=none; b=ZfF1QcYMLLs43ESqWOnjWv2tWZxQzvXpYNteUIZm8eK9Vv66rOPE64VSXaalHI8Gf8UTrgIGmC67vLajxlb0euTsJa0I0Eop5vdtPjG5OqsqLWe27nDSEH3/Bac7ZGrNDFbcnUpwV3PFcTQGOps1ksKN7BiDEZzy/bLOTgtbuvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007919; c=relaxed/simple;
	bh=wWDHwFMrAnkV5WaEW0RgDnLWEqsKmujFhA7jcRY3QCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGO/Y3oorWsBFbGebKpUN7W5Bbq4V4ksSfYz5r9vcg1xa/f4chVdUgl3oSB+9rdei+YTDstdpAfya2lI+3fCuY04UR0KODz7gVNEEzdjPwXZFkh1KPFC66tNVHuS2GErHtsrLZd3QQN1KgVR6MRUYye9+1qhg1Z0grAMeyqAAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=OPy4XGQm; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f61549406eso200423739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 04:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1720007916; x=1720612716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBIo+uStCQ1paPqSfZA5+vCejmY+rJugxSJUMJ0dpJs=;
        b=OPy4XGQmp5ZJVwertz4xDgZFocEzQzDZvtbK9+kQhOxacQ7lIhYcqxQrUUYzfB0MSK
         7NoUvahATBT7UJ+153WWxWmqgrAo+tnvJn1rUV2MUpr607nqMqvju7TMIa8UKO0EtDGh
         lCezYp/q2vaqIQuo1L2fq3DtxUorBoxn6YslhnCJf7w6RfrNcTNJa3OW7ilIY1TdmW1U
         3+ixWVJCuXhPGg/GEmiYC1PAcapbL2BRxlVXiWjCDar68mlFdKUpsz36v2O7VDddCiVn
         4G4LedAJtdln0Ml5OX8tdmdNCF/SePTm3y7edS93EYujjuLoRDt90Mz29HvAkaicDI1+
         DW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720007916; x=1720612716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBIo+uStCQ1paPqSfZA5+vCejmY+rJugxSJUMJ0dpJs=;
        b=Y/STWdr2R/WmIdxiiAXgUGCfsZZCsIbym6Kms2TVX0K+JhCzJtfU/ZOczJg3DleR47
         jKuN6rHQu6FHqMdeH6bGPkyfWjbtmYYzjJtj36v2E8iqgqQI3hYDf8/L8EjSzdFfT5k+
         DycCj+r3dCFr0t/d03COHWjBDhiiLP5JqfLC7S7btI4UEiy1m20C36RNb0TBqrOsq85l
         W8vXKjrjhmm1zqYDEgArVjq98IbvHbkwpnZbzhmnqkFcb4qzIJi233avGKuS7T1iIH3Y
         eoDi4vm0eIStHw9uzx5u5XZtcxjRCPgD5dYUWCTaUWH73/EKQsQRXroLskETQkaRzqZF
         0d8A==
X-Forwarded-Encrypted: i=1; AJvYcCU2azTOumbK9Gcbnnz0b6CQpluffHPup4yqDsvPnuOUXRsLk6qNEylE4jS9Lqbyj2TE1m0FNx6CzTbBh0eYeZ6t0obwBUhgwR2vX5Za
X-Gm-Message-State: AOJu0Yx4+CrlyvbpdSBSuH0XjsFKSfWjWyVLf7xuJ29mdDV5b4MV6j6B
	ChK5YnE0xABr5/lpT+lOJKDJFnCb0tqPPvkKwNcRtBxtTFEzOlgHeOshxcTyXJP5RFfrkGbMaer
	sOQfqdrIueCnRcgydRI/XSlV7NlFyat/AmuuENQ==
X-Google-Smtp-Source: AGHT+IGtEVfnde1bieGkI5SLPARCf/348XEIKCJO3SDHaPoIXAvv+n69uX9+bVbyCoNz+uoRDDv5kQ3q8qWIwWtXjR4=
X-Received: by 2002:a05:6e02:17c9:b0:37a:a9f0:f263 with SMTP id
 e9e14a558f8ab-37cd31b75aemr142038025ab.20.1720007916271; Wed, 03 Jul 2024
 04:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703072659.1427616-1-namcao@linutronix.de>
In-Reply-To: <20240703072659.1427616-1-namcao@linutronix.de>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Jul 2024 17:28:23 +0530
Message-ID: <CAAhSdy0ZGD-p0iBVPqHF0RKTwvAAMWwYZ0ufioRrO75JzSh1qQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Fix plic_set_affinity() only enables
 1 cpu
To: Nam Cao <namcao@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, b.spranger@linutronix.de, 
	Christoph Hellwig <hch@lst.de>, Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 12:57=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> plic_set_affinity() only enables interrupt for the first possible CPU in
> the mask. The point is to prevent all CPUs trying to claim an interrupt,
> but only one CPU succeeds and the other CPUs wasted some clock cycles for
> nothing.
>
> However, there are two problems with that:
> 1. Users cannot enable interrupt on multiple CPUs (for example, to minimi=
ze
> interrupt latency).

Well, you are assuming that multiple CPUs are always idle or available
to process interrupts. In other words, if the system is loaded running
some workload on each CPU then performance on multiple CPUs
will degrade since multiple CPUs will wastefully try to claim interrupt.

In reality, we can't make such assumptions and it is better to target a
particular CPU for processing interrupts (just like various other interrupt
controllers). For balancing interrupt processing load, we have software
irq balancers running in user-space (or kernel space) which do a
reasonably fine job of picking appropriate CPU for interrupt processing.

> 2. Even if users do not touch SMP interrupt affinity, plic_set_affinity()
> is still invoked once (in plic_irqdomain_map()). Thus, by default, only
> CPU0 handles interrupts from PLIC. That may overload CPU0.
>
> Considering this optimization is not strictly the best (it is tradeoff
> between CPU cycles and interrupt latency), it should not be forced on
> users.

Randomly attempting to take an interrupt on multiple CPUs affects the
workload running all such CPUs (see above comment).

It's better to have a more predictable and targeted interrupt affinity
so that software irq balancers work effectively.

>
> Rewrite plic_set_affinity() to enable interrupt for all possible CPUs in
> the mask.

At least from my side, it is a NO to this approach.

Regards,
Anup

>
> Before:
> $ cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>  10:       2538       2695       3080       2309  RISC-V INTC   5 Edge   =
   riscv-timer
>  12:          3          0          0          0  SiFive PLIC 111 Edge   =
   17030000.power-controller
>  13:       1163          0          0          0  SiFive PLIC  25 Edge   =
   13010000.spi
>  14:         60          0          0          0  SiFive PLIC   7 Edge   =
   end0
>  15:          0          0          0          0  SiFive PLIC   6 Edge   =
   end0
>  16:          0          0          0          0  SiFive PLIC   5 Edge   =
   end0
>  17:          0          0          0          0  SiFive PLIC  78 Edge   =
   end1
>  18:          0          0          0          0  SiFive PLIC  77 Edge   =
   end1
>  19:          0          0          0          0  SiFive PLIC  76 Edge   =
   end1
>  22:        796          0          0          0  SiFive PLIC  32 Edge   =
   ttyS0
>  23:          0          0          0          0  SiFive PLIC  38 Edge   =
   pl022
>  24:       9062          0          0          0  SiFive PLIC  75 Edge   =
   dw-mci
>  25:          0          0          0          0  SiFive PLIC  35 Edge   =
   10030000.i2c
>  26:          0          0          0          0  SiFive PLIC  37 Edge   =
   10050000.i2c
>  27:          1          0          0          0  SiFive PLIC  50 Edge   =
   12050000.i2c
>  28:          0          0          0          0  SiFive PLIC  51 Edge   =
   12060000.i2c
> IPI0:       118         98         88        138  Rescheduling interrupts
> IPI1:      2272       1910       3758       3200  Function call interrupt=
s
> IPI2:         0          0          0          0  CPU stop interrupts
> IPI3:         0          0          0          0  CPU stop (for crash dum=
p) interrupts
> IPI4:         0          0          0          0  IRQ work interrupts
> IPI5:         0          0          0          0  Timer broadcast interru=
pts
>
> After:
> $ cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>  10:       2539       2734       2295       2552  RISC-V INTC   5 Edge   =
   riscv-timer
>  12:          2          1          0          0  SiFive PLIC 111 Edge   =
   17030000.power-controller
>  13:        643        194        368         75  SiFive PLIC  25 Edge   =
   13010000.spi
>  14:          6         22         19         27  SiFive PLIC   7 Edge   =
   end0
>  15:          0          0          0          0  SiFive PLIC   6 Edge   =
   end0
>  16:          0          0          0          0  SiFive PLIC   5 Edge   =
   end0
>  17:          0          0          0          0  SiFive PLIC  78 Edge   =
   end1
>  18:          0          0          0          0  SiFive PLIC  77 Edge   =
   end1
>  19:          0          0          0          0  SiFive PLIC  76 Edge   =
   end1
>  22:        158        254        226        207  SiFive PLIC  32 Edge   =
   ttyS0
>  23:          0          0          0          0  SiFive PLIC  38 Edge   =
   pl022
>  24:       2265       2250       1452       2024  SiFive PLIC  75 Edge   =
   dw-mci
>  25:          0          0          0          0  SiFive PLIC  35 Edge   =
   10030000.i2c
>  26:          0          0          0          0  SiFive PLIC  37 Edge   =
   10050000.i2c
>  27:          0          0          0          1  SiFive PLIC  50 Edge   =
   12050000.i2c
>  28:          0          0          0          0  SiFive PLIC  51 Edge   =
   12060000.i2c
> IPI0:        92        118        116        120  Rescheduling interrupts
> IPI1:      4135       2653       2170       3160  Function call interrupt=
s
> IPI2:         0          0          0          0  CPU stop interrupts
> IPI3:         0          0          0          0  CPU stop (for crash dum=
p) interrupts
> IPI4:         0          0          0          0  IRQ work interrupts
> IPI5:         0          0          0          0  Timer broadcast interru=
pts
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index 9e22f7e378f5..f30bdb94ceeb 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -163,20 +163,19 @@ static void plic_irq_eoi(struct irq_data *d)
>  static int plic_set_affinity(struct irq_data *d,
>                              const struct cpumask *mask_val, bool force)
>  {
> -       unsigned int cpu;
>         struct plic_priv *priv =3D irq_data_get_irq_chip_data(d);
> +       struct cpumask new_mask;
>
> -       if (force)
> -               cpu =3D cpumask_first_and(&priv->lmask, mask_val);
> -       else
> -               cpu =3D cpumask_first_and_and(&priv->lmask, mask_val, cpu=
_online_mask);
> +       cpumask_and(&new_mask, mask_val, &priv->lmask);
> +       if (!force)
> +               cpumask_and(&new_mask, &new_mask, cpu_online_mask);
>
> -       if (cpu >=3D nr_cpu_ids)
> +       if (cpumask_empty(&new_mask))
>                 return -EINVAL;
>
>         plic_irq_disable(d);
>
> -       irq_data_update_effective_affinity(d, cpumask_of(cpu));
> +       irq_data_update_effective_affinity(d, &new_mask);
>
>         if (!irqd_irq_disabled(d))
>                 plic_irq_enable(d);
> --
> 2.39.2
>

