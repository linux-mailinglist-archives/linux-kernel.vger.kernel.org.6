Return-Path: <linux-kernel+bounces-334987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CB097DF65
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 00:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E717B2820D3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43228174EDB;
	Sat, 21 Sep 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="uQOZd3jy"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6E154C03
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726957273; cv=none; b=hCKXyE0tWbLm6G475PWG3bEKDyyuUwQMjDy9bKzmz44dFF2yAM6oBLnYvrBviW/oJEsxoBi2pgnqKCnIl86rDLTe+2fu+z+fLZt9MG57WXDR8K5q/ElIlMthSQAf3zclnKaH9N30vaQv9dhIrA3cXYaJufiBE85+EloERyF9VLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726957273; c=relaxed/simple;
	bh=h3gPCTdpuHWkodsWh4/OCphmUBGoIW6TJDe8mjOhsc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrmZvH6lmovljJXsZ6zk8h37XqSjPs/YMk+QPbRp0God7fuLIy1E7c3w6I1Qix/8WtZu7FrJYiLp35mlW9Wy8es4tcytKyl5BnH/ID/opEYi6d9ZKkfkdlILs28UytQzxO4c4fjK85oz/3J3sl0aF2lqbhynEA3rYSLivELf9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=uQOZd3jy; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1726957246; bh=q4HGnQgfycy2AHtw5GfrgdiaBd9jGsGqRiZpjBBUbHw=;
 b=uQOZd3jysDFSkaUze5WIN/0cEfwZHt2UeyM8cszJYuDpN9jMxjIhkAYfxrGxQWar/MiqiYnml
 S57QTZnmF3JUPqlIDBw1WYMrQ7c/aU+sUzZVVkKJE4CZXTDoCAEaII1C1o5CVy43kCnmmeTjJMH
 /8Ca6ExY1wua2Ggthv8CCYbShOJeL9iEoNjE+ui/ocQYeLNshyRjADFL/d5rveOHKpVNdw81d/7
 qxpT7RBxVWP1qc1J+b6R/Cp2TojDmhmWoDgsUOg/CsyKjCo+ovrcOdmTv+rkv7ee4QeF0CydNDq
 XGaL1JDAsvU6/5xTotMz2zsjr73QZIHxtlpUBlE2UFzw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/3] ARM: dts: rockchip: Split rk3288-vop into big and lit
Date: Sat, 21 Sep 2024 22:20:02 +0000
Message-ID: <20240921222007.2301868-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240921222007.2301868-1-jonas@kwiboo.se>
References: <20240921222007.2301868-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 66ef46bd18c10b4d4a165d17

The Rockchip RK3288 SoC contain two different Visual Output Processor
(VOP) blocks, VOP_BIG and VOP_LIT. The VOP blocks support different max
output resolution, 3840x2160 and 2560x1600.

Change compatible to differentiate between VOP_BIG and VOP_LIT, the old
compatible is kept for backward compatibility.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/boot/dts/rockchip/rk3288.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3288.dtsi b/arch/arm/boot/dts/rockchip/rk3288.dtsi
index 3f1d640afafa..db4a258551f4 100644
--- a/arch/arm/boot/dts/rockchip/rk3288.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288.dtsi
@@ -1026,7 +1026,7 @@ rga: rga@ff920000 {
 	};
 
 	vopb: vop@ff930000 {
-		compatible = "rockchip,rk3288-vop";
+		compatible = "rockchip,rk3288-vop-big", "rockchip,rk3288-vop";
 		reg = <0x0 0xff930000 0x0 0x19c>, <0x0 0xff931000 0x0 0x1000>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
@@ -1075,7 +1075,7 @@ vopb_mmu: iommu@ff930300 {
 	};
 
 	vopl: vop@ff940000 {
-		compatible = "rockchip,rk3288-vop";
+		compatible = "rockchip,rk3288-vop-lit", "rockchip,rk3288-vop";
 		reg = <0x0 0xff940000 0x0 0x19c>, <0x0 0xff941000 0x0 0x1000>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
-- 
2.46.1


