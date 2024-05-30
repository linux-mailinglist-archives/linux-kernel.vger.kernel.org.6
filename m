Return-Path: <linux-kernel+bounces-195521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A737A8D4DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F048280F11
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86717C206;
	Thu, 30 May 2024 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="NGQ7kVfn"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC33558B8
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079318; cv=none; b=g2PvKIxdpRIEAe08z0Xft7XNVRqZ1GIrFSqBNJf5bej1WJ5+kj7Uhd9mUfz/ZF1QHVw7ds9VMEt/heeW5cugemzeq6njXKQpSrAWgkdkCsEIjYvoWcbmH9Arv0eEty8BI27G5rSfozkQ5iTrKzQKrONbsObAn2AQ+FuoRUhSd7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079318; c=relaxed/simple;
	bh=F90wLy+KrICjTAlBJGruDZO+sk+znv1dpfv/OBIuDnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW1MJZDo2pqnzFGQ1sWz66Hk+Fr53xZnnwRHg4vBo1TtQpW2kN2xYfEwKzvHTKrqmX4mFTmpVuGzyJFO6648uOEiNKjg3Qs+NtUKvQpZ80/Ny7pKjPga1B5JUSpSJB+UEvcTRk4HuhffuWzjpeWrNdmQsXI6ZM7xnf2YwUC8tSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=NGQ7kVfn; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-374599be371so3084325ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1717079314; x=1717684114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrFY0VaYKU2vD77g/VQDb0AaoaOV/tz1VO820emrTH8=;
        b=NGQ7kVfnhtbv7mB7llkuLbRZB/3876gVI22peXo1rTKg30Gpj+aqxI1ik9NNRITn2E
         4vGHcEmNP3PQHSP6yACYSDh1bWuijZsqhePLC+I+U+lz0KjZ3IHrpb1VHFg7HBnd2ASE
         pu45xjUMgj9QVUGZdWpzLon5jOpNjC3NagmrkCJNrb0pbB36Tl4RRHy7qMvH30Yn8R3q
         nBeNUbqcqdl0OgTpqQYaFcXQ5E22jaHKNpchL6cJJ8iAz8jOoCfScly3FXA+OfpAMh/0
         UzzDLVL2pjfFtPqjEl9hjl9NnRQarJZn0oudzp9BOXvYP1/TxHw485dKI+k4o+ewEzEH
         3dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079314; x=1717684114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrFY0VaYKU2vD77g/VQDb0AaoaOV/tz1VO820emrTH8=;
        b=QK9cXNeBITwbspTpFRzzvuHPAp2fkNmsAixQjEz0dD2iTc22NcJBMjDa3I2LWoIAA0
         mqpfgOMoumZYyc3ZpPZUJEtlaX6VMknqwq/Ar58cMcy4LWt60RD7xy3DI+uW0FiHwl1V
         1PU9ZiooA1svzJsQf1mwz5V1v9lGy7dPgHua7ZKFIRAOyGz462R5FWxyElDdTFVn9aWD
         wlxmDkLlz2PExB4rVDlweLOgM6mKON6ho1fEAJIQXwJq9uuu8ZZbkoNN3denMlFdq0NS
         4yTGZwlCmGmHTkstaEPlhTSZAXFjOK63CrfX47gq45PGlmfmmuRvJGp8aKtbXB3M5KSG
         zYYA==
X-Forwarded-Encrypted: i=1; AJvYcCWjhYBi8Jw0Cec+ytnpJbua0ZVoLgE1M7nZPFJEMKCgJkHFUxqKNe//IfKmb7iMPX+9rKGKhHWsIQ5NmxvAZ6XAonLu9Es6UiuTmWPa
X-Gm-Message-State: AOJu0YxXg7hrGD5xnN8RmhyBRxXk9tjilJnr8ew5CrgY/zJ8+wP9UabP
	ZYkdlgBhu8bZweky6uTYUxKNRUCeQFbFCA9apkqPTXOdiRlJgHynjcUB+1DvOeyzNgZVfOzru72
	YrKOawHaK6fqHb1TH9D/YLDL9hnQL48s9ThZnyw==
X-Google-Smtp-Source: AGHT+IH7s7fRBncwQz/8YMXyL69aYbbbtWJ7w39VrMU/rk9239KjSERSYxjfvzkXIhh2PcCbFD7ALB2y7Lq+jxLKKk0=
X-Received: by 2002:a05:6e02:1b0e:b0:373:8d04:28a4 with SMTP id
 e9e14a558f8ab-3747e239d28mr17072745ab.13.1717079313717; Thu, 30 May 2024
 07:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529215458.937817-1-samuel.holland@sifive.com>
