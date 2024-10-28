Return-Path: <linux-kernel+bounces-383928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9DA9B2207
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0385BB20DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 01:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766ED14D71E;
	Mon, 28 Oct 2024 01:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="13j+QPhv"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB6224CF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730079257; cv=none; b=hMcRBTwVniSE9Q14O4F+tOBuZHueTFoV4r/99p6qyRH98JiHAQIYalftPwW2LLSmksByLMXHvnQkEhHk+XdtlCYNidaC37BhwXY31bvrVui5E/1jvQHZbmGIzeMWxAss3TTQY3+q23YTR79TISLf7O+cK5HtiznQQLsTrHDHCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730079257; c=relaxed/simple;
	bh=VCp95aZiq4wdUlCwpMKyOCrixWgQivMYEZwKuRwNFEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3BH8C62o0TeB3Sp7nhO7bzHLS5M+j0A6dbuTE6D4HaF46/iEmmEZHGgEia+f8vrRb1su4TlhXfSWcrECSLOmnHVOI5jzT0OKa0sNn485EMNTgHx6m4uonZPipg6NwEmxZ1xjEmXJCCCXFHT72s803qkUhL2lT328fBGvXHFyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=13j+QPhv; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4609beb631aso29871651cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 18:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1730079253; x=1730684053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd3rI0WOK8F+dWuu+ctl7DrBAqE+1P5jJI0tLZE7gbY=;
        b=13j+QPhvRxP6emwCcJK3Jw2HWqPBKO6rcYXYskhdgE7b6Vqcpri6bYcBeX/DObHu1p
         p1kGU3lJfvF8ffJp8QFZxTF2k74sH9ISLGjgvjvuQnQr+gJHgWs+NSIQ0uRNT+Xn1m85
         23NQTmVSLmbr0j9YD8i5Ijh2p7A0yB6VUiulmXr3W2j+iyybVrRu//VcjYR0/kxptX34
         sfasc615N1EAML2ThtDdJXh1FT2jCLarb3gFDZChkjacu3LCJOtQAh8RndSuDYb7OeqC
         erRLwkeSkSXzPnCiUcms0RnQEAPWCKd1NMcmENpTOfslSHeXA043JZ3jXLD14y+nnmUg
         xnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730079253; x=1730684053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd3rI0WOK8F+dWuu+ctl7DrBAqE+1P5jJI0tLZE7gbY=;
        b=mT5yBM2qSnSG7x/OwPl226mBOe0kmQ+di0yQ2URnfmA/xnHU/QWchKYqVIy6RTNsMZ
         hTvEFo2t7BuDpNfCh/uo1jm9eoWOm7Z1/JpxiwYsPc90SvdLuiwcYpzAY+CnPxcq/7xP
         EneyeIy+SfJ0NIBvMFZ+vdBdnbayJ2eL1FlZRVp31KOwnDJWILP/wc0D6hySV8Qvdjos
         nG/y+T6KsBqQ9y3SxhoyYzKz+mrr4Hg7DdelL2tAFhXN36y1v8MMFsrrmhPY/ZGi6IS2
         a2Bnp5tc/qSBpi1wFC63ov0IhAvrnnTjjKY/y55VdyqCVn43/3GmqTQmWzFuhmLzNO+t
         alrw==
X-Forwarded-Encrypted: i=1; AJvYcCVlPTBmpaD4XUc4Ze/zUn6uBH/W8xbsfi2R1FrFjLAEBZTIrRBkyjU2F44FRf8HMk558SzU223jwecgGJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9TA/l5TEp86ue+epAyjWyPAb+P7JEIkNDErnrdHTxWYFxe0yV
	OqAO3BX8QY1vnPbUM5x//Hude4NN/Wg9NMVRGKT473ZiQhC3pNDv9/A+sQ3slB0rPQ17xuwR6Uj
	e+s4mjJ1oijtp9QuD9AiUG3Cva761CXEagULImQ==
X-Google-Smtp-Source: AGHT+IHtuKHVvermmTR52Ox/8hxgNeJg5boJIeKQtSSzY9lSvZhTZHdDqW4DLxbe/T8oZLzhrvcXf1c2Uknf7WQ5T8g=
X-Received: by 2002:a05:622a:1aa2:b0:460:8bb8:fd79 with SMTP id
 d75a77b69052e-4613bfb6b86mr122633121cf.12.1730079253341; Sun, 27 Oct 2024
 18:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027144448.1813611-1-guodong@riscstar.com>
 <20241027144448.1813611-6-guodong@riscstar.com> <CAJM55Z8fgPLEn=XqfV-5mVBeqpbr-S+4N=vjivofXJY36AajuA@mail.gmail.com>
