Return-Path: <linux-kernel+bounces-236279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C2691DFDC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1691F1C214E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF515AAD5;
	Mon,  1 Jul 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PPWEMAm1"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B4155CA0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838154; cv=none; b=RpWj+nfoGaZ07JlzrGvJFzkCAA5MuaOD1E7oyiGLT0Eocu9ijkPo4PYNCZ4vd238FQwMeTKREYobj9hpMCz7W7j6T2TsyRv7D+hBPv8fzmPFN/5rhDr1jAE9D+nXdLureDl4V6pFI0Xjp9tNks/tu0h41/Kw3wtdf7kFaPy4fEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838154; c=relaxed/simple;
	bh=LSpfzcOMBHNmv2mRZgRjrnWRfp96uw+ReTva5CpBjIw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIiL7m7n6hL20/OkY59o6AvA1nH4+uVThgQW8tBd00/zFBXJGCfBdBn7PI/AOVzug2K5fDNdfnrQg5mSMmiJw43jJZ79jNqupoIzVKT6wi9loiCGAHFUDaEe+TbfVah3xUs0dMqzE+eXA76azqZ2HtxA1moiJ4Uvd19eFTvCkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PPWEMAm1; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C27E03F363
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719838142;
	bh=61jS+H3HhZX9yRGi6eltijbkS4GrGXv2R41trbsravI=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=PPWEMAm1tXBTPGCebtOv52o8VEd9tcvAOU3UpscfXLN6VnQZ8h3yIZ3GZzd6AM6ui
	 Q91AkzWr6MmCax0QunmUZA0c1u5puAgkWhTWt3xg9qbyPfsKK5j82vBqJSfwK7fRdP
	 NFm2MPJw/0AcqqglV9QBAy1Cq2UXkrEtqk+spv3oQbVXkxjP5tm0i3Y4srkTLpt+67
	 Z/5RbGGLZnjWmaPegX4kjfvga/H+Z8m4Ih4CKNy+ar5PplOSF+ZxVvw29XUXA1zgBh
	 t35yX+gb+8n18CYjQsj2QK4IvbzFrYWVJlUUjsa1nItfQiXrnUox4Nolpj33RlHKTx
	 hm1Yin5ieEDDA==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4465aff370fso33511491cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719838141; x=1720442941;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=61jS+H3HhZX9yRGi6eltijbkS4GrGXv2R41trbsravI=;
        b=mBgArm7I8qGdIbkqGtWG9C7bkLs0n1r014nRbrPk18IHBHLkvNzIUxuKxZ+3KvPr+y
         Pbx3voI9iMvQXJ9SK4UcRdWa7/PFfhf047RSefIiE73jlqk454q5jkGnvE50JEWeZDQ5
         oH95qYlvu2g6YCDTdNWlARb4554DK+vRKkD0/HE0gpxJGA6Hvu1L8YQj4ysobPUXNJKf
         fFlf4+wx4LssJU19ZzOt9y9yf/HuBBIBhYPbWkrDPlaQnEyDCdvh0eYJC1PiDqbuHrHi
         JQecWWyrurdvGUTqTMKIfYjbl6rFBNkDeuva1Wh3h+vn6TYVhhm8qlJbL9JaUxH10Gs9
         5SPw==
X-Forwarded-Encrypted: i=1; AJvYcCVVEe3n1EYr7jvUBzKH0OI0VqxPA8X9K4wtD4uaqrpofzPmDMJTExC2+1dZ7POvL7X6asrrqZDXWWgDaq8OHzaA8N9OzYbb+XUtYd72
X-Gm-Message-State: AOJu0YyueVQMcXIEVIQplaTx8d9oSEHPkpaQxcLRfcwyVB2Hzsskqzgb
	vfxDTWwwXU5KOyszusqiwSAqu6qM6rdOAQkZbrfrWdrhjktShLYQPIN5VzVouQepebj+LN81ZP7
	abtnRI8VGK66xsne6KuPbzLo7EuPirFxdqW93ws9/wDCLYYdPNcUgYDLolxJzV2C1CIvCbBbyTg
	qNhyESm3gS9FgtugabvxnXTh2wuJ+8xuEkAYtOi5/kvBPY7arrEwoh
