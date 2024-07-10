Return-Path: <linux-kernel+bounces-246912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF0392C8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AA61C22402
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC19B28683;
	Wed, 10 Jul 2024 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjZEXkQh"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40C364BA;
	Wed, 10 Jul 2024 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580593; cv=none; b=ZT1e1vkjhCc/klHi1hhps1WMnkr/aCz3tmQKoWsv8ppZPMZdxJN9IGhrTq8mG17c9Af2xy56ECd1CBlsb8Zb5XW5rE36Spd9LnX1GTgH6Udu9ctcSNS7Bh4ANPaTBk1Q1XuGZm4wjY7i4UwWGiPFv6DrltxokrfSGPV2TlTckxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580593; c=relaxed/simple;
	bh=GfbEa+uUizZaGzhN5tqQlx1HsH4nAvdKwuYdZKmllR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rt8K7tZ3BWi4I10CIv+VTkHMvNS4mjilQMzEcTyhvn4vJPmReIrgJ4TI48pApu1kv9d8lzlqGbVGzff4yeO2VYMkqctswwRfO6y/xRhpKAbw++7RuppFsFl1D6XvT0hzXRRB5xPgdkv8azzjISrXb2MNmQ2UMCqyCkdmB6lqKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjZEXkQh; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d9234b77dfso2201113b6e.0;
        Tue, 09 Jul 2024 20:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720580590; x=1721185390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KKkEn8gtIME2o7SskHC2V7w9XB0tpg/NcovnDfSPb3k=;
        b=PjZEXkQhxPnEMnRRCvq5b5G1IcF+f9gmDK4v1lbZ366OW5kbFsy/x3l2dbSkXuQmhY
         ntr1ijHbefLwrn70cbZaGsLUX320CCqJgWIZWYxtHXKi4BCh/0M2fGrewMgJSL1iRHAN
         yPlfLGVCQVE7s0Km5QSB3KD3TI5Xa/mW72aQhXcxR4893ZMvTIMgvt/VQk63R3hAKUEW
         8OslhbumcDLuVRtoxrtvkodU2xgqDGvHfqnaGQq0RgDIWLY8mHjyS6kO5JGzCR5hpnjx
         qkEEkmP3mJJ7Z2SpV900k8uuxxR8AQWSnVB5iGEATZzJVIOl69LN47n4ILIjmKbb1CUK
         kDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720580590; x=1721185390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKkEn8gtIME2o7SskHC2V7w9XB0tpg/NcovnDfSPb3k=;
        b=pj4X5gsFxtR+eg6dEddMJ8VxamEKIn3QYa2ib7qeGshe2QlchKmnz5n45mdmuMSRBK
         XUNWW1xUztkL2hq8gZDs/qwTYkOxFZWqWGD4uM0VXhb6DzQ0SXUG+sKPWsumNgcX5MHa
         nf0A9fqCEWAGs8RI8++QRzkU3L/+7bBVZG+8Tzm4xPqqjWyRB8zpFkCCnrZyresNOZLS
         2JdG9dVFfuCqZJeTCOB1D6jR5+nfzUC+L+QMx1f95eWdB54RRu+2uIteiAiel/SPu+/y
         CwZRDa6ww6uZ982mvEjVm6ziebZrjZnaMsZW6ODGBHxTKgt4GT7IN0z7vcjObM4OH5kY
         5otQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZXSWFke9NciJySGFFvpU5e9tu1CoyAr09K1c57MrhVpvWsIrQWAxbst+jz5N+1c/bmoPaFkDa8rO/CimAl+iPtPCNopmbARurIia0DEjjHdl8WHA6jJzfI/t5poaKGAjdbsRY9YgpDzGEBsf8+oLdOW9i9UrQ5WD+f4G/JUvTKdOA2A==
