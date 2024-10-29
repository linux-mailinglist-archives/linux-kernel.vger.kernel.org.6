Return-Path: <linux-kernel+bounces-386710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25389B473B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A88F1F2416E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC68205ABE;
	Tue, 29 Oct 2024 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="wxhqG3Qs"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B041204938;
	Tue, 29 Oct 2024 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198877; cv=none; b=HrfdagGlv+RQ5Cng6G7LiRTxpeqaBfmVqdfnCMXFsJB+OP4POsTXMLdzr0voTVComl1hN1dZT48l+HUGSca/BmoFE/bszNgnpRX2WqJ44UURRver1RFQGpl6qz0zW67lhmMx40c6GbTbZ2oZYrNxAotP3VgXnXG+ID/obm+ZEXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198877; c=relaxed/simple;
	bh=t0dCfe1NlZHydGMJfHitBBcy4Sko/G3WOMQon2SgtXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFVg9CWNQhOp7buen4DX1xyqshgrrXPt4VD5ip4BtgAAk37UU8IWYjdzi97HSVypE5RsFAhmNA3zqA3zegLIN/qEfOlvswGxOJwb0wLG+m2WFihjdLKQnXgtGTuq4AymlcoI5HfWMcpIYCPfX2T4gAmQ3L8z5htHTy7xhIVbJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=wxhqG3Qs; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout4.routing.net (Postfix) with ESMTP id 1F899100947;
	Tue, 29 Oct 2024 10:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/KolqS0YYWQP0oixitj94Pxcm9KCNLC3CIXSUPwlb4=;
	b=wxhqG3QsBQclIRalcvgxZPfIZNd/HWojdWrKBZkxleWOwndX59kkgdiGg8ilZKyChTGlwd
	CUU+65n493IfSzS5XSYBOiYJA5AK18ttW2xIEbx1kzkRNCmKBW+hzPUfYOzw8eipST/Qeh
	2pYhUx41BJJlkaHfvWhG9aFsUqX03So=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 7FA053600D8;
	Tue, 29 Oct 2024 10:39:44 +0000 (UTC)
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
Subject: [RFC v1 03/14] arm64: dts: mediatek: mt7988: add labels for usb nodes
Date: Tue, 29 Oct 2024 11:39:22 +0100
Message-ID: <20241029103937.45852-4-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029103937.45852-1-linux@fw-web.de>
References: <20241029103937.45852-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: e21543fd-2459-4976-ab15-093cffde658a

From: Frank Wunderlich <frank-w@public-files.de>

Add Labels to allow easier referencing in dtsi and board dts.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 0aa789da5592..6d2ea317f9b2 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -250,7 +250,7 @@ i2c2: i2c@11005000 {
 			status = "disabled";
 		};
 
-		usb@11190000 {
+		ssusb0: usb@11190000 {
 			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
 			reg = <0 0x11190000 0 0x2e00>,
 			      <0 0x11193e00 0 0x0100>;
@@ -264,7 +264,7 @@ usb@11190000 {
 			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
 		};
 
-		usb@11200000 {
+		ssusb1: usb@11200000 {
 			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
 			reg = <0 0x11200000 0 0x2e00>,
 			      <0 0x11203e00 0 0x0100>;
-- 
2.43.0


