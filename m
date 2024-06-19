Return-Path: <linux-kernel+bounces-221103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BBC90EDCB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F98128781B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA9C1474C8;
	Wed, 19 Jun 2024 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="m+Nc1qnu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7605146D49
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803327; cv=none; b=G+cGxDYLup5ARyCAX+RxOph+9cBmRIwxWip/77uXTyQqy+y2LE1eAC4ng25yELxw2PQjCTzkUgX4jYz7dLWvio0a7lf/Q+aa0HmNbSmpqcRLFar+gNiRsIt42SYJl5Moeibj/zZLH26oRsz5Zq1F9eC06coqiwBBHvyPOKXNpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803327; c=relaxed/simple;
	bh=6fKNhhnJdzkYpXZ7hZ32PX6Vv1Njh9o1MVYX2vgJXEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmeuRYOOgswrPxGnulYxqo4GcZV+YCrf4fdGzbUk/bWH8j3gng3b9FoBljCWRIYesxBQJNO39KW5Go9UJGvjxlCc5ON1KUgLPqVOErCoUbY1YcI7jKWLL+eV0eG1ghWUmDQ7EONpxyZl9HJZLNnI6c3mevXm4lsOA5RQ/iSy9aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=m+Nc1qnu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a63359aaacaso1047744766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1718803324; x=1719408124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dx0xyrgKo/hD+5I8bLHvVWmDCr5zlfkR0QHSybybAEo=;
        b=m+Nc1qnunw2dUDqtBvgv7YcdLSOXOgxfRiMO6ObBzfIlh5xCuQd2iq3iQRoCPa2dOt
         7mIg7qM410BZ6WGyXHPHoia/d582vInQY8+RGx8ZpsUOJuPM7OcBwUFYQuGbkWQL2bCU
         0YZo3qxb2j9oVKQ3IoghZuLlUWnmALxuNQHcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718803324; x=1719408124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dx0xyrgKo/hD+5I8bLHvVWmDCr5zlfkR0QHSybybAEo=;
        b=X0UFrX6R3coEy7zh3stsDVN9gEF7u3FwoReKFqRVsg+gdRHAdbnzD5nTpMKVKlrtIJ
         7HTbHdwp2VIFrFntwvKFHuKfmJ40hdwM+vCU6Xcd0tivbmYUYLm7YJZjavWBO4rtj2Wp
         lgaSU68L4K0f4TDgCRrtI2QydxpLMreJ1lEf5i2HvCAG6OEZb5yn5k6NFsUtunTFmm76
         AJ5Nr+NQ6yc58BbsVd9rPx0JuRhzg3wBzl6hy9t8dk+4p3wFODB8BIEhI+CGpL58rsnz
         PNaCZrRLGz+KhuhrppuZ0ZFJkuKX4wRkwQmQ7ZVWdCHwT0HEbDHPS9LCybqqJt1QaWTt
         ggjw==
X-Forwarded-Encrypted: i=1; AJvYcCW+n0exsRVHyjZgSr+Wnab+MJKTNotMRPcNX8vSf97vRrN0U25TiYmtSqXll43dKVefxZ6gFJiyQ0fzg7BzH7OcjkkbTp4UmMgpEz7z
X-Gm-Message-State: AOJu0YzUbkzUOt6w/mHVwRcxwiTf8S3Uui1fma6Imt07VkanmfFtBKGc
	0d1BVy5xphRNipt5TbX5sWH08SMOfXRqQZBe0kduX2OJqSQ4Yfm+NZ/nV1CwtwZTuxQF2P0mvLP
	TNCdZ3EQrQNxb+di7hLn7U5JatZBYGR0wi2cYKQ==
X-Google-Smtp-Source: AGHT+IHGGECjZ69ADknlWSO1J2DyCwjjJpFvw+irs/C/rEsZLazt4svXyb1ZHzxz5fYvUbJoclmXALPDcYuzIhOiXwc=
X-Received: by 2002:a17:906:37d2:b0:a6f:77bb:16f3 with SMTP id
 a640c23a62f3a-a6fab77569cmr146365366b.50.1718803324068; Wed, 19 Jun 2024
 06:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619091737.669040-1-albertosecondi@gmail.com>
 <0e03afd6-46be-4fc7-a974-bf506d8e503c@arm.com> <CAOf5uwkU1qCxC=OamNHLq3d3SZGVuX8_eh1_MYt6TELT4C1j5Q@mail.gmail.com>
 <000bca96-dd66-49d2-a540-f4cf36d74ee8@arm.com>
