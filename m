Return-Path: <linux-kernel+bounces-279526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9BC94BE80
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF43B212CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7B18DF71;
	Thu,  8 Aug 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="l0BEKjiT"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0218CC1E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123607; cv=none; b=k7qQlojy3bdXOCoewkCEf6Mt/MRil3U/UTBP9xJiNEJPDbQsUYXroKfylUI2rQ6a0kqxhGRZyxvdjM32tvKBjllLFBpb0PuU+FV0y/P7hJzL+zDv+YKBcVc6LvSuafPGbu+tTtz2c5zrYhqGfbv5R2RdMOIW1J3SlTaqAvWChcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123607; c=relaxed/simple;
	bh=IvGmrZKkzHMxreCW2yiT90mmgJVpIqu7CXshG1vWtRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQz2bdyu+kNaE7F5iwUIvG2PJKErpuSip+3K85EXxCOt5FTzRPX77+xNyWtXu1S34TAVruNCBt8RBnILdOAfKtfRXaX6jjcjhujRUx3jebuPONR1t0ZMyb7KsgOacYtgVwSdn9fqLXCFgUVfek4MgcNQebqzBK72we1eXeSSZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=l0BEKjiT; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39b3a6a7941so3327485ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1723123604; x=1723728404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f2sZw67FeYh4UfyoUHhTyMBouhrB7u7E2dwkiUnDOU=;
        b=l0BEKjiTdC04tCZTN3vBLM/6Yn2NIxV2wgwVyDfvtShaVvW+oRnBG5YfsfKoUwJ445
         NwnZBrMOGqhj2frtpyRvxhdVS8brrDK+GeUprUstNcjIc9KSWGJVSPB++uHOZ8tDdhAe
         RilfIctwdTuC1PKr8Wij/8ZkX7fmXjtlQKmr0DkkfHLOJX0LOZHhLG/NWy1NKti03/hL
         HGcFBdse9sYPZw7jjTr3V3+GDay48fbPArGID0llIaKXgeWFNNBCGHpB5Vb6IxxmFJil
         4zPtJL53Yfs/4gIrMpqVGrUoKZLTmu0cfMEid1U0s5VJkPFfsf8cMNTvbfiu1c2u0bxl
         IoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723123604; x=1723728404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6f2sZw67FeYh4UfyoUHhTyMBouhrB7u7E2dwkiUnDOU=;
        b=ggkGQg3w66W+98PkfihQFvhzFLcMhmM2aOuLhziAvGyi9EjxkV5A3j/tPXTB98O18L
         +shoBMXx6S3p7lu0Gab+LiSXboPWrgkWBVQ4YsqZ9iOxLyv2jW2MhHqWUJS5XvulRU4f
         5RhU60/ROS6mF5VPyuC4QK/5wPqdABg0twiCFMtTCzIornCYYTSAvmKDHJy9PNieq2hh
         QuxMrBEz2P8+RCf2qkAPUYXDmT6SiVAj85oR9QGUVdtolzJzT4hR6WniwM8jt4MPliAZ
         z6t8HjCXzvvRHMjAx6BL1JPuFR//5tCbvYoN+zPCcHuUlGKzomlxTJWH/9/eBtR5I7nT
         DG1A==
X-Gm-Message-State: AOJu0YyIR9cdfHo4nRSIVb7qVx3QI9J/wxdfGCfkGXPoKj9fBdRlMpZF
	Sptov01pFSbCPmbMb9SWTpJ7jdvTrzW6+pgQbfkmcFDjzAo71XHiWpLxAAKMlXSJtrHc0M+tlpg
	V1EHsp3qxa2RKHGdSytsqkgDB4GB0BZw3YHilnA==
X-Google-Smtp-Source: AGHT+IFD+JDzsihlY7CNjwkDlNPlTjFUlD2Es2LqoFt6m6hUbUcrYxfIFji963rPVGVGY5GOkjlWXhWWMSIo9rIX6AE=
X-Received: by 2002:a05:6e02:1a64:b0:39b:2daf:1b82 with SMTP id
 e9e14a558f8ab-39b5ecca1a6mr20393155ab.16.1723123604393; Thu, 08 Aug 2024
 06:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808081412.24553-1-yongxuan.wang@sifive.com>
In-Reply-To: <20240808081412.24553-1-yongxuan.wang@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 8 Aug 2024 18:56:32 +0530
Message-ID: <CAAhSdy3VKMngwHxOg5+z6pK3QgZnLv=3+hpZBeUm87L_e62aUQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv-aplic: manually set pending for the
 pre-existing interrupts
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	greentime.hu@sifive.com, vincent.chen@sifive.com, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

More appropriate patch subject should be:

