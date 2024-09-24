Return-Path: <linux-kernel+bounces-336944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D839842ED
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FEA1F23CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F45158DD9;
	Tue, 24 Sep 2024 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="BJAjnir0"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FDC156871
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172247; cv=none; b=Oo9y+v4JEzmYbjpYDgfdV2pbtrIC2CN5eiBSutnLWX4WuMCR7Qh3+ycS0QIyGkTSL8EY9/v4KBUv77SPTuc7iJZ5LK2orQ5y4DX/52tfmKdlPvcSIhAxJIGHImjXiDuCkBNPXfJT3xyD2SLHq4sLH37M2P5Lh4aT4nBIKHbszGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172247; c=relaxed/simple;
	bh=2845401r35f9abnXfJ8yUfXYEom6IHe6nAAH2z77qPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gekrF8ieaf/9Z21gNdrdGunHLkkXw8Afp5+I3wxomZ+VdGR5QuodZu2ogYncZE8r4ZI5Z7K3sxNrNpPcEZ/yMFNFM/R0U7SNoLvN6862MKyaCssRybReYex4JwhFE4XaKJ3KkNs+8y08T3xHXtFW2l7VXFQq+k+4Sn9/f4xBgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=BJAjnir0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9PhYPLjVwe/Ok8R5xESci9lBy2EalpZUO9Ew79WKLdI=; b=BJAjnir01Q8EwBe47wbTlEjWse
	izG8PIe1WvVNw+uu7j6TOBEweoTJXKNCFc/aF7g9QqmQ+YgX9sv9fDwn3LAmJnC34q22gAvk7VmEz
	DIpy2ErB4mUsIjp+ddkPnVZZu9A+x2LeR1UJgCdYdixMoENeAMeV4zi5vPrjuzKvftOY7uWLyV1LH
	PEagDY6nf4rb4nXvEPPssndeDk1Um9rGarZwbQnbJdZPDgb18oWJ7LPYbJgRURzmbt4sIalHIVFKz
	DctLLmRYir6Ep9RBqmGn4XBoI1CLTN+Aw91lINwiuR+LxBC4EE2f2wFPrZ136Z9wW/o7gMPMIV2Z8
	gKvRqSXg==;
Received: from 90-177-212-167.rck.o2.cz ([90.177.212.167] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1st2Oj-0000yj-Qg; Tue, 24 Sep 2024 12:03:57 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject:
 Re: [PATCH] phy: phy-rockchip-samsung-hdptx: Depend on CONFIG_COMMON_CLK
Date: Tue, 24 Sep 2024 12:03:56 +0200
Message-ID: <2000463.jZfb76A358@phil>
In-Reply-To: <20240923-sam-hdptx-link-fix-v1-1-8d10d7456305@collabora.com>
References: <20240923-sam-hdptx-link-fix-v1-1-8d10d7456305@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 23. September 2024, 18:40:16 CEST schrieb Cristian Ciocaltea:
> Ensure CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX depends on CONFIG_COMMON_CLK to
> fix the following link errors when compile testing some random kernel
> configurations:
> 
>   m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.o: in function `rk_hdptx_phy_clk_register':
>   drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1031:(.text+0x470): undefined reference to `__clk_get_name'
>   m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1036:(.text+0x4ba): undefined reference to `devm_clk_hw_register'
>   m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1040:(.text+0x4d2): undefined reference to `of_clk_hw_simple_get'
>   m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1040:(.text+0x4da): undefined reference to `devm_of_clk_add_hw_provider'
> 
> Fixes: c4b09c562086 ("phy: phy-rockchip-samsung-hdptx: Add clock provider support")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409180305.53PXymZn-lkp@intel.com/
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



