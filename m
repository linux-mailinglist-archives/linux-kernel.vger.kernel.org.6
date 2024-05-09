Return-Path: <linux-kernel+bounces-174498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0831A8C0F9D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68452817ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2490514D2B2;
	Thu,  9 May 2024 12:22:31 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0714BF8F;
	Thu,  9 May 2024 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257350; cv=none; b=OcuU3klH5F9p4t6U4A0osrzokED6gAHwL6VSe4T+Ho/GbvIzvgJH+NaFT6j5fWWjIkZdvdbeZRm804F2ZXbcNLvXeKVJJvGoYtLECBTQWTMkAETtpIbrh7QVUUIEB9Br75Ec+q6JooYEXy79k6u65kJenlI/Mi79C85J+OHU8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257350; c=relaxed/simple;
	bh=uDM27zrD39kvvURwdlNFw/NK0u0FOAXSDBMaCJTa3lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EK0qZ85UBgGcNtxamB+ni5DJ0XJgf8dL5XcfZ0CXfdSTLduBNbDwSeWEXcIcbcIFVCkhjn6+YgoMsJulCWmp3TX01pb3EATHFwGlCgFKV9tokXuRp2SG8nofjO2uwKxVvtHnbsPe91zbQkiGtnllgAG043PWmSheJT5sGrfmC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s52mU-0007xX-8U; Thu, 09 May 2024 14:21:50 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Alex Bee <knaerzche@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Alex Bee <knaerzche@gmail.com>, sebastian.reichel@collabora.com
Subject: Re: [PATCH v2 0/7] Add DSI support for RK3128
Date: Thu, 09 May 2024 14:21:47 +0200
Message-ID: <38423821.XM6RcZxFsP@diego>
In-Reply-To: <20240509120715.86694-1-knaerzche@gmail.com>
References: <20240509120715.86694-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Alex,

Am Donnerstag, 9. Mai 2024, 14:07:08 CEST schrieb Alex Bee:
> This series aims to add support for the DesignWare MIPI DSI controller and
> the Innoslicon D-PHY found in RK3128 SoCs. The code additions are rather
> tiny: It only need some code in the Rockchip dw-mipi-dsi glue layer for
> this SoC, add support for an additional clock and do some changes in the
> SoC's clock driver. Support for the phy was already added when the
> Innosilicon D-PHY driver was initially submitted. I tested it with a
> 800x1280 DSI panel where all 4 lanes that are supported are used.
> 
> changes in v2:
>   To improve power-efficiency when the DSI controller is not in use, I
>   dropped the patch which made hclk_vio_h2p a critical clock and instead
>   added support for an AHB clock to the DSI controller driver and updated
>   the bindings and the addition to the SoC DT accordingly.

The naming already suggests that hclk_vio_h2p is not a clock-part of
the actual dsi controller, but more an internal thing inside the clock
controller.

At least naming and perceived functionality would suggest a chain of
	hclk_vio -> hclk_vio_h2p -> pclk_mipi

In any case, I really don't see hclk_vio_h2p to be in the realm of the
actual DSI controller, but more a part of clock-controller / interconnect.
Similar to the NIU clocks for the interconnect.

rk3588 actually tries to implement this already and while the
gate-link clocks are described as "recent", I think this definitly the same
concept used a most/all older Rockchip SoCs, just nobody cared about that
till now ;-) [0] .

So TL;DR I'd really prefer to not leak CRU-details into the DSI controller.


Heiko

[0] Which reminds me that I should look at Sebastian's make GATE-LINK
actually-work-patch.