X-Gm-Message-State: AOJu0YyfYdxSzl6QL0VkpL01dAaQ6wd0LtiwWWNywjCRoqpszdzsYlMX
	+Kc3UrMM2SFDKIY2cZae5czy/RvL4iuXssEhQSVxu825HeV+RF93Y0BDhkz9g7K3U31d6RJrAGY
	wuSp1LXWr0ghZ4i7heO5JY48MuNE=
X-Google-Smtp-Source: AGHT+IFgagPufhfO3kVQfItv3SWrXC3htPT/1kAkqIC6JWUhjoj+56zpXjnNVV8XcysieMT0AiF5k6pFInYg5EvGmSk=
X-Received: by 2002:a05:6808:bd4:b0:3d9:3649:908a with SMTP id
 5614622812f47-3d93c0b5c09mr4527199b6e.58.1720580590556; Tue, 09 Jul 2024
 20:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709123121.1452394-1-heiko@sntech.de>
In-Reply-To: <20240709123121.1452394-1-heiko@sntech.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 10 Jul 2024 08:32:57 +0530
Message-ID: <CANAwSgQGoeyy3V9hBNcxFynRgR-rUanUzVN41uFxu0-_OqKKZg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Binding and driver for "dumb" clock generators
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Heiko,

On Tue, 9 Jul 2024 at 18:02, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Rockchip boards with PCIe3 controllers inside the soc (rk3568, rk3588) have
> external clock generators on the board to generate the needed 100MHz
> reference clock the PCIe3 controller needs.
>
> Often these clock generators need supplies to be enabled to run.
>
> Modelling this clock has taken a number of shapes:
> - The rk3568 Rock-3a modelled the generator-regulator as "phy-supply" [0]
>   &pcie30phy {
>         phy-supply = <&vcc3v3_pi6c_03>;
>         status = "okay";
>   };
>   which is of course not part of the binding
>
> - On the Rock-5-ITX the supply of the clock generator is controlled by
>   the same gpio as the regulator supplying the the port connected to the
>   pcie30x4 controller, so if this controller probes first, both
>   controllers will just run. But if the pcie30x2 controller probes first
>   (which has a different supply), the controller will stall at the first
>   dbi read.
>
> - Recent Theobroma-Systems boards (Jaguar and Tiger) modelled their
>   generator as a combination of fixed clock and gpio-gate, which works
>   because the generator's vdd-supply is always on and only the output-
>   enable pin needs to be toggled.
>
>
> So this series attempts to improve the situation by allowing to model
> these clock generators as actual entities in the devicetree, to not have
> them just accidentially work or break bindings.
>

I was wondering if these changes apply to Radxa Rock 5b SbC, it does not have
pi6c557 clock generator but the schematic supports GEN_CLK_100MHZ is
input to CLKin0 which is generated via the VCC3V3_PI6C_05 (100MHz,3.3V,3225)
regulator.

[1] https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock5b_v13_sch.pdf

Thanks
-Anand

>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts#n605
>
> Heiko Stuebner (6):
>   dt-bindings: clocks: add binding for generic clock-generators
>   clk: add driver for generic clock generators
>   arm64: dts: rockchip: fix the pcie clock generator on Rock 5 ITX
>   arm64: dts: rockchip: use clock-generator for pcie-refclk on
>     rk3588-jaguar
>   arm64: dts: rockchip: use clock-generator for pcie-refclk on
>     rk3588-tiger
>   arm64: dts: rockchip: add pinctrl for clk-generator gpio on
>     rk3588-tiger
>
>  .../bindings/clock/clock-generator.yaml       |  62 ++++++++
>  .../arm64/boot/dts/rockchip/rk3588-jaguar.dts |  13 +-
>  .../boot/dts/rockchip/rk3588-rock-5itx.dts    |  34 ++++-
>  .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi |  21 +--
>  drivers/clk/Kconfig                           |   7 +
>  drivers/clk/Makefile                          |   1 +
>  drivers/clk/clk-generator.c                   | 133 ++++++++++++++++++
>  7 files changed, 251 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/clock-generator.yaml
>  create mode 100644 drivers/clk/clk-generator.c
>
> --
> 2.39.2
>
>

