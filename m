Return-Path: <linux-kernel+bounces-575446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4243A702BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279D08428B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD46125A2D1;
	Tue, 25 Mar 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="abKHz4R3"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2525BAB2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909744; cv=none; b=IM5Bx84XfXEMJrUYDlKp7+owZ9/vkzZleAsgulxDPnvDTNPUCDu4DirhsbTzdnFWCHKhGpvw99BCBjdSihiL2TZm78Yc4Q/Zx6yDD/rVSjmRG9nQJJ1pIzZTzw+6gVhSkC061J53isjl8ouREksrjYypoKJqE7vluU8Sumy+aD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909744; c=relaxed/simple;
	bh=PPA/bnLbbF82Hh4tRor2++YUPwl1Ag0+T0RnSiJ+uyw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDWOQ5ClKVscJXCg3yZOuf5j0TCWVvJMYx9kqDE/MY5pKVvcpUzEwfcsFJTjEG8XVo+LGrFseRn8r7jWlluNoIa3iGn8y824TaZ6+jf+PPwo5K9CtBEd0FNmeRLORkfLqqzZr7jqjLfKnBa2nlPclPVZMAtpcsq7ATmkgywZ1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=abKHz4R3; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D58743F59C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742909739;
	bh=0hMG7fY7rFtgJ4XIZJtNcD145PRrc9hGfSpOL/Mrrv8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=abKHz4R3cZ/2xRL6yOtRkdrsd66iSss7r7IUaT62f8Gz5L4p150lPfayMu6c97r0x
	 5ANGn8vv8PigYsDlBC5Xra/gYsVoGs2nMqmjH0j6TSxczpHBFmkEtrVIg7oluSiGzu
	 9bfVhDVaoDljl9vLtk7oZg00qh6IrJE4LNC5hFO9SvlFru9xCKJBeWQh9QsaW3/u4f
	 6NCjzjrHI8jifRMOqqjTNRVITOyc4Z2aRf57xz1WcHBS8v3oCedB7ruT77K8dzhf2E
	 qEPqZWUuYOI9B5bwZTXyjO3EJq4AoS7o6xr9aMaffHzIa+wmdlCGMqRKJK6Hc2HUeZ
	 EC3DnWBMJPEZw==
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3f68fe933b7so5759004b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742909737; x=1743514537;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hMG7fY7rFtgJ4XIZJtNcD145PRrc9hGfSpOL/Mrrv8=;
        b=ua5dgLhItBVJytJbxN5XB60vBGCaPWUkqn87I0QpysZNDTgggQ9xx1jfciNV7l3BKc
         pmc4jdrSzDp7+YPvFXeiA5xqVm22vZIXmphIV/MxTHqcBOO2JtUItJOWwQjV21oJskCp
         h303PjvKutLSDItIIwjn5MDfwykBo/zTbdyfvQIc80KOXCCTtgB+Y005f8gb10y3uS9L
         wO+KQUQdYVAe+zjJR8UxvKE8JIYFJKI1nAMgAxjUy53x6IEzlLLrY7OjBYg+7IoHcbmv
         A+2JfXfh+XZ9AiZrwtZXG1TaPAwDe6Ji6QKufxKcACi3mLwDIr2TIYI52d7isXP1xGiM
         SPWw==
X-Forwarded-Encrypted: i=1; AJvYcCWcuYrd4zobVA9EKpOxwvUgKav2yz2uHoW2prKqICji453PMy2zGSPh93ACOEfjsfs30gqQrlD04y7CGIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQvE+QF/T8EvOkPH91F8tIgAIsI9QLaCbR3+VdR1MTGDhzgTS
	rwd2lTif2Vf1TdgxJoE/7TzzurRk5awihXdPpLCCiQdH0mZv+eeLJGAc27n1DteeMk26fjbfv4t
	S4z7jC3fMiEIni2glcN7qnIUGj3uCotbQ5xo8fzVsm1CjtfRV89DQTB9QqQ2NVsAxsLtdA2ul0a
	le/JM6J1NhXfjwslF9RsvCP4bGwyeLGlz40OMayXLcDkH7XUzpiZUV
