Return-Path: <linux-kernel+bounces-376793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DD39AB5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F661F23CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6E11BD515;
	Tue, 22 Oct 2024 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SysRyeaE"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FD1B654C;
	Tue, 22 Oct 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621122; cv=none; b=Di+7an2qJbW3Nj3bc4PGgHxyLJ0ZcUMH5+KHIjNlKOPhQeIrFwfOBfJ9//fIix0PlHkj9enj+WaR29dovBTXvJhlDf87K/hTWitQGR/Gdz0Y0KK50zs/cPhgqa73xm3ugt1OZBM0uwQTx3I4eppExLyCOh7MgoyWofcfqL7smUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621122; c=relaxed/simple;
	bh=0+D36PD0oyWEGdZT46EpzFiJXC/Bkh6tdCG+WE7z8AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lplsj7NMfbi1zEkVSraOZOFCqAVaSfY367wGpGnAGQDubGScRGnVGt182JF+R3jlXe3g0oCU95/pMUMKePpy7S4E+EYdbxfJ9FHJEMA4c0BZ+dx8QPcxi7/Uze1l1oTgm8wnVq6IMP1Qui2w2MnQFTlMkNw+CvutunXYiO4HOdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SysRyeaE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so80325a91.0;
        Tue, 22 Oct 2024 11:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729621120; x=1730225920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+D36PD0oyWEGdZT46EpzFiJXC/Bkh6tdCG+WE7z8AQ=;
        b=SysRyeaEXIoKYyJiFegINwy9xpY3fZTe8w09lzgMC11kNAe9II7kg6nNK0YFZQBWVZ
         khUrK8R5PhEVGUbIQfGIkC5RU3r6wVaIcLFoivVpPYqjJ9oyvoEdbxYtWMk6SbFsCLS0
         JjicAX/KJeDfxNO8zvJFRquO3g2Bo1DMnLFCO3i3qwS3IKWtHyUSZ0I0fo+fGyx8RTSo
         UTRMX78d5/xlADJIICg5NE8quwVSXqRj5ksWFZKUzsyoMcXD1VgqdQhyDQvtoSq1Ug5O
         SKf2cKfANrrqcJtXAml+JusmVkvcupJbKMZd3TpNxGAyXk4+BvbFH4/KxlDuLj+xppEN
         Qm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729621120; x=1730225920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+D36PD0oyWEGdZT46EpzFiJXC/Bkh6tdCG+WE7z8AQ=;
        b=e6E1IUm2WaTcwxe6j7Uklqc6uKlgyVKRL8pLbYgtkx18X/jyuI0k56mZj6D0dPDjIE
         ECfuw1Q6wSDihryhbkfZJBX5arj3Fq2uKVgMVxFda1ezfqDM8LlCd68bQNlL4GrJaxJb
         uCtO3zqbV50uLHTyx2pzOwXMw479wWv2Txg7kCThBc9eoo5yoSZP0YTrIUDwZ09KJnyq
         UdcET8ocfGsTks5QzQDtQoWH85Ov9biTv0I3vGikyOPTbydoJMsneHHe6pfS/uoUnIA4
         fKzWXIYW6teDc0szzP0vHG76o1JoRFK38qikuhaNCXhftXeGQYR/IDV9pxyJGEGT10Ji
         djXw==
X-Forwarded-Encrypted: i=1; AJvYcCVgIvZDabyVRluXAl2CyFDaQE41W3yV2anAIjnNoAH9vEzeGfj0nTcNiaaXj+/sLFMWFET0G2xYrzyH@vger.kernel.org, AJvYcCW7fEsEAtEP7GFliyeOOA2CBlIjR9CS1AVNoV1bArcdmjT4RahB3clLERenfCblI/3i1bCwQ7G1ALGjoFsq@vger.kernel.org
X-Gm-Message-State: AOJu0YzpLJeS1ASEo9tqeKbgms0iKNOHhoVX8A8Nvi5lMZKJsRSAdGZp
	1usCkChiK35TjWzcq2qfT3Zns18ldwjUx2iLRyftdx4kIdZ5CR/Z
X-Google-Smtp-Source: AGHT+IGhTfZx7xAaEGS4TbJV+BeWoFKCAVJJE3r+eNHK2Hyv5WlycfLWfAukyPd1alfStOe3GkAHzg==
X-Received: by 2002:a17:90b:108f:b0:2da:6e46:ad48 with SMTP id 98e67ed59e1d1-2e76a6e4830mr60264a91.1.1729621119846;
        Tue, 22 Oct 2024 11:18:39 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2408:8262:245d:4d65:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5e2691e4csm2025468a91.23.2024.10.22.11.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:18:38 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@edgeble.ai>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
