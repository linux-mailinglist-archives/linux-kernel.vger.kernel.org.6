Return-Path: <linux-kernel+bounces-434131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8599E620B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2E71885E5F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34621FDD;
	Fri,  6 Dec 2024 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e0IA8DBw"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2D8BE5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444064; cv=none; b=aBqFcJq3igHIzCA6BVGfJpq9KYMTC7WWQEGY211adNubLO6do13IsoD2S2TsmR0oyiuL/D0GVALsWrblnUN/L7Ve8PeF96jW0kuD/tMVcH75vQYPGI2l8WK1B593zIQ7NyWgH3N+HC9n7wfQdpjd/xoAOwjgP+qiF2Vp5KjHgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444064; c=relaxed/simple;
	bh=n1QMCR+o1IjAUTaDDfR1xEZ7D28jL25QnhcqGGlZcxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIDfT0u1vvgTYusEJWppVLIBlmQIYJMpOjszb995oiEnBUYCDGlNoCEdtKB6s/8vP0P1Qg3gybFEJ9h9mxwR6ZQs+drDvaSbyhoaIdQfr0mDvWOK+v+USS/nfL/F6dUz/R4955KjahhZFT0T3KyC1fMLd8WFwomromdus7/7U34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e0IA8DBw; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53df80eeeedso1613565e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733444060; x=1734048860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJZZetzxGhhv/pZ2FmC206fbtzecWH/gn5vhS8Kz1Hg=;
        b=e0IA8DBwRSj6qf+RYv/ZMw+z9Q/UQo7UPyz7L8+fzybqQBBYEs461a3RgpfqGi2nK0
         ps6UlJfSZ5RKebHO4UbaCii9dIGVV78LA+Zx4YYJ3NCn1buzjvLN5MZsDUC27lha2/P0
         sbus08ZgIbi1Idgu5yY2QeDhMRYel+ZtWaJFFyhuI52ni2yLogDx2EeEQ7X9KKQkqLX+
         yaeK1wUkXHB8ksalYt88UzbMHkCWfVrVKnINXvBXFrttpQ07biXIh59cSeX1ivT0nnqf
         DtrbwyNLd1ZVIu2NeG7xKlovaoU1WkBRvTQD41Boyiuscj7v3ZPYzGjruYip71mu90Az
         MNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733444060; x=1734048860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJZZetzxGhhv/pZ2FmC206fbtzecWH/gn5vhS8Kz1Hg=;
        b=BVUiEMekYvDtcM+Eqe0MMcyyC3IWyVMTAlTcFLY3oyUk+Z0d+F7iTgS3PeUSuvvZ/h
         c1VcxqExnnyUXr+BsluPSUz7QFHqgTrx1Y7fr8FwVmRBoafIUGkFfZ3uwMwhIXZwYFhv
         SZNIHAn1i2TxQmHnog8XAheaZywJ9U8pFamP1e/by6ygk6qL960YK1Z+TnKYNd/fT4J4
         4phVZZVl5VQDiamwzZhpoSqMGXHvbAYLv+YeY2pU3BsvEAm1UY5UJRXpY63VKjbahzD7
         poKzFeWIKYLOI0lHZWHzy1KOS5HatL6IdyPwKouhchngAC3KJ+Bj7FtZIkdXa+oMszhY
         wckw==
X-Forwarded-Encrypted: i=1; AJvYcCVnREkcPhGZkqYLiRGduS9sMlDyrfPEre692iqabmb2DJTIyJKMrnRn1leV/Vio+/Qfa3IwPyyLVaOfYhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7rXyOYA76vIH7rgmX9v4gfRXln4IJwkafy+0pBvdzcsHR3vc0
	DMVWt9cGqswFIljAXMGgCOZ9L8P2MmM61E51e1OZrQ7//LN9i05D3deD/W2Ni4UOxpGq5LTkS21
	6rXnKsN/7UdBHDl0OyG8MHStLd1wItpojS0ZRXhKe+SWfOH2Z6A==
