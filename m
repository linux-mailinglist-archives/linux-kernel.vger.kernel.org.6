Return-Path: <linux-kernel+bounces-383700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284559B1F3E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08921F213E2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74831E535;
	Sun, 27 Oct 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="n76DkLlk"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62941CFA9
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730047373; cv=none; b=QTjkFxc5lFnaMLQWPEjvSsZI6mvxd6Mf5baByfL+9obTwvhoJRirC1d+smm6eOa63uSDP1gnk6UDskrOANfdCa0EwC7nxloLboKg+h1fqh5vDVU7A3fmlC5kYI1/ByoTh7IvIp0xjZLAc0BMPBxUR/Cj6gGhD0yFZSgmpUPRte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730047373; c=relaxed/simple;
	bh=NkTK17fBd+Qv71Sdygfc9B7ZmqHB8GiudkyNIZKE4MQ=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUPVbnmIf6+Hr20mfWMK+3d7aU46pltirSLIkIuZ1DTx0Q7Si8zuwHLiZgkAz+gqFAyJcJFHtrjmGKwlS033awe1PM+ICrL5LDHYkxxUMxO0dMX4oiUpc/H6X9HoOQ1eykc/qiZQLQA7RkqMvCrpg6QEjA5HMQ6YdhtH/Jni9PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=n76DkLlk; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B29274120E
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730047369;
	bh=rx+Iv26SQSVeec4MS8C230GVRkuF+slURlh6a1FZiJk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=n76DkLlkGkJo7fC2Oyqp+aGxq33LiRC6yaZX95vuG4M7RFDYRh73LplHjNkh1wMRT
	 0aA7+I34pKCTekYcEfNH7pb65jvsxwwPTLzhM9+CbocHYqKRP+AC4afdoT9tI9Qfou
	 /CSk3UaCnfKpmdaiDUHqueMXCXOVyyAZL1Fr6PejL+nC3oeS2pQHPVo2MHvYov2TEG
	 RbnNqKosBNQantbjgmQte7CyXrqWHi0ZkuFziPVCRXRxJ279JlgCRXzhDCZjBeicTy
	 Fa3PkCWfEYOKldV6zUDSEwkLTXJDokmjU+uC/7teb3+1LYt3mWQq3r4gDitBfhP5Yl
	 pEsqBl6yYEZbA==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-28c65d3a0e9so3853631fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 09:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730047368; x=1730652168;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rx+Iv26SQSVeec4MS8C230GVRkuF+slURlh6a1FZiJk=;
        b=w10CZ2VVX6DrHC8aixU+u9wO9MrS51E4zliE7rUJ+h6jsOIQRJ2OHFJBclt7CpcSN8
         Bxgwm0pyPC3me8BJRi1jPtsV4cvJ50rV27B507jl6ps1AmJlxEWeqMAwQI9yhzJxJwDY
         HNoPmN4x4GP62+chox2taNbEHTAjMs07sRPVSVCk2wyrZAWc1aR8NKPbK7Em0fEQKt6/
         iE3h5ykYcLQ+jqwC1dKpzvWgL11r4HWYE3+RYUGllbVI/7V5sz8jwCxXoQ3m9e+v4Zvn
         8a3NtSVccpufjrRwKkkXxobpxFvvyqFT/HYHJQGaEvA94kQ/xjnEwAJspN0pcBY19uYU
         Ih1g==
X-Forwarded-Encrypted: i=1; AJvYcCXJ51TiQhMUmVmEowWN+XK/eHOS8WNvzEGiDOYLY2wULzXc6vYRz3s8L07lqTZTYGXMPbtZH4xW4sbI00A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsCkMx4zXtE96yCyoTOJp/IGPaZWurCdQiIPYFXynw9yasSdL
	yneWuPkYvvtQD7i1ckgslJxLAbLQ0XeNOLTPtx342r7Ol1iLixcQvX7cKCao4GqPbT2tQ1tGj11
	tnmU9mcDo/0FnBxaWSFHPNAHM4098jxObMvzYgnfd8ACQLhU1hHaY/e3MY8WA4pkkcqzi9Tgs8n
	BZ9gWH6XtZTt5v2h1Wh/Awr0ZuL7OJi10yu8aioaSIU/ktnOxqejN+
