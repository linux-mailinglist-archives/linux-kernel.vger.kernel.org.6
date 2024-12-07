Return-Path: <linux-kernel+bounces-435980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 000FB9E7F51
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 10:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EA3165B8A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278C13AD22;
	Sat,  7 Dec 2024 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTp28EWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582385626;
	Sat,  7 Dec 2024 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733562725; cv=none; b=cVXhyXw1ZvYQuZR3qwb0lPdspLT5QgUBbJVeCelu7CWRJS08FKTZdxo9zpHJKe8+P50X/Q0YJmQnuZDhQm2BjPtHlktroxOYf+UZgFmHkemTFPSMV4VSe0tl44+Mx/dcgf9FW5kPo6NxMp9mtxbhDdDQxrNOfalJi4Racco0SGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733562725; c=relaxed/simple;
	bh=QM3dO3IgDSl6o5lIGQCB9dg197jlldvwDAyQrKZYv3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLQeADQwyPZxTg3qH3W1sB5M3NfYYcobXDnz7LsBqNKkcL3EAYx624eIJbww3xB8GgMmR6K5xFXNW4YxvxgXuIezYjQfqN7RLwk2b1cbUePQ8/qyxglgedVTWTkfXxHnBz5xo8F8AUSPpHkVswQYsumnsbJ+H8cmEu9lqD8X1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTp28EWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C34EC4CECD;
	Sat,  7 Dec 2024 09:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733562724;
	bh=QM3dO3IgDSl6o5lIGQCB9dg197jlldvwDAyQrKZYv3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bTp28EWpE3ExZK+5Xs2L1Q8q0swUp2wWFRjCQtBdrBj94IYxtRDULH5ph85ujsVPV
	 7YIPdR8xkHJG2kpedB0hF1nqWIhOzZaWWf6iYAuSFdWig8ELvuhp/6605tkYlN+7Gf
	 VhpkKJPhmDjL8JsBxUm9+zpVQPKdz+7eTcJqY1ye390h33yprz/alOYyzGR7jGZEDm
	 ueIzXJe+1P/5RxzBjMOZVbsB3X5hMNyrD97vy/kZDaaiqtnUkMHIkKjhuyw/xR1t0/
	 ScmsYOLyFNCzKmGblfJ8bKnG4YiQqTw2FleBqhrHDZS8jFKJFQHroAGdWlhsJ3F9zH
	 vPp6/k/dlg1cA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa643eb7f24so174102166b.0;
        Sat, 07 Dec 2024 01:12:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVb36kNGETUuNhIPRx7IJVwexs/KmlHRI+bC57M2XZKomR3PGVpL9vKUE1ew8npkeSFksfVXvF5wtsOlcbH@vger.kernel.org, AJvYcCWwb2hiwLPv99iRxr/I/QLxa03NpsEYUCk57VANWOyIzwmJGuItll6US6oPwyRIKzlALJq6vSXYVZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGtwHYbSBIL7aqhrGZ6b1w0kJ54hzN24mBvjD+G7/jltXmko1
	fyMhX4QlXUZMUsdoATi3uL9YQ2+Y2tw2DV16IJMK5NzK9hIUpwPOGjdr2FCBjh7GtbpguJ2/BZU
	OacoL47ij7kv+8hyM5b1O3KlECAM=
X-Google-Smtp-Source: AGHT+IEJGrBvG/ShGpCySY5o73rk2XwpV1WNmzYZCleJxbsf6ctE3q/pdaSVAnpSfuCOYx8WSVD6NwrST7GnTWOsFP0=
X-Received: by 2002:a17:907:2817:b0:aa4:e18e:1ca1 with SMTP id
 a640c23a62f3a-aa63a266bbbmr514126266b.60.1733562723240; Sat, 07 Dec 2024
 01:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207033146.20938-1-zhangtianyang@loongson.cn>
In-Reply-To: <20241207033146.20938-1-zhangtianyang@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 7 Dec 2024 17:11:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4VAyD+=Btt9S6HrN6-sVQJqe1_jeLPS13UR1kxXJ8S5w@mail.gmail.com>
Message-ID: <CAAhV-H4VAyD+=Btt9S6HrN6-sVQJqe1_jeLPS13UR1kxXJ8S5w@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongarch-avec:Add multi-nodes topology support
To: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: kernel@xen0n.name, tglx@linutronix.de, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tianyang,

On Sat, Dec 7, 2024 at 11:31=E2=80=AFAM Tianyang Zhang
<zhangtianyang@loongson.cn> wrote:
>
> This patch enables the advanced interrupt controller function under
> multiple-node of 3C600. The topology of the advanced interrupt controller
> is consistent with NUMA node. We check the enable status of the node wher=
e
> each CPU is located once when it goes online, which may cause some
> additional operations, but it can ensure that the advanced interrupt
> controller can still be used in situations where some CPUs cannot start
The whole can be reworded:

Currently we only enable one chip's advanced interrupt controller
(AVEC) in hardware, so multi-chip machines with Loongson-3C6000 don't
work. This patch enables it for every chip (In theory every chip needs
to be enabled only once, but for simplicity we enable it on every core
in the CPU online hooks).

>
> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
> ---
>  drivers/irqchip/irq-loongarch-avec.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-l=
oongarch-avec.c
> index 0f6e465dd309..9e30198fa7e4 100644
> --- a/drivers/irqchip/irq-loongarch-avec.c
> +++ b/drivers/irqchip/irq-loongarch-avec.c
> @@ -56,6 +56,18 @@ struct avecintc_data {
>         unsigned int            moving;
>  };
>
> +static inline void avecintc_enable(void)
> +{
> +       u64 value;
> +
> +       if (!loongarch_avec.domain)
> +               return;
Is there any reason to check this? If domain is NULL, avecintc_init()
fails, there is no chance to execute this function.

Huacai

> +
> +       value =3D iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
> +       value |=3D IOCSR_MISC_FUNC_AVEC_EN;
> +       iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
> +}
> +
>  static inline void avecintc_ack_irq(struct irq_data *d)
>  {
>  }
> @@ -127,6 +139,8 @@ static int avecintc_cpu_online(unsigned int cpu)
>
>         guard(raw_spinlock)(&loongarch_avec.lock);
>
> +       avecintc_enable();
> +
>         irq_matrix_online(loongarch_avec.vector_matrix);
>
>         pending_list_init(cpu);
> @@ -339,7 +353,6 @@ static int __init irq_matrix_init(void)
>  static int __init avecintc_init(struct irq_domain *parent)
>  {
>         int ret, parent_irq;
> -       unsigned long value;
>
>         raw_spin_lock_init(&loongarch_avec.lock);
>
> @@ -378,14 +391,13 @@ static int __init avecintc_init(struct irq_domain *=
parent)
>                                   "irqchip/loongarch/avecintc:starting",
>                                   avecintc_cpu_online, avecintc_cpu_offli=
ne);
>  #endif
> -       value =3D iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
> -       value |=3D IOCSR_MISC_FUNC_AVEC_EN;
> -       iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
> +       avecintc_enable();
>
>         return ret;
>
>  out_remove_domain:
>         irq_domain_remove(loongarch_avec.domain);
> +       loongarch_avec.domain =3D NULL;
>  out_free_handle:
>         irq_domain_free_fwnode(loongarch_avec.fwnode);
>  out:
> --
> 2.20.1
>

