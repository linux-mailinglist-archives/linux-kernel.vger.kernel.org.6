Return-Path: <linux-kernel+bounces-192622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDDB8D1FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4471C22F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C151171E5F;
	Tue, 28 May 2024 15:10:03 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FBA16D9B2;
	Tue, 28 May 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909002; cv=none; b=rfkYHWmx+O3h8BDxEKjY5Fk1MxV/yQHxUi22D/l6xA3loYe2v2UQycDca4PqV3nNrQP8WY2Wz9tUr986BOO5q5vjrHRPcEovgtGpp2roM+/Sve1Pip3rBvNAXPxyUmPMoCzLGIxxaN1h+pqS9xc0DXJ79az5T5Hnh4mrFl3mlQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909002; c=relaxed/simple;
	bh=a8VvpnZYaXvaNeR8ycoNHw+5qH0GmgRt/FvoeqWD9TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6aXmHSGGmcuXSz0SOot/Ny10x6yWn8ZaJLVAbfwp9AAWoDKDL3exLjEwVtNFjwdFxj+OzU+XAzjGaHkSjg+t5EgPtSTVPr+NgFQuvVxUedblg5fEIhKWUTpIEDw6JOk97kC8uWAcSNwc+MFbg2lPeWcqQSDdIwNzGDbk20XjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sBySJ-0004pm-E9; Tue, 28 May 2024 17:09:39 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Alex Bee <knaerzche@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sandy Huang <hjc@rock-chips.com>,
	David Airlie <airlied@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/7] Add DSI support for RK3128
Date: Tue, 28 May 2024 17:09:23 +0200
Message-Id: <171690893341.1899981.5685030462624644928.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509140653.168591-1-knaerzche@gmail.com>
References: <20240509140653.168591-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 9 May 2024 16:06:46 +0200, Alex Bee wrote:
> This series aims to add support for the DesignWare MIPI DSI controller and
> the Innoslicon D-PHY found in RK3128 SoCs. The code additions are rather
> tiny: It only need some code in the Rockchip dw-mipi-dsi glue layer for
> this SoC and do some changes in the SoC's clock driver. Support for the phy
> was already added when the Innosilicon D-PHY driver was initially
> submitted. I tested it with a 800x1280 DSI panel where all 4 lanes that are
> supported are used.
> 
> [...]

Applied, thanks!

[2/7] dt-bindings: clock: rk3128: Add PCLK_MIPIPHY
      commit: 14a1d1dc35d346a1523f38f6517c349dfa447a58
[3/7] clk: rockchip: rk3128: Export PCLK_MIPIPHY
      commit: 577c04fbf255f81f26507a7ffb2477fce50c214d
[4/7] clk: rockchip: rk3128: Add hclk_vio_h2p to critical clocks
      commit: e745698209837a952d4515bc02cddd5a31a644b9
[6/7] ARM: dts: rockchip: Add D-PHY for RK3128
      commit: 45b22b83e00b1ec36d5de53b797cd9d8545a0d34
[7/7] ARM: dts: rockchip: Add DSI for RK3128
      commit: 73fc389129dfe22b5706b4b6cbc1a4f86d1fbc1b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

