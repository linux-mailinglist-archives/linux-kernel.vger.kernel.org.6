Return-Path: <linux-kernel+bounces-539956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0D4A4AB4B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B4116F116
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333EF1DF24F;
	Sat,  1 Mar 2025 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs9jRDVC"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868BC1DED79;
	Sat,  1 Mar 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740836490; cv=none; b=OG7iHLTQNjAzRbFZS21eOjTqTu1Fw+HigMEI8Dz686NSxe6W+oEnBLFhTEO7612zW/uhSJCEQwRADxRAptGBCfTp6UMhGcgHbCD0zI11lcpSGHda3wz8mHjON8dWVpjVf/BcLE5cAl/7GNGrbQUqPYyQN8a42tPMeSeIi36NC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740836490; c=relaxed/simple;
	bh=TLIhfOfTyCtDjvvlh1iDs9YNZo5D51zr3rSzpsvTr7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObPnSdeRH1ptSCscWN0J+3pDAnKLlcRTtWDqpjML0UrleaIhmeluzTXUgstr71K5NyANoQQM71lAqte85I3StM1HAcA2zO9UGz72aCrPpS6X+yWW2b8qAs3hnQC91si0gZo0i4vGS8dwUO1fU7LUUPQp4MrO+cpTEXEWttSVP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs9jRDVC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e04861e7a6so5150565a12.1;
        Sat, 01 Mar 2025 05:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740836486; x=1741441286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78FXd7H9s7OsBCpwurs18e3LRIW9gE8fGHh/i6qsJMY=;
        b=Zs9jRDVCtvn2I8fKKGp476tsZ7VvuUBCqqLmRkRmZ5uJc8wcFyuPEpnmeX5hiBcivB
         iJCuXI+OxTgELVLyyXJCQ/z0HhP5QHzXrVwcmwa5rEr8QlbJpT/11fvFgm+K8AVrsHRg
         ZteGJNAs94xt7Neh74hHdDxm4gSQaoLXeU5MZA47rrmv7EUSep2dPDgYkui00DdQVjkZ
         NYv4P8yozWCgST/mijT1Dy8vFYaHqGJiptEBYu/rQVp4OBmsB9bdc4mjjR41V50izLVj
         F7xihl+e/aHaYCDjpsIKFA9U9g3BfxpK2grg81B/teV7Kt70K8JSWP1Td+I3rhbNe+Co
         4ARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740836486; x=1741441286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78FXd7H9s7OsBCpwurs18e3LRIW9gE8fGHh/i6qsJMY=;
        b=cbVJG/W7J9Q7IyvOTzWwByrZghmQEqNPCvjAgxJ8POw0NM0kJbu+9MZ/pBT93Sc325
         L96aVC12L8oyz1/o34CuerNSa9gyh9B9hbF6Ic8v2pdsxkYI1YtWiRWiSjWk7YSWGrAJ
         MmLFtCwhW6Z/lPUWjt1Md68Pa7FJTx/VvkCDr/CsNQXAGtcnKq9KuHZEQ0YSa7ZS6/9Z
         K4kr3I73ixOGDVQoEJYJWOr0uAxWBnjvbIuuk+FymwtAprD7arKfbnu1qZN68qQvhOqe
         YQtywfniPKcZRNmm1dGz2OSFZ+Ct1IxdldzopEqFEJqo10Xmw2xxXeslGbQWlnVxXKGR
         Z9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoJ7ZJ6L2Vz8Mk/0WE0pOa5EgA2TrvgtMxr2Mq/T6J+e/McZXOm63cRq0s/cSVU3BqwaAz3p02zCoF@vger.kernel.org, AJvYcCVm4w73CmKkf6Z+rNWCjQa1lFIdTrozzzmhBXpZkw7BmroIOhSSYh/RGEv/q4uZDGihN1mdbqIbDqAvfWbK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2+nfJ2qVPhreyNacOG6Fen5KelFZ7TvkI++JTXCpognwaCUk
	B2G5KF+XWgdugPcMTntNBlWj66Ec5gXo/ltwkyS9luLP0k76OXIjx5uQQrcfURG6zqOchVWWmPC
	vJNwxhcIKFUG/M2NLA3W+VPdAv24=
X-Gm-Gg: ASbGnctqGWyREQqu3dgfvew/f8+mR3vRDMvDLf1XrJoul7YjomYiG8vVAC+fY82Ipb/
	nuzsdw27r+0QnW1jR8O5XX/SktsLsiT64pzCAhPpiEKn0cl6sPNGZLacJo1JQAr8cAu+pplozmt
	7j85dA/8VtjR+S3JXjNERz6N6y+O/zld3mOKrk7vR8LuVNcT3Z9PlBQM+6
X-Google-Smtp-Source: AGHT+IFLxVwOp5YMLsUkpptEmA0Qd2Flk1VNPL1BruQvXJdV1T6bcBXaIIh31J/l6mfSHIbhS/PJMvsfGdt69/SIBp4=
X-Received: by 2002:a17:907:2d0b:b0:abb:9d27:290f with SMTP id
 a640c23a62f3a-abf25da236emr881207766b.9.1740836485188; Sat, 01 Mar 2025
 05:41:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com> <20250228-factual-rage-0e1e1e48b009@spud>
In-Reply-To: <20250228-factual-rage-0e1e1e48b009@spud>
From: damon <sycamoremoon376@gmail.com>
Date: Sat, 1 Mar 2025 21:41:14 +0800
X-Gm-Features: AQ5f1JpwJ3BP_PC0W0ktRvkC8fjTUkMCYP9UPIHRuRuOyqb-ZHyNsvBVo66Lwcc
Message-ID: <CAKyUbwXUPBceR1ArZeLLjs1VNyRW=DngZyLTUCDGPFvT9wKikw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: sophgo: dts: Add spi controller for SG2042
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, chao.wei@sophgo.com, 
	xiaoguang.xing@sophgo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 25/02/28 06:22PM, Conor Dooley wrote:
> On Fri, Feb 28, 2025 at 08:40:23PM +0800, Zixian Zeng wrote:
> > Add spi controllers for SG2042.
> >
> > SG2042 uses the upstreamed Synopsys DW SPI IP.
> >
> > Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> > ---
> > For this spi controller patch, only bindings are included.
>
> ^^^ you've not actually included any bindings in this patch, copy-paste
> mistake?
>
My bad, I was confused about what=E2=80=99s the =E2=80=9Cbinding=E2=80=9D m=
eaning. I will
remove this description in next revision.
> > This is tested on milkv-pioneer board. Using driver/spi/spidev.c
> > for creating /dev/spidevX.Y and tools/spi/spidev_test for testing
> > functionality.
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
>
> I thought were were dropping the use of "snps,dw-abp-ssi" in isolation,
> and starting to require soc-specific compatibles now.
>
That=E2=80=99s better, I will do it in next revision.
BTW, <https://lore.kernel.org/linux-riscv/20240703-garbage-explicit-bd95f8d=
eb716@wendy>
has similar situation,
those patches only create binding but not implement the compatible
property of "thead,th1520-spi=E2=80=9D in driver.
When kernel matching, it will find out there=E2=80=99s no compatible of
"thead,th1520-spi=E2=80=9D so fallback to "snps,dw-apb-ssi=E2=80=9D

May I take you a few minutes for reason behind it? My understanding is
that using soc-specific compatible is better
for future maintaining, If the device actually comes with some unknown
quirks not present in the generic IP.
And all we need to do for fixing is implementing the soc-specific
compatible property.

> Rob, Krzysztof?
>

Best regards,
Zixian Zeng

