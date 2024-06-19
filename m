Return-Path: <linux-kernel+bounces-220971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D82290E9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAFF1C21D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60FE13D8BF;
	Wed, 19 Jun 2024 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VRRtD0/+"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC68173C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797427; cv=none; b=TmzzPlPcBkELYmBPLYlVFfec/6L+IWEyDXEEnmiSh+SEX72e4LEQdsKu0fPowLctpWIJ2n65i9nkl9M3P7tIdGJx24c7h2KIr1oAGuKyKzRQO4YIQLARg4YyOHLYvi8SRlqfqHnNKRJ/KMG6RzIY9uwtxWY6o9jLYX+LQ6yjaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797427; c=relaxed/simple;
	bh=oy1/VM1O8VGib8ShF+vmAO2orh7g2NVW3kzaz8SZj0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9oosl8wweR/uj3DeJFcMUJXkPLxjNyyc0otyA6VsRFez3rDHLirWqcSbocdtUEgPCWyfJUVSrV/NbjhWo3PuNtsNcnVfZvn7gPOF1bJaZatnfRCrOyIMEzTWX7WTiTz6FjrYvVEsmBnAJBa+JJnkY3tYauO7wVQ9xqazaDTHhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=VRRtD0/+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57cb9efd8d1so1260356a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1718797422; x=1719402222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GnjH/kkjRKyzu3uDJd3BYblSPtIV4vK9xdASoNfbuQ=;
        b=VRRtD0/+pjFZydJd9NDIx3En40Wc17ITLunq2aGaZHBh5qMBAHeFyycZZ7WmCBD6xG
         9Ztkloltxk+po9rJz5XEm9OqZF6DbGFIKGbhQUkSrNpySrtAdxUkOkeqWaL1e1RCfhch
         hQOlS427QhTiElDV6LZqOlw+eTTO80zTc9e08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718797422; x=1719402222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GnjH/kkjRKyzu3uDJd3BYblSPtIV4vK9xdASoNfbuQ=;
        b=P3Gt+KJpjZTTg1z0c0+lJ0XM6JVqfVDubM5pVupKW/JZVFh2MHnpLcMSXT1nO2+/vr
         LStpTL1YmrpWDYUaG8FwN3x5TVZdu3bvGa/cav+ZKiQ+fkvndoSM+VmgjeGmioPUGEmL
         PerbXm7VE+aeNLpTAY5njyRJtt5sGw6z3B+Ru4fpAf2dAVbFOvgfipOsr44h7MGbtiXN
         lrK4NDH+S+T4xqRN+oBYJc3BBK6DXoQKFjNiXOdXPpCqbGhaxcizaKYiScAUz1cBHRQU
         +50hmLo6Ph8epAcZR6tKufPRwSl3wE+K1obhAya+uc6Cp+ry8thcBEFoEg0MZYenPdYJ
         /wRg==
X-Forwarded-Encrypted: i=1; AJvYcCWUckfS8oNnR6J0g/LevFdD4l7yZIrER/baO3VaFKRzgIrwobaYhd/ZIT5WPViPfxr46SIbfvQnDDfVIJFf7Hj1bozzm26Td9aMrLpd
X-Gm-Message-State: AOJu0Yw1KP19bnbrEaX01fPR4kDahg4hDRaQguXmmsUVXjEZyCujO4YI
	9aSbU1qEyj7IovwEolmohHT6fo60apcbMFO7pZ2S5Ekbxl8xQNG3ZnVBDQcV7mK40aOoR/m2e+u
	tm/Yt05KpyKOHjGUFz7qKTJ2O/h79TMGUuDceXg==
X-Google-Smtp-Source: AGHT+IGplUBkcMqY8uT1JRiuzDGzVXRTpzbLVQnHZpBqUjCb4F+5Ertt8EMo+fxpvX3PCFzTSeyWlk0dbPDgVFMbMQ0=
X-Received: by 2002:a17:907:c089:b0:a6f:b201:8530 with SMTP id
 a640c23a62f3a-a6fb2018b1emr85834466b.31.1718797422501; Wed, 19 Jun 2024
 04:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619091737.669040-1-albertosecondi@gmail.com> <0e03afd6-46be-4fc7-a974-bf506d8e503c@arm.com>
In-Reply-To: <0e03afd6-46be-4fc7-a974-bf506d8e503c@arm.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 19 Jun 2024 13:43:31 +0200
Message-ID: <CAOf5uwkU1qCxC=OamNHLq3d3SZGVuX8_eh1_MYt6TELT4C1j5Q@mail.gmail.com>
Subject: Re: [PATCH] New config added to handle 64-bit systems with 32-bit DMA support
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alberto Secondi <albertosecondi@gmail.com>, hch@lst.de, m.szyprowski@samsung.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	alberto.secondi@abinsula.com, Davide Salaris <davide.salaris@abinsula.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robin

