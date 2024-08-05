Return-Path: <linux-kernel+bounces-275010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE243947F82
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE4A1C210DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D431615C14B;
	Mon,  5 Aug 2024 16:41:10 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018EB3E479
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876070; cv=none; b=nwPWre9IQ2Ot0IcLoHNKm3fWvV/WXBdUZnQfbRghnfRowlz20fhF7cl0C3IjEoK3EmhAp1AlemdWBeBD66Q58ZHt96rH3LIwC6qJ31zH47xvQCpUVDyO0cCfpwbWqhWPVv1Ty5jKbxP1xnX2qJ518vBhbiMvp5tdF89UxHueo1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876070; c=relaxed/simple;
	bh=0nLZarad/33XwHuKaOJpxEGT4Vu2bigaHRkIinHgmfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h46oskwCo0R63Yy3uiKzQ6tnsNjBCldVvv2EpdtAFs6c8LkwRiKFQ+W8+FWMcqLV8P0C0MbQDeU25++9jBOwlFf5u8/k9SC9qeduDD6LAHxofQ/9FmaRhm9ANZD8PKjDWLDIdwvUxhMxW4wRy/XWbs8g/PoLJrEqYsuATD/OtTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sb0S6-0003cC-HL; Mon, 05 Aug 2024 18:20:54 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: actually enable pmu-io-domains on qnap-ts433
Date: Mon,  5 Aug 2024 18:20:52 +0200
Message-Id: <20240805162052.3345768-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Contrary to the vendor-kernel the pmu-io-domains are not enabled by
default. This resulted in the value not being set according to the
regulator, which in turn made the gmac0 interface that is connected
to the vccio4 supply inoperable.

Fixes: 64b7f16fb394 ("arm64: dts: rockchip: add 2 pmu_io_domain supplies for Qnap-TS433")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 9ee8e954fd341..1417411d15ae8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -604,6 +604,7 @@ vcc5v0_otg_en: vcc5v0-otg-en {
 &pmu_io_domains {
 	vccio4-supply = <&vcc_1v8>;
 	vccio6-supply = <&vcc_1v8>;
+	status = "okay";
 };
 
 &sata1 {
-- 
2.39.2


