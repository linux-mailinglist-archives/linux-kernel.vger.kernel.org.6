Return-Path: <linux-kernel+bounces-221905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FBB90FA5B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B996DB21446
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDF96116;
	Thu, 20 Jun 2024 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mOFf1myb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442815A8;
	Thu, 20 Jun 2024 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843909; cv=none; b=Ue5OusdAHUym2hQe/dV/epI2aqX4r9YWs5+hEgsX4qWPNSv5oj3KQ6B831KDpv8nJ0Jx/L4Bf2NIlR5amnn2iB8GMzlou31xV7hbbcQ3J1f1dbTrjqkZQm/tZrOF86gNieo3XOzPVn9AAIbwUNFYKJ2oTyDQPIxbjrZHnhTQzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843909; c=relaxed/simple;
	bh=nH8hDgwrgvwMrmw5KJxAlXFHpeaiw/NSzLl5T+P+KN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1hnudJSFyGmYDOJvCoVr/xPp7EyA9QsNHjjRMIYlMglBkfw9F+ETND/AoGPtKPSf8gvE2Wrq5bXViSLe9HtREb7vsFkVEcBao/J/h/SyvWKNNQQ6ATCmpNIv+Y6YkK+Qn3V12TB0FiZSlhNtk3qWef6CX1aRRmi1h1QLYGuw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mOFf1myb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718843906;
	bh=nH8hDgwrgvwMrmw5KJxAlXFHpeaiw/NSzLl5T+P+KN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mOFf1mybJae9J2R1t/gwEZuTbbh0Vk1+OX1xvomk8PW/LisTxR+tsVbglQoG41obx
	 zVkShSAQ3mZJS19g39gnNH+Jvk6kkY2B9bYWTVuYGgEtaUr9R4Exk1q9HQe0myIY08
	 SwFzUBifltbFgVGsWA84HN1N9MWEtmi0oitc+szafT8QmKDGTwGrplcArUt/7CkxG5
	 2m7ztoXTVFJ2TXwvu3Qypi1gg/Z1GrF1vGu+TOE/Lxd8wUZDXwzHZZtGisCXR5tuRg
	 hFX9M07JjRFfEE35Ai7i+S11iWXVewgkvImQGbu2KWg5TpKdA1155dvvsAIGr0F3mt
	 ETdNEn+0RHiyA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 37FE037821A5;
	Thu, 20 Jun 2024 00:38:26 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 20 Jun 2024 03:36:22 +0300
Subject: [PATCH v2 1/4] phy: phy-rockchip-samsung-hdptx: Explicitly include
 pm_runtime.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-rk3588-hdmiphy-clkprov-v2-1-6a2d2164e508@collabora.com>
References: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
In-Reply-To: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

Driver makes use of helpers from pm_runtime.h, but relies on the header
file being implicitly included.

Explicitly pull the header in to avoid potential build failures in some
configurations.

Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 946c01210ac8..3bd9b62b23dc 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -15,6 +15,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/rational.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>

-- 
2.45.2