In-Reply-To: <20240529215458.937817-1-samuel.holland@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 30 May 2024 19:58:22 +0530
Message-ID: <CAAhSdy2kO5TYfh6-h4R3UWNidzYpp-CN7zL=JmAKdt1Q23TrwQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Chain to parent IRQ after handlers
 are ready
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 3:25=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Now that the PLIC uses a platform driver, the driver probed later in the
> boot process, where interrupts from peripherals might already be
> pending. As a result, plic_handle_irq() may be called as early as the
> call to irq_set_chained_handler(). But this call happens before the
> per-context handler is completely set up, so there is a window where
> plic_handle_irq() can see incomplete per-context state and crash. Avoid
> this by delaying the call to irq_set_chained_handler() until all
> handlers from all PLICs are initialized.
>
> Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a pla=
tform driver")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/r/CAMuHMdVYFFR7K5SbHBLY-JHhb7YpgGMS_hnRWm=
8H0KD-wBo+4A@mail.gmail.com/
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks for fixing this.

Regards,
Anup

> ---
>
>  drivers/irqchip/irq-sifive-plic.c | 34 +++++++++++++++----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index 8fb183ced1e7..9e22f7e378f5 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -85,7 +85,7 @@ struct plic_handler {
>         struct plic_priv        *priv;
>  };
>  static int plic_parent_irq __ro_after_init;
> -static bool plic_cpuhp_setup_done __ro_after_init;
> +static bool plic_global_setup_done __ro_after_init;
>  static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
>
>  static int plic_irq_set_type(struct irq_data *d, unsigned int type);
> @@ -487,10 +487,8 @@ static int plic_probe(struct platform_device *pdev)
>         unsigned long plic_quirks =3D 0;
>         struct plic_handler *handler;
>         u32 nr_irqs, parent_hwirq;
> -       struct irq_domain *domain;
>         struct plic_priv *priv;
>         irq_hw_number_t hwirq;
> -       bool cpuhp_setup;
>
>         if (is_of_node(dev->fwnode)) {
>                 const struct of_device_id *id;
> @@ -549,14 +547,6 @@ static int plic_probe(struct platform_device *pdev)
>                         continue;
>                 }
>
> -               /* Find parent domain and register chained handler */
> -               domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode=
(), DOMAIN_BUS_ANY);
> -               if (!plic_parent_irq && domain) {
> -                       plic_parent_irq =3D irq_create_mapping(domain, RV=
_IRQ_EXT);
> -                       if (plic_parent_irq)
> -                               irq_set_chained_handler(plic_parent_irq, =
plic_handle_irq);
> -               }
> -
>                 /*
>                  * When running in M-mode we need to ignore the S-mode ha=
ndler.
>                  * Here we assume it always comes later, but that might b=
e a
> @@ -597,25 +587,35 @@ static int plic_probe(struct platform_device *pdev)
>                 goto fail_cleanup_contexts;
>
>         /*
> -        * We can have multiple PLIC instances so setup cpuhp state
> +        * We can have multiple PLIC instances so setup global state
>          * and register syscore operations only once after context
>          * handlers of all online CPUs are initialized.
>          */
> -       if (!plic_cpuhp_setup_done) {
> -               cpuhp_setup =3D true;
> +       if (!plic_global_setup_done) {
> +               struct irq_domain *domain;
> +               bool global_setup =3D true;
> +
>                 for_each_online_cpu(cpu) {
>                         handler =3D per_cpu_ptr(&plic_handlers, cpu);
>                         if (!handler->present) {
> -                               cpuhp_setup =3D false;
> +                               global_setup =3D false;
>                                 break;
>                         }
>                 }
> -               if (cpuhp_setup) {
> +
> +               if (global_setup) {
> +                       /* Find parent domain and register chained handle=
r */
> +                       domain =3D irq_find_matching_fwnode(riscv_get_int=
c_hwnode(), DOMAIN_BUS_ANY);
> +                       if (domain)
> +                               plic_parent_irq =3D irq_create_mapping(do=
main, RV_IRQ_EXT);
> +                       if (plic_parent_irq)
> +                               irq_set_chained_handler(plic_parent_irq, =
plic_handle_irq);
> +
>                         cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTI=
NG,
>                                           "irqchip/sifive/plic:starting",
>                                           plic_starting_cpu, plic_dying_c=
pu);
>                         register_syscore_ops(&plic_irq_syscore_ops);
> -                       plic_cpuhp_setup_done =3D true;
> +                       plic_global_setup_done =3D true;
>                 }
>         }
>
> --
> 2.44.1
>
>

