Return-Path: <linux-kernel+bounces-386697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A0A9B4715
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E747D1F2359F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789E9205ADA;
	Tue, 29 Oct 2024 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="OYXEJ4mQ"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963A204F89;
	Tue, 29 Oct 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198397; cv=none; b=JsY6j+c8iS/D73AS3kGftEt5MX2GnWCKrhNkxUPVvgU30gbvmSg7LckALBjTJW1vlU0WRrvr4vTpmWYI41J9vua+IIRKfla06Qd8ps7PF8JVOWzAKP0dp8k5rKcSBGjTNpg2PAaSQMs8WD1iAk6dyhgznAMMbXYJR5HJTzLfPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198397; c=relaxed/simple;
	bh=OJYlfLhx403GbTrHVZB8UszZox9nYxZBzBQATfxnCmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwoL14RR//m+fxdga0BRLXYdM3F6zjC0Tt6GmGX/mfN2gO+k9rubtqzkimkTItXFd7KPiRbrGVOY5gxzUtXNq20dLS6f9kXAiR6qjSDT5ShBviXokQ9m4rRN625bSpCfUyBvGfvc4Fy9x+jxXxvw2PJlGcthKf1A7v3Rgi7QmG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=OYXEJ4mQ; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout4.routing.net (Postfix) with ESMTP id 9752B101578;
	Tue, 29 Oct 2024 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kA2523qYUhUEFCv+YtsYoSs5yMA+mmGNCd9m9PrUL0M=;
	b=OYXEJ4mQ/JPue8n7aKICB4zAyGO2GX9YXOOe8gq7FUECVLqCt/BaMKGg1wMS0x+ArP0Ses
	tluatSuxlWqX6PlDa/qZ0VA/1W7F8lTlSllihDhaqfH8kJGUjxGv9lkYh1dV4x9xPNcJgS
	RN/QtOI9Qq9j0IWETYaEBjgns3VGT1s=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 0694C36037C;
	Tue, 29 Oct 2024 10:39:50 +0000 (UTC)
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
Subject: [RFC v1 12/14] arm64: dts: mediatek: mt7988: add reserved memory
Date: Tue, 29 Oct 2024 11:39:31 +0100
Message-ID: <20241029103937.45852-13-linux@fw-web.de>
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
X-Mail-ID: a95d1809-21ad-4521-bf01-ef6152e9e13d

From: Frank Wunderlich <frank-w@public-files.de>

Add memory range handled by ATF to not be touched by linux kernel.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index a3a7deda35a5..7721d2ec06ee 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -81,6 +81,18 @@ reg_3p3v: regulator-3p3v {
 		regulator-always-on;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 320 KiB reserved for ARM Trusted Firmware (BL31 and BL32) */
+		secmon_reserved: secmon@43000000 {
+			reg = <0 0x43000000 0 0x50000>;
+			no-map;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		ranges;
-- 
2.43.0


