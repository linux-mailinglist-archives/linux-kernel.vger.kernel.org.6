Return-Path: <linux-kernel+bounces-190357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FAC8CFD3D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9CA2B21DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F8E13B585;
	Mon, 27 May 2024 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ur6wXGsn"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A69F13AD0D;
	Mon, 27 May 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802757; cv=none; b=CPDUAVCYouT7byScGakOnZEzlrvaSld6PT6sQuyDRgSL2x17ZqVmG5VKCB4VL+6q075+fVkB1DmcMbcUycOHswgITMq+ZFH8WUDdQUNryUl6IJEOsF0+td3yqoMPUI5gch3jug2Tj8jHY7pQFc+7oBeK3uroPt1ZSnCeDzgIW1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802757; c=relaxed/simple;
	bh=Q2u/g27bjls/di+Or+gNHb/H3YwXTAj8oy8HXh0H9UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DILHabnToGHH/Ok5gDQHuWFRvryHykiX+qbcyDvnWomrZiKoBoWnF6RxqX+siD9ErM7XoTTVnALJmJTeRQ+AWZHajuFGnNLLorLr60+Rn9CUkovN+ZfMUan+gpzpHgyE/OwY/ueXh0wIe3LQyFgW1FsQ0bnBxSllyB0EgZ268TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ur6wXGsn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716802753;
	bh=Q2u/g27bjls/di+Or+gNHb/H3YwXTAj8oy8HXh0H9UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ur6wXGsn0VGcFITfHnFT9w6tExhutj/M+wRTnG0nmsRXNaBRKDDzB/oYD1kREnvGQ
	 Ml0yjmKmIzQ/4adS0XKlkG2uLDADAe7IbwJqDCRtnQWPhMI5JkTvTi+Cu6R9KL/UTh
	 3+WLWJo0v2rSOXEVzI9ACsuIx02PywDf5dMLhuLYhkq3657tx0rI65DylIL5GJSUTq
	 7TmbpsaTyp+mxZEaX9QU5ekEDWMqMLGC3P2sL9PKu3eQhDOch6FZiRB3UPKndxMUl/
	 82VIT2MVuAU0rFqvuYEuh/m46K63z1PyTIyHFib0fWfu6+zG7YYxk4LkdzEuD91p9D
	 JbFSe2dZJuR2Q==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 079973782113;
	Mon, 27 May 2024 09:39:12 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	mandyjh.liu@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	jpanis@baylibre.com
Subject: [PATCH 2/5] arm64: dts: mediatek: mt8188: Add Global Command Engine mailboxes
Date: Mon, 27 May 2024 11:39:05 +0200
Message-ID: <20240527093908.97574-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
References: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding multimedia nodes and power domains, add
support for the two Global Command Engine (GCE) mailboxes found in
this SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index b4315c9214dc..06fa3b862c31 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mediatek,mt8188-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/mailbox/mediatek,mt8188-gce.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
 #include <dt-bindings/power/mediatek,mt8188-power.h>
@@ -413,6 +414,22 @@ pwrap: pwrap@10024000 {
 			clock-names = "spi", "wrap";
 		};
 
+		gce0: mailbox@10320000 {
+			compatible = "mediatek,mt8188-gce";
+			reg = <0 0x10320000 0 0x4000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <2>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_GCE>;
+		};
+
+		gce1: mailbox@10330000 {
+			compatible = "mediatek,mt8188-gce";
+			reg = <0 0x10330000 0 0x4000>;
+			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <2>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_GCE2>;
+		};
+
 		scp: scp@10500000 {
 			compatible = "mediatek,mt8188-scp";
 			reg = <0 0x10500000 0 0x100000>,
-- 
2.45.1


