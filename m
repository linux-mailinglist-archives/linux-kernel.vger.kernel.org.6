Return-Path: <linux-kernel+bounces-368695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE0D9A1375
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0261F21F47
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF8017C98C;
	Wed, 16 Oct 2024 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTPwJxvB"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6B1C07C7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109365; cv=none; b=lJBnivFV0gb7VdEvA/w8H+djKVlUDa2dtqMXMi8eu00TQv4H+vR+RWUvj8zZ6lnFUceHkraH5zHePjqbZtImLVapCN9GMCuk4Gkl4kDzjnzpGqjhiiPTK7sLu6tSVoUa4b/ujYWYP8sOWAzX56Ob+Lykmismc5AJLwHPULIEJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109365; c=relaxed/simple;
	bh=veSARikzalO6OGmODse06VZpL0Ta232Zy9EzWY1Q+v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URMA/ZsSaTFrVdC04Vx9AuzJTesJA2XHlh+a1wDSm4Cq8Zj7CpxwVCtVGZreCq33WqIQaR2Dw5nt4E3d4UUnEULy5It/5i5lswg2clu5++ctZ7s2YX4cft1EDsUmAetiHKhPHtzTRFPxoLbNNHDB3Far0iNP94Eau2r+y21Pzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hTPwJxvB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca03687fdso44455ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729109363; x=1729714163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59w8wM7GKkf1e6Y4T4xsg8w2LEt9Sw10RK5UQp3fH0M=;
        b=hTPwJxvBGoEWGLIJNnNrc1Rty59JzaCetY+y5CIR/XrK8tUzQl9AwqJ8tam+m/arXc
         Oz6kj8LCAAZbc74oF3D3GMLwOuihgt2rXkAa7M6Iy3eY7qtx9NsRGoYoQzRA/mZNbOzL
         zq+9RUVQntR+MMfVWkQLYYsX7RSrud6kfPpttYOSZw98Vk6n+8evS3dADOY2WXGyAlaO
         z8/7t7VVAuYvX7pdtvH7vAI4KSz96+aNVG4oSYV56RkQEngfzgMMP8VZs/UtHba78d7i
         1panvqxW8AelBzhC1f1S8TVDKtx3ac6e24VUV6mThSALF+E278Va4kkxv0Jc98gZik5U
         C61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109363; x=1729714163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59w8wM7GKkf1e6Y4T4xsg8w2LEt9Sw10RK5UQp3fH0M=;
        b=mJyS5Z2p9Ra182Xpynw5PIBKGQNfjOu/XkzOaSiaP/bMgmZJ7TpnMx886cNxZ0KMNZ
         xxq8oxe8qyh5JFs44g4AtZuCAg8wYyPa/Hep7eqNC+2B04gSqxeP4i3ZCofYTHrneTO2
         Ekw0HhsxgEYdS9mn3pzYx4U/2dZlLuaSELE9o/7owccMeD/vJjhfV8UImsybveg2dsTG
         fPunioDHt12EprBtJbnK1Llkt4lodcUsHLgeePhqAdc/mnjdjOaHtDA9DBklXYLg/Ylp
         vS352ZiZx65fWmeA3CHHeDB3MIPrwTNjJWPTaAMoUMbQlAfyKSLeMl6bG49SUf9fHNkg
         4FOw==
X-Forwarded-Encrypted: i=1; AJvYcCWtXrk8Ga3bE9wZ0wZ6GPF2nZEkEu/IAyoenV9csHklGAoXlkX74fUkxUwfCbwbAhRRTLselJBqwxD2xxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMg6w8l7OkH511ekeGu6ZVVyXO71ZjKVtWsf+1elBSSbOM8QUA
	Pngknij7EtFrsJ6uM+OLjwyiAP6BwUpWcPMioQNz/bbGCJrEA4/6hHrgxalyn2NPL61lBhqKi8z
	c9yIDtgtVpLVMwIv42hUPNyhZRBi1MBZsqFhU
X-Google-Smtp-Source: AGHT+IECveLuIbfaEsyleV4iSTkHTgwgd/dKZEEBgO/1tkui3hDZzAWy01jwGN7C+/hxz/kAVL13nqss0TBt36/wwP4=
X-Received: by 2002:a17:902:ea0f:b0:20c:bb35:dafe with SMTP id
 d9443c01a7336-20d48a8fb15mr756525ad.0.1729109362694; Wed, 16 Oct 2024
 13:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com> <20241016060523.888804-21-patrick.rudolph@9elements.com>
In-Reply-To: <20241016060523.888804-21-patrick.rudolph@9elements.com>
From: Moritz Fischer <moritzf@google.com>
Date: Wed, 16 Oct 2024 13:09:10 -0700
Message-ID: <CAFyOScrfp10DiXeOQ8VXafFAdqwf7VNAtngktOC753=o0n1fog@mail.gmail.com>
Subject: Re: [PATCH v9 20/37] arm: gic-v3-its: Implement of_xlate
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 11:15=E2=80=AFPM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Translate IRQs by implementing of_xlate() as required by
> irq_get_by_index() to parse interrupt properties.
>
> Map DT interrupts to ARM GIC interrupts as follows:
>
> - Interrupt numbers ID32-ID1019 are used for SPIs
> - ID0-ID15 are used for SGIs
> - ID16-ID31 are used for PPIs
>
> TEST: Booted on qemu sbsa-ref that has a GICV3.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Reviewed-by: Moritz Fischer <moritzf@google.com>
> ---
> Changelog v9:
> - Require at least 3 interrupt-cells
> - Map SPI interrupts to ID32+
> - Map PPI interrupts to ID16+
> ---
>  arch/arm/lib/gic-v3-its.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
> index 22fa46a341..58f8bf864f 100644
> --- a/arch/arm/lib/gic-v3-its.c
> +++ b/arch/arm/lib/gic-v3-its.c
> @@ -4,9 +4,11 @@
>   */
>  #include <cpu_func.h>
>  #include <dm.h>
> +#include <irq.h>
>  #include <asm/gic.h>
>  #include <asm/gic-v3.h>
>  #include <asm/io.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <linux/bitops.h>
>  #include <linux/printk.h>
>  #include <linux/sizes.h>
> @@ -163,8 +165,30 @@ static const struct udevice_id gic_v3_ids[] =3D {
>         {}
>  };
>
> +static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_ar=
gs *args)
> +{
> +       if (args->args_count < 3) {
> +               log_debug("Invalid args_count: %d\n", args->args_count);
> +               return -EINVAL;
> +       }
> +
> +       if (args->args[0] =3D=3D GIC_SPI)
> +               irq->id =3D args->args[1] + 32;
> +       else
> +               irq->id =3D args->args[1] + 16;
> +
> +       irq->flags =3D args->args[2];
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

