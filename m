Return-Path: <linux-kernel+bounces-386692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D289B4709
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0059B1C21080
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD1204F7D;
	Tue, 29 Oct 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="T4tW4Pjh"
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3461E102D;
	Tue, 29 Oct 2024 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198395; cv=none; b=ay0xjo8bdlOa+/Wlh1ArIm7hn+HWD+5YAJb9vb6MbT/DFizF6BcZM5grWle9e0JAnc0rVEykR1LmXmRBWldiOQC9e+JF1WUqyofPc8Q+qFDuTTz4Dat0VmYpQWP3hAaewQyJDauS24NPunB1eg632c9xwIutJMYUK4+LBZKAXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198395; c=relaxed/simple;
	bh=70qrFTnQRWApjaxgLtEzaxwn9O9H03R/UTqJ/+cdtuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7POYkEIHB4FEFGs/KqvXybUFczIPTlcbD672hw2oRjrK/8kL5VwDOUUwRYSVQRUlPKMlgQE29NTRviXMZg61n8s/4O5hGAvDBpaQkceqNX3O5YUk8fME8mwV95pq1TsEw2FOiOTDmr3m8CjnkEv+4Hlcn1IYNhnOvm1EpUN+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=T4tW4Pjh; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout3.routing.net (Postfix) with ESMTP id 23B966164E;
	Tue, 29 Oct 2024 10:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Zqi6Sl+Kx4Ji1QwakjgbRzaeDN7PqxTEdUVl3GZZf8=;
	b=T4tW4Pjh43l3XljyaRqU9KlcGnR0fhiX2E9UWADtycYVAGuymEwDQK9AL5m4dyWr+zAOR2
	jNpJMwSUvdbLtsp56XJyzF9xDuTJIOOqyI1Z+6xv8zmXV/X2Sw6fjO1MqPaHOv1FcyDPRq
	alwwm7A4KHF+3xfeMhtOiarqJjEjEfE=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 892EE36037C;
	Tue, 29 Oct 2024 10:39:47 +0000 (UTC)
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
Subject: [RFC v1 08/14] arm64: dts: mediatek: mt7988: add fixed regulators for 1v8 and 3v3
Date: Tue, 29 Oct 2024 11:39:27 +0100
Message-ID: <20241029103937.45852-9-linux@fw-web.de>
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
X-Mail-ID: 351e04a4-f535-41b6-80ef-f6eadcd15412

From: Frank Wunderlich <frank-w@public-files.de>

Add regulator nodes used for mmc.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 639c307b9984..7371cd80a4ff 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -62,6 +62,24 @@ psci {
 		method = "smc";
 	};
 
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
+
 	soc {
 		compatible = "simple-bus";
 		ranges;
-- 
2.43.0


