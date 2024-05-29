Return-Path: <linux-kernel+bounces-193440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2044E8D2C31
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC447287670
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7635415B973;
	Wed, 29 May 2024 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lz9+/A++"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78515A841
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716959767; cv=none; b=R9t5B8v96GfDSpvpgQ/jjdAPTv+Vv7Rc9wosL+GP4OqGlxueDgv+5DQNKcGV2jgAXbV8RiLCMqyqaMi08ZH+Sb/j31XfSaakh9FsestoWKSb0C4LDrR18PCfAOc/osNks5pSJTpbmcmx7uw5es2DxXnR5bfKpa4RBx3ZPXmF3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716959767; c=relaxed/simple;
	bh=3LtkZySiE3rur8I6zJ2+RVDVKpyyTjsohRTr8GJ2R+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gon27N1E1IXReDvrm+oU8n2wJGU8gR0OuNtbGHW1tYRbP1fUq2e6gBJSwlgP8PTA8A0C2t2IrAEqgz1JxedVwQF0U1CgJLX7RhPtif3B66zgzyp87OlQqTowFGe1txGvgYfNfYmVK4afF9B8ULSdvvOIQGOIUzja8DzUkMtKU2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lz9+/A++; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e96f298fbdso16013481fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716959764; x=1717564564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9ZQ9DZWQvzLjVwLl3ADCun2JEpKNxcZ7yv0Pu1NHRw=;
        b=lz9+/A++r1AWBot8KZb4kG+Ok4ylTvQ3CqGqgPmK8uGliYeAguDRplhD/YbLgt5DLA
         mfkl8py3g2ReA5uAlFdBVrYxz7hHx7uEnZOnqx8eTNvayeBKTpPKIrf4IxQIb4eo1A88
         LxhYGkIqPBe30uNaSyc+nGBgoCj7EGU0VK0GgBMceyThRLRIsYrMcONwzKxnniN4jqz+
         RoH2A/E1G1XoxKMjv1N/RVVJ/M6k9zJsRzqon9Oq44glkXlw8ubBcD3gjOszRjzJ3G3N
         QSgylDZYfd2EoOMyDTGv40hOzuAY+EnPGO6W4ejm9StXzZHYM3yzr1Bac4A1KHB8goOZ
         E8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716959764; x=1717564564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9ZQ9DZWQvzLjVwLl3ADCun2JEpKNxcZ7yv0Pu1NHRw=;
        b=Q7IGQND5TvtUOMcHayZBbhnrfs/gs1UJI95+apWoUQ9g1FR4iOrIrLhkbc7Aok+YB+
         Av9jAA9oZFLIAOlXljj6bTT2H1CUg9GFtfU9D29a1es8Ucj0Jl5DUJVtUGBMITcrVPBQ
         BSWCfAi1ll8v7+XdJiRmwreUju6grG04WlPVveBqzAUyQgkd8wYywjtXVOtb5KqHmgTd
         gNFnI9uomkUlB6z981eQKu3yahTxhL7I53e4+1gO6Zr5s6tGeuelBMWcVghFJPy6etLe
         nif7SnYAv5czB54jqn7psma7cy23QBz9x33pPmNaHKI5ALwQO5YX+HrJMHwAVZ0gqni0
         8Bow==
X-Forwarded-Encrypted: i=1; AJvYcCUfwo8V2zbni4nvUUc3TQAGO8VZuk2ywYFt15JBKMkncvQYo4vjlU12bVc25UuikrhiHTiqt6EdxkxRCn25sTuLO6oCA5NVtijXy9fB
X-Gm-Message-State: AOJu0YxOocSOxU+4iIKkmzXR0NQTdKZf37CCnCfQw4P7uEdO6xTN2TgB
	Be6FW8YetAWeoNYY/ZoEhxWXlwkWmC81sA5qf/Kk9GSrjqshLueS5kKPqwv9/5WkQcBsDtD1H2s
	RBLdX1O363S7hFLJyKzAIzsahNcS2zqXDmszhOA==
