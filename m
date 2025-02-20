Return-Path: <linux-kernel+bounces-523520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1450A3D7EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565A117C717
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140801F3D50;
	Thu, 20 Feb 2025 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VozmHJFM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3051F152F;
	Thu, 20 Feb 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049805; cv=none; b=GRJWlzie6AuJDdVx0FuI9uGITSgK2Pd1Yc6n6HiKkBxRGI0L8a/Fcnpfz1PXAku6TGpu2tu5UZL9YYKEborfYKkgWGwLdYXQ82QjFCwkf0sgOGAqm3PHFFIja0RJU1vKDZaKQFmaEADT33/Il7s7vmFqtEY+exW+nfZxdegRDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049805; c=relaxed/simple;
	bh=XRowMk/5gMfwXHxFEFKhwBi4Aeuclsw7ltcciXwDOXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwpwFfWPLhE0U35C8ooY3FMVUYCJfzgZcfStu9J69guKegEamkdiLkwNcQD3PF4pdDY7l6SAI80j6MEzC3VWl7dxwhRKBZYkzmvsFV3JK+W+xdPcQi3wfXAwLRRqAOe0f1F4xv+NngcaQK0ExCpMS+CVIzjSsIsi8vodND26FN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VozmHJFM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740049802;
	bh=XRowMk/5gMfwXHxFEFKhwBi4Aeuclsw7ltcciXwDOXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VozmHJFMdz01HBmeVnpACKYNJVqljzZw8gpJtSa+NuWSaEUTwUw445E/cfNhzU7Ew
	 hz58qKam8L5SBy6sqw1LOGUEVs9DWtGSs/wLpjbHtNszuNsPViYQwsqoavzG9SGCH5
	 1bCJrv/0BJCuK7QkhHn+DO3p0bg4DZQQlTrU3kkNdqN8vfVsJBvfP02OJUx3AS2NU7
	 9YvJsUD2m3oAFb66OVK2aLYGNA5AS1OAUy/5iCypFqaVMywQwwTfcVcNFkYkBsfl/B
	 C/cG+YnDi4/0LmB0cyfvuXp3MwmzMKTA3rl7MYJVGDhSm7S7HnFCBjTKHO09rJS7uh
	 VqHKMLJffikfA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5AC2F17E156F;
	Thu, 20 Feb 2025 12:10:01 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v1 4/4] arm64: dts: mediatek: mt8390-genio-common: Configure touch vreg pins
Date: Thu, 20 Feb 2025 12:09:48 +0100
Message-ID: <20250220110948.45596-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220110948.45596-1-angelogioacchino.delregno@collabora.com>
References: <20250220110948.45596-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pinctrl configuration for the Touchscreen IC's power line
to make sure that the pin is configured as GPIO and to stop
relying on correct pin configuration from bootloader.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index 0191776e037c..55564d91423f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -187,6 +187,8 @@ touch0_fixed_3v3: regulator-5 {
 		gpio = <&pio 119 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		vin-supply = <&reg_vsys>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_vreg_pins>;
 	};
 
 	usb_hub_fixed_3v3: regulator-6 {
@@ -1021,6 +1023,13 @@ pins-spi {
 		};
 	};
 
+	touch_vreg_pins: touch-avdd-pins {
+		pins-power {
+			pinmux = <PINMUX_GPIO120__FUNC_B_GPIO120>;
+			output-high;
+		};
+	};
+
 	touch_pins: touch-pins {
 		pins-irq {
 			pinmux = <PINMUX_GPIO6__FUNC_B_GPIO6>;
-- 
2.48.1