X-Gm-Gg: ASbGncuTW+au5ZNeZZCixcjeuMDb+cnpWTWa2KIVocpE/90YGEy7YIRFxF1wo3q6JL0
	yXuJJI/GXhV7YNk3NFda0UJCMuahZHw==
X-Google-Smtp-Source: AGHT+IGzC7Vw+/YWeKChUjNSnkqaCpm/8ww/D54zHlaFZyxrJkwQO+aTpEfr7ztP6v5D+/22dJnOBSTTri1nIsLJRp0=
X-Received: by 2002:a05:6512:1193:b0:53e:1ee1:25b1 with SMTP id
 2adb3069b0e04-53e2c2c45e4mr205779e87.33.1733444060334; Thu, 05 Dec 2024
 16:14:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204194806.2665589-1-swboyd@chromium.org>
In-Reply-To: <20241204194806.2665589-1-swboyd@chromium.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:13:43 -0800
Message-ID: <CAGETcx_JPi6-DrjFO_oAUc7V8tSL7gngFaFEsDWV_DfDeWVm_Q@mail.gmail.com>
Subject: Re: [PATCH v2] of: Hide of_default_bus_match_table[]
To: Stephen Boyd <swboyd@chromium.org>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:48=E2=80=AFAM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> This isn't used outside this file. Hide the array in the C file.

Acked-by: Saravana Kannan <saravanak@google.com>


>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1 https://lore.kernel.org/r/20241204000415.2404264-1-swboyd=
@chromium.org
>  * Move of_default_bus_match_table into function so it isn't unused in
>    different configs
>
>  drivers/of/platform.c       | 23 +++++++++++------------
>  include/linux/of_platform.h |  2 --
>  2 files changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 9bafcff3e628..c6d8afb284e8 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -24,16 +24,6 @@
>
>  #include "of_private.h"
>
> -const struct of_device_id of_default_bus_match_table[] =3D {
> -       { .compatible =3D "simple-bus", },
> -       { .compatible =3D "simple-mfd", },
> -       { .compatible =3D "isa", },
> -#ifdef CONFIG_ARM_AMBA
> -       { .compatible =3D "arm,amba-bus", },
> -#endif /* CONFIG_ARM_AMBA */
> -       {} /* Empty terminated list */
> -};
> -
>  /**
>   * of_find_device_by_node - Find the platform_device associated with a n=
ode
>   * @np: Pointer to device tree node
> @@ -484,8 +474,17 @@ int of_platform_default_populate(struct device_node =
*root,
>                                  const struct of_dev_auxdata *lookup,
>                                  struct device *parent)
>  {
> -       return of_platform_populate(root, of_default_bus_match_table, loo=
kup,
> -                                   parent);
> +       static const struct of_device_id match_table[] =3D {
> +               { .compatible =3D "simple-bus", },
> +               { .compatible =3D "simple-mfd", },
> +               { .compatible =3D "isa", },
> +#ifdef CONFIG_ARM_AMBA
> +               { .compatible =3D "arm,amba-bus", },
> +#endif /* CONFIG_ARM_AMBA */
> +               {} /* Empty terminated list */
> +       };
> +
> +       return of_platform_populate(root, match_table, lookup, parent);
>  }
>  EXPORT_SYMBOL_GPL(of_platform_default_populate);
>
> diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
> index a2ff1ad48f7f..17471ef8e092 100644
> --- a/include/linux/of_platform.h
> +++ b/include/linux/of_platform.h
> @@ -47,8 +47,6 @@ struct of_dev_auxdata {
>         { .compatible =3D _compat, .phys_addr =3D _phys, .name =3D _name,=
 \
>           .platform_data =3D _pdata }
>
> -extern const struct of_device_id of_default_bus_match_table[];
> -
>  /* Platform drivers register/unregister */
>  extern struct platform_device *of_device_alloc(struct device_node *np,
>                                          const char *bus_id,
>
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> --
> https://chromeos.dev
>