X-Google-Smtp-Source: AGHT+IE4Ixyyb9dBIC7b/LMvEyISULydyhrMO3jCXkTNja3SosYDAO4Cj0e7ftfvuomR4+6kRgh5fxUQRNLL0+8ak0I=
X-Received: by 2002:a2e:87c7:0:b0:2e9:794c:19ae with SMTP id
 38308e7fff4ca-2e9794c1b09mr40977011fa.23.1716959763885; Tue, 28 May 2024
 22:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528164132.2451685-1-maz@kernel.org>
In-Reply-To: <20240528164132.2451685-1-maz@kernel.org>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 29 May 2024 10:45:52 +0530
Message-ID: <CAK9=C2XNPJP0X=pg5TSrQbsuouDD3jP-gy2Sm4BXNJp0ZiWp+A@mail.gmail.com>
Subject: Re: [PATCH] of: property: Fix fw_devlink handling of interrupt-map
To: Marc Zyngier <maz@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 10:11=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> Commit d976c6f4b32c ("of: property: Add fw_devlink support for
> interrupt-map property") tried to do what it says on the tin,
> but failed on a couple of points:
>
> - it confuses bytes and cells. Not a huge deal, except when it
>   comes to pointer arithmetic
>
> - it doesn't really handle anything but interrupt-maps that have
>   their parent #address-cells set to 0
>
> The combinations of the two leads to some serious fun on my M1
> box, with plenty of WARN-ON() firing all over the shop, and
> amusing values being generated for interrupt specifiers.
>
> Address both issues so that I can boot my machines again.
>
> Fixes: d976c6f4b32c ("of: property: Add fw_devlink support for interrupt-=
map property")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Rob Herring (Arm) <robh@kernel.org>

Thanks for the fix patch but unfortunately it breaks for RISC-V.

> ---
>  drivers/of/property.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 1c83e68f805b..9adebc63bea9 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1322,7 +1322,13 @@ static struct device_node *parse_interrupt_map(str=
uct device_node *np,
>         addrcells =3D of_bus_n_addr_cells(np);
>
>         imap =3D of_get_property(np, "interrupt-map", &imaplen);
> -       if (!imap || imaplen <=3D (addrcells + intcells))
> +       imaplen /=3D sizeof(*imap);
> +
> +       /*
> +        * Check that we have enough runway for the child unit interrupt
> +        * specifier and a phandle. That's the bare minimum we can expect=
.
> +        */
> +       if (!imap || imaplen <=3D (addrcells + intcells + 1))
>                 return NULL;
>         imap_end =3D imap + imaplen;
>
> @@ -1346,8 +1352,14 @@ static struct device_node *parse_interrupt_map(str=
uct device_node *np,
>                 if (!index)
>                         return sup_args.np;
>
> -               of_node_put(sup_args.np);
> +               /*
> +                * Account for the full parent unit interrupt specifier
> +                * (address cells, interrupt cells, and phandle).
> +                */
> +               imap +=3D of_bus_n_addr_cells(sup_args.np);

This breaks for RISC-V because we don't have "#address-cells"
property in interrupt controller DT node and of_bus_n_addr_cells()
retrieves "#address-cells" from the parent of interrupt controller.

The of_irq_parse_raw() looks for "#address-cells" property
in the interrupt controller DT node only so we should do a
similar thing here as well.

The below change on top of this patch worked for me.

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 9adebc63bea9..f54da2989ea9 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1308,7 +1308,7 @@ static struct device_node
*parse_interrupt_map(struct device_node *np,
 {
     const __be32 *imap, *imap_end, *addr;
     struct of_phandle_args sup_args;
-    u32 addrcells, intcells;
+    u32 addrcells, intcells, paddrcells;
     int i, imaplen;

     if (!IS_ENABLED(CONFIG_OF_IRQ))
@@ -1356,7 +1356,8 @@ static struct device_node
*parse_interrupt_map(struct device_node *np,
          * Account for the full parent unit interrupt specifier
          * (address cells, interrupt cells, and phandle).
          */
-        imap +=3D of_bus_n_addr_cells(sup_args.np);
+        if (!of_property_read_u32(sup_args.np, "#address-cells", &paddrcel=
ls))
+            imap +=3D paddrcells;
         imap +=3D sup_args.args_count + 1;

         of_node_put(sup_args.np);

<snip>

Regards,
Anup

