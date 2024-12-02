Return-Path: <linux-kernel+bounces-427509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB749E024A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF367B3AD45
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F55204F71;
	Mon,  2 Dec 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="oo6MRp1w"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA585202F93;
	Mon,  2 Dec 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142383; cv=none; b=YZZdKQaSNkhQJQFDY4j3mzorQgQzVvKHmER4q/H5NpcHsQ2PeGuT1aZJp+SJj7Lb3Oopp+XBwaYazvcaI0cLiMAiLwSGSDdLekALWS2ZgXFuIRVj9B0x0tP34oaTxukTwnUvt119bPe1LGKl5xA5e47/4qNbwfFJuI+bOt+M6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142383; c=relaxed/simple;
	bh=UwQIy0UkQN3iy8mYcTx8Gr1yMhkH4YnFHHUd0ZQlmCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3d9KlMX+7MRm5Ue7D0j9kH8ktU1D8ja/X5/X35oyZ2wxnPCwFKlKAVtOAha/9HQCWYrxtCoKV98jPNMxm9f3TssTQvaoSAxodfN3xOO5SuJRE+EXL3sYoEyDV+U15g5oN+CwJaU5XO7AO56Cm8ISGmA9lYR3X9TwthytnfGdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=oo6MRp1w; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout1.routing.net (Postfix) with ESMTP id 5B48541A25;
	Mon,  2 Dec 2024 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bf0wU1/QYkNghuSaTTJ0zcYOBhFOpXxvLvBEJ3/2A98=;
	b=oo6MRp1w0dDlv1cyvERc+WtxWDJjQ5EQmyrU0/s4eLaE0PO8hbf85iEnSkIwZRZ74SPXUh
	5+49RC9NU1l9lpWhYy9N8X8IqCS0P/tdnATn3kWrra6Xr5u+IX/kOoWwliVSrjD/zZW4QF
	CVfrsvVk6cTzOC0tXB1MuhHzzWlPmSo=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 5D32C3600C0;
	Mon,  2 Dec 2024 12:26:14 +0000 (UTC)
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
Subject: [PATCH v2 08/18] arm64: dts: mediatek: mt7988: add mcu-sys node for cpu
Date: Mon,  2 Dec 2024 13:25:49 +0100
Message-ID: <20241202122602.30734-9-linux@fw-web.de>
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
X-Mail-ID: 1636f77e-5670-4746-b648-6f76788a7fe4

From: Frank Wunderlich <frank-w@public-files.de>

Add mcu-sys node which is used later as clock-controller for cpus.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 1cf801486e61..2af440510c86 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -192,6 +192,12 @@ pwm@10048000 {
 			status = "disabled";
 		};
 
+		mcusys: mcusys@100e0000 {
+			compatible = "mediatek,mt7988-mcusys", "syscon";
+			reg = <0 0x100e0000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		serial@11000000 {
 			compatible = "mediatek,mt7988-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11000000 0 0x100>;
-- 
2.43.0


