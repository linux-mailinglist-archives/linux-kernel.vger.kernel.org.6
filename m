Return-Path: <linux-kernel+bounces-220730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6385F90E65B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9011F23592
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605357E11E;
	Wed, 19 Jun 2024 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ENU22EDj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC77D3F5;
	Wed, 19 Jun 2024 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787212; cv=none; b=FdqdQXdc9KOgZr1RIN0iCHM/PaNvDaGo4Mo2ThIFVuYhZVZ5CbiQJK1yepoaPvUeiwCO7Bt0EJ6tfr8JaO6FQtuRXBPtIRojd967QmHDvIovcNsmKP53ijZEaMWE+wUr+o7+UMGYBxA7KfFKwJz8+9DT1qpBPikvzoz+a+2kPOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787212; c=relaxed/simple;
	bh=Tj3Ro2wAPS6ZAo5FEGtQ81HlMt4MROS7z6+Hz6sXCWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sz673slGC/URTAh0LnxooLyr4jcvmz5pjOb8qKHaSg40j/v+GRA8NvLd1K8REFoLfrSCVfvI63oGW5+h3jUbitSpt4JmmwnjXMh/WJ5opxtELBPxmqUvyYfhpRusO76BXn39HxVV8G8HwcY8i0sS5UE617u1Z0/RUo6TW2+YeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ENU22EDj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718787209;
	bh=Tj3Ro2wAPS6ZAo5FEGtQ81HlMt4MROS7z6+Hz6sXCWg=;
	h=From:To:Cc:Subject:Date:From;
	b=ENU22EDjOQk5Y+EW/OT3/ec7eZZUol0SHRbqwKQXmvsvG+I8BDx3o3t0VnlowIV89
	 z2Vv5t34eFBiMuIt6RCl4ilBL5KL2rv8nYpaOYBdDNcDBtXv2NjjlSTbyM/scuy6z1
	 /DvhTnuNyLS08aqSwiNOtLLON3Va7yadwuI/HXCUAluX42EO+o/fxoMY+BPYQSvzG8
	 dm3Ts+GaVNMY68vBCZmHi8mchiV4snMBOFAVslEereE3SVrS4USdtDMze8u69nSqLf
	 ge398dWfJJ9uIp7m7SlKAYpMw7cJw6j29LPMLqnLzo+ynxvfGsbGPPG2d83WBBWOsq
	 5pNOFShnrzHBQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 161C3378020A;
	Wed, 19 Jun 2024 08:53:28 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: krzk+dt@kernel.org
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	jassisinghbrar@gmail.com,
	garmin.chang@mediatek.com,
	houlong.wei@mediatek.com,
	Jason-ch.Chen@mediatek.com,
	amergnat@baylibre.com,
	Elvis.Wang@mediatek.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 1/3] arm64: dts: mediatek: mt8188: Fix VPPSYS0/1 node name/compatibles
Date: Wed, 19 Jun 2024 10:53:20 +0200
Message-ID: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like VDOSYS0/1, the VPPSYS0 and VPPSYS1 are syscon nodes, as
described by the mediatek,mmsys binding: fix the node name to
be syscon@address and add "syscon" to the list of compatible
strings for both VPPSYS0 and VPPSYS1.

Fixes: 9461e0caac9e ("arm64: dts: Add MediaTek MT8188 dts and evaluation board and Makefile")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 3b02170562ae..77c4f2d104cd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1331,8 +1331,8 @@ mfgcfg: clock-controller@13fbf000 {
 			#clock-cells = <1>;
 		};
 
-		vppsys0: clock-controller@14000000 {
-			compatible = "mediatek,mt8188-vppsys0";
+		vppsys0: syscon@14000000 {
+			compatible = "mediatek,mt8188-vppsys0", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
@@ -1349,8 +1349,8 @@ wpesys_vpp0: clock-controller@14e02000 {
 			#clock-cells = <1>;
 		};
 
-		vppsys1: clock-controller@14f00000 {
-			compatible = "mediatek,mt8188-vppsys1";
+		vppsys1: syscon@14f00000 {
+			compatible = "mediatek,mt8188-vppsys1", "syscon";
 			reg = <0 0x14f00000 0 0x1000>;
 			#clock-cells = <1>;
 		};
-- 
2.45.2


