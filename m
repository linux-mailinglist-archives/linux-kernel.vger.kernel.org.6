Return-Path: <linux-kernel+bounces-427502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBAF9E028D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7523EB33555
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68311FF61A;
	Mon,  2 Dec 2024 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="VPKUJ0pX"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED11FE479;
	Mon,  2 Dec 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142377; cv=none; b=RKUI7vBaR4sloVMzdFA3fAu6dkaC4wym1V4+o02W9Ie9WQ/aZEpiuiLYsYRe8QjLmKdK+dhr/58IK/oO1QH9qDXKt5+c2inDNYxSFM5sLZD2U+gwXY1smJf8bY/T2TYkfmOLv2uWcwYik5ii3TCnKf9h07LHwLmn/pF/lV3LCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142377; c=relaxed/simple;
	bh=8ZdDWa+iBQG6l45nOzdE91MJ3ECiqDra5V7T+0G+T7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGv24etK8tVXrSLNCru/hA2qHwBvMZ0HS8Aj+DclV7NezX6XdaHVQaDLe3qJtfn+lNi8A17IarThP4BPtpYNow5TDnzy8o7xPERwlD0YDdDVwwByk1adPKBVv2ABgOq8Esj0rkWfmL7prLvtSmTKqF5d5gmp2of3i2urC7uZW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=VPKUJ0pX; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id D0B476046B;
	Mon,  2 Dec 2024 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlHsPSsds4wfVdPuw/KHUgIalps/TN1syiynk/4rlxw=;
	b=VPKUJ0pXjVdKTjVTRrobEnKmmFoOGFI0D2hoT94iNr31w86RhVvTkuRK5mgcnoAzVEyVyC
	CBl1l29rVubzNMEQdKxjQYHDEUnMwtp3VzIrR0bv7FY5t6yaJoihzg+vk/6IDxH+cYlW6L
	YDx8+9ok51wZBnK6wIrVQToIgYwSyxQ=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 4DABC3600C0;
	Mon,  2 Dec 2024 12:26:13 +0000 (UTC)
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
Subject: [PATCH v2 06/18] arm64: dts: mediatek: mt7988: add thermal trips to bpi-r4
Date: Mon,  2 Dec 2024 13:25:47 +0100
Message-ID: <20241202122602.30734-7-linux@fw-web.de>
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
X-Mail-ID: 6c17b30a-1971-4b14-a2ad-0f3552d83a74

From: Frank Wunderlich <frank-w@public-files.de>

Add additional thermal trips to Bananapi R4 board.
SoC only contains the critical trip.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index df53512c6890..8a320d9da443 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -28,6 +28,34 @@ reg_3p3v: regulator-3p3v {
 	};
 };
 
+&cpu_thermal {
+	trips {
+		cpu_trip_hot: hot {
+			temperature = <120000>;
+			hysteresis = <2000>;
+			type = "hot";
+		};
+
+		cpu_trip_active_high: active-high {
+			temperature = <115000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		cpu_trip_active_med: active-med {
+			temperature = <85000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		cpu_trip_active_low: active-low {
+			temperature = <40000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+};
+
 &pio {
 	mdio0_pins: mdio0-pins {
 		mux {
-- 
2.43.0


