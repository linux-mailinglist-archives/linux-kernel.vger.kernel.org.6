Return-Path: <linux-kernel+bounces-280515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0226F94CB8B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6391F24E35
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A741F17C219;
	Fri,  9 Aug 2024 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Q61FMbQI"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BE17B4E1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723189255; cv=none; b=JbVipx/k0TfYE6hDvecOIYsJH7rUJMS4fKA4cGZPnyiEYiFYpfJDv8eBjIjSaDxJja0/ZxDeWr/briQfcW+NZZzA81ixhL3+V2BP+wibHIr1jZPpRazknlWeR71+4u/oNeRgi7wJ2D85kKN4zXwz7yNI8XsMrU+/6ITSGgTKFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723189255; c=relaxed/simple;
	bh=RL7LCB+DHPQAZvVoyBIlGYWe23JGKUVgbikgDh684mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u58xb1WGczBXrQ3Bzd9s97LAYccK76C+3Uq30gvTPHBeNdEFhTqHhPEQJIqa0u6xA6DwFtv1BJzhyMSPhzFTPkvc7wTy1J83S+T/ImTVuyj8c7/YgpgJtsIma17SgHLaOCY5PB9PY1pyh4rc/CKwzp2JPYukCEO0/b6vfaJOh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Q61FMbQI; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39b4eadbaa7so5837095ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1723189253; x=1723794053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvTxew8Byqy7FH0+Ero8MHq7Yfmx3knxdchtS7o3ERE=;
        b=Q61FMbQIwB323DmTmyNbBEo3s449vQWw+5p/T4ldaJZLwSmgZ5jmQOs8mKzMzAEeER
         jusm19nyd8Gr34p6tWKsNFCH7Yd7GcqYf5LfOkLV5kMc0DKCtIF5WA+VALoexrZPHbnn
         CWsGwCtYwDcegVm3V6R6bb/avrz3zWkQHHEh8c9eRjFsGP2u+4+50oK/b1btrHmhxeGD
         SlZWLZoUwei2tx8JNIdYE/7yZ5GyCJFC5IhadiY0qPHHkVFJ1QhNJSQj+4BiYGgBWpAf
         r8N7jHtu4MtejynM8SDu6d3DgkIv/xG7fxZ715NUZN85D/urbRsm6lgO4ZydWDk79RAo
         L7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723189253; x=1723794053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvTxew8Byqy7FH0+Ero8MHq7Yfmx3knxdchtS7o3ERE=;
        b=GlokLK4o5pGym0h3s6gBmpwO2NygFWBGwuNa630PwJ6BlxDFU8QzghEbDZTuwmg7RW
         asmCGP8tUXV6/tpV9UzkSatqp79IymFImuySgLgcqlyKhsq029jjtbgh2CzZTVTllHsf
         l8Jmx1rV3RELWewuMGdfWTrZ+MEEPS7R5EVFfcRrk5SnPZlAskUUN2LOU6rfn9m6hEgz
         Mna56QWdWhn3Sp2AHNMJPiJtE8MLzECkajDzPyY4VWTcKTBUlLwWlRBiGZDq2VTlwG3R
         UwHimAXPtpTfiZHuzV8MhtLblCKdT+DkH6E7UyWVQsGfBmj4baSeVRS/PtwYPqkR/ePE
         44EQ==
X-Gm-Message-State: AOJu0YwcZd84tfsqsgHOQCvIDanv7Pdo4A14abEsUjZ6jGfKfCbSWT9r
	mqlkMckeG71ah+1cEZAmTeKu+wucPYj9VXHQZCIospiEZ3Z1efuS9p6H30KFzljdv6k6s7aqKTV
	FRCWMZ6ubI7s2K2ypocicI13ziSfEQr3l5YwspaeGkk+rrbmK
X-Google-Smtp-Source: AGHT+IHbrJ4hZMchlSmfMj4NgTssVC/F92aVTWn6kOpDdbl79LGZuF4ig3Ca6JpaYJsw6t7esH5uMdUL+zK69nqPc50=
X-Received: by 2002:a05:6e02:1aa6:b0:397:75a:39b9 with SMTP id
 e9e14a558f8ab-39b7a423e94mr12506315ab.16.1723189252955; Fri, 09 Aug 2024
 00:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809071049.2454-1-yongxuan.wang@sifive.com>
In-Reply-To: <20240809071049.2454-1-yongxuan.wang@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 9 Aug 2024 13:10:41 +0530
Message-ID: <CAAhSdy0R7qAFA6DLrEoy5u+5mhQttvyfnrkjcUpvFsxwJeBiVQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] irqchip/riscv-aplic: Retrigger MSI interrupt on
 source configuration
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	greentime.hu@sifive.com, vincent.chen@sifive.com, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:40=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifiv=
e.com> wrote:
>
> The section 4.5.2 of the RISC-V AIA specification says that "any write
> to a sourcecfg register of an APLIC might (or might not) cause the
> corresponding interrupt-pending bit to be set to one if the rectified
> input value is high (=3D 1) under the new source mode."
>
> When the interrupt type is changed in sourcecfg register, the APLIC
> device might not set the corresponding pending bit, so the interrupt
> might never become pending.
>
> To handle sourcecfg register changes for level-triggered interrupts in
> MSI mode, manually set the pending bit for retriggering interrupt if it
> was already asserted.
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Vincent Chen <vincent.chen@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> v2:
> - update commit message (Anup, Thomas)
> - rename aplic_retrigger_asserting_irq() to aplic_msi_irq_retrigger_level=
()
>   and make it as a static function since only APLIC MSI mode require it.
>   (Anup, Thomas)
>
> ---
>  drivers/irqchip/irq-riscv-aplic-msi.c | 35 +++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-=
riscv-aplic-msi.c
> index 028444af48bd..9d63dc37dea5 100644
> --- a/drivers/irqchip/irq-riscv-aplic-msi.c
> +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> @@ -32,15 +32,10 @@ static void aplic_msi_irq_unmask(struct irq_data *d)
>         aplic_irq_unmask(d);
>  }
>
> -static void aplic_msi_irq_eoi(struct irq_data *d)
> +static void aplic_msi_irq_retrigger_level(struct irq_data *d)
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
> @@ -59,6 +54,32 @@ static void aplic_msi_irq_eoi(struct irq_data *d)
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
> +       aplic_msi_irq_retrigger_level(d);
> +}
> +
> +static int aplic_msi_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +       int rc;
> +
> +       rc =3D aplic_irq_set_type(d, type);
> +       if (rc)
> +               return rc;
> +
> +       /*
> +        * Updating sourcecfg register for level-triggered interrupts
> +        * requires interrupt retriggering when APLIC is in MSI mode.
> +        */
> +       aplic_msi_irq_retrigger_level(d);
> +       return 0;
> +}
> +
>  static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *msg)
>  {
>         unsigned int group_index, hart_index, guest_index, val;
> @@ -130,7 +151,7 @@ static const struct msi_domain_template aplic_msi_tem=
plate =3D {
>                 .name                   =3D "APLIC-MSI",
>                 .irq_mask               =3D aplic_msi_irq_mask,
>                 .irq_unmask             =3D aplic_msi_irq_unmask,
> -               .irq_set_type           =3D aplic_irq_set_type,
> +               .irq_set_type           =3D aplic_msi_irq_set_type,
>                 .irq_eoi                =3D aplic_msi_irq_eoi,
>  #ifdef CONFIG_SMP
>                 .irq_set_affinity       =3D irq_chip_set_affinity_parent,
> --
> 2.17.1
>

