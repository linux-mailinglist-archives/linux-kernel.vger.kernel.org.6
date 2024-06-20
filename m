Return-Path: <linux-kernel+bounces-221904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 296CF90FA5A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2034A1C214AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76334685;
	Thu, 20 Jun 2024 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o28fS7ly"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324E80B;
	Thu, 20 Jun 2024 00:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843909; cv=none; b=PYtQfJiIrxTZSw62gTBOlHaHMJrW2B8ahtjjj0XtLjvlWY0ZtU0pZP/ZNgbuluBO6OvtUT4vbyfFGnBaPKnwmBA3h2ND6XTsE7gxpr/sJZo4nzL2LnrCjzZXrbJ61z8u/93FWoZoxl63JL2+PNYjwU6PyHVVpfmeqby/ng7a/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843909; c=relaxed/simple;
	bh=XBeQpQicvg4Jsf0WSxNo6Kv6I1S/keBVke9aDXkWPLA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KrMEQSXFb2+DyGeOMTf7KTmsjiVDKHnVceBDhg+raxvIIeYttlYEdDBSKRen3eXPEW+JQI879JeqJ6C2UUNkDYWtKwWNVYoW/cTRu5EVSOBfh00EGKuAnZ14ON5Lvapzvxdr4tjUIyi2bGDXg2/0zLBw7WWhfErCk3d32cF7s9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o28fS7ly; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718843905;
	bh=XBeQpQicvg4Jsf0WSxNo6Kv6I1S/keBVke9aDXkWPLA=;
	h=From:Subject:Date:To:Cc:From;
	b=o28fS7lyeKjsKNAA6x176aEAoQEBaIbezxlFHnC33+ndHsCFfQoGU2LMqcO9jHlyt
	 LtrFXsFe4fBwHJZBLjsU6LSbSYFnTArWsjvmnfMwIcpOs/Y8RkwxeAza5CABsasWaa
	 NKBdv39+PNtYIdTSm1i0/drMqyLYwQPKJ0z17ypKmnACR3Tn4Mr89AfR5Z75xbEn6X
	 3nYM6gk4Cv917yMpoi/nje7gfahcJlLx3jHJyOFfzgryyOZKuc3fjXrortnCKs+rr1
	 Xxs8AHlkk+pQPbs/ZzgAmw1JqWkCoyBk+A+Slv8j+AC+K6C9+o79APq0GqOhbmDofs
	 xmKekASuLUGqQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E8537378107D;
	Thu, 20 Jun 2024 00:38:24 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/4] Add clock provider support to Rockchip RK3588 HDMI
 TX PHY
Date: Thu, 20 Jun 2024 03:36:21 +0300
Message-Id: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIV5c2YC/3WNywrCMBBFf0Vm7UgS+4iu/A/pIqZTE/pImUiwl
 P67seDS5Tlwz10hEnuKcD2swJR89GHKoI4HsM5MT0LfZgYlVCEqWSP351JrdO3oZ7egHfqZQ8J
 OlJ2sSmOFukAez0ydf+/he5PZ+fgKvOw/SX7tL6n/JZNEgVpQYYxUsq7pZsMwmEdgc7JhhGbbt
 g8uv1qZwAAAAA==
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0

The HDMI PHY PLL can be used as an alternative clock source to RK3588
SoC CRU. Since it provides more accurate clock rates, it can be used by
VOP2 to improve display modes handling, such as supporting non-integer
refresh rates.

The first two patches in the series provide a couple of fixes and
improvements to the existing HDPTX PHY driver, while the next two add
the necessary changes to support the clock provider functionality.

To: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
To: Algea Cao <algea.cao@rock-chips.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com
Cc: linux-phy@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

--- Changes in v2:
- Collected Reviewed-by tag from Heiko on PATCH 1 & 2, and Acked-by from
  Krzysztof on PATCH 3
- Updated PATCH 4 to make use of a forced consumer put in
  rk_hdptx_phy_power_on() and rk_hdptx_phy_clk_unprepare()
- Link to v1: https://lore.kernel.org/r/20240618-rk3588-hdmiphy-clkprov-v1-0-80e4aa12177e@collabora.com

---
Cristian Ciocaltea (4):
      phy: phy-rockchip-samsung-hdptx: Explicitly include pm_runtime.h
      phy: phy-rockchip-samsung-hdptx: Enable runtime PM at PHY core level
      dt-bindings: phy: rockchip,rk3588-hdptx-phy: Add #clock-cells
      phy: phy-rockchip-samsung-hdptx: Add clock provider support

 .../bindings/phy/rockchip,rk3588-hdptx-phy.yaml    |   3 +
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c  | 206 +++++++++++++++++----
 2 files changed, 176 insertions(+), 33 deletions(-)
---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240617-rk3588-hdmiphy-clkprov-f05f165ac029


