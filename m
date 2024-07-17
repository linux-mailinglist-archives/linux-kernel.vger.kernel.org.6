Return-Path: <linux-kernel+bounces-254766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC493375F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64791C229DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82EB179A3;
	Wed, 17 Jul 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="GWpXxs5q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZZVpa7q6"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC114F98;
	Wed, 17 Jul 2024 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199062; cv=none; b=aIyPpDrVc/05ar+S7zafoombtQDTIVL3wQDQ4+SdF2H4MOMAmndQkoIXXWa3l0AvM43/dUrY2tlsVRyZavBIngyXhx9pfFu5jLWaVFTz4xFeIo0cEG8g0RorfS7yCgPvNGEMGO7/XcurBsVSOjSSb4Kg5TZzHGdHaqna9s/ayow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199062; c=relaxed/simple;
	bh=dpOBx/JaJzJ9k+pu39P9pH1jVrhVAxMSt45ni74svac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qdjYtOtefkU02qT9fmkUpDgputDmBvCmIWNklgnIFvD+GRn8t/BGgpItQ5ggvcrT+DjRQ8P3n3hVOlU0tqfTVXXRT8s2AUvCuMd7SsUGCn8JfihINu/3ebks2MS2ItAzUhIboB4fjEO/44ElPl2iJAYIppjyqgZXhEC0+TG26qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=GWpXxs5q; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZZVpa7q6 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721199059; x=1752735059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rjcdWGSUL4wzFk1sXQX07yknR07Yxl1IIBPaDUB1jgg=;
  b=GWpXxs5qMnLf+5RPIgP0hHsLsqGrkMtuW5vepe/WDTBKezxpBXb2rUXo
   MWpxC8juJwmkVllcbfp+a/AtRJ9xTTEpEkOUz7QDFr0LLzZOb+WYP5nTw
   QwhTaecORfgrHy05kNwENKKSleB12WVH85F10GC41jq6KBG1fYGXbdlj5
   B9btekNpT7YrtlpTBEH0/pJ1BfilFQyOMTaQp/OVREYqIQCgCZIHPRUbg
   uT1Syubd9wEE4nKNJgPPd59F0gNsHUSlohIY2mWbNHi81aXsqVAltTenB
   3bRSWrupvaIiKcFfxSbTjWVysNN9I58MAV1Kww8I8SFzGJe2freYlBt1y
   Q==;
X-CSE-ConnectionGUID: WopxBByAQ9Gi02fl3Kjx+g==
X-CSE-MsgGUID: krEEA6B9TFG9TJrXiKBFiw==
X-IronPort-AV: E=Sophos;i="6.09,213,1716242400"; 
   d="scan'208";a="37942401"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jul 2024 08:49:46 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 362DB165A43;
	Wed, 17 Jul 2024 08:49:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721198986; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=rjcdWGSUL4wzFk1sXQX07yknR07Yxl1IIBPaDUB1jgg=;
	b=ZZVpa7q6uWratn3eaxrUbIJ+oQHqBUdSGlECKTHD5d+kEllZF8HYFGpo0pC5qwK+9W8pNJ
	mvGN+No1v9yCSfvyGDh1DadJxXCijrHqiyGFhnNdd9PiYq66HbI+g8ctKjoYVhrXY5xtXV
	7yCNMZM+iVrJhcgQvUeK6zj8K6ABbExbkBoVQihui5YXfJQevqVQv7Jj7z/r1f+MdC2+jL
	WMx5Bq5F2YxxGl71HAEMz9dEZdYeBE30dQfIq1oX4C6P2381ECo5U796vEXIzVHfq0aQiU
	wCstvKVbSGaHYEVyr/3ys7PP9L5nyjGHt+BMijIUTSSPi9LvDtan8yX578Qfpw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: mba8mx: Add Ethernet PHY IRQ support
Date: Wed, 17 Jul 2024 08:49:15 +0200
Message-Id: <20240717064916.1670702-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The interrupt pin of the PHY is connected to the GPIO expander, configure
it accordingly.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/mba8mx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
index 7b221f43d761e..1ab5cddac0659 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -204,6 +204,8 @@ ethphy0: ethernet-phy@e {
 			reset-gpios = <&expander2 7 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <500000>;
 			reset-deassert-us = <500>;
+			interrupt-parent = <&expander2>;
+			interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
 
 			leds {
 				#address-cells = <1>;
-- 
2.34.1


