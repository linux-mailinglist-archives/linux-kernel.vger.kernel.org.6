Return-Path: <linux-kernel+bounces-422362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC19D98A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4E8283A87
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B23193408;
	Tue, 26 Nov 2024 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWNooiF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE429BA49;
	Tue, 26 Nov 2024 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628250; cv=none; b=ZfvZcRiTkf2izr/NSiTMYIHz4mWaUSJa7KwCeNgELI0hHMSzWtAIjffZd5xG2CSN4rGEH5vDKmCQMEzYjYlCLcelIoOaQ8i7NCFMsOaFoY8yBpikwuTNVIrHQLTvheOwpE8d5XLjRJQnFZg9WYTRMQU9t/TGu6tiASSiZX2cbf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628250; c=relaxed/simple;
	bh=VbOkG7UxlyHWlguAL2j5KGuPIwyUxslVDdZfokzx/f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j221aicR2e0ubVvZE8pz5ntWH8kynP+LpmM4H95Lp4njaY0QuVhNbLcN4Tc2D0EzgT2YHifzPQCS2pAa5f56EvVmY8pjiHRB7KGh9dJKsuJIlOx12cgCrFLqCUtld0FPcDfJemOqEXiEJiYARzH660CHEvj7Hp35r8js7OwHCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWNooiF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E144C4CED2;
	Tue, 26 Nov 2024 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732628250;
	bh=VbOkG7UxlyHWlguAL2j5KGuPIwyUxslVDdZfokzx/f0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tWNooiF16pOSDmb1iMlDJG01LKQojiwCvtI97+t8rc31hnW1mqLconLH2q1DZiEdT
	 pHv6PFGvgVLx4syDuoJu8xJrqjnybRngr1i0zBeOFHuYenp2y9XeR/dI7EZEmRw+cm
	 Zzy4BEf2WxuGT3wACU+VHjLVcgmloEfTdKTxLSKHSUIXNtUemBQFf6DelxO5XEFlom
	 WLkGw9d8GK2tzjd6Ulnb/87zBq5khVWxoLDk33nQj7cKH2MEcVozwE/zZeS1/Yw1aY
	 waTMoaLK+g5xrawAGmbQdPfmnsgf6XJ8NmIKMhKaNABKnCrDMmzHzheUBoemTGpOe0
	 9+vISiy2Z3TmQ==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6eeca49d8baso43215617b3.0;
        Tue, 26 Nov 2024 05:37:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhtFv3dU7C2AVYSZWQKU4AdVcSvfT7A9ehv62gND+ETN4drc2P2KPwVgNR1u2xuSOoF+Wa0SUwAEIM@vger.kernel.org, AJvYcCVmxVnoJtyE63qIS/xykvyCqdoSxtEjpoBLq0M2IjO528IJ+7RYUWPzwkJUemPvYdBCt47aqM4kmKFwSlx6@vger.kernel.org
X-Gm-Message-State: AOJu0YyiT1VSK+og4I731g/4nnWDcI1jqasG8BMZ4PAcZFyUrjT/+Tg5
	8nD3+7KihNzJL++Il+e5RdGibdeQckC7YFTrmSxbsGkdA09uOlYgpGfdDu9i7ZXwqLP0L4NcWwW
	3o6u5LGzX0w7hlxGcKObZhsYpkA==
X-Google-Smtp-Source: AGHT+IEnXFbOa9aXTSk7jlPCIgSVpFPdSMelXI3aGNVoBWCaVRayUlLEtrcRuuQMm6/x5KJIU4FdbHA5bt4fqU7rYtE=
X-Received: by 2002:a05:690c:968e:b0:6ea:6644:ddf8 with SMTP id
 00721157ae682-6ef23a65d69mr27243007b3.0.1732628249338; Tue, 26 Nov 2024
 05:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126025710.591683-1-mpe@ellerman.id.au>
In-Reply-To: <20241126025710.591683-1-mpe@ellerman.id.au>
From: Rob Herring <robh@kernel.org>
Date: Tue, 26 Nov 2024 07:37:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKJzAoxFQ30rJbH7D7zmGtZ+jNpw2BL45dqjOUe2fFbwA@mail.gmail.com>
Message-ID: <CAL_JsqKJzAoxFQ30rJbH7D7zmGtZ+jNpw2BL45dqjOUe2fFbwA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/prom_init: Fixup missing powermac #size-cells
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, saravanak@google.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 8:57=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> On some powermacs `escc` nodes are missing `#size-cells` properties,
> which is deprecated and now triggers a warning at boot since commit
> 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells
> handling").
>
> For example:
>
>   Missing '#size-cells' in /pci@f2000000/mac-io@c/escc@13000
>   WARNING: CPU: 0 PID: 0 at drivers/of/base.c:133 of_bus_n_size_cells+0x9=
8/0x108
>   Hardware name: PowerMac3,1 7400 0xc0209 PowerMac
>   ...
>   Call Trace:
>     of_bus_n_size_cells+0x98/0x108 (unreliable)
>     of_bus_default_count_cells+0x40/0x60
>     __of_get_address+0xc8/0x21c
>     __of_address_to_resource+0x5c/0x228
>     pmz_init_port+0x5c/0x2ec
>     pmz_probe.isra.0+0x144/0x1e4
>     pmz_console_init+0x10/0x48
>     console_init+0xcc/0x138
>     start_kernel+0x5c4/0x694
>
> As powermacs boot via prom_init it's possible to add the missing
> properties to the device tree during boot, avoiding the warning. Note
> that `escc-legacy` nodes are also missing `#size-cells` properties, but
> they are skipped by the macio driver, so leave them alone.
>
> Depends-on: 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-ce=
lls handling")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/prom_init.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_i=
nit.c
> index 73210e5bcfa7..8e776ba39497 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -2848,7 +2848,7 @@ static void __init fixup_device_tree_chrp(void)
>  #endif
>
>  #if defined(CONFIG_PPC64) && defined(CONFIG_PPC_PMAC)
> -static void __init fixup_device_tree_pmac(void)
> +static void __init fixup_device_tree_pmac64(void)
>  {
>         phandle u3, i2c, mpic;
>         u32 u3_rev;
> @@ -2888,7 +2888,31 @@ static void __init fixup_device_tree_pmac(void)
>                      &parent, sizeof(parent));
>  }
>  #else
> -#define fixup_device_tree_pmac()
> +#define fixup_device_tree_pmac64()
> +#endif
> +
> +#ifdef CONFIG_PPC_PMAC
> +static void __init fixup_device_tree_pmac(void)
> +{
> +       __be32 val =3D 1;
> +       char type[8];
> +       phandle node;

I suppose you are keeping the existing style, but you could use
IS_ENABLED() here instead of #ifdef.

Either way,

Reviewed-by: Rob Herring <robh@kernel.org>

