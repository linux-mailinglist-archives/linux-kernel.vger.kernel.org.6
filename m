Return-Path: <linux-kernel+bounces-512794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7D1A33DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF79188D612
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3449222157F;
	Thu, 13 Feb 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TqEPr+8k"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD021D3E0;
	Thu, 13 Feb 2025 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445653; cv=none; b=ovBa/kFKPEM6MT6aIIES1oQSuYvAABt6LDsZ0l9eLeQKa7xDPyERYLAYoCF589/TLdX56NgXS4+JGLOPZ9r+U0Sbmz9KzUgGW1M7e8yFG+FhkqjPbSsvDshaEQSf6+aVdardk6LZyS8W9WnK4S55KcyE23UjGy4diTepBYEJyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445653; c=relaxed/simple;
	bh=e0eGua7t7TvlPBa9LwHKZrO9ganTKJP++6K1ucHteGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bwfq/TK6ZrCmOZXDXR5ihY57AO/JqEa+Vdm9s01p8UUCRf3HPgeWwZedWub4Ss9NBmeBzquV+ewbAUr07Oc2aTrKaOIsaEbPb1yENIImxhMYCoHDhFLOGmh5JWa4w/y9cE8BSiOP72fvaCOaYHFrz5z+TbWsPCJAV/DTsBHf5NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TqEPr+8k; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739445650;
	bh=e0eGua7t7TvlPBa9LwHKZrO9ganTKJP++6K1ucHteGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqEPr+8kYbymOGE/ORH11JUEEdKWYxPB7p25Xt+OeO7Nn4/SY/ClqOP4vY1tOmzvq
	 kQTsyLM0OehqUXgQ6pjd76W9tjrwy8hSG1mF5dNvYSQAs95u5TymWVIIi+V6HoGddy
	 +P/GvCBoeeNW0LQqncxqpkiQkvjlGKg7Dxaa5hCseGow1dwAlGMv+odl00upckl7nm
	 fwUFdhqnM6eOL646G4Q1wUxXXrrGCCtnIlWKyOWOMB8475Qk3pJL8BDK0yioYqFdCF
	 xOtnFU6PqDJXiKPqnCHsMgUOxir8jFejEjZipX1uriYmbXN1rr3JCc+OYmeR80OiIU
	 u/x6tyrm/ZGbg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 71A9917E151F;
	Thu, 13 Feb 2025 12:20:49 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v1 3/3] arm64: dts: mediatek: mt8395-nio-12l: Preconfigure DSI0 pipeline
Date: Thu, 13 Feb 2025 12:20:08 +0100
Message-ID: <20250213112008.56394-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213112008.56394-1-angelogioacchino.delregno@collabora.com>
References: <20250213112008.56394-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This board can use a MIPI-DSI panel on the DSI0 connector: in
preparation for adding an overlay for the Radxa Display 8HD,
add a pipeline connecting VDOSYS0 components to DSI0.

This pipeline remains disabled by default, as it is expected
to be enabled only by a devicetree overlay that declares the
actual DSI panel node, completing the graph.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8395-radxa-nio-12l.dts     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 41dc34837b02..7184dc99296c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -172,6 +172,32 @@ &cpu7 {
 	cpu-supply = <&mt6315_6_vbuck1>;
 };
 
+&dither0_out {
+	remote-endpoint = <&dsi0_in>;
+};
+
+&dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dsi0_in: endpoint {
+				remote-endpoint = <&dither0_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dsi0_out: endpoint { };
+		};
+	};
+};
+
 &eth {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&rgmii_phy>;
-- 
2.48.1


