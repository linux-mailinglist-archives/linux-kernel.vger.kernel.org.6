Return-Path: <linux-kernel+bounces-448907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 639019F470F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C8616E8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F81F03DE;
	Tue, 17 Dec 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="uq9eJZcK"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1321EB9E8;
	Tue, 17 Dec 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426784; cv=none; b=BReLDiv6ceqbzs6n0BvfCmoxnliW1uKDDA461eh7e8lcoMbBhJhqy0SM3g+eVDbL6XEpPdC7SjB80vWAvIOBOQBV2g0XFa1xWDscGe12/5JOjYihZU2WsEIkcCtP9N6YC7rJW5YHNoaCEaPNexS5snApLlVzTk1EN6N7ckE0qKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426784; c=relaxed/simple;
	bh=+3LBOloCyLQuH0g1C4/7q4qJ/fMBT8nD2lVqJ7RP0J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnwRhdgNVmHTpzLDS/ZK1Gyg+ql0MZQXwRhvNL05TOQMUlHWTGzGfDSeA9g4ngV18qG8bZDm9fYNPVIipGBXWrQWNaAenZojbHQDjKPd0TSWASWt+jTL3cRmOcUpxLi619oEQQ7reY5UWLqPnYhhqE+yJX7fpCBkMsb1p8Hl/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=uq9eJZcK; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout2.routing.net (Postfix) with ESMTP id 359DF60272;
	Tue, 17 Dec 2024 09:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPoopGLWVLPi2SmZElx0MdVEWVF3HSJwWlBXrl2iFIA=;
	b=uq9eJZcKO37SmiDYQTQSccmvAXpTXAXSJ8KVKS9BvNhr/c5Xfjbu7mC2vrxg3XBTEk+WR3
	e6Y+i0eY7E+VIrEBZkzxdo2LHAD8hOEXiApnvMEzHvsQFjvqoTrt32jHV1IOdeWTr8BDVi
	COi4PyRaz1+KWHV4Rp8tqFGcF84sbR0=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 7BED5100532;
	Tue, 17 Dec 2024 09:12:56 +0000 (UTC)
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
Subject: [PATCH v3 08/22] arm64: dts: mediatek: mt7988: Disable usb controllers by default
Date: Tue, 17 Dec 2024 10:12:22 +0100
Message-ID: <20241217091238.16032-9-linux@fw-web.de>
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
X-Mail-ID: 9199ffbc-98e2-41f5-b99d-21585855a86d

From: Frank Wunderlich <frank-w@public-files.de>

The controllers should be enabled at board level if used.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index a7954bf5c81e..f8b01f3fff32 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -334,6 +334,7 @@ usb@11190000 {
 				 <&infracfg CLK_INFRA_133M_USB_HCK>,
 				 <&infracfg CLK_INFRA_USB_XHCI>;
 			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
+			status = "disabled";
 		};
 
 		usb@11200000 {
@@ -348,6 +349,7 @@ usb@11200000 {
 				 <&infracfg CLK_INFRA_133M_USB_HCK_CK_P1>,
 				 <&infracfg CLK_INFRA_USB_XHCI_CK_P1>;
 			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
+			status = "disabled";
 		};
 
 		mmc0: mmc@11230000 {
-- 
2.43.0