On Wed, Jun 19, 2024 at 12:36=E2=80=AFPM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> On 2024-06-19 10:17 am, Alberto Secondi wrote:
> > ------ Tessian Warning ------
> >
> > Be careful, the email's sending address "albertosecondi@gmail[.]com" ha=
s never been seen on your company's network before today
> >
> > This warning message will be removed if you reply to or forward this em=
ail to a recipient outside of your organization.
> >
> > ---- Tessian Warning End ----
> >
> > From: Alberto Secondi <alberto.secondi@abinsula.com>
> >
> > The kernel assumes that 64-bit systems have 64-bit DMA support through
> > CONFIG_ARCH_DMA_ADDR_T_64BIT. This is not always true; for example, sev=
eral
> > iMX8 systems (verified on iMX8MM and iMX8MP) have DMA with only 32-bit =
support.
> > This results in several drivers requesting DMA_BIT_MASK(64), which caus=
es
> > malfunctions, particularly when systems have more than 3GB of DRAM (ver=
ified
> > with the lan743x driver and iMX8 systems with 4GB of DRAM). Therefore, =
a new
> > config ARCH_64BIT_HAS_DMA32_ONLY was added to manage 64-bit systems wit=
h 32-bit
> > DMA, which adjusts DMA_BIT_MASK(n) accordingly.
>
> No. If a system has devices naturally capable of >32-bit DMA, and memory
> at >32-bit system physical addresses, but only a 32-bit interconnect in
> between, that needs to be described properly in Devicetree/ACPI, not
> hacked around with completely non-portable kernel bodges.
>

commit 4251a3ac4de9625a284a9c046cc915487e9b2a5e
Author: Lucas Stach <l.stach@pengutronix.de>
Date:   Tue May 4 10:20:51 2021 +0200

    arm64: dts: imx8mm: specify dma-ranges

    DMA addressing capabilities on i.MX8MM are limited by the interconnect,
    same as on i.MX8MQ. Add dma-ranges to the the peripheral bus to let
    the kernel know about this.

    Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
    Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
    Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 64aa38fd2b6e0..e7648c3b83905 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -261,6 +261,7 @@ soc@0 {
                #address-cells =3D <1>;
                #size-cells =3D <1>;
                ranges =3D <0x0 0x0 0x0 0x3e000000>;
+               dma-ranges =3D <0x40000000 0x0 0x40000000 0xc0000000>;
                nvmem-cells =3D <&imx8mm_uid>;
                nvmem-cell-names =3D "soc_unique_id";


Somenthing like this should already do it?

Michael

> Thanks,
> Robin.
>
> > Signed-off-by: Alberto Secondi <alberto.secondi@abinsula.com>
> > Co-developed-by: Davide Salaris <davide.salaris@abinsula.com>
> > ---
> >   include/linux/dma-mapping.h | 4 ++++
> >   kernel/dma/Kconfig          | 8 ++++++++
> >   2 files changed, 12 insertions(+)
> >
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index f693aafe221f..629220a777e3 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -74,7 +74,11 @@
> >    */
> >   #define DMA_MAPPING_ERROR           (~(dma_addr_t)0)
> >
> > +#ifdef CONFIG_ARCH_64BIT_HAS_DMA32_ONLY
> > +#define DMA_BIT_MASK(n)      (((n) > 32) ? ((1ULL<<(32))-1) : ((1ULL<<=
(n))-1))
> > +#else
> >   #define DMA_BIT_MASK(n)     (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))-1=
))
> > +#endif
> >
> >   #ifdef CONFIG_DMA_API_DEBUG
> >   void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)=
;
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index c06e56be0ca1..0a27eafed808 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -36,6 +36,14 @@ config NEED_DMA_MAP_STATE
> >   config ARCH_DMA_ADDR_T_64BIT
> >       def_bool 64BIT || PHYS_ADDR_T_64BIT
> >
> > +config ARCH_64BIT_HAS_DMA32_ONLY
> > +        bool "64bit System has DMA32 only"
> > +        depends on ARCH_DMA_ADDR_T_64BIT
> > +        default n
> > +     help
> > +       This enables forcing the maximum DMA_BIT_MASK to 32 bits for
> > +       64-bit systems that have DMA support limited to 32 bits.
> > +
> >   config ARCH_HAS_DMA_SET_MASK
> >       bool
> >
>