X-Received: by 2002:a05:6870:5594:b0:288:a38c:fe7d with SMTP id 586e51a60fabf-28cebca3e9cmr6011972fac.23.1730047368465;
        Sun, 27 Oct 2024 09:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8LODRPd0idGnzbKdllZFk/ttfTmPCD9buQd7jAmTx/s6fTmJFsFUDMR1akME6dNXxir/YbJmHArbZwwf8dHU=
X-Received: by 2002:a05:6870:5594:b0:288:a38c:fe7d with SMTP id
 586e51a60fabf-28cebca3e9cmr6011940fac.23.1730047368186; Sun, 27 Oct 2024
 09:42:48 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Oct 2024 09:42:47 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241027144448.1813611-6-guodong@riscstar.com>
References: <20241027144448.1813611-1-guodong@riscstar.com> <20241027144448.1813611-6-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 27 Oct 2024 09:42:47 -0700
Message-ID: <CAJM55Z8fgPLEn=XqfV-5mVBeqpbr-S+4N=vjivofXJY36AajuA@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] riscv: dts: starfive: add DeepComputing FML13V01
 board device tree
To: Guodong Xu <guodong@riscstar.com>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, rafal@milecki.pl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Michael Zhu <michael.zhu@starfivetech.com>, 
	Drew Fustini <drew@beagleboard.org>, Alexandru Stan <ams@frame.work>, Daniel Schaefer <dhs@frame.work>, 
	Sandie Cao <sandie.cao@deepcomputing.io>, Yuning Liang <yuning.liang@deepcomputing.io>, 
	Huiming Qiu <huiming.qiu@deepcomputing.io>, Alex Elder <elder@riscstar.com>, linux@frame.work, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Guodong Xu wrote:
> From: Sandie Cao <sandie.cao@deepcomputing.io>
>
> The FML13V01 board from DeepComputing incorporates a StarFive JH7110 SoC.
> It is a mainboard designed for the Framework Laptop 13 Chassis, which has
> (Framework) SKU FRANHQ0001.
>
> The FML13V01 board features:
> - StarFive JH7110 SoC
> - LPDDR4 8GB
> - eMMC 32GB or 128GB
> - QSPI Flash
> - MicroSD Slot
> - PCIe-based Wi-Fi
> - 4 USB-C Ports
>  - Port 1: PD 3.0 (60W Max), USB 3.2 Gen 1, DP 1.4 (4K@30Hz/2.5K@60Hz)
>  - Port 2: PD 3.0 (60W Max), USB 3.2 Gen 1
>  - Port 3 & 4: USB 3.2 Gen 1
>
> Create the DTS file for the DeepComputing FML13V01 board. Based on
> 'jh7110-common.dtsi', usb0 is enabled and is set to operate as a "host".
>
> Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
> [elder@riscstar.com: revised the description, updated some nodes]
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

Thanks! Will you be adding more stuff later like fx. the I2S sound chip?

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
> v6: Dropped all node status disabled code
>     Enabled usb0 and set its operation mode to "host"
> v5: No change
> v4: Changed model string to "DeepComputing FML13V01"
>     Changed dts filename and Makefile accordingly to reflect the change
>     Updated device nodes status, and verified functional
>     Revised the commit message
> v3: Updated the commit message
> v2: Changed the model and copmatible strings
>     Updated the commit message with board features
>
>  arch/riscv/boot/dts/starfive/Makefile           |  1 +
>  .../starfive/jh7110-deepcomputing-fml13v01.dts  | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
>
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index 7a163a7d6ba3..b3bb12f78e7d 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -8,6 +8,7 @@ DTC_FLAGS_jh7110-starfive-visionfive-2-v1.3b := -@
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-beaglev-starlight.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
>
> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-deepcomputing-fml13v01.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> new file mode 100644
> index 000000000000..30b0715196b6
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 DeepComputing (HK) Limited
> + */
> +
> +/dts-v1/;
> +#include "jh7110-common.dtsi"
> +
> +/ {
> +	model = "DeepComputing FML13V01";
> +	compatible = "deepcomputing,fml13v01", "starfive,jh7110";
> +};
> +
> +&usb0 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> --
> 2.34.1
>

