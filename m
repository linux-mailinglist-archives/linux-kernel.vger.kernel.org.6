Return-Path: <linux-kernel+bounces-206939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824F8901018
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309D0283B7B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE091176ABC;
	Sat,  8 Jun 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Q635Mxdc"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA4C8D7;
	Sat,  8 Jun 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717833960; cv=none; b=a59Oli+fZMvzcMjuZc3JS9qRPnhUVbGnpcJbASvJrf13Wub97on7vuTvyF1fn6alnKRwyfGKk6TTBVZwz+kHKIgzH6CaMqG60cWwnOWIxNnKqLXjgl8Bf+lE9rWoMx/Y+NMOcPem6KPjKx1KCltCCA236054WKiNtMj08xZYdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717833960; c=relaxed/simple;
	bh=tv56+8UiagoHupXH0kuCdPisBjQflyyKaWZLInsBYqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rT3oHeXQ2jwYfrOLVW4FSU6XHJReuSozP8pFG9AqtQyVH0SQmrxrLxM12VEAJqqysfdGKSP3C9hp3kWoWxZxvml0kbd3cpRHrotq1DRM2F24GHfTQxGUCUBYTsVlelwJwP+lE4j7rHyUzhg5FhXURmAqyx8WuAaYWYHPO+x2KnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Q635Mxdc; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout4.routing.net (Postfix) with ESMTP id 3EA50100CFA;
	Sat,  8 Jun 2024 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1717833950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+RS4NoAYgU9AZL8LvXzHxrBJRVGTscCq1GO1sWMkik=;
	b=Q635MxdcWGufYFjzAiTMApiA9n/v23AiOcutpMuUtbjMxOeAHyqelknz2ATFLLY92TkaXP
	soHHWyvHteQG/zStV7GsQD+Whx0lZIf9PJZCyDDQETtP4zBX/pW9nYLmh897y8EzQoyT2M
	Vw5x942GKiNxD4wAo8l5pEtRjJLfnYQ=
Received: from frank-G5.. (fttx-pool-217.61.155.199.bambit.de [217.61.155.199])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 6BE118010F;
	Sat,  8 Jun 2024 08:05:49 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/2] arm64: dts: mt7986: add dtbs with applied overlays for bpi-r3
Date: Sat,  8 Jun 2024 10:05:29 +0200
Message-Id: <20240608080530.9436-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240608080530.9436-1-linux@fw-web.de>
References: <20240608080530.9436-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: eda811a8-5da4-4650-a7ce-a4d227bb3153

From: Frank Wunderlich <frank-w@public-files.de>

Build devicetree binaries for testing overlays and providing users
full dtb without using overlays.

Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
https://lore.kernel.org/all/CAL_JsqK_3xxD0DFwipXO85P=q=EYjUdjE1_8g1MKtvw3vVzx5A@mail.gmail.com/
https://lore.kernel.org/all/CAL_JsqJSi=kJSix=f3787ULZnaCy_Y26Phdhy5y9fat_vkDuUw@mail.gmail.com/

v2:
make full dtbs multiline for better readability
---
 arch/arm64/boot/dts/mediatek/Makefile | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 37b4ca3a87c9..0ec5b904d35d 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -15,6 +15,27 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
+mt7986a-bananapi-bpi-r3-emmc-nand-dtbs := \
+	mt7986a-bananapi-bpi-r3.dtb \
+	mt7986a-bananapi-bpi-r3-emmc.dtbo \
+	mt7986a-bananapi-bpi-r3-nand.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nand.dtb
+mt7986a-bananapi-bpi-r3-emmc-nor-dtbs := \
+	mt7986a-bananapi-bpi-r3.dtb \
+	mt7986a-bananapi-bpi-r3-emmc.dtbo \
+	mt7986a-bananapi-bpi-r3-nor.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nor.dtb
+mt7986a-bananapi-bpi-r3-sd-nand-dtbs := \
+	mt7986a-bananapi-bpi-r3.dtb \
+	mt7986a-bananapi-bpi-r3-sd.dtbo \
+	mt7986a-bananapi-bpi-r3-nand.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nand.dtb
+mt7986a-bananapi-bpi-r3-sd-nor-dtbs := \
+	mt7986a-bananapi-bpi-r3.dtb \
+	mt7986a-bananapi-bpi-r3-sd.dtbo \
+	mt7986a-bananapi-bpi-r3-nor.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nor.dtb
+
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7988a-bananapi-bpi-r4.dtb
-- 
2.34.1


