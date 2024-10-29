Return-Path: <linux-kernel+bounces-386706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260E09B472F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E80B2155D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E418C204F84;
	Tue, 29 Oct 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="V2Ag1/d+"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C72038A0;
	Tue, 29 Oct 2024 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198841; cv=none; b=joDsZHuLZHzYB8e4hZPo38gNEYKz5C5K6uPRYP6ANNyz176kAIOc63wBbCXstk+fz/5eUq+iAap8shh0eIqO0llTQT+XOemEvw4Ab+UbqyZaEmUAMvPu4+thXeGAR8Uw/M0EebyfLUDuWfO9fZyQR5WvTYhOpJLM62hNKqi4ZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198841; c=relaxed/simple;
	bh=bx+E3xIPoVUFNteRn7fpvqnxF61LA8Z6qnuT+L6jyrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fn2HCHGyLOZKDB83E0qhqqgkdjKy7BxL0ahGXPMbKHAB9L9eWo3LZhlGCnB3wR7GNR3hTlCp71nlmnYgEQoPeXSVlNYTaYaZrwDjeTVU8jD+A11Kde1UQ7KbeZcB2UUkteEELgnahZ3XwszYgAGR78MCFvwMSgsBkwB5u2sDw8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=V2Ag1/d+; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout1.routing.net (Postfix) with ESMTP id B1765404FD;
	Tue, 29 Oct 2024 10:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6MnpLRRV6D0qYtjvT6N/RJ0yKKwRAeg0UPLRteadPcE=;
	b=V2Ag1/d+nJ1XUQFIviC60Y2T9ospo5AwymtxtY4KMs8gVFNhcBo2LCVJGfSsiF8/pNKtVa
	JpNag7NrLDI65v14QLPUoZxURi4U0ns/PLJiPz6xiVEC7jq/AzvYUT9mrVhKEz9zH/IcGv
	CFlUi/I1B1FNvRr52ehFfqNw7bsN+fE=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 1B0B036037C;
	Tue, 29 Oct 2024 10:39:45 +0000 (UTC)
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
Subject: [RFC v1 04/14] arm64: dts: mediatek: mt7988: add serial labels
Date: Tue, 29 Oct 2024 11:39:23 +0100
Message-ID: <20241029103937.45852-5-linux@fw-web.de>
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
X-Mail-ID: 6858e22b-58d2-40a1-a28f-cb0b77144b8b

From: Frank Wunderlich <frank-w@public-files.de>

Add Labels to allow easier referencing in dtsi and board dts.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 6d2ea317f9b2..e5e7951b24f8 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -178,7 +178,7 @@ pwm@10048000 {
 			status = "disabled";
 		};
 
-		serial@11000000 {
+		serial0: serial@11000000 {
 			compatible = "mediatek,mt7988-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11000000 0 0x100>;
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
@@ -189,7 +189,7 @@ serial@11000000 {
 			status = "disabled";
 		};
 
-		serial@11000100 {
+		serial1: serial@11000100 {
 			compatible = "mediatek,mt7988-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11000100 0 0x100>;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
@@ -200,7 +200,7 @@ serial@11000100 {
 			status = "disabled";
 		};
 
-		serial@11000200 {
+		serial2: serial@11000200 {
 			compatible = "mediatek,mt7988-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11000200 0 0x100>;
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.43.0


