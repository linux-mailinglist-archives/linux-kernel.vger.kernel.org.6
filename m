Return-Path: <linux-kernel+bounces-364944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E1599DB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6C21F23198
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617D167D83;
	Tue, 15 Oct 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l337EvGs"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C631167271
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955830; cv=none; b=WNjcV6H0ieVm8OK1S/6uf+q2AwMYSvspsh7Ph1ZTuaNGUO1VCvrOCfmYkSAFvOuJbA29/QKb3K78gysTWOvW2TjS5E/uhrEqsRz2rJUQHfotm3LK/mL3UdXMk/tLd2caFli287Dem6PRBHEK3KI6LeXCtPRfxGPkDMi6iy2Emt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955830; c=relaxed/simple;
	bh=w8sVV292aOufb3bg8gbTLRGrWH+yC3swGdQqM40yT+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZLPbT2/7eYo8ZtdOg3Z+DVX2o77Ts7cmHDPORmsI5FCR6DuiWkd1jqOfsxBvKv2qV2Od2RdbbletjR3CY3kcWnYLQa6XIiB0Mv7VivDJB67/rKf90DehJSjrH2qFO253vhyyIXUSac2QUAjR7coGLkj3nou0f/P5V/EuGiDNjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=fail smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l337EvGs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ca03687fdso391185ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728955828; x=1729560628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vllfM8E6Kaxnzbc0Hltfi8CdZgVV51rRD9kikxKKQY4=;
        b=l337EvGsofRGbrOl472DTwVSjAaV04HMO3dq15ziS9NjTQ/57q3+c4yOivpfJItWAJ
         xZTMT3Odha6jejJlDGBYQzZjNva5oEIDWuyxfFvXj3jq47A1afeqL8ynLPWNGEPCJ46P
         ii0A1dqtEUMRZFiLSma50C4+sMH6pTAvvaSkJhAsAqT+GBtSS2NFPmYXXVG7oCOijyuc
         ZJTpUVUpw22uU+ZkcykCe0r1SEMUvaEMBMJ1OCNNmtl5Rmgw+7uNhN+8V3xIIFZ0vE0v
         CfcPCQ0+qXBdQP5aAIE0VKgQ7Lt1KlLRnhoI4gnqDiSfFaKAC6GoaDYqnmrPaIAJkM3J
         sBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728955828; x=1729560628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vllfM8E6Kaxnzbc0Hltfi8CdZgVV51rRD9kikxKKQY4=;
        b=Hmrw+FqpbDnLMIbRHatr0dUE/RotkB6G6gOVgukhs9F1mYAqMY2eO6WEmDoYYCyyVq
         Kv4HgLnWdkgGqOWbizmdx3xSlG6F8VHejzuPY/mxozKntyE5Do0VDADD5J6oriwIqnlo
         +aH8Qv8TOy9YeJPsGe2UWTEoZp7JRcKxW7pgHJM6GW9PfdnJ1RMpcqffWrRSUIR2Uwbp
         ugGyqpNLw/AGCTfjq3aX1wm3hKyXZCRV6ug/J+KJuI+8SuT+FIUkpVhAhp/T9EIZ1WkY
         oJNe/tXyXTlJ3ftK/DcmATPddP4X1fmxhf7JXpgPsAs/7ceKaVF8RnG2i/gRrglkXwc9
         6wxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLFJGDzYwEasTyjKbTedBuMkZtvIwZZ+AhMq63aliKsgRg+x7uTqnNnLZy/ArFIXqaWd1I+nPn2nfwb+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxItJcTel7/I7hPcmmwCHp4Mbrq3eQsPIhSEBUZZAiRADnFlzPL
	uBVyMVvW52b0duWX6IKPEfwpGbR+vQCGsS8RMEDdmBZFbNrhlXadL+6PZPdPpGE90QKoT5yGejD
	EBmbZXCd38EEESWwd3y9+IFQzbb+eL9zgkIB7
X-Google-Smtp-Source: AGHT+IFU7pGtg85AePAf0ggbcCTYZlKyfJFrLZ4ew2mefVyAZkTBLCqqzW0uRpPZncz104HMEjoT6iwzqj2dZMIMsE8=
X-Received: by 2002:a17:902:e5c2:b0:20b:bf5a:c8 with SMTP id
 d9443c01a7336-20cbce22417mr5279405ad.10.1728955827897; Mon, 14 Oct 2024
 18:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014131152.267405-1-patrick.rudolph@9elements.com> <20241014131152.267405-21-patrick.rudolph@9elements.com>
In-Reply-To: <20241014131152.267405-21-patrick.rudolph@9elements.com>
From: Moritz Fischer <moritzf@google.com>
Date: Mon, 14 Oct 2024 18:30:14 -0700
Message-ID: <CAFyOScrFmRQ2LeCC3MRDE1M4cbAvbjoyE-b97gjYPdrWBNBtZQ@mail.gmail.com>
Subject: Re: [PATCH v8 20/37] arm: gic-v3-its: Implement of_xlate
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, Oct 14, 2024 at 6:16=E2=80=AFAM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Translate IRQs by implementing of_xlate() as required by
> irq_get_by_index() to parse interrupt properties.
>
> TEST: Booted on qemu sbsa-ref that has a GICV3.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changelog v6:
> - Update header order
>
> ---
>  arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
> index 22fa46a341..0d5545bfb2 100644
> --- a/arch/arm/lib/gic-v3-its.c
> +++ b/arch/arm/lib/gic-v3-its.c
> @@ -4,6 +4,7 @@
>   */
>  #include <cpu_func.h>
>  #include <dm.h>
> +#include <irq.h>
>  #include <asm/gic.h>
>  #include <asm/gic-v3.h>
>  #include <asm/io.h>
> @@ -163,8 +164,28 @@ static const struct udevice_id gic_v3_ids[] =3D {
>         {}
>  };
>
> +static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_ar=
gs *args)
> +{
> +       if (args->args_count > 2) {
> +               log_debug("Invalid args_count: %d\n", args->args_count);
> +               return -EINVAL;
> +       }
Aren't gicv3 at least #interrupt-cells =3D 3; to distinguish PPI / SPI?
> +
> +       if (args->args_count > 0)
> +               irq->id =3D args->args[0];
> +       if (args->args_count > 1)
> +               irq->flags =3D args->args[1];

Don't you have to distinguish PPI and SPIs here? You'll use
args->args[0] as PPI vs SPI and args[1] is either 1:1 (PPI) or offset
by 32 for SPIs or am I misunderstanding something?
> +
> +       return 0;
> +}
> +
> +static const struct irq_ops arm_gic_v3_ops =3D {
> +       .of_xlate               =3D  arm_gic_v3_of_xlate,
> +};
> +
>  U_BOOT_DRIVER(arm_gic_v3) =3D {
>         .name           =3D "gic-v3",
>         .id             =3D UCLASS_IRQ,
>         .of_match       =3D gic_v3_ids,
> +       .ops            =3D &arm_gic_v3_ops,
>  };
> --
> 2.46.2
>

Cheers,
Moritz