X-Gm-Gg: ASbGncu8mZs7AQHHCF5Px1ivB8QqfHZvAvLCSYHy/WGgPX/E0KECUpiCpRu/TkvLA2s
	PTnazVWU5cz5n3rRUdOliYYNm/rFLKenyFi0o0uTIb6m3dIIq8R3pUjVFVhCADyWynBmzQjUm
X-Received: by 2002:a05:6808:23d0:b0:3fa:7909:2719 with SMTP id 5614622812f47-3febf74c308mr10195991b6e.19.1742909737173;
        Tue, 25 Mar 2025 06:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG+uwqksdhqc+U6GeLb0QCuQCixgYLcnD8bEk2R8UprbuPvn+1N9a0NF5Elvug2PTpZ30S9vMWikfZKkzJmos=
X-Received: by 2002:a05:6808:23d0:b0:3fa:7909:2719 with SMTP id
 5614622812f47-3febf74c308mr10195950b6e.19.1742909736731; Tue, 25 Mar 2025
 06:35:36 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Mar 2025 06:35:36 -0700
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Mar 2025 06:35:36 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20250320105449.2094192-10-pinkesh.vaghela@einfochips.com>
References: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com> <20250320105449.2094192-10-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 25 Mar 2025 06:35:36 -0700
X-Gm-Features: AQ5f1JrnR4gv-Y9IjY4QatijgkS1nbXpY-9W_yhvfwMRvgDU4HuRbOyvuw98aoo
Message-ID: <CAJM55Z-LUoeh0pSDnPKpduub_UBOPeg4g3t20JA0GBosJKuiAQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] riscv: dts: add initial support for EIC7700 SoC
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Min Lin <linmin@eswincomputing.com>, 
	Pritesh Patel <pritesh.patel@einfochips.com>, Yangyu Chen <cyy@cyyself.name>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Yu Chien Peter Lin <peterlin@andestech.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Kanak Shilledar <kanakshilledar@gmail.com>, 
	Darshan Prajapati <darshan.prajapati@einfochips.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, rafal@milecki.pl, Anup Patel <anup@brainfault.org>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pinkesh Vaghela wrote:
