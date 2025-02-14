Return-Path: <linux-kernel+bounces-514985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4688DA35E40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E9E3B1520
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175F267B1C;
	Fri, 14 Feb 2025 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUxc5uE7"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E68267AF9;
	Fri, 14 Feb 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537901; cv=none; b=UsUa/QOdHWU2mtV6kB+pfuqH5UrE/1UQnPY+Id1NFA2MahZnsKedK60edwe0uYF3szL0zWymmhaSnN9/HdeTESnKMLYknOD9J+ybUaFqH5DGQCfa7Ap9lnot92N3pj8H7fNQ1K2XsLV5N7b9AuszCJmtdxKl95jAt2hGYAIHaiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537901; c=relaxed/simple;
	bh=BuLd2PA0W0J6uEHCs9V5fiFHnH0MkuZzFNhpiM3IoKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eX0CIEPk0/UWem0CpkQtvX94PESDyqOlEX7On5zjUOCH+YIdNpZCeWG4W/E4WVAXAIm2GtIMwwKRdgA2rUYh7aLIwu49K7Rn9RMAW8jJBZ8wPvfgEXgR4x2GplEOwvCWBPZoPnZuq71Q4zG//uIvV19Hr1El7epA/rcpkX7by38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUxc5uE7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so404670566b.3;
        Fri, 14 Feb 2025 04:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739537898; x=1740142698; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lP1hpU69owb/Nx1wGtyX3wACbVKop7EcqQ2GnZSjLNQ=;
        b=NUxc5uE7AFsOEF2QoxG32JZFTZS+Wr0OV4EQQFx53rPK5sTmtpsDKb3ieqnfLJCVfc
         y1lR5W91Kx+I2w0z6NdtL9pZohP9ae8pK6ehnxlhDSYeLesoXfEC74MuiXb0a/IsAJ46
         1h0bu3hL6+q7DbkbvNJdzobZ41psFgKUV8I/jeKlNpYEWzGEXQ9kFQrLceLAyEHxlaK/
         oz8LKG8VmH81XpqkdcdqCM2Ek15GU9DDldeO/X3IL3qrA8uxWFn5a9GoHyUheYKYwVmc
         M4ZsR0G75ZWZgouaL8X7Pc3/vSNQDFmQ69uCBOo/U7Z4ckJTEX70hfyRzBSxaa90zUFR
         7PsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739537898; x=1740142698;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lP1hpU69owb/Nx1wGtyX3wACbVKop7EcqQ2GnZSjLNQ=;
        b=uDrn76w3O6Cc2RCZc/hiidu5lqgiR5zLP32DG75fj1prKzGrZMldj3Fm30ZQcp6yY6
         1u8xVSCvAI3CnB73TXIR8CCUfCqyziyk6PJpNaWoN3J2KzPmZZmKH5BP1SgFIG00Z25r
         e8hm5hNqfjmY1qCMjv8EPbC9v7XPpD5MRe70kGP6PEWpryvlvawTzaV9OrYjET0sNFpB
         985netwc7dkS4ebBAPv4JAFdSIvsipHJVCF8Lo/5YMp6ft7cc9ev+hPIEMMQ0iFwnCZX
         n3D8kwFuoCTDa4wgrLLV2P9daQiT7QQpdKanwXz7hA4luKlgN4czJqVO7DPRYIvhjjab
         oXTw==
X-Forwarded-Encrypted: i=1; AJvYcCU0yPCCP6R0UOXpj5xw/LxhguXNs8/ezhJ98veUTh6tj0UCg2UYFjl9JyxB8HMpHnRxvSQL1ZlnDMUd@vger.kernel.org, AJvYcCVyVYlUFNb7ow1RvBdyqdwsHw8fe6HJ4o8GfL9hCYreaeB341T6xNk17TxhGvdtIKoAKo6oBUSMAaiG++gX@vger.kernel.org
X-Gm-Message-State: AOJu0YyvoUzphEyqpTVQk9EBL/pS7pswJHxk83IMoBXdzmiBwNQ6niFm
	MWRdzo4qkLpBa6xecD4J+DlHhwO+RbOe1d54rtTUU+xuuJslUUPz
