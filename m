Return-Path: <linux-kernel+bounces-516838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E575A3780C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173773A4F1D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE271A9B24;
	Sun, 16 Feb 2025 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="XqfA279Y"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B551A5BAB;
	Sun, 16 Feb 2025 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739744302; cv=pass; b=SefDA8LlthsR2SOsL1RT/vT3hcJ6hdavW6f7v5KiwO1P8iRudo5dH/SOzdq7Sboweny2duBLzq04amwLLopwQ7i6Scmp3sGy5G5NTYkpWrOr1avs2HxUp34Q/64asEDLYHH+vFosLiUDY1DErCiwUAW+C+Z3K4RW0mecBA0jPcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739744302; c=relaxed/simple;
	bh=Ow2wOKW47xQxE1tes6dzGd7yzs8hgRX69tsKSBSfITc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUvCJs5NE7oCFwI6HaQGNO+cTGJ+YRhrzdOPre9BuK6DxoACIMRjqU55XMZDv9/BIsOlyeG9ri0Dj4k/4OCepORLSkI6J8BD1+galR4c4y2DWswDgbVat+plccjQOKPs/DQADHZ0KiKvyeyTRc1zgkxn4SJq91mCWQgyYm4DHEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=XqfA279Y; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739744269; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BvPGmvJYmrhsFTWC+5HKGniE0h7h+HgTmgnSsV4gOWE2e7bVOGLd+nv4YOxN3D3sXfmpZ5Cy4ywy3dq8XOBYe/OKGbsMjuCISubeGrDQozBuwJdTYHTioaRhw/303rOCpBOUtFwB/0CRnNN8h1FOoP/1/cXA6MQoY2MuZkHViUA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739744269; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qV9FtGc2J3JofUAmzm8a7AF6xA8rwztBenPkjZxjGQ4=; 
	b=TFpNfVS3uXJLTtA45QpC19mKMSSrF3VHkplIapyKHLWU5GltAtATRoZ1fxBonqtSCvdtqz8WGYbJwiPraLct3h7dSO+6uJ/Pi/kjaIUtFCw6zoBGmYnuQjeZYFHlMOCECaTvaw9A85UnhGQ8I9+2w6WKa6qqNBZKZFs5nItU2/w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739744269;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qV9FtGc2J3JofUAmzm8a7AF6xA8rwztBenPkjZxjGQ4=;
	b=XqfA279YJRUTqsywVZRV1flD/G4pzs3eywPnE/1MymVzaoTYCxmFZEneDrtHNeC4
	kCeX581kRYANASWq52UpCrxBm5H2Nv42kJ3aqpQrLmVKdD946917hSbkWeNcgz/DZGr
	xgk5iK2PGrcKhIaM3n08QB7bqcaR6CNPBwYOBh1Y=
Received: by mx.zohomail.com with SMTPS id 1739744266007162.2709788827533;
	Sun, 16 Feb 2025 14:17:46 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kever Yang <kever.yang@rock-chips.com>,
	XiaoDong Huang <derrick.huang@rock-chips.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	kernel@collabora.com
Subject: [PATCH v2 2/3] arm64: dts: rockchip: rk356x: Add MSI controller node
Date: Mon, 17 Feb 2025 01:16:33 +0300
Message-ID: <20250216221634.364158-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216221634.364158-1-dmitry.osipenko@collabora.com>
References: <20250216221634.364158-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Rockchip 356x SoC's GIC has two hardware integration issues that
affect MSI functionality of the GIC. Previously, both these GIC
issues were worked around by using MBI for MSI instead of ITS
because kernel GIC driver didn't have necessary quirks.

First issue is about RK356x GIC not supporting programmable
shareability, while reporting it as supported in a GIC's feature
register. Rockchip assigned Erratum ID #3568001 for this issue. This
patch adds dma-noncoherent property to the GIC node, denoting that a SW
workaround is required for mitigating the issue.

Second issue is about GIC AXI master interface addressing limited to
the first 4GB of physical address space. Rockchip assigned Erratum
ID #3568002 for this issue.

Now that kernel supports quirks for both of the erratums, add
MSI controller node to RK356x device-tree.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index de5e6c0c3d24..423185686600 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -284,6 +284,18 @@ gic: interrupt-controller@fd400000 {
 		mbi-alias = <0x0 0xfd410000>;
 		mbi-ranges = <296 24>;
 		msi-controller;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-noncoherent;
+
+		its: msi-controller@fd440000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0x0 0xfd440000 0 0x20000>;
+			dma-noncoherent;
+			msi-controller;
+			#msi-cells = <1>;
+		};
 	};
 
 	usb_host0_ehci: usb@fd800000 {
-- 
2.48.1


