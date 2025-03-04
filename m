Return-Path: <linux-kernel+bounces-543294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0EBA4D3F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ADFB1895E19
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29111F461A;
	Tue,  4 Mar 2025 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYxxeJbB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D21DCB24;
	Tue,  4 Mar 2025 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070179; cv=none; b=UFguOOV1qvYCwYdpARVpGCbRp/4jQhQUo+aWuNcTjw2Punxe6x6uKdSe2wQovBa7kLb+4FNKSuMgW8WzO1k5xHOGbMxbGlE6U8qemCAYulKHwqH2H5HD9AkYoRfMXO6rvlqheeG6ZN5dgEL9JgvtxpQKGRUxLOEdCbDjPM3zqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070179; c=relaxed/simple;
	bh=qo90MPty2vy5TkjHxjbbN8VqbnrgXqZe9HCQ6R+CBy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2cvorPi/nC9sGL5jc/q2J+4rijzSusFmEBOaFtiB33VXeaOPeUVxJmF1bSB3Cr5bhZlK5oYJ+D48LuXuvou6ubz3DIHOWXuFZ6of6nNL99h8vn/5YeRK5iXGVEJTN0cuLWyeFsuTPXcRzCRTXX8LUd4j7JH6YdcYvmNfXTqjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYxxeJbB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf57138cfaso500636866b.1;
        Mon, 03 Mar 2025 22:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741070175; x=1741674975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QIIT7csmVM8dlZqywgBobuFZmmi6UocIrnDWBO9ciw=;
        b=ZYxxeJbBG6HPubpoJItUypm/mdo2YiB/zrCdJ164OuUjRRACbGCtsHVqxXcnAj0vId
         5PuYwjIdiFUycWF6m4m9qTSc5js/KXTtgM/Nx1L2kVaJUJyy4WscnETwIRaYyfqbQPku
         pOC7u3oYINulMNES04ST8+VL11EFF/to0zZOOB0BkpogHLCPETJblrDql4bIPUWOr4lN
         JOLWHlq7/fgtJ1aMytouKC3TxBb92PnkApmL/pvQBu0TYqFMa5NJXg8eo0VRDvFVNwRM
         BrZWP2hYL2sxQqjf8QvVGJ1Mdl+aaGE6veT3KwcRvTExZevvPyWO6dJPkKQUt1ONpbms
         s8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741070175; x=1741674975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QIIT7csmVM8dlZqywgBobuFZmmi6UocIrnDWBO9ciw=;
        b=I8KHq9j0yrwW59iR0wFiPJkpsqVvSaPhIXW4pbWaLNUo+q5QPVWsPVLrISflZ0DC91
         pEqLopUslu+8sRv4qJxhEXZEdX1yz/2raAI9gKC94YeUfUmOPvvYjS6MBB2rV5YcyAp6
         StKgooEEQwqmiv9l5cG8rQ3FDST6HcCFI1KfFpE2tDG+HylfMcQdXsKU+JRgyIsXBJS4
         ji6uZSLIeF5JE7o3diwlX7447FpARRX00itn9CL5798t+IXfIvHMYT92vVMBtf1OJYXb
         umwlveQc3+NJLtLqQjpFcZnDwZFVNOkMykZ6iCNE7+7lgC0sYmfIdbJXwgKo54ao36/Q
         DMFg==
X-Forwarded-Encrypted: i=1; AJvYcCUsTM7Fj/gI4Yx32IYoV6sui2VcootHZxlg2u+cWjXNTq5xHNTlkuIhtnlUT1/AIuXScmfuzI9I96yfCtLt@vger.kernel.org, AJvYcCV2ZfdJywkI1WN4lW3ULlB7ZlhZBXtjzEYHuksxRMG43+pK3Eo+XhKJR2lmmOyhuOgEOMd/chKZHzqE@vger.kernel.org
X-Gm-Message-State: AOJu0YyzvECdbHJtOhlJdU2nC4+Y+2T7tLF4h/48rIcdOxcf1iB4Nz9w
	IYrR+m8THdvD5oinyrMAFf4X8L+3Zz0NqlKwHNVfPy4tFMqPBTj3XkhU2S6T5937tMcaDzxvPoO
	OkQcS0zl0vzE57pD0LwFa0iQEtTY=
X-Gm-Gg: ASbGnctAeGLPZurCEGbQVC1WoSmC/ge5VMi16hr52PkmIIVvd8nQDLAR6Q60nqkXbjN
	T5ExuZkBrOgBL1/I+pBj0roR8rv5/26zzGBP5saUAIH+MalnmiB7eAukKP7RlE6C8mdbdAFzOKg
	XkePWgg55suksorO8iQjMd2wsv8OLrghMFS6jzmNn/3Njx6bOEXOEG9vc=
X-Google-Smtp-Source: AGHT+IHZm0fkINHMh/RJm6iSWcBaUzASH1B4ShN21HBXQ4x/u3WqSAUs5vR9z8gHam8OvAnYpRbhVOA/A6CSdmFfsw8=
X-Received: by 2002:a17:907:3d89:b0:ac1:e5b1:86fb with SMTP id
 a640c23a62f3a-ac1e5b191c5mr390382766b.10.1741070174300; Mon, 03 Mar 2025
 22:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com> <fllmh65x7ke4sfolxbdod73fx3fm45w7gy7x4pgamxnbhztjvk@wqd56dzxaa37>
