Return-Path: <linux-kernel+bounces-448908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5A09F4710
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 905557A2453
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B581A1F03E6;
	Tue, 17 Dec 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="spfzf9on"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DBF1EC004;
	Tue, 17 Dec 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426785; cv=none; b=oOqpn/M98pZzp827uKb+aeOIUUGvnEO9od8WBuuCc8Xu72KrwHMUVJ7Ej0F2kZM+qxvjH4YErJc0m4o/zNmMiGcDbztHVB8nXkifnmbzqyRw/NGwFDfMecc2uKm6zSNJuP2gBUpkTJ0TdHFXdMQDpCxaBL49c6CZ+h5MY/PwQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426785; c=relaxed/simple;
	bh=iLluu61s68YDnrhqC1ocAcwh72wsH+P2uSZ1OMi8zws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU1qL4Y0QLuxRo+SMbSgsl0eEFck5nU5ucFLPsunpOh7pjnVo+DSGZSCEQq8Gy2jI7s/El++6gxaN92lshqhsUfkUZ/sc3evi/XnEAXTFhKYvRN0NzP4YlTpyPUS5+Vt8b7/hrzj09cB/3/azsiLkSjXD7ngnqul+poz441M4K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=spfzf9on; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout1.routing.net (Postfix) with ESMTP id ECEBE3FF69;
	Tue, 17 Dec 2024 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLH7B1/fsQT4OqgVuCSBjfAK93rVJz4M8MFDc9eGBSg=;
	b=spfzf9on6yBnt+qXCLEOOLvFZ2pWEjF3s8soA0YcCjnjby8a0yOCphApl9OVh/Jhpky2U0
	zDNedWIR8OShaofpOy240GMRk520GS7V8iD+dgGxOOs7EBD7tLcOHPoI4ln9pORoK38hGj
	+S26IuUgZ2/BiySyMk6JJacKivxsrSo=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 30CF91004DD;
	Tue, 17 Dec 2024 09:13:01 +0000 (UTC)
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
Subject: [PATCH v3 14/22] arm64: dts: mediatek: mt7988a-bpi-r4: Add thermal configuration
Date: Tue, 17 Dec 2024 10:12:28 +0100
Message-ID: <20241217091238.16032-15-linux@fw-web.de>
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
X-Mail-ID: d0e1eb62-cc28-4aa9-9dcf-a8ff22252987

From: Frank Wunderlich <frank-w@public-files.de>

Add additional thermal trips to Bananapi R4 board.
SoC only contains the critical trip.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


