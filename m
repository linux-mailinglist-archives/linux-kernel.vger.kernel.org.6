Return-Path: <linux-kernel+bounces-448900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208229F46FC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E171B188C0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1781DFE0B;
	Tue, 17 Dec 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Kuglu2Ji"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73B1DEFEC;
	Tue, 17 Dec 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426778; cv=none; b=CBKkZWNZ8U8jqrsjkwmsHZUdlf/1CezpOAts765w4lCbnVxykJ6CqLojBELjoWQIFzCXiZrEi7ohsYuQyFfT7I0c0i7qyLB6SIH4sL6ijw5smDEqO+amKkM/nhoys5KwNnr2Y3nCWijmD0SF6d2lmXQMB4gl7LdC0Ydr24C5A0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426778; c=relaxed/simple;
	bh=/0z2px/uOZ46egji19KaPpKb2t3TZEqjFDHO7p8xtHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0UiCkeHgmDnFga8MqkoaR1kNUp8ZsvVQnQFiokGiLe0PdSRqFCiYeN4uutU7T0HZAMcWBEeB+P/ZEs8pbznzJeQkXBi7mTxuqgkcG+F327V69UqVTvp1VRmOYd/m7PtDLrid6N0NlI8RCdfvA8AweJ8mB+CcJIUMZ7t9qaqKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Kuglu2Ji; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout1.routing.net (Postfix) with ESMTP id 4CD3440179;
	Tue, 17 Dec 2024 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBoy0mKxi/UwmOEKuFq+f8HRhibZKPc4IQyUCkM5FcE=;
	b=Kuglu2JiMD/LSM73JFRT0532mf92pbgAtX3KKzsRDv80Xb19plAHaqOEQRvTFODF1VlLMs
	Xa+op4iHRikGIYm4CLAJ/mB4+1wbvTZgC0Q7YI5oUBDSQ+cymhB/qIpn6CaT+ZIun8dYaI
	PfnN3SMfPrsLYlJuK7BrGuXMLbncsMc=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id A61BE100549;
	Tue, 17 Dec 2024 09:12:53 +0000 (UTC)
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
Subject: [PATCH v3 04/22] arm64: dts: mediatek: mt7988: Add thermal-zone
Date: Tue, 17 Dec 2024 10:12:18 +0100
Message-ID: <20241217091238.16032-5-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217091238.16032-1-linux@fw-web.de>
References: <20241217091238.16032-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: b128b330-7f6c-423b-a5a0-45a33d750123

From: Frank Wunderlich <frank-w@public-files.de>

Add basic thermal-zone node.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v2:
- only add critical trip to SoC dtsi, lower trips have to go to board dts
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 32bb04ce21b3..0e75a8692879 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -355,6 +355,21 @@ clock-controller@15031000 {
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+			thermal-sensors = <&lvts 0>;
+			trips {
+				cpu_trip_crit: crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-- 
2.43.0


