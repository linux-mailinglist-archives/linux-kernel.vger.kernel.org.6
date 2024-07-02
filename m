Return-Path: <linux-kernel+bounces-237147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058A791EC71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEE1282199
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 01:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDB4747F;
	Tue,  2 Jul 2024 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hMWNKsGk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA1883D;
	Tue,  2 Jul 2024 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719882791; cv=none; b=BH4PmCWro2dLx9hx9l4RxZzJPtsH0e/IvsSDrn+h6NFG7Fxd07oW3xFLkZpqLMaVE4WpDlCELm1oAnihgQ0pE2qf0Edm5lPsnZQzylqf/ozbPeNMdXdbrhLs9zkacciw3CYIhwNkO9qh253N4lVYe1fZ+0a9uocFwpH66ffPgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719882791; c=relaxed/simple;
	bh=LEpS0prWNwTg637CGji58I1O4rLSQPuHkPWQ3gbelhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FJY59saePcRVyTHjuTYZ4UzJz1K3CUh2P/ZuMecJXCJI83m5xmmAxyCOLb265L3BH1BSLMR+zme7Uqd4QtICSMJ+d5lZtBcjLKPwo1ROQnN2NU1weoSERzrAcYb0kM67+JAwm1752+oZhH9+0LXWpUlp2tUEC1dHUIW+fuTJuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hMWNKsGk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719882788;
	bh=LEpS0prWNwTg637CGji58I1O4rLSQPuHkPWQ3gbelhg=;
	h=From:Date:Subject:To:Cc:From;
	b=hMWNKsGkfexOjlTg+YJbWEj460nsPq0oadciGY1Okr8c72pPUmivorKnU1x14Yvyj
	 P92dvrCKUD8Lpy9gVtY8RqOTxj0HpjXIvoapuYawW4jAxP4iJTwIbvxjgCRtLwQU2E
	 kQU8+M6TwuXAOku6XEj5wrhxKFff48cyLNx3Wva7Fh+kAlefWa0CM7i3oZwkf8b6Oc
	 pihOrZen1Eme+X5NjdkRCskxe8yJKxEafCgCjYGvBeT2Ttfxp+7uxvj3Sot4m85ngK
	 NKXz9nnlJIICw64Oq3iREMArmWBo+dAFHmw4FTCTH6/SklxkDl4JAqngvH4lUGJ1DO
	 RFLj2x7YxG7kw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E1FF537820DE;
	Tue,  2 Jul 2024 01:13:07 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Jul 2024 04:12:52 +0300
Subject: [PATCH] arm64: dts: rockchip: Add missing power-domains for rk356x
 vop_mmu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-rk356x-fix-vop-mmu-v1-1-a66d1a0c45ea@collabora.com>
X-B4-Tracking: v=1; b=H4sIABNUg2YC/x2MQQqAIBAAvxJ7bsE0NfpKdJDaaolSlCII/550H
 IaZFxJFpgR99UKkmxP7s0BTVzBt7lwJeS4MUshWWCEx7kqbBxd+8PYBj+NCJ5WeTeesah2UMEQ
 q+p8OY84fliuXp2QAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

The iommu@fe043e00 on RK356x SoC shares the VOP power domain, but the
power-domains property was not provided when the node has been added.

The consequence is that an attempt to reload the rockchipdrm module will
freeze the entire system.  That is because on probe time,
pm_runtime_get_suppliers() gets called for vop@fe040000, which blocks
when pm_runtime_get_sync() is being invoked for iommu@fe043e00.

Fix the issue by adding the missing property.

Fixes: 9d6c6d978f97 ("arm64: dts: rockchip: rk356x: Add VOP2 nodes")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index d8543b5557ee..3e2a8bfcafea 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -790,6 +790,7 @@ vop_mmu: iommu@fe043e00 {
 		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		power-domains = <&power RK3568_PD_VO>;
 		status = "disabled";
 	};
 

---
base-commit: 1eb586a9782cde8e5091b9de74603e0a8386b09e
change-id: 20240702-rk356x-fix-vop-mmu-a235d68a734a


