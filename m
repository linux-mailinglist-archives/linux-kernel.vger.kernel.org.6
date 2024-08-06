Return-Path: <linux-kernel+bounces-276098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8862C948E53
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E7D281796
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437DC1C37AA;
	Tue,  6 Aug 2024 12:05:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F342165EFA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945932; cv=none; b=mw16DhO0Fj8K58T0kM/zYHOISFGcMclCX4SIjzz2EejQqAw9lb15Iy+dt/QtoNqON3zV8Bjk8HdudR5UsDfxOFLr2xLvFLNk9BLIjkuAycR2iwRlaDZYYTvY82Y8K4UNqaCMJGS+BtQPVDdKI9vZr9J3txaxcWH4AE1Tup9Gj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945932; c=relaxed/simple;
	bh=hVpDtj+lPPdKKOrlvXKADc0PEn5BwfZtJkF2447W06s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vq2kjyBg1OVsj/bVn0fVVREdOiCe67kJF97O/582MsUEaRz7gmHp0c2hV5ZAEoGHMCjEX9ktsdAPYH2FS+OwVeBFlsPMc/KEu/0z8FWkzO5nEdDg+LqnFhsaoBsIkPPE49WYdNpkJlUTsRGOCTYDO6kciztG4df5XlbqGaAJmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sbIwK-0000ep-97; Tue, 06 Aug 2024 14:05:20 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sbIwJ-004x2i-B1; Tue, 06 Aug 2024 14:05:19 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sbIwJ-001hoH-0r;
	Tue, 06 Aug 2024 14:05:19 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v1] arm: dts: st: stm32mp151a-prtt1l: Fix QSPI configuration
Date: Tue,  6 Aug 2024 14:05:17 +0200
Message-Id: <20240806120517.406714-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Rename 'pins1' to 'pins' in the qspi_bk1_pins_a node to correct the
subnode name. The previous name caused the configuration to be
applied to the wrong subnode, resulting in QSPI not working properly.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi b/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
index 3938d357e198f..4db684478c320 100644
--- a/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
@@ -123,7 +123,7 @@ flash@0 {
 };
 
 &qspi_bk1_pins_a {
-	pins1 {
+	pins {
 		bias-pull-up;
 		drive-push-pull;
 		slew-rate = <1>;
-- 
2.39.2


