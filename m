Return-Path: <linux-kernel+bounces-510880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C13A32321
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC99C165ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2DD2080EA;
	Wed, 12 Feb 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BhHkKrsq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C8208997;
	Wed, 12 Feb 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354644; cv=none; b=LWNwLNvRrjp7F4EAhc8CLRE1V8sV1U5xIECaYD+ke1NfvAXnsOHY3Scqnz8Qh+cz4GhkCnsdk8FXKr7m9xkxCIC8X4CLgfg2mF5Hc3TdZYu9U70Pomo5KH3mUDjYJRR9kerNCyNet4eUhpzwYif++HToykzpmORuWlCJs9aF+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354644; c=relaxed/simple;
	bh=8gwwanPEnjOVfUVp0WRUpBFYyCdDpvG9FjVwyVI7Dbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HOFBdl2/XC3mD9VQwdJN5loY85wjfzdxifYLpRGeLexiA1CJyJaF5/FzXj1Tuc+njBkHOzx47YagQ01eCXeDQTMs+dc+YqcaIaFEDGuQEjiZFqnC5CDDx+U01roTzUXNUvaJy3U+ujRoNO/pxPMq3u3sw+daOaPzETTNvuFf9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BhHkKrsq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739354641;
	bh=8gwwanPEnjOVfUVp0WRUpBFYyCdDpvG9FjVwyVI7Dbw=;
	h=From:To:Cc:Subject:Date:From;
	b=BhHkKrsqnofPKSE2FYG2N2nqv1F2YW6EkyIil2ayb0kLsgbivUjH4opF5/DWWrqoC
	 Mukn0tu4tA2ChsaLHuwNt3gl4NkfmQ9Sk+wUQEt0zSY8b6J+qOrr4WYfzCfFHKxNwm
	 MLnze3dR+VngLb3k1y5qouk+rVBR4BZ71vP01faL6g5Cb71gOVbliRiTe/+J2SpT5D
	 GOUE6sQ/SgEJlkrZir+uqcqAQwW6Qehe912bA9vz9rbhWWzm9tGzm/WqT42HRjm75V
	 KPDwrMpkQni5kSIQr9QRKGiV0lxxbtqpkXtRY/7r+rf8kme7YWGRmFjeUDpNEv0Xr0
	 Tk5NE32PbBmHA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 224EF17E0C9D;
	Wed, 12 Feb 2025 11:04:00 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: mturquette@baylibre.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	u.kleine-koenig@baylibre.com,
	amergnat@baylibre.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	macpaul.lin@mediatek.com,
	pablo.sun@mediatek.com
Subject: [PATCH v2 1/2] dt-bindings: clock: mediatek,mt8188: Add VDO1_DPI1_HDMI clock
Date: Wed, 12 Feb 2025 11:03:41 +0100
Message-ID: <20250212100342.33618-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for the HDMI TX clock found in the VDO1 controller.
While at it, also remove the unused CLK_VDO1_NR_CLK.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/dt-bindings/clock/mediatek,mt8188-clk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/mediatek,mt8188-clk.h b/include/dt-bindings/clock/mediatek,mt8188-clk.h
index bd5cd100b796..0e87f61c90f4 100644
--- a/include/dt-bindings/clock/mediatek,mt8188-clk.h
+++ b/include/dt-bindings/clock/mediatek,mt8188-clk.h
@@ -721,6 +721,6 @@
 #define CLK_VDO1_DPINTF				58
 #define CLK_VDO1_DISP_MONITOR_DPINTF		59
 #define CLK_VDO1_26M_SLOW			60
-#define CLK_VDO1_NR_CLK				61
+#define CLK_VDO1_DPI1_HDMI			61
 
 #endif /* _DT_BINDINGS_CLK_MT8188_H */
-- 
2.48.1


