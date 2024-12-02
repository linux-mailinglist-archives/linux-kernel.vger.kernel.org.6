Return-Path: <linux-kernel+bounces-427499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7919E021B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45786283023
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0161FECA1;
	Mon,  2 Dec 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="OTSfbBaI"
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0184A1A9B2A;
	Mon,  2 Dec 2024 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142375; cv=none; b=Kscet5FHmgdhfqyySydi8pGm6ycEKlJpUQ+e2WEd4NwKBisKmjvyOpQQRqUT6Dvk7pLId/UGAiDqVzfQfxFE+ioGtGwStZrSuxEDpNe/DKTKw1MVuC7nfeZmhkrRXs147nS1hTD01WkAguuMBtID07bxkZBd5crrnq+UGmEbMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142375; c=relaxed/simple;
	bh=6myf5VsBiM0tNksk/bBd3W3sCpFjV8Mbo1t0gkCwiDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ks0Ftad06rJdvF30jvw7Cr4aUtQdJe/Sws5oHt8/rhakcRIz0M0LW7WrgUq5+wUCvMvsUHUpgdqSfOyvWERp7ybUiwq0o8X4JxGt5a6YYPO7cMK5UIleFs25cxxKMd62GZyMhEH92FTETFtEPDvq9PUJELZcs9bnm1Ob+zObGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=OTSfbBaI; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout3.routing.net (Postfix) with ESMTP id 25AFE613E1;
	Mon,  2 Dec 2024 12:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8v2guR/DqSDPQbSGDrw5WvcAqYbrWwp+FqeYEM2590=;
	b=OTSfbBaITNk3SMuX0Xpwq2902OFD0bjWtFWcS10fm+lb8Px9wsLN4i/5x3jvzUHmb/pu15
	nYKLfyxRqV3O8UA0eT2pT+IhNUhdKryE1C/a8hIBFY850czwP8/hqAoyx3l0Joi7Y8HeYu
	fI+dLb5Qjh8K3I2S+i4auf2gjKyasBI=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 90B41360211;
	Mon,  2 Dec 2024 12:26:10 +0000 (UTC)
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
Subject: [PATCH v2 01/18] arm64: dts: mediatek: mt7988: enable watchdog on bpi-r4
Date: Mon,  2 Dec 2024 13:25:42 +0100
Message-ID: <20241202122602.30734-2-linux@fw-web.de>
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
X-Mail-ID: ee49b488-8f49-4350-aa87-37bdea1244f4

From: Frank Wunderlich <frank-w@public-files.de>

Enable the watchdog on Bananapi R4 board.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index aa2dabc041fd..d914eae2b524 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -198,3 +198,7 @@ mux {
 		};
 	};
 };
+
+&watchdog {
+	status = "okay";
+};
-- 
2.43.0


