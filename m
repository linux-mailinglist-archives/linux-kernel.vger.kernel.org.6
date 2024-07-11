Return-Path: <linux-kernel+bounces-248905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01B392E387
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1988E1C21486
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F5F1552E7;
	Thu, 11 Jul 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Wm4GXwdH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97337155A43;
	Thu, 11 Jul 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690368; cv=none; b=idFiaDCz+0dhg3FVLqQtbKgRoWASp5EHf7JvXUpv/2OW/5AuYtpD3/Y6Zx56NwwCKzwTAPI8uVKextPk82e1Vq5gMoixzBjnjVmt22RN/TmWJTnr/3CM3FediRPMmqaTvHgJh7PgrNuA61CtjDc7FJ5BHHGIn/Gtb2Wr/mOVcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690368; c=relaxed/simple;
	bh=RIRpn7uyPCKGU2gHT1Esd7Wxhmrbug5jzpTCAkrGfS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Smlob6GuFMgFelXTrIyqD/d5vMafShYUmtmRoiABbPnnN+GySEcNx1noZziz4bRRFaOzuhp0UVbLvNqMeC8fUFvY2hQd1+a35Kh0msvATmdIHftyQT6A2yA6WVs+2kXr+pe+KAgTJH4xMmRr8B5+de6Z8Wn0iZPCFMhdLsoxbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Wm4GXwdH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720690364;
	bh=RIRpn7uyPCKGU2gHT1Esd7Wxhmrbug5jzpTCAkrGfS4=;
	h=From:To:Cc:Subject:Date:From;
	b=Wm4GXwdHxwkGa/hrKc/yXcY5UQvlRIJ3fI6kx2mOfOl0cj0OB86w0q2y9hG60jmrr
	 LeRbQ8oilOHD7lxhVBQAfHIJJtoegM+2hoUQvSV/i0RBR+/POz5Qpq58PFPFhFKjEt
	 0y6FJ9WSHhY2pyg3BC00327gIX8TzWL2bGQP4KTkEwTT8EceJ0/A9N23IqLwnQdIj/
	 JzVeI4uOIR2NCFpQJedMvlALT+VVLunDMbpNPszetcYF9BZdylv6OLcrFbwokohp9g
	 2ZScg3QrGojnXrcgBbqJ4/xfVzKxIyhR7y8rD387VoLekBeKHAJG1PyDpfCIHejKPd
	 BlZz54S96ZcXQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2723837811F4;
	Thu, 11 Jul 2024 09:32:44 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	tinghan.shen@mediatek.com,
	seiya.wang@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nfraprado@collabora.com,
	wenst@chromium.org
Subject: [PATCH] arm64: dts: mediatek: mt8195: Add power domain to secondary XHCI
Date: Thu, 11 Jul 2024 11:32:30 +0200
Message-ID: <20240711093230.118534-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The secondary XHCI controller, using a PHY that is shared between
it and the secondary PCI-Express controller, gets powered by the
PCIE_MAC_P1 power domain.

Add this power domain to the usb@11290000 node to fix probe.

Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 2ee45752583c..96ad1b14626e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1445,6 +1445,7 @@ xhci1: usb@11290000 {
 			reg-names = "mac", "ippc";
 			interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
 			phys = <&u2port1 PHY_TYPE_USB2>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P1>;
 			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_1P>,
 					  <&topckgen CLK_TOP_SSUSB_XHCI_1P>;
 			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
-- 
2.45.2