> From: Min Lin <linmin@eswincomputing.com>
>
> Add initial support for EIC7700 SoC that uses a SiFive Quad-Core
> P550 CPU cluster.
>
> This file is expected to grow as more device drivers are added to the
> kernel.
>
> Signed-off-by: Min Lin <linmin@eswincomputing.com>
> Co-developed-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Co-developed-by: Darshan Prajapati <darshan.prajapati@einfochips.com>
> Signed-off-by: Darshan Prajapati <darshan.prajapati@einfochips.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Tested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> ---
>  MAINTAINERS                            |   1 +
>  arch/riscv/boot/dts/eswin/eic7700.dtsi | 344 +++++++++++++++++++++++++
>  2 files changed, 345 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/eswin/eic7700.dtsi
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc3c9191b00f..2c29023c6725 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8578,6 +8578,7 @@ M:	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
>  M:	Pritesh Patel <pritesh.patel@einfochips.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/riscv/eswin.yaml
> +F:	arch/riscv/boot/dts/eswin/
>
>  ET131X NETWORK DRIVER
>  M:	Mark Einon <mark.einon@gmail.com>
> diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
> new file mode 100644
> index 000000000000..9cef940f07e4
> --- /dev/null
> +++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2024 Beijing ESWIN Computing Technology Co., Ltd.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <1000000>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "sifive,p550", "riscv";
> +			device_type = "cpu";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv48";
> +			next-level-cache = <&l2_cache_0>;
> +			reg = <0x0>;
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "sscofpmf",
> +					       "zba", "zbb", "zicsr", "zifencei";
> +			tlb-split;
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "sifive,p550", "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv48";
> +			next-level-cache = <&l2_cache_1>;
> +			reg = <0x1>;
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "sscofpmf",
> +					       "zba", "zbb", "zicsr", "zifencei";
> +			tlb-split;
> +
> +			cpu1_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible = "sifive,p550", "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv48";
> +			next-level-cache = <&l2_cache_2>;
> +			reg = <0x2>;
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "sscofpmf",
> +					       "zba", "zbb", "zicsr", "zifencei";
> +			tlb-split;
> +
> +			cpu2_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible = "sifive,p550", "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv48";
> +			next-level-cache = <&l2_cache_3>;
> +			reg = <0x3>;
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "sscofpmf",
> +					       "zba", "zbb", "zicsr", "zifencei";
> +			tlb-split;
> +
> +			cpu3_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		l2_cache_0: l2-cache0 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-sets = <512>;
> +			cache-size = <262144>;
> +			cache-unified;
> +			next-level-cache = <&ccache>;
> +		};
> +
> +		l2_cache_1: l2-cache1 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-sets = <512>;
> +			cache-size = <262144>;
> +			cache-unified;
> +			next-level-cache = <&ccache>;
> +		};
> +
> +		l2_cache_2: l2-cache2 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-sets = <512>;
> +			cache-size = <262144>;
> +			cache-unified;
> +			next-level-cache = <&ccache>;
> +		};
> +
> +		l2_cache_3: l2-cache3 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-sets = <512>;
> +			cache-size = <262144>;
> +			cache-unified;
> +			next-level-cache = <&ccache>;
> +		};
> +	};
> +
> +	pmu {
> +		compatible = "riscv,pmu";
> +		riscv,event-to-mhpmcounters =
> +				<0x00001 0x00001 0x00000001>,
> +				<0x00002 0x00002 0x00000004>,
> +				<0x00004 0x00006 0x00000078>,
> +				<0x10009 0x10009 0x00000078>,
> +				<0x10019 0x10019 0x00000078>,
> +				<0x10021 0x10021 0x00000078>;
> +		riscv,event-to-mhpmevent =
> +				<0x00004 0x00000000 0x00000202>,
> +				<0x00005 0x00000000 0x00004000>,
> +				<0x00006 0x00000000 0x00002001>,
> +				<0x10009 0x00000000 0x00000102>,
> +				<0x10019 0x00000000 0x00001002>,
> +				<0x10021 0x00000000 0x00000802>;
> +		riscv,raw-event-to-mhpmcounters =
> +				<0x00000000 0x00000000 0xffffffff 0xfc0000ff 0x00000078>,
> +				<0x00000000 0x00000001 0xffffffff 0xfffe07ff 0x00000078>,
> +				<0x00000000 0x00000002 0xffffffff 0xfffe00ff 0x00000078>,
> +				<0x00000000 0x00000003 0xfffffffc 0x000000ff 0x00000078>,
> +				<0x00000000 0x00000004 0xffffffc0 0x000000ff 0x00000078>,
> +				<0x00000000 0x00000005 0xffffffff 0xfffffdff 0x00000078>,
> +				<0x00000000 0x00000006 0xfffffe00 0x110204ff 0x00000078>,
> +				<0x00000000 0x00000007 0xffffffff 0xf00000ff 0x00000078>,
> +				<0x00000000 0x00000008 0xfffffe04 0x000000ff 0x00000078>,
> +				<0x00000000 0x00000009 0xffffffff 0xffffc0ff 0x00000078>,
> +				<0x00000000 0x0000000a 0xffffffff 0xf00000ff 0x00000078>,
> +				<0x00000000 0x0000000b 0xffffffff 0xfffffcff 0x00000078>,
> +				<0x00000000 0x0000000c 0xfffffff0 0x000000ff 0x00000078>,
> +				<0x00000000 0x0000000d 0xffffffff 0x800000ff 0x00000078>,
> +				<0x00000000 0x0000000e 0xffffffff 0xf80000ff 0x00000078>,
> +				<0x00000000 0x0000000f 0xfffffffc 0x000000ff 0x00000078>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		ranges;
> +		interrupt-parent = <&plic>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;

Hi Pinkesh,

Thank your for the patches!

Should this not be marked dma-noncoherent to avoid having to mark each
peripheral as such?

> +
> +		clint: timer@2000000 {
> +			compatible = "eswin,eic7700-clint", "sifive,clint0";
> +			reg = <0x0 0x02000000 0x0 0x10000>;
> +			interrupts-extended =
> +				<&cpu0_intc 3>, <&cpu0_intc 7>,
> +				<&cpu1_intc 3>, <&cpu1_intc 7>,
> +				<&cpu2_intc 3>, <&cpu2_intc 7>,
> +				<&cpu3_intc 3>, <&cpu3_intc 7>;
> +		};
> +
> +		ccache: cache-controller@2010000 {
> +			compatible = "eswin,eic7700-l3-cache", "sifive,ccache0", "cache";
> +			reg = <0x0 0x2010000 0x0 0x4000>;
> +			interrupts = <1>, <3>, <4>, <2>;
> +			cache-block-size = <64>;
> +			cache-level = <3>;
> +			cache-sets = <4096>;
> +			cache-size = <4194304>;
> +			cache-unified;
> +		};
> +
> +		plic: interrupt-controller@c000000 {
> +			compatible = "eswin,eic7700-plic", "sifive,plic-1.0.0";
> +			reg = <0x0 0xc000000 0x0 0x4000000>;
> +			interrupt-controller;
> +			interrupts-extended =
> +				<&cpu0_intc 11>, <&cpu0_intc 9>,
> +				<&cpu1_intc 11>, <&cpu1_intc 9>,
> +				<&cpu2_intc 11>, <&cpu2_intc 9>,
> +				<&cpu3_intc 11>, <&cpu3_intc 9>;
> +			riscv,ndev = <520>;
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		uart0: serial@50900000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x50900000 0x0 0x10000>;
> +			interrupts = <100>;
> +			clock-frequency = <200000000>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@50910000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x50910000 0x0 0x10000>;
> +			interrupts = <101>;
> +			clock-frequency = <200000000>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@50920000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x50920000 0x0 0x10000>;
> +			interrupts = <102>;
> +			clock-frequency = <200000000>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial@50930000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x50930000 0x0 0x10000>;
> +			interrupts = <103>;
> +			clock-frequency = <200000000>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart4: serial@50940000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x50940000 0x0 0x10000>;
> +			interrupts = <104>;
> +			clock-frequency = <200000000>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		gpio@51600000 {
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0x0 0x51600000 0x0 0x80>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			porta: gpio-port@0 {

Maybe these labels could be something like gpioA, gpioB, etc. to not be
confused with an HDMI port fx.

> +				compatible = "snps,dw-apb-gpio-port";
> +				reg = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts =
> +					<303>, <304>, <305>, <306>, <307>, <308>, <309>,
> +					<310>, <311>, <312>, <313>, <314>, <315>, <316>,
> +					<317>, <318>, <319>, <320>, <321>, <322>, <323>,
> +					<324>, <325>, <326>, <327>, <328>, <329>, <330>,
> +					<331>, <332>, <333>, <334>;
> +				gpio-controller;
> +				ngpios = <32>;
> +				#gpio-cells = <2>;
> +			};
> +
> +			portb: gpio-port@1 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				reg = <1>;
> +				gpio-controller;
> +				ngpios = <32>;
> +				#gpio-cells = <2>;
> +			};
> +
> +			portc: gpio-port@2 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				reg = <2>;
> +				gpio-controller;
> +				ngpios = <32>;
> +				#gpio-cells = <2>;
> +			};
> +
> +			portd: gpio-port@3 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				reg = <3>;
> +				gpio-controller;
> +				ngpios = <16>;
> +				#gpio-cells = <2>;
> +			};
> +		};
> +	};
> +};
> --
> 2.25.1

