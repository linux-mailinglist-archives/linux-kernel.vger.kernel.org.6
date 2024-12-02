Return-Path: <linux-kernel+bounces-427500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC2B9E0223
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FD1163136
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914F91FECB6;
	Mon,  2 Dec 2024 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="JDvX5Rsw"
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50911F9F7A;
	Mon,  2 Dec 2024 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142376; cv=none; b=TPmOUSEisrQcEJ41BuUYTJKDCQpcO/Jj9R3W5+wgQCeY6j4dHwOWXLiMERFDA+Bq8Z9hfgKCeFbGAgtifchmqw4/6c1OjaeY/mxC4ETedvdtU7hczVexQvytkNuddPD6re2HFzaDW8XVaDOd/+3j+7UminTFX1+tDqQGgSSW+lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142376; c=relaxed/simple;
	bh=S0ZKI/qABEMegVq4CXB3M5p7sMXkllVQQkGVBnROvrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofCTf/2wCJI+SUTkYFH9IcDf0I/edlnMouOwK9yDStMwmCZ9wi6nZ6uKaIc4PrLDi9yRRfHE9N3i57kcF6BaUZVgE2/QqIqmcyVXjzjA3JhbX5REvwRAzmoPlBc06PNrcBbF+PMDy4EosPlmxSzVvw9+GIDJza+klHfk/8OxLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=JDvX5Rsw; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout3.routing.net (Postfix) with ESMTP id 40DC7613F7;
	Mon,  2 Dec 2024 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvio4qYnn152relW8d8dOOQlvOo0mSc7MB7Rnu0hWEg=;
	b=JDvX5RswSd2RQ/g18NW4rQ0qtVwn6IhhlCcpyGPRkmpyhxpxlfCiWLYLaeu6Cj51EnuuFC
	WiWnAQE5V24sCQjKuqg5sNhPdgFexNhcuwL0GWtMXlQrZe55QFOEuIv93h+4mSH5Gd8l+T
	DELL4n1NCuMb9Kb6ezsbNAs+mzQktPA=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id ABDA0360188;
	Mon,  2 Dec 2024 12:26:11 +0000 (UTC)
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
Subject: [PATCH v2 03/18] arm64: dts: mediatek: mt7988: add fixed regulators for 1v8 and 3v3
Date: Mon,  2 Dec 2024 13:25:44 +0100
Message-ID: <20241202122602.30734-4-linux@fw-web.de>
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
X-Mail-ID: f3d04e75-e09a-4074-aa49-cde4d43063c7

From: Frank Wunderlich <frank-w@public-files.de>

Add regulator nodes used for mmc to Bananapi R4 board.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2:
- move mmc regulators to board dts of bpi-r4
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index d914eae2b524..df53512c6890 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -8,6 +8,24 @@ / {
 	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
 	model = "Banana Pi BPI-R4";
 	chassis-type = "embedded";
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &pio {
-- 
2.43.0


