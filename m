Return-Path: <linux-kernel+bounces-192071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF408D1804
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465B31C24BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6F16ABC6;
	Tue, 28 May 2024 10:03:35 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E451021;
	Tue, 28 May 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890615; cv=none; b=PZQaoKfJtgdP2cQOl0oGuS65cmvLH4W/uF/zMgq1/0+WeVxxqjTC9nX4RtQ+Uvp/ryOPeYRj34fpg5ImtRBhNBBvfEaIX1vbYp1AZc30TBKhRgtMoDr3ojrNJ6T7zjB9/179G6Dh3fmbwE4pzU8rGTLdNtXyAvVFLAA9CJnSQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890615; c=relaxed/simple;
	bh=M0PLhgQcE1I1ycRccQEwm+xQfTN8vUyb9CgngkuTgbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoeZlGCr0IAbK0XbO2duZMRKiOSayqzdhnmuzmldbenAg9vMjAtoNJ49Tm2vW3NRPRbg9psQxrzGLE6u6sFTSr1uYof3vHGShBeLxdOhlL0iY1nishPEBxW7OzOKER2qa4+kTJb6+f1TUFmRlQrnU8b3jmaaSlX86sSy64JCIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193d.versanet.de ([94.134.25.61] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sBtff-0002JN-4z; Tue, 28 May 2024 12:03:07 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Alex Bee <knaerzche@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/7] Add DSI support for RK3128
Date: Tue, 28 May 2024 12:03:05 +0200
Message-Id: <171689056747.1839363.13897096799987854374.b4-ty@sntech.de>
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

[1/7] dt-bindings: display: rockchip,dw-mipi-dsi: Document RK3128 DSI
      commit: 9bb3d9ad3e19f16efc34f427a58e480424c56a16
[5/7] drm/rockchip: dsi: Add support for RK3128
      commit: 62545c719e26ec9f62efab7e9582deb73265b6d0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

