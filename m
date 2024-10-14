Return-Path: <linux-kernel+bounces-364671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8485299D7B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AA92845C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D991CDA3E;
	Mon, 14 Oct 2024 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S+y6ztHJ"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30EB1C877E;
	Mon, 14 Oct 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728935253; cv=none; b=UtEdFKy5iEBSp8HNQT7hNKMRakGvr5viq4lc9FDR4hpMy43QXu8g+bvTNerzYJefzYu1k4XiKxxSWvTkbyG1jtqRZzQICQWQ8PuGw3DCsLSbO8VIGcLULXcKsbCxmCyV+mdkGOgOCQNLqUuRk3BWZaXAACq5eRBIdhGJHJ+C5RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728935253; c=relaxed/simple;
	bh=HrjaBQddtlYnMWaPxZnfEaKP1aWpS2Gr/imB/Ke9JTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wn44aRHlkUbVPeELizEbCP0WzzRAzgygGNi27ZMQnTTqBpwHxHxG9xd0SNDVcJjO03UMfJ/dJ+y2wIi2ExIg+67NdaO6pHFv+irrqG9bn0SMlEeZQkGJHYOkTftKubjQBF2u8d0KB1+NamX2eUINdirPg/J0qJ/XZcLuQ2W7SXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S+y6ztHJ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49EJlNFW017926;
	Mon, 14 Oct 2024 14:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728935243;
	bh=OfeUQFbrKPf1VWol3OA2JgYbMdzM5STfxX6WAMWs4tc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=S+y6ztHJcqo4YA75V1gQvdyWlPTvKr3V6JEcL7kWbgmj3Fq5osEE8MGnvZVP59lP7
	 ap2ApL/Lr8kCNdbXJSti6xfN6AOdHznEfCYr20UzQR5jDBE03wnqZakXaCX27NetaN
	 TD8uNwOsHmtxSQ+s4g6AIln5jPsbgTjpP8hrVrXE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49EJlNkA009520
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 14:47:23 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 14:47:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 14:47:22 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49EJlM9Z002469;
	Mon, 14 Oct 2024 14:47:22 -0500
From: Judith Mendez <jm@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Judith
 Mendez <jm@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am65-main: Add missing itapdly to sdhci0
Date: Mon, 14 Oct 2024 14:47:21 -0500
Message-ID: <20241014194722.358444-3-jm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014194722.358444-1-jm@ti.com>
References: <20241014194722.358444-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

For am65x, add missing ITAP delay values for sdhci0
node according to the device datasheet [0].

[0] https://www.ti.com/lit/ds/symlink/am6548.pdf
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 1f1af7ea23305..0534b53483473 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -449,6 +449,8 @@ sdhci0: mmc@4f80000 {
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x5>;
 		ti,otap-del-sel-hs200 = <0x5>;
+		ti,itap-del-sel-legacy = <0xa>;
+		ti,itap-del-sel-mmc-hs = <0x1>;
 		ti,itap-del-sel-ddr52 = <0x0>;
 		dma-coherent;
 		status = "disabled";
-- 
2.47.0


