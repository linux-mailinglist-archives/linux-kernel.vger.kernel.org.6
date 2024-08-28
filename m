Return-Path: <linux-kernel+bounces-304760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 011CA96247F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316C81C21413
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484016BE1A;
	Wed, 28 Aug 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Sda/R7lY"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091916088F;
	Wed, 28 Aug 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840120; cv=none; b=WFau2apwMINITRZ6d5l9tjiyNCRnl1rSAxeP/TFYhsmqld7Np2dm93oxbzGPO/v54C5FnE1GybDUVslkk6TJMFFrpnkCS/wV3ONNB8CATbprmM1281v6TzdNspTtYUEeS6gcuFTqksnKXtL9WtfLHNsaSPA1cxDHeOessySowP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840120; c=relaxed/simple;
	bh=AwXwh1UNbR3eQevspYeClzrrvljxerz85aLWs2NpFp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sqng2SRlhVxfLWAhE23OBVrbUugPciNSlBE5BDT91GebIKRiW6c9uZnBLJUGVBlWo7kr935wOG6ZTy/NIE1vpGcenaBsl3OaUwXgKFsCRwOmA7g6zLOHFlAthxlD5cz091fF9zkPH4k3Gq0mnR2ofaIKkVmrrvRcpftbpndLyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Sda/R7lY; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=URObYksO4gN+9lzuCPAOWuGaNp4UNR2zdQZmZnnacwI=; b=Sda/R7lYsoCJLuDum6wi0TU5bE
	CxN9bn5NOJ3MADFrG4eMp2UGcz3N6Y7nYLYOC7PjiV69uJGXswRg958TqFzb741ocfGzOYegXbOS1
	G3ekmUTAhq+dMQZ+AqfQwVqETHflTGPOh0uIqvvhwkEBHW0NVS7//iuuAoaOsHYMGc53NCWwpdPyb
	IXLTOrh4y9q9ryhCFScLBCarILEcvHlmkxl0EzMqSMKBramZJd3G1/fohQDamcJU2XvvQmCSR6D6u
	5N0JI4Mt0+9CY/X9qz+CqgwiaqnD5C0yeVBiND4ZrUDyg7QEPSXSwZaVLh9nUHyRfN2HF3FvsoHYM
	H2Tte17Q==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjFhs-0004M3-Oa; Wed, 28 Aug 2024 12:15:16 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v3 2/5] clk: clk-gpio: update documentation for gpio-gate clock
Date: Wed, 28 Aug 2024 12:15:00 +0200
Message-ID: <20240828101503.1478491-3-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828101503.1478491-1-heiko@sntech.de>
References: <20240828101503.1478491-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main documentation block seems to be from a time before the driver
handled sleeping and non-sleeping gpios and which that change it seems
updating the doc was overlooked. So do that now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk-gpio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 5b114043771d..98415782f9a2 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -22,8 +22,9 @@
  * DOC: basic gpio gated clock which can be enabled and disabled
  *      with gpio output
  * Traits of this clock:
- * prepare - clk_(un)prepare only ensures parent is (un)prepared
- * enable - clk_enable and clk_disable are functional & control gpio
+ * prepare - clk_(un)prepare are functional and control a gpio that can sleep
+ * enable - clk_enable and clk_disable are functional & control
+ *          non-sleeping gpio
  * rate - inherits rate from parent.  No clk_set_rate support
  * parent - fixed parent.  No clk_set_parent support
  */
-- 
2.43.0


