Return-Path: <linux-kernel+bounces-259136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E69391C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D351F21A71
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C2616DEDA;
	Mon, 22 Jul 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SagOMCU9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401316CD07;
	Mon, 22 Jul 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662051; cv=none; b=g8+urmkdMddpxkBGKQujYeGbE9vWAL7P4/wrMqA/RGXbQfwUG6YglgIWK/84Gw+GIf44ske2sJhfhHvF1SSRaC6XlLIibcIArZg2J//1R5yc4jrjzLnQxFDZ01MJaUnp6jhuPKygGDfQqdwNGyLGl+z6B2PvK4ebjOGZQXlVpSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662051; c=relaxed/simple;
	bh=8F8AqL8+uz10xZlIRw115rqKTtHgjwv0e3CayfgJVno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DrJoOZjCyb06lDGNXC2fHrlC6vf6NYiFIlg+zCiZRp8y/l6Qqvp43J6THJ35RkBQ45Grf6zHZlljHcOQW4du9yUWe4/UxKR/BaD7dJRpDbO013TTSm4f+cCxnJXw5PzwKAbBKaiyUvYYPe+ttGptQlijJb+U3kvhtQgX8tie2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SagOMCU9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721662048;
	bh=8F8AqL8+uz10xZlIRw115rqKTtHgjwv0e3CayfgJVno=;
	h=From:Date:Subject:To:Cc:From;
	b=SagOMCU94ZPPnQfyFh6zFI2khT9EEF4MUcPcSRe7pwncodoAfwvPKlKTBi9yQAADO
	 phRE4ogpZoaWIS67EqGkT5cXNku33U0qSNmZfGImbPZbAML4kIHwJNdYiJv/JjGnEU
	 tGsAIWVB3mTWMDkEVKAWimvOy9fu90EcHuysvsK7KbThlDu/1ukBj90l1635Ml1Mm3
	 vIu/obugyqQ+s5XoBPIKDEfYK1kY1Wdvat6819IOoa+Eh+tPSVcsJQ7FMhrHq+69Uw
	 5UAvItx7YQNxYN8QhkLjEeThmVHg1IpF9Rrkp45cRHzr9QcHUEDELUHVZzB2XYMjTa
	 6w/ESdtIwWcxA==
Received: from [192.168.1.217] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0CFC137800DE;
	Mon, 22 Jul 2024 15:27:25 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 22 Jul 2024 11:26:55 -0400
Subject: [PATCH] arm64: dts: mediatek: mt8195: Add missing clock for xhci1
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240722-usb-1129-probe-pci-clk-fix-v1-1-99ea804228b6@collabora.com>
X-B4-Tracking: v=1; b=H4sIAD56nmYC/x3MTQqAIBBA4avErBvIQeznKtHCbKyhKFGKILp70
 vJ7i/dA4iicoCseiHxJkmPPUGUBbrH7zChTNlBFuqqJ8EwjKkUthniMjMEJum1FLzeyb4w2Xht
 rHeRBiJzzP++H9/0Af+1nAWwAAAA=
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.0

Currently if the xhci1 controller happens to probe before the pcie1
controller then it fails with the following errors:

xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
xhci-mtk 11290000.usb: can't setup: -110
xhci-mtk: probe of 11290000.usb failed with error -110

The issue has been tracked down to the CLK_INFRA_AO_PCIE_P1_TL_96M
clock, although exactly why this pcie clock is needed for the usb
controller is still unknown. Add the clock to the xhci1 controller so it
always probes successfully and use a placeholder clock name for it.

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 2ee45752583c..cc5169871f1c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1453,9 +1453,15 @@ xhci1: usb@11290000 {
 				 <&topckgen CLK_TOP_SSUSB_P1_REF>,
 				 <&apmixedsys CLK_APMIXED_USB1PLL>,
 				 <&clk26m>,
-				 <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>;
+				 <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>,
+				 /*
+				  * This clock is required due to a hardware
+				  * bug. The 'frmcnt_ck' clock name is used as a
+				  * placeholder.
+				  */
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_P1_TL_96M>;
 			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
-				      "xhci_ck";
+				      "xhci_ck", "frmcnt_ck";
 			mediatek,syscon-wakeup = <&pericfg 0x400 104>;
 			wakeup-source;
 			status = "disabled";

---
base-commit: dee7f101b64219f512bb2f842227bd04c14efe30
change-id: 20240722-usb-1129-probe-pci-clk-fix-ef8646f46aac

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