In-Reply-To: <CAJM55Z8fgPLEn=XqfV-5mVBeqpbr-S+4N=vjivofXJY36AajuA@mail.gmail.com>
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 28 Oct 2024 09:34:01 +0800
Message-ID: <CAH1PCMZ8bxG6_DoWL43E639HJ+PX-ynCSpbXPKMkRA5tCByuuQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] riscv: dts: starfive: add DeepComputing FML13V01
 board device tree
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, rafal@milecki.pl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
	Michael Zhu <michael.zhu@starfivetech.com>, Drew Fustini <drew@beagleboard.org>, 
	Alexandru Stan <ams@frame.work>, Daniel Schaefer <dhs@frame.work>, 
	Sandie Cao <sandie.cao@deepcomputing.io>, Yuning Liang <yuning.liang@deepcomputing.io>, 
	Huiming Qiu <huiming.qiu@deepcomputing.io>, Alex Elder <elder@riscstar.com>, linux@frame.work, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 12:42=E2=80=AFAM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> Guodong Xu wrote:
> > From: Sandie Cao <sandie.cao@deepcomputing.io>
> >
> > The FML13V01 board from DeepComputing incorporates a StarFive JH7110 So=
C.
> > It is a mainboard designed for the Framework Laptop 13 Chassis, which h=
as
> > (Framework) SKU FRANHQ0001.
> >
> > The FML13V01 board features:
> > - StarFive JH7110 SoC
> > - LPDDR4 8GB
> > - eMMC 32GB or 128GB
> > - QSPI Flash
> > - MicroSD Slot
> > - PCIe-based Wi-Fi
> > - 4 USB-C Ports
> >  - Port 1: PD 3.0 (60W Max), USB 3.2 Gen 1, DP 1.4 (4K@30Hz/2.5K@60Hz)
> >  - Port 2: PD 3.0 (60W Max), USB 3.2 Gen 1
> >  - Port 3 & 4: USB 3.2 Gen 1
> >
> > Create the DTS file for the DeepComputing FML13V01 board. Based on
> > 'jh7110-common.dtsi', usb0 is enabled and is set to operate as a "host"=
.
> >
> > Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
> > [elder@riscstar.com: revised the description, updated some nodes]
> > Signed-off-by: Alex Elder <elder@riscstar.com>
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
>
> Thanks! Will you be adding more stuff later like fx. the I2S sound chip?

Yes! Any device that has been tested and shown to work correctly can be
enabled / updated later.

>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>

Thank you Emil.

> > ---
> > v6: Dropped all node status disabled code
> >     Enabled usb0 and set its operation mode to "host"
> > v5: No change
> > v4: Changed model string to "DeepComputing FML13V01"
> >     Changed dts filename and Makefile accordingly to reflect the change
> >     Updated device nodes status, and verified functional
> >     Revised the commit message
> > v3: Updated the commit message
> > v2: Changed the model and copmatible strings
> >     Updated the commit message with board features
> >
> >  arch/riscv/boot/dts/starfive/Makefile           |  1 +
> >  .../starfive/jh7110-deepcomputing-fml13v01.dts  | 17 +++++++++++++++++
> >  2 files changed, 18 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-deepcomputing-f=
ml13v01.dts
> >
> > diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dt=
s/starfive/Makefile
> > index 7a163a7d6ba3..b3bb12f78e7d 100644
> > --- a/arch/riscv/boot/dts/starfive/Makefile
> > +++ b/arch/riscv/boot/dts/starfive/Makefile
> > @@ -8,6 +8,7 @@ DTC_FLAGS_jh7110-starfive-visionfive-2-v1.3b :=3D -@
> >  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7100-beaglev-starlight.dtb
> >  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7100-starfive-visionfive-v1.dtb
> >
> > +dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-deepcomputing-fml13v01.dtb
> >  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-milkv-mars.dtb
> >  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-pine64-star64.dtb
> >  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-starfive-visionfive-2-v1.2a.dt=
b
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01=
.dts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> > new file mode 100644
> > index 000000000000..30b0715196b6
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > +/*
> > + * Copyright (C) 2024 DeepComputing (HK) Limited
> > + */
> > +
> > +/dts-v1/;
> > +#include "jh7110-common.dtsi"
> > +
> > +/ {
> > +     model =3D "DeepComputing FML13V01";
> > +     compatible =3D "deepcomputing,fml13v01", "starfive,jh7110";
> > +};
> > +
> > +&usb0 {
> > +     dr_mode =3D "host";
> > +     status =3D "okay";
> > +};
> > --
> > 2.34.1
> >

