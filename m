Return-Path: <linux-kernel+bounces-448915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E29F471D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5CF1891066
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36FC1F4296;
	Tue, 17 Dec 2024 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="lbP79iWh"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30111F37CF;
	Tue, 17 Dec 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426790; cv=none; b=SmFSgbSBxF15GH6hbbJbRRkbHdajZ3iHa9M4uLXUMzeIw7Fx2yIeOs2OSMo866UT8Ekjp+qzMaf+RIaDVgjN7H1ESLVjxEn4O967BrjhgcRo3g/DmMaXjRYdETmfc36iCOLnkQciCW6YlEvctNVfeCaYH5OMwE/W9J2pjh/dfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426790; c=relaxed/simple;
	bh=gx4d/pLliFKObjsBjVHfw+1yh/fv7dNBp34W29RVfKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOwmTIkrUStB/xRwNOmi5yoO8jKi25P+aRXGG/sUHRNJ4y3bp2avVJlty6s+LFVKgxcvQxgwizRzyQEKq/QA0YtUwMTjZdMd2y8rg1nyEGwsemTKFLWM+vGJ6Ut9u9XuGH0m2iO9gW3XnTm9KztNGekhZ4hWDRZ9eCIrlrxdFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=lbP79iWh; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id 1ACDA100906;
	Tue, 17 Dec 2024 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dR5zR7nqfqQpHw9IRVQib2Z/UUi1+FSU0j+/LH4KgIg=;
	b=lbP79iWhx3Ggsa3KjFye94VvB4kgIWgV1yEZ//GKHGzdip3uT7jlfX14XFamcKFRK7zpdL
	fU/PKEs1SsXs6LKA7nQ6N1jPfyIHjSQmZren/nW6jA3ySgUjvZQBKIsz1zKFLZFBnmPMQS
	l/fuIuL8NM1GldXAk0JTmtjihxE57mI=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 6578810030F;
	Tue, 17 Dec 2024 09:13:05 +0000 (UTC)
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
Subject: [PATCH v3 20/22] arm64: dts: mediatek: mt7988a-bpi-r4: Enable ssusb1 on bpi-r4
Date: Tue, 17 Dec 2024 10:12:34 +0100
Message-ID: <20241217091238.16032-21-linux@fw-web.de>
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
X-Mail-ID: 165bfefd-7350-471d-9e9d-01df6696e7fe

From: Frank Wunderlich <frank-w@public-files.de>

Enable usb on Bananapi R4 board.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
changes:
v3:
change commit title to have bpi-r4 prefix
---
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi                | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 129031b0d784..08d664d6449b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -306,6 +306,10 @@ &serial0 {
 	status = "okay";
 };
 
+&ssusb1 {
+	status = "okay";
+};
+
 &tphy {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 0766ca0dd3f6..f3e942db0b99 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -337,7 +337,7 @@ usb@11190000 {
 			status = "disabled";
 		};
 
-		usb@11200000 {
+		ssusb1: usb@11200000 {
 			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
 			reg = <0 0x11200000 0 0x2e00>,
 			      <0 0x11203e00 0 0x0100>;
-- 
2.43.0