Date: Wed, 23 Oct 2024 02:18:29 +0800
Message-ID: <20241022181829.897547-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <c2a4e8a8-9466-41c4-83b3-57210fdf5a5c@kwiboo.se>
References: <c2a4e8a8-9466-41c4-83b3-57210fdf5a5c@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jonas,

On Wed, Oct 23, 2024 at 1:56 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Tianling,
>
> On 2024-10-22 19:38, Tianling Shen wrote:
> > Hi Jonas,
> >
> > On Wed, Oct 23, 2024 at 12:49â€¯AM Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Tianling,
> >>
> >> On 2024-10-20 19:39, Tianling Shen wrote:
> >>> The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
> >>> Ethernet ports designed and developed by FriendlyElec for IoT
> >>> applications.
> >>>
> >>> Specification:
> >>> - Rockchip RK3566
> >>> - 2GB LPDDR4X RAM
> >>> - optional 32GB eMMC module
> >>> - SD card slot
> >>> - 2x 1000 Base-T
> >>> - 3x LEDs (POWER, LAN, WAN)
> >>> - 2x Buttons (Reset, MaskROM)
> >>> - 1x USB 3.0 Port
> >>> - Type-C 5V 2A Power
> >>>
> >>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> >>> ---
> >>> Â arch/arm64/boot/dts/rockchip/Makefile Â  Â  Â  Â  | Â  1 +
> >>> Â .../boot/dts/rockchip/rk3566-nanopi-r3s.dts Â  | 554 ++++++++++++++++++
> >>> Â 2 files changed, 555 insertions(+)
> >>> Â create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> >>> index 8e1025cb5d20..e641033d23d1 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/Makefile
> >>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> >>> @@ -109,6 +109,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-model-a.dtb
> >>> Â dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-box-demo.dtb
> >>> Â dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lckfb-tspi.dtb
> >>> Â dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lubancat-1.dtb
> >>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-nanopi-r3s.dtb
> >>> Â dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
> >>> Â dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
> >>> Â dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
> >>> new file mode 100644
> >>> index 000000000000..951dd9bcb4b0
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
> >>> @@ -0,0 +1,554 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> >>> +/*
> >>> + * Copyright (c) 2020 Rockchip Electronics Co., Ltd.
> >>> + *
> >>> + * Copyright (c) 2024 FriendlyElec Computer Tech. Co., Ltd.
> >>> + * (http://www.friendlyarm.com/
>
> This could probably be updated to use https://www.friendlyelec.com/

Yes!

>
> >>> + *
> >>> + * Copyright (c) 2024 Tianling Shen <cnsztl@gmail.com>
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +#include <dt-bindings/gpio/gpio.h>
> >>> +#include <dt-bindings/input/input.h>
> >>> +#include <dt-bindings/leds/common.h>
> >>> +#include <dt-bindings/pinctrl/rockchip.h>
> >>> +#include <dt-bindings/soc/rockchip,vop2.h>
> >>> +#include "rk3566.dtsi"
> >>> +
> >>> +/ {
> >>> + Â  Â  model = "FriendlyARM NanoPi R3S";
> >>
> >> Please use the marketing name, and the name added in binding:
> >>
> >> Â  Â FriendlyElec NanoPi R3S
> >
> > Sorry for the copy & paste error, will fix it in new patch.
>
> The commit subject could probably also be updated :-)
>
> >
> >>
> >>> + Â  Â  compatible = "friendlyarm,nanopi-r3s", "rockchip,rk3566";
> >>> +
> >>> + Â  Â  aliases {
> >>> + Â  Â  Â  Â  Â  Â  ethernet0 = &gmac1;
> >>> + Â  Â  Â  Â  Â  Â  mmc0 = &sdmmc0;
> >>> + Â  Â  Â  Â  Â  Â  mmc1 = &sdhci;
> >>
> >> This board comes with on-board eMMC this please use mmc0 as alias for
> >> &sdhci; and mmc1 for sd-card.
> >
> > Is using mmc0 for sdhci a common practice for eMMC boards?
> > The eMMC module on R3S is optional and users may get boards without it.
>
> Typically any non-removable storage (emmc) is listed before removable
> storage (sd-card) options. Also U-Boot will try to override and use
> mmc0=sdhci and mmc1=sdmmc0 for all rk356x boards, so for EFI booing
> using control FDT the alias may be different.
>

Thank you for the details! May I have your Suggested-by tag for all
of these fixes?

Thanks,
Tianling.

> Regards,
> Jonas
>
> [snip]