In-Reply-To: <000bca96-dd66-49d2-a540-f4cf36d74ee8@arm.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 19 Jun 2024 15:21:52 +0200
Message-ID: <CAOf5uwk=bafBt2HCTzWs8R0wYS9r1G9uXV92Bx2CK7tMsP-Szw@mail.gmail.com>
Subject: Re: [PATCH] New config added to handle 64-bit systems with 32-bit DMA support
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alberto Secondi <albertosecondi@gmail.com>, hch@lst.de, m.szyprowski@samsung.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	alberto.secondi@abinsula.com, Davide Salaris <davide.salaris@abinsula.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robin

On Wed, Jun 19, 2024 at 2:46=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
>
> On 2024-06-19 12:43 pm, Michael Nazzareno Trimarchi wrote:
> > Hi Robin
> >
> > On Wed, Jun 19, 2024 at 12:36=E2=80=AFPM Robin Murphy <robin.murphy@arm=
.com> wrote:
> >>
> >> On 2024-06-19 10:17 am, Alberto Secondi wrote:
> >>> ------ Tessian Warning ------
> >>>
> >>> Be careful, the email's sending address "albertosecondi@gmail[.]com" =
has never been seen on your company's network before today
> >>>
> >>> This warning message will be removed if you reply to or forward this =
email to a recipient outside of your organization.
> >>>
> >>> ---- Tessian Warning End ----
> >>>
> >>> From: Alberto Secondi <alberto.secondi@abinsula.com>
> >>>
> >>> The kernel assumes that 64-bit systems have 64-bit DMA support throug=
h
> >>> CONFIG_ARCH_DMA_ADDR_T_64BIT. This is not always true; for example, s=
everal
> >>> iMX8 systems (verified on iMX8MM and iMX8MP) have DMA with only 32-bi=
t support.
> >>> This results in several drivers requesting DMA_BIT_MASK(64), which ca=
uses
> >>> malfunctions, particularly when systems have more than 3GB of DRAM (v=
erified
> >>> with the lan743x driver and iMX8 systems with 4GB of DRAM). Therefore=
, a new
> >>> config ARCH_64BIT_HAS_DMA32_ONLY was added to manage 64-bit systems w=
ith 32-bit
> >>> DMA, which adjusts DMA_BIT_MASK(n) accordingly.
> >>
> >> No. If a system has devices naturally capable of >32-bit DMA, and memo=
ry
> >> at >32-bit system physical addresses, but only a 32-bit interconnect i=
n
> >> between, that needs to be described properly in Devicetree/ACPI, not
> >> hacked around with completely non-portable kernel bodges.
> >>
> >
> > commit 4251a3ac4de9625a284a9c046cc915487e9b2a5e
> > Author: Lucas Stach <l.stach@pengutronix.de>
> > Date:   Tue May 4 10:20:51 2021 +0200
> >
> >      arm64: dts: imx8mm: specify dma-ranges
> >
> >      DMA addressing capabilities on i.MX8MM are limited by the intercon=
nect,
> >      same as on i.MX8MQ. Add dma-ranges to the the peripheral bus to le=
t
> >      the kernel know about this.
> >
> >      Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >      Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >      Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >      Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index 64aa38fd2b6e0..e7648c3b83905 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -261,6 +261,7 @@ soc@0 {
> >                  #address-cells =3D <1>;
> >                  #size-cells =3D <1>;
> >                  ranges =3D <0x0 0x0 0x0 0x3e000000>;
> > +               dma-ranges =3D <0x40000000 0x0 0x40000000 0xc0000000>;
> >                  nvmem-cells =3D <&imx8mm_uid>;
> >                  nvmem-cell-names =3D "soc_unique_id";
> >
> >
> > Somenthing like this should already do it?
>
> Hmm, indeed... so the question to dig into would be why that's
> apparently not getting picked up by of_dma_get_range() for that device.
>

The patch does not include what kernel version was tested.  After we
have this answer that
we can know

Michael

> Thanks,
> Robin.



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