In-Reply-To: <fllmh65x7ke4sfolxbdod73fx3fm45w7gy7x4pgamxnbhztjvk@wqd56dzxaa37>
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Tue, 4 Mar 2025 14:36:03 +0800
X-Gm-Features: AQ5f1JpUBt6QMLvOzLEGb8fYUdsyP3P3_7A1zhBvghXd3CBU5ioBvlsqG2gFerg
Message-ID: <CAKyUbwXqg13Ho7QHw8vV2W6OcObphwhQ8HUrZMDNBxrVxLmdug@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: sophgo: dts: Add spi controller for SG2042
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, chao.wei@sophgo.com, 
	xiaoguang.xing@sophgo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 25/03/02 10:18AM, Inochi Amaoto wrote:
> On Fri, Feb 28, 2025 at 08:40:23PM +0800, Zixian Zeng wrote:
> > Add spi controllers for SG2042.
> >
> > SG2042 uses the upstreamed Synopsys DW SPI IP.
> >
> > Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> > ---
> > For this spi controller patch, only bindings are included.
> > This is tested on milkv-pioneer board. Using driver/spi/spidev.c
> > for creating /dev/spidevX.Y and tools/spi/spidev_test for testing
> > functionality.
>
> I wonder whether this patch is tested (or at least can be
> tested), as I am not sure there are pins for spi or any
> onboard device on existing SG2042 board.
>
Yes, this is tested on milkv-pioneer board.
Since this patch is just for supporting SPI controller in BUS level
which not relates to the real hardware such as screen, I used
driver/spi/spidev.c for creating virtual device /dev/spidevX.Y by
adding nodes in DTS file as following:
spidev@0 {
        compatible =3D "snps,dw-apb-ssi";
        reg =3D <0>;
        status =3D "okay";
};

spidev@1 {
        compatible =3D "snps,dw-apb-ssi";
        reg =3D <1>;
        status =3D "okay";
};
And using tools/spi/spidev_{test,fdx} provided by kernel tree for
testing bus functionality.
> > ---
> > Changes in v2:
> > - rebase v1 to sophgo/master(github.com/sophgo/linux.git).
> > - order properties in device node.
> > - remove unevaluated properties `clock-frequency`.
> > - set default status to disable.
> > - Link to v1: https://lore.kernel.org/r/20250228-sfg-spi-v1-1-b989aed94=
911@gmail.com
> > ---
> >  .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts |  8 +++++++
> >  arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 28 ++++++++++++++=
++++++++
> >  2 files changed, 36 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch=
/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> > index be596d01ff8d33bcdbe431d9731a55ee190ad5b3..c43a807af2f827b5267afe5=
e4fdf6e9e857dfa20 100644
> > --- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> > +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> > @@ -72,6 +72,14 @@ &uart0 {
> >     status =3D "okay";
> >  };
> >
> > +&spi0 {
> > +   status =3D "okay";
> > +};
> > +
> > +&spi1 {
> > +   status =3D "okay";
> > +};
> > +
> >  / {
> >     thermal-zones {
> >             soc-thermal {
> > diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/d=
ts/sophgo/sg2042.dtsi
> > index e62ac51ac55abd922b5ef796ba8c2196383850c4..500645147b1f8ed0a08ad3c=
afb38ea79cf57d737 100644
> > --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > @@ -545,5 +545,33 @@ sd: mmc@704002b000 {
> >                                   "timer";
> >                     status =3D "disabled";
> >             };
> > +
> > +           spi0: spi@7040004000 {
> > +                   compatible =3D "snps,dw-apb-ssi";
> > +                   reg =3D <0x70 0x40004000 0x00 0x1000>;
>
> > +                   clocks =3D <&clkgen GATE_CLK_APB_SPI>,
> > +                                   <&clkgen GATE_CLK_SYSDMA_AXI>;
>
> Is the sysdma axi clock for the this device. IIRC is APB interface.
>
Thanks, I will remove the GATE_CLK_SYSDMA_AXI in next revision.
> Also, Are these clock aligned? If not, use space to align the two
> clocks. You also need to add the clock-names here.
In the case of the only clock, I think it=E2=80=99s probably no need to add
the clock-names property here.
>
> > +                   interrupt-parent =3D <&intc>;
> > +                   interrupts =3D <110 IRQ_TYPE_LEVEL_HIGH>;
>
> > +                   #address-cells =3D <0x01>;
> > +                   #size-cells =3D <0x00>;
> > +                   num-cs =3D <0x02>;
>
> Just use decimal number, no hex there.
>
Thanks, I will fix it in next revision.
> > +                   resets =3D <&rstgen RST_SPI0>;
> > +                   status =3D "disabled";
> > +           };
> > +
> > +           spi1: spi@7040005000 {
> > +                   compatible =3D "snps,dw-apb-ssi";
> > +                   reg =3D <0x70 0x40005000 0x00 0x1000>;
>
> > +                   clocks =3D <&clkgen GATE_CLK_APB_SPI>,
> > +                                   <&clkgen GATE_CLK_SYSDMA_AXI>;
>
> The same as above.
>
Thanks.
> > +                   interrupt-parent =3D <&intc>;
> > +                   interrupts =3D <111 IRQ_TYPE_LEVEL_HIGH>;
>
> > +                   #address-cells =3D <0x01>;
> > +                   #size-cells =3D <0x00>;
> > +                   num-cs =3D <0x02>;
>
> The same as above.
>
Thanks.
> > +                   resets =3D <&rstgen RST_SPI1>;
> > +                   status =3D "disabled";
> > +           };
> >     };
> >  };
> >
> > ---
> > base-commit: aa5ee7180ec41bb77c3e327e95d119f2294babea
> > change-id: 20250228-sfg-spi-e3f2aeca09ab
> >
> > Best regards,
> > --
> > Zixian Zeng <sycamoremoon376@gmail.com>
> >
Best regards,

Zixian Zeng <sycamoremoon376@gmail.com>

