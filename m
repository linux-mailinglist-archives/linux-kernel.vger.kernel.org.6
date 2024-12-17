Return-Path: <linux-kernel+bounces-448909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C989F4711
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB53116EABE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D391F130B;
	Tue, 17 Dec 2024 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="TmiZ+k49"
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68661EF0A1;
	Tue, 17 Dec 2024 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426786; cv=none; b=fCmAdnNSS32rZ7acIdwfmrQcHLakv320EUOe3xlAvqLET6u9RD2T3rlYasSIBGrt1b19UuQStXNvrly0zDubK3AwFcoVbi5NRkgqlOmoK6ehjRxOIT2G0JYa1Tj/9kLM7oDKfqoBdgvIMEDLZuxJDJRlTrRYkiERCP+QK5memCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426786; c=relaxed/simple;
	bh=khVWtm36KKege66akUMSImQgsGBiEMUY1v3zORb5B0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEumcXd44U8OnrCddoFseTOpyDC/i67VhznF4tDUJEe9U6PbfgYZBugc/ASgansYmBab5wThs73h/QL4o7h1FTB4ze0SLzoZMjHFnGL8CvTsjwT/8PiC1KWtx1MO4Hy4x7gs+AfUFJzvkOfVhJnY7YaLH475nu6syPMljV+xf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=TmiZ+k49; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout3.routing.net (Postfix) with ESMTP id 520D5605F0;
	Tue, 17 Dec 2024 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKsYOqlLWlZZ8BNWUWGXYqge99kuK2EmHZh2v+IIWGc=;
	b=TmiZ+k49hlgiTVw42Z+W3n5hORU4ILtAL6emBM4z9K01icAi4cnqrON1dlnB6d3lCH6QvI
	265VRREOkWJtmXpnCaQhYvYhN7jvQtTNWyigL9v1Zp9qW6NfiYj4h48YQEQVzgNB5+u3Mm
	MAKe7Yzp+iNXnw+aXqsoj2JNw7LlKHo=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id A56B51004DD;
	Tue, 17 Dec 2024 09:13:02 +0000 (UTC)
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
Subject: [PATCH v3 16/22] arm64: dts: mediatek: mt7988a-bpi-r4: Add default UART stdout
Date: Tue, 17 Dec 2024 10:12:30 +0100
Message-ID: <20241217091238.16032-17-linux@fw-web.de>
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
X-Mail-ID: 78664bc1-ee2f-4faf-b659-93544f0edf05

From: Frank Wunderlich <frank-w@public-files.de>

Add chosen node on Bananapi R4 board with stdout and default bootargs.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
changes:
v3:
- changed stdout-path to contain serial settings and dropped
  bootargs property
- changed commit title
---
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 9037f35857a9..46117df7d44c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -9,6 +9,10 @@ / {
 	model = "Banana Pi BPI-R4";
 	chassis-type = "embedded";
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
-- 
2.43.0


