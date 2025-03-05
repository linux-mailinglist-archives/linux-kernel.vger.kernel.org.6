Return-Path: <linux-kernel+bounces-546897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCB4A50064
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C783B35CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B162124BC16;
	Wed,  5 Mar 2025 13:14:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF824888C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180485; cv=none; b=pBtKOFibZl/gs6NLsTtw/qru4jmYVn8LsMPSoCwvD+Z9HpKgU2N8SW2PiNBvqt8kQrLKs5byKc9KmZn4LcbQWjN4UlCvkMW5dIGIAIvhvwcG9Gs0q5vA7wjZHiTu1Sla1usaOGIe197brt8jrMDyH0/F8j2amcHzHG2GQOicI/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180485; c=relaxed/simple;
	bh=AhX9nTXUHxErnVnwK/u8DTEJuxIo+ugezuNZ0jSV1os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PaZP4rI0PEw1yA2Ut543VHjsWTSwKtEggfEIh7aQAU0+LnpgSZjgXxrf/EVZM22saNIShnPteNb+efrMQU5cxZv57Oel/3d48dPd6PZvqpHnf3r7RDtN/Y+Fwt94UE71E5ManLv08EIe8fNFooabLXOorQNeZlcNfMHOO7pLQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tpoZw-0000xc-A1; Wed, 05 Mar 2025 14:14:28 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpoZv-0049P9-1b;
	Wed, 05 Mar 2025 14:14:27 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpoZv-006G5j-1J;
	Wed, 05 Mar 2025 14:14:27 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v5 2/4] dt-bindings: arm: stm32: Add Plymovent AQM board
Date: Wed,  5 Mar 2025 14:14:23 +0100
Message-Id: <20250305131425.1491769-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305131425.1491769-1-o.rempel@pengutronix.de>
References: <20250305131425.1491769-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add support for the Plymovent AQM board based on the ST STM32MP151 SoC
to the STM32 devicetree bindings.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
changes v4:
- add Reviewed-by: Rob...
changes v3:
- fix alphabetical order
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 2cea166641c5..544010683b06 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -60,6 +60,7 @@ properties:
       - description: ST STM32MP151 based Boards
         items:
           - enum:
+              - ply,plyaqm   # Plymovent AQM board
               - prt,mecio1r0 # Protonic MECIO1r0
               - prt,mect1s   # Protonic MECT1S
               - prt,prtt1a   # Protonic PRTT1A
-- 
2.39.5


