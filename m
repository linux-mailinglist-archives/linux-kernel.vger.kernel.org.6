Return-Path: <linux-kernel+bounces-516835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC9FA37807
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E9F3A6315
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0B91A3BC0;
	Sun, 16 Feb 2025 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="PQavqjZn"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835A1A2544;
	Sun, 16 Feb 2025 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739744299; cv=pass; b=gIDfoNqMGEvb43nUKgtMBkf3+IEeaMcD3SwHDT5UaQvWvhOZND3mNOGPqeBwVoUSs7CnXvooQwI5MjbCxj3VT5F/HjaNP2Tv9E7jq6ty5HBg48EmXxXvjl5WKpfxBgXOs2n4yKiEndDitkeMfzjxRd22P9H6z2/jFIIq3uMTymc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739744299; c=relaxed/simple;
	bh=wHJhwOeaSpNNbgCYMkjjG1GNlz5YxerPhIo6B14rw9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPRjA5RLxqP7ooL9Lll/kycouwMQ02LnsgiVIDI4oo/Djn3SYfZVN8+0IlGBQhncza64A+V5NAEDuU2lVht6LfVJe9nC8L2MaF8KRWVMXazxIBSaviRYEkM+Q4+VGZss6fPYYeK/DAMoWrErTimJrNBNZ2FrghmlkNa7NiAt0xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=PQavqjZn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739744271; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OIPg5n8vVNysNAPm+Fx4I0iVm/kVBYn1uipiSBFHzqoFnliSnBugJBIG6KTteAFX3rln6Hr/0PDeUNmcALZRNSHIn9Jr83nCFk2QfYlD4E0vmmWxOZ+rU5Oq+WdczxVSEkw6vD4xmhbeFl/mOrtrJ0evvs5loQPxIdCdt+ShcsQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739744271; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oCI25TPhy4Id7iRyjm7K0b1dudwW2Ibox3w9+UV2UCs=; 
	b=TsRIgq+zr3kAZtaC5R6BfiEv7ftvn90Hw1oj6g7EHtbS9KC5HUmI4o59Kgk07RvZ4JQ6oJKZzmytfKelA+38xwh707OeB57t+U7LkPxWMt3TT1modY86vdecxHCx+kS2YWhj2pkA/CQSk7GSje56KtxmJwnjJh9AWBvlABac/wY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739744271;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oCI25TPhy4Id7iRyjm7K0b1dudwW2Ibox3w9+UV2UCs=;
	b=PQavqjZngPTcpOG8lvnaNbyjOsHK+eEX9D0ggD8DQkhua7NrntRb9/+tXqnEaw5F
	aqutiC8q2x7X2wIdQH8F02Vy52j7DgYHN7aK2ZrWMZpwshhgf1JkhzSJaX07FjQsKhl
	YgDMjGwdjzEk2meE2Wz02msdw5mgN6Tlc1PVHyhQ=
Received: by mx.zohomail.com with SMTPS id 1739744269720837.2148685030786;
	Sun, 16 Feb 2025 14:17:49 -0800 (PST)
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
Subject: [PATCH v2 3/3] arm64: dts: rockchip: rk356x: Move PCIe MSI to use GIC ITS instead of MBI
Date: Mon, 17 Feb 2025 01:16:34 +0300
Message-ID: <20250216221634.364158-4-dmitry.osipenko@collabora.com>
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

Rockchip 356x device-tree now supports GIC ITS. Move PCIe controller's
MSI to use ITS instead of MBI. This removes extra CPU overhead of handling
PCIe MBIs by letting GIC's ITS to serve the PCIe MSIs.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 423185686600..4f11141ea146 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -969,7 +969,7 @@ pcie2x1: pcie@fe260000 {
 		num-ib-windows = <6>;
 		num-ob-windows = <2>;
 		max-link-speed = <2>;
-		msi-map = <0x0 &gic 0x0 0x1000>;
+		msi-map = <0x0 &its 0x0 0x1000>;
 		num-lanes = <1>;
 		phys = <&combphy2 PHY_TYPE_PCIE>;
 		phy-names = "pcie-phy";
-- 
2.48.1