irqchip: riscv-aplic: retrigger interrupt in MSI mode upon write to
sourcecfg register

On Thu, Aug 8, 2024 at 1:44=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifive=
.com> wrote:
>
> The section 4.5.2 of the RISC-V AIA specification says that any write
> to a sourcecfg register of an APLIC might (or might not) cause the
> corresponding interrupt-pending bit to be set to one if the rectified
> input value is high (=3D 1) under the new source mode.

Add quotes around the text from RISC-V AIA specification.

>
> If an interrupt is asserted before the driver configs its interrupt
> type to APLIC, it's pending bit will not be set except a relevant
> write to a setip or setipnum register. When we write the interrupt
> type to sourcecfg register, if the APLIC device doesn't check and
> update the pending bit, the interrupt might never becomes pending.

The second sentence above can be re-written as follows:

When interrupt type is changed in sourcecfg register, the APLIC
device might not set the corresponding pending bit, the interrupt
might never become pending.

>
> For the level interrupts forwarded by MSI, we can manually set the
> pending bit if the interrupts have been asserted before the interrupt
> type configuration.

The above sentence can be re-writtern as follows:

To handle sourcecfg register changes for level-triggered interrupts in
MSI mode, manually set the pending bit for retriggering interrupt if it
was already asserted.

>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  drivers/irqchip/irq-riscv-aplic-main.c |  4 ++++
>  drivers/irqchip/irq-riscv-aplic-main.h |  1 +
>  drivers/irqchip/irq-riscv-aplic-msi.c  | 17 +++++++++++------
>  3 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq=
-riscv-aplic-main.c
> index 28dd175b5764..46c44d96123c 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> @@ -58,6 +58,10 @@ int aplic_irq_set_type(struct irq_data *d, unsigned in=
t type)
>         sourcecfg +=3D (d->hwirq - 1) * sizeof(u32);
>         writel(val, sourcecfg);
>
> +       /* manually set pending for the asserting interrupts */
> +       if (!priv->nr_idcs)
> +               aplic_retrigger_asserting_irq(d);
> +

This is not the right place. See below.

>         return 0;
>  }
>
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq=
-riscv-aplic-main.h
> index 4393927d8c80..c2be66f379b1 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.h
> +++ b/drivers/irqchip/irq-riscv-aplic-main.h
> @@ -34,6 +34,7 @@ struct aplic_priv {
>
>  void aplic_irq_unmask(struct irq_data *d);
>  void aplic_irq_mask(struct irq_data *d);
> +void aplic_retrigger_asserting_irq(struct irq_data *d);
>  int aplic_irq_set_type(struct irq_data *d, unsigned int type);
>  int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
>                               unsigned long *hwirq, unsigned int *type);
> diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-=
riscv-aplic-msi.c
> index 028444af48bd..eaf4d730a49a 100644
> --- a/drivers/irqchip/irq-riscv-aplic-msi.c
> +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> @@ -32,15 +32,10 @@ static void aplic_msi_irq_unmask(struct irq_data *d)
>         aplic_irq_unmask(d);
>  }
>
> -static void aplic_msi_irq_eoi(struct irq_data *d)
> +void aplic_retrigger_asserting_irq(struct irq_data *d)

This needs to be a static function because we don't require
this for APLIC in direct mode.

Also, rename it to aplic_msi_irq_retrigger_level().

>  {
>         struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
>
> -       /*
> -        * EOI handling is required only for level-triggered interrupts
> -        * when APLIC is in MSI mode.
> -        */
> -
>         switch (irqd_get_trigger_type(d)) {
>         case IRQ_TYPE_LEVEL_LOW:
>         case IRQ_TYPE_LEVEL_HIGH:
> @@ -59,6 +54,16 @@ static void aplic_msi_irq_eoi(struct irq_data *d)
>         }
>  }
>
> +static void aplic_msi_irq_eoi(struct irq_data *d)
> +{
> +       /*
> +        * EOI handling is required only for level-triggered interrupts
> +        * when APLIC is in MSI mode.
> +        */
> +
> +       aplic_retrigger_asserting_irq(d);
> +}
> +

Define APLIC MSI mode specific irq_set_type() like below:

int aplic_msi_irq_set_type(struct irq_data *d, unsigned int type)
{
       int rc;

       rc =3D aplic_irq_set_type(d, type);
       if (rc)
              return rc;

       /*
        * Updating sourcecfg register for level-triggered interrupts
        * requires interrupt retriggering when APLIC in MSI mode.
        */
       aplic_msi_irq_retrigger_level(d);
       return 0;
}

>  static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *msg)
>  {
>         unsigned int group_index, hart_index, guest_index, val;
> --
> 2.17.1
>

Regards,
Anup

