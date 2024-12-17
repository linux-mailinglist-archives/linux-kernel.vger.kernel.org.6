Return-Path: <linux-kernel+bounces-448913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F589F4718
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317FF1890EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B395D1F37D3;
	Tue, 17 Dec 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="p+iKVX1K"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC591DE8AC;
	Tue, 17 Dec 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426788; cv=none; b=TkMteN4AB9C36Sj1whzz9aPjuRDr+kRR6PCUZW+qpw2bEaBxmBI/+W6G0yLBmsY2TaXTMticIkLI84587dDhHScMU639jTf9AURGKlqK82rm0TukvVihCIgeCpanXkkXeCY1gMFZM33kwQ9F1Wa4gz/Dk8ZeHE/SIDHQsem5xkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426788; c=relaxed/simple;
	bh=rwts638YK8jwh3+iE6J+/0Efiug+o6SeWJAetpH7hvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fky68+uc9fXVMZy3mib0nMS1sCtv/DT+zV5PUwWmNEu+fk7gMd3r1fRGv5X9kOh2MKIY3LPZJJI0UBFfNtqHtZRj1zzRHFBNfYy0Cy4clJO9aJhiaO6Sn5p84i1Cj3mPATVC4N6CFCd48QpUqtRA9vh4JL78E/rvPwM6zpwUwIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=p+iKVX1K; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout2.routing.net (Postfix) with ESMTP id AB4146027A;
	Tue, 17 Dec 2024 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3KydIItLpW1TOMUQofbIcrJKjEor2i2/sa8MxWxLRXY=;
	b=p+iKVX1Kyi54jlCy/P4IXhAsJf4qEPWe4kWvt6l3e8OwEO5P1en6PEr5/muJvWGzKIFVRy
	KXV9kuyOO6qkSOaJLEBTYgtMmQcLTiOGzmcDI609UokKny66/qRm547RDXoe3kWPDpvwR5
	U7FgGo+M6grcZfzsQ0/fXT5EeGg/zXw=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id EDBAD100532;
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
Subject: [PATCH v3 15/22] arm64: dts: mediatek: mt7988a-bpi-r4: Enable serial0 debug uart
Date: Tue, 17 Dec 2024 10:12:29 +0100
Message-ID: <20241217091238.16032-16-linux@fw-web.de>
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
X-Mail-ID: ca9ca4a3-5ca1-4a6b-8b77-70702b3ab45e

From: Frank Wunderlich <frank-w@public-files.de>

Enable the debug uart on Bananapi R4 board.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi                | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 8a320d9da443..9037f35857a9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -245,6 +245,10 @@ mux {
 	};
 };
 
+&serial0 {
+	status = "okay";
+};
+
 &watchdog {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 74c75d5149d7..59a1ffc2edfc 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -236,7 +236,7 @@ mcusys: mcusys@100e0000 {
 			#clock-cells = <1>;
 		};
 
-		serial@11000000 {
+		serial0: serial@11000000 {
 			compatible = "mediatek,mt7988-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11000000 0 0x100>;
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.43.0


