Return-Path: <linux-kernel+bounces-427511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B909E03BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1A6B3B095
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE83204F9E;
	Mon,  2 Dec 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="miO23gm/"
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5E1FECA2;
	Mon,  2 Dec 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142383; cv=none; b=TnJo9z1+PNqgPxev9wXZoWXLdE/fLqeqFGJzNzAKQXYZQnj3bBFc1o8t9Jwtqistco6pzMNmjzGcJyyq37HTZOx45Njo/X2SwnwuWu8m66ZYcsh+mhW0pDAPPSsuSSX2fmkaU/Bwyy/C9cexRF2q11kH4fL8sVawGop1Gd/XXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142383; c=relaxed/simple;
	bh=tXmGE50YOIz5SzcYHsKev2mYhOC/YO1vLvPg1XfuhQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/AgMvGxDLiTA2Z8xWI1W5DDkNGsFeg8BTo5v4s/dhuijTllApa4AAJeFoe4/hVL/ZpO8AkLmPDcb4fPqxwJqJ08OYQ+fNYP6AzLOech9FVg0vmJgrDEaMLBndmR9F6xwvBv+Paa1SuNQQy+2UgJSKSgbNxDhBmPTEuxQtjaL6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=miO23gm/; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout3.routing.net (Postfix) with ESMTP id DB71A613E1;
	Mon,  2 Dec 2024 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLz82rdcKDrgd4xoVhfZ0YMlDvGMQtoiJXXkans2pP0=;
	b=miO23gm/nSsZ0oaYi8oGEcKaTVbGDLIaibifAiQnTfcQ+/HVeFzS8Ecbj7B/tmd76ZdQVh
	g/gCLu2HYWBaWGbGtAs/NRBB2pO9bf/JZ0kpF6UzKZm2+fS2iMyc+qtRedSdHP3bJ+RUkp
	4shDPCZ6jPdOMXcWZWOud8ReGk1yb/8=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 28516360552;
	Mon,  2 Dec 2024 12:26:20 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 18/18] arm64: dts: mediatek: mt7988: enable pwm on bpi-r4
Date: Mon,  2 Dec 2024 13:25:59 +0100
Message-ID: <20241202122602.30734-19-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202122602.30734-1-linux@fw-web.de>
References: <20241202122602.30734-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 4134b58f-ee95-4f76-aa1e-472263d0e3cf

From: Frank Wunderlich <frank-w@public-files.de>

Enable pwm on Bananapi R4 board.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi                | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 12b45b18955b..181bb997cd8d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -369,6 +369,10 @@ mux {
 	};
 };
 
+&pwm {
+	status = "okay";
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 2be84acac06a..11651f5e167d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -211,7 +211,7 @@ mux {
 			};
 		};
 
-		pwm@10048000 {
+		pwm: pwm@10048000 {
 			compatible = "mediatek,mt7988-pwm";
 			reg = <0 0x10048000 0 0x1000>;
 			clocks = <&infracfg CLK_INFRA_66M_PWM_BCK>,
-- 
2.43.0