X-Received: by 2002:a05:622a:138d:b0:446:5fe5:5e6e with SMTP id d75a77b69052e-44662da0de5mr61377781cf.17.1719838141584;
        Mon, 01 Jul 2024 05:49:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElrPGN/hcpI+Rli/NoTxW15bcSu8Uur0w4SOp9t79rv1i75u4WH/O+/1MI+XpIreJUJ5RENYmsap/oUDMXVpk=
X-Received: by 2002:a05:622a:138d:b0:446:5fe5:5e6e with SMTP id
 d75a77b69052e-44662da0de5mr61377451cf.17.1719838141020; Mon, 01 Jul 2024
 05:49:01 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jul 2024 12:49:00 +0000
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240627-k1-01-basic-dt-v2-8-cc06c7555f07@gentoo.org>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org> <20240627-k1-01-basic-dt-v2-8-cc06c7555f07@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 1 Jul 2024 12:49:00 +0000
Message-ID: <CAJM55Z9jeAQTsVjRiLeofDm1RyMWCuHXC0a-pdKtpUiTkSjJCA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] riscv: dts: add initial SpacemiT K1 SoC device tree
To: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, 
	Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yixun Lan wrote:
> From: Yangyu Chen <cyy@cyyself.name>
>
> Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
>
> Key features:
> - 4 cores per cluster, 2 clusters on chip
> - UART IP is Intel XScale UART
>
> Some key considerations:
> - ISA string is inferred from vendor documentation[2]
> - Cluster topology is inferred from datasheet[1] and L2 in vendor dts[3]
> - No coherent DMA on this board
>     Inferred by taking vendor ethernet and MMC drivers to the mainline
>     kernel. Without dma-noncoherent in soc node, the driver fails.
> - No cache nodes now
>     The parameters from vendor dts are likely to be wrong. It has 512
>     sets for a 32KiB L1 Cache. In this case, each set is 64B in size.
>     When the size of the cache line is 64B, it is a directly mapped
>     cache rather than a set-associative cache, the latter is commonly
>     used. Thus, I didn't use the parameters from vendor dts.
>
> Currently only support booting into console with only uart, other
> features will be added soon later.
>
> [1] https://docs.banana-pi.org/en/BPI-F3/SpacemiT_K1_datasheet
> [2] https://developer.spacemit.com/#/documentation?token=3DBWbGwbx7liGW21=
kq9lucSA6Vnpb
> [3] https://gitee.com/bianbu-linux/linux-6.1/blob/bl-v1.0.y/arch/riscv/bo=
ot/dts/spacemit/k1-x.dtsi
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  arch/riscv/boot/dts/spacemit/k1.dtsi | 378 +++++++++++++++++++++++++++++=
++++++
>  1 file changed, 378 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/s=
pacemit/k1.dtsi
> new file mode 100644
> index 0000000000000..a46149b0b9ff8
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +/dts-v1/;
> +/ {
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	model =3D "SpacemiT K1";
> +	compatible =3D "spacemit,k1";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +		serial1 =3D &uart2;
> +		serial2 =3D &uart3;
> +		serial3 =3D &uart4;
> +		serial4 =3D &uart5;
> +		serial5 =3D &uart6;
> +		serial6 =3D &uart7;
> +		serial7 =3D &uart8;
> +		serial8 =3D &uart9;
> +	};
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		timebase-frequency =3D <24000000>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu =3D <&cpu_0>;
> +				};
> +				core1 {
> +					cpu =3D <&cpu_1>;
> +				};
> +				core2 {
> +					cpu =3D <&cpu_2>;
> +				};
> +				core3 {
> +					cpu =3D <&cpu_3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu =3D <&cpu_4>;
> +				};
> +				core1 {
> +					cpu =3D <&cpu_5>;
> +				};
> +				core2 {
> +					cpu =3D <&cpu_6>;
> +				};
> +				core3 {
> +					cpu =3D <&cpu_7>;
> +				};
> +			};
> +		};
> +
> +		cpu_0: cpu@0 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_z=
ifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_s=
vinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_1: cpu@1 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <1>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_z=
ifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_s=
vinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu1_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_2: cpu@2 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <2>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_z=
ifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_s=
vinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu2_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_3: cpu@3 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <3>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_z=
ifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_s=
vinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu3_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_4: cpu@4 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <4>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_z=
ifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_s=
vinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu4_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_5: cpu@5 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <5>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_z=
ifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_s=
vinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu5_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_6: cpu@6 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <6>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_z=
ifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_s=
vinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu6_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_7: cpu@7 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <7>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_z=
ifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_s=
vinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu7_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +	};
> +
> +	soc {
> +		compatible =3D "simple-bus";
> +		interrupt-parent =3D <&plic>;
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		dma-noncoherent;
> +		ranges;
> +
> +		plic: interrupt-controller@e0000000 {
> +			compatible =3D "spacemit,k1-plic", "riscv,plic0";
> +			reg =3D <0x0 0xe0000000 0x0 0x4000000>;
> +			interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_intc 9>,
> +					      <&cpu1_intc 11>, <&cpu1_intc 9>,
> +					      <&cpu2_intc 11>, <&cpu2_intc 9>,
> +					      <&cpu3_intc 11>, <&cpu3_intc 9>,
> +					      <&cpu4_intc 11>, <&cpu4_intc 9>,
> +					      <&cpu5_intc 11>, <&cpu5_intc 9>,
> +					      <&cpu6_intc 11>, <&cpu6_intc 9>,
> +					      <&cpu7_intc 11>, <&cpu7_intc 9>;
> +			interrupt-controller;
> +			#address-cells =3D <0>;
> +			#interrupt-cells =3D <1>;
> +			riscv,ndev =3D <159>;
> +		};
> +
> +		clint: timer@e4000000 {
> +			compatible =3D "spacemit,k1-clint", "sifive,clint0";
> +			reg =3D <0x0 0xe4000000 0x0 0x10000>;
> +			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> +					      <&cpu4_intc 3>, <&cpu4_intc 7>,
> +					      <&cpu5_intc 3>, <&cpu5_intc 7>,
> +					      <&cpu6_intc 3>, <&cpu6_intc 7>,
> +					      <&cpu7_intc 3>, <&cpu7_intc 7>;
> +		};
> +
> +		uart0: serial@d4017000 {
> +			compatible =3D "spacemit,k1-uart", "intel,xscale-uart";
> +			reg =3D <0x0 0xd4017000 0x0 0x100>;
> +			interrupts =3D <42>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		/* note: uart1 skipped */

The datasheet page you link to above says "-UART (=C3=9710)", but here you'=
re
skipping one of them. Why? I can see the vendor tree does the same, but it
would be nice with an explanation of what's going on.

> +
> +		uart2: uart@d4017100 {
> +			compatible =3D "spacemit,k1-uart", "intel,xscale-uart";
> +			reg =3D <0x0 0xd4017100 0x0 0x100>;
> +			interrupts =3D <44>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart3: uart@d4017200 {
> +			compatible =3D "spacemit,k1-uart", "intel,xscale-uart";
> +			reg =3D <0x0 0xd4017200 0x0 0x100>;
> +			interrupts =3D <45>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart4: uart@d4017300 {
> +			compatible =3D "spacemit,k1-uart", "intel,xscale-uart";
> +			reg =3D <0x0 0xd4017300 0x0 0x100>;
> +			interrupts =3D <46>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart5: uart@d4017400 {
> +			compatible =3D "spacemit,k1-uart", "intel,xscale-uart";
> +			reg =3D <0x0 0xd4017400 0x0 0x100>;
> +			interrupts =3D <47>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart6: uart@d4017500 {
> +			compatible =3D "spacemit,k1-uart", "intel,xscale-uart";
> +			reg =3D <0x0 0xd4017500 0x0 0x100>;
> +			interrupts =3D <48>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart7: uart@d4017600 {
> +			compatible =3D "spacemit,k1-uart", "intel,xscale-uart";
> +			reg =3D <0x0 0xd4017600 0x0 0x100>;
> +			interrupts =3D <49>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart8: uart@d4017700 {
> +			compatible =3D "spacemit,k1-uart", "intel,xscale-uart";
> +			reg =3D <0x0 0xd4017700 0x0 0x100>;
> +			interrupts =3D <50>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart9: uart@d4017800 {
> +			compatible =3D "spacemit,k1-uart", "intel,xscale-uart";
> +			reg =3D <0x0 0xd4017800 0x0 0x100>;
> +			interrupts =3D <51>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +	};
> +};
>
> --
> 2.45.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

