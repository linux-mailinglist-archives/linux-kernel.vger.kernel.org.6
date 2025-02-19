Return-Path: <linux-kernel+bounces-521445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E81FA3BD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3C81662F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DF71DB546;
	Wed, 19 Feb 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="fzeE/D70"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A4286291;
	Wed, 19 Feb 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965804; cv=none; b=F1owMONCx64+ugY/nI1H14kkgrdBJEG5V9alQe6jIXBrSkPiYdWKI3CoBcGmJ7G8oNhPJLFzJ7xt2L+HrUIeP7kNQwV6QPhEHUNRjEMguybm5ERZ9s4VZYxS5i7BwjdE8rYmomK7p7lC9Lqd3jlpY4VSFjGpIDKF+EO5YpvgpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965804; c=relaxed/simple;
	bh=zjCya3UkJ9nS19n6CQZQ4XIk6JtOv4d5YcFjY5uiVJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qJ3vVIM4Is2fnFAJzTc8Zq0Y3OXq/Gd/X9EzseA9proO0QFJAVMGR5Wy/Qj2PLeQm4nPCtBwY6Re1BN4/cN/mQJ5gq/MRJmNQDvaftqFi2ZD83fXJ+kFlCHC0DEPEgBsSn3HEOzJ74JxT1f7mewxnqBJ7qJK7cX0dDB3f9s3md8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=fzeE/D70; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62E6F10382F0F;
	Wed, 19 Feb 2025 12:49:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1739965798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DmE/AqNS2uy0QlORQ3XZZ++nuTd4ykAVXTbN7NVTIZw=;
	b=fzeE/D709YCLzOyof5x37NCe3HjjsvRoAPnhyqoAq6puzHn6jaKnAI/7HCLN2Adv+KWYIb
	qhykKL6tAFpc1IMieFJdTjtC0JW2IilHAuMXh9xLswuoiy6upsgIEKi//pwtr4LiM+jPdH
	iPjOuUmvVCIspveJlusVDxzmPRpz6Pqp0MltAil+j8Xfsp2kcNHa/cgIocHKK0Geo8lZoq
	o77vXhzqOARwQ4cLIKUiKOyPMJYYdF9C0i9At/CpKxwUj83S+gjiOORwvdSN1v8d9lv57b
	axXiLkxQ20q0vu5pV/MFlZw61ns9tLefp/zAqzuxxm6M69h6hd0/GpmcJnZmPA==
From: Lukasz Majewski <lukma@denx.de>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] arm: clk: Add ETH switch clock description for vf610 SoC
Date: Wed, 19 Feb 2025 12:49:36 +0100
Message-Id: <20250219114936.3546530-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The NXP's vf610 soc is equipped with L2 switch IP block from More
Than IP (MTIP) vendor.

It requires special clock (VF610_CLK_ESW) to be operational.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/clk/imx/clk-vf610.c             | 1 +
 include/dt-bindings/clock/vf610-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 9e11f1c7c397..405bf48a1d28 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -309,6 +309,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_ENET_TS] = imx_clk_gate("enet_ts", "enet_ts_sel", CCM_CSCDR1, 23);
 	clk[VF610_CLK_ENET0] = imx_clk_gate2("enet0", "ipg_bus", CCM_CCGR9, CCM_CCGRx_CGn(0));
 	clk[VF610_CLK_ENET1] = imx_clk_gate2("enet1", "ipg_bus", CCM_CCGR9, CCM_CCGRx_CGn(1));
+	clk[VF610_CLK_ESW] = imx_clk_gate2("esw", "ipg_bus", CCM_CCGR10, CCM_CCGRx_CGn(8));
 
 	clk[VF610_CLK_PIT] = imx_clk_gate2("pit", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(7));
 
diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index 373644e46747..95446f1bee16 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -197,6 +197,7 @@
 #define VF610_CLK_TCON1			188
 #define VF610_CLK_CAAM			189
 #define VF610_CLK_CRC			190
-#define VF610_CLK_END			191
+#define VF610_CLK_ESW			191
+#define VF610_CLK_END			192
 
 #endif /* __DT_BINDINGS_CLOCK_VF610_H */
-- 
2.40.1


