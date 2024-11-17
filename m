Return-Path: <linux-kernel+bounces-412242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D259D05BE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 21:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2201F21CC9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 20:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A961DCB06;
	Sun, 17 Nov 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="OpytaC9/"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D81DB940;
	Sun, 17 Nov 2024 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731874776; cv=none; b=WDaHHTv9COBqB+v5SoGVqCSbBD1M8zhaDQoyWi9c8IH7dCci3vU06LHSfCGGRlyJXDAzrTWUfUGMIqXnj8e0i6AT5UeXbw5AWgzNRzD7DsI/OVnUc8lfTG1SgsU/9GBwL1WNU9ArgDbZBwE3pkuhj/lkSwmT7VDWjYxgiQ4e+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731874776; c=relaxed/simple;
	bh=EFZo0N2qQ62s4ntH91C7FYfAQMBdVRPeofuX+ra/NWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1L54in+WqVfJrYih3JcmWgeKKCWXcurR+gM5CSRbexjJKltf9KG7wlJ7VUuYbhT8B2gPs9nGuXxAi5/4Ol/hFVDJ/2wTn/CWSZvsAIGc6LMw1SJFJpVUMnjf4C6GsloU/2EcVwj0PiMTcpauFBE1j+3qulu3mgK4VgNKv/Mo5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=OpytaC9/; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TKD78TTgurmM3/4RfGBACsKaxsRBI+9fjLe01mkkrME=; b=OpytaC9/ywsGIyVzBGJXRVIYRH
	NXLuUdVVw4O89u8ByJXKIzZe8T8nJzJ4+UKQN0QrZw2MLtF0Ewh0kNHXIAMu2VOYyZ/UTRECisEAH
	WNsgvtWQuFFPKKGu7seUYYqZrvmPrvtUdRORHiAErTmnoKiNunP9CwRAEPESf4cmXy2G0YOXBEiny
	Vja/8drhuZl92kcPlaSpDMmG3nd3xuJ4J6laBIDnp//p86lc0DlkAj6hi5IsNWrsG70kRCudi54z/
	sAO3xDwc85WJARaYjt9z9O0c1XRFdIty539S9Y317AJAL5KgYqYsMKAKSNgYlwhx69eACy1weNplq
	lohJcl5w==;
Received: from i53875a30.versanet.de ([83.135.90.48] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tCljt-0000cF-JY; Sun, 17 Nov 2024 21:19:21 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add Firefly ROC-RK3576-PC binding
Date: Sun, 17 Nov 2024 21:18:54 +0100
Message-ID: <20241117201855.789945-2-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241117201855.789945-1-heiko@sntech.de>
References: <20241117201855.789945-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding for the ROC-RK3576-PC SBC.

The board is based on the RK3576 SoC (4*Cortex-A72 + 4*Cortex-A53).

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 83139479db5e..ccfdc4c20438 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -211,6 +211,11 @@ properties:
               - firefly,roc-rk3399-pc-plus
           - const: rockchip,rk3399
 
+      - description: Firefly ROC-RK3576-PC
+        items:
+          - const: firefly,roc-rk3576-pc
+          - const: rockchip,rk3576
+
       - description: Firefly Station M2
         items:
           - const: firefly,rk3566-roc-pc
-- 
2.45.2