X-Gm-Gg: ASbGncv1NC+ZKbMd6gRMosA5y41YaMeZ2bd47DlkEsFyxDWQVbfCp5E2phq6oPURF4L
	K2vWR1eSAPMiAf1veph67sTUTE3TtWfqqRh3RM4qbMq3bPiWitrrEEaYrXzKJaPorMC2tUBTaLT
	a9BV7/S33texTScsk6+7k6asAZAdWg/lca43xaXuiNX9Ckbgq0RrAjMkY2W/cx7E7IgePTSYO8r
	SfRDvwZNm5bNRu8x9TxzwL+pH9MqISAW9kFkQMvh3nQFUBwidi3eI42oRX4JTPh2jD6inzwFRo/
	LdcvD2AtQCfpVkcwgHc+bxuIQAkIfUSq
X-Google-Smtp-Source: AGHT+IEM/giBHrNhE2apCFsLoOA7KVfIIVDAQlkLpgsqoRf+RI8nGhggXvQqe8I3LLSH6j7dYy8K3A==
X-Received: by 2002:a17:907:2ce5:b0:ab6:6018:df18 with SMTP id a640c23a62f3a-ab7f3325261mr1184848066b.6.1739537897901;
        Fri, 14 Feb 2025 04:58:17 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376aadsm335251866b.88.2025.02.14.04.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:58:17 -0800 (PST)
Message-ID: <f6b036acada7686e1bfd814bd62782890bf35a50.camel@gmail.com>
Subject: Re: [PATCH v2] riscv: dts: sophgo: add watchdog dt node for CV1800
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: AnnanLiu <annan.liu.xdu@outlook.com>, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, 	conor+dt@kernel.org, Inochi Amaoto
 <inochiama@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2025 13:58:15 +0100
In-Reply-To: <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
References: 
	<DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Annan, Inochi,

On Thu, 2024-01-25 at 17:46 +0800, AnnanLiu wrote:
> Add the watchdog device tree node to cv1800 SoC.
>=20
> Signed-off-by: AnnanLiu <annan.liu.xdu@outlook.com>
> ---
> This patch depends on the clk driver and reset driver.
> Clk driver link:
> https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR2=
0MB4953.namprd20.prod.outlook.com/
> Reset driver link:
> https://lore.kernel.org/all/20231113005503.2423-1-jszhang@kernel.org/
>=20
> Changes since v1:
> - Change the name of the watchdog from watchdog0 to watchdog.
> - Change the status of watchdog.
> v1 link:
> https://lore.kernel.org/all/DM6PR20MB23160B8499CC2BFDAE6FCACDAB9EA@DM6PR2=
0MB2316.namprd20.prod.outlook.com/
>=20
>=20
> =C2=A0arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |=C2=A0 4 ++++
> =C2=A0arch/riscv/boot/dts/sophgo/cv1800b.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++++++
> =C2=A02 files changed, 20 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/risc=
v/boot/dts/sophgo/cv1800b-milkv-duo.dts
> index 3af9e34b3bc7..75469161bfff 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> @@ -36,3 +36,7 @@ &osc {
> =C2=A0&uart0 {
> =C2=A0	status =3D "okay";
> =C2=A0};
> +
> +&watchdog {
> +	status =3D "okay";
> +};

It would be necessary in all SoCs unless... [1]

> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dt=
s/sophgo/cv1800b.dtsi
> index aec6401a467b..03ca32cd37b6 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -1,6 +1,7 @@
> =C2=A0// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> =C2=A0/*
> =C2=A0 * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2024 Annan Liu <annan.liu.xdu@outlook.com>
> =C2=A0 */
> =C2=A0
> =C2=A0#include <dt-bindings/interrupt-controller/irq.h>
> @@ -103,6 +104,21 @@ uart4: serial@41c0000 {
> =C2=A0			status =3D "disabled";
> =C2=A0		};
> =C2=A0
> +		watchdog: watchdog@3010000{
> +			compatible =3D "snps,dw-wdt";
> +			reg =3D <0x3010000 0x100>;
> +			interrupts =3D <58 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&pclk>;

&osc ?

> +			resets =3D <&rst RST_WDT>;
> +			status =3D "disabled";

[1] ... the status here is dropped. What is the reason for disabling it in =
the first place?

> +		};
> +
> +		pclk: pclk {
> +			#clock-cells =3D <0>;
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <25000000>;
> +		};
> +
> =C2=A0		plic: interrupt-controller@70000000 {
> =C2=A0			compatible =3D "sophgo,cv1800b-plic", "thead,c900-plic";
> =C2=A0			reg =3D <0x70000000 0x4000000>;

Why didn't it go into cv18xx.dtsi?

--=20
Alexander Sverdlin.


